Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16A6606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 14:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Vx4dg4Ef;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OLfjWCAO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM4kG-0005Nt-3T; Wed, 28 Oct 2026 10:35:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xM4j6-000521-1J
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 10:34:10 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xM4j1-0004TM-KS
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 10:34:03 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69SBe3lu691873
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 14:33:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Pu830gYy8Ds+PNBWkxWcCVyGsAlz+zZD8vp+WSahDtY=; b=Vx4dg4EfQSfXXq0g
 /HxCv2An9cY1cGFFKCWf6rF5pDeau5H+feJtWbQ9YL5raTfCSYuZk29SUJiqIocK
 T7rdfcKe0J+3DXjsWDquTin4Uz5JGe0m6tzJ3btfb5/POkWVpl4zTvGTzQy+nAC4
 E64B4jszqdWLfSomrqhE1ZxkydghPpfL4MohLvVmmX3wi2DTkfRKCe9sRlZ+KOXC
 BLuuryc4wix4zjepDPcSiHXos5hEmdlNj8yf7yVQxGOorvGbBONCqeF3XdBNA5Kv
 s2+ncgcq2uuvV4KNGA7hXx/tm6Q+MGL3LwpDf1oQrG8sTFnaYZ6Nliv474GOlL8I
 8Hvp2Q==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hk6be2x0d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 14:33:57 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f559420f3so88622285a.0
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 07:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793198037; x=1793802837; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Pu830gYy8Ds+PNBWkxWcCVyGsAlz+zZD8vp+WSahDtY=;
 b=OLfjWCAOclBYRuHQM7Sccr+fGiTDihkCIjYL0g7JbsXg8lIyJ0qKV4mMgCTFhn+r+c
 hzHUTo+axJqByv4RnfSqYFHZY1hq4Rh89/BgaoNpNUceBZ1XeJmSOt91pb9FhvSAc2WV
 kTRB6zHcXNvpLBgcmzzsfWtFibyxqiHYteHJX0v9fFZx7P4sVil0T91nzsIykrEzyMXi
 kQ+iCw8MqL5cnlOEVZNV2y9psAh5jZ/skVA4Aa7sE7r8I2joJ/8W0uErnAbPCQBAy8ql
 JxTRhbO9f9rduliZWHRfrDSQPTdDq+Qh8h02EdT6eT3IDeO14fbTqCK6z/Xl7yZB948O
 v5ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793198037; x=1793802837;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Pu830gYy8Ds+PNBWkxWcCVyGsAlz+zZD8vp+WSahDtY=;
 b=w9pRFfjtSfisRllSxyEcxMjWWMtoVvLzblZjMmhF3kQv4QQKYXNmOTHdNQdReyaWpX
 E+ZPc2GxfyKgXVsY7LwMevTKtV4r8n+vqJhlqtaR4lmVXbMHuPlBZ/h0bSeQ7VXQxYwa
 O2Cycf57QcvKtwWULOH9NdvbEJX3d1FQIQyXzATDyS3u495+7IGttXnNl3Tw47Hx4SyS
 AcLmkDYPj9XAFWBUXBXr2XLd1xc270LeGJGKMBoTp+ZAY1FjU1BJmRcTlKyLyA4HFDO+
 SZ6329zpUpa3yD7psXJeYBppaR2QI8IG2MU6UhNS+nHOTth4oh+qq93clNjlq2tsNAM/
 VlVQ==
X-Gm-Message-State: AFq9FYKIPHQa4xP5PbL1DSYVFinT/L4Bm28DCjLQNKRw1oIIFFmRyhJl
 V6OaIfCedEZQngUH75bu3Vg9n+xjuXmxVIpiiQ4xxYLEZuuCrEFUE31Qy3RiOTb4Y298TzL8wFd
 MjE8y+VTDWktjU/cZE/OLw9Bm5X/pxwzi5l7Om+WPpS25tOoU1tk5DimZP0GIIgDXZMZo
