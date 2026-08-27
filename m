Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4889C61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:17:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziNZ-0004wU-Kw; Thu, 27 Aug 2026 18:15:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziNX-0004vO-A3
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:15:23 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziNV-00061O-I3
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:15:23 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJMGDm1803885
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:15:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 v9Sa1icVd6BohV+0UjJ3GbEwIbtEZWeDP4ARKjR0Nc0=; b=L2yfiRs0pXpDqgUg
 HcuzCjl136NbKWFtZtYHnhVZbJwJdcPP+SEnwsErx4zpqpUi9ErSCFHF70ZM76BZ
 4eEJWbVFMFZ/ALxz8NUdW6f5GfRHtCdmoogjsvfPBsbMS7dd6PEU0MW/t0j3wcG3
 wzgzagMSbaYR38aY9tHIIyKt6rLpKUEGTnOE7sp6M8f5usdi0uX/LEkkIzrlo6U0
 N2Twj776j0Swo1NQruhekWolJLvgA8rg1lWcf5YxAJ+pY6cyVZlDfuXKJi9GdOgb
 6L9UmE7NQiPSEswc2QbkSxVKGQVjWGtHbAhKB9AIu9uWZg1BPO1rSC2hMtivdLYC
 ihyiIw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gatfxgv3b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:15:20 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-84e4ef486c7so288314b3a.1
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787868919; x=1788473719; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=v9Sa1icVd6BohV+0UjJ3GbEwIbtEZWeDP4ARKjR0Nc0=;
 b=iFa7N9ZLwWByYUcGJFvBvoAcIedqzL7Xlf6+Rwlc7Lxo86mDi9IFGno8H33crxxFJL
 gT42Bf5gigeFIb2tEJov37Feax5IthYNqoDKQjm/DXtxxrHizDUYmFt0LZObhPonnQAW
 cgzMDZr2l0AoIVkZmxcU01Cnh8eP3XUERrUpCtameVR26GvXR0w6mn643E0Gdqwo0Rjb
 L7nUsQx/AZmPXUK078/4wgOD73p5tbbqmNsGoM47OwCfZ3RC3yUPNTZBvWyn1DtSHz7O
 3ULLl86hL1ZrZsu6xSUWQ1eXX3OK0+IprLmSKBHPQw5c1gYVnUSw2WTE7q5/FnMDS9iF
 TBjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787868919; x=1788473719;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=v9Sa1icVd6BohV+0UjJ3GbEwIbtEZWeDP4ARKjR0Nc0=;
 b=sdED6fIqmEyXam+dnabEsD9NpN7WfxHhxrT4xTgX18l2Mv5Yw2ipVCt9G1/FJyJRoD
 GCm8Hc2Qc0wCVodKeYhyRKHWULFuWpY+YNxnkwIiBsn+k5TMrKMclHq/h6dqWIVOzr7f
 B/TPueQnA9M6xqC6E99LECb+779wU7Zq7ihG6H0+8JgduwIVPI6NUpTUe86sl3itnSO7
 yKPG6VG7aLJ1RxJ7jn0qexU4nOuwOK8EayKeXNBs1OoGJn+iJnunSAxPrxpFiP81BO5Q
 AIumfE7cRnUFFX8PFzCTfMzZQIhlQqeu0LqWqbeNvSFpXKgUNASnavXCspbjhWd5q1Xl
 CEPw==
X-Gm-Message-State: AFuF++mqb5G1K5bu1nMYvVex4olaf5O7wBxB0KqKbkTawokfu55K0s9v
 DZIKnkOgXc1LIROQHn5LvNLLEBoDe/fkfAF/jKuXG91sBsvpTXyoHMkmZJLy0Hp/KzVUGgaxyn1
 y89eTLPD09duERG7SCQ2BpZN5luKRzxKnPXX9hN14GjVoj0ziggQkoUkALaCZxWWcag==
X-Gm-Gg: AR+sD107UCu4uEsveFj9Zz4P5fWj8TSYBTpFxu6qmeb170mN+FPWOUVBFGqxqTTuTnI
 nr3MHzG3vbYTfRaQ6ohYgIIaHSbvJJ7JffREavhtQwdc01Xyt8FwDqCUnzIsBhQn2IHLziaw5jp
 OMDATxqIW7vLPxjRbA54lCHCJIwqTdBzuk6xs76+oWiigBhMn1YQvVYCYPZSl3Z/DVj61pIH6by
 2SYNG5HWnlu8A1pwm5OkLrBKqyyT3LN54f8j4BwxN7EMw/kIZwx4tupBBg6c4/iFpGa3ThTOKl0
 kghPdPVtQBbKKNw4Jik5WBRLTD/TvLAuW955dgsufBoGxRxoeFj2NOxhZ6WEnYgevsGpOG8QpQN
 gbYP5VJjtYyHzjZZKPGe33PX0HOvrLXdjlpVeQkQ9fsQ5Baptg4ZdvbXPhb8=
