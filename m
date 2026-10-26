Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21802606A31F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 16:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=It6aQntl;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PS10Uxsf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLNRL-0008TJ-0V; Mon, 26 Oct 2026 12:20:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLNRI-0008R1-ST
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 12:20:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLNRG-0000Sn-Ts
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 12:20:48 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QEvowY4168190
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 16:20:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 veNFh+Ah8cBEvcVLwZqeSFeqxYngP7EtU6xw8tnxB7A=; b=It6aQntlLzKr97y7
 EArbWk0+PuVIM60dXthBFtaJ24O0d1H2OKGAOFuIXxSZcyY5zSxU7MxKz0D5xWmF
 JIMJ3e30wWyefKgoCtAUH/CtuFdfVGPRbkBkRT1VAJm7+lCIEMQVo342S78RNaOa
 pPY6P+OtNIUwWOnvxmTqgDy32UlBoTKuDDuwQiilDwL91qaMn1hFwVXa7WFCs689
 S5sGpsyCpyROR/Czz3uGma8U6n0aoomjF/I65iQyKgK39zDWdq5zgV6ms2HXj205
 9wguYSdm/20MTPM5v9BYZx/6xzyDugUZSmUuW6MGqvHYGdTryXcRxvyWXPotS5+L
 lMryMA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj4sf1epa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 16:20:45 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f2373e9b4so339123585a.1
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 09:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793031645; x=1793636445; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=veNFh+Ah8cBEvcVLwZqeSFeqxYngP7EtU6xw8tnxB7A=;
 b=PS10Uxsf3LUZacqr2tsZN1vxIyqHwb4jhFFispe5ItuZ8yiTZHP6NkIFF9rTwkpYmQ
 yBgtn6OXb5wlhATypi4SoA4k9anryMQr2gY0td4YybybZ8bQISaDxfV1aqUkko3pBkMx
 3WG6zlJSqntyJ3Wq4Yc6y8Y1r5L0c6iWZpcj3hyBg0+LS4ONd9mvO6Tb/JP96/vwMAPO
 S25dshJTuXoE3W5cAsJN1PzUKG1RBKqlbhWdxQWqdWdzssPdxLnxLVAtbKKcgi8qoXyO
 OTIawvkyTrYxBnjx1ks7B0VTrtcoe7NnlyjEzZ8bfYvkXxRdnqsdO61cnYG+EWdzhcUC
 4F8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793031645; x=1793636445;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=veNFh+Ah8cBEvcVLwZqeSFeqxYngP7EtU6xw8tnxB7A=;
 b=QXgkkxwSNI7xNcI9z27E45RGjyr+3YWR8WeIzfYR242+2fUnXqU/887wCGfIhrU8+q
 u6UH6TqNqXbqD2vphsAycQwxqCu/6sBi79z/VVPbjdE9i2eo2NMVSu4jicqHJHDmOTh3
 vN4fMvvfSvPdgmdRUnvHpwTS0lmduS0qIcFwGo0WilmT5HtHWOFmijGKIdVCsakrPJkB
 oWEv/gtu1jS/EPGo+ruUWK0CcuoFi4Q3LYmxOpvNElggjbB//+IRN6BvK21IyoLUpP1s
 RIt0VBui8P+YbIX7sQrX96i/9pGWe+nuNP3fZl9cdKwNFbRUqrf7/XZAU9z1qlevtx6M
 gbFg==
X-Gm-Message-State: AFq9FYKHt5mdb9AlpbUCI3qRyJV3EO+728DrkO1APonQa87SB/Irmon1
 Rf78n/PBFi9QcymrAxy900hGhawlY+qINrYZsU8SuzE8WgEeGj56Df+JXMhJc5/laMyvWgrhrPX
 1T26oE1JkLLHHWexedl13OWFPi/dAPjJfn+cM/y1hE2yUZVjs/BSYIRe/nZd+Wp7xTw==
X-Gm-Gg: AYBFou1lS3MACGJSxhIS2fZtGShJ3dLRVapbDudNcUPxOzQ5Z4DnuaFq7ENI69B6Qm1
 U54QtcqYNBKIRX0WVt3ZshZXfAJ2p6lIvUZUEaJRUqUvFxSEP+0fASrBnYpcyOKdgsMG5CATBpo
 PrI/gcxbIlrvl7JC9dThTlmudUDXilRp2D8dtxHAFisMu1RGX9voGW9wIQ2YsIcVWszqrhNCO9j
 hX6KcYFoekK5ujOXcS6qj+t7zAGI1qib7h9V0TWHCAlAdQnZ5XB6yU+CQd0A1+YSonMS87p0V//
 jNidDN6obsyNkR+CriDV/XtkwfRicNQ8W9qh+fIMgV/175bm728oQo8fyFuwpoAXmgI4tsjEyRo
 Q1Dibp+WevNVxNRpYuvNwzu6gvFUeeUxB3RJZ5j6jQQiQC8p6BJFlS48gwGr9Gkq6yxnCWCkFEQ
 qcbqQ71RR0OX84Lw==
