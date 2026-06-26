Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14AE4C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 23:43:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdG9P-0003Xj-Ei; Fri, 26 Jun 2026 19:39:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wdG9O-0003XR-If
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 19:39:58 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wdG9M-000437-T9
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 19:39:58 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65QN02v12207693
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 23:39:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 H21yoKvmbMIPgdRRrw3U6ivG2dyPBgVcsCsVENzuXjE=; b=h0VVhABWoaLrk/ct
 2Rd5ieJtm4nirGVFl8a9NjVCSlG95R8yef/LVJh33kC5/sCu+ABeUPwHKXYx3T5d
 ujjcnG6/SZTLEAtT8GjmLz6nfp+2RdtlYR5RNvehjbZK3mLLtab48e8hLaeVmZIz
 lOp2cBQWpb/Fu3oSgwTi/ZEvJx4E57VodP1wWibJU3ukq3C5HASvKy2b7oyr+qjr
 05LWMMhzJvyWuSBrIp8r5unufZF8tkEXS4QHpPlzXMF5wa2av7Efu0PSynmNh9zt
 O9bKZX1Uk3sJcdpcXuYBAC/NoKVV8xtavIhX/vySP1KeGSDi67jztu/DEhuo6/aR
 hKmhWg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f1vm2hc9j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 23:39:45 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30c95b0e22aso4417130eec.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 16:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782517185; x=1783121985; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H21yoKvmbMIPgdRRrw3U6ivG2dyPBgVcsCsVENzuXjE=;
 b=ROYJK8t6L0/JgfTVIFve1evkwCisajpNDoppnCinVy0MAtYO64sgRiFVFdon02uSp5
 TZgkeRpkrwMfftYYV1OgUKcCVMdNngJFv3HnK/b+/uPfOqgHmhCih8ySdAYpGCgHp9jJ
 8bBKqqo2x4tJNbrkiu4/4LdZOFmJrS6QOoWFixhBwm5L1AanlNHZXQgLEoJN9T87A4EH
 OCSphOPP3vI+ynA+OjpTfxrmata9v6oPeAX2vy8lK0WiUkxZBSew4KIFsq4R1lLZaqxc
 CGcU93clUXE23W6WjixMJdoTcAHkrAIQN1pW3MF2pdq0DSl0K9GnIisR5CdMfe9rgXkA
 leNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782517185; x=1783121985;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=H21yoKvmbMIPgdRRrw3U6ivG2dyPBgVcsCsVENzuXjE=;
 b=JxSgBETNdLFDCPsJuYGLxJ6RtC3QQI3r26wudI2pc/E47CXjcu8xSUSgXNo9tlCeoI
 J/wVLC+Z7+DjIco5es04Imu/DoXK6QRyM3ke3a/1ZlwYsvYtyJ21+8hpfV4x6upYUKWV
 PwxlrD495taLcOHu1X5HwWgTOQHKOfzSdvcC+thDiPtPRjniTeYxJ/ApsXk7unxqgIwv
 AJA4Rvjh+SuF0ZWjAAEH7pbfjT/OUL5vPUC4YMjTq7ujWAQRMQEhVoL5AMlqGybvL5/T
 0RTdWd7Rq3ErE+5DMGbO0WSukV2rkHayuWcio0TOsmPLkac0YuKZJ5TQgUUal2UnjHCY
 dqkw==
X-Gm-Message-State: AOJu0YyVzcq65bGdTU0jVQvEqr5+CLrR85dddzEOQ0pdpKC0kFUg+o8P
 z0w6/kz8XlQpDydkab4eOF4dYWd9TtKukYBxjOs3RQqhkgxRMcK9xeDBz0TqeVie2iTbah8iPxp
 4zuKt6eksrdWTQ0epngD2vcH0cPrg9FWFlnekY/93J0tkRi3nuf7WwiazzFLmMr5VHQ==
X-Gm-Gg: AfdE7ck9zTNqPXJF4yWHgs/Sra8dF7oQvqCafKDqIzYpIIYo76bf7ZXHpnyafQepwLK
 JhkecSFg2A3El3rfsk9AM/Hn2Q2J/RR1BuirWKtKCqOZli2VHgD4RaLx0ruF474Uo80IQfhchA4
 /HRxxiFa37cqSyjQx8uNvq1hZX4oT+KhpFCEh/i+JiwwewSBT2XDYaWlikqas/8txpDRrV368jT
 794ccBX9NnLK5LIsL+Nn47TmlO8U48JaWfx0Y3sGaqNrejnZ+4x7gc6DjO2ES6qI9vh0a8rCGsi
 Y50v7soRcTCaVS1pG5z617rc2UyQ5o5e02RdAerTAf3RKoiechH0tceaKvxeEJ0Pd9OY/djm2y/
 mEKPfxMSsxE2fLjbd1TRfzguxQmuD/56l66w1q4wRn13mpg1J+dqO4hRE0cTWUCfnANjsVkbk+4
 0eXxXCyQ==
