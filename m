Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53725C43327
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 23:41:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdG9m-0004Xh-Ct; Fri, 26 Jun 2026 19:40:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wdG9j-0004JF-PW
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 19:40:19 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wdG9h-0004Ld-O8
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 19:40:19 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65QMxYsG2746797
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 23:40:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=QCRkANwvZzG
 xgNQSK5PLp/eyCNXQD8/14WvuSWGinMc=; b=eBbYkvCXz0Qsda/76gQBUCFPIgY
 1EfKEwTMYFMHYqmrUXPqxKfVbdTMx0AkjA+OrXEGnCxgNYQ7uOOLlQm/Xq8J+wCM
 9ITeGG3sjUpdtwkEMlRJgPUki/2s1tQHCLm0PXPm68SU3vOyHRN36awFHtXsyhdF
 F1Xca2i2JceiX0wSI9aAC5JmUWOMf54uGcbOCVgjQT3vlLye/szqXWj9SDNEYib2
 XhwO8YzcTjwdXXkkxWC7Eycn8oJSwgZ5H+f9NqKvnwf63V05wnSto1SnrFEh50Rj
 /xu9CW+bu8qGwzjtOUHGjcmrYmJkcVMxT5lMlIpvc4HLt2m6tm2C+OoinOQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f1yqv0myw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 23:40:06 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30cb2bcbf7cso377377eec.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 16:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782517206; x=1783122006; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QCRkANwvZzGxgNQSK5PLp/eyCNXQD8/14WvuSWGinMc=;
 b=ar6Z2oKz4Y8l6FyPlSWXiu1XLVy7oOmaAiGquNXsCeWjFsQaglK9tOs9uZA+GrTC2g
 BvhD/+j7tk09QO1wkmk48dugLSQD9q9ufXU4hUzR8a8ShU47CBBn0KkDcgu8d/wV6nFW
 lfvemcuRPitoytCoD3bGp0w9J/O2CjzyaVE+8HFyfB98YtyCJIhBudSp5mSez9G3U7DZ
 4wS4I8z2FwE061quN4lGGkBoYP3cklJN/OUGlFhwHzgVOvtjTyrOLhGfSfxVGw466qGE
 4nvuGmAjGIJqDiS5qVwy7whj4NVLI/Uh40Q6E6z3e3cReXhDdvkbAF8hccBNtmG0k47v
 kg8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782517206; x=1783122006;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QCRkANwvZzGxgNQSK5PLp/eyCNXQD8/14WvuSWGinMc=;
 b=TUSa6B4WMhxvVRflZx/P/fi3K+9Vr8rDF+8CgyR0jrYUfce7HqeWIPAcM0x5sKXL/c
 yWgpLOi70MZyEkAaxshT8jqzzW/5gaLmB+RGleMZltInAyrITMrUmHlKkeG7SQEW34d5
 EWMU5L7kn7U+nQVmndF3bExPapbOXVnp6F3h4LxHjOjWvOMQQ6jrHgokUkThVgcPZ5JT
 zBgurHm4YpCxQpSr0OBdG0RZrRUd24s/6DeE4IDpVAmyB8+l7FAqF6MrofI3guRvKGY1
 OXZHycODRb8mbcowA0dIGzV75W261x9LyqfUGXJuo6pZR2pTkKwEgswl2Mr0NOusIF2B
 6aeA==
X-Gm-Message-State: AOJu0YxtAK6No5+05FHFvme1IO4SmRVUpxURknUxt6F0kVvF9VVD8jfT
 3Tb+RwWS467Z0lX+smY+T6mpfBd3nbG1x4WYhR6i9mutg1TqjQi/NK8oCGeJ+9B6Ivnb3uqqKVl
 Luw6tMFBtg0S9ZI0md1kfeJQ6KnbQqux4CSmvS3+729EJLVcHdt8Og2vfyC1zTasXJQ==
X-Gm-Gg: AfdE7cnhftGGAJdsju0nVukOU0erFjg/qBZYwLdTpdOuGiKny2t5Qd7jkdQVOvZN/jr
 0epOrwh5CBq7gqFufUhLjgaoiHkixICDO9Y4VKF0sK/trfkWg+j5shorKAFx0vXnCcSTZbU43d1
 ka4hCKe+sDwa1eVA55kiHqUPuLWd8XClg16ZBfXfs7qup/CU3kP1yh0lUy3Zd0ovWVeQSp+X0s1
 xMS0yPq9l+NfQlESlhRX82GW3oJQKVxXu2z9DCvmqzRGgd+tNRzIionI+ZTf8VNlAmhDvaWT+xF
 ckbvPlYfCmHIe6PqOXsekpBfVSrx6V11/2o8Pv3AJNHSVlANwhd87fGiailSopme7sG3wrbUFue
 cUnKzKYy1WrT2F2HCUwfSndtT3LB4IXC+O0azlWeJCVHvCy2SlsdK2jxQi/3nKpdM9445WS1AjQ
 zu9B1NyQ==
X-Received: by 2002:a05:7301:624c:b0:30b:e4a3:44d2 with SMTP id
 5a478bee46e88-30c84b64c90mr7949569eec.8.1782517205645; 
 Fri, 26 Jun 2026 16:40:05 -0700 (PDT)
X-Received: by 2002:a05:7301:624c:b0:30b:e4a3:44d2 with SMTP id
 5a478bee46e88-30c84b64c90mr7949535eec.8.1782517205087; 
 Fri, 26 Jun 2026 16:40:05 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c52c591sm29369756eec.7.2026.06.26.16.40.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 16:40:04 -0700 (PDT)
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
 qemu-arm@nongnu.org, Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH v2 30/37] tests/tcg/meson.build: introduce gdb_feat and
 gdb_feat_version
