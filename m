Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76D84C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:35:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgrt8-0002fS-H3; Mon, 06 Jul 2026 18:34:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrt3-0002fD-4U
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:34:01 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrsz-0005LA-Ly
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:34:00 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KEJUx1639917
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 22:33:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sJ+V23fgpgaWJ74AMIbFfqqKcYUehAVyEUxBZ/1GIt4=; b=ksf07wPjYou8bWkE
 cT2mD8ybJ04LRAYVX4S7Rxm0eo+b9LGotXx/9+sbBhb3z2kmw6GoYT3kXMbzkdNr
 vZ7FiFGfcCwXMgCxK6P3l+2Ey/DJcjmEDoOG4aewa7B2rewcaO5LbH2KoXr+kFgd
 GwCSHDJvv31Rxd3CjM4W2kqgGj1S3cPguinfG3otLZMe93tzO6a2BSV2qsXT+hXd
 6r6qHNOE/3Ue7PbdXYEDRT7RvxtEcCHdz5LZH2kdB/fF5lxGXo+j8RxTLeXIH7hH
 xvqk4EIntgucX7COyFKv2CvXC4ZTpmzEUDYpZUHuw4ZqQ+PvGaHuunsQZUSZNR9q
 idg7bA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a3r34pv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 22:33:56 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c9667280edeso4249834a12.2
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 15:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783377235; x=1783982035; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sJ+V23fgpgaWJ74AMIbFfqqKcYUehAVyEUxBZ/1GIt4=;
 b=IgmK5s/LzFX1yxGngBiy6hip3eHLuov+uGdsy1t2U/RruMc45JU75I5e7vQ67OT58u
 NloGZCvRKw8CzTaoM0h0Co8V+7LtdvUiIPByQM51rEtiOjDHiX1GWK1NtE2bLPwBMMmE
 znTU1JPBjERhhVdfWNefgcgCrRjMio8GVM+IwMNRUrRO4cMmFnkx862/A1DMeNSSuUlk
 Sb6HFekwnKnomCL4FQPk4YjX15u7vIIfhha5qlwkZw+iyEiZA/dehnGKU4vLXWEiG4J5
 04P1kRwAEUDHEyJoOA6jFL4IbSg1sqJP0hCBiM7bC1U9jP8DoW5VjrQR1xjYBdXYghcK
 qacw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783377235; x=1783982035;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sJ+V23fgpgaWJ74AMIbFfqqKcYUehAVyEUxBZ/1GIt4=;
 b=rzhdxOa2bU4c/nvdOwIVqRoFyaiE9iXc9xFbSPhKkc0xl9uB5dQszNDskfWeHNk9Vi
 04LnmsXvZ9jMKeLajnWrv9ADapzN4Aqh6XhVMYuHiimYXOzRSF8BNt8839w/5g3HJFes
 CL8XgKLYM12NJ+VCqSgDfK5lK9bRLy9+Wf6PjXZp364S+0HstgX/4CTlzu+iSN3Uotz/
 QWCjDBCw4Jq/lggoofcqUvmEk9xHGIRKfrWr+H1ykq9SjWvm9Fr/p0SyYw9haK462lMQ
 yZPH4oSOia9y9lxVO55b+Q0sQRUrjTpp+uCETY/BNA9Z56AVZVhxNaFD7VMA7MsCIezp
 WF/g==
X-Gm-Message-State: AOJu0Yz7BSrBBvo6Fi0ZANGPr1AbrnXYDdSOagROi4db5hA5o5bFG+YS
 a0B9gXomJ3k3XKOwznMFntRUU2aVJS0M+BNokXeU/O+uwo5faScu0XF3nBqW0Z+btUwL3w8hjAA
 43xKqI1bkII8LrOiboPx9su9hHE47BbXlR0lVeYVg3OQujF3yGKzGub/Dax3XdC1ZOQ==
