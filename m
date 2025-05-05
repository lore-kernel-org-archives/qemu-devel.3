Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50F7EC3ABB0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 09:05:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBrl0-0003Yr-Lg; Mon, 05 May 2025 05:05:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uBrkw-0003Xm-47
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:04:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uBrks-0005kR-0q
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:04:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746435892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cIxpaB6/ZhVVZ3Mu10nisbWNoNkSNb8M6k4MEeUMH1w=;
 b=Xbp/6Pwdrc5NuCdHfCWCGebFaUh/FqFSUsVP6YX2VnQbnsJjYWNIX59AGKLA3UBc9SVAvL
 Vz7DCOHSXmkI+XuTs2r/OqhebPRQulCh0BVcDU8Obc4q1hw6ZJx6fAcESc1GdzNhrYPz+p
 xFIEVb/LathzdeA00qiuyqpW2EjL01I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-c7T1JwD8MM2wo-Uf0u9fpw-1; Mon, 05 May 2025 05:04:51 -0400
X-MC-Unique: c7T1JwD8MM2wo-Uf0u9fpw-1
X-Mimecast-MFC-AGG-ID: c7T1JwD8MM2wo-Uf0u9fpw_1746435890
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43eed325461so22468045e9.3
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 02:04:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746435890; x=1747040690;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cIxpaB6/ZhVVZ3Mu10nisbWNoNkSNb8M6k4MEeUMH1w=;
 b=a8ZPkMX5i8Rw/3LwaTdzYur1GnXnxR6jthIhOYd0O+Hj3f1KQtk7V2mc+NwJEC8frw
 s8P4zy1GmyVgRR8F9qHiTYv34F+4p4wEkE6418oVkR0oA5tHHPDFYFvDNLpFiWVbiL8w
 AOiSWBhAGyxB7J0s1+8k1Rs+jq0z36zKjsu+tZQD3ksEoGtrNTvNkMq2W8FBFWSKIN1l
 B1MWi3RgXN4nvOWFM31LDThili995wG7uckynCHAQYsbUcFttvoNYUCnzY7nOFYbamiG
 QH/NfXhoFFQ+RPbkB+NVQCJOqBOeDRda9yO+xdUaKcbG3PeNmznpJB+MSgoBvjG9TjkA
 Z0jg==
X-Gm-Message-State: AOJu0YyDewUKvWjAe7PTRJ8s+08Ef0UCooKmYtOWZWm3KDo6KE/DR3xq
 ZZEt9zF9bicEt1drf63eW7CsZCv1Eoq7Qbn8E2y1wimsLlEiPg1HLt2Kadfs1XW4dtgcpiotqPY
 pLG0XW7f1seUfxScbzlfprQjdKW2g/mJ4qzQmDUbO91EPQmAQh2NkkPMWUOjai2eiqAgi6d4JTF
 8G4rZwA8qJtkahiVtaYq3HCONsncfG9LB2HdQe
X-Gm-Gg: ASbGncs7TMgVENgsn7FuWsbQggQFWcrGco5c5izABXItckqIF2thWWhX7Vw6M8KOsUH
 hiQ4i2ZU7yCmZs71MnIt0rQtRezm9SrqEVn2RF7/B32RpZWQ8YE30T+3KSj7Tfo403l+F8vdUiJ
 QePg1s93kWI71sgVCggxvB0XgAzxn/qa1QKTLwtGQpoFuZvuW7XCn8Gm/6iwyeOS9Gmp2XPF7Qo
 X9aZdgIUxYoClNko7oYSt13EGRS71DAB2qM2E1OPlI8R1kLCyMpwTRPQqOaPSmZRR0WgkdV3+sm
 j3CNrLToepZ0MyA=
X-Received: by 2002:a05:600c:1e8d:b0:43c:f8fc:f69a with SMTP id
 5b1f17b1804b1-441c48b05edmr59869775e9.4.1746435889681; 
 Mon, 05 May 2025 02:04:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFU3HBgeE9+NVL2gCkYNhERdLc3dP6tTfX8jB6xXHmxVF0BUOEr8pd7nLrYMZCQfoTuKan9zQ==
X-Received: by 2002:a05:600c:1e8d:b0:43c:f8fc:f69a with SMTP id
 5b1f17b1804b1-441c48b05edmr59869455e9.4.1746435889298; 
 Mon, 05 May 2025 02:04:49 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b89d150fsm125521165e9.15.2025.05.05.02.04.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 02:04:47 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: manos.pitsidianakis@linaro.org,
	qemu-rust@nongnu.org
