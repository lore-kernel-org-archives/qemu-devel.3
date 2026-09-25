Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0D7DC98321
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 17:56:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAA7t-00089g-4r; Fri, 25 Sep 2026 13:54:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xAA7p-00086e-Aj
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 13:54:22 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xAA7m-0000dc-9U
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 13:54:21 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PG5L4U1759227
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 17:54:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ohEbYbvIHAyUhNO/Wn1+ptkHAfi9vmkdvfLyTUoixF4=; b=Tuns+w/L1u+zhH0y
 OuhmvyQxeWvNO1s1zJNLZ7/WPcU1D8GKFMRn+wlGZoxOYXrsNpfirPJbICKFULHe
 3SRnWrnjRBXm0QRIP+MLM2cE+bik8KWRXg68n515Y44wte+uaGWPmyLCQyLhVYfi
 Rnlvqw4H6LG+uxP6ycj+1lWS8lPqGaszI1bVJXcJlXmtWAg0xhU6UrMtYZPKYJ7m
 /E92X2CHr99kgJqeExAILC+256JhNrpW7eNasMotwql9V2MW9wP8P7PG16NALdkj
 LnTcTZSnfA1sqQ7/EGLGTPYofc7g5eu8Dah3xVOb2Cdv0cPjaRhk1zAEMpjVLUnA
 KbBguA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwv5yrctj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 17:54:13 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-342b66c0b06so101341eec.0
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 10:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790358852; x=1790963652; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ohEbYbvIHAyUhNO/Wn1+ptkHAfi9vmkdvfLyTUoixF4=;
 b=ToKnYJHiR0pbGTiATmh99xMTbMgF3UtecGAeB2/tS+BJQLE8pBxoCcGNe7jLiDAfTm
 Nzqa6vGfmiNmtrB7YsfIrwC0o2ZuUZJPE26Ssr1szd2N6Abh9RIR7Pr3K18u+DHu51Aw
 R2wTvwosgSLnZiUXdTV5i/hcsaqyIupuHm962t/PbcitK9P2XBRq1lMDH441rwggBzXP
 ajMTzjxlQjlWoPxjGYlk5gHog38LixzAKrnhLvHy7S4H8ALAmocaD2DB/P1pl0od2uMH
 FQjcqucFxTJkVvbROYWfWPGBVyQq+PBkFbhsEDH5+x1cU4TyxPlaeoeAmBW0RB1ECrxU
 K6Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790358852; x=1790963652;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ohEbYbvIHAyUhNO/Wn1+ptkHAfi9vmkdvfLyTUoixF4=;
 b=nd9FNiD6Hu4dYhx/M5wQ5RPfBS1JhuRj70o0S71O3MN/AgcfiilwMB0ULYqsw5aA1h
 Hoij3QdT0W/wfnpWPuxp3ChqmOmIVYHtwczIfE2OcZaW0Hh2q35fvM8+6y8I3d3slkOj
 kowV/eiC2vPjJqQWKMjn9j24gz/7Rx/ZdHHvXLGnS4nBp44jXhjlUJnuZ99cWIb6Khk6
 AefVNQVpGyEsoAIOZKXtp6sZWJ69XQk1JDg0S/ogdanJscAx85fDP2rUOiVBQ1YB6bNr
 Jv/0gsoPeCJ56HKhIWnQD9jLEv3J1ksWo1Y1ukTYIA7uPMOEgS5RU/IyrzyQcK3NXdLf
 hcpA==
X-Gm-Message-State: AFuF++mvb8Rtbu69ZJTOljC7auUJgL3IqaAleZ7UEr1sCLPBGuLGngVN
 uGL3tdZ/F2rVcB0PfIiHE/95U/1j+FLJG9CnH7mPibI7WLqqGWtjzD6Kgdr4Iuf8UPd7gbCzROz
 sM5I9Yu1su/iuXiMhow8B6WllyUbTMF0bmI6ifkJtXHPm9swRhzaUtN8Drmc6Mz0oOA==
X-Gm-Gg: AYBFou1fHotDJLmXgfr3UNQROdqw/mFIT/5Qs1dTVYmTGnRdJ9XcQo7uD4WLcU4/cDp
 aULMP/lbMYmRPVHuVUtflUx4h+g424maKN4wFIaSkKi7litq5pXsAk1GtrVOMLTT8Chv+aNb5zX
 sXanAMlfIZM5TCDg+bpfSftof3y/WGj7XVFZ/1p5YWZD2kJyApTCvViQB4eKo0Dz/ayM4uXWrqz
 XPqceRUCOhej1SK8UlebOlXJU05InRzy/GYX8IOYPg6rF87gFfbG9z2tSYBpO2pEhjNMkRNikBt
 5xwXEUr7jLi4A7OF8ylSkat7eysQUkrOVR5OO6O/BDV6Sb5Q8cpXLhU/a5vbraNkr20781HhZqZ
 sAWM+huKrYM0fWL3B23TfFWhJhD92FsUvsldcPfTjOAG1/0qkFRBwaw7vDg==
X-Received: by 2002:a05:693c:42db:b0:342:6575:c9ca with SMTP id
 5a478bee46e88-342721805e2mr687915eec.15.1790358851876; 
 Fri, 25 Sep 2026 10:54:11 -0700 (PDT)
X-Received: by 2002:a05:693c:42db:b0:342:6575:c9ca with SMTP id
 5a478bee46e88-342721805e2mr687891eec.15.1790358851214; 
 Fri, 25 Sep 2026 10:54:11 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34144172de6sm11055128eec.9.2026.09.25.10.54.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 10:54:10 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 04/13] tests/tcg/meson.build: force use of linux/amd64 platform
 for containers
