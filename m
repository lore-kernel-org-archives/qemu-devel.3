Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8F1606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 16:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XlReCeAb;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Y1kM26LE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLNSo-0002RQ-NK; Mon, 26 Oct 2026 12:22:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLNSl-00026Y-72
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 12:22:19 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLNSj-0000eI-8Z
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 12:22:18 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QEwPkg2082429
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 16:22:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MTWkeelgwt+RhMXHUzDPnHV1zgpLaXhQQgc0pPLfRxg=; b=XlReCeAbv9O5FEdF
 8wRNscLAM30ZcVTloESdvxuHqpn0wi+rAYc6rq+RvWXqdZQ3WPh03utaPzFhfNag
 lBlJlx0BVhCwId1Ese+LqgBhYx1szl7Kw0bJJKY0w7p//r9gFV2lXSP2RpXOYvkM
 ZHcl9Z3icj8Bf+tX3DJJ1CZ23W8Ey9WtD3yrwEacAk770dXjMJvb7GsJ/RWrRSMK
 lzVplPyhwfggBtQwlQfSuvVC+AGoG438qGua3yq2UvVa0xS8BA69qqIOlBhlHLQr
 VwCEqsXYLUmUD24lLWFQNKify+2fsGUF3o1oE519fmD14c2gYQjEfW8NyEYFm16u
 y4DdTA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hhsgsub4a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 16:22:15 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-943e8ff02d0so113861885a.2
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 09:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793031735; x=1793636535; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MTWkeelgwt+RhMXHUzDPnHV1zgpLaXhQQgc0pPLfRxg=;
 b=Y1kM26LE2QH7K2lH0l3d25Ilc8zhzLogPxCBGlmfSp7jovd9crSqiRdQozR9MacZcE
 Gz9PxNH2ZqrGzma+b1o/RQm2sVzc1RjNdrbrc4NMu3dUQqjOayX2kK7giKtULLCaVwqM
 lXRxSqPL6efUUlsReEe9UI5QIsnzOcBXwe4bQKB1Cyj4f4lT0Fi9/eIgPiePNbQsaJ65
 L65UEsQ2LsaJES1Bla7WBYvMwfuftShe8CvBxS+COnl7xDdphQfUozC4kk0JwhrR3o+G
 80eF4rwNlOJUgLFDZ3kyYlwn4tS950R2sWxP2QaVc16otJOt7OwctAufXKXOvxycb2Jn
 UMBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793031735; x=1793636535;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MTWkeelgwt+RhMXHUzDPnHV1zgpLaXhQQgc0pPLfRxg=;
 b=Dw/KuKRGqg/f4wommAjjcFSmNF1KfMoC9cTLl8aIQV+2wae0Fhq+t07zhSXkxqvqaq
 Isd6aQ28PkGYX8m0YEZ16zBki8vpMk4rmRGeTEKk2PYtnNqAQdMbautlcs7cRpVyrBqQ
 gfknq+yngu/iutf8gPSlvkINKs3h7MURhNjItppBvdTJ98B5+CC41GMpxYv9CE/M9vNc
 /DOgAiYfEdwGI1O+ZruOqNorUY9yhvLABVz6k/CAhxE/aHLJQjNubBVw3fDJKal5xrOb
 i1fD/KJlR8JF/0xBKf9eh33H0hNGB5UduQI1SwSKXfgITJJ+9Q0CvHKllYC5864ozdeu
 kDYQ==
X-Gm-Message-State: AFq9FYKR9Ura48y6ULoeslbkHElUsts54f6L/amvOVzN2W1dOeSfRVHz
 GYAW7AQ1icUziO4/ma37RtAmtsup2A7f1oPzPbCn7xzPIfo3SAjBJUKdDueCN01olg55sZxT6sE
 dSosjmPDeRhUbCLGSNp0obmrgmp28bz0efStrGDtcTMlNc8fG8Sd3WZT2tNyX0K5xzw==
