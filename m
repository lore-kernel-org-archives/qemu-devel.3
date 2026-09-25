Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EC86C9830E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 17:55:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAA88-0008Eh-Lp; Fri, 25 Sep 2026 13:54:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xAA86-0008DY-2Z
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 13:54:39 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xAA84-0000fc-2f
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 13:54:37 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PG0KC61363029
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 17:54:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 W5S5K96jfdRc58qpywknVIN8q2uaKPiMuI7TC24v428=; b=nHnRk3VUzGxoKTht
 OnX48Tieljw2uIvOIfNjOiEMnfBVLmfBiNIlIzHTbKMck9PIdOYaWeR6MCkFzUue
 086w/kkEhGAHDWQGP0BrMMfIdle7INrWeP97QRILxDbW1JklCiez7I0MSKHz9lPf
 5JyRg57dQrcic+vndWaBZEzEWjswRjMxOTqQXjDETLyW3ayVIM1fugdFIDimewTN
 zW0E5OK6ybavbxYcZ4NCIl4/qNNjRvbyB+D+RJHZIhv7rYn405+izE5SJkI3Ebv+
 TPRSV49t9YWzNhtSQFl8q4/m+xKmDHiTPHSEB1tyJBrXAR7n8Uy7vFHdAQGfE3iJ
 dod7gQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwpvnsmmv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 17:54:25 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-313d1015161so3957343eec.1
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 10:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790358864; x=1790963664; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=W5S5K96jfdRc58qpywknVIN8q2uaKPiMuI7TC24v428=;
 b=dYLhht5t+VxzRl8//DERmMHlgIp5uved1/SqRWfnru8lgvRHAhbBkZOC8lV1Bz2XZe
 npkjtSjAll6sa8VXMq+K4zbGBXDSlbI0aCMQLmr/qIXgvMW1J3/sRHzmSsIT2I0afvC0
 HaNMq63I+pY6X4Iwgx3Wbqhn96Mgl7+tup5YDlkT1Ny1lTLbNqayyJhFEXr4zVfQSgik
 gN1UkFL33Kt2I7+DMZNDrYxnGMt9vK/GjczCxqp/JTQDcZelRl1PXakn2bncCdKaHW1x
 Xtu6X/2BPhowPer/1xW6fg2OMG3CBtr1KFX4GrgXwt/WPrgXBp5PxWHoGXeL3bteOq7W
 nj7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790358864; x=1790963664;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=W5S5K96jfdRc58qpywknVIN8q2uaKPiMuI7TC24v428=;
 b=lJ6YnjnHg1aNwmab10Whc6co/i+W1/hhRbbHsVvRlD/en9V0N9Tp8Mg7vW0navhnXM
 lMum4LtbfK+z+liEq2GPgBOO2XJr1eanFdJDsFQMfWxgEms4fj2WUpRUVnmr9rJpEPTP
 v4A4jhmvK26xGIe2oGpN/HW3CQIcBU7g+t6gFvjD3wJUEC2vR6k0RpH0PNr2RRJI0lwh
 gFjT1VAK24Mq6N6Jdzz0wHDEGFScGNWQR7cB1spUzATKs13UPHfO/RqcGU3/Rs8dT7D6
 rx+SA7BFoZdWUrBDmHrNh5316pzkEnAV/0bf/BfbOM49qBSW6L81kChIL0M16kI94kPL
 6o3g==
X-Gm-Message-State: AFuF++lS67b4S6FDBrsXsnHPmG6tv9BV3W4SX5dH8pisv5/Hy87uW78K
 KsPEYiIlXBiSaVCPJ5+hYbfKq4paiUrN6SznBxOeUcdQkhFG1lQh2KIpawX6mVfUTEGsHGu7BQ6
 C5hp7LIoihlR7h7XbAiCirvGDmxUOxBjQQpNDKDcIyKOqoFZ/jdDypYCOAWMwkJBELw==
X-Gm-Gg: AYBFou0hu1dB83sZ1TJKh7UxZQr9jzGNuSNs71sa3Lstmk4Aa06ye0pAX1kj45uFnNm
 tlpqxeM/7QaJ9CsK8DIxJx/G5d82nKXsn4P+2792SPTuv41xb+dQTFTmI2Ob7v2L70uAW0q6CY7
 4/tNsOempsmchpBeNVuYWF6i1reffq7b0INu7gjBluK54Yw1QMty0cOpcmTBLoFU4BJhJC8RDvu
 yE9w8EDumcUDFlTolUigxLDE7fKvuEQgeK9VI+7VRuL5AZGodp2RseYqBASGyHvc1Kcuz7gpX5A
 xE2Z6SGV3yNMMEKQGTeXl/6xLJEeHigsq1erBaWf+QXRV91c+oxovo+th1KPXeKuaCJ8KmQr85l
 wKosTahGleEOAw3PMz47R2IHAcnycDlrR+GsFoDiQZc/Uo2uzOnlRyaC4sg==
