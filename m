Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07EC1D1BDD3
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 17:34:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t80sg-0007Ij-VF; Mon, 04 Nov 2024 12:28:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t80se-00073J-PY
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:28:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t80sc-0000Qk-CG
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:28:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730741321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+15v7Qrucllbz0DgQ1LDJqDSgy9GhWKZdsSY2VjeTjI=;
 b=IXN0uX9dNEvD2jOxT2I2jlb3mlMTFB6u9abTQbQ1ycfCzbHtbX4nBBZ4bdKIuC9TvN5fI1
 dKrhmdvLtyR3vKKKBiKVkrXN7ZaUGLzOh5Z+KD78cPCqC47jQYVBJe2s5CUwhhUoaUtSQh
 iGrlsGPmok9wstfo1i1vEUtp2+0O1UE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-5cGXQCyaPZeqyfsDxwnVZA-1; Mon, 04 Nov 2024 12:28:40 -0500
X-MC-Unique: 5cGXQCyaPZeqyfsDxwnVZA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-37d49887a2cso2359475f8f.0
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 09:28:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730741318; x=1731346118;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+15v7Qrucllbz0DgQ1LDJqDSgy9GhWKZdsSY2VjeTjI=;
 b=G4J6rhlchzsgmRFo8QMR3/JbdmvLVFZTc1ayHE4jv7d1VAbU06nGA+2Jq2E46w/g4u
 k0utAqoqr1iY3nR2o+xOd9oJblEOqyfmJitXs/mwlHW9/Dk4EoV8LqP2vnb9BRTABtFu
 41kctfhbBwB8xcRe6W3kdKklrs/s+IBfaXjQ3pdXTiGFhSFoEiLqO4zQCRHzqfKvSY4O
 7QvQAT1ZOqOnUT2lTxLPgHi9rauvOUGkICRJtLyZQWU+F1S02etSuVh+Q5/mF4TUepDJ
 9xptT1EbZTvHaznEUTfCJ27kT9p8IGZsfIprBQIhtl9FdU9+S9dMX0n4irm+hFPTqpfd
 ljDQ==
X-Gm-Message-State: AOJu0YzSICaNAzgUALP4Bo+8b4mg2pGRal2RPjeB50wH91v2WQRxjSsL
 +D4sAXlzeRELAK3C7Od+sXnkm+fsh5cMWH073VKOPrDPFP3DkFKl2lc2a1Z7D2mk154rgbwa3YO
 jTooBVrN2T/yEy0jtvg4OYp8RgEFAQ2CJe5wkUbDnt9M3+ZD4BB0knu2XEdKan+/sGZYAY9vlnC
 aqx+SP/f/DTSYa08Hj+UlpR9lrIycaqPhYY47lPF0=
X-Received: by 2002:a05:6000:4013:b0:37d:39ff:a9cf with SMTP id
 ffacd0b85a97d-381c7967346mr9277967f8f.5.1730741317810; 
 Mon, 04 Nov 2024 09:28:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFv88MBT4vDsy6UijKzdu367JhoQS8rp5XfdbtWrWKNORzDhBFNSveZwYoR62ROS7pGRONGLg==
X-Received: by 2002:a05:6000:4013:b0:37d:39ff:a9cf with SMTP id
 ffacd0b85a97d-381c7967346mr9277953f8f.5.1730741317402; 
 Mon, 04 Nov 2024 09:28:37 -0800 (PST)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4327d5e7c9asm164887845e9.21.2024.11.04.09.28.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 09:28:36 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 34/40] rust: clean up detection of the language
Date: Mon,  4 Nov 2024 18:27:13 +0100
Message-ID: <20241104172721.180255-35-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241104172721.180255-1-pbonzini@redhat.com>
References: <20241104172721.180255-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Disable the detection code altogether if have_system == false.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 42 ++++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 20 deletions(-)

