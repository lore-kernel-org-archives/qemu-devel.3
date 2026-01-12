Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98CDBCF45DA
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 22:53:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfQmI-0003vo-5a; Mon, 12 Jan 2026 17:52:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQlx-0003G1-3g
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:52:29 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQlv-0003I7-FO
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:52:28 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-430fbb6012bso5600586f8f.1
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 14:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768258346; x=1768863146; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7Xh3fCZx1unPOmLK/0bVMJA5wt4kUnt3SGcv9+Xa0qI=;
 b=ebG1PrUc3FAlY1wlDJ5U6Z7YH6v7pfEQn6ARqrCgkkgPFB9EhYpdDmdWVETyJe7jou
 8xhcVVB8GOnuZTXnq5zpjP5cpeCvwc1BywZ8zwG6s6PAnrgQrkUEQ62d6d+vhJKiA4Lf
 Zwt/cx2JpDbgIOUa7FJc9ts3DwQR/Wk5tA2tDeKEuqExMJYMeWSD0iUomAPbHalhLq0e
 gaNvpk6OP0pPvy/BlvjkTtu9EmByJap5hDcudZDSXVKeZwqlLDva3RW1R5rqibGC9y+O
 MZu/rF6/glprYHWwC1xlZ9KopGEpGzu93PinuS+ppUTidgIHx1LuEh0Tb5OfRtXX1SUT
 lHoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768258346; x=1768863146;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7Xh3fCZx1unPOmLK/0bVMJA5wt4kUnt3SGcv9+Xa0qI=;
 b=kbyEOzp2GFLM7U8+0UpDv1oi2ZnwbhmYlpvOzgj4L0KHBogsC0oNt4hLR9r2LXFe83
 AIoHwg53vCHcxfIKnTX5G7MbzDEQc59WrcBWz/Qs8ps415UdNuUdy63HOtVVYtP1Z2yb
 D4QbLvRugXnMBylLmXZYOWYdsxT0M+UGu7kZ9eovDqZEFGTM1Rsf+LD6H4iMsL1EUsqD
 H0Sh1h6CimLYj0NOyMsMk3fZ1h6OylOV5yTtqpivyBL+7uwTcigDmiBW5DZ54r3Achf6
 Si8ZBEmKos6odRiBD239AD557lmRfP3d2ZT1IL5kmp9v2JyOLbx6NZJvPkXu+GSUWg7y
 QcgQ==
X-Gm-Message-State: AOJu0YzYKBG32HpamVKlHTNmx21Ap3bG8ZlkktlbGIfXKk9ZrLOzUd8a
 7eatQYG4qddUWDIE/K5wBz0d46z5AUhua3cBihemJqLNbt4qjuYDBp+eWMBEeh1vULNkZDNQG8T
 /UhZBlts=
X-Gm-Gg: AY/fxX5DGOxe3oijxuSdVSKrPFaKMLnJsd/U3Zuj4R6oT0DHuOdlWFkCAhWqsjFEDxo
 4sV5XQMlXlSrHBa2GZfZ2A8+vx2BnT+HWpnSnZHN8PemW19pduyXi5o03c1NJmNjYzqvS2hqDFz
 f4qmrxgwvCUpnjdDp4I31iY/kHKJPbaGSfZ36QEciLq9MIH3yWA5sIgP5eh19B/eLn9iOfuTm0i
 7eX6PEV2NCYC4Ha3qRMJFhNHOlUSrsqeBJ9v2VvgjzbRM3nYB7lFqjg3PSJk1GzMwpYQJ8a+b0/
 M6k7RjaiynxLrccfuEeUtqDPhMAF2X9uGp9xOJudoZG4PuTrAdDewC9ThkeBGe02ssf+nGqlmRU
 07LB92RarRQAxKEqESGQDNnqZu7upNusJ/T1Hv5fOeuh4HP5o2cL4EYw44PteJiBbf0Tp+vtXE1
 IBjxFFcoESYfJRiflEC42+Ce1IMl70VlagKB6oAUzBTvxNNRsqsE4sHe0QCa1TzU6cwhSzlQ/PS
 5ZpVFGAxw==
X-Google-Smtp-Source: AGHT+IGk+lNs1IofsSpeSCyDaZQhm/MynIPJY7dTfvPZgDqbPKQeOBHZiYxRjlS5tKYMaxUckJ578A==
X-Received: by 2002:a05:6000:25c1:b0:430:f5ed:83f3 with SMTP id
 ffacd0b85a97d-432c37610c9mr20889802f8f.9.1768258345574; 
 Mon, 12 Jan 2026 14:52:25 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5edd51sm40758858f8f.29.2026.01.12.14.52.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 Jan 2026 14:52:25 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/61] target/loongarch: Use explicit little-endian LD/ST API
Date: Mon, 12 Jan 2026 23:48:25 +0100
Message-ID: <20260112224857.42068-31-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112224857.42068-1-philmd@linaro.org>
References: <20260112224857.42068-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The LoongArch architecture uses little endianness. Directly
use the little-endian LD/ST API.

