Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59D07C5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:27:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPPo-0007P4-8w; Tue, 18 Aug 2026 15:24:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPPm-0007Et-KW
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:24:02 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPPk-0006h6-MY
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:24:02 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IIaUoM1940383
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:23:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fI7SwyIiAwt5aVQmocAsX+WFU78M+s19fjtxbeNbWRQ=; b=Peo9SRmFk4635bQ7
 9FOuGC6Fi/c7NZIC9fcUYuT88dYuNlbmS6kFIeY2NNBeiyqtF3WhzYHHr9eKc8ZT
 FpiiAMGhjoEXnhdWtpNc2YoArNG9Oi01V1TORqDTDy5WvT9d67cEu9q8ju/vkJr4
 DuOCtlZLLehjEuBedaXm1mEXqJ9Ld4eXSt9DZ2PBnfHuGtGImOtBNWM0CSVP/ukK
 vDYyCG0lYQA0XFbBh3Xgd7zMmuVZZENiQdVUsmfnOdBq2UDc03uZi96Slg7gT7ID
 6QE487sfrhX944sau0q8YCoY3O1ndskm4efdKVowWownLaqEWndNwQjuF58+9d2y
 VoG8Tw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4vtu05kf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:23:59 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38e6d253330so111460a91.1
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787081038; x=1787685838; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fI7SwyIiAwt5aVQmocAsX+WFU78M+s19fjtxbeNbWRQ=;
 b=PgSzPd33YALChPWIIEeltib1Vg3nTIY+eDnUaHpgXvDVMiPv0gq01fc23mriB13OJL
 52UwbyLC5MVhyRVsGmjzOSexQ6d9c5mQKrqjUlbNji8UlcLSrOebULWHW6/SqAUuSnb8
 XlqbFLmzV09Ve3K22tWZLjcgnWXEl7Msp1ZYKNEN8yHyWbFnZUGyj+lBVB5f/rzMqVvE
 zkScDfc7CmC9SLpusCvKs4EHS311weM4g8UnCXCf+5lZej1F55Eyz/vl3SUK/qkI/dBH
 Pb0hwo0yQmDiWk1wPXb9ebUCNvugl32h2gbZgzv7XtVsW3Nq8RLTcerOLaPVjMyEUY87
 qZBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787081038; x=1787685838;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fI7SwyIiAwt5aVQmocAsX+WFU78M+s19fjtxbeNbWRQ=;
 b=IzdayrLi/ppWgYLOPlm2CmjFXpnvn34leFkeaf1XMLNJWgrKA8jO3DWf980yM0ZBg/
 XhxpYM5XoJDaYZXQAbNkTYqMtRwRFeFDBFv2ptsGb2jbLjz8TdNEazhD0hXcNnj+y1VV
 ZSKHDNsI3hAhjAbREGjyzQhuJw0E3HnL67pc+uo9e2AHP5yZd1z5mfiNNcmFWAQPqJIp
 //QfKeN6IkfRWioMT9Io3nqIzPW+vzZhnnksSki2pZkQpdZdW2YVJOcv2IcBsz4lMHjI
 n32FZ/NO4cC4ptewa7Qon9cLnHuitHnz4BMIdLy6yVhN/wtbIAxiLCRq3r2jbOZAZ5Vh
 DAqw==
X-Gm-Message-State: AOJu0Yyp6n9WFkJB7J3sOhDWoVSpa8fg2xRrDFxijxGPF8JIVWzR8wxC
 P9B5FeQqzRyxpeIWiO1z1IThVKsLHxLggUyMbzZi1aI/iJhvnyrZ2cuZqXbxap3HNKr7NEBQ/WQ
 nhInkTHVWAZVVm3pUiQwkZkJLkHJrDC8s7bwwxF3Z5Ww/SqscN0EAIvt3XcxDUPSMPQ==
X-Gm-Gg: AR+sD13wLY9Vi0A/y1Q9x+MTaghaKJJnJ2RRj20prwjKHqFiGZt0rGLga7HQxUJke+/
 YmhUzfIJRgKTmWmoW8hn/BYRUOT95wmGsja2ruqexxwD1wutZsfJYw0QtapzxE5kIvOQOoNFvhz
 2/mnCI4X3xBBvEzKdCPGqHKDlbIwQnNbf0TPKxKcOAY0svmKgqEG6MDkBgOtTGHk4lSR+P5mTF7
 s8CPT7zjG8tY+yQa26VtqHNqX/wPjAIhgMsq00ABGiIYV13msp9P2JUFA17ZWBsCJYGUse7GFhQ
 DP8hkFjWwa+NPk+bBFdDQNl6JvtI/aGGDxKW/06+jK3UUyy8twyD9PGPMqYVOZ+dZSDf+e4uz1K
 RylslYyDtyoJLEhvYGyvlEzZl3E8IBagLeyG4XNLImHRUFuIOqbUEk244Y4w=
X-Received: by 2002:a17:90b:4a81:b0:38f:657:6823 with SMTP id
 98e67ed59e1d1-3957992752dmr412573a91.8.1787081038294; 
 Tue, 18 Aug 2026 12:23:58 -0700 (PDT)
X-Received: by 2002:a17:90b:4a81:b0:38f:657:6823 with SMTP id
 98e67ed59e1d1-3957992752dmr412496a91.8.1787081037789; 
 Tue, 18 Aug 2026 12:23:57 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3267c897e37sm21879429eec.28.2026.08.18.12.23.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:23:57 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v7 028/104] tests/tcg/meson.build: introduce cc_dockerfile and
 cc_docker_host_arch
Date: Tue, 18 Aug 2026 19:21:52 +0000
Message-ID: <20260818192309.22169-29-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: yI5o1VnmLFKdb6i68Q5JoL4Q8X6xY92W
X-Proofpoint-GUID: yI5o1VnmLFKdb6i68Q5JoL4Q8X6xY92W
X-Authority-Analysis: v=2.4 cv=FeYHAp+6 c=1 sm=1 tr=0 ts=6a84b14f cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=VnNF1IyMAAAA:8 a=D8BCvRf4TFo9TPcboT4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX5DRC9Xl8SAwL
 DpTlEIvGUaJhNYLjax/X+wllUjvhqim1PNC9rE2rUKgqvTf9HBUq2dG0y7etOY0p3AJl23slNj7
 BEteo5AxokNoBKr40oBIHUJugje/k4pFPPTYbrybsXKoLROJsbDvn5fxh+B0Mho22KdX8fXEdar
 WP2EcIVNKLjql9G29eKasuBjBl30ECqRPDzwbqFLdS6j867qYjahPvEyOKcV0yof21arN0sMeNQ
 1Gkud5M2BVY4jEbEg7/ei2sTzhnh2NZwuYPzNinavQuomMNT4lWUtdcOjbpvHxmrCFNh3P3qZE4
 Q4i9nbR69bN4k30KiKOQxsQ02FcFpOJJZJmJqf2y2XQtNt8NZzS1vQ6qLxK92Q6vsIhLHXONklp
 ng1EAhmELroHb8kuGDcandSGM9/CkdUkS2sq+ijMm5y5wYYqJyoJxZc9QnqDxM0IMqmq+xBt0NN
 6TOiZ32GKktCLK5Us0w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX3/Se2IsJma6x
 I9kdeUf+vOnkXG8zlc31mKo+79/ZIupjtX8qubHLnw5Bnky8SicDCrpXQo0uRT+69GtPvG2N5Bx
 L2mniqoAbw9QUpkHruR/iSdRPn8deR8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180142
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
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
2.43.0


