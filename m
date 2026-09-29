Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EF78CA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 21:27:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBfKC-0000I2-4B; Tue, 29 Sep 2026 17:25:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBfK9-0000Fw-MN
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 17:25:17 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBfK6-0003gg-N4
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 17:25:17 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TJF1AG1649625
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 21:25:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 s/iAWST4eylVJROI7goDIM8/Yq0VBiruPektvWFs3vQ=; b=Xqg3j2aBour4s/vm
 2LCJiPG2ivWzjjZ2AprOiciQj/nSDfnIThyJ0b2WTf0d52tSLAOsWZc6LmD2XQCe
 eNq0lMUdOjBf5OFOt7wrDCUBbuxyg44B8w9tB54zstXha6GYO7IoGuIZMaB9EZ2x
 jOzxuzcG+vHNMOK2LAaKyGRvPl9KL+gCzFzR61FexP4VvYCzK+Q01JQvp8aBGtnI
 tmkq+DKYOUyEMKCi4FwNiHiXkDg84ZlY0eJjcbPbVo2bLZwJKr2xvvxChS3d67bv
 7wgxwioPBAndP4yxdLX/hPyblJ6nyXgGStr/Cj8NLUujvQxW+Hc67JUfVmWdC09n
 2pZ2Bg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0et29wed-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 21:25:13 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30f1b904861so6382504eec.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 14:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790717112; x=1791321912; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=s/iAWST4eylVJROI7goDIM8/Yq0VBiruPektvWFs3vQ=;
 b=MVh+G3Mqg5e6grWT+bzZjQMq5IfwUwykzR3s+Io8M5U+YXPM0dQ1nu0CGlUTWtKCZy
 RG/YxeZSh4nbd7k7/ly+2FQ839mSiTv8VvAxPcrVG1o++wL9nCTM93t/8Yxj+I3Q8Dbf
 k/DbpgbVYyLBmvK7vlWb7k7vNe3poxMXHxBvI4l7nAEUkLuGRqJlxBNeSCI9ufq7wOA5
 4ehWj/3S1I58hVX7mpqPWbGC2HzzU2aODSS9Im1ep1MXe8+9zoZhzHHARh4+PEk/3k9m
 Gu6LBR2ZiqBxj+b+cDBIMxZVNgqfYnXVOAAEnEKTjIhpz7tYT2qfGx5sdZAiGg2WHkd1
 LWfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790717112; x=1791321912;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=s/iAWST4eylVJROI7goDIM8/Yq0VBiruPektvWFs3vQ=;
 b=KaC5Gf3cGhJdYckxcqnDaxZ/C3GvWI/5vXsniOdMcjmV+KoZl7o6zLsUCUPrbA5vYF
 swRU0Nl0hji2HJrcv6mxAZt7wnfsZrCp2hYq7l/Tbz1SgaQ/4VDq+ChZpJC5Dneti4wT
 4ZRYXh2P1wiBYokrR7o/SOjRB+ul/njWdAcsaYYLUAPKtDTHeUJxnZrf783ibNs8fulS
 ZQK25/JWbhsB2Tn9A96TV0n8zX+kZW/uIYioGa7YjdNXirZB1/49c7GyUhDWcbg52LDs
 QBT3qW6XBAWGsaA4n+Pfgc3VpO6iLRTzEbp+b26uPgFQ4TGxk8VKzHULVIrMYjsKjzCc
 Nscg==
X-Gm-Message-State: AFq9FYJJD/ochWrHmXaZSYYTQN30m9ZC+hfutqKTXAuX0ThakcS8SC5k
 QlNpQGEC660KI5iTPYq7+1CGCSRC+6095rSnKzOeFrMreEqMiSZS5va31N6hAUTuca+HuVNQOHd
 UrNsb58vwPi/WmX2sAr4xTdpUVM3ECanKfdjd13LQiWgTQhxAtqZomHWmHY4U0zA9sw==
