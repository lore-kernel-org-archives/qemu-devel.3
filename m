Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2FE7C61DCD
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:18:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziOD-0006NC-4y; Thu, 27 Aug 2026 18:16:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziO9-000697-7y
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:16:02 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziO7-00069z-1Z
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:16:00 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJLglp235799
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:15:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VJu5JmIj1s7u4PjoUWGJXmxrTB26Fxyqfrpmk8ehL8w=; b=d2a0HVq3gqDydVtv
 FBu1V+NkI5vzIDuro/ZvGncslIkQ7jROqTtAOxDlKhw06m1LGil0SDfRGzuar1Kn
 eq3GfkYX4xQK7YQ1Lhhno1TYAlIZ2DZWGxqxoYzZfchCCyQjz7bpcfkHRbpKDBdy
 IynVC/UkKdwJNLmCtqVJpSkx82J1RM4wxDE7SdksNMgnQLoHH+P2taZg4lQthdV5
 ZCE56NCfgI8iKvluiYVHruE1YBTRtBXbpBsKkpG2b0v0lGfftqnDtC6pzeQZHnpc
 JBt/IgxsAC482cl+KHy7Jo+IMpptgiXCS5UijBWyJEWanR2KAkyixnwg0OAyozVZ
 prqksg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gatkjgtuc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:15:47 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-84e13b57b2cso575549b3a.1
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787868946; x=1788473746; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VJu5JmIj1s7u4PjoUWGJXmxrTB26Fxyqfrpmk8ehL8w=;
 b=jv39JNWiwkrmXimU+faAX+kDQ3zadfW3/T2idGKjrN9k9Kv+Yiiaydj2NnvzsWWQye
 Rea07YoP1fijAX5syDotskPaaD2ogMWcYGcXqqq4YV9Fvsi96UVEbmMdnWgqySPBNUBG
 N9gchZ8kLI/dCTZDaVy4vWbMjSxLN0rpp9wF1vAMTFmeWq+Jiv99tYVqcNHLiWWjhyYW
 rC/XFPfuQ/5BeJPzC+44TrsZ1FzgFDZ152sdyobTUGRZ/hAc+D09szKHAgnPyRFJs2af
 +Q9Q7omoy6UMujvP7BBLH5mUciQylJvtrFvXkaCkPj75C8PzgmHEJ6bTca3pgOjqI1PT
 1mbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787868946; x=1788473746;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VJu5JmIj1s7u4PjoUWGJXmxrTB26Fxyqfrpmk8ehL8w=;
 b=rXdo1RBQLNHdvmJBTszcRKUHXofn+4VYiT2szyusnoecSWRYO7VaPcplngIpvAYyTB
 LJzsWeZP9pHBfoc8IKZHdAL5WxIQ+Ml8IXh2uo83Z4GCF1WeBkwCBk5qqUFwCjKJbq6g
 myxeXUJOZIMxmo8L6ehKWD4xFLnFcMz6xtUv3oH+OooNeOYb3ucRkzL2KztyzMNzWqZS
 4c//0sG3k3yf7FbptjMr82tBe6F0GSLJP6MhNqFu8Df97l1+F6HPKcrWeLhrvt06Qf+f
 TA0nEsGfih5fmEFl9pl3fM0R5TVXtdUT7AR81XDvSzb9MdxRJ5uDuHsDpyK+hJuXZ89M
 hn/w==
X-Gm-Message-State: AFuF++ljgXTzJJOB6V1bmmF4cgm/666pqYaQ1YTB4ijnJ51oCMfUNFSE
 hmcIAu4EImIeFYQe4pqTRU+RP7I34tR2dIL0TMctSVfoV2tbgSd9QlnbgcDBfsMqYYOonGbUNDL
 5DZUqFw2xgaShhd42TAduPdjPDZXfLKCEf5ETfgl13ZktTJsMG/gQVPNRKTJThoOxKg==
