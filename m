Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D25F1CAC58E
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Sep 2025 08:13:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uxLM8-0008MB-PJ; Sat, 13 Sep 2025 04:11:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLM2-0007ue-4R
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:11:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLLy-00055p-Az
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:11:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757751084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YZRZj3xQEand5ugY5kt3w0beYXz2rYMkRq6Ld6OQVjg=;
 b=hTyAyDyRUySJDtaag/IGkuPboxMZlud1VcJvqiFbW9Y8PIKkIiIjFR7RyhzD9kexGXLYs0
 jpcQ/keZaxY7KrSLc3My0Vj35xgALJ1iTz1YO70nEgk0yfHmC7XPFiC3FsGRFopX0mTSYj
 cxjlA9OvlnvZh4i6HaTcavnjwWHv/3U=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-1uqkIvsMOUe70SSPHGSH6Q-1; Sat, 13 Sep 2025 04:11:22 -0400
X-MC-Unique: 1uqkIvsMOUe70SSPHGSH6Q-1
X-Mimecast-MFC-AGG-ID: 1uqkIvsMOUe70SSPHGSH6Q_1757751082
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-45df7e734e0so16319075e9.0
 for <qemu-devel@nongnu.org>; Sat, 13 Sep 2025 01:11:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757751081; x=1758355881;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YZRZj3xQEand5ugY5kt3w0beYXz2rYMkRq6Ld6OQVjg=;
 b=KRIaLoX+zVXcjJnYQHPSXVwqRcEt8O4gqL5Hb0CYbh3pI+a45l7vxlzv830tQz93sy
 eEoRfSlPqT8qaouLLm93pgC0IEhUqwMMR69ijvBxL+azWq4gpTLwCN9/49apcu1IybwY
 fmnEMvZ5RzLaRTPMBXqekCBz8jZa28JeaQf5vX1VhDsWh7p9knolmX+qnjUcfmzDztKC
 a0nTTfPtsba8e+7H7zqjNLlHRDvKaXqn4tz6i4ci+G9/pjrvuGQhWyqNc7NBgcWjmn6a
 BqvvlPkCoEf8li72uvkVMSfGbRzHVWixH4PKMLy1JtviLsdQ2XNzMlLk5uuOwzUiBo1d
 MnnQ==
X-Gm-Message-State: AOJu0YxNrLNjSp0pIgUzdrfxaCzB5fEqVbxhL2Kh6KwG+Vq6R/t3pjDR
 +qTr4EpG6dbhBRzDuDFDCOhnsNHBxoHoWX/lU4aPXqntd8fUiNEydo87pRuEfPtcXL2jXl33hQp
 T3kYWOapFOGjhYue6SlccY7llnl1uEsWMJ3OlzlhMU/3NZivbGUjuen9DV+sFMKZmc1FSO9EDMT
 M9V8r0x7uCizV2MbnTo6UgZfmlWCk92BDzzl/SPc9N
X-Gm-Gg: ASbGnctP4b1esAfzNilOpuHuZG/BCDvIpEOnGX/GogYXsS0zbrfHQCsGY/U0rkm1NXN
 i5DBBek6k9MMBtnh2Obql2EDEStBSXjMW/j5qKKjxQqB7GlF9OPHWwFxL7gVrOeuuhhNZhV2kOG
 65z5vIKhoEYaHljIpVMS32WYlwPOVnySBXfsEWflFsH3xIwM4HGqi1EyKRCby9g+0oTTAsRQc/p
 Tx4WjSXTMtjCJJuVfeyHcVgENmMMXkmUyTk3A7jjgMtc6EkYcoWpWwMq30G2aXJewI+zfvaVUgC
 mfWacBZUwrCX3q6YTQq4aV8DfTwR+2PPKAbihyCdT8CkPnqPw3q8K0lsvNYoHdC96ZBouFbqVZj
 zbHen7ojOk6BxEvsD3abxdd/S1JxUY5E4uhRuLbVAVP0=
X-Received: by 2002:a05:600c:46ca:b0:458:a992:6f1e with SMTP id
 5b1f17b1804b1-45f211c4c8bmr71741885e9.5.1757751080576; 
 Sat, 13 Sep 2025 01:11:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFF2yMpDjIHRJ7Tzz66XWWfm61RCG2asf0x0C1cdih5CEHSeqUFHOZvkZFKUHQjA2YVsiHDAA==
