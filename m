Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5737DD1CDD0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 10:11:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3Bqb-0004uv-3h; Tue, 22 Oct 2024 06:10:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t3BqZ-0004uT-0W
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 06:10:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t3BqX-0004P4-8p
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 06:10:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729591836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8J+8xZYPHbr72c/IJr5xzYf68Dz55JZJUDo+rchRnfs=;
 b=BWafTN9ooCu3Q8HwEY3llSWVzmktRORBy9JuRoQG5KsX6vNVasabn+GSplXi4nazB/vOWz
 Ryp1KgecSWRdF2IX1CeWu268eFmyJ7DQNapqD+hbeF/lqdMZfdSgyLAVYeQTCgUkdQ+tUZ
 RzNXNc4I2QMmPHNL08d8Rc7/WKY3IVo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-fSTsnomuNvqtEb2DW1GSZA-1; Tue, 22 Oct 2024 06:10:35 -0400
X-MC-Unique: fSTsnomuNvqtEb2DW1GSZA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-37d49887a2cso3024973f8f.0
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 03:10:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729591833; x=1730196633;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8J+8xZYPHbr72c/IJr5xzYf68Dz55JZJUDo+rchRnfs=;
 b=Xqo7lzCHwB8R8I4Qwnp60oeIaUbOfaWjTv9iJOXNyywushUHvKpZBMrNLi3V0X5ne/
 6eqctI+qYOWQzCqv7sTTWOAC6hTd/rqOIKP+6m5q/GW6b58tWaOk7g9rGmq783PDfCRA
 uYwRhoD0p+VpXHGMVHkwTBNnpVudfS14EWzf4vguZwm7A/TfMxBe3Lkr9ianbTLAKB0D
 9aEooh8YcAg/Xz8vjf4LZL/+1FoGPAx/QiWaQWQBiihzbJ8zT2V+jFMyH4q8F9JcMGMD
 DKjgA6z/NEKNLzYN+nj1Ta6c9blzuEXK5Nek5PpQ/tUP1i7e8Vxa+wvvi7XUG9c4kx1v
 mrcw==
X-Gm-Message-State: AOJu0YzYpFEugLIFLLz73OQCoHyxSHa+YhYVUQCYyC/KDlrd9EQz7mka
 AzRhxCraQqLlkOW9ss5AZjsACJKoDAjnvKOM42IZXluTsPK8W9bh34JJXNKF3+KCm5PkblsQhgA
 e2IPJLsIKi524j+nYrSD9BgStI7AwvW8/yLEkF+M+OZlCxyF6xt/NWA8OjbEJKjceyvlGqmrICs
 DejmFVV4LyOFSothBYIC4GDt9laD1RkygUqnpyprc=
X-Received: by 2002:a05:6000:4388:b0:378:8b56:4665 with SMTP id
 ffacd0b85a97d-37ef12c8531mr1556434f8f.24.1729591833455; 
 Tue, 22 Oct 2024 03:10:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCu/q/XeHdz46UNT7zYQqEGMXcEYMCfCQgwfVFqVhd8DBg290J5LEF3gXAVmH5PiePmhyung==
X-Received: by 2002:a05:6000:4388:b0:378:8b56:4665 with SMTP id
 ffacd0b85a97d-37ef12c8531mr1556406f8f.24.1729591832855; 
 Tue, 22 Oct 2024 03:10:32 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ee0a4ac2esm6272449f8f.44.2024.10.22.03.10.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 03:10:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, kwolf@redhat.com, junjie.mao@hotmail.com,
 manos.pitsidianakis@linaro.org
Subject: [PATCH v2 09/14] rust: clean up detection of the language
Date: Tue, 22 Oct 2024 12:09:50 +0200
Message-ID: <20241022100956.196657-10-pbonzini@redhat.com>
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

Disable the detection code altogether if have_system =3D=3D false.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 42 ++++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 20 deletions(-)

diff --git a/meson.build b/meson.build
index fe72f9951ca..e411a8ae567 100644
--- a/meson.build
+++ b/meson.build
@@ -53,6 +53,17 @@ cpu =3D host_machine.cpu_family()
=20
 target_dirs =3D config_host['TARGET_DIRS'].split()