X-Received: by 2002:a05:7301:7196:b0:341:d152:9cfe with SMTP id
 5a478bee46e88-34272c5c768mr732202eec.38.1790358863885; 
 Fri, 25 Sep 2026 10:54:23 -0700 (PDT)
X-Received: by 2002:a05:7301:7196:b0:341:d152:9cfe with SMTP id
 5a478bee46e88-34272c5c768mr732172eec.38.1790358863226; 
 Fri, 25 Sep 2026 10:54:23 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34144172de6sm11055128eec.9.2026.09.25.10.54.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 10:54:22 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 13/13] tests/tcg: add alternative cross-compilers for macos
 (homebrew)
Date: Fri, 25 Sep 2026 10:54:00 -0700
Message-ID: <20260925175400.1897574-14-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260925175400.1897574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260925175400.1897574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: AwoWex_Ae0H5-Dqv3JeG6MjHxhdp7iSq
X-Proofpoint-GUID: AwoWex_Ae0H5-Dqv3JeG6MjHxhdp7iSq
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA3MSBTYWx0ZWRfXxjDC/+pKdRj5
 urcQy2i2YjsWgXv7Omuf3ziKaPkmLO4HkL+kN3MPQXHcVmwkaqNaFyQN/kuRl/ncUb5VWwIaQzK
 S9cBnaCVRCKnb/bE8bFtojR24uyK/RU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA3MSBTYWx0ZWRfX0thqABBS+ZnI
 1KBVyDYJ54IFPfze6s11by/8EYF821Q2ZKmh8kdWImQhlQcRWtDuXoh212JdxXfpT/mUbR2O1io
 A3tzKRvO5ATyodRS3wcUPfwrmTMXqwU3BUzIJ4bYW2sN9UtbGk1cbk/kZoRYC1jjo6V4ERQmEvo
 vIpEBoOqdqsLBdk2cLVqo6ZCqm8/VgvzY6uWeLyugyKlRaZtVtM7rqBB9aKkYGH8cJ3tJ1BcCuy
 dGeW55iMM5kwcojSxnod1EpljNY2yc4hCIqxAaJDZqNIGOAbg0DKzBKwn+nJaPWDWjCSXnvsPDU
 GzAEBgXxSGtMfOVvqVENFmzzfvIVEG6/RzHhPtoHkMAK9CrsgPKiHob2tSEnqOGb442DK4uTfTh
 L1n+3Bc5AJQZYCy1unCUAkzgkwggumIMbOqRW9hwGZI5otXQ1ckTHMUD2ddy8nlR+u9N5+3cMbC
 j1I9HoU3Cy31lB30Emg==
X-Authority-Analysis: v=2.4 cv=eNmGH3p1 c=1 sm=1 tr=0 ts=6ab6b551 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8
 a=xDO-KKndLwJen7abHAMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609250071
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