X-Received: by 2002:a05:600c:46ca:b0:458:a992:6f1e with SMTP id
 5b1f17b1804b1-45f211c4c8bmr71741495e9.5.1757751080047; 
 Sat, 13 Sep 2025 01:11:20 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45e037b91e6sm89445105e9.14.2025.09.13.01.11.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Sep 2025 01:11:18 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 34/61] rust: move Cell vmstate impl
Date: Sat, 13 Sep 2025 10:09:15 +0200
Message-ID: <20250913080943.11710-35-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250913080943.11710-1-pbonzini@redhat.com>
References: <20250913080943.11710-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

This will allow to split vmstate to a standalone crate next.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Link: https://lore.kernel.org/r/20250827104147.717203-10-marcandre.lureau@redhat.com
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/cell.rs    |  6 +++++-
 rust/qemu-api/src/vmstate.rs | 14 +++++++-------
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/rust/qemu-api/src/cell.rs b/rust/qemu-api/src/cell.rs
index 148a13e3f56..9943d7286b6 100644
--- a/rust/qemu-api/src/cell.rs
+++ b/rust/qemu-api/src/cell.rs
@@ -221,7 +221,7 @@
     ptr::NonNull,
 };
 
-use crate::bindings;
+use crate::{bindings, impl_vmstate_transparent};
 
 /// An internal function that is used by doctests.
 pub fn bql_start_test() {
@@ -456,6 +456,8 @@ pub fn take(&self) -> T {
     }
 }
 
+impl_vmstate_transparent!(crate::cell::BqlCell<T> where T: VMState);
+
 /// A mutable memory location with dynamically checked borrow rules,
 /// protected by the Big QEMU Lock.
 ///
@@ -764,6 +766,8 @@ fn from(t: T) -> BqlRefCell<T> {
     }
 }
 
+impl_vmstate_transparent!(crate::cell::BqlRefCell<T> where T: VMState);
+
 struct BorrowRef<'b> {
     borrow: &'b Cell<BorrowFlag>,
 }
diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index 4e1086779ac..ce42b031bc1 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -124,7 +124,8 @@ pub const fn vmstate_varray_flag<T: VMState>(_: PhantomData<T>) -> VMStateFlags
 /// * scalar types (integer and `bool`)
 /// * the C struct `QEMUTimer`
 /// * a transparent wrapper for any of the above (`Cell`, `UnsafeCell`,
-///   [`BqlCell`], [`BqlRefCell`]
+///   [`BqlCell`](crate::cell::BqlCell),
+///   [`BqlRefCell`](crate::cell::BqlRefCell)),
 /// * a raw pointer to any of the above
 /// * a `NonNull` pointer, a `Box` or an [`Owned`](crate::qom::Owned) for any of
 ///   the above
@@ -254,14 +255,15 @@ unsafe impl $crate::vmstate::VMState for $tuple {
 
 // Transparent wrappers: just use the internal type
 
+#[macro_export]
 macro_rules! impl_vmstate_transparent {
     ($type:ty where $base:tt: VMState $($where:tt)*) => {
-        unsafe impl<$base> VMState for $type where $base: VMState $($where)* {
-            const BASE: VMStateField = VMStateField {
+        unsafe impl<$base> $crate::vmstate::VMState for $type where $base: $crate::vmstate::VMState $($where)* {
+            const BASE: $crate::vmstate::VMStateField = $crate::vmstate::VMStateField {
                 size: mem::size_of::<$type>(),
-                ..<$base as VMState>::BASE
+                ..<$base as $crate::vmstate::VMState>::BASE
             };
-            const VARRAY_FLAG: VMStateFlags = <$base as VMState>::VARRAY_FLAG;
+            const VARRAY_FLAG: $crate::bindings::VMStateFlags = <$base as $crate::vmstate::VMState>::VARRAY_FLAG;
         }
     };
 }
@@ -269,8 +271,6 @@ unsafe impl<$base> VMState for $type where $base: VMState $($where)* {
 impl_vmstate_transparent!(std::cell::Cell<T> where T: VMState);
 impl_vmstate_transparent!(std::cell::UnsafeCell<T> where T: VMState);
 impl_vmstate_transparent!(std::pin::Pin<T> where T: VMState);
-impl_vmstate_transparent!(crate::cell::BqlCell<T> where T: VMState);
-impl_vmstate_transparent!(crate::cell::BqlRefCell<T> where T: VMState);
 impl_vmstate_transparent!(crate::cell::Opaque<T> where T: VMState);
 
 #[macro_export]
-- 
2.51.0