X-Gm-Gg: AYBFou0+UXD6woa7lOzqk/hBhgddcfvOY8u3wQztl0fb6zWxkN1cYbFx7VdMGLC8Gqd
 GBRPmZYbqQ/8j/xNSx9tdG2yiNiFaoA2BZDt7rMzVmQU6dZPyAY4zurt63H84INGqT4MytobYSp
 kYMu4Ot8ELrHZFv66yllpUaKeuGXab/gCKSAT2TkwvGtM9v0pOYEgJti6EW4HjoRiQ4jy4LbXxT
 zTRe8oxa1jjQLaLupjhslRID7LFW4sXpOuIxwnnI7UpezKhFMXM1imttC428vUFJQhm7XVsTilc
 WlDlCZC4Yj4RKlM6m1TOVkS7rRANJnqFvxHKwdWIQ+xbmWl61D79BuNGM+yzWxKvSS0nGd15MF4
 rWU6NM00YjNukRrNCe61F7TGw1C1sMsrGA6m3OdFmouEUemEnfGzYgtfBZxW/
X-Received: by 2002:a05:7301:d16:b0:33e:6ba8:9519 with SMTP id
 5a478bee46e88-34c6691d2famr1034897eec.25.1790717112218; 
 Tue, 29 Sep 2026 14:25:12 -0700 (PDT)
X-Received: by 2002:a05:7301:d16:b0:33e:6ba8:9519 with SMTP id
 5a478bee46e88-34c6691d2famr1034848eec.25.1790717111159; 
 Tue, 29 Sep 2026 14:25:11 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34c388d0110sm1415413eec.20.2026.09.29.14.25.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 14:25:08 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v3 10/24] tests/tcg/mips64/test_mips64r6: fix include path
Date: Tue, 29 Sep 2026 21:24:25 +0000
Message-ID: <20260929212439.110454-11-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929212439.110454-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260929212439.110454-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: sDmgsnpoCrDwA2zThfB9thJ6itKH78IQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA4NSBTYWx0ZWRfX2o0HpQve5uVR
 hGY68c1oH9bukIAgf1rdCD2I/Wxg/IhvZ/JzvS+5NpiRiJEnuiJBLMyd0LZ1iV1X41AHKCLZa2u
 YWSbs7NfL+vqWH496qB+9zk3kyy5HDMUM6yaNvYHyKmPeqCvMfF7x9rSs5RBTf6nmENh831g3lO
 765gA4uT500/lt/Z1ZAepDDw//zUECB7Hkv/x2dTgff+Jc+1V0LPOSKnwH/iTpgjdB8QFONKrvE
 H3r3OYKhJfrhNiCq4uPPAU3X7pNLLxLAINlZ/xZUKNcgd6Z7o2lh4AJiNOXDdiidiIJ2Z7fxoX6
 EdzUioJSbHwTl/XG7Aqr2TpGPh0w5lvjfNpEEiBV7RmALP8Uhkq7jqivgdPihPsF4UPn9unm/QD
 gJQ3j9t3LgB9mT+FS8ZGRvlCxs3sse4nScyy/GpQRUAjWa3w6vFBo+xhH8Gez16FY/HzwrYLi8e
 Mz1ih6ICMj6VfrKTvRA==
X-Authority-Analysis: v=2.4 cv=cokOAF4i c=1 sm=1 tr=0 ts=6abc2cb9 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=XxA8iSUrf-6v42RAVLYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: sDmgsnpoCrDwA2zThfB9thJ6itKH78IQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA4NSBTYWx0ZWRfX/VByEwY5FE6h
 bng9dWz52fHpRLeibSBq9uhvzsL8YmgYYxRZAo9/XFXaoZ3Yq/CkjWnsZjJi6ovo2tTl4WxR68d
 RviUwOYWDURF0cNwnweo2fWb4Zc3Fg8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 suspectscore=0 phishscore=0 impostorscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290085
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

