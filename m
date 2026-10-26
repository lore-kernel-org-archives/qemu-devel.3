Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364C8606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 16:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VXNfIgql;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YBdt+Ok7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLNSf-0001Zc-K1; Mon, 26 Oct 2026 12:22:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLNS9-0000vf-84
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 12:21:46 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLNS7-0000br-DE
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 12:21:40 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QEvvQx3567430
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 16:21:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3okr9sWXDLnFonX1a2zwvcyDEpU9mz+nbZYc+1yw4fQ=; b=VXNfIgqlPszyv+1f
 OcA6a/UofBusyWZU8iYIvkpXe+6Vmi58h3cFOUv2NDh8AiR1+rVVyyrjz0+Uy7Ui
 UyIyVJ5De+E4UrlcfAIvbwEdw3cV13pDQFciONBEr4ToWHwCkCcN4FbPXpI8JZ1H
 D0WccBUvwhWHzQAhv22xsCvUNgMjWIcrdN01DJgmcWmCRu9/tkANyc8/UUG79juY
 biMckaM/d9Gm/NgXOYr+PELCtmbzvHz81cN9SrxnqR+6Bgc2wxZjgxx/vFvQaM8Q
 ViemglLMqV1xDtXcaOZkXNQvDySwC0reFzwitInzzQLne3O/hgkDHqeEUomNux+V
 XdEOyQ==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj56y1a8v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 16:21:38 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-5eaad995a7eso572823e0c.3
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 09:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793031698; x=1793636498; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3okr9sWXDLnFonX1a2zwvcyDEpU9mz+nbZYc+1yw4fQ=;
 b=YBdt+Ok7cZLOYM7pdDPP1zjb5IMHqX0lxNIYT6ycsGOueblnTXuzARjPPhbGqVI9pI
 j2ppO0CEzaHPjGQpfv2CPGnagh6jDjmOk10XsCdNZMkbZXLS7sXonGgnZfqhiR9Shcds
 DUrwJBXotyDrC4y06H5pMLnX+Z8ryg9EXHoOGlarrbC0p2Aj0nER8wAqOH7c6B5aDQfD
 AN40nUNplxX6te7zTrET2dO4mrtCdXSPe70x+MPtup4/U26U9LPUL0fkjxkgo6eO1pXF
 75MWvFQR2xL+ei6O53VbHaRWCZyaJhkkNi+qzP2C4vSgKO50/hPhWEQAdUJnvN374K8m
 4nFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793031698; x=1793636498;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3okr9sWXDLnFonX1a2zwvcyDEpU9mz+nbZYc+1yw4fQ=;
 b=s7f30PM3ArHgjBATNFlhCth1PCtmNCMWjmNMxArLRYztwM1BLm8Nq9x6wKX0t5KYp5
 uZCKgeBvDQyu7QOGTWsPp2V/sComdk0euo4Qo239B9UszmqXPjMEURqZkWa6svrP1VKq
 zrD4gt7rmrkrYIPOTou/WGsWPHteXGC+B3p7IIf+mC9kO1DvY6btF2FHpQzixcCY1Bpb
 MCo+XHzuyvlPtrPPtSgcVCcpOc/uhGOecs1SxpYWgNFAOiJiZ8RePOLx9F3iVkWfKCYb
 IYRXycxxrtrPq0PcOJXQ5UksKu2sqSDBXSQPYGGUKRE7f6vob2tlyY/ue9Iq2bXBPBye
 +fgQ==
X-Gm-Message-State: AFq9FYIh/dDvqfO4IiGvOC9+373qPxYFt3/SYNyteGUryIo7Nn85QOIG
 9rSTdyDbR5jUR1f/a7JcrLzPT5/NFF9dGtdAvCE4x+9FTaCNfNwmoohrSkBdcU8G7AKqnS8a8aw
 6CAHvBKTNluSP5xdmh7s8sW0ryPFyr7qIhng6jgdMkoJ7vDgK197UjKQCO56ZVcUsYw==
