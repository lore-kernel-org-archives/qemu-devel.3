Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4332606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 23:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EhbrFu2j;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SxV34qT0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT63s-0003Tv-Do; Mon, 16 Nov 2026 18:24:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xT63g-0003HK-G8
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 18:24:24 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xT63Z-0003JA-PU
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 18:24:18 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGJfQQ52590223
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 23:24:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9v4puvhLpTMszKdXZU4WXi70UwSA6TYBPT/LJ1m3GiQ=; b=EhbrFu2jHunMAPDB
 BLbSpEnqMOobFD303eOS5gDSA/rSGazjufP17TZDH3P0NXbFXFUAjY2KBTx2jqcn
 5nGhopvi9vVbUqJiLdOOzjnHA7J8HEYtPllL7lqJHVJI8HLGJuf0FJlamW2QBai6
 LWO7Tl6LYELsu2ku8Gj2rS7KdbxrkVz4cYLU8Xlaq9O3bwBW0lohJUz3fCrOkdIi
 tgGRIf/ELnHMcRIwkNxVvQ5UrK8uA+bA8WxuiOn76E3n6vMYR3reRWPnlC1Wh04Q
 nzvcILi5ZqDQR3vQNbzdLHsOK3QQkt+MTMGZkGPFBUJGhbUSmFPX6ojTtLequ/Tx
 OElKQQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hyxx2k88p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 23:24:12 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f5844cb60so77755785a.0
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 15:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794871452; x=1795476252; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9v4puvhLpTMszKdXZU4WXi70UwSA6TYBPT/LJ1m3GiQ=;
 b=SxV34qT0r6FvEs8TBaVIJ6yWD7sXEW3HrkAxVNDUBIkffWPhyQbDtWFyb35SdQeQjH
 xUX1B8gCToaPwDq+TIoGzeBZ71YgiomrlmkYwJyQW4Isn1Zt3QHNTNnS8JYeNo+GSrpE
 pRUL2UstEUyaNex7jjV9FTqXysBwU2zRl6UrBpfKMwN1pZQ/mcCMy3egrOz48kkOfGEF
 Ws1YQ7gFJ+F68pklmWhMmA7TJrbn9QvC94i8iaI77g9XeMbzo2VCNq32/xcfjab9RSoQ
 AiCm3NYduGjVzG5Ou5hfFOxDgTxgamaH8STMSCJA0wQhE5dGYZKBedM8oQiVwGJB9qbj
 TSOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794871452; x=1795476252;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9v4puvhLpTMszKdXZU4WXi70UwSA6TYBPT/LJ1m3GiQ=;
 b=0a/4BrVh4JeB8rm4sw4hvUpvfBCvQcAQjkfA34BXeuBmK1dxvzjmJclluNxvNxEkrL
 OKPCXN8QX5jBPnzbkZ+GK/h7JCjVuAPrDu6PDTqrvyZiPdyVYHj9jDZYSIo4GIFNgE6K
 J1dVKgaWOS07uJ15qf+ZPk63KpPHbg3C/XGLP4wvR5CkpHFc+YyAkyxRy9p0tE/bGxFh
 iYMBb4nUQL8H1yPNSWjTksYa2qN+Kd58siGwXW3IIUJcNsO7WhmnLfGJL/7dMSnx5zpc
 TJaciUoHvEum6uwS4sidyNJeFgv1kicA2Lbby+nazD8KXyhsEa8zdaj980ty3EU7jDZD
 2kUw==
X-Gm-Message-State: APuU4Z/Wl4/6xoCVY9hhtt26ImqjSTv+ILSVqQETc+C1D5fTeydxj8QA
 5TWjTkuS84HiXWjAPlEtRkSZDH1xBk2uVI92tNLFA437IAJWuCUBiCOoRoARwtYK1+lP3rALnUB
 bx2YTAdQGDFL5fNUb8XlgzGsfYoJOcdZNmuf/q16hFEfBNYLriUQjgb2BiI1CQzlJgw==
X-Gm-Gg: AYBFou2BUuZ0uMtix2j9yFz3+Cfnuqvg5En/IPRwewooJZWcwp+gxxV/oAkiYcVepSX
 9OWSSAJ8K3mVdGie9S3RFy0VWEpj8O9TNtej95OzlN6YjQ6rMAG2fGQjYUo9LF56yNA742MD/GJ
 0QM252UchKwxpU97y4tzxvs8jLjnFb1vwOn0hjeWiIGePXFct/vT0PFrUgi1N02ERQqPyLav2T3
 kA9gipSmvHD0X9mKRjx2aB8Es5yBygNsn6yhWUjWT/Kg/44Mo1EIBD5yC6sikw6GT/Fyizg+Qde
 6Pge2O6oRCnsT0dr/H58qRPwLQ2Ihlm19fZSWSYNmTnMdDZRDLIlY5ZeXDiKlYUJPWy6rmVSrMT
 lN0ii91Z4zxg04xC1dmPvbGzAfHwhWS8W25e3LKyfvIQjoCRAA78dlyXqbgjfLnhS4QnPSLQMER
 +V+MxGJqcTrjL/dw==
