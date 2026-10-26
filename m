Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0153C606A31D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 16:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=m1lLnyGe;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YpgdFLkZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLNSk-00021z-NQ; Mon, 26 Oct 2026 12:22:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLNSd-0001Vb-Q8
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 12:22:11 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLNSb-0000dk-Uz
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 12:22:11 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QEvYpw470733
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 16:22:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 T+ldatT/v+MMal47aeSA46zdTbwHMa8JmqbtgmDlWGQ=; b=m1lLnyGebtR4zkMS
 dBfh7S9/yqGVIU2v1wxITW5b7iVzSrr6en8MUKTgIJlQrj8nfXE3zM8XBq/w1rhU
 jgOkuRQ92TZvUPNeEwKaGcindJE5nUoIK+NbyvaKu4iqQDgOa1vCGm1k4o7Bd6Lf
 u3qXAK7YMktKIrKekE66N/AmXDHVg/yS4kidUCp45Savm3+hWzUaOETcGjoCmoS5
 dBaLaFsa7nkkfmnzN3o5kwYUExa5nY2wIO8xFewNw/vPNhzrcsfXrKh9D+p4Dihl
 4VJVef7oY65zqlJZ8chSvjnPmMtR2BNMwgGbL7k1rydAQ0Zt9lwSiUxRKdqBmSag
 4Pv/+A==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj53q1brj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 16:22:08 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-7b206156cc6so3209067137.1
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 09:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793031727; x=1793636527; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=T+ldatT/v+MMal47aeSA46zdTbwHMa8JmqbtgmDlWGQ=;
 b=YpgdFLkZnXTg5w9W7idS1H4BJDKdj8Mth3Al8Z1pO/O9CXLb15bs3YqoaD1J+h0bm7
 BokujxOxvYERZ+98Ne3zshqVM2NPrR1s4vrAJ0tLOQM24C4D22LXjxqn6IIohh1APxqQ
 p/p4LQDU0y31BencFrc40EPpCdxfeJGj8BksKVoxg/5RC1eJENPZpbfW3zbjgt/dHFa5
 FoE7okrVM+ttS4rmXc7J3FYpQe0eE06AmTiWwDqygTVrkjZQiqQjqjl/bx8uhXdjdXFm
 PMih+A1QxJkkDhcSkmzWinLQXUaVKIKdhwSg/qnZnlr47afQiiII3NVJCJcPO1JzhxR/
 g7DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793031727; x=1793636527;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=T+ldatT/v+MMal47aeSA46zdTbwHMa8JmqbtgmDlWGQ=;
 b=Z2nIEMraSoCP7ziRkhxDhx0ErzdSoxW2R7npMv7ybN/T6UvraWSBpnI4Zv4brjGcd2
 cZRtA9ZObDWgzDCzqRxgG8I18uA68Uc+AW2uonGh1ko1d7e7mlns8xVNSaLIxPk9LXiQ
 6szzj2AXfqvl0p/U/fCfwLISzvpS+NaXcS5zkpWgpK2x4FRiojxsGqljrANHqquX630n
 U5FKU2x/+pW7ww1UP7YpaIE9Qf9G7Q0pPg1nSi+ESDCNhQMkMPdFVilQj3Dir58JgO55
 xaRvsjGMUvhVtWuOgd1ufa9zUi6pwNwb78QrcMjoo+ebOLNwq3yoxZGj8AP6eLkuizb+
 uXyQ==
X-Gm-Message-State: AFq9FYLVrU4zHac1QLx0uFaQfpseC8gnrSLaywQN9djYS4NdURpAgid+
 TOkHPaIbtP/dRwBRkXgBSlnr+2iMV4tvwaVNiWBYsYI0H03XdKSLzDWk45LoF9HXl3MxXEZnRu7
 Dfbo3SLfU/Kv0vQ8pbqGruppCWhDtGR2Fob5/ZYnZKoYYuGa91Y7FRRhxfaG3ob03Vg==
X-Gm-Gg: AYBFou1eeVynemSyhWU3oVtXGmrlwN6xqprzakarD5PiVJ87OgjhAJgB2xUb0zx4MLv
 UEszezw9Af762Cqc3XsQ5UcxH/zUqbJ7xM1DkxVnIBP3RTRLq5JCJlJpSqQsduXz6ObtzxvE/Wf
 4GO4x55vytg8iTy4qZi57ayxoQAK+iRJuyYFRwlDnfqJCyF347VSKJSVwmBNlUW0zuiOA02pOJu
 y3wiqTh+xPMCvOFDF+cRCcf40uVavzkh6Kg2BH4oxStT76/n3zZZaNxBR02i/4GfUNn3c6eLNyU
 BBiyrq5EFs546FttF0FYbpIGyeWueiA1kbv6+ggH9rwa+BMYNlB5RnT3+cpD6HWb8rU33zW2/+S
 zGdyRY07WVll2q56yG8I1SM52PVzFR5UaRvYQ0+j6
X-Received: by 2002:a05:6102:604b:b0:7cc:9d46:f062 with SMTP id
 ada2fe7eead31-7ce5cc937cdmr2209299137.17.1793031727312; 
 Mon, 26 Oct 2026 09:22:07 -0700 (PDT)
X-Received: by 2002:a05:6102:604b:b0:7cc:9d46:f062 with SMTP id
 ada2fe7eead31-7ce5cc937cdmr2209265137.17.1793031726806; 
 Mon, 26 Oct 2026 09:22:06 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a0bb112sm222891735e9.8.2026.10.26.09.22.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 26 Oct 2026 09:22:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v4 12/14] target/mips: Convert microMIPS LI opcode to
 decodetree
