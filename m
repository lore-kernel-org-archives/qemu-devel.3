Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD5BEC3ABC0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 09:51:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCxu5-00017T-KT; Thu, 08 May 2025 05:51:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCxu4-00017G-GS
 for qemu-devel@nongnu.org; Thu, 08 May 2025 05:50:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCxu2-0000ru-Si
 for qemu-devel@nongnu.org; Thu, 08 May 2025 05:50:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746697854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=HTk+mYRT1LOI3F73W9QdnR3cHVo2iSCIf5Ka5QX5+NE=;
 b=MBBwG1kR+6rs7pIevcdxt8xyCmQJdS/asV51pPQ2ICcVTHYcpPuepekdOPXTTPVvLsumRx
 ul9+SM2rGN5tN2Bnmr5QFwAulkEUhWvWqRNX5J0e9vc/7cQdsYaTNdjZ0U2hNuibUWpzwA
 IlhV7ta7tX3l4s0sqF1zqrvg82E8Gy8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-K2Fytz7ROl-WrT-O9do93Q-1; Thu, 08 May 2025 05:50:50 -0400
X-MC-Unique: K2Fytz7ROl-WrT-O9do93Q-1
X-Mimecast-MFC-AGG-ID: K2Fytz7ROl-WrT-O9do93Q_1746697847
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43cf5196c25so3846685e9.0
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 02:50:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746697846; x=1747302646;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HTk+mYRT1LOI3F73W9QdnR3cHVo2iSCIf5Ka5QX5+NE=;
 b=m23SNmQxwCCZDxVrljKqykqNKp3p3nZDuplcm/PyTb9YH2t0GvBxleCayHMx0iJfuU
 c7TUXHssO34ftkLT8YBZHStXrBS9WvosCYm++PT63CN0+8q8TU4BRkSGcu9LMdtMPfsY
 BHSCFTbn8NHUknLuGdlrkYTt2w8jC1deH5lxBJ+rzd0Y4h1clbaztEJPjrtWVTJE+4aw
 bF8shMnDZ26020iWCSO58C0zFYvFpOqRCmrWFhMBqDXBTdjra5xnR70P3WCZPQZ3IdBc
 dk7d+9tpkjNZ2zSqs0pRH1xL5wtrvTfrK1Hs5KX2uHB9DVB3IpNSGfxqlLI4reaTrN3i
 2V9w==
X-Gm-Message-State: AOJu0Yyh+cRKzYsnwoCIr4Ucnm2XSomD0UFzHPfW4D6QOV6fbAaXfH++
 yHPpV5zx6xs+lLl/OoJqSVAs076UEN5os/fZrrETkoZ7jg9KRaJ4auYYBd/V/o6pbiXP4mAp9Xp
 I+EY6JkTk6DMr+45+0nBR84Ob6AMBBWLj7UsKdoJ8toPvTrxU6ZabMa7/pr4ihZmqvxAIMndq4P
 wUnoLslj18QWWOXNty2R1oeV4+E1LZweHVeyzH
X-Gm-Gg: ASbGncv4i08jwmI2ZMOH7/SRn/d3/+abTnGtTdHZsVNsKQu3aHlQVZM0URavv7mXGnh
 04bqKOsJcZQTYOo2f5iiYO336VcKOM6IY5UO/4DmDxOFl45w4VG4eLy7Sxt+y9Fib0v7fonoByu
 MGpBoAfdaWS9x7Lb2zTvzt6dGHalIDGfExEcmZSzSL/1iMsSVKFtHwAl8N5CcY9m/t0gLPq9M8p
 Z+8qX6YMN0DUDx94hD4cOLkGC5Uc6m5IGusZYbT/mfJg8ur3EGuS+vWK8WVV5E+ejRXyxwwIfcr
 EfPHsKSYfRPQoo0=
X-Received: by 2002:a05:600c:1388:b0:43d:82c:2b11 with SMTP id
 5b1f17b1804b1-442d034ad8fmr19939855e9.23.1746697845971; 
 Thu, 08 May 2025 02:50:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzo0RIDtJUaWqtHso+WomOzt1FM61yLAQYcNq0djCpssxjbDSJ+IoSAOdShH3eXoSS0vX3iA==
X-Received: by 2002:a05:600c:1388:b0:43d:82c:2b11 with SMTP id
 5b1f17b1804b1-442d034ad8fmr19939635e9.23.1746697845521; 
 Thu, 08 May 2025 02:50:45 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442cd3b7f18sm32296855e9.40.2025.05.08.02.50.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 May 2025 02:50:44 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] meson: drop --enable-avx* options
Date: Thu,  8 May 2025 11:50:43 +0200
Message-ID: <20250508095044.468069-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Just detect compiler support and always enable the optimizations if
it is avilable; warn if the user did request AVX2/AVX512 use via
-Dx86_version= but the intrinsics are not available.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                   | 30 +++++++++++++++++++-----------
 meson_options.txt             |  4 ----
 scripts/meson-buildoptions.sh |  6 ------
 3 files changed, 19 insertions(+), 21 deletions(-)

