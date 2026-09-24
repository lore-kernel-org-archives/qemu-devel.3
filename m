Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED4C5C98318
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 21:40:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9rAq-0008TZ-9A; Thu, 24 Sep 2026 17:40:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x9rAb-0008Og-15
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 17:39:57 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x9rAY-0000wI-Hh
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 17:39:56 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OIdt8n2866645
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 21:39:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=se1+gKqEYEp
 HesItheZ0WLl/VL84/Vv+XbpTmslCcII=; b=EBV+KeY1bBe2uFeRPJrxpjHilmO
 ZVYuFVyfKfPe/+KCnqpZDAiu25rHWGGMOm6+yjwhD0vwItp3c5KoRd18y5dnQNv1
 ZaWJ9iUPvZascA3giWQlR/C3Q7NBo1aG2YPxLZziQaNq91rEcJEix5aej+1DJ6b7
 JZRQMcb29G4SMmcnywMlq5HIbB14CrtSPYDm7KI0MRSerfuzUzVsu5qeCgma+5GB
 4cfKmyDZB4u+XTFfFJpowZXvBFXBN/jw4WnyCjMqiJ6QFlAMuio1hoigkrzrf6vl
 arPPIrdgx9GtuzrqFFcPeFfURVNho7jcuPaWgtP9zUviFt1930dMF9rFG1g==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw5q8srb0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 21:39:53 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-32861f5448cso767505eec.0
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 14:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790285992; x=1790890792; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=se1+gKqEYEpHesItheZ0WLl/VL84/Vv+XbpTmslCcII=;
 b=ZZu4mtXFpC8FDwaKch1AQYbe37gthrDC/04Zxz7RnUx5nTGf4ZjiqGnzS3635++EMU
 u+NM49uE3yk0UWHMol2N0fO7BbsYYgoUo9SVJ0wuXQWU/opipyeTTrGNN8shBm3k7O3O
 xKsXLdbk45Vyd1FznPqWqotDHDRmMj+rvYasSriReH7p+KWYjULVzmzXIOOC/2idpsyC
 WgUPuWbujM1UbhCbgzeet5hztnPz+7yDsNwPxjbAxhcXdvpoWmTotIPxRB/6gYK+3tuW
 RAYQnFjUpEeMqWUUi2vXFPKtHZRavUKZm4uqHXyUghr9Sd9UnE6Arq6WNj64+HfeaJLY
 5VmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790285992; x=1790890792;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=se1+gKqEYEpHesItheZ0WLl/VL84/Vv+XbpTmslCcII=;
 b=C1Bgz5C8Dh7DQ5y7UkhhDMbOSLJ5qu2Ksq4Y6ep5Bbj7LVvdXOSrfcN/6NrmCD11+x
 SXvVDUJg2y/xouP8RVH3TUlHGGEj+E4vfz3p8AsQ3aDoC/4Obf3PjfIZSD8ErSGiKa5n
 Cn1RB+A/iE8/Q6MqjCrhiwdwXsR3satNSed21t7si779QhkuYvKAckZqRIR2X3eVT1cQ
 /4ZxaguDFpseR+aYaV+77EWq51tC/6CP6DvPhFJwGH3KW8p1jXz240w0pI/tOxUJGJL+
 /AJwrkJPfwdhRTOdRGJzHkEnNIbdvoslslqZJAbt2nXOmCIduBN7FwuG8I+GDlY9FZf5
 DDNA==
X-Gm-Message-State: AFuF++n682Y2ATH6hKaAIY0G7YyqphshZ2Ijl27Lir5RQr5FYfFn9GMA
 0+Hyk1QvbQLdjWX2HQZHsQivJKLqCaL4tRE26amCQ0YNvHzRilPFxCEwjRQxcMeN6Yst52GLAXJ
 9wzAURHFL/Z5QjShvC/nG4ZJoZA8D+0Fue7hQB/4JkW187m9gZSA+PVKXAjfE51FSEw==
