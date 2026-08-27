Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05608C61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:17:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziOK-0006vN-P9; Thu, 27 Aug 2026 18:16:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziO7-000693-FX
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:16:02 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziO4-00068v-DK
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:15:59 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJLgTL1358579
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:15:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fI7SwyIiAwt5aVQmocAsX+WFU78M+s19fjtxbeNbWRQ=; b=hbwFDgbtjQ664Pp3
 wmRIbCJvis4Kf4Y2dc2qfF6FbgJl7/HGUD8ZwftvTPs/e7wSho038GydK+w6DU2A
 fU0TkxpVSyHWtxmYM0UwEdJhU8KE5skWayfbJzfnhKLkxTnA3NBF2QAv2JQVV53v
 lF1x4pQZTWR0EJbZeg0kbcbjJUrhBUfEaS2Pxslu02clJsAQDpJp7Cs57xyOJjrk
 hDlZwcVkUjwGVzegPY0JK52gJLNHjcXmuWMlaHS+bctpRL9iq3OCaJTG/KjONq4d
 WzHB+v0pOQO+71MbDRZmcJIY2A60aSa6BvDzzi/V5lJHPksejB2z6M8QkQ2hnkb7
 zoUNSQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gapgva9uc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:15:44 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cc1bbd7d6e6so406702a12.3
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787868944; x=1788473744; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fI7SwyIiAwt5aVQmocAsX+WFU78M+s19fjtxbeNbWRQ=;
 b=DyhdL8/N30Idajq60g1/QXMEuiclrgvO+j1tDt/xLzLNcO1plCN983SqE3Hm5hCajP
 8xFAUPBjAoQZn2t/TyEP0D9z14uakwf4SwYcNbNGeO3uSlJFKRjeTwOVCEgluOKwiTM1
 sQI7M6U5VBI10hIV5crB5hkcWN6kWuzQDzJ+nV5gdT5uoXUBreK9mkLNyhEMhWmU4PYY
 DUYrhwJc00zH2Ijrd1paauHINgrUkDyYI3EEgfzep2tt5NYpljIETScFMlMaoUPHHY5Y
 iYRckC3WTWgsiXpMh/tyK00BmEz17vQvgkrqcQPdO/vsQgui7Oa2lS+eIAoIVhIb1PXQ
 RnIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787868944; x=1788473744;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fI7SwyIiAwt5aVQmocAsX+WFU78M+s19fjtxbeNbWRQ=;
 b=ZPYpV52OEhAkS/vTWGGLvhky8mu1qvxDgLgFQ2VaN7CUeK0PZRqzAUcapzpj1rbldU
 frWGx2gp1toW/3fa600KUqyUo0H6y+tKErHasSuNuhcttexUrbKWMkSZvV+gUJswBjAD
 ZxJayBR//5E2/NTRdzBtHLqRsejgwQ5zy+U3e2Fpq3il2xabGTemQtJZXov95Bpw5D24
 OfbFxgJeG+yEj1dttgnnLnd2usbS8ebiILYlZi9yC87bzzpIuEOKEneWy/ETszTYlqM2
 d/xFcjd942XmB1Z8MgdHcTdiTwTOgIV4CzD8WaiRnr3kv7LZeE9AiptKrNy2VM5c90JR
 sCgQ==
X-Gm-Message-State: AFuF++lJLO/yTTF3CcuxZdNg9JqR+2rjyJY6hhaQv2pKWkzr9Rk4zf3Q
 guwGbosUdiX2DSOc3N54hMxUWOFpfUntGIkIASNVRTZ1V0WQ8dBPg2gFSBp0927n8dirXzBaeLC
 zr3Yke8cJ6sx+jonaaPcepP6Il6Xe3umMtiL4IgO2xZusufZuch45dYlc4s1Z6Ae57w==
X-Gm-Gg: AR+sD111FcWJpr0UaEpAJ+Y7o7gmNbfwAzgjyRvJPIO/MqfecD9ow6z7nS4RWw8yPjm
 UhdvsrHgeLyqlBEoNl90BvPanBO8yQa6ccOluZF4ihRcYV4faLyHcNg9t2CJLBlkGaItTOK5eue
 HGImjXb9QaV/wjeqSPWhu0XHv6Ua7pGz0Wa9p0P2y/ig7O4ucAJ3N2rkKqxgRSOG7YY0h2rxIkz
 NN+5mLtZOQ61RN3Z/GeN2Zoip90mccQHZTMNLUanjjYzkxXexgKFJrJ7HNylIsWeN6uksUX6KBd
 QgPiqIemALIEKvk7em+iuhFDk1Nm0Y5LG5pxL/93PazGVH08w3Tghk43eEhfTLH/JB7aJdSpxpy
 uv/KXAg2l1rGfMtr0zZa2ey7dMtJfkaQ9xWiZNYXXhfsSijjkw2ajJzrdzeQ=
X-Received: by 2002:a05:6a00:4187:b0:852:3726:dfde with SMTP id
 d2e1a72fcca58-8562b58e1b5mr5119374b3a.9.1787868944177; 
 Thu, 27 Aug 2026 15:15:44 -0700 (PDT)
X-Received: by 2002:a05:6a00:4187:b0:852:3726:dfde with SMTP id
 d2e1a72fcca58-8562b58e1b5mr5119251b3a.9.1787868943605; 
 Thu, 27 Aug 2026 15:15:43 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535cf4b213sm2524104b3a.55.2026.08.27.15.15.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:15:42 -0700 (PDT)
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
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v8 028/105] tests/tcg/meson.build: introduce cc_dockerfile and
 cc_docker_host_arch
Date: Thu, 27 Aug 2026 22:13:49 +0000
Message-ID: <20260827221506.91574-29-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 2mVtCE00T3tNcY-yzJjDNJCv3l_L1OWq
X-Proofpoint-GUID: 2mVtCE00T3tNcY-yzJjDNJCv3l_L1OWq
X-Authority-Analysis: v=2.4 cv=FpU1OWrq c=1 sm=1 tr=0 ts=6a90b710 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=VnNF1IyMAAAA:8 a=D8BCvRf4TFo9TPcboT4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfXya+Cgq4SWVfz
 xUGvjRRfp/0wLlY4tvT/5pYmyhV0Pdzhl4AxB3fHy88UOtYMnZLBVYiiFVUVrqIp5Z4tTuYush+
 Ogxl7H4kLpqCYRGcUNaemvCJhM8ssZ+wY8lJBJ3ZAJcINt/wupE1GDIjPlTomVaVC/Gx9Frmj5n
 TAXurFXKNXZekPCvCjtRVNc5S3Im7U/Rezi9OEjtrqUMjMUxMXv3gAowWKCmFCcNTT5/GQ7woN2
 a4JXZ4h/Esp1weCXrQbAoNeQ4IyTHFrAQ6Ho7ekKW3jDrndM9xLGCyTeuX3k1aSzFc5ILV86Lnp
 4IHnujHUK+5oRPA10rFrbdC9X+cmjQWxxGxgAzdUpaItu/RvpmWmvdL0KO//R7xBg0uHCrmtyNK
 7TjyHwx1AxSaDeJyJHyF1QtCTFfhXBh9bOoMjL9m0VM+1w124JMBauIYVyMkafp0dIM58lm32sd
 0/wzYM8j2P1ziWR7elw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfXw9r0Im+H7uyC
 Iq7E65adPptrpScg9HSenetNzx6Ny+sr3LBTPgXTuevZMVfWgcit7Pwk1lAj0iqZ0v5Rp/qxzw1
 TtSLn0ZkbRLOoGVeYv6/hhBcid0UJgY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0
 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
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


