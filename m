Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E041C9830B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 18:58:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9SA3-000161-SS; Wed, 23 Sep 2026 14:57:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x9S9y-00014Q-Qd
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 14:57:38 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x9S9w-0003XX-Q3
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 14:57:38 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68NGThQc2470173
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 18:57:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 x2q56D51wq0VRaAG+JzB/lsAtmfRVBvCaUzxWZieWOI=; b=M8qJle/UlMNIBt4Q
 AKmYO0fhRUI9jVOwtfgaTSPxOKmZtAHIzfB03pdr7ji1Vgwt3QZtD3ZJhqjqZ8Mg
 PzE+TcscuiyhH08iiTt1s0OGIamivosVmN2qnCuXxbcYQhJv5uzuQ6GmThpqx80y
 2GjFQXEgqCPBU+4N4CcErBg4Cvk/ICxo0qHYLW7yc10856cRH+/fz2lEav5XPKQ3
 CRks8mEEf6inTE7wB9HzR4qx7e9InMzavJGeemCJAG5A/yVLUm3qCAO399rZn0Hd
 sRhqaj8y/itk9xifXzhXfVWu+9ilvIdXlhFfsmaDTBje6sagT+0y+XBJ4KPgjUcl
 C91/NQ==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvfjv1gx2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 18:57:33 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1384427c3efso2098119c88.0
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 11:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790189853; x=1790794653; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=x2q56D51wq0VRaAG+JzB/lsAtmfRVBvCaUzxWZieWOI=;
 b=E4eM0ZhUwPEtyTUSHHNtH1bgAoGwY+SrVHYDR5zueFp9PDlLDIhRlUAgT0i8G8e6Jw
 cVm4WPx5vdX8YFgYmoisCn5X1s9wiLgc0omlnkM2dYALm8MeHgeu8DKKUP8n5Rl0FcGR
 k7R1lxUqpHns93HEepqLC+r88+LiXTjYcFj+lZmcBxjclWsbgb1rKSZoUR89O9UVkrbq
 CuNYe59DO/UKvmK1SpWYqdYp1EAmkEwF6ndCyr5/XFEMunxLWdKD//C4/yM/SBCKQ0dz
 ySrl/uxXNkUB09jVTdCY/RNae0YF4G+hGMg8IFNNUzPC0HJoP5+6r5xcUsZoh1FaTAPU
 bEhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790189853; x=1790794653;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=x2q56D51wq0VRaAG+JzB/lsAtmfRVBvCaUzxWZieWOI=;
 b=BFjRneZGkp0eVWrvC0f6ZEK7+hgSSWWUvd3qS+kwe3a6iTDAd77qILBXd25vCDmhhD
 BAYc6fY2U+gl43L008ZHv1BsQi97rhNfCWd+butTVmKhRq69cXsmt1QXvl1YQUY8km++
 4dXNaHDJKrxLZezH3EC5W4Y3DKolpH2YiI433w0FcFDTMY1QwrAFIG9BHzXfbobxDBiv
 +2wP7o99oN7uF7ZcBJnT+4AftwjlPYFkdJ11EPTB1w+PF+ftD1E8ZHhutrc+Fq//rj4N
 5+Xl3dIkP5MQZbnZMt2Kpu6Qx1vxVJhXnugHh5/Z285IFMNu5dE47D+ouYtUQhRKH1hx
 4x5Q==
X-Gm-Message-State: AFuF++mtHjuWR/FK44eWjIMH5MJZFTt2B78QkE7dQW/3MG6xPLATaeuu
 vhm1pdVsB5hliWJSL3KJfZD0lEHH824xrF/V6Q1dmAzvWYmVl+0FTKSUeJ6AHONLZy7i6gJMoLO
 wcRk4biiABkK/mJJ7rEkgDA4n7pykVEH/ZUqzvqbx5qbmu7I1ZhLWfJT8hlWMErfzBQ==
