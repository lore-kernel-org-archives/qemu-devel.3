Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 515DECCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 07:55:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3re3-0006sB-4X; Wed, 01 Oct 2025 03:53:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3rdo-0006bg-7H
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 03:52:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3rdd-00037e-BE
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 03:52:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759305151;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6UgNsg+9ytrlpHwm/sbKqP2fFr5axX+BwklO0H9vEu0=;
 b=B7Ww/IU9QcFGmBiUfQi4YBrTvNocMS/OpslHc48O8OptEKHUTXyOwOuRJRkeY8JC9epxFy
 VE2FwW4j7ECCYXgU+D22FSHfkSVe02oT97wompUbnVJ8egvn9iMHjWi0cv9LRd7DlFmWw/
 sNH9HZjLyCbpv5qUpimrvEOTbyWK4zI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-aBBGGp2INACbLhVYutzk1g-1; Wed, 01 Oct 2025 03:52:30 -0400
X-MC-Unique: aBBGGp2INACbLhVYutzk1g-1
X-Mimecast-MFC-AGG-ID: aBBGGp2INACbLhVYutzk1g_1759305149
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-6365fb32d66so1990210a12.0
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 00:52:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759305148; x=1759909948;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6UgNsg+9ytrlpHwm/sbKqP2fFr5axX+BwklO0H9vEu0=;
 b=LHZouMD54Pa5Qi+GYFL3X1c1rMc/h+zOfWGiVWGwyaKH6hjigeUvRL2lsi98JVIoNx
 0Z2iv0dpC7gX7u4khl7YESGFOH61x5AolMkGXuVcErbAbplsGqNB6eOyE8dwNY5X8lxH
 Bys0z0Iw9jfXJlwRJUll9MrgMJS9yyz9ccPulM5iVrUqQexI9+NTnNms2sq6YNgc23FL
 vTmODzvve8TX2QWeYac5W5h8uY+NQqr8W3MIMS8/8r5y61T5JHRoS+jg76oGJ9zxWd+h
 132ODwkUijkquxBwwVOtT8f3XfBsaPGKdYw91IEV6UkfWJWl+6KCzkStrgod0UAwPapA
 1qsw==
X-Gm-Message-State: AOJu0YzZ72gFxabZYWgT8Ao8jEyulWBDG8P+M59EK0svH7a0EIAcPqYe
 9jHGaflKMML48i+NSEeGFgiaNV+G3Pzfd2ITUXB2ubF838lvwv1ReozNIbzfScvsK8UKlxLWJxB
 rzgcB6Txs1IjSboaaRSD1N6wJdUmqNwFhvWtHSlWebsnqvXUU/x2JxwvbGpOkHzYx+G99U2Xkij
 8kjzLekm57WdMVi8kzoBO36vUMPG75i40ToowRg3Rz
X-Gm-Gg: ASbGncv2QpkEyxSpRGm8DwEc871BH6F2j0sBCDIxtq2AfscaRy+WUVW4HfAWD7lyQkA
 WygkPXHwoKUJ/G0uAG7Wfh2l7sa7DeGFq5JqMwYzi/DwfMy53UybLTyYMbFjA+7q+VKHlzI1ahX
 9czakEMA30m8SNNqI8BNlZPJ5c7NYAxXUHtQUaXbYJMM2A8jFyJ85oTxDThWUSc0DQw7kXKSWoJ
 ZA5/XGUcx1wXjJjX1Fcuf2OVCT+YPeIRSLe3hv8GXXsWt3eZ6ZHDSUB+NTw0HB/7THKMNMx6iaK
 6ssAciWbRi2qAaPGU9R+p6uyYChwp/y3rraTzlseT3IE/Hgb7gb+NNTaVKD0Yb2p9UemhFXDNVQ
 MWfCs5f8QXdLBgiaLZJFY3QpHjIGPF1RaygRAX8o2QjvOF3LlvbY=
X-Received: by 2002:a50:ed19:0:b0:633:e4e7:76af with SMTP id
 4fb4d7f45d1cf-63678cfcb2amr2188827a12.33.1759305147780; 
 Wed, 01 Oct 2025 00:52:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/eOwp9/Wq7zArvPld4wBQt+LsULL9niwn6AQ+aO18U6ipi+23wHa2WAuOIUxh+63YNziSuQ==
X-Received: by 2002:a50:ed19:0:b0:633:e4e7:76af with SMTP id
 4fb4d7f45d1cf-63678cfcb2amr2188798a12.33.1759305147069; 
 Wed, 01 Oct 2025 00:52:27 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.127.188])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-634bf4a5351sm9114469a12.43.2025.10.01.00.52.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 00:52:25 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 07/11] rust: migration: add high-level migration wrappers
