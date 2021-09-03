{-# OPTIONS --cubical --type-in-type #-}

module leibniz-equality where

open import Cubical.Foundations.Isomorphism
open import Cubical.Foundations.Function
open import Cubical.Data.Equality
open import Agda.Primitive

open import equalities
open import leibniz
open Leibniz

liftIso : ∀ {a b} {A : Type a} {B : Type b} → Iso {a} {b} A B → Iso {a ⊔ b} {a ⊔ b} A B
liftIso {a} f = iso fun inv (λ x i → rightInv x i) (λ x i → leftInv x i)
  where open Iso f

module FinalEquality {A : Set} where
  open MainResult A

  ≐≅≡ : ∀ {a b} → Iso (a ≐ b) (a ≡p b)
  ≐≅≡ = iso j i (ptoc ∘ ji) (ptoc ∘ ij)

  ≐≡≡' : ∀ {a b} → (a ≐ b) ≡c (a ≡p b)
  ≐≡≡' = let lifted = liftIso ≐≅≡  in isoToPath lifted

  ≐≡≡ : _≐_ {A} ≡c _≡p_
  ≐≡≡ i x y = ≐≡≡' {x} {y} i

  open IsEquality

  instance
    ≐-IsEquality : IsEquality {_} {A} _≐_
    ≐-IsEquality = eq (≐≡≡ ∙ ≡p-IsEquality .≣-≡-≡)
