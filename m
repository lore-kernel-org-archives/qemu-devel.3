Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0201C61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:11:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziGK-0007ys-2r; Thu, 27 Aug 2026 18:07:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziGI-0007qH-7T
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:07:54 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziGG-0003dc-5R
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:07:53 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJMD2p779594
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:07:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oSRvqgL2uvtBT9ePvRjp7eOopnvLpiDGW089SWdvYdo=; b=Y7hb+S3C7NS8QgLZ
 Pgg2xz2o9sXysYCSBHe3QT8nF1K1SZzhiK2DT2QqMpLrqXhR08/sm92wVJcXCWVc
 KY4BKL0kZEC8Qh0d20tibSMjvxs2o6rmw6GAtVlRuGKXT1jrVyDYrCJQ1HQ2Qorf
 vqxZnHYkiyYWzIDuRYE/eumK3d5ZYbxcqDraq68hcPPcgwJkJaFfipTKFTWD15VS
 lhGZKKmcQfNYylMBSOmNeap7uClAbmO32greup0rHWf1+5ldsvq/DxCHhLsIkH97
 khxgqfAworL+owrNfZsRGeasG3xrwhEM6RmUbF/P/cmKE8BH2rnr6t6mYRtE5oI+
 /c+/Fw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4garee1pg7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:07:40 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-855315ccb64so320565b3a.3
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787868460; x=1788473260; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oSRvqgL2uvtBT9ePvRjp7eOopnvLpiDGW089SWdvYdo=;
 b=jcF/KzGPtZhCmTtPaPNTukpPZYsrZh0hTkJlreTgIp+iMvkzvt/QkhpkBhnMfOs5sw
 QV9AbVnuF80M515ydPOs7W/Q+f+E5JYekjM5fPKqkIZgGq2P+dK9C/Dp8lS4WzQlNF/e
 rduTMCaXTwU2kpk2ws7hZ12nm5aN15l3BK+IHI0nB1gtuIslPinKr1/hTPAhoclmuzDP
 9Y8ilHNb1B6BNSb4LQRhAcXNLaLKegYncdPtlTBEFHANRRtjjFNQvxx+Y2QI130w3w7O
 D7o9y1JRQcmbXOUSfcBynP68V0TCG0gzFguWax9sfak+0G7z3EcZNCsy05fyEzEKrADJ
 SXog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787868460; x=1788473260;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oSRvqgL2uvtBT9ePvRjp7eOopnvLpiDGW089SWdvYdo=;
 b=cWffU2psyAjk9qJnvQ+ilMDYNeNTf4ieEODSvMUwL7Jm92M2LFiq43Ux87jZmjj749
 uiJHQxKvE97va7O2l4U8hoOOgvxIf08VbXsiWJ5n+BwJ9CbNbRs+55RBrev+b9o9QQuc
 TNg1xhiOE5dkYQwVAHabntUioPvZBzjOvqq7j9uQUnRkC7jjhGVPu0moBDCH6ThDxlWm
 iH7E6nfwXnOHvFoL8vp5nxZGTmk5AQMOhSfrjfUPb8kC2GYdeshjjO7OchVF4IcIZm0R
 ywnEi5vk0nkF9RHyZqi93+xAX0VqFOBfTqb1CTNxTkH+7U+GyY5/aJ6ogrP0tMeKvMgn
 SfCg==
X-Gm-Message-State: AFuF++lbfvU1w0ssmTA3EvOXV7zqC/uG26WkO7AHu7Grs9rp8LdYUals
 i/nKSjJ5Oj/7sKLxyzz5Ic5NkAtldhxczzTGk8Mg443XXIVzQKZFuUGdDHQkYnMb26SjEIMMC/7
 BvDnxba2UUs73EQ3SzZ3TXRMWxvN+qPaoWn9avY5+xB4HN1HpJUOO8BQAlIICjUI2GA==
X-Gm-Gg: AR+sD10c4MKbAmzSWciH9+M5fc2UCfH0CIsUCkY9u+0HtZD2pB7vM+Fu9fJ3cHONkTj
 G4yjj9kjy642McOU+Tp9g0WNhU/tRYC66ych08lyVJ9Sq1t9rD7dMe0MXHt2ULpnpKo8I+KdUkL
 sKiEod+L6LbH3OqD8sAgJochLfRWcGdJTEFl76f3pDdV+uzrdabu1alJOvpvu0iM7fXXls9DYBz
 +XmxCKFwVBnHMN+gUU5a1YjGIMQ4AQGQSeKFh6YLUmbskxJc9vvcsppjVA2m5SIoXf3XSx40ve3
 roW8ue+z0caFxWZ1G8vKZlaSigydJn46MwgiguoJzVDIfd1/3cjfjzgvPsaaNtY4CrJlSfHDCeq
 1TYVILSjo8fa09X0GGLvVloJYER35VzguMw28AsA/f9z3TjNDkhAqBW5XoEE=
