Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D226C61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:08:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziG7-0007YP-JG; Thu, 27 Aug 2026 18:07:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziG5-0007Wg-Hm
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:07:41 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziG3-0003X8-EJ
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:07:41 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJM2DJ795306
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:07:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fI7SwyIiAwt5aVQmocAsX+WFU78M+s19fjtxbeNbWRQ=; b=Tnyqd8wyL0VXR65f
 YJh4SjAzWFvI2U2YIpbMqu5fLAkiu0JQWZUG9jSFpwctbrSNRKUs3TU1rRMLpxK2
 Im0JgeBSjxjA1iXlzh9aYNbqXktap5JB4egpwNUXBHiP4WOBwnd2r99BuwAWEXOu
 4peigqQbV2UM+m8YFHc/xu1Ka5a0UUO2ThPF8glk9qQGSdH9VzeLtcDzxuR7tkNk
 uOv4u/AK6FpISGFgH1awnipKR04EhyCTEA9PaQJlTdp7uGuvRHZSCl4iIkvNDZEf
 TmEIPPGHWt8VRxhALxeKQg48icsHd6c3qzc+L6EJUMIbsh/te3mcl12KWC7k8h53
 SdHVNw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gam6fjm7h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:07:28 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-84e048a801dso226441b3a.3
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787868447; x=1788473247; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fI7SwyIiAwt5aVQmocAsX+WFU78M+s19fjtxbeNbWRQ=;
 b=IJhOV4/mXKcOZgAmnTYWk4IkgWnAOql7cqa0skYB+O++nGPNa8dDjtbs+Ir6v0WZfw
 ZvSEFuiw4FAVpho0xk0CwfdJgtZCpzx5qt9mr2dGIQg2LT/mdyTw/UjTupyZVkbleUvn
 +8L2SDSQt08OcweUe9W1mikYRwe5KFZOcuLjD9Yp7b7MYklPCfqLm4TftNNfmLksc1PS
 IGKWcHxgwa604wIwrUR+glj6T3FkLUy8W8BKnBRFioj/EMYP1SYHabBOnxSAFS15Igj8
 302YXh5GywSHuwGS8xvdT0WGbck1KMWvnO1xYaybhsg/DuWaP+GBWsdoHA8goXJ04fs9
 erSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787868447; x=1788473247;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fI7SwyIiAwt5aVQmocAsX+WFU78M+s19fjtxbeNbWRQ=;
 b=UBK24tuqdH0FguSFQ0J4zrWMV7h99X9kMeW268AxvFYU8qIRYZ5LmmOJu9tukn6ws9
 sCXRHRMwhkop7VIbATj6gGNgpf+MCPGAV99APhz3bGmuE3O9RDsblXwNVuSXfpf+BRiC
 SvTPuflnmJQYLdcQ1dUFnjNNg1CrhDfLm18IKz+O/B+c8/PXISaod8516kEES3ZrZJOm
 2mjXljyv8c+NqxvEZsymDyOrOwYgE+1bNws6EfbB/H2Zv6RWb8eUbnCzxtleLgaqsOxG
 bARldfPG2ac7XFo+2uCxtn51B7yOe+jqu8CNX0YRijFI//Tev4xHB6zeCFGttuTRkdmX
 1+9Q==
X-Gm-Message-State: AFuF++m3BSm3BqiKOPQmJzJyupNI8U9ttaPuIgEI8J0kLaIc+YGguo6g
 TJHUhbL3kJ8fJ4Lx7c0II782TFU4NUU2yBC5e8Rd3iNf8fmjRvbfLM2oaJY2i1kQW5aH9YZ045y
 UiHXAiJS4D/NCWLbCi4lnM3OD39esv0DplZkH55sVEUs5rrnezg/UxiszJV50DoKacg==
