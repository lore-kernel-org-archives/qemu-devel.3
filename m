Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 895DAC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:36:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgru2-0003gt-JR; Mon, 06 Jul 2026 18:35:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrtr-000347-TY
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:34:53 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrtp-0005eV-RB
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:34:51 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KE4b71626325
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 22:34:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=hkFeEyQiMBr
 qR/hntKsWNrMlcCo64epKAAVAg5Id7LU=; b=bApWWzvl/MQEuqm5QXBWKx5H08Z
 Nt2tJ9pGj3IQo3SVXrZaRmmxQzZSBuJn5zGAMJB14TrxTvwFOrHKKdRqalYWrc1K
 SK1bcnpXYNwYHXtWhb/F5YEOezytX0/UTXJOQCcrx8ifN/aEiTe7kiF5ov3AdqPa
 SOaOaVm35LRL4mcALE+5y8AGbyptlkGP3hR1EfvbhvhC47fjcdrC4gf+5NmcDemh
 eqBKkga4+mQqlHFeMdfDerNPqgKRPXuGjNlQdItRRiHZlP89idebBYtlLONRaK25
 FRgXvd0FeCu4dItl/lf36Y8jE3J88+exhICQ2HGiadec3evOPxyS+OB5mIw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88h9bn6v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 22:34:38 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c9fe4c5eb39so2144330a12.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 15:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783377277; x=1783982077; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hkFeEyQiMBrqR/hntKsWNrMlcCo64epKAAVAg5Id7LU=;
 b=FftZZc2Re/NWbTUlxu0LQXf4FxoICL9VjU1tx+2qBzbkNA3GrkUIChGK4jl69cP/Xw
 2oOkt5yfwuUyBJqzguWidUM1qe/SI9TNYG06EkX2NbeWHydxqeGWgidgVMwuEikFVDt6
 MLrXD1tgvh93atrLD6qBvUuou+/HgTBKNO8HTMssRSI8ONCFHkrdfFJAIShXhTLHNS6m
 2LLpf2F0uErAHSQ14VFUJa4RR5t/oDDBsX/k0KNt0EDc2PhPXS3HKes4tRbLTOquBOjT
 xp3O45qyWhZACCUhhFkzf3G+j+YHUniKrAt7VlxdQ8DSGY/e3tMhv2KLYRhfAA4oWOq8
 qpqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783377277; x=1783982077;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hkFeEyQiMBrqR/hntKsWNrMlcCo64epKAAVAg5Id7LU=;
 b=gdnZkYa7UlItK6hJpKDOfdlSUyqa+nMxEURZc9cWOPsY26eEf9aDo1WSjti/Ze/O/q
 XJvxXTXiGHE13kgJluPbunmBtm58v67f/n+W/9XJSH8d58tuMM3MT92yhtV2DLOaq84x
 I0+FIN5zxuXxZjv2EDUfUGrAwIRUQLOCCCK8/n5IPgR35oqN+hqtA+Ozeh1qgCY1Ivzb
 5gfhFfJ9ny4TAGWVS/jo9uL8ywjuBGuRodgCwqBqv/6Nn3iEs2mup2igtA5sf5wO53BX
 p16y0VyT+6LsDeQBQRpVhiu98rIy88VlAKFzgdPP075Xy+KhiK2edYJl8amZJLiJtV2I
 Ri4g==
X-Gm-Message-State: AOJu0Yx+89EZ2W/W8uZ8b8mHMjKliJaDRvG9hurrXzig5gtBuym/6E1W
 tl0aWomBbT56PRVg+9iSdikkuLMUflSh4jGyvLJ0ssx63sD3jqI/JbfZbKVZk3yP1aV3tqVhhfG
 UBFU3uNDPV5SVDo5oBlVTgdm1Axwx0nkr7mTEfNZZ2pckMQpK/GPZVZpd5Yrr7MBFcQ==
X-Gm-Gg: AfdE7cn6zRVi069ELKlZ6zJyrBbhhm8uvrPCitZb1gQVIU/qP7Li4Fw5Ihytv62fb9P
 jy1mTNsXhP7+EBAiQ4/gZkPhb+v50gG2i1RgRFnJDwFhyWLUT+iG/NKk8ON5qxdvNGuQibayA5G
 L6fBmi2gXODhA4oVST7GpdXUMdcawtbgillHytosaRBeqOUdIlMpACmf9N+KdekHmgxkSvrvDqO
 OpURkNQSgu6WP2o14y5e18fAtte7n0/mPVN8x/Uymsb3dJ30Y9aHxbD0cuk7qFcL0yNhrXzPg1j
 TgzBqwILk20p+w8/RaMg34PS7siVZcEcbj0MiR9ZBjKewo/WTKgNaqD/nLI2zJj3h6QGftyrAK2
 hczzvovA+lDdLIhZ/Bfxrf/pjfKu3FuA6rKmtjKUiB+MtIW3tczqYOyfpDZu9pYg3/6UEnuQ1ii
 TQ86DoQA==
