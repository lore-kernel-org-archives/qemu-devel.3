Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36D37C19F32
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 14:27:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tneoX-00077G-Fv; Thu, 27 Feb 2025 09:24:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnemm-0003zf-5u
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:22:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnemk-00049E-EL
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:22:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740666165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S8IXFl1tjzcTpL3RiOm0U3qS7SeRxt+gon+nIrKlE5k=;
 b=cNzbA9qVkydW6XyIEoSXEYSPL4YCrHQkxztx0jYvUlK3nRyVkkqK9ZJ0q5s2aej+SQriey
 yda9PCQye1h4c3vRXSG00SCbPGnT356Km5yrKTye/4ZCMjzfUWNQQWfvTM4252766a04Me
 svrXmntMiwgHa108UHaGdJM3Et4GHNc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-V8MUClVmMmK0-IkIZc6vRg-1; Thu, 27 Feb 2025 09:22:44 -0500
X-MC-Unique: V8MUClVmMmK0-IkIZc6vRg-1
X-Mimecast-MFC-AGG-ID: V8MUClVmMmK0-IkIZc6vRg_1740666163
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-abbba16956bso132130766b.2
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 06:22:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740666162; x=1741270962;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S8IXFl1tjzcTpL3RiOm0U3qS7SeRxt+gon+nIrKlE5k=;
 b=RVrCjnyic6lRWZo9sN0NPf2Fe5X5EFIz8RgQyiw4fyDeThWzBTINOO4tVWXR9vPMdE
 PZXbq0Z1M/+z9BbqQQcjNdxc9P+04AGAWJvNTwUKelJzFioPcTpDrKcxtZ6HvsH0WuhB
 wTqLVHo4WG9TboSv1QEfqhuyGYJAcExgfD/o+vrR+dKQtUJ7xElwCRjM8qsHB2QzKWvE
 x0kpTY85Pxt0pOuNwpWY0wY96zWhStUdA6cmKVjPlgm0IXzfdWHQi9KTsls/mCYALaF+
 ZgOF++r4WKA3JXAF3UfKveJjJ2ENSvx6rxRdIa5fUcSKSbsdZHj46XBeYQAKs8fWuodI
 iyrA==
X-Gm-Message-State: AOJu0YwD+Dv3yZBBkzJ0Cz1lH6LE5FiaFC2ZOFTHuDVXGb7kCTRAuQOs
 P7grFSkVmPMLlMBjxRVwZQlxMW4Q91hctBHtcfxM1SXx5B2NziKFj3ziJ51dQOI0hWn6H88x2EV
 6LHH862PLfg7gYjvvw29sVinRJpLbSWQP6nYmdYOkvP9SRDTISmuz/2AsIPHZn6HQ5hmUDn/c/v
 NQcn5tMrJWIduwsGKcBPsqKYeens+hHZSQt+A3JD0=
X-Gm-Gg: ASbGncvURJuqIenhvBx+Uw4fiQpkvQHCeD2zWtlvGD+FnnTWkMUgxrzmKqJXzeNd6/a
 swhU+N79Bq7TDu1Bn418UEux7e3xpdRR9ysvDD2xhEmElDMRAmSXWR1iXJZRYnQNliU/mS2nRBp
 Lc6dScxynDgjwL2eAB2MkMKuoA2H1o/Us1c1IOEeU7zr0TuH4p0UW9vDSk928HLJTk9PLKuXjVT
 f/dyL7A9eSjDFQNnvfA497iR2IVdYAZFwi5NcaV2AY5DqePYwhQmeqDqljzWKHvwFBC6laZs62I
 OWfgyTV4UU1KHJG7szAd
X-Received: by 2002:a17:907:7710:b0:abb:6e07:3714 with SMTP id
 a640c23a62f3a-abed0c66ec7mr1325157666b.10.1740666161950; 
 Thu, 27 Feb 2025 06:22:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHfH4DUS1aqoEPb8TbvHR8xTpCzsmC2z5Qrepw6+FBwsfJjKOd9cg0gRimz6jmdxtGHn68PWA==
X-Received: by 2002:a17:907:7710:b0:abb:6e07:3714 with SMTP id
 a640c23a62f3a-abed0c66ec7mr1325154266b.10.1740666161492; 
 Thu, 27 Feb 2025 06:22:41 -0800 (PST)
Received: from [192.168.10.48] ([176.206.102.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abf0c75af58sm129868666b.147.2025.02.27.06.22.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 06:22:41 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	zhao1.liu@intel.com
Subject: [PATCH 10/12] rust: memory: wrap MemoryRegion with Opaque<>
Date: Thu, 27 Feb 2025 15:22:17 +0100
Message-ID: <20250227142219.812270-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227142219.812270-1-pbonzini@redhat.com>
References: <20250227142219.812270-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


