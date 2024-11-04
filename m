Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7812D1BDD0
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 17:34:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t80s8-0005IN-Th; Mon, 04 Nov 2024 12:28:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t80s7-0005Hw-Lb
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:28:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t80rt-0000GW-Vu
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:28:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730741277;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pk/ExTQ6ucVRc/G0SIy96rszaYTtvZQeQUouajsdp/c=;
 b=WbOJjC5O594iEUlYuS+BqGG8xJjNdg/HX/vkDDY1SHnCX0PiSwxvBxgF4VnrYTIoil030t
 bH/ya23m+f2AL/lplNz10No/w+UWd6nCahEeZT3WSNEq1UrkNzLmpdW2uhnZAJvkKbcvtz
 LRriz5aD4MV85KrOMUKcRoWUWZqabpY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358--fCdCgH8Ow-mL7AQPVzcvA-1; Mon, 04 Nov 2024 12:27:56 -0500
X-MC-Unique: -fCdCgH8Ow-mL7AQPVzcvA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-37d462b64e3so2205463f8f.3
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 09:27:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730741274; x=1731346074;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pk/ExTQ6ucVRc/G0SIy96rszaYTtvZQeQUouajsdp/c=;
 b=GUfzGOhBkfUFpmy62zsh47iX9drkjB8Fc1qdVMUObafFbwzQTMpGErP7DQ5Tm+ohvZ
 ExxvLW2t1cBPH41tadyAX/kTdq86r/FsSVfbgAyLKaTsTSJXw1NwEEv9vyGyYKifm8ZF
 ciYERUnYUhgZ+ecg7WjF5/AZLFHpkzMjKWNV8EO1B2Yzkg3ZP7ary984xJ6+3kfgNkvZ
 sVu1nHNKodjLVjNdVDUn63W7TiUyfZaDU3DMku3eMgQjufQA+V0FmvwAjTogt4Flxly9
 EPWOmrOWMfaB5S2kS1Hyu9iK8HK3hmpzc2dPGTi0k0bw4PrtxapnHIPsooP16XipbfkR
 84yw==
X-Gm-Message-State: AOJu0Yw3Vy1dockVmCiMNLRgeuRvdMlH5jiNqOrrC8yHl1VRb4kCxvyG
 JVgjaPY0Rv5PeWCMwBLmV3qhNeYb0ys8xZOfSd3rDFwut/YWmgWGOQLYsM33kSHu6DEmde/iJL7
 prWBAP+XQYKOjGcLzs2O5yTs2OvUD8or2xLpD8lTgOQ2AOrVwk9s+wEVIZVB/p9/Y5sfZtdeMtK
 w3+FALVTHfmsrU73abj6GWk6j5ol46+c6tg70ubjA=
X-Received: by 2002:a5d:59ae:0:b0:37d:4436:4505 with SMTP id
 ffacd0b85a97d-381c7a6da29mr11183512f8f.32.1730741274161; 
 Mon, 04 Nov 2024 09:27:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE5OD0chnnFJNh9oI3nKMGx+drihViu2NxC6XbMhte5HIU3oQ1YFjnJIpz9F384EgrbBzmZmA==
X-Received: by 2002:a5d:59ae:0:b0:37d:4436:4505 with SMTP id
 ffacd0b85a97d-381c7a6da29mr11183471f8f.32.1730741273702; 
 Mon, 04 Nov 2024 09:27:53 -0800 (PST)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10e7387sm13668758f8f.51.2024.11.04.09.27.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 09:27:52 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 14/40] rust: clean up define_property macro
Date: Mon,  4 Nov 2024 18:26:53 +0100
Message-ID: <20241104172721.180255-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241104172721.180255-1-pbonzini@redhat.com>
References: <20241104172721.180255-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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