=20
+# type of binaries to build
+have_linux_user =3D false
+have_bsd_user =3D false
+have_system =3D false
+foreach target : target_dirs
+  have_linux_user =3D have_linux_user or target.endswith('linux-user')
+  have_bsd_user =3D have_bsd_user or target.endswith('bsd-user')
+  have_system =3D have_system or target.endswith('-softmmu')
+endforeach
+have_user =3D have_linux_user or have_bsd_user
+
 ############
 # Programs #
 ############
@@ -71,11 +82,13 @@ if host_os =3D=3D 'darwin' and \
   all_languages +=3D ['objc']
   objc =3D meson.get_compiler('objc')
 endif
-have_rust =3D false
-if not get_option('rust').disabled() and add_languages('rust', required: g=
et_option('rust'), native: false) \
-    and add_languages('rust', required: get_option('rust'), native: true)
+
+have_rust =3D add_languages('rust', native: false,
+    required: get_option('rust').disable_auto_if(not have_system))
+have_rust =3D have_rust and add_languages('rust', native: true,
+    required: get_option('rust').disable_auto_if(not have_system))
+if have_rust
   rustc =3D meson.get_compiler('rust')
-  have_rust =3D true
   if rustc.version().version_compare('<1.80.0')
     if get_option('rust').enabled()
       error('rustc version ' + rustc.version() + ' is unsupported: Please =
upgrade to at least 1.80.0')
@@ -186,17 +199,6 @@ have_vhost_net_vdpa =3D have_vhost_vdpa and get_option=
('vhost_net').allowed()
 have_vhost_net_kernel =3D have_vhost_kernel and get_option('vhost_net').al=
lowed()
 have_vhost_net =3D have_vhost_net_kernel or have_vhost_net_user or have_vh=
ost_net_vdpa
=20
-# type of binaries to build
-have_linux_user =3D false
-have_bsd_user =3D false
-have_system =3D false
-foreach target : target_dirs
-  have_linux_user =3D have_linux_user or target.endswith('linux-user')
-  have_bsd_user =3D have_bsd_user or target.endswith('bsd-user')
-  have_system =3D have_system or target.endswith('-softmmu')
-endforeach
-have_user =3D have_linux_user or have_bsd_user
-
 have_tools =3D get_option('tools') \
   .disable_auto_if(not have_system) \
   .allowed()
@@ -3317,7 +3319,7 @@ endif
=20
 genh +=3D configure_file(output: 'config-host.h', configuration: config_ho=
st_data)
=20
-if have_rust and have_system
+if have_rust
   rustc_args =3D run_command(
     find_program('scripts/rust/rustc_args.py'),
     '--config-headers', meson.project_build_root() / 'config-host.h',
@@ -3937,7 +3939,7 @@ common_all =3D static_library('common',
                             implicit_include_directories: false,
                             dependencies: common_ss.all_dependencies())
=20
-if have_rust and have_system
+if have_rust
   bindgen_args =3D [
     '--disable-header-comment',
     '--raw-line', '// @generated',
@@ -4091,7 +4093,7 @@ foreach target : target_dirs
   arch_srcs +=3D target_specific.sources()
   arch_deps +=3D target_specific.dependencies()
=20
-  if have_rust and have_system
+  if have_rust and target_type =3D=3D 'system'
     target_rust =3D rust_devices_ss.apply(config_target, strict: false)
     crates =3D []
     foreach dep : target_rust.dependencies()
@@ -4453,9 +4455,9 @@ else
 endif
 summary_info +=3D {'Rust support':      have_rust}
 if have_rust
-  summary_info +=3D {'rustc version':   rustc.version()}
-  summary_info +=3D {'rustc':           ' '.join(rustc.cmd_array())}
   summary_info +=3D {'Rust target':     config_host['RUST_TARGET_TRIPLE']}
+  summary_info +=3D {'rustc':           ' '.join(rustc.cmd_array())}
+  summary_info +=3D {'rustc version':   rustc.version()}
 endif
 option_cflags =3D (get_option('debug') ? ['-g'] : [])
 if get_option('optimization') !=3D 'plain'
--=20
2.46.2


