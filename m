Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17BEAC44501
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:21:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4c1-0001eA-LC; Fri, 10 Jul 2026 02:21:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4bz-0001SZ-Bh
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:21:23 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4bx-0004ng-FF
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:21:23 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3nTs13803913
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:21:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yCs3+Svrq7yoHhH+rk6ilKYcdPc6uI8frr2BJmbr6Lo=; b=F5HpJCQRYGFRd/8W
 0WlKGsK/nkQgsWGG4oE+OECmEL92Zj/Da/0vvKNmmLkxbPcfQrCQUeDZihZwIMM6
 jR0l5NgdkBFlj1uVPp0aILjzqd/CzRuKAc/1iQFFS5ahysPiPm9vDvDUYADYDErJ
 U1WE7kdFhNI+xFOM0QV72Z4Z9rd0WwdGKE94XekmVWvltqd//oc/fpeZ2eCoqrrm
 yoYtSj3aVLziOLUkYZhEaUtcwClUCMZoSdFt4WbGjRM9rTeaLwNb8mtOAuPhDCsq
 0GoirWQ2LSXAM7PgtB7tnh2QCEMp0yfssHi8D3E+6uZQL6lR5P/3TzfiwyN7NFCH
 NzAVFg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faf5mtu0s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:21:20 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c889d1eedcdso946971a12.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783664479; x=1784269279; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yCs3+Svrq7yoHhH+rk6ilKYcdPc6uI8frr2BJmbr6Lo=;
 b=CZ06WDhjaq5yIgOPnAGibfpHTJTA5I5WiBD5BSyLHSiMeWZXbwNAqaL5DtcNVJn8/T
 mOTHb6I1CMazrQlqNX59H8d4TLK2PClhHxLy/MDd9HogHaVxj3UFHbRdiiAoXTtVJmOQ
 wIiOY8GBHkfFQIFJjBXySzIukBqXIAetrZhqC2Xa97cwDstBO+d/stiFSFsICPI1KT90
 Lx0aNadsNUlJUvi3xtF/qYxK+MsRvJvh/my46adjXTLTU1nn3WuGVmBXZOsVQawNOlc9
 eP83mGNOLjrXsZSQJFH/zH6gBNj7N8GU29DdkYtgd2xXrfcy9lsUqWPpjLGxcZG+U0GK
 4g8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783664479; x=1784269279;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yCs3+Svrq7yoHhH+rk6ilKYcdPc6uI8frr2BJmbr6Lo=;
 b=o+qRUXxNl4uCeoZGmhk4+jE+DaEcnoW1vqhjgNfX0AMU7K5Dl1D5EgY7EaaV9FRsey
 ct3+XAW9i0nxyUInY5YwQAw3xm1Jure/n1xBTg8SxbqCWW0a4mNsXLlVViW9cmu4xyH1
 fJIa5XCQB8blhm/rk8jQQdl4g6GURK7bmD6TgOXIudjkBTpzjrdp6rUKvaqp4uIzwhTU
 VdCLZtP3wmnbAvaJxP5KO8VCtTX5MDEkjL//2D6qXr7vK9r4ufLFyPYz+UojZV9BPhAz
 69mVEdvP7uLw05uopx+DhT0TQI8O6PqfDzJkQo2ziFN8fLiczmNG5zzmoUSf+Hiy6rGn
 vFVg==
X-Gm-Message-State: AOJu0YyfCLqKg1ia3TqIt3bGGkulc7WmVAMAjRhinJi2W8rJgOWkGrpF
 +qQfz4BZWLNOfMF/mMinnhaswqYMRG7TwBP/PWtO5lUXDp2+Pn9NrapiKlx0ZNd8Yv7vs4yoXF0
 lcJ1OTCps6Bm6bzuzsw9V0lzOhIQmOaKDpDMZPPCxYwABT43fhdYM344Am0rdroonQw==
X-Gm-Gg: AfdE7clicJJsMY5A91PQszm/bhsWeQOs/m/FNjia9UIknysSSnAv9D5HaVlsE+0/SSZ
 cGeIDoZQ322ZOKOOtz8h0cZCX64UMZ/3Zb9rckZLw+T9EKiw+NAXZmYtAi/TRbjV3pmDlR08EdK
 Naui38ZhXda/twGNpovwuxT0VaAH1zeG2dkqAHdv1iEEMqpOsaD10K/bBHYm7t5/1KyJqxiPRuU
 hqnXilrETDYmIPpRBsgQz1I20/ppoaudCdiNUMRWS2AppK7MUOOY6n0bsZhvyNYBNiThy0q41cW
 yXMKip5yS0IjiktiIMW14Ek8h2kti7SsBFFllYgeFGxoo1drM6ZWdEsUcAvwDcUT/Qc0QBtQJxW
 PqQdEQpgKlHKEFqn9TVrL5RZ2RYYgML7rlpb5rAQLl73ByI8L0FXhl5JCNE2Ab0dpT4LBe7LAoS
 jH5W43lA==
X-Received: by 2002:a05:6a20:430e:b0:3bd:3591:2457 with SMTP id
 adf61e73a8af0-3c0bc8c5ed0mr13376952637.4.1783664479476; 
 Thu, 09 Jul 2026 23:21:19 -0700 (PDT)
