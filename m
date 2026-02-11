Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E9ECECD6EE
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 22:21:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqIZI-0005O9-N0; Wed, 11 Feb 2026 17:20:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vqIZ6-0005LO-Jj
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 17:20:09 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vqIZ2-0004vi-Rj
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 17:20:07 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61BIp3Lv2546585
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 22:20:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lf9GsssanYZxN0gyGdB7yeLiFXVC+hnpLJqwJLYHF/k=; b=kQFx3i7G9A2UEA5Q
 sgJiOZyp74RBVpJQMrdJruKWKyPLIvukKkhwUZXwMVi2TCnFUty/1yH77FCZmIEV
 56p43U6AdnA71AKUH0L52YoZaAHgfixw2DSm7ksof/VAZHbHj70fR3yhHrp9Gb6c
 0wx1bSbqys49wA17lMMS1f3I3S0cCnIZdGb2n5ER0M5mzHGRH9qxVVIoaxBrkq3b
 7Uk43My+x3eFOWUS8p0TEipxzYYaz6XfBdP1YLineA3/m4hB5F9HaUAL9iHHdBv1
 sXQHu/PdzJKnliblVfWOO0YSiiiHWuetdexq+rxJi8vQQOMA5d8m1JG4UA08R7lk
 2xgckw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c8ydn0huv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 22:20:01 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2ba7e98178fso2526845eec.0
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 14:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1770848401; x=1771453201; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lf9GsssanYZxN0gyGdB7yeLiFXVC+hnpLJqwJLYHF/k=;
 b=MIbwWa+IxjziDOrzWF8O17eAPwpLGlYjHHCzjI1tXUifFbkNyA2rbEh8RHR8WfK25L
 pI0p9BhaHfKfT4S4N0P0/pW+Rc8wT2MeUD43f7uYvwEM65vvRmrhMycevcEA8KzWO47p
 jsHbqBEeQZ5c/C3mJZdnttTGQ4QBikk04l3vAx/i0WnLjR/a9kUHltv6T9CQMNeZQhAC
 OUdlwgVwnRIbVlDxN3XYrWn8XH68yal/j6ivGJXRcZT7KZ4Oziftdf//jao83yWwSKG6
 psFX6eGmSg1vghxUu63dqkNNdMRfeyi7o8iyZr2FakeurhRgxrPLfzFOYcWu6J4RQSk4
 X6iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770848401; x=1771453201;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lf9GsssanYZxN0gyGdB7yeLiFXVC+hnpLJqwJLYHF/k=;
 b=MelZW1DJC8T4jWopmhkenzNk8Er+dLTskJ3WSLHNs0f+UlTRcC8tAThiuzwe3eavsl
 sX7Y+3d3337PPbr1jPIUMQuGeTmOx8e+uPv0L26yxZiQlSEt8U7H385uMJXCShkGZ8jB
 bV30+u8Vi/EUNczrXdPUPeQkB5HW272gyciB0smlpFQCWbjFZSAGQap0l/JadQpVcjeS
 tO1SYsRS8RvTpY3l2iBMhhRebDGvG4iv+35sG6mpdk82QlL4+vE/CFpx5FwaFQFjys6b
 03oOvAmTDB054tAc3Rv8RXc7tMBIlNNKCk22PYg9IfeiruU450nKCh6Zk5LtBJxI+xXc
 SXag==
X-Gm-Message-State: AOJu0Yxgiykb3AEXDMFOZNLQVrNvk62bnDjg8IbwQaYvql3YhBjn9oDN
 wet0fXDvDEYlOpxp3ALV1dKHRtkJdwqQRx/q3BlXb+7xOU+/hu0zhEcT0sNe+qK00/ne6ZnEIFc
 SKsmMOxw78MXt0VMpTjsuAEXcPQLRffuF+TKoXJMwCuv+EV2xwd1/BYPbov8iJk8mRQ==
