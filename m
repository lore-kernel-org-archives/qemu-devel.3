Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E9D606A33B
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 16:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=C+m9QUsB;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cBwiAR9l
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRtu4-0002AY-Sd; Fri, 13 Nov 2026 11:13:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xRtty-0001xu-MG
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 11:13:24 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xRttu-0008Rw-GZ
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 11:13:21 -0500
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ADFR5rJ551880
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 16:13:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xFrpiDV3xzFHelDb4zO/SPhK0dl7q7vZPbU4BtCMd4Y=; b=C+m9QUsB1FRSIbFN
 OsJWkTvfIhpX5OCw11o+lvMsjNJ54r/u1k8ULkNV0Q6suru5/TH57eLY4NsQt+56
 Zx8V8LEv5H34xf3l6tRyXaaa4PEiQM4XO4ndj9faikRZ211X9/RY324Imj3JCBdX
 CnLlvosuoxTjfFQh6Jccpshn6JCDWASEFCWctAqI3BOYEieRSvQqjeVNd40DSRSV
 sBAEk8khdH4TQH6s3R6biBGEor5CkZThh4WTGS/V7gcfsiuvTvl/amKBZSIz4qEM
 +FeKDb4d1kJcuzjJ+B2u9HfJj1PNolsjF4Kep3+RHfdhPFxMNltlRasrsSLpz4re
 D4Xbsg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwkgwbscp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 16:13:16 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f5844cb60so234048885a.0
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 08:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794586396; x=1795191196; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xFrpiDV3xzFHelDb4zO/SPhK0dl7q7vZPbU4BtCMd4Y=;
 b=cBwiAR9l0cSFJvHmCACew8SSR7Qung9xOHFGzgdyad1ecP9DlNB+BBnruGNddoxV5U
 LZzBVCIi8WDclRb25k2J/QzDCN8GPBxx8X6As4ucBKhp0if553tzvlyevc0meGE2qwrt
 LTFB1oBOb9dtncnIQr7ZHOhAB/gwVJPRHrk0WZvxAG57CD1UQcd0sQoCllRZTWNH+Qeg
 Y+bXjyHA0LMdOaBA5fgA+DtFyoLF/rUaCHnkAsywazqBadzAUWRwNvG3hG4uwsa01iks
 x3mRjvwEr7E9FHejWEE2BqdcFST+e7wOHquUufXSEVXBAjmaQQVoEakqpwXz9rUMSXj0
 wiaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794586396; x=1795191196;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xFrpiDV3xzFHelDb4zO/SPhK0dl7q7vZPbU4BtCMd4Y=;
 b=I5QUw7RSz0JBSsswh05SHaBClnmnCN3IK0IlLF7K2+DZUPDtdVULAyzbPwnfd7u5cP
 eUtAOWhUV1mfK7Mlrk2F2b67M1Zt4TXKS+pXRfU+hEDutXTjVAltNOstalm686i6CQXn
 MI5D0ULHjkmGxcpcYtD4c+ap2CkcW3xAY3pcjHJGBz+0bQiTvEILHoD4XJN8zt8DCLkx
 jpmJa6jQiZuRPd9YZMAshpizrSrtPuWmoPBHE9/kdHoRmE8S0IQUN8/RqlbRMkGUmMH0
 UbfkTJcgvubDEusuJ9LkMIsEa/Xrh/ZyD+3vloOMvtG7t0e+qWEX+HolYk4jRCk0unUg
 C/tw==
X-Gm-Message-State: APuU4Z+wYz5OGfpcXCp5TqIMK7SNrwKny1gtDox3aYjCPw1OLQEc4JB+
 NT3tVTAWG8GDDwYJAAj7C/XzqVgPXKksppLSWDRmrM0D83mpPJwN/np09R0Ls2yI2ZUNB3UbQXW
 x+15BfK329rnxaBXO7cRAV0Upikvfr76JIfxD9klThtnu+to7Q56SpTW/i7+h56MweaCi