X-Gm-Gg: AYBFou1zKRR6L9fVMGfv2iYZlWjZRCCzId/gvY1En3q0wIhJNmxHLQLUE5D+0O531C8
 9VEWYwiKq0+rwxT3ysz9uOWs/zWjjMEZuI10WBoXtaCPvONQKhzdNVFiOpZGU9/NPXy9AVXIv+4
 iQfh9WKzPPsH5iGcCxeQooQ/+TsAvYzoJ6PuHWuUGs/Xa69ghIDUbiIbbPUUE7utR8c6xOkivXT
 Jz2gVI3uiCyRcJxIpZ9FEwizrnTFEJM0fHjnLie/fw6AjS94GmJHiCZV6cagb3plYKhZLGW7R2w
 wXVL9+kln2Gb2k7ysOmHqLyLB9B7mzHgDf7QdYXCdU0kSTgInyoIxu7UuIA7cz/v7Y2pDz8RS6m
 EtgcHxufZbNu5FB/WnXkoXb5uYSVbTlTnWBA7puHB8xPdMByPPIO82Nbdh2/qQh5ddaF5hsNljp
 s1GF7FkPeEXxmJ+DIR1Xvv31grAXY22g==
X-Received: by 2002:a05:620a:458a:b0:93b:bce3:5499 with SMTP id
 af79cd13be357-944089393e4mr364659085a.6.1793198036473; 
 Wed, 28 Oct 2026 07:33:56 -0700 (PDT)
X-Received: by 2002:a05:620a:458a:b0:93b:bce3:5499 with SMTP id
 af79cd13be357-944089393e4mr364654285a.6.1793198035981; 
 Wed, 28 Oct 2026 07:33:55 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a97c9f1403sm54169865e9.9.2026.10.28.07.33.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 28 Oct 2026 07:33:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v3 3/6] tcg/riscv64: Extract elements for vector arithmetic
 immediates
Date: Wed, 28 Oct 2026 15:33:27 +0100
Message-ID: <20261028143330.6518-4-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261028143330.6518-1-philmd@oss.qualcomm.com>
References: <20261028143330.6518-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: evus5yTVSDsG-Y6ZYyEzqoFXV54-I1zt
X-Authority-Analysis: v=2.4 cv=HeuB3SE8 c=1 sm=1 tr=0 ts=6ae207d5 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=njo3DiN-QtZAaPIEphkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA1NyBTYWx0ZWRfX696eQAtsdNBX
 kHaO8+XXoBMioUXSrkBYdEtJIkfeGTy3Jg+oGq3BzHJZ8GFyRDaYKOzK5ubqs96ACkMG4CGPYD2
 d1/daSHZqIdokC2MV9kC0NKL88AUclg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA1NyBTYWx0ZWRfXyDISM4ruA67G
 9/ChxVBAqLnatc6YryPhoQRTrbTD9RW3eiS3GPwB6jdJhmXqq6t3keq336s2J9wcZQ5Enlyim6F
 AbJmKN8qY22vxB7HqsL9AytrQxe+bg0dM/o1xlHw1ljtcXAD0M9ntT2Fe9gJ5CLz4vGI1uLEMZP
 44bpUlk0gDs4W3snPDE9kUHhTYk5mMCdfDNAytvkUNXLrIMxLTdny1JQI/gpEb593TL2PJIA06H
 v6miiRT7XPDg4fqiQ33dhrUQ0znGH1ucsgkk7Q4WBmpuE0u5HrFBRiSqZ8tIDL4SOfVOWE5zbBf
 swyftGpSdIkYRzImgevrrzSP/HMnmaHsRXnndlmIpqHZ9v59+I3jltsFmrkukzgJJ7JA7iJxqwx
 i0r28tsFMO4aAXuczKABYlZBBGZqfYPULn905SG9YPBQdGi3PwYT8IdXOyVSXxk4RF8TeE7vtxK
 VkuCWtcpgBBbkhzmrMg==
X-Proofpoint-GUID: evus5yTVSDsG-Y6ZYyEzqoFXV54-I1zt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610280057
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The .vi emitters for add, reverse sub and saturating ops pass the
whole replicated constant (e.g. 0x0505050505050505) to encode_vi()
instead of a single element. This aborts debug builds on common
vectorized guest code and is undefined behaviour in release builds.

