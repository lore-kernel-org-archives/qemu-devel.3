Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFA2606A332
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 16:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=a6wgaU9L;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Gq8Y2gQd
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRtwM-0005jr-7l; Fri, 13 Nov 2026 11:15:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xRtut-0003jx-9W
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 11:14:19 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xRtur-0000Nn-JN
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 11:14:19 -0500
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ADFQpw4074616
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 16:14:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HqEO89uvNXRdfraxCewRhPAAoZ0k5lVq+cFSsa/edVo=; b=a6wgaU9LefZdg5wt
 htst6v5gYR9d1euvIp/cLT0P0rydY5Fk7KNylLVy4rseU7WeKN24HDQHKPL870Wl
 VjIH/ZjD00OREX0TZUOmuYOXQX75B3UqtnmlUUJ7nbTfqGWMruQinfPGBK/JPPZx
 cjnNKti9fenxpsIb69Wfs3XWhUHuhuEjSN0Teb/muKQEeB7WY7AfiPIXYCxRq+8b
 m/jSnIwD3wQYty/6VQrfFG4c8qcc3wHXVEp8TBWocZoNg9qMPq0kwp6CA8oJMZEo
 fpR5Tm987QBxbAVOTfwvzR06tUhWt+TXu8Xza3FOgtSC2bvMTq8UF0hqPFIagep0
 mkKwJg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwu2mth2a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 16:14:16 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f5844cb60so234263985a.0
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 08:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794586455; x=1795191255; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HqEO89uvNXRdfraxCewRhPAAoZ0k5lVq+cFSsa/edVo=;
 b=Gq8Y2gQdeIvwVUvBHwWeAUq1XPgxt/QQtNKKLnQ9kpfBz4l77ZHH96A7SdvR5UGnnJ
 qLCnlP9dPSYg4PXY1Nwu6yOYV6gCYUrT8cOjGh7dyIsBy9XjJCPygoQNugCzE0Ornfvc
 HHiz6RgK/2lvu4eR9J6+e2Nr9Bl1CgB+lPrBvhXpv0pgohg2Lfz/E6vnNsOxwMg/DdCi
 crv5qUmX11mQ8Qu4tjhpycCghvRX3T7IZ46hsI/Byxjg/uagseBrk5Eujr5zDM5Q1lgC
 YlULRK28bYrfpa3tGzQNBjf0fxw7jyTa48PY0+nAQtH10c0cgmz46Ngcz14esNvEl8JE
 z/nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794586455; x=1795191255;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HqEO89uvNXRdfraxCewRhPAAoZ0k5lVq+cFSsa/edVo=;
 b=eDGZjpiqKC7IrBlOvr6uRd0q+SZEaIWQvX/vRL/WTVqzrA+UncllJ4evQ5xm8Vdstx
 ev/TRsZs3QMkW8fiOiSynPVb0cXkf8plSKrQkVreGIWKqWsSF0oz/WoDderHXY2wsTKc
 /QrzUsyv2lig3Do5/g3m0J+CeGmqg9mL72Cfnra+AER1IyRTB7NDrdzzN07aalhW8Zaz
 4q9I30qAzxnmdKZtdnDGAdq6B/bCvcDeKjvCGrGl7X2doVKQk4txiDXWftOnaqbC+cde
 /KD2tkeSOonRM/NoX2dBvI3CYQ44b6bUopwinQ6HQYb10/GRQ7XfDIqeWzvvbQy1UNwv
 RT5w==
X-Gm-Message-State: APuU4Z9bpfX0pdiNSMBBcHQCGwZqlVMNpDbecL9PXgiLVUZ3gIrRi3LN
 50R2UEGinWe4lojUO5Lb7XRdDA3aME8+vXLSZ7vqbNp+QgH+/bZlab2W+cr4vTuO/0FRqHcCWy1
 JMR3Gbh3rRDrG7lPNk6zRwNykCGjMaXrvw0bxbws4Whsl5K37/Tq8GfNexMSKmBLf6i6F
X-Gm-Gg: AYBFou1ih21uygWdysRUwReS4ws3jPOi0RjfJOxVQFkjnc0R0coCzixhNT9DCS1FEQO
 NLFay5WrUXtxH8CLBrEYVyGgOiMvXObYG7zO/NgX39ZQL9K+xsJ8EKIlLqAnrx/QA7mbtFAhPEr
 az8OPqLx+BYfInT5mknQprd6ttKCq08CAx+ITayKHgGXS6Uim1mQ6ButhYZDCDmc5DVkxCB6K+r
 a7GO4VvSxJuP+t/of5nmq01pkX4m/W2aLMZduuNWRtT+z+7meTeGvCpwnq2AZ5Gic5L6z7e+NO9
 v62lRPQUi7K9kwij0kyHEKl/8O1NS0FF9o5PYQfIyFZlW8yM5WC0JtLXzaVIdXMhD3KklJ0whFD
 GwRapnRmyaP+SDmAiYpR0GNTrgYPTDSYCDpMBpDIWig2oIXdygIlDkb4WEFGUXNyxaDnfi1bvxX
 3r+yka4JABsLv2pw==
