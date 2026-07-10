Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93C44C44507
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:21:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4bF-00010l-Kk; Fri, 10 Jul 2026 02:20:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4b9-0000sC-4t
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:20:31 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4b6-0004Pb-St
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:20:30 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3nTpX3848810
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:20:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 aK9swL6vwyKwSK4D5tGpDTTFSSnYRhez7T4ukB3lE0o=; b=h1feg2FnxdLEVJB9
 5DHHQd5zfCV/RbONjx/jeeM2Se2TcIOfcetWITKs+ZhmTbstkBbWiBucd8TJkGBZ
 gM82yH7y57FTDUnbNoacy0H9rJ/RYO4f9BJxz2QqsjDznmN6Ig2zMql8ov/jcVis
 7KvgLUKcSpg0xZnXm3W/dTh6VYNCBRg6rQk9GM7Glt1sm56i1XPYhl+2n3zCuCfd
 KMTsNjoXlTalRw5IZaxnMDDe2K+TUxR5VszZMY6Be7DFJdLQ4sF3UbyJkVpIxBmK
 eSQjSMp5BfOgvjtAsRs01Eb9b/IsWutQ9BotTeGuR7KWGeOxgFtGgLrRYJ2z8jXM
 EKYWpg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faeesu27a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:20:26 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c890bac374eso1047808a12.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783664425; x=1784269225; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=aK9swL6vwyKwSK4D5tGpDTTFSSnYRhez7T4ukB3lE0o=;
 b=cr7vXP++c6EFUm67fUdMF1M7KjnDAUFHZwq3i2Lx/HQg1w4zsexoa+1Rxr01epRu2m
 fyT0nlvwtyC4TOkybZ9Nd9op6Snbi4i4XTaYSpbu4Y7r/ltmn7yGAxgSnH+mFBoEnAbe
 CX+ENV/K5qdpWTnQ9ts0p1X6uurVEbqPrN+C5U5Fozn2R2eBXN2TiC3t0m55UKCO9KtI
 xp+5G0DJ7ZumtpJtDfrOp7869CYj9HqJHKM7MSXdF31a/+VJtxJGhZ623wrWr2VplwH1
 tIIBp+M+qdu2t+V4EuNL/19c6KGqMBm2iJ8ZI6Voo0wYz3O55k/UMLY4mC8ycgLIjFuh
 8Alw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783664425; x=1784269225;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aK9swL6vwyKwSK4D5tGpDTTFSSnYRhez7T4ukB3lE0o=;
 b=a66Ksas2QFIcLilzYX3EyjR1TgH+t89Kzjwl+JMYyEU+yQKrleprFkFxvTVyf3nqaC
 Q/Oxs9i4+JO0La25tSroeOw0KS4Sn/k4e3EvNylGqJNgUi8q1PSCMxU8tLadJtgODeHn
 CFaS+Fk5gmSlw2YC+/Yvp8eIMj8rfiFL3ubq7G8q/ok1dDnuhxt9qmr3gg7gm2/QycFx
 9bV2NMl8rE1f+w44rerQ55aRRp3c+oFEY1zhtdyweKH9eWbcXA9G9FRnNscXa3PBqcRa
 4AJefBq03UXgp4kFq5CGX8wazQ6T9izH8j8P6RWp2kFL6TyTlBBzdgIBuJBmdyvCtVbx
 pgmQ==
X-Gm-Message-State: AOJu0YzAM4cq7gF+uLXsuCX4mncRBRi8Oe9bGfhNPlZnYvjsvIaDEu/p
 5HAJKzq4uiPTk1wfK0M86umlCPC0XE/hVK9mu7B9hSUSU+L5t5RWFjduVw5flvZs0xbqmcgBTHJ
 0u5UooAdf5EPBTOIWIcYyK2jW0YmsH06GuH+3fqLeUotoU+RqboQPaM6d9NHRHwYOqA==
X-Gm-Gg: AfdE7ckpd0I1OsfMnWgRPFMG0WZm4WhOfr0WjSfHUd76W9MY11//6tqRL2EiiK+CDmz
 UUlnNhp8xTfAHY9Q/IwAMfIacJvxJ0wiypujOWPIsKc5DD39mpMzfJqD8bePX4k/elWy9BAWOAW
 YEztc7+LlvG9ISChftkrzYGQ+oO0HrLlWXRpFbeURGRJCz1ayNAuvjExz1O2syD4brkUxwl83FP
 XBA3LnNmqPDbeD+R6avq1M2Ey0q0o2JQqFOEbV9nXUqtNU5+3fMDHYFXCn1pl92zSsyiMPcBCup
 4K8CbhK0eAPMfvvbH+/Cqk2S2fhqzWuOiQ7/XszDNeDoeLwAqT/3oOZDmCgsF2WNJsrbuiJ+57Y
 gHj5dzHHhYSTZFDYIbb3Px508c3lDPlUnFFKy5LUbZyw8M4d7K++LlZDeS7rIKyT5MBJLHl4jdi
 O9Q9mYLg==
