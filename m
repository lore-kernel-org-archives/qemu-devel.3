Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C937C282D1
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 10:33:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trDws-00086N-68; Sun, 09 Mar 2025 06:31:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1trDwq-00085g-BZ
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 06:31:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1trDwo-00042x-Ld
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 06:31:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741516314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S8IXFl1tjzcTpL3RiOm0U3qS7SeRxt+gon+nIrKlE5k=;
 b=et7PYwuTYJOEFOpUlS1MQ6EYEVZy6jEJ02FgVpMA8IlNiBUe1S5NZA1ZpiBD1pdXxrsmot
 pNLLT+ZFVUDhHugHsFhpllBwkemNLFo5h+Xlng9frKgftKWMknGyVhy6122VF5aJvdJdwS
 QCFKtgXZNJC/7s+cNuvUUXNBYNX2RL8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-RRRoSOgCPi-aNM--X11fQQ-1; Sun, 09 Mar 2025 06:31:52 -0400
X-MC-Unique: RRRoSOgCPi-aNM--X11fQQ-1
X-Mimecast-MFC-AGG-ID: RRRoSOgCPi-aNM--X11fQQ_1741516311
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-391425471ddso276396f8f.0
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 03:31:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741516310; x=1742121110;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S8IXFl1tjzcTpL3RiOm0U3qS7SeRxt+gon+nIrKlE5k=;
 b=AtBNfrWAJ1F7smSEUbeXXCDDP/gUHgooaq/mqrl0nHT+uRtuFUEsNNuRrdG5E1mGan
 fEB1xeHQLY1XW3bhs8GEbiYnguFylaNyqeUgleT0VnRZcMXuiDOOlRc4eYZp6YBExsbA
 VS/0gDKYZ0hznb+LMJ9D6O/BFRTOXA2sanKhSgAa+q9x+fVXazGbQdsg/saFsA/BfS6g
 W2T8wrUuQ8U0xrRQMzEK7ZNkqWAt4chPn8RyEIA3QfjKfS9qf/1Sgoz8oAsv6noTRuyO
 /YSxTAXJJfbkjaLo8SGG7F62vYsXSnykAljLNOzSIHbQDDTH3qipGwdb6eclNqNPnd12
 u+8A==
X-Gm-Message-State: AOJu0Yw2Pv2HmDFYgdf47SZ00F5O7ZOlrNWOgHy03vlKjJqhENucxvTl
 XUmD0iY/q39gBllIsIZGtUrXy5aYOVCwrwvGEfZ4GOMZwIIqWC4MRBhdBGNyN919bIYWGtc/5uY
 bgQgKM6EalM9Dmaz9FnYX5eVBzxFQ8CxAThkchixX6W7N6Jl3xHP8Cj5EE7boZM/VW+VSFum26U
 zC2xOxyXIOcWhM3/TEEj665dQDI1egZtHpQ7Ayn/E=
X-Gm-Gg: ASbGnctMQSVMiU8Rn3kVNRfN3JZ4ZQz+tZdw7vlTDMYZxi+rdaDbGRcT99dzaMzdZrd
 J+G1p460IA2tn7d+FksrVLn6EbaZ5bsYTnuE3RQSmI66fhdIf+ET1rOGVhJLirbZOwRNxp9RASK
 cFCp/J5k+SiaeQ1gK4c3TAOdPxAEw7vgxVHe+YdgAPZI99UrnJOIFAL1kZJhjMZVMD+Op00TwJI
 P5HT6VSn5J7iHVEoSanHSJOM4zvZeEbsl1XHNLPKG1YY+BfEmah7t3CTNgZYmU3QaZv14bshHIV
 CCxEV2ZT7qY4V17siSs6lw==
X-Received: by 2002:a5d:59a8:0:b0:391:2d76:baaa with SMTP id
 ffacd0b85a97d-39132db1be7mr7390410f8f.46.1741516310313; 
 Sun, 09 Mar 2025 03:31:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMGDQfpoP1jSEc42gXxru/mIgJyHc3uFrRPXfX8vLnbnBb8beohFmnKEXXVsNoq7Z99WuZqw==
