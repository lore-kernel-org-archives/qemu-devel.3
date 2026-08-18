Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8CBDC5DF85
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:24:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPPA-0006XQ-4j; Tue, 18 Aug 2026 15:23:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPP8-0006Vz-Hu
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:23:22 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPP6-0006Vy-I9
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:23:22 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IHGsIu2494368
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:23:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zXUotgp9WS2vINghYdTpZtvEitESkAGWuoDtFbxD28E=; b=McdXPaZ7pAm+KWvz
 ydapo0tOK//l0nwU9yDnrZ4n4eEcTXUOm9C9BRFU1Kaio+PS8XLVQH34Y1ilhs8V
 l1oGrjMSO8OEFJlpmWdL6LVVIQGtZvbEVLHF9oJxE/+zOGTPa7iX3NetcB8TsUv+
 2FVQzeNhOZkYyM+gHTaDmKENyIM1lKBFzV5VOpNmNL78kHcHgKP230fSzheSUnLQ
 d6cLb8nWlEti4W1Ooumw2IHtJIILwYt2Au5c3vRSZsVnRttTLykYxR5lnFnHuIgB
 kaDvO0yJm5vcAFASoJnCGMDB8WHCHFQqUE9eMHogfUgrOM/4zLNTg1PDjW+yyOuM
 d/rREw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4sfnha33-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:23:18 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38dc085b0a7so468689a91.2
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787080997; x=1787685797; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zXUotgp9WS2vINghYdTpZtvEitESkAGWuoDtFbxD28E=;
 b=UlpGTtGzegmy3RXSzr0tOfSUHNS09V7jStuOw0PVkycvQh+o7UmwuKQvBSLRRrHMvU
 681/gOypivjFqnV09pCzFkHSwhNQlpL+4F26i8G0WJXR0wW8mZRV2j7QNwPuCOKoHnw1
 Kd4iyGZnLYkrrZ0J7PKqMtzQb/beOpBZTpo+kI6dT/6ZoXZvUHHQ3BYak2++jr+CUsby
 4yPhzvAAY3k6/4gexkP0KdmA5YlmnWV/ZzUFT5zHAibnK7RWdsIbwOifEA1cAnDTPAP8
 FpgbCWMPGppkiMPsmEVKoyz6LnmFX+xjZPj54N8Urd5f+62egBM/IRqVX2ZXY8Rucgh3
 f1vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787080997; x=1787685797;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zXUotgp9WS2vINghYdTpZtvEitESkAGWuoDtFbxD28E=;
 b=MrUAydb92S7KB1rJpf7RZ7yOj+5a+V9vGfgXh+2jY/8NtQRay/kP8NLEzJhs+BP9Aw
 +PZrOBr9Xw27rl2npIzR7UflrhdDyJYHaNUHdAfG+Re2GfuFreV5eTYw1b1nibzh5RMC
 XVYPByRUPd9cdGBbRe+kxcYlaW8q8siDyIXCZmNpsvO49ZPBnSeNQjSLeyqFyVcp1dNx
 DqHjx+hdpamRiBHtbqd9w93q1eQ1Y/NQV9qpdCmHQjfNMJe6+6VsZjzNZSRd1byjI78D
 +ibwUS9PwBr4BdOBsb0JApIk37EEx6YPmtRLRWxbSP9a3XDpqLYoI/fJimQ4xk/DuG4w
 VEzw==
X-Gm-Message-State: AOJu0YyAxJQ6ZiE9QRQ/eUTSU9NtQXNCc5IrwtPlAnV+RdQbn/V4irk+
 bI3FjZEiJYV6lm+fn65LBX289wYhDkeLvS7wPHQwBdg2NIynEw14BYomuA6AqsE/OpZOQc8xRgo
 dPYClKLkO1dYyMsAZL/BX7A/XoBwBlX52RqHaysFflRdWow3ADRH9Yn1rku0wop7b+Q==
