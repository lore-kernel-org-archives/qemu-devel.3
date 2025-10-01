Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CEBDCCA474
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 08:03:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3rmo-0005uE-F5; Wed, 01 Oct 2025 04:02:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3rml-0005st-Sv
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 04:02:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3rmH-0006AT-Ii
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 04:02:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759305688;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iXRxIvcEe/Z7qFtxTMRf88GtEhTdd8ApPecigj5FOVg=;
 b=T+rcyh/i7yuZ/ORvRoPl6FiSa1zfpKGs8w12v6KgkrKSVChgd//g2nvUcVrrA3IiwrOgZ/
 hLv966952FMuu/tuDFn4jxtk4vhCDHj0SqXPPBEiGBJ4wMEdT/+wNMX7ajkbNBRbxX3LZJ
 rLPSMSKxAHzQ3t+wAPPFAzImavZlaDI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-3In2vL6fO_6sZg2QhjF0QQ-1; Wed, 01 Oct 2025 04:01:27 -0400
X-MC-Unique: 3In2vL6fO_6sZg2QhjF0QQ-1
X-Mimecast-MFC-AGG-ID: 3In2vL6fO_6sZg2QhjF0QQ_1759305686
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-634ad8328fdso6837750a12.0
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 01:01:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759305685; x=1759910485;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iXRxIvcEe/Z7qFtxTMRf88GtEhTdd8ApPecigj5FOVg=;
 b=N7pioKzMOsQCtDK10WjFHffCmfU3/oJAKIJqdaosnVAPsGQjbXeCMNkY1I4ML67lK3
 SGt2UhrcfwzRz+1UurvlvQ/ThjhgNy4SaXqnkiPaJDr5xmkUS2AWKkwLhIDFiNmvlFoF
 NbjHlJjg1xwDJp1+T6DKuDj7qxYt6lxoYtLb0ssjufcVPn5lTE0D2Nd01H6rwdWzt1Fe
 t2QvGA9O4cplbyA+r77CXGgp6mjsxPP76NJcS4Yyd5qBxM7RCmJwTirrek6fbCNaICMQ
 VGbuPmiKbV1zSZfZK9pgnKGiY6FO+U75s4NxtlDtWkUdLzM7lqcEPrejWfGYeQ2cZ2/o
 LYvg==
X-Gm-Message-State: AOJu0YzJI2e2WgbOYtcqHTxZnMc2VdggMLHZSAkV9MKydXZBVtcbpf5e
 Vi91FMWJUtaPWuimERn55VpFoMjVphu9cDuDv7ijBX/vmXfclzpuJDP2GWLMD/yAeqPueDdVPmZ
 lfo5xt7Jceyd88AAOlAaswMmmP1cM3Iga2pUu0mfABCRzZUunu8aAmCKckdMH6U7XbPoVhkC/rO
 JTclssfsrnn2YV7BaTTR2CiCQR3xUp8mOYEuWFcY7V
X-Gm-Gg: ASbGncu+6Mv5ScnnTQ8pjrhS2bbEZZFG0Ae8M6rf7mQGvTiQ8P1QuQmZse4G7b1upuA
 XzuMhGMM0kx+2OVzVo2NmM7uQLw25Lg/NKj75LMQa66iw98jcKtDVaWxzHy2Ozz+h198WYu4gPD
 OEm+03LCAcZsNb56Keyj1NzijIemjm3H+zCUMJZaFo+3rOS3kU5vCHgkGxQqX8kkqMlmKTkdQRi
 VXzK9qqsgQkjgTNcjiot2fXBEkpaR3sxNmwVRM7P1Q3a9f7cqrObWSyRwE+asZGBSm0I+VHbaKf
 z/vrnoK1YL8a00RrLtU64kuazmXQMQhvzF/FqtqTvF37NI1GjXSdJsHoonspbHYLmYlUkb3Gk+I
 9WIxYI9BWwV6g97Pa9umzDMg39UI9esoDKhnHcag0XtiSdYxv0kU=
X-Received: by 2002:a17:906:5607:b0:b47:de64:df1e with SMTP id
 a640c23a62f3a-b47de64e377mr21305466b.4.1759305685440; 
 Wed, 01 Oct 2025 01:01:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECp6ucsvTf8qIxdz1Z0r5ke/rmhTYGrrISeMrRk+6Rs27KZyPF3EOVognMGBp2ohqYu/TyyA==
X-Received: by 2002:a17:906:5607:b0:b47:de64:df1e with SMTP id
 a640c23a62f3a-b47de64e377mr21300666b.4.1759305684996; 
 Wed, 01 Oct 2025 01:01:24 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.127.188])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b353f772528sm1316250066b.37.2025.10.01.01.01.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 01:01:23 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	armbru@redhat.com,
	marcandre.lureau@redhat.com
