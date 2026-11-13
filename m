Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3A8606A8B6
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 16:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WRUW2/Wt;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MNQ4fHlb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRtwA-0005Cu-Lg; Fri, 13 Nov 2026 11:15:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xRtul-0003Sw-EI
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 11:14:11 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xRtuj-0000N1-QP
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 11:14:11 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ADFRRnP738055
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 16:14:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zW11rmRsNZGc/uNLUSwQvTV8WQJqGKr3BHpraN1tjq8=; b=WRUW2/Wtyf3kJKok
 odw08/9mQVj3VRyak42atnk//+LxNgv0a5GsNzck2y55t2L2bl36yOXmP8NqhU5T
 QAuttlAT+fSH4HSjawNV1bSsbjUIc5/BUl7SQ8czu8qCzKJ++ruBvRM7NXqinKUg
 NoPi+6fsrPsZuWegWq2C6QaJWZhrfMWaIv0THimtOhNa/4JavLCpZkc+rdSN4jHN
 jJqZEA0AFhOFEJDortSG0Nedsx3Xshz0pqhfUTx3U9xC+ngNnT/1ZkRoafGoP922
 qG+H6jUM3NxXHMOKaEmKb0IPUuvs5BnGA3q9WtUYkBB5dFOLYUenNZgmPDrBnpNQ
 mHpV7A==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwv37j9g3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 16:14:07 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-7d2cba05824so1154909137.1
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 08:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794586447; x=1795191247; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zW11rmRsNZGc/uNLUSwQvTV8WQJqGKr3BHpraN1tjq8=;
 b=MNQ4fHlb8HqI9LDbFpnIxYM0gMk1O5OOqHQtUz8XA2ItiXV8YRbcs8wlEOl3XidxQe
 UwOPm5EFEi3Pabocj3uCjLAADk0u5oUEOwqznrDRXGFbzywvmzKTNLpLERgNwj07zTix
 FLKLKyNFyLrstFfLJUchehKovOCZLp1alKHjIa4zcJEuU/uDkARgYi0ySW/uX6uiNP9h
 Xojqv/UnbAiR2FpC5jRZfgwPbmIP6W7FdIUlmDZlinVfacL4pUeuEBVQeLRqhKW632Za
 +Nfba8RRBo/9AfwKpGQxr51xkpiCFsTu+ZBOzkvgAal+RE1WV/OPljgV8R5vD6j4tnfM
 xdlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794586447; x=1795191247;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zW11rmRsNZGc/uNLUSwQvTV8WQJqGKr3BHpraN1tjq8=;
 b=MBJD0beMaZ/BPHlmhBGkehxj62msnALo33HBbo2J9FHP7tdTtQjSf0ln67d659F1kJ
 A3AMiNuKvLNEiP7bYQMxy8+VbMWqIlJa+JDXlsVxloU12Irzx41f/xHAzVLAhmvIXwo5
 2s3S7s3McI55nT9ZebXBVhcn8DYNlo5StogJBeUpdZhh++oyRhyY9c3xLdmcIrH2AQPS
 d5uoo1zXJk9gyN5xYh4w8AKG4djNnUlZ4nhpuUtPWu36woSUVWRTSYISWpyzExMcE/5s
 mWKGFePwOuHych1ScfH6lzkyldhA7F+/cMCUr3+xcF5V2WiGFyvqM29iTAhnYy3BUoXO
 Xt2A==
X-Gm-Message-State: APuU4Z8dxS52UcGenNRNr0alAYJhWx2LO9hqr3Wayh8HS4jxzAXctNly
 D9kli1/JuuMKimffoAomx9q8bnlEol7gurXK9lcHNSDr1SWm185rEyLuw2Vxk5gwCRtjw2/8ReA
 BQmgBuqwAabdnzveFjMVmOKBL46XXpWo18pJqn9PlZPzl8KeM65QLg5ZcEJnEkUO6rN/1
X-Gm-Gg: AYBFou3lOuS4oRyEcCF2plWaFDG+vN/rpJWxBWHDOaF0ndLb3oy7zcgTtHfgnBACA0o
 YMIgoSoc3wJAqmSmWi0QnlFXnNx9ePksbiVOFORWy7cg6Ndmn/5+6VgkjdaYmawMPAa0Vn08fW7
 6pKqmWI/mqdEC2Ibs/VzOM1qFQw0XPe2KtR87QEnNcbSO+bBb1d9SAGLK7To2BcydH45RUPnlR1
 +BAlBi1TX/ahnehvlrF3RS02xL8mLMSiPaNR30cRRBKfhWu8ho3EMLk/we840245P2dUZon216g
 9f/P95OM++UEV/IPQWQ4xFqJ/lbu2HFArRxhz08K1P5+cMmWAVHNIs06O6Id7F3xLirI1dXbe8W
 e6/aJ+DrCfFJvwgXhXeqsZYbaBGhllAhQEwyH4H0kHv1GDPh/GxjRuTFd8jz6voIp5mdGPAnhiC
 aGiRaUXYHOUfxCbg==
