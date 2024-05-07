Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF4FBC10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 07:21:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4F7K-0007fD-FT; Tue, 07 May 2024 03:20:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s4F7I-0007eL-Qh
 for qemu-devel@nongnu.org; Tue, 07 May 2024 03:20:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s4F7H-0004BD-1l
 for qemu-devel@nongnu.org; Tue, 07 May 2024 03:20:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715066398;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=84v/4qsjERWpXvEfekpOOvFOg4h6lGBG7/Q0iXd2pZ0=;
 b=OAZbY42KFVHuTWFAj5jgdkG2aDCVFt/sRiYVH2sshVe5HLAKz2BjyAWJtrFot3rZVd+LXA
 1nXEEs+xDF6IPvCVWbLXgqA6iwtZB7cAD9Bik9e8Nije3OmEIMiNn3b2dFNcX+9wU08wrF
 5GYkNuezutoq0GtgKD0K4FEKgdYQP6o=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-7utFJ_5wPKu1xwyrMPCK2w-1; Tue, 07 May 2024 03:19:56 -0400
X-MC-Unique: 7utFJ_5wPKu1xwyrMPCK2w-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a59eea00cafso21231866b.1
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 00:19:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715066394; x=1715671194;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=84v/4qsjERWpXvEfekpOOvFOg4h6lGBG7/Q0iXd2pZ0=;
 b=lNywd/nlDr6t0t8rhnftTVFP5KxRbrs6TfvpCUoieXW95WKYkzNkCKutFUr25D0c/t
 XsR6M01J2ZuVW5KTbGmesfmWKZxgzoLpBJBkozLVzLVDRUuXxd7EdxuCiLrCzABu7hAQ
 sx5EuDQPEaLVssWs+SnENWKRbyJXVSsX/AUHlfIA47a6utd0u89Q1F92CuYLEw0m+g0u
 DDwwv1jeACX3hH1ZVRl6ohQcoRp7v+390Vljf7Qg3UwpuOSnbBruVo/x0OB9SizbgQ2C
 KJ1GrirC1Ta1EpH3DUY2gqYhciIMswlDpBvqj2Tn7V2AzUV1Msl9c4AwR4iCK5Hlw1HM
 ZGSQ==
X-Gm-Message-State: AOJu0Yy5E4ddAWX4xp+f+sWfSbJG+O92CaIWvrk7q0sawUCNm9OjSVIA
 HBUHqW8oamDVugfH8yGaBUB8hqnkx+C7BCe80rAS7+RaKTSasSXncctRJ9PThIT3jtlKfKZE0Ny
 GkG1JgVFrH/l9mAwn3jt8FL7l+6QREbd1LGmGr+sHvBKM+3OWs6jZOmGwUobDiGtHocSy0z+ADF
 TnFwxvUbUI4aTA8meznNvCeeBhlyGEqzV0wPF3
X-Received: by 2002:a17:906:c00a:b0:a55:6602:e3a9 with SMTP id
 e10-20020a170906c00a00b00a556602e3a9mr10431821ejz.1.1715066394264; 
 Tue, 07 May 2024 00:19:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKRJWsSUBlg48vt91ws4tRQj8/goatk1U6Q1s+dCr8mB+FryijYhxcD4K9jTGI8iag5G4+/Q==
X-Received: by 2002:a17:906:c00a:b0:a55:6602:e3a9 with SMTP id
 e10-20020a170906c00a00b00a556602e3a9mr10431801ejz.1.1715066393819; 
 Tue, 07 May 2024 00:19:53 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 h12-20020a170906718c00b00a59a6026ee1sm4068876ejk.14.2024.05.07.00.19.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 00:19:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH 1/4] meson: remove system/internal distinction for libfdt
