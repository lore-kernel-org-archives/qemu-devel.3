Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BAE606A31D
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VgfUhxfQ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bKBrKjRD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMTrD-0005ey-Io; Thu, 29 Oct 2026 13:24:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMTrB-0005dQ-Aw
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:24:06 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMTr8-00013U-IA
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:24:05 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69THDjDQ182196
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:24:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 j6BkNP7Y+KCW2d0qDWXRmcx2kUV5UXjV3g/TnP9YUfM=; b=VgfUhxfQUTG1Ncif
 hR+HrfUm1QoMw/Ek4i0JjjAA/vIdSjVoSHXBKOT1hGSq6u4lI7Pzh5jr74c6fiFf
 20xQAwcFDw9MfX5hxvrFoAHyZ8TYNdgeTzTslUidrWsY8yIzzKM/2+wnmBvLnsOf
 YvtjtyzyR6m5KEt/bStzSH042FuUvIfxl4HD7lAoyH7f5YB5VxzIv22h+s9Vj4sW
 6BZe6FAm4tPy7M/t2m+qcnKHhVxA8tFtgxoc/0PomQanZ3mDETeWy6kDyqNx7AD7
 8JW35Wm4xd0xOQ9isqMYQIBzu7yzlIH6+uCGb6j3cuS4JYwxf4uaJTTz3Y+lJl4B
 ZHOUcw==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hmac0r1qn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:24:00 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-98c73709b84so1931759241.0
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 10:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793294640; x=1793899440; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=j6BkNP7Y+KCW2d0qDWXRmcx2kUV5UXjV3g/TnP9YUfM=;
 b=bKBrKjRDndjblaqNcmWwpyq5urX+5UhpzBYSLn3GQ3X/9zylAJ9V3Q7Q232WBX7N0y
 OfSrVOebtiEQwm/CVu3yXanWvCaVEsuj0TEMpvS4/RezTKeG5NwAIQVy+XMNmdAJHdkL
 GRq7dHaTvLsW0F1QhHeSzpQbkJ6ld6P+TkZNcXtZgk5YHoI1X7057pep4Q5eCMmYRpdn
 H8mSJmHyF7bjMze5sRp1LpqKa25E0fC+/FbtKWrmo5AfuSHCrZd4AyAd2BI8Ru3/UFao
 lkjlX8ne504MUeg1LYX9VAXoMmsnpVl4fnOYkY5pZPPoTnmqoMf76DeoDce4fNLOL0jV
 k10Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793294640; x=1793899440;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=j6BkNP7Y+KCW2d0qDWXRmcx2kUV5UXjV3g/TnP9YUfM=;
 b=e0tC0Ipe4Pitj/4/uIOG5YktY3nrcpsZ6d7BL13MMC1KuFp96dyeUzPrjAPlDtIHqq
 PEXtMRY3QwOqgWE5AybdUOLI6eZ59dyjfZ2GebwIY53rzMVq9Z2mqpg8QAQ93FExhqhy
 4rleLrO616y6E59B4zyM1RyWu2RuFjmIECrIm+J3bnaN/YsNxuY2ztlMJWeyyRCZ6TlM
 pkOGKRhWXgBtzHo9ru9esmkdnXLRevp05H9MR9CegWU/zBUf/xn/hOiuJsCCL5GBwZb2
 stsyksdFxNGEqcNy4XwmBeIu1ItpnIQjgZuggyPI3tHpy5/oU8HE0Fwrch95tvN6YbsK
 UOSg==
X-Gm-Message-State: AFq9FYIvaZLFFajcT0ehLVBwNFdh6A73+0nperJdFSxUIF5jq06bRZqz
 p8xIQDZT97cy9t1RWqBR2UPSJMOab17CsglAu8J0E0+W/SsEG+ChxbiZNQ5+jZ6zL+J9hCa3j/k
 wfrkWTFIs4bwrDkSlMuWlAsmr39Doy9h1p9DQrP0WLrIpMhlfJ7HMrJWOJyDqujrN96d3
