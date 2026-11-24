Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE5C606A33A
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 23:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YF4JFbBp;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aH3drdtg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVzwu-0003su-F0; Tue, 24 Nov 2026 18:29:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVzwq-0003jO-VW
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:29:17 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVzwp-00083u-86
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:29:16 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOMbLE9031619
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 23:29:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6xsZVswq+G0zVU7hNJZq2lQp8BbpzMYxppw0olqX62s=; b=YF4JFbBp/iYXLSfb
 uu2XIUDt6B6djIa+YV+rXYaDUELCO17JwGwySZT+CJ4MlpJ76Z24qjp4qtV+KJIl
 DnBRelcJ9JjeUGybSTYdwfAIoKnmZMRX4Is6tF2qUcmT17Fae9MQGhm5//c7CqsJ
 SrjAGU5DB22q7srOmCBTB+NOjkuIYv01ZV+59NBY5GNxL/laN63SAnW04RlVUoFv
 zNhrGUR7T1BSZ7Jho15YHtiql3ABP/FuoqSx/mordKjrdMTGFomuU7UxlDrj88+x
 DdDxAOvKd6nf1U1VNwPsVgQtVqFxbI/rO7RaR3Fc88u4qfkDpkWKrvkfOX8TykjP
 N8UVew==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5ad7tr3d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 23:29:14 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-921286add9fso31444496d6.3
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 15:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795562953; x=1796167753; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6xsZVswq+G0zVU7hNJZq2lQp8BbpzMYxppw0olqX62s=;
 b=aH3drdtgtZKxVn4NliM/HGz6/BOWS6DYp5NP9yZ4pG4JYOQTHq0/25ydbKdUL0rVog
 5QcgP4j9dRsaQwtiYQOgQHDJdlsqrkY7LtD7Axh4hHxVKQ41RB/DadbMCCY3FFmavjOL
 /DuASI6QcQVG8O4F3y/ZdD+4fne/NiDD521N9Gto+8HECFgJTK7znbOoC2z2lNeUIO9m
 E5lSocDw1UCUtsdzmM5hC7ZJBv8FmjZGc0c09L3qwwKN2NLLonU5aLSYNm+w/mjipr15
 4KLfh3kbMEPoWpaADPJV4gEW2G9mmz2oN3PdQ/NHDVRYP/zVs8rsC3/5hvpNlPt8kLfc
 KoaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795562953; x=1796167753;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6xsZVswq+G0zVU7hNJZq2lQp8BbpzMYxppw0olqX62s=;
 b=TGSjgdwVPkcIcw8kTCa5SprFdAlkcMEGRG8vaV/sJpK6ArLBgvzK/Zil9O10DiP7UE
 biDsHs4hKQes8TPJiWX58GfsI/uaGsbCWrk2RkFPyYT7pq8gPAVNCmxWggNFRPli8GFD
 CEAmfQ18SsxxA9+U9AYOwmKUJzxRtuvWoMLR4ChpxinRH6hvQZk66IjJsrmSy8uGvXBr
 I4FoX3CITJlaKL5hxpgD44wMiFGRAaDIGbxZMzPbkagCb5sVbmFuxPSclMbX7pCyPyNj
 AsGHTPGQuubTLIuFuhyfapbtqGpSqBrvy3qXnr2HQdX2kcHFcwaZfgQQLSkvlDj1bO2L
 cYpQ==
X-Gm-Message-State: APuU4Z9t3N6kpizecmSOyp9OTuwmBCWhkUHoFZdpVQq+nHiBwn9D0VXZ
 qDifS0QIkl1j1uGHGiSxITzCt4LYv4jy3f87Tbh717n5L/562uGE4G+9YZU5IZcCRdG6ZWiIGlR
 otbHlnqlKgzvasvfOKYESOVBgSPdu8/vqqkfDQRuLI0zG9NJWaZzUrLa37dHakdf++hNe
X-Gm-Gg: AZFdTZdb5BjrhlASlicwFQuOM31XgAQFkAQUvtprDXH7YQ6iG4BI0CGCuUV/RYia4pa
 HXeE0TRBoiKHfVKm4JFc3PadJhFHGdGTuSliC98WHi8rwAVn9lnB8nGMxQTskd4YwnNKA7bBbXH
 Xt82IlMsW/KLj7b3TWvAg/Zk93HCb/wKgjNINjEoGOFpxhhNuYHQI8UBD3d2bq4J5Nn6qchWOGY
 Qt9DygaKL52ZT/XRkzbTQTfZMTzAonQSWMy6yRFeHot6838kWyvC2l6cNSL3enEQXJf/5YqwrLF
 wuqAP6ESr7n2WevULtfyXxBiFtGb+8Y4SWRfLZOSvbSDYryEdYzS5kTE2Vzz0JuRNijDx1pJLbk
 xukd5X2yOGfB9EjGi5P53jNGXze9egikO7kvIwhRWD7PX1aHLr6x4yl1IhdlCaFU6jEJkhlVQEk
 7v/uKCtrXZf3u9kQ==
