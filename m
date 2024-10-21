Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DF18D15DBA
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 16:39:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2vP2-0006yB-1t; Mon, 21 Oct 2024 12:37:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t2vOF-0006E5-DB
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 12:36:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t2vOD-0006KP-OI
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 12:36:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729528575;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hHp8U+fC4YmDmSdyK3Hbe0MIdIfjHmGSBbEEt6avx3w=;
 b=ZI4pae39sOpSnJuIUw0l7jnmA9GiYvTHpFGh+EjkccWq2pn5R9AMiFEUs1WD071y1iY3nV
 HjWoJK0KAAH+eUAhl3MSpiNRYoRbluhjdEGguR4BLTJcNQn5GCkfN4hmbjKGU+Wi8xalgn
 wq20s4K0TvwEuVSv9DD28NbByXsktBk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-ra4IysxaN8yKTROnfyO01A-1; Mon, 21 Oct 2024 12:36:14 -0400
X-MC-Unique: ra4IysxaN8yKTROnfyO01A-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4315c1b5befso33563535e9.1
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 09:36:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729528572; x=1730133372;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hHp8U+fC4YmDmSdyK3Hbe0MIdIfjHmGSBbEEt6avx3w=;
 b=FSv0QpluhBUVV5nEHlaN7CdNeNkHuTCoiVxyZqJaIOBObydXFUtT8AU2X0Rgajscdt
 9JNI50XLeC+cJ9V/YLZUGf3g/GscFLcR0sOOVVxIv5XQPikRi7LsXVyU56y6sgI19LUS
 MgKIs/eA9NdXkN02evFLbXnbU022FiL/abcjmQn9AazZxiRI3KCCQ3V7GMwAP5Tx+hW1
 xsVaGb+SiNsYHX9/5K4zuey2VCHOWqh+OXxrAS21T+eyqhyvL/9gvfiSpgHCYPVns3RI
 Zci9or8tw6qFeC41LXI/G5OBVU16uk1eEgf9pE5AAZkpdTNqz/26kmjeWmYlFf3AK5df
 GMUg==
X-Gm-Message-State: AOJu0Yw1jp5j2jxYOHSQ0JRb1OGAjLs6mvPQHcZqX7FYkNjoZliv3aO/
 7GzBZ27m6wYUDjkWQ7VAGEIzB343yaLMJrR5zP3loQEchINu6d98XQVV0a8yIHy4acyH18v/a1H
 QKN7vQcl1ECOLPlMMfz57wh+w/5HHuw6MuBCZRzW9YdbczuAxc9hIqQA8x7XwVpIJNN0Lp7tXqx
 huARrC1F8twq1u9vgQU41R2c6UmE+nuUQFgk82sGY=
X-Received: by 2002:a05:600c:1d8d:b0:426:5e91:3920 with SMTP id
 5b1f17b1804b1-43161692d44mr99877815e9.29.1729528572039; 
 Mon, 21 Oct 2024 09:36:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTpuBpV1Y/2bigGkfFPEf+RgAHG6s7VIKYboB4Cb69l40jGZAMLPiQQSnRKeIKdRBMrLo3ZA==
X-Received: by 2002:a05:600c:1d8d:b0:426:5e91:3920 with SMTP id
 5b1f17b1804b1-43161692d44mr99877635e9.29.1729528571622; 
 Mon, 21 Oct 2024 09:36:11 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4316f5cc5b9sm63138085e9.45.2024.10.21.09.36.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 09:36:11 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: [PATCH v2 09/13] rust: clean up define_property macro
Date: Mon, 21 Oct 2024 18:35:34 +0200
Message-ID: <20241021163538.136941-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241021163538.136941-1-pbonzini@redhat.com>
References: <20241021163538.136941-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.699,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


