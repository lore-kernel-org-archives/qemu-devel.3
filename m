Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72020C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:48:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJ5Q-00028t-3D; Fri, 10 Jul 2026 17:48:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ5J-0001al-FA
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:48:37 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ5H-0004iv-NI
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:48:37 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AK3Ao71891693
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:48:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=IU/dXqdteTl
 A1FrIqKuRnJRR7zejI3cn8QuU0VYu8hg=; b=WqCdZG4IBPCcXdf2Mm32innsi6V
 XmiYutuH/ZuY4ZuLxVR/mWdNtLONMINgyTXKLQcKRXMJbTqkjgVj/MUBRv+gGeqZ
 QIVr9jqGM6bCT+0hE9LDqFZcedmLk7ev/oO1EHAvqSCU5ltTGSIEW835HAxmPusO
 ND/7cnTqxgK5mSPvBd6uoi4BJhMEc62ylBg8mRi8gGT25RG/IH616VM/Qdn0UITP
 WAHsSnU91BtfL1PwJKFOirTDFi5ko9RPkxUHUeg3K4UMcq9ABdSrHaN2j0OxzyfO
 ZFaK88a6qH5BJif8oi6ar3zMzsLF5Kdea23y8zwLsmqMePNMwVQsqcYO1/A==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb3xvs32c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:48:23 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38dbe39ce62so530098a91.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783720103; x=1784324903; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IU/dXqdteTlA1FrIqKuRnJRR7zejI3cn8QuU0VYu8hg=;
 b=jOd6XtezERtO0VMuvZ2rdyWOT8GGRKPYekPtLv81VjVkAI5R3mMVqKdbtZDpcISuGe
 EAT8KSZMBM/tagsyS6ewFkxtE7wTdYU/wdJY+UPIMsCxBwMrZtjWSim1EfSDUcAqPleW
 OA9lST1gD3IsYBOXFGXNTkZu9dxRjPOE6E9aiWP+IaptoueB+xwlJIxcqQ42l4FwnPYj
 OvGFjNihHdPnNRD+KgdCFq8LqfKTSh8vVgaHTDJ4PZMoKokVijfeS7f6p2AX0P/k8QDc
 WprPBWvSAB5Kt/cuQ6Pjr4fX4BzAc23U5NxAYLl3qgO9J69OrHOCL5ed8ANx+PUv3yJK
 w5qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783720103; x=1784324903;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=IU/dXqdteTlA1FrIqKuRnJRR7zejI3cn8QuU0VYu8hg=;
 b=DnyC5SHd3eMEdNCMkRzHWulSk3X5ZrG+nuM3OqX8JgIIIZPLA5bNsao0OlvSZi6YiF
 4dTSemUr4qMgoQmK6cotrQcDB65Dhjlt42Q4krq1zvrY/JCBRzAXRymUuq75AHlrfNLr
 5mLtY1fZAUwh+9MjAp3Io5PCD1vE72LE7JNndxxubsbPxvdMT3VdhudnGUmBv/GuZWvO
 FrO/PHVVjY/zuuSOk8mCisY/bylIUIyXeeG2tSNycRvVtTCBXqi0h6HWVVx0pmKbJTNv
 +g5qk59ysDnv7DRxW6qX5tmqxeoLHmacW+5tL1St2cQ35ADitB/KJ9RmYsMaeZZuJiau
 CIQA==
X-Gm-Message-State: AOJu0Yx5SJGHtEY6bAGttnhI6pJAPk/FkzZ+PGdVHjVBvaa9pVzBbxPl
 eE1RVlSIRkr9nuLFrR0cga0GVL90xhsRBYHrbVNo4615Gtcoyga0vcAvWH2F5flxqYQVMxXXuOK
 SORM603IaABMCIlhzw8nltspHyCgCmxNiKuzcgjdWbasH15nPUu0x28u9G2dPf7FS0w==
X-Gm-Gg: AfdE7clLQgzzeuoFFrcZYlYGZwhz2PrMH9MnXl95kZERHIEYbSABX9ziJhw0IEGct3M
 ZeOVYlG4iDaVi/xp46d7lFkLP+OQV2HQxw8sU5IBtzjoUMJBkKj5pRQzmYGKgJhgDC5Ku0Y2dl6
 5/dM9vTsME1eyy9MpYaVQ71RGKULSzD4Dh4OFoRsH0y3ZBIzPeOIEio8ovndThfcyJU6aete6UR
 YS4HeQfW4VcyKWBsohWzcGQQHQRUDXYH8xz6vT9W9NNUxbJJ78Fe6mrsw5Ptd1MuYFc83j+nQop
 sNa4ajTsPvEYSFTouuRCULgWiDy28nYdTzIjW0Clqf5NguXIraYnapw4+QeQJManao0PSFHSC6U
 9oGQXteqDPQjAYB1zlaHV6NXFN/c2Ku14t5OezEVIOVSSVyKTZx1OOQ3qNpPL+IKw/ojREw9tju
 jLnZ+67A==
X-Received: by 2002:a17:90b:180a:b0:387:d9cc:7dc1 with SMTP id
 98e67ed59e1d1-38d15c8e9c6mr5526518a91.19.1783720103228; 
 Fri, 10 Jul 2026 14:48:23 -0700 (PDT)
