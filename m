Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 229D8C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:50:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJ6d-0001e9-GZ; Fri, 10 Jul 2026 17:49:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ6a-0001Iz-EG
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:49:56 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ6Y-0005CE-BM
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:49:56 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AK3F0f1621234
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:49:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=M0tYYA9WxU4
 vkaROsOsWaCy5vVw8jRz8XNI57Fc4xmQ=; b=gzFYoc+mXD93FCba1zlPCI6LCUZ
 gmgKatTYmtDX+2DAun9ACCDYZC4n7cylu95L3TNPPMtJ3kyxGQJQeCZ63A+2UVfc
 +cHv+8n1zKj84oQE5C/I8INiD8FAr+REju9+3Tk+Tg7r40evPYW048y9JNanPSs/
 UYwVqBZTXQwc6PZyS9z7OZ4A+iNze2ok3DJd+ilU2xucq7Pp5Oj2EwPkardmUs59
 8HghvEeh4RyftdaBNpPHXzzx7sa6ty2eiSf3temNb2zjrvVbOyPFnrujoWlkxZVj
 GlMADEmT79aXogIY94VR273IqqdFk05Jb/SECTv1AppedMbaOEnWSrWOeJg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb4rm8v89-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:49:42 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-ca860baea9fso348068a12.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783720182; x=1784324982; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=M0tYYA9WxU4vkaROsOsWaCy5vVw8jRz8XNI57Fc4xmQ=;
 b=P/M6fx9XopkkO3p427xrtdg2gss403U+rxImrjC0AFbx4TWv/G5b7EVC6wfTJSrLZC
 q54k9w4W2q5FVCXYII5WK4ksw1Lg+3Ul80hOTGi18iKWlpeHXCNqwAO4yO8Jvj5Uv3uz
 473nGsarpSlj3v3xqjWRIWM4VA7/YWrlUKoJvjxOJVyUboR4p8uq1Wa18WDsTmmYPow8
 lly+DEooZO8pEUQ5K//TsF71zuAN/JYQTnHmgNpt3WYfZiFa7VteKYuuyAwTmorcNQsz
 0xc56Vd7D8Ef88MKNzjDHx4FMafeG/eVh6ythrQrL7k4U3IunXy03TtVSSdcR8zBDRK6
 cxwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783720182; x=1784324982;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=M0tYYA9WxU4vkaROsOsWaCy5vVw8jRz8XNI57Fc4xmQ=;
 b=HsDZgo6V6fYgxdstZRYo+iVSPUj0j72Wo7O/fO4Ok/E8L2O8O01/eHAU/zTQ8qyIeY
 PO0IZST1aoqjomkxnCgiDsYeB6NcdJGFQetBHFWK2bYrrg3QZfKjlWNyrgBMoM1MBWT4
 Kjt2kEbWT/M2WGjD/0OLbYJuiildM4ah2jVWZKgvBS+2QkoE6rYbYnZ345PeKKqalQaY
 BhLZSs2CB1/S6nj4kyUCK+KE7R4ndQdGTXPar5fyKsXh+6SxpHQDWVOT8Fr0SIVjXeI1
 iVtFFh50dv4JNHqeQy8dbG4WJDZ2z1D+xJO1WjA55F358HUDJo/G+pnF7hiIDVDnCzsn
 RrDQ==
X-Gm-Message-State: AOJu0YyD8wPN5TvFNTSbYKk/ozy4fx71JWO7ID3wtB0FjucI9MYC5tBF
 I2XMuOrUmXXpUTaM15u+mm09guOtoAOmEUp6tB9COafQ3lmfvMGY9XSwBosTksg9MgxmumJpvE+
 yZLWf611EjrTO8OUZ4W+Olk3E1qJ/jEhZD/iAHTXE0Zpd6Cy6Ow1tzm0W9TRwVftVuQ==
X-Gm-Gg: AfdE7clVWo8PjAnC6DuDq7Gj4+UR4w+V4aerIg6VE42XSKUJYExKZXDw9ZEMqrkKwif
 E28WSi7i2BlTO5IAvwVkVkumYMKBug5ZD6fEG68ncbYrbg8ILULKOLSDPkSo/bToLt+45wjg+SF
 eeG7/cDF5KCsEY731p6qjCVWQH4XLtdg5zrHgC56fvCOQo8fw5YVzeZfH+soAl+F5tWE+0hg/mp
 d4BZF7Mzy3LRCb45fFvU/1DLPWOwmu++ZNLhgd6hIl+yQ/jL7DDrtFKhyf58N+hR3rTlqAGyIVJ
 nDlY+hjkUNJ0lE5aRwHdgQQcPu0AfMVLhA2Kf9VwLfq8mEsVAI3YyMcbdTKoAe6JLIrBH3xdE/V
 e+WEDAMmRdFmxk9gp0JmcwM+16/m9zP0SxZQ/UekGfFBAG1+Byu8YpPpsWz1Meb4WXAvJn4qG3c
 e2XjAe9g==
X-Received: by 2002:a05:6a20:258e:b0:3b4:dd7:6304 with SMTP id
 adf61e73a8af0-3c110009c4fmr786130637.8.1783720182121; 
 Fri, 10 Jul 2026 14:49:42 -0700 (PDT)
X-Received: by 2002:a05:6a20:258e:b0:3b4:dd7:6304 with SMTP id
 adf61e73a8af0-3c110009c4fmr786104637.8.1783720181730; 
 Fri, 10 Jul 2026 14:49:41 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311838c9235sm39886355eec.21.2026.07.10.14.49.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:49:41 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>, Helge Deller <deller@gmx.de>