diff --git a/meson.build b/meson.build
index 27f11501528..6923f94b856 100644
--- a/meson.build
+++ b/meson.build
@@ -3097,22 +3097,16 @@ config_host_data.set('CONFIG_ASM_HWPROBE_H',
                      cc.has_header_symbol('asm/hwprobe.h',
                                           'RISCV_HWPROBE_EXT_ZBA'))
 
-config_host_data.set('CONFIG_AVX2_OPT', get_option('avx2') \
-  .require(have_cpuid_h, error_message: 'cpuid.h not available, cannot enable AVX2') \
-  .require(cc.links('''
-    #include <cpuid.h>
+if have_cpuid_h
+  have_avx2 = cc.links('''
     #include <immintrin.h>
     static int __attribute__((target("avx2"))) bar(void *a) {
       __m256i x = *(__m256i *)a;
       return _mm256_testz_si256(x, x);
     }
     int main(int argc, char *argv[]) { return bar(argv[argc - 1]); }
-  '''), error_message: 'AVX2 not available').allowed())
-
-config_host_data.set('CONFIG_AVX512BW_OPT', get_option('avx512bw') \
-  .require(have_cpuid_h, error_message: 'cpuid.h not available, cannot enable AVX512BW') \
-  .require(cc.links('''
-    #include <cpuid.h>
+  ''')
+  have_avx512bw = cc.links('''
     #include <immintrin.h>
     static int __attribute__((target("avx512bw"))) bar(void *a) {
       __m512i *x = a;
@@ -3120,7 +3114,21 @@ config_host_data.set('CONFIG_AVX512BW_OPT', get_option('avx512bw') \
       return res[1];
     }
     int main(int argc, char *argv[]) { return bar(argv[0]); }
-  '''), error_message: 'AVX512BW not available').allowed())
+  ''')
+  if get_option('x86_version') >= '3' and not have_avx2
+    warning('Cannot enable AVX optimizations due to missing intrinsics')
+  elif get_option('x86_version') >= '4' and not have_avx512bw
+    warning('Cannot enable AVX512 optimizations due to missing intrinsics')
+  endif
+else
+  have_avx2 = false
+  have_avx512bw = false
+  if get_option('x86_version') >= '3'
+    warning('Cannot enable AVX optimizations due to missing cpuid.h')
+  endif
+endif
+config_host_data.set('CONFIG_AVX2_OPT', have_avx2)
+config_host_data.set('CONFIG_AVX512BW_OPT', have_avx512bw)
 
 # For both AArch64 and AArch32, detect if builtins are available.
 config_host_data.set('CONFIG_ARM_AES_BUILTIN', cc.compiles('''
diff --git a/meson_options.txt b/meson_options.txt
index cc66b46c636..a442be29958 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -123,10 +123,6 @@ option('valgrind', type : 'feature', value: 'auto',
 option('membarrier', type: 'feature', value: 'disabled',
        description: 'membarrier system call (for Linux 4.14+ or Windows')
 
-option('avx2', type: 'feature', value: 'auto',
-       description: 'AVX2 optimizations')
-option('avx512bw', type: 'feature', value: 'auto',
-       description: 'AVX512BW optimizations')
 option('keyring', type: 'feature', value: 'auto',
        description: 'Linux keyring support')
 option('libkeyutils', type: 'feature', value: 'auto',
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 8a67a14e2e2..f09ef9604f0 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -97,8 +97,6 @@ meson_options_help() {
   printf "%s\n" '  alsa            ALSA sound support'
   printf "%s\n" '  attr            attr/xattr support'
   printf "%s\n" '  auth-pam        PAM access control'
-  printf "%s\n" '  avx2            AVX2 optimizations'
-  printf "%s\n" '  avx512bw        AVX512BW optimizations'
   printf "%s\n" '  blkio           libblkio block device driver'
   printf "%s\n" '  bochs           bochs image format support'
   printf "%s\n" '  bpf             eBPF support'
@@ -244,10 +242,6 @@ _meson_option_parse() {
     --audio-drv-list=*) quote_sh "-Daudio_drv_list=$2" ;;
     --enable-auth-pam) printf "%s" -Dauth_pam=enabled ;;
     --disable-auth-pam) printf "%s" -Dauth_pam=disabled ;;
-    --enable-avx2) printf "%s" -Davx2=enabled ;;
-    --disable-avx2) printf "%s" -Davx2=disabled ;;
-    --enable-avx512bw) printf "%s" -Davx512bw=enabled ;;
-    --disable-avx512bw) printf "%s" -Davx512bw=disabled ;;
     --enable-gcov) printf "%s" -Db_coverage=true ;;
     --disable-gcov) printf "%s" -Db_coverage=false ;;
     --enable-lto) printf "%s" -Db_lto=true ;;
-- 
2.49.0


