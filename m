Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E334CCD192
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 13:42:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8fEc-000649-V7; Tue, 14 Oct 2025 09:38:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v8fES-0005vu-Ud
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:38:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v8fEP-00017i-Uw
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:38:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760449102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2MMGynjhv4WBBo4X3LLy26Qc6OUsNSBvfImlI2mQ1Zo=;
 b=YmywTNhQzuCM6mziiy/qSFULs8xDke3EHAJStC6B3qMvNXsM+ijGFUTmFwkVG2xHlwAeJO
 eCv/o+DpyadHhLdjFmbjeAD0z4PYkPqdxkI+NmZ6hFPY+4ybVRtLlxJNpLQIQzExiJEDUf
 RpTQ6TM8NB37hy06lX1MmrAQXawt10s=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-Yh28bZIyOPae2M_lwAxBfQ-1; Tue, 14 Oct 2025 09:38:17 -0400
X-MC-Unique: Yh28bZIyOPae2M_lwAxBfQ-1
X-Mimecast-MFC-AGG-ID: Yh28bZIyOPae2M_lwAxBfQ_1760449096
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3f924ae2a89so6288381f8f.3
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 06:38:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760449095; x=1761053895;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2MMGynjhv4WBBo4X3LLy26Qc6OUsNSBvfImlI2mQ1Zo=;
 b=R2pD7qk7EsjomlV9NhHEUBAWtW4imPdQ22acVP6pQMg/EmBVgnvdzY3n/XroTJXmZg
 v4NfRFtHN7OJBblbCwizw5yzHDVcfjBSuaKkEKEs3AqG+Lh67FJh6pFvAROuwuTz/8mJ
 aj9rJP6PfGmxgY5zRPfgv0ZHNNgeRF9OvH0NcWQ5mlMZIwElDYjdZUeRa3ycE1OkwLm7
 9twXGF1KX1o3SC5NoWwmKYs1VApcl/BTSBJC5nOQEmOW7MGsLRC6+O063DNI87au4XJ5
 KpPoWPgEoCvexINmg8yD8f4Td02p8gJyPzjC1+9We2yrd//kSFlrHbBOVvckkhp0bx+2
 g+qg==
X-Gm-Message-State: AOJu0YzK6SCJ1YCB37x8mHWstOJwd4aKn/OYgpHO1D4UMY4UOQTlLJEI
 FV2YTVMDIFtnDtlYOY+ZyNZ7L3o9V6gK3C/SlbUzbQOAd9/NtUTM/nU0urm+zBt2bv1iSRanhdb
 R7WqKVbuPwrK/ZziVFrpsOakdKimZD9WB94W4yhtpG8fR5L6Ta1EWnvNpdsQBtTxeKwY0T04vdw
 1UvmISnb43gvy2rvXg1g+9w9GJWRWwedJZyjtRx/jd
X-Gm-Gg: ASbGnctsa7kGcApW6CQ6nnrXkW+/SCECniTpFiwTN4+UCBCAr2Gokn7VAs4QiFwq3qb
 G+fmGzp1IB3UUNVkasb0tQ6APrRLMa30V8ZrVfY7uNypwNQjI/sVDmiJaQI/P1gRlyyUBc3R4sd
 E3zgYYyRPPdaLUkVkTgmw1oKBPm3uxA0P+1mbVWucGUbpp5sXVrwz4zCqKsILalShp0qsgqbyX+
 7o64cQU6UNx0O9JxW4ioYJxA7zXVVknKBRoAsMSWebe54VwcjQBWPUK449rRV/7aEqeqCkuwWg+
 deCufQX1BbRNhDFSHIcZbl3ySaDW3sNCtPV3yAcoOYa26ddSgEBngM6M4Vk+zaKlFlBf2ZftoM7
 I5VNHEIv3vmGxtbzQo4lqxGq9uHsjYKQcYEygX3HIN/Q=
