Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1115606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 16:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pEcGfuCJ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=S1fjNbeP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLNSv-00034a-DD; Mon, 26 Oct 2026 12:22:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLNSs-0002pd-PN
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 12:22:26 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLNSq-0000eo-Lc
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 12:22:26 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QEvcxV465825
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 16:22:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 k/ZV/W69xco6YBhRL3yKOVP87/iS58eMGzHNLJp5VqY=; b=pEcGfuCJCgtxx1Y5
 zA9QwcvWZHEVYxWcIs1lFsp5gV4xlH4uT8Fmm4BQgiVf/iao2yI0Zs63R52dHqHd
 bC/+GTklGzCb8CHuQKLR6S84aljpfVZhg5nt5SufLGOa166gScbppecdZVla/POf
 q7u9GcK2tV0hsUwccGCA9YhPydl76iuv+2s5Vh5JIfU1Awo82DSJ9zXaYd54CuSy
 RFuUJDh/saweAMkEh/80FGDKSMKx1VEfqz0PyL2/OFi5X0O3F7o0WDu4wMK4QH3s
 kP+6Qrv4Fdo+ofz8FDQW6EsNMhv5beYFtdcflEv1rlTE0jcolYy/wWgzM3z79hKp
 kJQ8Ag==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hhshpuacs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 16:22:23 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-7c10b8abe29so3136355137.0
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 09:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793031742; x=1793636542; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=k/ZV/W69xco6YBhRL3yKOVP87/iS58eMGzHNLJp5VqY=;
 b=S1fjNbePlSyC5yKHJJLk1GGF/4o1tpl4w0OkRzCGp1yoho6t05HGa6KI7MomoU9EVw
 0RNaRrFb44higDhi6hr3IxSZBd5PwB6v7RyPClkJJMcFwdawJPuHw5f8MWTqxVv+8CZF
 8aKHwqpLjEDu8FTuAEjuJbfwckKJIgJU/xfRyUE0CnPDSMqIxUzLx7//gl7WBTMfGYMP
 fpC8WRHd+JUfsVZMJPAbWEUpsganN1sQyeC4cJ1XFatpjqn8LS+kk3xp0i31MB4CyQ2l
 Vvd1HC3tewLIYC84HhX3LtZl0AT96PUdkQ2XWMOlpM5X3QZ2FgFgVHutSq50PVb3iTPd
 GvQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793031742; x=1793636542;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=k/ZV/W69xco6YBhRL3yKOVP87/iS58eMGzHNLJp5VqY=;
 b=p3JvDz1+SQiPP+tJ0YZPeL9CiG8cmIV7/HbVCBmq0T7Pw0LvrBOwF7bq/JtavZJPln
 edflYpYpzcV43NOTfoVX2NPIg6UpWZVcC3s9pnnDbN8iA2Hq0AHmCWBAeehQsohuBkYy
 88IMaSNtdfC8K9V0k1Zw1SnhDZ7b7RNR2jkvLi3PiPZ2gI4H+ynndYecJ+8MwXGSBxBi
 vjB3gO53BVuBZnYxS/XNfZzNZmvW/H22mY2mr3rTH8kWDASe4OgvTDHMyQCtoBsQCAGg
 w9e+HjdwVUgS3f+juhF+RQf1l8pqSIYsJ/Y9oRaL7SjsHEResNpC4TIoD7Mw6/mHldpD
 b54g==
X-Gm-Message-State: AFq9FYKCmJVApVew38rj35OdXX8EOrbQmdFY3Riob5gmA1sdCQzMLhSq
 JyNVNLrWfZDyX2hdElrjFA8ns+4LSoycV7qbDJE5Zy/yxOSC0WugLOGrwZg6u4OOTrJ4cTLRJv4
 vSojbPfJcu+6h9QFBcI1mgtn57mvxR3eSqQLFWRClRxFnJs/XFJeVIssxPU6XmUvHNg==
X-Gm-Gg: AYBFou20l/08DdPppHETOLQ6/ALLe8cVc7b6U57qjxuH1JI2bIHIpvwXXYhXQflbMl1
 yT05dxRTnuY5/wg1vi1h8yHXeCtgNKMx/4v1DnvyPd7w7osnNqqUYJZXWRFmrA/cshPuhZLvJyi
 TWZCLWiLp50lM1YGMK0aDLJZs/xr8wA1BkLcmxwxpFbkxI2QF3lifjCp6HDW5r1nBFP39rY936Q
 scYjnaxSox7OqqSun9d50oOlKbP4MVW8oavuVuTuuJUlMZH8w47r3N3hA/VcsS3xGqxibp+TLas
 VCsDEOXl3Xe8ivR4iszxAsQgxRfeHG1v+PkwTOMqL4TlgdGIpR2/LAHKNqiYykACHYbG1n2SXHR
 iGQIe3oYTYATE2WWgqnGBp10F7uhpcTNx5cWIWxPf