X-Gm-Gg: AR+sD13a/UQDFAMXXGDLxyek+xgheoK560E5IYzq0lg8M0VFmIEFPXsNt6VDL626Rtb
 yXFXQlrXJgJqd68e+bItJr+VsH8TWF2wppyGH4PMQHzG5sYJn/123hUOyyzspd9UyOm/8w+dKXS
 vGeG67kXdFhxA3yhlIoDfx0xlpQ6xeY2h+VoExGaQAzQkzpwoMsU3yJ3EcAc7SlWGRMpIQPTkiE
 hYfhtmy4HL+v+fqN6i3jZX26NYSkX1OKLIU9hmv5NfrDh8rYkCsrcWlIjr/EIkxWBVLfCTtkQDH
 rJAFn4smdJ+/ZlztQyWR6S10WA6zS2CfjCMeIwgbMBs6TgwlxaTU28A4I2ZlyVXy3Qg8zgWLo/T
 3V7BBdm6UxN/r5jLSa9CR/wdkKbEMO1DbTO/+rXrx+/iJJF9ztE/guKh/cbg=
X-Received: by 2002:a05:6a00:f0c:b0:848:2e7e:353a with SMTP id
 d2e1a72fcca58-85625a395bemr4914482b3a.0.1787868946393; 
 Thu, 27 Aug 2026 15:15:46 -0700 (PDT)
X-Received: by 2002:a05:6a00:f0c:b0:848:2e7e:353a with SMTP id
 d2e1a72fcca58-85625a395bemr4914394b3a.0.1787868945982; 
 Thu, 27 Aug 2026 15:15:45 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535cf4b213sm2524104b3a.55.2026.08.27.15.15.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:15:45 -0700 (PDT)
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
Subject: [PATCH v8 030/105] tests/tcg/meson.build: introduce depends
Date: Thu, 27 Aug 2026 22:13:51 +0000
Message-ID: <20260827221506.91574-31-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Ai6S2HULwzqpZEo6UNnoTkwHSM7rnwfy
X-Proofpoint-ORIG-GUID: Ai6S2HULwzqpZEo6UNnoTkwHSM7rnwfy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX9CmluHsWZ+4v
 F4C/szdd9lUiZvUVL880n5z2qX0Q1taubPyUWDvafp0wt3eP2+ua8Y6oInKE0Zkd9OXi5KMPoCE
 hdEqnQkQYMPoqyRD/dg1Wt0JE/OH6EBhu9MZXydC9W2Mu/t28ezuKpA/iy52lzUDsEzdiGjmjCi
 DFoRFh86eI4awtkg7xAXrd088A/34hp0G9TJWP1fI+SFhll1LM+mn7WJpLGLpQbcWv5+YVmxzqA
 mBSmcH6UR3z5mvzPjTWL7Xi8QrDmvkc24Xr6xkotHMMkR7K0iswzeMGvw0CQJpyQprKzo9sJ6lx
 5Z/nCUHaqn2VOs4LZd4KbRlVpR6Gu8JWtbKhyHzDY0oLLqHrySG5De+OsmM9wAMf9TDOlXa1nbj
 2BDQQaCBqrhQGWhSoZILDuBgpoVbSDgbN2zTwxKpwd3gW48ksIEkpg7WYVJ/U+UfD6CYMcsGLYM
 LoYLmTs2JPc+pgjOrPQ==
X-Authority-Analysis: v=2.4 cv=Rsn16imK c=1 sm=1 tr=0 ts=6a90b713 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=aZLzzxQjhWCqgOQfChsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX3qduUQgq2C/O
 zhy/66Ik1LQ9eI6g0OLc6f9fMSL7OH+r7TiJsNuTbE6GHxoXt4FYbd3h9YFlHXdKJXMZqjrP+4x
 4zlLc8j0CHglIvuzY3ObRnUE83Cl4v8=
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


