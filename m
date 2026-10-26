Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673AD606A31D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 16:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GoXW5sJT;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Z2AToSlq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLNRr-0000YU-Iz; Mon, 26 Oct 2026 12:21:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLNRf-0000OE-F5
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 12:21:13 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLNRd-0000Xu-Lr
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 12:21:11 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QEvmh04098830
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 16:21:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DLJ+rerP29KetRElgUwW7uYKSK6Z0hnkHDU2x8CxMxA=; b=GoXW5sJTxvDF13OG
 M2YqLNNoaZJ0YUgbuSBFbyNfRm/ts3gXCULbnNxEngKzBXuKOrOH5+rjp+QqUSLi
 1dtYtxmGG52Lk+vMmYCAzKmGHt5cDd5LhG3IZR4U8enuzq3iOtLuaQ3PCUBMin3N
 vZFFhuzwBwjGEcvI/keZe8jt+lBJd08ta2C7i0xH/60/aYD1Xhgajak2V5nTEQ0L
 JJ6UxnpaxvtSxDLLubyD8ohyet9J8/iqC2taXJpznLljdKTWdpVzVNB1Nwgj865t
 kQS51wymFkXXMzQaNMgaRs3K6i2unqOgUZNhLruKkD3zjkZktix0atCW8Oaic4+m
 Tlmfaw==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj4s91g81-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 16:21:08 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-7cc1bb97ff8so543193137.2
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 09:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793031668; x=1793636468; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DLJ+rerP29KetRElgUwW7uYKSK6Z0hnkHDU2x8CxMxA=;
 b=Z2AToSlqBFHjIn/NQW1sGgQ79Rme869pVYuhfSkCnWbBY9xoraffRfD9WDJxcqhzg6
 /xt6HTNpvsjS+aDe1qt4jVhYeRKI+kBpXm81pnq+ELAmveFvtnj6dC87reLZlR3o/hjP
 RvOuJ+MLGnVNT37xnV01XhA4/GSSR8DhaC8UjSyHwf33/TFNpLsJEtEQY3cxoirg2+bW
 ky46/qqxepw01K1ZQ3yjpqdNF/N7U8uZ/igrnaKkNaqOKOzCj+g8aOHImpR5CRdGPFNN
 bXvKJx23p0sV98KnTwlnPJfiA/oQ55X8N3eX6fhiD+yiGnZvHbrlUuYb11Kn4/J6ib0J
 CpXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793031668; x=1793636468;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DLJ+rerP29KetRElgUwW7uYKSK6Z0hnkHDU2x8CxMxA=;
 b=NzoxiDFkhBtUSvJVsdD5qfdzvx2VE6fMn19GVp94hxzrxnUBDSl3IxAnuwkdQJXTJa
 jDZ8eDKtZD7bCko6lzZKqeMqoSUKqckYajkUAAoItBphGN8y/RhY5/Fsuc/YGVPKVulD
 tF0mXuUQGMKuQLiixeheFm/1CM2nmWjc8mG+hjJqY0jbLRn0yF3hdEZFTcF/SzlKMBkm
 82WSnpce/q+bQ+NpgNxTKH55V3/Jha+SZA3AE27jRZDXMKOguiYYfAR6nuzsXtHAunVi
 6kpstgY5KJ26RGFmwpBbpSksxit3pfl1kU6GwSH+fjWoiECrPjc+ffgH+ybCfgtFWbZ+
 8BkA==
X-Gm-Message-State: AFq9FYLKMVdihcj8gZDulBRgTtXzb7FAZiEGcEz9n1g7HPB+g5AvtjTl
 65h5+y2S7P9YlzV66M7leXfKFuDcZuihGID6MIFl2fkMteE9IAabaKSMJ2kYb+exRlrfTYwLY3T
 YF8qEoaQmcIYeZMwfUlKKcznulc95wbBM03WVU4jbe+dWJNXRDea0UzVN5/cUyMlmNg==
