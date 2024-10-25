Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88FFFD149C1
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 16:10:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4Mov-0005Ce-EX; Fri, 25 Oct 2024 12:05:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t4Mnx-0004WJ-RR
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 12:04:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t4Mnv-0004yv-VB
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 12:04:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729872287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=max4ptoWARDXa3Y5mnahsubFzzuLs19p4ctB7GiY7D4=;
 b=OIXKjH9XKJDWMFkEd0D55MVxHBjSOcnp9m/Gy5d5QIyj9SBMCHBDPUKFI4tfRI/90TCi0P
 EFPDBU7+x3SPP9ToYTkj9jm5JyR35+ufL16euchQuBp5ABtbY8NPKCyQNlPJXZZGR42y3H
 sDIjqaOGhzJa0wOUir/tcDfFzJeklpU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-1nflGp0VNk-arTG7xYITZw-1; Fri, 25 Oct 2024 12:04:42 -0400
X-MC-Unique: 1nflGp0VNk-arTG7xYITZw-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a9adb271de7so102553266b.0
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 09:04:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729872280; x=1730477080;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=max4ptoWARDXa3Y5mnahsubFzzuLs19p4ctB7GiY7D4=;
 b=ZKyFTE3pfPwQAiPPe4qzmdfwCO9/VOmios8WwoB2F3DRrpsZaaQFuNQXcHhvpdXdin
 mOvx/1l4vBTPZV878Cxu656QSF6UTM27/ibpcoPirEmb+3LIRjRIHSfa9gzNq+SVm/KW
 VRxb92pViZ/dkNFs/HcinadpQOQmzpSR61pB+ZXB4e2YfotWMEsU+vXUU14mXp8UhT06
 LHwCZrxBWzlzUj51Riw9RGqZbcLyXVfaL+uumJu6DG1plUxWLL0666hsbUoYVCaupTXJ
 rW9Xv6xd2b+1PNVRzh5vry0MoKu72wcuX18QVpRsyWodsOBXmb3EXvboauLG8LKSHtQm
 HLPw==
X-Gm-Message-State: AOJu0YwK3ULgRuiTiVOr90aIvXzoiuMX+bNKcSaUUqRvnQcI+NK3lKxc
 Cos8pv1yW1BpJ4oMnutGCaA2hr0mQCOcFCd7OxbcHKU6a8pKRFNeSUi0EB4RsbUkn7y+ltUpT/X
 7k0Wx6WPbLnLpPlvLaH8z/TAcJyJNVvDTvREupJcQrKr96d5ClEazNzoGND05qHLnPclSrals2V
 MqqRluXR/YtrGix02LuAZ+ZDuXMFEjrgMpkT2N5jc=
X-Received: by 2002:a17:907:7da5:b0:a9a:421:720 with SMTP id
 a640c23a62f3a-a9ad283263emr466289866b.46.1729872279985; 
 Fri, 25 Oct 2024 09:04:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEumtWYbq0/deuwQSHN+ZegtMRrT7wZQr4VKX8XXxm7QWfGz7uYrI0AEqHRFrcj6g1+9PG23Q==
X-Received: by 2002:a17:907:7da5:b0:a9a:421:720 with SMTP id
 a640c23a62f3a-a9ad283263emr466286666b.46.1729872279440; 
 Fri, 25 Oct 2024 09:04:39 -0700 (PDT)
Received: from [192.168.10.47] ([151.81.112.43])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9b1dfbc814sm85423266b.37.2024.10.25.09.04.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2024 09:04:34 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: manos.pitsidianakis@linaro.org, zhao1.liu@intel.com,
 junjie.mao@hotmail.com, berrange@redhat.com
Subject: [PATCH 19/23] rust: do not use --generate-cstr
Date: Fri, 25 Oct 2024 18:02:04 +0200
Message-ID: <20241025160209.194307-20-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241025160209.194307-1-pbonzini@redhat.com>
References: <20241025160209.194307-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.454,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
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