Date: Fri, 25 Sep 2026 10:53:51 -0700
Message-ID: <20260925175400.1897574-5-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260925175400.1897574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260925175400.1897574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA3MSBTYWx0ZWRfX/9WjQJWBLRCr
 SjSwdE7Ggffj4gId5tfarVxQ7bNQc1D70wFRKE4rxnhvBU/J5RyckanBZUDZkANMn9d6+EqdevV
 0WN+U5nfjtQeXhUe9GJjOapGB2tRLgDMaoqscrHFuVFRGghw1ODAXLvCncuYdlSaSMrN847Hi9U
 a2JB9HVeal4q7a515mIn9BZ4ERu7oXikGtwF/SMqbQCyumCPjUp08kHbOoZ+RleT2ACrCx6jNr2
 j8KNipRVSEOv6PvBBvZXOMG8ugqS+LPuQN1eWA5dk4tPv3eGlL6YBM2Y5ObCvlCMMd7lYIvLbIX
 yoLcgtVZqUc+8prNyiyQANIg0XqVcXAKJkRkioxVsNXqJwmuiRXa8Wf+p1+SFoSwtadnFN5/TAM
 7uEN6UhsW3CH2ku9NC/EvLWpOCF8FVTHKO7u5fNDmGIj7uRFujBKGoZEI9DYA6tY47cBmCgHKQ7
 5ZRZ5U4+iBf1jjLhclQ==
X-Proofpoint-ORIG-GUID: SnCFRtQYImZxwOPF7oar_bsI5oV_oaQ1
X-Authority-Analysis: v=2.4 cv=EoRHPicA c=1 sm=1 tr=0 ts=6ab6b545 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=7d-bZuWUf30YydaP674A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA3MSBTYWx0ZWRfX6MNUr9xZwxIw
 W6FVRuRg8DBEnjtY32EYHjxPPgMPGBDs1lNWxxOCmfmZ8Hp0AtDIEJ53+j2iQuQPE28EvPzUAdn
 lwprkhNVkLQRVpKmbSdZK4x2k2yTb6A=
X-Proofpoint-GUID: SnCFRtQYImZxwOPF7oar_bsI5oV_oaQ1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 impostorscore=0
 adultscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250071
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

On hosts != x64_64, we detect if host can run amd64 containers (usually
through qemu-user-binfmt). If not, we deactivate container support.

We could technically stop here and force container engine to use this
platform. Since existing base image (docker.io/library/debian:13-slim)
is multi platforms, container engine will enable this variant by
default.

Now the problem is that if user reuses this image for their own
Dockerfiles, they will run into unpleasant surprise that now, their
container engine is using x86_64 variant by default, on any host.

So, in next commit, we'll change base image we use to x86_64 variant,
which has a single platform: linux/amd64. This ensures we don't generate
any unwanted side effect when building our images.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260923185725.863311-2-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 7a3f06ddcfd..3a6339c2a12 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -81,6 +81,7 @@ tcg_tests_summary += {'gdb': gdb}
 
 docker_supported = false
 container_command = false
+docker_platform = ['--platform', 'linux/amd64']
 if get_option('containers')
   if get_option('container_command') != ''
     # make sure command is working
@@ -99,6 +100,18 @@ if get_option('containers')
                         container_command]
     endif
   endif
+
+  if docker_supported
+    # Check that x86_64 containers can be executed. It implies xthat 86_64
+    # binaries can be executed. On host with a different architecture,
+    # this is usually achieved with qemu-user-binfmt.
+    docker_supported = run_command([docker_wrapper, 'run', '--',
+                                    docker_platform,
+                                    'docker.io/amd64/debian:13-slim',
+                                    '/bin/true'],
+                                    check: false).returncode() == 0
+    tcg_tests_summary += {'x86_64 container support': docker_supported}
+  endif
 endif
 tcg_tests_summary += {'container command': container_command}
 if get_option('container_registry') != ''
@@ -253,13 +266,11 @@ foreach target, plan: tcg_tests
               target + ' (possible: [' + ', '.join(allowed) + '])')
       endif
     endforeach
-    docker_host_arch_supported = host_machine.cpu_family() in cc_docker_host_arch
     dockerfile = files('..'/'docker'/'dockerfiles'/cc_dockerfile + '.docker')
     image_name = 'image-' + cc_dockerfile
-    has_docker = docker_host_arch_supported and docker_supported
-    if cc_dockerfile not in image_targets and has_docker
+    if cc_dockerfile not in image_targets and docker_supported
       cmd = [docker_wrapper, 'build', '-f', dockerfile, '-t', 'qemu/' + cc_dockerfile,
-             '--add-current-user']
+             docker_platform, '--add-current-user']
       if get_option('container_registry') != ''
         cmd += ['--registry', get_option('container_registry')]
       endif
@@ -270,7 +281,7 @@ foreach target, plan: tcg_tests
       image_targets += {cc_dockerfile: t}
     endif
 
-    if not has_cc and has_docker
+    if not has_cc and docker_supported
       build_test_depends += image_targets[cc_dockerfile]
       build_test_depend_files += dockerfile
       mount = meson.project_source_root()
@@ -279,6 +290,7 @@ foreach target, plan: tcg_tests
       cc = [docker_wrapper, 'run', '--run-as-current-user', '--',
             # SELinux blocks modification of host fs by default
             '--security-opt', 'label=disable',
+            docker_platform,
             '-w', here, '-v', here + ':' + here, '-v', mount,
             'qemu/' + cc_dockerfile, plan['cc']]
       has_cc = true
-- 
2.47.3


