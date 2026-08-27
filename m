Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DC10C61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:10:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziFz-0007OT-6Q; Thu, 27 Aug 2026 18:07:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziFy-0007OD-9i
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:07:34 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziFw-0003Z0-0C
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:07:33 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJLoun235958
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:07:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VJu5JmIj1s7u4PjoUWGJXmxrTB26Fxyqfrpmk8ehL8w=; b=bW/kbKJHTDi/Kq0o
 /FtiUZ7iX2jApegDEDSNx7AufCreZwpiPE32/9UHWTk3/+OWwI+C3IsxT8GUu7qZ
 j+c+QeMTKRVypK6D2oqlS9RQBwcSHXeXdzxFAGteBMnxgyGGSeATpO7TGo6e4dda
 ywwRdlzZoekTHOTjMag+dYLN3ETahVAXFzfV7bhsxJ1wRbXPtLqOPtjJnyILfwgM
 hl4z+ncXfoS6/vv3tO5eIk8uIKoyhVyDNVqeUbqavAjtbC0Z1n/N+Y1fuGvkP77m
 IduqfJ9Jp8X2MJ2KSMMQeOdgdg128G43SkbHk6Ytm7+hxMVjnbLiwP3yvdp4zDcB
 qnp48A==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gatkjgsvt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:07:30 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cc1c2f1acebso583791a12.1
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787868450; x=1788473250; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VJu5JmIj1s7u4PjoUWGJXmxrTB26Fxyqfrpmk8ehL8w=;
 b=NX2ADzdkeoamdL/LbmHpnxCx/x2y+QdHTwMDtix+djvlFo/4N2khfxE2wkOJQfRQfq
 m6skjzxH9DkjD/K0UxXG7RbBpZ9nvpLEEvL5GpDyk9w5b8H3SRkX2dj1G3KME18lvGFE
 2h5ECKiApykPGrbBUHs7ShSfhqxanVG17ddTGaWW3sd5P0A+PElU/tU6r7PjxfOdbiqM
 atOsQsLrz+1b1Vq/ITR9hzmH3RVffU08pelQogE9kROtwGKX2w5EljllmvpWcVjkDtXI
 ByZlOEs+TcTJjXyBg9moPNpXAJgA1SvRYMlLvL8AUsaLOY7H1rjmuAovgakS3ZJGQgDo
 eDCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787868450; x=1788473250;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VJu5JmIj1s7u4PjoUWGJXmxrTB26Fxyqfrpmk8ehL8w=;
 b=jR5LfZwT7by6U3YFqdYMhbMazicSnGWSghq39iZUn31YY5jNeP6av8rFXXhqSRxAyH
 Pn0Bh+tjTzXunkdbWOqW5CJHGBlyRX2Q1lpcTBH+tNGG5NxpTRss25n6GU7+hiCdGmjK
 0/VY003Rpb110AAFGMp10eUb1z/QM5f5S9hTXbZ/wi0RgaRdQ5agYQJZA8dQHvnNEpoC
 i0lM4iU3KeiExqxjQk5yxdenrmqU3Vvjgcf+06UnitvcnelnBIUkB8ls6/Jvza+c3kgZ
 2RIU99Zo2npCAAZz7N4+ORcJmlegETGGmeR5hoxVHiA5KqD2vzJKAu1NboisdkH2omiV
 y/AQ==
X-Gm-Message-State: AFuF++mmt8wiodhw8ymItwFmA+8gN1jak+uVTJSJ85gmnbZ/QaGrpzoe
 9VNm8lDiC8a+EFyP6awj/j02NaW8+LL4lNvzfi7EqbE8YL5ieLjMbqYW9C5UF3N/xJ7vETONCSE
 TLNHDN1SRjxcOQFaoGhqMzm4DPpRh7sloXgHxVJXKDqXNN5aeZ1JEYJFfSJd9JZhmCw==
X-Gm-Gg: AR+sD10AKHQDAKnWBEdyXn+LCgJw2R3ERuJY4gQoN6UbehnFm0Rp6R1p5mWbc+MjwaP
 8aZdOPAdX9rxHFyp8GE01UWi9Obruktr2AEsygHDe95l5WPhcNYu6BXQOVXZzFSH7kmjDOFeYgf
 eW6/1AtXTmlnoRWZnQkEdIDOkXwwSyc8OUBiApmcDjk5j8F5+UXgcbbt41PetnNjiNvwQb+kBf1
 Jws5+vBzVib189ZJNKRS4reNX9y2MvIW5989pqTYOH9kE05mtTwulpVOr0tyklgsP6++zalgiWm
 1ESCrKrUWMOMpXLl1fkwV+NJRgYLBoMVRwIpV3JAajIUSep8k7JwirJdj9G0fBJZorrOfsBvJ3C
 E9igJYwJjF9cqbsHN4LkZ0YH4KkpRHmdwk6fQ5PIB9AFIavQxrEofx6+4zsA=
