{-# OPTIONS --cubical --cumulativity #-}

module leibniz-equality where

open import Cubical.Foundations.Isomorphism
open import Cubical.Foundations.Function
open import Cubical.Data.Equality
open import Agda.Primitive

open import leibniz
open Leibniz

liftIso' : ∀ {a b} {B : Type b} → Iso {b} {a ⊔ b} B B
liftIso' = iso (λ x → x) (λ y → y) (λ x i → x) (λ y i → y)

liftIso : ∀ {a b} {A : Type a} {B : Type b} → Iso {a ⊔ b} {b} A B → Iso {a ⊔ b} {a ⊔ b} A B
liftIso {a} f = compIso f (liftIso' {a})


module FinalEquality (A : Set) where
  open MainResult A

  ≐≅≡ : ∀ {a b} → Iso (a ≐ b) (a ≡p b)
  ≐≅≡ = iso j i (ptoc ∘ ji) (ptoc ∘ ij)

  ≐≡≡' : ∀ {a b} → (a ≐ b) ≡c (a ≡p b)
  ≐≡≡' = let lifted = liftIso ≐≅≡  in isoToPath lifted

  ≐≡≡ : _≐_ ≡c _≡p_
  ≐≡≡ i a b = ≐≡≡' {a} {b} i
