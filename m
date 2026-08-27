Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F7DBC61DCD
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:20:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziSF-00069k-0a; Thu, 27 Aug 2026 18:20:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziRs-0004QA-Ie
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:19:54 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziRp-0007J6-DX
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:19:51 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJMFVl1803873
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:19:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 22URDdqhinmBEgy6NKIh5uuq7h1J/PPpgxypWgqbkeU=; b=Knx2zObe+//hMt4T
 VyYx1/Wobl7GNHBs9s3nH73Fx0PXrc1VPkXdheIqX3QWOqMNkTVlaPbYL6VOk5NM
 xOhlitHH59mcLeHOcDAFNy5iksxBP8TxUFl8AqP3V26bqYNabOtzHowofwkylvH9
 yaKE9kfGeQjonTLnIBZq4FVyXj4MGBd42QO/LMgbX/bJMku4CIpqcyrskEWpOMdX
 TzR2vNaqyHT4SOXctx7BspQf1bgIPuI+bgvUCsIhuYPZOaTIBo6eEaxV2DovIIDc
 U8OGehvWyRU3cfI3sdVdLG8nCFBaGRKamd+yvypbfjm4bceHqYIWNfJerZlZgQDt
 HhsUBA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gatfxgvj6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:19:47 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38e54b6556aso278845a91.2
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787869187; x=1788473987; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=22URDdqhinmBEgy6NKIh5uuq7h1J/PPpgxypWgqbkeU=;
 b=fVsa69k8Ph7t8RgaX8+hvVqeWroC6qfvS7xrZPl8FfVK+dqJZRh1HuKQ608IfVEy4f
 nAs2DfULIvFxDv8QjhYZ3YC0Kg3SG14enYB9dn1Xe1WZwhJGkBodkOVYGrmuncXso6kw
 NHL37E3Shf49HOlpfIqlqA1RdVcc/4piaUzR/D/tdZ+Qdx2h63v1XEmgVX7XdcHGQb2Z
 Ys88u5fuo3MiNpuFxHnAJbQ6VoLxVrFCWYieOD4Vb9xS1ef/bE55bwnVytp1iOMEyW3O
 mRzFmFJkdB+1z6YxPkRo+JR9V0Yql2ccPGDYM5uzD9eAEAsJULBJGSvPPkyepAXIT276
 UEag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787869187; x=1788473987;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=22URDdqhinmBEgy6NKIh5uuq7h1J/PPpgxypWgqbkeU=;
 b=ioZana51R0mKjm/RjWJS47BYKDowXrzD0Z8p/FdFPMcSky+TFS55Ib6EtRWt00krky
 /y0B7qhzLpgV23bsmt7gbBpPUAvU1grCqTWRwccyq6dZfHxRvy4wi+O2DQ+d2xakSHOP
 7xDAk5ttqXwqi6ushDVdKWWqug8z2OeyfA/Qs+ASoFYHyvCxku2gQFynd1R71qoB0yyo
 qKKp2ato3JzYYfaaN8HKoWgOanyia9lHmqgoJzP15LusnsEHhNI9NBxNh8APND9SPu+t
 /nzUiX3mqCI1ZYQEWewH2eoZ4MKC6Tg8o63qr5C7br+uQXwtwaboMqLlUxkGZGesjBv1
 zoIA==
X-Gm-Message-State: AFuF++l0gXzX6rWSto3qc0kGgA7vF8yyTjTmgeSmm/Y0KP8W5oPqHJLw
 MVTP667TE2IbTxGGzPB4lY+CkB1g7ACj+8rLiAaYHG5zZWtZd5grtCVcKZ8Dxk+dk6kv2dJfSDL
 8YE/PaxMLY3XnMkaXzoAJhmdn9qesFcCSbC3Kp2X8FTl71Ca4Tvwa68E80lYnoUL7XQ==
X-Gm-Gg: AR+sD12ucJhz0rMzlAXUAoHhGncGUc6JPswqTe2t5S5CczPlsELiMhh/j8qU/0EZVT4
 gDNORX9desHB4R1FbVWERu6jc3+KD4ZcXTlFqVNGu+A3zqSw70MHY5yE/D8Uhno0W8Ieb+fRMet
 EkNhTLWXQjGlraT9ZI6ytmCUJqHytsIYheLXmWT36cCBrohY1MpkqKraRKP+YljK4Z8fInle38k
 HdeGYdwhIa9oVJgPCWy5Mwl0ZO+Hd0TtvOW7zr4+2iji7OsA0BR0WoQDqSx7VKY3gR7ybN0PVwJ
 6sSxrefnerQwYTys4zPPQrxPupUOJRr1fAoJeu+n6+tQA41boVeQOojKHlBCQPQgJVhvMzlxewQ
 aJiMmzhH6PywNe5bIKNFXhcOO2dmx2a7GQDEVvUh7IPILpwF+xsxJ/vLONQQ=
X-Received: by 2002:a17:90b:2f0f:b0:380:540:d499 with SMTP id
 98e67ed59e1d1-396d0ed0023mr4800802a91.6.1787869187171; 
 Thu, 27 Aug 2026 15:19:47 -0700 (PDT)
