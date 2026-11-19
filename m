Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF694606A320
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 23:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ebgUQkfR;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=B2WxYT7O
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUB95-0003VE-7N; Thu, 19 Nov 2026 18:02:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xUB93-0003Um-N5
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 18:02:21 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xUB91-0001AP-Hs
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 18:02:21 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJJUcBD3367594
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 23:02:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RtsI/XIT+6rH2gx7TOK1YxLGOMRr//idZuN+pb4yhUg=; b=ebgUQkfR79djZsP5
 Ca36sryLCfRgYCm6eKjfnLvUbLGvUrAeicPTBKm+iGEP1DI7Hj4M172IHNLvejzY
 DuULFls+2FsvCQ+f+6OzCh7DgIZlzhbZAjx7gLt0TPyZRTfv3zhVxRufvUbk/Fcx
 HipJAziiSMyDWJxM+To3xinm6en3D9eGmR5XcFU6F2/4ruk9PH17J/YGz4oySz8R
 ytGOlqAoEVKaOD+mk5KogJxH9yny2WLdbnPw9jgnt5E5zJfJYgOOeyNFADML9O2o
 eCmWUR/wDzSLws0eHXp36/T4UZuxjJeUH/9XtsVJsHus8XlOqcPDygPse6r5rfs2
 MDdZ9g==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j27b5ruh3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 23:02:17 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-5eacc615f73so210620e0c.1
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 15:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795129337; x=1795734137; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RtsI/XIT+6rH2gx7TOK1YxLGOMRr//idZuN+pb4yhUg=;
 b=B2WxYT7O7BnZ8IyyrfJiRPa4U3vOKkrgYj6RpLmUvbfGFHSWk2v8sBjPn8W7dkkggl
 +81fn+9Rwi+npfBBvPAmXir9y7XzYh3MvWpub8yt0KIHYQ4/vPcciYymaTI9RtNiLWvb
 uNOemER8MNP/WBWttPJsPc2NlSGANgG6SqC4iIIRYlJyG2cZ8eGiU20wVOtVQeWjpFVC
 PA7vNwCQkWoO57xmBKAMGUU2USHqKiblxVTNo2cvAe52Zm6MOEXGTELGyyik7Wykomtu
 2/7hFofZ8T/EZiewNGJjm1shHMFv56YtRMb+Ri8OWTubKS4UM1wtloL3ZLH/tq6acawH
 dBXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795129337; x=1795734137;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RtsI/XIT+6rH2gx7TOK1YxLGOMRr//idZuN+pb4yhUg=;
 b=Wg6trHGMCylYoFNUO/jxz8Hh71zQzNzx0IDolidlOpv2d16ZrNbY0vkFCbQKmYlBVw
 tgS2Ls3SeMuCH1ySnOBhMA3VoIDlrQyIDrkRn6FsXAfUVgZP8nCzz3M+KjHKkChPO+ti
 7bTh/A4j/6HNpQ+5+c0C2xQHOPnIBGy6oT+g48Qhvo5AIshjV1+sMUIeSKVDBOHkeuzf
 Ee4elf59yA9Avw5Z9/e+/1jfBzqhK+VvQqBDx23Zw+7WR2qitWLxZDXyjSl4n031u0JH
 yyhMfrhn6Xa3df2jjreJVyiIRLJFCgpqACPbvQ47Te2zAWkzZvQzZbz5Sx3tjWy/6lbG
 TSjw==
X-Gm-Message-State: APuU4Z8VONI+hO+lcU9TRk0XkZ/ivsM17sV0N8qvHCm35VMhNLLVgXlT
 OIOyQAJngMaBcnsEjpFg9jLVWrtNPQEf89Zv2n1zTUeF51xNhezlr2No/2CQD0NBoKsk+A0OHwv
 TwBKUysHycgREYNGeD8WsWU5ROZJHwq5emsWXPayoAFRkUxTySqEEaUFx+WnnasB1uK0m
X-Gm-Gg: AYBFou20OFsPrtwwfDaN5IzfEaYr4QzoMHeTya8vIBvAEvvKRzK63Inb/q23pFJtIs+
 N40GCxJiXEboK9cyVxdzWiLTi5bvfFFigvyvIUdLTjuRRQWFu2XssFdOZSMLlhtWpd8mRGhcyPF
 0tZhz2YnOenaqFPLbnjvQvL/cLFVlk/9CWNCMAWpQ1WE7tZzXCjkgIbtPPFTSursXlNZmmPvES8
 08mDuDQ7Q6Zki5vKVUCLEOkBxQZBhTlXHn9E3bEoYcYJxNFF241TbtvDayHY9Lbw20rhUY+pSGw
 FAzJlcxTasiNiXHeQNlZPno+hzswFrjBoD8RY8sWTuZlOFdDoZ786A59quX3NqI1hWVjrHwwcq1
 tSLeZYIJdtqvjwS62NG/y8MGml9ab5WCL6OGEy4M6JQBf6+EF5mV+AIsDLNzQO4ryhQnTlVhu/P
 djZV3T9melWwuD0Q==
