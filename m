Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4615A606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 19:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pTEfRkhL;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YqPqf0S1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM9IJ-0001BC-K8; Wed, 28 Oct 2026 15:26:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xM9Hr-0000p3-OQ
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 15:26:19 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xM9Ho-0006Ck-TA
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 15:26:14 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69SIdUHu1920913
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 19:26:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 eKck2cTpZveohmF7FnPIDh08iqbceGMcFtvm0eu1aP8=; b=pTEfRkhLBBlm/okj
 yUSMw5OAsN4HU1eK8PmSRRpPqg3otxSBIfYDuapzdQ/fVXIOH7/KSliI5t5sWf4V
 uL8sjbwQphuxn+H8eirT6oOUPDvEHozGXhlbLNOFVd+t6Py5qzodzVvB+OluhLEC
 y18YylSBxB7JiQAbRXBFos9woFyyeFgG2UVKDjjsyryQR6TAg6kpr6fdtw4zKuzp
 2NExFsAQbexKruzPtPVZO4GtyNzm1qe7AZ7XjXSAE9v2lwWBFUIdX/1bV0Udg9kp
 uFk5PD/0uPjD9N5QCiyaWODP2GWa3NqDUoHX91+ZFqpSBTDhs3IrnmgNPj8ykaTd
 SWgFUA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkpgpr60j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 19:26:11 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f1f2fafeaso164544185a.2
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 12:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793215571; x=1793820371; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=eKck2cTpZveohmF7FnPIDh08iqbceGMcFtvm0eu1aP8=;
 b=YqPqf0S1+wTlE3OnjALA5WFy4sjt9VpfkVsbJ1gCxewgzEw9JJH3a/bA0C/jcGlGzP
 fx9UkoGW61sO79fT0ycgaJeb4VurRIYDvfezbZvMq0ZaM7NBJnV1zE7LAqzBfzL+zP+q
 XMZCpZfVkBwRC84gtM1ngoVMVPU0J6nbXKfccUttLr6+rWsWcfQpHzJwTJ+2oAaWh6+s
 P8We/ZO+OWpZENHn5164lz7weTdHExJNV6o0o9n31Tpkr3a3+yRKuuN4C/iW4RKY0NvA
 FFQfqfCZZMNofwSl0o4GHbDSyYpl4WK+xuJFUTO29UxHLaiywuVm9WNsg105DQFjthvl
 vRYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793215571; x=1793820371;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eKck2cTpZveohmF7FnPIDh08iqbceGMcFtvm0eu1aP8=;
 b=oiEbkSVf8uJtXHmtHxiQyQumSTFvXS8GKmQfZHsjWNLoRED0S4VdPlooCnwT3ZKa1X
 qP4EJibAG8TzdukvQ5RwGNtt4NPhINF8+JLFR35KSMXBVgnQ0NJg3Jl4ND+q0QjoeKkD
 Mis44VPfM1TODwngSKIJVtTEAtp4wWkF3H2yzKD7Btp6ARYbrngmlurc8MF/1BZxisd1
 kwVKpx9FmkmznNd/dHEpw6N0fpfjsAI2YjATVgWTTxvEnsg5N3/RQEI+f0d/Ph+xthVR
 wh+VMbUOd1w96Lc9iamlDrp8jWhiritI97YNgwx3xcmCiNxe42uBsC6NwQ65E/avnbwp
 Ic6Q==
X-Gm-Message-State: AFq9FYK3JehpUH0ctqH0SrZVNA1uqlM7va+66Bdypu9ILZhsj9DVvWam
 Zyiv7E4vAG6Zmo+SsdTHbUvibVkLSocF9XSEvtZ86qNnAc60ZfV/wwJIkd/cUSVMZPaL43Uyftc
 rlWhRNWsCOdArH0L0w5mGbe+pqwG3X/2YQ4roxSpBb8BsTz8jAtL5FU3o3UAvUCpz9lKF
