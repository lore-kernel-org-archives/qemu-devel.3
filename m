Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 513B5C61DD4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:22:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziSf-0000aj-AL; Thu, 27 Aug 2026 18:20:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziSQ-0007Vk-RT
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:20:27 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziSM-0007bu-Vr
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:20:26 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJLhQ61358582
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:20:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 v10mKXwu+nKBetXxCTpDguNMbWArrru1Gn4U3yP/OY8=; b=nbBGmBlqsP+WBUYQ
 V3obM8cXQMYjswS0EcvZH09KAO27RJf1gvC0VknyLe1DM/M9gNu3OT4TRJYzsME1
 kwhjy9jkICdg47srSk4VtggaBxpbpClr+sWRO47G6n5+HDIovXbM5ZGeKl5xTfis
 NyRgqYaY/kjr5vLAR7vIcVCCBTkTHrQweQWnRtPmHcTr9BRtdEFuDhJY2LwDr4ml
 caYm/dpWzfIC+BcYqsdhMcdnLZP21Ug0HV97Hf63CSBTxKREqhgD+P5hFcUc+90T
 pY5FtmcSg51bhAMKZGPtEf09f7aT0spFyWRm3RH9iXhpbtfZ6zP9F8iITrbbSu1D
 lqvgeg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gapgvaaaw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:20:11 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cbb467e56aaso303187a12.1
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787869210; x=1788474010; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=v10mKXwu+nKBetXxCTpDguNMbWArrru1Gn4U3yP/OY8=;
 b=KLxUdV2f4XE3dEfzE6twbD4oTfGsyzupcFLBVtVSQCYWWOra5+Dk5DZTOVlTUx9hG+
 +D3/5vNYqIPYlR8vb9J68briPji0Bq107WY9StqbjK5OTvGuWN0kFRD2m3FfIVax9jA3
 RgJ1CDNTHtx3Mfl0xYSTSz/DAsfmar8UZmM+KO/9ArTWNzAZqgXRPQijVoqTir4EgYVB
 9L+S3VwamSvh4SVpKCOLzQIy+UbZmP9+w9b34enhl+to6Hsw0s/oSXn9dhaojU7pzB93
 EA1pI9N43FvpBgGq6v1llaNptNCisOCT8gGecQtYOliXC3VqttSNCQSIXPZc19mcXgDC
 UodA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787869210; x=1788474010;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=v10mKXwu+nKBetXxCTpDguNMbWArrru1Gn4U3yP/OY8=;
 b=AIegq2mXaVumhE4DBHiNXabeMvUt6ZLRkTUrIoNHgCzCawkZmbsqV/a3wpaUlle0z3
 epY6XHe/tga7PNWMRcQAy773vhfehQ7EgfzbjwFlb9dXm6vw34ryZveBfNiKozMy654d
 S2GmozmD3xAJmWCOBltj6cQ3yDPvmVv5lwVohDamCII4jvkCiJBSHF48BdbRuZCkCyL4
 bE+/xHf+6+Pj2AKKM+Wyb6tscNpg74KIoQGMYBRTJq+AjVAgEKi/aSHMDn0D2Aa/SKVh
 nPjsnaDDZWZ5lYAmozisoNbm1o0vnHKzPHTuSHS5d+vV5xJs+bz4NUzsljICX8xdWd/N
 rS3A==
X-Gm-Message-State: AFuF++kguCmSWXxMrGSSxIgIFyA84pA5swp2/DIAopJUEvNU4hxtBH2M
 xhLi3WpzveWdI7xtwUFM/qyb1vpR/kWxA0xEaCXgcWnmdYD/i6L5K9fbVJLyZPh0yFG/OaYRe6Q
 vcuEMYBkoaKvHEbwhN211KL0VdI0A7WRW3X0HNamqSDG8jjOisdoKSO34lJdvcXoWXg==
