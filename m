Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D51EC982E6
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 23:16:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8nEG-0008FR-5w; Mon, 21 Sep 2026 19:15:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x8nEB-0008AM-PK
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 19:15:15 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x8nE8-0000En-86
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 19:15:15 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LKe5Xv3423689
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 23:15:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=GTBT5L5MPO+
 dzfTLgH8DupafYr70UiGlJNtN2qQLuPI=; b=VRoxUy0YkTk0q8B9xFei+fAQ3yP
 P71pE0r+WWzOPY3+YzwqNxRqoT6EVnvO+y75qwG/eYUKBGeVtbcYUMIBltM94wmH
 1+RtVWMlud3g8LEGuOCTbKO8+vk2JNX93kMVMh14SUbvfbGJ9FUPqC5Mm1vFdTav
 2WKDIcO+g5+RBrCg0DSf3xETcY1mbesHeK01Eor0m8wCWL754BMMa+50iG81fYhY
 y0NmF/dvQSz7nDT6NDQB46+VdIX96RY7zBSihHBF9aGDXVMKhUc/wf4xW6MmVtOd
 ydfZvGf6zrsh9KZY8wwmUENoCg4UADu3jqOzKQUa7VEa4PsjIMPS5Si/yLg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gu8v517t4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 23:15:10 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-385d2703b64so336368a91.1
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 16:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790032510; x=1790637310; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GTBT5L5MPO+dzfTLgH8DupafYr70UiGlJNtN2qQLuPI=;
 b=TVEH36Vr/G02qMBq+z+wNxn9ZbJhMEjC+dG2kQWjkbh5kCEjbIMAODQ99NG5c9+XyF
 qVnMG081Hsg5gD1N61AAwdJJIzwjedptc8B+sI6h9rr9wYwOWYE5F1G1cAeK+0rhB+nQ
 6VXP4is6kQPM+qPTHnkW4CYVDVcZJN3UhUp1S8xNOmMrqKidiU0L5oyPgKh4u8ccSRR6
 OjjuZGndIvFZDfHxfYleRNqs83Eyr5LHaWw6oixE4P9OJoOjp91IJaPsw2Sqp6TAwVd1
 Jt5sqU5BmBug2L/t5B/3rHRkOX6Vi99CQGu8jDIf86iXwupl3soNmyQtEMvXdVO+j5HE
 K9ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790032510; x=1790637310;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GTBT5L5MPO+dzfTLgH8DupafYr70UiGlJNtN2qQLuPI=;
 b=YvECXjSqQew50Z0F2s4a6rJln4J1oBWGoQUSL4A0ELRqDR1bomXUA6K2P9cylL3HLU
 zNxT4WGjWYkKD2hK01hup3RdEUP1z5DAqYaqY3wxlG8gA8MA0CgYDKQ165gpkBaDsgQg
 y7FedCkLYLlUYCz49Sm8MnQdogEdFasxcgdB2YQJ552NBCV/t2gkPGlmZJUaR8hKtWe1
 l2jghlaVyA14MZif9m4AQIS+eFpn2KAuHVcXjk49qD1qIWOVqUMpBoK2wFck+sA4Pjc4
 BF+N1JIChT1ivDyNvEAk/MfSdFKBPKDgHlXNQlxGO2VkbO64XHwvdvPr/V2u43KHTPil
 mspQ==
X-Gm-Message-State: AFuF++nii2ykKUzJALywFNtgg07TwZtnZoCoeotWDnTTq9dLrsCKldpS
 FVFhWlF5ycI7e05++Ic2AKfMoo6xNdfn+2p46w+Vgy6L/qBK18IaSsSCZRTutJwRaPD1WkFBWXP
 Ke3KIcT5B2xPpszosbKIZvnbkWNR8agcoJUdtf7wZ6qjgiExbyjGWwxntE3ap9QoqNA==
X-Gm-Gg: AYBFou0IV6IE3VYke+qWBSPFTdCowdq9IK0dKdKegU2ByrCpaS6bHSkkvB2LEphwLt9
 mGVPA7f/kQUYuDw6OQSqnSNr3T4NY1WomIzBJOEkSJFYzkmD89gfDPXH1gAbQWM0mN5juyncVVf
 KdszCl+wN9BZrcsnUCZbeOCZUERDq17qslGeof1OsPDHe/9UmMj/Ik15pjCstWkkRjoAgkQHyu8
 yiEgj2Kcz65TVmzcpaSAInP2fadU//6BYCd99T3IDm+TRZu+94UijH7kY+2ogqdVnAPj3Vhprr3
 fImtNhwmUKnTZkdbKqCXDJgntu5UyzWj8qmfMO97DYnTKYgVh90SEmyxPunH09rg3cuRKXm2dGq
 R2xu1CnOfmKBK5LY0cxWLnedZx0vW5CZakAc3peBFCV2cnsHhYuzXdfS/l+R/qg==
