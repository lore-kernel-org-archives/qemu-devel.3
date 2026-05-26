Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2B33CD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 11:05:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRpb6-00070o-SZ; Tue, 26 May 2026 07:05:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fritchleybohrer@gmail.com>)
 id 1wRpb5-0006tM-0c
 for qemu-devel@nongnu.org; Tue, 26 May 2026 07:05:19 -0400
Received: from mail-dl1-x1241.google.com ([2607:f8b0:4864:20::1241])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fritchleybohrer@gmail.com>)
 id 1wRpb3-00084s-CW
 for qemu-devel@nongnu.org; Tue, 26 May 2026 07:05:18 -0400
Received: by mail-dl1-x1241.google.com with SMTP id
 a92af1059eb24-13621cca8f5so8903738c88.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 04:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779793516; x=1780398316; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qjg82WDIgy6OHMRcSY2Fwvwz1clLzOMiW4+Z+txy8Xc=;
 b=EyQnEiY5tCvBQYizRM1sbHsCBWZDYsybyvuzBrMpiX0kmIG3z9TES14BfY5HgpBJAq
 tPsKO+3VRbXWUNU4sjfdUBaOQ7CozETT27+0PdboN6T/QzYYcpPpArFOs5maYupGpPr1
 nK4VVe49wJYMuG6OdR1FQ/2+m4gfR3zRthGg6j7I678kLfqSKQOzjRJKHrngB9prpIy8
 84a8Z1Ktcwy5lN1o7OyFpwIejnM3pp88lZzZuC+Kg8uADhfJIq3r3FYS3DAIgXc3uP57
 5fXEZdr+pOKytYCDi6NRU7WsDg3UWLg+jkDQZ2bO6CWMLXWkr1tMXxOjmDJdIhqOpWxr
 5NmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779793516; x=1780398316;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qjg82WDIgy6OHMRcSY2Fwvwz1clLzOMiW4+Z+txy8Xc=;
 b=Aqkmvq0CS2B+yCPKeNKrU7z59tz6N5nwbu1ehbDXAa1zCAqyA2Z3lszwr+Tk/lmdGN
 rJ7ixMorNnGU9jITctvNm5ClDIo7pTt2U1Lb/GLmW4ANP6y/5Blu5upx4n/T8nEV9Xcl
 zz08oyCYM6RFZuo5iqNoZ29kPujp109I4oehoXeGlZHE4g2uZz2hm8mXoyh4JVy881jR
 4Vloo8zo/G+X9clQFZppFk9FX6uYum4GXm74uLXSKUQuy2mU1cCEh6N2Fqt5Z20+B8yn
 9rrmKtzxHL2Yfu0IWAFE02Zb5yBTynWNVgxmJrvBX3ZyvnZXhq11vEa9QzQlCyTv0VgU
 Wjxg==
X-Gm-Message-State: AOJu0Yw8a8c4EAcsTXhqnUtSqSb0E7pp5eRcGNW9UL5DaMw6JZK9UoW2
 kpSIPlzA4viYkyi6qed3KycFHpjTPnBLXctq1Eveuk/I23wWNLo/rs9VZt3eeriIUAmh7g==
X-Gm-Gg: Acq92OHKIwHBmhSlbdp7bVOYakuscKKXxuAHwLEb5PcTRjpzWYQ6BcdMZCthvWAl/zN
 S4PnuyyrMhrBC7+TRCpRVeToDj8JO3sG0RfZ55wyZettjEBxuqlvXAXAn8qxUm780yxUk+7G98W
 rVQQYza4hOyohSZXBjssA5N96F0tm91MdOTvgHdrHZ+/vhzqXtNpEbwWNsi+UK4L5uMKhs3Wcuk
 g9HUWROVYR0r1rpGd7npmWJEbewg6voRU8mPsG9JTuoAXy0IFSPlKwfDB8dyrR3m1yeiscXgMVj
 by6VEKwAPII9MTt0KOEHqi2ROXXlAYEQS3rAMSbTmzPUkxiK8eDhVmaZ6kWUNCcXcDGJczNhgjp
 6e8CkC6Zjl45GdPRj9yko06+71vFD1fg1HfjNMLLgg8GEqIIhlika2ok2TgQSC+MeRDLUoEq/HO
 pUarLbf+9KfFIODeFqyhM9Y2e/HKzZeROpcOxT4gydFMRjE+o11A4jeb75tAer0qq/bdfrBibB5
 8ZV8t0uSGs=
X-Received: by 2002:a05:701b:2214:b0:127:3915:76b2 with SMTP id
 a92af1059eb24-1365fb52fa7mr4004972c88.27.1779793515770; 
 Tue, 26 May 2026 04:05:15 -0700 (PDT)