Date: Mon, 26 Oct 2026 17:20:31 +0100
Message-ID: <20261026162034.32711-13-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026162034.32711-1-philmd@oss.qualcomm.com>
References: <20261026162034.32711-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA2NSBTYWx0ZWRfX5u4+kWWfOZWf
 2qEUq7UCrO4dyVw63d6N9nAAQ5JwUpf5k72veYf0zdjWn6JPMzfoXNuRZo455IPcBMMowuQGQpr
 /JLjsmzXB8bAtMxE0ZAiwiP9Rdf459g=
X-Proofpoint-ORIG-GUID: kifo3K4eZJdxfmwYY7RSZssOUcKSmq2f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA2NSBTYWx0ZWRfX3c35/4ofH6gP
 Cne8sOVtxetGMufCFI9QPfiHTg8bbYEegKuk9bynbXiDD/rOBCl0oMLnYAqwTAiD+rJDsp+0Yni
 g9EgntvOxyDrvOHemzupsGDSdv/xSq5z3vKNWZ/yqr3R4QNYSYUPDRMHe3qpV4ePUvIxe5CBjDO
 l76GOADyVF4fUopPK30NtslLClHOAVZd0cnZy3twvsqBUoIK54W9tJt+JnesRvqHCZbb5ZK75Bs
 gjxmN97kCtxW+nfXiduWY/lGqsjjegk23EExXXXbr6leP673iWpbj3tVIJiIPU9OvPPsag+pv7y
 rGoiHw0geoCqY9oOjEuJBmUn+WnkKO5A1FjKPjEYCnzjAmIxb3qhfxQ65Xl6l8onuXVvVQbXmKb
 VF/a0EsI3Swk6/KcLeXoDjipy0+23P9wcLPV2UPLuHFcxnBpjdFrq+Xc9SZkflUh2KLVC2Sk5x3
 vIlmmuijJuTq2bT2N6Q==
X-Authority-Analysis: v=2.4 cv=D93SufRj c=1 sm=1 tr=0 ts=6adf7e30 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=vOBsFBfdn5dWXIoTpcwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=gYDTvv6II1OnSo0itH1n:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: kifo3K4eZJdxfmwYY7RSZssOUcKSmq2f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260065
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Decode the destination with xlat(), and the immediate
with li16_imm7() (0x7f encodes -1), then call gen_li().

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
Since v3:
- Rename simm7() as li16_imm7(), drop the single-use format
- Helpers no longer declared inline
---
 target/mips/tcg/micromips16.decode        |  7 +++++++
 target/mips/tcg/micromips_translate.c     | 12 ++++++++++++
 target/mips/tcg/micromips_translate.c.inc | 10 ----------
 3 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/target/mips/tcg/micromips16.decode b/target/mips/tcg/micromips16.decode
index 4b1f04299132..e4f193c79989 100644
--- a/target/mips/tcg/micromips16.decode
+++ b/target/mips/tcg/micromips16.decode
@@ -9,3 +9,10 @@
 #            (Document Number: MD00582)
 #            microMIPS64 Instruction Set
 #            (Document Number: MD00594)
+
+&rd_imm         rd imm
+
+%rd3            7:3 !function=gpr3_m16
+%li16_imm7      0:7 !function=li16_imm7
+
+LI              111011 ... .......          &rd_imm rd=%rd3 imm=%li16_imm7 # LI16
diff --git a/target/mips/tcg/micromips_translate.c b/target/mips/tcg/micromips_translate.c
index 2a2b5aaa4530..8d9b31a5ddf8 100644
--- a/target/mips/tcg/micromips_translate.c
+++ b/target/mips/tcg/micromips_translate.c
@@ -14,6 +14,11 @@ static int plus_1(DisasContext *ctx, int x)
     return x + 1;
 }
 
+static int li16_imm7(DisasContext *ctx, int x)
+{
+    return x == 0x7f ? -1 : x;
+}
+
 /* Include the auto-generated decoders.  */
 #include "decode-micromips16.c.inc"
 #include "decode-micromips32.c.inc"
@@ -23,3 +28,10 @@ static bool trans_LSA(DisasContext *ctx, arg_r *a)
 {
     return gen_lsa(ctx, a->rd, a->rt, a->rs, a->sa);
 }
+
+static bool trans_LI(DisasContext *ctx, arg_rd_imm *a)
+{
+    gen_li(ctx, a->rd, a->imm);
+
+    return true;
+}
diff --git a/target/mips/tcg/micromips_translate.c.inc b/target/mips/tcg/micromips_translate.c.inc
index 88ec1668bd8b..d6a5c2263b56 100644
--- a/target/mips/tcg/micromips_translate.c.inc
+++ b/target/mips/tcg/micromips_translate.c.inc
@@ -113,7 +113,6 @@ enum {
     BLTZALC = 0x38,
     BLTUC = 0x38,
     SW16 = 0x3a,
-    LI16 = 0x3b,
     JALX32 = 0x3c,
     JAL32 = 0x3d,
     BLEZC = 0x3d,
@@ -3223,15 +3222,6 @@ static int decode_isa_micromips(CPUMIPSState *env, DisasContext *ctx)
                            (ctx->insn_flags & ISA_MIPS_R6) ? 0 : 4);
 
         break;
-    case LI16:
-        {
-            int reg = gpr3_m16(ctx, uMIPS_RD(ctx->opcode));
-            int imm = ZIMM(ctx->opcode, 0, 7);
-
-            imm = (imm == 0x7f ? -1 : imm);
-            tcg_gen_movi_tl(cpu_gpr[reg], imm);
-        }
-        break;
     case RES_29:
     case RES_31:
     case RES_39:
-- 
2.55.0


