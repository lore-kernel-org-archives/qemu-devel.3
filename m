Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C642606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 16:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mRNiIpCW;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LiiVSx2/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLNSh-0001is-40; Mon, 26 Oct 2026 12:22:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLNSQ-00017H-1H
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 12:22:00 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLNSM-0000cd-S8
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 12:21:57 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QEvtYp3567341
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 16:21:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xFKlv/viOHvkjCoNEGti7ttWLhvnoRE4h/jdafN8Bv0=; b=mRNiIpCWbb3Dsdoy
 nk7Q6DvQaaZVwcEq4WQi+A3t6zAFG9yRutrWFcoXkJ6ssik5qF/nvdrZqAoSxOm5
 kbcBsejCFwl1HBmTBHttOicaLju0YSB5887telzWHrigLU87ts2BLn3XQtzcc8eC
 Wlhw5pStGJ+TdVo80ych14yiJhPi02Ra9rjnle+cUenATBDlBPrGNmz9iqXef1Zb
 7xlDWJfvgifeUAY8IcE6HOOQzmPhILG97abza4NO4vdOWkRRJ94JFZwoMoufAlHF
 P6jvh5H5y1N+ucRCgjS8qBbkv6IKTlAwbI5ry8ATZCsIWoXZskQ5KdUEkxtvOWzJ
 hpTuYA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj56y1aah-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 16:21:53 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f5844e383so567751085a.1
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 09:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793031713; x=1793636513; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xFKlv/viOHvkjCoNEGti7ttWLhvnoRE4h/jdafN8Bv0=;
 b=LiiVSx2/rwrnMa0fuAIXWgzlCN50/LhfkCMOycipNUga2QLnGpD4et14/mSi6u1Xqw
 zi5OhhYBczC/J97L2Hs7rzs/WrKbzxWBLltbuIZUvwm/cMuXgfYYZ0ZP504YB6N/8E51
 htJoZGfEPaZX4ITrbrJVmwDBUTq70zHHzWnI1J+ydV1YcGBECvxpR12Uvdo9pDuu3HSx
 VelC5vMtMids/8Dybv3TSM9AtWitX1xane63GieUFVy37H/8hUUtMG1iQ0bML3wI0x13
 25HVKnsp5LKv3+WxDNNc7iLPaedAT2M0tuer9HUEUDTRZd39orgpBdhayZsjdBUvtyGa
 ztHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793031713; x=1793636513;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xFKlv/viOHvkjCoNEGti7ttWLhvnoRE4h/jdafN8Bv0=;
 b=D/Ct9rLZGtQI2s8swyNjCUd4hzb1nCWB7IjBxGcnrRxyXCf/uvWjCcoz0dT/3uigZR
 cIfrUDKfZHv28tz6x0qw4ZNL3oy16Yidf3efup50l9XQb8NSk34naAAQTUSnT8l8RdQY
 kC6yrxTwsAnhI8+qQ9aMYf3N+87LtnCzQQeuP2FR08jJxdQLLXFCBDKPoSdCWVXZrfWy
 VcBcBCNYM9joAqNeVYDrW0v6164jkjOBaWpFMZDc7s5dWOSzWGg2CtmBDb3QBRw+PQeH
 K+CBeA2gRfgoupFeV2sMfhf7tgr1IoNtGg9MMABq9qYjMaJsqCWiNq8orMeaJr5zinAL
 qvGQ==
X-Gm-Message-State: AFq9FYIn62TGIJkbSGrLujG1REXzLT9sLSIZ+r/2o7CvxjYt0PC1zblj
 JfdKilE1lPeNQ+AvtYEKEfB8yo156Gx9rUKd4CrfS6KSEkOx7q1gts5+IPNYLGDQyGQArkrGcHb
 Pw1XWlyiCTUi/wz2xiN3z7EucKuUdPh+BQQhYvKHM5uXpSasxGIdEMwrvmtKeJR3UJw==
