Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C190DF589D4
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 13:52:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFuT0-0000vm-Sx; Thu, 23 Apr 2026 09:51:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFuSz-0000uI-5m
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 09:51:41 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFuSv-00065u-U8
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 09:51:40 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-488a9033b2cso73808865e9.2
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 06:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776952296; x=1777557096; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NBipw+AVki3XcTDneyzqokcGNbW5c0iuymLSnDl+Pwo=;
 b=ep9DjWkSLGg1CTmrouP3t7MS7Wlj6uFqTCCWWZOqNR7br+6t5L1X5F+yLhoSdwyma2
 nCaX6V41mOhFaH62cFAJF+Ol/gsMz2K0DfjBbuMpe5kmx/8EQLmTp9vG4sw6/rMoJbr7
 94NguOR4jacgTRR5LaCglx9vQGmyJtRJpmB5Zp3Olnc34oYaFeyoVX5hwVnO7t91zp7G
 pPzNHxHtLIaNITT4VASJLuN3DT+UiFFFtmay3DhZ5o/+hC0V1AZJW/0ILfD5Ow77oAtM
 8YvK+R+h0qFMepWI7z5v2n+6duVv3Y8Y8//mljLwlsPp6l7002wdAC0e48BOJiFvMBJG
 mzhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776952296; x=1777557096;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NBipw+AVki3XcTDneyzqokcGNbW5c0iuymLSnDl+Pwo=;
 b=Yk1dhTZJYvIaCI5K+L3vKstlOWpdGIRPJ/bq4Z+TPX96KunywVqa3Y9PtBivVHkAIy
 MmpFvsdmgcEbfMw0deFdVuYL1izuqyiqgbetlZtcNKAM4a7H7BcsnH6NFx2rCWQaudZk
 xviA9ObXJV+dL8vAgc0Ne2PGVxISJOgfKSPEhiTVt7AzOuEZioGlXSBM44DDOjvnoYQf
 AF2JbNHoxJ2cQ1QPZQvGN0ToS3DMgDP5gEanNOBJ+rvvdnPTFRslctmC5KKiZG982sfB
 UPSVatJnWdZ4BtZ+3Iy/8t63HHVYldId0bi+H3UOkgG9jLrn4UqVdDbXTKfKapnKq5Q+
 PqBQ==
X-Gm-Message-State: AOJu0YwlsbNh2ly4Pe0klu5kgGow5fxeA74YRr6xIipwiu7xvq474Sg6
 YC29zX8qC3AW/PHSCJpZ2RDu8c1BIxPKfZeet6xDCWNCbQaIcc1n1SalqScrQ37nbFBnLPcuInt
 VG8zGGdc=
X-Gm-Gg: AeBDieuseTGtbOt5WHfU9de4AiwiDJkek1X1SUw9XLaziC0uxcgjSPFGYLloFSXiIuy
 5AYZ5AfoyWVNIFRncQTnCAOfcF9jz/zZ1aKEBx/hx/2hlRk8ZxfLApWyKHuD2p7cd3qYI0wXTlv
 fyOoKQVYucCRwDs2Jqp9y427NuurkqHZVhK03resyErTSc5OWjLeB8ZeoSTEols/7jbqIpU3a3v
 vSUotouzEczpgHkjlnREeyr03ijePiQMDl+V9qbkRYSeKVVUtJZXi/JzOQKJVPtqrK3WmSiYQbL
 ytbu/WuaHIbMcydUiXetV9L0i7lw9d+0kRYWILNwkFi/1pfyFgPTzkoyWF3actKpyi1sSFLa1UV
 OA/oOjgyjdZt9RczICLst495bwMWCg7opqyghJ19fGh6yzCC1nwRu6KGJ9m+T3YoL/glgnY3QXZ
 U2KYEceEOmPbFoYCffTiNGS+k6/QwRruIbY0HpzT228x0G62EywzRfjqg+RQBJZxZBj0T9Y1akS
 kR+dN/IUvY=