X-Gm-Gg: AZuq6aJWsEXbkXDC7nBqt3LUyfam8KVggDD4bn7iJdRndJ3yL4cwQuSJF0iRk21VQip
 XMY+zAqVYmKvBr+b/0Mjm5wt+kW7Vm02oE8KUAkgWevP3OixsBXKD2y61V1mLFCCPwkxJPSDGpa
 YQxW26rD1+n9tH458QNP4EjAYh70u+k5FW8Ni5pPu1bsON5VWv1Oyid8FN6alLvA1wdOKm0e9Fc
 YUlW3gaIYsJ2PT6+7zZSsIX2fCPE9wa+Ft7Imnzxu33ATcX316xSGEjY1zRD8QWCoFeLQ7Cae2G
 MNvjnkKq594Owpa9mkGWfOCH5p63XG4RxZc1wkXh0CAf0Rq7s32czk71Gy9xPJVwMeolNlw7mr0
 FBEe51v4RWGqZPACm3KsZ8T4fIQN3jxHl6Vc+/FMV9HwX1W48Xx3b4ymIZlczc6+YbW6JFw==
X-Received: by 2002:a05:7301:2f91:b0:2b8:64ad:ad4c with SMTP id
 5a478bee46e88-2baa809185emr378984eec.31.1770848400379; 
 Wed, 11 Feb 2026 14:20:00 -0800 (PST)
X-Received: by 2002:a05:7301:2f91:b0:2b8:64ad:ad4c with SMTP id
 5a478bee46e88-2baa809185emr378957eec.31.1770848399569; 
 Wed, 11 Feb 2026 14:19:59 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ba9dbe123asm2588379eec.13.2026.02.11.14.19.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 14:19:58 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com, alex@alexrp.com,
 Brian Cain <bcain@quicinc.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 1/4] target/hexagon: Fix invalid duplex decoding
Date: Wed, 11 Feb 2026 14:19:50 -0800
Message-Id: <20260211221953.4099441-2-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260211221953.4099441-1-brian.cain@oss.qualcomm.com>
References: <20260211221953.4099441-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=NLHYOk6g c=1 sm=1 tr=0 ts=698d0091 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=p0WdMEafAAAA:8 a=COk6AnOGAAAA:8 a=KKAkSRfTAAAA:8 a=pGLkceISAAAA:8
 a=OCWrEZw6VeUBrM89gJgA:9 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: GIVzEEdF8omWgmrcWZAA0phETNuHVGW6
X-Proofpoint-ORIG-GUID: GIVzEEdF8omWgmrcWZAA0phETNuHVGW6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjExMDE3MSBTYWx0ZWRfXz40/Gi5A18Du
 b8ha10TBtX0UeHCKQuhyen2bySchVYx1fMwjbdW91/mdwv0S59arN2GH0wygyGotTQpH/9HCfSw
 05YKNW30DxthDPIoC8pK2PI4Uov4ScCR6c9CXHdKiYQ2ZhTT1MScdzCYjmnVajgjKKTeuZB9KMW
 rD8Urbo0UhLbS+N8ySPqhkCv0/V0Q7fOLAwwkGIEclLQPQH6baSgJWdeeBYudtxOngU4GPZEqXo
 b8AIWFz45U1AVcw8CopuN1fbQFpGUeTaFx0CrVYqtLOhQx7zhD9hUXTZkhg+oeNGk7pjy95+H9W
 9uaDvaN3pf2yqqxRSrGn1aJDzhviE39SxiUM8hbjl7lxnlkHOoo3VsT0a+nGFIRUhEBfL68TCZ4
 pIzFLxhry7LcV1rtJMtUuSJh3mlEG6YeSkuveNGsyMBQc0GmzlvVjVCAlmuaN0j/qVhv0LpqQgN
 txX4m3BsNEcHofZ2QiA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-11_03,2026-02-11_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602110171
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