Acked-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/mips64/test_mips64r6_and.c      | 6 +++---
 tests/tcg/mips64/test_mips64r6_bitswap.c  | 6 +++---
 tests/tcg/mips64/test_mips64r6_clo.c      | 6 +++---
 tests/tcg/mips64/test_mips64r6_clz.c      | 6 +++---
 tests/tcg/mips64/test_mips64r6_crc32b.c   | 6 +++---
 tests/tcg/mips64/test_mips64r6_crc32cb.c  | 6 +++---
 tests/tcg/mips64/test_mips64r6_crc32cd.c  | 6 +++---
 tests/tcg/mips64/test_mips64r6_crc32ch.c  | 6 +++---
 tests/tcg/mips64/test_mips64r6_crc32cw.c  | 6 +++---
 tests/tcg/mips64/test_mips64r6_crc32d.c   | 6 +++---
 tests/tcg/mips64/test_mips64r6_crc32h.c   | 6 +++---
 tests/tcg/mips64/test_mips64r6_crc32w.c   | 6 +++---
 tests/tcg/mips64/test_mips64r6_dbitswap.c | 6 +++---
 tests/tcg/mips64/test_mips64r6_dclo.c     | 6 +++---
 tests/tcg/mips64/test_mips64r6_dclz.c     | 6 +++---
 tests/tcg/mips64/test_mips64r6_dmuh.c     | 6 +++---
 tests/tcg/mips64/test_mips64r6_dmuhu.c    | 6 +++---
 tests/tcg/mips64/test_mips64r6_dmul.c     | 6 +++---
 tests/tcg/mips64/test_mips64r6_dmulu.c    | 6 +++---
 tests/tcg/mips64/test_mips64r6_dsllv.c    | 6 +++---
 tests/tcg/mips64/test_mips64r6_dsrav.c    | 6 +++---
 tests/tcg/mips64/test_mips64r6_dsrlv.c    | 6 +++---
 tests/tcg/mips64/test_mips64r6_muh.c      | 6 +++---
 tests/tcg/mips64/test_mips64r6_muhu.c     | 6 +++---
 tests/tcg/mips64/test_mips64r6_mul.c      | 6 +++---
 tests/tcg/mips64/test_mips64r6_mulu.c     | 6 +++---
 tests/tcg/mips64/test_mips64r6_nor.c      | 6 +++---
 tests/tcg/mips64/test_mips64r6_or.c       | 6 +++---
 tests/tcg/mips64/test_mips64r6_sllv.c     | 6 +++---
 tests/tcg/mips64/test_mips64r6_srav.c     | 6 +++---
 tests/tcg/mips64/test_mips64r6_srlv.c     | 6 +++---
 tests/tcg/mips64/test_mips64r6_xor.c      | 6 +++---
 32 files changed, 96 insertions(+), 96 deletions(-)

