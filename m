Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50677C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:46:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJ24-00063P-Qk; Fri, 10 Jul 2026 17:45:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ1l-0005bS-KM
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:45:07 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ1j-0003X5-GN
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:44:56 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AKt0631948335
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:44:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=3hVUCG2XoKd
 Vu6RStLQ8mD4GgKFz8xSgxGGmuA+81kM=; b=bhgskR6ayKIDKg4g1t4HK+WRnbr
 kox4nf774yvZfzuyjUuij42jEbyDstyBrGYUUZquRJSeJGMifJttDRbu7/+qUQpE
 9v+SGwRuMvSjssQPbftQTJM7C+mLycXXST6cwy8Q7CtnIjINX4KlewEP9sloG2I8
 cMHZrtvNVI08oQrULygS1KF1RzT5TQCkLD+YPg5nrcGAmpHd+Ik0p3Y5kshm364t
 e+gpHWe0n0cESd+ygrMMv2wSObfKlSJ5r4KIt/3hiEbSstUF7CU/QcfdpiOVAhUt
 TDGe0/KuaUwuz95+iFDBhnt9N+hfUM4CNYj7MX1xc6VyIuA+f777kEKir4g==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb86eg46m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:44:44 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c889d1eedcdso2059164a12.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783719883; x=1784324683; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3hVUCG2XoKdVu6RStLQ8mD4GgKFz8xSgxGGmuA+81kM=;
 b=CGLtR1/eamoNpk2nGh4NzamNnISAdyjed37g+JghLa5gxQ+9beq07WzvdmNIApNU49
 yRsjafWf6k/BuE0+JGSLjht6rkX5F5FijaqNDWz1Eah7X72W+qKmqruyjhGqN/SqypMk
 Fhy5qYJZ0R/ghiaV3lI85NeJ4h7enblCkI0bqghn8XfC/yInl/Nww0lridvW+B2Ovwpl
 qQqA5ojHswW/PaC9HL19n6Dv65DOYDY/XHuUr07UriJgLIWx81839L267hOZWyyHGBPR
 0rpJmHcVwlEccJNwu0SZL/UI+g+9lfZBNkUQyG13uqwauUBzQ0XxRnk+3cZ9oTbD478+
 0PdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783719883; x=1784324683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3hVUCG2XoKdVu6RStLQ8mD4GgKFz8xSgxGGmuA+81kM=;
 b=NrOI9qlaXyhvZ9h5vAXWpLDqHXiOd78dA1X7QPQAZ+P78AGpg4l25UNXagoiOE1LaN
 eu1wYkY/KViJNvQty7E21KijRjD016vw+NNeDNGrWI93xVUn0q9xN7T9DIFJk0PWNfQu
 X4mMwXbn5C19+9VBpRPro0H/q0JpsFO/mYzpY1Tit5twDTqQZ5DbxU+lSsayBXB0WPHu
 /3HYT/uBLvhGT+ufLI1g7f07sHMDnyOhBjnYVW0uM+JVx/vSKL/v4KHk3dKFRL82bnzh
 PHKXeZ1FpDd3OCdVb+50nVlioRWi79sf2XNrrLkSEdPVu7Y/zvNQ45Xy1Ts4mYTEOOTJ
 +jTw==
X-Gm-Message-State: AOJu0YwWLnzbrmwxT9EEkLCNfiBSm4k/neFGgJamlG8nZDtSeuQ/fdOB
 f7rM6ZtKoqofUaLFSFMrAxUZ7TJbnu4bS9/a/HDJHNa0osKvnaxoL2DwAg6dixI2tJnErNNLz7O
 LFVGVyQ3TYIKywJUHmQa+P0G0LlmaiVTYL6/CU4OqlAxu9fXoNIPbR6lcyoSNNKvspQ==
X-Gm-Gg: AfdE7cm8yN7/+fxbvo4yVL4/np8R6NpLRGZn8t6DngN+pB2HXMcbd5/MGatmTTNQahE
 UbWkfol2pU532xV1vUDYo2zf/HruaRrzKyiQyjnU15MPhBSMo9J/WJVO7xlZR5kZN22z4qJuAAC
 Fqg+sLy7YTDP8xj5SOMhAqmbQop9Cf9Hjt6kLNka7rn9CFt5uMeqH8tJ5TbFg4Iddx5HTN0iZJ8
 XHLPM1TjOFB/oVNN08pgti8ZTLPYeobZkaPrg+xxsC+MmVtlKjda4qn6PGLgZ8x59Mh0WWDed0M
 EV6AXL1tvPpZzaSGd14ajKVQtfTTnKzElVrmTC0oIXUDoPXzspYau92RfKZSkPbeUFoRbMiWWtW
 1eZPKlaRvCfwImgVAlzLS8aEUNST576LTC1/7ZbTcxFuG6cPVxzyjhYihmSf592sqy5Vy/blY1v
 RMHFkKIQ==