X-Gm-Gg: AR+sD11ELunB6cXltgezsgjWZa5jCVkOLX/585hPYMogVXSp47axjamuzD+YNPBB6cU
 VgXmMJu15ymfMZqcNZBx3VuQXpZ6oYvJQ8++9vNeTsiETDD5u8tbdS5R0R1kCRaFtc5Z3+pYIqZ
 D0bMbfv3fJDDcEfz/AeEhPkQ6Eh87dA3FjNteZTAqmbmX3fpaIhfjudWK5TSoE0lMXX1hDy1pGe
 tXRYanHJluutdzuKUj7ri8XKvjIYV1BM3fJd4iABOdhnLz0ucpGJpOP6EPiTxDL/jOpDR4S82ck
 axHaYGDWX4fpM8vwG9ApzlzDVftlzOs4qVwAsSzJExEu2KJlo1tmO0bopcfQqNo+I6g9blDKwVO
 EC6KFPtDF+OQzLDJJRQZ89vRRBYSIcdUH0sCRYsS+Ij4a3r+Ek3IIuy1ZJ4E=
X-Received: by 2002:a17:90b:57e8:b0:38f:5801:dc0e with SMTP id
 98e67ed59e1d1-3957b2be4camr57379a91.15.1787080997411; 
 Tue, 18 Aug 2026 12:23:17 -0700 (PDT)
X-Received: by 2002:a17:90b:57e8:b0:38f:5801:dc0e with SMTP id
 98e67ed59e1d1-3957b2be4camr57283a91.15.1787080996877; 
 Tue, 18 Aug 2026 12:23:16 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3267c897e37sm21879429eec.28.2026.08.18.12.23.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:23:16 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v7 001/104] tests/tcg/multiarch/system/memory.c: remove unused
 variable
Date: Tue, 18 Aug 2026 19:21:25 +0000
Message-ID: <20260818192309.22169-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX5grH9WuO66zS
 TptA3mSkMqivk5KSfe4+JqQABq4E5qKjFUx254TDU9I/3HyQro+fh5oaieKqlYNaosxYKq0Du7E
 MAMibzgWkHXW4BUj2sNA53XiCJPdPf4=
X-Authority-Analysis: v=2.4 cv=MpliLWae c=1 sm=1 tr=0 ts=6a84b126 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=VnNF1IyMAAAA:8 a=wOKWSiVmv2u3Qo4ObykA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: BAvnfvP-AaX81C5Zh_YVFrJCRYPVIRTy
X-Proofpoint-GUID: BAvnfvP-AaX81C5Zh_YVFrJCRYPVIRTy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX9Oc76A3I5Abx
 Bso4r0xkThW6CJ1cmDIkofiraKPKdPWFgMSzDydayiiCHM7T8zdFejf+gBbaigtib8G1eMtSoX/
 Utbjvg4wBItVXIutzVVOoDvBtyTsfWQ0DRiQ8+xVgSh/f2JMEYeAyrLKLKUBKGZvc8t4pcrOrfs
 fiOE3tHbxSFQ093w6iwXPuWhb9SqYTuqcaIqPuvSgueb+c11mbOgkkbNOsh8FfXaJVENPa8kSPk
 XnKxHj1pG8Doz8RAQate3Dn/Sk1edo3Q/e9fG8Wam6rtq+SqVXehoSD7Fo3TDqVAmYcWy/Gw68r
 +JStWl1KMI/5wJgnYGduaY0Na1heDAK9Ldhc8FKuVD1fY5liLvU9k/mGi0teMpqlb+6rxIXSz/Y
 U+/3XErmYJkqyt/QBqUjF2vvq13GRIIlSXeQLdkE3xj+gqZAR63gn58LQT6Jnctlq5pznB+KoN3
 +jdy7iiyZvw8K8hLffw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 phishscore=0 adultscore=0 spamscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180142
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
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
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
2.43.0


