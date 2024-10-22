Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4622D1CDCB
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 10:13:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3Bq8-0004qY-LR; Tue, 22 Oct 2024 06:10:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t3Bq6-0004pK-Hs
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 06:10:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t3Bq4-0004Mh-R9
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 06:10:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729591807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wbBj01caC6lJt2jK3U2GIrbaj1k0y4qahoaWSgkgdlg=;
 b=PUHrMeskO0+SWuOZFxhz1iXYaqKyfcJvKrxwx+9PEPkR/Ye6vNcAjP3/oq/dnUTyQx6qG5
 /dbCpnWi38AHbr5TVZCiDcCYA2XNcanEye4dRkavrtM9TlBcnoLaik+deOmUFXA8xnmkvg
 MU53fq4pNti1ThSmzJ/AdFd5KbfH5kU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-pztrLJLRPbm3S_bPACgvYw-1; Tue, 22 Oct 2024 06:10:05 -0400
X-MC-Unique: pztrLJLRPbm3S_bPACgvYw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4316e350d6aso19324655e9.3
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 03:10:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729591804; x=1730196604;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wbBj01caC6lJt2jK3U2GIrbaj1k0y4qahoaWSgkgdlg=;
 b=Ffk1JYO+dRtnj7Dzv9/X2KhkdtzlrDk+MTjNmbCY8Yv/VFuzUHn5GfTB5vCvx8KqZP
 CiXKAvzkpV2pEIORXR7FxWxG1VDA0gut5M7O3PrCWJ+PYq8ve1d6mZA7aVkaRIZt+ruB
 2FHoJCPz6pC8zWBEz43NYjcMKSXFtJgy3M6GlyTSikX2yJeq18qBSOiWr+dTPIBlZro2
 cUna4bhLDBIbqetJMiGS7llwLglfkuIlPBB4vKnTv7TfZ/4VuIsscfeVSPf9sl9IZ1t+
 fdkkkEQ7rNntIdlLpoPoB/LJE71BA01f41Jo/I+4hj88mZynAGmKbkS8b8qEZ+tuJJww
 J81g==
X-Gm-Message-State: AOJu0Yw1lITSWVqf+inamYTzd3XkQvjAj3B/xVuisFlCPzy5KVQPSrSY
 +/IckGmsvMXNsNgrO9OV5iYwNQdvciaNaNs/x4Cs6+sxw/ECrfHJCo/yN59gGYh7J8d7c/9zG4t
 q6udUUcq8KiZeqAnut0MuM7dxQhZMFN6Wy69xr//oWR+zziPwQ/S/JBpqsrPwkGbR4mOm7fBn2A
 DbR0VC4dbUfLLIXLfc86Jw65p5yucJf/HLqIck/3Q=
X-Received: by 2002:a7b:ce07:0:b0:431:251a:9dc9 with SMTP id
 5b1f17b1804b1-4317ed25874mr11360845e9.25.1729591803826; 
 Tue, 22 Oct 2024 03:10:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDj51YiXUYWxiG6Ym1Hu15udjnbMb0pqij8oKFiKRX2OJ1LRaQYKCnThPzMhv/tJL+PiO5gw==
X-Received: by 2002:a7b:ce07:0:b0:431:251a:9dc9 with SMTP id
 5b1f17b1804b1-4317ed25874mr11360535e9.25.1729591803366; 
 Tue, 22 Oct 2024 03:10:03 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4316f57fdb2sm82969035e9.20.2024.10.22.03.10.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 03:10:00 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, kwolf@redhat.com, junjie.mao@hotmail.com,
 manos.pitsidianakis@linaro.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 01/14] rust: patch bilge-impl to allow compilation with
 1.63.0
Date: Tue, 22 Oct 2024 12:09:42 +0200
Message-ID: <20241022100956.196657-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241022100956.196657-1-pbonzini@redhat.com>
References: <20241022100956.196657-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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

Apply a patch that removes "let ... else" constructs, replacing them with
"if let ... else" or "let ... =3D match ...".  "let ... else" was stabilize=
d in
Rust 1.65.0.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .gitattributes                                |  2 +
 subprojects/bilge-impl-0.2-rs.wrap            |  1 +
 subprojects/packagefiles/.gitattributes       |  1 +
 .../packagefiles/bilge-impl-1.63.0.patch      | 45 +++++++++++++++++++
 4 files changed, 49 insertions(+)
 create mode 100644 subprojects/packagefiles/.gitattributes
 create mode 100644 subprojects/packagefiles/bilge-impl-1.63.0.patch

