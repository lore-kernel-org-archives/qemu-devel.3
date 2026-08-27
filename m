Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE0DEC61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:23:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziVP-00031Z-Q7; Thu, 27 Aug 2026 18:23:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziVI-0002pt-Oi
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:23:25 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziVH-000084-0h
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:23:24 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJLupl779276
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:23:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HenXo+DSELlzUZUuEMy/zed3hJN0r9K3ALowwVOjBv4=; b=X5wHiabrJMyjvm9c
 uU1YcJCjK/rb1iCjatTe7AGQX9n+wXJ7g81x3xBxzGPsJKBzK+xYojrvih0TmkwL
 lr17/tw+WQw63PzbeVhCDpdWlwaISVEwihjmPfGyaxtBddlvSVfTsB1aZXeG1FDX
 z1YZnjhE0w+LRlRhofO3YCEly2I8YExzB+YMUdhAztRlz/3ZpXsd4GcR68mnOpu1
 fyEf0Vgma0bWpnastubM+s94QZlLQUdVoJbBsxW/3x8O6HNZ+RK0ExgugzUZIoIG
 0vrvqVgPT86KwTUOzTZg28LN295lEOU+LUjIUWkQ7Q0kylYM7AIbBlRUc3AbfsL0
 DvxXzw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4garee1r52-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:23:21 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2d6f710f066so3030345ad.1
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787869400; x=1788474200; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HenXo+DSELlzUZUuEMy/zed3hJN0r9K3ALowwVOjBv4=;
 b=J1+3mTB3DqbHDZGYn1uzaMNcrpNXd1HNQ7UaPypL0DYHLRUP6vMkZe38FfS8rq8/w5
 Y4V4h6Wcevr3+az+Kd1nN802VUj6Ij0L+fTZggvQ0rJiiEo1ibYTCn5gX40mZlVD9Cot
 pu5MQPQ3ekCzvLfyT6phI0YwlyYcgHxAzPwS83RN3ez31K7nB2gUUTKkeCGvJHYM81HK
 ZSE0EZcEbIzkc3vYRx2U2+m8gl+FHll7+A6Yt4ln04ss6gHGWi/RVvKP76xgz2xIIh1b
 QMASU1xLX5PoiPdvwXLqktEcX/QfXWZvw9sxlmIu25YvCPa6gvMc4MrH0x7JwJSd6AmP
 CIZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787869400; x=1788474200;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HenXo+DSELlzUZUuEMy/zed3hJN0r9K3ALowwVOjBv4=;
 b=QtkAWy+b23q1ftgKHvHQvQv1Tdd7PQptr+i9SdvMuB/gQ6kpVZZZTLX0skrjoIo1ic
 Axw9i4bLLcoU6KBeGk/rOd1BrYZWaagzvh9p+7CurgeQ8FW7hSclCKqIfxzLE0cutTJO
 y83n3/AcBDHQaH6V92DQ8lsgsARRHpVJdwNb7/gEcuuwUujCpkYGiL9BcG6UugxsJD31
 CKEpDlcNSTzV3zFos3DsPnWl1Zk5othoxdVuGjp+OJQ1lwXoSDu55GuDVbJjDatcRpvJ
 v+r2/Y/GbNqX7JUCMxVZr1H8+qp3oYryRvFbwE3fORasaMM07SPvti747b+pqthGdEzC
 PFwQ==
X-Gm-Message-State: AFuF++nwoEMiqwpnUEsaCG21RRjD5z4ooDPu0acIn5C9jAfN8h918B/3
 14qCXFRnMSubMA5LaiDAtPARWNESFKNIRwExcmsH1bGm3664rg89IhkMHDPJ/SIFZH2gAiiNUCH
 pNuQpkT5gdulldxLZDjVG9iDQ1IdtC8/8katx4/bcmLLw71b7M0/yQW60vYU9qbo21Q==