X-Gm-Gg: AYBFou2PQMhwbnDutC87fradgmhlDfp2Zmzjwd+TJv+GzvGc8HMwTqwXbE3PLfxxYJO
 5Aiy/HjYO+1PXI4UpGD33yJRwUCbQ8ku2N/qnlrrFFvbvPLHQul89Eo8feF+vbX9yFYdCKhrAOa
 1xMZe9VadMGY5/hf7XS+u8iWVcEJy+OIKoReyQVOx6V6Ovb3q/HhSeRQx9RGN0dsFB8SHobfHi0
 cKUQ9m4ZjENv5N140/xtWTzFNXbKEZ4X1OF+AxaDZHbhX8OyvcXSJ8gc0eptfHfAoAG5G7U4ZuV
 5ot1PEho5Ge+Vw8bTrxAPTeM/AZgc29qjnNUzlhI7ZeLxm9KdJea+aJJMcpZ3fDhz+wvYpd+6F9
 XP7Yp/00bdsj2NQjODK6nrRUXZWOjCtRQQBhZmqY17yH7LDEFvZvhutYEi9r2F8Rxegri2Vl08J
 pmIxoM0sPZJ2goLaYbH4lQj5yXQTgRqg==
X-Received: by 2002:a05:620a:d8a:b0:93c:17db:d91f with SMTP id
 af79cd13be357-94408a5c3a6mr518977785a.39.1793215571044; 
 Wed, 28 Oct 2026 12:26:11 -0700 (PDT)
X-Received: by 2002:a05:620a:d8a:b0:93c:17db:d91f with SMTP id
 af79cd13be357-94408a5c3a6mr518972285a.39.1793215570392; 
 Wed, 28 Oct 2026 12:26:10 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa82048db8sm11970555e9.12.2026.10.28.12.26.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 28 Oct 2026 12:26:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Fredrik Noring <noring@nocrew.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 "Maciej W. Rozycki" <macro@orcam.me.uk>
Subject: [PATCH v2 4/9] tests/tcg/mips64el: Add bare-metal harness for R5900
 system tests
Date: Wed, 28 Oct 2026 20:25:32 +0100
Message-ID: <20261028192538.31600-5-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261028192538.31600-1-philmd@oss.qualcomm.com>
References: <20261028192538.31600-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA3NyBTYWx0ZWRfXyvSEoeJ2yTRL
 4gdHpgJEtVgmXXlqmDGklKLDn/SoCITw8MaUyn1rQsjsGnasbZsFLm6pdHvxlz/UJ3kMxDrLHqe
 xaDlrQC6UT8KkGoy94/UuIf8OW7/gFIt0DHJcHv6JaoFJWcj0Xaj2ApBWdoN0+b/BWTNjA5qR2e
 XKewJ14H/k12jZ0saUgSl+HDyhzSIofdV5QxOepaKcAcct8nHNYwnQxP6N8spuySlzwxXEI9tYv
 ar6I49QYk/NX8bMH2tZlUworESZgcBHM8cLXCx6TaFCAgOSi4qISCwNc10ZLRZ0+l2k8Wq4y7AU
 lukq8YruRRWq9QInjCnEjo8pqjxHHdPTMmqUm0f8wX+CoM+mi8HG0wTaJ79Ab2alO+bQYzDTn5T
 MjlRJwBHEocOUH0Rd/kwmoy4d+PQhh4skVSaeTawR37z0+ZoGrLdztA/KgZpAumBU74xxCEfGFk
 quILIXNBDiDzPQEESCA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA3NyBTYWx0ZWRfX1cqWHDhXJL+1
 s3XeSRUWo8AA3zEz5LJ1jeHXhuErV7xed8i9PKYGCOJHM4WHPlmZRiif1DU9jDsH8MrCMfBSvo8
 zl1Rfqjy4DMnuVQmnc7Ak5QuniruRNI=
X-Proofpoint-ORIG-GUID: 6AVT3m6_HrithRZ5MU9CiEhxo1Obzo8h
X-Proofpoint-GUID: 6AVT3m6_HrithRZ5MU9CiEhxo1Obzo8h
X-Authority-Analysis: v=2.4 cv=T4oZ3PKQ c=1 sm=1 tr=0 ts=6ae24c53 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=BcPKCTjPAAAA:8 a=EUspDBNiAAAA:8 a=ptgw2CBjsXCMiKluzNsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=MNXww67FyIVnWKX2fotq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280077
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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

