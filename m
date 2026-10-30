Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E504606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 15:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MP9UkgpQ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VINy10ah
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMo8h-0000L6-W7; Fri, 30 Oct 2026 11:03:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMo8a-0008Ux-H3
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:03:25 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMo8X-0007BC-W5
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:03:24 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UERDm13564437
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 15:03:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pHBfphjFk72RZcXH8pnpvBiHw5H3I6zUtVVH2ElhPEU=; b=MP9UkgpQo6xv/Pf/
 VH+EPf/t1bIPkG/7o/M/68sEY6J/jLh7t/+mAw8UaXOXF7NlbmeuqE/XPiMH60AB
 iL0l4cpHvn9fmaHaONtrFMeeYa9ffN3yZiQUfhX376N+wYD4WgqfGf8o6UT8b3NK
 LUtfFdkPd9CP/nZIHUJlYHNRPAv+q6lu+gusHUetVmW6IxLitOqa/JKMcSWvEYpd
 2QanYM/YmgpCJC7lwZWllSArxxKNKJfsFkwC4dFq7kj5ACoAxfs7jvuv4OJXiYcq
 ei+eJBnwXv7YnkxyxjLeGl1kquQ0KQZhKHknZRzv99jK5P2S5WbcOjzWbRkUoRHa
 GlMoxQ==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qkm04-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 15:03:20 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-7bf5c02f7a3so179368137.2
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 08:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793372600; x=1793977400; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pHBfphjFk72RZcXH8pnpvBiHw5H3I6zUtVVH2ElhPEU=;
 b=VINy10ahr/IPPYRTYahvq2c1Tg8Du7+U/Oalyifq5uYjCwBQg4S2KYrXqFcazFExUK
 2pfg0/AFUE/27VLrOvsLRv7ivsmIwiyVZC+WUoMFkr2CJHdpw0Hoq/DAj1zN0fmX7vre
 rl1VuyShwCEcBOHiKofAY1xfcBIdGVcAmFHc6mfVIDvj1eOcf0jR/7eQsscBXAB+QR6a
 MtyIKoIom/AT5tzBq2AmBJu448N93t9e/azP2wR41Qz6mDtDWgBRwz6oTnoGbKqCyIwt
 EaZKoUs/SuQOG36uDLyEYSfJmIOQ28Ud4dsNqdBU3wnrHqCOEIk9z1uztqtKiEWoPtqC
 fUGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793372600; x=1793977400;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pHBfphjFk72RZcXH8pnpvBiHw5H3I6zUtVVH2ElhPEU=;
 b=SNDSzZPf7dS6CQN6UvWYSda3DN+/BGNcfiiRpBCxMPccd6XlYwlYfR3ReNCR5yDqBX
 5DVrnJQSifsbGZonxPJdRlVe7zFccLMx955geMtuXPvK6iFfzS9vM7e48v3oroilqvSR
 YYyMAzueE+6vr31KNDFJWMfiuqPjAP3iyhRUFb6oVVoyd7wJa9wJSbxlbfvAuQcdGVt/
 NdTwQcuPQMzsinAIVQl5fX6jSAaEczpKLdGmig+rQ0aYSfYvyV/qBA9tBmFP4InXELf0
 XUdoJ+p/GojvRtc6f249+O44W3bhQWpKzlTmfnqZnN3LdwnKGuYoiOJzOnyrPuak8xV9
 omrw==
X-Gm-Message-State: AFq9FYLJCGJxJgpg6QmHvqgLDvuBLeSYoW8ZM8MfPPy+wT058Ry9m9jo
 WQD48dVjxoo83z4ZLmKzYQuxxCubMkf2mGCRs3chyMyv1SLGLWTYl2EZb/JBoXM+K+V77JPu9op
 dUiBu3NaGUhhBAaTLNFYWtbW1SmAzy68Slrq0TDb7/860mufezSU5YCLkcFk7uN3+YLLW
