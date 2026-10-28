Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DA8606A330
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 14:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YDC6DrSD;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Jr0h1l+W
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM4kE-0005Iu-7h; Wed, 28 Oct 2026 10:35:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xM4jC-00052t-QG
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 10:34:14 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xM4j8-0004UM-2B
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 10:34:10 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69SBe3Ce4154763
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 14:34:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oUJHPAl/sq7ko9Rjo0DfTrXkuYys9d/lMIlf8pyggp0=; b=YDC6DrSD+O6rOP7d
 F5dmpVwrb2UIzKwmYOFPhxtFXG/H7kc/DpUHOTMZYRkqOKxTmnNv25PVUWKyq+j+
 mce9NG9mN1Cit9wzKoMPLUL9w9phkV3pqmfGyCVWhMryQPW1LZbb1U6bsA285Dok
 qylhgLoOirhw3XJlVCs9dlea3IdrwvK7XkS4jtTtEKs/Jd+Tk47j4ogpEeHVwBUo
 RgsRgh6EHxH0TpcxBG+O7MSqXDHy5TM8yyX5MTgAhXBoFph9GNA1dQmBjEuJIG0N
 Q/h4U03umUMk5tzyG9r6bW1abCy4wiozk7b2695fS65dkKEoWoaQhAaiACwkBHUb
 mdKYgg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkdsp19v6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 14:34:04 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-91c85c9a756so13717656d6.0
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 07:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793198044; x=1793802844; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oUJHPAl/sq7ko9Rjo0DfTrXkuYys9d/lMIlf8pyggp0=;
 b=Jr0h1l+Wrh0E0GhI0sHNQosNWz0sE6BFdMTEQNELgAHKfwVTkb2fx6yuj8uEQMqzey
 /sEOIwbhh3uApeulpz0C40p/6WPFw5vVL61qVwT9fZA+4udeVFN57nUtz6hpRvJHCBvA
 Hb5bzASI5ZzZovei21zE486u5uLm7Yo0QcKSy8fsYCJ2WY/g8VxrPPvnz9dXZSL5Zyf6
 KxKxdvf+psHge+GX7Vps1fDbmp5fca5prPXvtdiEE0dKPbgbJcaogBYf6JndmG3A7ybT
 ytOhpNE2WXRZUK1zZp2UWpw+AciquQc521tXQ90fzfESHhDZ2wvA8DFAzGNCwn+iVYWZ
 6GRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793198044; x=1793802844;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oUJHPAl/sq7ko9Rjo0DfTrXkuYys9d/lMIlf8pyggp0=;
 b=hS9MykRlm9TvjsAAXqHN3kihgQYO7npOByNOF6+PFokFwTBi0dgMgT8has5eYefsy/
 cu9dNE67gHu6ogZVGmuuKmkGXP6MRUmUg5b4R/4DWD3LQycfRqegVLyePeReeyL0fU+m
 uq7EGdw1G2BMzM1D85tZ5Vxvmxy1j5dqePVKl0q0pR17C+1xTZf1HeDrF4yUVF0veCVf
 FLw9RiLCwWW/8kOfIRLuQmmV9I6G6VUmWEXfyw1Wpb9BqL0y4B6utt/M8hdL0UQgonsR
 5eWZitneTy6cR0lKtdL2vgIwpAd/BipKD+53RN9+NWDfENjVscqF+TcD5BYMBWL14wFl
 y7Tw==
X-Gm-Message-State: AFq9FYJh113d2Mjzp26fJ9Q5gOVQYE71EQ79sf++T4mPSCFxfiYkdaAC
 rbo2Zt4Zm1A0JzMMYoY3fEGDHWWWJ5QEDxunF22C2rCR5ahnmcKznz43TsQ718O8aZ7Vmwr4yqA
 AzC8xRqw5AnsUp2PV3fz/JGK+uVfBUyS1YBwQgRMlKFcoSuEPEt3/dkoxcjJv0BwsTk8/
X-Gm-Gg: AYBFou0K+k69hkX4Dem6KNMXLear6SWPa7ihyxoWFitz5zydDbSPOzrmBmNiThmKsK2
 pVhKZ3nICDs6lWsstjoUaCvu8/GauprvH/mSk0kWWWLARxHasf/C84c3myegQZrX5ySCIxScJvl
 dAwzYXdnRc5rYQ8QWCElWWvR6EI+lVMQM/2mhpMImeIJvw5aNDNGNYUwo+JbCQfyOw9g87VMbLS
 +6vQD7UyTRqtJE48PEl6KDpU81q7Pg0lxn71rvulok+Gw5QQ+EO8C/xFSLcLXfNli+WCQ9/6gTq
 gXG5bWvU54IsB9obyZw0XiNYpBiy5MsUfD8BWGzxm05s9Qg1ig7xUvtuYs4LNSRu8a+uUFmXNmh
 o292ZxtQleOp73SyI1z5h8nUr4hj39X7X05e8OwZVnbgGaSAJacBJC0Ty7SUoId/PdL30zRiyu4
 m/CN/mPJ9WXSyLGWjlxY3tt8SbboQwfg==
X-Received: by 2002:a05:620a:2720:b0:93f:26f6:6bab with SMTP id
 af79cd13be357-94408a80789mr339268285a.18.1793198043695; 
 Wed, 28 Oct 2026 07:34:03 -0700 (PDT)
X-Received: by 2002:a05:620a:2720:b0:93f:26f6:6bab with SMTP id
 af79cd13be357-94408a80789mr339263785a.18.1793198043208; 
 Wed, 28 Oct 2026 07:34:03 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a978795f42sm53938835e9.8.2026.10.28.07.34.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 28 Oct 2026 07:34:02 -0700 (PDT)
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
Subject: [PATCH v3 4/6] tcg/riscv64: Fix constant handling in vector
 comparisons and selects
