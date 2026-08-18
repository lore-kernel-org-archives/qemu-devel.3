Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A42EDC5DF85
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:27:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPTU-000399-L1; Tue, 18 Aug 2026 15:27:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPTT-00032m-IA
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:27:51 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPTQ-0007Pb-Tw
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:27:51 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IHH88B2494684
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:27:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LZeClEfY8sF56ncwMJmhY+JHbLHZ/Vvs6BSKHUh294Y=; b=kMT3F0eE11uvIKii
 syIhtDwvaSLekrleiYMJzjLpzv4DWkgfTnx34BgJx1K+JQSjjA/328fzFF5D5JGL
 lMYy3J0bES8rwSzYJU1492SlAEkasu8bI4aCTH/Rz3C7jb9yJD1MHpNGgsBMT2KI
 uIM3iO6BV3DaVCqAvo5WifUQ7U7qqYq+IdE1KO1H7u7pWytbPPslWPjXrcNE2n3A
 y6yc3AOpGSSHHp6c7yN16DIDk+ZzNghdVvd8N81K2Qk1sMTMTKJinmlIQFzUaPP0
 YsH1N+HujVMUNG5F7QZRUOMR9eNnIoKw3MhIq8VWbjRJPmI8hhEsGyt6++fK1BBB
 qLkmDg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4sfnhajm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:27:47 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cc15155cde2so109533a12.2
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787081266; x=1787686066; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LZeClEfY8sF56ncwMJmhY+JHbLHZ/Vvs6BSKHUh294Y=;
 b=XGtOI2Z2Bnku5oZkvSe9t4YmTg5BT86DGm79+z4016Bhc6BDBK5rOBs2K7ZLx/S5NA
 yYzbVMCQWc+n+HrafQ+t81ZJWRFqaW0pb/OBdsDQYvfR9WNTuvq+CLne9XlZvyr41HMU
 qfcVo6VMgzMtEnK2+d0rPaeROMM0JSr3vpnqhz4Mb2hor8fu/vVJbh5pkGuGhu4sQ0ta
 zivl2H7yE9CAV9V3QUUwMbNOHahb6RqMtnx0SQxDorVW2cJJnPDSJh1vwMngPs2oYjL0
 RqinQxG2gU10pmkOEZOu3CEAh09yaP4eeDtrwAM4+3u7LceJt38cFrtSpE4MQzW/Si/A
 j6Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787081266; x=1787686066;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LZeClEfY8sF56ncwMJmhY+JHbLHZ/Vvs6BSKHUh294Y=;
 b=LXfyt56XXqwEBCyQBoZZtNyTShnmBA1KPLHce3kJmYF8gsrIjWzxNRmgBqAd6Bd5y+
 KfOw5L2t/LZJLRPbQIsQreFk/hLr0WjXdgM3jx+f59FdgKe9E9fUz/sD4GuOZXg4Ef17
 h3I1Hbqqr6r5Bdj/wPZQV0nfngLnYeDLIsOZDiwo17hBN4c3x3S2VEAKG2qgf1dqS1m4
 Q4S3eZIft7n9cmcRDOyteaMcxrN1jWa0SsSH9BggWZgO1CGtSiscE3yRHHjf/djg4K6M
 sgIAHdeAZMOk2+L2r0V9g9wDPoH/8T/g7BlBcshB45BxVbFxqENoP5lSYCeUWEa9IVOB
 4Qsg==
X-Gm-Message-State: AOJu0Yz4DFuIP7YKjpgXXQx2rWMBtdjVxBsUlWiL1pa2VzpH6XAn8WEQ
 jzkMRAMjoAROmCdLj0KMUBKT2+QEaVJ8ZhOn5okUhj6BN4dVQcfD9eBvfbrcdTA0d+RWKlizdNE
 faF6NEbKwcT636bYIPGwRxowmJuWCTH1pSjRtXrbe08rbB94d7hjspjGTYIORvz15eA==