X-Received: by 2002:a05:6102:4455:b0:7cb:70ed:ff90 with SMTP id
 ada2fe7eead31-7ce5cd94757mr1832852137.26.1793031741909; 
 Mon, 26 Oct 2026 09:22:21 -0700 (PDT)
X-Received: by 2002:a05:6102:4455:b0:7cb:70ed:ff90 with SMTP id
 ada2fe7eead31-7ce5cd94757mr1832838137.26.1793031741414; 
 Mon, 26 Oct 2026 09:22:21 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a59d998sm212196885e9.15.2026.10.26.09.22.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 26 Oct 2026 09:22:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v4 14/14] target/mips: Convert nanoMIPS LI opcodes to
 decodetree
Date: Mon, 26 Oct 2026 17:20:33 +0100
Message-ID: <20261026162034.32711-15-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026162034.32711-1-philmd@oss.qualcomm.com>
References: <20261026162034.32711-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA2NSBTYWx0ZWRfX7HTlzvF6yMMT
 DIo/sHJ6wZ0BVQ/9ayBoat1YGUchvmT/ZHyE3nKX6vVZdt0/V6joL/zO90I2fC70D8FlyU2gqBp
 XqJLZHaYtYdg6fcICEksHbAKrrm3ylI=
X-Proofpoint-GUID: qZ1PQDi84VLM-o5StcXA9IxrmcPgL59S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA2NSBTYWx0ZWRfX8nCxTflb+Umk
 0O1sjcQ/q533ELOtzvxWJCypfQfxmypu1upODcBQagX1iMivxsF7aV7aoM42B+2YPpyXBJS5W8t
 PKtGBAEUReHAJoukhyjrMpNA5R8MUuyYjDIotMOnpbIs1mCw7988Ea7hkOorwwNxQ9c7S7oUQph
 6mTN8fODrmdYnA/JAWFAz9pq66+zHsd283AyZOhjyHgbxG0iypfQh+T5tvLxb1wrWTqdUlHDwus
 R7IHOSctsLjGjaXuggKQ90tT5cSsokP58K9+lEH51G5LyT/rElD/wBkfBRcMHKEOp6rlla80o88
 Zx4njyvBnSP54wKPbcHohA1SUwqKJOeIgDxvvdj/DwHOjNzmTsb62CmE9GrNrlMgumAGDkLvbLC
 +u2l9ycXF+5+wrYHaRZrxbDiNVX5OoiIfocQwov+tErUgjwNMozOtzUpwJIMQeNaoFGYeiJEYmt
 bBNeShCRIoRyl1BAKiA==
X-Authority-Analysis: v=2.4 cv=HZWB3SE8 c=1 sm=1 tr=0 ts=6adf7e3f cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=afSiZASKlENp3Nq3tvsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=gYDTvv6II1OnSo0itH1n:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: qZ1PQDi84VLM-o5StcXA9IxrmcPgL59S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 spamscore=0
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

Convert LI[16] and LI[48]. LI[16] decodes its 3-bit register
with gpr3() and its immediate with s_eu() (0x7f encodes -1).
LI[48] takes a 32-bit immediate and is not available in NMS
cores; handle it in trans_LI_nnms(), which checks NMS before
calling trans_LI(). Expose check_nms() for that purpose.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
Since v3:
- Fix LI[16] register decoding, using the gpr3() mapping
- Fix LI[16] immediate, extracted unsigned
- Fix LI[48] immediate halfword order
- Replace the not_in_nms argument by trans_LI_nnms()
- Reuse check_nms() from translate.c
---
 target/mips/tcg/translate.h              |  1 +
 target/mips/tcg/nanomips16.decode        |  9 ++++++++
 target/mips/tcg/nanomips48.decode        |  8 ++++++++
 target/mips/tcg/nanomips_translate.c     | 26 ++++++++++++++++++++++++
 target/mips/tcg/translate.c              |  2 +-
 target/mips/tcg/nanomips_translate.c.inc | 17 ----------------
 6 files changed, 45 insertions(+), 18 deletions(-)

diff --git a/target/mips/tcg/translate.h b/target/mips/tcg/translate.h
index 71370f336dc1..0af9f2fb3603 100644
--- a/target/mips/tcg/translate.h
+++ b/target/mips/tcg/translate.h
@@ -152,6 +152,7 @@ void check_cp1_enabled(DisasContext *ctx);
 void check_cp1_64bitmode(DisasContext *ctx);
 void check_cp1_registers(DisasContext *ctx, int regs);
 void check_cop1x(DisasContext *ctx);
+void check_nms(DisasContext *ctx);
 
 void gen_base_offset_addr(DisasContext *ctx, TCGv addr, int base, int offset);
 void gen_base_index_addr(DisasContext *ctx, TCGv addr, int base, int index);
