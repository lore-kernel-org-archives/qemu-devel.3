Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CFA0C3ABAA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 10:26:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAnYX-0001Dh-Oj; Fri, 02 May 2025 06:23:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uAnYT-0001CM-8h
 for qemu-devel@nongnu.org; Fri, 02 May 2025 06:23:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uAnYP-0000gF-Tl
 for qemu-devel@nongnu.org; Fri, 02 May 2025 06:23:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746181416;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0wGtDv+e42FWFLc2rz5Xnqr0uS39xEo6CeUJ4+JJbog=;
 b=MBtjqBwX+U6ibp3Imd/56DIWP3DF6B4l/O/O64gIhiUrrpPFTWWLOBHAzyZhlIPiDfgS8p
 /EhbGR8Cgr46rh2c+iXY8CzvfBpJBzTrm8aKAOHfRfpzYdvXU0d9Pg36q9HyZHjPq4Oyul
 CWJr7/KGWTxWYSeJdZRsAxyf6tX/g9g=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-feQnFU4VM7O2c2IZLJ1yEQ-1; Fri, 02 May 2025 06:23:35 -0400
X-MC-Unique: feQnFU4VM7O2c2IZLJ1yEQ-1
X-Mimecast-MFC-AGG-ID: feQnFU4VM7O2c2IZLJ1yEQ_1746181414
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3912e4e2033so498487f8f.0
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 03:23:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746181413; x=1746786213;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0wGtDv+e42FWFLc2rz5Xnqr0uS39xEo6CeUJ4+JJbog=;
 b=vFn5HEUcOa24X6jU5K1nNUL1cZDpCt6x/z54rZCFsDzHWFM335z83sV8SfmkECkH2h
 kJjw1Ja1dU6D1uAL8TlMV2TGcQEAtm4S5T1GN8KP56vE6ITeZA2WR/OHA97Hprg2tR6X
 Ss72Cn/EOBN9Edmu7Kz7LbsBTsdgM3CgInSrmdJxPCVCaVWPqgwi6rMLd0WuL0a/mZ+C
 Cc1LSJT4Ts0yUlX+OaDkMcdWv6+DpLWVi2JQRTADTx5HKN14GZ8g1xi2hvZQB3q6jPtl
 eN8VqkgZMVPIgUX03J4Zu0dbRRiteAhwzHz+7K1viHPTgITWNhrvg0G3lwPrqWnGmAnu
 LfLQ==
X-Gm-Message-State: AOJu0Yxkg8ZGjMx+1HgeE3JVoI692413XlofKOWxsK6FLa78hTJ5uier
 7EFLC17Kj0guJVmxSW196QV+jv1f+g9rAN0VCEh+RkFGCkWw+KdHASPMGTQyc6QXVauS5L/MX9K
 JvWe41OlPn5wolhN86yEpxZBHpvNQvFs1i8D9ZZF63jJzVsHCfyeKV/wTV+FrXSnHCYgIZlvhGL
 Q1c5zDS5QyTm2JXgcGw1sKgiC1JU53PlJCAkfh
X-Gm-Gg: ASbGncuSY2i0zOEw/jM61qx9vpaHEcCpY6g+yIn6aswZPEPAycCWp6Z8IvuKzirJWVa
 89Vb3/K3TEH0J2fLt1PRrhPvbB0LsMn5XNYO8TZmy2hdGBm5SkC1jnR71pxe1tKi1jRj90nY8Nu
 BbCAMKg1kjzImK3JZwmfWLuRrQSrEkfMp7IGD9+eI1BfCGiHKeZ1VPgXHOlePs+4EiFRWYgluEc
 thsP0ZmzuFAi8GTwJBGxe/kB1WFhVrLvK/yyUp4d+ZBGOEyRBotA3jRf6zu9A0FZBYElTbqIpXX
 ELiwsJkoLlUEi9M=
X-Received: by 2002:a05:6000:2209:b0:399:6dc0:f15b with SMTP id
 ffacd0b85a97d-3a099af15f3mr1294157f8f.48.1746181413652; 
 Fri, 02 May 2025 03:23:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfMXw17xYz1tqsdhpeJ/VG91CpziOEli/SuErCOrID/k3V9+B2fqQEJvOky4PjVjinZ+XBpA==
X-Received: by 2002:a05:6000:2209:b0:399:6dc0:f15b with SMTP id
 ffacd0b85a97d-3a099af15f3mr1294138f8f.48.1746181413173; 
 Fri, 02 May 2025 03:23:33 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099b16ea2sm1684645f8f.85.2025.05.02.03.23.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 03:23:30 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 3/9] rust: let bilge use "let ... else"
Date: Fri,  2 May 2025 12:23:16 +0200
Message-ID: <20250502102323.104815-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250502102323.104815-1-pbonzini@redhat.com>
References: <20250502102323.104815-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.644,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/rust.rst                           |  3 --
 subprojects/bilge-impl-0.2-rs.wrap            |  2 -
 .../packagefiles/bilge-impl-1.63.0.patch      | 45 -------------------
 3 files changed, 50 deletions(-)
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
index d14c3dc769b..4ccd376eb98 100644
--- a/subprojects/bilge-impl-0.2-rs.wrap
+++ b/subprojects/bilge-impl-0.2-rs.wrap
@@ -4,8 +4,6 @@ source_url = https://crates.io/api/v1/crates/bilge-impl/0.2.0/download
 source_filename = bilge-impl-0.2.0.tar.gz
 source_hash = feb11e002038ad243af39c2068c8a72bcf147acf05025dcdb916fcc000adb2d8
 #method = cargo
-patch_directory = bilge-impl-0.2-rs
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