X-Gm-Gg: AYBFou2/Re7WA8rMNm3ZmxqSC0VXWqtlxCuSO80pA4kw8dNCm+GKhC9Vr6UTfe9gB+k
 wg249qa26PJrSIUjgI/Pl6Q18ueYGurznV5TPX5TXxJoyYHp/CayaX8yDtPH0VUy6PrQJjQ9Oa9
 jC/bRyKp+H093kedvOQwy5QTcGlwB3vpRnXbRaG1wsHIrX1rnE0qZKqp2HUdNVQ19xWYckdumPJ
 GpWVGxdLCOj09TjH4TJUjIBZKSuKRbX4SO5f0h4fAzUjabogFzI3ktYeqP+BXcZv4hs+DUZiImV
 Qcy+Wt/z4FOf3wW4OH4O4inxXaXWzs2qtw0ZoSQnLJoXO6ZPKWP0ikt8YnYNJQAMzkUAx+FiFQX
 oczuyYSxGE5+3XsvYAdWv2SriGu/aWNkFv3WqEAo4RXd1i4Mo9kJgpnH4zi0cu5f6ixcjyr010G
 F0fSmGldMJM3+Fd9S0QjwSzUj+uxuu5Q==
X-Received: by 2002:a05:6102:4b03:b0:7cc:26e4:193e with SMTP id
 ada2fe7eead31-7d03a602e49mr3069403137.29.1793294639261; 
 Thu, 29 Oct 2026 10:23:59 -0700 (PDT)
X-Received: by 2002:a05:6102:4b03:b0:7cc:26e4:193e with SMTP id
 ada2fe7eead31-7d03a602e49mr3069384137.29.1793294638669; 
 Thu, 29 Oct 2026 10:23:58 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e6df87f26sm454334f8f.17.2026.10.29.10.23.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Oct 2026 10:23:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v2 05/31] tests/tcg/mips: Group DSP dot tests
Date: Thu, 29 Oct 2026 18:22:49 +0100
Message-ID: <20261029172319.25766-6-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261029172319.25766-1-philmd@oss.qualcomm.com>
References: <20261029172319.25766-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: xumTYQZjhbZ0K-0E5vQBLnxMI_ynD_XU
X-Proofpoint-GUID: xumTYQZjhbZ0K-0E5vQBLnxMI_ynD_XU
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2OCBTYWx0ZWRfX3rPbD01cWFwo
 te4Gc/1QAA9J7PKNf9nruja3pVkhWBWLLQv8w7cW9K6Vkn2qR0C0w2lulhDLTyUhgCsgqOnuxW8
 jqzHjxOMwfDBGxZhB82ka78RRkwQBRc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2OCBTYWx0ZWRfXyVPJ3P/BnJRb
 t2/MRs156YWJ3dwZOHTzZ2wWdgDj9ZzfUCyiAankT/pDVtToULWJK4bUg6+fPjCeZYkyfMRoKYk
 3akUfkMz70Q0GXOglkmX1RQzc8qPFT3anQEuCRm6aFK0pAKb8vUnB1nSLNmV+K3M5I7Ce/BJ2JZ
 prBQttoL/9/jex4mZp8WNwlpccvHRaDap1o4Ie1ARAm9sliqwdoZO84sX0GsXlxPcrHW7qdhrg+
 1tPgIffKBbPUwH4joTScVL6tVp6oj6shVn+IX6Wn8NOgJgmYmcNzss/o2j82lVXS/PmFMzvvbG6
 Ru2VjnqLoAq7C9rRw+rHCQc91be8hP4+I27KSqfd0XjrEVjObpBQa6auC0b2B6bMYVs1bW19RlL
 EXQ6GYRAEOPjSJ/vn1D8eJugq5/9RoAVfMtXpeSw7GE/wH9pnI5pt4iWGDSiOdtx25AvrtRiGmG
 0djxdJ3tyc6CDXy39CA==
