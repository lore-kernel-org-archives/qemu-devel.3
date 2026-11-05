Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE69606D831
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 12:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pIpaCi1t;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kAFgTDBt
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOwxg-0002sS-HL; Thu, 05 Nov 2026 07:53:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xOwxS-0002qO-Ov
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 07:52:46 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xOwxQ-0005hh-4k
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 07:52:46 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A59tKMe4084474
 for <qemu-devel@nongnu.org>; Thu, 5 Nov 2026 12:52:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 r8cbebLCAezKzqo21AD8WKBJcS2oxVy06oRDOWLIWgc=; b=pIpaCi1tNbSWPuiB
 +CEoDQRJW9+uRkaGLdqnNXFYkEoBXaYZsRH6Vp9SbbuIilus0oPqE//ZpIQDcwSA
 GiGmXWpubOFYYSvqtSc3a/NPVzIQDs3VFQ8PePgFv/dB7TIwcdVY8q/K7tod63Mj
 33VDh3XvF0cracHMl7QIV2dyH+3j/SFf8U99yHk4AeQW6e7R6d2r84d8pyArc2Gk
 VFUip1C6uY5ztstDBAj4ovm6sima3s/xl2OS3GPfSL2c509vlsaDd0A6IRNR4TxY
 eFBdT54zuhLCIdbyzIHxbDyy9QaRGj5sm9ABakykvYsR0uqIi7qaa9yr05DLxyuS
 TASKpg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrqhkrq1v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 12:52:32 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f1f2fafeaso274565485a.2
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 04:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793883151; x=1794487951; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=r8cbebLCAezKzqo21AD8WKBJcS2oxVy06oRDOWLIWgc=;
 b=kAFgTDBtebFwi+D1hAQAfnWFd6bQMv9C92f6EP0+kqDjw8UWG7JfYMaKyB6mjmqB1c
 6GBG2OS4uOTQBkDaa0OrAyslSuQ9Yu3zd9B1XwCRy+Xexstw2uWJ9Xb5VVc5PSLSxGvk
 9YZwG54Z/1F7r7TA9herAckIWjp83qVEuJ3NW1JVLKieSiXqJPg+ShNd7ytJonOT/RdQ
 oHvv8qRw3y/D/J7HcfE+UdNc3Uikr346SywMVrethR+taKGJzZXDviPrrg4z5R7r+Shy
 xTyCD0TGDxCzZU/yyjYClaehBjohQuQXRWhfTvp0e9BT/Yr3VYI4VuVPPkTBFFTtCzfV
 DAMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793883151; x=1794487951;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=r8cbebLCAezKzqo21AD8WKBJcS2oxVy06oRDOWLIWgc=;
 b=2PAmT8kM7heMVgb4lIEjmTbwHlCaaon7PpBKpNVSm98yDAGXykD9tQH8P1Ei+lbnST
 twDT0asf2Dyt3NB8tKH8qlwyX8Zf2EkOgrJL0gVwbIpR1lckXI/vF1eDk9oPFyArdivF
 0pxoVvQKFYV8uHWJhpu7FWKdSmusn0BrlE/AnWRONZUOghvcu1vTfD8WN+fUHkf/PPaf
 hb79hGod7tB6qLkURQPiMed3X8h/Jqf7qbP/4xMoX7hL6d7xXQMj6ZG7ceWgKoY4Y3Lt
 dCWDvCOvF8pb3VTh4gwFv2varwpS9eBs4t0PzksDENosp6cjJajPBdHJQ2/jHue3wNBl
 fLaw==
X-Gm-Message-State: APuU4Z8tVwfF+aWffhXlbRd1RGljXoM31MSRY9Exq6Blp5fYmab6BjSr
 Xrh2/NI6gMKK3M7wjbCEi9dVElbQu1O5AQeaCJdXQXqweL6Z1p1f8BqomEzYGHUvhTXkgCbJAnD
 B4V5eCeQ5Iyw+D0/U6XGHVUaHcTN/wZkNb9gcsRoXBa5U+gzuS60etOaV1jOR4JOVoQ==