X-Received: by 2002:a05:6a21:9211:b0:3bf:a0e5:99a0 with SMTP id
 adf61e73a8af0-3c110be0c4bmr782659637.47.1783719883542; 
 Fri, 10 Jul 2026 14:44:43 -0700 (PDT)
X-Received: by 2002:a05:6a21:9211:b0:3bf:a0e5:99a0 with SMTP id
 adf61e73a8af0-3c110be0c4bmr782642637.47.1783719883094; 
 Fri, 10 Jul 2026 14:44:43 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659c8665sm43539840c88.10.2026.07.10.14.44.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:44:42 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>, Helge Deller <deller@gmx.de>
Subject: [PATCH v5 28/98] tests/tcg/meson.build: introduce cc_dockerfile and
 cc_docker_host_arch
Date: Fri, 10 Jul 2026 14:42:32 -0700
Message-ID: <20260710214343.2065491-29-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIxOCBTYWx0ZWRfX+JtmnzAHmeli
 dXfBoSAc9iXciAwfbP9JfzgUIIdVsUUbI/soXinDnPjxUflsRn0FJioQqS6HSe39LmZeu8IuW2Q
 pq5OwSm5jfIP0CzAaueorNxgCzHjykyj+13OiUymcRRm2hrrVPegzVyubiYdoJY7hEYcgKyfUZW
 OkExdyt1in2jWvyKN4P0mfbGZuEzfOHMTQSi5g++dXVhGuJtYXQs6HF8+MJAAOiDfW4G3ss7rqI
 R/L9xTEQxUQ6zI8qDglI0v/QesO8jXQSUbuZhevkZwrbrPcxBHjE2dRwcCKZ8YJ9vLTYoyuRV76
 D1na1hMadi5VR9Q3dVCqGktFwr9pkWob6rPfImg4wARfL7IAsk96P1svZOUsu6YLZLlMGyYcgTe
 GLR1jR0QjPN/GD4OdORdMWEqPMTIcQNTiPfJtEUOzHoEL/W5I4HiZotdfLmPBiPROcwE1Qk+crN
 tIIJPTExn/obXz7QExA==
X-Proofpoint-ORIG-GUID: vrksjkBvMVoA6mXI701VfoAJ4CmoULnn
X-Authority-Analysis: v=2.4 cv=IOQyzAvG c=1 sm=1 tr=0 ts=6a5167cc cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=qzorxrrS95WKHyIffIYA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIxOCBTYWx0ZWRfXwHhLddIdkle2
 zI/HMUHpSXHnTg3oQGHdGwzZ8fwI/LU3OIajglcNK46586cnQAaxxFP5N+VVQblwmoxi53AQVJb
 QlyChe35Izq1dJ5tEM2YVTSCu7pcCjA=
X-Proofpoint-GUID: vrksjkBvMVoA6mXI701VfoAJ4CmoULnn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0 clxscore=1015
 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100218
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

We specify list of hosts for which image can be built and contains
required cc, using cc_docker_host_arch.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 61 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 57 insertions(+), 4 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 9c00d21f059..9db0692685f 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -1,5 +1,6 @@
 env = find_program('env')
 
+docker_wrapper = find_program('../docker/docker.py')
 gdb_progs = ['gdb-multiarch', 'gdb']
 if config_host.has_key('GDB')
   gdb_progs = [config_host['GDB'], gdb_progs]
@@ -20,6 +21,8 @@ tcg_tests = {}
 # {
 #   'name_of_target': {
 #     'cc': 'cross_compiler',
+#     'cc_dockerfile': 'name_of_dockerfile',
+#     'cc_docker_host_arch': ['host_arch_supported (meson cpu)', ...],
 #     'cc_feat_cflags': {
 #       'name': ['feature cflags'],
 #       ...
@@ -74,10 +77,14 @@ if gdb.found()
   endforeach
 endif
 
