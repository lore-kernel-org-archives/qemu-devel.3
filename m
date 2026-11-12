Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DC3606A327
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 18:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GPNT5+vN;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TSLaR56V
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRZEh-0000cB-BO; Thu, 12 Nov 2026 13:09:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xRZEf-0000bg-Mx
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 13:09:21 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xRZEd-0003cC-Pq
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 13:09:21 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ACGRS7Z1768204
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 18:09:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7BCKV5IVDk7vsjlvCYKKr9cyCqjoU/iBPzkhqVikM4I=; b=GPNT5+vNhlJvZ3wn
 oBgQpJIVRHozNppK2w0kD9KL4ytPU0hEEysu1FALFwqQqbP00t2CUqBJYGQY62ZJ
 GkncJ0LuslZQ8uxTc+tThhfikYzukv0lctPk7wVaSkU8/2angbq4ifhhi5EqJ1j7
 bzIGrvzOQAMV2qYzTt2TLs0azVLXAUvv+tGPRORfD1bAt3d+SnteNcQ/R/q2w8TS
 8fUMBOrWqOoUfXSjykh7keTt6wPUm9K1DdNGiqnRmN7/HgM1urpdaHeT3w3G7TCs
 MPJwRyHAmpUhTGi2PnrlMBKfT59Dz/Cq/EI4dEJ5IEwoHJMTmeO2gSPYtjFcs9+i
 Fd7a7w==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwh0agdy2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 18:09:18 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-99077a0be0bso59025241.2
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 10:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794506958; x=1795111758; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7BCKV5IVDk7vsjlvCYKKr9cyCqjoU/iBPzkhqVikM4I=;
 b=TSLaR56VVsAc/6UFDTRQcIj0MY+W31Vj33nS1r2/kxRoYPcBLoRVB/oUpRYXnyP9+R
 YdKC5hXbN343NKFefubtfl/kntFl2PshmVzVP1NvCcAEYMxvG2FAr/asA1pa8hEc7d0E
 RiSQw28Mvip5LXUFi43N60tvaSC/e72DNNdgGfcm1ZA71fEEWNQwW7mC0XYkJLy5zNND
 BWbB/VuD5ca03WYD4RN/ghW4lOMyTlDmx6JQiWZU4Z5xJqu8O/rUGnzwMEQu5h9Wdz3g
 SpMKtJ6BebH1xzJtu4dniFOJaKOYLH22n2O6hUmPAUnNC2HXkHVg6YbD8dIyRKO+z3W8
 73mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794506958; x=1795111758;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7BCKV5IVDk7vsjlvCYKKr9cyCqjoU/iBPzkhqVikM4I=;
 b=oxZKniT2y2xhBXhisSpnnZ+G8uJgpBpvhVwm+P+Lws535jG+ru3wfh687C1c1s+vHZ
 EOFclY8OB6/lNByZaMsV6Se1ZMOPnD4xI42gFqwyS4mI2rlUgUmyleeiWU/D4D+JasOr
 1Sd4l6KfalKbJjYFuFLJV1pwqLLYvQ+O+mKyr+gD8XW9MVC6Wb8g1W8HvmjYDn28HV9R
 /kdiUuXgm9DKHNXiKGDRj8BVE9ROSAVc7EG7ZyYI/rqO1Oyy82CnFC8X1xcfVVIJDHkC
 iVXeq2PQSU4CmTYYeSUZPGSS9EEKxW93RioRY99OS/rY29t/YQGFlAZgr2RcPuXjSd0z
 hypA==
X-Gm-Message-State: APuU4Z9/ftH+gvGgy3gnB3i+YstnjLGnOkdWu0TMsp4Y9aXr8qRVoODo
 GcGO5j21HHk3xaD6t0bkHcNMQYj9S3LQuklJdfAitDY7CzPRVg6btoQ95O1h4MGS+jx2waMpCgt
 wWkulCcjbaO0hhiy1JL0k2rwWZlXdvxa96yzxZC2YE1Yox2PrZu/jrRNc2Iw/zuJjcnI2
