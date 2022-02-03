(** * Lim sup, lim inf and Bolzano-Weierstrass

Authors:
    - Jim Portegies

This file is part of Waterproof-lib.

Waterproof-lib is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

Waterproof-lib is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with Waterproof-lib.  If not, see <https://www.gnu.org/licenses/>.
*)

Require Import Reals.
Require Import Lra.
Require Import Classical.
Require Import Classical_Pred_Type.

Require Import Waterproof.AllTactics.
Require Import Waterproof.load_database.RealsAndIntegers.
Require Import Waterproof.notations.notations.
Require Import Waterproof.set_search_depth.To_5.
Require Import Waterproof.set_intuition.Disabled.
Require Import Waterproof.load_database.DisableWildcard.

Require Import Waterproof.theory.analysis.sequences.
Require Import Waterproof.theory.analysis.subsequences.
Require Import Waterproof.theory.analysis.sup_and_inf.
Require Import Waterproof.theory.analysis.sequential_accumulation_points.

Global Hint Resolve Rabs_Rabsolu.

(** ## lim sup*)
Definition lim_sup_bdd (a : ℕ → ℝ) 
                       (pr1 : has_ub a) 
                       (pr2 : has_lb (sequence_ub a pr1))
:= decreasing_cv (sequence_ub a pr1) (Wn_decreasing a pr1) (pr2).

Lemma lim_const_min_1_over_n_plus_1 :
  ∀ x : ℝ, Un_cv (fun (n : ℕ) ↦ x - 1 / (INR n + 1)) x.
Proof.
Take x : ℝ.
    It holds that (x = x - 0) (i).
    rewrite (i) at 1.
    apply CV_minus with
      (An := fun (n : ℕ) ↦ x)
      (Bn := fun (n : ℕ) ↦ 1 / (INR n + 1))
      (l1 := x)
      (l2 := 0).
    - We need to show that ((constant_sequence x) ⟶ x).
      By lim_const_seq we conclude that ((constant_sequence x) ⟶ x).
    - We need to show that (Un_cv d 0).
      By lim_d_0 we conclude that (Un_cv d 0).
Qed.

Lemma exists_almost_lim_sup : 
  ∀ (a : ℕ → ℝ) (i : has_ub a) (ii : has_lb (sequence_ub a (i))) (m : ℕ) (N : ℕ),
    ∃ k : ℕ, (N ≤ k)%nat ∧ a k > proj1_sig (lim_sup_bdd a (i) (ii)) - 1 / (INR(m) + 1).
Proof.
    Take a : (ℕ → ℝ).
    Assume that (has_ub a) (i).
    Assume that (has_lb (sequence_ub a (i))) (ii).
    Take m, Nn : ℕ.
    By exists_almost_lim_sup_aux it holds that 
      (∃ k : ℕ, (k ≥ Nn)%nat ∧ a k > sequence_ub a (i) Nn - 1 / (INR(m) + 1)) (iii).
    Obtain n according to (iii), so for n : nat it holds that
      ((n ≥ Nn)%nat ∧ a n > sequence_ub a (i) Nn - 1 / (INR(m) + 1)) (iv).
    Choose k := n.
    We show both statements.
    - We need to show that (Nn ≤ k)%nat.
      We conclude that (Nn <= k)%nat.
    - We need to show that (a k > proj1_sig (lim_sup_bdd a (i) (ii)) - 1 / (m + 1)).
      We claim that (proj1_sig (lim_sup_bdd a (i) (ii)) ≤ sequence_ub a (i) Nn).
      { Expand the definition of lim_sup_bdd.
        That is, write the goal as 
          (proj1_sig (decreasing_cv (sequence_ub a (i)) (Wn_decreasing a (i)) (ii)) 
            ≤ sequence_ub a (i) Nn).
        Define v := (decreasing_cv (sequence_ub a (i)) (Wn_decreasing a (i)) (ii)).
        Obtain l according to (v), so for l : R it holds that 
          (Un_cv (sequence_ub a (i)) l).
        We need to show that (l ≤ sequence_ub a (i) Nn).
        By Wn_decreasing it holds that (Un_decreasing (sequence_ub a (i))).
        By decreasing_ineq we conclude that (l <= sequence_ub a (i) Nn).
      }
      Because (iv) both (n ≥ Nn)%nat and 
        (a n > sequence_ub a i Nn - 1 / (m + 1)) hold.
      It holds that (proj1_sig (lim_sup_bdd a (i) (ii)) - 1 / (m + 1) ≤ a n).
      We need to show that (proj1_sig (lim_sup_bdd a (i) (ii)) - 1 / (m + 1) < a k).
      We conclude that (& proj1_sig (lim_sup_bdd a (i) (ii)) - 1 / (m + 1) &< a n &= a k).
Qed.


Lemma exists_subseq_to_limsup_bdd :
   ∀ (a : ℕ → ℝ) (i : has_ub a) (ii : has_lb (sequence_ub a (i))),
    ∃ n : ℕ → ℕ, is_index_seq n ∧ ∀ k : ℕ, a (n k) > proj1_sig (lim_sup_bdd a (i) (ii)) - 1 / (INR(k) + 1).
Proof.
    Take a : (ℕ → ℝ).
    Assume that (has_ub a) (i).
    Assume that (has_lb (sequence_ub a (i))) (ii).
    (* TODO: notation for apply with parameters *)
    apply exists_good_subseq with (P := fun (m : ℕ) (y :ℝ) ↦ y > proj1_sig (lim_sup_bdd a (i) (ii)) - 1 / (INR(m) + 1) ).
    Take m, N1 : nat.
    By exists_almost_lim_sup we conclude that (there exists k : ℕ, (N1 ≤ k)%nat
      ∧ a k > proj1_sig (lim_sup_bdd a (i) (ii)) - 1 / (m + 1)).
Qed.



Lemma sequence_ub_bds :
  ∀ (a : ℕ → ℝ) (i : has_ub a) (N : ℕ) (n : ℕ),
    (n ≥ N)%nat ⇒ a n ≤ sequence_ub a (i) N.
Proof.
    Take a : (ℕ → ℝ). 
    Assume that (has_ub a) (i).
    Take Nn, n : ℕ; such that (n ≥ Nn)%nat.
    Expand the definition of sequence_ub.
    That is, write the goal as (a n ≤ lub (k) ↦ (a (Nn + k)%nat) (maj_ss a Nn (i))).
    Expand the definition of lub.
    That is, write the goal as
      (a n ≤ (let (a0, _) := ub_to_lub (k) ↦ (a (Nn + k)%nat) (maj_ss a Nn (i)) in a0)).
    Define ii := (ub_to_lub (fun (k : ℕ) ↦ a (Nn +k)%nat) (maj_ss a Nn (i))).
    Obtain M according to (ii), so for M : R it holds that 
      (is_sup (EUn (fun (k : ℕ) ↦ a (Nn +k)%nat)) M) (iii).
    Expand the definition of is_lub in (iii).
    That is, write (iii) as (is_upper_bound (EUn (k) ↦ (a (Nn + k)%nat)) M
      ∧ (for all b : ℝ, is_upper_bound (EUn (k) ↦ (a (Nn + k)%nat)) b ⇨ M ≤ b)).
    Because (iii) both (is_upper_bound (EUn (k) ↦ (a (Nn + k)%nat)) M) (iv)
      and (for all b : ℝ, is_upper_bound (EUn (k) ↦ (a (Nn + k)%nat)) b ⇨ M ≤ b) hold.
    Expand the definition of is_upper_bound in (iv).
    That is, write (iv) as (for all x : ℝ, EUn (k) ↦ (a (Nn + k)%nat) x ⇨ x ≤ M).
    It holds that (Nn + (n-Nn) = n)%nat.
    It suffices to show that (EUn (fun (k : ℕ) ↦ (a (Nn + k)%nat)) (a n)).
    Expand the definition of EUn.
    That is, write the goal as (there exists i : ℕ, a n = a (Nn + i)%nat).
    We need to show that (∃ i : ℕ, a n = a (Nn + i)%nat).
    Choose k := (n - Nn)%nat.
    We conclude that (& a n &= a (Nn + n - Nn)%nat &= a (Nn + k)%nat).
Qed.


(** ## A slightly upgraded version of the Bolzano-Weierstrass Theorem*)
Theorem Bolzano_Weierstrass_gen :
  ∀ (a : ℕ → ℝ) (i : has_ub a) (ii : has_lb (sequence_ub a (i))),
    ∃ (n : ℕ → ℕ), is_index_seq n ∧ Un_cv (fun (k : ℕ) ↦ a (n k)) (proj1_sig (lim_sup_bdd a (i) (ii))).
Proof.
    Take a : (ℕ → ℝ).
    Assume that (has_ub a) (i).
    Assume that (has_lb (sequence_ub a (i))) (ii).
    Define L_with_proof := (lim_sup_bdd a (i) (ii)).
    Define L := (proj1_sig L_with_proof).
    Define sequence_ub_cv_to_L := (proj2_sig L_with_proof).
    We claim that (∃ m : ℕ → ℕ, is_index_seq m 
      ∧ ∀ k : ℕ, a (m k) > L - 1 / (INR(k) + 1)) (iii).
    {
      By exists_subseq_to_limsup_bdd it holds that 
        (there exists n : ℕ ⇨ ℕ, is_index_seq n 
          ∧ (for all k : ℕ, a (n k) > proj1_sig (lim_sup_bdd a (i) (ii)) - 1 / (k + 1))) (iv).
      Obtain m_seq according to (iv), so for m_seq : ℕ ⇨ ℕ it holds that
       (is_index_seq m_seq ∧
        (for all k : ℕ, a (m_seq k) > proj1_sig (lim_sup_bdd a i ii) - 1 / (k + 1))) (v).
      Because (v) both (is_index_seq m_seq) and 
        (for all k : ℕ, a (m_seq k) > proj1_sig (lim_sup_bdd a (i) (ii)) - 1 / (k + 1)) hold.
      Choose m := m_seq.
      We show both statements.
      - We need to show that (is_index_seq m).
        We conclude that (is_index_seq m).
      - We need to show that (for all k : ℕ, a (m k) > L - 1 / (k + 1)).
        We conclude that (∀ k : ℕ, a (m k) > L - 1 / (INR(k) + 1)).
    }
    Obtain m according to (iii), so for m : ℕ ⇨ ℕ it holds that
      (is_index_seq m ∧ (for all k : ℕ, a (m k) > L - 1 / (k + 1))) (iv).
    Because (iv) both (is_index_seq m) (v) and
      (for all k : ℕ, a (m k) > L - 1 / (k + 1)) (vi) hold.
    Choose n := m.
    We need to show that (is_index_seq m ∧ Un_cv (k) ↦ (a (m k)) L).
    We show both statements.
    - We need to show that (is_index_seq m).
      By (v) we conclude that (is_index_seq n).
    - We need to show that (Un_cv (k) ↦ (a (n k)) L).
      (** TODO: an equivalent to "apply with" would be nice here *)
      apply (squeeze_theorem (fun (k : ℕ) ↦ L - 1 / (INR k + 1)) 
        (fun (k : ℕ) ↦ (a (n k)))
        (sequence_ub a (i))).
      + (* apply squeeze_theorem with (c := sequence_ub a (i))
        (a := fun (k : ℕ) ↦ L - 1 / (INR k + 1)).*)
        Take k : ℕ.
        We show both statements.
        * We need to show that (L - 1 / (k + 1) ≤ a (n k)).
          By (vi) it holds that (a (m k) > L - 1 / (k+1)).
          We conclude that (L - 1 / (k + 1) ≤ a (n k)).
        * We need to show that (a (n k) ≤ sequence_ub a (i) k).
          By index_seq_grows_0 it holds that (m k ≥ k)%nat.
          By sequence_ub_bds we conclude that (a (n k) ≤ sequence_ub a (i) k).
      + (*TODO: fix not being able to use notation convergence with ''By ... we conclude that ...*)
        We need to show that (Un_cv (k ↦ (L - 1 / (k + 1))) L).
        By lim_const_min_1_over_n_plus_1 we conclude that (Un_cv (k) ↦ (L - 1 / (k + 1)) L).
      + By sequence_ub_cv_to_L we conclude that (sequence_ub a (i) ⟶ L).
Qed.

(** ## The Bolzano-Weierstrass Theorem*)
Theorem Bolzano_Weierstrass :
  ∀ (a : ℕ → ℝ), has_ub a ⇒ (has_lb a ⇒ 
    ∃ (n : ℕ → ℕ) (l : ℝ), is_index_seq n ∧
      Un_cv (fun (k : ℕ) ↦ a (n k)) l ).
Proof.
    Take a : (ℕ → ℝ).
    Assume that (has_ub a) (i).
    Assume that (has_lb a) (ii).
    Define iii := (maj_min a (i) (ii)).
    By Bolzano_Weierstrass_gen it holds that
      (∃ (n : ℕ → ℕ), is_index_seq n
        ∧ Un_cv (fun (k : ℕ) ↦ a (n k)) (proj1_sig (lim_sup_bdd a (i) (iii)))) (iv).
    Obtain n0 according to (iv), so for n0 : ℕ → ℕ it holds that
      (is_index_seq n0 ∧ Un_cv (fun (k : ℕ) ↦ a (n0 k)) (proj1_sig (lim_sup_bdd a (i) (iii)))).
    Choose n := n0.
    Choose l := (proj1_sig (lim_sup_bdd a (i) (iii))).
    We conclude that (is_index_seq n ∧ Un_cv (k) ↦ (a (n k)) (proj1_sig (lim_sup_bdd a (i) (iii)))).
Qed.

Lemma acc_pt_bds_seq_ub :
  ∀ (a : ℕ → ℝ) (i : has_ub a) (x : ℝ),
    is_seq_acc_pt a x ⇒ ∀ m : ℕ, x ≤ sequence_ub a (i) m.
Proof.
    Take a : (ℕ → ℝ).
    Assume that (has_ub a) (i).
    Take x : ℝ.
    Assume that (is_seq_acc_pt a x) (ii).
    Expand the definition of is_seq_acc_pt in (ii).
    That is, write (ii) as (there exists n : ℕ → ℕ, is_index_seq n 
      ∧ Un_cv (k) ↦ (a (n k)) x).
    Obtain n according to (ii), so for n : ℕ → ℕ it holds that 
      (is_index_seq n ∧ Un_cv (k) ↦ (a (n k)) x) (iii).
    Because (iii) both (is_index_seq n) and (Un_cv (k) ↦ (a (n k)) x) hold.
    Take m : ℕ.
    Define L := (sequence_ub a (i) m).
    We argue by contradiction.
    Assume that (~ x <= L).
    It holds that (L < x).
    Define ε := (x - L).
    It holds that (ε > 0).
    It holds that (∃ K : ℕ, ∀ k : ℕ, (k ≥ K)%nat ⇒ R_dist (a (n k)) x < ε) (iv).
    Obtain K according to (iv), so for K : nat it holds that
      (∀ k : ℕ, (k ≥ K)%nat ⇒ R_dist (a (n k)) x < ε).
    Define Nn := (Nat.max K m).
    It holds that (R_dist (a (n Nn)) x < ε).
    By Rabs_def2 it holds that (a (n Nn) - x < ε ∧ - ε < a (n Nn) - x) (v).
    Because (v) both (a (n Nn) - x < ε) and (- ε < a (n Nn) - x) hold.
    It holds that (x - a (n Nn) < x - L).
    It holds that (a (n Nn) > L).
    By index_seq_grows_0 it holds that (n Nn ≥ Nn)%nat.
    By sequence_ub_bds it holds that (a (n Nn) ≤ L).
    It holds that (~ a (n Nn) > L).
    Contradiction.
Qed.

(** ## Comparing definitions of lim sup*)
Lemma lim_sup_bdd_is_sup_seq_acc_pts :
  ∀ (a : ℕ → ℝ) (i : has_ub a) (ii : has_lb (sequence_ub a (i))),
    is_sup (is_seq_acc_pt a) (proj1_sig (lim_sup_bdd a (i) (ii))).
Proof.
    Take a : (ℕ → ℝ).
    Assume that (has_ub a) (i).
    Assume that (has_lb (sequence_ub a (i))) (ii).
    (* TODO: fix that we refer to is_lub here. Moreover, we show both statements should work immediately. *)
    Expand the definition of is_lub.
    That is, write the goal as 
      (is_upper_bound (is_seq_acc_pt a) (proj1_sig (lim_sup_bdd a (i) (ii)))
      ∧ (for all b : ℝ, is_upper_bound (is_seq_acc_pt a) b ⇨ proj1_sig (lim_sup_bdd a (i) (ii)) ≤ b)).
    We show both statements.
    - We need to show that (is_upper_bound (is_seq_acc_pt a) (proj1_sig (lim_sup_bdd a (i) (ii)))).
      Expand the definition of is_upper_bound.
      That is, write the goal as (for all x : ℝ, is_seq_acc_pt a x ⇨ x ≤ proj1_sig (lim_sup_bdd a (i) (ii))).
      Take x : ℝ.
      Assume that (is_seq_acc_pt a x).
      By acc_pt_bds_seq_ub it holds that (∀ m : ℕ, x ≤ sequence_ub a (i) m).
      Define iii := (lim_sup_bdd a (i) (ii)).
      Obtain L according to (iii), so for L  : R it holds that (Un_cv (sequence_ub a i) L).
      simpl.
      By (low_bd_seq_is_low_bd_lim (sequence_ub a (i)))
          it holds that (L ≥ x).
      We conclude that (x ≤ L).
    - We need to show that (for all b : ℝ, is_upper_bound (is_seq_acc_pt a) b 
        ⇨ proj1_sig (lim_sup_bdd a (i) (ii)) ≤ b).
      Take b : ℝ; such that (is_upper_bound (is_seq_acc_pt a) b) (iii).
      Expand the definition of is_upper_bound in (iii).
      That is, write (iii) as (for all x : ℝ, is_seq_acc_pt a x ⇨ x ≤ b).
      Expand the definition of is_seq_acc_pt in (iii).
      That is, write (iii) as (for all x : ℝ, 
        (there exists n : ℕ ⇨ ℕ, is_index_seq n ∧ Un_cv (k) ↦ (a (n k)) x) ⇨ x ≤ b).
      It suffices to show that (there exists n : ℕ ⇨ ℕ, is_index_seq n
        ∧ Un_cv (k) ↦ (a (n k)) (proj1_sig (lim_sup_bdd a (i) (ii)))).
      By Bolzano_Weierstrass_gen we conclude that (there exists n : ℕ ⇨ ℕ, is_index_seq n
        ∧ Un_cv (k) ↦ (a (n k)) (proj1_sig (lim_sup_bdd a (i) (ii)))).
Qed.

(** ## Some attempts to get nicer subsequences*)
(** In a sequence, either there are finitely many terms larger than or equal to a given number $L$, or for every $N$ there is an $n \geq N$ such that $a_n \geq L$.*)
Lemma finite_or_find_one :
  ∀ (a : ℕ → ℝ) (L : ℝ),
    (∃ N : ℕ, ∀ k : ℕ, (k >= N)%nat ⇒ a k < L) 
       ∨ 
    (∀ m : ℕ, ∃ n : ℕ, (n >= m)%nat ∧ a n ≥ L).
Proof.
    Take a : (ℕ → ℝ).
    Take L : ℝ.
    Define P := (∃ N : ℕ, ∀ k : ℕ, (k >= N)%nat ⇒ a k < L).
    By classic it holds that (P \/ ~P) (i).
    Because (i) either P or (¬P) holds.
    - Case P.
      It suffices to show that (∃ N : ℕ, ∀ k : ℕ, (k >= N)%nat ⇒ a k < L).
      We conclude that (∃ N : ℕ, ∀ k : ℕ, (k >= N)%nat ⇒ a k < L).
    - Case (¬P).
      It suffices to show that (∀ m : ℕ, ∃ n : ℕ, (n ≥ m)%nat ∧ a n ≥ L).
      It holds that (~ ∃ N : ℕ, ∀ k : ℕ, (k >= N)%nat ⇒ a k < L).
      We conclude that (∀ m : ℕ, ∃ n : ℕ, (n ≥ m)%nat ∧ a n ≥ L).
Qed.