+docker_supported = run_command(docker_wrapper, 'probe',
+                               check: false).returncode() == 0
+
 # plugins come first, as we need to build the list
 test_plugins = {}
 subdir('plugins')
 
+image_targets = {}
 # Finally, we can create all test executables and test targets
 foreach target, plan: tcg_tests
   # Detect duplicated executables/tests, and report an error to force user to
@@ -88,8 +95,8 @@ foreach target, plan: tcg_tests
 
   # return a clear error if user misspell a target entry
   foreach key, _ : plan
-    allowed = ['cc', 'cc_feat_cflags', 'folder', 'gdb_arch', 'gdb_feat_version',
-               'qemu', 'tests']
+    allowed = ['cc', 'cc_dockerfile', 'cc_docker_host_arch', 'cc_feat_cflags',
+               'folder', 'gdb_arch', 'gdb_feat_version', 'qemu', 'tests']
     if key not in allowed
       error('unknown tcg test plan entry \'' + key + '\' for target ' + target +
             ' (possible: [' + ', '.join(allowed) + '])')
@@ -97,6 +104,46 @@ foreach target, plan: tcg_tests
   endforeach
 
   cc = find_program(plan['cc'], required : false)
+  cc_from_system = cc.found()
+  has_cc = cc.found()
+  build_test_depends = []
+  build_test_depend_files = []
+
+  if 'cc_dockerfile' in plan
+    cc_dockerfile = plan['cc_dockerfile']
+    cc_docker_host_arch = plan['cc_docker_host_arch']
+    allowed = ['aarch64', 'x86_64']
+    foreach arch: cc_docker_host_arch
+      if arch not in allowed
+        error('incorrect docker arch ' + arch + ' for target ' +
+              target + ' (possible: [' + ', '.join(allowed) + '])')
+      endif
+    endforeach
+    docker_host_arch_supported = host_machine.cpu_family() in cc_docker_host_arch
+    dockerfile = files('..'/'docker'/'dockerfiles'/cc_dockerfile + '.docker')
+    image_name = 'image-' + cc_dockerfile
+    has_docker = docker_host_arch_supported and docker_supported
+    if cc_dockerfile not in image_targets and has_docker
+      cmd = [docker_wrapper, 'build', '-f', dockerfile, '-t', cc_dockerfile]
+      t = custom_target(image_name, command: cmd,
+                        build_by_default: false,
+                        output: 'no_output_' + image_name)
+      image_targets += {cc_dockerfile: t}
+    endif
+
+    if not has_cc and has_docker
+      build_test_depends = image_targets[cc_dockerfile]
+      build_test_depend_files = dockerfile
+      mount = meson.project_source_root()
+      mount = mount + ':' + mount
+      here = meson.project_build_root()
+      cc = [docker_wrapper, 'run', '--run-as-current-user',
+            '-w', here, '-v', mount,
+            cc_dockerfile, plan['cc']]
+      has_cc = true
+    endif
+  endif
+
   folder = plan['folder']
   gdb_arch = plan['gdb_arch']
   qemu = plan['qemu']
@@ -190,11 +237,15 @@ foreach target, plan: tcg_tests
         cc_feat = setup['cc_feat']
         if cc_feat not in cc_has_feat
           avail = false
-          if cc.found()
+          if cc_from_system
+            # check flag for host cc
             cmd = run_command([cc, '-xc', '/dev/null', '-o', '/dev/null', '-c',
                                cc_feat_cflags[cc_feat]],
                               check: false)
             avail = cmd.returncode() == 0
+          elif has_cc
+            # docker cc always have feature
+            avail = true
           endif
           cc_has_feat += {cc_feat: avail}
         endif
@@ -206,7 +257,7 @@ foreach target, plan: tcg_tests
         cflags += cc_feat_cflags[cc_feat]
       endif
 
-      if not cc.found()
+      if not has_cc
         skip_test = 'compiler ' + plan['cc'] + ' not available'
         built_tests += {exe_name: exe_name}
       endif
@@ -223,6 +274,8 @@ foreach target, plan: tcg_tests
                                       cflags],
                             depfile: exe_name + '.d',
                             output: exe_name + '.test',
+                            depends: build_test_depends,
+                            depend_files: build_test_depend_files,
                             build_by_default: false)
         built_tests += {exe_name: exe}
       endif
-- 
2.47.3


