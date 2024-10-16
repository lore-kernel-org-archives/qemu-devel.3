Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72474D2A52F
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 16:36:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t16zU-0004d4-Qp; Wed, 16 Oct 2024 12:35:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <htafreit@gmail.com>)
 id 1t16zS-0004cI-VE
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 12:35:15 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <htafreit@gmail.com>)
 id 1t16zP-0008PL-8z
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 12:35:13 -0400
Received: by mail-pl1-x643.google.com with SMTP id
 d9443c01a7336-20c7b9087c4so2555ad.1
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2024 09:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729096509; x=1729701309; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ViGrz5nUjbs6rlMPNsWvSWD1kV9WAHQo5K8DMRq96dg=;
 b=kV3vajv4uQREBnHdDUi3ULpsgzuIPXU2cKjZgVSHWOlBl/ts1Ij8cthGG3WVFups3h
 R0TvpJOyehCsvhppFjLlYHfuF4Pugc1UW8Qv1l+BiSLOm6UAyQXLZQ3SQZe/rio4K2B/
 MagyWi3gPLyL+JH58E6RpHdWzVYxYgcxQsEwfA0RALwVZfqnTlynpKIMmTZGFdMiNLp0
 ceBygw/D4/KEEkGgmJGM5vpw8pz3fRxKD1T+CVnrQKzrhh4vR3lUDlBCa4zExfkOCnc6
 LhSgB4/Bq4nyAD9urM2MtpwWd+N8CKqyfyTXk3OZSv7ZV+svLrkVaqcBWVHgu/Lt2otT
 MK5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729096509; x=1729701309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ViGrz5nUjbs6rlMPNsWvSWD1kV9WAHQo5K8DMRq96dg=;
 b=f8tVRStNEgLi+0HRo4Pwgs8KCHtqfPNxwadtIm0oAFBuMAA87cqgEBwOPVcj27drkM
 UIEO5ZL33gAPNUrWg8sYz8CEYcxcVbA2zp2RIvUv01oGTbfi4hKTnsjo+ghfvuoxgHUT
 qGGFRerQQs2WaxwFRs7+UNT017AO4WG4LK3lVgKrkjW1iUWlTJZ9RkBIAFtY9SN0EIXy
 4Ap6iCEfCiRYZxFspKFOBwSHAGuvUMbMi/jRD/6l6m0wE5dlb4KO6PPDO0V8hL2gJWCZ
 vbeBVIY424bvNQ7/TmHXLBspMYD/0FhpRg/bKQc3m/K6FI7YxuSihnmErxZD66jmsH2A
 Oyng==
X-Gm-Message-State: AOJu0Yz1QAJV1BNG+w/PbNkvzQjTFkE0c4rVRw/4qMvzC3Ik7M9oaoZI
 B7q65gjLHWtmwgzM170hlRks5dlCBlwBs4Z5qCZsIU7uoweFBAWqbBZqr65hoNY=
X-Google-Smtp-Source: AGHT+IEgZgCN1luTUktnzUaujt8joRWXeqw3bG4e3vrbLG7gWvIj19KpHbmhm+rB+TuoKgBLh8tzvQ==
X-Received: by 2002:a17:902:e74b:b0:20c:bb35:dae5 with SMTP id
 d9443c01a7336-20d2fe21712mr19209815ad.11.1729096509053; 
 Wed, 16 Oct 2024 09:35:09 -0700 (PDT)
Received: from ubuntu.hitronhub.home ([2804:14c:43:29c4:2cae:c0ff:fe0e:9152])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20d17f84d8fsm30613485ad.20.2024.10.16.09.35.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2024 09:35:08 -0700 (PDT)
From: htafr <htafreit@gmail.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	htafr <htafreit@gmail.com>
Subject: [PATCH 1/1] libspdm: insert LibSPDM as subproject
Date: Wed, 16 Oct 2024 13:34:39 -0300
Message-ID: <20241016163439.1130168-2-htafreit@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241016163439.1130168-1-htafreit@gmail.com>
References: <20241016163439.1130168-1-htafreit@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=htafreit@gmail.com; helo=mail-pl1-x643.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: htafr <htafreit@gmail.com>
---
 .gitmodules                   |  3 ++
 Kconfig.host                  |  3 ++
 meson.build                   | 84 +++++++++++++++++++++++++++++++++++
 meson_options.txt             |  8 ++++
 scripts/make-config-poison.sh | 19 ++++----
 scripts/meson-buildoptions.sh |  9 ++++
 6 files changed, 117 insertions(+), 9 deletions(-)

diff --git a/.gitmodules b/.gitmodules
index 73cae4cd4d..1bf93427ad 100644
--- a/.gitmodules
+++ b/.gitmodules
@@ -43,3 +43,6 @@
 [submodule "tests/lcitool/libvirt-ci"]
 	path = tests/lcitool/libvirt-ci
 	url = https://gitlab.com/libvirt/libvirt-ci.git