X-Gm-Gg: AYBFou3lxGazy0mn7BxVQYENdVzSJ9RsY0D4TPv6UZbjG++oSIne48H8VaaAY4rW4Im
 7xs0fd1ZLDTbQ9y1KnEalCfumv1f0yYfN439trxnNsyigh7WbUPOnJXuEd/ESORO7CFvt/cZEbq
 +UU06yyIuCfi2pJVFHSBm6rbKmKAuArOOZ0ws0FvEccut9qt/oGEXUUDdrGAlI7v0RAXNvyp4Gq
 QcD2v4hSBQfAeyKm+03wG2L/HM3vtb3Gk5IYcTvDRtUoY6IoUeXZhF80aEgSlrqEDak56BGOee8
 5b4lhM1nCJCTXnu35qoGkL5/yLALgFYTbaYewnuiIa9hzadg7B2aZHYcADnyLWAdf7Xpd6lmneD
 c3IUDz1HxuoAy6oV8Hlv0zVkKeva+ARLZcReJ0RrdKEtoYUp6doONTGJCm85DXsFRsP/eIzsKqY
 r4abKq/1GAGtmJoSNB3Mq0LK7wr8mC+A==
X-Received: by 2002:a05:6102:5126:b0:7cc:56a:58e0 with SMTP id
 ada2fe7eead31-7d0725e16d4mr1062744137.21.1793372598349; 
 Fri, 30 Oct 2026 08:03:18 -0700 (PDT)
X-Received: by 2002:a05:6102:5126:b0:7cc:56a:58e0 with SMTP id
 ada2fe7eead31-7d0725e16d4mr1062561137.21.1793372596167; 
 Fri, 30 Oct 2026 08:03:16 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abf5b27e46sm103437665e9.3.2026.10.30.08.03.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Oct 2026 08:03:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 08/31] tests/tcg/mips: Group DSP shift tests
Date: Fri, 30 Oct 2026 16:01:38 +0100
Message-ID: <20261030150202.61556-9-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030150202.61556-1-philmd@oss.qualcomm.com>
References: <20261030150202.61556-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: VpgbddvX6TCvW9S6xS3vz-sTcpMrJZ1T
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA1OSBTYWx0ZWRfX1BPvpvfTFk99
 ozjjnyUXa6iKhGyNv4Ms2NwnQkHgOGlQSKG9UR3S3aG23C+X/tPMnmOM2yDKyHxLFlDsLXT92qf
 hckQVF21KkAiZZ0WRhmivDI5Ipga0E0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA1OSBTYWx0ZWRfXw+v4FbmYyGV7
 5Tg0rIbU7a5nfC50ZxMSjHGYoNycjKOWxNm61wV5aCNIpi/sM5umsOn/jiME/sqfePjjbkdNZNh
 0L+6KtAwjpe8JVvpEXjhM3B5RZ8RapkS4cBpoPAiTayJ9X1UcdHvyFEG1Z2KZiBMUQHN8TWO/8D
 vkhQ6UCamIs7OuKud6nJm2OBrgd1/4KDd4orON+Q8d0NXbxyy15wNl9jEu3PWxp566mGlA1zZqF
 FzY4eIxfjNwBftWYgfrumkbT+/n0iDXSwqie4i2tndndHgLptGfP4P7l3u1ms91IN5O/EtX+JH7
 iz6E6DFmjH6xUuP4PFq/2NY9K7rw+ogqXtl2RbfS3yBNQhb3BICxNzJltNuqcdYDgSdabt2MRky
 o7Rp0hKgFze0lEBMN5W5wFMafqegKfadyAnsBuXHqBRuY59kTWJXLcy3t0zY8hs6HueuP4ECgr4
 cegFik6xRtEUEBzmsiA==
X-Proofpoint-ORIG-GUID: VpgbddvX6TCvW9S6xS3vz-sTcpMrJZ1T
X-Authority-Analysis: v=2.4 cv=TpVzFzXh c=1 sm=1 tr=0 ts=6ae4b1b8 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=PBVPcx0-DJstsYKfvf4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 adultscore=0 suspectscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300059
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

Build the 22 per-opcode shift tests as a single executable,
test_dsp_shift.c, to reduce the number of test binaries.
Each opcode reports one TAP line.

All DSP tests now emit TAP: select it in the meson setup.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
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
 tests/tcg/mipsel/test_dsp_shift.c         | 123 ++++++++++++++++++++++
 tests/tcg/mipsel/meson.build              |  24 +----
 24 files changed, 125 insertions(+), 44 deletions(-)
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
index 000000000000..a7e8ed342718
--- /dev/null
+++ b/tests/tcg/mipsel/test_dsp_shift.c
@@ -0,0 +1,123 @@
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
+    return tap_done();
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