X-Received: by 2002:a05:6123:110:b0:5ea:c3bc:c567 with SMTP id
 71dfb90a1353d-5ee8aefbd39mr806586e0c.9.1795129336840; 
 Thu, 19 Nov 2026 15:02:16 -0800 (PST)
X-Received: by 2002:a05:6123:110:b0:5ea:c3bc:c567 with SMTP id
 71dfb90a1353d-5ee8aefbd39mr806501e0c.9.1795129336266; 
 Thu, 19 Nov 2026 15:02:16 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb85399d52sm65268935e9.6.2026.11.19.15.02.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Nov 2026 15:02:15 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Max Filippov <jcmvbkbc@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 1/2] target/xtensa: Describe RER and WER register operands
Date: Fri, 20 Nov 2026 00:02:04 +0100
Message-ID: <20261119230205.4744-2-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261119230205.4744-1-philmd@oss.qualcomm.com>
References: <20261119230205.4744-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA5MiBTYWx0ZWRfX1JTOouR5WZq7
 lnBvQQ+Fiok3RqaKqZ9FngCj98oHR8jCgBBF2n4PXQnt36VPGJkET/7H2pjFIKOl1GqfSEc/TjU
 qU7Tcx4lfVHyy9NPKXHjRJAempiBIq0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA5MiBTYWx0ZWRfX+p4nu9M6MScc
 40KNpX7ZHEo0z4Xhz4zMHDB5j54TdRMLHI4ow2zqGTaG4luuzb/b6EtyknCUbXprjj1NEQdPfrQ
 Cagcap+/68YUZ1+qWgOIJhBDA9tJWJZj9ua2cCwCz5G+QMLhHL1ningUI+1cxaXVB+Rn8R97xeA
 ufA13a78EUJ/62+KanO2BoACg+/fsPX9ZARmfkqyCD3XVywNzAikYC+qABdV0oidvs2EIstez1U
 bWv3dA4HUgUdyRKA8Qde73OKiOL//4C1tPxZ0IaIOWcSA+ou4q86sLTRlS4nDS7LkQWH218TL62
 C/zYHec8W9CN1cJHp4aSLxPNgik/Skr7oUX1oUDgvA4lYACiZAH8a9+M7HlGvq+HultmabXpT0f
 UnjaAmH1gMtn02SsFvoyH3VostGD0IxxlzDsYkZ0EDiWQ4HF6c8UzSM7aZOvY2S99qMubJpZPLn
 ejcwUofjqt3HEIE8E7w==
X-Proofpoint-GUID: PKaFsiV2DUOodY6fP47EecZcvC7TCPXc
X-Proofpoint-ORIG-GUID: PKaFsiV2DUOodY6fP47EecZcvC7TCPXc
X-Authority-Analysis: v=2.4 cv=LPTz05W9 c=1 sm=1 tr=0 ts=6aff7ff9 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=H1htKhyfUzTIpUZEvLMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190092
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

Supply the two register operands missing from the dc233c, lx106
and dsp3400 ISA tables. RER writes its destination and reads its
address; WER reads both.

The translator expects these operands and otherwise consumes
uninitialized arguments when a guest accesses an external register.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/xtensa/core-dc233c/xtensa-modules.c.inc  | 14 ++++++++++++--
 target/xtensa/core-dsp3400/xtensa-modules.c.inc | 14 ++++++++++++--
 target/xtensa/core-lx106/xtensa-modules.c.inc   | 14 ++++++++++++--
 3 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/target/xtensa/core-dc233c/xtensa-modules.c.inc b/target/xtensa/core-dc233c/xtensa-modules.c.inc
index 0f32f0804ab3..30a7970207cb 100644
--- a/target/xtensa/core-dc233c/xtensa-modules.c.inc
+++ b/target/xtensa/core-dc233c/xtensa-modules.c.inc
@@ -5814,6 +5814,16 @@ static xtensa_arg_internal Iclass_xt_iclass_div_args[] = {
   { { OPERAND_art }, 'i' }
 };
 
