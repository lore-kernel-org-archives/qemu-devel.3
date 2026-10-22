Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616C4606A31B
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 20:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KT0ml0ss;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PTYHpjwg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJzEV-0004XS-Py; Thu, 22 Oct 2026 16:17:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJzES-0004Wy-CR
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 16:17:49 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJzEP-0006aF-8q
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 16:17:48 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MHtYle409002
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 20:17:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=zE8FjfLBzyB
 dVdMbYC4/ya5lUDFBrQawEF5jmuDv+Z0=; b=KT0ml0ss7nN6NgZCtW7KYuUtqLH
 SImgC9i9nIj9SMn9RrWV2feTF1vLrPtvp//Mxy6G7FyQVteMR2DKCIhQmymMmnz4
 U9OYx4CDVTCybMyP93vIdHiamiIUmSq1fHpskLd7jB4W9LQMhwCzOdGR71dt6e2A
 FDLyuXPicHrydaYdxlF6IhnAidRivDELGJtERjr9i7m8LQPnNWTp2QqYUu0McQco
 Jd+KUnLm4tuDniP+LNwsrZWb1RzAVVjj97ttD9GtO9RlfgbLVKO3zAj8JlyXsH75
 zs2FPoB0/coByntzejPlxT/zTFdd7pdQz7erIemB7kc9B4ldSxhLLBqfilw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf93a5c9d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 20:17:43 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-8862ed0539dso269132b3a.0
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 13:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792700263; x=1793305063; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zE8FjfLBzyBdVdMbYC4/ya5lUDFBrQawEF5jmuDv+Z0=;
 b=PTYHpjwgb8hQrP2y6zhLycZV4kVTEOVAEi7bbSqnP+1zFr7nOqf2bsTVIr71NFVNoA
 5rz60WMpzXLVRaSHkkHko+IEIW1wn9dThvSVVPRwlPFQZ6cGv5eX6Ck2L5KZiX6vx/KW
 Oknb2aZCufZ6NBr79grWZcsAfXd4SjHaaJVOkMoVe0/D/wLsHNoAtbNAfg23dGQI0Pst
 HRTVcHcLzfvHoO3C1yxQsKNJ7lA71vaVP4HwuV++djh/5vfrihUz1266RsxDaArdee+Y
 5pMUqLiAzEf0VYKb3RsvcitaFSqAFCJrs/hBusa4wCpGMlIs19qWA8FLfXy5n8/2ATBt
 YAQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792700263; x=1793305063;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zE8FjfLBzyBdVdMbYC4/ya5lUDFBrQawEF5jmuDv+Z0=;
 b=bio1CeJAMcIuycaNqdm40uYyRlIZdrIdOtc5ybMwErP6IEvm972sEphL3DgTg/QL4l
 n9z2AU2MjMi4lL/Fm3gdEnq3eFwW/Ivo1rSRRrTrxoAW4ZVPqOqjNDe0NxTMp1hEklMr
 m3eDZ4tG7VQ0bQwpUyusbba1RAtqSxnBLC06+T2CgUE8qbc22HAw4uYVyJER4l528kls
 6xF9CrY5RnNwJTP4QKFMMV06Di1kBXkpQDA3GNTMzeLTEhsoIbhwoB3J6IK0U51HPxFf
 4pOy0HTQDaNC3u6wT9SeFyiD7wrkKhXil+9CwdR8IHI4TIZsmcYR+uGQYtOmiRSUo/2W
 VsTg==
X-Gm-Message-State: AFq9FYKFJ1qopjEAy0AEKdCyy3+q/LsTxrPbQEzvHles+gP8m9JmHAT2
 eqv6AS+P7fc8zkxKMyAd3/sSObs5LHoZy1Oo9plg4O7r+pbjkrjoGl0AMkhMEiwe0TqqncXrm7j
 CxpqM0StHo3sEvL2uVY308PFst2AL6/NQUDz7IJk0AMu6/RUAfVR+05u+GD9F+wYVsw==
X-Gm-Gg: AYBFou0Gbe7HPT2zU/bhNt0iPJUFdg+jy0GTN+ScKTbVvEdtJ+CqMmCRNrdBYr92gKA
 533qFh4opgODoP7QSmTl0RtQQSEB6qJPJKy2f5kd4gA/eMh8NJtDbLYaRb7Pa2FEQzItGiuJ/kq
 sDCqqeJSZ/lAWEFqeNzgkpyqz0+1+NZGEzA5yldInEskPYbCiejcAvvjnJt6UgppnpSGabNvfQr
 l2ZUkSMuAgNBY/HHbE5eqXQAFqYMzoRkMrA0Xd3P1AjzOd9GRo/mIgeiaAMAzYPIzj8AiX/clwR
 XCfLtapZAlEyqdnuQMsiY9iHpedvZo7IzE3oA2/T2n7OQ6EFeyqWqL/HHRIcP73UJX8fe0bTpiD
 gJXignDWP/8afugXXMTuVCDwefwwB97XCcO+9LaNDR5f/LNyuabtXhsq1v7IqS0I=
