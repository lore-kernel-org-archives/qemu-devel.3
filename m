Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48907E9A05A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 19:21:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt9aA-0008VD-9W; Thu, 19 Feb 2026 14:21:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9a8-0008Nu-9Q
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:21:00 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9a5-0007n9-F1
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:21:00 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-4376acce52eso833742f8f.1
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 11:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771528856; x=1772133656; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JKMwcn1d5KB8sji6SRmM4mI4+WQ2D8XijU3xMHY5so8=;
 b=XVmSiaTFvo5GkI6Qwz/gn5qVNdLpZ34Ufo/dcmsPzk+jY10ktoGKPWYWJjdfzf2qSS
 3xqVuny91oDFhpmwbGRuN0AUr1Ut9+2e5lyJkPjsG73kWDq7UTA+YEkURwdDnTzgxTPi
 0Br66VvBwbOzXaKjoup4TxQX2iIBud4eG4k0cZfl/vqrkBi9f/LzXih11u9qXVW76F++
 KVt3gReNch9SSWuT97mLpP13zPq7pRe+XayzPZAsiD2yuH/cIigAnZoeITkMg/vL6WQT
 Ril9/jL2e8lq5nnbylMLv9pOzhEl/jfZDo7MuGT2QiPB5cQVxrDH+hOZUJQLOet80wsb
 TjeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771528856; x=1772133656;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JKMwcn1d5KB8sji6SRmM4mI4+WQ2D8XijU3xMHY5so8=;
 b=XMJ92kaqcdOfobB5heMf6QIGCfj0NkQ3+fF90QYam7qNrC8/pbb/LfiKSXzdKjMNk/
 uvF6cLPl4/KvKEOl9EeOoPoZoCAVR81GC6f8YoNBQVRio491EB1Q8HP8W9sVPP66k9Su
 M664nD3HbbXoJboYGiEyzBArslFgiIF8nMTiY6MqynJ54/zQH70KWy+g6tnYldd+GCKT
 fNw0INVyW18nqGH6u64mS6+VZOYEnWKmpj2qgfgBn/UyTifXNIp2r7RyqH2ZXCNH5d2n
 Hx5jtqSh6yBGlfQNtpjLQvHHspyvpkxs/05gSd8Qe1sX71Axd9XftFO+VeZRBRoIPS21
 yoCw==
X-Gm-Message-State: AOJu0Yy5qW6+Ldldmzev21BDjY50I5kUAVhEh0oZtxEHkPEDxHTA3Iuh
 5SPrJEm8xNrUXg3YvGFziUvG5hqv3Q64YDx1AfmEvA5XqUVN2rCPM89L+fEIpWgkFrSxtwYxXsu
 /ylzMVV+sSA==
X-Gm-Gg: AZuq6aIWLVbFSg5iH3stJKpL1vo8aP6Px99/Drcs4X/E5d9p8aM6e4onbEGqXUitE1G
 RsWqOlLrzIKIKVAJBps6SxYzPHiiHPiMkPVanDiN76vV4RzmJmgcefGFaQUwnb4RyHkQJbV6htu
 VXKJAPqKnYT3xCwKNnhIOAovGMIIrLddnjgnWpGJ/AUvq953fDXcwVgyaTRdPdGS3PbqCXrMViE
 E8fHCOzoSccr9xm1YtyWxCc8QvskP8txk54J8vyYDavMhPO5ugsZglbPvr63HVFczAV3zxyPBLM
 dvdSD0FOjxZc/b20vwdmh7spNI6EOvD0gcDWChCGwBto3O5bquNa990rhujAI4uKX5tCTa1lTZu
 8Ats22l7IBgb4muqgJLd0ev9uPjqwHfCRGAhoN0nHbc5vvY6sJQF2BlLiIFexPC+99qqKvUIMES
 chc0hxDi6/2m2JK1jXCYUkld20Nqffh84Ep1VkIuLTWkBwbhWsVQhMniFc/neZP9Q7kU8fefkNw
 /+NouH5GsE=
X-Received: by 2002:a05:6000:4022:b0:437:6ca8:3ede with SMTP id
 ffacd0b85a97d-43958e010f5mr11815946f8f.15.1771528855595; 
 Thu, 19 Feb 2026 11:20:55 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796ac8d82sm51683171f8f.31.2026.02.19.11.20.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Feb 2026 11:20:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH v2 08/50] target/ppc: Remove dead code depending on
 USE_APPLE_GDB
Date: Thu, 19 Feb 2026 20:19:10 +0100
Message-ID: <20260219191955.83815-9-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260219191955.83815-1-philmd@linaro.org>
References: <20260219191955.83815-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

We never defined USE_APPLE_GDB, so the code introduced in commit
b3cad3abf6d ("PPC: Add support for Apple gdb in gdbstub") is dead
since almost 12 years. Remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/cpu.h      |   2 -
 target/ppc/cpu_init.c |   7 ---
 target/ppc/gdbstub.c  | 124 ------------------------------------------
 3 files changed, 133 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 49445eb4ca8..d637a50798f 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1637,9 +1637,7 @@ static inline bool vhyp_cpu_in_nested(PowerPCCPU *cpu)
 
 void ppc_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 int ppc_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
-int ppc_cpu_gdb_read_register_apple(CPUState *cpu, GByteArray *buf, int reg);
 int ppc_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
-int ppc_cpu_gdb_write_register_apple(CPUState *cpu, uint8_t *buf, int reg);
 #ifndef CONFIG_USER_ONLY
 hwaddr ppc_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 #endif
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 27de8d80204..0b5610d02d5 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -52,7 +52,6 @@
 #endif
 
 #include "cpu_init.h"