X-Received: by 2002:a5d:59a8:0:b0:391:2d76:baaa with SMTP id
 ffacd0b85a97d-39132db1be7mr7390392f8f.46.1741516309796; 
 Sun, 09 Mar 2025 03:31:49 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.122.167])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c0e1476sm11511766f8f.70.2025.03.09.03.31.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Mar 2025 03:31:49 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 13/25] rust: memory: wrap MemoryRegion with Opaque<>
Date: Sun,  9 Mar 2025 11:31:07 +0100
Message-ID: <20250309103120.1116448-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309103120.1116448-1-pbonzini@redhat.com>
References: <20250309103120.1116448-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/bindings.rs |  3 ---
 rust/qemu-api/src/memory.rs   | 35 +++++++++++++++++++++--------------
 2 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/rust/qemu-api/src/bindings.rs b/rust/qemu-api/src/bindings.rs
index b791ca6d87f..26cc8de0cf2 100644
--- a/rust/qemu-api/src/bindings.rs
+++ b/rust/qemu-api/src/bindings.rs
@@ -34,9 +34,6 @@ unsafe impl Sync for CharBackend {}
 unsafe impl Send for Chardev {}
 unsafe impl Sync for Chardev {}
 
-unsafe impl Send for MemoryRegion {}
-unsafe impl Sync for MemoryRegion {}
-
 unsafe impl Send for ObjectClass {}
 unsafe impl Sync for ObjectClass {}
 
diff --git a/rust/qemu-api/src/memory.rs b/rust/qemu-api/src/memory.rs
index 713c494ca2e..eff9f09fd7f 100644
--- a/rust/qemu-api/src/memory.rs
+++ b/rust/qemu-api/src/memory.rs
@@ -6,9 +6,8 @@
 
 use std::{
     ffi::{CStr, CString},
-    marker::{PhantomData, PhantomPinned},
+    marker::PhantomData,
     os::raw::{c_uint, c_void},
-    ptr::addr_of,
 };
 
 pub use bindings::{hwaddr, MemTxAttrs};
@@ -16,6 +15,7 @@
 use crate::{
     bindings::{self, device_endian, memory_region_init_io},
     callbacks::FnCall,
+    cell::Opaque,
     prelude::*,
     zeroable::Zeroable,
 };
@@ -132,13 +132,13 @@ fn default() -> Self {
     }
 }
 
-/// A safe wrapper around [`bindings::MemoryRegion`].  Compared to the
-/// underlying C struct it is marked as pinned because the QOM tree
-/// contains a pointer to it.
-pub struct MemoryRegion {
-    inner: bindings::MemoryRegion,
-    _pin: PhantomPinned,
-}
+/// A safe wrapper around [`bindings::MemoryRegion`].
+#[repr(transparent)]
+#[derive(qemu_api_macros::Wrapper)]
+pub struct MemoryRegion(Opaque<bindings::MemoryRegion>);
+
+unsafe impl Send for MemoryRegion {}
+unsafe impl Sync for MemoryRegion {}
 
 impl MemoryRegion {
     // inline to ensure that it is not included in tests, which only
@@ -174,13 +174,20 @@ pub fn init_io<T: IsA<Object>>(
         size: u64,
     ) {
         unsafe {
-            Self::do_init_io(&mut self.inner, owner.cast::<Object>(), &ops.0, name, size);
+            Self::do_init_io(
+                // self.0.as_mut_ptr() needed because Rust tries to call
+                // ObjectDeref::as_mut_ptr() on "&mut Self", instead of coercing
+                // to "&Self" and then calling MemoryRegion::as_mut_ptr().
+                // Revisit if/when ObjectCastMut is not needed anymore; it is
+                // only used in a couple places for initialization.
+                self.0.as_mut_ptr(),
+                owner.cast::<Object>(),
+                &ops.0,
+                name,
+                size,
+            );
         }
     }
-
-    pub(crate) const fn as_mut_ptr(&self) -> *mut bindings::MemoryRegion {
-        addr_of!(self.inner) as *mut _
-    }
 }
 
 unsafe impl ObjectType for MemoryRegion {
-- 
2.48.1