X-Received: by 2002:a05:6a00:1784:b0:845:3d82:10fc with SMTP id
 d2e1a72fcca58-8562496610fmr4327008b3a.0.1787868460041; 
 Thu, 27 Aug 2026 15:07:40 -0700 (PDT)
X-Received: by 2002:a05:6a00:1784:b0:845:3d82:10fc with SMTP id
 d2e1a72fcca58-8562496610fmr4326915b3a.0.1787868459592; 
 Thu, 27 Aug 2026 15:07:39 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535ced0f99sm2523713b3a.44.2026.08.27.15.07.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:07:38 -0700 (PDT)
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
Subject: [PATCH v8 038/105] tests/tcg/meson.build: add generic plugin tests
Date: Thu, 27 Aug 2026 22:05:32 +0000
Message-ID: <20260827220641.84885-39-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827220641.84885-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827220641.84885-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfXwpa5jPBUs04d
 N55Ard+h9IRpChSrjn2RpH6RNUMl413RovviI0cJFylrl9dkb7JnUVVCgFqr2IcWqzvo493QbZE
 H3CEf3sJHoKtT2QYa96Kzicnk69WCC5wjgUZWm5cgaHz/Mq84bpLavhc+jzK0Sr57rV4AMKVONy
 Ks2CZB60OiScA5+Z0iRqNdsOiqu6EUxTN7+lfV3axv2vBUaxNnmES+IDL70sxUcI0e5m5CJcLBs
 vCKo7pOT1wOcCfZfFPRvgS2QXiGcTMhNEGead8A6cLgQxnLP3NEjHBvvq8kKs8ZAkhhtLJc0kEX
 vm/HN3e4aOFPdr5CQuhf/DRzwKBDe3mVD3w+cAJwTMj+PIZverjm3E5KxPTo0B+4XUd/hB+62rW
 grjxIOtpuEWEcwjtdQ2CEzgGusARnYUo0YbHn7GrWBZ6Mzz+yPei6AVqPIjvWM2P+q7l+ypivnL
 CHv1Tls3vcfjgAdItvg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfXwWajXCnzyOZ5
 kPtWS2Ei0qo4Cj7tZoaXprmbziT5rk/wIXirrdMjmcLy1FgZQnELSsxOJSkJPSpU4NSJ4Uc4R/S
 XZq5REgwJlO9r1409acIgDDSYS0xC20=
X-Proofpoint-ORIG-GUID: R7a79BdwIpDg9CsAMMLVgQeRZ6S9ZyVT
X-Proofpoint-GUID: R7a79BdwIpDg9CsAMMLVgQeRZ6S9ZyVT
X-Authority-Analysis: v=2.4 cv=e8E2j6p/ c=1 sm=1 tr=0 ts=6a90b52c cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=20YfESkggsZWOKr5SEMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
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

We add one test for each plugin by picking a different user and system
multiarch test.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 45 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 536def60b44..16292d4d7b0 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -90,6 +90,51 @@ subdir('plugins')
 # multiarch comes second, so it can be referenced by other arch after
 subdir('multiarch')
 
+# Generic Plugin tests
+# add a single test for each plugin in user/system multiarch set
+plugin_tests_exclude = ['patch']
+foreach target: ['multiarch-linux-user', 'multiarch-softmmu']
+  plugin_tests = []
+  tests = tcg_tests[target]['tests']
+  normal_tests = []
+
+  # filter tests that are not plugin or gdb tests
+  foreach t: tests
+    foreach src, setup: t
+      if 'plugin_test' in setup or 'gdb_test' in setup
+        continue
+      endif
+      normal_tests += {src: setup}
+    endforeach
+  endforeach
+
+  idx = 0
+  foreach plugin_name, _: test_plugins
+    if plugin_name in plugin_tests_exclude
+      continue
+    endif
+
+    # pick one different test for each plugin
+    foreach src, setup: normal_tests[idx % normal_tests.length()]
+      # copy existing setup and remove existing cflags
+      new_setup = {}
+      foreach key, val: setup
+        if key == 'cflags'
+          continue
+        endif
+        new_setup += {key: val}
+      endforeach
+      new_setup += {'plugin_test': {'plugin': plugin_name}}
+      plugin_tests += {src: new_setup}
+    endforeach
+
+    idx += 1
+  endforeach
+
+  # replace list of tests with old and new ones
+  tcg_tests += {target: {'tests': tests + plugin_tests}}
+endforeach
+
 image_targets = {}
 exe_targets = []
 # Finally, we can create all test executables and test targets
-- 
2.43.0