diff --git a/target/mips/tcg/nanomips16.decode b/target/mips/tcg/nanomips16.decode
index f68fb57022a5..70db007e820b 100644
--- a/target/mips/tcg/nanomips16.decode
+++ b/target/mips/tcg/nanomips16.decode
@@ -6,3 +6,12 @@
 #
 # Reference: nanoMIPS32 Instruction Set Technical Reference Manual
 #            (Document Number: MD01247)
+
+&rd_imm             rd imm
+
+%rt3                7:3 !function=gpr3
+%s_eu               0:7 !function=s_eu
+
+@rt3_s          ...... ... .......          &rd_imm         rd=%rt3 imm=%s_eu
+
+LI              110100 ... .......          @rt3_s          # LI[16]
diff --git a/target/mips/tcg/nanomips48.decode b/target/mips/tcg/nanomips48.decode
index 0ab33ce5a952..4c9fe695a869 100644
--- a/target/mips/tcg/nanomips48.decode
+++ b/target/mips/tcg/nanomips48.decode
@@ -6,3 +6,11 @@
 #
 # Reference: nanoMIPS32 Instruction Set Technical Reference Manual
 #            (Document Number: MD01247)
+
+&rd_imm     rd  imm                                                  !extern
+
+%imm        0:s16 16:16
+
+@rd_imm     ...... rd:5  ..... ................ ................    &rd_imm imm=%imm
+
+LI_nnms     011000 ..... 00000 ................ ................    @rd_imm
diff --git a/target/mips/tcg/nanomips_translate.c b/target/mips/tcg/nanomips_translate.c
index 6b8aaedb5477..c9ef142fe73f 100644
--- a/target/mips/tcg/nanomips_translate.c
+++ b/target/mips/tcg/nanomips_translate.c
@@ -9,6 +9,18 @@
 #include "qemu/osdep.h"
 #include "translate.h"
 
+static int gpr3(DisasContext *ctx, int x)
+{
+    static const int map[8] = { 16, 17, 18, 19, 4, 5, 6, 7 };
+
+    return map[x];
+}
+
+static int s_eu(DisasContext *ctx, int x)
+{
+    return x == 0x7f ? -1 : x;
+}
+
 /* Include the auto-generated decoders.  */
 #include "decode-nanomips16.c.inc"
 #include "decode-nanomips32.c.inc"
@@ -18,3 +30,17 @@ static bool trans_LSA(DisasContext *ctx, arg_r *a)
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
+
+static bool trans_LI_nnms(DisasContext *ctx, arg_rd_imm *a)
+{
+    check_nms(ctx);
+
+    return trans_LI(ctx, a);
+}
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 74c571c1c125..10811db827c9 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -1712,7 +1712,7 @@ static inline void check_cp0_mt(DisasContext *ctx)
  * This code generates a "reserved instruction" exception if the
  * Config5 NMS bit is set.
  */
-static inline void check_nms(DisasContext *ctx)
+void check_nms(DisasContext *ctx)
 {
     if (unlikely(ctx->CP0_Config5 & (1 << CP0C5_NMS))) {
         gen_reserved_instruction(ctx);
diff --git a/target/mips/tcg/nanomips_translate.c.inc b/target/mips/tcg/nanomips_translate.c.inc
index 028ef49ea053..c883b5514f1c 100644
--- a/target/mips/tcg/nanomips_translate.c.inc
+++ b/target/mips/tcg/nanomips_translate.c.inc
@@ -57,7 +57,6 @@ enum {
 
     NM_POOL32S      = 0x30,
     NM_P_BRI        = 0x32,
-    NM_LI16         = 0x34,
     NM_SWGP16       = 0x35,
     NM_P16_BR       = 0x36,
 
@@ -86,7 +85,6 @@ enum {
 
 /* P48I instruction pool */
 enum {
-    NM_LI48        = 0x00,
     NM_ADDIU48     = 0x01,
     NM_ADDIUGP48   = 0x02,
     NM_ADDIUPC48   = 0x03,
@@ -3665,12 +3663,6 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
                                        mo_endian(ctx));
             target_long addr_off = extract32(ctx->opcode, 0, 16) | insn << 16;
             switch (extract32(ctx->opcode, 16, 5)) {
-            case NM_LI48:
-                check_nms(ctx);
-                if (rt != 0) {
-                    tcg_gen_movi_tl(cpu_gpr[rt], addr_off);
-                }
-                break;
             case NM_ADDIU48:
                 check_nms(ctx);
                 if (rt != 0) {
@@ -4628,15 +4620,6 @@ static int decode_isa_nanomips(CPUMIPSState *env, DisasContext *ctx)
             break;
         }
         break;
-    case NM_LI16:
-        {
-            imm = extract32(ctx->opcode, 0, 7);
-            imm = (imm == 0x7f ? -1 : imm);
-            if (rt != 0) {
-                tcg_gen_movi_tl(cpu_gpr[rt], imm);
-            }
-        }
-        break;
     case NM_ANDI16:
         {
             uint32_t u = extract32(ctx->opcode, 0, 4);
-- 
2.55.0


