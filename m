Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EF7EC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:23:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4cA-0002Td-To; Fri, 10 Jul 2026 02:21:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4c6-0002AD-Oi
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:21:30 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4c4-0004nO-Ld
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:21:30 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3moiI3629749
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:21:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=lrsScN7X6ef
 WnATytKRfNmaT7W1kKhhf5FdgZD5pV/E=; b=gjam7+fOun7upUQoX0TB9fiq4x7
 hwJ2wUkyRzTZ7uFLXG0sSzEMXDboNprlr0UJL1TF1XbmJxFbJhsn0HiOBLYwIHdW
 FgPXrUZQ3pEleWsjFbVyffTVACamdtl74ufOJ2E4CCPb/Cw1ol4MUJjnTsk1+hPm
 VIGecUZAUepCjyUMsOAM8B1YHVslFz9p19K9S3B1ARcH+UnRlua6jBpLU6+efEwZ
 qn+TnTeqxbhmgp7f5Saqi40Gmd1SKLul/Gvq6cRzwHkmKjfzV7Sm1apis7qLXl07
 UD68GlfaBamYWyPAMF2RiNz1Vu8L7z2jux3G8wU9Y9z4L6N+k7mtgWNjX+A==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fahv8hwwt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:21:17 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c9c26587e67so639485a12.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783664476; x=1784269276; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lrsScN7X6efWnATytKRfNmaT7W1kKhhf5FdgZD5pV/E=;
 b=aAKujceXO3afr8onFMk7tOXvbUqr5gmVcio/0o/AufDK9dxKlPc8iLuaaNVTtEfdrq
 2zlP1WpwpW3hjEtrra42howk3WKPGomZmumi7OH9VmCCmdkWRZrwNFLyA3lh/7CKxML+
 TgTns+ONscBAPEzsnzmbnLA9YdPDu97NngKGAfQKfsuxLUh6aS8kr7gLRh/Tjo9YoTt5
 NnGVjb0ywBe5sjeCHD1NFUKjBRRioyjOpbwSmLcZdP6svnHyh16FDYy/cuk1WczR9Hwb
 N7omr89CsySHSefo5XfkRcNyqRnEI+b1lS+tlvq1dUtXVoEt7JZhi3sT/BYTtL5ZM4A8
 jL7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783664476; x=1784269276;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lrsScN7X6efWnATytKRfNmaT7W1kKhhf5FdgZD5pV/E=;
 b=FoCVGqujTWj5mVGM69SZvJZ0cVb9BraAe7G2zst1L40SaKdL0z+ZuhE/qtxa79EbTl
 H4wOMspj78DGVWuGQpbfnqtxbVBlaZePVf6EBvRzN6ewOoH9925B8hO1I7nDhjaDk+fR
 W0e55g6DLWqE/2IPUz9Z4l7bi4ZgbCRoHcDCtEpB1z6K0AiVnyQB0FMlWxebSRKimuzI
 Ufrp6NiVwR/p2Y6tUgXxrjbZMXwAqmDc9B9h+sq3i2SpBzK0ljfQH+7XyoJOvDh6vbsT
 +HsJ+kCBGCdXcULfzULJbCfu3XExhswiIYRGS3dJke4xvUdCtScHrR52pbMUcsj92Pdb
 x1VA==
X-Gm-Message-State: AOJu0YxdhJYwSC78DoFcqyOU2GqEMovG4+cacVoNphvN+sYTUgc0tg4P
 r/TN8o/b+f5D3G7jRS1jE8TPkqtp99k1F4mKa0ZjkKaIn9qxQNfrpjmJxkXWxW+31xP/778PP62
 B0lczbh9PLl0voitvEE+mHG7G9oJItBmXN8widqEHAF5hC+uK4zLTzAzCjCyPjVVsaA==