X-Received: by 2002:a05:620a:4542:b0:93f:2bc8:283d with SMTP id
 af79cd13be357-940ef95fe8bmr983436785a.47.1793031644899; 
 Mon, 26 Oct 2026 09:20:44 -0700 (PDT)
X-Received: by 2002:a05:620a:4542:b0:93f:2bc8:283d with SMTP id
 af79cd13be357-940ef95fe8bmr983430985a.47.1793031644302; 
 Mon, 26 Oct 2026 09:20:44 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a04ad39sm539622035e9.1.2026.10.26.09.20.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 26 Oct 2026 09:20:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v4 01/14] target/mips: Call translator_ld() in
 translate_insn() callees
Date: Mon, 26 Oct 2026 17:20:20 +0100
Message-ID: <20261026162034.32711-2-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026162034.32711-1-philmd@oss.qualcomm.com>
References: <20261026162034.32711-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA2NSBTYWx0ZWRfXxUcAUL77UI9R
 gAFFk43x06+bq8sJgXrtQVumZQStGAS7/tjWKaZGwPb3ab/Fwi57p6pLFsilOub/kwPBz0dUE94
 HZzl6upRBrD8gky8COmTFfE5brVIBjk=
X-Authority-Analysis: v=2.4 cv=ZOdCCn7b c=1 sm=1 tr=0 ts=6adf7ddd cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=DdBj6WcCB6XYcVw86CkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: NROQWuLJWyh8e08Ch9CkduNNXKxVpVUa
X-Proofpoint-ORIG-GUID: NROQWuLJWyh8e08Ch9CkduNNXKxVpVUa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA2NSBTYWx0ZWRfX4Wpv+PVVDbwP
 Od8CQArM8NTLijzffpBJDLtZxkezR0ggGI5uhx8wKtxMlNOrXGpZS/e2UiIeDhnCMRJ/aNIPUUk
 /YyWcSu0cwhuEnUiMJ9513ezo1wARLjIutWAVEo6RAauA1jb//t/+SXoFUrpJ17nC8r+8Lj0vnr
 FNzJgqaDdSdlfvfxxcKD9S439nIPw3iKC6YiGjT9QC4ibG1dHUUjl7ABAo/Ad+f7IHvKZ7v3zoM
 8wU+EG+ccMLMrwjvIuXeOAQTNqDtNzTQumVLMWVpIvv+wH8zMA0vZlk2eWl9ZUTzYRBAstqsrxw
 RDEVpVAHnYX7e6i3MjfWTcpUE4jw7YmuJdisR3+cw7YuqAscUfnVevEKOVUqrrTKo2gc2fwItLo
 lo3xhb41p2rM6wuoxKTYIXS2Lt1oSEqM9P086uoOTu5E9KltRq6LlwTuV7drNj68MIl5GB5/Lxw
 Dh9kUhGuNpilwVycmMw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 spamscore=0 bulkscore=0 impostorscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610260065
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Historically we were only calling decode_opc() from the MIPS
translate_insn() handler. Then variable instruction length
ISAs were added, we kept using the same pattern but call
yet more translator_ld() in the callees when necessary.

This is cumbersome and bug prone, so better move all
translator_ld() calls to the callees where it is more
logical.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
Since v3:
- Rebased on translator_ld*_end() API, passing mo_endian()
---
 target/mips/tcg/translate.c               | 11 +++--------
 target/mips/tcg/micromips_translate.c.inc |  4 ++++
 target/mips/tcg/mips16e_translate.c.inc   |  9 ++++++---
 target/mips/tcg/nanomips_translate.c.inc  | 13 ++++++++++---
 4 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 936f8c4eddc4..69c82af046a0 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -15050,6 +15050,9 @@ static void decode_opc(CPUMIPSState *env, DisasContext *ctx)
         gen_set_label(l1);
     }
 
+    ctx->opcode = translator_ldl_end(env, &ctx->base, ctx->base.pc_next,
+                                     mo_endian(ctx));
+
     /* Transition to the auto-generated decoder.  */
 
     /* Vendor specific extensions */