There is no libc for the R5900, so its tests can not run in user
mode [*]. Provide what is needed to run them bare-metal on the
'none' machine: start-up code, linker script, minimal assert.h,
inttypes.h, stdio.h and string.h, and a gdb script.

A first generic loader loads the ELF at its physical addresses, a
second one sets the PC to the KSEG0 entry point, sign-extended as the
CPU is 64-bit. Tests end in test_done(), where the gdb script checks
the status and kills QEMU. Tests use 32-bit pointers, so gdb must
send 64-bit addresses to the remote stub.

No test is registered yet.

[*] https://lore.kernel.org/qemu-devel/alpine.DEB.2.21.2103172243160.21463@angie.orcam.me.uk/

Inspired-by: Maciej W. Rozycki <macro@orcam.me.uk>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 tests/tcg/mips64el/system/include/assert.h   | 15 +++++
 tests/tcg/mips64el/system/include/inttypes.h |  7 +++
 tests/tcg/mips64el/system/include/stdio.h    | 17 +++++
 tests/tcg/mips64el/system/include/string.h   | 16 +++++
 tests/tcg/mips64el/system/harness.c          | 66 ++++++++++++++++++++
 tests/tcg/mips64el/meson.build               |  2 +
 tests/tcg/mips64el/system/boot.S             | 23 +++++++
 tests/tcg/mips64el/system/kernel.ld          | 43 +++++++++++++
 tests/tcg/mips64el/system/meson.build        | 33 ++++++++++
 tests/tcg/mips64el/system/test-r5900.py      | 30 +++++++++
 10 files changed, 252 insertions(+)
 create mode 100644 tests/tcg/mips64el/system/include/assert.h
 create mode 100644 tests/tcg/mips64el/system/include/inttypes.h
 create mode 100644 tests/tcg/mips64el/system/include/stdio.h
 create mode 100644 tests/tcg/mips64el/system/include/string.h
 create mode 100644 tests/tcg/mips64el/system/harness.c
 create mode 100644 tests/tcg/mips64el/system/boot.S
 create mode 100644 tests/tcg/mips64el/system/kernel.ld
 create mode 100644 tests/tcg/mips64el/system/meson.build
 create mode 100644 tests/tcg/mips64el/system/test-r5900.py