X-Gm-Gg: AYBFou1hQvvcs/xXd50jb/C4jPxe4/ksgzmNOOWtW2oKyQkEp0ak8J5E9BPS8zaQCBp
 6IEXl9DdSwkqgdZFvbJV8Rb98kD/m266+Mr2GNZdn2fAAP3EE8830ij0buy9M/7tC3EQY94ex31
 5Er+yu4r/pUVMgK9mIL3241ds8NX59Gr8SGCRb2uipkdH5KZg8oZKi2EVLrweAT/tZL5wBzDc7t
 fwc+sHP31FZneZeuMkILlSUoXFR6eDVU0/ea2/wDRi29Fy71Q3RiWE6EErymLXKJHIsjViwWvCG
 F1F8SRnbnjBQpT/EnprVkUJwbrQdyFcspHHW7e5y69ryCZj7ME/olqjeHYAw91R+Ot2UIZ+vhEs
 ZdV9Bn91Y6axlnjsbtDg8K6/59gmRySKsgntcwC32YJLAqTUcUKM1TyrWpg==
X-Received: by 2002:a05:701a:ca03:b0:145:49e:c068 with SMTP id
 a92af1059eb24-145049ee2ebmr3129299c88.8.1790285992083; 
 Thu, 24 Sep 2026 14:39:52 -0700 (PDT)
X-Received: by 2002:a05:701a:ca03:b0:145:49e:c068 with SMTP id
 a92af1059eb24-145049ee2ebmr3129243c88.8.1790285990073; 
 Thu, 24 Sep 2026 14:39:50 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-341463ec3ecsm1273668eec.31.2026.09.24.14.39.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 14:39:49 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 3/4] tests/tcg: add alternative cross-compilers for fedora
Date: Thu, 24 Sep 2026 21:39:41 +0000
Message-ID: <20260924213942.26491-4-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260924213942.26491-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260924213942.26491-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA4OCBTYWx0ZWRfX/cjEJNJ4IIq3
 Uxz72BJcn1aCBRFVg1FkAvJllft4rJxV17lT/rXl4en4FPM0r2wMiiHRkV5qJyIdT7aEc/bwJwN
 3EZGsdmwm55lrcYCfnmOKkNY4TiQFtY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA4OCBTYWx0ZWRfX4hTagMrS//sM
 1TMaJbDpnxPjASZpY/iu/cTBpagcs5UULfxtQGEV0bO6EdNFtUT+fOpbNCjAQd2sY7okBffUxQ3
 TpUMer6YI1eODq45FGbZa8LyLZuek2c3m0RKd0qk/8jLkgi1/dRbmvve+gGqt6PCKRlxvrfv/GB
 SBwtA7/aa31uQ2ORP9RxGa9wX3gG5rwkiNf+w2RKXT8WQPoXn3zMIK1n1eqBmxWodZU684JE0p5
 PChQtTmWu2AZm9kCqRGI4hA8HEG5jzihHyqpr4KvVOoEHagaxWuzgPMnatYZhLnBNT5n2Letm+t
 0rlO7LE0kaGp0IGCY6zxTcYW8AD+k73A6AF/qnsOElB2ZYFXH27JSXLAiHRCFJjIqFMhfyoSSuR
 Ysd7KH+Vy7R9dmdw+a7OP3n8IRhCIXhOGjbBPE0PRASshaGYEP+JVan8H4kxG8aWgypT6WDTcTm
 x4zhw1uPkfhPhhrPitA==
X-Authority-Analysis: v=2.4 cv=SYRi5fRu c=1 sm=1 tr=0 ts=6ab598a9 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=vTr9H3xdAAAA:8
 a=EUspDBNiAAAA:8 a=1qaXVQrJmLcKRRiVE9QA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: QlAkI4QU0kOm-wOVAfyarZY3MCe8Gj7g
X-Proofpoint-ORIG-GUID: QlAkI4QU0kOm-wOVAfyarZY3MCe8Gj7g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240088
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

This allows to pick host compiler automatically on fedora, as those
binaries are installed with 'gcc' package.

