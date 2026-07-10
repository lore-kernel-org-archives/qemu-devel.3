Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EF82C44501
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:44:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJ0w-0004pw-C7; Fri, 10 Jul 2026 17:44:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ0u-0004pZ-Pq
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:44:04 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ0t-0003Mg-2z
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:44:04 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AK3VKs1714048
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:44:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 aK9swL6vwyKwSK4D5tGpDTTFSSnYRhez7T4ukB3lE0o=; b=L0phA1T05wI7CZFm
 dpFYTZN7xZBp0PHq6WpyIsci6r1FjJ8UTK9jgCeImwo/KFsr0y6+sdLIXfqnqu6S
 Megbp7MvAiwzTZ9UF3y4seJHWO9mT/8yYP6hqQKaYO6MOUd5ILIwUI6SRAG1PjtW
 1HthUDqygFkFYlK91Jr/sZftghMycxsQfULPYyvRY015PuiGqghs2nnD+kgT1b2V
 AI63zZd43mykH4tOHRJOCwNwa4qPHI/I1U2gTjbuQCSitKTC0HQppnr328w11kx1
 z71p9bJRK8awxO99lSmtx97YzCel807Wkmq7JeUTJr+A0HIRVWXJEtgRPk+tRg5I
 14Hkdw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb339s9gg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:44:00 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-848568a6f62so2239018b3a.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783719840; x=1784324640; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=aK9swL6vwyKwSK4D5tGpDTTFSSnYRhez7T4ukB3lE0o=;
 b=eD3NylMUJZw3qq1DCOEBwrqNrxBqMqun9e/TtHN6mCrrF32QXO0vg707sCelVlhZf1
 +ZyIlFwmcHGxZCi48RDKw+JIBQeUUN6Jj8HVzgq+L0GIvYE307gkVHDyoKEAZw3yQcAi
 ZY8L5YQKjzPNM+SWzGU1tG4hAc2YmGXl5InbnMcIxWUvQ05NBG3lqf6KELD1CAo8kmMT
 /LFcCJ2rBuh0CnSQaV7w65rxUi880L1MxX8ZubrRewlMpIVp1SyFiOrDBB1j+i7AtkSS
 lcwnhhYWH9vrXS9x771021iXzE/0bu7NWJJ9MMc2ksNYFXVcBhWub/uJiKIPqICP7Ipq
 xn1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783719840; x=1784324640;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aK9swL6vwyKwSK4D5tGpDTTFSSnYRhez7T4ukB3lE0o=;
 b=LXbn99L4N6BWw+TAQg9lynvnXhBOMUQFEdssB5GuQtbGS8MP5iAQO0Ej5SS/DNzN0D
 tfTUNKlOgfg4/k7NnNRrkb8Lsd+qP1Gkx8p2KZ0tqDavOXg2zrqPdOkzru3uQNFdV1cS
 kqXEMv+3lhha0Olt78c64ea+4Ta/NaUkS5T/jTKP8OsotgGttx9Z+Q+ggDuT3x/NsCKR
 ZFFJiUGmuC7qPOTwY6wGfoB5hp2Px39wSYoQYRC2Cp8J8bvaCe/rKbTogfMUyJN2eQbG
 x/14jQTsarZogxR5MHMcvU1HMuocBfDsrDWFoiItIlhQZvxrGXmElFVJ4n3B3kQwhAKT
 UVuw==
X-Gm-Message-State: AOJu0Yw2uJJEKQPq9DQ9vFcs4ku4bsV0ywghvbKfNrWHKAMokSkLIUkM
 Olkgn2rceD1tUxf3pgXySFB3IjbJH0KxE7xHiEgFwxBwwgSZqgZTFQIYHFboqv0JR4hOxG5/lXf
 HesR3Btp7X4g36BhAyBD10+hOOqNal6HAByB/xeuz0JTUAfZ4oLtRAjD/yzYF7CiRkA==
