Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 122EBC61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:07:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziFM-00075G-Fm; Thu, 27 Aug 2026 18:06:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziFL-000751-5l
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:06:55 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziFJ-00038o-8T
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:06:54 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJLwYW795169
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:06:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zXUotgp9WS2vINghYdTpZtvEitESkAGWuoDtFbxD28E=; b=VhBBwjmDrwblduEi
 SB8lUDjWLSMjWtQ8NbocfhP0JKjvXInl7e7BDPRHJkAZaMOvtd8vi6CMCTkwcCS8
 YVl1lumHhdAwwU2DFOb+MyRQbaRG7WgvWNpRKSeKFlk6bcQY1bzMQCnmBgrnZqRS
 p8Gs2MlAUfUkOnHB2lolhYZlxfP4UuBJPr/HCgtAjWg8253Tz6GtMt179chp2+fn
 xQTjw5vl9Gp2K2KRkO628wdIdh6eQ8XHU3Hk+56cSDL9K3i9OIrNrZhxESrVeBuH
 tMYyLYgvvhROz+gN+OobJYpC+0MqUH33j6V9ZvlyERg/zrLU/9+4P+q1LRn6BKu2
 KQL9PQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gam6fjm41-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:06:51 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-84e13b57b2cso565291b3a.1
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787868411; x=1788473211; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zXUotgp9WS2vINghYdTpZtvEitESkAGWuoDtFbxD28E=;
 b=BXLJbnwkGAjMYKhfxAs+X9tfe+T9TbWniraBFzvuy/+7gulL1y8iHyT58KdXhG4pQc
 6gPvNgPhFZpJOZNWQER9VRVYXBAG4dBogD4OtV7APiuk7qnfId7O9cHj/6IhqVAMSl77
 OaMVhuX7BH6snbn68Op7pgkxQRFBxBXbPvELghYN/WTY00Jzlt77HBjMkhfNFjluBNpZ
 YZYP2xuJfJBZ8gCBXOCNlbNCx+/lKK01rP+mkEouqdN3OnFIXIZHHonsTPM/rEI4VvwC
 Gws2pqNcsb7M/q+EjVCWrgQ664NRgKGtgo00ZHX72k10ashbxrlcwqCaJ+e233NyqylV
 OM4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787868411; x=1788473211;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zXUotgp9WS2vINghYdTpZtvEitESkAGWuoDtFbxD28E=;
 b=miwL89YF7Em9Ht2785r8siGOrANEJwG0pAKkjSlL7xjOlInwKHSuWcJEgbv6unA/2o
 etzGoVA2nuJkU5hrofFYQhO7eNAfxTlRvEHW5lpQ4Ym9cSwJIsmYJY+uyCQtv8iTfBUI
 aFM9HmwykwsyC1Cnn/tHxAhdEQv7zrHQQVG0X6yfXjO7zvsfBKByx8nGGrDFRblr/it+
 7V/gQtN8IBrAHsNIEa1AdRfsY1Q6UbU0GBW6dPhJP7vPpW69c2GqeYO5BfyahAG0FIlA
 +SHWsp4U0p5+TpdyIWpkQYHecljy+qJ30PchUW3Dp/3+ZJ8YriGT9LlT9U3JtvZDeeLL
 3JBA==
X-Gm-Message-State: AFuF++n8DakVfcMgG+ho975ihX0f9RfliQINEEEYyxQbMqcmfUEQEne8
 7eTkqsitGOiITl7JKiydJX+1e17lkhQxyN0UVImHQQ0p78VbQnRvLAYGe05LQW/8w/jodwI4ij1
 5DdIdrmPN2Y9fBbfV90qyRkjyNEYkoyaV7Tb4eJz//lh6njh9Y7nLf6i9PH7cHLNYXQ==