X-Received: by 2002:a05:6000:2305:b0:3e9:b7a5:5dc9 with SMTP id
 ffacd0b85a97d-4266e7d6bb2mr15176857f8f.23.1760449094742; 
 Tue, 14 Oct 2025 06:38:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdoYEj4wak2TUf2VQqLGs++zrvAZKV8Pl801kp0Bfg4H90QZFAghMtUeaDV2ZzYb8hWULXaQ==
X-Received: by 2002:a05:6000:2305:b0:3e9:b7a5:5dc9 with SMTP id
 ffacd0b85a97d-4266e7d6bb2mr15176842f8f.23.1760449094265; 
 Tue, 14 Oct 2025 06:38:14 -0700 (PDT)
Received: from [192.168.10.48] ([151.61.22.175])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5cf71dsm22921264f8f.29.2025.10.14.06.38.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 06:38:11 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 21/28] rust: migration: do not store raw pointers into
 VMStateSubsectionsWrapper
Date: Tue, 14 Oct 2025 15:37:06 +0200
Message-ID: <20251014133713.1103695-21-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014133540.1103268-1-pbonzini@redhat.com>
References: <20251014133540.1103268-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Raw pointers were used to insert a NULL one at the end of the array.
However, Option<&...> has the same layout and does not remove Sync
from the type of the array.

As an extra benefit, this enables validation of the terminator of the
subsection array, because is_null() in const context would not be stable
until Rust 1.84.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/migration/src/vmstate.rs | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/rust/migration/src/vmstate.rs b/rust/migration/src/vmstate.rs
index 2e320262f06..a6ee7e93853 100644
--- a/rust/migration/src/vmstate.rs
+++ b/rust/migration/src/vmstate.rs
@@ -470,33 +470,21 @@ unsafe impl $crate::vmstate::VMState for $type {
     };
 }
 
-/// A transparent wrapper type for the `subsections` field of
-/// [`VMStateDescription`].
-///
-/// This is necessary to be able to declare subsection descriptions as statics,
-/// because the only way to implement `Sync` for a foreign type (and `*const`
-/// pointers are foreign types in Rust) is to create a wrapper struct and
-/// `unsafe impl Sync` for it.
-///
-/// This struct is used in the
-/// [`vm_state_subsections`](crate::vmstate_subsections) macro implementation.
-#[repr(transparent)]
-pub struct VMStateSubsectionsWrapper(pub &'static [*const crate::bindings::VMStateDescription]);
-
-unsafe impl Sync for VMStateSubsectionsWrapper {}
+/// The type returned by [`vmstate_subsections!`](crate::vmstate_subsections).
+pub type VMStateSubsections = &'static [Option<&'static crate::bindings::VMStateDescription>];
 
 /// Helper macro to declare a list of subsections ([`VMStateDescription`])
 /// into a static and return a pointer to the array of pointers it created.
 #[macro_export]
 macro_rules! vmstate_subsections {
     ($($subsection:expr),*$(,)*) => {{
-        static _SUBSECTIONS: $crate::vmstate::VMStateSubsectionsWrapper = $crate::vmstate::VMStateSubsectionsWrapper(&[
+        static _SUBSECTIONS: $crate::vmstate::VMStateSubsections = &[
             $({
                 static _SUBSECTION: $crate::bindings::VMStateDescription = $subsection.get();
-                ::core::ptr::addr_of!(_SUBSECTION)
+                Some(&_SUBSECTION)
             }),*,
-            ::core::ptr::null()
-        ]);
+            None,
+        ];
         &_SUBSECTIONS
     }}
 }
@@ -686,8 +674,9 @@ pub const fn fields(mut self, fields: &'static [VMStateField]) -> Self {
     }
 
     #[must_use]
-    pub const fn subsections(mut self, subs: &'static VMStateSubsectionsWrapper) -> Self {
-        self.0.subsections = subs.0.as_ptr();
+    pub const fn subsections(mut self, subs: &'static VMStateSubsections) -> Self {
+        let subs: *const Option<&bindings::VMStateDescription> = subs.as_ptr();
+        self.0.subsections = subs.cast::<*const bindings::VMStateDescription>();
         self
     }
 
-- 
2.51.0