Received: from openkylin.. (ec2-3-101-81-203.us-west-1.compute.amazonaws.com.
 [3.101.81.203]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1366a2e634csm9250276c88.2.2026.05.26.04.05.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 04:05:15 -0700 (PDT)
From: Zephyr Li <fritchleybohrer@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, daniel.barboza@oss.qualcomm.com
Subject: [PATCH v2 2/5] target/riscv: Move fflags helpers to common code
Date: Tue, 26 May 2026 19:04:47 +0800
Message-ID: <564c8cef67bb3dbfcbe17da66b9bdd2433c48e16.1779792111.git.fritchleybohrer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1779792111.git.fritchleybohrer@gmail.com>
References: <cover.1779792111.git.fritchleybohrer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1241;
 envelope-from=fritchleybohrer@gmail.com; helo=mail-dl1-x1241.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Signed-off-by: Zephyr Li <fritchleybohrer@gmail.com>
---
 target/riscv/cpu_helper.c | 28 ++++++++++++++++++++++++++++
 target/riscv/fpu_helper.c | 27 ---------------------------
 2 files changed, 28 insertions(+), 27 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 17305e1bb7..678c106ae5 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -21,6 +21,7 @@
 #include "qemu/log.h"
 #include "qemu/main-loop.h"
 #include "cpu.h"
+#include "fpu/softfloat.h"
 #include "internals.h"
 #include "pmu.h"
 #include "exec/cputlb.h"
@@ -38,6 +39,33 @@
 #include "pmp.h"
 #include "qemu/plugin.h"
 
+target_ulong riscv_cpu_get_fflags(CPURISCVState *env)
+{
+    int soft = get_float_exception_flags(&env->fp_status);
+    target_ulong hard = 0;
+
+    hard |= (soft & float_flag_inexact) ? FPEXC_NX : 0;
+    hard |= (soft & float_flag_underflow) ? FPEXC_UF : 0;
+    hard |= (soft & float_flag_overflow) ? FPEXC_OF : 0;
+    hard |= (soft & float_flag_divbyzero) ? FPEXC_DZ : 0;
+    hard |= (soft & float_flag_invalid) ? FPEXC_NV : 0;
+
+    return hard;
+}
+
+void riscv_cpu_set_fflags(CPURISCVState *env, target_ulong hard)
+{
+    int soft = 0;
+
+    soft |= (hard & FPEXC_NX) ? float_flag_inexact : 0;
+    soft |= (hard & FPEXC_UF) ? float_flag_underflow : 0;
+    soft |= (hard & FPEXC_OF) ? float_flag_overflow : 0;
+    soft |= (hard & FPEXC_DZ) ? float_flag_divbyzero : 0;
+    soft |= (hard & FPEXC_NV) ? float_flag_invalid : 0;
+
+    set_float_exception_flags(soft, &env->fp_status);
+}
+
 int riscv_env_mmu_index(CPURISCVState *env, bool ifetch)
 {
 #ifdef CONFIG_USER_ONLY
diff --git a/target/riscv/fpu_helper.c b/target/riscv/fpu_helper.c
index af40561b31..eec6328281 100644
--- a/target/riscv/fpu_helper.c
+++ b/target/riscv/fpu_helper.c
@@ -23,33 +23,6 @@
 #include "fpu/softfloat.h"
 #include "internals.h"
 
-target_ulong riscv_cpu_get_fflags(CPURISCVState *env)
-{
-    int soft = get_float_exception_flags(&env->fp_status);
-    target_ulong hard = 0;
-
-    hard |= (soft & float_flag_inexact) ? FPEXC_NX : 0;
-    hard |= (soft & float_flag_underflow) ? FPEXC_UF : 0;
-    hard |= (soft & float_flag_overflow) ? FPEXC_OF : 0;
-    hard |= (soft & float_flag_divbyzero) ? FPEXC_DZ : 0;
-    hard |= (soft & float_flag_invalid) ? FPEXC_NV : 0;
-
-    return hard;
-}
-
-void riscv_cpu_set_fflags(CPURISCVState *env, target_ulong hard)
-{
-    int soft = 0;
-
-    soft |= (hard & FPEXC_NX) ? float_flag_inexact : 0;
-    soft |= (hard & FPEXC_UF) ? float_flag_underflow : 0;
-    soft |= (hard & FPEXC_OF) ? float_flag_overflow : 0;
-    soft |= (hard & FPEXC_DZ) ? float_flag_divbyzero : 0;
-    soft |= (hard & FPEXC_NV) ? float_flag_invalid : 0;
-
-    set_float_exception_flags(soft, &env->fp_status);
-}
-
 void helper_set_rounding_mode(CPURISCVState *env, uint32_t rm)
 {
     int softrm;
-- 
2.43.0


