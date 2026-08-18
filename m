Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C99CBC5DF88
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:32:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPY0-00037I-9H; Tue, 18 Aug 2026 15:32:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPXp-0002t5-Lr
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:32:23 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPXm-0000D3-QF
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:32:20 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IIaaW31940453
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:32:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HenXo+DSELlzUZUuEMy/zed3hJN0r9K3ALowwVOjBv4=; b=Itzd3ZHziCzCvdTa
 yRaTn27K+MyUJ8+qUZRbdG8PyaQmcU64LNP06hVo4XOyQJupgsA7uGWEP3WUD7TQ
 doCyhLyRj19/dK7lPT47vpyxOEPj7NXD2y+LZ5F99FjdmvdMqNGkGsq8djBlN9fl
 MtPKWQ0lTjmU9kI+cCzSFTrPyFtcCOnzZxzlrO6GuviJOQ+4FgQ479A6lcIF284i
 0LTh5yuWjRRrsatcZyd9fVpnUe0msCWkeuwogSEltYBh9pwBYIgC8QiCBjwV+n3R
 L+lkQdypirmJZnj2RF3LCPs2mkrzOWkjaj8veSx57Owu+pOn8yrqfuq/QctDNYC6
 acUsng==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4vtu06nm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:32:17 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c9fe4c5eb39so89560a12.1
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787081536; x=1787686336; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HenXo+DSELlzUZUuEMy/zed3hJN0r9K3ALowwVOjBv4=;
 b=JRn7wuneUfYBeJyrbLWm61at+wVvayVo6WlxApfVXrMYgYmJdpKMkhy6OFA/1CwMYt
 vOPxXk+wJa0J1LEbdiDOzfEy+xM3sr3zSAFvWxAsz9NMhi5SZTMFCYkoOVRuPZfsk4FG
 u+wofKKLNjMTlRw6CgLxOHr+Vz38Ajj3QBDuiiNVRIfN9iYZhU3sHxBBn51ck82OdwhV
 h1sfUSJh8E3AudWx2p6wSyd3hHhrrETDVUVag3wPiVWGjrAyLJeJA4FOzh0P60rlkMiJ
 FuNQORAkRTw9z3XZK2ndtftAamP/5WdfP0QRLQ+jqt4TeDknhMQBNRGh6ARoXIZVm7H4
 aKRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787081536; x=1787686336;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HenXo+DSELlzUZUuEMy/zed3hJN0r9K3ALowwVOjBv4=;
 b=mERyFd2TrgN6p23z28lWPF98nUVICUTzUVNGP4YcMKLr2LtQuDAX/Wls1CDnsnJrEd
 M01GWAVkUYx5e5D8DK87Mdv/eR9Q6KdNVV+IISDIrT3GvFMyRpZeitrWnKdMLwfmvLK5
 v8iq0IJCUzxUjdZc+h+i7/LhyKZF+NOoQUpfQ6Yz1Qm++0Okq6yriF+efcCB1XudtlaS
 PHHdGuojq231M1LH18xG+Dvs/KaUk0fYC062fzRcDHr4WtdjHjCJ52uZLKTx5wj/tW3F
 1R9/AEYwhcBii27SFCe7shiXO0xlX4tsEPRGrgEZ2FOIzxcVNEFYLDOP7BBd6eRDyqh6
 LuHQ==
X-Gm-Message-State: AOJu0Ywk3l4mJwLcySH1Jb/Gkqv4evCu9QVaE4HotawufEZh2JY4n8ID
 zKQ9pDcu6naocwWijgG0uR5eLvF/1jFbnLaNzXal1Vu9GeaXcmNKFTxQ36lUqLCUQns+ZNwrb8X
 VMaK4LUs19a8bcket4Gdlzm2W0TbNLpGNzZGneylt0zHzrG1mMk13T/ZT5KftgH1YdA==
X-Gm-Gg: AR+sD13PtztbWtPTQoo9CnVYmtcpjTj1g4dPkRInbUyMc7BaYeaNWQxyU72uEINy4Wm
 HKS+P5d1qMk4KkczR1lqf3EbxZqQ7JYHncYzbHW1f2S9BKScKLuHBngpKj9t/pjfqIXSJWYrXVe
 P2Vt6DU/AoTyjZ3mZIRqc/QsB4ei4OjB5weik+IM+yqpc2WneVMqqbxhzNEUrJ6voWH6pjIW9OZ
 bSiWSkNsdj/Vb1Sfhh/D5wQRdNyALRzfBRwdPrqMH2wLlYWp+CtADJlLFA7c6AM5KND4Q2yJ0rV
 fw4Uezu4Bg9BoBMt3hsd1v/nkTVnG1abNYyLOv/IfhZNlS9tWDarQ1UHsscVlNZm+3sAd6ud7MD
 zmT7tqkYCY4qtCxyp4P1pNjutX4ASe0PvSpEbGvpQwn5Lb2g7QgO9/uIH+5M=
X-Received: by 2002:a05:6a21:a38c:b0:3c0:b766:751b with SMTP id
 adf61e73a8af0-3ccfef62cb0mr277909637.14.1787081536319; 
 Tue, 18 Aug 2026 12:32:16 -0700 (PDT)
X-Received: by 2002:a05:6a21:a38c:b0:3c0:b766:751b with SMTP id
 adf61e73a8af0-3ccfef62cb0mr277824637.14.1787081535791; 
 Tue, 18 Aug 2026 12:32:15 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-326798c566asm21877135eec.11.2026.08.18.12.32.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:32:15 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v7 080/104] tests/tcg/riscv64: user tests
Date: Tue, 18 Aug 2026 19:22:44 +0000
Message-ID: <20260818192309.22169-81-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: XJPUXy372DrSpBBJNa0oDBeR_ruSlTig
X-Proofpoint-GUID: XJPUXy372DrSpBBJNa0oDBeR_ruSlTig
X-Authority-Analysis: v=2.4 cv=FeYHAp+6 c=1 sm=1 tr=0 ts=6a84b341 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=VnNF1IyMAAAA:8 a=2nRveiBTxYvp2EUq1skA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX/H7DkzSqrBcB
 GPR2l1zle5LC3cXWhhIZBkP1T+xBOAkQ7gT663f4cRDpei34TfFoirD7Vg/eozS3cFKMXC5j2eM
 AeopgRJN7SHdFcLbh6ivqZY3C9EVYQ2ALOz9d+pH11cR724DCSiRcwr6d1vXzn3e9fECBRXmi6n
 z2DUTo0rY3cO5TMIS3Vy6wvykcrD1IQpssuWH6q/YJ2dWZxHio0Q0O+vCCAAO25yR2i6vwa4vcU
 c96XaeeosF0XnWWDmyllDiIzHPAa61tk8das//Vkp8Vm7WqamLytnJ7nnkX+pMhP3rrstn5dGt9
 rOs8DRW6kRzxHBwnVw1gS9MN8Mn9Qqqd8AcKAATk+rNp47Kb2zVr/QClSaVzixlcC4LNZZW4o5/
 vgLRN9zLHSVZd13OgZqGfPZf0LgP1x4dqFLVZ5PpN1ovPdPQkNegmm2W4yg0RInP7jtZstBn+TQ
 sv6OGDd3y0hWuV+GeBA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX7gGfqpofMPiX
 iBjkFH+YdWvhVKDE1/SmVZS6PU7eUZ1OWrjsK+3qi1JtUA7mz4U+ricOlHAdrujZNG0FVec/ksD
 vZYAcBD/z/Jlv63BOCF5ebPyoHMtVv8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180142
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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


