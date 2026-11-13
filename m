Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4936606A335
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 16:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=d5DOU+va;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VLK0Iku2
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRtvO-0003mk-QL; Fri, 13 Nov 2026 11:14:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xRtuP-0002xx-Sn
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 11:13:53 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xRtuO-0000Ks-Br
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 11:13:49 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ADFRDuW1076437
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 16:13:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wkhH0r0uSN88vjf9iluIGaGWyt4bF4TrC9geOZzupeQ=; b=d5DOU+vaRLm8Fgtl
 G6EXmK/34mpvOu75AW+ws3qcAGnx3O/TV44iSUjG06dNTKG2ygVhzGCLjFvERpC6
 rE7du65IEMNVBg+6L+Py5OiSjx3u9Be5JVKkrNBdn4u59kJ3OJXgyr9lKJsMIbZp
 vkubBhLmZFHTI2tlWCTM8THF+jr4vnAossZnXkj9D1ZHRGtuVmHpwEvA2OqHPi1x
 OEg9e44La5K93EelklWudKIuLvNbZ1BnmXfEXrOZH7hNcc662rj/uWQxdVroM1Ew
 Q8aBjMZXVb9Kqgu0Fq8w6uUULKcnlJ1h3oKwP26BJfZLBx9+fU9tJGbZouApsOHZ
 95fOFA==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwh0amhta-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 16:13:45 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-99076c676cbso198208241.3
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 08:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794586425; x=1795191225; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wkhH0r0uSN88vjf9iluIGaGWyt4bF4TrC9geOZzupeQ=;
 b=VLK0Iku2ZUOggeRLqY5eP4h1WLIcGBk/nFv6uoUmSOQbHbFQ6WYgCWUvdkFC2BVgcm
 8qCrB9M2jZvrvuw26sE8lroK1Wo83HxshPk/ZF4MC8PwYTqgtayjdevOn5x36YcnlUW9
 igx71CP62Hhdbo3Cprf8e3cdfrbMKOQavmZjjqVyTuofLWnn1bRm1KYv9I1yeEDYN3iz
 HexsWeyg9BkSgLj1/znJ6hRj1QDpxeYycQoVq6lYPkqmj9qMLtenu9v2DMh/cd9WA0fi
 C/6BtxCS+ltl5+93rQ0bbDMPbUonJUmv50MBtEahFXaSxBxmZnbaoy/3Jdm6fvqJA5ls
 hxJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794586425; x=1795191225;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wkhH0r0uSN88vjf9iluIGaGWyt4bF4TrC9geOZzupeQ=;
 b=HwWO7LcCtcnAtUl0cq125XIS5dfu5bt3UdXSupLPqfw5Z3aFTi41nYmSgF0SFhRtz4
 V/VHciDMZWDx+X2AfWhdORmYvByFHBBy9nnRMbUaiPwTbX6bL5ucECz9INGc2searz7b
 T9NScMHB36SPsjbH67BuumxxuoVjWY4PkkOP+yAKjFXvlMQlV73SSIyWKnjRU1gStcW9
 Jji3ZwKJCFIMEBGl0kKmtgofdD2tal9ldPM9pc/gpLzuWR5CPQ231pAO1dS5A07jCr4d
 GbgPPDoMwS03VIQejwlwXqKAMuZv2xJROdpZdNtfFs178EFP5ZvhH0t/NMkQmcpBGJ3T
 eIGQ==
X-Gm-Message-State: APuU4Z+3+J+Z6O6bI1JAHe5LYkJKUmP+6rArgLZSIDayPDeyLanEmBDf
 c1ZeEMahl8FvLqKpYS87Fq8tp0tBMsnPa06cJD67Wqn+RHiLPfQJg4AxwrnSnf6quhklCUud+9+
 6z35LRyusuYfJRd17faUfiF/b5FGoGdGil1ynCbBDqepd9in2q4q9whrGYWuzLQqTBk9y
X-Gm-Gg: AYBFou1lzKJ49dWjsJxBxP7iqmWSPUZRjrT8Q19ZsoGPZbd20o6l6frHmSOvIGcwLSy
 shnwol4iINAgqv4ldzYUhKGfx6ck4je56lieLpswVdIKj7IhN7oOk98U9yuORhgLY01zgmh0vHK
 AZjXlXXSa7HCBQuoOEEy8sJgF4GoyofY5FWMmT2uRBqgFDG/JZYYTsv0YiFANcuSixdLQ/5P7Mf
 +HH2GoKHSHALUCALlJmhMBnikj9s4bgPiwTTR4bdxfEF7G/wr1Ydm1KrlgNGDJKIZfnh4FwZBTz
 F3uemkQZxSFWDW9n0vfHmrISdkjZe/8qq9LeSEA9lqUvAAhNX/B3HALzBjelXvDv8+75LgYEZa0
 cVeyYBKtK9wNwLUu5aA/aqB1pz6PCGBF0HUSs1jKTwa/N08F/qicK9fEiNgk11QXPzHMYXb/yn1
 PhXk6AVN8YZfK4JA==