X-Received: by 2002:a05:6a00:929e:b0:854:2071:be08 with SMTP id
 d2e1a72fcca58-854c6b7fa20mr11427431b3a.6.1787868919528; 
 Thu, 27 Aug 2026 15:15:19 -0700 (PDT)
X-Received: by 2002:a05:6a00:929e:b0:854:2071:be08 with SMTP id
 d2e1a72fcca58-854c6b7fa20mr11427381b3a.6.1787868919112; 
 Thu, 27 Aug 2026 15:15:19 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535cf4b213sm2524104b3a.55.2026.08.27.15.15.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:15:18 -0700 (PDT)
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
Subject: [PATCH v8 009/105] tests/tcg/meson.build: introduce qemu_args
Date: Thu, 27 Aug 2026 22:13:30 +0000
Message-ID: <20260827221506.91574-10-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=UKLt2ify c=1 sm=1 tr=0 ts=6a90b6f8 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=BgapuaGD2VAwZ5NCc8gA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 7xKQkEoXoa74mWsFJkYnu2MHpDR2lvqN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfXxqH0W5yBnylj
 S+KqWvEwnCyQDQb1I4lu9goDNXgeZNvclfEqHi7oG25bL1wmKXdGS/vP2mObUgGeQtiHqOtpB9m
 qi6U9Rd/iJpnn2gX2nkYFTXl1s+JsKJBscHR/aXBYwJLXxOxP43I0cGy+bpmtZApctHolO2e1ob
 RMgslhfLhjp7bE6TGwJBBUgpP8BchCeDACcMO77Q6oTSiDIYtnr8yxea+gvZw0FoLc+Rr89hcGI
 tIUq0jg/P94snLfDs2J7jh6DnOyn0Ru5s8ASkYA4V0M+0HdpWik4EB2Bdx6rnDDYD3WAV/OxL13
 cP+lqTBG+82R+pszo6AZWoxWlMTvpdqsOi9C0bjrkINoEcxfyx7R0TnphXnKqdeunEV7dHJyoAt
 dVJZO3klXHsKSvH7q+rbxbESfa/a3t+zUr6q5BrGeZA2Wzj8g0W0nKsPY/p1r0VHTUOusRynOE4
 7+IL0czSNKzMO9oetDQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX093ufnOXEB6c
 SMFULIIF5YfX1K5yQZ99AC6X2xEt+GaOLaj+5lUCBz/PWVFrO0vu3D9MomSjIsRtkYyNagoTxEq
 /R7TRgU2K2I4RwdSxm9w1otNP5aC1bY=
X-Proofpoint-ORIG-GUID: 7xKQkEoXoa74mWsFJkYnu2MHpDR2lvqN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
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

We add possibility to use custom arguments when calling qemu for a test.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index e8d8cfbcf88..a7699b7f62d 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -14,6 +14,7 @@ tcg_tests = {}
 #           'exe_name': ['provide an alternative binary name'],
 #           'test_name': ['provide an alternative test name'],
 #           'cflags': ['additional cflags to compile test', ...],
+#           'qemu_args': ['qemu command line flags', ...],
 #         }
 #       },
 #       ...
@@ -56,7 +57,7 @@ foreach target, plan: tcg_tests
     foreach src, setup: t
       # return a clear error if user misspell a setup entry
       foreach key, _ : setup
-        allowed = ['exe_name', 'cflags', 'test_name']
+        allowed = ['exe_name', 'cflags', 'qemu_args', 'test_name']
         if key not in allowed
           error('unknown tcg setup entry \'' + key + '\' for test ' + src +
                 ' (possible: [' + ', '.join(allowed) + '])')
@@ -110,9 +111,13 @@ foreach target, plan: tcg_tests
       endif
 
       depends = []
+      qemu_args = []
+      if 'qemu_args' in setup
+        qemu_args = setup['qemu_args']
+      endif
 
       exe = built_tests[exe_name]
-      cmd = [qemu, exe]
+      cmd = [qemu, qemu_args, exe]
 
       # some tests expect QEMU env var to be set
       cmd = ['QEMU=' + qemu.full_path(), cmd]
-- 
2.43.0