X-Gm-Gg: AfdE7cnoEZ/gUQaKG2vWVUTquaVf1N85CNVMzFHE/eQimpkp8qxpEHn4+vdSu3ZEpa/
 cZqC4euhwZ23bZG/b7q57CheSYM+pZNGcu8xa54zytcpdkn+mThaJ8qkiQWHgl3AjmwGBpuJ716
 5s/mF3QKTYQJDcWc8h7XViXlLGvR6BP6mMMVQGORaFeLOVBXtzQm0+ryRxBhOdXWH3qMl+mKEpF
 dcHEcFj99u2Oq4ASpbntBqTPB6YO3BIaUXnGKs5MtauNXHoLrjW2czG7vXM06+UujWAJoUmTwfO
 aet6uiOV1GEvIg2M550f89OLucI9OG8Ikfw8XNua1ByadJ+K7HxgErOeVCYqHTxyJGnKeNxBhmv
 sTX4xLyr7kcBcrZb4rpvADKedtK9EkmJ2hpkqxpwOmlSMnBeRKUy8mBPavQ7ZPSdzbxsOdwzUgz
 8/ZD1H5Q==
X-Received: by 2002:a05:6a20:cf85:b0:3c0:b598:4983 with SMTP id
 adf61e73a8af0-3c0f0bc744dmr2588992637.30.1783664476377; 
 Thu, 09 Jul 2026 23:21:16 -0700 (PDT)
X-Received: by 2002:a05:6a20:cf85:b0:3c0:b598:4983 with SMTP id
 adf61e73a8af0-3c0f0bc744dmr2588930637.30.1783664475820; 
 Thu, 09 Jul 2026 23:21:15 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659fa13bsm35428126c88.15.2026.07.09.23.21.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 23:21:15 -0700 (PDT)
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
Subject: [PATCH v4 28/97] tests/tcg/meson.build: introduce cc_dockerfile and
 cc_docker_host_arch
Date: Thu,  9 Jul 2026 23:19:06 -0700
Message-ID: <20260710062016.1818125-29-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ijnLKQQu6NJ2iAv1dDS9QUznkuS1igrM
X-Proofpoint-ORIG-GUID: ijnLKQQu6NJ2iAv1dDS9QUznkuS1igrM
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA1OCBTYWx0ZWRfXxfTkpsV7KT40
 CZVBHvt7DNQv3hn5uhXTcJJutEHOcZqY46x423FGTjXi8n6Pc+85t0lWoCfFZflf8I+1fHWl/et
 29PhapJjibnmbZE8ALQbAkDiXaaxY4I=
X-Authority-Analysis: v=2.4 cv=funsol4f c=1 sm=1 tr=0 ts=6a508f5d cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=qzorxrrS95WKHyIffIYA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA1OCBTYWx0ZWRfX/MZr+kHApQBY
 QgyT9IbD8mW7PrnbMtycy9UlFJo2S/k1yPju4YViGQUyuKVUEUIrE2R4TyIZ7j9XBomX0fZzTNv
 n8L1bxEaC+qpDPEw6E/IT2rDWobAt1db0wF3vczgC2xBDaszQWo9LgA5EyDtIpK4hGLCqHJ1xkN
 WRW2Orw0p9GmyRJedm2ANrzf2DKINBo3QsuONY86bhUZfp8Qnolpcjf+COHdRDiGJqVG6O8RM01
 HLceylUBwSGO2jRqmtyVLr2W4qT4ayHZtpLwnYIWru3nvC4oOGPgAqsJCXmGL32NEQ2q3BQmSda
 1IpeHLKKMJGaMn67KPR3mH7+p18dflraeS0Nx8aWSWnUdYAmZ1X9x5YZfGNwEO8CvvV+vReJTWJ
 946EJDvKm/Ij373V721qY1/LKpEteNEVOOSN3DwHsEV7JQZSmnYNCz1HsIktXbkirk7tDZGycom
 5iplIzOC+gBR184vG7g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100058
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
required cc, using cc_docker_host_arch.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 61 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 57 insertions(+), 4 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index cb58ad25a1a..eb17b0bdd67 100644
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


