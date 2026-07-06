Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF311C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:36:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgru2-0003h9-LS; Mon, 06 Jul 2026 18:35:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrtg-0002v5-2v
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:34:41 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrte-0005eC-3v
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:34:39 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KEGnx1505078
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 22:34:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=1hisPI8lrc9
 jvr303Ow8rYnIuuD9Px+8N1OoqJWGnWY=; b=JUmVlBnN7LN25wUDoc20jXHqNG5
 MqY3m4RNr1xgr3DonrTONGxFLAp+Yr4lKbwUfX6aqktBpAZDnHLFxEV3J+nhvgUn
 jApLyEFrEsoOGc0oRCJ/embebQAw76h40Z/JgXs1qfESAeKtvoUQq3TbzXBuIxUe
 OKovBLnROB6d/VXYxcfWDSTxpn7lHQx47p3YrDGfGrBb0D/D5K5Fgo2TwuLFjHgt
 N/Hbuld8wFqhWcMXgRkYkHHR2sIPMtoBV/oiR+kUQL7y15DogAx3iOP+RPP+Ap7r
 v0ySR/xJk0WFhH1fiT08XOIjTGLCzTlxEOLl+lCyw0TV/G8r8pwAbDvKluQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a98k2px-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 22:34:36 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c889d1eebafso8510001a12.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 15:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783377276; x=1783982076; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1hisPI8lrc9jvr303Ow8rYnIuuD9Px+8N1OoqJWGnWY=;
 b=Gz0TOwsfjrBA2Xu4XHONeVIMh2BA4ZcTAh8aZuMZ10ogPJfcn1PaGuMxOpHI1x5Agi
 +lJGT/RuQfw+AlXkDExjH5PLPJHGPhfv+pnhPUwAkHG6NtC1jnT9TzHtQz+kegfpWgl2
 tG/ONgtix0yxuKPu0EyqFITp/6BasAyBZSC+UGpOXS3HAeUUoQE5ftTyi3mWg5pNTsaH
 Xsu5u7m8j09GCOkCsoN4j/iBmHA2hCQz3RGqXyYPOOKzLA+v61W8ocZyff8Hi2xm4YTg
 2Zi6USLZFmoBKIrZieMSbmYCA/8OwTuewKsGAxtejSAabM+ImSiZIlXw6yYjhw4nR7Iv
 Q73w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783377276; x=1783982076;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1hisPI8lrc9jvr303Ow8rYnIuuD9Px+8N1OoqJWGnWY=;
 b=fW61UWJ90RDFVLzj6BLydM364uXVZp82BHCuziyWM6I4Zw24MdwirN3jAfTpQoo/K+
 dH0AULXboyn1l1KXDS803GTi6Jht7chtWGRE3qyRFQLO5tM5U8y4mwRM1vwzzFtjCzIh
 QTMHCjoWlMygR6D1rFny9uU2baOWVOfXISexN2XPG3grh4yw1aPDHd0uqLCg/396TZ2H
 7PDjgiIqfa3UoWOpKbgm/WP+tMdAcOOAfHSwy4o+Kwf/szCh/rOkkppUJULpZ4UgQo6f
 7qcWSepPXFxnWBsULw9GO2Di4r/9bJUYMKX/Q4wQTZfUmnr1vSstIzEydpbS+hjvupGo
 ZzQA==
X-Gm-Message-State: AOJu0YxS3P3gOkERV3UlrTNJXAsIlXopJ+TJ8Y/PmaROG2C5O068eJJa
 +5rtlJzXanR0oXvXTWvUBnl/IuvIOm5kMrZp63FwQ+VgD4gpUMS4E5Ye+bp2MogDaw+RJZSEEbb
 YJDWDh6Rctg+PNR9N0aVnr/rP500DBleBr1TM/83rrXlUnI/TbwypiX2MNzRjoA5Daw==
X-Gm-Gg: AfdE7cmNEukfZFg2qKL+vj+jg8GprwEyeP5u7ZrNMaFj8q+bqmLq1LDs7CWkCqP3kfx
 yUUOv3dvSH4DsLR4DJYapiAVXlKmj9RfFBwsy98dTfppURcufUzZle9jPlcdSL1Sas91eJltjtE
 tGNogx10xlamfsMGgVfFgVBvn92nkvs0cqtzF/LgzS1iy4LoIWFMhs2iLiGRAbe6t97XpfAmFf+
 X5ANVLkLfWXXMYRqiQZmj6Y2EK9zKlWSlZgMppWULgNI9vzjCPXoxrWLC3SqkYdQlwBEGEZgMjx
 S7iDW77h1/9rVbY57HLXJRbMWUKworJmvcD7MJgJMKJur/YmKgcI4XHOhYkfKVl8PbJdEhz0fwp
 G7LDpsDG4jo4LWy+FTUF9FqOAhLqc8cxCDyGdT1SfTEv3fOzFezZ//xcoUX63DJj7s9qCa8R2ae
 FFVGm4qA==
X-Received: by 2002:a05:6a20:e68c:b0:3bf:a881:4093 with SMTP id
 adf61e73a8af0-3c08ec78ef2mr2988344637.9.1783377276020; 
 Mon, 06 Jul 2026 15:34:36 -0700 (PDT)