X-Gm-Gg: AfdE7cmH/HD1tqteD9t8Kys21URRnyqb82qZ7OGpovg+ORCesyr7hLv7pRUCMUzizvE
 YshYDX+Mv9be0u5nY0/YBiH+NKfu7XdUEw8tjDuo2gY3O0rKgGC59qdHAYFmuF4YGy5X7gz5UXk
 JDvlO56Xw68fiUYG4JiFyXuuhMn1Trl1lrul0LxxmabFboCJLjMkH8xe9IlU1xbd+AyYJx5maL7
 Ek0VQp9EdAN3hjBtyevcUia2hSmTPwayIbroPFfwbJ6PF1DrRhbOYvZFppPQzjvx8228ZXRQQP2
 dzT7GrzpnY1Sblawhcz+DrwZdbvNAtINTVMqn9JOdQFm18wUYONPWP1QRZRsG84tXSGa+yOHy9W
 Nq8HNPiTlZ5EhzkyahTeW/rAYpm+tUTgtm5XkKdxih6yMXQhLTLfM/cvDSNk8M5d8goMa3wN2Op
 SKmhlR7A==
X-Received: by 2002:a05:6a21:1506:b0:39f:82bd:298 with SMTP id
 adf61e73a8af0-3c08eac5070mr3210250637.0.1783377235396; 
 Mon, 06 Jul 2026 15:33:55 -0700 (PDT)
X-Received: by 2002:a05:6a21:1506:b0:39f:82bd:298 with SMTP id
 adf61e73a8af0-3c08eac5070mr3210225637.0.1783377234903; 
 Mon, 06 Jul 2026 15:33:54 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31174ac0557sm977244eec.26.2026.07.06.15.33.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 15:33:54 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 01/91] tests/tcg/multiarch/system/memory.c: remove unused
 variable
Date: Mon,  6 Jul 2026 15:32:13 -0700
Message-ID: <20260706223343.988769-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIyNyBTYWx0ZWRfXzy3t8QRqoGpG
 +oMzu8Y/LT4RdqOH1JOrnN2sPiIMml6R3mSEMoQPnQA7ujdGg1gtcuJ1Wz5IRSZFqTm5eRtdCHA
 tiLdfbx5p4LFJQ+dcxIHCQT4YsQWyaiU+QU21GmnbNCOs+41NH/gYBf/FWAU/HWtpWge6F+p4c7
 v6xvDB3W3f3lGR8xCkfO6BKY5kWwf6hNAxd2nF4sJvx33GOO3mUjR6mK2+UmDekD3I/OH79ZJH4
 GjkWbiFLYknoROpe5cL0Ry0/z7jxVux200ckWsRbrLIGDjaZo1i6cu+PMLGjMBVk5bcWv4duqz6
 wg/nCkEPxiEkvXBXBUoE0cEIoz8I7NVsr0c1pDP6IA7HxAcYpJwd9/WZExJqPBpQTY56T5f3i0R
 iOrWgrj2GPIWfjWzs7bPuSq3ND5TcrXPpkykBStA9vDztFXKMuav7Zc9huwFrc2xn5cc6ftU96G
 LMN7///ljo4yACi3CCw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIyNyBTYWx0ZWRfX++3BeIoeP477
 PFsqlnkbl6+Na1f0Q/r1PHEXL12fBRsZWLxDOtuoAKkY8/JSoEnK5DCt7KspWWoLaaYP6fT5fZv
 hzNFpUxMK3106YJ9104Z/dIC4lfI+eo=
X-Proofpoint-GUID: f_znEEFJNL4opl3JYGcyfwMOzxQvEKot
X-Proofpoint-ORIG-GUID: f_znEEFJNL4opl3JYGcyfwMOzxQvEKot
X-Authority-Analysis: v=2.4 cv=OKcXGyaB c=1 sm=1 tr=0 ts=6a4c2d54 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=wOKWSiVmv2u3Qo4ObykA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060227
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