X-Received: by 2002:a05:6102:4410:b0:7c3:c0b9:9028 with SMTP id
 ada2fe7eead31-7d64d77b869mr1087709137.24.1794586447224; 
 Fri, 13 Nov 2026 08:14:07 -0800 (PST)
X-Received: by 2002:a05:6102:4410:b0:7c3:c0b9:9028 with SMTP id
 ada2fe7eead31-7d64d77b869mr1087701137.24.1794586446746; 
 Fri, 13 Nov 2026 08:14:06 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb5ba25b50sm29998895e9.14.2026.11.13.08.14.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Nov 2026 08:14:06 -0800 (PST)
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
Subject: [PATCH 16/19] target/mips: Decode 6-bit bit number of nanoMIPS
 BBEQZC/BBNEZC
Date: Fri, 13 Nov 2026 17:11:54 +0100
Message-ID: <20261113161158.25811-17-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261113161158.25811-1-philmd@oss.qualcomm.com>
References: <20261113161158.25811-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA2NCBTYWx0ZWRfX3mwKWw/mF7kr
 v3g3riHQZo45AWRpRunZ2w56JNmCQq0CaAHzwFe/YQ42IkkZTJBCAwBm4qi0efO6lix5mjFpYb3
 OzdkzJqoAXOsWUIg0JfpKajIIVoJyBs=
X-Proofpoint-ORIG-GUID: xWRInby5Dc0jRGlJQcZmse-AMIuxsRUe
X-Proofpoint-GUID: xWRInby5Dc0jRGlJQcZmse-AMIuxsRUe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA2NCBTYWx0ZWRfX9vKVOnNkS8Ak
 2y9dZ5rk1SvMdYX3Cako+OPaBYEr6bif0GXkddVMrbBEr3PKZaMWBARBHrpYAYFNXTpCQjAmfcA
 dg6BFqeDKVdJFucJ6EN4T8CW9X0ufJYTNie94TBBUViE+2lgrfwN50WW6wcgKJjQr2DjsAOdolA
 dut1exPcOmKU7jAt7Dor9tR63oFLgM4lfkzvjXAH8QK0ipaHiuoHbbZLHgdT9HTm7syOSEzeJAr
 y9074I1os4Gllelvs7IN71so3MnmT9GBNBmk7MJzQkownRhimIQSyTDV+gnpxRDQ+hmsKjdbuA/
 UzY6TTdbNly4eEgSJOjO5KNjcEwdrZqM7h+/VbLCCU6sgj3hVo5yGUfpnqqGdJMnATuHrrKiJ6W
 jkqK1OhhZZ5Cu3V8BvyljR0bpAENJCSYDxy4l/Bv+UACiIdtMRuKU5OtebAmeywPGKH/NTNlODW
 5JWSVR9cgLpM3L9ZnNw==
X-Authority-Analysis: v=2.4 cv=ZeeIpcVA c=1 sm=1 tr=0 ts=6af73750 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=M4u4gXv3FWbnTiq_ZVkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 phishscore=0 impostorscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611130064
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

BBEQZC (MD01247 p.38) and BBNEZC (p.39) encode the bit number in
bits 16:11; bit 17 is 'x' (don't care). The decoder used the 7-bit
immediate (17:11) of the other P.BRI branches, so a set bit 17 gave
a bit number >= 64 and raised Reserved Instruction on cores without
64-bit operations. Decode only 6 bits for these two; BEQIC and the
other P.BRI branches really have a 7-bit u field.

Fixes: 11d0fc10b7ef ("target/mips: Add emulation of nanoMIPS 32-bit branch")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/mips/tcg/nanomips_translate.c.inc | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/target/mips/tcg/nanomips_translate.c.inc b/target/mips/tcg/nanomips_translate.c.inc
index 3612c68561fd..68e9ca9cdb03 100644
--- a/target/mips/tcg/nanomips_translate.c.inc
+++ b/target/mips/tcg/nanomips_translate.c.inc
@@ -4403,10 +4403,12 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
         {
             int32_t s = sextract32(ctx->opcode, 0, 1) << 11 |
                         extract32(ctx->opcode, 1, 10) << 1;
-            uint32_t u = extract32(ctx->opcode, 11, 7);
+            uint32_t opc = extract32(ctx->opcode, 18, 3);
+            uint32_t u = extract32(ctx->opcode, 11,
+                                   (opc == NM_BBEQZC ||
+                                    opc == NM_BBNEZC) ? 6 : 7);
 
-            gen_compute_imm_branch(ctx, extract32(ctx->opcode, 18, 3),
-                                   rt, u, s);
+            gen_compute_imm_branch(ctx, opc, rt, u, s);
         }
         break;
     default:
-- 
2.55.0


