Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2B56D30011
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 14:45:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1oCd-0008Gw-3l; Fri, 18 Oct 2024 10:43:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t1oCb-0008Gj-QU
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 10:43:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t1oCa-0002cD-7K
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 10:43:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729262619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KJ9hL0B7RAY1pA3mAAYh7QRZKmrXfTFSuloe8GbmWow=;
 b=cKh9UQsy74Xui9Qn2/rmuh5iTTnzGEhrlJzBLtp1r432QoGYrvV049KupeyVoJTfrI3GOW
 PaHzjhzXhv9QCujrq15SCRzC37iFXD2iniSu1VqaF9G4vjZ1ePB3heHqWzuxjqehonk9KG
 JzXqcL2zoukh/Lk1poDeYUGJnNUcB7A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-M2HA-QtJNjSSiC7yB5LdIw-1; Fri, 18 Oct 2024 10:43:38 -0400
X-MC-Unique: M2HA-QtJNjSSiC7yB5LdIw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4315c1b5befso13542805e9.1
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2024 07:43:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729262617; x=1729867417;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KJ9hL0B7RAY1pA3mAAYh7QRZKmrXfTFSuloe8GbmWow=;
 b=R7BdJlSYG+FqMZhuefAxsWA+JBilwbs7DZAQREOdkxx0uIelCKpXUmIZYOR3xVFOEd
 X2Kw7haHtHTpsMwuMNlH+iLIsmxZ7JWQlUrbL3rrr+8m4jJxcF6PiH0WtWBISY8Pq3rM
 SWfXCLfuk6iQc16EbrjFInh5McBJKmdH2o6U29icjbokCc0Ue7G/Hd66mukoPcgQ7046
 KdAE8eoVKspE+RhEK5yZ8iGtfNd8VuD+6wbqmz+4rWYE5NinRkEX/1l1q8fI3wNtzJJR
 Z8ZI+9gkCJ+xtYSWASpJG8gZ4kIHxUKirTggu6ot+hs1NuoOtB7AORV/WAUZ9KMSbLMW
 mOHQ==
X-Gm-Message-State: AOJu0Yx00UX4xF06fIar23LjXmdiAfgfDUjNA3AjD4VBJGHRr6cJTNtq
 aJG8DtyrdL5ffw78098MOSTkNFBDrYua8vIr1n5mc0vR2TwB3R6mOEbvRrq5N54iBGCIsqg4Fir
 Cxmi+c+3sO/zt7K/CW+3t0cn1kXf3pMUcPwMKpjJmRFMPPv0n9yNm5jV2s4EgYaO/K1SgsavRhA
 Yxj5ArZm6CdGbIA8HRr9X9dqqOLTM2X7VzqE/tz+s=
X-Received: by 2002:a05:600c:1c03:b0:431:3bf9:3ebb with SMTP id
 5b1f17b1804b1-431616898a5mr21939355e9.24.1729262616711; 
 Fri, 18 Oct 2024 07:43:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/2cIUiEBADCILiY5g85Eusx16/mEEHLBs7CDCit4oBcI9vX6pe+Zt6icYGYffc8B+zKocKg==
X-Received: by 2002:a05:600c:1c03:b0:431:3bf9:3ebb with SMTP id
 5b1f17b1804b1-431616898a5mr21939075e9.24.1729262616252; 
 Fri, 18 Oct 2024 07:43:36 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431606c6be6sm29414975e9.31.2024.10.18.07.43.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 07:43:35 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: [PATCH 09/13] rust: clean up define_property macro
Date: Fri, 18 Oct 2024 16:43:01 +0200
Message-ID: <20241018144306.954716-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241018144306.954716-1-pbonzini@redhat.com>
References: <20241018144306.954716-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/device_class.rs | 29 ++++++-----------------------
 1 file changed, 6 insertions(+), 23 deletions(-)

diff --git a/rust/qemu-api/src/device_class.rs b/rust/qemu-api/src/device_class.rs
index 2219b9f73d0..5aba426d243 100644
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
             defval: $crate::bindings::Property__bindgen_ty_1 { u: $defval.into() },
-            arrayoffset: 0,
-            arrayinfo: ::core::ptr::null(),
-            arrayfieldsize: 0,
-            link_type: ::core::ptr::null(),
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
2.46.2