X-Received: by 2002:a17:90b:2f0f:b0:380:540:d499 with SMTP id
 98e67ed59e1d1-396d0ed0023mr4800701a91.6.1787869186697; 
 Thu, 27 Aug 2026 15:19:46 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b0fd55a4sm4466925a91.7.2026.08.27.15.19.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:19:46 -0700 (PDT)
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
Subject: [PATCH v8 065/105] tests/tcg/mips64: user tests
Date: Thu, 27 Aug 2026 22:14:26 +0000
Message-ID: <20260827221506.91574-66-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=UKLt2ify c=1 sm=1 tr=0 ts=6a90b803 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=VnNF1IyMAAAA:8 a=d1guRcTfha0oDln5RU8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: IoON7dZgXJxF1w6QmIVRmtDNmnEE04w0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OSBTYWx0ZWRfXzsc0AT+ARwhR
 DB4JB/zmVi54zduRq/9Ha8Q9LMmbpDo5EKrAQoOQXzL/BKL2uJ3sgCO8mQYaMmxoAncrZbJ+Cmv
 oz7Fpg0VcbUSwi28izRz2NZHVFNHuMNAjLhKzCC8eHVopcjc/Jv6732whzerkEE0L6zHuVhWqdS
 agbTBZO8jB3/ognWrsCRECoLbWJwA4LLmzy+6K0esHsG3FAAJGTo0Bqo51VPpKvcWym1UupQXry
 lK1l3RQgx9YrupD8uQ0MnpfnfFouDriYXiLw/PTqrAPC3aHXsdELONblMb2q2P3Dm63EQg2Xcfs
 hBOwm/uS7KkcY+jYaVl3/p00LBQ0jxQB3ZjAEZ74h1lH7M4c143DP1XINUYBiuM1evAI++n/5AD
 8GeCFnnqFNfAJpDFLGy9qNfvrNPocH8Zcw3UTDNHVo/s+3wRG1aeKUdPJim3QyR8WmDLIOE+Cvf
 Tg4mMJTQtXyRAzodH0Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OSBTYWx0ZWRfX3BtD+sBWQ7yn
 28CEKm60GijV4NCxoGoVeMKC0Sf8StBwwr4A+J5I9CpOWEGVe7UL+4ZqiTLGAt9LWi7Eg/DZ+rj
 R84OBpaZmBlSkqn+Zb4PD3abwGWdcfw=
X-Proofpoint-ORIG-GUID: IoON7dZgXJxF1w6QmIVRmtDNmnEE04w0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270189
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
 tests/tcg/meson.build              |  1 +
 tests/tcg/mips64/Makefile.target   | 20 --------------------
 tests/tcg/mips64/meson.build       | 27 +++++++++++++++++++++++++++
 tests/tcg/mips64el/Makefile.target |  2 +-
 4 files changed, 29 insertions(+), 21 deletions(-)
 delete mode 100644 tests/tcg/mips64/Makefile.target
 create mode 100644 tests/tcg/mips64/meson.build

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 3d7438245dc..0102e74e8a7 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -146,6 +146,7 @@ subdir('i386')
 subdir('loongarch64')
 subdir('m68k')
 subdir('mips')
+subdir('mips64')
 
 image_targets = {}
 exe_targets = []
diff --git a/tests/tcg/mips64/Makefile.target b/tests/tcg/mips64/Makefile.target
deleted file mode 100644
index 042855844a8..00000000000
--- a/tests/tcg/mips64/Makefile.target
+++ /dev/null
@@ -1,20 +0,0 @@
-# -*- Mode: makefile -*-
-#
-# SPDX-License-Identifier: GPL-2.0-or-later
-#
-# MIPS64 - included from tests/tcg/Makefile.target
-#
-
-MIPS64_SRC=$(SRC_PATH)/tests/tcg/mips64
-MIPS_OCTEON_SRC=$(SRC_PATH)/tests/tcg/mips/user/isa/octeon
-
-# Set search path for all sources
-VPATH 		+= $(MIPS64_SRC) $(MIPS_OCTEON_SRC)
-
-MIPS64_TESTS=octeon-insns
-
-TESTS += $(MIPS64_TESTS)
-
-$(MIPS64_TESTS): CFLAGS+=-mabi=64
-
-run-octeon-insns: QEMU_OPTS+=-cpu Octeon68XX
diff --git a/tests/tcg/mips64/meson.build b/tests/tcg/mips64/meson.build
new file mode 100644
index 00000000000..69391c23187
--- /dev/null
+++ b/tests/tcg/mips64/meson.build
@@ -0,0 +1,27 @@
+tests = []
+
+tests += tcg_tests['multiarch-linux-user']['tests']
+
+tests += {
+  '../mips/user/isa/octeon/octeon-insns.c': {
+    'qemu_args': ['-cpu', 'Octeon68XX'],
+  },
+}
+
+# export tests for mips64el
+tcg_tests_mips64 = tests
+
+if 'qemu-mips64' in emulators
+  tcg_tests += {
+    'mips64-linux-user': {
+      'cc': 'mips64-linux-gnuabi64-gcc',
+      'cc_dockerfile': 'debian-all-test-cross',
+      'cc_docker_host_arch': ['aarch64', 'x86_64'],
+      'cc_feat_cflags': cc_feat_cflags,
+      'folder': 'mips64',
+      'gdb_arch': 'mips64',
+      'qemu': emulators['qemu-mips64'],
+      'tests': tcg_tests_mips64,
+    }
+  }
+endif
diff --git a/tests/tcg/mips64el/Makefile.target b/tests/tcg/mips64el/Makefile.target
index dbc5f8dc5fe..78c722a583d 100644
--- a/tests/tcg/mips64el/Makefile.target
+++ b/tests/tcg/mips64el/Makefile.target
@@ -5,4 +5,4 @@
 # MIPS64 little-endian - included from tests/tcg/Makefile.target
 #
 
-include $(SRC_PATH)/tests/tcg/mips64/Makefile.target
+#include $(SRC_PATH)/tests/tcg/mips64/Makefile.target
-- 
2.43.0