X-Received: by 2002:a05:6a00:9288:b0:8a0:1c79:b442 with SMTP id
 d2e1a72fcca58-8a2c523496fmr270443b3a.0.1792700262653; 
 Thu, 22 Oct 2026 13:17:42 -0700 (PDT)
X-Received: by 2002:a05:6a00:9288:b0:8a0:1c79:b442 with SMTP id
 d2e1a72fcca58-8a2c523496fmr270409b3a.0.1792700261950; 
 Thu, 22 Oct 2026 13:17:41 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8a2c89d8138sm55163b3a.18.2026.10.22.13.17.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 13:17:41 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 3/3] tests/tcg: remove global meson variables
Date: Thu, 22 Oct 2026 13:17:33 -0700
Message-ID: <20261022201733.1941651-4-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261022201733.1941651-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261022201733.1941651-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4MCBTYWx0ZWRfX0e6GOOt/irHR
 6ykD/T6S0GKsBP8pWqkQNzfuo0bUZIMl0fI/dpdxIirsYeNN1GbuABuXJ2EvgPtc5fEkYMzMjz1
 h/JU4u+i+LSdX6vWOMGTcX0j8gArz4h9tBci/khHHQuOSqZ17C+mNqwAMVe3AgU1j7UfZlGZ0bB
 3XYfwQMWXHd2mnGQnMkJnNOeiSdhxePqSSrSmlNqy0llS7W4X9A0zr0ZuqZ+y3g8SDY2ixeVgsf
 ZdpHNQFSs3OShqs+Cts5TPFjvQCes8WHzKpHPxLLkCT+dJ0srflCOLQOFBNug0/eDFzTKpZaUIj
 Hjeqqk3v1R3ALYX6CSJJMaVYk0lz4+3RY2AOLxrHX0ppaw+LHOCk73maj4rjxR78lgYfCboOkr6
 kbhGz7GebDXGX6ABjXzVgH1oU7qwb0cPB0DMhDDyjCVnyYdhOqjukeBp5xwTZPToF3UhCf9LYRf
 UoK+NZKztYMGVDn9hsA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4MCBTYWx0ZWRfX0URqXrpPfu37
 8/5Sp0M1C/cuzy0zXLqOoN7F/cmuVQdm6VA1JeH1JPjeKmarO4qzZMbYm1NGr7R5ofv2mseiXnT
 KzDDopUob1+jBC0KOJ/eiWeZ7OHCQoo=
X-Proofpoint-GUID: O3SlRRspmfjXvDJGa-tY5WnE-g68BVdt
X-Authority-Analysis: v=2.4 cv=NaFzRGD4 c=1 sm=1 tr=0 ts=6ada6f67 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=4RIeDs6z6I20CdcLo6MA:9 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: O3SlRRspmfjXvDJGa-tY5WnE-g68BVdt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 phishscore=0 priorityscore=1501 adultscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220080
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When writing the conversion, I tried to factorize some definitions
between linux-user and softmmu and variants of a target. Unfortunately,
as meson has (sadly) no support for local variables, this required to
use global variables.
As a consequence, those variables are also exposed between targets, and
this resulted in some entries being wrongly set (cc_feat_cflags or
gdb_feat_version, for instance, wrongly set on target not defining
them).

Being bitten by this while writing the two previous patches, I decided
it was time to clean this up and not rely on global variables.
This patch inlines required entries directly in test suite definition.

Change is correct since all keys modified here are checked during meson
configuration, so we can't forget a definition.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/aarch64/meson.build            | 46 ++++++++++--------------
 tests/tcg/aarch64/system/meson.build     | 16 ++++++---
 tests/tcg/aarch64_be/meson.build         |  1 -
 tests/tcg/alpha/meson.build              |  7 ++--
 tests/tcg/alpha/system/meson.build       |  4 +--
 tests/tcg/arm/meson.build                |  7 ++--
 tests/tcg/arm/system/meson.build         |  4 +--
 tests/tcg/hppa/meson.build               |  1 -
 tests/tcg/i386/meson.build               |  7 ++--
 tests/tcg/i386/system/meson.build        |  4 +--
 tests/tcg/loongarch64/meson.build        | 19 ++++------
 tests/tcg/loongarch64/system/meson.build | 10 ++++--
 tests/tcg/m68k/meson.build               |  1 -
 tests/tcg/mips/meson.build               |  1 -
 tests/tcg/mipsel/meson.build             |  2 --
 tests/tcg/or1k/meson.build               |  1 -
 tests/tcg/ppc64/meson.build              | 11 +++---
 tests/tcg/ppc64le/meson.build            |  5 ++-
 tests/tcg/riscv32/meson.build            |  3 --
 tests/tcg/riscv32/system/meson.build     |  4 +--
 tests/tcg/riscv64/meson.build            | 10 ++----
 tests/tcg/riscv64/system/meson.build     |  6 ++--
 tests/tcg/s390x/meson.build              | 21 ++++-------
 tests/tcg/s390x/system/meson.build       |  7 ++--
 tests/tcg/sh4/meson.build                |  1 -
 tests/tcg/x86_64/meson.build             | 10 ++----
 tests/tcg/x86_64/system/meson.build      |  6 ++--
 tests/tcg/xtensa/meson.build             |  6 ++--
 28 files changed, 89 insertions(+), 132 deletions(-)