X-Gm-Gg: AfdE7cmEciGKaS4JMTcJU4M1/GcYzemFbO4PZj+qnjOz69XM5RvXhGhjyMIgSgQKU9m
 5Qfq3l2sWbyjCtw0BrIYTekqiceZOxqvHqqLy/WO1uC5vhCOim5kl8qCklv9rehwz8r6qzsKg8A
 b56prj7vl1Koxz8viV7/H/wZLNSAK2+/OG/J9Noyqy9t9vlrFKhuM8Y44u4+2iD33nFFnlON9Uk
 KKLIQOl+AcXgeGTnXHNsr9/rdj3TwYLs25UnKN+R/bn1auqXCyn8COyCuTv/OFLLDe2jb3QPx0/
 Fl+uEN3netM79if5uEcvKGfToYSvE099PldB52JKnICLJO+oO7sU3vrz8AI04UTKfHWeqQ0RdeB
 1lQvDT4+1/nSX05E6aQNygYz43gVLqayev8FylQc5Jog8Lah9IFwu45ZQ9vWYYj5VxQhWKeUQgU
 EIblO7Fg==
X-Received: by 2002:a05:6a20:da1a:b0:3b4:9171:2573 with SMTP id
 adf61e73a8af0-3c110be6d93mr695368637.37.1783719840342; 
 Fri, 10 Jul 2026 14:44:00 -0700 (PDT)
X-Received: by 2002:a05:6a20:da1a:b0:3b4:9171:2573 with SMTP id
 adf61e73a8af0-3c110be6d93mr695344637.37.1783719839864; 
 Fri, 10 Jul 2026 14:43:59 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659c8665sm43539840c88.10.2026.07.10.14.43.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:43:59 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>, Helge Deller <deller@gmx.de>
Subject: [PATCH v5 01/98] tests/tcg/multiarch/system/memory.c: remove unused
 variable
Date: Fri, 10 Jul 2026 14:42:05 -0700
Message-ID: <20260710214343.2065491-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIxOCBTYWx0ZWRfX26zstIDNSAsf
 iEP37Q5N0WJ7iZs44EH4dO59WvmtuKZFB42EwRv29JpB358ZVdkpULSs0+crNmZU6tIZVJrNlxU
 BYgMjwNwa66syycHykL5kD5uzjF0egs=
X-Authority-Analysis: v=2.4 cv=Re6gzVtv c=1 sm=1 tr=0 ts=6a5167a1 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=wOKWSiVmv2u3Qo4ObykA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: NQDuGcAF1HBhyHcSmSPhqPGR4a6glUz8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIxOCBTYWx0ZWRfXxZ+QBcF2NTc8
 bWRupztq9jJe1bXplui12vdOn1D49npFvgx6ivsTAquOMJUsps2xoTrkT+LSCZPM0dsCAwwOpwU
 0twk9hka4ybzM5WjHbjtm5PNsJOs2y6hzjG1n9IoKEhy2sRG13jfK9bIXlWcekdmgg0us2ZHukc
 b6OXgxyH/s1v+qBOrzpJcwR631PiMGadMbpqwrAyMJ2F13cWlTddrfyvMc0rE3oB+lA4U8PPmqN
 HrwUBO7WH5dXXoFAwtqZjI+0jW83jX3rvgHrYQHxYXVwEPLolunDum8CLZcQ/A2su7HxFd9O9Wi
 mbLKoaHrJ1hDczHKlgV8gJbDOcLQpnNdqIWLu9zClgAtfz8bwaUAEzPl5eBiieMYnS7IIcP0EWJ
 5n0NH3N6otWDLWM9T0OgWWtEpQMaRoL70Kkylj/bFSdZ+YrDY9qak7NPnkBwekQcb0fMUu24aME
 tNgUXb4BvEVmLc/mtzA==
X-Proofpoint-GUID: NQDuGcAF1HBhyHcSmSPhqPGR4a6glUz8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100218
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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


