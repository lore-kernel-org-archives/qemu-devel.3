Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D139D3398E
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 14:34:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5QmG-00021V-SN; Mon, 28 Oct 2024 10:31:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5QlH-0000X7-Bs
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 10:30:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5QlF-0003zY-P9
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 10:30:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730125824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pk/ExTQ6ucVRc/G0SIy96rszaYTtvZQeQUouajsdp/c=;
 b=gU/w9mEjUSRslODDV+LRCv+zb+cDGGszbQ+mAGWacdcpqhm1kZ4fZ5zbEgPr5Xqx2pe3yB
 Uvv4v3I5ZcMSGGcqwnMQCwhqGpzDMXyqy94LtgSJCn61dkI9u/JUBGIHrViFDN4KfJDbd/
 rCzpRitQ7pJTlM6aHpg0NjoLwbARXq4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-kJYvjULUMyiwCEFbJ2Cnug-1; Mon, 28 Oct 2024 10:30:23 -0400
X-MC-Unique: kJYvjULUMyiwCEFbJ2Cnug-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43151e4ef43so29228445e9.3
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 07:30:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730125821; x=1730730621;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pk/ExTQ6ucVRc/G0SIy96rszaYTtvZQeQUouajsdp/c=;
 b=oefe8RoS6+0+LiCg0QObPSeDKplSB6Zi1LzKICXIn/PRr9Lc69weOfmbaxvOPK1Ukp
 g4gRO/5jsKfk90jQcVRuhOgumi+LVzN4npW4JGqP9/1oOd5xsB6dNhEa8KjI8qaVGwNU
 +/ScsXAE97Dh5wpD/URmhY47YGvz2bjZn+VZkWnTuH19TkpKZ1JmJ52g1akf5+7zM/L7
 JMP7ude+5i+IpsdjvPMQi7jJcTlCSu+w1upJyQl//5Da4R5+5K1kKy/KdXKe6RZ1ptD7
 eftprG7oGbkLTK+BzTcSDpjvPtzDAObIeYalnGxAUxWa60R+H2SgCbkGCap7MHmzeKgI
 bCdQ==
X-Gm-Message-State: AOJu0YwSvmjPZrjWi5Au9/rSBkdYaOmSLyTFfqKq0a/AXghNIvBRpkxp
 8Sr3/d0s/2K4SmQuzzhurg0Jb9kXHXJ6GCKNMaCjG61wG2qflJByfKL+h500lOXX8QhkKcpuxLZ
 zug+6reVScPGIwhuMLHt87z92J45qY2FNmT4tJI/xZvok9Tg7cvJEunFBhylgXQiInREJkiUGTC
 pLbyjhXjL0ipzy6YF5ZzvDhYH4fX7CNbSQTrmcFbg=
X-Received: by 2002:a05:600c:35cd:b0:431:5863:4240 with SMTP id
 5b1f17b1804b1-4319ad0f10cmr71826835e9.24.1730125820935; 
 Mon, 28 Oct 2024 07:30:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwkn0iLfnA9Cyx3xl6Bz568wmEr3A8/4dZfsNLCpF9Ns4X1pK1fBQVC7b/jmexd0ZvgmERxQ==
X-Received: by 2002:a05:600c:35cd:b0:431:5863:4240 with SMTP id
 5b1f17b1804b1-4319ad0f10cmr71826605e9.24.1730125820538; 
 Mon, 28 Oct 2024 07:30:20 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4318b567838sm143777595e9.23.2024.10.28.07.30.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 07:30:18 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Junjie Mao <junjie.mao@hotmail.com>,
	Kevin Wolf <kwolf@redhat.com>
Subject: [PULL 18/24] rust: clean up define_property macro
Date: Mon, 28 Oct 2024 15:29:25 +0100
Message-ID: <20241028142932.363687-19-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028142932.363687-1-pbonzini@redhat.com>
References: <20241028142932.363687-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.373,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Use the "struct update" syntax to initialize most of the fields to zero,
and simplify the handmade type-checking of $name.

Reviewed-by: Junjie Mao <junjie.mao@hotmail.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/device_class.rs | 31 +++++++------------------------
 1 file changed, 7 insertions(+), 24 deletions(-)

diff --git a/rust/qemu-api/src/device_class.rs b/rust/qemu-api/src/device_class.rs
index 2219b9f73d0..aab60484096 100644
--- a/rust/qemu-api/src/device_class.rs
+++ b/rust/qemu-api/src/device_class.rs
@@ -29,44 +29,27 @@ macro_rules! device_class_init {
 macro_rules! define_property {
     ($name:expr, $state:ty, $field:expr, $prop:expr, $type:expr, default = $defval:expr$(,)*) => {
         $crate::bindings::Property {
-            name: {
-                #[used]
-                static _TEMP: &::core::ffi::CStr = $name;
-                _TEMP.as_ptr()
-            },
+            // use associated function syntax for type checking
+            name: ::core::ffi::CStr::as_ptr($name),
             info: $prop,
             offset: ::core::mem::offset_of!($state, $field)
                 .try_into()
                 .expect("Could not fit offset value to type"),
-            bitnr: 0,
-            bitmask: 0,
             set_default: true,
-            defval: $crate::bindings::Property__bindgen_ty_1 { u: $defval.into() },
-            arrayoffset: 0,
-            arrayinfo: ::core::ptr::null(),
-            arrayfieldsize: 0,
-            link_type: ::core::ptr::null(),
+            defval: $crate::bindings::Property__bindgen_ty_1 { u: $defval as u64 },
+            ..unsafe { ::core::mem::MaybeUninit::<$crate::bindings::Property>::zeroed().assume_init() }
         }
     };
     ($name:expr, $state:ty, $field:expr, $prop:expr, $type:expr$(,)*) => {
         $crate::bindings::Property {
-            name: {
-                #[used]
-                static _TEMP: &::core::ffi::CStr = $name;
-                _TEMP.as_ptr()
-            },
+            // use associated function syntax for type checking
+            name: ::core::ffi::CStr::as_ptr($name),
             info: $prop,
             offset: ::core::mem::offset_of!($state, $field)
                 .try_into()
                 .expect("Could not fit offset value to type"),
-            bitnr: 0,
-            bitmask: 0,
             set_default: false,
-            defval: $crate::bindings::Property__bindgen_ty_1 { i: 0 },
-            arrayoffset: 0,
-            arrayinfo: ::core::ptr::null(),
-            arrayfieldsize: 0,
-            link_type: ::core::ptr::null(),
+            ..unsafe { ::core::mem::MaybeUninit::<$crate::bindings::Property>::zeroed().assume_init() }
         }
     };
 }
-- 
2.47.0


