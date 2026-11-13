Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D26606A880
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 16:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SlRWewcE;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QaIhWMyg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRttX-00015E-3I; Fri, 13 Nov 2026 11:12:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xRttV-00014l-5Z
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 11:12:53 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xRttT-00080d-9I
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 11:12:52 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ADFRbOY2638617
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 16:12:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6m0LMLgKU1XA19/hl/4URz11ZcDlNF58kf2fncD3waM=; b=SlRWewcEvZ9ZZetk
 Hjsia/yf2CAzjqKV+Sm48Uiya3wQRCHxdlpuPv65Yi2QLh+KNCmfpqek2itP23Uo
 NQHgds53mdWVMrAhr4hhEhu8k9HSYVEHQ8CVxZWln9m+pcJvulmfFouiqWEGQQKQ
 EBw03RxCaF1xEMgh9X47vQn1l82YuhmGNkhwoKfHY4hVAuEX7Y/Pbzh215MOQvJ3
 /lgxG02fwgn7r41xoA6sBAUMj2sI5NfSBx306qSrHnGLYCq4tB13tGoVQxDDLpHI
 sQJ7dQcVe2pj7fR0Mn7FOfWMoNVnJ64Np89hZVNn25J/CqmXGWvGa7NGGEL9h3Vc
 v/r8CQ==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hww5ra0mr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 16:12:50 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-998de183a74so252887241.2
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 08:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794586369; x=1795191169; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6m0LMLgKU1XA19/hl/4URz11ZcDlNF58kf2fncD3waM=;
 b=QaIhWMyg/ljNVFsXC2sgzCfYToItBtzgHfLRCLi7hyRxTM/cNS7TnyWnov5ddgzc0h
 BuV+qSV9PZcjS9Ht3T3vxsiMzNLLXRL2tV3bcs9e4Fg+eVq+s62oNKZA/eVunMCXE9Zy
 YsCGw+CikhG9NaqJZ3xuBYVnkpPKkzX/fENXS20C8krNBgfszBsZmiXiXqzQ6rdUxL8i
 rnWAc9ASdYA8mTCRC7hVLcRLGZlIXdU9QGIGchqQDT8N02+aTyQDRC6EYoz6uPti6sps
 uiCzqQhtn+N1W17Ky6Ewtn3vpRU+BI02E0Irfh3X0WTmZF4KB4q6AV9O7G/GBHQQWB0s
 HctQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794586369; x=1795191169;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6m0LMLgKU1XA19/hl/4URz11ZcDlNF58kf2fncD3waM=;
 b=nT8SjzVzgupHzGdo1SULkwN1UYShuRgbD5tsP6gZoTIhH3kINYMuMTOGu05MinyfQj
 xTVixhYN1gXjTJNM0itD+dQxjoLt6F8lK2u0j6Vt03j9BYu+Bx4oCME8ghTUgZyn1EfX
 xWlVXactLbG4zA0+yHfAKuHVlnK9+p9uIuzXcEbiZoQNHr2wCOnRiv4hyPuD5Cs38NW6
 HPasOztlT+39Yyy2AeL2GbFd9trz/x5m9T1J49yMJi68/7ECVYjTJy8pwvnzymt7UywV
 0A1NrMmREKYtkC+Vvt2W3iIF80cnl0ZlBDgcAK5DHu6dh80O8WFAhifL8X4efTtfpnJ9
 T6Bw==
X-Gm-Message-State: APuU4Z/GboZcwc2jT2dWRT+MwUFjbaOvaScBT9GzqjUJU6gKZmBFmBLO
 PJ9hVsrF4wK14D33wlKyLbVINCPxSiMkZXSMnKxQRPgQbnyNN3+4JVghG+dg/vOU7Mls232BQCw
 cDxSh7heIshsGJNLppzpGauvD86NpWJLdoJJ6jUdGhEUZua9oIGc2p6tlGwBog1HjMu2G
X-Gm-Gg: AYBFou3RKqAWdjTD5z3neFbJieUuuf4RLgmxtGF/wC2IkAlrB4cE8sZdCKzdL3VaDCI
 +ztToUrn/Cu9mUbX/3s7Z+NVK7mZ6tJnssVjEvCVuwVAxBC5yY0YuCNpQUNKjXwE7y5i9jzHaBQ
 AnzznysyseZvwO0wsJkiBN0ziNXDRaIOaTWv+sz4K8Al4x0F7i63YPFXg3x7piU0Vf+RV1woAOV
 UkV0nNkrIrdq78HUzhOOv30Q297OLIxTX9zN2JnGhWslNCD+5wt/6vXToL5dyzMmEyQelQDtQWy
 GftUlGVrcGYZw9I0BFEL30SfR84hsYa/Hfu6OiZW8HnuWibIbEEpa56/1zQHD4vvLWK9/nS+EDl
 kzpGhvCKB2oKHgUXkiW7OULkD3X7+H114hrMtv+Lx+gLbblZNCvibFIT5u2WJ3lnJbML6/9iF+3
 5+YsD+xthvuRObaA==
