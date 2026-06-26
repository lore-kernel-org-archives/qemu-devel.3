Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9A11C43327
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 23:43:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdG9t-00054v-RM; Fri, 26 Jun 2026 19:40:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wdG9r-0004vW-AT
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 19:40:27 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wdG9p-0004O1-6k
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 19:40:26 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65QMxCNv2675865
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 23:40:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=mwimZ1P6AVk
 q4wrwUnmtk0O1DWoQDV5zTwfXE51G7gg=; b=DK/oZDbTVC6cajKj1h79LatDom+
 6lIPabyo6ycuJ5njrcIScbxHCvWroNVKfYQEJpzi5S36BiFLqKPq6Dg8u2Gy73N9
 9gmGvSF2jRd6eDM+nNg0EYxPYaaJf14gx/fqsBvxnuh+XUA3hH+F56NA6LEtCPaw
 UVmyTnRHZT1s0WgTDwGZsXLPPC08Yu5mLDYxeQces+u+e60dLKQD6jVlDm2wHjYi
 lWKQEU7NkYvJttEbSnxfg1yKX8soGML6b1uSRCUytmqQKYynZAogNwrd+mZYALYn
 Wr0q3ufxR4Rp2wZ35+tS4uSnOe9aeDnJ3+bXFYijIuDcfnEkrzTDLB88grA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f1xqa8uyv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 23:40:13 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30c62861b3bso3653971eec.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 16:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782517213; x=1783122013; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mwimZ1P6AVkq4wrwUnmtk0O1DWoQDV5zTwfXE51G7gg=;
 b=ZZ7l597s1MIbBBNkJLwM8S4JUwP29e/C2LiAZnexg+cSXhPov21jKKfnEDQWx/mrMb
 QdOyqYithB2FPUO13K+hLaGYKnKJS+cm2sPYqVa1GgLjnvyLAaQVgwjNfQtoRJjQMvEu
 xrmjG/ckfrejNxNnE55ixGr4nQ0zgflAyubPBhoewksguX9l/VchV7fxd24JcAeANr7h
 udZ8GfknZZgu5ZOkOypKRRA3SwH3KfMEtVHmc56KAvp33iDrdAZ22ELaGVxMk8QAGM5z
 B3MW2MMWs5EF2TgoEgbtOPlOtyu8Yrue/PRIjGIZQJh964SMKINlKK0LIxC4mr1XowAx
 THgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782517213; x=1783122013;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mwimZ1P6AVkq4wrwUnmtk0O1DWoQDV5zTwfXE51G7gg=;
 b=jd56xYqbOYuNsFAJ4nlbErWGpqJy0pAehwjHm/ibZpGKEi1t/SQLwQP/vlmzvyJXty
 tcPw0W/12faJplcr6zhP3Eq2Q8/vFc82G8KzmYuus55X5eYchz6lyFFqlCXkYLMMWZll
 AdPx88xzsJ52uqQBbt1DJF0rMv7ygijo78Jlq1Jdra2j9kEelEfEPa7o9Na/pZjnZ/dC
 Smi0gNtpte82xEzRsp5lIJiWRfy9jsxrzCsntsgayyj2tkiePMfZg0TgvtrCLEMgfgqn
 lOqOIhoexBQu3cT7zTPfLFpYW+C5fxQ/1726fZiTbyK46t6A50f6MTXJPw5C48Q4a8Mm
 kekA==
X-Gm-Message-State: AOJu0Yw3pRQOTbz07ZWyniGTadc/HWfHCFjgO+5ZEbTMzyRU7soDsn8M
 lQ4DyZeQRXl5PvJOaS2JmIEWSUFCjh1jgTR35y9YGc5oo2y2LW+JjccCDgrClcoJ5BkApdRUEoG
 LMfE3FTlKoAW4zaPu3h/dlI7nMWjvzAyhdy0Zv2OHpQUWuOcOxqFJAk6SSExffHoVKg==
