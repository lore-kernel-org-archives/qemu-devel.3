Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32CF606A330
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 17:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VRzmRzaC;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fNPv58Mp
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMqpB-0005yr-Lf; Fri, 30 Oct 2026 13:55:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMqoc-0005fP-JF
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:55:00 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMqoa-0007w0-Ki
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:54:58 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UERRjF2968389
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 17:54:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 15OmZNYbzQCt2QVv5Xk4bwOjKMAb5Lq5EeNJyDejFnY=; b=VRzmRzaC5jnJG6GF
 wNJ1LbZPSP30NSbPQ8LFmJDJejlE5YFxhbPutHSDEJ3dbCCFx8PRZSYIxt+RPNqX
 tbSSHnJn6VNUtgyOR9wUBrik/MNj7Uxwii7t9BMeoU6TQfx120AGFu/zeVo00kDJ
 c1n1hNuI8WjymwVtz7M7JA73Z1OmF98iZTuvHGGh3Mtxm2A+zToAiGJAerrWmGIu
 rY5RSJdwvLcODDdh1stHbRtOSv4xekLX30cr2Uf6xkR88fNFnU0LM73BFaZX0czb
 Ww/q+zTreJwLIlsk2gTwMLwCXPxVF8CY9LlWhMS1pqzNZKFeEUHEFH1aHe/fIBRr
 Ya2sSQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qmbpu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 17:54:55 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f6f4fe531so162487885a.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 10:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793382894; x=1793987694; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=15OmZNYbzQCt2QVv5Xk4bwOjKMAb5Lq5EeNJyDejFnY=;
 b=fNPv58Mps+0p+T/BIkRn1vMPUqm5gPqdiqy1QdkpWxB4nTGVLDS3Qf5+ia/NSxXE9g
 iBQSE6xpSN0WTbKgN66lS+XyAEj/lMcX1XMtQLoVx98qDoPd1leMI8t7v+/qh9z9AVN6
 9ZxCG+MvRzP6onBdz8A1CWMz+Yqew0teCAhF+p7C58OZbchHq0bi7UcJ9m8Hf6RwiU5N
 7dvFeu1bI76N/5O5LdNiIaYwMSMY83vmal94z9ZiUQGMZRT5astv6zujBBH04iBH8aeQ
 ELOiUiBuBA1rrL5/3dj26TJABaweQw/tSoZEf+S9zQ16EyT5Up5kueJIQhVUqoWSFnwS
 1RPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793382894; x=1793987694;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=15OmZNYbzQCt2QVv5Xk4bwOjKMAb5Lq5EeNJyDejFnY=;
 b=RmnXYHbVl0s2UtIhyHwU7m7qFhHzQDpe2wokKPVP7KATP5zBpvS0PzTkfM+dTergqh
 SN3nfLiv2rA68M9QH/cZI/uc0stmdr5Pzm9eWHKfwFem41EkYp/ZDmjbaSACZz5OQN1h
 oYWHH7MatjxjFu0KFWPAveJcbkIf84TneJcspeG9qkp71Vj+0ffJ1KPP//DyFi47D1IA
 1FGm13+UrwvdEFTOQJjKpi0dFR3xuKvxZ28TDfg6/IQ9ysBDZf+RjRzK6dvGGMnxtA0c
 +kxMkxHNuopKRmTzUPENV7Z0MjO0ln4RRStaw5PZgF7EzMHYXALx0PUoOSZIvjQjNG5J
 5hqQ==
X-Gm-Message-State: AFq9FYL/+H8b53XdkWHA0epXN0NzWa5THEsYM/yUNK39LcgR6j5EhLgq
 ECOUZUZ2CWGmK5tq9t3CiPE6xIByl3hBEzaaQew3JHemnzO/cYOcicOQaOeIeIw522pipXt+dwK
 09GCcC00AW05L1/57erbg2HPIKkUOrseWakAL4RTdBhqtWuWjVKkmxIqsKe21E81lcQEZ