X-Gm-Gg: AYBFou0cgsG1mt+HKpZ394qsw2V3komvWIzGDleGQ/84X1eIA1szFmzTWy6yTnbrJ2z
 GKUWtOWyv3bbqw3bEELveBdQvwm1XSRHVMKEHP9QlWZ614EBNNPkaZKnZGAOoWveStzEh9pcoCN
 1i46WnpPx+csXU3gZHh7zSTmCmQTsAn7L359O+Mt5ze5JkyTp8DUvzcVQ3dYVRfTjcn0Rfadu1f
 ZhFrU6ciA/xCxpCCnMpwFTXlYyG8k8LESCJYDLMOfPV1hjx8R1ZlY17UUJnCrinBzyubZ+2+EP3
 yDC+7V5v9rPWwrVRjOLLQ1br517FE2ti6zOfoVkaWCaHmcKh3jMWlpLvFOCeVAqWakpqweU8Dn/
 1WFQOzyJVUr8xbCUGw2e2TSrdGHsqOCsEdvunp1rukqxdGfeWDpUXkP8cglqMTBYgu5UxFGvspT
 jEtpxWG2DPc8utoA==
X-Received: by 2002:a05:620a:4627:b0:93f:8dc:a710 with SMTP id
 af79cd13be357-940ef9df5c8mr1058893785a.80.1793031734592; 
 Mon, 26 Oct 2026 09:22:14 -0700 (PDT)
X-Received: by 2002:a05:620a:4627:b0:93f:8dc:a710 with SMTP id
 af79cd13be357-940ef9df5c8mr1058888785a.80.1793031734077; 
 Mon, 26 Oct 2026 09:22:14 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a0bac37sm218385975e9.6.2026.10.26.09.22.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 26 Oct 2026 09:22:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v4 13/14] target/mips: Convert MIPS16e LI opcodes to decodetree
Date: Mon, 26 Oct 2026 17:20:32 +0100
Message-ID: <20261026162034.32711-14-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026162034.32711-1-philmd@oss.qualcomm.com>
References: <20261026162034.32711-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA2NSBTYWx0ZWRfXyeX/5M3AYuOV
 98fMycD9GXJs/UFsdKTddU4QmUN/BY/FX/PIMliYWQnDRIIankhwCbg1sHqB+XG+0f5JJgZXJ8Y
 zJrWhaPzrgDnBLQRe3jMMAd2QyC9I7M=
X-Proofpoint-GUID: yGUzKC_BMClF0cY-3Ut9KNomEDC8pBSJ
X-Authority-Analysis: v=2.4 cv=c+8+0h9l c=1 sm=1 tr=0 ts=6adf7e37 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=abmB6Fif9p7BRXVaEgEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: yGUzKC_BMClF0cY-3Ut9KNomEDC8pBSJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA2NSBTYWx0ZWRfX2+RBAYbE9aqt
 B6PYY56KWVlGhePUE1mAzv8VqUm1OYhIBlOy3hgDzZ2R6qmxzoodYscQ2p+YG4pf7/VDwFLZVZo
 h+Uv01jBePu5v2c1Im31mfTNEAag0jhgdZI1KjhcX4hlxRHBk1su4bqH1dFBbBzJ0lqpA125AU7
 SPonTMti/ypj34Quq2cDupeYzhh7yLKLGL0YywbSuwTF+p1EXNtwJeko0pBXG8IovbG5FyOWokb
 3IPvXNT/PR96xZ8+2ci9jOe4FDdM+wRjfmDhahtrpK4t76qOAGKJgUkRTbQxr87l1P3Mo7Ey7yA
 UIshfc8/MYVGTTHVVFsOD987mlx8ecAi7T+VMduoc0w7pwiuOjNLvtgSgYhJDoC6ttP2ORLtVXk
 dHpKzKoCfTN2qbK/TNqj+eLJRsM1IJHjXHnLp75Vc6k2MALK/DR/r3MDlxNgRdqtSZxbyccXmKf
 PGChvSgbkWm4ahTbWcg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610260065
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

Convert both the 16-bit RI and the extended EXT-RI forms.
Decode the destination with xlat(); both immediates are
zero-extended (8-bit and 16-bit).

