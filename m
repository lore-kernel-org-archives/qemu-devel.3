Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4F5FC9830B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 18:58:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9SA6-00016I-U2; Wed, 23 Sep 2026 14:57:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x9SA1-00015U-Lt
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 14:57:41 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x9S9y-0003Xm-LV
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 14:57:41 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68NGTdqf595974
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 18:57:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=SS+r69TGZsD
 DswdzWnlkPyRxHqEbEK5LNnl8IaquWuo=; b=hypYrr/emYAnp+ip9ZfUuaOLfte
 2MNjr01PJb5Aar28IsXIewSTe7jG1dR68Y1NxGJBDhotfA6cEFBI9KJySHEnZhUJ
 4FpxuMnCN6J2ADziTamgJ8kWPj2PRWnnGnWUyIaXCbyNKaeF7h2q0c+PuFhSSUqh
 kzCsTvRxt3dUMqIyeMyujkZ9aOXGcz9Gh6zOBatSoMlG/RTWs7Py4ZnsmOmMpEIO
 yMZGSb3xkdMbSuQ4vYMz24w6rJrHf1LZoVlw36CxUEeL6EQ9SXAOUi3DnLW20lnv
 oSd+VmqE/1JpIzJEsJLiVRGkkc8jH06b/nTuNQZtQ0dcXrhUj+abMwgQFzw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvfjxshhy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 18:57:37 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-333543ac378so1491821eec.1
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 11:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790189857; x=1790794657; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SS+r69TGZsDDswdzWnlkPyRxHqEbEK5LNnl8IaquWuo=;
 b=WEx+JWdq3p4kCbq3swa8JSfqKOITBONmbC2YVnoRITqcorYlL3+A+PAmIbPtxO/pgG
 1Qb5mDgtERikfsrQkYSMrKPEBk8TXtO2glUt1UQMg9dwu7y0IUwi0PuqhX6u5xw7ykWd
 ymW0mVOMYL+Jo5J7XqtvBTNnE942OZfqnWhnWoZt04du4a48otmxaRqJGNDDFvhkyAVR
 TfQc/RbCbRWF70fF+QSZiJyAGOSoVynwAaGC3KtBO4pLaMfizo+tfDcudBniX9JCwsoR
 K4O/3ee2mMtgh/145PyN0X1rkNhumx7q9S5q3ya5Fnh4Cx8OoCZj/2ZrM5IS6Yv0Uhga
 LCFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790189857; x=1790794657;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SS+r69TGZsDDswdzWnlkPyRxHqEbEK5LNnl8IaquWuo=;
 b=z0H3f/X7pzg2RzFhMUt102XluFQn+GStabTjSbOIP5RwHe1j/2KhAcMAX4ArV8nUUA
 y4EqG/QzwDjRa9QhzjrE+9U0b9meohAHAfhqI5TeKmRrYQk4QhkMfEh4ZncupvQW81dP
 SxUvr7aTypyt5/VuM/KNBuDG7hLiwnPkmLCeBLMxVXv4EFB2hCFSeChTk3X8pLmXxFGk
 xqwRCuT4b5vjqWFpHKzED7h1YTRiabFwQwr4Mz8tTDaG5ZO+epuhBRUNgv55jWJ/62o/
 xxnZc0CfoHIsNIQnsHCIXaZLU8KTO6wh0AF5pzL0ZOWlrn6FF8cDfQbY2CJKV2Q1Iskn
 iYwA==
X-Gm-Message-State: AFuF++mKZ15AneDFAxLE9j4L6xI2rjfGAgY8CrXzOiGZRPnNhKiNetbb
 H9LohaYFctxQOqHAGEdh9VPUTtuxe4CrxY/1TqKI7KaQEGlwmiiQDvsI62MFTsSlA9SoibYcwJN
 jJ2kN5NNViETpHgL+tPLDGeFjVwBWvPK1RvQjeBK6r6pG+2RdRI0N+Nj39fP0WdwgRQ==