When decoding a duplex instruction, if the slot0 sub-instruction fails
to decode after slot1 succeeds, QEMU was leaving the packet in a
partially-decoded state. This allowed invalid duplex encodings (where
one sub-instruction doesn't match any valid pattern) to be executed
incorrectly.

Fix by resetting the decoder state when slot0 fails, returning an empty
instruction that triggers an exception.

Add gen_exception_decode_fail() for raising exceptions when decode fails
before ctx->next_PC is initialized. This keeps gen_exception_end_tb()
semantics unchanged (it continues to use ctx->next_PC for the exception
PC after successful decode).

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3291
Signed-off-by: Brian Cain <bcain@quicinc.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
---
 linux-user/hexagon/cpu_loop.c        |  4 ++
 target/hexagon/decode.c              | 13 ++++-
 target/hexagon/translate.c           | 18 ++++++-
 tests/tcg/hexagon/Makefile.target    |  1 +
 tests/tcg/hexagon/invalid-encoding.c | 81 ++++++++++++++++++++++++++++
 5 files changed, 113 insertions(+), 4 deletions(-)
 create mode 100644 tests/tcg/hexagon/invalid-encoding.c

diff --git a/linux-user/hexagon/cpu_loop.c b/linux-user/hexagon/cpu_loop.c
index 1941f4c9c1..c0e1098e3f 100644
--- a/linux-user/hexagon/cpu_loop.c
+++ b/linux-user/hexagon/cpu_loop.c
@@ -64,6 +64,10 @@ void cpu_loop(CPUHexagonState *env)
             force_sig_fault(TARGET_SIGBUS, TARGET_BUS_ADRALN,
                             env->gpr[HEX_REG_R31]);
             break;
+        case HEX_CAUSE_INVALID_PACKET:
+            force_sig_fault(TARGET_SIGILL, TARGET_ILL_ILLOPC,
+                            env->gpr[HEX_REG_PC]);
+            break;
         case EXCP_ATOMIC:
             cpu_exec_step_atomic(cs);
             break;
diff --git a/target/hexagon/decode.c b/target/hexagon/decode.c
index b5ece60450..69ba1ec96c 100644
--- a/target/hexagon/decode.c
+++ b/target/hexagon/decode.c
@@ -509,8 +509,14 @@ decode_insns(DisasContext *ctx, Insn *insn, uint32_t encoding)
                 insn->iclass = iclass_bits(encoding);
                 return 2;
             }
+            /*
+             * Slot0 decode failed after slot1 succeeded. This is an invalid
+             * duplex encoding (both sub-instructions must be valid).
+             */
+            ctx->insn = --insn;
         }
-        g_assert_not_reached();
+        /* Invalid duplex encoding - return 0 to signal failure */
+        return 0;
     }
 }
 
@@ -674,7 +680,10 @@ int decode_packet(DisasContext *ctx, int max_words, const uint32_t *words,
         encoding32 = words[words_read];
         end_of_packet = is_packet_end(encoding32);
         new_insns = decode_insns(ctx, insn, encoding32);
-        g_assert(new_insns > 0);
+        if (new_insns == 0) {
+            /* Invalid instruction encoding */
+            return 0;
+        }
         /*
          * If we saw an extender, mark next word extended so immediate
          * decode works
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index e88e19cc1a..7fe8b35351 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -195,7 +195,21 @@ static void gen_exception_end_tb(DisasContext *ctx, int excp)
     tcg_gen_movi_tl(hex_gpr[HEX_REG_PC], ctx->next_PC);
     gen_exception_raw(excp);
     ctx->base.is_jmp = DISAS_NORETURN;
+}
 
+/*
+ * Generate exception for decode failures. Unlike gen_exception_end_tb,
+ * this is used when decode fails before ctx->next_PC is initialized.
+ */
+static void gen_exception_decode_fail(DisasContext *ctx, int nwords, int excp)
+{
+    target_ulong fail_pc = ctx->base.pc_next + nwords * sizeof(uint32_t);
+
+    gen_exec_counters(ctx);
+    tcg_gen_movi_tl(hex_gpr[HEX_REG_PC], fail_pc);
+    gen_exception_raw(excp);
+    ctx->base.is_jmp = DISAS_NORETURN;
+    ctx->base.pc_next = fail_pc;
 }
 
 static int read_packet_words(CPUHexagonState *env, DisasContext *ctx,
@@ -935,7 +949,7 @@ static void decode_and_translate_packet(CPUHexagonState *env, DisasContext *ctx)
 
     nwords = read_packet_words(env, ctx, words);
     if (!nwords) {
-        gen_exception_end_tb(ctx, HEX_CAUSE_INVALID_PACKET);
+        gen_exception_decode_fail(ctx, 0, HEX_CAUSE_INVALID_PACKET);
         return;
     }
 
@@ -950,7 +964,7 @@ static void decode_and_translate_packet(CPUHexagonState *env, DisasContext *ctx)
         gen_commit_packet(ctx);
         ctx->base.pc_next += pkt.encod_pkt_size_in_bytes;
     } else {
-        gen_exception_end_tb(ctx, HEX_CAUSE_INVALID_PACKET);
+        gen_exception_decode_fail(ctx, nwords, HEX_CAUSE_INVALID_PACKET);
     }
 }
 
