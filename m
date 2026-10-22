Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366AC606A326
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 12:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=aSawto8d
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJsOS-0001K9-Q6; Thu, 22 Oct 2026 08:59:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xJsNv-00013l-QX
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 08:59:10 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xJsNu-0007KM-00
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 08:59:07 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4a20a37703bso4745595e9.1
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 05:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792673944; x=1793278744; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qI8OBD9x6CAOtPn1OPrDP7VOd6EWQBpJduYoW7fgTe8=;
 b=aSawto8d1ECoY5B7AzEYvRXV+ZTig5V9Hr9Y/eo08V5KGB4PwnraYF8sQjucBpox4y
 y+Sx/u9GuoJorkO9cqYYSN9mEx0eXBmE80zHiCW5Fp2BgTl3RqtEBBJ8Dg+sqaY7uRN4
 3LJWxn58N87wS+mkkCi3KdJ3YVLWaVagwWcJQYN7KleSDvd1x8k/Tq1lfe7im/jmBDZO
 D9jn/X/vBi85sO0mrT82Ip0zPvgr2EaqZs2aaBFT2c0K8Dkz4YLN6jnu8dLtCb7GA7J5
 J4GW4F/segLJDNF79bGpJId3NHXXXRv8k0euB2rGEYb3qAzu6R4mQc2D6wCfyibraUxs
 IUgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792673944; x=1793278744;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=qI8OBD9x6CAOtPn1OPrDP7VOd6EWQBpJduYoW7fgTe8=;
 b=K351ke9yfh9Izax7o2B1t1ZvJ3ZnVkGzID6Ur8KIqXUcNGr7YVPWVXI3DFvVss3H8/
 EOsVqB7DBJgxU8Ya6cUqTS4TivhpT+WrrlONaPYEfPzjSfdFFfKaYWjOllLWIbhGfkvi
 TUlCtfZSzttLD5weEytDd7YCOwlKdsyVT6h71idveL1MLX3qN7mSQGKpPR9IpN4Jknfm
 FqSjNaEm+t6NHHCNi0wdflmWHVT6E7sGIOVCRlw1Gk0Q+PONr7Pbk7xrY2W1YBBe/WRI
 S0F+WatmGzMAmNWr5xAkUJLm6pQ+JhyhfY2vz1EOFutvHYPjiFMxH2dI/EgTkFpTOkLx
 XSEg==
X-Gm-Message-State: AFq9FYI4HtPmXlIy21OMndmtNvyIy1FX2vpe5oeQk+QHnZctehPPKHRR
 qQVld+7EunEGAkNYxuw3xr8v9lheUDIRSbIw49O0K2R6L2VjIptLa373/BVdnHtnXfixtJDl3nS
 PMHb7PLU=
X-Gm-Gg: AYBFou1wmfxdZLhbFBb9bLZZyMM/0DsrlNSzzWvqfgwCQreJlojZ7jJOcm/G14wdZRQ
 rOhaf5NuzKrkkW3V+xYY+m/Ut8kop8NmvNhQy8chdw/Mgoe3ebzz73OU9pYJcBEUfckiFsTg5zA
 /OeLUytcCFhk6xB+4rlWBOGcO7l2ivx4iJ+f9KuOLvU76WtsGHwfBnZ4p5UmSNPnQgiNprsz5GX
 Nrqns49Wv9bhKPuYiYhGuMOBiiBNhYLuQ0ZUDAnvw67aDliwpCLLE4e+k6kUbmij28ifWfjw/BM
 INsvZYQ7MmxNzCGt68zQdyEnOfJqnADohaFWzOc2jleNlKY1vbaOAbPQN7Opus8r3p73FfaQqtI
 WtKxZ1Y08PQ8pPM1IErBsCrl+8hp84raN9TxelHCFEKT0r6WTHuoila1eOMuKo/Ey6/pyB0CmW1
 mFYaDJDZHYNBERkZGKcsuo53IMXo3d0LthWQNYkR0ef+7nWeUohWQR8huMPca60FCezDuaBnkoR
 OIbtBl6FW06lcdgaf2gbuFViDNLHn+TWmAU3riUzBjVju16Pn6or/mxpNKkYIl+PIIErOL+JYie
 Er8dhptcwOmiHMVRnthrgbFSfDDhwNsnq1Sj4nrCx0fQAAtcW0tQeAhT8I3s1O9iVdgphbwjYMb
 OR39mVQ==