X-Gm-Gg: AYBFou2jAasZb8HX+aK7FypoUnV2NQEIOEeiNBbN1qYlfguh8I9ZTb7vnPNdRks+jd+
 wP3OvinuIhXR7OIDB4FS75ExsGIhu8ogO3Q3T6rvRmhByT7wOzwtHVaDlqAI9nsY58NeOiUHMXn
 2a14EITFfQpGk6xV/PkVNB0BYkiT9tkLAOfEIAqkbQly5617iCxEb7krX2XmSGMM03oTcrEMT5d
 aKPoRtwBzKnijdXvRUPLsExuQd1aEWhMjwUmyQw6tAi7KN0ZlHUSwe9LuA9f2rzKWqoH9wExeY1
 VSs1+qk88LqwmrneADcSI89WWLFEcj0IZ9p/W9jSvBPCB8Ve6BR26Tpfg6x8FYraf5gOWETA8t+
 VuU1AZpqDCJlPQH0g0Pjgc6BJ/5OZaVzQMDWhTDuZx53MYKUNOQvrcBZB+j0KZo5XM9i1JmqVOj
 Q=
X-Received: by 2002:a05:620a:6cc4:b0:93e:c12d:4ec7 with SMTP id
 af79cd13be357-94933159a63mr1031848585a.39.1794586395512; 
 Fri, 13 Nov 2026 08:13:15 -0800 (PST)
X-Received: by 2002:a05:620a:6cc4:b0:93e:c12d:4ec7 with SMTP id
 af79cd13be357-94933159a63mr1031842785a.39.1794586395023; 
 Fri, 13 Nov 2026 08:13:15 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5d223a29sm6250539f8f.8.2026.11.13.08.13.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Nov 2026 08:13:13 -0800 (PST)
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
Subject: [PATCH 09/19] target/mips: Add the NMS check to the nanoMIPS CACHE
 instruction
Date: Fri, 13 Nov 2026 17:11:47 +0100
Message-ID: <20261113161158.25811-10-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261113161158.25811-1-philmd@oss.qualcomm.com>
References: <20261113161158.25811-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=DNgacCNb c=1 sm=1 tr=0 ts=6af7371c cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=M4u4gXv3FWbnTiq_ZVkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: _tWW0Wg8Kz7-kzL1PFyObQcGKyYCddlj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA2NCBTYWx0ZWRfX4TVlYg954Wp6
 vCSv9QOzjAIN809m1IL9LlvCtqGzafFe+KM3UuIt/fRcE3VuXfcxyxpPFpApjvsB4bjlY0M+pT0
 HgyxfsN5+xPPGvDukkZpX84/fjbVo5WNuM4F4Mj3OYMmBgJ6YTXWqNEBnFovZcN+2LhOkez9Gg4
 UTEcLOVG6gK21gmsIDFri5fzkdS983tKnByYFv09J0FJRaLcIrcZDB/rT9MGuxWJKVPq0f6q8IB
 f1Kxrk8g9nmev6DpHtMs4aQTab5vWidyzhJbXmtKavBFgUX47V7ehYfPThmHoFYVWKuY16BlL/1
 YdamF6VBjIy5diYMt+9ZoBMn2IzO462cjGFE3XuVW8An+sYd5jmGvB23xq//ENE/GYNIInMNDhY
 m/CZ/LO+tsqE50ghqrQgXUKCzzD7SjYa88m53iFs0Cy3izbZIOmWCiRKzFnanWdfcUBgdKBwbJX
 P6+ldpnVfhRBzkkNJTg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA2NCBTYWx0ZWRfX8AU7J1R5aBkh
 6GkqY0vj9FtNnIy2XxgNhOHvjlJerWzqWHLve3ww3LEhTFgzJg/Fm+2Y+/SV4UflMgcuWqejgrQ
 TibZ7SHNyWN3D/SYP30zp1r1R4ANHws=
X-Proofpoint-GUID: _tWW0Wg8Kz7-kzL1PFyObQcGKyYCddlj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130064
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

CACHE and CACHEE share pseudo-code raising Reserved Instruction on
NMS cores without caches, but only CACHEE performed that check.
See MD01247 rev 01.01, "CACHE/CACHEE" (printed page 63).

Fixes: 8f1d9b6d6397 ("target/mips: Add emulation of nanoMIPS 32-bit LD/ST")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/mips/tcg/nanomips_translate.c.inc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/mips/tcg/nanomips_translate.c.inc b/target/mips/tcg/nanomips_translate.c.inc
index c883b5514f1c..20e96f2ad9be 100644
--- a/target/mips/tcg/nanomips_translate.c.inc
+++ b/target/mips/tcg/nanomips_translate.c.inc
@@ -4131,6 +4131,7 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
                     }
                     break;
                 case NM_CACHE:
+                    check_nms_dl_il_sl_tl_l2c(ctx);
                     check_cp0_enabled(ctx);
                     if (ctx->hflags & MIPS_HFLAG_ITC_CACHE) {
                         gen_cache_operation(ctx, rt, rs, s);
-- 
2.55.0


