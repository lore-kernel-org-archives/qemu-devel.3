Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08063F45A08
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 19:57:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBHwR-0001uk-7O; Fri, 10 Apr 2026 15:54:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBHwP-0001ne-JH
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:54:57 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBHwM-0001fp-R0
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:54:57 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-488a9033b2cso28744825e9.2
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 12:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775850893; x=1776455693; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fh21TaJ8ypSq1QYVzVlTyt3qC9Wy73HL07UKYAF+YwI=;
 b=TGFVtCpGYmPsT4teK8F0a5UXze3GU24UHg6FJ8oSPqgbtX5bahNZEZBQ0P7ds76g2G
 Jd+Db68E9AEgoX81Rl6Qcg2oSeKpw+FFBL10HMrSeUpQG6SRoR719NB5XSWjoY45qZia
 IYrcaVoNLj8tpBRhva25hnn0JZE3Io7tSoZkmNMSBIM/ErW4Z5h0C4i+Z3C4vbWmUw29
 EE2mITArdjdHf+hxljzdbFiIth1yJcaOgYXqoIOx0X3NuZEYKdwDIxr4/Qcdika0a9kO
 uQWyr9oRV9VRGSxh35ivYpu9+OGE1qkztge6qr2mvo5f66vNFoTiyXaMHKQ3Jmk/HCWt
 0YVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775850893; x=1776455693;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Fh21TaJ8ypSq1QYVzVlTyt3qC9Wy73HL07UKYAF+YwI=;
 b=g23eRlPHlnBENs1LTg2UO8ssHiHuTbWCtJH8e86SrXRDnVljHmrWVBopSYpoQuIeKo
 fCutlj/pb5MBj9o20HKhX1P+uBWfW0Dg+WeV2aJiQnd9osY5CEPmNOnIpU8TrlPwYmLj
 rPrwUbkiuY/Dj6yHbOVYVqJL8+8ppJ2leq4/L1G1gOTKrIBM8Y6g31HPst2nMcXAAyG8
 jdO+O6I6g6xXYBJ7+ilMqBFyhkttqkrizZIxtMt2sd8FvOaAC7FbSRAsRpnBZzgLfXBP
 1YqOFpgUqLnX7M/oZyR+4ObWCAtjO76LKhkVwkjX2oYOfYOL5wrRLzdCP/yXI6HEDfbj
 0Jbw==
X-Gm-Message-State: AOJu0YxCyF4i40sbPrKh89w72f6u8FPz9VdktI8syOPZuFIx/eDijMR8
 srYpC5SdYdpBtrpOoQwvzdXDlKqoYRLRtfXNJlt6OfIhKkN6PuVZ3cKu6AArWgWZcCbsflE9Apc
 InmnpydA=
X-Gm-Gg: AeBDiet6rb0OpOmwMl3AUWi19qWJAMBMcympSy5VqhOE35Jx9RFem8LQwJE4TQZ1kTE
 XHWHArZ6IhvK+7kZMyoL0hzexWNurNJcmL0r5JuFyyjutr8C5PDSFaDZR9hjp/lOgtm8dfNA1uA
 8NTtsBdF3IwcD7H6u5z/R5+8jer5yUU/g1UanOkifG/3Z3ut97WqQUreZekRCMo3yScfyiiWIhb
 wkehvwvlDHXxhPiVzMKd8mMa+Mxg5s+lbbacXeTcdlW1Fj03WALjGGFSoZ6OXiUHQuCAL/lVMCO
 daPPbz3wqY6H5keMa1phEknxxqMZ5jtEaij8qhD48KNmEItgv1IBIyiSOfaF0H9X60rm1wqOZyH
 rfjDcp5yU1OQEItYiasDHYLFzES0YoZ/PCg7u8pVEOZfP4QtxOBRA83fEXaFWrnmF0Qcxvp0qPZ
 +L5GrFVMrmnsFSK+E4nzeoGDPyDhYow5MT5pPj2XXtxcNUPaSv5KBjWeNsyHYr69BcXi0Optu/
X-Received: by 2002:a05:600c:3b24:b0:488:c078:bfda with SMTP id
 5b1f17b1804b1-488d688d2a1mr56635425e9.26.1775850892918; 
 Fri, 10 Apr 2026 12:54:52 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d5396293sm84794825e9.15.2026.04.10.12.54.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Apr 2026 12:54:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>
Subject: [PATCH v2 12/27] target/riscv: Register target_get_monitor_def in
 SysemuCPUOps
Date: Fri, 10 Apr 2026 21:53:06 +0200
Message-ID: <20260410195323.17937-13-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410195323.17937-1-philmd@linaro.org>
References: <20260410195323.17937-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Rename target_get_monitor_def() as riscv_monitor_get_register_legacy()
and register it as SysemuCPUOps::monitor_get_register() handler.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/internals.h | 3 +++
 target/riscv/cpu.c       | 1 +
 target/riscv/monitor.c   | 4 +++-
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index 35b923c4bf5..7c91f1872b6 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -233,4 +233,7 @@ static inline int insn_len(uint16_t first_word)
     return (first_word & 3) == 3 ? 4 : 2;
 }
 
+int riscv_monitor_get_register_legacy(CPUState *cs, const char *name,
+                                      uint64_t *pval);
+
 #endif
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 8ac935ac06e..dbd88fa6655 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2720,6 +2720,7 @@ static const struct SysemuCPUOps riscv_sysemu_ops = {
     .get_phys_page_debug = riscv_cpu_get_phys_page_debug,
     .write_elf64_note = riscv_cpu_write_elf64_note,
     .write_elf32_note = riscv_cpu_write_elf32_note,
+    .monitor_get_register = riscv_monitor_get_register_legacy,
     .legacy_vmsd = &vmstate_riscv_cpu,
 };
 #endif
diff --git a/target/riscv/monitor.c b/target/riscv/monitor.c
index 3f206b9fca5..1c90c779534 100644
--- a/target/riscv/monitor.c
+++ b/target/riscv/monitor.c
@@ -26,6 +26,7 @@
 #include "monitor/monitor.h"
 #include "monitor/hmp.h"
 #include "system/memory.h"
+#include "internals.h"
 
 #ifdef TARGET_RISCV64
 #define PTE_HEADER_FIELDS       "vaddr            paddr            "\
@@ -310,7 +311,8 @@ static bool reg_is_vreg(const char *name)
     return false;
 }
 
-int target_get_monitor_def(CPUState *cs, const char *name, uint64_t *pval)
+int riscv_monitor_get_register_legacy(CPUState *cs, const char *name,
+                                      uint64_t *pval)
 {
     CPURISCVState *env = &RISCV_CPU(cs)->env;
     target_ulong val = 0;
-- 
2.53.0