X-Authority-Analysis: v=2.4 cv=I6/w19gg c=1 sm=1 tr=0 ts=6ae38130 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=-Rm5u7GiSCzGvK1VmZsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 phishscore=0 adultscore=0 clxscore=1015
 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290068
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Build the 28 per-opcode dot tests as a single executable,
test_dsp_dot.c, to reduce the number of test binaries.
Each opcode reports one TAP line.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 tests/tcg/mipsel/test_dsp_dot.c              | 157 +++++++++++++++++++
 tests/tcg/mipsel/test_dsp_r1_dpaq_s_w_ph.c   |   1 -
 tests/tcg/mipsel/test_dsp_r1_dpaq_sa_l_w.c   |   1 -
 tests/tcg/mipsel/test_dsp_r1_dpau_h_qbl.c    |   1 -
 tests/tcg/mipsel/test_dsp_r1_dpau_h_qbr.c    |   1 -
 tests/tcg/mipsel/test_dsp_r1_dpsq_s_w_ph.c   |   1 -
 tests/tcg/mipsel/test_dsp_r1_dpsq_sa_l_w.c   |   1 -
 tests/tcg/mipsel/test_dsp_r1_dpsu_h_qbl.c    |   1 -
 tests/tcg/mipsel/test_dsp_r1_dpsu_h_qbr.c    |   1 -
 tests/tcg/mipsel/test_dsp_r1_madd.c          |   1 -
 tests/tcg/mipsel/test_dsp_r1_maddu.c         |   1 -
 tests/tcg/mipsel/test_dsp_r1_maq_s_w_phl.c   |   1 -
 tests/tcg/mipsel/test_dsp_r1_maq_s_w_phr.c   |   1 -
 tests/tcg/mipsel/test_dsp_r1_maq_sa_w_phl.c  |   1 -
 tests/tcg/mipsel/test_dsp_r1_maq_sa_w_phr.c  |   1 -
 tests/tcg/mipsel/test_dsp_r1_msub.c          |   1 -
 tests/tcg/mipsel/test_dsp_r1_msubu.c         |   1 -
 tests/tcg/mipsel/test_dsp_r1_mult.c          |   1 -
 tests/tcg/mipsel/test_dsp_r1_multu.c         |   1 -
 tests/tcg/mipsel/test_dsp_r2_dpa_w_ph.c      |   1 -
 tests/tcg/mipsel/test_dsp_r2_dpaqx_s_w_ph.c  |   1 -
 tests/tcg/mipsel/test_dsp_r2_dpaqx_sa_w_ph.c |   1 -
 tests/tcg/mipsel/test_dsp_r2_dpax_w_ph.c     |   1 -
 tests/tcg/mipsel/test_dsp_r2_dps_w_ph.c      |   1 -
 tests/tcg/mipsel/test_dsp_r2_dpsqx_s_w_ph.c  |   1 -
 tests/tcg/mipsel/test_dsp_r2_dpsqx_sa_w_ph.c |   1 -
 tests/tcg/mipsel/test_dsp_r2_dpsx_w_ph.c     |   1 -
 tests/tcg/mipsel/test_dsp_r2_mulsa_w_ph.c    |   1 -
 tests/tcg/mipsel/test_dsp_r2_mulsaq_s_w_ph.c |   1 -
 tests/tcg/mipsel/meson.build                 |  29 +---
 30 files changed, 158 insertions(+), 56 deletions(-)
 create mode 100644 tests/tcg/mipsel/test_dsp_dot.c