X-Gm-Gg: AR+sD11pe/pDCMmpZy0cVlCcwgUCC8gf8911I83fPa5ME9u9bHS/pB7aA3c5Kc4sgBQ
 HH2kD1O9bddyrl9g9UNYx6mgQWPfz/bOz746TQYWwSE0jNlNGWsM2ccVTRcg6jtthiHCAB17+76
 3Amy98Ryf8ZXwiAJsRKTE6gCCXPhXeYDwyhQZoOndoFFKZXdHpeYUPqUwKzKfxNkFYAxKFL0csG
 CeOODzZ/VJ2QJNEw+XACtqQ/XG/Od0+hsnxslIuqFxT8NBD7p6B99qG0nyi2TCvtma/iqO1l10A
 zN+BoA+CBjR4cmYJ1KYXtjUEygwxET+DMOWxuKTg1jCw+pqOkiBF/mXvuXRDlktdW+h2Qx5rABV
 GqqKQMGDi9M2aRVD1i+JCop5AQOnhdL9cLEQLl8RBF+zoIAMixmyJh6bAyNA=
X-Received: by 2002:a05:6a20:b7aa:b0:3bf:8de9:c647 with SMTP id
 adf61e73a8af0-3ccfe675dbfmr522966637.0.1787081266383; 
 Tue, 18 Aug 2026 12:27:46 -0700 (PDT)
X-Received: by 2002:a05:6a20:b7aa:b0:3bf:8de9:c647 with SMTP id
 adf61e73a8af0-3ccfe675dbfmr522893637.0.1787081265988; 
 Tue, 18 Aug 2026 12:27:45 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-326794c0c94sm36782451eec.9.2026.08.18.12.27.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:27:45 -0700 (PDT)
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
Subject: [PATCH v7 043/104] tests/tcg/aarch64_be: user tests
Date: Tue, 18 Aug 2026 19:22:07 +0000
Message-ID: <20260818192309.22169-44-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX7NEQ7ZOoiYpj
 5WAN/h974iyUgAkTnMI144ZmMJO71H5t3S7yydB/mcvprb8k8elQ96UI4+Ya1isoyq8s9KXNqOI
 dGga3gmLP5PPEI8nT9kqn8B5T/iiS9M=
X-Authority-Analysis: v=2.4 cv=MpliLWae c=1 sm=1 tr=0 ts=6a84b233 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=VnNF1IyMAAAA:8 a=cU6hyqZTfTbaeHUSQJ8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: vFpKWhQ9eO4e-7J4j0ogwIbmFwMw70Kg
X-Proofpoint-GUID: vFpKWhQ9eO4e-7J4j0ogwIbmFwMw70Kg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfXxhv6B3MUVyii
 LYsLl3qailiI/3LR8V0uvuui+nXHQ9Q3sokcYlaoOua0VoKVe6eJjgQfc8jQUFTQLCV35ol/AFV
 Xq1Fi7k6rNOX7Nayi/Frk+9E14FcMzbOhywtFzTpb8h90kDQEXuef9y4funmZAx6D59JJhOqf15
 Y4367VvT/Wk41UvQNvRV1J2X00cPYWDsRQU4y1iuUKtBWv6FEAzI9Qb/8I9bHHr5DnlSS9qHBD+
 jOnPao/XADxzIYMRjHMoa+44+qBYNHh0IZi3RQ05DQoYJ6IsBZOliXDtdJs2+1pedRaD3nmsNtj
 KATcs39J3y2WT8kYkwBL7l1U8Ob2pu945pQCmGWKMoHVNzpl88oUY9wqZWlVHkv55/H8BA9OLQO
 WSMKeD/0CRZo2O/yqe6sj3FvzRR2rcIcT4Vrc4ocdf/PLyE1Z+7ntrFlW7dR2QWTsuPs3BbHmSP
 kXFi3WcJoQ30OFw8nkQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 phishscore=0 adultscore=0 spamscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180142
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
index 76d7dbe045b..d878581b660 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -137,6 +137,7 @@ endforeach
 
 # Now let's go through all architectures
 subdir('aarch64')
+subdir('aarch64_be')
 
 image_targets = {}
 exe_targets = []
-- 
2.43.0