X-Gm-Gg: AYBFou0Nwn395zzZdv536ER1+wl4RlLC9cUTrtsHhhFlGNj2D/5Zwz7sU2xhIdF++N5
 4hvmXMhvAzVYoDiET5wFzp0X6+KB1dTC98YN6AwnOmyqom4scPqyJWWN17IRaDyrvnc2mY1xV9s
 hK1NpDu6kmKoe8TY4giwxEcHWRmEnP/x+0oBqUNLQgCLjar4nZqaIa87/LDx4SaX1KFuFmAUPl8
 tkRCbdbRTzqapWo2hVxW0wmvOI58Hv764Tf7NoBLLu2w+Io1yC6xvI8EOmjZrn/zz+c8bak2IuC
 +Mlc6sG3HhjRnMA6gETInTbmY7btBvzwy78g0/rFtaHs8C13zEuuQWGnD+dEM+zRvLnGw6Riim+
 ZOXnyIH1erNYUPnj4LYIsAetyM/GtCZhNzWeEekCy
X-Received: by 2002:a05:6122:1798:b0:5ea:e324:7c0c with SMTP id
 71dfb90a1353d-5ec233198f1mr2658166e0c.22.1793031697634; 
 Mon, 26 Oct 2026 09:21:37 -0700 (PDT)
X-Received: by 2002:a05:6122:1798:b0:5ea:e324:7c0c with SMTP id
 71dfb90a1353d-5ec233198f1mr2658123e0c.22.1793031697164; 
 Mon, 26 Oct 2026 09:21:37 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecdd5b3sm17204358f8f.53.2026.10.26.09.21.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 26 Oct 2026 09:21:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v4 08/14] target/mips: Convert microMIPS LSA opcode to
 decodetree
Date: Mon, 26 Oct 2026 17:20:27 +0100
Message-ID: <20261026162034.32711-9-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026162034.32711-1-philmd@oss.qualcomm.com>
References: <20261026162034.32711-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA2NSBTYWx0ZWRfX99775wXphUsW
 /athJyMU4+OPII0LUs8MpF9KHNPyK8GUa5Zi0iPshdQcZeaClIrYWBz1I4elB7RRzF4jmnFC7XQ
 I4cGjP+8EUwEkZz+40TJyXujoDqrjWs=
X-Authority-Analysis: v=2.4 cv=eMeGH3p1 c=1 sm=1 tr=0 ts=6adf7e12 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=wz6AJgg05Mc9BV8Zt_oA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=tNoRWFLymzeba-QzToBc:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA2NSBTYWx0ZWRfXwyF89vMMzHTu
 8TYJjGkhLHUsTx9Xl7GuG1K7ZhnSyjW2XjPJXpr5eWmd677QqJOFpy2WyYR5z5Ax2MQI/tXjTnB
 6HNncLsXToyMoy/YDi4dQJKGOXn4rsIFLsCvVUhs0VXmuJUnUw4DwaCuluEltS6lhnDGGhAZmqS
 CFjTmamw6mBMdFPpayM47eggAI4yN00O70vp8QD4mb4wjkjFaqD/VI12GC1tt2NrmYaZ8aUvukS
 p1yEDg8We+5a1nyQy1komQ0ciO/2f1am+3WRspLcREIvBRpeiMtyzGLWPCodqnHtKt/iIoSdRfH
 MkWQBcBKN7OML/+HHWvt1bpedWda/B41pwHtTyYBJxRzOmVVHBdUt7oiZwErEuHvdkulimqrxQi
 o7H5E2j5EdySgsENZeZCPlUXs9BxaA9dBxTZnmMJ0Nhdvex1QxxTGo0Y4/aBduU6ekCgzZW+ExF
 IgWfiEzf4oteErsMlIg==