diff --git a/meson.build b/meson.build
index 2f7e0550105..eb5660a0836 100644
--- a/meson.build
+++ b/meson.build
@@ -53,6 +53,17 @@ cpu = host_machine.cpu_family()
 
 target_dirs = config_host['TARGET_DIRS'].split()
 
+# type of binaries to build
+have_linux_user = false
+have_bsd_user = false
+have_system = false
+foreach target : target_dirs
+  have_linux_user = have_linux_user or target.endswith('linux-user')
+  have_bsd_user = have_bsd_user or target.endswith('bsd-user')
+  have_system = have_system or target.endswith('-softmmu')
+endforeach
+have_user = have_linux_user or have_bsd_user
+
 ############
 # Programs #
 ############
@@ -71,11 +82,13 @@ if host_os == 'darwin' and \
   all_languages += ['objc']
   objc = meson.get_compiler('objc')
 endif
-have_rust = false
-if not get_option('rust').disabled() and add_languages('rust', required: get_option('rust'), native: false) \
-    and add_languages('rust', required: get_option('rust'), native: true)
+
+have_rust = add_languages('rust', native: false,
+    required: get_option('rust').disable_auto_if(not have_system))
+have_rust = have_rust and add_languages('rust', native: true,
+    required: get_option('rust').disable_auto_if(not have_system))
+if have_rust
   rustc = meson.get_compiler('rust')
-  have_rust = true
   if rustc.version().version_compare('<1.80.0')
     if get_option('rust').enabled()
       error('rustc version ' + rustc.version() + ' is unsupported: Please upgrade to at least 1.80.0')
@@ -186,17 +199,6 @@ have_vhost_net_vdpa = have_vhost_vdpa and get_option('vhost_net').allowed()
 have_vhost_net_kernel = have_vhost_kernel and get_option('vhost_net').allowed()
 have_vhost_net = have_vhost_net_kernel or have_vhost_net_user or have_vhost_net_vdpa
 
-# type of binaries to build
-have_linux_user = false
-have_bsd_user = false
-have_system = false
-foreach target : target_dirs
-  have_linux_user = have_linux_user or target.endswith('linux-user')
-  have_bsd_user = have_bsd_user or target.endswith('bsd-user')
-  have_system = have_system or target.endswith('-softmmu')
-endforeach
-have_user = have_linux_user or have_bsd_user
-
 have_tools = get_option('tools') \
   .disable_auto_if(not have_system) \
   .allowed()
@@ -3331,7 +3333,7 @@ endif
 
 genh += configure_file(output: 'config-host.h', configuration: config_host_data)
 
-if have_rust and have_system
+if have_rust
   rustc_args = run_command(
     find_program('scripts/rust/rustc_args.py'),
     '--config-headers', meson.project_build_root() / 'config-host.h',
@@ -3951,7 +3953,7 @@ common_all = static_library('common',
                             implicit_include_directories: false,
                             dependencies: common_ss.all_dependencies())
 
-if have_rust and have_system
+if have_rust
   bindgen_args = [
     '--disable-header-comment',
     '--raw-line', '// @generated',
@@ -4105,7 +4107,7 @@ foreach target : target_dirs
   arch_srcs += target_specific.sources()
   arch_deps += target_specific.dependencies()
 
-  if have_rust and have_system
+  if have_rust and target_type == 'system'
     target_rust = rust_devices_ss.apply(config_target, strict: false)
     crates = []
     foreach dep : target_rust.dependencies()
@@ -4467,9 +4469,9 @@ else
 endif
 summary_info += {'Rust support':      have_rust}
 if have_rust
-  summary_info += {'rustc version':   rustc.version()}
-  summary_info += {'rustc':           ' '.join(rustc.cmd_array())}
   summary_info += {'Rust target':     config_host['RUST_TARGET_TRIPLE']}
+  summary_info += {'rustc':           ' '.join(rustc.cmd_array())}
+  summary_info += {'rustc version':   rustc.version()}
 endif
 option_cflags = (get_option('debug') ? ['-g'] : [])
 if get_option('optimization') != 'plain'
-- 
2.47.0