X-Gm-Gg: AfdE7clYYrfSqvFuHvvmayIVmnDCIj4gSg3W7T6qozg2DmtPzbWFpEXu9hAI3bHdjqg
 qXlkQr4xUzjhxUMciQAk0zXkRqiUwliubhJevI+YI3Clr+jdombCpN3CnWcko2sbv46rgsFCU5x
 gt4tsP3TR2lAkCpoUVybqa0FhONsjTabKKQY8z4s+ZI5uXurTXfRTf0G34xQCk7ZC0PFIMy4iug
 sZsKT3dTdWNG8SqqbQNll4DcuukFuKfoSGpK23atElKhTikLyeFDJgQ/dSn6SXpmIxndTPP/FeM
 x76Rqdrb1g+mGYZ1B/daZ1rOwSE+xVrJprval4dQT/qCPZaWZl/2bUWtNBEEzR2WBnWWAK04DSi
 z/4fWtFxeyY5npFYBSJXAOdUGo4PNGnFOOldum7otlZ57QWcaF/9yI6V+gb1XOAQ7oaI8LhHMil
 yeJp/H/g==
X-Received: by 2002:a05:7301:5f03:b0:306:f474:7389 with SMTP id
 5a478bee46e88-30cab36ed99mr1871665eec.25.1782517212839; 
 Fri, 26 Jun 2026 16:40:12 -0700 (PDT)
X-Received: by 2002:a05:7301:5f03:b0:306:f474:7389 with SMTP id
 5a478bee46e88-30cab36ed99mr1871638eec.25.1782517212214; 
 Fri, 26 Jun 2026 16:40:12 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c52c591sm29369756eec.7.2026.06.26.16.40.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 16:40:11 -0700 (PDT)
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
Subject: [PATCH v2 35/37] tests/tcg/meson.build: introduce cc_dockerfile
Date: Fri, 26 Jun 2026 16:39:16 -0700
Message-ID: <20260626233918.158740-36-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626233918.158740-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260626233918.158740-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: dwsXYBNLfqV_tmGBLvM2ZiteVpC-bm7H
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDE5NyBTYWx0ZWRfX1F4fKguNrwHA
 t7y7lbdcQt6vtlwDk1OI1KCykhREgH4iDdIyMpw+ZZb8D08xTP7A75Z1ng2+qNAMvY/K8cgYMms
 3+yDc9tXuyvYGAa7VTo/tj3q/byNTgE=
X-Authority-Analysis: v=2.4 cv=GPs41ONK c=1 sm=1 tr=0 ts=6a3f0ddd cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=Hc6WaSv40d03dXQXC8cA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDE5NyBTYWx0ZWRfX198ckRfIWi1S
 uH6AmgSRzbvzyTKKnv/BLhmgzl1RIhDb+p4kleQkd0yZ/TcFA/uU0PJLOYzHZrmDpKbSOq4BNkJ
 otmM07MkI6s8mReaKL0rkrYU2gaZaLSlYg9saBYA9AI3YATQRzN0ARDWdd/85Cb4jgs5XY4XpHG
 zV0Z3yyMBNijibT2HXVtu1K6u6V49TBU9ks9gpXbSCy8EwzgBa3YIhzbgoaMAYZQjrbMC1SSq5I
 uJI00n3b1krxRlOpr3EEoaPCgmVwGUYKXf5SeRhdPQzFINceGjXzwmYZLnquOqyeSQDUBPMmgP3
 YqreB5RV6Jq1R1JgB5EtzcHORZwec8xK6MR4gtfBe0QF0qyl896H9Pt1PP5iOum/CqAu1zRNoQp
 uVPnxjOCn/QT0bi5INaWAG7gIEDWtrDVMOuG1cbLb5GkOHTRJnX/LqZuc4u3HlkO5HWdbYYubgf
 Ru+NhHT9wPkwE++B5AQ==
X-Proofpoint-GUID: dwsXYBNLfqV_tmGBLvM2ZiteVpC-bm7H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_06,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606260197
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

We allow target to declare a dockerfile containing required cc. We reuse
tests/docker/docker.py, and correctly set dependencies for tests on
original dockerfile.

In case we rely on docker, we do not build tests by default anymore.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 52 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 47 insertions(+), 5 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 2a308d8ad32..eb6b65c0021 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -1,6 +1,7 @@
 cc_check_args = ['-xc', '/dev/null', '-o', '/dev/null', '-c']
 env = find_program('env')
 
+docker_wrapper = find_program('../docker/docker.py')
 gdb_progs = ['gdb-multiarch', 'gdb']
 if config_host.has_key('GDB')
   gdb_progs = [config_host['GDB'], gdb_progs]