X-Received: by 2002:a05:6102:a50:b0:7cc:2712:cafb with SMTP id
 ada2fe7eead31-7d64d769e6emr897716137.15.1794586369201; 
 Fri, 13 Nov 2026 08:12:49 -0800 (PST)
X-Received: by 2002:a05:6102:a50:b0:7cc:2712:cafb with SMTP id
 ada2fe7eead31-7d64d769e6emr897706137.15.1794586368669; 
 Fri, 13 Nov 2026 08:12:48 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb571f976esm32164375e9.3.2026.11.13.08.12.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Nov 2026 08:12:47 -0800 (PST)
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
Subject: [PATCH 06/19] target/mips: Fix reset into microMIPS mode when
 Config3.ISA is 3
Date: Fri, 13 Nov 2026 17:11:44 +0100
Message-ID: <20261113161158.25811-7-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261113161158.25811-1-philmd@oss.qualcomm.com>
References: <20261113161158.25811-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA2NCBTYWx0ZWRfX5mG3uc1aSd/w
 HNMlwGYdOff8g9nkbErK1Ns0sCsqxv39vjATaEjF3ATgzgaiLffEHGNvhbxioLqkzz/zm5kGFUr
 nMrMeGyJCwTvUMDKdh45thgCCinIgsIW7MWmZBRCmNqSd5WMHynlk0pMArGdmp3jhHUO+sBqPUt
 Fzn+3l7RR4MheNOcp6Zv6tR8hAl8w1einlDOfcX7hIM22wnFlDU+sHNu9thP3C1hNbNCG5DwGLM
 +4UYUXb3dszVho4MPUE1i2gDQcdf6P2/n+vn12AzxE5gIECRIFeoH3PGBsfqkXTeMBvSyrZVehm
 CNplsaZmuMdESy8K631LoA/k1yInAymRYDMIgrJUf3vob3Pk3KeX0Gr+GwElE0UjpYKjIvgfijB
 XMvswAOhTpH3upArjBrLR4iNCq2IGzEvqYskhUVw71kTvLdD0dK2TxdBUMcDgNJnWNcMvpGD56e
 9H1eSGQNNObBz5qUykQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA2NCBTYWx0ZWRfX5DAlufhlSeUL
 +aZ8Ddjyg/VATm4belh2nMrAdfqgePpPNbKzJ4BgFOjUTRiq73up4vJ7GOQ323Siu+Sydjrl+2C
 0wsudIbQ8+JfgJQmjmL1F2GcIYd8xls=
X-Proofpoint-ORIG-GUID: AwjWRIrMxEVbcLBAywdYWjP16U_hBQrC
X-Authority-Analysis: v=2.4 cv=Vqq2kO2n c=1 sm=1 tr=0 ts=6af73702 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=OzHiCVVnrDrB4rO0jAQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-GUID: AwjWRIrMxEVbcLBAywdYWjP16U_hBQrC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 impostorscore=0 phishscore=0 malwarescore=0
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

The Config3.ISA == 3 test ANDs bit 14 and bit 15 as two separate
constants, so it is always false and no CPU resets into microMIPS
mode.  Test the 2-bit field instead.

Config3.ISA == 3: both MIPS32 and microMIPS32 are implemented, with
microMIPS32 used out of reset (MD00090 rev 6.02, Table 9.67, p. 248).

Fixes: 0bbc0396809f ("target/mips: Prevent switching mode Config3 ISA bit nanoMIPS")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/mips/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 8ad5e49ade41..324e5989cca1 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -459,7 +459,7 @@ static void mips_cpu_reset_hold(Object *obj, ResetType type)
         env->CP0_PWField = 0x02;
     }
 
-    if (env->CP0_Config3 & (1 << CP0C3_ISA) & (1 << (CP0C3_ISA + 1))) {
+    if (extract32(env->CP0_Config3, CP0C3_ISA, 2) == 3) {
         /*  microMIPS on reset when Config3.ISA is 3 */
         env->hflags |= MIPS_HFLAG_M16;
     }
-- 
2.55.0


