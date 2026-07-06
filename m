Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2813C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:39:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgry6-0002We-Ap; Mon, 06 Jul 2026 18:39:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrxo-000259-QH
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:38:59 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrxm-00071Y-Ft
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:38:56 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KDxsR1478021
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 22:38:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=qxtZpw2+QL9
 hdcgorD+0uyXjoZ/uL+GIE8b2vpdtO48=; b=KP1ew0rJIoaBFNnvsKI9t0VJkUd
 QIDQ2qHLbyKBf+mh+WdJfkyxnb7ClYZCFVd66sxuO/4nhDmOqtLgWnRo0FUJkQDn
 Mcd1Ol2JpRWVMLfiHH+DMmeZRIgG3NqJk5rfYzLvw5kAAOiT2xfiycLxXSprwYy8
 KF6qPycw31qzJECiLCS+qnxk5nuDvqjxuUBLSRdVjsII9ad/uKDwcw1O04yaNz1b
 b82FUjG52gkO8gi+hmVyxL25el68kElm5X3l/UA5aCv68PT48eZPo+CS+RdFfoyZ
 XwW6C0oM2vF+m7mu51kk0LYUhEa9fozDKN4wD98Hdqr+bxIcVXCTHdifkKQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88hsbmh8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 22:38:53 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c8620ee0971so4119101a12.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 15:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783377532; x=1783982332; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qxtZpw2+QL9hdcgorD+0uyXjoZ/uL+GIE8b2vpdtO48=;
 b=EHlApRsdwrdsx6TfiDKIXpSTyKyd10jkRVWTa/F59TBDzU5Y9jkzk3u7+fXzNfITLQ
 JCCxtM3xbve3U6WcOamsRppv2cTRvFVKQvlHxKAW7EZThf5xt/vi6Att9uxsDAXY3fv2
 d77lQLQXIGYkLcv3foGOHwo9SlKraQCR3wrHlJ6vP4anX0mB+EIUl4ea3L4dLrvzjJ0H
 khGGoOFG8pZ2RFXd9bp8GxnEHyaHFoh06jf+LeJbY5TtjFdtuohWZP6s+gjaO7iVgbgu
 0UylYFMkbMPCR5PQZeHwakmUEtZ+vIoBG6whgp1ThPvXn04VO4lm4jABsTTsmyVrW2dE
 poRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783377532; x=1783982332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=qxtZpw2+QL9hdcgorD+0uyXjoZ/uL+GIE8b2vpdtO48=;
 b=V3b63kgpwGLyH+eUdvDXU7L8DW818E781vGUTKPAHwE34Q3H/kjUEA9ujmzGaebD0m
 fo4bQFN2klXAUnfc1nRNF14COxQ7APss2syJ3EH60/FDtuyMBaUTOMVL/XsFrGGEoA7N
 GmksE9LZzUHjDAJUIKvClQBUN44iGHPPf5HUrI7rdzDMcYubD3MApPpgyPq0RLPL9RMD
 kAV6gviY/60L+culpySF7v+EwwvMvygLjiGUEpMbViNnI1pGhV5p48F6L/E+4Qo/SpE5
 3Li1sHj9UKuCfPcoQ29LKsxzaZm45Ml1VG6T5pKwLCNxVxtK7gEj3dFUrXdu0K/l3y/o
 OROA==
X-Gm-Message-State: AOJu0YwOSv+LLywnqnF0KqN7GutF3WUEqH6cYCvpHTgiLoN6jDx9LuRu
 JVzloYAnS/+qbWJ7OPz04kSJnw+RsyWrXOQWmStnk1STJEiKXiD3TA+xsHstke5/kIJLdB9193h
 YotzhITkyWoG3/0CzHK3GTpEEtgEo8w4iVUM2EBLe+z2X/x9kfUXBsHn3LB2MkyBbgw==