diff --git a/.gitattributes b/.gitattributes
index 6dc6383d3d1..9ce7a19581a 100644
--- a/.gitattributes
+++ b/.gitattributes
@@ -5,3 +5,5 @@
 *.rs            diff=3Drust
 *.rs.inc        diff=3Drust
 Cargo.lock      diff=3Dtoml merge=3Dbinary
+
+*.patch         -text -whitespace
diff --git a/subprojects/bilge-impl-0.2-rs.wrap b/subprojects/bilge-impl-0.=
2-rs.wrap
index eefb10c36c2..b24c34a9043 100644
--- a/subprojects/bilge-impl-0.2-rs.wrap
+++ b/subprojects/bilge-impl-0.2-rs.wrap
@@ -5,3 +5,4 @@ source_filename =3D bilge-impl-0.2.0.tar.gz
 source_hash =3D feb11e002038ad243af39c2068c8a72bcf147acf05025dcdb916fcc000=
adb2d8
 #method =3D cargo
 patch_directory =3D bilge-impl-0.2-rs
+diff_files =3D bilge-impl-1.63.0.patch
diff --git a/subprojects/packagefiles/.gitattributes b/subprojects/packagef=
iles/.gitattributes
new file mode 100644
index 00000000000..bf5b766d75d
--- /dev/null
+++ b/subprojects/packagefiles/.gitattributes
@@ -0,0 +1 @@
+/*.patch     -text
diff --git a/subprojects/packagefiles/bilge-impl-1.63.0.patch b/subprojects=
/packagefiles/bilge-impl-1.63.0.patch
new file mode 100644
index 00000000000..987428a6d65
--- /dev/null
+++ b/subprojects/packagefiles/bilge-impl-1.63.0.patch
@@ -0,0 +1,45 @@
+--- a/src/shared/discriminant_assigner.rs
++++ b/src/shared/discriminant_assigner.rs
+@@ -26,20 +26,20 @@
+         let discriminant_expr =3D &discriminant.1;
+         let variant_name =3D &variant.ident;
+=20
+-        let Expr::Lit(ExprLit { lit: Lit::Int(int), .. }) =3D discriminan=
t_expr else {
++        if let Expr::Lit(ExprLit { lit: Lit::Int(int), .. }) =3D discrimi=
nant_expr {
++            let discriminant_value: u128 =3D int.base10_parse().unwrap_or=
_else(unreachable);
++            if discriminant_value > self.max_value() {
++                abort!(variant, "Value of variant exceeds the given numbe=
r of bits")
++            }
++
++            Some(discriminant_value)
++        } else {
+             abort!(
+                 discriminant_expr,
+                 "variant `{}` is not a number", variant_name;
+                 help =3D "only literal integers currently supported"
+             )
+-        };
+-
+-        let discriminant_value: u128 =3D int.base10_parse().unwrap_or_els=
e(unreachable);
+-        if discriminant_value > self.max_value() {
+-            abort!(variant, "Value of variant exceeds the given number of=
 bits")
+         }
+-
+-        Some(discriminant_value)
+     }
+=20
+     fn assign(&mut self, variant: &Variant) -> u128 {
+--- a/src/shared/fallback.rs
++++ b/src/shared/fallback.rs
+@@ -22,8 +22,9 @@
+             }
+             Unnamed(fields) =3D> {
+                 let variant_fields =3D fields.unnamed.iter();
+-                let Ok(fallback_value) =3D variant_fields.exactly_one() e=
lse {
+-                    abort!(variant, "fallback variant must have exactly o=
ne field"; help =3D "use only one field or change to a unit variant")
++                let fallback_value =3D match variant_fields.exactly_one()=
 {
++                    Ok(ok) =3D> ok,
++                    _ =3D> abort!(variant, "fallback variant must have ex=
actly one field"; help =3D "use only one field or change to a unit variant")
+                 };
+=20
+                 if !is_last_variant {
--=20
2.46.2


