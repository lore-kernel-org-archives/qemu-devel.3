Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20F2CC61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:16:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziNt-0005dK-F6; Thu, 27 Aug 2026 18:15:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziNr-0005W7-6G
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:15:43 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziNp-00067I-3t
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:15:42 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJLjpR779132
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:15:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 i7lOBJmzAhzCql4OqEzwcbVaUI7nsVb0oELiNNb5eQs=; b=oNn4uZYQBqtNzzCT
 fYRJ2OCAGsue5Qg1mENafpAWPEPZv2yOr+YPy8soxGM+NNAEi7HluHjdFUpEu+Nv
 F2DavDOxvspPLJlnCfnYbM9EiA1Mrplj1R9l6nuouYG4wJvmOOW9vR66unmcSswE
 SLS3+DhlLPW6yIdWS6XMZTg6wUpBsTL3PHdAFLdacJ/pOK6wu2JSZClwWLeWP2Ig
 D8kZDd7Lrjh2k2xEytxyZfClJ8HZ/Rh36TlcvXo6xdr+B7pf0CsoU1h1MFf0L9Uo
 H3fSPKL5NFwcwRogutHjJ3xLPuyjf/nYq0feh8ry7pXx2YTdDGwAfgu1WdQtxA1z
 Ay5MyA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4garee1qd2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:15:39 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cc1c62f0d60so625801a12.1
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787868939; x=1788473739; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=i7lOBJmzAhzCql4OqEzwcbVaUI7nsVb0oELiNNb5eQs=;
 b=DYq56YBOX4yHnhIgxY5vTUG06JhYNyTwV9IqyV1e79K3pDJdZkCMPDpjY3/7at7cvw
 yveJbHvRq+/Xanl5z+0VEqDTluF2guhDrCtnijeqO18kZR+cqNoOnj9J+UsWnOAJKtFe
 1KQCGYpMdlcrBIkExfC3bpdBKBSP59TdliutadhpGidwy/gKfrIM74/yl1JyZw29BGmF
 3LiBWZrU8p7sMJ+9b76G7ikevRIHNdHIpaBIF4x5+bTd4Tr+mxGuu3qzG91O/ZSFIZ09
 F4yJ3uQ21/XGy8kH2rngvR68qgONyBNZYL+Si4jWGcRCuaycFoly46vR+90AsRpCHUVi
 +FaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787868939; x=1788473739;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=i7lOBJmzAhzCql4OqEzwcbVaUI7nsVb0oELiNNb5eQs=;
 b=oqt0ejZMslIOVQga5TwbNw7HJXXHMT6ZG1W4PTUBHv6fUA/BTfaCmvss1g4O0/MhLy
 T9rKvvzA+LBrsVId/PlpJbdVHfkXzZRG9jMz3YWxVo0h54vnMVWJGX0TFKIj+wVAS/in
 Xu1sTNggQhVk2g65Icml8gMiZ/pxdOkERRHlgXezhAG7b1ZdVeMHZw7hzuJJJ5HpOv/X
 3/x/Sx/xeUmzdlhsaN02GTd/4/a6OoSwXYqTMW2XFQyf59TH+mQtkuYhzJWp/B7XvjHM
 +Ql5Ut8Eus7QIhHT07JzU+EfPHM5jLMgnjQFzTZl9Js886NHP/PX1AJqQtehXOjINfAV
 HIug==
X-Gm-Message-State: AFuF++nagzDxGU9mu9QeW0aXfDQssfz2Pd4d3b9RrFLnvhJdx2RoM/mY
 3mvokT/8TGcww/uMTIoXsDYmes8eHZc9HMblGdH8XfF8jd8554VxE/PhehJpDeX89F2x3RfDbIR
 ji34Qj7nIW3kmm8EHx8yTr+rq4Z9wyZpVi4nvLRQmwgjM71EeV9imFQQ1kA38tjzV3g==