X-Gm-Gg: AR+sD13RxCSmtLkyzN31cuNTyinKvcz6Ij39icEwChZJufVM1PntGrUATJVv7FJ4z+l
 kOI+JodKidzpr3UJaZgKiJqgDOXt8w4aX8H7dNQef60dcJQVRDr2tHBYZ9AkxbJMIgYjRnqVcLO
 vB3jt5YvKmBlPZR/f+O8wD4K1CegeCpNc/b7p0vKTA5XOEIa+cq/0Rm2+ArPB6f+TvbIev3rwqD
 LZFCS2RNx3Nj0V9fFZxBdSYZnW7PvBsix+UVA8vI+AKs/pzQjJNjGN+clywxmgmvzHMKivfj/EO
 Vh2E2peqOYbSKHNLpwNUJ601lX5fa5iPXY7+9d0XL9m6a+rXRqfyLZhXfW9WxB6x5BbJqV5YZZ8
 ZonOxx0+EOJFCoWIrplUr3glc1zggp9Dd8PWd7ujXMqw1jnp1lfO18QpSZyo=
X-Received: by 2002:a17:90b:2d82:b0:393:194d:5366 with SMTP id
 98e67ed59e1d1-396d0f6f8bfmr4510371a91.10.1787869210543; 
 Thu, 27 Aug 2026 15:20:10 -0700 (PDT)
X-Received: by 2002:a17:90b:2d82:b0:393:194d:5366 with SMTP id
 98e67ed59e1d1-396d0f6f8bfmr4510034a91.10.1787869208668; 
 Thu, 27 Aug 2026 15:20:08 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b0fd55a4sm4466925a91.7.2026.08.27.15.20.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:20:08 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 pierrick.bouvier@oss.qualcomm.com, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bibo Mao <maobibo@loongson.cn>, Helge Deller <deller@gmx.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Song Gao <17746591750@163.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Laurent Vivier <laurent@vivier.eu>, Nicholas Piggin <npiggin@gmail.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v8 075/105] tests/tcg/ppc64: remove dependency on
 qemu/compiler.h
Date: Thu, 27 Aug 2026 22:14:36 +0000
Message-ID: <20260827221506.91574-76-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 74nFYcNqkXiUmkQFVEaUUWPyYGODINuS
X-Proofpoint-GUID: 74nFYcNqkXiUmkQFVEaUUWPyYGODINuS
X-Authority-Analysis: v=2.4 cv=FpU1OWrq c=1 sm=1 tr=0 ts=6a90b81b cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=UsHlXZ0vMnIq6N_CsqQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OSBTYWx0ZWRfXwwq+V38v4qaQ
 J2zdJGwxliea4wjHGK+3ndnsCBLe2I+WbIH9NbzZyH5r1z+X9cHcuAR3+1uc9Y3NoacGM2eZgwb
 JwEZieCtyUOXnYJP7g5OlPkyPbubyAGgLYu6tqGvYwmhg5jYtOQlctv2vF36hRzvpe4bYoS6eYb
 S4q3XhQ51E5IxTOpLx+1n6X8EyTyh2+hboPLlIAucTrrvoTv6x6EkThAPJxN+UqKVrmcfZdAXHi
 HL0gYjMZbqnEUDmWcmQQC84XHrNaR6sHFvKVJJc9Q+fMLARvhjhQsviN+OWYevN2uRO6qpV8e2e
 c1EfUqmZNOecU0QqRgcpB0G7xm9fgukztcgeCl3nOg6XfAf7eN6wQ2MgTgj75R30wYO28I/w+8u
 sOilejG6LMzJb8kRg/KeyUG80breCaSfX0Vy9wXggvaKmo17k2u+66Ta0THNMm9Jo3/+JFVhtTx
 RkB1sMpM+uI4/LPndMQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OSBTYWx0ZWRfX4uPdUg4dYGA6
 jDBp9bBAfPTrjHPAEeNSrb4OQ4R3QnB59iG9g3WgdtPhNyx3OrcSasW3Yn2m5bMNE7VhybQWAvS
 QQ3j0siCQI8sGIxKv912IyTLRn9iPGw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0
 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270189
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

