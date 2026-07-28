Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48A93C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:45:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZfi-00059o-O5; Tue, 28 Jul 2026 00:44:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZfZ-00052n-UV
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:43:57 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZfX-0001cZ-SC
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:43:57 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S3apGH1673508
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:43:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hQiCEv7OQVF2XBiRoQAoxE4vITQCDDOhUG3u9Ulorhc=; b=h5lZ1yxd65GivtLi
 bBnw+BdOWo28qZGQ8webka8f2ESU/nZbvqvy+zCkT3ciJjknOhik/cXdljOftqgK
 gbp6fN7DXZ9FSY2RAeoo0UVC1gBF91zExjvVMZyQuYrackt/5jZmBkfbmEIExqay
 taM7e2eGTsVSYWq+RJbdoM3X7h/1K3Wkum6bE0kC3C+ZB6HgmeqRIy6kmlbXVBye
 SO7fM+u4xve8ZVr+7U23s/7kBL630AyvQ7vPM1uVlEnHG9P+m9h5l328LH0h0oFY
 ivOiFumvZOY8nS1kI/Pbjy5Cv3seK+/zCCHrykPfySWzT/WozKyF+U0cS7NOgrnD
 8IaMDA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpbrstbx6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:43:44 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c85798977dcso5263015a12.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785213824; x=1785818624; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hQiCEv7OQVF2XBiRoQAoxE4vITQCDDOhUG3u9Ulorhc=;
 b=Bvc8Xq7VCQMXtYayUEcK4/4b3T5XscKZyspmJNrzAjsehpwknMVglJEWLaWLGuujWx
 Io6etvb39UrRqM+qgr7PTpIxx4su0XFIgA2bPiRgVwkdD/+5vRIei6+J5Wl/yXfh7t71
 a2BzHIg2lACmMGtgJpClfkgvpAIKqLjVP5gVODpZ0Rplljf4nagvw0X1ZPnU/Ppy8xFe
 1bJabJCanuG5QOlfKA3Zlfp2wjCWtnMcSw2wLsvU2D9/5ArxGIGZwLBOptkOAYSrttoR
 ie7RbM+Ddcl7Tuq22Fhn0/EcIQYvi0kiB0AHWSRtoJ+vIEtfWUU1Mmjnjy8OHhHVczoi
 myeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785213824; x=1785818624;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hQiCEv7OQVF2XBiRoQAoxE4vITQCDDOhUG3u9Ulorhc=;
 b=Uj7Ot+rY0vYx21UVNmP6VWOeTMggQvqE5s/s76ziTh4XhqAHnZClryFjqd6RQZWddR
 tIRgRuQKUQeZ85o9iWm4cimsrqcPbWdUULqMQqfRczCKkrcs+ZMFA5YcpIR+IN1HgP43
 5upEnggJU7C5S/PXnQiuVLZcocGrB724ilvR7my3vLMlG6NF0tt+3d18XJKXto1TK0kB
 kTwd162vzwbtHjrfcnL2z5N5xwkvbdLREsXLz+hsNL8UjdQ+JfzHeQs3n9WLCvFUzzqn
 oXdtrb4BZuNa9C6bDV8fHJnqtS5DhmPBt6TNCg3gpF00ywFZmtUeJx53chZYp98qG4zs
 /j/A==
X-Gm-Message-State: AOJu0Yy5luVpIH39UoJiUAGqp5KlvVrPshnLr+zR9Jqnk7SzfU75jZQK
 ysEkoZuMlrXxNqzg+gvzZvGz2OoFb542DchHYhTr7Qpdn4d13jqIbQ6XYBMCvMJcE3w+2jdacxi
 idt3d24X3iaWig7RXHKzus+5l/xZ5qy+WHM1Ry/et2O1vCudGv3ffl993+2SUvvppiA==
X-Gm-Gg: AR+sD10hB/i9/o0USBfxSIFYCgUSSP17vdbyxBC0ZfyzJzhm8IRp1RDY3BqfNDsBnhR
 6vV1enqRIGFiqPjPA0waal08oq1qjTbA97FuHGahugCPVNx65MGUE7vGCWFIMwL+ndijBU3WOAM
 +ELWxBqspTjQmhf97+oSCl/HrdSqB3Llemjnz3hYeG8x14vPNnPtC8hqDnrxvCWsK520rrdyPPH
 Mm8mvUX1YDpmc1wSZ0I9FsduClvMvHhTGlxOndrSPX5eYENu5OvnhwfI9dAjc2Je3E90eAyR52b
 YsWea+sfz9/P9h7wvDZQHgs3+uhhqE7vg8bOFCxvqlHG058yFGPFsPlDEoXhuY6kBbzspwdAvVH
 QPar4UsmhWiphwd8CXXM/s3blutM352M8a9WipwsHmGHPsatS8CoI3VnVRuMGr/E46SHujEY=
