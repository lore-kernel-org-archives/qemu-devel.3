Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F207CA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 10:05:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBUfa-00080s-Qb; Tue, 29 Sep 2026 06:02:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBUfO-0007eO-4d
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 06:02:30 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBUfM-0008Gx-Bh
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 06:02:29 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49ffde3cec6so14057015e9.3
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 03:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790676147; x=1791280947; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7FcDnvk9pAWjFQZm+alNq0PBIDEtJ047Mx8z3tKKR6c=;
 b=t2DI/9FTmR3hVJcawdwW/2qxvOtYCmsa2qnxG3PZKPqU4rbLZ7nQb69FzKV1Py+aQY
 vLvL1MUqp3AHRlsQNOrUreygqaATCkSjOp3qmsM/wcVaw1jBd1eJG+n9XrV10pvaRUpt
 QUAIvI9prMgUJe09eqGylsxr3QmA/u6LiJS5t7YMsyLw2eUtmjrnSS2xnTYjK7lXdMQp
 9ImsHAWR/Dy2EVsedQ4B/m4vIrngxN1JSWzYmQw2+68snL6mZOaeluniIeeWXnDAHppn
 cbEGkP9EpThgFLEC/xRoa0RqLAWeVApVC/Wh0P/hlVj9bwfF9jJXUXA7fHNzaXBMsakD
 jDUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790676147; x=1791280947;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7FcDnvk9pAWjFQZm+alNq0PBIDEtJ047Mx8z3tKKR6c=;
 b=GwmrW7NVV4M/4c85HDIInQs9jjrn5kzHGvytoQmcdfAo4BCfBHJfn4XDeNKfmwmspN
 eEl3ZIaWpDaa6KeOvl1ScLisOxpV0gepN9It6rsbxlMq2Fapn5IYafhb/JPS8ehGtoB0
 dgACtyZe/UL6vhwnzzjkV2TvK1pmwLL8c+YEXzduk+h6OQF6ihDB6T8wo+bEzna/bQCg
 yB6KrBcbu3V7H0SxMmU6a8djvx6bUcKc+BFb5oVlrW+99Nz4cR15rbsx62LSltIhVu5n
 ZoOVPy1N5UM3S1SVWmOErOXLhOOr/7iEiaaTVq9TgZexQYBCz8keDPmRJhc3XggbVeMX
 Oo4Q==
X-Gm-Message-State: AFuF++ltW1OSXnfwQRswDsFOXsZ/CKuzNqDiy0s/kUtME7C4dwNB2Y5f
 ZkNE6xP15huoHhjvb6Vx2VCpk4epP5IuEaSW+hVZXu2AQUpu/WAJNWB0ccQfw3DC0su4K9MXhRP
 tX0KW
X-Gm-Gg: AYBFou04rxQ1pwZLpREE+bUArT02IKybiY9BwgFFqSUUJbpuegEbeLiorvUt4h+mJte
 fd4o9WH27TdHtkEAr4edP/E23818Cn6y20qNJA/bpDMLU2d8zrAIa6vRAoxGamQ0gbcHikoK6CL
 gJz+0sRSNAcI1HPxTg3QgGUnZQKq35xtUMCvgvkCb6vMgCmY4nkjOhvubHUuoGSlh3S9qTPINZO
 UzCl7fooMSCfuSsfgJ7ebpSjsFMQmtqT8sdhxSK14TzyLuf580r67HgY6Ham3avgddKMDuXyw7R
 GSTYp37ud1g8bDHZCRUAxMwzh6H5Htd8VETclMm0mqua7dvlvckqWmYGtA9f18OLWBx/S91S6vo
 lDon8zmpMl3eDhZK7OWRHFZ4xLUXSmcolTE70fvoMmOc8T+swMcdBBi8Ve0k4zljdDv0xGvCrqW
 43m0JP+ize4HqnRR9mbWITtMzwOSUKQafQcyyOy2aQg39MzEhoE6IcOapGxkM7qpLv/OvPOeHv9
 KZSn+6MU8vcF/v4/TIWtPSu9FQ/DCI0kWfF5LNAGarB8YObEEy8azcrx9F7EJQ53iqWErJ6qjwI
 V+o=
X-Received: by 2002:a05:600c:4e53:b0:49e:6861:50f7 with SMTP id
 5b1f17b1804b1-49fe66c8921mr263353615e9.5.1790676146611; 
 Tue, 29 Sep 2026 03:02:26 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af4f88b37sm3091412f8f.5.2026.09.29.03.02.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 03:02:25 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 33/37] target/arm: Split out check_il
Date: Tue, 29 Sep 2026 11:01:28 +0100
Message-ID: <20260929100133.2598676-34-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929100133.2598676-1-peter.maydell@linaro.org>
References: <20260929100133.2598676-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm2-x10.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-id: 20260925215004.456336-13-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-a64.c |  7 +------
 target/arm/tcg/translate.c     | 28 ++++++++++++++++------------
 target/arm/tcg/translate.h     |  1 +
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index b3438235828..7f858654c43 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -11174,12 +11174,7 @@ static void aarch64_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
     s->fp_access_checked = 0;
     s->sve_access_checked = 0;
 
-    if (s->pstate_il) {
-        /*
-         * Illegal execution state. This has priority over BTI
-         * exceptions, but comes after instruction abort exceptions.
-         */
-        gen_exception_insn(s, 0, EXCP_UDEF, syn_illegalstate());
+    if (check_il(s)) {
         return;
     }
 
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index f32200cc47e..fbacc3b7574 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -1159,6 +1159,20 @@ void unallocated_encoding(DisasContext *s)
     gen_exception_insn(s, 0, EXCP_UDEF, syn_uncategorized());
 }
 
+/*
+ * These conditions have less priority than instruction abort, and thus
+ * must be checked after reading the instruction.  They have more priority
+ * than the AArch64 BTI exception.
+ */
+bool check_il(DisasContext *s)
+{
+    if (s->pstate_il) {
+        gen_exception_insn(s, 0, EXCP_UDEF, syn_illegalstate());
+        return true;
+    }
+    return false;
+}
+
 /* Force a TB lookup after an instruction that changes the CPU state.  */
 void gen_lookup_tb(DisasContext *s)
 {
@@ -6153,12 +6167,7 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
         return;
     }
 
-    if (s->pstate_il) {
-        /*
-         * Illegal execution state. This has priority over BTI
-         * exceptions, but comes after instruction abort exceptions.
-         */
-        gen_exception_insn(s, 0, EXCP_UDEF, syn_illegalstate());
+    if (check_il(s)) {
         return;
     }
 
@@ -6728,12 +6737,7 @@ static void thumb_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
     dc->base.pc_next = pc;
     dc->insn = insn;
 
-    if (dc->pstate_il) {
-        /*
-         * Illegal execution state. This has priority over BTI
-         * exceptions, but comes after instruction abort exceptions.
-         */
-        gen_exception_insn(dc, 0, EXCP_UDEF, syn_illegalstate());
+    if (check_il(dc)) {
         return;
     }
 
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index f633aa265f0..7eba9b764ce 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -382,6 +382,7 @@ void arm_jump_cc(DisasCompare *cmp, TCGLabel *label);
 void arm_gen_test_cc(int cc, TCGLabel *label);
 MemOp pow2_align(unsigned i);
 void unallocated_encoding(DisasContext *s);
+bool check_il(DisasContext *s);
 void gen_exception_internal(int excp);
 void gen_exception_insn_el(DisasContext *s, int64_t pc_diff, int excp,
                            uint32_t syn, uint32_t target_el);
-- 
2.43.0