X-Gm-Gg: AR+sD103lH6qJjGkimRW+d08ZHOGPMDa0sIskI/d2HnqFXMW1XbuyX3litI4ecevQg+
 jxI4dsxTPPx7/09lIx5C6KDOrK/oK3LamJgJwRZSUZAlOBQ9j4lBcf7hdevaK6W/OOBi5rluev6
 5q/Nwbq/euw1nbFQ+vZYqaupa08Gu0EtuuaPGm7JgjfcbJH/aHempdzGPAfYD9LUpgYr3A0ss9X
 j7NKHLhOdQ3vmW9C27YpwA567x2SumF0afDA2C5sfAhPTtFo1uEYn6oSokzuPJ+5+f5aVbF6WCF
 8MSEWNMIicbw3PbJFACwuZKGnJqWLip2kCNf0IJBJkSNdmro6J5vQMIiSykyaThB1+LDHnDoQtX
 siUIUwv/b6VWi2loQYAlRde7YyMi7ogpQqy4KaJBNQkOnct3uYLhoPPrP5po=
X-Received: by 2002:a05:6a00:13a0:b0:855:a211:6679 with SMTP id
 d2e1a72fcca58-85628b7d138mr4052047b3a.5.1787868939076; 
 Thu, 27 Aug 2026 15:15:39 -0700 (PDT)
X-Received: by 2002:a05:6a00:13a0:b0:855:a211:6679 with SMTP id
 d2e1a72fcca58-85628b7d138mr4051971b3a.5.1787868938651; 
 Thu, 27 Aug 2026 15:15:38 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535cf4b213sm2524104b3a.55.2026.08.27.15.15.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:15:37 -0700 (PDT)
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
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v8 024/105] tests/tcg/meson.build: move gdb_arch support check
Date: Thu, 27 Aug 2026 22:13:45 +0000
Message-ID: <20260827221506.91574-25-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX3tbJExWFcdhi
 5eOHf4W1F6DlGuTrU/ETNFETF88GJCgx6l7JWx6QlI4sgEmeg7UiSmPtjztK/ljQVmeTP8i+wEt
 veiYAkECDtHPRCdRor8JnYPv1sYOfSwjyuEBO8I8C4KWV5anuuNpVN7b0f8eQ2imQouFQ6BnRhq
 SBZr0ydvvdIm3Y4PVbtgLLki5WujIbpljypyZdS9d8Tf3vQfp3jedIyqz9AUbMzFioBzPKbnwVz
 ovI5wQK/uSE8u37T1ytfggbX71KPbsMMaiZekhaDanosd0vy7sBgC7wY6zXLVL7fqhvqUB+FGiE
 JXXGgqcGnA+MN2wcBXJ7FIR2apsJVwtPZYlPfwm1r/qp366DCocjBUMISHXKD5fdLhSIZCAvniS
 O3kLNI408J7XNgK8l/Gs9dlOEfRSfiIvR5sBsURi5mFkyDdoR1nFw1DZFutPA3qVyI97WCoi2gx
 8l2dOXqj30rrdQaF51A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX8LixPBuBgcqi
 Ds9+DFsHJjFDshIddxEcVFaM7tvnPyIQqhJ63xt513eyviJlm9Gok4JkQZf1rII7RdT3pHQPQTJ
 a9kit2YldoBJ0GV441cGgyy6/v95C6c=
X-Proofpoint-ORIG-GUID: niV8sVWj9AkREAxqtUPWRSb00-V2CjWC
X-Proofpoint-GUID: niV8sVWj9AkREAxqtUPWRSb00-V2CjWC
X-Authority-Analysis: v=2.4 cv=e8E2j6p/ c=1 sm=1 tr=0 ts=6a90b70b cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=XzjeZAZuwW6bxlwlfogA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270188
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

This allows to report the correct skip reason instead of saying gdb does
not support a specific feature for some tests.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 7384786f7f8..c227bb52381 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -138,10 +138,6 @@ foreach target, plan: tcg_tests
       # if set, we'll skip test and print the reason
       skip_test = ''
 
-      if 'gdb_test' in setup and gdb_arch not in gdb_arch_supported
-        continue
-      endif
-
       if 'plugin_test' in setup and not get_option('plugins')
         # do not use the skip_test logic, and simply ignore the test
         continue
@@ -284,6 +280,10 @@ foreach target, plan: tcg_tests
         endif
       endif
 
+      if 'gdb_test' in setup and gdb_arch not in gdb_arch_supported
+        skip_test = 'gdb not available for ' + gdb_arch
+      endif
+
       if skip_test != ''
         # still declare test, but skip it and print reason
         cmd = ['sh', '-c', 'echo "' + skip_test + '" && exit 77']
-- 
2.43.0


