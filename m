Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB7C606A31D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 16:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=djR7cLmY;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bvnLec4i
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLNSc-0001Po-RV; Mon, 26 Oct 2026 12:22:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLNSP-00015e-Em
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 12:22:00 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLNSM-0000cL-S0
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 12:21:57 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QEvg6S2544128
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 16:21:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KieAnJO9sHEqXdU/bIcYo1otmuapE7eliq4aXuOvrXw=; b=djR7cLmYfG3eifJG
 M1TSpgk7ciPWf0AuY0aRZOKwJPqedUnhLxgie1J9d11IafbrU04SUtdxj6XoOG55
 x9h/w8I8X9mp0hQacoRkNNJr/W5A8HuL0rpzg5g5djcJz+6XOClNGeSC4s5kM6hE
 r6tYExHC0RkeJYM5wQSQbELsxcksFITELafz3OdfiwDVRP3GwVhZLdv8GMqmXE7w
 04UP+W9AmJv1Gon16YA4L5xD+5coRfWOxqZrorgFcmpKuLI/CONCjb5U8TFFof/X
 wigqDyN8x/TPyhPXarlJWItiKRRZf5wt/ADgCrUHVBTuedbhcCr5WMSN7NGYLFEH
 LDvnNw==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj8smre0t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 16:21:45 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-9806756ea40so3247431241.1
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 09:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793031705; x=1793636505; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KieAnJO9sHEqXdU/bIcYo1otmuapE7eliq4aXuOvrXw=;
 b=bvnLec4iiRQ2ODiZpKY8dI3EG8sby8YgITN1gp2f9o39L8QASPc2M5hIPDtKW35X40
 ZlUtuZoB2jX+BFS7PPkl9af3wWJQFVFaXbkP8WTtyNI6dZPqAc1e3yGInD9YVQWl8Ri7
 jHPO6HV2xkb8OjwQ+xQUgvWvjfgIz8D8vx5A/Wm0xZv96zEZnk18D+ShdiEXxjWQs8gB
 3WDPE5fy0BZLz4nuY1OkctpYZJStvcZTTujj12aPSnWJWq3IDOTQ1t7qwMnZMNuAybKl
 sgtfQhMeRvXoXVQT6K8Yy5PYn7FLRLwijI2wlSRNkMXrnL/al7fRbtV0BxZZnuCIRay0
 vG+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793031705; x=1793636505;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KieAnJO9sHEqXdU/bIcYo1otmuapE7eliq4aXuOvrXw=;
 b=ZaTS457K5zNg/Cvjvx5fLlvNOEkFvmrETPNa4y0WCYFC1TyJmj11BA08yw6gkvyUe0
 /qUOx23xMJypLf5dpa2d/UZFSuVHlemsWZt/DvwN1dmspV74rFYeqZmHNy9eNAfj7l0J
 ll/ApiQW4UsSiscETCh5xHAU4PhFvmihhNYy4r+dvQB+PLskILVj2iWqAHW6OKbRClu6
 vyDeCbK3bB3+YBiToEUY9N9MAv3uLVMsNmhqqHPIsdAMM5f/8W4iJxxqNNIVrkXg6Gqa
 2ULDPo3FygAfJ9PPr8Nqyok8ZsJzq3fm+9t5I3NIo0Bp9ddZylIvFY+ArcxwLP/OP+En
 5Ffg==
X-Gm-Message-State: AFq9FYIzxgV4rdpQbBSCFnUuPBUo79+vWMYYpPdwjmvd/MDdCw571Vcm
 AQ1Qf8ulom1qDOmR7T7c2jISnB+w1dhCQULklmlwk01+lBwXI5WGriQWCc+mOd+RRw5S/wwA+RP
 Qf9cOtdW6V7z6Rt34tMrNR4rRnusxeK9XiQm6CoO86AmFEbH/7T8p4PsR4bcG6LUw7A==
X-Gm-Gg: AYBFou0dlO9DtEyLtjJGWS9PmXJmAuQ8lUShf5aGMMhH68+Ckib4kLMYQk1lXTKFNnl
 kY9/JOjmIGCvix+Wxclwdmopp+8r/FjXtZvGnn1glZ4zTv43t24sI3m3NHHtayNa1aFuOFnvUk0
 tLM0zjF1z3PbdPKSsVrxJXzUj7UoyJoacTBG4oGLGFLYHxToAnlJxZueA1a29dMFmZuQf/ZuI7e
 iHZfnJeUBx5AIvXVYFFXVrWPSPaudZ7+S2K2666qRV5xScAQOzOmvCC8mlvIpt8zJBmFETtHRyG
 dJ+fpOAndtwplTf2hFoKvjHHMkBg0+iRVeArtxb/ufDe6v8+fbd8Tg4ccjvhxft7kBf5GiSPnYp
 NBbdKHh1hDMS0fz4IpzWsUBdJsqZBIEKuU7Qh7nKQ
X-Received: by 2002:a05:6102:a4a:b0:7cc:115:ddf4 with SMTP id
 ada2fe7eead31-7ce5cdddd6cmr2832161137.25.1793031704745; 
 Mon, 26 Oct 2026 09:21:44 -0700 (PDT)