X-Gm-Gg: AYBFou0J4UXJvrBJKdfCDM/S9EreAtNk4mb2tjvwXPQTlYPH4UE79KivHg79B+CEbGf
 WUa5oeDcp2maQvTDFqzcVYd0meG9/8PjZqe3JiHLKR1jvFsGNqPMtXyNyLIEToX1V1ndQsVpMfP
 gxXphvsMcKNuyT4mrKYp6RVKuYjBe3/2IwO6sLjLjj+BHxT97p2WCrUhLP0WJ+Zhh3eIellc061
 wNbw0zoZOL5l5s/qSvAa7L7vt5kWeEGDyK6abNLbBGD3126J9b7yf2wH7asmdgIPGHGieNvt06F
 Arpr8hVV7Bpr5U7XlhEZfs9lblQtnuP6OahYMOk5gRZE0Tnx8aIjBfbL1Jo7uvVmM7lL1j8k+zx
 xpGX222dn/dkL43jldlKRym7l8yboRtQE+q4J+XrG
X-Received: by 2002:a05:620a:1a26:b0:93e:942f:b8b1 with SMTP id
 af79cd13be357-940ef9b8bcdmr1027395185a.64.1793031712324; 
 Mon, 26 Oct 2026 09:21:52 -0700 (PDT)
X-Received: by 2002:a05:620a:1a26:b0:93e:942f:b8b1 with SMTP id
 af79cd13be357-940ef9b8bcdmr1027388085a.64.1793031711660; 
 Mon, 26 Oct 2026 09:21:51 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a04ad39sm539728095e9.1.2026.10.26.09.21.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 26 Oct 2026 09:21:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v4 10/14] target/mips: Share MIPS16e/microMIPS 3-bit GPR xlat
 mapping
Date: Mon, 26 Oct 2026 17:20:29 +0100
Message-ID: <20261026162034.32711-11-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026162034.32711-1-philmd@oss.qualcomm.com>
References: <20261026162034.32711-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA2NSBTYWx0ZWRfX8z3FuPXJDxYP
 dv2jePM4hY5y5kFdf5nrssKcFYjpwxJAbYQrgn0CrwKiY/b6sYxZ8nGpghqelTaJXWxlNqjHGYP
 uqIZU5M7CQqdepVTgRZ2munbmCGqftM=
X-Authority-Analysis: v=2.4 cv=eMeGH3p1 c=1 sm=1 tr=0 ts=6adf7e21 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=m3IZ4kzmJbVghjqrMy4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA2NSBTYWx0ZWRfXwMvpAO4/2Wu8
 QFCsDziyDG76S3cyG6JJnoDkOMY7+8P+zQ3h971yCdNO0q20d5L04T5BHLOeZSzCgOYKU65gEy1
 B27OpFuhqOQvA82xMzMviU3XGMuS8MZ/MoVAPmdFIt2ioNzUTldDWJYSGJOZnocYC29m/qZ0NfO
 ked5EkFTV0FXJRfR02u/Jb5jaFHyb5oDEz9wtyDIVQNeMjnIRJZNoBENAwV1uLz8A5n1kIcryA5
 PtFJcdmouZlwgrkfjzNr+MPcJILyCjZ4oKuXSYi4hDrClqUbd32j6a5RuwJAUy53cYX5uPsCkNB
 sWPoNTkHvkauCxwK4Ky8ewh6C4bKQ5ENTstkgONan7atsPdiJRILGqq/0GKlLAtGsxBgvlVv3uP
 lN7+NVu2Fkrx7rN9Tg4VZeNqkoEPipNf/N8pkd0nxy+QQv8rsdL8+wPD+TP/4tYMWVNgeNPY5GD
 2AuLHRstoXLsMd2Qigg==
X-Proofpoint-GUID: o_MWbVoO0XN44RlCA-VJooyOmNvB_LCK
X-Proofpoint-ORIG-GUID: o_MWbVoO0XN44RlCA-VJooyOmNvB_LCK
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