Date: Fri, 26 Jun 2026 16:39:11 -0700
Message-ID: <20260626233918.158740-31-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626233918.158740-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260626233918.158740-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=aoiCzyZV c=1 sm=1 tr=0 ts=6a3f0dd6 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=WryKx-XaCgVW6WutTgQA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: yjDoSzE13Kycj0DRhK8LnAIUvR6UwQd1
X-Proofpoint-ORIG-GUID: yjDoSzE13Kycj0DRhK8LnAIUvR6UwQd1
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDE5NyBTYWx0ZWRfXxq8IN0i6Sngx
 EOSbgmtUwpC0yWFPKf7pmk5jvXkmvueGEUeYEeuItmJ/zWnj/DjmxB7OdKUqiHZIo5cmZmuZQtc
 AKpJHo/8DVOYLhsIQsh+z7+nQspnP5M=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDE5NyBTYWx0ZWRfX7D4iJpmCyi2U
 D0z5SK4BEn/WPhNpT7QwQkM6CZ0gfu4kx1cP5fQeydxBYk6jwQCoMZz7OJSBVsPUZ2eCtGQZ7fp
 MCQOjGn67RruKFZKIVw1ezZk7ltITQvsPcgHOpU4Hwh17EqsTxNlwkB9u8Jzl0pIKTGEDh/zRfR
 31ohZHixsA3DlXqJ+PEowMdmDDYqJzQlj2R3H2mO2pvLng7C2oGztmJZuoRBElsi0gdA+hGZuXv
 LRdt2g9lvZcQ7vgaYlwMXCaD4rSLOWdgtgK+jOd+ukyWugGiZO6GWEPnFcKNYTsWIsuERH+ML83
 gPfsnziu0jnuMxjmgT+Pq2buoQT0G/2VFUJQSc2av6pgEJUNZz6p9B6TckX13wK280oFTV/SyME
 mRwFhjSBEuq5OqMvGpJW2RL6aOIpyKNP3x6BZH7YA5JSo6nxPMCywzUu/haq3EG97ROJJKmdfgI
 B0zSjfUpddWI0HccmQQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_06,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606260197
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

Similar to cc features, we declare the same for gdb. With both
available, we can now declare all tests inconditionally.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index f4ccfb0bd84..80743c2ecd6 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -27,6 +27,10 @@ tcg_tests = {}
 #     },
 #     'folder': 'folder_for_test_src_files',
 #     'gdb_arch': 'gdb architecture requirement',
+#     'gdb_feat_version': {
+#       'name': ['minimal gdb version supporting feature'],
+#       ...
+#     },
 #     'qemu': emulators['qemu-...'],
 #     'tests': [
 #       {
@@ -38,6 +42,7 @@ tcg_tests = {}
 #           'qemu_args': ['qemu command line flags', ...],
 #           'expected_output': 'file_to_compare_output',
 #           'gdb_test': ['gdb test args'],
+#           'gdb_feat': ['feature name, must be present in gdb_feat_version'],
 #           'env_var': ['VAR=value', ...],
 #           'wrapper': [program_to_launch_test, 'args'...],
 #           'plugin_test': {
@@ -130,7 +135,8 @@ foreach target, plan: tcg_tests
 
   # return a clear error if user misspell a target entry
   foreach key, _ : plan
-    allowed = ['cc', 'cc_feat_cflags', 'folder', 'gdb_arch', 'qemu', 'tests']
+    allowed = ['cc', 'cc_feat_cflags', 'folder', 'gdb_arch', 'gdb_feat_version',
+               'qemu', 'tests']
     if key not in allowed
       error('unknown tcg test plan entry \'' + key + '\' for target ' + target +
             ' (possible: [' + ', '.join(allowed) + '])')
@@ -145,6 +151,11 @@ foreach target, plan: tcg_tests
   if 'cc_feat_cflags' in plan
     cc_feat_cflags = plan['cc_feat_cflags']
   endif
+  gdb_feat_version = {}
+  if 'gdb_feat_version' in plan
+    gdb_feat_version = plan['gdb_feat_version']
+  endif
+
   tests = plan['tests']
 
   foreach t : tests
@@ -152,8 +163,8 @@ foreach target, plan: tcg_tests
       # return a clear error if user misspell a setup entry
       foreach key, _ : setup
         allowed = ['exe_name', 'env_var', 'expected_output', 'cc_feat', 'cflags',
-                   'gdb_test', 'plugin_test', 'qemu_args', 'test_name',
-                   'wrapper']
+                   'gdb_feat', 'gdb_test', 'plugin_test', 'qemu_args',
+                   'test_name', 'wrapper']
         if key not in allowed
           error('unknown tcg setup entry \'' + key + '\' for test ' + src +
                 ' (possible: [' + ', '.join(allowed) + '])')
@@ -308,6 +319,18 @@ foreach target, plan: tcg_tests
         cmd = [setup['env_var'], cmd]
       endif
 
+      if 'gdb_feat' in setup
+        if 'gdb_test' not in setup
+          error('test ' + test_name + ' is not a gdb test, but it requires ' +
+                'a gdb feature')
+        endif
+        gdb_feat = setup['gdb_feat']
+
+        if not gdb_version.version_compare('>=' + gdb_feat_version[gdb_feat])
+          skip_test = 'gdb feature ' + gdb_feat + ' not supported'
+        endif
+      endif
+
       if skip_test != ''
         # still declare test, but skip it and print reason
         cmd = ['sh', '-c', 'echo "' + skip_test + '" && exit 77']
-- 
2.47.3