X-Received: by 2002:a05:6102:a4a:b0:7cc:115:ddf4 with SMTP id
 ada2fe7eead31-7ce5cdddd6cmr2832150137.25.1793031704317; 
 Mon, 26 Oct 2026 09:21:44 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a4cb7bece3sm147711915e9.10.2026.10.26.09.21.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 26 Oct 2026 09:21:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v4 09/14] target/mips: Convert nanoMIPS LSA opcode to
 decodetree
Date: Mon, 26 Oct 2026 17:20:28 +0100
Message-ID: <20261026162034.32711-10-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026162034.32711-1-philmd@oss.qualcomm.com>
References: <20261026162034.32711-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: kZJ36YzB4WXMM4pOqazm2eOC0wxbm8bh
X-Authority-Analysis: v=2.4 cv=Sfti5fRu c=1 sm=1 tr=0 ts=6adf7e19 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=Ixn1CAxRAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=pDBHowQsxXgegazyqkAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=1WsBpfsz9X-RYQiigVTh:22
 a=_0vDLAJOulx5KDpLVjVP:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: kZJ36YzB4WXMM4pOqazm2eOC0wxbm8bh
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA2NSBTYWx0ZWRfX1P+9/8SKcR9I
 whFyOLLXcZAB8lycIHg5GBdh9EbKmz4o4s5VzYl4vr1NYwnOgfh20pKUVAldSKfS9x2py6vVS77
 YQMadDkzHHtRRK8EW/zkkWFBk0tFb7o=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA2NSBTYWx0ZWRfX7cY/a11LJh5D
 bbZ+1UaKyArnyWH4jUNEwrTxMOj0U1Vp+tDOwguJOn8mCd2BtZNfGvaL2xOrbqZ9/bMW3r1NhY3
 AbS6I0tkTOQMxxF7T+TwILvyl9t8yK9BHFJoSvywA8xDloxD2jmv0ZhCUqFxK+kSiDOwlsqvzte
 XAUCNGqUyqLzoviRph2cD+WEeaIIQrBaMdSejcS6IuvSa9i3cANy11wb6H2lg/E7glTjN9HTtq8
 8e3sZPIrrGf5/f32f9M6wKq84+WpdRV6H2EJM/5GvEOHfp6vug14I3rkjWOdmU3S0y4A6zBakTR
 OnKN8Z2P8ReVxkNAtsUKjiiAG38PfLWZEd9GcXj2cM+9IIQN6+LV3fLGZ0bPrG8x5oc0n5NTAjq
 w2mui0+hfuvoFcAcFLGQTsB1PKmK5KuUOv4Vtse79KCp/EAmoTAHVK0UwTZTpCaT3eCmvWtDDk5
 eKn0HWc2UBky63MTHZQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 suspectscore=0
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Call the generic gen_lsa(). Unlike MIPS R6, the nanoMIPS
shift amount is encoded as is, without +1 bias.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20241112172022.88348-7-philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
Since v3:
- Return gen_lsa() result, like the other LSA handlers
- Reworded description
---
 target/mips/tcg/nanomips32.decode        | 6 ++++++
 target/mips/tcg/nanomips_translate.c     | 5 +++++
 target/mips/tcg/nanomips_translate.c.inc | 4 ----
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/target/mips/tcg/nanomips32.decode b/target/mips/tcg/nanomips32.decode
index 2127c57444e6..3886009d77ad 100644
--- a/target/mips/tcg/nanomips32.decode
+++ b/target/mips/tcg/nanomips32.decode
@@ -6,3 +6,9 @@
 #
 # Reference: nanoMIPS32 Instruction Set Technical Reference Manual
 #            (Document Number: MD01247)
+
+&r                  rs rt rd sa
+
+@lsa                ...... rt:5 rs:5 rd:5 sa:2 --- ... ...  &r
+
+LSA                 001000 ..... ..... ..... .. ... 001 111 @lsa
diff --git a/target/mips/tcg/nanomips_translate.c b/target/mips/tcg/nanomips_translate.c
index 9393257612aa..6b8aaedb5477 100644
--- a/target/mips/tcg/nanomips_translate.c
+++ b/target/mips/tcg/nanomips_translate.c
@@ -13,3 +13,8 @@
 #include "decode-nanomips16.c.inc"
 #include "decode-nanomips32.c.inc"
 #include "decode-nanomips48.c.inc"
+
+static bool trans_LSA(DisasContext *ctx, arg_r *a)
+{
+    return gen_lsa(ctx, a->rd, a->rt, a->rs, a->sa);
+}
diff --git a/target/mips/tcg/nanomips_translate.c.inc b/target/mips/tcg/nanomips_translate.c.inc
index 6f6b5f190c9a..028ef49ea053 100644
--- a/target/mips/tcg/nanomips_translate.c.inc
+++ b/target/mips/tcg/nanomips_translate.c.inc
@@ -399,7 +399,6 @@ enum {
 /* POOL32A7 instruction pool */
 enum {
     NM_P_LSX        = 0x00,
-    NM_LSA          = 0x01,
     NM_EXTW         = 0x03,
     NM_POOL32AXF    = 0x07,
 };
@@ -3625,9 +3624,6 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
             case NM_P_LSX:
                 gen_p_lsx(ctx, rd, rs, rt);
                 break;
-            case NM_LSA:
-                gen_lsa(ctx, rd, rt, rs, extract32(ctx->opcode, 9, 2));
-                break;
             case NM_EXTW:
                 gen_ext(ctx, 32, rd, rs, rt, extract32(ctx->opcode, 6, 5));
                 break;
-- 
2.55.0


