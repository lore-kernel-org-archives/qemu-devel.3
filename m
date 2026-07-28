Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DBF1C54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:43:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZej-0004AB-IX; Tue, 28 Jul 2026 00:43:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZeh-000492-9W
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:43:03 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZef-00018L-D9
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:43:03 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S3afQj1303627
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:42:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 aK9swL6vwyKwSK4D5tGpDTTFSSnYRhez7T4ukB3lE0o=; b=Dwsi2XVEAuTEU5I/
 TXCVyqDo3DR+ivTZ3xHYcbwPy1le7q9huJ4z3yybPsENITT4vsD/+oOXy+Z9axZp
 TU63qUvve80pSd2gE359Zs1s+5ByQdFTN4NFyUhAcDzgU2+OaNOJEkOgHBrsCtmG
 X6blTnP9++VqxvWNU1VmuVi/2iotU5Ox628+qIvIg8h7lxv5qF84Cm7qSYXiUGtK
 /qjxns1j/wJqbof+VZi0PvJ3KU3tuTsaELxTbvrg2ILvyCVirLGKYxiNaQ5EEVDa
 kz9RFY0iXWz81X54c1aUzhhZU+iekc9o2YDZ2ONVjUaUMTE6WvUuuyT2jPFfz26u
 /tHoww==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpbp8afng-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:42:59 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cb6ef846b33so478234a12.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785213779; x=1785818579; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=aK9swL6vwyKwSK4D5tGpDTTFSSnYRhez7T4ukB3lE0o=;
 b=GoWkcxGVBBkQ8hE32eGVe5da6DxhyK3cYeul7Phw8+beZLuDM0l1qsV3lNkWWn2AUj
 k9lg9mMXiMWZYgyxy3fAzIktDBhJr6K0GncEehQSt6hOzEVIqUiz9jjKfrJ3LIEh6VW1
 +XGIiYgHAuM3Sc/ZbLzIzfOoo28LK5ntDZRwVS5J/GydyDixgSr6i00CMZT3YfBfjIic
 dKw87FQUFshrr3Ol/0sbDBaCYXswBL28y1vf9GcBUDvU61rdoovhwRwnJnw/ZIDqx0o5
 hj6gcwRfZAz5mCfogfY/XYAlrUfugAvb4Ej5jVE78bzuIulEhHWdGUnDNIHt4C4c/8m4
 u2Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785213779; x=1785818579;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aK9swL6vwyKwSK4D5tGpDTTFSSnYRhez7T4ukB3lE0o=;
 b=g1bb+EiKzQ/2CuTfz0HZyXirnWce2/o06N//q1kTjPtzedFORvwv7FhtGAvNdfFzF4
 /UMFqqxPkeq48ZCL57csMIakIPKHJE68/Uale++5Yc90aT5zSAL7eGtabzPgpAiEmUWC
 G/Cv+CNzZQpJqKCca9xi13fk1ZWv8/+5wlmO8TSHmFehdmyi93EEOlDjok2xbdc6N0la
 Kq+jZuLaE1UGoPsMHm8NOUjxXoIyCudiRBhk/Dnaw0zGsLQwqNEqG2BXQSbTFNDK8xjY
 zi4FwvDMRbsinlWEHl1gwgtL5bcH3UiXZZ2HCzyPXSuCNlrON2ld8013kxwKL5EUTwgk
 QI/g==
X-Gm-Message-State: AOJu0YxWXsTLYpJtknrv9w0i+TyF153CXwtd/3BkX53Isgrz3oQtS0e3
 aTwMNa4ZUv1Nan34QlYb6jpLic0VwA9pUf6K9VzaVzSuQ8TipIYvw2mNe13znKfbble6mNRXC68
 AI5abbrdimc7eDosMMNMjpjIlkd27jAOyzNmF5b8iz29mCu0yMkw3oyD748IJP9o7yg==