X-Gm-Gg: AYBFou3QuHQICDyBrCeClQybXowOb2ipfz3A/FmtW0PNPNly8Em3H+wxzSBKpeHsYL4
 W1x6LhaACormgUMwVeGf9U1VtkBkINKTVG8VgJkbChNBJU6beF21tmKDz7FLdZvEWOnF2E/xRfc
 EAv5XJYYeXCrj7CXSsS7N2fPFVWGg+maIogmLrC/LTr+yB8npWoJy+3vWpP9kiP0wP0f1Hw6KLT
 IrMPKFfTaDnmH7AijOhXPCG7S8fzt8wfoYSrJtv+BDEnR7LfaMqnsMvLQtmfirIkZKYAGHOJhoQ
 NhKTqHtr+A9gZYgZH85kz5obExgsnSNpAyv/2evFd9rTefxwjr8l/ieZdk7V7PhUolUwtWzWOVe
 7TA2cmNl50NgvXe57h57TGahBbHVajVxf74tp2ad8srKdnreyXxAVb4dePk2+f9/45m9XQ+hrvG
 cEqDM5j4Njd7vzPpFpf51cscPTfBRtVQ==
X-Received: by 2002:a05:620a:608e:b0:93f:2bca:2cd8 with SMTP id
 af79cd13be357-94421796040mr499788085a.57.1793382894150; 
 Fri, 30 Oct 2026 10:54:54 -0700 (PDT)
X-Received: by 2002:a05:620a:608e:b0:93f:2bca:2cd8 with SMTP id
 af79cd13be357-94421796040mr499784385a.57.1793382893627; 
 Fri, 30 Oct 2026 10:54:53 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abea533a1esm51239635e9.1.2026.10.30.10.54.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Oct 2026 10:54:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v4 07/32] tests/tcg/mips: Group DSP mul tests
Date: Fri, 30 Oct 2026 18:53:29 +0100
Message-ID: <20261030175357.99684-8-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030175357.99684-1-philmd@oss.qualcomm.com>
References: <20261030175357.99684-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA3MSBTYWx0ZWRfX1NVIdOgH15bu
 LdJVO5aDiGVwYthmvBAa29u27opLImqYLRDrL5Qfnx3FGaJCxGGx+jPzGyUulmNV2E0TjY1HG7G
 XaJ2CptnENhO9wl/IVSo0O42qH3OKEbXXlax4pEqDrtl8xISr8cBA4gkOfpr+qGJ1GIRm5LPj2g
 25A/SseBaz0IZ8VCJ++eO1bl3tcuhPwhW5j2d1xUvdgM1/eQ95FyoXihAU9ogSAqmh/gGGi9N2b
 24idaePUvELJi/3eo99pgL9mbQq48zEvWv9xVNOMnF5291yo5Lytjx70qH29FpTE86Dv8HIM7DX
 RlP8j16+pXQY72vJ5S7vCFnSs4FtA+/qD5Omasvfwqs58YHfWMka7aGJC7j9ZmYtz9KzloF8jiR
 6oGnr8A7Rn3l2ykzOK5C790B+ABsu1h7hnn6RNfDUu4Ab8/MWRAeky9pFWJt+9Cze6aitOJoiT8
 CE5p6BjiXiS/uVyjlaw==
X-Proofpoint-GUID: BedqOy8zkwVnnVmKtfugDjDd9lc2tZLw
X-Proofpoint-ORIG-GUID: BedqOy8zkwVnnVmKtfugDjDd9lc2tZLw
X-Authority-Analysis: v=2.4 cv=IumL47/g c=1 sm=1 tr=0 ts=6ae4d9ef cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=MrkvrxfUm_GaFPyPbecA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA3MSBTYWx0ZWRfX8uV2NQIfd8vn
 NMd2bz+HHsXf5p79jM5ZSjdJfgPFfYohHMlJaAT6mDzevumXDKNBiRkD85Dc2FrMIoL1+njFfsC
 vMqgYeWaPiYyrNQzRjzsE9E36Gf4f3k=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 clxscore=1015 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300071
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

Build the 10 per-opcode mul tests as a single executable,
test_dsp_mul.c, to reduce the number of test binaries.
Each opcode reports one TAP line.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/mipsel/test_dsp_mul.c               | 64 +++++++++++++++++++
 tests/tcg/mipsel/test_dsp_r1_muleq_s_w_phl.c  |  1 -
 tests/tcg/mipsel/test_dsp_r1_muleq_s_w_phr.c  |  1 -
 tests/tcg/mipsel/test_dsp_r1_muleu_s_ph_qbl.c |  1 -
 tests/tcg/mipsel/test_dsp_r1_muleu_s_ph_qbr.c |  1 -
 tests/tcg/mipsel/test_dsp_r1_mulq_rs_ph.c     |  1 -
 tests/tcg/mipsel/test_dsp_r2_mul_ph.c         |  1 -
 tests/tcg/mipsel/test_dsp_r2_mul_s_ph.c       |  1 -
 tests/tcg/mipsel/test_dsp_r2_mulq_rs_w.c      |  1 -
 tests/tcg/mipsel/test_dsp_r2_mulq_s_ph.c      |  1 -
 tests/tcg/mipsel/test_dsp_r2_mulq_s_w.c       |  1 -
 tests/tcg/mipsel/meson.build                  | 11 +---
 12 files changed, 65 insertions(+), 20 deletions(-)
 create mode 100644 tests/tcg/mipsel/test_dsp_mul.c