X-Gm-Gg: AYBFou3kidIyZV02rhp/dm/fs7m3YUlnmL7XnFz92mP62QpZ9/VsqPw6IjK98UCDQP5
 vNJ7zco9jNdJXCfEITtQQNIZGbe41aRWCknYFu51qZBihQOvG23bcymhGDy6oJa2N+zHcOewCfF
 d7d39rmhFKKXYcfYXn4uhja20E9wwk90ZBEcYismmEgWfeEEWliapzBnWi0YJfWJxnbSqs3J+k3
 yddCNXHh6RVNAdF5Almc4EVWIOUDfTfE7eZsonkRWtxKOSoFep2R4qTlJQlucfQTg5jXmubVYWm
 ToJlKZ7ivubtBYKgC7H5DzvTWoVVjU/8oFstl9koEe7bOdhsmvPoZmpe3N8P2DKZEavUAs22EoM
 MPf9tZlXWycWG6d6vLPaR6VvwHbOWIJx9yDW41qXPIm7+LZ9qnbD0UUws7A==
X-Received: by 2002:a05:7022:1009:b0:143:5722:55be with SMTP id
 a92af1059eb24-14504033d55mr38186c88.30.1790189856391; 
 Wed, 23 Sep 2026 11:57:36 -0700 (PDT)
X-Received: by 2002:a05:7022:1009:b0:143:5722:55be with SMTP id
 a92af1059eb24-14504033d55mr38163c88.30.1790189855675; 
 Wed, 23 Sep 2026 11:57:35 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-144f9820ca5sm8154931c88.3.2026.09.23.11.57.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 11:57:35 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, philmd@oss.qualcomm.com, 
 berrange@redhat.com, alex.bennee@linaro.org,
 pierrick.bouvier@oss.qualcomm.com
Subject: [PATCH v2 4/6] tests/tcg/meson.build: remove cc_docker_host_arch
Date: Wed, 23 Sep 2026 11:57:23 -0700
Message-ID: <20260923185725.863311-5-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260923185725.863311-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260923185725.863311-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: kDTctUSAGCjpPqTVh7gSDaBypch810sH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA3NSBTYWx0ZWRfX4ktrDXf5Cdbo
 8NpeLkHdAhzuDk6jsaewhkLSSvjxMiNk07T5D85Q0jZQpvxKNHOoIXhqtofPfAyk7xXeH1EJ4ZV
 TCW4KuHXSFxbI6SlfgwW9Ci7jtPnQKjCwXZkQ7fpRYnDx40wGtn4P/uAN/fuZyQDR4a4F6yR/31
 EQJA8rP5G4hY9zX9aVZtvL6HYoSnIls7FYVBF61sf9NywUjJb1/8XhFWAwlz9XDghr9+USwSdJX
 eEGFYNKJE/6Tp9yFTZj3PaF64/Uk763Ccp19rz5evsAomVkYanQNymy2qPWmDeON8rowc5ZLySX
 tJqPCDwnM+wZLS0CtTqqCQTtjPCpTRwoFkTdhkamuDp+oQ2UZwLpupV6y3V1as5OEkHknKIY1DC
 3id4KOrCvjCsPm1/helO2+1Xrlmr6ouUV36b2JkRTHMnsISCfEX8kYUzOZbkFDteJQ+E+IvRgws
 Gi9o6pKHTN3LvldWWjQ==
X-Proofpoint-GUID: kDTctUSAGCjpPqTVh7gSDaBypch810sH
X-Authority-Analysis: v=2.4 cv=NLpAaE6g c=1 sm=1 tr=0 ts=6ab42121 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=lf3uF_WxYAFngkJIBPEA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA3NSBTYWx0ZWRfXzHXlBrekMvxR
 OdKjWCmqhb2zbzII6a2a+5FahH7LZBhhQY2+SSSQXDOy6q/r/MUoCAhE8izlPADG+j3zqH1Ev2Z
 8IMuBvYVBxVsUZnSOi6hknVk+DLoDl8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 phishscore=0
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

