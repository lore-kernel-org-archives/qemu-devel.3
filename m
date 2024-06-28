Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD4FEC2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 17:30:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNFPW-0005a1-WB; Fri, 28 Jun 2024 13:29:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sNFPT-0005ZX-Pv
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 13:29:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sNFPP-0002Au-8F
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 13:29:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719595754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2zJrXRaDXBIm9h7tTU28UT9xcD/K/7uFNW/URjbJHRw=;
 b=RJ6MTIT9v89PeXpFvx0wkwauOaKucxjF8Ndqy715rrsfN1azrSiyowjYIVmHbx5Yx6Oeqk
 An7dXmNMtj8C0Q3IMsq9ROAnnjcDUxb7v/UcRPg1rXlmRKU4jAOLex3wBo4ENlhrZJWsGM
 A+r1/FptBwgAgYUHxrKVXWuz8fc3NeY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-C_SVBynnP1WADU07CsuFnw-1; Fri, 28 Jun 2024 13:29:12 -0400
X-MC-Unique: C_SVBynnP1WADU07CsuFnw-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a6f571c3eefso57917266b.2
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 10:29:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719595750; x=1720200550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2zJrXRaDXBIm9h7tTU28UT9xcD/K/7uFNW/URjbJHRw=;
 b=tDNrAfbJq3zkHlga5Tv/8JVCAPghmuNBuAK/rKsuQNJJxtQNlz1EN0AcoG0WBxyJua
 HVCCdhP7Pb2a2fVOhRY5Xi9zM1O9xTcrY8SE1ONhOW1WVUJzXJaM21F0IqCok1/QojlT
 /ARMmejKij7bxPiWa+zq0stZ+l0APYc1Dja55k/5X7UJTzjRoY61BmgLFPzJ6fVaZnET
 0O9H6RJY9A+DIdChXX3iyZfaKbo42qxNbmWPl9d1Q/iD8u+/jFaVy+HJhVE5awMPu9hU
 DihD5ejvWcoQ65IAkTovxvXyu0IwzaPVgJNac/QifFX8y8rMbSThuxMP+H3USbJ1XNFG
 UO2w==
X-Gm-Message-State: AOJu0YyWfM/lU2P+BZ3YiFQqAq2XdHe7/gvy93VcOU0XiX41czqP4f4u
 V4Rw52dW+VH5R0Ar6i02xChOIukObY+wevbs3oHpp7cs4qefKnCX8BduAn0oshOhHsLd7KOFaXN
 3ubiihU8Xfx34mE6JRS4YfiRxIhI5EBwtvvJ6i8OyYj6eB+ZMYX8kvCXy+gl0warfsfyp56onN0
 JjKwkO0TEYJSjahm7af9IGZTuEzQ22lr7pXLPi
X-Received: by 2002:a17:907:d310:b0:a72:65e5:3e2 with SMTP id
 a640c23a62f3a-a727f650205mr843279566b.6.1719595750386; 
 Fri, 28 Jun 2024 10:29:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+buScbpv3BPqe4MQkVHuuLXiYuQczrX/JB59NEf+S41DyzRHTqqlmOkfRlxLTab1bjtawDw==
X-Received: by 2002:a17:907:d310:b0:a72:65e5:3e2 with SMTP id
 a640c23a62f3a-a727f650205mr843278266b.6.1719595749999; 
 Fri, 28 Jun 2024 10:29:09 -0700 (PDT)
Received: from avogadro.local ([151.62.196.71])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72ab08cecfsm97165066b.147.2024.06.28.10.29.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 10:29:08 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 06/23] meson: remove dead optimization option
Date: Fri, 28 Jun 2024 19:28:38 +0200
Message-ID: <20240628172855.1147598-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240628172855.1147598-1-pbonzini@redhat.com>
References: <20240628172855.1147598-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.206,
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                   | 13 -------------
 meson_options.txt             |  2 --
 scripts/meson-buildoptions.sh |  3 ---
 3 files changed, 18 deletions(-)