diff --git a/tests/tcg/mipsel/test_dsp_mul.c b/tests/tcg/mipsel/test_dsp_mul.c
new file mode 100644
index 000000000000..4d1127c05b1f
--- /dev/null
+++ b/tests/tcg/mipsel/test_dsp_mul.c
@@ -0,0 +1,64 @@
+/*
+ * MIPS DSP ASE tests: Multiply instructions
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "test_dsp_runner.h"
+
+#define main test_dsp_r1_muleq_s_w_phl
+#include "test_dsp_r1_muleq_s_w_phl.c"
+#undef main
+
+#define main test_dsp_r1_muleq_s_w_phr
+#include "test_dsp_r1_muleq_s_w_phr.c"
+#undef main
+
+#define main test_dsp_r1_muleu_s_ph_qbl
+#include "test_dsp_r1_muleu_s_ph_qbl.c"
+#undef main
+
+#define main test_dsp_r1_muleu_s_ph_qbr
+#include "test_dsp_r1_muleu_s_ph_qbr.c"
+#undef main
+
+#define main test_dsp_r1_mulq_rs_ph
+#include "test_dsp_r1_mulq_rs_ph.c"
+#undef main
+
+#define main test_dsp_r2_mul_ph
+#include "test_dsp_r2_mul_ph.c"
+#undef main
+
+#define main test_dsp_r2_mul_s_ph
+#include "test_dsp_r2_mul_s_ph.c"
+#undef main
+
+#define main test_dsp_r2_mulq_rs_w
+#include "test_dsp_r2_mulq_rs_w.c"
+#undef main
+
+#define main test_dsp_r2_mulq_s_ph
+#include "test_dsp_r2_mulq_s_ph.c"
+#undef main
+
+#define main test_dsp_r2_mulq_s_w
+#include "test_dsp_r2_mulq_s_w.c"
+#undef main
+
+int main(void)
+{
+    TAP_START();
+    RUN_TEST(test_dsp_r1_muleq_s_w_phl);
+    RUN_TEST(test_dsp_r1_muleq_s_w_phr);
+    RUN_TEST(test_dsp_r1_muleu_s_ph_qbl);
+    RUN_TEST(test_dsp_r1_muleu_s_ph_qbr);
+    RUN_TEST(test_dsp_r1_mulq_rs_ph);
+    RUN_TEST(test_dsp_r2_mul_ph);
+    RUN_TEST(test_dsp_r2_mul_s_ph);
+    RUN_TEST(test_dsp_r2_mulq_rs_w);
+    RUN_TEST(test_dsp_r2_mulq_s_ph);
+    RUN_TEST(test_dsp_r2_mulq_s_w);
+
+    return tap_done();
+}
diff --git a/tests/tcg/mipsel/test_dsp_r1_muleq_s_w_phl.c b/tests/tcg/mipsel/test_dsp_r1_muleq_s_w_phl.c
index b3a5370fe59e..e9b0dc55071b 100644
--- a/tests/tcg/mipsel/test_dsp_r1_muleq_s_w_phl.c
+++ b/tests/tcg/mipsel/test_dsp_r1_muleq_s_w_phl.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_muleq_s_w_phr.c b/tests/tcg/mipsel/test_dsp_r1_muleq_s_w_phr.c
index 8066d7d02a1e..a8238c673293 100644
--- a/tests/tcg/mipsel/test_dsp_r1_muleq_s_w_phr.c
+++ b/tests/tcg/mipsel/test_dsp_r1_muleq_s_w_phr.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_muleu_s_ph_qbl.c b/tests/tcg/mipsel/test_dsp_r1_muleu_s_ph_qbl.c
index 66a382806a21..ce16164bc853 100644
--- a/tests/tcg/mipsel/test_dsp_r1_muleu_s_ph_qbl.c
+++ b/tests/tcg/mipsel/test_dsp_r1_muleu_s_ph_qbl.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_muleu_s_ph_qbr.c b/tests/tcg/mipsel/test_dsp_r1_muleu_s_ph_qbr.c
index 4cc6c8f7cfe1..2baedb9f53a5 100644
--- a/tests/tcg/mipsel/test_dsp_r1_muleu_s_ph_qbr.c
+++ b/tests/tcg/mipsel/test_dsp_r1_muleu_s_ph_qbr.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r1_mulq_rs_ph.c b/tests/tcg/mipsel/test_dsp_r1_mulq_rs_ph.c
index 370c2a801832..bd2ab49b0717 100644
--- a/tests/tcg/mipsel/test_dsp_r1_mulq_rs_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r1_mulq_rs_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_mul_ph.c b/tests/tcg/mipsel/test_dsp_r2_mul_ph.c
index c7e9d60d12e2..bb92f6cbc0f1 100644
--- a/tests/tcg/mipsel/test_dsp_r2_mul_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r2_mul_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_mul_s_ph.c b/tests/tcg/mipsel/test_dsp_r2_mul_s_ph.c
index 33da110de869..092dd531f421 100644
--- a/tests/tcg/mipsel/test_dsp_r2_mul_s_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r2_mul_s_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_mulq_rs_w.c b/tests/tcg/mipsel/test_dsp_r2_mulq_rs_w.c
index 7ba633bc17f7..f94c1678af09 100644
--- a/tests/tcg/mipsel/test_dsp_r2_mulq_rs_w.c
+++ b/tests/tcg/mipsel/test_dsp_r2_mulq_rs_w.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_mulq_s_ph.c b/tests/tcg/mipsel/test_dsp_r2_mulq_s_ph.c
index 00e015542e69..8c944c6ea3fa 100644
--- a/tests/tcg/mipsel/test_dsp_r2_mulq_s_ph.c
+++ b/tests/tcg/mipsel/test_dsp_r2_mulq_s_ph.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/test_dsp_r2_mulq_s_w.c b/tests/tcg/mipsel/test_dsp_r2_mulq_s_w.c
index 9c2be06cc08a..caa8e8d76193 100644
--- a/tests/tcg/mipsel/test_dsp_r2_mulq_s_w.c
+++ b/tests/tcg/mipsel/test_dsp_r2_mulq_s_w.c
@@ -1,5 +1,4 @@
 #include<stdio.h>
-#include<assert.h>
 
 int main()
 {
diff --git a/tests/tcg/mipsel/meson.build b/tests/tcg/mipsel/meson.build
index c26f5fba06b7..4991c14b7bf8 100644
--- a/tests/tcg/mipsel/meson.build
+++ b/tests/tcg/mipsel/meson.build
@@ -9,13 +9,9 @@ tests_dsp = [
   'test_dsp_cmp.c',
   'test_dsp_ctrl.c',
   'test_dsp_dot.c',
+  'test_dsp_mul.c',
   'test_dsp_r1_bitrev.c',
   'test_dsp_r1_insv.c',
-  'test_dsp_r1_muleq_s_w_phl.c',
-  'test_dsp_r1_muleq_s_w_phr.c',
-  'test_dsp_r1_muleu_s_ph_qbl.c',
-  'test_dsp_r1_muleu_s_ph_qbr.c',
-  'test_dsp_r1_mulq_rs_ph.c',
   'test_dsp_r1_packrl_ph.c',
   'test_dsp_r1_preceq_w_phl.c',
   'test_dsp_r1_preceq_w_phr.c',
@@ -53,11 +49,6 @@ tests_dsp = [
   'test_dsp_r1_shrlv_qb.c',
   'test_dsp_r2_append.c',
   'test_dsp_r2_balign.c',
-  'test_dsp_r2_mul_ph.c',
-  'test_dsp_r2_mul_s_ph.c',
-  'test_dsp_r2_mulq_rs_w.c',
-  'test_dsp_r2_mulq_s_ph.c',
-  'test_dsp_r2_mulq_s_w.c',
   'test_dsp_r2_precr_qb_ph.c',
   'test_dsp_r2_precr_sra_ph_w.c',
   'test_dsp_r2_precr_sra_r_ph_w.c',
-- 
2.55.0