diff --git a/tests/tcg/mips64/test_mips64r6_and.c b/tests/tcg/mips64/test_mips64r6_and.c
index 4d6cf2e1f1d..38ae641e907 100644
--- a/tests/tcg/mips64/test_mips64r6_and.c
+++ b/tests/tcg/mips64/test_mips64r6_and.c
@@ -22,9 +22,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_bitswap.c b/tests/tcg/mips64/test_mips64r6_bitswap.c
index df3d1b11f6b..ae2f74b34ee 100644
--- a/tests/tcg/mips64/test_mips64r6_bitswap.c
+++ b/tests/tcg/mips64/test_mips64r6_bitswap.c
@@ -22,9 +22,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_clo.c b/tests/tcg/mips64/test_mips64r6_clo.c
index e7ecdc59100..611dcc9572f 100644
--- a/tests/tcg/mips64/test_mips64r6_clo.c
+++ b/tests/tcg/mips64/test_mips64r6_clo.c
@@ -22,9 +22,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_clz.c b/tests/tcg/mips64/test_mips64r6_clz.c
index a77a8e4eb59..3f89cbdec2f 100644
--- a/tests/tcg/mips64/test_mips64r6_clz.c
+++ b/tests/tcg/mips64/test_mips64r6_clz.c
@@ -22,9 +22,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_crc32b.c b/tests/tcg/mips64/test_mips64r6_crc32b.c
index bb1f3f69249..7b8955cffd5 100644
--- a/tests/tcg/mips64/test_mips64r6_crc32b.c
+++ b/tests/tcg/mips64/test_mips64r6_crc32b.c
@@ -11,9 +11,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_crc32cb.c b/tests/tcg/mips64/test_mips64r6_crc32cb.c
index 1439d44bf20..58479c2733b 100644
--- a/tests/tcg/mips64/test_mips64r6_crc32cb.c
+++ b/tests/tcg/mips64/test_mips64r6_crc32cb.c
@@ -11,9 +11,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_crc32cd.c b/tests/tcg/mips64/test_mips64r6_crc32cd.c
index bf258e0696d..417cd895fb9 100644
--- a/tests/tcg/mips64/test_mips64r6_crc32cd.c
+++ b/tests/tcg/mips64/test_mips64r6_crc32cd.c
@@ -11,9 +11,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_crc32ch.c b/tests/tcg/mips64/test_mips64r6_crc32ch.c
index 0e7b67732e0..9ae4804e687 100644
--- a/tests/tcg/mips64/test_mips64r6_crc32ch.c
+++ b/tests/tcg/mips64/test_mips64r6_crc32ch.c
@@ -11,9 +11,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_crc32cw.c b/tests/tcg/mips64/test_mips64r6_crc32cw.c
index f7110b3a0a4..2e1ca6f836f 100644
--- a/tests/tcg/mips64/test_mips64r6_crc32cw.c
+++ b/tests/tcg/mips64/test_mips64r6_crc32cw.c
@@ -11,9 +11,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_crc32d.c b/tests/tcg/mips64/test_mips64r6_crc32d.c
index e391be803f7..d916ee2586b 100644
--- a/tests/tcg/mips64/test_mips64r6_crc32d.c
+++ b/tests/tcg/mips64/test_mips64r6_crc32d.c
@@ -11,9 +11,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_crc32h.c b/tests/tcg/mips64/test_mips64r6_crc32h.c
index 100f02c7dda..72575e95858 100644
--- a/tests/tcg/mips64/test_mips64r6_crc32h.c
+++ b/tests/tcg/mips64/test_mips64r6_crc32h.c
@@ -11,9 +11,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_crc32w.c b/tests/tcg/mips64/test_mips64r6_crc32w.c
index b4f5f4bbee2..4518b4fe482 100644
--- a/tests/tcg/mips64/test_mips64r6_crc32w.c
+++ b/tests/tcg/mips64/test_mips64r6_crc32w.c
@@ -11,9 +11,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_dbitswap.c b/tests/tcg/mips64/test_mips64r6_dbitswap.c
index 377835940d9..7473f3f0ceb 100644
--- a/tests/tcg/mips64/test_mips64r6_dbitswap.c
+++ b/tests/tcg/mips64/test_mips64r6_dbitswap.c
@@ -22,9 +22,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_dclo.c b/tests/tcg/mips64/test_mips64r6_dclo.c
index eb41fbdfdf7..a6f8688b76c 100644
--- a/tests/tcg/mips64/test_mips64r6_dclo.c
+++ b/tests/tcg/mips64/test_mips64r6_dclo.c
@@ -22,9 +22,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_dclz.c b/tests/tcg/mips64/test_mips64r6_dclz.c
index be393ac1992..ab2d3eadeff 100644
--- a/tests/tcg/mips64/test_mips64r6_dclz.c
+++ b/tests/tcg/mips64/test_mips64r6_dclz.c
@@ -22,9 +22,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_dmuh.c b/tests/tcg/mips64/test_mips64r6_dmuh.c
index eb21615f952..490c81f884a 100644
--- a/tests/tcg/mips64/test_mips64r6_dmuh.c
+++ b/tests/tcg/mips64/test_mips64r6_dmuh.c
@@ -22,9 +22,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_dmuhu.c b/tests/tcg/mips64/test_mips64r6_dmuhu.c
index 7316d79e2af..28dd2026418 100644
--- a/tests/tcg/mips64/test_mips64r6_dmuhu.c
+++ b/tests/tcg/mips64/test_mips64r6_dmuhu.c
@@ -22,9 +22,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_dmul.c b/tests/tcg/mips64/test_mips64r6_dmul.c
index 3ac1965cca3..2a33d678992 100644
--- a/tests/tcg/mips64/test_mips64r6_dmul.c
+++ b/tests/tcg/mips64/test_mips64r6_dmul.c
@@ -22,9 +22,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_dmulu.c b/tests/tcg/mips64/test_mips64r6_dmulu.c
index 0862780e3de..161d1fe96bc 100644
--- a/tests/tcg/mips64/test_mips64r6_dmulu.c
+++ b/tests/tcg/mips64/test_mips64r6_dmulu.c
@@ -22,9 +22,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_dsllv.c b/tests/tcg/mips64/test_mips64r6_dsllv.c
index 4f719efda12..fc93e0b218a 100644
--- a/tests/tcg/mips64/test_mips64r6_dsllv.c
+++ b/tests/tcg/mips64/test_mips64r6_dsllv.c
@@ -22,9 +22,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_dsrav.c b/tests/tcg/mips64/test_mips64r6_dsrav.c
index 024d508ca87..e496e8fa83a 100644
--- a/tests/tcg/mips64/test_mips64r6_dsrav.c
+++ b/tests/tcg/mips64/test_mips64r6_dsrav.c
@@ -22,9 +22,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_dsrlv.c b/tests/tcg/mips64/test_mips64r6_dsrlv.c
index fd1c398ffde..2c4c04f4c42 100644
--- a/tests/tcg/mips64/test_mips64r6_dsrlv.c
+++ b/tests/tcg/mips64/test_mips64r6_dsrlv.c
@@ -22,9 +22,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_muh.c b/tests/tcg/mips64/test_mips64r6_muh.c
index ff1ae6fd9ce..8f371e22e61 100644
--- a/tests/tcg/mips64/test_mips64r6_muh.c
+++ b/tests/tcg/mips64/test_mips64r6_muh.c
@@ -22,9 +22,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_muhu.c b/tests/tcg/mips64/test_mips64r6_muhu.c
index cb2752767a5..79824c05b13 100644
--- a/tests/tcg/mips64/test_mips64r6_muhu.c
+++ b/tests/tcg/mips64/test_mips64r6_muhu.c
@@ -22,9 +22,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_mul.c b/tests/tcg/mips64/test_mips64r6_mul.c
index 5cdc4d56324..9589c4c3a08 100644
--- a/tests/tcg/mips64/test_mips64r6_mul.c
+++ b/tests/tcg/mips64/test_mips64r6_mul.c
@@ -22,9 +22,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_mulu.c b/tests/tcg/mips64/test_mips64r6_mulu.c
index ccb3bdc1ac5..72b4d038cfe 100644
--- a/tests/tcg/mips64/test_mips64r6_mulu.c
+++ b/tests/tcg/mips64/test_mips64r6_mulu.c
@@ -22,9 +22,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_nor.c b/tests/tcg/mips64/test_mips64r6_nor.c
index 21005ddc53b..04b841c8df1 100644
--- a/tests/tcg/mips64/test_mips64r6_nor.c
+++ b/tests/tcg/mips64/test_mips64r6_nor.c
@@ -22,9 +22,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_or.c b/tests/tcg/mips64/test_mips64r6_or.c
index 345b4544fe0..fde9601a78d 100644
--- a/tests/tcg/mips64/test_mips64r6_or.c
+++ b/tests/tcg/mips64/test_mips64r6_or.c
@@ -22,9 +22,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_sllv.c b/tests/tcg/mips64/test_mips64r6_sllv.c
index a5fa72b7278..46136de0634 100644
--- a/tests/tcg/mips64/test_mips64r6_sllv.c
+++ b/tests/tcg/mips64/test_mips64r6_sllv.c
@@ -22,9 +22,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_srav.c b/tests/tcg/mips64/test_mips64r6_srav.c
index 79e1a047eb7..94c528f8ab8 100644
--- a/tests/tcg/mips64/test_mips64r6_srav.c
+++ b/tests/tcg/mips64/test_mips64r6_srav.c
@@ -22,9 +22,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_srlv.c b/tests/tcg/mips64/test_mips64r6_srlv.c
index 1f8c45d8cc8..993d0b75205 100644
--- a/tests/tcg/mips64/test_mips64r6_srlv.c
+++ b/tests/tcg/mips64/test_mips64r6_srlv.c
@@ -22,9 +22,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
diff --git a/tests/tcg/mips64/test_mips64r6_xor.c b/tests/tcg/mips64/test_mips64r6_xor.c
index 7e36fee517a..3ab67ea0555 100644
--- a/tests/tcg/mips64/test_mips64r6_xor.c
+++ b/tests/tcg/mips64/test_mips64r6_xor.c
@@ -22,9 +22,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../../include/wrappers_mips64r6.h"
-#include "../../../../include/test_inputs_64.h"
-#include "../../../../include/test_utils_64.h"
+#include "../mips/include/wrappers_mips64r6.h"
+#include "../mips/include/test_inputs_64.h"
+#include "../mips/include/test_utils_64.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT)
 
-- 
2.43.0


