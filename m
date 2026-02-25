Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F28F5FD45F1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 23:17:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvO7s-0000BI-AI; Wed, 25 Feb 2026 18:17:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvO78-0007Vj-5P
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:16:22 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvO76-0002q9-JM
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:16:17 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-483a233819aso2845225e9.3
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 15:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772061375; x=1772666175; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SfG85GUI03+8GDD7qHcmAPdD+Fc/EBns15jXqib8Sv4=;
 b=aRPls/QzE82FyOKX2bfik1NrQMxJCZRHvtWE+hPirqcmjj2wT9FcSbXBRf2biT8J2Q
 LOS3EFyaaXLSa6hFCj1qGBU7qc3cgFZd9PlTRdwrh/MBUc/HA+cNtKJ9Gb7AmHFfYGnA
 GO3873O5hKc/uxweFedoZ55wXzjZeWOlqB63TiTia3sG+kT+nzZjB8+pZUjZ2BrNoT6D
 sCrkHpCpmmaL/ueZpAttQ+sblvhyDLp3FiDrNrx6ewUuFG2ENqn8An0+vsowzxOg+6Fh
 lfBGxzX+mHDzlLzzHhAYb8+xgak97upQcWlm8BqgSx4bVmn+uTxvcy9x5Op6n3q/SUFE
 0qJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772061375; x=1772666175;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=SfG85GUI03+8GDD7qHcmAPdD+Fc/EBns15jXqib8Sv4=;
 b=a862cUa/P1zd90QGznw4v60cvl4HQDQbecsSMKGYMSjJMU3XRmUE20DNFaJpwbUOjZ
 Kh5g1fWJgH9VRCEAZzltkedlzeyQ2mSgEQzBFkcD9la0ouEVYsILrHw7TbqYsii5qNU3
 MxDrgZuowyq1R01HFfAxQ66dzRirKwg67Jcss3jYkSlkyPlTs1UZJ9vkMtNEEX6g3w5H
 rdDhu1qg9DXw0aFsbIdafRb1XLjugd4NIfzwXeKiviysZzWrrqg3RNfYSU3VMUIPs20e
 OLknHpkQpw1wsPHBi/yrYa4RM8KXlKfSXLFScDq6Ez/dI/iOXrWniIBDhxY9QPiZPD83
 4C1g==
X-Gm-Message-State: AOJu0YyeP61XeK1H4ehfZDOCnyt24ayerwRIfnhVRZxrCkTo1ry68JRX
 c5MdW15s6UafQIMa7JBO3UNz7P2bSdFf7hnCUQ5zHpGkQwfJeV4ilVRvXBhG8MjxO5mBikUu2XB
 s4f95caE=
X-Gm-Gg: ATEYQzzszoXsIAa82BhrnP4BF7qogKgBd/tkBCkACfoB4waGWcxtvN0Zaw44dZuixDK
 97xlOZ/HFRzGg4MUneLbnwaSVijW0i4UWbLvj3BrCYl0EaEe9RlIQ62gMJmZ0LkWEHuNSiTG1ox
 MwDD6TDgqtCmTt9OiH/NE+GIfSae5NLw/JGE2VC9okGNQl/zQCak0kMqAromdCYmZfsixn0L07G
 G1DxGWacqiEzIilrdtQn+JHnYAG0St+4LrzyokOdbzXsczfHjI4eRNhSYb6bZjmwEh5OLi+WTrU
 yaD/eB3k4D0D5yWsgEt6jSmzD1FiVfDWyP0Ba9+LVBwCR8BnCvJ/s6bZ4Cm2IvIz6nqXaAfhLmI
 HJCUf6fSRz9qhFdVnH3eAPzs28IRNHBimoYv+1xAA6Yi2h3iNQp9/mzihzU5qTrQEY3T3uUds3O
 G/65iQG/ZZAF3j7zkcxg/vx471JtL/Mnua4Zd7Pd/xVUobl7cyQXnrrqNbWPHi+cDDeOBRFiwt
X-Received: by 2002:a05:600c:8b6c:b0:477:6d96:b3e5 with SMTP id
 5b1f17b1804b1-483c3da0b4dmr1305165e9.7.1772061374716; 
 Wed, 25 Feb 2026 15:16:14 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd7030b9sm83060585e9.4.2026.02.25.15.16.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Feb 2026 15:16:14 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/70] target/sparc: Introduce sparc_cpu_register_gdb_regs()
 stub
Date: Thu, 26 Feb 2026 00:13:18 +0100
Message-ID: <20260225231411.96482-19-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225231411.96482-1-philmd@linaro.org>
References: <20260225231411.96482-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Introduce sparc_cpu_register_gdb_regs() which we are going
to fill in the next commits.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260219191955.83815-11-philmd@linaro.org>
---
 target/sparc/cpu.h     | 1 +
 target/sparc/cpu.c     | 2 ++
 target/sparc/gdbstub.c | 9 +++++++++
 3 files changed, 12 insertions(+)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 7169a502432..0139732e4cc 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -586,6 +586,7 @@ hwaddr sparc_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 void sparc_cpu_do_interrupt(CPUState *cpu);
 int sparc_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int sparc_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
+void sparc_cpu_register_gdb_regs(CPUState *cs);
 G_NORETURN void sparc_cpu_do_unaligned_access(CPUState *cpu, vaddr addr,
                                               MMUAccessType access_type,
                                               int mmu_idx,
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index c11d600dc30..f688f07445c 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -897,6 +897,8 @@ static void sparc_cpu_realizefn(DeviceState *dev, Error **errp)
         return;
     }
 
+    sparc_cpu_register_gdb_regs(cs);
+
     qemu_init_vcpu(cs);
 
     scc->parent_realize(dev, errp);
diff --git a/target/sparc/gdbstub.c b/target/sparc/gdbstub.c
index 134617fb232..79d661fbc10 100644
--- a/target/sparc/gdbstub.c
+++ b/target/sparc/gdbstub.c
@@ -215,3 +215,12 @@ int sparc_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
     return 8;
 #endif
 }
+
+void sparc_cpu_register_gdb_regs(CPUState *cs)
+{
+#if defined(TARGET_ABI32) || !defined(TARGET_SPARC64)
+    /* Not yet supported */
+#else
+    /* Not yet supported */
+#endif
+}
-- 
2.52.0


