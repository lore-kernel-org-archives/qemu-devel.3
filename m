Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBE03CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 08:04:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3rmQ-0005kC-Ij; Wed, 01 Oct 2025 04:01:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3rmK-0005iH-LY
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 04:01:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3rlw-00061r-T3
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 04:01:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759305666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A9PF9wocpKr4tHKqTOJUmRJZPPDhEGhAo4xKIzRERVo=;
 b=OQituGhqwIQVoupjPY+v1mM9UkyPn44vxH1VFe/Ox48PmfhGVgOltW2dPeZ7aW5jbleAAu
 8vf4IQfRIhP8zM7Vg1+nGXfFOxv4rVIkhvxeBdKDx9g6xdZbHOaA6Mol0OIZL3LeOOWA8e
 aOUCcBDDVUXuTSE/sVc6+6wufcRkbSM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-CBQX29wjPEeA6JQ2blxyUw-1; Wed, 01 Oct 2025 04:01:05 -0400
X-MC-Unique: CBQX29wjPEeA6JQ2blxyUw-1
X-Mimecast-MFC-AGG-ID: CBQX29wjPEeA6JQ2blxyUw_1759305664
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-afcb7338319so567320766b.0
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 01:01:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759305663; x=1759910463;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A9PF9wocpKr4tHKqTOJUmRJZPPDhEGhAo4xKIzRERVo=;
 b=YQT4RV+ompjVRQFS5Vj+yuuNCbPEaIT0ThPlsMvtojvST5I1PGZb/twdprrJuwZ4bt
 6bTFN5njNI8pWjfPUVuTX8441nHdWAFDJ4xApr2PHn4lIdqi6zPbk0TF0RqTC+ZHvgsN
 8BpKRSStUQw2DGXWz1UBMxDcc5Fape6bwtnWtGC9y4ctd9HE3tX3rwu43fNHE6zohERP
 nPy8E+7IPe5nkx5Ytuic0kWJmBZ5Oqv1jYFlMO98Kph5q6N5mIRAkTK1IJWb+aysDQUI
 N9MOeBOS1uw3TJzkagSzU/eZZk+NAf+yOgk2lZZX4ca+4mhvFcnycmOp+UJmQ0vtuv4x
 M/iA==
X-Gm-Message-State: AOJu0Yx9nEJrK28+Ed8N/OsfuhhL3GesTVzrkjpqDBkHt3nUqyipGofT
 bfdxMU1f6c20pbJNorKiz2UfYdoBFqJ8z4cdh8H1QlRpS7I5Jb8OctGNswl3tIacXNsVrmNZzIY
 6Aa3dFfOFWcH3hqMPbgJbkoxGjpLci89QXKwx0M4LJfIIcLYSxBse6FZgFozx/6PcETzzUI+j6p
 u2BIS9tQ0Co49FdHu0DmR2pR6b+Ib9XiJ9CulVJOKh
X-Gm-Gg: ASbGncsp+YF4BCfRCF1O30GVjeXEI1VCAUHL4fPd0IVk6O5HVaWrVkWCkA+L8OqJEPT
 U4C29XN7jK7wb1Wr6u/FWKrPVfCpT9VqBkZwmvoAGZWMLIQhuZepDtTGTnn9jbihsCyBiUA3QMo
 Mn1XMjLZvo7AhcpZhtu688GTcev58VqI0I/2JGk1bjC1x06wyyvSrKE71l6Aj/shlSsa124BtMX
 1D7dTASi8iVmeeVmvW4M6eXSc+jsX7uiwPpH77vcAv12ERzNiA73mr3iPpOxcaSyo3GPcXO7imi
 LuGs1bPM2CGCgnOKkjLN8PmXXPBmaun2V00Pw/zzW5VC2Uuo/P2hWVjoTLaOyIiU0RBSiu2W0Pc
 4hSSKpxu7FamVDXWMxhHanMsPjD9a1Qi822DJoD+MXZetW19AylQ=
X-Received: by 2002:a17:907:3f8c:b0:b3d:7e5c:8578 with SMTP id
 a640c23a62f3a-b46e2436403mr365285566b.12.1759305662686; 
 Wed, 01 Oct 2025 01:01:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQR/t5nVKKRvg8n/5/D4brEMuY3YFvkcqcZ+wqR2v0RBFywUc4mJ2X2bMo4BAfneyqVCHerw==
X-Received: by 2002:a17:907:3f8c:b0:b3d:7e5c:8578 with SMTP id
 a640c23a62f3a-b46e2436403mr365273566b.12.1759305661546; 
 Wed, 01 Oct 2025 01:01:01 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.127.188])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b3ed414ec70sm575065266b.42.2025.10.01.01.00.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 01:00:59 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	armbru@redhat.com,
	marcandre.lureau@redhat.com
Subject: [PATCH 04/14] rust: add Serialize implementation for QObject
Date: Wed,  1 Oct 2025 10:00:41 +0200
Message-ID: <20251001080051.1043944-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001075005.1041833-1-pbonzini@redhat.com>
References: <20251001075005.1041833-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This allows QObject to be converted to other formats, for example
JSON via serde_json.

This is not too useful, since QObjects are consumed by
C code or deserialized into structs, but it can be used for testing
and it is part of the full implementation of a serde format.

Co-authored-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/Cargo.lock                    |  1 +
 rust/util/Cargo.toml               |  1 +
 rust/util/meson.build              |  3 +-
 rust/util/src/qobject/mod.rs       |  4 +-
 rust/util/src/qobject/serialize.rs | 59 ++++++++++++++++++++++++++++++
 5 files changed, 65 insertions(+), 3 deletions(-)
 create mode 100644 rust/util/src/qobject/serialize.rs

