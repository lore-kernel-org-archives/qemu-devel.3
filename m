Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B073F606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 13:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=BZZL0pw+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJsOU-0001Rh-Gh; Thu, 22 Oct 2026 08:59:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xJsNy-00014X-JL
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 08:59:12 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xJsNw-0007Km-I5
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 08:59:10 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4a20e5628f2so225245e9.2
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 05:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792673947; x=1793278747; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5q8cqXkH4d0IOT4zH3mEoMRfAvV9e/9SmmXGC/TaIL0=;
 b=BZZL0pw+RZCnKKQxMQVx8hxtqhKHsfjUBybwTttLGY26pPEbIfYEdb2f+l64KQaSZH
 2poRQB7icarPo2uhQ5m+nFYCnocUx39XZQYWOnLVJHS3C8h7r3W8aKpeEP/4C7i01UQ5
 UfYBGpwrV4aXqHF7NDoYlDw1ZPewFyqND9jZVia8+7EStUb1/AyHxqnXwgGBFGp5IEX5
 QhV2igBErUxBvNON2NP8FxfN6mOkGET+QbKV2EzJsI8veLF/kCMg3TDIC0nrZORPSe/r
 AhjcSDBYIW0AsrucX0AzFu8vmHu12an9GuVh2RPwwwS/imQvRwpP1VaDpOZfUN1N45i4
 fV7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792673947; x=1793278747;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5q8cqXkH4d0IOT4zH3mEoMRfAvV9e/9SmmXGC/TaIL0=;
 b=HsX3odBFtyMtiXkC8VHLKw/60ViLnZDzb8NOttda3IpMBrnUJOehupPdC/0jqMZooC
 THhfQi4dgfDvPCO96CFq1F+kqXbC+K9eXmzA6rfx21W4ZBQsVkz/YEXC3rqNBqb1LltC
 PSjA3xchA5nSmh9jyQhQfAV+Ft9/Nlp5x35ATe30Rc5w4hb5hpdFMZDOsuWbcKYAafqk
 CfnA+M8n2+TQj+Td6HIJybIzoSfhyqtdGfe3pqtk5SLIBA9/tRojs3QCzMwAtZOC9LYk
 bGp4Gi5vgUDhVYtT+Wnt57TyDdu36wJ3Xh8yG7L3YwSjEJHiMo7u/vk9oi7iVOUDDeBa
 LOJA==
X-Gm-Message-State: AFq9FYL5322hQExsrNqfCITEs8NO1JAsIByw/NZDVgWLY3+T9knvgCQO
 6HPKince4iWrKym4BOSy4tdHeXKUCO+7AwDINj++BctunDs/Hugp4ZbsvZyInTgqm4UUNHFasXI
 +K0qXItI=
X-Gm-Gg: AYBFou0coBt0adxDOkXhjxd8WfwdqVStx2Q54slbCLbvk4AaUkEiOVzHX2VbC0uwvT4
 bNMI7ovnICsUS5HduH8RuQIv8EMxWA/f6sqVCd+imT3QyYYT0R7pwmgPTCeIhMcPINLeOGACikr
 ha2PWpG8WgPN4YsRRNeEPchS+gRdoQZzbr0lMuYrmXP+fPfLLWaJcgq+vy5oV1wbxjCld7k0zkO
 cpbtpiVcC2KI5MIqQ5mO0/z/LCCbc/AgqpCxseC1T9LSJkl+BmT70kwhDLA/FJrQYObn20ntO+v
 mtZxbd4hZl5Ewsc/zsomZBmVnXazqSiouhljc9p3jdBitKHFWhvT4IO7Ifm4JKrBtyo+9GhlXjF
 pMgx+6N+2aoxMQIKc0fYXNi8pLjaGcgjwkhaOY0Kpp/6UMjvnYGZRtj1ERFiJx4Chatynwjx/4k
 zAT8mIS3Cm5Te8k4xI2ksVZkU8xr58c2Fu2Lz6qljC/d0YaTouhprsXvG95dy0ZEh7jzVWzbaH6
 iYVCmCimXnj8On/JoB+jtjH0cclNRZfBAQI8jGDCy1bMiDkEvcQhqdoE06715uF1PfDrwxic6rU
 T2KwhoarI8nHkE0EWaT4LQysXmGS1pv0XSJAgmV7MJxNZuRpSDinUrYSNxsA
