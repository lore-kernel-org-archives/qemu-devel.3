Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F48EC61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:15:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziNR-0004sK-UE; Thu, 27 Aug 2026 18:15:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziNP-0004rk-5x
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:15:15 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziNM-0005xt-3v
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:15:14 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJMTpQ655550
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:15:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zXUotgp9WS2vINghYdTpZtvEitESkAGWuoDtFbxD28E=; b=QjIxw7b1YoBiwjG9
 WNpXYQnS1SgjGRauYePv8Ssnbqo5V6aSpPPejW8HC0WKHytkW2jGKTpe7+mn5Mx2
 PR+XX7zRtSSRg+EHR36MR8lbjymRTfwI0fBLkLhPbqb9nhPFwpu+1c3hJZBeXJ/U
 hckfu6oPAfSaBPh0RwGDi/2hGHbrorKlDQtCyzqfKO2hSDuEx8Bsb59KFr+Z2Ak+
 +3/R2Sf+8+KvIyzLJ/xPSxAYrQNd0CFW3iNqKzlIxkKoBUdVLZSd8KC9SYDksxnL
 zbtd6fgD5abMTAn43hITsC1E1OWuMP+KjT9oVUSccszFRzJ4t0ncL0srjf1LKQcd
 wRyueQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gagjfuk12-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:15:10 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cc1b8088203so267232a12.3
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787868909; x=1788473709; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zXUotgp9WS2vINghYdTpZtvEitESkAGWuoDtFbxD28E=;
 b=Jncu8LYDOAH16sUEKDbKKSi12PIS97H8fzjKitgl/bHfGXf/FoPeeS5etAUzQkIu2o
 c4zVWxjj42TO/DewUaYrcY0jgp5fQ5dTjhmcWaMwV2VYtTZg6VJSywHT+mck6OxiRA3Y
 RWoz1cL4vB1yOOcE3RbcVdyEmtINN6fh+K4ib2Q3Fq+hDOvVyBlyJBHJSVlZu4CXxFHf
 3KWOU8Ig6ir16Nti9iuN883zvCNImS1FMFPoqFYSevKfVrofesoxDgsHa9KQzaTCHih8
 yQ0uVjOpifHYoRxpXhnZKQuRdLmXpmnfVxXaHuLD3vOlZHZJRk8vk/irgaNSJKjir/rI
 R6kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787868909; x=1788473709;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zXUotgp9WS2vINghYdTpZtvEitESkAGWuoDtFbxD28E=;
 b=EDuBoLc49bNMk4RDafqs/vI9njum6FDAJV7Axd0GB9Yh2AOKP1XNooz288P3a70CGJ
 ezkd5amU1TwR3QcwgZmR7ro7FiaJvB3dVM3v6Nkoq5vOKNvH9jQ0SjHC+t7QjVXhyP7F
 GgVD2VCfShA7zvMamaT/TRJAfZDbKvVJ2Lu3+pZsE+MHxyF1sK3ztWohiK3Nzf7qGRLm
 f/OjfKChSm5O75iPqjH9DUZVK68F/SsTP9tovxJErCD75EbXHXsw5BQbT/bfxBkBPUOU
 aVgtzqX8Vwun7ZH1lE1FLRMrzRGu4GjwOCxjSXmDP5Oti9tORU7q/uNK6nCRsF3vWaVN
 Xw9Q==
X-Gm-Message-State: AFuF++mXwnJUSJxpUu1Sk+llsvhyNDs5c04VgY+It4O0Y+o1q7bqFslF
 aK/WNwdR2Qu6cZWk9h5TIwUNiqXZpSIRwVFbWWdG8OXREmG9B5B22KxYVfH/nPvUIFVTakYkmKX
 3VI3F43yJx5ZK+cCsGn/stM0VqTHCTGIy295w9bb0JIxApYWVrVmbqsbgKv8w2+mkpA==