-/* #define USE_APPLE_GDB */
 
 static const Property powerpc_cpu_properties[] = {
     DEFINE_PROP_BOOL("rtas-stopped-state", PowerPCCPU,
@@ -7554,12 +7553,6 @@ static void ppc_cpu_class_init(ObjectClass *oc, const void *data)
 #endif
 
     cc->gdb_num_core_regs = 70;
-#ifdef USE_APPLE_GDB
-    cc->gdb_read_register = ppc_cpu_gdb_read_register_apple;
-    cc->gdb_write_register = ppc_cpu_gdb_write_register_apple;
-    cc->gdb_num_core_regs = 71 + 32;
-#endif
-
     cc->gdb_arch_name = ppc_gdb_arch_name;
 #if defined(TARGET_PPC64)
     cc->gdb_core_xml_file = "power64-core.xml";
diff --git a/target/ppc/gdbstub.c b/target/ppc/gdbstub.c
index b19c0f1ea9c..ece1e5c9bd7 100644
--- a/target/ppc/gdbstub.c
+++ b/target/ppc/gdbstub.c
@@ -23,31 +23,6 @@
 #include "gdbstub/helpers.h"
 #include "internal.h"
 
-static int ppc_gdb_register_len_apple(int n)
-{
-    switch (n) {
-    case 0 ... 31:
-        /* gprs */
-        return 8;
-    case 32 ... 63:
-        /* fprs */
-        return 8;
-    case 64 ... 95:
-        return 16;
-    case 64 + 32: /* nip */
-    case 65 + 32: /* msr */
-    case 67 + 32: /* lr */
-    case 68 + 32: /* ctr */
-    case 70 + 32: /* fpscr */
-        return 8;
-    case 66 + 32: /* cr */
-    case 69 + 32: /* xer */
-        return 4;
-    default:
-        return 0;
-    }
-}
-
 static int ppc_gdb_register_len(int n)
 {
     switch (n) {
@@ -149,59 +124,6 @@ int ppc_cpu_gdb_read_register(CPUState *cs, GByteArray *buf, int n)
     return r;
 }
 
-int ppc_cpu_gdb_read_register_apple(CPUState *cs, GByteArray *buf, int n)
-{
-    CPUPPCState *env = cpu_env(cs);
-    uint8_t *mem_buf;
-    int r = ppc_gdb_register_len_apple(n);
-
-    if (!r) {
-        return r;
-    }
-
-    if (n < 32) {
-        /* gprs */
-        gdb_get_reg64(buf, env->gpr[n]);
-    } else if (n < 64) {
-        /* fprs */
-        gdb_get_reg64(buf, *cpu_fpr_ptr(env, n - 32));
-    } else if (n < 96) {
-        /* Altivec */
-        gdb_get_reg64(buf, n - 64);
-        gdb_get_reg64(buf, 0);
-    } else {
-        switch (n) {
-        case 64 + 32:
-            gdb_get_reg64(buf, env->nip);
-            break;
-        case 65 + 32:
-            gdb_get_reg64(buf, env->msr);
-            break;
-        case 66 + 32:
-            {
-                uint32_t cr = ppc_get_cr(env);
-                gdb_get_reg32(buf, cr);
-                break;
-            }
-        case 67 + 32:
-            gdb_get_reg64(buf, env->lr);
-            break;
-        case 68 + 32:
-            gdb_get_reg64(buf, env->ctr);
-            break;
-        case 69 + 32:
-            gdb_get_reg32(buf, cpu_read_xer(env));
-            break;
-        case 70 + 32:
-            gdb_get_reg64(buf, env->fpscr);
-            break;
-        }
-    }
-    mem_buf = buf->data + buf->len - r;
-    ppc_maybe_bswap_register(env, mem_buf, r);
-    return r;
-}
-
 int ppc_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 {
     CPUPPCState *env = cpu_env(cs);
@@ -248,52 +170,6 @@ int ppc_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
     }
     return r;
 }
-int ppc_cpu_gdb_write_register_apple(CPUState *cs, uint8_t *mem_buf, int n)
-{
-    CPUPPCState *env = cpu_env(cs);
-    int r = ppc_gdb_register_len_apple(n);
-
-    if (!r) {
-        return r;
-    }
-    ppc_maybe_bswap_register(env, mem_buf, r);
-    if (n < 32) {
-        /* gprs */
-        env->gpr[n] = ldq_p(mem_buf);
-    } else if (n < 64) {
-        /* fprs */
-        *cpu_fpr_ptr(env, n - 32) = ldq_p(mem_buf);
-    } else {
-        switch (n) {
-        case 64 + 32:
-            env->nip = ldq_p(mem_buf);
-            break;
-        case 65 + 32:
-            ppc_store_msr(env, ldq_p(mem_buf));
-            break;
-        case 66 + 32:
-            {
-                uint32_t cr = ldl_p(mem_buf);
-                ppc_set_cr(env, cr);
-                break;
-            }
-        case 67 + 32:
-            env->lr = ldq_p(mem_buf);
-            break;
-        case 68 + 32:
-            env->ctr = ldq_p(mem_buf);
-            break;
-        case 69 + 32:
-            cpu_write_xer(env, ldl_p(mem_buf));
-            break;
-        case 70 + 32:
-            /* fpscr */
-            ppc_store_fpscr(env, ldq_p(mem_buf));
-            break;
-        }
-    }
-    return r;
-}
 
 #ifndef CONFIG_USER_ONLY
 static void gdb_gen_spr_feature(CPUState *cs)
-- 
2.52.0