X-Received: by 2002:a05:7300:2326:b0:30b:e3c7:27f0 with SMTP id
 5a478bee46e88-30c84c04eb1mr8892848eec.13.1782517184906; 
 Fri, 26 Jun 2026 16:39:44 -0700 (PDT)
X-Received: by 2002:a05:7300:2326:b0:30b:e3c7:27f0 with SMTP id
 5a478bee46e88-30c84c04eb1mr8892812eec.13.1782517184385; 
 Fri, 26 Jun 2026 16:39:44 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c52c591sm29369756eec.7.2026.06.26.16.39.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 16:39:43 -0700 (PDT)
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
Subject: [PATCH v2 15/37] tests/tcg/meson.build: introduce wrapper
Date: Fri, 26 Jun 2026 16:38:56 -0700
Message-ID: <20260626233918.158740-16-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626233918.158740-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260626233918.158740-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDE5NyBTYWx0ZWRfX0qyBxdQ9qknx
 k4QZmjLgVd0UeCGyM3c+Lx1ykpeTZPvBK02ID7JLoNUlYrSNX1+IxCZ0+xhultWbgaWwx8pAMeQ
 FeJDrW2zd9jtx/leIv+xz7w4Du5PCUwY6cgS5+tlA7rTT1iFelV5YFc8Clo+6bOJKDCnEb7ZHg+
 VjkeUcf4yNcnE5KfKwajjmkdkgIzhsqiaXJi9NTCNnjjRi9iq+jLyzrOpVXzqO2BN5hE+9d1AYl
 n4Sr9ERGmGu1mjP8rIL+3MSDnmtlmc0Wn37rTmNilsFIP5v6IE8Mj6Glpk/HoaQGuAYYJsYAnwX
 COrnfrHJfD2ZhNpmi+l77yKpd74JC1JmCQwB+YTZa1AfLb8HJXDL3QUsBFWjmschJRGlD7XFhu9
 7+x+MShI2777rKprZzP9MdEeOpMaX2Nh0tofvJcximhtFfbKtbe0a1qacrCg726hp0gVlQGAxph
 n09UyVDZFEw3XyD1YCg==
X-Proofpoint-GUID: -DjL37fbsTrzhIDlulRkRdi2zf63iHSC
X-Authority-Analysis: v=2.4 cv=UIvt2ify c=1 sm=1 tr=0 ts=6a3f0dc1 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=oeoYDfJPrL2azRNJ8Y4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: -DjL37fbsTrzhIDlulRkRdi2zf63iHSC
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDE5NyBTYWx0ZWRfX3TJVWOmwhkeb
 VROXSliLsGZVo9NZkSz6LkIzisMNTHeovdPLY21/lUDrRhElWcfTORyLeSzO+RF3B7zNQ39/11j
 IbBVVKsdq2UziYa2l7GsnLOpb1V4WxY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_06,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 spamscore=0
 phishscore=0 bulkscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606260197
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

We add possibility to wrap a test command through a given script. This
can be used to provide any kind of ad-hoc check for specific tests.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index fa9c0d15342..ad4024f793b 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -26,6 +26,7 @@ tcg_tests = {}
 #           'qemu_args': ['qemu command line flags', ...],
 #           'gdb_test': ['gdb test args'],
 #           'env_var': ['VAR=value', ...],
+#           'wrapper': [program_to_launch_test, 'args'...],
 #           'plugin_test': {
 #             'plugin': 'plugin_name',
 #             'args': ['plugin_args', ...],
@@ -87,7 +88,7 @@ foreach target, plan: tcg_tests
       # return a clear error if user misspell a setup entry
       foreach key, _ : setup
         allowed = ['exe_name', 'env_var', 'cflags', 'gdb_test', 'plugin_test',
-                   'qemu_args', 'test_name']
+                   'qemu_args', 'test_name', 'wrapper']
         if key not in allowed
           error('unknown tcg setup entry \'' + key + '\' for test ' + src +
                 ' (possible: [' + ', '.join(allowed) + '])')
@@ -201,6 +202,10 @@ foreach target, plan: tcg_tests
               ]
       endif
 
+      if 'wrapper' in setup
+        cmd = [setup['wrapper'], cmd]
+      endif
+
       # some tests expect QEMU env var to be set
       cmd = ['QEMU=' + qemu.full_path(), cmd]
 
-- 
2.47.3