diff --git a/meson.build b/meson.build
index 6e694ecd9fe..54e6b09f4fb 100644
--- a/meson.build
+++ b/meson.build
@@ -2874,18 +2874,6 @@ config_host_data.set('CONFIG_AVX2_OPT', get_option('avx2') \
     int main(int argc, char *argv[]) { return bar(argv[argc - 1]); }
   '''), error_message: 'AVX2 not available').allowed())
 
-config_host_data.set('CONFIG_AVX512F_OPT', get_option('avx512f') \
-  .require(have_cpuid_h, error_message: 'cpuid.h not available, cannot enable AVX512F') \
-  .require(cc.links('''
-    #include <cpuid.h>
-    #include <immintrin.h>
-    static int __attribute__((target("avx512f"))) bar(void *a) {
-      __m512i x = *(__m512i *)a;
-      return _mm512_test_epi64_mask(x, x);
-    }
-    int main(int argc, char *argv[]) { return bar(argv[argc - 1]); }
-  '''), error_message: 'AVX512F not available').allowed())
-
 config_host_data.set('CONFIG_AVX512BW_OPT', get_option('avx512bw') \
   .require(have_cpuid_h, error_message: 'cpuid.h not available, cannot enable AVX512BW') \
   .require(cc.links('''
@@ -4283,7 +4271,6 @@ summary_info += {'mutex debugging':   get_option('debug_mutex')}
 summary_info += {'memory allocator':  get_option('malloc')}
 summary_info += {'avx2 optimization': config_host_data.get('CONFIG_AVX2_OPT')}
 summary_info += {'avx512bw optimization': config_host_data.get('CONFIG_AVX512BW_OPT')}
-summary_info += {'avx512f optimization': config_host_data.get('CONFIG_AVX512F_OPT')}
 summary_info += {'gcov':              get_option('b_coverage')}
 summary_info += {'thread sanitizer':  get_option('tsan')}
 summary_info += {'CFI support':       get_option('cfi')}
diff --git a/meson_options.txt b/meson_options.txt
index 6065ed2d352..0269fa0f16e 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -119,8 +119,6 @@ option('membarrier', type: 'feature', value: 'disabled',
 
 option('avx2', type: 'feature', value: 'auto',
        description: 'AVX2 optimizations')
-option('avx512f', type: 'feature', value: 'disabled',
-       description: 'AVX512F optimizations')
 option('avx512bw', type: 'feature', value: 'auto',
        description: 'AVX512BW optimizations')
 option('keyring', type: 'feature', value: 'auto',
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 62842d47e88..cfadb5ea86a 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -95,7 +95,6 @@ meson_options_help() {
   printf "%s\n" '  auth-pam        PAM access control'
   printf "%s\n" '  avx2            AVX2 optimizations'
   printf "%s\n" '  avx512bw        AVX512BW optimizations'
-  printf "%s\n" '  avx512f         AVX512F optimizations'
   printf "%s\n" '  blkio           libblkio block device driver'
   printf "%s\n" '  bochs           bochs image format support'
   printf "%s\n" '  bpf             eBPF support'
@@ -240,8 +239,6 @@ _meson_option_parse() {
     --disable-avx2) printf "%s" -Davx2=disabled ;;
     --enable-avx512bw) printf "%s" -Davx512bw=enabled ;;
     --disable-avx512bw) printf "%s" -Davx512bw=disabled ;;
-    --enable-avx512f) printf "%s" -Davx512f=enabled ;;
-    --disable-avx512f) printf "%s" -Davx512f=disabled ;;
     --enable-gcov) printf "%s" -Db_coverage=true ;;
     --disable-gcov) printf "%s" -Db_coverage=false ;;
     --enable-lto) printf "%s" -Db_lto=true ;;
-- 
2.45.2