@@ -15175,21 +15178,13 @@ static void mips_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
 
     is_slot = ctx->hflags & MIPS_HFLAG_BMASK;
     if (ctx->insn_flags & ISA_NANOMIPS32) {
-        ctx->opcode = translator_lduw_end(env, &ctx->base, ctx->base.pc_next,
-                                          mo_endian(ctx));
         insn_bytes = decode_isa_nanomips(env, ctx);
     } else if (!(ctx->hflags & MIPS_HFLAG_M16)) {
-        ctx->opcode = translator_ldl_end(env, &ctx->base, ctx->base.pc_next,
-                                         mo_endian(ctx));
         insn_bytes = 4;
         decode_opc(env, ctx);
     } else if (ctx->insn_flags & ASE_MICROMIPS) {
-        ctx->opcode = translator_lduw_end(env, &ctx->base, ctx->base.pc_next,
-                                          mo_endian(ctx));
         insn_bytes = decode_isa_micromips(env, ctx);
     } else if (ctx->insn_flags & ASE_MIPS16) {
-        ctx->opcode = translator_lduw_end(env, &ctx->base, ctx->base.pc_next,
-                                          mo_endian(ctx));
         insn_bytes = decode_ase_mips16e(env, ctx);
     } else {
         gen_reserved_instruction(ctx);
diff --git a/target/mips/tcg/micromips_translate.c.inc b/target/mips/tcg/micromips_translate.c.inc
index 07172a6c7fe0..0984b8a505dd 100644
--- a/target/mips/tcg/micromips_translate.c.inc
+++ b/target/mips/tcg/micromips_translate.c.inc
@@ -2979,6 +2979,7 @@ static void decode_micromips32_opc(CPUMIPSState *env, DisasContext *ctx)
 
 static int decode_isa_micromips(CPUMIPSState *env, DisasContext *ctx)
 {
+    uint32_t opcode;
     uint32_t op;
 
     /* make sure instructions are on a halfword boundary */
@@ -2988,6 +2989,9 @@ static int decode_isa_micromips(CPUMIPSState *env, DisasContext *ctx)
         return 2;
     }
 
+    opcode = translator_lduw_end(env, &ctx->base, ctx->base.pc_next,
+                                 mo_endian(ctx));
+    ctx->opcode = opcode;
     op = (ctx->opcode >> 10) & 0x3f;
     /* Enforce properly-sized instructions in a delay slot */
     if (ctx->hflags & MIPS_HFLAG_BDS_STRICT) {
diff --git a/target/mips/tcg/mips16e_translate.c.inc b/target/mips/tcg/mips16e_translate.c.inc
index e83587971d4e..eb77326acf6b 100644
--- a/target/mips/tcg/mips16e_translate.c.inc
+++ b/target/mips/tcg/mips16e_translate.c.inc
@@ -453,12 +453,9 @@ static void decode_i64_mips16(DisasContext *ctx,
 
 static int decode_extended_mips16_opc(CPUMIPSState *env, DisasContext *ctx)
 {
-    int extend = translator_lduw_end(env, &ctx->base, ctx->base.pc_next + 2,
-                                     mo_endian(ctx));
     int op, rx, ry, funct, sa;
     int16_t imm, offset;
 
-    ctx->opcode = (ctx->opcode << 16) | extend;
     op = (ctx->opcode >> 11) & 0x1f;
     sa = (ctx->opcode >> 22) & 0x1f;
     funct = (ctx->opcode >> 8) & 0x7;
@@ -659,6 +656,8 @@ static int decode_ase_mips16e(CPUMIPSState *env, DisasContext *ctx)
     int funct;
     int n_bytes;
 
+    ctx->opcode = translator_lduw_end(env, &ctx->base, ctx->base.pc_next,
+                                      mo_endian(ctx));
     op = (ctx->opcode >> 11) & 0x1f;
     sa = (ctx->opcode >> 2) & 0x7;
     sa = sa == 0 ? 8 : sa;
@@ -1105,6 +1104,10 @@ static int decode_ase_mips16e(CPUMIPSState *env, DisasContext *ctx)
         }
         break;
     case M16_OPC_EXTEND:
+        ctx->opcode <<= 16;
+        ctx->opcode |= translator_lduw_end(env, &ctx->base,
+                                           ctx->base.pc_next + 2,
+                                           mo_endian(ctx));
         decode_extended_mips16_opc(env, ctx);
         n_bytes = 4;
         break;
diff --git a/target/mips/tcg/nanomips_translate.c.inc b/target/mips/tcg/nanomips_translate.c.inc
index 4b0b01ba37ad..421f26a192cb 100644
--- a/target/mips/tcg/nanomips_translate.c.inc
+++ b/target/mips/tcg/nanomips_translate.c.inc
@@ -4463,10 +4463,11 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
 
 static int decode_isa_nanomips(CPUMIPSState *env, DisasContext *ctx)
 {
+    uint64_t opcode;
     uint32_t op;
-    int rt = decode_gpr_gpr3(NANOMIPS_EXTRACT_RT3(ctx->opcode));
-    int rs = decode_gpr_gpr3(NANOMIPS_EXTRACT_RS3(ctx->opcode));
-    int rd = decode_gpr_gpr3(NANOMIPS_EXTRACT_RD3(ctx->opcode));
+    int rt;
+    int rs;
+    int rd;
     int offset;
     int imm;
 
@@ -4478,6 +4479,12 @@ static int decode_isa_nanomips(CPUMIPSState *env, DisasContext *ctx)
         return 2;
     }
 
+    opcode = translator_lduw_end(env, &ctx->base, ctx->base.pc_next,
+                                 mo_endian(ctx));
+    ctx->opcode = opcode;
+    rt = decode_gpr_gpr3(NANOMIPS_EXTRACT_RT3(ctx->opcode));
+    rs = decode_gpr_gpr3(NANOMIPS_EXTRACT_RS3(ctx->opcode));
+    rd = decode_gpr_gpr3(NANOMIPS_EXTRACT_RD3(ctx->opcode));
     op = extract32(ctx->opcode, 10, 6);
     switch (op) {
     case NM_P16_MV:
-- 
2.55.0