X-Received: by 2002:a05:6a20:7343:b0:3c3:9a7f:72fd with SMTP id
 adf61e73a8af0-3c8ba5ac31cmr1122002637.44.1785213823920; 
 Mon, 27 Jul 2026 21:43:43 -0700 (PDT)
X-Received: by 2002:a05:6a20:7343:b0:3c3:9a7f:72fd with SMTP id
 adf61e73a8af0-3c8ba5ac31cmr1121965637.44.1785213823446; 
 Mon, 27 Jul 2026 21:43:43 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc3e878esm38795784eec.3.2026.07.27.21.43.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 21:43:43 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v6 028/103] tests/tcg/meson.build: introduce cc_dockerfile and
 cc_docker_host_arch
Date: Mon, 27 Jul 2026 21:41:32 -0700
Message-ID: <20260728044248.137626-29-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MCBTYWx0ZWRfXz4gpJrST/idA
 7yMVK/SSXCO83Ec8cxveuhUrOGAieFyWMvAgFmaWZDds+6TQz2Rojgw0fjAVALyy/XBwO8ptILN
 yb6qHDI+xdDD3fRRx2m+eaf+CtTbF1dviR2tgDeSpbJJ3rpe6zrcnlD1reeLiZJcLtMATlLgMln
 vyg++fQ5ENJc2izFZ8Kum2qTTC9nU3/xlEvnuE2Vd4itGZQ76S22yT5QFK35u6prbFM0Bq188Fp
 k27sPPVdF479Uu75Qjk+WHAhJlNWRfkfyGLgQVkTPadmhm81Z0uXMPpKbXWAomxWU94h1rTwp9f
 dKXlCvs5lwS2+mn+nHWy+3W3DP3HcYYhQhqpTeUjKNfUWw50M/pk/u6Kn9ihAJwzh5zv3t0VvKu
 SjBGr9DNCeWEwa0W/YFcZnvfpv86TWIV65wbMRaWu7LjNzbp25+3d8LAi3zVTfjTVke3D2Ml+l6
 AigFgRJkA7YKnPxyGgg==
X-Proofpoint-ORIG-GUID: ZVOZPK7FtHC8cyaqChzZ8aulQaZxq8Zg
X-Proofpoint-GUID: ZVOZPK7FtHC8cyaqChzZ8aulQaZxq8Zg
X-Authority-Analysis: v=2.4 cv=ALkdLnG8 c=1 sm=1 tr=0 ts=6a683380 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=D8BCvRf4TFo9TPcboT4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MCBTYWx0ZWRfXx9MjTbjk7cOM
 LYs5HNyMg9cehzVQqxiW4wK+mbWazidDVyO42b4DQeHUEpgXuN2a2P6BYUcMqLnrC07zn1QELh6
 3JPqIeny0qkRIuUz95UqHTGB8dHrv54=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 phishscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607280040
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 64 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 60 insertions(+), 4 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 9c00d21f059..ab7090a62fe 100644
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
@@ -74,10 +77,17 @@ if gdb.found()
   endforeach
 endif
 
+docker_probe = run_command(docker_wrapper, 'probe', check: false)
+docker_supported = docker_probe.returncode() == 0
+if docker_supported
+  docker_wrapper = [docker_wrapper, '--command', docker_probe.stdout().strip()]
+endif
+
 # plugins come first, as we need to build the list
 test_plugins = {}
 subdir('plugins')
 
+image_targets = {}
 # Finally, we can create all test executables and test targets
 foreach target, plan: tcg_tests
   # Detect duplicated executables/tests, and report an error to force user to
@@ -88,8 +98,8 @@ foreach target, plan: tcg_tests
 
   # return a clear error if user misspell a target entry
   foreach key, _ : plan
-    allowed = ['cc', 'cc_feat_cflags', 'folder', 'gdb_arch', 'gdb_feat_version',
-               'qemu', 'tests']
+    allowed = ['cc', 'cc_dockerfile', 'cc_docker_host_arch', 'cc_feat_cflags',
+               'folder', 'gdb_arch', 'gdb_feat_version', 'qemu', 'tests']
     if key not in allowed
       error('unknown tcg test plan entry \'' + key + '\' for target ' + target +
             ' (possible: [' + ', '.join(allowed) + '])')
@@ -97,6 +107,46 @@ foreach target, plan: tcg_tests
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
@@ -190,11 +240,15 @@ foreach target, plan: tcg_tests
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
@@ -206,7 +260,7 @@ foreach target, plan: tcg_tests
         cflags += cc_feat_cflags[cc_feat]
       endif
 
-      if not cc.found()
+      if not has_cc
         skip_test = 'compiler ' + plan['cc'] + ' not available'
         built_tests += {exe_name: exe_name}
       endif
@@ -223,6 +277,8 @@ foreach target, plan: tcg_tests
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


