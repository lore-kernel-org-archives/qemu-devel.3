Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944D0606A891
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 16:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KYdUoPa6;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XDSkZzrE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRttO-0000zK-Vg; Fri, 13 Nov 2026 11:12:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xRttN-0000yJ-TF
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 11:12:45 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xRttL-000804-Pi
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 11:12:45 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ADFREg01190175
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 16:12:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MA0TPwxCTdUxsdMtN7k2yzrXgzdN0tBqodwBHMHtQeY=; b=KYdUoPa6OWnOoH1C
 E4UqVNbqHmhdN9fLC6IC3nZBZwmtXNY8ygDVcpu618833q1bt71DyUAyeDY6D7Le
 41Npsmb5rdaU1W2Zm4hns+1Afy3e0rtWhJeGOp3BiHXcJdIGc/T2KqD0FOKvCzO+
 hRICfywZWltMgewoLZbcW3R2D8KdSwgVAm2GCymU4pZ3BEa8nzxAN3bMsMRngyy4
 t42DyRdo04Ae2e8V2Rg7ajSJxH7hag+wiwXMHDnS0FVijTZ6sdFSpv7uFb30Dii0
 +uKjO2A7sLB8+hQWUZC115DhryASIRcvrOPQVs8Z1ucPLFIERxmOWd2BAY6U27Ur
 jwIgXA==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwqufk4ty-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 16:12:42 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-7d2cb77c7abso98941137.3
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 08:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794586361; x=1795191161; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MA0TPwxCTdUxsdMtN7k2yzrXgzdN0tBqodwBHMHtQeY=;
 b=XDSkZzrEIypL1URT75L6g/GTMZ60hE/2owbB4yWBrwws1UF6H9AZ72D1Mi4KfzR9Lj
 QZJ5ZaeMxbrZ+NLpbi+h5qwQrRR7bYnRRexkWOAoTnkP4s5o7PWetaFGVg6USzU3weIe
 Cw/lOyIiuUPa3N394Ud6IMHmzr+WXRszrM+Hpbywu8qz4Kvg2gTXVxtd7n1ekNwKVHVe
 58rjng7h1nbVDfio/wzEO1sNgGdRAJx8FVOb2+gONOVZ1n0MsnEz+jDq/IDnU64MMmrX
 rxvHplG+StTyXx0FbOpE8X8cJ1ntLJ3upVcOLP2qoxX4o+U/Vx5q8HtXIQeQMZRpAzE7
 sFqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794586361; x=1795191161;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MA0TPwxCTdUxsdMtN7k2yzrXgzdN0tBqodwBHMHtQeY=;
 b=QqQqHs37JFC5K0bwjT8jco4dhup0WRJ9nmGiYUILHqm1NqBrm3yYQZXL0ET5G+3hxH
 5w9e/xnTk3g2w0V1rhhQzmI9AH5sIG3V/IWxWwHLoUtWEySPPW8THxGvo/S0x3D0go3b
 8MhaeEvMzRyxHPV1W9/07z5KXoV9ktXsGS7yzRnx6/0Cq+2OM17c39zbwynRz/IPVOPZ
 tsYKhUylRX+Lc2tVG8Nr7gGa/ImqQP6MhHpejKrwX/uTq+Boyw+N4u5zSqOKxzTgSyZp
 n1Xbr5+75XC+f58g9HKUbbOJwDFIyqSQeMPG2qHVkWISk6E/jdLpnyRus9OJSDaDh9Dn
 iEng==
X-Gm-Message-State: APuU4Z/ZhQLmJysOxDiZ09VGMjNXzjJeznsqo9t2jjJ0dzBaOzRA1WCM
 +hftZhR5jldzefEHST2q0gnJAkC2Y1QBIoylbzeNlgGe+OgP4v09lF9IhcYLEi2R8JbnZGkUa1l
 pztEJAdKfPf+crV4tga/KV/mNjd/WQZesRgO67nX9cCF+DK6mz/a1yBRQ+GQZq8AL5Ep/
X-Gm-Gg: AYBFou3LcMNMvScGeVDkC6sjDlgt2g7vRHyPWLtedV5TL+ILUNSkcE65UxINWLFIyzL
 02weaR4p2u+36gN/QF/l7GN3Q35WziY7TFf6CNONNuI6ufSXU2sFuaE1tZEPaPum27DZ3UaXsPR
 9+In2Id30PMCRCjiS4khBieNvKHkgNZASPJ0JOl1fKcvoK7RoJE+5Hx2h/IM3t7PL3NcurtrF4H
 tq+qopENecSCrCRnFA8UGSFBeQ+5z5ov5au2GGYzWhrW4kOiHiyxG7DHMDLD4kUK76B9HeaEiDl
 1ZIGAezN7oCj9g95oCqWf71a/sSu6abKmJKPlBSSmts1dKjg/VHuB9E+xNy4T1ZwTsJqNGWN9fq
 /K4OugeqFVdMIw5VkAD0zmo7U8o3sttCjFPNRKHcI4UQjJLhf4lrmqqAk+dC1zCc3vGo5jgx4Ue
 gVQfsfHLTNNoiAPQ==