diff --git a/tests/tcg/aarch64/meson.build b/tests/tcg/aarch64/meson.build
index 1cec335df04..52eb67ae6ac 100644
--- a/tests/tcg/aarch64/meson.build
+++ b/tests/tcg/aarch64/meson.build
@@ -1,26 +1,3 @@
-cc = 'aarch64-linux-gnu-gcc'
-cc_alt = ['aarch64-redhat-linux-gcc']
-cc_dockerfile = 'debian-all-test-cross'
-
-cc_feat_cflags = {
-  'aes': '-march=armv8-a+aes',
-  'sve': '-march=armv8.1-a+sve',
-  'sve2': '-march=armv8.1-a+sve2',
-  'v8.2': '-march=armv8.2-a',
-  'v8.3': '-march=armv8.3-a',
-  'v8.5': '-march=armv8.5-a',
-  'bti':  '-mbranch-protection=standard',
-  'mte':  '-march=armv8.5-a+memtag',
-  'sme':  '-Wa,-march=armv9-a+sme',
-  'fprcvt': '-march=armv9-a+fprcvt',
-}
-
-gdb_feat_version = {
-  'sme-tiles': '14.1',
-  'mte': '15.1',
-  'mte-baremetal': '16.0',
-}
-
 subdir('system')
 
 tests = []
