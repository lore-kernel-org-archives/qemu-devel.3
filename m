Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DA05CD5BA4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 17:36:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPkpY-0002nZ-IS; Wed, 20 May 2026 13:35:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wPkpW-0002md-S5
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:35:38 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wPkpT-0006vc-FH
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:35:38 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64KGjMYd446901
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 17:35:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=LKwHMwV5sY9HeeMU+0TTLT82xjmN8iEJXK1
 bIKU8aHg=; b=cr87fajwUPpeOffEOeC0Kvq4LL169UufVCoYCO3y2Bv/9w/HJDa
 srIv1jPuHk8Oa3/rK78sGa76qyd9Hn36bvf2TfKGvmGw69JKZ/OT7IoHF1ugsRhR
 iS1tyEEyx4a9+cNlhIpwU6gQjrcvwo6xFGsQ6FXQB3dO/KrT4kZBPQwcEgbr+/KH
 ZXif+T97wIANBEGUuHR/QAbKkpd4YHNlNYNDl3zZzOJUE/O8FLj+/8gyaZwum00T
 wDR2P57GuFa/x/olKF+rR6lm/nAsa6XevJAIc3/Ldhybt/pJkUUBw0nsxYKFCjCY
 GXEUDWBtRE7++i2BVH6ZUFcOZWiVBokGWZg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9anrhws9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 17:35:28 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8b58065ea15so152206596d6.2
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 10:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779298527; x=1779903327; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LKwHMwV5sY9HeeMU+0TTLT82xjmN8iEJXK1bIKU8aHg=;
 b=N41J6z3m4tg1at16p85lMX+zsd4EYGdQ+fV7V45Lp3yO3VRXV8tD8b/Z4NmlJa+rjh
 fmaln0zRITEp3e4xx3GeiKuDPLubvbtrR+tPKLLAnck73cRwtB6V9LMAqpB+H456YvN6
 CPdHeqwNa8JUyvFCB1Nx2zdS+tPjLpQOcSuZ1gehoRB3mdPy4QH/sozyWDsLAOKCnd3i
 tjS9nU4F/0V3zEtsuFzHXUGkarTGpiA9QeezT0zYBqYSRahBVe/oIqDGNwW/SpMm8Bvw
 jr95m2Uo+rCQptQ4i/sdLuXQTMP5Czb+4GHn//7TRh6Ta0MD8kXm5PYzZ5Tz9n6dcKBV
 51zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779298527; x=1779903327;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LKwHMwV5sY9HeeMU+0TTLT82xjmN8iEJXK1bIKU8aHg=;
 b=OwZOcYTG7NuJAOMEI+H/rZgi0tk7qWdRFgHGpsIGao/OtdTpWqiEfs2KI21BYxFh06
 F77vVkI5xQtDwrsUGBGiF0BIIV4ERoTTpEQKeF4X2zfOnGX9ZDQh2WPGckQbR33qYZ6C
 b0+kT6+VbnVonmkLOpd8yirBm8UlKuvhy9zXT1fJhTbkbpxdInsLpF5nPUiTHW4CAiOk
 tYOsY84CWQmIPVWj8kCZ5rqkCuXnOp/SWaN0svOKn/NJ5g2mvPCgyzN/PFUhtf7tztu/
 AZYCHnHgs16vyRMfbNQB+LCUq5PthyVLipSEqryuzrsy4uxkPWyqXts5jaOJJHDdLgAW
 Fbug==
X-Gm-Message-State: AOJu0YxckbVDYzpxHuM2EEkkRFzLhkKQria/dt19MhyTR6jLP/pkuJo5
 ktvOw+VaHx3C2zxi7dy4ID+jUelmA71ixOHJjEZKYGnPOWqTcA2xCGp3ofK+tYk9PrlG3R7KVH0
 reFWNEdBv56km8rE6NhE6jQeED1ZM/T963WQ5p9N0bZxbUSxnYO0YnN9sgeQ2ddGNTw==
X-Gm-Gg: Acq92OF8kAJ3z8nyyDlFuQQIUmySD+kub073ActyyGFYoIGu+XnGcUgDvuEinj32JZa
 92tGWJKeG+GaxZo7mw3oFnLoKN7daTb5LHHZc6tjhYn0mha5b1dCAYc7ZCc7eTg1pab8dv4ijXi
 RPYciFds3ckRmQ14jGihFgqZr8tgxUVK+ZHlRs3n52V0NIV0F17LDuZm/HJCKek3nsYwD+4dWux
 oVUDPSkocF0u15RaxqEXfRP2OJ9YJOQs0fxBxfVDkGZ4cgZDrpBA33nnet5wf/e3nRuJaeBbqgI
 LnsZAaozqeir/zQUAKpDcSzAkG26DGRX3XqnF84UXOq864X0qf60c43597XXwgsQHEXf5MZfyZc
 Kn2vDP3XGDPo4oTx1Jv4WzcS06PVnIIPuPNwWHjPAEiROXk/tQjSi8hdg6t8w