+static xtensa_arg_internal Iclass_xt_iclass_rer_args[] = {
+  { { OPERAND_art }, 'o' },
+  { { OPERAND_ars }, 'i' }
+};
+
+static xtensa_arg_internal Iclass_xt_iclass_wer_args[] = {
+  { { OPERAND_art }, 'i' },
+  { { OPERAND_ars }, 'i' }
+};
+
 static xtensa_arg_internal Iclass_xt_iclass_rer_stateArgs[] = {
   { { STATE_PSEXCM }, 'i' },
   { { STATE_PSRING }, 'i' }
@@ -6519,9 +6529,9 @@ static xtensa_iclass_internal iclasses[] = {
     4, Iclass_xt_iclass_xsr_atomctl_stateArgs, 0, 0 },
   { 3, Iclass_xt_iclass_div_args,
     0, 0, 0, 0 },
-  { 0, 0 /* xt_iclass_rer */,
+  { 2, Iclass_xt_iclass_rer_args,
     2, Iclass_xt_iclass_rer_stateArgs, 0, 0 },
-  { 0, 0 /* xt_iclass_wer */,
+  { 2, Iclass_xt_iclass_wer_args,
     2, Iclass_xt_iclass_wer_stateArgs, 0, 0 },
   { 1, Iclass_rur_expstate_args,
     2, Iclass_rur_expstate_stateArgs, 0, 0 },
diff --git a/target/xtensa/core-dsp3400/xtensa-modules.c.inc b/target/xtensa/core-dsp3400/xtensa-modules.c.inc
index 28ea3d75fef0..5c358207ed69 100644
--- a/target/xtensa/core-dsp3400/xtensa-modules.c.inc
+++ b/target/xtensa/core-dsp3400/xtensa-modules.c.inc
@@ -54194,6 +54194,16 @@ static xtensa_arg_internal Iclass_wur_phasor_offset_stateArgs[] = {
   { { STATE_CPENABLE }, 'i' }
 };
 
+static xtensa_arg_internal Iclass_xt_iclass_rer_args[] = {
+  { { OPERAND_art }, 'o' },
+  { { OPERAND_ars }, 'i' }
+};
+
+static xtensa_arg_internal Iclass_xt_iclass_wer_args[] = {
+  { { OPERAND_art }, 'i' },
+  { { OPERAND_ars }, 'i' }
+};
+
 static xtensa_iclass_internal iclasses[] = {
   { 0, 0 /* xt_iclass_excw */,
     0, 0, 0, 0 },
@@ -54719,9 +54729,9 @@ static xtensa_iclass_internal iclasses[] = {
     2, Iclass_xt_iclass_wsr_atomctl_stateArgs, 0, 0 },
   { 1, Iclass_xt_iclass_xsr_atomctl_args,
     2, Iclass_xt_iclass_xsr_atomctl_stateArgs, 0, 0 },
-  { 0, 0 /* xt_iclass_rer */,
+  { 2, Iclass_xt_iclass_rer_args,
     0, 0, 0, 0 },
-  { 0, 0 /* xt_iclass_wer */,
+  { 2, Iclass_xt_iclass_wer_args,
     0, 0, 0, 0 },
   { 1, Iclass_rur_fcr_args,
     9, Iclass_rur_fcr_stateArgs, 0, 0 },
diff --git a/target/xtensa/core-lx106/xtensa-modules.c.inc b/target/xtensa/core-lx106/xtensa-modules.c.inc
index f2b5efc6ec88..d7889e707932 100644
--- a/target/xtensa/core-lx106/xtensa-modules.c.inc
+++ b/target/xtensa/core-lx106/xtensa-modules.c.inc
@@ -3291,6 +3291,16 @@ static xtensa_arg_internal Iclass_xt_iclass_nsa_args[] = {
   { { OPERAND_ars }, 'i' }
 };
 
+static xtensa_arg_internal Iclass_xt_iclass_rer_args[] = {
+  { { OPERAND_art }, 'o' },
+  { { OPERAND_ars }, 'i' }
+};
+
+static xtensa_arg_internal Iclass_xt_iclass_wer_args[] = {
+  { { OPERAND_art }, 'i' },
+  { { OPERAND_ars }, 'i' }
+};
+
 static xtensa_iclass_internal iclasses[] = {
   { 0, 0 /* xt_iclass_excw */,
     0, 0, 0, 0 },
@@ -3606,9 +3616,9 @@ static xtensa_iclass_internal iclasses[] = {
     0, 0, 0, 0 },
   { 2, Iclass_xt_iclass_nsa_args,
     0, 0, 0, 0 },
-  { 0, 0 /* xt_iclass_rer */,
+  { 2, Iclass_xt_iclass_rer_args,
     0, 0, 0, 0 },
-  { 0, 0 /* xt_iclass_wer */,
+  { 2, Iclass_xt_iclass_wer_args,
     0, 0, 0, 0 }
 };
 
-- 
2.55.0