diff --git a/tests/tcg/mips64el/system/include/assert.h b/tests/tcg/mips64el/system/include/assert.h
new file mode 100644
index 000000000000..7b466a3b8ab5
--- /dev/null
+++ b/tests/tcg/mips64el/system/include/assert.h
@@ -0,0 +1,15 @@
+/*
+ * Freestanding assert() for bare-metal R5900 tests
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef R5900_SYSTEM_ASSERT_H
+#define R5900_SYSTEM_ASSERT_H
+
+void test_assert_fail(int line) __attribute__((noreturn));
+void test_done(int status) __attribute__((noreturn));
+
+#define assert(cond) ((cond) ? (void)0 : test_assert_fail(__LINE__))
+
+#endif
diff --git a/tests/tcg/mips64el/system/include/inttypes.h b/tests/tcg/mips64el/system/include/inttypes.h
new file mode 100644
index 000000000000..3bfbd2ce65ea
--- /dev/null
+++ b/tests/tcg/mips64el/system/include/inttypes.h
@@ -0,0 +1,7 @@
+/*
+ * Freestanding <inttypes.h> for bare-metal R5900 tests
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <stdint.h>
diff --git a/tests/tcg/mips64el/system/include/stdio.h b/tests/tcg/mips64el/system/include/stdio.h
new file mode 100644
index 000000000000..6130f77b77d1
--- /dev/null
+++ b/tests/tcg/mips64el/system/include/stdio.h
@@ -0,0 +1,17 @@
+/*
+ * Freestanding <stdio.h> for bare-metal R5900 tests
+ *
+ * There is no console: fprintf() only records its format string,
+ * which the gdb script reports when the test fails.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef R5900_SYSTEM_STDIO_H
+#define R5900_SYSTEM_STDIO_H
+
+void test_message(const char *msg);
+
+#define fprintf(stream, fmt, ...) test_message(fmt)
+
+#endif
diff --git a/tests/tcg/mips64el/system/include/string.h b/tests/tcg/mips64el/system/include/string.h
new file mode 100644
index 000000000000..819da7cb1ada
--- /dev/null
+++ b/tests/tcg/mips64el/system/include/string.h
@@ -0,0 +1,16 @@
+/*
+ * Freestanding <string.h> for bare-metal R5900 tests
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef R5900_SYSTEM_STRING_H
+#define R5900_SYSTEM_STRING_H
+
+#include <stddef.h>
+
+void *memset(void *s, int c, size_t n);
+void *memcpy(void *dest, const void *src, size_t n);
+int memcmp(const void *s1, const void *s2, size_t n);
+
+#endif
diff --git a/tests/tcg/mips64el/system/harness.c b/tests/tcg/mips64el/system/harness.c
new file mode 100644
index 000000000000..aa6c75579e59
--- /dev/null
+++ b/tests/tcg/mips64el/system/harness.c
@@ -0,0 +1,66 @@
+/*
+ * Bare-metal harness for R5900 tests
+ *
+ * There is no libc nor any way to exit QEMU on the 'none' machine.
+ * Tests end in test_done(), where the gdb script reads the status.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <assert.h>
+#include <stdio.h>
+#include <string.h>
+
+volatile int test_failed_line;
+const char *volatile test_failed_message;
+
+void __attribute__((noinline, noreturn)) test_done(int status)
+{
+    for (;;) {
+        /* The gdb script stops here */
+    }
+}
+
+void test_assert_fail(int line)
+{
+    test_failed_line = line;
+    test_done(1);
+}
+
+void test_message(const char *msg)
+{
+    test_failed_message = msg;
+}
+
+void *memset(void *s, int c, size_t n)
+{
+    unsigned char *p = s;
+
+    while (n--) {
+        *p++ = c;
+    }
+    return s;
+}
+
+void *memcpy(void *dest, const void *src, size_t n)
+{
+    unsigned char *d = dest;
+    const unsigned char *s = src;
+
+    while (n--) {
+        *d++ = *s++;
+    }
+    return dest;
+}
+
+int memcmp(const void *s1, const void *s2, size_t n)
+{
+    const unsigned char *a = s1, *b = s2;
+
+    for (; n; n--, a++, b++) {
+        if (*a != *b) {
+            return *a - *b;
+        }
+    }
+    return 0;
+}
diff --git a/tests/tcg/mips64el/meson.build b/tests/tcg/mips64el/meson.build
index 606f300804a4..a68ceab3b4b9 100644
--- a/tests/tcg/mips64el/meson.build
+++ b/tests/tcg/mips64el/meson.build
@@ -1,3 +1,5 @@
+subdir('system')
+
 if 'qemu-mips64el' in emulators
   tcg_tests += {
     'mips64el-linux-user': {
diff --git a/tests/tcg/mips64el/system/boot.S b/tests/tcg/mips64el/system/boot.S
new file mode 100644
index 000000000000..0448f983bbeb
--- /dev/null
+++ b/tests/tcg/mips64el/system/boot.S
@@ -0,0 +1,23 @@
+/*
+ * Minimal start-up code for bare-metal R5900 tests
+ *
+ * The CPU starts in kernel mode at _start (PC set by the generic
+ * loader device). Set up a stack, run main() and report its return
+ * value to test_done(), where the gdb script is waiting.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+    .set    noreorder
+    .section .text.boot, "ax"
+    .globl  _start
+    .ent    _start
+_start:
+    la      $sp, _stack_top
+    jal     main
+    nop
+    jal     test_done
+    move    $a0, $v0
+1:  b       1b
+    nop
+    .end    _start
diff --git a/tests/tcg/mips64el/system/kernel.ld b/tests/tcg/mips64el/system/kernel.ld
new file mode 100644
index 000000000000..1a0aae7df4da
--- /dev/null
+++ b/tests/tcg/mips64el/system/kernel.ld
@@ -0,0 +1,43 @@
+/*
+ * Linker script for bare-metal R5900 tests
+ *
+ * Code runs from KSEG0 (unmapped, cached) and is loaded at the
+ * corresponding physical address, in RAM mapped at zero.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+ENTRY(_start)
+
+KSEG0 = 0x80000000;
+
+SECTIONS
+{
+    . = KSEG0 + 0x100000;
+    .text : AT(ADDR(.text) - KSEG0) {
+        *(.text.boot)
+        *(.text*)
+    }
+    .rodata : AT(ADDR(.rodata) - KSEG0) {
+        *(.rodata*)
+    }
+    .data : AT(ADDR(.data) - KSEG0) {
+        *(.data*)
+        *(.sdata*)
+    }
+    .bss : AT(ADDR(.bss) - KSEG0) {
+        *(.sbss*)
+        *(.bss*)
+        *(COMMON)
+    }
+    . = ALIGN(16) + 0x10000;
+    _stack_top = .;
+
+    /DISCARD/ : {
+        *(.MIPS.abiflags)
+        *(.reginfo)
+        *(.pdr)
+        *(.gnu.attributes)
+        *(.comment)
+    }
+}
diff --git a/tests/tcg/mips64el/system/meson.build b/tests/tcg/mips64el/system/meson.build
new file mode 100644
index 000000000000..265a2eca4ff1
--- /dev/null
+++ b/tests/tcg/mips64el/system/meson.build
@@ -0,0 +1,33 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+tests = []
+
+cflags = ['-nostdlib', '-ffreestanding',
+          '-march=r5900', '-msoft-float',
+          '-mno-abicalls', '-fno-pic', '-G0',
+          '-I', meson.current_source_dir() / 'include',
+          files('boot.S')[0], files('harness.c')[0],
+          '-Wl,-T', files('kernel.ld')[0],
+          '-Wl,--no-warn-rwx-segments', '-Wl,--build-id=none']
+
+qemu_args = ['-M', 'none', '-cpu', 'R5900', '-m', '16M',
+             '-display', 'none',
+             '-device', 'loader,file=@BINARY@',
+             '-device', 'loader,addr=0xffffffff80100000,cpu-num=0']
+
+# Pointers are 32-bit (o32, n32), sign-extend them for the 64-bit CPU
+gdb_test = ['--gdb-args=-ex "set remoteaddresssize 64"',
+            '--test', files('test-r5900.py')]
+
+if 'qemu-system-mips64el' in emulators
+  tcg_tests += {
+    'mips64el-softmmu': {
+      'cc': 'mips64el-linux-gnuabi64-gcc',
+      'cc_dockerfile': 'debian-all-test-cross',
+      'folder': 'mips64el/system',
+      'gdb_arch': 'mips64el',
+      'qemu': emulators['qemu-system-mips64el'],
+      'tests': tests,
+    }
+  }
+endif
diff --git a/tests/tcg/mips64el/system/test-r5900.py b/tests/tcg/mips64el/system/test-r5900.py
new file mode 100644
index 000000000000..2e7ed191b3b6
--- /dev/null
+++ b/tests/tcg/mips64el/system/test-r5900.py
@@ -0,0 +1,30 @@
+"""Run a bare-metal R5900 test and check its result
+
+The guest runs until test_done(); a non-zero status means the test
+failed: test_failed_line holds the line of a failed assert(), and
+test_failed_message the last message the test tried to print.
+
+SPDX-License-Identifier: GPL-2.0-or-later
+"""
+
+import gdb
+from test_gdbstub import main, report
+
+
+def run_test():
+    gdb.execute("break test_done")
+    gdb.execute("continue")
+
+    status = int(gdb.parse_and_eval("status"))
+    details = ""
+    if status:
+        line = int(gdb.parse_and_eval("test_failed_line"))
+        message = gdb.parse_and_eval("test_failed_message")
+        if line:
+            details = f" (assert failed at line {line})"
+        elif int(message):
+            details = f" ({message.string().strip()})"
+    report(status == 0, "guest test" + details)
+
+
+main(run_test)
-- 
2.55.0