X-Gm-Gg: AR+sD11jdLPDPH+uyh7vptWieAYh9vaRrqsZSfiWS/0N4Q3lIr+75fDyxhAgzBKkEJE
 jQyYRwufR5qk/F616QVGLDufaNiryLNtEfgA/r489PHPHClAJnONtf5DzIQoKSXHp2JLAybsZO3
 fMbnHczjP4tbZWMq8je2/+dkN4OvAMwKUI6XcF8DMIhbck8agTmshxFdnIDRkdSoPmM9W0SoC0O
 8wJNI6zdTK4l++/isYys/HewsWI0HEpVJ+0OCLHsmyHAblTcbV4gWnrW+9IbPQXzkMjDZ0TCdje
 HiXJ02CmaXIo2n/x4WkWN7jAiyBLUhVj1WR5Mo/YgnKBJd0imVDBPCqvkK4V0NKpF5FG4BNV7nm
 N72q1b2TiruWm12lfuTmlkeosrXqNoHbo1BxkHbL8Rjx9KF30UKIj5QemHyY=
X-Received: by 2002:a05:6a00:4fca:b0:846:8b22:4933 with SMTP id
 d2e1a72fcca58-8562c24568cmr3580106b3a.17.1787868909252; 
 Thu, 27 Aug 2026 15:15:09 -0700 (PDT)
X-Received: by 2002:a05:6a00:4fca:b0:846:8b22:4933 with SMTP id
 d2e1a72fcca58-8562c24568cmr3580007b3a.17.1787868908818; 
 Thu, 27 Aug 2026 15:15:08 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535cf4b213sm2524104b3a.55.2026.08.27.15.15.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:15:08 -0700 (PDT)
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
Subject: [PATCH v8 001/105] tests/tcg/multiarch/system/memory.c: remove unused
 variable
Date: Thu, 27 Aug 2026 22:13:22 +0000
Message-ID: <20260827221506.91574-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: cVaJhzSKlOtvKN-WcVBtG9fWvorgfKSW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfXwHZkCzlUT/Ef
 Ni/DRayXJG/Xpv1I4xa6uAZEFplyhTuxi8R8QvZZyxib8hF3uIUbldw4dJrI+Tf9+2wnL3CA63Z
 dYv4NJzxpwu/VxVOTxDtW9RUB86zVKj4CS/UmI7TzO8st1zMAkkiSWf6CwsHco6ESUFAo0PsUhO
 OBigftvPz5FHxgX0o/KRTcB6o1IoNValiBmv+bXt0y6nPhl8yf6ikNZLnGLjAUx7e70gIQLsqzz
 bxZBb736kGaH5FeAyBSiiHZsxKURSL+vyVuJEGa73n026aiBhMsmxVb49npd30Nc7VghYTbVWrM
 zW1eNTDQ5/6G/3e5OQYNjxRI3yJLNUYVt+2ucJScMusfY5/1aV3dcR08SDiJKdPpfqgAoUg3POV
 +O2u4sI2JKimlzRB4zk3GfTxPWmrOJEtwYlBKtVNYAIsGweBnhrAuJfUYfhz6Bq+jHkuEGIJRRR
 a6LMffYXndchgVrdvBQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX8bCnqX4Wb2sn
 DzVmW/JAz/V9CXCu5HFkt9rvynPLA5dKoKAGWsRHmzxT7Ft2lDo/Q9UlL67crtl3oAuUWI9f9Dy
 njEEA31P5zUePNOut8DjR+YV190dt2c=
X-Proofpoint-GUID: cVaJhzSKlOtvKN-WcVBtG9fWvorgfKSW
X-Authority-Analysis: v=2.4 cv=dd+wG3Xe c=1 sm=1 tr=0 ts=6a90b6ee cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=VnNF1IyMAAAA:8 a=wOKWSiVmv2u3Qo4ObykA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015 bulkscore=0
 adultscore=0 suspectscore=0 impostorscore=0 malwarescore=0 phishscore=0
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