X-Received: by 2002:a05:6214:5297:b0:8cc:f94:86af with SMTP id
 6a1803df08f44-8cc0f9489damr41857106d6.50.1779298527190; 
 Wed, 20 May 2026 10:35:27 -0700 (PDT)
X-Received: by 2002:a05:6214:5297:b0:8cc:f94:86af with SMTP id
 6a1803df08f44-8cc0f9489damr41856066d6.50.1779298526464; 
 Wed, 20 May 2026 10:35:26 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([191.202.238.222])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ca360b274bsm126854276d6.21.2026.05.20.10.35.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 10:35:25 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH] target/riscv,disas/riscv: add insn len encodings > 64 bit
Date: Wed, 20 May 2026 14:35:22 -0300
Message-ID: <20260520173522.1794433-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: iGsdcq1W1zCcQv6eMDwdsbrWFqgeOHoy
X-Proofpoint-ORIG-GUID: iGsdcq1W1zCcQv6eMDwdsbrWFqgeOHoy
X-Authority-Analysis: v=2.4 cv=UuJT8ewB c=1 sm=1 tr=0 ts=6a0df0e0 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=etEqFfc6qwXwpI8uT8rzbw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=p0WdMEafAAAA:8
 a=EUspDBNiAAAA:8 a=p0CW7Bo4BwABr9lP6VwA:9 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE3MSBTYWx0ZWRfXzPkc+ywW+es3
 9FMA0yPwWVhNLx5WoykhRsfJeBSu1eiL45L9iYkdlBqX76vFioA/ZdvQZtuJn7VeerAxKavy3ST
 ywDrnRW1w2BSgbHYtAjO+7YZan7VTFVFP4OYwOKAt5dhPt2lrQB8UIRxqBfXzjAjMRTZhqmACbm
 Q2giFXZkh+n4HfZhVkA4erN+lobaxerPbkMaq05tlaGhKm+55YkcsIi7sZhcQhtodvIBNxNCfVL
 DRFLq3j58ULQsRWD6h4QDq+metb46ViaKQX1l8t4mVLzNCSCgACNP0CEzMFeT08OHTWQ7KKBqHa
 eZCFQ64vnARzMOe3OP5jDZBraEljTHBEHU+V3itp6g2IRB/WA6Ybj538ByXLJUoNw5fPIt3ZXYn
 ynsQl7spfFFkJoSFJIksUbeZs4NiDoUmjk3FUov6gnoZiEqmu/+Rb5QBv2p9K/aNGF2ROZc/Cyi
 eDvoM/17KXbs3uNs8XQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605200171
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

We're missing the "Expanded Instruction-Length Encoding" logic from the
unpriv isa, meaning we're not detecting missing insn len > 8 bytes.
This doesn't have impact in regular insn emulation because most (if not
all) of the existing insns are 2 or 4 bytes.

However, running with "-d in_asm" will cause QEMU to run an infinite
loop because our disas code can't handle the expanded length encoding,
causing inst_length() to return '0' and target_disas() to loop forever
since it's using the len to decrease the loop counter.

Fixing just the disas code isn't enough.  target_disas() will do a

"if (size < count) {"

check, where size = the insn length from the translator and count = the
insn length from disas, and will warn about it during disassembling.  We
need both places to use the same insn length logic.

[1] https://gitlab.com/qemu-project/qemu/-/work_items/3479

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3479
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 disas/riscv.c            | 50 +++++++++++++++++++++++++++++-----------
 target/riscv/internals.h | 33 ++++++++++++++++++++++++--
 target/riscv/translate.c |  7 +++++-
 3 files changed, 73 insertions(+), 17 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index d416a4d6b3..d32661c857 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -5057,26 +5057,48 @@ static bool check_constraints(rv_decode *dec, const rvc_constraint *c)
     return true;
 }
 