X-Gm-Gg: AR+sD10loEysCxddlFlNANDj//rjz8/cfHudLfpSz4dYpR7LWj36OK5i9PrmX5wOEJc
 WG197pq2O56VeB0qMm8hJ5so1KueSgBBHDtnGb5JnoH7Qtn3sLoxiEU+ccmEaUZtgBohZxwhx1N
 9u5w3FgN9goEvlPRcc5ELjDnAt+vnD6has/r/DjBuycY7P0Bs/G7H9ukEyr8JfsIWiB9IgcwOU1
 jQG43Tc7h3zuyH894I7ejaKIz8uyr8+Sq0RQhhgdXzRlAQeYURppYKgBYXTo9b3vWjJAwGtfG1I
 I7Zt60BEvtfKU85S/qQrEme7J6uZNF2PvujsxkV1M6bAfp+oH4aS+rekMeUQuqXouibTBLyYPTw
 QB79lF5E4nrDBBHwL3UMgs0XUosmJ1umUrfD1ju7dzq74ATiUfZ6K+d1S+Sc=
X-Received: by 2002:a05:6a00:ad03:b0:845:cdc1:a803 with SMTP id
 d2e1a72fcca58-8562a8d3070mr4382601b3a.11.1787868447361; 
 Thu, 27 Aug 2026 15:07:27 -0700 (PDT)
X-Received: by 2002:a05:6a00:ad03:b0:845:cdc1:a803 with SMTP id
 d2e1a72fcca58-8562a8d3070mr4382513b3a.11.1787868446924; 
 Thu, 27 Aug 2026 15:07:26 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535ced0f99sm2523713b3a.44.2026.08.27.15.07.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:07:26 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Bibo Mao <maobibo@loongson.cn>, Yoshinori Sato <yoshinori.sato@nifty.com>,
 Laurent Vivier <laurent@vivier.eu>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Song Gao <17746591750@163.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v8 028/105] tests/tcg/meson.build: introduce cc_dockerfile and
 cc_docker_host_arch
Date: Thu, 27 Aug 2026 22:05:22 +0000
Message-ID: <20260827220641.84885-29-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827220641.84885-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827220641.84885-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX+Ixn+TPdEgzI
 xmdY5guEFBtESGR3HZx22I9gt8ozsHDw/kn3kJzI1Dcz7T5IZJqZ6+NThf2B1O4mXq2mvmv8REs
 UxNKdmeIBwts/IWuozX0AHQu4z0cC4A=
X-Proofpoint-GUID: PKaHMz2xaLypjXtIPad_KThXrQfIUIBW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX1L8wuPVA0usk
 m0+rxip2JagkifnCU5dmT4QDqD63hfprbZxymHmM6KUTJi5FhV7oUTh6+VIFnH4dp/AEmMWj+K/
 /D5XV8whnlpCTlK7mt7HXY4uX6dpQJDQDKJCxhe36ksvqhKLGlSZrJniwumdVysxifPhO7HPkal
 Ju4vHon3phdUhsFrXYyxsbKRMFTjDRIl01zVYIHWWDn96mioDG484hBWTfuZr45lxj4ffTGbJ4M
 LBKXfwSWZ7vQVbafIsj4pCseIjj7sPQ+17Vs2m1YtShEokGN4OxNNP9vCKN36UGhdDGpl5SQXx4
 o9aFwTMvb7X6O+j4yN29uIF/GffMNyN2DATdjjieIsBnnRDAmwkyCytE8oIPLgALFima91gS/Lm
 z/ZO4qX6RXAX87FlBHYo0jX6/V8Pg7umhHd5qaSxiKTBwduvhfIPM4fnNbhd0E3kwCtH/4/74+H
 AxZG+a21rveqM55mHRg==
X-Authority-Analysis: v=2.4 cv=eIgjSnp1 c=1 sm=1 tr=0 ts=6a90b520 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=VnNF1IyMAAAA:8 a=D8BCvRf4TFo9TPcboT4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: PKaHMz2xaLypjXtIPad_KThXrQfIUIBW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 bulkscore=0 phishscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270188
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