X-Received: by 2002:a05:600c:4f53:b0:4a1:ce33:1536 with SMTP id
 5b1f17b1804b1-4a1fdd20d2amr108196565e9.9.1792673944423; 
 Thu, 22 Oct 2026 05:59:04 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a203b439absm79247015e9.9.2026.10.22.05.59.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 05:59:03 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Song Gao <17746591750@163.com>,
 Bibo Mao <maobibo@loongson.cn>, Xianglai Li <lixianglai@loongson.cn>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
Subject: [PATCH 3/5] target/loongarch: Convert to translate_for_debug
Date: Thu, 22 Oct 2026 13:58:56 +0100
Message-ID: <20261022125858.310252-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261022125858.310252-1-peter.maydell@linaro.org>
References: <20261022125858.310252-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Convert loongarch to providing the translate_for_debug method rather
than the deprecated get_phys_addr_debug method.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/loongarch/cpu-mmu.h    |  3 ++-
 target/loongarch/cpu.c        |  2 +-
 target/loongarch/cpu_helper.c | 12 +++++++++---
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/target/loongarch/cpu-mmu.h b/target/loongarch/cpu-mmu.h
index 54fb732d62d..491eb514d9d 100644
--- a/target/loongarch/cpu-mmu.h
+++ b/target/loongarch/cpu-mmu.h
@@ -99,7 +99,8 @@ TLBRet loongarch_ptw(CPULoongArchState *env, MMUContext *context,
                      int access_type, int mmu_idx, int debug);
 void get_dir_base_width(CPULoongArchState *env, uint64_t *dir_base,
                         uint64_t *dir_width, unsigned int level);
-hwaddr loongarch_cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
+bool loongarch_cpu_translate_for_debug(CPUState *cpu, vaddr addr,
+                                       TranslateForDebugResult *result);
 uint64_t loongarch_palen_mask(CPULoongArchState *env);
 
 #endif  /* LOONGARCH_CPU_MMU_H */
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 54c26998979..69d9658f8ce 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -841,7 +841,7 @@ static void loongarch_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 static const struct SysemuCPUOps loongarch_sysemu_ops = {
     .has_work = loongarch_cpu_has_work,
     .write_elf64_note = loongarch_cpu_write_elf64_note,
-    .get_phys_addr_debug = loongarch_cpu_get_phys_addr_debug,
+    .translate_for_debug = loongarch_cpu_translate_for_debug,
 };
 
 static int64_t loongarch_cpu_get_arch_id(CPUState *cs)
diff --git a/target/loongarch/cpu_helper.c b/target/loongarch/cpu_helper.c
index 123cad3d930..270917184a6 100644
--- a/target/loongarch/cpu_helper.c
+++ b/target/loongarch/cpu_helper.c
@@ -363,7 +363,8 @@ TLBRet get_physical_address(CPULoongArchState *env, MMUContext *context,
     return loongarch_map_address(env, context, access_type, mmu_idx, is_debug);
 }
 
-hwaddr loongarch_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
+bool loongarch_cpu_translate_for_debug(CPUState *cs, vaddr addr,
+                                       TranslateForDebugResult *result)
 {
     CPULoongArchState *env = cpu_env(cs);
     MMUContext context;
@@ -371,9 +372,14 @@ hwaddr loongarch_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
     context.addr = addr;
     if (get_physical_address(env, &context, MMU_DATA_LOAD,
                              cpu_mmu_index(cs, false), 1) != TLBRET_MATCH) {
-        return -1;
+        return false;
     }
-    return context.physical;
+    *result = (TranslateForDebugResult) {
+        .physaddr = context.physical,
+        .attrs.debug = 1,
+        .lg_page_size = TARGET_PAGE_BITS,
+    };
+    return true;
 }
 
 uint64_t loongarch_palen_mask(CPULoongArchState *env)
-- 
2.43.0