X-Proofpoint-GUID: Pq0SW9NTQHbi3kczSTi2GU2Ns8Y3qtZP
X-Proofpoint-ORIG-GUID: Pq0SW9NTQHbi3kczSTi2GU2Ns8Y3qtZP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 phishscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260065
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

Call the generic gen_lsa(), using plus_1() to add 1 to
the shift amount. LSA is a Release 6 instruction: add it
to micromips32_r6.decode, which is only called on R6 CPUs.

The legacy decoder only matched bits [5:0]; the pattern
also requires bits [8:6] to be zero, as specified. Other
encodings now raise a Reserved Instruction exception.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20241112172022.88348-6-philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
Since v3:
- Move LSA to micromips32_r6.decode; v2 accepted it on
  pre-R6 microMIPS CPUs
- plus_1() no longer declared inline
---
 target/mips/tcg/micromips32_r6.decode     |  8 ++++++++
 target/mips/tcg/micromips_translate.c     | 10 ++++++++++
 target/mips/tcg/micromips_translate.c.inc |  5 -----
 3 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/target/mips/tcg/micromips32_r6.decode b/target/mips/tcg/micromips32_r6.decode
index 5786947c7c96..35f7afe53bd2 100644
--- a/target/mips/tcg/micromips32_r6.decode
+++ b/target/mips/tcg/micromips32_r6.decode
@@ -9,3 +9,11 @@
 #            (Document Number: MD00582)
 #            microMIPS64 Instruction Set
 #            (Document Number: MD00594)
+
+&r                  rs rt rd sa
+
+%lsa_sa             9:2  !function=plus_1
+
+@lsa                ...... rt:5  rs:5  rd:5  .. ... ......  &r sa=%lsa_sa
+
+LSA                 000000 ..... ..... ..... .. 000 001111  @lsa
diff --git a/target/mips/tcg/micromips_translate.c b/target/mips/tcg/micromips_translate.c
index b30c0119996c..2a2b5aaa4530 100644
--- a/target/mips/tcg/micromips_translate.c
+++ b/target/mips/tcg/micromips_translate.c
@@ -9,7 +9,17 @@
 #include "qemu/osdep.h"
 #include "translate.h"
 
+static int plus_1(DisasContext *ctx, int x)
+{
+    return x + 1;
+}
+
 /* Include the auto-generated decoders.  */
 #include "decode-micromips16.c.inc"
 #include "decode-micromips32.c.inc"
 #include "decode-micromips32_r6.c.inc"
+
+static bool trans_LSA(DisasContext *ctx, arg_r *a)
+{
+    return gen_lsa(ctx, a->rd, a->rt, a->rs, a->sa);
+}
diff --git a/target/mips/tcg/micromips_translate.c.inc b/target/mips/tcg/micromips_translate.c.inc
index 7528591b1ab4..6eb8e79ec57b 100644
--- a/target/mips/tcg/micromips_translate.c.inc
+++ b/target/mips/tcg/micromips_translate.c.inc
@@ -191,7 +191,6 @@ enum {
     /* The following can be distinguished by their lower 6 bits. */
     BREAK32 = 0x07,
     INS = 0x0c,
-    LSA = 0x0f,
     ALIGN = 0x1f,
     EXT = 0x2c,
     POOL32AXF = 0x3c,
@@ -1799,10 +1798,6 @@ static void decode_micromips32_opc(CPUMIPSState *env, DisasContext *ctx)
         case INS:
             gen_bitops(ctx, OPC_INS, rt, rs, rr, rd);
             return;
-        case LSA:
-            check_insn(ctx, ISA_MIPS_R6);
-            gen_lsa(ctx, rd, rt, rs, extract32(ctx->opcode, 9, 2) + 1);
-            break;
         case ALIGN:
             check_insn(ctx, ISA_MIPS_R6);
             gen_align(ctx, 32, rd, rs, rt, extract32(ctx->opcode, 9, 2));
-- 
2.55.0