X-Received: by 2002:a17:90b:180a:b0:387:d9cc:7dc1 with SMTP id
 98e67ed59e1d1-38d15c8e9c6mr5526495a91.19.1783720102757; 
 Fri, 10 Jul 2026 14:48:22 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311838c9235sm39886355eec.21.2026.07.10.14.48.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:48:22 -0700 (PDT)
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
Subject: [PATCH v5 41/98] tests/tcg/aarch64_be: user tests
Date: Fri, 10 Jul 2026 14:42:45 -0700
Message-ID: <20260710214343.2065491-42-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ZK8vzH6uhmPQz1aC9Hfqot25Bpe6ozFV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIxOSBTYWx0ZWRfXwEgaDPOASE5T
 MI5vSnN+8lEsofdZW1t1SM/iwIll4PAXXylgx0uhBKuXjzwnBCHRa1BNG4z3bUrnbkfmpuVfJcL
 VMhhMsEMB2AfINcKHr3x1z7PWa5bKzGvKTO8Tz0MaN1rRqmnbvX5SDULLvpd3RpOSARDcpMXOzS
 PpvKHBsIMFzT3lnDI15kk5lHnDh5A2ifOAtc5fpjL9Ud19BmanEotha4ini36Eg8Kx/TVpCqAlb
 yAbBEboReYAGLugh6s4oPahPviZ0RjGGB/XNfHCwUoVe5YaMGNB1uGuzaspVqozkQeUJEQ/YP6n
 w+zUTumtwYPqmt4jDAHqGQiTgC++c3xdiTlxJHljfdYeMKh/Ptzp7DC8j8xTq33vxUkXUNwBPhA
 WnTSnoA9kjRcjMpJSnwq0niA6aDrWn6LxlqjHAFlX5cvUvAql3Hz4jlCWAioRxUY7y9fSEuxE2V
 GJzMmScCdyvUdPMkr7A==
X-Proofpoint-GUID: ZK8vzH6uhmPQz1aC9Hfqot25Bpe6ozFV
X-Authority-Analysis: v=2.4 cv=HInz0Itv c=1 sm=1 tr=0 ts=6a5168a7 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=cU6hyqZTfTbaeHUSQJ8A:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIxOSBTYWx0ZWRfX9Caoo1MWxB0t
 1UZ2L2nZbWEiRxY9j8qlOGLC7jv7k/8UVlyFyoNuIrH7jAPMdfCxeQbF1TS/d2bRQ1ZFP5fqfIj
 4IQSIiVP1FLqRNI4/GPnlfR5vjJOfFw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100219
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
 tests/tcg/aarch64_be/Makefile.target | 17 -----------------
 tests/tcg/aarch64_be/meson.build     | 22 ++++++++++++++++++++++
 tests/tcg/meson.build                |  1 +
 3 files changed, 23 insertions(+), 17 deletions(-)
 delete mode 100644 tests/tcg/aarch64_be/Makefile.target
 create mode 100644 tests/tcg/aarch64_be/meson.build

diff --git a/tests/tcg/aarch64_be/Makefile.target b/tests/tcg/aarch64_be/Makefile.target
deleted file mode 100644
index cbe5fa0b2db..00000000000
--- a/tests/tcg/aarch64_be/Makefile.target
+++ /dev/null
@@ -1,17 +0,0 @@
-# -*- Mode: makefile -*-
-#
-# A super basic AArch64 BE makefile. As we don't have any big-endian
-# libc available the best we can do is a basic Hello World.
-
-AARCH64BE_SRC=$(SRC_PATH)/tests/tcg/aarch64_be
-VPATH += $(AARCH64BE_SRC)
-
-AARCH64BE_TEST_SRCS=$(notdir $(wildcard $(AARCH64BE_SRC)/*.c))
-AARCH64BE_TESTS=$(AARCH64BE_TEST_SRCS:.c=)
-#MULTIARCH_TESTS = $(MULTIARCH_SRCS:.c=)
-
-# We need to specify big-endian cflags
-CFLAGS +=-mbig-endian -ffreestanding
-LDFLAGS +=-nostdlib
-
-TESTS += $(AARCH64BE_TESTS)
diff --git a/tests/tcg/aarch64_be/meson.build b/tests/tcg/aarch64_be/meson.build
new file mode 100644
index 00000000000..9ea111f9885
--- /dev/null
+++ b/tests/tcg/aarch64_be/meson.build
@@ -0,0 +1,22 @@
+tests = []
+
+# As we don't have any big-endian libc available,
+# the best we can do is a basic Hello World.
+tests += {
+  'hello.c': {'cflags': ['-mbig-endian', '-ffreestanding', '-nostdlib']},
+}
+
+if 'qemu-aarch64_be' in emulators
+  tcg_tests += {
+    'aarch64_be-linux-user': {
+      'cc': 'aarch64-linux-gnu-gcc',
+      'cc_dockerfile': 'debian-all-test-cross',
+      'cc_docker_host_arch': ['aarch64', 'x86_64'],
+      'cc_feat_cflags': cc_feat_cflags,
+      'folder': 'aarch64_be',
+      'gdb_arch': 'aarch64_be',
+      'qemu': emulators['qemu-aarch64_be'],
+      'tests': tests,
+    }
+  }
+endif
diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index eef7ae12afb..1996fb0cdf8 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -134,6 +134,7 @@ endforeach
 
 # Now let's go through all architectures
 subdir('aarch64')
+subdir('aarch64_be')
 
 image_targets = {}
 exe_targets = []
-- 
2.47.3