X-Received: by 2002:a05:620a:a911:b0:949:3cfa:8592 with SMTP id
 af79cd13be357-9493cfa8d6bmr672840485a.17.1794586455188; 
 Fri, 13 Nov 2026 08:14:15 -0800 (PST)
X-Received: by 2002:a05:620a:a911:b0:949:3cfa:8592 with SMTP id
 af79cd13be357-9493cfa8d6bmr672835885a.17.1794586454594; 
 Fri, 13 Nov 2026 08:14:14 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c604ee47dsm5633472f8f.38.2026.11.13.08.14.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Nov 2026 08:14:13 -0800 (PST)
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
Subject: [PATCH 17/19] target/mips: Don't set forbidden slot on never-taken
 nanoMIPS branches
Date: Fri, 13 Nov 2026 17:11:55 +0100
Message-ID: <20261113161158.25811-18-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261113161158.25811-1-philmd@oss.qualcomm.com>
References: <20261113161158.25811-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: x-wWo0y8EvF3wpWN1W8DwjO5YU154E6Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA2NCBTYWx0ZWRfX832qDfo/b75z
 oaTUPzG34oQs0bEq+d6549XhrZ/pS4bX95Mw6IfgvJxpoPc5QOZDcpu4OOPP2sPQV8F2WrSty2l
 H/Ni9IDhUADdnImAbtLvFWLj77FrfITCnVUVIvkBIraPddy/mkb9TjHPV6x10UhXWdH1UpS5OpT
 K7NA2zELzWjXdiELMXMGtCH0Ixj9ACriH8Ak7lQrc/7zHz7pMREU2UGnj+N4dTisA2Jw1tfYAk7
 a9SX4wLP/uEAErOEx8P/OdwCazkimHnVBzKEHiy7mGxJqMFH6GpmFHTzSaXJ5ZI3xAansBTwS7o
 z1Lterr+acJSWPi0aaunuZXrG4VqUm0idPqSq5LuBs0yFGinGCBIGOJTFL33y6D4/NPXl0apR0u
 xERDrVRd6hPEOaXfp9VPKd2AETRJPsiOv6umDh+Nbv8AIM/5ZVfUTm3zqz/2r4tNvyejFa7HSjt
 9B9Nezkq4jk/YUFUZTA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA2NCBTYWx0ZWRfX38qT6q/KSFoH
 5l8Otyg59bEU0O9thISpNFml5seO7mMYohm5il0i1radNusoct07SblYuJifhR5agfIQ9ABcebK
 AGltACDF2XpjPpuk14p0KOUp9IgGqW8=
X-Authority-Analysis: v=2.4 cv=ddQVTnXe c=1 sm=1 tr=0 ts=6af73758 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=yXgUsjZhidMzqO2r6Y8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: x-wWo0y8EvF3wpWN1W8DwjO5YU154E6Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
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

BNEC (rs == rt), BLTC (rs == rt != 0) and BLTUC (rs == rt) are NOPs,
but flagged the next insn as a forbidden slot. A following branch
then raised RI, and a fault there got a wrong EPC/Cause.BD. nanoMIPS
has neither delay nor forbidden slots (MD01247 p.12), so just fall
through.

Fixes: 11d0fc10b7ef ("target/mips: Add emulation of nanoMIPS 32-bit branch")
Fixes: 14668cfaaf4d ("target/mips: Fix emulation of nanoMIPS BNEC[32]")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/mips/tcg/nanomips_translate.c.inc | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/target/mips/tcg/nanomips_translate.c.inc b/target/mips/tcg/nanomips_translate.c.inc
index 68e9ca9cdb03..72d72f6f84a0 100644
--- a/target/mips/tcg/nanomips_translate.c.inc
+++ b/target/mips/tcg/nanomips_translate.c.inc
@@ -4370,26 +4370,20 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
             switch (extract32(ctx->opcode, 14, 2)) {
             case NM_BNEC:
                 check_nms(ctx);
-                if (rs == rt) {
-                    /* NOP */
-                    ctx->hflags |= MIPS_HFLAG_FBNSLOT;
-                } else {
+                /* rs == rt is never taken: NOP */
+                if (rs != rt) {
                     gen_compute_branch_nm(ctx, OPC_BNE, 4, rs, rt, s);
                 }
                 break;
             case NM_BLTC:
-                if (rs != 0 && rt != 0 && rs == rt) {
-                    /* NOP */
-                    ctx->hflags |= MIPS_HFLAG_FBNSLOT;
-                } else {
+                /* rs == rt != 0 is never taken: NOP */
+                if (rs == 0 || rt == 0 || rs != rt) {
                     gen_compute_compact_branch_nm(ctx, OPC_BLTC, rs, rt, s);
                 }
                 break;
             case NM_BLTUC:
-                if (rs == rt) {
-                    /* NOP */
-                    ctx->hflags |= MIPS_HFLAG_FBNSLOT;
-                } else {
+                /* rs == rt is never taken: NOP */
+                if (rs != rt) {
                     gen_compute_compact_branch_nm(ctx, OPC_BLTUC, rs, rt, s);
                 }
                 break;
-- 
2.55.0


