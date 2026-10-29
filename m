Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8361A606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=l6U1UO9o;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hnumXq4n
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMTrh-0006BQ-E2; Thu, 29 Oct 2026 13:24:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMTra-00062S-Rl
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:24:30 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMTrS-00016s-Ug
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:24:26 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGDHab227449
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:24:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ihtI0tOTwH0JQzq9Rfhpaze0cXnf9b6PJefpTTIAEfg=; b=l6U1UO9oixKo3qm0
 uNdIMsWdDT43DJBTvlO0J7e2z7BIQNF+SljKwKWXuunuznhZjepsk2czDRw/A9ek
 Wv/JoLIswj3tsY4082ceIH7iw8F08gl2dbLi1Cp48VKtcK2h5gpoJlNAXQms9Zmr
 23JiWgnj4cvdfnsNJuWFNVn9daI4ORXa5Lejeq0bZOOb6ovzy26jviDIKCQxDry4
 GtfmgRz856O+Ht62UnRDJ8snGx4eSu/ZcTZ+B0XnDILzCWkXwbPKP/PaLEZSrvQP
 1o4MeNFi9GLbaUxB0yMdbVPfxPzcepZWuPhyx2jXoywuYXsD59c1ld+gpG1xO0Fv
 ZE1Izg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm42fj9j4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:24:21 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93caf7856ffso534395885a.3
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 10:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793294661; x=1793899461; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ihtI0tOTwH0JQzq9Rfhpaze0cXnf9b6PJefpTTIAEfg=;
 b=hnumXq4naMddXmFCKVndIk0Wm8Ahs5S+NV5jdPFU5tNLXJxwDZPyO+c6efAu08IeGi
 UAGM09B38z3gr1yxUw2r3LsSskirpWC4yX5vgooCCh3MQS6jMT1W+ZSdZccexuOceBc2
 O5w2JWnd9L5cl5s7MhSsHDy9jv4301s6jQVv1J7bjKH77v5NdNL2GyKOZ56zoV9sJs5N
 cBhnw9ov4mEP1RK0qGQwLCogO9QZkUSkqcLtbJAxQif1nVhdC4gHjN78he4MsPp/QhWK
 uLZ9je3T2/xdk/XFnF0JzvDfXDx7yVPOlBg/4EEQHMQrqTcy33mmOSudMgmvEg9qjJcr
 KDDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793294661; x=1793899461;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ihtI0tOTwH0JQzq9Rfhpaze0cXnf9b6PJefpTTIAEfg=;
 b=g/o16lKSFICpRojeeQqlRMPDwXOUESMAlOV2yIqOgJPDpcvpSRmED9Wx72FgiC3+Wy
 XhFXu1E7U7BYNOfEyGMkr4llc6gO7SfiOrl6vu1vLW6lSdfh2EgOulWOEO0RJc4crq9h
 oaebUFAe3HrYa63KjZeuWZmJuBN59Tr4X+KpR2b9sxvjLnzNmKi31ZvgkM3XcnLpOS4A
 5GY+xpT3euYyWBozJfrd8zbCAmzEXIvAtbZ802hYIOUDbYq8N+3VI7ppZ8rpQKvmxkAm
 xqUVmzHDYMMw3DvHKvWRFObEO0IG4bLBLQ6RkIOayISXKAyzPo4Y4M/D9UgmfG8ABj2H
 1YcQ==
X-Gm-Message-State: AFq9FYLXrSmfLamGODZ3apfeOpihsXXiXQUKGFnZtBroSI0q8dDZAVko
 YB/UUpEbCojdZJBXbJGQ4uoCIHw7wn0d+BYXfzdzk/dHyxQwlKuhLwWp6ILS79oRZ4GafoQ+h0d
 58w+GzYQ2gsIF+GsQb6H1dn5lY429AIV+AVa/2kKR0zMDsHszA0E5Ln9VmNK+SaJtlZcz