X-Received: by 2002:a05:620a:4726:b0:93e:618f:8127 with SMTP id
 af79cd13be357-9498b874ffbmr179138585a.8.1794871451751; 
 Mon, 16 Nov 2026 15:24:11 -0800 (PST)
X-Received: by 2002:a05:620a:4726:b0:93e:618f:8127 with SMTP id
 af79cd13be357-9498b874ffbmr179135785a.8.1794871451212; 
 Mon, 16 Nov 2026 15:24:11 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a3d39b8a37sm705075f8f.46.2026.11.16.15.24.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 16 Nov 2026 15:24:09 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 04/22] tcg/riscv64: Fix constant handling in vector comparisons
 and selects
Date: Tue, 17 Nov 2026 00:23:17 +0100
Message-ID: <20261116232335.31593-5-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261116232335.31593-1-philmd@oss.qualcomm.com>
References: <20261116232335.31593-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=R7WWitRX c=1 sm=1 tr=0 ts=6afb909c cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=xWu8-Agft_6X_INOG6MA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA5MyBTYWx0ZWRfX1S7B6rKnQi7w
 JIfFxpyefR6GcxoX8Rv9UQdh6SQzIZwE2Tpc1xc2HBMYrHNqkNeCfCdlFV/zldX2GAxXr9LmXhD
 rRF6pXoSc/niSl88HLWhZbyVFrMtVrQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA5MyBTYWx0ZWRfX3+TitISZs/vb
 gQsiEiwgMEzI8m3M4tRknD9gmM5UnCGhtWifsrQfK0G3FfNpDktSzupSnzuGyEM5t7woQFb5cxN
 OKuoiDiR3pPIxrkESfR3cIWNIlo3Z8N8OROgthgcxBER6aLy45yX0OZung+Df3AytZRW+qLzmzs
 9OwOC7xoT0SeFwbvLcWujDDLcvpQDwnmlkVIrFt7KnXX1+HBgEDSPI/TKs+xhmQcD8WJpCg3aJO
 v0Roq05LCy4vBer8xb9qV0L3JoQemEO5+2qqbWElojbRDLXvc8FXwMuhs5K6Ar++ysoRnxYnccv
 M0cxUZdgfz7588Z1On8hYY43ahEKh9jpBfHmMz1tP1VnEHVHmHrIP3AS1KrWrMbsa37UJ5YBezp
 rdx3EbCFmqRlFX4rTMNK6h3X1eVNEVrDXotwM+WFX2g+mUyZ1/tpZsI07vFvlK3Mw38aZD14xSu
 Ue4AVlN5Kmiv+cR+Img==
X-Proofpoint-GUID: Al6bLrM5nHojkmbOHjjNfLat34WmLF05
X-Proofpoint-ORIG-GUID: Al6bLrM5nHojkmbOHjjNfLat34WmLF05
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_06,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 phishscore=0 adultscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160093
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

tcg_out_cmpsel() takes constants as TCGReg and passes the whole
replicated value to the .vi encoders instead of one element. The
encoding is still correct, because encode_vi() keeps the low 5 bits,
but it trips the range assert added in 006352d69f14 in debug builds.
E.g. "cmlt v0.8h, #0" computes 0 - 1 in unsigned TCGReg, giving
0xffffffff instead of -1.

Use TCGArg for these operands and extract the element with vec_imm()
before encoding, including before the LT/GE adjustment, so the assert
keeps checking that the emitter agrees with the constraint matcher.

Fixes: 006352d69f14 ("tcg/riscv64: Assert immediate in range ...")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20261028143330.6518-5-philmd@oss.qualcomm.com>
---
 tcg/riscv64/tcg-target.c.inc | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tcg/riscv64/tcg-target.c.inc b/tcg/riscv64/tcg-target.c.inc
index 55685db44f3a..902e600a1f51 100644
--- a/tcg/riscv64/tcg-target.c.inc
+++ b/tcg/riscv64/tcg-target.c.inc
@@ -1556,9 +1556,9 @@ static void tcg_out_cltz(TCGContext *s, TCGType type, RISCVInsn insn,
 
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
 
@@ -1575,7 +1575,7 @@ static void tcg_out_cmpsel(TCGContext *s, TCGType type, unsigned vece,
     /* Perform the comparison into V0 mask. */
     if (c_cmp2) {
         tcg_out_opc_vi(s, tcg_cmpcond_to_rvv_vi[cond].op, TCG_REG_V0, cmp1,
-                       cmp2 - tcg_cmpcond_to_rvv_vi[cond].adjust);
+                       vec_imm(cmp2, vece) - tcg_cmpcond_to_rvv_vi[cond].adjust);
     } else if (tcg_cmpcond_to_rvv_vv[cond].swap) {
         tcg_out_opc_vv(s, tcg_cmpcond_to_rvv_vv[cond].op,
                        TCG_REG_V0, cmp2, cmp1);
@@ -1585,11 +1585,12 @@ static void tcg_out_cmpsel(TCGContext *s, TCGType type, unsigned vece,
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