X-Gm-Gg: AR+sD12MgjGgzTwUNfoV3mrU0856ji32Ubsx2vaczXVHxH6sSUnhWI8xSWV/Lp+km+O
 4A1MZ/KgLcx0ScCmM1JP0BcPfXXeLB3pJMhcvYxDhpMDGpJBrZjSf+hL3ioxr6LT/Fxx8C+i7+H
 oVkYtMx+wKWZyxambglSwnhSQ3LsCTGUIIRJpZVFIi1PEjEjtAm798buu5tWN7q2WaVZQwlvuV9
 m/+V+wHDZx+PFfzFsIxVBaUKy27MHE3wzokbjsqnBn774YGrmzriuvLZImEJglyQK7karWNG72C
 0V7KPXl53Ou2g5krRWfSLFdTcj/FKey5j191QNBU7vbnUvfoHoNPYg0iGp/IxqOCPOIdTie5Rb7
 DRMvC0zvyxzY5XSM9yGKx59RWMPIvze421ilQD3FrGh+aVY8ljt42aCiFhh/2ShbuliEIskQ=
X-Received: by 2002:a05:6a21:6f8b:b0:3ba:d7b0:fcac with SMTP id
 adf61e73a8af0-3c8ab0d42f8mr1105960637.5.1785213778808; 
 Mon, 27 Jul 2026 21:42:58 -0700 (PDT)
X-Received: by 2002:a05:6a21:6f8b:b0:3ba:d7b0:fcac with SMTP id
 adf61e73a8af0-3c8ab0d42f8mr1105920637.5.1785213778340; 
 Mon, 27 Jul 2026 21:42:58 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc3e878esm38795784eec.3.2026.07.27.21.42.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 21:42:57 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v6 001/103] tests/tcg/multiarch/system/memory.c: remove unused
 variable
Date: Mon, 27 Jul 2026 21:41:05 -0700
Message-ID: <20260728044248.137626-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MCBTYWx0ZWRfX8EeG15ERV1hS
 8xHNr7tpUOvfrFAKg+EHnZliOxCxynwiOtvKGIGTx3f9SBmAAIvMyFyXAQfHsPfCk4j3KHXTXt+
 WYwsAhRzBWS6+RqCXnst8O0ir/wvvjs=
X-Proofpoint-GUID: Otwm0wBx6EvUZ1BY7Y-HlWJVeNLKGCtH
X-Proofpoint-ORIG-GUID: Otwm0wBx6EvUZ1BY7Y-HlWJVeNLKGCtH
X-Authority-Analysis: v=2.4 cv=KLJqylFo c=1 sm=1 tr=0 ts=6a683353 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=wOKWSiVmv2u3Qo4ObykA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MCBTYWx0ZWRfX503FiOejeLgJ
 mmi8T47Nzo81JqZZkcn7lamm0gfeakNZ9Ys5Wa6bG2OmtlY7XXOqHCDScuFpzMDeJ6qsFj//ljG
 8vjuPUkuJhETYV1vk4BptrPyf9PsWOkSESh7tgjLnYRRLgaFNLbO9085oi7Dx5L1v+Ag5X7cavu
 4YizFn6e5vw9gGvBP6AODKgiU7iFvEx6+wWYjjf8HJ+ggG5vBoz6ubOps9TyXQyI9zVLKn204tB
 06tpEr2bBdRF17ziFFMp2BSwilViPqhBVq4a4cXePqJW7alKnd3EjRlOBFJiz1WdpD+1wWw10IS
 pRMj+1+ASrgSzU0ZgQK+YOOLxzWCEg7jssSngYHkdk+HeE+vIGuzVy28Zligv0CiSQGYYLAI8UJ
 +iXd+S3SnMmJNCX3bNBhrGoWnqzq4w4mviYDes1MMKgYETQOC10muRUcH/2o/4Q4wy3vHsTeGp5
 VAOZ2PMK4NyeUZFv3KQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280040
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