Subject: [PATCH 04/11] rust: let bilge use "let ... else"
Date: Mon,  5 May 2025 11:04:29 +0200
Message-ID: <20250505090438.24992-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250505090438.24992-1-pbonzini@redhat.com>
References: <20250505090438.24992-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/rust.rst                           |  3 --
 subprojects/bilge-impl-0.2-rs.wrap            |  1 -
 .../packagefiles/bilge-impl-1.63.0.patch      | 45 -------------------
 3 files changed, 49 deletions(-)
 delete mode 100644 subprojects/packagefiles/bilge-impl-1.63.0.patch

diff --git a/docs/devel/rust.rst b/docs/devel/rust.rst
index c7dfba98de1..8167ff49aa9 100644
--- a/docs/devel/rust.rst
+++ b/docs/devel/rust.rst
@@ -76,9 +76,6 @@ are missing:
 
 * ``cast_mut()``/``cast_const()`` (1.65.0).  Use ``as`` instead.
 
-* "let ... else" (1.65.0).  Use ``if let`` instead.  This is currently patched
-  in QEMU's vendored copy of the bilge crate.
-
 * Generic Associated Types (1.65.0)
 
 * ``CStr::from_bytes_with_nul()`` as a ``const`` function (1.72.0).
diff --git a/subprojects/bilge-impl-0.2-rs.wrap b/subprojects/bilge-impl-0.2-rs.wrap
index d14c3dc769b..4f84eca1ccd 100644
--- a/subprojects/bilge-impl-0.2-rs.wrap
+++ b/subprojects/bilge-impl-0.2-rs.wrap
@@ -5,7 +5,6 @@ source_filename = bilge-impl-0.2.0.tar.gz
 source_hash = feb11e002038ad243af39c2068c8a72bcf147acf05025dcdb916fcc000adb2d8
 #method = cargo
 patch_directory = bilge-impl-0.2-rs
-diff_files = bilge-impl-1.63.0.patch
 
 # bump this version number on every change to meson.build or the patches:
 # v2
diff --git a/subprojects/packagefiles/bilge-impl-1.63.0.patch b/subprojects/packagefiles/bilge-impl-1.63.0.patch
deleted file mode 100644
index 987428a6d65..00000000000
--- a/subprojects/packagefiles/bilge-impl-1.63.0.patch
+++ /dev/null
@@ -1,45 +0,0 @@
---- a/src/shared/discriminant_assigner.rs
-+++ b/src/shared/discriminant_assigner.rs
-@@ -26,20 +26,20 @@
-         let discriminant_expr = &discriminant.1;
-         let variant_name = &variant.ident;
- 
--        let Expr::Lit(ExprLit { lit: Lit::Int(int), .. }) = discriminant_expr else {
-+        if let Expr::Lit(ExprLit { lit: Lit::Int(int), .. }) = discriminant_expr {
-+            let discriminant_value: u128 = int.base10_parse().unwrap_or_else(unreachable);
-+            if discriminant_value > self.max_value() {
-+                abort!(variant, "Value of variant exceeds the given number of bits")
-+            }
-+
-+            Some(discriminant_value)
-+        } else {
-             abort!(
-                 discriminant_expr,
-                 "variant `{}` is not a number", variant_name;
-                 help = "only literal integers currently supported"
-             )
--        };
--
--        let discriminant_value: u128 = int.base10_parse().unwrap_or_else(unreachable);
--        if discriminant_value > self.max_value() {
--            abort!(variant, "Value of variant exceeds the given number of bits")
-         }
--
--        Some(discriminant_value)
-     }
- 
-     fn assign(&mut self, variant: &Variant) -> u128 {
---- a/src/shared/fallback.rs
-+++ b/src/shared/fallback.rs
-@@ -22,8 +22,9 @@
-             }
-             Unnamed(fields) => {
-                 let variant_fields = fields.unnamed.iter();
--                let Ok(fallback_value) = variant_fields.exactly_one() else {
--                    abort!(variant, "fallback variant must have exactly one field"; help = "use only one field or change to a unit variant")
-+                let fallback_value = match variant_fields.exactly_one() {
-+                    Ok(ok) => ok,
-+                    _ => abort!(variant, "fallback variant must have exactly one field"; help = "use only one field or change to a unit variant")
-                 };
- 
-                 if !is_last_variant {
-- 
2.49.0