Add support for cross compilers that can be installed with
homebrew: https://github.com/orgs/Homebrew/packages?tab=packages&q=-gcc
- i686-elf-gcc
- x86_64-elf-gcc
- aarch64-elf-gcc
- m68k-elf-gcc (ignored since we don't have system tests for m68k)
- riscv64-elf-gcc
- arm-none-eabi-gcc

Those toolchain target bare metal, so can be used for softmmu targets
only (macos has no user target anyway).

With this, we can also cleanup our CI for MacOS since it does not
require any --cross-prefix anymore.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260924213942.26491-5-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 .gitlab-ci.d/macos.yml               | 7 -------
 tests/tcg/aarch64/system/meson.build | 2 +-
 tests/tcg/arm/system/meson.build     | 1 +
 tests/tcg/i386/system/meson.build    | 1 +
 tests/tcg/riscv64/system/meson.build | 2 +-
 tests/tcg/x86_64/system/meson.build  | 2 +-
 6 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/.gitlab-ci.d/macos.yml b/.gitlab-ci.d/macos.yml
index 40b9b637b3b..c798384392c 100644
--- a/.gitlab-ci.d/macos.yml
+++ b/.gitlab-ci.d/macos.yml
@@ -41,10 +41,6 @@ aarch64-macos-15-build:
     PKG_CONFIG_PATH: /opt/homebrew/curl/lib/pkgconfig:/opt/homebrew/ncurses/lib/pkgconfig:/opt/homebrew/readline/lib/pkgconfig
     CONFIGURE_ARGS:
         --target-list=aarch64-softmmu,arm-softmmu,i386-softmmu,x86_64-softmmu
-        --cross-prefix-aarch64=aarch64-elf-
-        --cross-prefix-arm=arm-none-eabi-
-        --cross-prefix-i386=i686-elf-
-        --cross-prefix-x86_64=x86_64-elf-
         --disable-plugins
     TEST_TARGETS: check-unit check-tcg
 
@@ -59,8 +55,5 @@ aarch64-macos-26-build:
     PKG_CONFIG_PATH: /opt/homebrew/curl/lib/pkgconfig:/opt/homebrew/ncurses/lib/pkgconfig:/opt/homebrew/readline/lib/pkgconfig
     CONFIGURE_ARGS:
         --target-list=aarch64-softmmu,i386-softmmu,x86_64-softmmu
-        --cross-prefix-aarch64=aarch64-elf-
-        --cross-prefix-i386=i686-elf-
-        --cross-prefix-x86_64=x86_64-elf-
         --disable-plugins
     TEST_TARGETS: check-unit check-tcg
diff --git a/tests/tcg/aarch64/system/meson.build b/tests/tcg/aarch64/system/meson.build
index fb3b33861ea..f9c4448abaf 100644
--- a/tests/tcg/aarch64/system/meson.build
+++ b/tests/tcg/aarch64/system/meson.build
@@ -96,7 +96,7 @@ if 'qemu-system-aarch64' in emulators
   tcg_tests += {
     'aarch64-softmmu': {
       'cc': cc,
-      'cc_alt': cc_alt,
+      'cc_alt': cc_alt + ['aarch64-elf-gcc'],
       'cc_dockerfile': cc_dockerfile,
       'cc_feat_cflags': cc_feat_cflags,
       'folder': 'aarch64/system',
diff --git a/tests/tcg/arm/system/meson.build b/tests/tcg/arm/system/meson.build
index 93d0cfec24e..89734f95605 100644
--- a/tests/tcg/arm/system/meson.build
+++ b/tests/tcg/arm/system/meson.build
@@ -64,6 +64,7 @@ if 'qemu-system-arm' in emulators
   tcg_tests += {
     'arm-softmmu': {
       'cc': cc,
+      'cc_alt': ['arm-none-eabi-gcc'],
       'cc_dockerfile': cc_dockerfile,
       'folder': 'arm/system',
       'gdb_arch': 'arm',
diff --git a/tests/tcg/i386/system/meson.build b/tests/tcg/i386/system/meson.build
index c3a19f43260..91c6e887191 100644
--- a/tests/tcg/i386/system/meson.build
+++ b/tests/tcg/i386/system/meson.build
@@ -42,6 +42,7 @@ if 'qemu-system-i386' in emulators
   tcg_tests += {
     'i386-softmmu': {
       'cc': cc,
+      'cc_alt': ['i686-elf-gcc'],
       'cc_dockerfile': cc_dockerfile,
       'folder': 'i386/system',
       'gdb_arch': 'i386',
diff --git a/tests/tcg/riscv64/system/meson.build b/tests/tcg/riscv64/system/meson.build
index c87e3eee1ad..c2d7d098871 100644
--- a/tests/tcg/riscv64/system/meson.build
+++ b/tests/tcg/riscv64/system/meson.build
@@ -65,7 +65,7 @@ if 'qemu-system-riscv64' in emulators
   tcg_tests += {
     'riscv64-softmmu': {
       'cc': cc,
-      'cc_alt': cc_alt,
+      'cc_alt': cc_alt + ['riscv64-elf-gcc'],
       'cc_dockerfile': cc_dockerfile,
       'folder': 'riscv64',
       'gdb_arch': 'riscv64',
diff --git a/tests/tcg/x86_64/system/meson.build b/tests/tcg/x86_64/system/meson.build
index 08b770d43ae..7d61257b771 100644
--- a/tests/tcg/x86_64/system/meson.build
+++ b/tests/tcg/x86_64/system/meson.build
@@ -52,7 +52,7 @@ if 'qemu-system-x86_64' in emulators
   tcg_tests += {
     'x86_64-softmmu': {
       'cc': cc,
-      'cc_alt': cc_alt,
+      'cc_alt': cc_alt + ['x86_64-elf-gcc'],
       'cc_dockerfile': cc_dockerfile,
       'folder': 'x86_64/system',
       'gdb_arch': 'x86_64',
-- 
2.47.3