X-Gm-Gg: AYBFou1pi0vT3gYWdKk4pXsTUO+dXxUB4KTEJkZRXtXykyFj0l9yxQ+fVU6EIzU8x3G
 aSGNQWnWWaDUXIRStAcvYpH86nKoR0DUxHfVPGITaYhMlYvKzHl88fih3eeqMHEudmYAmmkt0F+
 3UcHW8aL9so2a1k2hRjz546msVlrrcg3hXHz2vu4GVVaMx1OzQtlcG+Xta86HrF1+2/iimVnGKA
 FmVI9LPWhIbSDLWs/hm5o4AgwX94p6GAaEOvBY1lNGlETNCGdA//35+0dwdAQn1pdgeCVpvBzbA
 CIrki1f8E1cgl6JythQpXG1ATAps7OKcYodD6x48eBjTE6xd9OtXXT7kjYqCB9GWxgLxRKp3LWF
 NbaxCWtQqF2oQdGyhkDUpMd+EB04vTGvy5DwNs9MpoC4HjcYLx3g95l3gsq+BqQpATjV2AxMGLz
 o8yaqTjqgNhwxZVZMILuc8yKzFVzpYqA==
X-Received: by 2002:a05:620a:31a9:b0:93e:6c4f:bdf1 with SMTP id
 af79cd13be357-94408a5f828mr1010940385a.17.1793294661000; 
 Thu, 29 Oct 2026 10:24:21 -0700 (PDT)
X-Received: by 2002:a05:620a:31a9:b0:93e:6c4f:bdf1 with SMTP id
 af79cd13be357-94408a5f828mr1010934985a.17.1793294660436; 
 Thu, 29 Oct 2026 10:24:20 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa7f322c46sm74712535e9.2.2026.10.29.10.24.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Oct 2026 10:24:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v2 08/31] tests/tcg/mips: Group DSP shift tests
Date: Thu, 29 Oct 2026 18:22:52 +0100
Message-ID: <20261029172319.25766-9-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261029172319.25766-1-philmd@oss.qualcomm.com>
References: <20261029172319.25766-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2OCBTYWx0ZWRfX46l9CGK1T9Ny
 VJl+59/vk01cRiEsT0j1y8gxJ92J0sEput2JmB/eja0l0AqdFd8pw+LtXjubobgx8Kl6y29O6qT
 /YLHK2RheGPsIUh9ypgtAnKmtavonSKfB5KRKW6MV2JGQi4xQinLJeVToSOL2qHhCINWGIdG8Y9
 65bKjWDUvrAmV63Vf8yBdPRHth55wMJBdjWxijEWCExQJd63oqQrJe5IcA/a4xPBwGV8Yuh5Xze
 RE6mQh0TsxHyc3EY4KgMLhGFpohPb9Kv5//yynqLr+HVx4xTo1oZ39vR4EZAT84j6YVMfh9aGhA
 eP8TINlDufjippPJSLG70TxD4qwWjH7RrfsVw+gLSizS+FTjVlGc9PQRqs5NE8+50xiHPsvA+Ho
 Yz8aI4TPYk/j2tgXXfhkIdIDO2BhsQ==
X-Proofpoint-GUID: FlD_TQYXPXhqpg9BbAcVULvMWtwttrWe
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2OCBTYWx0ZWRfX1EEMds5SWjp5
 d7qrX7XrTLnc3bD+Nq1hqGi9YG3LsK5yHerACsr/2+0aJk5OtbBbNrbQyTE6ttRNJpOAbyl3BSB
 V1IUTLW62/FvThwDmF/SBZSc9ADYBPY=
X-Authority-Analysis: v=2.4 cv=UN9Ijyfy c=1 sm=1 tr=0 ts=6ae38146 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=4Ezote9JcLLRqYrsOlYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: FlD_TQYXPXhqpg9BbAcVULvMWtwttrWe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2610190000 definitions=main-2610290068
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Build the 22 per-opcode shift tests as a single executable,
test_dsp_shift.c, to reduce the number of test binaries.
Each opcode reports one TAP line.