Add vec_imm() to extract the VECE element, and use it.

Fixes: 006352d69f14 ("tcg/riscv64: Assert immediate in range ...")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 tcg/riscv64/tcg-target.c.inc | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/tcg/riscv64/tcg-target.c.inc b/tcg/riscv64/tcg-target.c.inc
index 0e749ae296b8..a3d995e290b7 100644
--- a/tcg/riscv64/tcg-target.c.inc
+++ b/tcg/riscv64/tcg-target.c.inc
@@ -735,6 +735,12 @@ static void tcg_out_opc_vi_u(TCGContext *s, RISCVInsn opc,
     tcg_out32(s, encode_vi_u(opc, vd, imm, vs2, true));
 }
 
+/* Constants are replicated by VECE; extract one element for .vi forms. */
+static int64_t vec_imm(TCGArg arg, unsigned vece)
+{
+    return sextract64(arg, 0, 8 << vece);
+}
+
 static void tcg_out_opc_vv_vi(TCGContext *s, RISCVInsn o_vv, RISCVInsn o_vi,
                               TCGReg vd, TCGReg vs2, TCGArg vi1, int c_vi1)
 {
@@ -2788,12 +2794,13 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         break;
     case INDEX_op_add_vec:
         set_vtype_len_sew(s, type, vece);
-        tcg_out_opc_vv_vi(s, OPC_VADD_VV, OPC_VADD_VI, a0, a1, a2, c2);
+        tcg_out_opc_vv_vi(s, OPC_VADD_VV, OPC_VADD_VI, a0, a1,
+                          c2 ? vec_imm(a2, vece) : a2, c2);
         break;
     case INDEX_op_sub_vec:
         set_vtype_len_sew(s, type, vece);
         if (const_args[1]) {
-            tcg_out_opc_vi(s, OPC_VRSUB_VI, a0, a2, a1);
+            tcg_out_opc_vi(s, OPC_VRSUB_VI, a0, a2, vec_imm(a1, vece));
         } else {
             tcg_out_opc_vv(s, OPC_VSUB_VV, a0, a1, a2);
         }
@@ -2824,19 +2831,23 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         break;
     case INDEX_op_ssadd_vec:
         set_vtype_len_sew(s, type, vece);
-        tcg_out_opc_vv_vi(s, OPC_VSADD_VV, OPC_VSADD_VI, a0, a1, a2, c2);
+        tcg_out_opc_vv_vi(s, OPC_VSADD_VV, OPC_VSADD_VI, a0, a1,
+                          c2 ? vec_imm(a2, vece) : a2, c2);
         break;
     case INDEX_op_sssub_vec:
         set_vtype_len_sew(s, type, vece);
-        tcg_out_opc_vv_vi(s, OPC_VSSUB_VV, OPC_VSSUB_VI, a0, a1, a2, c2);
+        tcg_out_opc_vv_vi(s, OPC_VSSUB_VV, OPC_VSSUB_VI, a0, a1,
+                          c2 ? vec_imm(a2, vece) : a2, c2);
         break;
     case INDEX_op_usadd_vec:
         set_vtype_len_sew(s, type, vece);
-        tcg_out_opc_vv_vi(s, OPC_VSADDU_VV, OPC_VSADDU_VI, a0, a1, a2, c2);
+        tcg_out_opc_vv_vi(s, OPC_VSADDU_VV, OPC_VSADDU_VI, a0, a1,
+                          c2 ? vec_imm(a2, vece) : a2, c2);
         break;
     case INDEX_op_ussub_vec:
         set_vtype_len_sew(s, type, vece);
-        tcg_out_opc_vv_vi(s, OPC_VSSUBU_VV, OPC_VSSUBU_VI, a0, a1, a2, c2);
+        tcg_out_opc_vv_vi(s, OPC_VSSUBU_VV, OPC_VSSUBU_VI, a0, a1,
+                          c2 ? vec_imm(a2, vece) : a2, c2);
         break;
     case INDEX_op_smax_vec:
         set_vtype_len_sew(s, type, vece);
-- 
2.55.0


