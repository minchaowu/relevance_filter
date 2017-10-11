import _target.deps.mathlib.category.basic
import _target.deps.mathlib.algebra.ordered_monoid
import _target.deps.mathlib.algebra.big_operators
import _target.deps.mathlib.algebra.ring
import _target.deps.mathlib.algebra.group_power
import _target.deps.mathlib.algebra.group
import _target.deps.mathlib.algebra.module
import _target.deps.mathlib.algebra.field
import _target.deps.mathlib.theories.set_theory
import _target.deps.mathlib.pending.default
import _target.deps.mathlib.tactic.finish
import _target.deps.mathlib.tactic.alias
import _target.deps.mathlib.tactic.rcases
import _target.deps.mathlib.tactic.converter.old_conv
import _target.deps.mathlib.tactic.converter.interactive
import _target.deps.mathlib.tactic.converter.binders
import _target.deps.mathlib.tactic.default
import _target.deps.mathlib.tactic.interactive
import _target.deps.mathlib.topology.topological_space
import _target.deps.mathlib.topology.topological_structures
import _target.deps.mathlib.topology.measure
import _target.deps.mathlib.topology.continuity
import _target.deps.mathlib.topology.infinite_sum
import _target.deps.mathlib.topology.ennreal
import _target.deps.mathlib.topology.measurable_space
import _target.deps.mathlib.topology.uniform_space
import _target.deps.mathlib.topology.metric_space
import _target.deps.mathlib.topology.real
import _target.deps.mathlib.logic.basic
import _target.deps.mathlib.logic.function_inverse
import _target.deps.mathlib.data.seq.wseq
import _target.deps.mathlib.data.seq.parallel
import _target.deps.mathlib.data.seq.seq
import _target.deps.mathlib.data.seq.computation
import _target.deps.mathlib.data.fin
import _target.deps.mathlib.data.hash_map
import _target.deps.mathlib.data.nat.basic
import _target.deps.mathlib.data.nat.sqrt
import _target.deps.mathlib.data.nat.gcd
import _target.deps.mathlib.data.nat.sub
import _target.deps.mathlib.data.nat.pairing
import _target.deps.mathlib.data.nat.bquant
import _target.deps.mathlib.data.pnat
import _target.deps.mathlib.data.encodable
import _target.deps.mathlib.data.num.lemmas
import _target.deps.mathlib.data.num.basic
import _target.deps.mathlib.data.num.bitwise
import _target.deps.mathlib.data.array.lemmas
import _target.deps.mathlib.data.prod
import _target.deps.mathlib.data.fp.basic
import _target.deps.mathlib.data.option
import _target.deps.mathlib.data.int.basic
import _target.deps.mathlib.data.int.order
import _target.deps.mathlib.data.finset.basic
import _target.deps.mathlib.data.finset.fold
import _target.deps.mathlib.data.finset.default
import _target.deps.mathlib.data.rat
import _target.deps.mathlib.data.set.enumerate
import _target.deps.mathlib.data.set.basic
import _target.deps.mathlib.data.set.prod
import _target.deps.mathlib.data.set.lattice
import _target.deps.mathlib.data.set.default
import _target.deps.mathlib.data.set.countable
import _target.deps.mathlib.data.set.finite
import _target.deps.mathlib.data.equiv
import _target.deps.mathlib.data.bool
import _target.deps.mathlib.data.list.set
import _target.deps.mathlib.data.list.basic
import _target.deps.mathlib.data.list.comb
import _target.deps.mathlib.data.list.perm
import _target.deps.mathlib.data.list.default
import _target.deps.mathlib.data.list.sort
import _target.deps.mathlib.data.sigma.basic
import _target.deps.mathlib.data.sigma.default
import _target.deps.mathlib.data.pfun
import _target.deps.mathlib.order.zorn
import _target.deps.mathlib.order.basic
import _target.deps.mathlib.order.complete_boolean_algebra
import _target.deps.mathlib.order.boolean_algebra
import _target.deps.mathlib.order.bounds
import _target.deps.mathlib.order.lattice
import _target.deps.mathlib.order.galois_connection
import _target.deps.mathlib.order.bounded_lattice
import _target.deps.mathlib.order.default
import _target.deps.mathlib.order.filter
import _target.deps.mathlib.order.fixed_points
import _target.deps.mathlib.order.complete_lattice

import k_nn

open tactic expr
--set_option profiler true
-- the commands below are slow
/-
run_cmd
do (contents, features, ⟨n, names⟩) ← get_all_decls,
   trace n,
   trace $ name_distance features contents `list.append_nil `list.append_nil,
   trace $ name_distance features contents `list.append_nil `list.nil_append,
   trace $ name_distance features contents `list.append_nil `list.append_assoc,
   trace $ name_distance features contents `list.append_nil `hash_map.valid.as_list_length,
   trace $ name_distance features contents `list.append_nil `list.has_append,
   trace $ name_distance features contents `list.append_nil `linear_ordered_semiring.le_of_add_le_add_left,
   trace "the nearest 10 declarations to `list.append_nil`:",
   trace $ nearest_k_of_name `list.append_nil  contents features names 10,
   trace "the nearest 50 declarations to `add_le_add`:",
   trace $ nearest_k_of_name `add_le_add  contents features names 50,
   trace "the nearest 20 declarations to `(∀ x y : ℝ, x < y → ∃ z : ℝ, x < z ∧ z < y):",
   trace $ nearest_k_of_expr  `(∀ x y : ℝ, x < y → ∃ z : ℝ, x < z ∧ z < y) contents features names 20,
   trace "the most relevant facts to prove `(∀ x y : ℝ, x < y → ∃ z : ℝ, x < z ∧ z < y):",
   trace $ find_k_most_relevant_facts_to_expr `(∀ x y : ℝ, x < y → ∃ z : ℝ, x < z ∧ z < y) contents features names 20

run_cmd
do (contents, features, ⟨n, names⟩) ← get_all_decls,
   trace "number of declarations in environment:", 
   trace n,
   trace "number of constants appearing in the type of `list.append_nil`:",
   trace $ (contents.find' `list.append_nil).1.size,
   trace "number of constants appearing in the proof of `list.append_nil`:",
   trace $ (contents.find' `list.append_nil).2.size,
   trace "number of declarations whose proof contains the constant `nat`:",
   trace $ (features.find' `nat).size,
   trace "number of declarations whose proof contains the constant `real`:",
   trace $ (features.find' `real).size,
   trace "they are:",
   trace $ (features.find' `real)

-/