X-Received: by 2002:a17:90b:1d83:b0:39e:6a7f:6186 with SMTP id
 98e67ed59e1d1-3a066ae2369mr757164a91.23.1790032509428; 
 Mon, 21 Sep 2026 16:15:09 -0700 (PDT)
X-Received: by 2002:a17:90b:1d83:b0:39e:6a7f:6186 with SMTP id
 98e67ed59e1d1-3a066ae2369mr757127a91.23.1790032508722; 
 Mon, 21 Sep 2026 16:15:08 -0700 (PDT)
Received: from localhost.localdomain (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0674c0b4bsm1295939a91.13.2026.09.21.16.15.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 16:15:08 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 1/7] tests/tcg/meson.build: force use of linux/amd64 platform
 for containers
Date: Mon, 21 Sep 2026 23:14:52 +0000
Message-ID: <20260921231458.3369-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260921231458.3369-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260921231458.3369-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 5OdEjkB9ZQPiUWrEDkY6Tm4PdAqIOGHk
X-Authority-Analysis: v=2.4 cv=B+0sQ+tM c=1 sm=1 tr=0 ts=6ab1ba7e cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=7d-bZuWUf30YydaP674A:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDM0MCBTYWx0ZWRfX5G8Q0kgNaCYE
 29HnGjIbR7FjCGYq/WlX6sLSQYNoKKssukLW1Weu+G0cPVs2wNZT9ZwnQdzVLqHwOLtF+mKPGLx
 EQVhhiNK/uOn2g5FjKwLnGxn/BKR4d0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDM0MCBTYWx0ZWRfXzsJ254l61DnO
 S17ijoZiJ0V7bu8LddE5a19OS2LKnCqUV1YkjFpddj6q1oYyo0vPSeyDGMCFNfLrIdFx4j1XFsC
 fTvPGdVS8FAnDpTd6EgPjXfD5jGBIhrXnaZ6pWD5nj/kQQEIQPuoSupnrDsjoZPu7lTt4cjkvxx
 oNHzrbTGuPpLI3Tdj3dnr94JEqPxZbTnUrdqDJNO34k6NRNI08xmnbvZGVFJqplq9ayOxkwU3pk
 vCB24SSTd8YgBw1VMyO8uHkVBHUT8Uynl9PatWBE4lflrcXBm57fakmfJ+rEHDAdSdUGjNV/hR4
 e29kN/4sWwBD0vAmppUNC6WaOolhbutvsoOP3fRs0wEzl5MvMESglPKjPp+tiT4hvSn1Xubd2Vf
 vToWvJWjRkypytjsZsXTrZdrGYNOumQMzsrWjwDHUMJLQvjEGSp35TtrVJgxMsHMRLujAVjJGXe
 GYc+yDrV4lroOqV9XpA==
X-Proofpoint-ORIG-GUID: 5OdEjkB9ZQPiUWrEDkY6Tm4PdAqIOGHk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210340
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 75f0a52fd22..4cf4865461e 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -81,6 +81,7 @@ tcg_tests_summary += {'gdb': gdb}
 
 docker_supported = false
 container_command = false
+docker_platform = ['--platform', 'linux/amd64']
 if get_option('containers')
   if get_option('container_command') != ''
     # make sure command is working
@@ -99,6 +100,15 @@ if get_option('containers')
                         container_command]
     endif
   endif
+
+  if docker_supported
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
@@ -253,13 +263,11 @@ foreach target, plan: tcg_tests
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
@@ -270,7 +278,7 @@ foreach target, plan: tcg_tests
       image_targets += {cc_dockerfile: t}
     endif
 
-    if not has_cc and has_docker
+    if not has_cc and docker_supported
       build_test_depends += image_targets[cc_dockerfile]
       build_test_depend_files += dockerfile
       mount = meson.project_source_root()
@@ -279,6 +287,7 @@ foreach target, plan: tcg_tests
       cc = [docker_wrapper, 'run', '--run-as-current-user', '--',
             # SELinux blocks modification of host fs by default
             '--security-opt', 'label=disable',
+            docker_platform,
             '-w', here, '-v', here + ':' + here, '-v', mount,
             'qemu/' + cc_dockerfile, plan['cc']]
       has_cc = true
-- 
2.43.0