@@ -196,13 +173,26 @@ tests += {
 if 'qemu-aarch64' in emulators
   tcg_tests += {
     'aarch64-linux-user': {
-      'cc': cc,
-      'cc_alt': cc_alt,
-      'cc_dockerfile': cc_dockerfile,
-      'cc_feat_cflags': cc_feat_cflags,
+      'cc': 'aarch64-linux-gnu-gcc',
+      'cc_alt': ['aarch64-redhat-linux-gcc'],
+      'cc_dockerfile': 'debian-all-test-cross',
+      'cc_feat_cflags': {
+        'aes': '-march=armv8-a+aes',
+        'sve': '-march=armv8.1-a+sve',
+        'sve2': '-march=armv8.1-a+sve2',
+        'v8.2': '-march=armv8.2-a',
+        'v8.3': '-march=armv8.3-a',
+        'v8.5': '-march=armv8.5-a',
+        'bti':  '-mbranch-protection=standard',
+        'mte':  '-march=armv8.5-a+memtag',
+        'sme':  '-Wa,-march=armv9-a+sme',
+      },
       'folder': 'aarch64',
       'gdb_arch': 'aarch64',
-      'gdb_feat_version': gdb_feat_version,
+      'gdb_feat_version': {
+        'sme-tiles': '14.1',
+        'mte': '15.1',
+      },
       'qemu': emulators['qemu-aarch64'],
       'tests': tests,
     }
diff --git a/tests/tcg/aarch64/system/meson.build b/tests/tcg/aarch64/system/meson.build
index 270d4d6c311..8710ebfdad3 100644
--- a/tests/tcg/aarch64/system/meson.build
+++ b/tests/tcg/aarch64/system/meson.build
@@ -108,13 +108,19 @@ tests += {
 if 'qemu-system-aarch64' in emulators
   tcg_tests += {
     'aarch64-softmmu': {
-      'cc': cc,
-      'cc_alt': cc_alt + ['aarch64-elf-gcc'],
-      'cc_dockerfile': cc_dockerfile,
-      'cc_feat_cflags': cc_feat_cflags,
+      'cc': 'aarch64-linux-gnu-gcc',
+      'cc_alt': ['aarch64-redhat-linux-gcc', 'aarch64-elf-gcc'],
+      'cc_dockerfile': 'debian-all-test-cross',
+      'cc_feat_cflags': {
+        'sve': '-march=armv8.1-a+sve',
+        'v8.3': '-march=armv8.3-a',
+        'mte':  '-march=armv8.5-a+memtag',
+      },
       'folder': 'aarch64/system',
       'gdb_arch': 'aarch64',
-      'gdb_feat_version': gdb_feat_version,
+      'gdb_feat_version': {
+        'mte-baremetal': '16.0',
+      },
       'qemu': emulators['qemu-system-aarch64'],
       'tests': tests,
     }
diff --git a/tests/tcg/aarch64_be/meson.build b/tests/tcg/aarch64_be/meson.build
index 509408de8e7..c1873cd5606 100644
--- a/tests/tcg/aarch64_be/meson.build
+++ b/tests/tcg/aarch64_be/meson.build
@@ -12,7 +12,6 @@ if 'qemu-aarch64_be' in emulators
       'cc': 'aarch64-linux-gnu-gcc',
       'cc_alt': ['aarch64-redhat-linux-gcc'],
       'cc_dockerfile': 'debian-all-test-cross',
-      'cc_feat_cflags': cc_feat_cflags,
       'folder': 'aarch64_be',
       'gdb_arch': 'aarch64_be',
       'qemu': emulators['qemu-aarch64_be'],
diff --git a/tests/tcg/alpha/meson.build b/tests/tcg/alpha/meson.build
index 30ea2a6978e..970b845ac21 100644
--- a/tests/tcg/alpha/meson.build
+++ b/tests/tcg/alpha/meson.build
@@ -1,6 +1,3 @@
-cc = 'alpha-linux-gnu-gcc'
-cc_dockerfile = 'debian-all-test-cross'
-
 subdir('system')
 
 tests = []
@@ -42,8 +39,8 @@ tests += {
 if 'qemu-alpha' in emulators
   tcg_tests += {
     'alpha-linux-user': {
-      'cc': cc,
-      'cc_dockerfile': cc_dockerfile,
+      'cc': 'alpha-linux-gnu-gcc',
+      'cc_dockerfile': 'debian-all-test-cross',
       'folder': 'alpha',
       'gdb_arch': 'alpha',
       'qemu': emulators['qemu-alpha'],
diff --git a/tests/tcg/alpha/system/meson.build b/tests/tcg/alpha/system/meson.build
index 5388e17a2f7..80a629a9385 100644
--- a/tests/tcg/alpha/system/meson.build
+++ b/tests/tcg/alpha/system/meson.build
@@ -35,8 +35,8 @@ endforeach
 if 'qemu-system-alpha' in emulators
   tcg_tests += {
     'alpha-softmmu': {
-      'cc': cc,
-      'cc_dockerfile': cc_dockerfile,
+      'cc': 'alpha-linux-gnu-gcc',
+      'cc_dockerfile': 'debian-all-test-cross',
       'folder': 'alpha/system',
       'gdb_arch': 'alpha',
       'qemu': emulators['qemu-system-alpha'],
diff --git a/tests/tcg/arm/meson.build b/tests/tcg/arm/meson.build
index fd82b5c7a63..6e498232f0d 100644
--- a/tests/tcg/arm/meson.build
+++ b/tests/tcg/arm/meson.build
@@ -1,6 +1,3 @@
-cc = 'arm-linux-gnueabihf-gcc'
-cc_dockerfile = 'debian-all-test-cross'
-
 subdir('system')
 
 tests = []
@@ -69,8 +66,8 @@ tests += {
 if 'qemu-arm' in emulators
   tcg_tests += {
     'arm-linux-user': {
-      'cc': cc,
-      'cc_dockerfile': cc_dockerfile,
+      'cc': 'arm-linux-gnueabihf-gcc',
+      'cc_dockerfile': 'debian-all-test-cross',
       'folder': 'arm',
       'gdb_arch': 'arm',
       'qemu': emulators['qemu-arm'],
diff --git a/tests/tcg/arm/system/meson.build b/tests/tcg/arm/system/meson.build
index 80c5461e620..c20818f0893 100644
--- a/tests/tcg/arm/system/meson.build
+++ b/tests/tcg/arm/system/meson.build
@@ -69,9 +69,9 @@ tests += {
 if 'qemu-system-arm' in emulators
   tcg_tests += {
     'arm-softmmu': {
-      'cc': cc,
+      'cc': 'arm-linux-gnueabihf-gcc',
       'cc_alt': ['arm-none-eabi-gcc'],
-      'cc_dockerfile': cc_dockerfile,
+      'cc_dockerfile': 'debian-all-test-cross',
       'folder': 'arm/system',
       'gdb_arch': 'arm',
       'qemu': emulators['qemu-system-arm'],
diff --git a/tests/tcg/hppa/meson.build b/tests/tcg/hppa/meson.build
index 01d4554d993..8c1813636c4 100644
--- a/tests/tcg/hppa/meson.build
+++ b/tests/tcg/hppa/meson.build
@@ -11,7 +11,6 @@ if 'qemu-hppa' in emulators
     'hppa-linux-user': {
       'cc': 'hppa-linux-gnu-gcc',
       'cc_dockerfile': 'debian-all-test-cross',
-      'cc_feat_cflags': cc_feat_cflags,
       'folder': 'hppa',
       'gdb_arch': 'hppa',
       'qemu': emulators['qemu-hppa'],
diff --git a/tests/tcg/i386/meson.build b/tests/tcg/i386/meson.build
index 84bd68067a5..e7c30958608 100644
--- a/tests/tcg/i386/meson.build
+++ b/tests/tcg/i386/meson.build
@@ -1,6 +1,3 @@
-cc = 'i686-linux-gnu-gcc'
-cc_dockerfile = 'debian-i686-cross'
-
 subdir('system')
 
 tests = []
@@ -47,8 +44,8 @@ tests += {
 if 'qemu-i386' in emulators
   tcg_tests += {
     'i386-linux-user': {
-      'cc': cc,
-      'cc_dockerfile': cc_dockerfile,
+      'cc': 'i686-linux-gnu-gcc',
+      'cc_dockerfile': 'debian-i686-cross',
       'folder': 'i386',
       'gdb_arch': 'i386',
       'qemu': emulators['qemu-i386'],
diff --git a/tests/tcg/i386/system/meson.build b/tests/tcg/i386/system/meson.build
index 91c6e887191..44e86a12cdd 100644
--- a/tests/tcg/i386/system/meson.build
+++ b/tests/tcg/i386/system/meson.build
@@ -41,9 +41,9 @@ tests += {
 if 'qemu-system-i386' in emulators
   tcg_tests += {
     'i386-softmmu': {
-      'cc': cc,
+      'cc': 'i686-linux-gnu-gcc',
       'cc_alt': ['i686-elf-gcc'],
-      'cc_dockerfile': cc_dockerfile,
+      'cc_dockerfile': 'debian-i686-cross',
       'folder': 'i386/system',
       'gdb_arch': 'i386',
       'qemu': emulators['qemu-system-i386'],
diff --git a/tests/tcg/loongarch64/meson.build b/tests/tcg/loongarch64/meson.build
index bff30cb49c8..152bb1d4edb 100644
--- a/tests/tcg/loongarch64/meson.build
+++ b/tests/tcg/loongarch64/meson.build
@@ -1,12 +1,3 @@
-cc = 'loongarch64-unknown-linux-gnu-gcc'
-cc_dockerfile = 'debian-loongarch-cross'
-
-gdb_feat_version = {
-  # previous version report "Architecture rejected target-supplied
-  # description", exposing a mismatch between our gdbstub and gdb.
-  'loongarch64': '16.1',
-}
-
 subdir('system')
 
 tests = []
@@ -32,11 +23,15 @@ tests += {
 if 'qemu-loongarch64' in emulators
   tcg_tests += {
     'loongarch64-linux-user': {
-      'cc': cc,
-      'cc_dockerfile': cc_dockerfile,
+      'cc': 'loongarch64-unknown-linux-gnu-gcc',
+      'cc_dockerfile': 'debian-loongarch-cross',
       'folder': 'loongarch64',
       'gdb_arch': 'loongarch64',
-      'gdb_feat_version': gdb_feat_version,
+      'gdb_feat_version': {
+        # previous version report "Architecture rejected target-supplied
+        # description", exposing a mismatch between our gdbstub and gdb.
+        'loongarch64': '16.1',
+      },
       'qemu': emulators['qemu-loongarch64'],
       'tests': tests,
     }
diff --git a/tests/tcg/loongarch64/system/meson.build b/tests/tcg/loongarch64/system/meson.build
index 93e76b696ed..37b72bafc4d 100644
--- a/tests/tcg/loongarch64/system/meson.build
+++ b/tests/tcg/loongarch64/system/meson.build
@@ -39,11 +39,15 @@ endforeach
 if 'qemu-system-loongarch64' in emulators
   tcg_tests += {
     'loongarch64-softmmu': {
-      'cc': cc,
-      'cc_dockerfile': cc_dockerfile,
+      'cc': 'loongarch64-unknown-linux-gnu-gcc',
+      'cc_dockerfile': 'debian-loongarch-cross',
       'folder': 'loongarch64/system',
       'gdb_arch': 'loongarch64',
-      'gdb_feat_version': gdb_feat_version,
+      'gdb_feat_version': {
+        # previous version report "Architecture rejected target-supplied
+        # description", exposing a mismatch between our gdbstub and gdb.
+        'loongarch64': '16.1',
+      },
       'qemu': emulators['qemu-system-loongarch64'],
       'tests': tests,
     }
diff --git a/tests/tcg/m68k/meson.build b/tests/tcg/m68k/meson.build
index 4b73d7fc57d..b34cb032446 100644
--- a/tests/tcg/m68k/meson.build
+++ b/tests/tcg/m68k/meson.build
@@ -12,7 +12,6 @@ if 'qemu-m68k' in emulators
     'm68k-linux-user': {
       'cc': 'm68k-linux-gnu-gcc',
       'cc_dockerfile': 'debian-all-test-cross',
-      'cc_feat_cflags': cc_feat_cflags,
       'folder': 'm68k',
       'gdb_arch': 'm68k',
       'qemu': emulators['qemu-m68k'],
diff --git a/tests/tcg/mips/meson.build b/tests/tcg/mips/meson.build
index 2164f143ea8..88d598a4f89 100644
--- a/tests/tcg/mips/meson.build
+++ b/tests/tcg/mips/meson.build
@@ -14,7 +14,6 @@ if 'qemu-mips' in emulators
     'mips-linux-user': {
       'cc': 'mips-linux-gnu-gcc',
       'cc_dockerfile': 'debian-all-test-cross',
-      'cc_feat_cflags': cc_feat_cflags,
       'folder': 'mips',
       'gdb_arch': 'mips',
       'qemu': emulators['qemu-mips'],
diff --git a/tests/tcg/mipsel/meson.build b/tests/tcg/mipsel/meson.build
index 3ac47117480..c9e869b000f 100644
--- a/tests/tcg/mipsel/meson.build
+++ b/tests/tcg/mipsel/meson.build
@@ -181,7 +181,6 @@ if 'qemu-mipsel' in emulators
     'mipsel-linux-user': {
       'cc': 'mipsel-linux-gnu-gcc',
       'cc_dockerfile': 'debian-all-test-cross',
-      'cc_feat_cflags': cc_feat_cflags,
       'folder': 'mipsel',
       'gdb_arch': 'mipsel',
       'qemu': emulators['qemu-mipsel'],
@@ -207,7 +206,6 @@ if 'qemu-mipsel' in emulators
     'mips32r5el-linux-user': {
       'cc': 'mips32r5el-buildroot-linux-gnu-gcc',
       'cc_dockerfile': 'debian-all-test-cross',
-      'cc_feat_cflags': cc_feat_cflags,
       'folder': 'mipsel',
       'gdb_arch': 'mipsel',
       'qemu': emulators['qemu-mipsel'],
diff --git a/tests/tcg/or1k/meson.build b/tests/tcg/or1k/meson.build
index c89bb372b47..f1124609b88 100644
--- a/tests/tcg/or1k/meson.build
+++ b/tests/tcg/or1k/meson.build
@@ -61,7 +61,6 @@ if 'qemu-or1k' in emulators
     'or1k-linux-user': {
       'cc': 'or1k-none-linux-musl-gcc',
       'cc_dockerfile': 'debian-all-test-cross',
-      'cc_feat_cflags': cc_feat_cflags,
       'folder': 'or1k',
       'gdb_arch': 'or1k',
       'qemu': emulators['qemu-or1k'],
diff --git a/tests/tcg/ppc64/meson.build b/tests/tcg/ppc64/meson.build
index 8cca4d65a4c..7713d743384 100644
--- a/tests/tcg/ppc64/meson.build
+++ b/tests/tcg/ppc64/meson.build
@@ -1,8 +1,3 @@
-cc_feat_cflags = {
-  'power8': '-mcpu=power8',
-  'power10': '-mcpu=power10',
-}
-
 tests = []
 
 # Multi arch tests
@@ -44,10 +39,12 @@ if 'qemu-ppc64' in emulators
     'ppc64-linux-user': {
       'cc': 'powerpc64-linux-gnu-gcc',
       'cc_dockerfile': 'debian-all-test-cross',
-      'cc_feat_cflags': cc_feat_cflags,
+      'cc_feat_cflags': {
+        'power8': '-mcpu=power8',
+        'power10': '-mcpu=power10',
+      },
       'folder': 'ppc64',
       'gdb_arch': 'ppc64',
-      'gdb_feat_version': gdb_feat_version,
       'qemu': emulators['qemu-ppc64'],
       'tests': tests,
     }
diff --git a/tests/tcg/ppc64le/meson.build b/tests/tcg/ppc64le/meson.build
index 9f386287e7a..b474bf4eee5 100644
--- a/tests/tcg/ppc64le/meson.build
+++ b/tests/tcg/ppc64le/meson.build
@@ -4,7 +4,10 @@ if 'qemu-ppc64le' in emulators
       'cc': 'powerpc64le-linux-gnu-gcc',
       'cc_alt': ['ppc64le-redhat-linux-gcc'],
       'cc_dockerfile': 'debian-all-test-cross',
-      'cc_feat_cflags': cc_feat_cflags,
+      'cc_feat_cflags': {
+        'power8': '-mcpu=power8',
+        'power10': '-mcpu=power10',
+      },
       'folder': 'ppc64le',
       'gdb_arch': 'ppc64le',
       'qemu': emulators['qemu-ppc64le'],
diff --git a/tests/tcg/riscv32/meson.build b/tests/tcg/riscv32/meson.build
index 862f1349c2b..8af80d5e66e 100644
--- a/tests/tcg/riscv32/meson.build
+++ b/tests/tcg/riscv32/meson.build
@@ -1,6 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-cc = 'riscv64-linux-gnu-gcc'
-cc_dockerfile = 'debian-all-test-cross'
-
 subdir('system')
diff --git a/tests/tcg/riscv32/system/meson.build b/tests/tcg/riscv32/system/meson.build
index f8e55ad3d4e..117ae6fbce4 100644
--- a/tests/tcg/riscv32/system/meson.build
+++ b/tests/tcg/riscv32/system/meson.build
@@ -25,8 +25,8 @@ tests += {
 if 'qemu-system-riscv32' in emulators
   tcg_tests += {
     'riscv32-softmmu': {
-      'cc': cc,
-      'cc_dockerfile': cc_dockerfile,
+      'cc': 'riscv64-linux-gnu-gcc',
+      'cc_dockerfile': 'debian-all-test-cross',
       'folder': 'riscv32',
       'gdb_arch': 'riscv32',
       'qemu': emulators['qemu-system-riscv32'],
diff --git a/tests/tcg/riscv64/meson.build b/tests/tcg/riscv64/meson.build
index 91c840b0058..0766f4e3ff0 100644
--- a/tests/tcg/riscv64/meson.build
+++ b/tests/tcg/riscv64/meson.build
@@ -1,7 +1,3 @@
-cc = 'riscv64-linux-gnu-gcc'
-cc_alt = ['riscv64-redhat-linux-gnu-gcc']
-cc_dockerfile = 'debian-all-test-cross'
-
 subdir('system')
 
 tests = []
@@ -26,9 +22,9 @@ tests += {
 if 'qemu-riscv64' in emulators
   tcg_tests += {
     'riscv64-linux-user': {
-      'cc': cc,
-      'cc_alt': cc_alt,
-      'cc_dockerfile': cc_dockerfile,
+      'cc': 'riscv64-linux-gnu-gcc',
+      'cc_alt': ['riscv64-redhat-linux-gnu-gcc'],
+      'cc_dockerfile': 'debian-all-test-cross',
       'folder': 'riscv64',
       'gdb_arch': 'riscv64',
       'qemu': emulators['qemu-riscv64'],
diff --git a/tests/tcg/riscv64/system/meson.build b/tests/tcg/riscv64/system/meson.build
index 3e1c9703820..728526dc7a3 100644
--- a/tests/tcg/riscv64/system/meson.build
+++ b/tests/tcg/riscv64/system/meson.build
@@ -80,9 +80,9 @@ tests += {
 if 'qemu-system-riscv64' in emulators
   tcg_tests += {
     'riscv64-softmmu': {
-      'cc': cc,
-      'cc_alt': cc_alt + ['riscv64-elf-gcc'],
-      'cc_dockerfile': cc_dockerfile,
+      'cc': 'riscv64-linux-gnu-gcc',
+      'cc_alt': ['riscv64-redhat-linux-gnu-gcc', 'riscv64-elf-gcc'],
+      'cc_dockerfile': 'debian-all-test-cross',
       'folder': 'riscv64',
       'gdb_arch': 'riscv64',
       'qemu': emulators['qemu-system-riscv64'],
diff --git a/tests/tcg/s390x/meson.build b/tests/tcg/s390x/meson.build
index f2328d9e5cf..15a63c7dea4 100644
--- a/tests/tcg/s390x/meson.build
+++ b/tests/tcg/s390x/meson.build
@@ -1,12 +1,3 @@
-cc = 's390x-linux-gnu-gcc'
-cc_alt = ['s390x-redhat-linux-gcc']
-cc_dockerfile = 'debian-all-test-cross'
-
-cc_feat_cflags = {
-  'z14': '-march=z14',
-  'z15': '-march=z15',
-}
-
 tests_s390x_pgm = [
   'br-odd.S',
   'cgrl-unaligned.S',
@@ -140,13 +131,15 @@ tests += {
 if 'qemu-s390x' in emulators
   tcg_tests += {
     's390x-linux-user': {
-      'cc': cc,
-      'cc_alt': cc_alt,
-      'cc_dockerfile': cc_dockerfile,
-      'cc_feat_cflags': cc_feat_cflags,
+      'cc': 's390x-linux-gnu-gcc',
+      'cc_alt': ['s390x-redhat-linux-gcc'],
+      'cc_dockerfile': 'debian-all-test-cross',
+      'cc_feat_cflags': {
+        'z14': '-march=z14',
+        'z15': '-march=z15',
+      },
       'folder': 's390x',
       'gdb_arch': 's390x',
-      'gdb_feat_version': gdb_feat_version,
       'qemu': emulators['qemu-s390x'],
       'tests': tests,
     }
diff --git a/tests/tcg/s390x/system/meson.build b/tests/tcg/s390x/system/meson.build
index 359d124cc78..d45975d8044 100644
--- a/tests/tcg/s390x/system/meson.build
+++ b/tests/tcg/s390x/system/meson.build
@@ -81,10 +81,9 @@ endforeach
 if 'qemu-system-s390x' in emulators
   tcg_tests += {
     's390x-softmmu': {
-      'cc': cc,
-      'cc_alt': cc_alt,
-      'cc_dockerfile': cc_dockerfile,
-      'cc_feat_cflags': cc_feat_cflags,
+      'cc': 's390x-linux-gnu-gcc',
+      'cc_alt': ['s390x-redhat-linux-gcc'],
+      'cc_dockerfile': 'debian-all-test-cross',
       'folder': 's390x',
       'gdb_arch': 's390x',
       'qemu': emulators['qemu-system-s390x'],
diff --git a/tests/tcg/sh4/meson.build b/tests/tcg/sh4/meson.build
index 12b24fffc77..1e96c78afb1 100644
--- a/tests/tcg/sh4/meson.build
+++ b/tests/tcg/sh4/meson.build
@@ -14,7 +14,6 @@ if 'qemu-sh4' in emulators
     'sh4-linux-user': {
       'cc': 'sh4-linux-gnu-gcc',
       'cc_dockerfile': 'debian-all-test-cross',
-      'cc_feat_cflags': cc_feat_cflags,
       'folder': 'sh4',
       'gdb_arch': 'sh4',
       'qemu': emulators['qemu-sh4'],
diff --git a/tests/tcg/x86_64/meson.build b/tests/tcg/x86_64/meson.build
index 95c7ee676eb..ad4d1f558a7 100644
--- a/tests/tcg/x86_64/meson.build
+++ b/tests/tcg/x86_64/meson.build
@@ -1,7 +1,3 @@
-cc = 'x86_64-linux-gnu-gcc'
-cc_alt = ['x86_64-redhat-linux-gcc']
-cc_dockerfile = 'debian-amd64-cross'
-
 subdir('system')
 
 tests = []
@@ -73,9 +69,9 @@ tests += {
 if 'qemu-x86_64' in emulators
   tcg_tests += {
     'x86_64-linux-user': {
-      'cc': cc,
-      'cc_alt': cc_alt,
-      'cc_dockerfile': cc_dockerfile,
+      'cc': 'x86_64-linux-gnu-gcc',
+      'cc_alt': ['x86_64-redhat-linux-gcc'],
+      'cc_dockerfile': 'debian-amd64-cross',
       'folder': 'x86_64',
       'gdb_arch': 'x86_64',
       'qemu': emulators['qemu-x86_64'],
diff --git a/tests/tcg/x86_64/system/meson.build b/tests/tcg/x86_64/system/meson.build
index 7d61257b771..46a35d227d0 100644
--- a/tests/tcg/x86_64/system/meson.build
+++ b/tests/tcg/x86_64/system/meson.build
@@ -51,9 +51,9 @@ tests += {
 if 'qemu-system-x86_64' in emulators
   tcg_tests += {
     'x86_64-softmmu': {
-      'cc': cc,
-      'cc_alt': cc_alt + ['x86_64-elf-gcc'],
-      'cc_dockerfile': cc_dockerfile,
+      'cc': 'x86_64-linux-gnu-gcc',
+      'cc_alt': ['x86_64-redhat-linux-gcc', 'x86_64-elf-gcc'],
+      'cc_dockerfile': 'debian-amd64-cross',
       'folder': 'x86_64/system',
       'gdb_arch': 'x86_64',
       'qemu': emulators['qemu-system-x86_64'],
diff --git a/tests/tcg/xtensa/meson.build b/tests/tcg/xtensa/meson.build
index 5ff9c6cd548..627fb14a7f5 100644
--- a/tests/tcg/xtensa/meson.build
+++ b/tests/tcg/xtensa/meson.build
@@ -78,13 +78,11 @@ foreach core: cores
   tests_per_core += {core: tests}
 endforeach
 
-cc_dockerfile = 'debian-xtensa-cross'
-
 if 'qemu-system-xtensa' in emulators
   tcg_tests += {
     'xtensa-softmmu': {
       'cc': 'xtensa-dc232b-elf-gcc',
-      'cc_dockerfile': cc_dockerfile,
+      'cc_dockerfile': 'debian-xtensa-cross',
       'folder': 'xtensa',
       'gdb_arch': 'xtensa',
       'qemu': emulators['qemu-system-xtensa'],
@@ -97,7 +95,7 @@ if 'qemu-system-xtensaeb' in emulators
   tcg_tests += {
     'xtensaeb-softmmu': {
       'cc': 'xtensa-test_kc705_be-elf-gcc',
-      'cc_dockerfile': cc_dockerfile,
+      'cc_dockerfile': 'debian-xtensa-cross',
       'folder': 'xtensa',
       'gdb_arch': 'xtensaeb',
       'qemu': emulators['qemu-system-xtensaeb'],
-- 
2.47.3