X-Gm-Gg: AYBFou1oySr0kUV7VqN+af8i8KB8TSJmiox5K0Hrmmou5Yevp+kq8eM1TDrCIxtexph
 cPsjeVRi8BOdBybtzfSe6JtUB4zLtY3k17sjvKiIkfHPpXrlYX8ER7HthUX+na+NLwfa4URhh46
 6cuVNsgOKQEBwQ4YXbrQBdBagZ0N4x+I5llD2bnitomYZ/sBJzQ0DLTiquMO98nvnXqB9ZtHp8+
 q4PWU/XS3W6UnzbMBTv9SmUu/voirOR92b2v0RA392aeV6soEHneRLv1jDSgygcxTOS+uhVbfTN
 QqUVnnKOJ/TZKw0MixgKsXvBeimLmxAC7p7FxyNqyiPbsCcS291qJrrQXNJDLcfjJlPzvi5F+f1
 4zxSMuPbazR0vAcGaAMllIRNpkTIndI1E6qJN+tRqUEwwdNPQsCPdAuxh1zLc5CQjjWPEl869HA
 t4Xu4RKqVtyEWKd3WLxN23Z+TDtuNAzg==
X-Received: by 2002:a05:620a:3188:b0:93f:2ab9:728c with SMTP id
 af79cd13be357-94421758732mr3271153485a.71.1793883151398; 
 Thu, 05 Nov 2026 04:52:31 -0800 (PST)
X-Received: by 2002:a05:620a:3188:b0:93f:2ab9:728c with SMTP id
 af79cd13be357-94421758732mr3271150585a.71.1793883150915; 
 Thu, 05 Nov 2026 04:52:30 -0800 (PST)
Received: from localhost.localdomain (104.171.88.92.rev.sfr.net.
 [92.88.171.104]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b55ac925c2sm1679124a12.34.2026.11.05.04.52.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 05 Nov 2026 04:52:30 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 02/17] tests/qtest/npcm7xx: Replace deprecated sprintf()
 with g_strdup_printf()
Date: Thu,  5 Nov 2026 13:51:47 +0100
Message-ID: <20261105125203.40320-3-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261105125203.40320-1-philmd@oss.qualcomm.com>
References: <20261105125203.40320-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA1MSBTYWx0ZWRfX4RPw8eGZCulh
 JaLtQGN4j6Sy+0rVDTDeAV/ZcROIeZO4eRXZr20OR+4MZtEZvCLvALIc/8bpj64iSWd4r4btbYR
 XdmpqqU1rkXsLDjDR08Op6uitP0/aEnVaoMURTpaTVlm29YpT/LPIyJYUqlMcxoJSg0fiTzFuoc
 iOFjQWZFwhzYgTf6J7R5l5YeEcU8HKyLiTGOZHD5plYMjYNbRuAA5IXX68HcWwBYCF+uXX12q0a
 R8nEeNNdI+tRkH/TPP1MkM1xJ3Qp7eGidSG9a2iu0t01g5xrHyeiS/N7A+FTi1TxHrARFlFSyNW
 G3lBQLFtftDcAdWr9j8pL3aqY2PeOaaFmgqgI8ndFH6PrnNS3DR9PHXkF8ituttYDfB5yPenhY2
 UAy6rdU3TvyfES1zrgG+1fprZBCyBsJl0FUCGDg+plxbHuwzIshvaYZ96MJVsTyPPBLtqac6OJ3
 R12RlGMTWiiCLVoXW6g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA1MSBTYWx0ZWRfX+jAphsRiMtwo
 UQU7/BhCJfyLzCbSIRyg0JxVnbzMY6MVV8c28LWU9BoZtNSyLM5cJDDYdYBFlwceQuCjKMH7BVD
 ECkgYZz8zRB789IOLSOqfH540FgDtpE=