X-Received: by 2002:a05:6a21:60c6:b0:3b8:58c:97b8 with SMTP id
 adf61e73a8af0-3c0bc9b0971mr13209858637.22.1783664425309; 
 Thu, 09 Jul 2026 23:20:25 -0700 (PDT)
X-Received: by 2002:a05:6a21:60c6:b0:3b8:58c:97b8 with SMTP id
 adf61e73a8af0-3c0bc9b0971mr13209820637.22.1783664424867; 
 Thu, 09 Jul 2026 23:20:24 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659fa13bsm35428126c88.15.2026.07.09.23.20.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 23:20:24 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Helge Deller <deller@gmx.de>, Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v4 01/97] tests/tcg/multiarch/system/memory.c: remove unused
 variable
Date: Thu,  9 Jul 2026 23:18:39 -0700
Message-ID: <20260710062016.1818125-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: K4abAIz3ttlLYx8oMlf4Y97DVExZIp6E
X-Authority-Analysis: v=2.4 cv=bbpbluPB c=1 sm=1 tr=0 ts=6a508f2a cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=wOKWSiVmv2u3Qo4ObykA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA1OCBTYWx0ZWRfX3MZU0qNpNC1r
 tV6kJVgOjpmmyhYz79g+PqKpRqkORzsMsp7FT0I6GrDyMCQXSmkqeRd1wwnIYXSYTMCXzqKiwlA
 rlRC1CD1cKvNvJ81203BVws8gbSNHao=
X-Proofpoint-ORIG-GUID: K4abAIz3ttlLYx8oMlf4Y97DVExZIp6E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA1OCBTYWx0ZWRfX6DUvx8NHvHXy
 oG6xSDAZQ05o1h74mNkkaYfYvSlPXJxv6nkpMSYqX6VNKA1hhGBF3uaboC0PpgI9OyQ0xZZ8Oqp
 SOBAs8FBXGjs2NBIQpa6myN1f0sgpXkY1TV2qyka25o9sy+4lVjRU9C62Et8l0ziNLmNGHvkVN5
 vZIweGj1eSgNkptQxD+dh1Q3TwaVaFu/f8U6/nRj9/dp7K84gQCR0+Z0/Q8PgATepyFdIwJQf5e
 9bnRhCiEKRqQGILXbWt0W3OJtTZp5DIuMMH1NfAf+4PIV/cIilAOcbqjSPPtNyROd9Ivedl2L3U
 kN6qSwYUECDPsKYu2rr1jOPlpZhwwfbCmWrLU9TWacOEO1AvTYF91phVt57f5YZ8gw6Ou0eQXp8
 lAd/UdT/2CoGwj7qS5rZrUidyqeiQNSXsLLvcqCSvVSOenbW1qMhmTMy1oDbUNemi3VZF6TVdDM
 zi3U6V0d+tOlA9zaVTw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 suspectscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100058
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Caught this since by compiling this file with -Wall, -Werror.

../tests/tcg/aarch64/system/../../multiarch/system/memory.c: In function ‘init_test_data_s8’:
../tests/tcg/aarch64/system/../../multiarch/system/memory.c:97:18: error: unused variable ‘bottom’ [-Werror=unused-variable]
   97 |     uint8_t top, bottom, *ptr = &test_data[0];
      |                  ^~~~~~
../tests/tcg/aarch64/system/../../multiarch/system/memory.c:97:13: error: unused variable ‘top’ [-Werror=unused-variable]
   97 |     uint8_t top, bottom, *ptr = &test_data[0];
      |             ^~~
../tests/tcg/aarch64/system/../../multiarch/system/memory.c: In function ‘read_test_data_s8’:
../tests/tcg/aarch64/system/../../multiarch/system/memory.c:384:14: error: unused variable ‘ok’ [-Werror=unused-variable]
  384 |         bool ok;
      |

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/multiarch/system/memory.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tests/tcg/multiarch/system/memory.c b/tests/tcg/multiarch/system/memory.c
index 7508f6b916d..adc7ac60c1f 100644
--- a/tests/tcg/multiarch/system/memory.c
+++ b/tests/tcg/multiarch/system/memory.c
@@ -94,7 +94,7 @@ static inline uint8_t get_byte(int index, bool neg)
 
 static void init_test_data_s8(bool neg_first)
 {
-    uint8_t top, bottom, *ptr = &test_data[0];
+    uint8_t *ptr = &test_data[0];
     int i;
 
     ml_printf("Filling test area with s8 pairs (%s):",
@@ -381,7 +381,6 @@ static bool read_test_data_s8(int offset, bool neg_first)
 
     for (i = 0; i < max; i++) {
         int16_t first, second;
-        bool ok;
         first = *ptr++;
         second = *ptr++;
 
-- 
2.47.3