All DSP tests now emit TAP: select it in the meson setup.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 tests/tcg/mipsel/test_dsp_r1_shll_ph.c    |   1 -
 tests/tcg/mipsel/test_dsp_r1_shll_qb.c    |   1 -
 tests/tcg/mipsel/test_dsp_r1_shll_s_ph.c  |   1 -
 tests/tcg/mipsel/test_dsp_r1_shll_s_w.c   |   1 -
 tests/tcg/mipsel/test_dsp_r1_shllv_ph.c   |   1 -
 tests/tcg/mipsel/test_dsp_r1_shllv_qb.c   |   1 -
 tests/tcg/mipsel/test_dsp_r1_shllv_s_ph.c |   1 -
 tests/tcg/mipsel/test_dsp_r1_shllv_s_w.c  |   1 -
 tests/tcg/mipsel/test_dsp_r1_shra_ph.c    |   1 -
 tests/tcg/mipsel/test_dsp_r1_shra_r_ph.c  |   1 -
 tests/tcg/mipsel/test_dsp_r1_shra_r_w.c   |   1 -
 tests/tcg/mipsel/test_dsp_r1_shrav_ph.c   |   1 -
 tests/tcg/mipsel/test_dsp_r1_shrav_r_ph.c |   1 -
 tests/tcg/mipsel/test_dsp_r1_shrav_r_w.c  |   1 -
 tests/tcg/mipsel/test_dsp_r1_shrl_qb.c    |   1 -
 tests/tcg/mipsel/test_dsp_r1_shrlv_qb.c   |   1 -
 tests/tcg/mipsel/test_dsp_r2_shra_qb.c    |   1 -
 tests/tcg/mipsel/test_dsp_r2_shra_r_qb.c  |   1 -
 tests/tcg/mipsel/test_dsp_r2_shrav_qb.c   |   1 -
 tests/tcg/mipsel/test_dsp_r2_shrav_r_qb.c |   1 -
 tests/tcg/mipsel/test_dsp_r2_shrl_ph.c    |   1 -
 tests/tcg/mipsel/test_dsp_r2_shrlv_ph.c   |   1 -
 tests/tcg/mipsel/test_dsp_shift.c         | 127 ++++++++++++++++++++++
 tests/tcg/mipsel/meson.build              |  24 +---
 24 files changed, 129 insertions(+), 44 deletions(-)
 create mode 100644 tests/tcg/mipsel/test_dsp_shift.c