X-Received: by 2002:a05:6a20:430e:b0:3bd:3591:2457 with SMTP id
 adf61e73a8af0-3c0bc8c5ed0mr13376905637.4.1783664479024; 
 Thu, 09 Jul 2026 23:21:19 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659fa13bsm35428126c88.15.2026.07.09.23.21.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 23:21:18 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Helge Deller <deller@gmx.de>, Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v4 30/97] tests/tcg/meson.build: introduce depends
Date: Thu,  9 Jul 2026 23:19:08 -0700
Message-ID: <20260710062016.1818125-31-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 9fNabV0Eta7gEsunKMyWh3H7bMKFCJQQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA1OCBTYWx0ZWRfX+kYWxWWuPMHM
 gl2JGng9nUkLS7Wx0sW8VhyqQYwq13Gs1FhjqwxrbTaoiUk7o3K2OuW+QKN7MDojqCLX9JYVGAQ
 bZTffSAErok/+lzJncyBYM2f9Ytee8Q=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA1OCBTYWx0ZWRfX4tWR3BjvAgO3
 XJRwjnouiC5I053rL6qv9O46SuLCq9altISMx1kALJsKof8/3Y8FfNrYAzHFoVyGQ5tYUX4wIv/
 8LlaG2rJNzXlF3RaplXkascrrMzKAkln40yzzlN11+T44OfJ2AoUwCYKI//nDHfUhKjQNG5uMjc
 bbyDtICitoC2MyvwEYrevmRWqwZsG0xoGChKKGvuNuOyoVRM0fjMD3MZALpc4YMKjA3j4JYBAvy
 PVImEnbnPrg+8CWoU6iJl7ils2SPs4g7sHwafgjhLhfKA6MO/7SNJxYALfpqzP8TBQuQh7fud2s
 0f9WlzrDbFaE/OCS+a9OmzSdaHTgdH3DfM5t35SyRr6JogwreDIo3jKfcNhuJRo6W0l6YpFs0L4
 gJ/n0dVhprqcGq0FVK8AOnfxScufjGAIRvtX6gm9qYJpDdSMUuG2VOr7TCX5MIfJTLcGFSFI+wH
 GjBLTco7LVGIJNapULg==
X-Proofpoint-GUID: 9fNabV0Eta7gEsunKMyWh3H7bMKFCJQQ
X-Authority-Analysis: v=2.4 cv=N+QZ0W9B c=1 sm=1 tr=0 ts=6a508f60 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=aZLzzxQjhWCqgOQfChsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 phishscore=0 adultscore=0
 suspectscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100058
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

This can be used to declare dependencies for a given test executable.
Useful when generating headers (like x86_64 does).

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 4cdd0a95310..bdb63bd5491 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -40,6 +40,7 @@ tcg_tests = {}
 #           'exe_name': ['provide an alternative binary name'],
 #           'test_name': ['provide an alternative test name'],
 #           'cflags': ['additional cflags to compile test', ...],
+#           'depends': [meson_dependency, ...],
 #           'cc_feat': 'feature name, must be present in cc_feat_cflags',
 #           'qemu_args': ['qemu command line flags', ...],
 #           'expected_output': 'file_to_compare_output',
@@ -176,7 +177,7 @@ foreach target, plan: tcg_tests
       # return a clear error if user misspell a setup entry
       foreach key, _ : setup
         allowed = ['exe_name', 'env_var', 'expected_output', 'cc_feat', 'cflags',
-                   'gdb_feat', 'gdb_test', 'plugin_test', 'qemu_args',
+                   'depends', 'gdb_feat', 'gdb_test', 'plugin_test', 'qemu_args',
                    'test_name', 'wrapper']
         if key not in allowed
           error('unknown tcg setup entry \'' + key + '\' for test ' + src +
@@ -275,6 +276,11 @@ foreach target, plan: tcg_tests
         built_tests += {exe_name: exe_name}
       endif
 
+      exe_depends = build_test_depends
+      if 'depends' in setup
+        exe_depends += setup['depends']
+      endif
+
       # build executable if needed
       if exe_name not in built_tests
         exe = custom_target(exe_name,
@@ -287,13 +293,13 @@ foreach target, plan: tcg_tests
                                       cflags],
                             depfile: exe_name + '.d',
                             output: exe_name + '.test',
-                            depends: build_test_depends,
+                            depends: exe_depends,
                             depend_files: build_test_depend_files,
                             build_by_default: false)
         built_tests += {exe_name: exe}
       endif
 
-      depends = []
+      test_depends = []
       qemu_args = []
       if 'qemu_args' in setup
         qemu_args = setup['qemu_args']
@@ -310,7 +316,7 @@ foreach target, plan: tcg_tests
         plugin_args = ','.join(plugin_args)
 
         # since we turn plugin into a string, add dependency explicitly
-        depends += plugin
+        test_depends += plugin
         qemu_args = ['-plugin', plugin.full_path() + plugin_args, qemu_args]
       endif
 
@@ -365,7 +371,7 @@ foreach target, plan: tcg_tests
       endif
 
       test(test_name, env, args: cmd,
-           depends: depends,
+           depends: test_depends,
            suite: ['tcg', 'tcg-' + target])
       added_tests += {test_name: true}
     endforeach
-- 
2.47.3