X-Received: by 2002:a05:600c:5391:b0:4a1:d537:1c8d with SMTP id
 5b1f17b1804b1-4a1fdd23e21mr109204925e9.19.1792673947054; 
 Thu, 22 Oct 2026 05:59:07 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a203b439absm79247015e9.9.2026.10.22.05.59.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 05:59:06 -0700 (PDT)
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
Subject: [PATCH 5/5] target/mips: Convert to translate_for_debug
Date: Thu, 22 Oct 2026 13:58:58 +0100
Message-ID: <20261022125858.310252-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261022125858.310252-1-peter.maydell@linaro.org>
References: <20261022125858.310252-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

Convert mips to providing the translate_for_debug method rather
than the deprecated get_phys_addr_debug method.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/mips/internal.h        |  3 ++-
 target/mips/cpu.c             |  2 +-
 target/mips/system/physaddr.c | 13 ++++++++++---
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/target/mips/internal.h b/target/mips/internal.h
index 7dba22300b1..f054dca5f7a 100644
--- a/target/mips/internal.h
+++ b/target/mips/internal.h
@@ -118,7 +118,8 @@ enum {
 int get_physical_address(CPUMIPSState *env, hwaddr *physical,
                          int *prot, target_ulong real_address,
                          MMUAccessType access_type, int mmu_idx);
-hwaddr mips_cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
+bool mips_cpu_translate_for_debug(CPUState *cpu, vaddr addr,
+                                  TranslateForDebugResult *result);
 
 typedef struct r4k_tlb_t r4k_tlb_t;
 struct r4k_tlb_t {
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 0fead20d651..c618fd3d000 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -659,7 +659,7 @@ static ObjectClass *mips_cpu_class_by_name(const char *cpu_model)
 
 static const struct SysemuCPUOps mips_sysemu_ops = {
     .has_work = mips_cpu_has_work,
-    .get_phys_addr_debug = mips_cpu_get_phys_addr_debug,
+    .translate_for_debug = mips_cpu_translate_for_debug,
     .legacy_vmsd = &vmstate_mips_cpu,
 };
 #endif
diff --git a/target/mips/system/physaddr.c b/target/mips/system/physaddr.c
index 746dbf8aa4e..6f11e70ba80 100644
--- a/target/mips/system/physaddr.c
+++ b/target/mips/system/physaddr.c
@@ -19,6 +19,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/page-protection.h"
+#include "exec/target_page.h"
 #include "../internal.h"
 
 static int is_seg_am_mapped(unsigned int am, bool eu, int mmu_idx)
@@ -227,7 +228,8 @@ int get_physical_address(CPUMIPSState *env, hwaddr *physical,
     return ret;
 }
 
-hwaddr mips_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
+bool mips_cpu_translate_for_debug(CPUState *cs, vaddr addr,
+                                  TranslateForDebugResult *result)
 {
     CPUMIPSState *env = cpu_env(cs);
     hwaddr phys_addr;
@@ -235,7 +237,12 @@ hwaddr mips_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
 
     if (get_physical_address(env, &phys_addr, &prot, addr, MMU_DATA_LOAD,
                              mips_env_mmu_index(env)) != 0) {
-        return -1;
+        return false;
     }
-    return phys_addr;
+    *result = (TranslateForDebugResult) {
+        .physaddr = phys_addr,
+        .lg_page_size = TARGET_PAGE_BITS,
+        .attrs.debug = 1,
+    };
+    return true;
 }
-- 
2.43.0


