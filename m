Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A439FD45FB
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 23:17:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvO7j-0008Qp-KJ; Wed, 25 Feb 2026 18:16:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvO6q-0007BJ-7f
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:16:03 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvO6n-0002pF-8O
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:15:59 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4807068eacbso2211355e9.2
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 15:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772061355; x=1772666155; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nuDGlu1ravc7wqM1ewnTKp2BLMejuoYcRQ9ew040oao=;
 b=XhBJWFwohLBJuuKLsR2DWL3pqTzNVrsWpUfQ96hjphGV37/4kZS5iMfdcs/C3zfA4B
 ILz0JJmBVKl2pC3j+yu6XqWkVZlE2eVvXJHKtBMHKruPF4GxeuC0lGZX1dv1T6MUyp9Q
 5Scv1Jw5eVYNhSOoOUUSCgT/PlQtOHMOkQ6Dd95wckfSZxUlTKWWLhicrhQb7302KlTG
 C9ZUcRkPsS/SF7YNBKcFlLDLKWsnWKKhcgI8sY9OTE4pmdigQy+kjGvbcrqHRUs7HPvb
 XSrLraKE3xOcknfrwBKSlk6/CfM7bL4r2v54pISC0jKJRaAOjkQ1El/TwtygxEwucjw5
 Z1dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772061355; x=1772666155;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nuDGlu1ravc7wqM1ewnTKp2BLMejuoYcRQ9ew040oao=;
 b=Uw17pVtCVgCP0+VWZMJX+FaawQMm4uUvnCHdPorhHmjA1H7yFdltdVZc1MdvLkumy4
 D0xndgp9LSDXXSJjSVl+WyUDgKOaYVtYuJ41meVNb/juH326E5Zq+MptgoMxQS14Rxxw
 gn2fjwe1X/QFs5DklOkPWXd2OYktDM5Q4mZNZFmhOvsPe4Zv3KvCq7E5ebkxu+qYEgEi
 YWSYjmRip5Ro9thLvsb0MBi85FirvCsUV63MlW3DIaZLc1Uv0DYTH5w+3x5WbtNnty51
 hMtwZb23sX3Z3W2Awcr2a7KplOEp65AtYnT2BT3EQuxzODIDdZs+2iuLcswGxsCJ2Nc0
 gHIA==
X-Gm-Message-State: AOJu0Yyg0gIBsD3B26zFKbEuA4nuBgiQpA9V5LvpaR5TW32lrioAXWlV
 9lwEo7mJG8MJdc6Ud4keK7sGAtRjBk+KttCohUAAOhux+carpV9ILUlEZxSh6CSWSCSMOKMMfGF
 kQObyStM=
X-Gm-Gg: ATEYQzxdpu2kI7rxTJah1HQFEyo3ey6rzwtCRDt8frAKfmI8YdauwHs1ShIGuj2jv4W
 ww06NJf8IIEYLxBqnmq6ST2EQb7Ru4BHLb4BVsTx5ruSTnfPKXqM2GoMClt0sjdmiI1tOE7ff3N
 9a4nhuw/Yk4eVN5GHJmEdWAalBC0RyYSs9k3fEYv28Nk+6O8q+7xL2WVLj7KMGN23D7/D1dG7jU
 7jiLAJHTqKfc7M220lF+z0d5LSrhsAaD4D7tFTjl+VqvlJMusQQ44OunNOxmoYFTMWVQirSsPSy
 /lI9eG7S1wcv8ZFetmO32AIFC0xGo691q7ctp5eCmKP40BtypOZ3lJOo/LLE0OYJ8yyVrrUb5nb
 8E/4zWURVYohHl+5smgYMcbBo3TB/Ws6i4WNS4lDth/fLhjMQ7X9k1/UDKGqBcypqG08em+MWO9
 +G9Tle8FdX6lH6CCtGdAHlJTwHuB5kdybo1l2jhvdu1VXAiO6cqDE0SMkEeYA2rM3koOjBjuJzC
 JCDkCPTlsQ=
X-Received: by 2002:a05:600d:644e:20b0:483:bf23:1915 with SMTP id
 5b1f17b1804b1-483c3db51a4mr1052005e9.2.1772061355131; 
 Wed, 25 Feb 2026 15:15:55 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfb29715sm56645705e9.0.2026.02.25.15.15.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Feb 2026 15:15:54 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/70] target/ppc: Remove dead code depending on USE_APPLE_GDB
Date: Thu, 26 Feb 2026 00:13:15 +0100
Message-ID: <20260225231411.96482-16-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225231411.96482-1-philmd@linaro.org>
References: <20260225231411.96482-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

We never defined USE_APPLE_GDB, so the code introduced in commit
b3cad3abf6d ("PPC: Add support for Apple gdb in gdbstub") is dead
since almost 12 years. Remove it.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260219191955.83815-9-philmd@linaro.org>
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