diff --git a/rust/Cargo.lock b/rust/Cargo.lock
index 0c1df625df1..c1075e11d6c 100644
--- a/rust/Cargo.lock
+++ b/rust/Cargo.lock
@@ -446,6 +446,7 @@ dependencies = [
  "foreign",
  "glib-sys",
  "libc",
+ "serde",
 ]
 
 [[package]]
diff --git a/rust/util/Cargo.toml b/rust/util/Cargo.toml
index 85f91436545..554004816eb 100644
--- a/rust/util/Cargo.toml
+++ b/rust/util/Cargo.toml
@@ -17,6 +17,7 @@ anyhow = { workspace = true }
 foreign = { workspace = true }
 glib-sys = { workspace = true }
 libc = { workspace = true }
+serde = { workspace = true }
 common = { path = "../common" }
 
 [lints]
diff --git a/rust/util/meson.build b/rust/util/meson.build
index 38da1ba8cd1..5b99d38c903 100644
--- a/rust/util/meson.build
+++ b/rust/util/meson.build
@@ -39,10 +39,11 @@ _util_rs = static_library(
     {'.': _util_bindings_inc_rs,
     'qobject': [
       'src/qobject/mod.rs',
+      'src/qobject/serialize.rs',
     ]}),
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
-  dependencies: [anyhow_rs, libc_rs, foreign_rs, glib_sys_rs, common_rs, qom, qemuutil],
+  dependencies: [anyhow_rs, libc_rs, foreign_rs, glib_sys_rs, common_rs, serde_rs, qom, qemuutil],
 )
 
 util_rs = declare_dependency(link_with: [_util_rs], dependencies: [qemuutil, qom])
diff --git a/rust/util/src/qobject/mod.rs b/rust/util/src/qobject/mod.rs
index f43d87a3b66..2e3cb247b27 100644
--- a/rust/util/src/qobject/mod.rs
+++ b/rust/util/src/qobject/mod.rs
@@ -6,6 +6,8 @@
 
 #![deny(clippy::unwrap_used)]
 
+mod serialize;
+
 use std::{
     cell::UnsafeCell,
     ffi::{c_char, CString},
@@ -222,7 +224,6 @@ fn drop(&mut self) {
     }
 }
 
-#[allow(unused)]
 macro_rules! match_qobject {
     (@internal ($qobj:expr) =>
         $(() => $unit:expr,)?
@@ -305,5 +306,4 @@ macro_rules! match_qobject {
                 $($type $(($val))? => $code,)+)
     };
 }
-#[allow(unused_imports)]
 use match_qobject;
diff --git a/rust/util/src/qobject/serialize.rs b/rust/util/src/qobject/serialize.rs
new file mode 100644
index 00000000000..34ec3847c1d
--- /dev/null
+++ b/rust/util/src/qobject/serialize.rs
@@ -0,0 +1,59 @@
+//! `QObject` serialization
+//!
+//! This module implements the [`Serialize`] trait for `QObject`,
+//! allowing it to be converted to other formats, for example
+//! JSON.
+
+use std::{ffi::CStr, mem::ManuallyDrop, ptr::addr_of};
+
+use serde::ser::{self, Serialize, SerializeMap, SerializeSeq};
+
+use super::{match_qobject, QObject};
+use crate::bindings;
+
+impl Serialize for QObject {
+    #[inline]
+    fn serialize<S>(&self, serializer: S) -> Result<S::Ok, S::Error>
+    where
+        S: ::serde::Serializer,
+    {
+        match_qobject! { (self) =>
+            () => serializer.serialize_unit(),
+            bool(b) => serializer.serialize_bool(b),
+            i64(i) => serializer.serialize_i64(i),
+            u64(u) => serializer.serialize_u64(u),
+            f64(f) => serializer.serialize_f64(f),
+            CStr(cstr) => cstr.to_str().map_or_else(
+                |_| Err(ser::Error::custom("invalid UTF-8 in QString")),
+                |s| serializer.serialize_str(s),
+            ),
+            QList(l) => {
+                let mut node_ptr = unsafe { l.head.tqh_first };
+                let mut state = serializer.serialize_seq(None)?;
+                while !node_ptr.is_null() {
+                    let node = unsafe { &*node_ptr };
+                    let elem = unsafe { ManuallyDrop::new(QObject::from_raw(addr_of!(*node.value))) };
+                    state.serialize_element(&*elem)?;
+                    node_ptr = unsafe { node.next.tqe_next };
+                }
+                state.end()
+            },
+            QDict(d) => {
+                let mut state = serializer.serialize_map(Some(d.size))?;
+                let mut e_ptr = unsafe { bindings::qdict_first(d) };
+                while !e_ptr.is_null() {
+                    let e = unsafe { &*e_ptr };
+                    let key = unsafe { CStr::from_ptr(e.key) };
+                    key.to_str().map_or_else(
+                        |_| Err(ser::Error::custom("invalid UTF-8 in key")),
+                        |k| state.serialize_key(k),
+                    )?;
+                    let value = unsafe { ManuallyDrop::new(QObject::from_raw(addr_of!(*e.value))) };
+                    state.serialize_value(&*value)?;
+                    e_ptr = unsafe { bindings::qdict_next(d, e) };
+                }
+                state.end()
+            }
+        }
+    }
+}
-- 
2.51.0


