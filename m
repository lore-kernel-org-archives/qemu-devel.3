Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C79C1C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 23:41:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdG8y-0003Jy-RJ; Fri, 26 Jun 2026 19:39:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wdG8x-0003Iv-HR
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 19:39:31 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wdG8u-0003vg-0m
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 19:39:31 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65QMxNMr796349
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 23:39:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sJ+V23fgpgaWJ74AMIbFfqqKcYUehAVyEUxBZ/1GIt4=; b=GXwjk8Z+nALpbdBM
 /3Q1KSQxr1Iz93dvCiY3F6aVn/bYoXYJtWRJEp+9JvqrasbZjvn6e+ZLSKGdZ6JS
 UNzrHaNgAdD6ScdMh/uGiIonyV6stYjDsahQqO/USRVTAH4jcRg1KZilaxuPpnIJ
 vNmoWh+cKJEcCEBoculjIrH9hVGGwTGJN3FalBPZSD0wTr81NtppfY6iEKRdSnao
 LWziDSkRJaG8VPpwY8ute2uZUAYCrFklfDMoxKAgOkp+Di8HgTTMXZ2cFf0IIPwm
 uXEZPgYCaEfvufu87lzwnGYJ+hoZ575o0CSez2XykBAanvU0L4pJz2XcUZuk0tMm
 +jNRRg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f1ups9kj3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 23:39:25 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30c0a27ad86so659739eec.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 16:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782517164; x=1783121964; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sJ+V23fgpgaWJ74AMIbFfqqKcYUehAVyEUxBZ/1GIt4=;
 b=GI27i9DfG63PdArr46TdVbzsV+eo8ywrZ4k+uMxlzRXO93NoJSWLrpLunRmz8O/MPX
 mUhG+QMhqD4ZJjm60waf3dJU5ZVpQJqNuHLzxoukWZmzZoLgH5MftofQBCZD79WBKSna
 8KZiar6UY9RDQcRNH2ZO7OS+SkhhQvOaD4xdvr4EqfVr6grOZYOMFyfbyCIfADCJZnjM
 0H2bPnPN3iZbO7oc5ykGduZuBtRPrWbGWg/ZQqi5L3hai4ik6LTxV2xwN5vt608xaOwx
 lQA+wLRtGM8GDoNgTwR0cKbJY5Y+EBI3bjcyhDCRYLEdZEwDynLPLMEpk/SDf16UClR3
 GTDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782517164; x=1783121964;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sJ+V23fgpgaWJ74AMIbFfqqKcYUehAVyEUxBZ/1GIt4=;
 b=SfHC91887M5R6vQcz18ku+3kCt4NKBDYoEWwF0Pyzd70ukW2O9W3Ww0y2yEPXd+hEM
 Ijej//HEFwx+A6Fe4l6V1zRbeOwmuXWx4aW/kgAncDT7OlsIwwMZNY0HocDPI64xjtBk
 b4t5FfYhL2kDJtvJLONj6vDmlf0Jhjt20bS90GEGXqlh2vzYGf5km2c0gJ4B8JpWPB/3
 2vu6xGKX18/D8dc97jTCN/B0NN+1rY6W5YVZaMRbhn7B+Vgp7n+Yned8bf1gPEtTeRYr
 dvskzK3udTSh20p0WdJe+3wv2DnexjBKEgCsRbv5IEToGmOY05SXiUKFZqa67y2pf3FD
 4A4A==
X-Gm-Message-State: AOJu0Yw4g+fo8alW5HmFQ52AdF5iGPuWXiODW0afiShwQfG/K3yPw09l
 ACtutJtTQ4DqIZbh6GDV6lf66jzAZc7Pz0myXe6hYObiYFCH9ZpRtwJ/IKvwyAp/lLL0QYRWs6E
 OGAx9pbVKEoZVcOOZUlPDf8BLVp3XSk9IHYHFqpggPRKp3bkS7oz0BX1tvc2bS96enA==