X-Gm-Gg: AYBFou1614Ge2W7aiWyAA86Y6lncvPnZnqF21zBoOPoqAdeR6qbHKE4eRfiqzUB3Niz
 uL3kk8Wu/DZL5ZmKKeb5LnToo06UmjT90ahN8bNCCbUzngOmab0RiTOo96Wk24Plbb79x7Mqop+
 Oazsx+RcMBy4A+hsI2AeJrCY3x8ES/MgjrihNuQf4yhgt0s3y1GRRvVL2k0NLjqnY4RHtHw//Zr
 TmfkfXETXIrHjaJv8eV/kvMPnVnGF1681gPxO445jJ4e4HgpsjH3IY1likjEywv86ny3XQC6SOm
 kFzz//cHzVsscBKKqPZofVJ7e+Anr4OLODCNllag4IzJqUflj8/fwRM06y1KDmR2hEf+E/Jdi2m
 xcwHZFYxjnm4HTuFktS8AOvNowiw8C5/+WZNySp3D
X-Received: by 2002:a05:6102:149d:b0:7c2:5692:1917 with SMTP id
 ada2fe7eead31-7ce5cca85b1mr2241691137.10.1793031667814; 
 Mon, 26 Oct 2026 09:21:07 -0700 (PDT)
X-Received: by 2002:a05:6102:149d:b0:7c2:5692:1917 with SMTP id
 ada2fe7eead31-7ce5cca85b1mr2241647137.10.1793031667011; 
 Mon, 26 Oct 2026 09:21:07 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a046fefsm260935885e9.5.2026.10.26.09.21.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 26 Oct 2026 09:21:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v4 04/14] target/mips: Determine microMIPS insn size before
 delay slot check
Date: Mon, 26 Oct 2026 17:20:23 +0100
Message-ID: <20261026162034.32711-5-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026162034.32711-1-philmd@oss.qualcomm.com>
References: <20261026162034.32711-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA2NSBTYWx0ZWRfX5H0W9DfRMWPO
 Q1zxpgJDBQ3nEO8DjPIzPMplIkjuaddcZ3OaYAWOx0osxt3tBxkykM/snem9Z43NvAJSu8FkQJO
 L4CjBuZEOGiz6WdUQRF/caORQcrnEOSF/Tm5l1zQZXzZaxiIvzCz8D3OmZhdSqnZaLMmDnXn0Mn
 VjYH4Wuu7GwKyue8Xwf8MVS6xFf5aT88q3sUewZNmmhcFIf5Jy5n5tCWSu8sL9ksAkTYcGVccbQ
 ElDYTC7QPhmbVM1Q8BHg+ktIgVNo4D1cG1Gob7SSTL3F+vh4hVssBqmh1BziRhsJghSX+PGNOn4
 HS6qH8OSrf+0g4n5Lp0dvO73KEnNbzQqrGzMyxO54vaUTpqJuGWr/RMpUaJ7EPvURsMndz/Jmi0
 vJSBH+lmgJBFfoxtAFj3KKhFtt9+7ZFcYYnU2hD0sKsGibTUYWttgxEbDN9UXnSsBI8Owe6LUTg
 +VYF33D8M5BnfsUCq5g==
X-Proofpoint-ORIG-GUID: v_NFZOpVzvYjp9XDlCDdLyHh0nwL01yV
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA2NSBTYWx0ZWRfXyOmrdBeKAuVh
 RskHbvCJa1u1Geqk6rm1VaaWLUeqn+FSt7KkjQrb/jgKsCdgTPlwiSyJKG0IaVFnObdOvQyb1LK
 +MBTbMzk6LDTwQI5w5R8rxpznN6vbOc=
X-Proofpoint-GUID: v_NFZOpVzvYjp9XDlCDdLyHh0nwL01yV
X-Authority-Analysis: v=2.4 cv=HKhWhYtv c=1 sm=1 tr=0 ts=6adf7df4 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=DRizRFIDFqjCqRW0pYYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=crWF4MFLhNY0qMRaF8an:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 spamscore=0
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

Compute whether the instruction is 16-bit or 32-bit unconditionally,
then use the result for the delay slot size check. The default case
is unreachable. No functional change.