+[submodule "subprojects/libspdm"]
+	path = subprojects/libspdm
+	url = https://github.com/DMTF/libspdm.git
diff --git a/Kconfig.host b/Kconfig.host
index 4ade7899d6..80bde9eb3d 100644
--- a/Kconfig.host
+++ b/Kconfig.host
@@ -23,6 +23,9 @@ config IVSHMEM
 config TPM
     bool
 
+config SPDM
+    bool
+
 config FDT
     bool
 
diff --git a/meson.build b/meson.build
index d26690ce20..40bef9a5cc 100644
--- a/meson.build
+++ b/meson.build
@@ -17,6 +17,7 @@ not_found = dependency('', required: false)
 keyval = import('keyval')
 ss = import('sourceset')
 fs = import('fs')
+cmake = import('cmake')
 
 host_os = host_machine.system()
 config_host = keyval.load(meson.current_build_dir() / 'config-host.mak')
@@ -163,6 +164,10 @@ have_tpm = get_option('tpm') \
   .require(host_os != 'windows', error_message: 'TPM emulation only available on POSIX systems') \
   .allowed()
 
+have_libspdm = get_option('libspdm') \
+  .require(host_os == 'linux', error_message: 'LibSPDM is supported only on Linux') \
+  .allowed()
+
 # vhost
 have_vhost_user = get_option('vhost_user') \
   .disable_auto_if(host_os != 'linux') \
@@ -280,6 +285,65 @@ if host_os != 'darwin'
   modular_tcg = ['i386-softmmu', 'x86_64-softmmu']
 endif
 
+libspdm_dep_targets = [
+  'debuglib',
+  'malloclib',
+  'memlib',
+  'platform_lib',
+  'rnglib',
+  'spdm_cert_verify_callback_sample',
+  'spdm_common_lib',
+  'spdm_crypt_ext_lib',
+  'spdm_crypt_lib',
+  'spdm_device_secret_lib_sample',
+  'spdm_requester_lib',
+  'spdm_responder_lib',
+  'spdm_secured_message_lib',
+  'spdm_transport_mctp_lib',
+  'spdm_transport_pcidoe_lib',
+  ]
+
+if cpu not in supported_cpus
+  libspdm_host_arch = 'unknown'
+  message(f'LibSPDM will not compile with CMake defines: -DARCH=@libspdm_host_arch@')
+elif cpu == 'x86_64'
+  libspdm_host_arch = 'x64'
+elif cpu == 'x86'
+  libspdm_host_arch = 'ia32'
+elif cpu == 'arm'
+  libspdm_host_arch = 'arm'
+elif cpu == 'aarch64'
+  libspdm_host_arch = 'aarch64'
+else
+  libspdm_host_arch = cpu
+endif
+
+if get_option('debug')
+  libspdm_target = 'Debug'
+else 
+  libspdm_target = 'Release'
+endif
+
+if get_option('libspdm-crypto') == 'openssl'
+  libspdm_dep_targets += [
+    'cryptlib_openssl',
+    'openssllib',
+  ]
+elif get_option('libspdm-crypto') == 'mbedtls'
+  libspdm_dep_targets += [
+    'cryptlib_mbedtls',
+    'mbedcrypto',
+    'mbedtls',
+    'mbedx509',
+  ]
+endif
+
+if get_option('b_coverage')
+  libspdm_gcov = 'ON'
+else 
+  libspdm_gcov = 'OFF'
+endif
+
 ##################
 # Compiler flags #
 ##################
@@ -2409,6 +2473,7 @@ if get_option('tcg').allowed()
   config_host_data.set('CONFIG_TCG', 1)
   config_host_data.set('CONFIG_TCG_INTERPRETER', tcg_arch == 'tci')
 endif
+config_host_data.set('CONFIG_LIBSPDM', have_libspdm)
 config_host_data.set('CONFIG_TPM', have_tpm)
 config_host_data.set('CONFIG_TSAN', get_option('tsan'))
 config_host_data.set('CONFIG_USB_LIBUSB', libusb.found())
@@ -3310,6 +3375,23 @@ if have_libvduse
   libvduse = libvduse_proj.get_variable('libvduse_dep')
 endif
 
+spdm = []
+if have_libspdm
+  libspdm_opt = cmake.subproject_options()
+  libspdm_opt.add_cmake_defines({'ARCH': libspdm_host_arch, \
+                                 'TOOLCHAIN': get_option('libspdm-toolchain'), \
+                                 'TARGET': libspdm_target, \
+                                 'CRYPTO': get_option('libspdm-crypto'), \
+                                 'DISABLE_TESTS': 1, \
+                                 'GCOV': libspdm_gcov, \
+                                 'BUILD_LINUX_SHARED_LIB': 'ON'})
+  libspdm_proj = cmake.subproject('libspdm', options: libspdm_opt)
+
+  foreach dep : libspdm_dep_targets
+    spdm += libspdm_proj.dependency(dep)
+  endforeach
+endif
+
 #####################
 # Generated sources #
 #####################
@@ -3892,6 +3974,7 @@ common_ss.add(hwcore)
 ###########
 
 system_ss.add(authz, blockdev, chardev, crypto, io, qmp)