diff --git a/tests/tcg/hexagon/Makefile.target b/tests/tcg/hexagon/Makefile.target
index e5182c01d8..16669e04a8 100644
--- a/tests/tcg/hexagon/Makefile.target
+++ b/tests/tcg/hexagon/Makefile.target
@@ -51,6 +51,7 @@ HEX_TESTS += scatter_gather
 HEX_TESTS += hvx_misc
 HEX_TESTS += hvx_histogram
 HEX_TESTS += invalid-slots
+HEX_TESTS += invalid-encoding
 HEX_TESTS += unaligned_pc
 
 run-and-check-exception = $(call run-test,$2,$3 2>$2.stderr; \
diff --git a/tests/tcg/hexagon/invalid-encoding.c b/tests/tcg/hexagon/invalid-encoding.c
new file mode 100644
index 0000000000..010a5eb741
--- /dev/null
+++ b/tests/tcg/hexagon/invalid-encoding.c
@@ -0,0 +1,81 @@
+/*
+ * Test that invalid instruction encodings are properly rejected.
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <assert.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+static void *resume_pc;
+
+static void handle_sigill(int sig, siginfo_t *info, void *puc)
+{
+    ucontext_t *uc = (ucontext_t *)puc;
+
+    if (sig != SIGILL) {
+        _exit(EXIT_FAILURE);
+    }
+
+    uc->uc_mcontext.r0 = SIGILL;
+    uc->uc_mcontext.pc = (unsigned long)resume_pc;
+}
+
+/*
+ * Each test function:
+ *   - Sets r0 to something other than SIGILL
+ *   - Stores the resume address into resume_pc
+ *   - Executes the invalid encoding
+ *   - The handler sets r0 = SIGILL and resumes after the faulting packet
+ *   - Returns the value in r0
+ */
+
+/*
+ * Invalid duplex encoding (issue #3291):
+ * - Word 0: 0x0fff6fff = immext(#0xfffbffc0), parse bits = 01
+ * - Word 1: 0x600237b0 = duplex with:
+ *     - slot0 = 0x17b0 (invalid S2 subinstruction encoding)
+ *     - slot1 = 0x0002 (valid SA1_addi)
+ *     - duplex iclass = 7 (S2 for slot0, A for slot1)
+ *
+ * Since slot0 doesn't decode to any valid S2 subinstruction, this packet
+ * should be rejected and raise SIGILL.
+ */
+static int test_invalid_duplex(void)
+{
+    int sig;
+
+    asm volatile(
+        "r0 = #0\n"
+        "r1 = ##1f\n"
+        "memw(%1) = r1\n"
+        ".word 0x0fff6fff\n"  /* immext(#0xfffbffc0), parse=01 */
+        ".word 0x600237b0\n"  /* duplex: slot0=0x17b0 (invalid) */
+        "1:\n"
+        "%0 = r0\n"
+        : "=r"(sig)
+        : "r"(&resume_pc)
+        : "r0", "r1", "memory");
+
+    return sig;
+}
+
+int main()
+{
+    struct sigaction act;
+
+    memset(&act, 0, sizeof(act));
+    act.sa_sigaction = handle_sigill;
+    act.sa_flags = SA_SIGINFO;
+    assert(sigaction(SIGILL, &act, NULL) == 0);
+
+    assert(test_invalid_duplex() == SIGILL);
+
+    puts("PASS");
+    return EXIT_SUCCESS;
+}
-- 
2.34.1