X-Gm-Gg: AYBFou3a8sEIGsk/J/6UH4YqaNvCX3aV7PxB10D19arNZ6EPBaehJWEzqgSo+kQAb8r
 DoNqAHELAzvcmkL+LtgTf++NipmZKi6C3gnoE2f04IDUdTrhOZh7vCMKdYAbsf7LbtveaSdG8Nl
 jXVfrVRFYPZ0Zrht84m1wH15uuq842isEB2Cv5g5IsXD3I4H/Wb/Lwo4SnY1mgjs2KH5DQvW9Qv
 PEQKrCRZHNVSEVcErwNrdww5i0P0SKJG7LnMrUHRuB6SJj3ECvPiMUmBiEFuC9Mwvx4a6a40wcE
 SOiaXb1EKEsanCZtcbjKVtAZBAYbg9M9AMw3ggM8UO9kcun8Cxd2Jb4/fWPhWIo92yJ6ZgQ3yP8
 3oB03Z2rS1VRAFYz/JoWGXRrDSuwdVUt7YdeJSvXzJhpljWr8eJU3gCRZeQ==
X-Received: by 2002:a05:7022:e998:b0:143:6ef8:862 with SMTP id
 a92af1059eb24-14503f23f56mr90611c88.11.1790189853024; 
 Wed, 23 Sep 2026 11:57:33 -0700 (PDT)
X-Received: by 2002:a05:7022:e998:b0:143:6ef8:862 with SMTP id
 a92af1059eb24-14503f23f56mr90593c88.11.1790189852292; 
 Wed, 23 Sep 2026 11:57:32 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-144f9820ca5sm8154931c88.3.2026.09.23.11.57.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 11:57:31 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, philmd@oss.qualcomm.com, 
 berrange@redhat.com, alex.bennee@linaro.org,
 pierrick.bouvier@oss.qualcomm.com
Subject: [PATCH v2 1/6] tests/tcg/meson.build: force use of linux/amd64
 platform for containers
Date: Wed, 23 Sep 2026 11:57:20 -0700
Message-ID: <20260923185725.863311-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260923185725.863311-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260923185725.863311-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA3NSBTYWx0ZWRfXzEuBJ00TWO6v
 RK28U23WWES8P6FIauoNJsA7vvNt3PzQTWP2hwcNYlIKFsMyE4p+XqHh2ZNs8pyxu2eFECSpG+p
 tpXVpn+EZ/K5Kbt5MKZHSUOK7ojAgtS6G9RuDDAgiQXpMZplI6QwcTf8FrXgZIUJpHcTRNGSkGw
 AhDujPAqUEuHR7t65Q864LiqDtclTZeVPS1pciD4EIdu3c+RGhfv491ru/PpnuCGNovhYUBUdrt
 vk9yMrZ25SiboLfSOP0fTOoCvN2NwjzWpurzJoADsTFPt5gPiRPIEWHh3AJhMv5zleqZ3mcvThw
 PNOBXYVr+0N/g3Lx4j4U9TGzrTO+uEAi6jHM+Ek07qD7SaY9pJZnW3QBIh/Tz7v/Se4660Tvmpz
 PiBEIOGXkX4GT7ANJFBqVIfEWEhUWI0vdQI1wMyYFItna0npX++68Vm/tbJx5iiLhu0QCMMJNeb
 2mQs6lYX725/ZmnDeTA==
X-Authority-Analysis: v=2.4 cv=aIxlOr9m c=1 sm=1 tr=0 ts=6ab4211e cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=7d-bZuWUf30YydaP674A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-GUID: DZHCqdH9qxDHMmzD1yr67DUzDpKZGj54
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA3NSBTYWx0ZWRfX72bjc0bpTmIz
 vNPH0IV0gc3i7UCFkCCxaSlNJTp9VVbaaWntbj6IpyLWm6rjIWgK2v2WzK3TD3p4gu4iXskVAgR
 JOl+/SuCRdHVfDO1KNtj5450JOAG+pU=
X-Proofpoint-ORIG-GUID: DZHCqdH9qxDHMmzD1yr67DUzDpKZGj54
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 spamscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230075
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 75f0a52fd22..b0a857dc14b 100644
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