diff --git a/tests/tcg/mipsel/test_dsp_r1_shll_ph.c b/tests/tcg/mipsel/test_dsp_r1_shll_ph.c
index 5fa58ccf6374..336ef50ca8a6 100644
--- a/tests/tcg/mipsel/test_dsp_r1_shll_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r1_shll_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_shll_qb.c b/tests/tcg/mipsel/test_dsp_r1_shll_qb.c
index 729716d62618..60cd916766ed 100644
--- a/tests/tcg/mipsel/test_dsp_r1_shll_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r1_shll_qb.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_shll_s_ph.c b/tests/tcg/mipsel/test_dsp_r1_shll_s_ph.c
index 910fea3b317e..833b1d5673c8 100644
--- a/tests/tcg/mipsel/test_dsp_r1_shll_s_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r1_shll_s_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_shll_s_w.c b/tests/tcg/mipsel/test_dsp_r1_shll_s_w.c
index 628c7521027b..1848afb21323 100644
--- a/tests/tcg/mipsel/test_dsp_r1_shll_s_w.c
+++ b/tests/tcg/mipsel/test_dsp_r1_shll_s_w.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_shllv_ph.c b/tests/tcg/mipsel/test_dsp_r1_shllv_ph.c
index f98a6322dc1d..bc1664d70d12 100644
--- a/tests/tcg/mipsel/test_dsp_r1_shllv_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r1_shllv_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_shllv_qb.c b/tests/tcg/mipsel/test_dsp_r1_shllv_qb.c
index 6d8ff4a259ba..84600fc7fb36 100644
--- a/tests/tcg/mipsel/test_dsp_r1_shllv_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r1_shllv_qb.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_shllv_s_ph.c b/tests/tcg/mipsel/test_dsp_r1_shllv_s_ph.c
index fc9bd32765b8..4c84f3b94164 100644
--- a/tests/tcg/mipsel/test_dsp_r1_shllv_s_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r1_shllv_s_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_shllv_s_w.c b/tests/tcg/mipsel/test_dsp_r1_shllv_s_w.c
index 350c25617adc..5c06b4411a0e 100644
--- a/tests/tcg/mipsel/test_dsp_r1_shllv_s_w.c
+++ b/tests/tcg/mipsel/test_dsp_r1_shllv_s_w.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_shra_ph.c b/tests/tcg/mipsel/test_dsp_r1_shra_ph.c
index 5b2d840a6bc5..38fdc66e5b66 100644
--- a/tests/tcg/mipsel/test_dsp_r1_shra_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r1_shra_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_shra_r_ph.c b/tests/tcg/mipsel/test_dsp_r1_shra_r_ph.c
index adc4ae68bdc3..c838f8a32fe2 100644
--- a/tests/tcg/mipsel/test_dsp_r1_shra_r_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r1_shra_r_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_shra_r_w.c b/tests/tcg/mipsel/test_dsp_r1_shra_r_w.c
index ec0cf2c72ccb..d722cdecd166 100644
--- a/tests/tcg/mipsel/test_dsp_r1_shra_r_w.c
+++ b/tests/tcg/mipsel/test_dsp_r1_shra_r_w.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_shrav_ph.c b/tests/tcg/mipsel/test_dsp_r1_shrav_ph.c
index 6e42aaf8e1a7..c2cad6e67309 100644
--- a/tests/tcg/mipsel/test_dsp_r1_shrav_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r1_shrav_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_shrav_r_ph.c b/tests/tcg/mipsel/test_dsp_r1_shrav_r_ph.c
index f03b978d0544..ec2eea36b947 100644
--- a/tests/tcg/mipsel/test_dsp_r1_shrav_r_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r1_shrav_r_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_shrav_r_w.c b/tests/tcg/mipsel/test_dsp_r1_shrav_r_w.c
index 2ab03bb5daae..af50a92af2a9 100644
--- a/tests/tcg/mipsel/test_dsp_r1_shrav_r_w.c
+++ b/tests/tcg/mipsel/test_dsp_r1_shrav_r_w.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_shrl_qb.c b/tests/tcg/mipsel/test_dsp_r1_shrl_qb.c
index a7e4e6a5e4f5..bf6fab4ceb81 100644
--- a/tests/tcg/mipsel/test_dsp_r1_shrl_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r1_shrl_qb.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_shrlv_qb.c b/tests/tcg/mipsel/test_dsp_r1_shrlv_qb.c
index db77f6d0e117..99d7aba6dde9 100644
--- a/tests/tcg/mipsel/test_dsp_r1_shrlv_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r1_shrlv_qb.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_shra_qb.c b/tests/tcg/mipsel/test_dsp_r2_shra_qb.c
index 48193de87ad0..d4ca7430fdba 100644
--- a/tests/tcg/mipsel/test_dsp_r2_shra_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r2_shra_qb.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_shra_r_qb.c b/tests/tcg/mipsel/test_dsp_r2_shra_r_qb.c
index 29afa0e4b07b..08d22fd4cd6f 100644
--- a/tests/tcg/mipsel/test_dsp_r2_shra_r_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r2_shra_r_qb.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_shrav_qb.c b/tests/tcg/mipsel/test_dsp_r2_shrav_qb.c
index b21e1b7ca64a..5015a124b89d 100644
--- a/tests/tcg/mipsel/test_dsp_r2_shrav_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r2_shrav_qb.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_shrav_r_qb.c b/tests/tcg/mipsel/test_dsp_r2_shrav_r_qb.c
index 9ea8aa0cbb90..1bfc66ec3676 100644
--- a/tests/tcg/mipsel/test_dsp_r2_shrav_r_qb.c
+++ b/tests/tcg/mipsel/test_dsp_r2_shrav_r_qb.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_shrl_ph.c b/tests/tcg/mipsel/test_dsp_r2_shrl_ph.c
index 724b9a7a4691..ea53113568e0 100644
--- a/tests/tcg/mipsel/test_dsp_r2_shrl_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r2_shrl_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_shrlv_ph.c b/tests/tcg/mipsel/test_dsp_r2_shrlv_ph.c
index ac79aa69acf0..40edd7cab67f 100644
--- a/tests/tcg/mipsel/test_dsp_r2_shrlv_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r2_shrlv_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_shift.c b/tests/tcg/mipsel/test_dsp_shift.c
new file mode 100644
index 000000000000..8854ca255747
--- /dev/null
+++ b/tests/tcg/mipsel/test_dsp_shift.c
@@ -0,0 +1,127 @@
+/*
+ * MIPS DSP ASE tests: Shift instructions
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "test_dsp_runner.h"
+
+#define main test_dsp_r1_shll_ph
+#include "test_dsp_r1_shll_ph.c"
+#undef main
+
+#define main test_dsp_r1_shll_qb
+#include "test_dsp_r1_shll_qb.c"
+#undef main
+
+#define main test_dsp_r1_shll_s_ph
+#include "test_dsp_r1_shll_s_ph.c"
+#undef main
+
+#define main test_dsp_r1_shll_s_w
+#include "test_dsp_r1_shll_s_w.c"
+#undef main
+
+#define main test_dsp_r1_shllv_ph
+#include "test_dsp_r1_shllv_ph.c"
+#undef main
+
+#define main test_dsp_r1_shllv_qb
+#include "test_dsp_r1_shllv_qb.c"
+#undef main
+
+#define main test_dsp_r1_shllv_s_ph
+#include "test_dsp_r1_shllv_s_ph.c"
+#undef main
+
+#define main test_dsp_r1_shllv_s_w
+#include "test_dsp_r1_shllv_s_w.c"
+#undef main
+
+#define main test_dsp_r1_shra_ph
+#include "test_dsp_r1_shra_ph.c"
+#undef main
+
+#define main test_dsp_r1_shra_r_ph
+#include "test_dsp_r1_shra_r_ph.c"
+#undef main
+
+#define main test_dsp_r1_shra_r_w
+#include "test_dsp_r1_shra_r_w.c"
+#undef main
+
+#define main test_dsp_r1_shrav_ph
+#include "test_dsp_r1_shrav_ph.c"
+#undef main
+
+#define main test_dsp_r1_shrav_r_ph
+#include "test_dsp_r1_shrav_r_ph.c"
+#undef main
+
+#define main test_dsp_r1_shrav_r_w
+#include "test_dsp_r1_shrav_r_w.c"
+#undef main
+
+#define main test_dsp_r1_shrl_qb
+#include "test_dsp_r1_shrl_qb.c"
+#undef main
+
+#define main test_dsp_r1_shrlv_qb
+#include "test_dsp_r1_shrlv_qb.c"
+#undef main
+
+#define main test_dsp_r2_shra_qb
+#include "test_dsp_r2_shra_qb.c"
+#undef main
+
+#define main test_dsp_r2_shra_r_qb
+#include "test_dsp_r2_shra_r_qb.c"
+#undef main
+
+#define main test_dsp_r2_shrav_qb
+#include "test_dsp_r2_shrav_qb.c"
+#undef main
+
+#define main test_dsp_r2_shrav_r_qb
+#include "test_dsp_r2_shrav_r_qb.c"
+#undef main
+
+#define main test_dsp_r2_shrl_ph
+#include "test_dsp_r2_shrl_ph.c"
+#undef main
+
+#define main test_dsp_r2_shrlv_ph
+#include "test_dsp_r2_shrlv_ph.c"
+#undef main
+
+int main(void)
+{
+    int ret = 0;
+
+    RUN_TEST(test_dsp_r1_shll_ph);
+    RUN_TEST(test_dsp_r1_shll_qb);
+    RUN_TEST(test_dsp_r1_shll_s_ph);
+    RUN_TEST(test_dsp_r1_shll_s_w);
+    RUN_TEST(test_dsp_r1_shllv_ph);
+    RUN_TEST(test_dsp_r1_shllv_qb);
+    RUN_TEST(test_dsp_r1_shllv_s_ph);
+    RUN_TEST(test_dsp_r1_shllv_s_w);
+    RUN_TEST(test_dsp_r1_shra_ph);
+    RUN_TEST(test_dsp_r1_shra_r_ph);
+    RUN_TEST(test_dsp_r1_shra_r_w);
+    RUN_TEST(test_dsp_r1_shrav_ph);
+    RUN_TEST(test_dsp_r1_shrav_r_ph);
+    RUN_TEST(test_dsp_r1_shrav_r_w);
+    RUN_TEST(test_dsp_r1_shrl_qb);
+    RUN_TEST(test_dsp_r1_shrlv_qb);
+    RUN_TEST(test_dsp_r2_shra_qb);
+    RUN_TEST(test_dsp_r2_shra_r_qb);
+    RUN_TEST(test_dsp_r2_shrav_qb);
+    RUN_TEST(test_dsp_r2_shrav_r_qb);
+    RUN_TEST(test_dsp_r2_shrl_ph);
+    RUN_TEST(test_dsp_r2_shrlv_ph);
+
+    DSP_TAP_PLAN();
+
+    return ret;
+}
diff --git a/tests/tcg/mipsel/meson.build b/tests/tcg/mipsel/meson.build
index 247db7d10d79..9e446eed0f6e 100644
--- a/tests/tcg/mipsel/meson.build
+++ b/tests/tcg/mipsel/meson.build
@@ -11,28 +11,7 @@ tests_dsp = [
   'test_dsp_dot.c',
   'test_dsp_mul.c',
   'test_dsp_pack.c',
-  'test_dsp_r1_shll_ph.c',
-  'test_dsp_r1_shll_qb.c',
-  'test_dsp_r1_shll_s_ph.c',
-  'test_dsp_r1_shll_s_w.c',
-  'test_dsp_r1_shllv_ph.c',
-  'test_dsp_r1_shllv_qb.c',
-  'test_dsp_r1_shllv_s_ph.c',
-  'test_dsp_r1_shllv_s_w.c',
-  'test_dsp_r1_shra_ph.c',
-  'test_dsp_r1_shra_r_ph.c',
-  'test_dsp_r1_shra_r_w.c',
-  'test_dsp_r1_shrav_ph.c',
-  'test_dsp_r1_shrav_r_ph.c',
-  'test_dsp_r1_shrav_r_w.c',
-  'test_dsp_r1_shrl_qb.c',
-  'test_dsp_r1_shrlv_qb.c',
-  'test_dsp_r2_shra_qb.c',
-  'test_dsp_r2_shra_r_qb.c',
-  'test_dsp_r2_shrav_qb.c',
-  'test_dsp_r2_shrav_r_qb.c',
-  'test_dsp_r2_shrl_ph.c',
-  'test_dsp_r2_shrlv_ph.c',
+  'test_dsp_shift.c',
 ]
 
 foreach src: tests_dsp
@@ -41,6 +20,7 @@ foreach src: tests_dsp
       'cflags': ['-EL', '-mabi=32', '-march=mips32r2', '-mgp32', '-mdsp', '-mdspr2',
                  '-Wno-unused-but-set-variable', '-Wno-unused-variable'],
       'qemu_args': ['-cpu', '74Kf'],
+      'protocol': 'tap',
     }
   }
 endforeach
-- 
2.55.0


