Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8643D1039E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 16:03:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4MmU-00026Z-QO; Fri, 25 Oct 2024 12:03:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t4MmP-00021T-5y
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 12:03:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t4MmN-0004q1-1Y
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 12:03:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729872190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SHZpikGNVFgjiDhFQjm7CP2c0blb3vG5jwdwFgYBZPE=;
 b=fMXHGwEII2A4LEfkEGMa+HzfYgDAVcygC6keRYW892XSGyYxSNKh6uvWJfcV6lt1vEZIbV
 P9JbAnQ9PCVJHAIMuthujJFZnC6f8piCI3QCOP5r+DvZMnwB7TWhCkMqPc+EJwEaopO6NG
 Jd+4KIu19mJAJnvIR8rHj6cdap6Eg8Y=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-UvFP4-YYPFWQz4SQ3HjI-g-1; Fri, 25 Oct 2024 12:03:09 -0400
X-MC-Unique: UvFP4-YYPFWQz4SQ3HjI-g-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2fb4e2da8baso17579021fa.0
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 09:03:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729872186; x=1730476986;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SHZpikGNVFgjiDhFQjm7CP2c0blb3vG5jwdwFgYBZPE=;
 b=xAGIbh6N1NwroBeIOoz14sXM1ZzewC+3+9gAl3JJVi57OeY6SEDT0cxIYdqcvr7Eil
 9r9GDEplpjSHYMR50IPyWofZR9MhWf+8vZpwiFuCc2icZhn0vA8QkVFy4idsms/VPdoi
 dN9fvj/KswcuukYvTk/E0ZI4zkVIzZek72bc1NTO09Nj7jszcZPlVuNIxy9XH1FAdSf6
 jOwYT5ifVMVa34zI3TtCWMRhjyDNPBEvxuszKKEO5UHJdPG8gDDzxMrrH2poIf4BtI2M
 CYNDfhikJsFsc7AL/MWXpSOfNv7le77HBdXjRCCPuNwXq9HmWOOjAZ2cVvE+SNWhfhKx
 hhzQ==
X-Gm-Message-State: AOJu0Yzny8I7Fy0IdqGyn/xi+k3MrqTpxTFft9HdWLrKhm0aKp1KykYt
 UKfW1rt6OEA7rgFhP7I4ap8ZrMMoKzvV8/fWgUNdjrm7rxaDiTryVRNkYrXNMzD8WJY231/3UPv
 8VmTkEabUpmem7ouz94iuuNNC6Ty/eIWDwLXW0MJReRGBSfQFyLYLZyMuEMOv41LDJ84MtV/bbt
 QJ64HuXQ/4qL3Gsg7uZHXqZ5V++daWfMPJOpBgx6c=
X-Received: by 2002:a2e:4619:0:b0:2fa:cc86:f217 with SMTP id
 38308e7fff4ca-2fca8264714mr32733971fa.35.1729872185197; 
 Fri, 25 Oct 2024 09:03:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGX0SK+dO0ES1KpzNxs1DZBihiCSdKwZn6wpiDNWGJRyJMfizHisBCqJ4cJpyuuEPZOWRVyiw==
X-Received: by 2002:a2e:4619:0:b0:2fa:cc86:f217 with SMTP id
 38308e7fff4ca-2fca8264714mr32732591fa.35.1729872182953; 
 Fri, 25 Oct 2024 09:03:02 -0700 (PDT)
Received: from [192.168.10.47] ([151.81.112.43])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cbb62c4860sm752003a12.54.2024.10.25.09.02.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2024 09:02:57 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: manos.pitsidianakis@linaro.org, zhao1.liu@intel.com,
 junjie.mao@hotmail.com, berrange@redhat.com
Subject: [PATCH 08/23] rust: patch bilge-impl to allow compilation with 1.63.0
Date: Fri, 25 Oct 2024 18:01:53 +0200
Message-ID: <20241025160209.194307-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241025160209.194307-1-pbonzini@redhat.com>
References: <20241025160209.194307-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.454,
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
"if let ... else" or "let ... =3D match ...".  "let ... else" was stabilize=
d in
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
2.47.0