The 3-bit register fields of MIPS16e and microMIPS 16-bit
encodings map to the same 8 GPRs. The map is duplicated,
and we want to re-use it for nanoMIPS. Rename as common
gpr3_m16() helper, using the decodetree !function signature
so both the legacy and the decodetree decoders can call it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/mips/tcg/translate.h               |  1 +
 target/mips/tcg/translate.c               | 11 ++++
 target/mips/tcg/micromips_translate.c.inc | 61 ++++++++++-------------
 target/mips/tcg/mips16e_translate.c.inc   | 19 +++----
 4 files changed, 45 insertions(+), 47 deletions(-)

diff --git a/target/mips/tcg/translate.h b/target/mips/tcg/translate.h
index d11b2f32f009..50b62b9dfd28 100644
--- a/target/mips/tcg/translate.h
+++ b/target/mips/tcg/translate.h
@@ -224,6 +224,7 @@ void mxu_translate_init(void);
 bool decode_ase_mxu(DisasContext *ctx, uint32_t insn);
 
 bool decode_64bit_enabled(DisasContext *ctx);
+int gpr3_m16(DisasContext *ctx, int x);
 
 /* decodetree generated */
 bool decode_isa_micromips16(DisasContext *ctx, uint16_t insn);
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 69c82af046a0..74c571c1c125 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -1623,6 +1623,17 @@ bool decode_64bit_enabled(DisasContext *ctx)
     return ctx->hflags & MIPS_HFLAG_64;
 }
 