Replace definition of vector attribute, remove unlikely, and detect
endianness from __BYTE_ORDER__.

It's the only tests that use this, so for consistency, it's better to
not make exceptions. Also, not having this include path by default
prevents anyone from having the "good" idea to reuse any other header
from qemu in the future.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/ppc64/vector.c      | 11 ++++++-----
 tests/tcg/ppc64/vsx_f2i_nan.c |  7 ++++---
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/tests/tcg/ppc64/vector.c b/tests/tcg/ppc64/vector.c
index cbf4ae93323..70491d59251 100644
--- a/tests/tcg/ppc64/vector.c
+++ b/tests/tcg/ppc64/vector.c
@@ -1,6 +1,7 @@
 #include <assert.h>
 #include <stdint.h>
-#include "qemu/compiler.h"
+
+#define vector __attribute__((altivec(vector__)))
 
 int main(void)
 {
@@ -15,28 +16,28 @@ int main(void)
     vector __uint128_t vbc_qi_src;
 
     asm("vextractbm %0, %1" : "=r" (result_wi) : "v" (vbc_bi_src));
-#if HOST_BIG_ENDIAN
+#if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
     assert(result_wi == 0b1101111111000011);
 #else
     assert(result_wi == 0b1100001111111011);
 #endif
 
     asm("vextracthm %0, %1" : "=r" (result_wi) : "v" (vbc_hi_src));
-#if HOST_BIG_ENDIAN
+#if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
     assert(result_wi == 0b10010011);
 #else
     assert(result_wi == 0b11001001);
 #endif
 
     asm("vextractwm %0, %1" : "=r" (result_wi) : "v" (vbc_wi_src));
-#if HOST_BIG_ENDIAN
+#if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
     assert(result_wi == 0b0011);
 #else
     assert(result_wi == 0b1100);
 #endif
 
     asm("vextractdm %0, %1" : "=r" (result_wi) : "v" (vbc_di_src));
-#if HOST_BIG_ENDIAN
+#if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
     assert(result_wi == 0b10);
 #else
     assert(result_wi == 0b01);
diff --git a/tests/tcg/ppc64/vsx_f2i_nan.c b/tests/tcg/ppc64/vsx_f2i_nan.c
index 94b1a4eb02d..6a9d54faf52 100644
--- a/tests/tcg/ppc64/vsx_f2i_nan.c
+++ b/tests/tcg/ppc64/vsx_f2i_nan.c
@@ -1,5 +1,6 @@
 #include <stdio.h>
-#include "qemu/compiler.h"
+
+#define vector __attribute__((altivec(vector__)))
 
 typedef vector float vsx_float32_vec_t;
 typedef vector double vsx_float64_vec_t;
@@ -104,7 +105,7 @@ static inline vsx_uint64_vec_t vsx_mask_out_float32_vec_to_uint64_vec(
 static inline vsx_int32_vec_t vsx_mask_out_float64_vec_to_int32_vec(
     vsx_int32_vec_t v)
 {
-#if HOST_BIG_ENDIAN
+#if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
     const vsx_int32_vec_t valid_lanes_mask = {-1, 0, -1, 0};
 #else
     const vsx_int32_vec_t valid_lanes_mask = {0, -1, 0, -1};
@@ -209,7 +210,7 @@ static inline int test_vsx_conv_##SRC_T##_vec_to_##DEST_T##_vec(         \
     const int test_result =                                              \
         vsx_##DEST_T##_all_eq(expected_result, actual_result);           \
                                                                          \
-    if (unlikely(test_result == 0)) {                                    \
+    if (test_result == 0) {                                    \
         fputs("FAIL: Conversion of " #SRC_T " vector to " #DEST_T        \
               " vector failed\n", stdout);                               \
         fputs("Source values: ", stdout);                                \
-- 
2.43.0