Date: Wed, 28 Oct 2026 15:33:28 +0100
Message-ID: <20261028143330.6518-5-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261028143330.6518-1-philmd@oss.qualcomm.com>
References: <20261028143330.6518-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: S7RE7OiUIphDjOSxk4SaZzw1_SVb2RGs
X-Proofpoint-ORIG-GUID: S7RE7OiUIphDjOSxk4SaZzw1_SVb2RGs
X-Authority-Analysis: v=2.4 cv=Cssq4X4D c=1 sm=1 tr=0 ts=6ae207dc cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=NyIpxno2YUF8kvApL20A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA1NyBTYWx0ZWRfX63sFlKhGvbF4
 zoqcF9ho8yoOlhTghMDr+rqObe2KxDKsCRSkCWjjuOdBTMQO8TKNB2kWi4fv08vS/cQ+zO25kiE
 GC163XwUow87gHILjSv5JPGCrcEog3wTSJsD8gLYg9q70KkqFSIsxQMT75ainw9UBRyunfl10o9
 9zHFDwOX6J/CHRHl06YFsfOkzBXDmOqk8tCKasDKIohObTcO2FXu9OF/y2sXtptQTKC8TGKxgZn
 6sHeJ1T/5dO+5YbTJQA2TDGfymRIxQ8E4ilbrE28pSclwr73iGd+Aolyj8dnKHkvNTuDPrmXAzA
 pjAlHbUG8bSTOzhgVWl+lB1+BPd5N/ePEYJlU8ffgLDeMo+rZPTLJ/F3gNPLAjiTuh9OBBi3SlM
 gQKSbfdjKpszVNDxeBDf135dwU3FBs5C3UYH2HTsUKVehRK/Q9rAdKqa8vzdueJpRg2JIfqtw0j
 1xPgLJLdzfOh9hntErg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA1NyBTYWx0ZWRfX4QtxfG4RPLA1
 EqTB9D50+DlKsOHPoiRVS9NiNCggnllr/x/fU38lZs9bFG9mYp9m5+5c5Um5nRunz2D4rDjHN+5
 vMty2KjhkZKAuaqD19kiXTwzyjk9SRc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610280057
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

tcg_out_cmpsel() takes constants as TCGReg and passes them to the
encoders unextracted. In a release build, "cmlt v0.8h, #0" emitted
the illegal instruction 0xffffb057.

Use TCGArg for these operands and extract the element with
vec_imm() before encoding, including before the LT/GE adjustment.

Fixes: 006352d69f14 ("tcg/riscv64: Assert immediate in range ...")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 tcg/riscv64/tcg-target.c.inc | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tcg/riscv64/tcg-target.c.inc b/tcg/riscv64/tcg-target.c.inc
index a3d995e290b7..168932711796 100644
--- a/tcg/riscv64/tcg-target.c.inc
+++ b/tcg/riscv64/tcg-target.c.inc
@@ -1555,9 +1555,9 @@ static void tcg_out_cltz(TCGContext *s, TCGType type, RISCVInsn insn,
 
 static void tcg_out_cmpsel(TCGContext *s, TCGType type, unsigned vece,
                            TCGCond cond, TCGReg ret,
-                           TCGReg cmp1, TCGReg cmp2, bool c_cmp2,
-                           TCGReg val1, bool c_val1,
-                           TCGReg val2, bool c_val2)
+                           TCGReg cmp1, TCGArg cmp2, bool c_cmp2,
+                           TCGArg val1, bool c_val1,
+                           TCGArg val2, bool c_val2)
 {
     set_vtype_len_sew(s, type, vece);
 
@@ -1574,7 +1574,7 @@ static void tcg_out_cmpsel(TCGContext *s, TCGType type, unsigned vece,
     /* Perform the comparison into V0 mask. */
     if (c_cmp2) {
         tcg_out_opc_vi(s, tcg_cmpcond_to_rvv_vi[cond].op, TCG_REG_V0, cmp1,
-                       cmp2 - tcg_cmpcond_to_rvv_vi[cond].adjust);
+                       vec_imm(cmp2, vece) - tcg_cmpcond_to_rvv_vi[cond].adjust);
     } else if (tcg_cmpcond_to_rvv_vv[cond].swap) {
         tcg_out_opc_vv(s, tcg_cmpcond_to_rvv_vv[cond].op,
                        TCG_REG_V0, cmp2, cmp1);
@@ -1584,11 +1584,12 @@ static void tcg_out_cmpsel(TCGContext *s, TCGType type, unsigned vece,
     }
     if (c_val1) {
         if (c_val2) {
-            tcg_out_opc_vi(s, OPC_VMV_V_I, ret, 0, val2);
+            tcg_out_opc_vi(s, OPC_VMV_V_I, ret, 0, vec_imm(val2, vece));
             val2 = ret;
         }
         /* vd[i] == v0.mask[i] ? imm : vs2[i] */
-        tcg_out_opc_vim_mask(s, OPC_VMERGE_VIM, ret, val2, val1);
+        tcg_out_opc_vim_mask(s, OPC_VMERGE_VIM, ret, val2,
+                             vec_imm(val1, vece));
     } else {
         /* vd[i] == v0.mask[i] ? vs1[i] : vs2[i] */
         tcg_out_opc_vvm_mask(s, OPC_VMERGE_VVM, ret, val2, val1);
-- 
2.55.0