X-Proofpoint-ORIG-GUID: UGrj08v9f6dQxCPFN-S2cKIgAidsnUID
X-Authority-Analysis: v=2.4 cv=a4+lZkSF c=1 sm=1 tr=0 ts=6aec7c10 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=pBdeej1U2jlWEHTh2vTwjw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=oaMw_JJsXAdkk1pLVOMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: UGrj08v9f6dQxCPFN-S2cKIgAidsnUID
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 spamscore=0 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050051
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Replace sprintf() by safer g_strdup_printf() to fill the QOM path
and property names. This silences when using Apple clang 17.0.0:

  ../tests/qtest/npcm7xx_adc-test.c:140:5: warning: 'sprintf' is deprecated [-Wdeprecated-declarations]
  ../tests/qtest/npcm7xx_adc-test.c:322:9: warning: 'sprintf' is deprecated [-Wdeprecated-declarations]
  ../tests/qtest/npcm7xx_pwm-test.c:244:5: warning: 'sprintf' is deprecated [-Wdeprecated-declarations]
  ../tests/qtest/npcm7xx_pwm-test.c:245:5: warning: 'sprintf' is deprecated [-Wdeprecated-declarations]
  ../tests/qtest/npcm7xx_pwm-test.c:255:5: warning: 'sprintf' is deprecated [-Wdeprecated-declarations]
  ../tests/qtest/npcm7xx_pwm-test.c:256:5: warning: 'sprintf' is deprecated [-Wdeprecated-declarations]

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 tests/qtest/npcm7xx_adc-test.c |  8 ++++----
 tests/qtest/npcm7xx_pwm-test.c | 14 ++++----------
 2 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/tests/qtest/npcm7xx_adc-test.c b/tests/qtest/npcm7xx_adc-test.c
index 8bc89b8a8b9a..85915d6f1243 100644
--- a/tests/qtest/npcm7xx_adc-test.c
+++ b/tests/qtest/npcm7xx_adc-test.c
@@ -135,9 +135,8 @@ static void adc_qom_set(QTestState *qts, const ADC *adc,
 static void adc_write_input(QTestState *qts, const ADC *adc,
         uint32_t index, uint32_t value)
 {
-    char name[100];
+    g_autofree char *name = g_strdup_printf("adci[%u]", index);
 
-    sprintf(name, "adci[%u]", index);
     adc_qom_set(qts, adc, name, value);
 }
 
@@ -316,10 +315,11 @@ static void test_calibrate(gconstpointer adc_p)
             adc_calculate_output(R0_INPUT, iref),
             adc_calculate_output(R1_INPUT, iref),
         };
-        char buf[100];
+        g_autofree char *buf = g_strdup_printf("-machine quanta-gsj"
+                                               " -global npcm7xx-adc.iref=%u",
+                                               iref);
         QTestState *qts;
 
-        sprintf(buf, "-machine quanta-gsj -global npcm7xx-adc.iref=%u", iref);
         qts = qtest_init(buf);
 
         /* Check the converted value is correct using the calibration value. */
diff --git a/tests/qtest/npcm7xx_pwm-test.c b/tests/qtest/npcm7xx_pwm-test.c
index 052ea876621a..400d44f424e1 100644
--- a/tests/qtest/npcm7xx_pwm-test.c
+++ b/tests/qtest/npcm7xx_pwm-test.c
@@ -238,22 +238,16 @@ static uint64_t pwm_qom_get(QTestState *qts, const char *path, const char *name)
 
 static uint64_t pwm_get_freq(QTestState *qts, int module_index, int pwm_index)
 {
-    char path[100];
-    char name[100];
-
-    sprintf(path, "/machine/soc/pwm[%d]", module_index);
-    sprintf(name, "freq[%d]", pwm_index);
+    g_autofree char *path = g_strdup_printf("/machine/soc/pwm[%d]", module_index);
+    g_autofree char *name = g_strdup_printf("freq[%d]", pwm_index);
 
     return pwm_qom_get(qts, path, name);
 }
 
 static uint64_t pwm_get_duty(QTestState *qts, int module_index, int pwm_index)
 {
-    char path[100];
-    char name[100];
-
-    sprintf(path, "/machine/soc/pwm[%d]", module_index);
-    sprintf(name, "duty[%d]", pwm_index);
+    g_autofree char *path = g_strdup_printf("/machine/soc/pwm[%d]", module_index);
+    g_autofree char *name = g_strdup_printf("duty[%d]", pwm_index);
 
     return pwm_qom_get(qts, path, name);
 }
-- 
2.55.0