X-Gm-Gg: AR+sD10PdjYnTK3uPaMyj0jXQBIJZzsRrI01LJdit5EiyCcshubc1HdSnGa2NMAfQG4
 t6nQjDbBRhbBv5rDo63VTlcDfTWLBtaSEi1rDbkxWjxQLZHEFefm16O5rbM/MRbksRKWUFUoLlU
 +UtcaNQ+4dineqt+p5lHTi7p7kl5pI54vqT0DukgmgaTdR6sekKnRZ/imu6iP0WSTLKHWRGoTCS
 mxR/2h4d0vmgSjRTRHkpU7zvyb/YNjd11TJvh84oSiYfSPaUHWoky4O/+bHMxq4Nc4BerAObNSk
 rQfcFt6sEbeRPBdAlFS1souqxCceYOzC+4uRPw2W9pEKcBxZ84CelBTAIuTxWsmGCO+N6q76Bpz
 CfVGgkBFktHW3hZpMbjWTWIk/amcf3M4KTQHOdHx/zLmfzrF+3ndnYW7g7bs=
X-Received: by 2002:a05:6a00:1149:b0:851:804c:f4eb with SMTP id
 d2e1a72fcca58-8562868f342mr3960658b3a.4.1787868410787; 
 Thu, 27 Aug 2026 15:06:50 -0700 (PDT)
X-Received: by 2002:a05:6a00:1149:b0:851:804c:f4eb with SMTP id
 d2e1a72fcca58-8562868f342mr3960585b3a.4.1787868410329; 
 Thu, 27 Aug 2026 15:06:50 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535ced0f99sm2523713b3a.44.2026.08.27.15.06.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:06:49 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Bibo Mao <maobibo@loongson.cn>, Yoshinori Sato <yoshinori.sato@nifty.com>,
 Laurent Vivier <laurent@vivier.eu>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Song Gao <17746591750@163.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v8 001/105] tests/tcg/multiarch/system/memory.c: remove unused
 variable
Date: Thu, 27 Aug 2026 22:04:55 +0000
Message-ID: <20260827220641.84885-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827220641.84885-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827220641.84885-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX5dW7ZZPlVUrq
 hiR0aMaRjKYPrFYlSRs8GqcSNyLkvsm5XJYDLHYZJOFM6Ud3vgcO7HOYdaGvazqXmXUKvWg3g6L
 gg8j4E8gzEHj8pYG8qtXkpxmz479T+A=
X-Proofpoint-GUID: 3jDYKApK_X50fa8--IxHldoU9cz4j_n_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX6StPLd5EwCDq
 GzvjvUAVcm9Ri+oac6MbZU00Ku3Tlt6Dn7cuHCZ2RchS7eEkl+DkNg49vxDbxUKTb274TAqSxEv
 nVvFjdco2C0P4gWNHY5OB9ALnv6NAw/BFyKR4RS/5p7UqGuKxQAQTMvVkxDXlERKTW5QRO6l9uF
 3muBDKkKz/HB2sUtOh7/W+XzXynTruVikRrY0Xf9c8gbumRXreuNtfUOSwTVQ1K0DMA8IMmlJyS
 YdpfjFQ2axKVAlCAIrSbKaK8m0ctC9Ox5vDUq9sTUNDwIh9TW/uSKUk9n+AoyNEMD9wB8Vbj/uB
 x3RlvTLPBRCRmIc09J+pfB5grphesS64D04u+OaCQ6w+Df2Z5g6o98FUAF5AiNwbIopPFf9Abb9
 UeiPopZkO131M3meDpk8pfbcC0WcOrEJC5hi+OzGgnlb+SA6ZTZhxSif+LMEXCrc1YJdlW1k2MC
 f1TPA9HBbsT8jtsXdTQ==
X-Authority-Analysis: v=2.4 cv=eIgjSnp1 c=1 sm=1 tr=0 ts=6a90b4fb cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=VnNF1IyMAAAA:8 a=wOKWSiVmv2u3Qo4ObykA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 3jDYKApK_X50fa8--IxHldoU9cz4j_n_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 bulkscore=0 phishscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270188
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