Subject: [PATCH v5 78/98] tests/tcg/riscv64: user tests
Date: Fri, 10 Jul 2026 14:43:22 -0700
Message-ID: <20260710214343.2065491-79-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: mUBytycPG9E5iKqODlhO-PHMLhq-JiPI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIxOSBTYWx0ZWRfXw7ZLYs7i+dyO
 qNcjEg0pof9qVxKGiFbmCvm9+fpT8CC1gDD0ufC97cFJ59oTfDytQ27iSoM9t/YVzKMBm3rbZs0
 qyXTH/MBCjYGuuw0kF0eQQG+4EB4WjAjbRHVyTW0wPY2UhnxJ6TXpCqTPRFV1ZoBrBvun6sctGq
 Ab7yx39b9eHwkOQG7r2mnHAEZtle3YqiGLwyZKE60UuAimgfURVcAd4iRY1wb/1zzIi0HZhqFMU
 CaiCJxD4mT5y4ejKShTMcGLhUIZ60vpQTwMmfGZdZeDVpaJ8V+3RychcnCwj4WAc96E9DHd+lf7
 eXcM2x8j23bwLf4JvDeKoOjjn05bFVSNsQEQ5xFt89OJTmPONQwdyEWVYDBf3xt9bI5bPrkfp/k
 IVLUzlSHPo70O2zIyN7jG20RlzFM6fRycRFkIe4Gb1kSTkps/AbcpWTRBBPznyqSbYpcJ39SYzw
 OOqqqYn7sqwjIWakxxg==
X-Authority-Analysis: v=2.4 cv=JIYLdcKb c=1 sm=1 tr=0 ts=6a5168f6 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=1oZykkQblgpw-AWK45YA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: mUBytycPG9E5iKqODlhO-PHMLhq-JiPI
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIxOSBTYWx0ZWRfX6IXdx613c8Hg
 aDWo4J5MJ4ZqoaAHiqt/py7zKSB7QunK1pxRupYq8RtK3S5Sd5iJZOf0BIZy55eHc7WPpjvSSHf
 BVN/zygve6wqnRUONpb+QuOzF2BrLWc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 impostorscore=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100219
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build             |  1 +
 tests/tcg/riscv64/Makefile.target | 20 -----------------
 tests/tcg/riscv64/meson.build     | 36 +++++++++++++++++++++++++++++++
 3 files changed, 37 insertions(+), 20 deletions(-)
 delete mode 100644 tests/tcg/riscv64/Makefile.target
 create mode 100644 tests/tcg/riscv64/meson.build

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 36f597a2447..d2501e6a43e 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -148,6 +148,7 @@ subdir('mips64el')
 subdir('or1k')
 subdir('ppc64')
 subdir('ppc64le')
+subdir('riscv64')
 
 image_targets = {}
 exe_targets = []
diff --git a/tests/tcg/riscv64/Makefile.target b/tests/tcg/riscv64/Makefile.target
deleted file mode 100644
index 4da5b9a3b32..00000000000
--- a/tests/tcg/riscv64/Makefile.target
+++ /dev/null
@@ -1,20 +0,0 @@
-# -*- Mode: makefile -*-
-# RISC-V specific tweaks
-
-VPATH += $(SRC_PATH)/tests/tcg/riscv64
-TESTS += test-div
-TESTS += noexec
-
-# Disable compressed instructions for test-noc
-TESTS += test-noc
-test-noc: LDFLAGS = -nostdlib -static
-run-test-noc: QEMU_OPTS += -cpu rv64,c=false
-
-TESTS += test-aes
-run-test-aes: QEMU_OPTS += -cpu rv64,zk=on
-
-# Test for fcvtmod
-TESTS += test-fcvtmod
-test-fcvtmod: CFLAGS += -march=rv64imafdc
-test-fcvtmod: LDFLAGS += -static
-run-test-fcvtmod: QEMU_OPTS += -cpu rv64,d=true,zfa=true
diff --git a/tests/tcg/riscv64/meson.build b/tests/tcg/riscv64/meson.build
new file mode 100644
index 00000000000..b5f574c1377
--- /dev/null
+++ b/tests/tcg/riscv64/meson.build
@@ -0,0 +1,36 @@
+cc = 'riscv64-linux-gnu-gcc'
+cc_dockerfile = 'debian-all-test-cross'
+cc_docker_host_arch = ['aarch64', 'x86_64']
+
+tests = []
+
+# Multi arch tests
+tests += tcg_tests['multiarch-linux-user']['tests']
+
+tests += {
+  'noexec.c': {},
+  'test-aes.c': {'qemu_args': ['-cpu', 'rv64,zk=on']},
+  'test-div.c': {},
+  'test-fcvtmod.c': {
+    'cflags': ['-march=rv64imafdc'],
+    'qemu_args': ['-cpu', 'rv64,d=true,zfa=true'],
+  },
+  'test-noc.S': {
+    'cflags': ['-nostdlib'],
+    'qemu_args': ['-cpu', 'rv64,c=false'],
+  },
+}
+
+if 'qemu-riscv64' in emulators
+  tcg_tests += {
+    'riscv64-linux-user': {
+      'cc': cc,
+      'cc_dockerfile': cc_dockerfile,
+      'cc_docker_host_arch': cc_docker_host_arch,
+      'folder': 'riscv64',
+      'gdb_arch': 'riscv64',
+      'qemu': emulators['qemu-riscv64'],
+      'tests': tests,
+    }
+  }
+endif
-- 
2.47.3