-/* instruction length */
-
+/*
+ * Note: basically a carbon copy of insn_len() from
+ * target/riscv/internals.h.
+ */
 static size_t inst_length(rv_inst inst)
 {
-    /* NOTE: supports maximum instruction size of 64-bits */
-
     /*
-     * instruction length coding
+     * "Expanded Instruction-Length Encoding" as in
+     * unpriv isa section 1.5.1.
      *
-     *      aa - 16 bit aa != 11
-     *   bbb11 - 32 bit bbb != 111
-     *  011111 - 48 bit
-     * 0111111 - 64 bit
+     *               aa - 16 bit aa != 11
+     *            bbb11 - 32 bit bbb != 111
+     *           011111 - 48 bit
+     *          0111111 - 64 bit
+     * xnnnxxxxx1111111 - (80 + 16*nnn) bits, if nnn != 111
+     * x111xxxxx1111111 - 192 bits
      */
+    if ((inst & 0b11) != 0b11) {
+        return 2;
+    } else if ((inst & 0b11100) != 0b11100) {
+        return 4;
+    } else if ((inst & 0b111111) == 0b011111) {
+        return 6;
+    } else if ((inst & 0b1111111) == 0b0111111) {
+        return 8;
+    } else if ((inst & 0b1111111) == 0b1111111) {
+        uint32_t nnn = (inst >> 12) & 0b0111;
+
+        if (nnn == 0b111) {
+            return 24;
+        }
+        return (16 * nnn + 80) / 8;
+    }
 
-    return (inst &      0b11) != 0b11      ? 2
-         : (inst &   0b11100) != 0b11100   ? 4
-         : (inst &  0b111111) == 0b011111  ? 6
-         : (inst & 0b1111111) == 0b0111111 ? 8
-         : 0;
+    /*
+     * Returning 0 if we don't find the right insn length will
+     * cause an infinite loop in target_disas().  Return an
+     * unrealistic length value instead, making target_disas()
+     * trigger the "Disassembler disagrees with translator over
+     * instruction" error path.
+     */
+    return 1024;
 }
 
 /* format instruction */
diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index 8c24af0d85..80c2f8f5f8 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -245,9 +245,38 @@ static inline target_ulong adjust_addr_virt(CPURISCVState *env,
     return adjust_addr_body(env, addr, true);
 }
 
-static inline int insn_len(uint16_t first_word)
+static inline int insn_len(uint32_t opcode)
 {
-    return (first_word & 3) == 3 ? 4 : 2;
+    /*
+     * "Expanded Instruction-Length Encoding" as in
+     * unpriv isa section 1.5.1.
+     *
+     *               aa - 16 bit aa != 11
+     *            bbb11 - 32 bit bbb != 111
+     *           011111 - 48 bit
+     *          0111111 - 64 bit
+     * xnnnxxxxx1111111 - (80 + 16*nnn) bits, if nnn != 111
+     * x111xxxxx1111111 - 192 bits
+     */
+    if ((opcode & 0b11) != 0b11) {
+        return 2;
+    } else if ((opcode & 0b11100) != 0b11100) {
+        return 4;
+    } else if ((opcode & 0b111111) == 0b011111) {
+        return 6;
+    } else if ((opcode & 0b1111111) == 0b0111111) {
+        return 8;
+    } else if ((opcode & 0b1111111) == 0b1111111) {
+        uint32_t nnn = (opcode >> 12) & 0b0111;
+
+        if (nnn == 0b111) {
+            return 24;
+        }
+        return (16 * nnn + 80) / 8;
+    }
+
+    /* Shouldn't happen, but ... */
+    return -1;
 }
 
 int riscv_monitor_get_register_legacy(CPUState *cs, const char *name,
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 1e4f340256..bd28ed3fcb 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1255,6 +1255,7 @@ static void decode_opc(CPURISCVState *env, DisasContext *ctx)
 {
     uint32_t opcode;
     bool pc_is_4byte_align = ((ctx->base.pc_next % 4) == 0);
+    int insn_length;
 
     ctx->virt_inst_excp = false;
     if (pc_is_4byte_align) {
@@ -1279,7 +1280,11 @@ static void decode_opc(CPURISCVState *env, DisasContext *ctx)
     }
     ctx->ol = ctx->xl;
 
-    ctx->cur_insn_len = insn_len((uint16_t)opcode);
+    insn_length = insn_len(opcode);
+    if (insn_length < 0) {
+        gen_exception_illegal(ctx);
+    }
+    ctx->cur_insn_len = insn_length;
     /* Check for compressed insn */
     if (ctx->cur_insn_len == 2) {
         ctx->opcode = (uint16_t)opcode;
-- 
2.43.0