The size will be used to select the 16-bit or 32-bit decodetree
decoder in the next commit.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/mips/tcg/micromips_translate.c.inc | 59 ++++++++++++-----------
 1 file changed, 30 insertions(+), 29 deletions(-)

diff --git a/target/mips/tcg/micromips_translate.c.inc b/target/mips/tcg/micromips_translate.c.inc
index 0984b8a505dd..40ffb1a71d30 100644
--- a/target/mips/tcg/micromips_translate.c.inc
+++ b/target/mips/tcg/micromips_translate.c.inc
@@ -2981,6 +2981,7 @@ static int decode_isa_micromips(CPUMIPSState *env, DisasContext *ctx)
 {
     uint32_t opcode;
     uint32_t op;
+    bool is_16bit;
 
     /* make sure instructions are on a halfword boundary */
     if (ctx->base.pc_next & 0x1) {
@@ -2993,36 +2994,36 @@ static int decode_isa_micromips(CPUMIPSState *env, DisasContext *ctx)
                                  mo_endian(ctx));
     ctx->opcode = opcode;
     op = (ctx->opcode >> 10) & 0x3f;
+    switch (op & 0x7) { /* MSB-3..MSB-5 */
+    case 0:
+    /* POOL32A, POOL32B, POOL32I, POOL32C */
+    case 4:
+    /* ADDI32, ADDIU32, ORI32, XORI32, SLTI32, SLTIU32, ANDI32, JALX32 */
+    case 5:
+    /* LBU32, LHU32, POOL32F, JALS32, BEQ32, BNE32, J32, JAL32 */
+    case 6:
+    /* SB32, SH32, ADDIUPC, SWC132, SDC132, SW32 */
+    case 7:
+    /* LB32, LH32, LWC132, LDC132, LW32 */
+        is_16bit = false;
+        break;
+    case 1:
+    /* POOL16A, POOL16B, POOL16C, LWGP16, POOL16F */
+    case 2:
+    /* LBU16, LHU16, LWSP16, LW16, SB16, SH16, SWSP16, SW16 */
+    case 3:
+    /* MOVE16, ANDI16, POOL16D, POOL16E, BEQZ16, BNEZ16, B16, LI16 */
+        is_16bit = true;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
     /* Enforce properly-sized instructions in a delay slot */
-    if (ctx->hflags & MIPS_HFLAG_BDS_STRICT) {
-        switch (op & 0x7) { /* MSB-3..MSB-5 */
-        case 0:
-        /* POOL32A, POOL32B, POOL32I, POOL32C */
-        case 4:
-        /* ADDI32, ADDIU32, ORI32, XORI32, SLTI32, SLTIU32, ANDI32, JALX32 */
-        case 5:
-        /* LBU32, LHU32, POOL32F, JALS32, BEQ32, BNE32, J32, JAL32 */
-        case 6:
-        /* SB32, SH32, ADDIUPC, SWC132, SDC132, SW32 */
-        case 7:
-        /* LB32, LH32, LWC132, LDC132, LW32 */
-            if (ctx->hflags & MIPS_HFLAG_BDS16) {
-                gen_reserved_instruction(ctx);
-                return 2;
-            }
-            break;
-        case 1:
-        /* POOL16A, POOL16B, POOL16C, LWGP16, POOL16F */
-        case 2:
-        /* LBU16, LHU16, LWSP16, LW16, SB16, SH16, SWSP16, SW16 */
-        case 3:
-        /* MOVE16, ANDI16, POOL16D, POOL16E, BEQZ16, BNEZ16, B16, LI16 */
-            if (ctx->hflags & MIPS_HFLAG_BDS32) {
-                gen_reserved_instruction(ctx);
-                return 2;
-            }
-            break;
-        }
+    if ((ctx->hflags & MIPS_HFLAG_BDS_STRICT)
+        && (ctx->hflags & (is_16bit ? MIPS_HFLAG_BDS32 : MIPS_HFLAG_BDS16))) {
+        gen_reserved_instruction(ctx);
+        return 2;
     }
 
     switch (op) {
-- 
2.55.0