X-Received: by 2002:a05:620a:4110:b0:949:a690:d9c3 with SMTP id
 af79cd13be357-949bab39bacmr2846649085a.62.1795562953462; 
 Tue, 24 Nov 2026 15:29:13 -0800 (PST)
X-Received: by 2002:a05:620a:4110:b0:949:a690:d9c3 with SMTP id
 af79cd13be357-949bab39bacmr2846645685a.62.1795562952991; 
 Tue, 24 Nov 2026 15:29:12 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab5ffcad11sm29533648f8f.0.2026.11.24.15.29.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Nov 2026 15:29:12 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 15/18] target/mips: Fix nanoMIPS BC1EQZC/BC1NEZC always raising
 RI
Date: Wed, 25 Nov 2026 00:27:19 +0100
Message-ID: <20261124232722.90234-16-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261124232722.90234-1-philmd@oss.qualcomm.com>
References: <20261124232722.90234-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA5MiBTYWx0ZWRfX2WObdEwbs1mg
 F1xGI2p46YuSKsg3WB+WJtHDlB1qlmyTPLpj8yAyHDNavcnkNcImY76RX2L5Yuf/1aG/O0/Kjuo
 c3RRYR838d0rW+Zlh6U4a643ItkbELw=
X-Authority-Analysis: v=2.4 cv=cI51IVeN c=1 sm=1 tr=0 ts=6b061dca cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=snbnvTbt-5-dSQZ-83gA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA5MiBTYWx0ZWRfX3h00pCht5ZFB
 a7nZfy1zLE/lpv+5PPUonu+rGtrUXaPC6ZzlYWFARdpkgWFwecNfHKZl2mwYigzznWBM3hQCaHj
 MsvvbmUm9EsKqQW6FFaAIqrX67uFI/jAhBlG+nL3wgrt4y3/hVz8i27Q5CL58d0vVY+OTySmjGk
 M0waN345g8/MYNS3H/9qSjJ7i9g0A05uYa3A36UW8rOo0FMQ4x2L2e0QDHXlEzI1/czVZdFMUzb
 dGnnrvav92LKBYUvo7TEFiQdBLd/Qg5+xY3yKFlWhSVxWNi3NV6H1n6MavF2pPb/zsQrW0/CxP9
 fxTfQL+Z1toAzDV3fIiVPBOhfCg9MFj5TzSkQiZSghOjckg5y4QCHa8ysrmLPIPbNI/SQTEmsXF
 QOnmUbWCjybxPx2OsaZ3ltUE/j8b8cBMm/UsK80wDUIFOC0cMPIAeJb9T9tjv079ipC5Ri2jMR7
 WdpnnjvuDnEkS6iw8VQ==
X-Proofpoint-ORIG-GUID: 7cKJSjwELyBn00XiCddi37SNnj0U_61L
X-Proofpoint-GUID: 7cKJSjwELyBn00XiCddi37SNnj0U_61L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_06,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 impostorscore=0 spamscore=0 adultscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611240092
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

The P.BR3A decoder passes OPC_BC1EQZ / OPC_BC1NEZ (the MIPS CP1
opcodes) to gen_compute_branch_cp1_nm(), but the function switches
on the nanoMIPS pool values NM_BC1EQZC (0) and NM_BC1NEZC (1). No
call could match, so both instructions raised Reserved Instruction.

The P.BR3A encoding is in MD01247 rev 01.01, printed page 288.
Switch on the values the callers pass.

Fixes: 11d0fc10b7ef ("target/mips: Add emulation of nanoMIPS 32-bit branch")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20261113161158.25811-13-philmd@oss.qualcomm.com>
---
 target/mips/tcg/nanomips_translate.c.inc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/mips/tcg/nanomips_translate.c.inc b/target/mips/tcg/nanomips_translate.c.inc
index 39ba96230596..dcee8df333f4 100644
--- a/target/mips/tcg/nanomips_translate.c.inc
+++ b/target/mips/tcg/nanomips_translate.c.inc
@@ -2558,11 +2558,11 @@ static void gen_compute_branch_cp1_nm(DisasContext *ctx, uint32_t op,
     btarget = addr_add(ctx, ctx->base.pc_next + 4, offset);
 
     switch (op) {
-    case NM_BC1EQZC:
+    case OPC_BC1EQZ:
         tcg_gen_xori_i64(t0, t0, 1);
         ctx->hflags |= MIPS_HFLAG_BC;
         break;
-    case NM_BC1NEZC:
+    case OPC_BC1NEZ:
         /* t0 already set */
         ctx->hflags |= MIPS_HFLAG_BC;
         break;
-- 
2.55.0