X-Received: by 2002:a05:6a20:431f:b0:3bf:b4ed:5579 with SMTP id
 adf61e73a8af0-3c08efadc69mr2969770637.59.1783377277497; 
 Mon, 06 Jul 2026 15:34:37 -0700 (PDT)
X-Received: by 2002:a05:6a20:431f:b0:3bf:b4ed:5579 with SMTP id
 adf61e73a8af0-3c08efadc69mr2969729637.59.1783377277009; 
 Mon, 06 Jul 2026 15:34:37 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31174ac0557sm977244eec.26.2026.07.06.15.34.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 15:34:36 -0700 (PDT)
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
Subject: [PATCH v3 29/91] tests/tcg/meson.build: introduce depends
Date: Mon,  6 Jul 2026 15:32:41 -0700
Message-ID: <20260706223343.988769-30-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: AkHtaIEgTYCEIx9E6RGpxlIlz4Z9A2ss
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIyNyBTYWx0ZWRfX2NOsJ7l2+9M5
 jQmJjM2ROatoF1fWsGHdBIgk/KxcppdVdT4TgoVTyDJiY+N5bgxEMrhrLDYD6lu+9CeymHYqjCi
 6Jgp3U7KOirtIvrE/zAQd8W1qHjiCAM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIyNyBTYWx0ZWRfX+KlXPhtNna4U
 E5VCowkpnez257p+vxIhI22RstzCG2QhVJVtpNCOTRcjxyo2hrrfclmGBRJxYrNxfU/JvWYWazl
 irmABnMCvqUjbahVCdh0rlYnx0OpByRnJVOtuGna/k/ICWnGnB6TyUZarlseeaowKYBJRlUe7E2
 O1qPMozpRIlyFRqDhd4rzK+MOAXq6TXkFBxY/y7j3M6h2x82G1x+6b1UVgtSJHPjn70BDokL5xP
 FsXa657PkJ6ehjLiUkgE/lQqkBs4wAIAgYUS1UZ3qdLGimoFTbdAbZmzfSszwWNvFxz9vHB9Xsm
 qTbAXNyQRNKd3zulqfTzhe/MFvxGO28bXOw5u3PUJibSESiC+/JxjD4U3k6XAlHLGSr7tDAgmDB
 7zoozsC3IVHNrd+XnEYaDKfTe28YYHnE3O2fW5LH5KtiVWKC5FijwNS0w3zVNLsq9CL/c0x7EDI
 /Le5Fu5fKx2VrJ2B+Zw==
X-Proofpoint-GUID: AkHtaIEgTYCEIx9E6RGpxlIlz4Z9A2ss
X-Authority-Analysis: v=2.4 cv=GulyPE1C c=1 sm=1 tr=0 ts=6a4c2d7e cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=aZLzzxQjhWCqgOQfChsA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060227
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 57e7c3f8801..1f553a0aa8d 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -41,6 +41,7 @@ tcg_tests = {}
 #           'exe_name': ['provide an alternative binary name'],
 #           'test_name': ['provide an alternative test name'],
 #           'cflags': ['additional cflags to compile test', ...],
+#           'depends': [meson_dependency, ...],
 #           'cc_feat': 'feature name, must be present in cc_feat_cflags',
 #           'qemu_args': ['qemu command line flags', ...],
 #           'expected_output': 'file_to_compare_output',
@@ -164,7 +165,7 @@ foreach target, plan: tcg_tests
       # return a clear error if user misspell a setup entry
       foreach key, _ : setup
         allowed = ['exe_name', 'env_var', 'expected_output', 'cc_feat', 'cflags',
-                   'gdb_feat', 'gdb_test', 'plugin_test', 'qemu_args',
+                   'depends', 'gdb_feat', 'gdb_test', 'plugin_test', 'qemu_args',
                    'test_name', 'wrapper']
         if key not in allowed
           error('unknown tcg setup entry \'' + key + '\' for test ' + src +
@@ -262,6 +263,11 @@ foreach target, plan: tcg_tests
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
@@ -274,13 +280,13 @@ foreach target, plan: tcg_tests
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
@@ -297,7 +303,7 @@ foreach target, plan: tcg_tests
         plugin_args = ','.join(plugin_args)
 
         # since we turn plugin into a string, add dependency explicitly
-        depends += plugin
+        test_depends += plugin
         qemu_args = ['-plugin', plugin.full_path() + plugin_args, qemu_args]
       endif
 
@@ -352,7 +358,7 @@ foreach target, plan: tcg_tests
       endif
 
       test(test_name, env, args: cmd,
-           depends: depends,
+           depends: test_depends,
            suite: ['tcg', 'tcg-' + target])
       added_tests += {test_name: true}
     endforeach
-- 
2.47.3