Date: Wed,  1 Oct 2025 09:52:06 +0200
Message-ID: <20251001075210.1042479-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001075005.1041833-1-pbonzini@redhat.com>
References: <20251001075005.1041833-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Instead of dealing with pre/post callbacks, allow devices to
implement a snapshot/restore mechanism; this has two main
advantages:

- it can be easily implemented via procedural macros

- there can be generic implementations to deal with various
  kinds of interior-mutable containers, from BqlRefCell to Mutex,
  so that C code does not see Rust concepts such as Mutex<>.

Using it is easy; you can implement the snapshot/restore trait
ToMigrationState and declare your state like:

     regs: Migratable<Mutex<MyDeviceRegisters>>

Migratable<> allows dereferencing to the underlying object with
no run-time cost.

Note that Migratable<> actually does not accept ToMigrationState,
only the similar ToMigrationStateShared trait that the user will mostly
not care about.  This is required by the fact that pre/post callbacks
take a &self, and ensures that the argument is a Mutex or BqlRefCell
(including an array or Arc<> thereof).

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/rust.rst              |   1 +
 rust/migration/meson.build       |   1 +
 rust/migration/src/lib.rs        |   3 +
 rust/migration/src/migratable.rs | 434 +++++++++++++++++++++++++++++++
 4 files changed, 439 insertions(+)
 create mode 100644 rust/migration/src/migratable.rs

diff --git a/docs/devel/rust.rst b/docs/devel/rust.rst
index 2f0ab2e2821..79c26d9d165 100644
--- a/docs/devel/rust.rst
+++ b/docs/devel/rust.rst
@@ -155,6 +155,7 @@ module                     status
 ``hwcore::irq``            complete
 ``hwcore::qdev``           stable
 ``hwcore::sysbus``         stable
+``migration::migratable``  proof of concept
 ``migration::vmstate``     stable
 ``qom``                    stable
 ``system::memory``         stable