Now we know all container images used for tcg-tests are x86_64 only, we
don't need to specify anymore which arch they support.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/aarch64/meson.build            |  2 --
 tests/tcg/aarch64/system/meson.build     |  1 -
 tests/tcg/aarch64_be/meson.build         |  1 -
 tests/tcg/alpha/meson.build              |  2 --
 tests/tcg/alpha/system/meson.build       |  1 -
 tests/tcg/arm/meson.build                |  2 --
 tests/tcg/arm/system/meson.build         |  1 -
 tests/tcg/hexagon/meson.build            |  1 -
 tests/tcg/hppa/meson.build               |  1 -
 tests/tcg/i386/meson.build               |  2 --
 tests/tcg/i386/system/meson.build        |  1 -
 tests/tcg/loongarch64/meson.build        |  2 --
 tests/tcg/loongarch64/system/meson.build |  1 -
 tests/tcg/m68k/meson.build               |  1 -
 tests/tcg/meson.build                    | 11 +----------
 tests/tcg/mips/meson.build               |  1 -
 tests/tcg/mips64/meson.build             |  1 -
 tests/tcg/mips64el/meson.build           |  1 -
 tests/tcg/or1k/meson.build               |  1 -
 tests/tcg/ppc64/meson.build              |  1 -
 tests/tcg/ppc64le/meson.build            |  1 -
 tests/tcg/riscv64/meson.build            |  2 --
 tests/tcg/riscv64/system/meson.build     |  1 -
 tests/tcg/s390x/meson.build              |  2 --
 tests/tcg/s390x/system/meson.build       |  1 -
 tests/tcg/sh4/meson.build                |  1 -
 tests/tcg/tricore/meson.build            |  1 -
 tests/tcg/x86_64/meson.build             |  2 --
 tests/tcg/x86_64/system/meson.build      |  1 -
 tests/tcg/xtensa/meson.build             |  3 ---
 30 files changed, 1 insertion(+), 49 deletions(-)

diff --git a/tests/tcg/aarch64/meson.build b/tests/tcg/aarch64/meson.build
index 28498e82cba..cc2c59fb4b6 100644
--- a/tests/tcg/aarch64/meson.build
+++ b/tests/tcg/aarch64/meson.build
@@ -1,6 +1,5 @@
 cc = 'aarch64-linux-gnu-gcc'
 cc_dockerfile = 'debian-all-test-cross'