This covers all host arch supported to this day:
https://fedoraproject.org/wiki/Architectures
- x86_64
- aarch64
- ppc64le
- riscv64
- s390x
Note: QEMU and Fedora don't support 32-bit hosts anymore.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/aarch64/meson.build        | 2 ++
 tests/tcg/aarch64/system/meson.build | 1 +
 tests/tcg/aarch64_be/meson.build     | 1 +
 tests/tcg/ppc64le/meson.build        | 1 +
 tests/tcg/riscv64/meson.build        | 2 ++
 tests/tcg/riscv64/system/meson.build | 1 +
 tests/tcg/s390x/meson.build          | 2 ++
 tests/tcg/s390x/system/meson.build   | 1 +
 tests/tcg/x86_64/meson.build         | 2 ++
 tests/tcg/x86_64/system/meson.build  | 1 +
 10 files changed, 14 insertions(+)

diff --git a/tests/tcg/aarch64/meson.build b/tests/tcg/aarch64/meson.build
index cc2c59fb4b6..1cec335df04 100644
--- a/tests/tcg/aarch64/meson.build
+++ b/tests/tcg/aarch64/meson.build
@@ -1,4 +1,5 @@
 cc = 'aarch64-linux-gnu-gcc'
+cc_alt = ['aarch64-redhat-linux-gcc']
 cc_dockerfile = 'debian-all-test-cross'
 
 cc_feat_cflags = {
@@ -196,6 +197,7 @@ if 'qemu-aarch64' in emulators
   tcg_tests += {
     'aarch64-linux-user': {
       'cc': cc,
+      'cc_alt': cc_alt,
       'cc_dockerfile': cc_dockerfile,
       'cc_feat_cflags': cc_feat_cflags,
       'folder': 'aarch64',
diff --git a/tests/tcg/aarch64/system/meson.build b/tests/tcg/aarch64/system/meson.build
index 6ba35a9f722..fb3b33861ea 100644
--- a/tests/tcg/aarch64/system/meson.build
+++ b/tests/tcg/aarch64/system/meson.build
@@ -96,6 +96,7 @@ if 'qemu-system-aarch64' in emulators
   tcg_tests += {
     'aarch64-softmmu': {
       'cc': cc,
+      'cc_alt': cc_alt,
       'cc_dockerfile': cc_dockerfile,
       'cc_feat_cflags': cc_feat_cflags,
       'folder': 'aarch64/system',
diff --git a/tests/tcg/aarch64_be/meson.build b/tests/tcg/aarch64_be/meson.build
index e45a49ec2da..509408de8e7 100644
--- a/tests/tcg/aarch64_be/meson.build
+++ b/tests/tcg/aarch64_be/meson.build
@@ -10,6 +10,7 @@ if 'qemu-aarch64_be' in emulators
   tcg_tests += {
     'aarch64_be-linux-user': {
       'cc': 'aarch64-linux-gnu-gcc',
+      'cc_alt': ['aarch64-redhat-linux-gcc'],
       'cc_dockerfile': 'debian-all-test-cross',
       'cc_feat_cflags': cc_feat_cflags,
       'folder': 'aarch64_be',
diff --git a/tests/tcg/ppc64le/meson.build b/tests/tcg/ppc64le/meson.build
index a0f3e62e4d3..9f386287e7a 100644
--- a/tests/tcg/ppc64le/meson.build
+++ b/tests/tcg/ppc64le/meson.build
@@ -2,6 +2,7 @@ if 'qemu-ppc64le' in emulators
   tcg_tests += {
     'ppc64le-linux-user': {
       'cc': 'powerpc64le-linux-gnu-gcc',
+      'cc_alt': ['ppc64le-redhat-linux-gcc'],
       'cc_dockerfile': 'debian-all-test-cross',
       'cc_feat_cflags': cc_feat_cflags,
       'folder': 'ppc64le',
diff --git a/tests/tcg/riscv64/meson.build b/tests/tcg/riscv64/meson.build
index 5ee20a1e98d..91c840b0058 100644
--- a/tests/tcg/riscv64/meson.build
+++ b/tests/tcg/riscv64/meson.build
@@ -1,4 +1,5 @@
 cc = 'riscv64-linux-gnu-gcc'
+cc_alt = ['riscv64-redhat-linux-gnu-gcc']
 cc_dockerfile = 'debian-all-test-cross'
 
 subdir('system')
@@ -26,6 +27,7 @@ if 'qemu-riscv64' in emulators
   tcg_tests += {
     'riscv64-linux-user': {
       'cc': cc,
+      'cc_alt': cc_alt,
       'cc_dockerfile': cc_dockerfile,
       'folder': 'riscv64',
       'gdb_arch': 'riscv64',
diff --git a/tests/tcg/riscv64/system/meson.build b/tests/tcg/riscv64/system/meson.build
index 87c3f9f11ce..c87e3eee1ad 100644
--- a/tests/tcg/riscv64/system/meson.build
+++ b/tests/tcg/riscv64/system/meson.build
@@ -65,6 +65,7 @@ if 'qemu-system-riscv64' in emulators
   tcg_tests += {
     'riscv64-softmmu': {
       'cc': cc,
+      'cc_alt': cc_alt,
       'cc_dockerfile': cc_dockerfile,
       'folder': 'riscv64',
       'gdb_arch': 'riscv64',
diff --git a/tests/tcg/s390x/meson.build b/tests/tcg/s390x/meson.build
index 1f9aa57fc73..f2328d9e5cf 100644
--- a/tests/tcg/s390x/meson.build
+++ b/tests/tcg/s390x/meson.build
@@ -1,4 +1,5 @@
 cc = 's390x-linux-gnu-gcc'
+cc_alt = ['s390x-redhat-linux-gcc']
 cc_dockerfile = 'debian-all-test-cross'
 
 cc_feat_cflags = {
@@ -140,6 +141,7 @@ if 'qemu-s390x' in emulators
   tcg_tests += {
     's390x-linux-user': {
       'cc': cc,
+      'cc_alt': cc_alt,
       'cc_dockerfile': cc_dockerfile,
       'cc_feat_cflags': cc_feat_cflags,
       'folder': 's390x',
diff --git a/tests/tcg/s390x/system/meson.build b/tests/tcg/s390x/system/meson.build
index ef19c4831fd..359d124cc78 100644
--- a/tests/tcg/s390x/system/meson.build
+++ b/tests/tcg/s390x/system/meson.build
@@ -82,6 +82,7 @@ if 'qemu-system-s390x' in emulators
   tcg_tests += {
     's390x-softmmu': {
       'cc': cc,
+      'cc_alt': cc_alt,
       'cc_dockerfile': cc_dockerfile,
       'cc_feat_cflags': cc_feat_cflags,
       'folder': 's390x',
diff --git a/tests/tcg/x86_64/meson.build b/tests/tcg/x86_64/meson.build
index cfeef1d969c..968fe27cfc5 100644
--- a/tests/tcg/x86_64/meson.build
+++ b/tests/tcg/x86_64/meson.build
@@ -1,4 +1,5 @@
 cc = 'x86_64-linux-gnu-gcc'
+cc_alt = ['x86_64-redhat-linux-gcc']
 cc_dockerfile = 'debian-amd64-cross'
 
 subdir('system')
@@ -72,6 +73,7 @@ if 'qemu-x86_64' in emulators
   tcg_tests += {
     'x86_64-linux-user': {
       'cc': cc,
+      'cc_alt': cc_alt,
       'cc_dockerfile': cc_dockerfile,
       'folder': 'x86_64',
       'gdb_arch': 'x86_64',
diff --git a/tests/tcg/x86_64/system/meson.build b/tests/tcg/x86_64/system/meson.build
index 43e7d7afa85..08b770d43ae 100644
--- a/tests/tcg/x86_64/system/meson.build
+++ b/tests/tcg/x86_64/system/meson.build
@@ -52,6 +52,7 @@ if 'qemu-system-x86_64' in emulators
   tcg_tests += {
     'x86_64-softmmu': {
       'cc': cc,
+      'cc_alt': cc_alt,
       'cc_dockerfile': cc_dockerfile,
       'folder': 'x86_64/system',
       'gdb_arch': 'x86_64',
-- 
2.43.0