X-Received: by 2002:a05:6102:6050:b0:7b2:7490:fd75 with SMTP id
 ada2fe7eead31-7d64d6d2d9amr765383137.7.1794586424958; 
 Fri, 13 Nov 2026 08:13:44 -0800 (PST)
X-Received: by 2002:a05:6102:6050:b0:7b2:7490:fd75 with SMTP id
 ada2fe7eead31-7d64d6d2d9amr765374137.7.1794586424495; 
 Fri, 13 Nov 2026 08:13:44 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb55acdfebsm65923075e9.7.2026.11.13.08.13.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Nov 2026 08:13:43 -0800 (PST)
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
Subject: [PATCH 13/19] target/mips: Fix nanoMIPS BEQC16/BNEC16 corner cases
Date: Fri, 13 Nov 2026 17:11:51 +0100
Message-ID: <20261113161158.25811-14-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261113161158.25811-1-philmd@oss.qualcomm.com>
References: <20261113161158.25811-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA2NCBTYWx0ZWRfXyC2dLrAstqVU
 h4q55lN09Aclz0HAqDyOBB6jCy/pcCIYTrIYK3Urq0PoHZwokd2MNxAhcx+Nz/E+O0fJ7KROkqQ
 F5km8yKnlnAMJR1H0g5HwdPew3N+0z8=
X-Proofpoint-GUID: gunEuu2otiitc2aI0rAdttT3Uj6hnGVr
X-Authority-Analysis: v=2.4 cv=N+e8hG9B c=1 sm=1 tr=0 ts=6af73739 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=M4u4gXv3FWbnTiq_ZVkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA2NCBTYWx0ZWRfX1/5L5Ds1ygzS
 ildJqHuxo4uwJuW2TT+kUAmFpeNdwPgi18xd/6Igeyz4YaDCu3d9UeBKQekl2b1L5XgFV1be13a
 1p/qnbIjA3tUFTUUp/5Esb5nQSF9ViJpWH54BLO8fF51G9jyGJzA2Jk36rsforBDkeg4DCO4PP3
 cvQK2brP+CF7iO8pZMqxbVqKsJJ19MoHq4SsWAKPj2e8pCAtxep8zlunpmCrnXjtL1ffCZXRWFA
 5KSKTj5NBia9ROape0Yla9aFvrhyaK90isUQ/qk8Zr7roJAdJZKamv//pg9YdfjoJ6t50gQ/XHf
 CIUpMMCMTPuSuMzTHWXEV+WjLVk8tE07CfX1lPhRtibkpBZoIysA+tmYkawhaAMoWkNjiA+3iw8
 t3gmKD6c++dPilLKx0vkxid7zF73qHzRotldziU4yxaEVLaezWkZeLyv83rgoZ9bRqXghW1c0Tu
 bJb6NCnDuMn58qI46hA==
X-Proofpoint-ORIG-GUID: gunEuu2otiitc2aI0rAdttT3Uj6hnGVr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 malwarescore=0 bulkscore=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 spamscore=0
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

BNEC[16] with identical registers is never taken, so it is a NOP.
gen_compute_branch_nm() instead wrote $ra and skipped the next
4 bytes as if it were a MIPS branch-and-link-likely.

Also raise Reserved Instruction on NMS cores, where the 16-bit
forms are not available.

Fixes: 764371d24c51 ("target/mips: Add emulation of nanoMIPS 16-bit branch")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/mips/tcg/nanomips_translate.c.inc | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/mips/tcg/nanomips_translate.c.inc b/target/mips/tcg/nanomips_translate.c.inc
index f9dc573dbb01..25d57e75a0b0 100644
--- a/target/mips/tcg/nanomips_translate.c.inc
+++ b/target/mips/tcg/nanomips_translate.c.inc
@@ -4756,6 +4756,10 @@ static int decode_isa_nanomips(CPUMIPSState *env, DisasContext *ctx)
                 /* P16.BRI */
                 uint32_t opc = extract32(ctx->opcode, 4, 3) <
                                extract32(ctx->opcode, 7, 3) ? OPC_BEQ : OPC_BNE;
+                check_nms(ctx);
+                if (rs == rt) {
+                    break;
+                }
                 gen_compute_branch_nm(ctx, opc, 2, rs, rt,
                                       extract32(ctx->opcode, 0, 4) << 1);
             }
-- 
2.55.0