X-Gm-Gg: AYBFou1r9U3iK02IZUYNZQQI+LQghKyYoDszZakm1BPsnrMQ9IV8s1zUXgi1byX+ejt
 bvgznQRBPVV2GxinUVy/K4cfKotAHOGgV+9ppyaZ+cmj7149laLtLAjHKRTnOZLoMIMvfSK+nJd
 s+nzI/zx1g3+MeXA8lMH2eYCyuI6gBJG/H7PYHG9wO+t5Zsc50K/KBXuyV9L4WANFnXn8rXESVs
 4IekwGSB/jv3MAWuHxgjG9yQB2IJFbTk0uWEn0Dy693NK4gSKV8WacmYqxP9+psSbvnPx9DA09J
 QVwUIZoPxoVIOaCN7lwfg2E7ausuUNlt868mdcamRlHHCeUveeMY3Q+z3xLYrQHrJNELnMB8jYo
 DIzbo6FeIC8DxyRSv/LqDoYfzBDtfC3GaRrEhEz5rX3M6q8lz1dxqFJyZc867CnmYH9KEPm2Isn
 p6M7xPYqvWZtpmxQ==
X-Received: by 2002:a05:6102:f10:b0:7cc:ccb:ce5a with SMTP id
 ada2fe7eead31-7d505805529mr2476338137.28.1794506957772; 
 Thu, 12 Nov 2026 10:09:17 -0800 (PST)
X-Received: by 2002:a05:6102:f10:b0:7cc:ccb:ce5a with SMTP id
 ada2fe7eead31-7d505805529mr2476319137.28.1794506957122; 
 Thu, 12 Nov 2026 10:09:17 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb4e2adf53sm85347265e9.15.2026.11.12.10.09.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Nov 2026 10:09:16 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 devel@lists.libvirt.org, Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org
Subject: [PATCH-for-12.0 v2 02/12] tests/tcg/arm: Add BE8 and BE32 hello tests
Date: Thu, 12 Nov 2026 19:08:48 +0100
Message-ID: <20261112180859.85380-3-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261112180859.85380-1-philmd@oss.qualcomm.com>
References: <20261112180859.85380-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA3MiBTYWx0ZWRfX/n3S3zw4G6s2
 K7pVXiXYT9iIOgfuxzEp+XTKpaqWhJw/vzjRbTzv9xok50mpA0nPMlm3p3xEGgZcINWr0UlaU0o
 8ATHgFvuOvJh5ixMw/JyL5pbBGJ3V68=
X-Proofpoint-GUID: lBU_TSpiRwmhtNbNCwPtFczpHwGLDveF
X-Authority-Analysis: v=2.4 cv=N+e8hG9B c=1 sm=1 tr=0 ts=6af600ce cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=GDvUlClSzrHbYYPi8DYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA3MiBTYWx0ZWRfX2HQCY7MpvMMM
 z9et8ztQ+VzbZP3pUK0yEFmPgp0D5a/lpm1zWzw3Y9cnMnfNkaOm56CIW9nyLJMsfGm8/mVleSH
 VODiFT+xrLvIpRHAotyy2Ua6SFSvGr7JA7grDtO+qxFLnyilaJcBb4yNyIZpDsd1DRQ7i4Y1jqu
 788E7QW0OTSvLalVHg8LzNpnJ3G0BsyeF0L8+XZK/ay/PWbVf5qkGX82JAesxaRY8pJMQSnghF5
 d/qhAg428Kchbd2mO27Xk6FSLobJ7s6oBJHm8qS6QAlSOa/C5PAFcll+M0unWo5JBsNUIvgBbF9
 UZWnULwreZUImcpwVhZuhbJ5ypfsyakTyZ8Q3Q/c/g/eyGWCp5kZIGKkZLSvZTjeZdDJeiZqF17
 it1ISMcq2xiboXhHKuMUGPgfADNGVs5C2oJWEj4v8aLo7t8JRDTNpCPWNdB3JIxpA6LMPx+qAbr
 C1S3wObBKdVJly3gc5A==
X-Proofpoint-ORIG-GUID: lBU_TSpiRwmhtNbNCwPtFczpHwGLDveF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 malwarescore=0 bulkscore=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120072
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