Mechanical change using:

  $ end=le; \
    for acc in uw w l q tul; do \
      sed -i -e "s/ld${acc}_p(/ld${acc}_${end}_p(/" \
             -e "s/st${acc}_p(/st${acc}_${end}_p(/" \
        $(git grep -wlE '(ld|st)t?u?[wlq]_p' target/loongarch/); \
    done

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Message-ID: <20251224161456.89707-1-philmd@linaro.org>
---
 target/loongarch/cpu_helper.c       |  8 ++++----
 target/loongarch/tcg/iocsr_helper.c | 24 ++++++++++++------------
 target/loongarch/tcg/tlb_helper.c   |  4 ++--
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/target/loongarch/cpu_helper.c b/target/loongarch/cpu_helper.c
index 2b27274f64e..51ad9ff2b46 100644
--- a/target/loongarch/cpu_helper.c
+++ b/target/loongarch/cpu_helper.c
@@ -172,7 +172,7 @@ TLBRet loongarch_ptw(CPULoongArchState *env, MMUContext *context,
         /* get next level page directory */
         index = (address >> dir_base) & ((1 << dir_width) - 1);
         phys = base | index << 3;
-        base = ldq_phys(cs->as, phys);
+        base = ldq_le_phys(cs->as, phys);
         if (level) {
             if (FIELD_EX64(base, TLBENTRY, HUGE)) {
                 /* base is a huge pte */
@@ -204,8 +204,8 @@ restart:
     } else if (cpu_has_ptw(env)) {
         index &= 1;
         context->pte_buddy[index] = base;
-        context->pte_buddy[1 - index] = ldq_phys(cs->as,
-                                            phys + 8 * (1 - 2 * index));
+        context->pte_buddy[1 - index] = ldq_le_phys(cs->as,
+                                                    phys + 8 * (1 - 2 * index));
     }
 
     context->ps = dir_base;
@@ -237,7 +237,7 @@ restart:
         ret1 = loongarch_cmpxchg_phys(cs, phys, pte, base);
         /* PTE updated by other CPU, reload PTE entry */
         if (ret1 == MEMTX_DECODE_ERROR) {
-            base = ldq_phys(cs->as, phys);
+            base = ldq_le_phys(cs->as, phys);
             goto restart;
         }
 
diff --git a/target/loongarch/tcg/iocsr_helper.c b/target/loongarch/tcg/iocsr_helper.c
index c155f48564d..b0f171608bc 100644
--- a/target/loongarch/tcg/iocsr_helper.c
+++ b/target/loongarch/tcg/iocsr_helper.c
@@ -22,20 +22,20 @@ uint64_t helper_iocsrrd_b(CPULoongArchState *env, target_ulong r_addr)
 
 uint64_t helper_iocsrrd_h(CPULoongArchState *env, target_ulong r_addr)
 {
-    return address_space_lduw(env->address_space_iocsr, r_addr,
-                              GET_MEMTXATTRS(env), NULL);
+    return address_space_lduw_le(env->address_space_iocsr, r_addr,
+                                 GET_MEMTXATTRS(env), NULL);
 }
 
 uint64_t helper_iocsrrd_w(CPULoongArchState *env, target_ulong r_addr)
 {
-    return address_space_ldl(env->address_space_iocsr, r_addr,
-                             GET_MEMTXATTRS(env), NULL);
+    return address_space_ldl_le(env->address_space_iocsr, r_addr,
+                                GET_MEMTXATTRS(env), NULL);
 }
 
 uint64_t helper_iocsrrd_d(CPULoongArchState *env, target_ulong r_addr)
 {
-    return address_space_ldq(env->address_space_iocsr, r_addr,
-                             GET_MEMTXATTRS(env), NULL);
+    return address_space_ldq_le(env->address_space_iocsr, r_addr,
+                                GET_MEMTXATTRS(env), NULL);
 }
 
 void helper_iocsrwr_b(CPULoongArchState *env, target_ulong w_addr,
@@ -48,20 +48,20 @@ void helper_iocsrwr_b(CPULoongArchState *env, target_ulong w_addr,
 void helper_iocsrwr_h(CPULoongArchState *env, target_ulong w_addr,
                       target_ulong val)
 {
-    address_space_stw(env->address_space_iocsr, w_addr,
-                      val, GET_MEMTXATTRS(env), NULL);
+    address_space_stw_le(env->address_space_iocsr, w_addr,
+                         val, GET_MEMTXATTRS(env), NULL);
 }
 
 void helper_iocsrwr_w(CPULoongArchState *env, target_ulong w_addr,
                       target_ulong val)
 {
-    address_space_stl(env->address_space_iocsr, w_addr,
-                      val, GET_MEMTXATTRS(env), NULL);
+    address_space_stl_le(env->address_space_iocsr, w_addr,
+                         val, GET_MEMTXATTRS(env), NULL);
 }
 
 void helper_iocsrwr_d(CPULoongArchState *env, target_ulong w_addr,
                       target_ulong val)
 {
-    address_space_stq(env->address_space_iocsr, w_addr,
-                      val, GET_MEMTXATTRS(env), NULL);
+    address_space_stq_le(env->address_space_iocsr, w_addr,
+                         val, GET_MEMTXATTRS(env), NULL);
 }
diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index aab89b9be19..b6e9a3a3c7f 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -719,7 +719,7 @@ target_ulong helper_lddir(CPULoongArchState *env, target_ulong base,
     get_dir_base_width(env, &dir_base, &dir_width, level);
     index = (badvaddr >> dir_base) & ((1 << dir_width) - 1);
     phys = base | index << 3;
-    return ldq_phys(cs->as, phys) & TARGET_PHYS_MASK;
+    return ldq_le_phys(cs->as, phys) & TARGET_PHYS_MASK;
 }
 
 void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
@@ -781,7 +781,7 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
         ptoffset0 = ptindex << 3;
         ptoffset1 = (ptindex + 1) << 3;
         phys = base | (odd ? ptoffset1 : ptoffset0);
-        tmp0 = ldq_phys(cs->as, phys) & TARGET_PHYS_MASK;
+        tmp0 = ldq_le_phys(cs->as, phys) & TARGET_PHYS_MASK;
         ps = ptbase;
     }
 
-- 
2.52.0