+system_ss.add(when: spdm, if_true: spdm)
 common_ss.add(qom, qemuutil)
 
 common_ss.add_all(when: 'CONFIG_SYSTEM_ONLY', if_true: [system_ss])
@@ -4574,6 +4657,7 @@ summary_info += {'AF_ALG support':    have_afalg}
 summary_info += {'rng-none':          get_option('rng_none')}
 summary_info += {'Linux keyring':     have_keyring}
 summary_info += {'Linux keyutils':    keyutils}
+summary_info += {'LibSPDM algorithm': get_option('libspdm-crypto')}
 summary(summary_info, bool_yn: true, section: 'Crypto')
 
 # UI
diff --git a/meson_options.txt b/meson_options.txt
index 0ee4d7bb86..e991109048 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -376,3 +376,11 @@ option('x86_version', type : 'combo', choices : ['0', '1', '2', '3', '4'], value
 
 option('rust', type: 'feature', value: 'disabled',
        description: 'Rust support')
+
+option('libspdm', type: 'feature', value: 'disabled',
+  description: 'LibSPDM support')
+option('libspdm-crypto', type: 'combo', value: 'mbedtls',
+  choices: ['mbedtls', 'openssl'],
+  description: 'set LibSPDM crypto algorithm')
+option('libspdm-toolchain', type: 'string', value: 'GCC',
+  description: 'toolchain to use for LibSPDM compilation')
diff --git a/scripts/make-config-poison.sh b/scripts/make-config-poison.sh
index 2b36907e23..d4582007da 100755
--- a/scripts/make-config-poison.sh
+++ b/scripts/make-config-poison.sh
@@ -1,17 +1,18 @@
 #! /bin/sh
 
 if test $# = 0; then
-  exit 0
+    exit 0
 fi
 
 # Create list of config switches that should be poisoned in common code,
 # but filter out several which are handled manually.
 exec sed -n \
-  -e' /CONFIG_TCG/d' \
-  -e '/CONFIG_USER_ONLY/d' \
-  -e '/CONFIG_SOFTMMU/d' \
-  -e '/^#define / {' \
-  -e    's///' \
-  -e    's/ .*//' \
-  -e    's/^/#pragma GCC poison /p' \
-  -e '}' "$@" | sort -u
+    -e' /CONFIG_TCG/d' \
+    -e '/CONFIG_USER_ONLY/d' \
+    -e '/CONFIG_SOFTMMU/d' \
+    -e '/CONFIG_SPDM/d' \
+    -e '/^#define / {' \
+    -e 's///' \
+    -e 's/ .*//' \
+    -e 's/^/#pragma GCC poison /p' \
+    -e '}' "$@" | sort -u
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 6d08605b77..115113fdf4 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -62,6 +62,10 @@ meson_options_help() {
   printf "%s\n" '                           cpu name [/usr/gnemul/qemu-%M]'
   printf "%s\n" '  --libdir=VALUE           Library directory [system default]'
   printf "%s\n" '  --libexecdir=VALUE       Library executable directory [libexec]'
+  printf "%s\n" '  --libspdm-crypto=CHOICE  set LibSPDM crypto algorithm [mbedtls] (choices:'
+  printf "%s\n" '                           mbedtls/openssl)'
+  printf "%s\n" '  --libspdm-toolchain=VALUE'
+  printf "%s\n" '                           toolchain to use for LibSPDM compilation [GCC]'
   printf "%s\n" '  --localedir=VALUE        Locale data directory [share/locale]'
   printf "%s\n" '  --localstatedir=VALUE    Localstate data directory [/var/local]'
   printf "%s\n" '  --mandir=VALUE           Manual page directory [share/man]'
@@ -139,6 +143,7 @@ meson_options_help() {
   printf "%s\n" '  libkeyutils     Linux keyutils support'
   printf "%s\n" '  libnfs          libnfs block device driver'
   printf "%s\n" '  libpmem         libpmem support'
+  printf "%s\n" '  libspdm         LibSPDM support'
   printf "%s\n" '  libssh          ssh block device support'
   printf "%s\n" '  libudev         Use libudev to enumerate host devices'
   printf "%s\n" '  libusb          libusb support for USB passthrough'
@@ -372,6 +377,10 @@ _meson_option_parse() {
     --disable-libnfs) printf "%s" -Dlibnfs=disabled ;;
     --enable-libpmem) printf "%s" -Dlibpmem=enabled ;;
     --disable-libpmem) printf "%s" -Dlibpmem=disabled ;;
+    --enable-libspdm) printf "%s" -Dlibspdm=enabled ;;
+    --disable-libspdm) printf "%s" -Dlibspdm=disabled ;;
+    --libspdm-crypto=*) quote_sh "-Dlibspdm-crypto=$2" ;;
+    --libspdm-toolchain=*) quote_sh "-Dlibspdm-toolchain=$2" ;;
     --enable-libssh) printf "%s" -Dlibssh=enabled ;;
     --disable-libssh) printf "%s" -Dlibssh=disabled ;;
     --enable-libudev) printf "%s" -Dlibudev=enabled ;;
-- 
2.43.0