X-Received: by 2002:a05:600c:c4a6:b0:48a:761:57fe with SMTP id
 5b1f17b1804b1-48a07615be4mr248179155e9.0.1776952295554; 
 Thu, 23 Apr 2026 06:51:35 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-489e124f6c7sm85402525e9.29.2026.04.23.06.51.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Apr 2026 06:51:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-s390x@nongnu.org,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 7/9] target/s390x: Have MSA helper pass a mmu_idx argument
Date: Thu, 23 Apr 2026 15:50:33 +0200
Message-ID: <20260423135035.50126-8-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423135035.50126-1-philmd@linaro.org>
References: <20260423135035.50126-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Next commit will use the cpu_ld/st_mmu() API and thus
will also use a @mmu_idx. In order to keep it simple to
review, propate @mmu_idx in a preliminary step.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/s390x/tcg/crypto_helper.c | 41 +++++++++++++++++---------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/target/s390x/tcg/crypto_helper.c b/target/s390x/tcg/crypto_helper.c
index 4447bb66eee..074d745eb3f 100644
--- a/target/s390x/tcg/crypto_helper.c
+++ b/target/s390x/tcg/crypto_helper.c
@@ -18,6 +18,7 @@
 #include "tcg_s390x.h"
 #include "exec/helper-proto.h"
 #include "accel/tcg/cpu-ldst.h"
+#include "accel/tcg/cpu-mmu-index.h"
 
 static uint64_t R(uint64_t x, int c)
 {
@@ -119,8 +120,8 @@ static void sha512_bda_be64(uint64_t a[8], uint64_t w[16])
     sha512_bda(a, t);
 }
 
-static void sha512_read_icv(CPUS390XState *env, uint64_t addr,
-                            uint64_t a[8], uintptr_t ra)
+static void sha512_read_icv(CPUS390XState *env, const int mmu_idx,
+                            uint64_t addr, uint64_t a[8], uintptr_t ra)
 {
     int i;
 
@@ -130,8 +131,8 @@ static void sha512_read_icv(CPUS390XState *env, uint64_t addr,
     }
 }
 
-static void sha512_write_ocv(CPUS390XState *env, uint64_t addr,
-                             uint64_t a[8], uintptr_t ra)
+static void sha512_write_ocv(CPUS390XState *env, const int mmu_idx,
+                             uint64_t addr, uint64_t a[8], uintptr_t ra)
 {
     int i;
 
@@ -141,8 +142,8 @@ static void sha512_write_ocv(CPUS390XState *env, uint64_t addr,
     }
 }
 
-static void sha512_read_block(CPUS390XState *env, uint64_t addr,
-                              uint64_t a[16], uintptr_t ra)
+static void sha512_read_block(CPUS390XState *env, const int mmu_idx,
+                              uint64_t addr, uint64_t a[16], uintptr_t ra)
 {
     int i;
 
@@ -152,8 +153,8 @@ static void sha512_read_block(CPUS390XState *env, uint64_t addr,
     }
 }
 
-static void sha512_read_mbl_be64(CPUS390XState *env, uint64_t addr,
-                                 uint8_t a[16], uintptr_t ra)
+static void sha512_read_mbl_be64(CPUS390XState *env, const int mmu_idx,
+                                 uint64_t addr, uint8_t a[16], uintptr_t ra)
 {
     int i;
 
@@ -163,8 +164,9 @@ static void sha512_read_mbl_be64(CPUS390XState *env, uint64_t addr,
     }
 }
 