--generate-cstr is a good idea and generally the right thing to do,
but it is not available in Debian 12 and Ubuntu 22.04.  Work around
the absence.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                       |  4 +++-
 rust/hw/char/pl011/src/device.rs  |  1 +
 rust/qemu-api/src/device_class.rs | 10 ++++++++++
 rust/qemu-api/tests/tests.rs      |  4 ++--
 4 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/meson.build b/meson.build
index ab0613f353c..bfd04294850 100644
--- a/meson.build
+++ b/meson.build
@@ -3941,13 +3941,15 @@ common_all =3D static_library('common',
                             dependencies: common_ss.all_dependencies())
=20
 if have_rust
+  # We would like to use --generate-cstr, but it is only available
+  # starting with bindgen 0.66.0.  The oldest supported versions
+  # are in Ubuntu 22.04 (0.59.1) and Debian 12 (0.60.1).
   bindgen_args =3D [
     '--disable-header-comment',
     '--raw-line', '// @generated',
     '--ctypes-prefix', 'std::os::raw',
     '--formatter', 'rustfmt',
     '--generate-block',
-    '--generate-cstr',
     '--impl-debug',
     '--merge-extern-blocks',
     '--no-doc-comments',
diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/devi=
ce.rs
index bca727e37f0..2a85960b81f 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -12,6 +12,7 @@
     bindings::{self, *},
     c_str,
     definitions::ObjectImpl,
+    device_class::TYPE_SYS_BUS_DEVICE,
 };
=20
 use crate::{
diff --git a/rust/qemu-api/src/device_class.rs b/rust/qemu-api/src/device_c=
lass.rs
index 56608c7f7fc..0ba798d3e3c 100644
--- a/rust/qemu-api/src/device_class.rs
+++ b/rust/qemu-api/src/device_class.rs
@@ -2,6 +2,10 @@
 // Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
 // SPDX-License-Identifier: GPL-2.0-or-later
=20
+use std::ffi::CStr;
+
+use crate::bindings;
+
 #[macro_export]
 macro_rules! device_class_init {
     ($func:ident, props =3D> $props:ident, realize_fn =3D> $realize_fn:exp=
r, legacy_reset_fn =3D> $legacy_reset_fn:expr, vmsd =3D> $vmsd:ident$(,)*) =
=3D> {
@@ -62,3 +66,9 @@ macro_rules! declare_properties {
         ];
     };
 }
+
+// workaround until we can use --generate-cstr in bindgen.
+pub const TYPE_DEVICE: &CStr =3D
+    unsafe { CStr::from_bytes_with_nul_unchecked(bindings::TYPE_DEVICE) };
+pub const TYPE_SYS_BUS_DEVICE: &CStr =3D
+    unsafe { CStr::from_bytes_with_nul_unchecked(bindings::TYPE_SYS_BUS_DE=
VICE) };
diff --git a/rust/qemu-api/tests/tests.rs b/rust/qemu-api/tests/tests.rs
index 7442f695646..43a4827de12 100644
--- a/rust/qemu-api/tests/tests.rs
+++ b/rust/qemu-api/tests/tests.rs
@@ -8,7 +8,7 @@
     bindings::*,
     c_str, declare_properties, define_property,
     definitions::{Class, ObjectImpl},
-    device_class_init,
+    device_class, device_class_init,
     zeroable::Zeroable,
 };
=20
@@ -57,7 +57,7 @@ impl ObjectImpl for DummyState {
         type Class =3D DummyClass;
         const TYPE_INFO: qemu_api::bindings::TypeInfo =3D qemu_api::type_i=
nfo! { Self };
         const TYPE_NAME: &'static CStr =3D c_str!("dummy");
-        const PARENT_TYPE_NAME: Option<&'static CStr> =3D Some(TYPE_DEVICE=
);
+        const PARENT_TYPE_NAME: Option<&'static CStr> =3D Some(device_clas=
s::TYPE_DEVICE);
         const ABSTRACT: bool =3D false;
         const INSTANCE_INIT: Option<unsafe extern "C" fn(obj: *mut Object)=
> =3D None;
         const INSTANCE_POST_INIT: Option<unsafe extern "C" fn(obj: *mut Ob=
ject)> =3D None;
--=20
2.47.0