Date: Tue,  7 May 2024 09:19:45 +0200
Message-ID: <20240507071948.105022-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240507071948.105022-1-pbonzini@redhat.com>
References: <20240507071948.105022-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Treat libfdt like slirp and the other dependencies that use --enable-download;
remove the ability to force usage of the subproject.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                   | 69 +++++++++++++++--------------------
 meson_options.txt             |  6 +--
 scripts/meson-buildoptions.sh |  4 +-
 3 files changed, 34 insertions(+), 45 deletions(-)

diff --git a/meson.build b/meson.build
index 43da4923721..530f92c0a9c 100644
--- a/meson.build
+++ b/meson.build
@@ -1858,6 +1858,30 @@ if numa.found() and not cc.links('''
   endif
 endif
 
+fdt = not_found
+if get_option('fdt').disable_auto_if(not have_system).allowed()
+  fdt = cc.find_library('fdt', required: false)
+  if fdt.found()
+    if not cc.links('''
+      #include <libfdt.h>
+      #include <libfdt_env.h>
+      int main(void) { fdt_find_max_phandle(NULL, NULL); return 0; }''',
+        dependencies: fdt)
+      libfdt_proj = subproject('dtc', required: get_option('fdt'),
+                               default_options: ['tools=false',  'yaml=disabled',
+                                                 'python=disabled', 'default_library=static'])
+      fdt = libfdt_proj.get_variable('libfdt_dep')
+    endif
+    if not fdt.found()
+      if get_option('fdt').enabled()
+        error('libfdt found but too old (1.5.1 or newer required)')
+      else
+        warning('libfdt found but too old (1.5.1 or newer required)')
+      endif
+    endif
+  endif
+endif
+
 rdma = not_found
 if not get_option('rdma').auto() or have_system
   libumad = cc.find_library('ibumad', required: get_option('rdma'))
@@ -2199,6 +2223,7 @@ config_host_data.set('CONFIG_BSD', host_os in bsd_oses)
 config_host_data.set('CONFIG_CAPSTONE', capstone.found())
 config_host_data.set('CONFIG_COCOA', cocoa.found())
 config_host_data.set('CONFIG_DARWIN', host_os == 'darwin')
+config_host_data.set('CONFIG_FDT', fdt.found())
 config_host_data.set('CONFIG_FUZZ', get_option('fuzzing'))
 config_host_data.set('CONFIG_GCOV', get_option('b_coverage'))
 config_host_data.set('CONFIG_LIBUDEV', libudev.found())
@@ -3120,6 +3145,10 @@ genh += custom_target('config-poison.h',
                       command: [find_program('scripts/make-config-poison.sh'),
                                 target_configs_h])
 
+if fdt_required.length() > 0 and not fdt.found()
+  error('fdt disabled but required by targets ' + ', '.join(fdt_required))
+endif
+
 ###############
 # Subprojects #
 ###############
@@ -3130,44 +3159,6 @@ if have_system and vfio_user_server_allowed
   libvfio_user_dep = libvfio_user_proj.get_variable('libvfio_user_dep')
 endif
 
-fdt = not_found
-fdt_opt = get_option('fdt')
-if fdt_required.length() > 0 or fdt_opt == 'enabled'
-  if fdt_opt == 'disabled'
-    error('fdt disabled but required by targets ' + ', '.join(fdt_required))
-  endif
-
-  if fdt_opt in ['enabled', 'auto', 'system']
-    if get_option('wrap_mode') == 'nodownload'
-      fdt_opt = 'system'
-    endif
-    fdt = cc.find_library('fdt', required: fdt_opt == 'system')
-    if fdt.found() and cc.links('''
-       #include <libfdt.h>
-       #include <libfdt_env.h>
-       int main(void) { fdt_find_max_phandle(NULL, NULL); return 0; }''',
-         dependencies: fdt)
-      fdt_opt = 'system'
-    elif fdt_opt == 'system'
-       error('system libfdt requested, but it is too old (1.5.1 or newer required)')
-    else
-      fdt_opt = 'internal'
-      fdt = not_found
-    endif
-  endif
-  if not fdt.found()
-    assert(fdt_opt == 'internal')
-    libfdt_proj = subproject('dtc', required: true,
-                             default_options: ['tools=false',  'yaml=disabled',
-                                               'python=disabled', 'default_library=static'])
-    fdt = libfdt_proj.get_variable('libfdt_dep')
-  endif
-else
-  fdt_opt = 'disabled'
-endif
-
-config_host_data.set('CONFIG_FDT', fdt.found())
-
 vhost_user = not_found
 if host_os == 'linux' and have_vhost_user
   libvhost_user = subproject('libvhost-user')
@@ -4411,7 +4402,7 @@ summary_info += {'Linux AIO support': libaio}
 summary_info += {'Linux io_uring support': linux_io_uring}
 summary_info += {'ATTR/XATTR support': libattr}
 summary_info += {'RDMA support':      rdma}
-summary_info += {'fdt support':       fdt_opt == 'disabled' ? false : fdt_opt}
+summary_info += {'fdt support':       fdt}
 summary_info += {'libcap-ng support': libcap_ng}
 summary_info += {'bpf support':       libbpf}
 summary_info += {'rbd support':       rbd}
diff --git a/meson_options.txt b/meson_options.txt
index adc77bae0cd..90902c19d1c 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -308,9 +308,9 @@ option('vduse_blk_export', type: 'feature', value: 'auto',
 
 option('capstone', type: 'feature', value: 'auto',
        description: 'Whether and how to find the capstone library')
-option('fdt', type: 'combo', value: 'auto',
-       choices: ['disabled', 'enabled', 'auto', 'system', 'internal'],
-       description: 'Whether and how to find the libfdt library')
+option('fdt', type: 'feature', value: 'auto',
+       deprecated: { 'system': 'enabled' },
+       description: 'device tree support')
 
 option('selinux', type: 'feature', value: 'auto',
        description: 'SELinux support in qemu-nbd')
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 0a29d35fdb6..d816b35a2f4 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -33,8 +33,6 @@ meson_options_help() {
   printf "%s\n" '  --enable-debug-stack-usage'
   printf "%s\n" '                           measure coroutine stack usage'
   printf "%s\n" '  --enable-debug-tcg       TCG debugging'
-  printf "%s\n" '  --enable-fdt[=CHOICE]    Whether and how to find the libfdt library'
-  printf "%s\n" '                           (choices: auto/disabled/enabled/internal/system)'
   printf "%s\n" '  --enable-fuzzing         build fuzzing targets'
   printf "%s\n" '  --enable-gcov            Enable coverage tracking.'
   printf "%s\n" '  --enable-lto             Use link time optimization'
@@ -113,6 +111,7 @@ meson_options_help() {
   printf "%s\n" '  dmg             dmg image format support'
   printf "%s\n" '  docs            Documentations build support'
   printf "%s\n" '  dsound          DirectSound sound support'
+  printf "%s\n" '  fdt             device tree support'
   printf "%s\n" '  fuse            FUSE block device export'
   printf "%s\n" '  fuse-lseek      SEEK_HOLE/SEEK_DATA support for FUSE exports'
   printf "%s\n" '  gcrypt          libgcrypt cryptography support'
@@ -310,7 +309,6 @@ _meson_option_parse() {
     --disable-dsound) printf "%s" -Ddsound=disabled ;;
     --enable-fdt) printf "%s" -Dfdt=enabled ;;
     --disable-fdt) printf "%s" -Dfdt=disabled ;;
-    --enable-fdt=*) quote_sh "-Dfdt=$2" ;;
     --enable-fuse) printf "%s" -Dfuse=enabled ;;
     --disable-fuse) printf "%s" -Dfuse=disabled ;;
     --enable-fuse-lseek) printf "%s" -Dfuse_lseek=enabled ;;
-- 
2.45.0