+/*
+ * Map the 3-bit register field of MIPS16e and microMIPS
+ * 16-bit encodings to a GPR index.
+ */
+int gpr3_m16(DisasContext *ctx, int x)
+{
+    static const int map[8] = { 16, 17, 2, 3, 4, 5, 6, 7 };
+
+    return map[x];
+}
+
 /*
  * This code generates a "reserved instruction" exception if cpu is not
  * 64-bit or 64-bit instructions are not enabled.
diff --git a/target/mips/tcg/micromips_translate.c.inc b/target/mips/tcg/micromips_translate.c.inc
index 6eb8e79ec57b..88ec1668bd8b 100644
--- a/target/mips/tcg/micromips_translate.c.inc
+++ b/target/mips/tcg/micromips_translate.c.inc
@@ -605,13 +605,6 @@ enum {
     ADDIUR1SP = 0x1
 };
 
-static int mmreg(int r)
-{
-    static const int map[] = { 16, 17, 2, 3, 4, 5, 6, 7 };
-
-    return map[r];
-}
-
 /* Used for 16-bit store instructions.  */
 static int mmreg2(int r)
 {
@@ -637,7 +630,7 @@ static int mmreg2(int r)
 
 static void gen_addiur1sp(DisasContext *ctx)
 {
-    int rd = mmreg(uMIPS_RD(ctx->opcode));
+    int rd = gpr3_m16(ctx, uMIPS_RD(ctx->opcode));
 
     gen_arith_imm(ctx, OPC_ADDIU, rd, 29, ((ctx->opcode >> 1) & 0x3f) << 2);
 }
@@ -645,8 +638,8 @@ static void gen_addiur1sp(DisasContext *ctx)
 static void gen_addiur2(DisasContext *ctx)
 {
     static const int decoded_imm[] = { 1, 4, 8, 12, 16, 20, 24, -1 };
-    int rd = mmreg(uMIPS_RD(ctx->opcode));
-    int rs = mmreg(uMIPS_RS(ctx->opcode));
+    int rd = gpr3_m16(ctx, uMIPS_RD(ctx->opcode));
+    int rs = gpr3_m16(ctx, uMIPS_RS(ctx->opcode));
 
     gen_arith_imm(ctx, OPC_ADDIU, rd, rs, decoded_imm[ZIMM(ctx->opcode, 1, 3)]);
 }
@@ -681,8 +674,8 @@ static void gen_andi16(DisasContext *ctx)
 {
     static const int decoded_imm[] = { 128, 1, 2, 3, 4, 7, 8, 15, 16,
                                  31, 32, 63, 64, 255, 32768, 65535 };
-    int rd = mmreg(uMIPS_RD(ctx->opcode));
-    int rs = mmreg(uMIPS_RS(ctx->opcode));
+    int rd = gpr3_m16(ctx, uMIPS_RD(ctx->opcode));
+    int rs = gpr3_m16(ctx, uMIPS_RS(ctx->opcode));
     int encoded = ZIMM(ctx->opcode, 0, 4);
 
     gen_logic_imm(ctx, OPC_ANDI, rd, rs, decoded_imm[encoded]);
@@ -734,8 +727,8 @@ static void gen_ldst_multiple(DisasContext *ctx, uint32_t opc, int reglist,
 
 static void gen_pool16c_insn(DisasContext *ctx)
 {
-    int rd = mmreg((ctx->opcode >> 3) & 0x7);
-    int rs = mmreg(ctx->opcode & 0x7);
+    int rd = gpr3_m16(ctx, (ctx->opcode >> 3) & 0x7);
+    int rs = gpr3_m16(ctx, ctx->opcode & 0x7);
 
     switch (((ctx->opcode) >> 4) & 0x3f) {
     case NOT16 + 0:
@@ -872,8 +865,8 @@ static inline void gen_movep(DisasContext *ctx, int enc_dest, int enc_rt,
 
 static void gen_pool16c_r6_insn(DisasContext *ctx)
 {
-    int rt = mmreg((ctx->opcode >> 7) & 0x7);
-    int rs = mmreg((ctx->opcode >> 4) & 0x7);
+    int rt = gpr3_m16(ctx, (ctx->opcode >> 7) & 0x7);
+    int rs = gpr3_m16(ctx, (ctx->opcode >> 4) & 0x7);
 
     switch (ctx->opcode & 0xf) {
     case R6_NOT16:
@@ -2853,7 +2846,7 @@ static void decode_micromips32_opc(CPUMIPSState *env, DisasContext *ctx)
             }
         } else {
             /* ADDIUPC */
-            int reg = mmreg(ZIMM(ctx->opcode, 23, 3));
+            int reg = gpr3_m16(ctx, ZIMM(ctx->opcode, 23, 3));
             offset = SIMM(ctx->opcode, 0, 23) << 2;
 
             gen_addiupc(ctx, reg, offset, 0, 0);
@@ -3041,9 +3034,9 @@ static int decode_isa_micromips(CPUMIPSState *env, DisasContext *ctx)
     switch (op) {
     case POOL16A:
         {
-            int rd = mmreg(uMIPS_RD(ctx->opcode));
-            int rs1 = mmreg(uMIPS_RS1(ctx->opcode));
-            int rs2 = mmreg(uMIPS_RS2(ctx->opcode));
+            int rd = gpr3_m16(ctx, uMIPS_RD(ctx->opcode));
+            int rs1 = gpr3_m16(ctx, uMIPS_RS1(ctx->opcode));
+            int rs2 = gpr3_m16(ctx, uMIPS_RS2(ctx->opcode));
             uint32_t opc = 0;
 
             switch (ctx->opcode & 0x1) {
@@ -3067,8 +3060,8 @@ static int decode_isa_micromips(CPUMIPSState *env, DisasContext *ctx)
         break;
     case POOL16B:
         {
-            int rd = mmreg(uMIPS_RD(ctx->opcode));
-            int rs = mmreg(uMIPS_RS(ctx->opcode));
+            int rd = gpr3_m16(ctx, uMIPS_RD(ctx->opcode));
+            int rs = gpr3_m16(ctx, uMIPS_RS(ctx->opcode));
             int amount = (ctx->opcode >> 1) & 0x7;
             uint32_t opc = 0;
             amount = amount == 0 ? 8 : amount;
@@ -3094,7 +3087,7 @@ static int decode_isa_micromips(CPUMIPSState *env, DisasContext *ctx)
         break;
     case LWGP16:
         {
-            int rd = mmreg(uMIPS_RD(ctx->opcode));
+            int rd = gpr3_m16(ctx, uMIPS_RD(ctx->opcode));
             int rb = 28;            /* GP */
             int16_t offset = SIMM(ctx->opcode, 0, 7) << 2;
 
@@ -3115,8 +3108,8 @@ static int decode_isa_micromips(CPUMIPSState *env, DisasContext *ctx)
         break;
     case LBU16:
         {
-            int rd = mmreg(uMIPS_RD(ctx->opcode));
-            int rb = mmreg(uMIPS_RS(ctx->opcode));
+            int rd = gpr3_m16(ctx, uMIPS_RD(ctx->opcode));
+            int rb = gpr3_m16(ctx, uMIPS_RS(ctx->opcode));
             int16_t offset = ZIMM(ctx->opcode, 0, 4);
             offset = (offset == 0xf ? -1 : offset);
 
@@ -3125,8 +3118,8 @@ static int decode_isa_micromips(CPUMIPSState *env, DisasContext *ctx)
         break;
     case LHU16:
         {
-            int rd = mmreg(uMIPS_RD(ctx->opcode));
-            int rb = mmreg(uMIPS_RS(ctx->opcode));
+            int rd = gpr3_m16(ctx, uMIPS_RD(ctx->opcode));
+            int rb = gpr3_m16(ctx, uMIPS_RS(ctx->opcode));
             int16_t offset = ZIMM(ctx->opcode, 0, 4) << 1;
 
             gen_ld(ctx, OPC_LHU, rd, rb, offset);
@@ -3143,8 +3136,8 @@ static int decode_isa_micromips(CPUMIPSState *env, DisasContext *ctx)
         break;
     case LW16:
         {
-            int rd = mmreg(uMIPS_RD(ctx->opcode));
-            int rb = mmreg(uMIPS_RS(ctx->opcode));
+            int rd = gpr3_m16(ctx, uMIPS_RD(ctx->opcode));
+            int rb = gpr3_m16(ctx, uMIPS_RS(ctx->opcode));
             int16_t offset = ZIMM(ctx->opcode, 0, 4) << 2;
 
             gen_ld(ctx, OPC_LW, rd, rb, offset);
@@ -3153,7 +3146,7 @@ static int decode_isa_micromips(CPUMIPSState *env, DisasContext *ctx)
     case SB16:
         {
             int rd = mmreg2(uMIPS_RD(ctx->opcode));
-            int rb = mmreg(uMIPS_RS(ctx->opcode));
+            int rb = gpr3_m16(ctx, uMIPS_RS(ctx->opcode));
             int16_t offset = ZIMM(ctx->opcode, 0, 4);
 
             gen_st(ctx, OPC_SB, rd, rb, offset);
@@ -3162,7 +3155,7 @@ static int decode_isa_micromips(CPUMIPSState *env, DisasContext *ctx)
     case SH16:
         {
             int rd = mmreg2(uMIPS_RD(ctx->opcode));
-            int rb = mmreg(uMIPS_RS(ctx->opcode));
+            int rb = gpr3_m16(ctx, uMIPS_RS(ctx->opcode));
             int16_t offset = ZIMM(ctx->opcode, 0, 4) << 1;
 
             gen_st(ctx, OPC_SH, rd, rb, offset);
@@ -3180,7 +3173,7 @@ static int decode_isa_micromips(CPUMIPSState *env, DisasContext *ctx)
     case SW16:
         {
             int rd = mmreg2(uMIPS_RD(ctx->opcode));
-            int rb = mmreg(uMIPS_RS(ctx->opcode));
+            int rb = gpr3_m16(ctx, uMIPS_RS(ctx->opcode));
             int16_t offset = ZIMM(ctx->opcode, 0, 4) << 2;
 
             gen_st(ctx, OPC_SW, rd, rb, offset);
@@ -3225,14 +3218,14 @@ static int decode_isa_micromips(CPUMIPSState *env, DisasContext *ctx)
     case BNEZ16: /* BNEZC16 */
     case BEQZ16: /* BEQZC16 */
         gen_compute_branch(ctx, op == BNEZ16 ? OPC_BNE : OPC_BEQ, 2,
-                           mmreg(uMIPS_RD(ctx->opcode)),
+                           gpr3_m16(ctx, uMIPS_RD(ctx->opcode)),
                            0, sextract32(ctx->opcode, 0, 7) << 1,
                            (ctx->insn_flags & ISA_MIPS_R6) ? 0 : 4);
 
         break;
     case LI16:
         {
-            int reg = mmreg(uMIPS_RD(ctx->opcode));
+            int reg = gpr3_m16(ctx, uMIPS_RD(ctx->opcode));
             int imm = ZIMM(ctx->opcode, 0, 7);
 
             imm = (imm == 0x7f ? -1 : imm);
diff --git a/target/mips/tcg/mips16e_translate.c.inc b/target/mips/tcg/mips16e_translate.c.inc
index dfb4312f1835..ed2bbbc66be9 100644
--- a/target/mips/tcg/mips16e_translate.c.inc
+++ b/target/mips/tcg/mips16e_translate.c.inc
@@ -120,13 +120,6 @@ enum {
   RR_RY_CNVT_SEW = 0x6,
 };
 
-static int xlat(int r)
-{
-  static const int map[] = { 16, 17, 2, 3, 4, 5, 6, 7 };
-
-  return map[r];
-}
-
 static void decr_and_store(DisasContext *ctx, unsigned regidx, TCGv t0)
 {
     TCGv t1 = tcg_temp_new();
@@ -459,8 +452,8 @@ static int decode_extended_mips16_opc(CPUMIPSState *env, DisasContext *ctx)
     op = (ctx->opcode >> 11) & 0x1f;
     sa = (ctx->opcode >> 22) & 0x1f;
     funct = (ctx->opcode >> 8) & 0x7;
-    rx = xlat((ctx->opcode >> 8) & 0x7);
-    ry = xlat((ctx->opcode >> 5) & 0x7);
+    rx = gpr3_m16(ctx, (ctx->opcode >> 8) & 0x7);
+    ry = gpr3_m16(ctx, (ctx->opcode >> 5) & 0x7);
     offset = imm = (int16_t) (((ctx->opcode >> 16) & 0x1f) << 11
                               | ((ctx->opcode >> 21) & 0x3f) << 5
                               | (ctx->opcode & 0x1f));
@@ -676,9 +669,9 @@ static int decode_ase_mips16e(CPUMIPSState *env, DisasContext *ctx)
 
     sa = (ctx->opcode >> 2) & 0x7;
     sa = sa == 0 ? 8 : sa;
-    rx = xlat((ctx->opcode >> 8) & 0x7);
+    rx = gpr3_m16(ctx, (ctx->opcode >> 8) & 0x7);
     cnvt_op = (ctx->opcode >> 5) & 0x7;
-    ry = xlat((ctx->opcode >> 5) & 0x7);
+    ry = gpr3_m16(ctx, (ctx->opcode >> 5) & 0x7);
     op1 = offset = ctx->opcode & 0x1f;
 
     n_bytes = 2;
@@ -831,7 +824,7 @@ static int decode_ase_mips16e(CPUMIPSState *env, DisasContext *ctx)
                 break;
             case I8_MOV32R:
                 {
-                    int rz = xlat(ctx->opcode & 0x7);
+                    int rz = gpr3_m16(ctx, ctx->opcode & 0x7);
 
                     reg32 = (((ctx->opcode >> 3) & 0x3) << 3) |
                         ((ctx->opcode >> 5) & 0x7);
@@ -910,7 +903,7 @@ static int decode_ase_mips16e(CPUMIPSState *env, DisasContext *ctx)
         break;
     case M16_OPC_RRR:
         {
-            int rz = xlat((ctx->opcode >> 2) & 0x7);
+            int rz = gpr3_m16(ctx, (ctx->opcode >> 2) & 0x7);
             int mips32_op;
 
             switch (ctx->opcode & 0x3) {
-- 
2.55.0