arm-linux-user had no big-endian test coverage. Build the
non-libc hello world with -mbig-endian (BE8 by default) and
again with -mbe32 for legacy BE32 code/data ordering. The
volatile length forces a data load, checking the CPU data
byte order. Plumb both tests with the meson machinery.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 tests/tcg/arm/hello-arm-be.c   | 34 ++++++++++++++++++++++++++++++++++
 tests/tcg/arm/hello-arm-be32.c |  4 ++++
 tests/tcg/arm/hello-arm.ref    |  1 +
 tests/tcg/arm/meson.build      | 11 +++++++++++
 4 files changed, 50 insertions(+)
 create mode 100644 tests/tcg/arm/hello-arm-be.c
 create mode 100644 tests/tcg/arm/hello-arm-be32.c
 create mode 100644 tests/tcg/arm/hello-arm.ref

diff --git a/tests/tcg/arm/hello-arm-be.c b/tests/tcg/arm/hello-arm-be.c
new file mode 100644
index 000000000000..6c2aa6637b93
--- /dev/null
+++ b/tests/tcg/arm/hello-arm-be.c
@@ -0,0 +1,34 @@
+/*
+ * Non-libc syscall hello world to exercise big-endian ARM Linux-user.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#define __NR_exit 1
+#define __NR_write 4
+
+static const char hello[] = "Hello World\n";
+/* Volatile forces a data load to check the CPU data byte order. */
+static volatile int len = sizeof(hello) - 1;
+
+static inline int write(int fd, const char *buf, int len)
+{
+    register int r0 __asm__("r0") = fd;
+    register const char *r1 __asm__("r1") = buf;
+    register int r2 __asm__("r2") = len;
+    register int r7 __asm__("r7") = __NR_write;
+
+    __asm__ volatile("svc 0" : "+r"(r0) : "r"(r1), "r"(r2), "r"(r7)
+                     : "memory");
+
+    return r0;
+}
+
+void _start(void)
+{
+    register int r0 __asm__("r0") = write(1, hello, len) != len;
+    register int r7 __asm__("r7") = __NR_exit;
+
+    __asm__ volatile("svc 0" : : "r"(r0), "r"(r7) : "memory");
+    __builtin_unreachable();
+}
diff --git a/tests/tcg/arm/hello-arm-be32.c b/tests/tcg/arm/hello-arm-be32.c
new file mode 100644
index 000000000000..f639332a1aa2
--- /dev/null
+++ b/tests/tcg/arm/hello-arm-be32.c
@@ -0,0 +1,4 @@
+/* Rebuild the big-endian hello test with legacy BE32 code/data ordering. */
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "hello-arm-be.c"
diff --git a/tests/tcg/arm/hello-arm.ref b/tests/tcg/arm/hello-arm.ref
new file mode 100644
index 000000000000..557db03de997
--- /dev/null
+++ b/tests/tcg/arm/hello-arm.ref
@@ -0,0 +1 @@
+Hello World
diff --git a/tests/tcg/arm/meson.build b/tests/tcg/arm/meson.build
index 6e498232f0d4..818447ae84d7 100644
--- a/tests/tcg/arm/meson.build
+++ b/tests/tcg/arm/meson.build
@@ -30,6 +30,17 @@ tests += {
   'hello-arm.c': {
     'cflags': ['-marm', '-nostdlib', '-ffreestanding', '-fno-stack-protector'],
   },
+  # The cross compiler emits BE8 for -mbig-endian; test legacy BE32 too.
+  'hello-arm-be.c': {
+    'cflags': ['-marm', '-mbig-endian', '-nostdlib', '-static', '-ffreestanding',
+               '-fno-stack-protector'],
+    'expected_output': 'hello-arm.ref',
+  },
+  'hello-arm-be32.c': {
+    'cflags': ['-marm', '-mbig-endian', '-mbe32', '-nostdlib', '-static',
+               '-ffreestanding', '-fno-stack-protector'],
+    'expected_output': 'hello-arm.ref',
+  },
   'fcvt.c': {
     'cflags': ['-lm', '-march=armv8.2-a+fp16', '-mfpu=neon-fp-armv8'],
     'expected_output': 'fcvt.ref',
-- 
2.55.0