X-Received: by 2002:a05:6a20:e68c:b0:3bf:a881:4093 with SMTP id
 adf61e73a8af0-3c08ec78ef2mr2988318637.9.1783377275628; 
 Mon, 06 Jul 2026 15:34:35 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31174ac0557sm977244eec.26.2026.07.06.15.34.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 15:34:35 -0700 (PDT)
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
Subject: [PATCH v3 28/91] tests/tcg/meson.build: introduce cc_dockerfile and
 cc_docker_arch
Date: Mon,  6 Jul 2026 15:32:40 -0700
Message-ID: <20260706223343.988769-29-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=SpigLvO0 c=1 sm=1 tr=0 ts=6a4c2d7c cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=fAk60GKZjlvebI5guTUA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIyNyBTYWx0ZWRfX5IbBvyXCoHch
 exxfttcsjfiEHynSAu4h8p5HP9IFYNAunoPI+C7aGy+AbyR7W9ppoBlqbktKphORO0G/S0m1j71
 P7rCxdwbjZ3dl1PpNJ3TSxIuHJBHP4MYKZ8/vLY7Ua1GtZuk2C57HcPEi8+ftn3hlPi7m6KHFb5
 aTowp1zJAbpCNf5pOYfqRAnBE8lAivz+hGgNp2IdNCvtN+b1XL40ZG37llPpbH/fzU1IoONv56U
 ONPdvD6ZHkaQtQmo66CvmPrD/Ff8OqeHca/0fjerSnENF/jo7PHso7OuzaWwrlsIP2DR6BBlnVx
 S2Q69wpnP8v45v3LYABWorzpJ0jZOq4g0smnOoBqSwc+GuJrPPrLuGh+P4x7FWMiY+lQFIcTEF5
 qvjnU6T/JYrPLDx5NkDa5emHHEGmarcDiD2hwnGpgbtXjBZshaFsa43I8xOZcuXtm4L+buKUn/E
 /J+KLFah6+OpgjZoixA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIyNyBTYWx0ZWRfXwo+xQAcNycF3
 bQShxheGIiUBjApAPdqDdcuEhlLHcUuBgFCZMTR825k9hs31unjcHprZ4Hh5l7cxAhDtmr28Get
 PsJJNMop0vFiKLTtOm+slru0t8PbmGk=
X-Proofpoint-GUID: M7S6f4xAaH_I_QXB8uj9uzyVbNa8qigZ
X-Proofpoint-ORIG-GUID: M7S6f4xAaH_I_QXB8uj9uzyVbNa8qigZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060227
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

We allow target to declare a dockerfile containing required cc. We reuse
tests/docker/docker.py, and correctly set dependencies for tests on
original dockerfile.

We specify list of hosts for which image can be built and contains
required cc, using cc_docker_arch.

In case we rely on docker, we do not build tests by default anymore.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 61 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 57 insertions(+), 4 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 0d2fefe8f51..57e7c3f8801 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -1,6 +1,7 @@
 cc_check_args = ['-xc', '/dev/null', '-o', '/dev/null', '-c']
 env = find_program('env')
 
+docker_wrapper = find_program('../docker/docker.py')
 gdb_progs = ['gdb-multiarch', 'gdb']
 if config_host.has_key('GDB')
   gdb_progs = [config_host['GDB'], gdb_progs]
@@ -21,6 +22,8 @@ tcg_tests = {}
 # {
 #   'name_of_target': {
 #     'cc': 'cross_compiler',
+#     'cc_dockerfile': 'name_of_dockerfile',
+#     'cc_docker_arch': ['host_arch_supported (meson cpu)', ...],
 #     'cc_feat_cflags': {
 #       'name': ['feature cflags'],
 #       ...
@@ -75,10 +78,14 @@ if gdb.found()
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
@@ -89,8 +96,8 @@ foreach target, plan: tcg_tests
 
   # return a clear error if user misspell a target entry
   foreach key, _ : plan
-    allowed = ['cc', 'cc_feat_cflags', 'folder', 'gdb_arch', 'gdb_feat_version',
-               'qemu', 'tests']
+    allowed = ['cc', 'cc_dockerfile', 'cc_docker_arch', 'cc_feat_cflags',
+               'folder', 'gdb_arch', 'gdb_feat_version', 'qemu', 'tests']
     if key not in allowed
       error('unknown tcg test plan entry \'' + key + '\' for target ' + target +
             ' (possible: [' + ', '.join(allowed) + '])')
@@ -98,6 +105,46 @@ foreach target, plan: tcg_tests
   endforeach
 
   cc = find_program(plan['cc'], required : false)
+  cc_from_system = cc.found()
+  has_cc = cc.found()
+  build_test_depends = []
+  build_test_depend_files = []
+
+  if 'cc_dockerfile' in plan
+    cc_dockerfile = plan['cc_dockerfile']
+    cc_docker_arch = plan['cc_docker_arch']
+    allowed = ['aarch64', 'x86_64']
+    foreach arch: cc_docker_arch
+      if arch not in allowed
+        error('incorrect docker arch ' + arch + ' for target ' +
+              target + ' (possible: [' + ', '.join(allowed) + '])')
+      endif
+    endforeach
+    docker_arch_supported = host_machine.cpu_family() in cc_docker_arch
+    dockerfile = files('..'/'docker'/'dockerfiles'/cc_dockerfile + '.docker')
+    image_name = 'image-' + cc_dockerfile
+    has_docker = docker_arch_supported and docker_supported
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
@@ -191,10 +238,14 @@ foreach target, plan: tcg_tests
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