The legacy decoder ignored EXT-RI bits [7:5]; the pattern
requires them to be zero, as specified. Other encodings
now raise a Reserved Instruction exception.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
Since v3:
- Fix EXT-RI immediate field order (%ext_uimm16)
- Rename @ri format as @ext_ri
---
 target/mips/tcg/mips16e_16.decode       |  8 ++++++++
 target/mips/tcg/mips16e_32.decode       |  9 +++++++++
 target/mips/tcg/mips16e_translate.c     |  7 +++++++
 target/mips/tcg/mips16e_translate.c.inc | 11 -----------
 4 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/target/mips/tcg/mips16e_16.decode b/target/mips/tcg/mips16e_16.decode
index 2f3926052b9e..67c6c1bb7362 100644
--- a/target/mips/tcg/mips16e_16.decode
+++ b/target/mips/tcg/mips16e_16.decode
@@ -7,3 +7,11 @@
 # Reference: MIPS Architecture for Programmers, Volume IV-a
 #            The MIPS16e Application Specific Extension
 #            (Document Number: MD00076)
+
+&rd_imm         rd imm
+
+%rx3            8:3  !function=gpr3_m16
+
+@ri             ..... ... imm:8             &rd_imm   rd=%rx3
+
+LI              01101 ... ........          @ri
diff --git a/target/mips/tcg/mips16e_32.decode b/target/mips/tcg/mips16e_32.decode
index 1dccb554fb56..39cd8144ac03 100644
--- a/target/mips/tcg/mips16e_32.decode
+++ b/target/mips/tcg/mips16e_32.decode
@@ -7,3 +7,12 @@
 # Reference: MIPS Architecture for Programmers, Volume IV-a
 #            The MIPS16e Application Specific Extension
 #            (Document Number: MD00076)
+
+&rd_imm         rd imm                                          !extern
+
+%ext_uimm16     16:5 21:6 0:5
+%rx3            8:3  !function=gpr3_m16
+
+@ext_ri         ..... ...... ..... ..... ... ... .....          &rd_imm rd=%rx3 imm=%ext_uimm16
+
+LI              11110 ...... ..... 01101 ... 000 .....          @ext_ri
diff --git a/target/mips/tcg/mips16e_translate.c b/target/mips/tcg/mips16e_translate.c
index 136468c65c71..ff739a50b0cd 100644
--- a/target/mips/tcg/mips16e_translate.c
+++ b/target/mips/tcg/mips16e_translate.c
@@ -12,3 +12,10 @@
 /* Include the auto-generated decoders.  */
 #include "decode-mips16e_16.c.inc"
 #include "decode-mips16e_32.c.inc"
+
+static bool trans_LI(DisasContext *ctx, arg_rd_imm *a)
+{
+    gen_li(ctx, a->rd, a->imm);
+
+    return true;
+}
diff --git a/target/mips/tcg/mips16e_translate.c.inc b/target/mips/tcg/mips16e_translate.c.inc
index ed2bbbc66be9..043baa0965ea 100644
--- a/target/mips/tcg/mips16e_translate.c.inc
+++ b/target/mips/tcg/mips16e_translate.c.inc
@@ -24,7 +24,6 @@ enum {
   M16_OPC_SLTI = 0x0a,
   M16_OPC_SLTIU = 0x0b,
   M16_OPC_I8 = 0x0c,
-  M16_OPC_LI = 0x0d,
   M16_OPC_CMPI = 0x0e,
   M16_OPC_SD = 0x0f,
   M16_OPC_LB = 0x10,
@@ -575,9 +574,6 @@ static int decode_extended_mips16_opc(CPUMIPSState *env, DisasContext *ctx)
             break;
         }
         break;
-    case M16_OPC_LI:
-        tcg_gen_movi_tl(cpu_gpr[rx], (uint16_t) imm);
-        break;
     case M16_OPC_CMPI:
         tcg_gen_xori_tl(cpu_gpr[24], cpu_gpr[rx], (uint16_t) imm);
         break;
@@ -841,13 +837,6 @@ static int decode_ase_mips16e(CPUMIPSState *env, DisasContext *ctx)
             }
         }
         break;
-    case M16_OPC_LI:
-        {
-            int16_t imm = (uint8_t) ctx->opcode;
-
-            gen_arith_imm(ctx, OPC_ADDIU, rx, 0, imm);
-        }
-        break;
     case M16_OPC_CMPI:
         {
             int16_t imm = (uint8_t) ctx->opcode;
-- 
2.55.0