-static int cpacf_sha512(CPUS390XState *env, uintptr_t ra, uint64_t param_addr,
-                      uint64_t *message_reg, uint64_t *len_reg, uint32_t type)
+static int cpacf_sha512(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
+                        uint64_t param_addr, uint64_t *message_reg,
+                        uint64_t *len_reg, uint32_t type)
 {
     enum { MAX_BLOCKS_PER_RUN = 64 }; /* Arbitrary: keep interactivity. */
     uint64_t len = *len_reg, a[8], processed = 0;
@@ -182,7 +184,7 @@ static int cpacf_sha512(CPUS390XState *env, uintptr_t ra, uint64_t param_addr,
         tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
     }
 
-    sha512_read_icv(env, param_addr, a, ra);
+    sha512_read_icv(env, mmu_idx, param_addr, a, ra);
 
     /* Process full blocks first. */
     for (; len >= 128; len -= 128, processed += 128) {
@@ -192,7 +194,7 @@ static int cpacf_sha512(CPUS390XState *env, uintptr_t ra, uint64_t param_addr,
             break;
         }
 
-        sha512_read_block(env, *message_reg + processed, w, ra);
+        sha512_read_block(env, mmu_idx, *message_reg + processed, w, ra);
         sha512_bda(a, w);
     }
 
@@ -215,13 +217,13 @@ static int cpacf_sha512(CPUS390XState *env, uintptr_t ra, uint64_t param_addr,
          * or use an additional one.
          */
         if (len < 112) {
-            sha512_read_mbl_be64(env, param_addr + 64, x + 112, ra);
+            sha512_read_mbl_be64(env, mmu_idx, param_addr + 64, x + 112, ra);
         }
         sha512_bda_be64(a, (uint64_t *)x);
 
         if (len >= 112) {
             memset(x, 0, 112);
-            sha512_read_mbl_be64(env, param_addr + 64, x + 112, ra);
+            sha512_read_mbl_be64(env, mmu_idx, param_addr + 64, x + 112, ra);
             sha512_bda_be64(a, (uint64_t *)x);
         }
 
@@ -236,14 +238,14 @@ static int cpacf_sha512(CPUS390XState *env, uintptr_t ra, uint64_t param_addr,
      * TODO: if writing fails halfway through (e.g., when crossing page
      * boundaries), we're in trouble. We'd need something like access_prepare().
      */
-    sha512_write_ocv(env, param_addr, a, ra);
+    sha512_write_ocv(env, mmu_idx, param_addr, a, ra);
     *message_reg = deposit64(*message_reg, 0, message_reg_len,
                              *message_reg + processed);
     *len_reg -= processed;
     return !len ? 0 : 3;
 }
 
-static void fill_buf_random(CPUS390XState *env, uintptr_t ra,
+static void fill_buf_random(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                             uint64_t *buf_reg, uint64_t *len_reg)
 {
     uint8_t tmp[256];
@@ -271,6 +273,7 @@ static void fill_buf_random(CPUS390XState *env, uintptr_t ra,
 uint32_t HELPER(msa)(CPUS390XState *env, uint32_t r1, uint32_t r2, uint32_t r3,
                      uint32_t type)
 {
+    const int mmu_idx = cpu_mmu_index(env_cpu(env), false);
     const uintptr_t ra = GETPC();
     const uint8_t mod = env->regs[0] & 0x80ULL;
     const uint8_t fc = env->regs[0] & 0x7fULL;
@@ -303,11 +306,11 @@ uint32_t HELPER(msa)(CPUS390XState *env, uint32_t r1, uint32_t r2, uint32_t r3,
         }
         break;
     case 3: /* CPACF_*_SHA_512 */
-        return cpacf_sha512(env, ra, env->regs[1], &env->regs[r2],
+        return cpacf_sha512(env, mmu_idx, ra, env->regs[1], &env->regs[r2],
                             &env->regs[r2 + 1], type);
     case 114: /* CPACF_PRNO_TRNG */
-        fill_buf_random(env, ra, &env->regs[r1], &env->regs[r1 + 1]);
-        fill_buf_random(env, ra, &env->regs[r2], &env->regs[r2 + 1]);
+        fill_buf_random(env, mmu_idx, ra, &env->regs[r1], &env->regs[r1 + 1]);
+        fill_buf_random(env, mmu_idx, ra, &env->regs[r2], &env->regs[r2 + 1]);
         break;
     default:
         /* we don't implement any other subfunction yet */
-- 
2.53.0


