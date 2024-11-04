Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E043D1BDD0
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 17:31:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t80sP-0005UY-6J; Mon, 04 Nov 2024 12:28:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t80sL-0005SB-AC
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:28:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t80sJ-0000Mx-78
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:28:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730741301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3UmgO9fsqdEmWzMoi61XEIn14aScetkmk6rxlD4mFVQ=;
 b=dLI8b/AQ/hWMRD4qUtTfY00KD+h56omXSk8ktPAKVNudqhwOC+f+5XTwTsSs8L8YpSi7Xm
 GCyzFUN5JWFtCdhZQWMzOCvXZmBtcfMcDvvn7b+H/kEGTrqdci/AFXKDP73SMjnDXShPUD
 WWLzA38DmxIqqjkyMoPHHpWhUN1+VkE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-8pGi4Gn3MGi8B1cLc40y4Q-1; Mon, 04 Nov 2024 12:28:19 -0500
X-MC-Unique: 8pGi4Gn3MGi8B1cLc40y4Q-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-381d07c377cso1637134f8f.1
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 09:28:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730741297; x=1731346097;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3UmgO9fsqdEmWzMoi61XEIn14aScetkmk6rxlD4mFVQ=;
 b=t5a3cvXqvuzKDAVsSjcRQMq+ySQwbSnUn1WfFMFok+3G6WDFlcCTr9HacbPRn/DDH7
 CT82JY40BvRvTvmlHxJ5CmR9OWlTgUw6+HkgBD9Nmic/8riaod3a/K+S0RX9CuCVxUlc
 mNjaHckOJeuGWYBDHbZnk0vKfk37un8D295fOXZnuF/HGHl20L+aFVVaurEkkhpoTAGR
 t5dhH+F7vXO9q4pb8b+rf6OLB7Q8llpyd6mObRKjDcqyjdFUiRyY6FGRE0okfBvIXkRY
 8jczNBFj42C3A1u25l1HBe55TB0qWzDCRC+amM0Hw+ug07qbK1Qgev1ibpbdKT1KqYh8
 qT8g==
X-Gm-Message-State: AOJu0YwAg+4LbxSUVrRgZhYXkxba/A5wA/eAoO99R7Juw64NjNvBhlZ7
 kcfdB4thjm7oFplygMARvFPEwY2ajFkY+ndknAt02BKrPiwcftFIoQggSfaATysmH7pN5PZ/xrX
 GfYW9yTNthpiAQUEnrpGN5nWHpNqThxT5ivHafFTHBwTNj+oD3waLRLSJ63OO1o4Yfp2+FgfTgE
 vhow3ogKcCFhBZ/6tZFR7aAqwf9+hDy3AIfRbNmZY=
X-Received: by 2002:a5d:47ac:0:b0:37d:48f2:e749 with SMTP id
 ffacd0b85a97d-381c7a4636cmr13690109f8f.10.1730741297402; 
 Mon, 04 Nov 2024 09:28:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFpMPJYcg9oY5gWVVg3kGldS68WlxPrUKLExniUyJ3JWSOfRtU6X6FWHRWIW7Ku9YYH8bymVQ==
X-Received: by 2002:a5d:47ac:0:b0:37d:48f2:e749 with SMTP id
 ffacd0b85a97d-381c7a4636cmr13690078f8f.10.1730741296938; 
 Mon, 04 Nov 2024 09:28:16 -0800 (PST)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10b7c08sm13779745f8f.17.2024.11.04.09.28.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 09:28:16 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 25/40] rust: patch bilge-impl to allow compilation with 1.63.0
Date: Mon,  4 Nov 2024 18:27:04 +0100
Message-ID: <20241104172721.180255-26-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Apply a patch that removes "let ... else" constructs, replacing them with
"if let ... else" or "let ... = match ...".  "let ... else" was stabilized in
Rust 1.65.0.

Reviewed-by: Junjie Mao <junjie.mao@hotmail.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .gitattributes                                |  2 +
 subprojects/bilge-impl-0.2-rs.wrap            |  1 +
 .../packagefiles/bilge-impl-1.63.0.patch      | 45 +++++++++++++++++++
 3 files changed, 48 insertions(+)
 create mode 100644 subprojects/packagefiles/bilge-impl-1.63.0.patch

diff --git a/.gitattributes b/.gitattributes
index 6dc6383d3d1..9ce7a19581a 100644
--- a/.gitattributes
+++ b/.gitattributes
@@ -5,3 +5,5 @@
 *.rs            diff=rust
 *.rs.inc        diff=rust
 Cargo.lock      diff=toml merge=binary
+
+*.patch         -text -whitespace
diff --git a/subprojects/bilge-impl-0.2-rs.wrap b/subprojects/bilge-impl-0.2-rs.wrap
index eefb10c36c2..b24c34a9043 100644
--- a/subprojects/bilge-impl-0.2-rs.wrap
+++ b/subprojects/bilge-impl-0.2-rs.wrap
@@ -5,3 +5,4 @@ source_filename = bilge-impl-0.2.0.tar.gz
 source_hash = feb11e002038ad243af39c2068c8a72bcf147acf05025dcdb916fcc000adb2d8
 #method = cargo
 patch_directory = bilge-impl-0.2-rs
+diff_files = bilge-impl-1.63.0.patch
diff --git a/subprojects/packagefiles/bilge-impl-1.63.0.patch b/subprojects/packagefiles/bilge-impl-1.63.0.patch
new file mode 100644
index 00000000000..987428a6d65
--- /dev/null
+++ b/subprojects/packagefiles/bilge-impl-1.63.0.patch
@@ -0,0 +1,45 @@
+--- a/src/shared/discriminant_assigner.rs
++++ b/src/shared/discriminant_assigner.rs
+@@ -26,20 +26,20 @@
+         let discriminant_expr = &discriminant.1;
+         let variant_name = &variant.ident;
+ 
+-        let Expr::Lit(ExprLit { lit: Lit::Int(int), .. }) = discriminant_expr else {
++        if let Expr::Lit(ExprLit { lit: Lit::Int(int), .. }) = discriminant_expr {
++            let discriminant_value: u128 = int.base10_parse().unwrap_or_else(unreachable);
++            if discriminant_value > self.max_value() {
++                abort!(variant, "Value of variant exceeds the given number of bits")
++            }
++
++            Some(discriminant_value)
++        } else {
+             abort!(
+                 discriminant_expr,
+                 "variant `{}` is not a number", variant_name;
+                 help = "only literal integers currently supported"
+             )
+-        };
+-
+-        let discriminant_value: u128 = int.base10_parse().unwrap_or_else(unreachable);
+-        if discriminant_value > self.max_value() {
+-            abort!(variant, "Value of variant exceeds the given number of bits")
+         }
+-
+-        Some(discriminant_value)
+     }
+ 
+     fn assign(&mut self, variant: &Variant) -> u128 {
+--- a/src/shared/fallback.rs
++++ b/src/shared/fallback.rs
+@@ -22,8 +22,9 @@
+             }
+             Unnamed(fields) => {
+                 let variant_fields = fields.unnamed.iter();
+-                let Ok(fallback_value) = variant_fields.exactly_one() else {
+-                    abort!(variant, "fallback variant must have exactly one field"; help = "use only one field or change to a unit variant")
++                let fallback_value = match variant_fields.exactly_one() {
++                    Ok(ok) => ok,
++                    _ => abort!(variant, "fallback variant must have exactly one field"; help = "use only one field or change to a unit variant")
+                 };
+ 
+                 if !is_last_variant {
-- 
2.47.0