-cc_docker_host_arch = ['aarch64', 'x86_64']
 
 cc_feat_cflags = {
   'aes': '-march=armv8-a+aes',
@@ -198,7 +197,6 @@ if 'qemu-aarch64' in emulators
     'aarch64-linux-user': {
       'cc': cc,
       'cc_dockerfile': cc_dockerfile,
-      'cc_docker_host_arch': cc_docker_host_arch,
       'cc_feat_cflags': cc_feat_cflags,
       'folder': 'aarch64',
       'gdb_arch': 'aarch64',
diff --git a/tests/tcg/aarch64/system/meson.build b/tests/tcg/aarch64/system/meson.build
index 94e16ba3300..6ba35a9f722 100644
--- a/tests/tcg/aarch64/system/meson.build
+++ b/tests/tcg/aarch64/system/meson.build
@@ -97,7 +97,6 @@ if 'qemu-system-aarch64' in emulators
     'aarch64-softmmu': {
       'cc': cc,
       'cc_dockerfile': cc_dockerfile,
-      'cc_docker_host_arch': cc_docker_host_arch,
       'cc_feat_cflags': cc_feat_cflags,
       'folder': 'aarch64/system',
       'gdb_arch': 'aarch64',
diff --git a/tests/tcg/aarch64_be/meson.build b/tests/tcg/aarch64_be/meson.build
index 9ea111f9885..e45a49ec2da 100644
--- a/tests/tcg/aarch64_be/meson.build
+++ b/tests/tcg/aarch64_be/meson.build
@@ -11,7 +11,6 @@ if 'qemu-aarch64_be' in emulators
     'aarch64_be-linux-user': {
       'cc': 'aarch64-linux-gnu-gcc',
       'cc_dockerfile': 'debian-all-test-cross',
-      'cc_docker_host_arch': ['aarch64', 'x86_64'],
       'cc_feat_cflags': cc_feat_cflags,
       'folder': 'aarch64_be',
       'gdb_arch': 'aarch64_be',
diff --git a/tests/tcg/alpha/meson.build b/tests/tcg/alpha/meson.build
index fe60ce2496a..30ea2a6978e 100644
--- a/tests/tcg/alpha/meson.build
+++ b/tests/tcg/alpha/meson.build
@@ -1,6 +1,5 @@
 cc = 'alpha-linux-gnu-gcc'
 cc_dockerfile = 'debian-all-test-cross'
-cc_docker_host_arch = ['aarch64', 'x86_64']
 
 subdir('system')
 
@@ -45,7 +44,6 @@ if 'qemu-alpha' in emulators
     'alpha-linux-user': {
       'cc': cc,
       'cc_dockerfile': cc_dockerfile,
-      'cc_docker_host_arch': cc_docker_host_arch,
       'folder': 'alpha',
       'gdb_arch': 'alpha',
       'qemu': emulators['qemu-alpha'],
diff --git a/tests/tcg/alpha/system/meson.build b/tests/tcg/alpha/system/meson.build
index b10f2c3e28d..5388e17a2f7 100644
--- a/tests/tcg/alpha/system/meson.build
+++ b/tests/tcg/alpha/system/meson.build
@@ -37,7 +37,6 @@ if 'qemu-system-alpha' in emulators
     'alpha-softmmu': {
       'cc': cc,
       'cc_dockerfile': cc_dockerfile,
-      'cc_docker_host_arch': cc_docker_host_arch,
       'folder': 'alpha/system',
       'gdb_arch': 'alpha',
       'qemu': emulators['qemu-system-alpha'],
diff --git a/tests/tcg/arm/meson.build b/tests/tcg/arm/meson.build
index 1b491cea026..30154efaec8 100644
--- a/tests/tcg/arm/meson.build
+++ b/tests/tcg/arm/meson.build
@@ -1,6 +1,5 @@
 cc = 'arm-linux-gnueabihf-gcc'
 cc_dockerfile = 'debian-all-test-cross'
-cc_docker_host_arch = ['aarch64', 'x86_64']
 
 subdir('system')
 
@@ -70,7 +69,6 @@ if 'qemu-arm' in emulators
     'arm-linux-user': {
       'cc': cc,
       'cc_dockerfile': cc_dockerfile,
-      'cc_docker_host_arch': cc_docker_host_arch,
       'folder': 'arm',
       'gdb_arch': 'arm',
       'qemu': emulators['qemu-arm'],
diff --git a/tests/tcg/arm/system/meson.build b/tests/tcg/arm/system/meson.build
index 52869976704..93d0cfec24e 100644
--- a/tests/tcg/arm/system/meson.build
+++ b/tests/tcg/arm/system/meson.build
@@ -65,7 +65,6 @@ if 'qemu-system-arm' in emulators
     'arm-softmmu': {
       'cc': cc,
       'cc_dockerfile': cc_dockerfile,
-      'cc_docker_host_arch': cc_docker_host_arch,
       'folder': 'arm/system',
       'gdb_arch': 'arm',
       'qemu': emulators['qemu-system-arm'],
diff --git a/tests/tcg/hexagon/meson.build b/tests/tcg/hexagon/meson.build
index 6e36a9a1220..f3d20091aa9 100644
--- a/tests/tcg/hexagon/meson.build
+++ b/tests/tcg/hexagon/meson.build
@@ -111,7 +111,6 @@ if 'qemu-hexagon' in emulators
     'hexagon-linux-user': {
       'cc': 'hexagon-unknown-linux-musl-clang',
       'cc_dockerfile': 'debian-hexagon-cross',
-      'cc_docker_host_arch': ['x86_64'],
       'folder': 'hexagon',
       'gdb_arch': 'hexagon_is_not_supported_by_gdb',
       'qemu': emulators['qemu-hexagon'],
diff --git a/tests/tcg/hppa/meson.build b/tests/tcg/hppa/meson.build
index 9ca8f29fa93..01d4554d993 100644
--- a/tests/tcg/hppa/meson.build
+++ b/tests/tcg/hppa/meson.build
@@ -11,7 +11,6 @@ if 'qemu-hppa' in emulators
     'hppa-linux-user': {
       'cc': 'hppa-linux-gnu-gcc',
       'cc_dockerfile': 'debian-all-test-cross',
-      'cc_docker_host_arch': ['x86_64'],
       'cc_feat_cflags': cc_feat_cflags,
       'folder': 'hppa',
       'gdb_arch': 'hppa',
diff --git a/tests/tcg/i386/meson.build b/tests/tcg/i386/meson.build
index 5cda03655fa..04d438a062a 100644
--- a/tests/tcg/i386/meson.build
+++ b/tests/tcg/i386/meson.build
@@ -1,6 +1,5 @@
 cc = 'i686-linux-gnu-gcc'
 cc_dockerfile = 'debian-i686-cross'
-cc_docker_host_arch = ['x86_64']
 
 subdir('system')
 
@@ -48,7 +47,6 @@ if 'qemu-i386' in emulators
     'i386-linux-user': {
       'cc': cc,
       'cc_dockerfile': cc_dockerfile,
-      'cc_docker_host_arch': cc_docker_host_arch,
       'folder': 'i386',
       'gdb_arch': 'i386',
       'qemu': emulators['qemu-i386'],
diff --git a/tests/tcg/i386/system/meson.build b/tests/tcg/i386/system/meson.build
index d3f73997c7f..0986f5898d4 100644
--- a/tests/tcg/i386/system/meson.build
+++ b/tests/tcg/i386/system/meson.build
@@ -39,7 +39,6 @@ if 'qemu-system-i386' in emulators
     'i386-softmmu': {
       'cc': cc,
       'cc_dockerfile': cc_dockerfile,
-      'cc_docker_host_arch': cc_docker_host_arch,
       'folder': 'i386/system',
       'gdb_arch': 'i386',
       'qemu': emulators['qemu-system-i386'],
diff --git a/tests/tcg/loongarch64/meson.build b/tests/tcg/loongarch64/meson.build
index 1d62de64ed6..4dd64f16d87 100644
--- a/tests/tcg/loongarch64/meson.build
+++ b/tests/tcg/loongarch64/meson.build
@@ -1,6 +1,5 @@
 cc = 'loongarch64-unknown-linux-gnu-gcc'
 cc_dockerfile = 'debian-loongarch-cross'
-cc_docker_host_arch = ['x86_64']
 
 subdir('system')
 
@@ -22,7 +21,6 @@ if 'qemu-loongarch64' in emulators
     'loongarch64-linux-user': {
       'cc': cc,
       'cc_dockerfile': cc_dockerfile,
-      'cc_docker_host_arch': cc_docker_host_arch,
       'folder': 'loongarch64',
       'gdb_arch': 'loongarch64',
       'qemu': emulators['qemu-loongarch64'],
diff --git a/tests/tcg/loongarch64/system/meson.build b/tests/tcg/loongarch64/system/meson.build
index 5bf4c56e385..035dd5f85fb 100644
--- a/tests/tcg/loongarch64/system/meson.build
+++ b/tests/tcg/loongarch64/system/meson.build
@@ -38,7 +38,6 @@ if 'qemu-system-loongarch64' in emulators
     'loongarch64-softmmu': {
       'cc': cc,
       'cc_dockerfile': cc_dockerfile,
-      'cc_docker_host_arch': cc_docker_host_arch,
       'folder': 'loongarch64/system',
       'gdb_arch': 'loongarch64',
       'qemu': emulators['qemu-system-loongarch64'],
diff --git a/tests/tcg/m68k/meson.build b/tests/tcg/m68k/meson.build
index 8ecf450ac68..4b73d7fc57d 100644
--- a/tests/tcg/m68k/meson.build
+++ b/tests/tcg/m68k/meson.build
@@ -12,7 +12,6 @@ if 'qemu-m68k' in emulators
     'm68k-linux-user': {
       'cc': 'm68k-linux-gnu-gcc',
       'cc_dockerfile': 'debian-all-test-cross',
-      'cc_docker_host_arch': ['x86_64'],
       'cc_feat_cflags': cc_feat_cflags,
       'folder': 'm68k',
       'gdb_arch': 'm68k',
diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index b0a857dc14b..ce77063cd4d 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -22,7 +22,6 @@ tcg_tests = {}
 #   'name_of_target': {
 #     'cc': 'cross_compiler',
 #     'cc_dockerfile': 'name_of_dockerfile',
-#     'cc_docker_host_arch': ['host_arch_supported (meson cpu)', ...],
 #     'cc_feat_cflags': {
 #       'name': ['feature cflags'],
 #       ...
@@ -211,7 +210,7 @@ foreach target, plan: tcg_tests
 
   # return a clear error if user misspell a target entry
   foreach key, _ : plan
-    allowed = ['cc', 'cc_dockerfile', 'cc_docker_host_arch', 'cc_feat_cflags',
+    allowed = ['cc', 'cc_dockerfile', 'cc_feat_cflags',
                'folder', 'gdb_arch', 'gdb_feat_version', 'qemu', 'tests']
     if key not in allowed
       error('unknown tcg test plan entry \'' + key + '\' for target ' + target +
@@ -258,14 +257,6 @@ foreach target, plan: tcg_tests
 
   if 'cc_dockerfile' in plan
     cc_dockerfile = plan['cc_dockerfile']
-    cc_docker_host_arch = plan['cc_docker_host_arch']
-    allowed = ['aarch64', 'x86_64']
-    foreach arch: cc_docker_host_arch
-      if arch not in allowed
-        error('incorrect docker arch ' + arch + ' for target ' +
-              target + ' (possible: [' + ', '.join(allowed) + '])')
-      endif
-    endforeach
     dockerfile = files('..'/'docker'/'dockerfiles'/cc_dockerfile + '.docker')
     image_name = 'image-' + cc_dockerfile
     if cc_dockerfile not in image_targets and docker_supported
diff --git a/tests/tcg/mips/meson.build b/tests/tcg/mips/meson.build
index 3c4f6ec482d..efda857ab61 100644
--- a/tests/tcg/mips/meson.build
+++ b/tests/tcg/mips/meson.build
@@ -14,7 +14,6 @@ if 'qemu-mips' in emulators
     'mips-linux-user': {
       'cc': 'mips-linux-gnu-gcc',
       'cc_dockerfile': 'debian-all-test-cross',
-      'cc_docker_host_arch': ['aarch64', 'x86_64'],
       'cc_feat_cflags': cc_feat_cflags,
       'folder': 'mips',
       'gdb_arch': 'mips',
diff --git a/tests/tcg/mips64/meson.build b/tests/tcg/mips64/meson.build
index 69391c23187..b8eb6705eae 100644
--- a/tests/tcg/mips64/meson.build
+++ b/tests/tcg/mips64/meson.build
@@ -16,7 +16,6 @@ if 'qemu-mips64' in emulators
     'mips64-linux-user': {
       'cc': 'mips64-linux-gnuabi64-gcc',
       'cc_dockerfile': 'debian-all-test-cross',
-      'cc_docker_host_arch': ['aarch64', 'x86_64'],
       'cc_feat_cflags': cc_feat_cflags,
       'folder': 'mips64',
       'gdb_arch': 'mips64',
diff --git a/tests/tcg/mips64el/meson.build b/tests/tcg/mips64el/meson.build
index f6c0fae7981..2aafbba750d 100644
--- a/tests/tcg/mips64el/meson.build
+++ b/tests/tcg/mips64el/meson.build
@@ -3,7 +3,6 @@ if 'qemu-mips64el' in emulators
     'mips64el-linux-user': {
       'cc': 'mips64el-linux-gnuabi64-gcc',
       'cc_dockerfile': 'debian-all-test-cross',
-      'cc_docker_host_arch': ['aarch64', 'x86_64'],
       'cc_feat_cflags': cc_feat_cflags,
       'folder': 'mips64el',
       'gdb_arch': 'mips64el',
diff --git a/tests/tcg/or1k/meson.build b/tests/tcg/or1k/meson.build
index 5151e8f361f..c89bb372b47 100644
--- a/tests/tcg/or1k/meson.build
+++ b/tests/tcg/or1k/meson.build
@@ -61,7 +61,6 @@ if 'qemu-or1k' in emulators
     'or1k-linux-user': {
       'cc': 'or1k-none-linux-musl-gcc',
       'cc_dockerfile': 'debian-all-test-cross',
-      'cc_docker_host_arch': ['x86_64'],
       'cc_feat_cflags': cc_feat_cflags,
       'folder': 'or1k',
       'gdb_arch': 'or1k',
diff --git a/tests/tcg/ppc64/meson.build b/tests/tcg/ppc64/meson.build
index c7e495f3d34..8cca4d65a4c 100644
--- a/tests/tcg/ppc64/meson.build
+++ b/tests/tcg/ppc64/meson.build
@@ -44,7 +44,6 @@ if 'qemu-ppc64' in emulators
     'ppc64-linux-user': {
       'cc': 'powerpc64-linux-gnu-gcc',
       'cc_dockerfile': 'debian-all-test-cross',
-      'cc_docker_host_arch': ['x86_64'],
       'cc_feat_cflags': cc_feat_cflags,
       'folder': 'ppc64',
       'gdb_arch': 'ppc64',
diff --git a/tests/tcg/ppc64le/meson.build b/tests/tcg/ppc64le/meson.build
index 720aa167f23..a0f3e62e4d3 100644
--- a/tests/tcg/ppc64le/meson.build
+++ b/tests/tcg/ppc64le/meson.build
@@ -3,7 +3,6 @@ if 'qemu-ppc64le' in emulators
     'ppc64le-linux-user': {
       'cc': 'powerpc64le-linux-gnu-gcc',
       'cc_dockerfile': 'debian-all-test-cross',
-      'cc_docker_host_arch': ['x86_64'],
       'cc_feat_cflags': cc_feat_cflags,
       'folder': 'ppc64le',
       'gdb_arch': 'ppc64le',
diff --git a/tests/tcg/riscv64/meson.build b/tests/tcg/riscv64/meson.build
index 2292bf8ed1b..5ee20a1e98d 100644
--- a/tests/tcg/riscv64/meson.build
+++ b/tests/tcg/riscv64/meson.build
@@ -1,6 +1,5 @@
 cc = 'riscv64-linux-gnu-gcc'
 cc_dockerfile = 'debian-all-test-cross'
-cc_docker_host_arch = ['aarch64', 'x86_64']
 
 subdir('system')
 
@@ -28,7 +27,6 @@ if 'qemu-riscv64' in emulators
     'riscv64-linux-user': {
       'cc': cc,
       'cc_dockerfile': cc_dockerfile,
-      'cc_docker_host_arch': cc_docker_host_arch,
       'folder': 'riscv64',
       'gdb_arch': 'riscv64',
       'qemu': emulators['qemu-riscv64'],
diff --git a/tests/tcg/riscv64/system/meson.build b/tests/tcg/riscv64/system/meson.build
index 8604c2a45a9..87c3f9f11ce 100644
--- a/tests/tcg/riscv64/system/meson.build
+++ b/tests/tcg/riscv64/system/meson.build
@@ -66,7 +66,6 @@ if 'qemu-system-riscv64' in emulators
     'riscv64-softmmu': {
       'cc': cc,
       'cc_dockerfile': cc_dockerfile,
-      'cc_docker_host_arch': cc_docker_host_arch,
       'folder': 'riscv64',
       'gdb_arch': 'riscv64',
       'qemu': emulators['qemu-system-riscv64'],
diff --git a/tests/tcg/s390x/meson.build b/tests/tcg/s390x/meson.build
index 57ea6c5ca55..96cd0e4847f 100644
--- a/tests/tcg/s390x/meson.build
+++ b/tests/tcg/s390x/meson.build
@@ -1,6 +1,5 @@
 cc = 's390x-linux-gnu-gcc'
 cc_dockerfile = 'debian-all-test-cross'
-cc_docker_host_arch = ['aarch64', 'x86_64']
 
 cc_feat_cflags = {
   'z14': '-march=z14',
@@ -141,7 +140,6 @@ if 'qemu-s390x' in emulators
     's390x-linux-user': {
       'cc': cc,
       'cc_dockerfile': cc_dockerfile,
-      'cc_docker_host_arch': cc_docker_host_arch,
       'cc_feat_cflags': cc_feat_cflags,
       'folder': 's390x',
       'gdb_arch': 's390x',
diff --git a/tests/tcg/s390x/system/meson.build b/tests/tcg/s390x/system/meson.build
index 1e360e70821..ef19c4831fd 100644
--- a/tests/tcg/s390x/system/meson.build
+++ b/tests/tcg/s390x/system/meson.build
@@ -83,7 +83,6 @@ if 'qemu-system-s390x' in emulators
     's390x-softmmu': {
       'cc': cc,
       'cc_dockerfile': cc_dockerfile,
-      'cc_docker_host_arch': cc_docker_host_arch,
       'cc_feat_cflags': cc_feat_cflags,
       'folder': 's390x',
       'gdb_arch': 's390x',
diff --git a/tests/tcg/sh4/meson.build b/tests/tcg/sh4/meson.build
index d73df074497..12b24fffc77 100644
--- a/tests/tcg/sh4/meson.build
+++ b/tests/tcg/sh4/meson.build
@@ -14,7 +14,6 @@ if 'qemu-sh4' in emulators
     'sh4-linux-user': {
       'cc': 'sh4-linux-gnu-gcc',
       'cc_dockerfile': 'debian-all-test-cross',
-      'cc_docker_host_arch': ['aarch64', 'x86_64'],
       'cc_feat_cflags': cc_feat_cflags,
       'folder': 'sh4',
       'gdb_arch': 'sh4',
diff --git a/tests/tcg/tricore/meson.build b/tests/tcg/tricore/meson.build
index d0bf55dedce..837a3d5e22f 100644
--- a/tests/tcg/tricore/meson.build
+++ b/tests/tcg/tricore/meson.build
@@ -47,7 +47,6 @@ if 'qemu-system-tricore' in emulators
     'tricore-softmmu': {
       'cc': 'tricore-gcc',
       'cc_dockerfile': 'debian-tricore-cross',
-      'cc_docker_host_arch': ['x86_64'],
       'folder': 'tricore',
       'gdb_arch': 'tricore',
       'qemu': emulators['qemu-system-tricore'],
diff --git a/tests/tcg/x86_64/meson.build b/tests/tcg/x86_64/meson.build
index ab336eca9b2..787a2ca61b2 100644
--- a/tests/tcg/x86_64/meson.build
+++ b/tests/tcg/x86_64/meson.build
@@ -1,6 +1,5 @@
 cc = 'x86_64-linux-gnu-gcc'
 cc_dockerfile = 'debian-amd64-cross'
-cc_docker_host_arch = ['x86_64']
 
 subdir('system')
 
@@ -74,7 +73,6 @@ if 'qemu-x86_64' in emulators
     'x86_64-linux-user': {
       'cc': cc,
       'cc_dockerfile': cc_dockerfile,
-      'cc_docker_host_arch': cc_docker_host_arch,
       'folder': 'x86_64',
       'gdb_arch': 'x86_64',
       'qemu': emulators['qemu-x86_64'],
diff --git a/tests/tcg/x86_64/system/meson.build b/tests/tcg/x86_64/system/meson.build
index 80110d0ae57..43e7d7afa85 100644
--- a/tests/tcg/x86_64/system/meson.build
+++ b/tests/tcg/x86_64/system/meson.build
@@ -53,7 +53,6 @@ if 'qemu-system-x86_64' in emulators
     'x86_64-softmmu': {
       'cc': cc,
       'cc_dockerfile': cc_dockerfile,
-      'cc_docker_host_arch': cc_docker_host_arch,
       'folder': 'x86_64/system',
       'gdb_arch': 'x86_64',
       'qemu': emulators['qemu-system-x86_64'],
diff --git a/tests/tcg/xtensa/meson.build b/tests/tcg/xtensa/meson.build
index bb1dd1542e5..5ff9c6cd548 100644
--- a/tests/tcg/xtensa/meson.build
+++ b/tests/tcg/xtensa/meson.build
@@ -79,14 +79,12 @@ foreach core: cores
 endforeach
 
 cc_dockerfile = 'debian-xtensa-cross'
-cc_docker_host_arch = ['x86_64']
 
 if 'qemu-system-xtensa' in emulators
   tcg_tests += {
     'xtensa-softmmu': {
       'cc': 'xtensa-dc232b-elf-gcc',
       'cc_dockerfile': cc_dockerfile,
-      'cc_docker_host_arch': cc_docker_host_arch,
       'folder': 'xtensa',
       'gdb_arch': 'xtensa',
       'qemu': emulators['qemu-system-xtensa'],
@@ -100,7 +98,6 @@ if 'qemu-system-xtensaeb' in emulators
     'xtensaeb-softmmu': {
       'cc': 'xtensa-test_kc705_be-elf-gcc',
       'cc_dockerfile': cc_dockerfile,
-      'cc_docker_host_arch': cc_docker_host_arch,
       'folder': 'xtensa',
       'gdb_arch': 'xtensaeb',
       'qemu': emulators['qemu-system-xtensaeb'],
-- 
2.47.3