diff --git a/rust/migration/meson.build b/rust/migration/meson.build
index e381c76d3e8..1ba0ec21d72 100644
--- a/rust/migration/meson.build
+++ b/rust/migration/meson.build
@@ -31,6 +31,7 @@ _migration_rs = static_library(
     [
       'src/lib.rs',
       'src/bindings.rs',
+      'src/migratable.rs',
       'src/vmstate.rs',
     ],
     {'.' : _migration_bindings_inc_rs},
diff --git a/rust/migration/src/lib.rs b/rust/migration/src/lib.rs
index 5f51dde4406..efe9896b619 100644
--- a/rust/migration/src/lib.rs
+++ b/rust/migration/src/lib.rs
@@ -2,5 +2,8 @@
 
 pub mod bindings;
 
+pub mod migratable;
+pub use migratable::*;
+
 pub mod vmstate;
 pub use vmstate::*;
diff --git a/rust/migration/src/migratable.rs b/rust/migration/src/migratable.rs
new file mode 100644
index 00000000000..46e533c16d1
--- /dev/null
+++ b/rust/migration/src/migratable.rs
@@ -0,0 +1,434 @@
+// Copyright 2025 Red Hat, Inc.
+// Author(s): Paolo Bonzini <pbonzini@redhat.com>
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+use std::{
+    fmt,
+    mem::size_of,
+    ptr::{self, addr_of, NonNull},
+    sync::{Arc, Mutex},
+};
+
+use bql::{BqlCell, BqlRefCell};
+use common::Zeroable;
+
+use crate::{
+    bindings, vmstate_fields_ref, vmstate_of, InvalidError, VMState, VMStateDescriptionBuilder,
+};
+
+/// Enables QEMU migration support even when a type is wrapped with
+/// synchronization primitives (like `Mutex`) that the C migration
+/// code cannot directly handle. The trait provides methods to
+/// extract essential state for migration and restore it after
+/// migration completes.
+///
+/// On top of extracting data from synchronization wrappers during save
+/// and restoring it during load, it's also possible to use `ToMigrationState`
+/// to convert runtime representations to migration-safe formats.
+///
+/// # Examples
+///
+/// ```
+/// use bql::BqlCell;
+/// use migration::{InvalidError, ToMigrationState, VMState};
+/// # use migration::VMStateField;
+///
+/// # #[derive(Debug, PartialEq, Eq)]
+/// struct DeviceState {
+///     counter: BqlCell<u32>,
+///     enabled: bool,
+/// }
+///
+/// # #[derive(Debug)]
+/// #[derive(Default)]
+/// struct DeviceMigrationState {
+///     counter: u32,
+///     enabled: bool,
+/// }
+///
+/// # unsafe impl VMState for DeviceMigrationState {
+/// #     const BASE: VMStateField = ::common::Zeroable::ZERO;
+/// # }
+/// impl ToMigrationState for DeviceState {
+///     type Migrated = DeviceMigrationState;
+///
+///     fn snapshot_migration_state(
+///         &self,
+///         target: &mut Self::Migrated,
+///     ) -> Result<(), InvalidError> {
+///         target.counter = self.counter.get();
+///         target.enabled = self.enabled;
+///         Ok(())
+///     }
+///
+///     fn restore_migrated_state_mut(
+///         &mut self,
+///         source: Self::Migrated,
+///         _version_id: u8,
+///     ) -> Result<(), InvalidError> {
+///         self.counter.set(source.counter);
+///         self.enabled = source.enabled;
+///         Ok(())
+///     }
+/// }
+/// # bql::start_test();
+/// # let dev = DeviceState { counter: 10.into(), enabled: true };
+/// # let mig = dev.to_migration_state().unwrap();
+/// # assert!(matches!(*mig, DeviceMigrationState { counter: 10, enabled: true }));
+/// # let mut dev2 = DeviceState { counter: 42.into(), enabled: false };
+/// # dev2.restore_migrated_state_mut(*mig, 1).unwrap();
+/// # assert_eq!(dev2, dev);
+/// ```
+pub trait ToMigrationState {
+    /// The type used to represent the migrated state.
+    type Migrated: Default + VMState;
+
+    /// Capture the current state into a migration-safe format, failing
+    /// if the state cannot be migrated.
+    fn snapshot_migration_state(&self, target: &mut Self::Migrated) -> Result<(), InvalidError>;
+
+    /// Restores state from a migrated representation, failing if the
+    /// state cannot be restored.
+    fn restore_migrated_state_mut(
+        &mut self,
+        source: Self::Migrated,
+        version_id: u8,
+    ) -> Result<(), InvalidError>;
+
+    /// Convenience method to combine allocation and state capture
+    /// into a single operation.
+    fn to_migration_state(&self) -> Result<Box<Self::Migrated>, InvalidError> {
+        let mut migrated = Box::<Self::Migrated>::default();
+        self.snapshot_migration_state(&mut migrated)?;
+        Ok(migrated)
+    }
+}
+
+// Implementations for primitive types.  Do not use a blanket implementation
+// for all Copy types, because [T; N] is Copy if T is Copy; that would conflict
+// with the below implementation for arrays.
+macro_rules! impl_for_primitive {
+    ($($t:ty),*) => {
+        $(
+            impl ToMigrationState for $t {
+                type Migrated = Self;
+
+                fn snapshot_migration_state(
+                    &self,
+                    target: &mut Self::Migrated,
+                ) -> Result<(), InvalidError> {
+                    *target = *self;
+                    Ok(())
+                }
+
+                fn restore_migrated_state_mut(
+                    &mut self,
+                    source: Self::Migrated,
+                    _version_id: u8,
+                ) -> Result<(), InvalidError> {
+                    *self = source;
+                    Ok(())
+                }
+            }
+        )*
+    };
+}
+
+impl_for_primitive!(u8, u16, u32, u64, i8, i16, i32, i64, bool);
+
+impl<T: ToMigrationState, const N: usize> ToMigrationState for [T; N]
+where
+    [T::Migrated; N]: Default,
+{
+    type Migrated = [T::Migrated; N];
+
+    fn snapshot_migration_state(&self, target: &mut Self::Migrated) -> Result<(), InvalidError> {
+        for (item, target_item) in self.iter().zip(target.iter_mut()) {
+            item.snapshot_migration_state(target_item)?;
+        }
+        Ok(())
+    }
+
+    fn restore_migrated_state_mut(
+        &mut self,
+        source: Self::Migrated,
+        version_id: u8,
+    ) -> Result<(), InvalidError> {
+        for (item, source_item) in self.iter_mut().zip(source) {
+            item.restore_migrated_state_mut(source_item, version_id)?;
+        }
+        Ok(())
+    }
+}
+
+impl<T: ToMigrationState> ToMigrationState for Mutex<T> {
+    type Migrated = T::Migrated;
+
+    fn snapshot_migration_state(&self, target: &mut Self::Migrated) -> Result<(), InvalidError> {
+        self.lock().unwrap().snapshot_migration_state(target)
+    }
+
+    fn restore_migrated_state_mut(
+        &mut self,
+        source: Self::Migrated,
+        version_id: u8,
+    ) -> Result<(), InvalidError> {
+        self.get_mut()
+            .unwrap()
+            .restore_migrated_state_mut(source, version_id)
+    }
+}
+
+impl<T: ToMigrationState> ToMigrationState for BqlRefCell<T> {
+    type Migrated = T::Migrated;
+
+    fn snapshot_migration_state(&self, target: &mut Self::Migrated) -> Result<(), InvalidError> {
+        self.borrow().snapshot_migration_state(target)
+    }
+
+    fn restore_migrated_state_mut(
+        &mut self,
+        source: Self::Migrated,
+        version_id: u8,
+    ) -> Result<(), InvalidError> {
+        self.get_mut()
+            .restore_migrated_state_mut(source, version_id)
+    }
+}
+
+/// Extension trait for types that support migration state restoration
+/// through interior mutability.
+///
+/// This trait extends [`ToMigrationState`] for types that can restore
+/// their state without requiring mutable access. While user structs
+/// will generally use `ToMigrationState`, the device will have multiple
+/// references and therefore the device struct has to employ an interior
+/// mutability wrapper like [`Mutex`] or [`BqlRefCell`].
+///
+/// Anything that implements this trait can in turn be used within
+/// [`Migratable<T>`], which makes no assumptions on how to achieve mutable
+/// access to the runtime state.
+///
+/// # Examples
+///
+/// ```
+/// use std::sync::Mutex;
+///
+/// use migration::ToMigrationStateShared;
+///
+/// let device_state = Mutex::new(42);
+/// // Can restore without &mut access
+/// device_state.restore_migrated_state(100, 1).unwrap();
+/// assert_eq!(*device_state.lock().unwrap(), 100);
+/// ```
+pub trait ToMigrationStateShared: ToMigrationState {
+    /// Restores state from a migrated representation to an interior-mutable
+    /// object.  Similar to `restore_migrated_state_mut`, but requires a
+    /// shared reference; therefore it can be used to restore a device's
+    /// state even though devices have multiple references to them.
+    fn restore_migrated_state(
+        &self,
+        source: Self::Migrated,
+        version_id: u8,
+    ) -> Result<(), InvalidError>;
+}
+
+impl<T: ToMigrationStateShared, const N: usize> ToMigrationStateShared for [T; N]
+where
+    [T::Migrated; N]: Default,
+{
+    fn restore_migrated_state(
+        &self,
+        source: Self::Migrated,
+        version_id: u8,
+    ) -> Result<(), InvalidError> {
+        for (item, source_item) in self.iter().zip(source) {
+            item.restore_migrated_state(source_item, version_id)?;
+        }
+        Ok(())
+    }
+}
+
+// Arc requires the contained object to be interior-mutable
+impl<T: ToMigrationStateShared> ToMigrationState for Arc<T> {
+    type Migrated = T::Migrated;
+
+    fn snapshot_migration_state(&self, target: &mut Self::Migrated) -> Result<(), InvalidError> {
+        (**self).snapshot_migration_state(target)
+    }
+
+    fn restore_migrated_state_mut(
+        &mut self,
+        source: Self::Migrated,
+        version_id: u8,
+    ) -> Result<(), InvalidError> {
+        (**self).restore_migrated_state(source, version_id)
+    }
+}
+
+impl<T: ToMigrationStateShared> ToMigrationStateShared for Arc<T> {
+    fn restore_migrated_state(
+        &self,
+        source: Self::Migrated,
+        version_id: u8,
+    ) -> Result<(), InvalidError> {
+        (**self).restore_migrated_state(source, version_id)
+    }
+}
+
+// Interior-mutable types.  Note how they only require ToMigrationState for
+// the inner type!
+
+impl<T: ToMigrationState> ToMigrationStateShared for Mutex<T> {
+    fn restore_migrated_state(
+        &self,
+        source: Self::Migrated,
+        version_id: u8,
+    ) -> Result<(), InvalidError> {
+        self.lock()
+            .unwrap()
+            .restore_migrated_state_mut(source, version_id)
+    }
+}
+
+impl<T: ToMigrationState> ToMigrationStateShared for BqlRefCell<T> {
+    fn restore_migrated_state(
+        &self,
+        source: Self::Migrated,
+        version_id: u8,
+    ) -> Result<(), InvalidError> {
+        self.borrow_mut()
+            .restore_migrated_state_mut(source, version_id)
+    }
+}
+
+/// A wrapper that enables QEMU migration for types with shared state.
+///
+/// `Migratable<T>` provides a bridge between Rust types that use interior
+/// mutability (like `Mutex<T>`) and QEMU's C-based migration infrastructure.
+/// It manages the lifecycle of migration state and provides automatic
+/// conversion between runtime and migration representations.
+///
+/// ```ignore
+/// # use std::sync::Mutex;
+/// # use migration::Migratable;
+///
+/// pub struct DeviceRegs {
+///     status: u32,
+/// }
+///
+/// pub struct SomeDevice {
+///     // ...
+///     registers: Migratable<Mutex<DeviceRegs>>,
+/// }
+/// ```
+#[repr(C)]
+pub struct Migratable<T: ToMigrationStateShared> {
+    /// Pointer to migration state, valid only during migration operations.
+    /// C vmstate does not support NULL pointers, so no `Option<Box<>>`.
+    migration_state: BqlCell<*mut T::Migrated>,
+
+    /// The runtime state that can be accessed during normal operation
+    runtime_state: T,
+}
+
+impl<T: ToMigrationStateShared> std::ops::Deref for Migratable<T> {
+    type Target = T;
+
+    fn deref(&self) -> &Self::Target {
+        &self.runtime_state
+    }
+}
+
+impl<T: ToMigrationStateShared> std::ops::DerefMut for Migratable<T> {
+    fn deref_mut(&mut self) -> &mut Self::Target {
+        &mut self.runtime_state
+    }
+}
+
+impl<T: ToMigrationStateShared> Migratable<T> {
+    /// Creates a new `Migratable` wrapper around the given runtime state.
+    ///
+    /// # Returns
+    /// A new `Migratable` instance ready for use and migration
+    pub fn new(runtime_state: T) -> Self {
+        Self {
+            migration_state: BqlCell::new(ptr::null_mut()),
+            runtime_state,
+        }
+    }
+
+    fn pre_save(&self) -> Result<(), InvalidError> {
+        let state = self.runtime_state.to_migration_state()?;
+        self.migration_state.set(Box::into_raw(state));
+        Ok(())
+    }
+
+    fn post_save(&self) -> Result<(), InvalidError> {
+        let state = unsafe { Box::from_raw(self.migration_state.replace(ptr::null_mut())) };
+        drop(state);
+        Ok(())
+    }
+
+    fn pre_load(&self) -> Result<(), InvalidError> {
+        self.migration_state
+            .set(Box::into_raw(Box::<T::Migrated>::default()));
+        Ok(())
+    }
+
+    fn post_load(&self, version_id: u8) -> Result<(), InvalidError> {
+        let state = unsafe { Box::from_raw(self.migration_state.replace(ptr::null_mut())) };
+        self.runtime_state
+            .restore_migrated_state(*state, version_id)
+    }
+}
+
+impl<T: ToMigrationStateShared + fmt::Debug> fmt::Debug for Migratable<T>
+where
+    T::Migrated: fmt::Debug,
+{
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        let mut struct_f = f.debug_struct("Migratable");
+        struct_f.field("runtime_state", &self.runtime_state);
+
+        let state = NonNull::new(self.migration_state.get()).map(|x| unsafe { x.as_ref() });
+        struct_f.field("migration_state", &state);
+        struct_f.finish()
+    }
+}
+
+impl<T: ToMigrationStateShared + Default> Default for Migratable<T> {
+    fn default() -> Self {
+        Self::new(T::default())
+    }
+}
+
+impl<T: 'static + ToMigrationStateShared> Migratable<T> {
+    const FIELD: bindings::VMStateField = vmstate_of!(Self, migration_state);
+
+    const FIELDS: &[bindings::VMStateField] = vmstate_fields_ref! {
+        Migratable::<T>::FIELD
+    };
+
+    const VMSD: &'static bindings::VMStateDescription = VMStateDescriptionBuilder::<Self>::new()
+        .version_id(1)
+        .minimum_version_id(1)
+        .pre_save(&Self::pre_save)
+        .pre_load(&Self::pre_load)
+        .post_save(&Self::post_save)
+        .post_load(&Self::post_load)
+        .fields(Self::FIELDS)
+        .build()
+        .as_ref();
+}
+
+unsafe impl<T: 'static + ToMigrationStateShared> VMState for Migratable<T> {
+    const BASE: bindings::VMStateField = {
+        bindings::VMStateField {
+            vmsd: addr_of!(*Self::VMSD),
+            size: size_of::<Self>(),
+            flags: bindings::VMStateFlags::VMS_STRUCT,
+            ..Zeroable::ZERO
+        }
+    };
+}
-- 
2.51.0