X-Gm-Gg: AR+sD13KIOtL36xZOjdsBjfgIIff/ZwtQYdUusgJ7CMfTTl/wJE7BtxLPCMOnN0Tjwk
 5f2l5bZ1kXAacYXjEsd/5tH7kekS98WVdnA3jFeuL8gQppTI5fM0TsznRHh3AXyc7zGKxVlt5Ex
 hzu4MSQtlzdoSfcZdQ21cWgKc+25Ev3zlF43y7TKmz7sOwGvfDp0YcJUnmyRj2f4qRZRZ+VTDi1
 uK4T/uaLL/JIcaF5KmQxBPwBRoBkW+fCBOrvlNuLlt3YKz/NRiA1eDQ5ewn5E2fRjp47y2vXm3j
 aZ3SYg4GFt6eMB0xcoSFcG7dADDIHNj4J79kWpboVjNVYh3G+5gBgdZebdx/Jx9YFTLsBpRoJok
 6y9jBpMhqic9Gm4O2Ne3fm4kQncNrYArXM2eo42BQWo0TWPpOYH2YtiUSZhU=
X-Received: by 2002:a17:903:a90:b0:2cf:8aa7:7810 with SMTP id
 d9443c01a7336-2d74cc49176mr25754835ad.2.1787869400547; 
 Thu, 27 Aug 2026 15:23:20 -0700 (PDT)
X-Received: by 2002:a17:903:a90:b0:2cf:8aa7:7810 with SMTP id
 d9443c01a7336-2d74cc49176mr25754275ad.2.1787869400075; 
 Thu, 27 Aug 2026 15:23:20 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d70493f729sm20776155ad.2.2026.08.27.15.23.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:23:19 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 pierrick.bouvier@oss.qualcomm.com, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bibo Mao <maobibo@loongson.cn>, Helge Deller <deller@gmx.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Song Gao <17746591750@163.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Laurent Vivier <laurent@vivier.eu>, Nicholas Piggin <npiggin@gmail.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v8 080/105] tests/tcg/riscv64: user tests
Date: Thu, 27 Aug 2026 22:14:41 +0000
Message-ID: <20260827221506.91574-81-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE5MCBTYWx0ZWRfX2EYYFI/ILWe6
 tlEmDbIYeaOkE+qMuSM8GMOoQFqOm2zQ+/1+33FAVR9rXTSPS6WNRdNgpTc+7gdDBx5WUdP6f8D
 cRB3SlBr2IrShztYOMWTGSzYm+b5MTyQNhX7+xiJyhk0BeSSDG7KC0o1pCaMTWMst4mc6yFZsKQ
 Qt/pZPaBSy+ZkzHagkjtVyoRuRsBweUfOjwxAHPggUrdIt5PfmtRtyLGSYsa4Wn2+MelCZLkuvQ
 spQB4HsiHbqx5huK7wDjoxPe9UBX2AXU1AlCcRgaMMSJo/jqvD//pWNpJ93LP/MVvxR/WUdQSOX
 MeVYQzJa4YMj5gOkLWG4BoNIvrjo0ITKkrGrxrLQseBnAVtQEAXT4yQkYY1BrLv7UHUqOl1y7tJ
 JNJvZyMQPIDEVZM1UIgJ5bU3bsPPyEiMPiTNbrr4mqv/UjN45zXk3Tp5S7jFLJrRYtVpngYZNXK
 C7fiUE4jts8w7/HWbYg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE5MCBTYWx0ZWRfX4E9UqZdCattW
 30FXGtGnsk13ag1zQb0G7bV/5nbWnBVu6iDciaa57UnrvDTxp9/hOcepfClgTUJMscBOKt6ON/7
 yGR1Ve7d2bVc6JCTXCpKBDgfCMVE7rs=
X-Proofpoint-ORIG-GUID: kWyvCv2Sq4MP7nXV_FIFWyMOUYwloem3
X-Proofpoint-GUID: kWyvCv2Sq4MP7nXV_FIFWyMOUYwloem3
X-Authority-Analysis: v=2.4 cv=e8E2j6p/ c=1 sm=1 tr=0 ts=6a90b8d9 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=VnNF1IyMAAAA:8 a=2nRveiBTxYvp2EUq1skA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270190
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build             |  1 +
 tests/tcg/riscv64/Makefile.target | 20 -----------------
 tests/tcg/riscv64/meson.build     | 36 +++++++++++++++++++++++++++++++
 3 files changed, 37 insertions(+), 20 deletions(-)
 delete mode 100644 tests/tcg/riscv64/Makefile.target
 create mode 100644 tests/tcg/riscv64/meson.build

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index f13f0d84792..1a48b37f75c 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -151,6 +151,7 @@ subdir('mips64el')
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
2.43.0