diff --git a/tests/tcg/mipsel/test_dsp_dot.c b/tests/tcg/mipsel/test_dsp_dot.c
new file mode 100644
index 000000000000..97bcb73f4114
--- /dev/null
+++ b/tests/tcg/mipsel/test_dsp_dot.c
@@ -0,0 +1,157 @@
+/*
+ * MIPS DSP ASE tests: Dot Product and Multiply-Accumulate instructions
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "test_dsp_runner.h"
+
+#define main test_dsp_r1_dpaq_s_w_ph
+#include "test_dsp_r1_dpaq_s_w_ph.c"
+#undef main
+
+#define main test_dsp_r1_dpaq_sa_l_w
+#include "test_dsp_r1_dpaq_sa_l_w.c"
+#undef main
+
+#define main test_dsp_r1_dpau_h_qbl
+#include "test_dsp_r1_dpau_h_qbl.c"
+#undef main
+
+#define main test_dsp_r1_dpau_h_qbr
+#include "test_dsp_r1_dpau_h_qbr.c"
+#undef main
+
+#define main test_dsp_r1_dpsq_s_w_ph
+#include "test_dsp_r1_dpsq_s_w_ph.c"
+#undef main
+
+#define main test_dsp_r1_dpsq_sa_l_w
+#include "test_dsp_r1_dpsq_sa_l_w.c"
+#undef main
+
+#define main test_dsp_r1_dpsu_h_qbl
+#include "test_dsp_r1_dpsu_h_qbl.c"
+#undef main
+
+#define main test_dsp_r1_dpsu_h_qbr
+#include "test_dsp_r1_dpsu_h_qbr.c"
+#undef main
+
+#define main test_dsp_r1_maq_s_w_phl
+#include "test_dsp_r1_maq_s_w_phl.c"
+#undef main
+
+#define main test_dsp_r1_maq_s_w_phr
+#include "test_dsp_r1_maq_s_w_phr.c"
+#undef main
+
+#define main test_dsp_r1_maq_sa_w_phl
+#include "test_dsp_r1_maq_sa_w_phl.c"
+#undef main
+
+#define main test_dsp_r1_maq_sa_w_phr
+#include "test_dsp_r1_maq_sa_w_phr.c"
+#undef main
+
+#define main test_dsp_r1_madd
+#include "test_dsp_r1_madd.c"
+#undef main
+
+#define main test_dsp_r1_maddu
+#include "test_dsp_r1_maddu.c"
+#undef main
+
+#define main test_dsp_r1_msub
+#include "test_dsp_r1_msub.c"
+#undef main
+
+#define main test_dsp_r1_msubu
+#include "test_dsp_r1_msubu.c"
+#undef main
+
+#define main test_dsp_r1_mult
+#include "test_dsp_r1_mult.c"
+#undef main
+
+#define main test_dsp_r1_multu
+#include "test_dsp_r1_multu.c"
+#undef main
+
+#define main test_dsp_r2_dpa_w_ph
+#include "test_dsp_r2_dpa_w_ph.c"
+#undef main
+
+#define main test_dsp_r2_dpaqx_s_w_ph
+#include "test_dsp_r2_dpaqx_s_w_ph.c"
+#undef main
+
+#define main test_dsp_r2_dpaqx_sa_w_ph
+#include "test_dsp_r2_dpaqx_sa_w_ph.c"
+#undef main
+
+#define main test_dsp_r2_dpax_w_ph
+#include "test_dsp_r2_dpax_w_ph.c"
+#undef main
+
+#define main test_dsp_r2_dps_w_ph
+#include "test_dsp_r2_dps_w_ph.c"
+#undef main
+
+#define main test_dsp_r2_dpsqx_s_w_ph
+#include "test_dsp_r2_dpsqx_s_w_ph.c"
+#undef main
+
+#define main test_dsp_r2_dpsqx_sa_w_ph
+#include "test_dsp_r2_dpsqx_sa_w_ph.c"
+#undef main
+
+#define main test_dsp_r2_dpsx_w_ph
+#include "test_dsp_r2_dpsx_w_ph.c"
+#undef main
+
+#define main test_dsp_r2_mulsa_w_ph
+#include "test_dsp_r2_mulsa_w_ph.c"
+#undef main
+
+#define main test_dsp_r2_mulsaq_s_w_ph
+#include "test_dsp_r2_mulsaq_s_w_ph.c"
+#undef main
+
+int main(void)
+{
+    int ret = 0;
+
+    RUN_TEST(test_dsp_r1_dpaq_s_w_ph);
+    RUN_TEST(test_dsp_r1_dpaq_sa_l_w);
+    RUN_TEST(test_dsp_r1_dpau_h_qbl);
+    RUN_TEST(test_dsp_r1_dpau_h_qbr);
+    RUN_TEST(test_dsp_r1_dpsq_s_w_ph);
+    RUN_TEST(test_dsp_r1_dpsq_sa_l_w);
+    RUN_TEST(test_dsp_r1_dpsu_h_qbl);
+    RUN_TEST(test_dsp_r1_dpsu_h_qbr);
+    RUN_TEST(test_dsp_r1_maq_s_w_phl);
+    RUN_TEST(test_dsp_r1_maq_s_w_phr);
+    RUN_TEST(test_dsp_r1_maq_sa_w_phl);
+    RUN_TEST(test_dsp_r1_maq_sa_w_phr);
+    RUN_TEST(test_dsp_r1_madd);
+    RUN_TEST(test_dsp_r1_maddu);
+    RUN_TEST(test_dsp_r1_msub);
+    RUN_TEST(test_dsp_r1_msubu);
+    RUN_TEST(test_dsp_r1_mult);
+    RUN_TEST(test_dsp_r1_multu);
+    RUN_TEST(test_dsp_r2_dpa_w_ph);
+    RUN_TEST(test_dsp_r2_dpaqx_s_w_ph);
+    RUN_TEST(test_dsp_r2_dpaqx_sa_w_ph);
+    RUN_TEST(test_dsp_r2_dpax_w_ph);
+    RUN_TEST(test_dsp_r2_dps_w_ph);
+    RUN_TEST(test_dsp_r2_dpsqx_s_w_ph);
+    RUN_TEST(test_dsp_r2_dpsqx_sa_w_ph);
+    RUN_TEST(test_dsp_r2_dpsx_w_ph);
+    RUN_TEST(test_dsp_r2_mulsa_w_ph);
+    RUN_TEST(test_dsp_r2_mulsaq_s_w_ph);
+
+    DSP_TAP_PLAN();
+
+    return ret;
+}
diff --git a/tests/tcg/mipsel/test_dsp_r1_dpaq_s_w_ph.c b/tests/tcg/mipsel/test_dsp_r1_dpaq_s_w_ph.c
index a6425b6edc84..3818ba7c2a48 100644
--- a/tests/tcg/mipsel/test_dsp_r1_dpaq_s_w_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r1_dpaq_s_w_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_dpaq_sa_l_w.c b/tests/tcg/mipsel/test_dsp_r1_dpaq_sa_l_w.c
index cbf900713f33..56a3c2f6e1d1 100644
--- a/tests/tcg/mipsel/test_dsp_r1_dpaq_sa_l_w.c
+++ b/tests/tcg/mipsel/test_dsp_r1_dpaq_sa_l_w.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_dpau_h_qbl.c b/tests/tcg/mipsel/test_dsp_r1_dpau_h_qbl.c
index 6017b5e73ab2..b90a9e9e72cc 100644
--- a/tests/tcg/mipsel/test_dsp_r1_dpau_h_qbl.c
+++ b/tests/tcg/mipsel/test_dsp_r1_dpau_h_qbl.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_dpau_h_qbr.c b/tests/tcg/mipsel/test_dsp_r1_dpau_h_qbr.c
index e4abb2e2af03..7828182f3151 100644
--- a/tests/tcg/mipsel/test_dsp_r1_dpau_h_qbr.c
+++ b/tests/tcg/mipsel/test_dsp_r1_dpau_h_qbr.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_dpsq_s_w_ph.c b/tests/tcg/mipsel/test_dsp_r1_dpsq_s_w_ph.c
index 74058fe7ecd0..14698262d589 100644
--- a/tests/tcg/mipsel/test_dsp_r1_dpsq_s_w_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r1_dpsq_s_w_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_dpsq_sa_l_w.c b/tests/tcg/mipsel/test_dsp_r1_dpsq_sa_l_w.c
index eda3b14e2be2..900f3f90bcb8 100644
--- a/tests/tcg/mipsel/test_dsp_r1_dpsq_sa_l_w.c
+++ b/tests/tcg/mipsel/test_dsp_r1_dpsq_sa_l_w.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_dpsu_h_qbl.c b/tests/tcg/mipsel/test_dsp_r1_dpsu_h_qbl.c
index 94e2bf625499..6958bbeb753b 100644
--- a/tests/tcg/mipsel/test_dsp_r1_dpsu_h_qbl.c
+++ b/tests/tcg/mipsel/test_dsp_r1_dpsu_h_qbl.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_dpsu_h_qbr.c b/tests/tcg/mipsel/test_dsp_r1_dpsu_h_qbr.c
index a1e66356310d..f127d1662714 100644
--- a/tests/tcg/mipsel/test_dsp_r1_dpsu_h_qbr.c
+++ b/tests/tcg/mipsel/test_dsp_r1_dpsu_h_qbr.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_madd.c b/tests/tcg/mipsel/test_dsp_r1_madd.c
index af4bfcfe9df3..f724fd9a27c0 100644
--- a/tests/tcg/mipsel/test_dsp_r1_madd.c
+++ b/tests/tcg/mipsel/test_dsp_r1_madd.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_maddu.c b/tests/tcg/mipsel/test_dsp_r1_maddu.c
index af4bfcfe9df3..f724fd9a27c0 100644
--- a/tests/tcg/mipsel/test_dsp_r1_maddu.c
+++ b/tests/tcg/mipsel/test_dsp_r1_maddu.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_maq_s_w_phl.c b/tests/tcg/mipsel/test_dsp_r1_maq_s_w_phl.c
index 0f7c070155a8..aa29fd5e3821 100644
--- a/tests/tcg/mipsel/test_dsp_r1_maq_s_w_phl.c
+++ b/tests/tcg/mipsel/test_dsp_r1_maq_s_w_phl.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_maq_s_w_phr.c b/tests/tcg/mipsel/test_dsp_r1_maq_s_w_phr.c
index 942722a530c2..42833686936c 100644
--- a/tests/tcg/mipsel/test_dsp_r1_maq_s_w_phr.c
+++ b/tests/tcg/mipsel/test_dsp_r1_maq_s_w_phr.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_maq_sa_w_phl.c b/tests/tcg/mipsel/test_dsp_r1_maq_sa_w_phl.c
index d83dce6f3272..9dda4ebdbbe9 100644
--- a/tests/tcg/mipsel/test_dsp_r1_maq_sa_w_phl.c
+++ b/tests/tcg/mipsel/test_dsp_r1_maq_sa_w_phl.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_maq_sa_w_phr.c b/tests/tcg/mipsel/test_dsp_r1_maq_sa_w_phr.c
index d2331118abb8..1b34664280dc 100644
--- a/tests/tcg/mipsel/test_dsp_r1_maq_sa_w_phr.c
+++ b/tests/tcg/mipsel/test_dsp_r1_maq_sa_w_phr.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_msub.c b/tests/tcg/mipsel/test_dsp_r1_msub.c
index 5779e6f47ac7..74146284ffe2 100644
--- a/tests/tcg/mipsel/test_dsp_r1_msub.c
+++ b/tests/tcg/mipsel/test_dsp_r1_msub.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_msubu.c b/tests/tcg/mipsel/test_dsp_r1_msubu.c
index e0f9b5a77ae3..2eb728af64b4 100644
--- a/tests/tcg/mipsel/test_dsp_r1_msubu.c
+++ b/tests/tcg/mipsel/test_dsp_r1_msubu.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_mult.c b/tests/tcg/mipsel/test_dsp_r1_mult.c
index 15e6fde92c0e..c0509396de72 100644
--- a/tests/tcg/mipsel/test_dsp_r1_mult.c
+++ b/tests/tcg/mipsel/test_dsp_r1_mult.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_multu.c b/tests/tcg/mipsel/test_dsp_r1_multu.c
index 85d36c1b621a..1c8a7f1e01e7 100644
--- a/tests/tcg/mipsel/test_dsp_r1_multu.c
+++ b/tests/tcg/mipsel/test_dsp_r1_multu.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_dpa_w_ph.c b/tests/tcg/mipsel/test_dsp_r2_dpa_w_ph.c
index fae49f10eb95..68eae5a08346 100644
--- a/tests/tcg/mipsel/test_dsp_r2_dpa_w_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r2_dpa_w_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_dpaqx_s_w_ph.c b/tests/tcg/mipsel/test_dsp_r2_dpaqx_s_w_ph.c
index ce8783024685..06b1a0a0d7e8 100644
--- a/tests/tcg/mipsel/test_dsp_r2_dpaqx_s_w_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r2_dpaqx_s_w_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_dpaqx_sa_w_ph.c b/tests/tcg/mipsel/test_dsp_r2_dpaqx_sa_w_ph.c
index d551d64ae293..6dd106d74cae 100644
--- a/tests/tcg/mipsel/test_dsp_r2_dpaqx_sa_w_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r2_dpaqx_sa_w_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_dpax_w_ph.c b/tests/tcg/mipsel/test_dsp_r2_dpax_w_ph.c
index 514797cfd1b4..a812c8a7f854 100644
--- a/tests/tcg/mipsel/test_dsp_r2_dpax_w_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r2_dpax_w_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_dps_w_ph.c b/tests/tcg/mipsel/test_dsp_r2_dps_w_ph.c
index f51f9b9d13d7..a656d219d89f 100644
--- a/tests/tcg/mipsel/test_dsp_r2_dps_w_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r2_dps_w_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_dpsqx_s_w_ph.c b/tests/tcg/mipsel/test_dsp_r2_dpsqx_s_w_ph.c
index e40543fd8292..960f2bbbdf36 100644
--- a/tests/tcg/mipsel/test_dsp_r2_dpsqx_s_w_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r2_dpsqx_s_w_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_dpsqx_sa_w_ph.c b/tests/tcg/mipsel/test_dsp_r2_dpsqx_sa_w_ph.c
index 7da278eacc0e..68f20348c2c9 100644
--- a/tests/tcg/mipsel/test_dsp_r2_dpsqx_sa_w_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r2_dpsqx_sa_w_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_dpsx_w_ph.c b/tests/tcg/mipsel/test_dsp_r2_dpsx_w_ph.c
index bb49a4031d34..d85b504b402e 100644
--- a/tests/tcg/mipsel/test_dsp_r2_dpsx_w_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r2_dpsx_w_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_mulsa_w_ph.c b/tests/tcg/mipsel/test_dsp_r2_mulsa_w_ph.c
index a6940939ca50..842233b2785b 100644
--- a/tests/tcg/mipsel/test_dsp_r2_mulsa_w_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r2_mulsa_w_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_mulsaq_s_w_ph.c b/tests/tcg/mipsel/test_dsp_r2_mulsaq_s_w_ph.c
index 06c91a43e7ea..c0f8e51ad389 100644
--- a/tests/tcg/mipsel/test_dsp_r2_mulsaq_s_w_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r2_mulsaq_s_w_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/meson.build b/tests/tcg/mipsel/meson.build
index 1c2851f56369..c26f5fba06b7 100644
--- a/tests/tcg/mipsel/meson.build
+++ b/tests/tcg/mipsel/meson.build
@@ -8,31 +8,14 @@ tests_dsp = [
   'test_dsp_arith.c',
   'test_dsp_cmp.c',
   'test_dsp_ctrl.c',
+  'test_dsp_dot.c',
   'test_dsp_r1_bitrev.c',
-  'test_dsp_r1_dpaq_s_w_ph.c',
-  'test_dsp_r1_dpaq_sa_l_w.c',
-  'test_dsp_r1_dpau_h_qbl.c',
-  'test_dsp_r1_dpau_h_qbr.c',
-  'test_dsp_r1_dpsq_s_w_ph.c',
-  'test_dsp_r1_dpsq_sa_l_w.c',
-  'test_dsp_r1_dpsu_h_qbl.c',
-  'test_dsp_r1_dpsu_h_qbr.c',
   'test_dsp_r1_insv.c',
-  'test_dsp_r1_madd.c',
-  'test_dsp_r1_maddu.c',
-  'test_dsp_r1_maq_s_w_phl.c',
-  'test_dsp_r1_maq_s_w_phr.c',
-  'test_dsp_r1_maq_sa_w_phl.c',
-  'test_dsp_r1_maq_sa_w_phr.c',
-  'test_dsp_r1_msub.c',
-  'test_dsp_r1_msubu.c',
   'test_dsp_r1_muleq_s_w_phl.c',
   'test_dsp_r1_muleq_s_w_phr.c',
   'test_dsp_r1_muleu_s_ph_qbl.c',
   'test_dsp_r1_muleu_s_ph_qbr.c',
   'test_dsp_r1_mulq_rs_ph.c',
-  'test_dsp_r1_mult.c',
-  'test_dsp_r1_multu.c',
   'test_dsp_r1_packrl_ph.c',
   'test_dsp_r1_preceq_w_phl.c',
   'test_dsp_r1_preceq_w_phr.c',
@@ -70,21 +53,11 @@ tests_dsp = [
   'test_dsp_r1_shrlv_qb.c',
   'test_dsp_r2_append.c',
   'test_dsp_r2_balign.c',
-  'test_dsp_r2_dpa_w_ph.c',
-  'test_dsp_r2_dpaqx_s_w_ph.c',
-  'test_dsp_r2_dpaqx_sa_w_ph.c',
-  'test_dsp_r2_dpax_w_ph.c',
-  'test_dsp_r2_dps_w_ph.c',
-  'test_dsp_r2_dpsqx_s_w_ph.c',
-  'test_dsp_r2_dpsqx_sa_w_ph.c',
-  'test_dsp_r2_dpsx_w_ph.c',
   'test_dsp_r2_mul_ph.c',
   'test_dsp_r2_mul_s_ph.c',
   'test_dsp_r2_mulq_rs_w.c',
   'test_dsp_r2_mulq_s_ph.c',
   'test_dsp_r2_mulq_s_w.c',
-  'test_dsp_r2_mulsa_w_ph.c',
-  'test_dsp_r2_mulsaq_s_w_ph.c',
   'test_dsp_r2_precr_qb_ph.c',
   'test_dsp_r2_precr_sra_ph_w.c',
   'test_dsp_r2_precr_sra_r_ph_w.c',
-- 
2.55.0