X-Received: by 2002:a05:6102:512b:b0:7cc:32ce:4c49 with SMTP id
 ada2fe7eead31-7d64d82ba02mr816048137.27.1794586361289; 
 Fri, 13 Nov 2026 08:12:41 -0800 (PST)
X-Received: by 2002:a05:6102:512b:b0:7cc:32ce:4c49 with SMTP id
 ada2fe7eead31-7d64d82ba02mr816034137.27.1794586360579; 
 Fri, 13 Nov 2026 08:12:40 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb55ac0e3fsm58849725e9.5.2026.11.13.08.12.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Nov 2026 08:12:39 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Vince Del Vecchio <Vince.DelVecchio@mediatek.com>,
 Faraz Shahbazker <faraz.shahbazker@mediatek.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Milica Lazarevic <Milica.Lazarevic@Syrmia.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
Subject: [PATCH 05/19] target/mips: Enforce alignment and 64-bit CPU for the
 DSP LX loads
Date: Fri, 13 Nov 2026 17:11:43 +0100
Message-ID: <20261113161158.25811-6-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261113161158.25811-1-philmd@oss.qualcomm.com>
References: <20261113161158.25811-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: SVQ1QU_92ZP21cuU5VtacH5mnpS_TVsr
X-Proofpoint-ORIG-GUID: SVQ1QU_92ZP21cuU5VtacH5mnpS_TVsr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA2NCBTYWx0ZWRfX/actUi6YOA3A
 NWtVrvXke1He1M4/8O1Tw+QZlujLyTf0W9z0Lrtg/FuvtQjL6QfaaCTd/sKWaj9862uFz5mKmPW
 8+JWStuTcgneIqy9rIeluctOzQssvM5079iizAuXFN52Uy28/ralX10nEl57BIWPCPdPrxhSYUK
 Ley9vbcHPeQGRzoeGiJ52QYDhj8+ZA4RbSrmyTkrYQSnpVfuPGKWHASojXvW3VrsCCYujzL2oT4
 0PyKIeBfmPGiywuFG2Dm2hDEfl87/dplx4z1YF5oaoaCSVPVWQEsPJRHCQTc/bd+0CMReMgZMLa
 D+7GsFoXLTCtTqsdKWtQtoda/u2OPscTpJJieXxD3xId6VXKl6wgtz/Difwi4gSAEx5i5Sm4NyK
 /4D8V52f5IxUjfuNJAU+gMBX/ZbOFeb7olpPJRutkIvmYwftAC1/PzDu5/zw7xRNHYfD2NDfs5t
 /d+R9rFoaM/NlQ24oIQ==
X-Authority-Analysis: v=2.4 cv=XZocX455 c=1 sm=1 tr=0 ts=6af736fa cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=kI7ue_SDoHa-woyrWu0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA2NCBTYWx0ZWRfX1BKAB7MAa0KX
 z/zSzBiIPGrs6suituooI3TOj0Sjjs5C+WGiCsK7CIT9tGa2dfPPgP8ai+reCNzL5UEcYhXU4jd
 FOuY9NuWyRDhzStkJ3qsCJrCcegFECs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130064
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

The DSP LHX, LWX and LDX loads require a naturally aligned address
and raise Address Error otherwise (MD00374 r3.01 p.130-131, MD00375
r3.02 p.145). Use the default memop alignment mask for them (strict,
except under linux-user FIXADE); LBUX is a byte access.
The Octeon LX forms share gen_lx() and are unchanged.

LDX belongs to the MIPS64 DSP module only, but was decoded on any DSP
CPU in a 64-bit build, including 32-bit ones such as the 24KE or 74K.
Call check_mips_64() after the DSP Disabled check to raise Reserved
Instruction there.

Fixes: 9b1a1d68d041 ("target-mips: Add ASE DSP load instructions")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/mips/tcg/translate.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index d1be32bfd9f5..6966b7e56abb 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -13653,17 +13653,18 @@ static void decode_opc_special3_legacy(CPUMIPSState *env, DisasContext *ctx)
         switch (op2) {
 #if defined(TARGET_MIPS64)
         case OPC_LDX:
-            gen_lx(ctx, rd, rs, rt, MO_UQ);
+            check_mips_64(ctx);
+            gen_lx(ctx, rd, rs, rt, MO_UQ | ctx->default_tcg_memop_mask);
             break;
 #endif
         case OPC_LBUX:
             gen_lx(ctx, rd, rs, rt, MO_UB);
             break;
         case OPC_LHX:
-            gen_lx(ctx, rd, rs, rt, MO_SW);
+            gen_lx(ctx, rd, rs, rt, MO_SW | ctx->default_tcg_memop_mask);
             break;
         case OPC_LWX:
-            gen_lx(ctx, rd, rs, rt, MO_SL);
+            gen_lx(ctx, rd, rs, rt, MO_SL | ctx->default_tcg_memop_mask);
             break;
         default:            /* Invalid */
             MIPS_INVAL("MASK LX");
-- 
2.55.0