X-Received: by 2002:a05:6a00:3319:b0:851:fb36:a701 with SMTP id
 d2e1a72fcca58-8562879115cmr5024541b3a.7.1787868449927; 
 Thu, 27 Aug 2026 15:07:29 -0700 (PDT)
X-Received: by 2002:a05:6a00:3319:b0:851:fb36:a701 with SMTP id
 d2e1a72fcca58-8562879115cmr5024436b3a.7.1787868449475; 
 Thu, 27 Aug 2026 15:07:29 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535ced0f99sm2523713b3a.44.2026.08.27.15.07.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:07:28 -0700 (PDT)
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
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v8 030/105] tests/tcg/meson.build: introduce depends
Date: Thu, 27 Aug 2026 22:05:24 +0000
Message-ID: <20260827220641.84885-31-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827220641.84885-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827220641.84885-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: V0s3jRyGUHf0lXdHLdPVURTuuX3rzvFQ
X-Proofpoint-ORIG-GUID: V0s3jRyGUHf0lXdHLdPVURTuuX3rzvFQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX1HXG5x3DNoZ4
 /G0W2Bg0wcF7sJxVt35HZNeoje5c/hJj7RNYgxBAE+GlJ+pkM6TDWmJE+ZJv8hEbyJ3Poe6xeW0
 t50CBH12AaUa/yEi5jhiLKQc01Us3dvnWkOX7knTeo0tj0yfpH0mEGR/kxW6rv/d5MtZ1D7uMY1
 5Xh+NXF1L5i5PA/EzjlfE2B2HeZJUKXFj/l8f4+M7RpJdryz6XCDpdyD+S2VDEdcWqxooDsdGke
 b6/VKP9w8OLaJrZwtWJSzDzENozPNL+H+yQg9FeBSFrkX6cwZZwsVbqfo7TWFhj6q5o7XeYap01
 ZwJn7AJLp6pGEaBNZARBDFkqdR//JqKW+wdx5waNP7me4VQy1eeQyoMDUdLjcD8ONuJNl4b6PPk
 p8R23ZCuvI4cz7H7vq5isfTZpwQoUVuREXXRDZ8kgupmSMEcf8MUhbnFKSvHjX+YtkEtJPp6ULA
 29mPx6//zuoevTD5tsg==
X-Authority-Analysis: v=2.4 cv=Rsn16imK c=1 sm=1 tr=0 ts=6a90b522 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=aZLzzxQjhWCqgOQfChsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX0+ngf46BfAzk
 5eyt2QnycgUrYHPP01VPm3FoQlwtN99glpUMu2jgeiY2Z1UNc28HY9QNZN+hkNPzlW0HOnR9ryW
 7BDyavGM5tb/zdjKX6FbheWUFYcrFy8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 clxscore=1015
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

This can be used to declare dependencies for a given test executable.
Useful when generating headers (like x86_64 does).

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 9809695f3b8..ea17a947628 100644
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
@@ -178,7 +179,7 @@ foreach target, plan: tcg_tests
       # return a clear error if user misspell a setup entry
       foreach key, _ : setup
         allowed = ['exe_name', 'env_var', 'expected_output', 'cc_feat', 'cflags',
-                   'gdb_feat', 'gdb_test', 'plugin_test', 'qemu_args',
+                   'depends', 'gdb_feat', 'gdb_test', 'plugin_test', 'qemu_args',
                    'test_name', 'wrapper']
         if key not in allowed
           error('unknown tcg setup entry \'' + key + '\' for test ' + src +
@@ -277,6 +278,11 @@ foreach target, plan: tcg_tests
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
@@ -289,13 +295,13 @@ foreach target, plan: tcg_tests
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
@@ -312,7 +318,7 @@ foreach target, plan: tcg_tests
         plugin_args = ','.join(plugin_args)
 
         # since we turn plugin into a string, add dependency explicitly
-        depends += plugin
+        test_depends += plugin
         qemu_args = ['-plugin', plugin.full_path() + plugin_args, qemu_args]
       endif
 
@@ -367,7 +373,7 @@ foreach target, plan: tcg_tests
       endif
 
       test(test_name, env, args: cmd,
-           depends: depends,
+           depends: test_depends,
            timeout: 120,
            suite: ['tcg', 'tcg-' + target])
       added_tests += {test_name: true}
-- 
2.43.0