X-Gm-Gg: AfdE7cmoFMqMxMJ1aMgbJxt315rKlgoAP0DkuRX/uxaHFiEpKrWw89U96YfRvmPxKKv
 cVTOUEg0p1aovyPLzry1Yd6210zIkaTGKnSgepr+6/QG9+bzXHz36OXPYW+oA82tMDlGcrSPM1b
 FtPa+Kji3l6LLI740p8s7NoHggHs19T06P9j34cW8cfoJpSm4/7UndL4LJYBaVjepLlnAbgQoec
 WlSGRwfEhlJazX9HZjoX4ViSHJ2TOHuSyi/NzEKBTpFJhqbnmMS/t/sIXVlfO9Iwy3UQFeSqmgV
 KOa7v8qXIGsgaQFHTvMkonl/KCuTZHvjkveBA75usHCw1GGMFKDrR0/oxpHfW7gUtaVUVZzYush
 qMvqtORWkvQud07Ojc8YSni8dC0NT/9ut0FLc6tLO0itVHISvqOB2CSZVl8tUFRt6TCHgPLSqOo
 PyJvvTlg==
X-Received: by 2002:a05:6a20:d494:b0:398:7ed3:a001 with SMTP id
 adf61e73a8af0-3c08ec61813mr2750283637.2.1783377532464; 
 Mon, 06 Jul 2026 15:38:52 -0700 (PDT)
X-Received: by 2002:a05:6a20:d494:b0:398:7ed3:a001 with SMTP id
 adf61e73a8af0-3c08ec61813mr2750254637.2.1783377532011; 
 Mon, 06 Jul 2026 15:38:52 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659d8da9sm1399484c88.14.2026.07.06.15.38.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 15:38:49 -0700 (PDT)
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
Subject: [PATCH v3 63/91] tests/tcg/or1k/test_addic.c: remove unused variables
Date: Mon,  6 Jul 2026 15:33:15 -0700
Message-ID: <20260706223343.988769-64-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: BTWuQby6juC4Peqbi2egXmFJB-KJMbw0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIyOCBTYWx0ZWRfX2zJx4WFcaT0s
 6a7W1/7P19nAes8YXvtSGebttufrDwi9I9dUPrlIgc6LL2qaiNQg8MiT4FAjWeZQh1CRopU05zx
 G+5GF95foh19Clvi/J3shu849Htl3J2GzeE8XRBvHitj8KAQV2373btLL4gJBV91uDoc8HcBf0d
 iUHdgjB7fOtHolTcnnC2UtJr7P5N5/FYRlBvrtMV4qM8/Rzxn2te0qpYbgLYbVZfBTOEn9CkicJ
 VD7+iU/0ZyDgjsSmik9QX9BwQKEapwiqOnqKP3ZWNOEandDB8RRMut6OatUHNFSwiRXtoihJwQS
 qj5gGydfqnF5gjCjs+4y+53POjU0XOQlb7EsBb5UA6Hu7cE+Oe4bo/lapEm0RGOdk9IRiGD1One
 VLY/ePLQhOl0clNnLsw7/Kq6RF9VY1CZGCzspVnMUQRUC4Yc9sbd+JYIMt/ul5HXLHXyJUD2Shk
 4JZyQ8IB09D7dfrIr9g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIyOCBTYWx0ZWRfX36AY11QATibN
 BvUObsJDhKi0twP08MN+PdOmIIiACDpSKCqVnKPUE6mIXQa3P5TUP+s09zyAx4/nZxBQc00PxzV
 YYxs8gt1s0ahI0bCvgfje+7bY4k52C8=
X-Authority-Analysis: v=2.4 cv=XIwAjwhE c=1 sm=1 tr=0 ts=6a4c2e7d cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=RqiPX8BHZv66XakhfXkA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: BTWuQby6juC4Peqbi2egXmFJB-KJMbw0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060228
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/or1k/test_addic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/tcg/or1k/test_addic.c b/tests/tcg/or1k/test_addic.c
index 857aaa13302..27939c64ff1 100644
--- a/tests/tcg/or1k/test_addic.c
+++ b/tests/tcg/or1k/test_addic.c
@@ -2,7 +2,7 @@
 
 int main(void)
 {
-    int a, b, c;
+    int a;
     int result;
 
     a = 1;
-- 
2.47.3


