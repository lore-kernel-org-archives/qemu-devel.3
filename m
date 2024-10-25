Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BFA9D149C0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 16:07:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4Mnw-0004Re-IC; Fri, 25 Oct 2024 12:04:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t4Mnl-0003zV-MF
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 12:04:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t4Mni-0004x1-Nq
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 12:04:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729872274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5bGJBtVVkGQYWHGxYnD41tlCY5KrVJ/GvB7hkFSkEs4=;
 b=gqYWEywVtrHDG3I+h8ZKzUMxtdRLtQPAWkDDV5ocycCqskuuBrw+TRXMdvW/8gzwE6mYnp
 pXs6Gv+W/0iyP7ry2FAAKcE9iMXJvQ+U+43/q7mm6jZEFiBSFQa6+e5ZPFwRWSJpW4Auew
 OQ9SgxydYqcUyIpDvU8wZNWn/sR4XYs=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-0-3JnyTuNc63VAeNG7HVPg-1; Fri, 25 Oct 2024 12:04:31 -0400
X-MC-Unique: 0-3JnyTuNc63VAeNG7HVPg-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5c938ae4152so3691159a12.1
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 09:04:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729872269; x=1730477069;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5bGJBtVVkGQYWHGxYnD41tlCY5KrVJ/GvB7hkFSkEs4=;
 b=cx4Ky6XkMuS+TpGW2v7SBXvrRYu+ffmbz1M6uFnbWBZhBUDSXbLIoUYiFA79sLBkB0
 z36zlbfGpZTVMjAtk4jjT2hlcxhHnC4DmgJHU51ZnVQE6SWHMMWv5zUVJYR1Sp+qx+xN
 NY4CBtMFkhMH7PJQ8rx8cLzt4vMr0zCTQ5QZnxOFXktCZlb9ylqDtAkBueglHDdLeUcV
 vBHjcZ+b6RKxtcJfJuWABYyWQ6WJY+hIg9YM+s8DBBCMYwPP5t9Z3JITMV4LV4VH1r9Y
 SZ22OZKsZWcHm6kfsnPNdQyMamzwJ9J1LSHxv7dCol7IoQCD8Rs+ffV5GInlN6A90TiO
 yzTw==
X-Gm-Message-State: AOJu0YzXWVgjjRbB6fLU+drGNx26YhsrtTGcJx+PUb/pWSsnMs31MF99
 u024k1ussgbW+vkP2hSsIBHYbHG8VxAZpZMtbza+xupyRmabAtSWJ187hTuabAbNyi3RPFT57eo
 lmitF6fOdx5VXCrnbAuYZoizugetiWHOsFEmegKlpP2JU95gsZhsJCwjyUZbW1Cyl0FyNvOXgDj
 HlXNUqEY9JAfXPQxeq+Q2bBT5/LUorj8s/RaOpjCI=
X-Received: by 2002:a17:907:2d89:b0:a9a:dfa5:460e with SMTP id
 a640c23a62f3a-a9de3917fc6mr1934866b.34.1729872268843; 
 Fri, 25 Oct 2024 09:04:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG876xCoOxcgMaCnTKx/b1U91+hWy1WNVNj6Q3ISjbqAMuGa/ZbTGE5v2+cwFYjR4OgbSW7AQ==
X-Received: by 2002:a17:907:2d89:b0:a9a:dfa5:460e with SMTP id
 a640c23a62f3a-a9de3917fc6mr1930666b.34.1729872268302; 
 Fri, 25 Oct 2024 09:04:28 -0700 (PDT)
Received: from [192.168.10.47] ([151.81.112.43])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9b1f029617sm84911666b.81.2024.10.25.09.04.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2024 09:04:19 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: manos.pitsidianakis@linaro.org, zhao1.liu@intel.com,
 junjie.mao@hotmail.com, berrange@redhat.com
Subject: [PATCH 17/23] rust: clean up detection of the language
Date: Fri, 25 Oct 2024 18:02:02 +0200
Message-ID: <20241025160209.194307-18-pbonzini@redhat.com>
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

Disable the detection code altogether if have_system =3D=3D false.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 42 ++++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 20 deletions(-)

diff --git a/meson.build b/meson.build
index 69b8367eb3c..d199bcdd824 100644
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
2.47.0