@@ -21,6 +22,7 @@ tcg_tests = {}
 # {
 #   'name_of_target': {
 #     'cc': 'cross_compiler',
+#     'cc_dockerfile': 'name_of_dockerfile',
 #     'cc_feat_cflags': {
 #       'name': ['feature cflags'],
 #       ...
@@ -75,6 +77,9 @@ if gdb.found()
   endforeach
 endif
 
+docker_supported = run_command(docker_wrapper, 'probe',
+                               check: false).returncode() == 0
+
 # plugins come first, as we need to build the list
 test_plugins = {}
 subdir('plugins')
@@ -120,6 +125,7 @@ endforeach
 # Now let's go through all architectures
 subdir('aarch64')
 
+image_targets = {}
 # Finally, we can create all test executables and test targets
 foreach target, plan: tcg_tests
   if target.startswith('multiarch-')
@@ -135,8 +141,8 @@ foreach target, plan: tcg_tests
 
   # return a clear error if user misspell a target entry
   foreach key, _ : plan
-    allowed = ['cc', 'cc_feat_cflags', 'folder', 'gdb_arch', 'gdb_feat_version',
-               'qemu', 'tests']
+    allowed = ['cc', 'cc_dockerfile', 'cc_feat_cflags', 'folder', 'gdb_arch',
+               'gdb_feat_version', 'qemu', 'tests']
     if key not in allowed
       error('unknown tcg test plan entry \'' + key + '\' for target ' + target +
             ' (possible: [' + ', '.join(allowed) + '])')
@@ -144,6 +150,35 @@ foreach target, plan: tcg_tests
   endforeach
 
   cc = find_program(plan['cc'], required : false)
+  cc_from_system = cc.found()
+  has_cc = cc.found()
+  build_test_depends = []
+  build_test_depend_files = []
+
+  if 'cc_dockerfile' in plan
+    cc_dockerfile = plan['cc_dockerfile']
+    dockerfile = files('..'/'docker'/'dockerfiles'/cc_dockerfile + '.docker')
+    image_name = 'image-' + cc_dockerfile
+    if cc_dockerfile not in image_targets
+      cmd = [docker_wrapper, 'build', '-f', dockerfile, '-t', cc_dockerfile]
+      t = custom_target(image_name, command: cmd,
+                        build_by_default: false,
+                        output: 'none')
+      image_targets += {cc_dockerfile: t}
+    endif
+
+    if docker_supported and not has_cc
+      build_test_depends = image_targets[cc_dockerfile]
+      build_test_depend_files = dockerfile
+      mount = meson.project_source_root()
+      mount = mount + ':' + mount
+      here = meson.project_build_root()
+      cc = [docker_wrapper, 'run', '-w', here, '-v', mount,
+            cc_dockerfile, plan['cc']]
+      has_cc = true
+    endif
+  endif
+
   folder = plan['folder']
   gdb_arch = plan['gdb_arch']
   qemu = plan['qemu']
@@ -237,10 +272,14 @@ foreach target, plan: tcg_tests
         cc_feat = setup['cc_feat']
         if cc_feat not in cc_has_feat
           avail = false
-          if cc.found()
+          if cc_from_system
+            # check flag for host cc
             cmd = run_command([cc, cc_check_args, cc_feat_cflags[cc_feat]],
                               check: false)
             avail = cmd.returncode() == 0
+          elif has_cc
+            # docker cc always have feature
+            avail = true
           endif
           cc_has_feat += {cc_feat: avail}
         endif
@@ -252,12 +291,13 @@ foreach target, plan: tcg_tests
         cflags += cc_feat_cflags[cc_feat]
       endif
 
-      if not cc.found()
+      if not has_cc
         skip_test = 'compiler ' + plan['cc'] + ' not available'
         built_tests += {exe_name: exe_name}
       endif
 
       # build executable if needed
+      # build by default only if cc comes from system
       if exe_name not in built_tests
         exe = custom_target(exe_name,
                             input: file,
@@ -269,7 +309,9 @@ foreach target, plan: tcg_tests
                                       cflags],
                             depfile: exe_name + '.d',
                             output: exe_name + '.test',
-                            build_by_default: true)
+                            depends: build_test_depends,
+                            depend_files: build_test_depend_files,
+                            build_by_default: cc_from_system)
         built_tests += {exe_name: exe}
       endif
 
-- 
2.47.3