Subject: [PATCH 13/14] rust/util: build QAPI types
Date: Wed,  1 Oct 2025 10:00:50 +0200
Message-ID: <20251001080051.1043944-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001075005.1041833-1-pbonzini@redhat.com>
References: <20251001075005.1041833-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/util/wrapper.h          |  1 +
 qapi/meson.build             |  6 ++++++
 rust/Cargo.lock              |  1 +
 rust/util/Cargo.toml         |  1 +
 rust/util/meson.build        | 18 +++++++++++++++++-
 rust/util/src/qobject/mod.rs |  9 +++++++++
 6 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/rust/util/wrapper.h b/rust/util/wrapper.h
index 0907dd59142..c88820a5e5b 100644
--- a/rust/util/wrapper.h
+++ b/rust/util/wrapper.h
@@ -37,3 +37,4 @@ typedef enum memory_order {
 #include "qobject/qobject.h"
 #include "qobject/qlist.h"
 #include "qobject/qdict.h"
+#include "qobject/qjson.h"
diff --git a/qapi/meson.build b/qapi/meson.build
index ca6b61a608d..5d4b55b47f8 100644
--- a/qapi/meson.build
+++ b/qapi/meson.build
@@ -129,3 +129,9 @@ foreach output : qapi_outputs
   util_ss.add(qapi_files[i])
   i = i + 1
 endforeach
+
+qapi_rs_files = custom_target('QAPI Rust',
+  output: 'qapi-types.rs',
+  input: [ files('qapi-schema.json') ],
+  command: [ qapi_gen, '-o', 'qapi', '-b', '@INPUT0@', '-B', 'qapi.backend.QAPIRsBackend' ],
+  depend_files: [ qapi_inputs, qapi_gen_depends ])
diff --git a/rust/Cargo.lock b/rust/Cargo.lock
index c1075e11d6c..991533d92c1 100644
--- a/rust/Cargo.lock
+++ b/rust/Cargo.lock
@@ -447,6 +447,7 @@ dependencies = [
  "glib-sys",
  "libc",
  "serde",
+ "serde_derive",
 ]
 
 [[package]]
diff --git a/rust/util/Cargo.toml b/rust/util/Cargo.toml
index 554004816eb..9f6c52c5acd 100644
--- a/rust/util/Cargo.toml
+++ b/rust/util/Cargo.toml
@@ -18,6 +18,7 @@ foreign = { workspace = true }
 glib-sys = { workspace = true }
 libc = { workspace = true }
 serde = { workspace = true }
+serde_derive = { workspace = true }
 common = { path = "../common" }
 
 [lints]
diff --git a/rust/util/meson.build b/rust/util/meson.build
index 45366d03786..a2d0e6ded0d 100644
--- a/rust/util/meson.build
+++ b/rust/util/meson.build
@@ -50,7 +50,7 @@ _util_rs = static_library(
   dependencies: [anyhow_rs, libc_rs, foreign_rs, glib_sys_rs, common_rs, serde_rs, qom, qemuutil],
 )
 
-util_rs = declare_dependency(link_with: [_util_rs], dependencies: [qemuutil, qom])
+util_rs = declare_dependency(link_with: [_util_rs], dependencies: [])
 
 rust.test('rust-util-tests', _util_rs,
           dependencies: [qemuutil, qom],
@@ -64,3 +64,19 @@ rust.doctest('rust-util-rs-doctests',
      dependencies: util_rs,
      suite: ['doc', 'rust']
 )
+
+_qapi_cfg = run_command(rustc_args,
+  '--no-strict-cfg',
+  '--config-headers', config_host_h,
+  capture: true, check: true).stdout().strip().splitlines()
+
+_qapi_rs = static_library(
+  'qapi',
+  qapi_rs_files,
+  rust_args: _qapi_cfg,
+  override_options: ['rust_std=2021', 'build.rust_std=2021'],
+  rust_abi: 'rust',
+  dependencies: [common_rs, util_rs, serde_rs],
+)
+
+qapi_rs = declare_dependency(link_with: [_qapi_rs])
diff --git a/rust/util/src/qobject/mod.rs b/rust/util/src/qobject/mod.rs
index b6e86f11a64..f2618c86473 100644
--- a/rust/util/src/qobject/mod.rs
+++ b/rust/util/src/qobject/mod.rs
@@ -13,6 +13,7 @@
 mod serializer;
 
 use core::fmt::{self, Debug, Display};
+use foreign::prelude::*;
 use std::{
     cell::UnsafeCell,
     ffi::{c_char, CString},
@@ -104,6 +105,14 @@ fn refcnt(&self) -> &AtomicUsize {
         let qobj = self.0.get();
         unsafe { AtomicUsize::from_ptr(addr_of_mut!((*qobj).base.refcnt)) }
     }
+
+    pub fn to_json(&self) -> String {
+        let qobj = self.0.get();
+        unsafe {
+            let json = bindings::qobject_to_json(qobj);
+            glib_sys::g_string_free(json, glib_sys::GFALSE).into_native()
+        }
+    }
 }
 
 impl From<()> for QObject {
-- 
2.51.0