X-Gm-Gg: AfdE7cknuQcZeWKd8hLlOWM+aH4Trp0/a25OaEhsvfFYd6y1HuL0Pt6XVSF9ReQNohX
 Df01sEmpMneL/mUZl8keeHA+l/IcY2g1psM0TqDT+FteOmMlwoJag0L+1wNyciyuLLAbd++gxvA
 4SzYXrZV4mIR53MDvCnVmtRnc5PWjYpbs81WwR3Zn/pvrmAx6MQyGvQ7javrhtYkyOjsOjWRtMl
 PucCR3KCxhPYMt1gRp1X1V8HyNMIox9BdSmOFhhnGw4JQqMZbg2L4khPj9gESM4SuOaQRgewYiR
 BIVxXJ5CR6eLyMrTGdFa8Ye6/rD220o9O9CUapC1KfUs797PD9NFrUVwmFvodL+dCXmc9+qNBGQ
 YJsStvT2GtDLcTT9df6DtbENFxXV6leTJs201gwOptc1Xq/goDkMl/0NMTX46OBKWng5W3seYUx
 kMhg+ygw==
X-Received: by 2002:a05:7300:cb87:b0:30b:f888:7821 with SMTP id
 5a478bee46e88-30c850a2bd2mr9491611eec.28.1782517164381; 
 Fri, 26 Jun 2026 16:39:24 -0700 (PDT)
X-Received: by 2002:a05:7300:cb87:b0:30b:f888:7821 with SMTP id
 5a478bee46e88-30c850a2bd2mr9491590eec.28.1782517163912; 
 Fri, 26 Jun 2026 16:39:23 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c52c591sm29369756eec.7.2026.06.26.16.39.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 16:39:23 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 01/37] tests/tcg/multiarch/system/memory.c: remove unused
 variable
Date: Fri, 26 Jun 2026 16:38:42 -0700
Message-ID: <20260626233918.158740-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626233918.158740-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260626233918.158740-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDE5NyBTYWx0ZWRfX1rVgT/tWNQbt
 DfhBDxz04ULSYBoS5nxvkWBGn3KWR55o9CtWvUR8+Ax+axEEPFbfnPCCCfmhpt3cshDpa0VK6S+
 +usneVwdbi2ltUIh2yATpS2tOG7/CjXtSMKT+zTTIw+LRGhWs7pysxFjDfwWFNwapJ7+VNG6Bnf
 3ysBM6X4e5bC18+qskZKFdzZKR1+zXPVAGeISKcgPo7sAhBrc0I8UE9AHnA7qcOqUveUnnCVxrx
 9KowD003VXuX9kg/LeHK6seMYmtuV7BJTjDEvsgJbAsYwpXoEYaAA7gb/cOURIpfK6FIC88tTc+
 7M31ooXGMCFHk7xEdHdvBYCO8cK6IE9yq46+3s7gx5owTJgUcGWdYBoKbZwgZvB9+sCJIMoh6Ms
 WG3E36XtIEspMFt90Ipj6NyGIKs0WfXwGfw6xmlrvYKsHVWyB4cAMwpOfaBQn+F4htyxpznozn/
 DNNwnZR56RYy3rNhFPw==
X-Proofpoint-GUID: ncu3KVt13-xoCMO-jaOoz_ci5Vr_eacF
X-Proofpoint-ORIG-GUID: ncu3KVt13-xoCMO-jaOoz_ci5Vr_eacF
X-Authority-Analysis: v=2.4 cv=R6kz39RX c=1 sm=1 tr=0 ts=6a3f0dad cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=wOKWSiVmv2u3Qo4ObykA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDE5NyBTYWx0ZWRfXwgKg0PKbw8bC
 yJh6HZe0bWoYux6CeYiv5hhcW9vohPOKZDY3JAUw888vPS/19TXd+ou8IL6pAyaAdZsyfAT6HKr
 PkBlpA0MLwFPQJLQcR4uCOjwKFp702I=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_06,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606260197
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


