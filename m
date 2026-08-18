Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57C6CC5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:30:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPTx-0005qf-21; Tue, 18 Aug 2026 15:28:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPTu-0005bZ-QS
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:28:18 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPTs-0007Vj-RD
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:28:18 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IHJG2x735618
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:28:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=DQFHNic8spI
 vrmtK3rav7cniBYL2dwCI/53LhaogpS4=; b=BEvu54p5U+2ooZYJG7ZnnnmALxY
 hfWL75HvN81LGFrpD3LU1V/3mIvup3r2kL0Xutm+uQkOP1fNiKwbf14qCqZ6WaPU
 BJ2dhavSsUM8X4jEKlzxk2b9q1LaDgoBS+Vivyi2gWoH4lE2dG+4XGx/4CNt6vJZ
 CyH5FNKNVhfAt9bbsdqWQlCCnw/yBbGjAyzc8mPOGRzh1UfAaVaZU5J+O6tBVd9p
 xA4VH6fLPAnZN+Fn+utvo392V+/lbX1D1DQwe6eIVtQiKIM3C35256yfMM7t3wCK
 guTyrrAuvByLdSyhfWYZWoG5QmYnqtFxvkNcpicE7mQu/Hz18dHH49p754g==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4reshmbt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:28:15 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2cf7dd9fd91so1825855ad.1
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787081295; x=1787686095; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DQFHNic8spIvrmtK3rav7cniBYL2dwCI/53LhaogpS4=;
 b=PhwDc37S1MX2JFmcLyvyFhpTCyhW30yI9+yjw/dJpS3slLVelxhzS1WIQuddTVxSsG
 w1YmLKX8k5kF5AG7ZpQLgyGoyyAhR99wvrl65o+vNAoskulxkwTnAbYUH7Z5cWsvRgK4
 dyuk8KwtbAan2GQMdSfg7+8NADnUkLzTK5LCZKMjf+UwzVqTgFBzfgMbSjX4HEQMZyS5
 U3VpyG6BAwSst8uv0OR6Zr9Z1e8WywC+PhpQa5zTE9lGyx63B6MaScwzW6q4Z/YCyJiz
 lUkUPyN68ZxJf5fDB/59nH1vpFLbK0+yMfkNdmqSjrhMElRzwCfH9cFlqzsN9nuhNMbz
 xqXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787081295; x=1787686095;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DQFHNic8spIvrmtK3rav7cniBYL2dwCI/53LhaogpS4=;
 b=Ra7f4Ltb8Oebe1Yp6DsEdJWqaVo4a1NwKk8GXb81ylh2LXwv6/37SFDHMbTLCNpvyA
 g+3T99+10dqz5/qerESrj4p+oi9GpLoJ+rjy5h+7xZFMGi+5L8AI6NHxn4N0+KrKoBoq
 9/5ADLGcF5MT5odcY33N4yJHTdORq7Pa6yV+oXKTNKVwIkmhcMJbiz08YoF3A77YyOV7
 lBfTby8b1nPFLdF8dQ5P43LUEWXM3WetxNNDBsSUuu2unM324QVfnsoL7/GgTiMldMaw
 rymJ0KBMeipj74paCfY2mTQVp1MktvJlUV1OANtwLptdKYt1nJJrsso5R3lHDOkHIEoU
 ZHpg==
X-Gm-Message-State: AOJu0YzPRz9ooDqizfTxhm5sqjZ2+Dn69CS+++G9gEq8IjOd60fTA9wf
 rFPooeeOusec7XeJ2FgkODZSqDhM9vzY4CI9aTgO78Z6hMqX4od8sN1ZTcJpf89cywKFIgCrp9o
 7GHz9wmTTc+WdB0z7H61pYanKp5fJw/jZGOP9a/LOpw/X5tv9Bz4tYCnvsuOTjohSrw==
X-Gm-Gg: AR+sD13tQuX6HVQa/QHMWWZl/GmrH/FCuvbAzLiSIu2EyucDCYNsxFT2/VKDQdHPgtz
 BCFXFxqHajYcso1KguVxiUG5HbeJ0doi0jEZO2DtK4DoSH49YYrgR+pRyP5EoIW19K/fkB0L8JO
 H6mJlnyK8OYh7fPm7116/bAxglS5RqS5QyTeKH6S02ti1xMvgsFMjlRre2z+nND1NxElrHoTaX1
 itn5NBd6KPOLnbOdkGpVscw5Oyw9whbEihfsa8gEg78dHaCTlFW7EPTF4qDqxSix60Z2mkA0Etg
 WAnoG9RLtLJRYjLqlKZOB2162Cx5lXoQyv33lRfBNQeK9ZkfnqomrZtAYvsp7wUu0dtpaLEYiXy
 MV/bbB1fysW7p9MRYCF3qdK182OuVqHHqZYS6dfAjSRFJIIR0mieTOEvzqJ0=
X-Received: by 2002:a05:6a21:2d46:b0:3cc:c7cf:5a44 with SMTP id
 adf61e73a8af0-3ccfec0dd57mr354364637.2.1787081294583; 
 Tue, 18 Aug 2026 12:28:14 -0700 (PDT)
X-Received: by 2002:a05:6a21:2d46:b0:3cc:c7cf:5a44 with SMTP id
 adf61e73a8af0-3ccfec0dd57mr354296637.2.1787081294060; 
 Tue, 18 Aug 2026 12:28:14 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-326794c0c94sm36782451eec.9.2026.08.18.12.28.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:28:13 -0700 (PDT)
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
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>, Song Gao <17746591750@163.com>
Subject: [PATCH v7 058/104] tests/tcg/loongarch64: system tests
Date: Tue, 18 Aug 2026 19:22:22 +0000
Message-ID: <20260818192309.22169-59-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Ne/WEWD4 c=1 sm=1 tr=0 ts=6a84b24f cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VnNF1IyMAAAA:8
 a=Byx-y9mGAAAA:8 a=EUspDBNiAAAA:8 a=FVW9kWhLySRIolcT2UUA:9
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: HagpwvcBevmxB-evAD6Az6QODE6ht7St
X-Proofpoint-ORIG-GUID: HagpwvcBevmxB-evAD6Az6QODE6ht7St
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX+DeFhKy8coGX
 GtjsTaTgjSuCtQj9VnfRxdPcr3qBMq1VaZoht3o63Eh2NFp4PLhMKiGrZEm6xU1U/GdxtfH4E/J
 XofGBHGFiC3ddPOZQYwFX0eXAThk7M0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX3NrBkelbX8Qp
 KvgcyugEE+RihzmPXl0IiwQemYWJSJ0Dn/lzOGP2FZ0oPTwzB9e/KI1dtUwW2jJkvE0NGTx5ndz
 uL40MCOsl97FNmK4EQ1n73lh5oH4S5FwF+sYWcq6qBC7QthMXFcZsgxFM3tclD3sGK8P7Sa6e0q
 R1RDRK635bBFZPQt8HnhS9zve4qrrEkikSTXhRTWPTS6R6fN5iiVBn63Fl8Mw2vZORE8aAPqT78
 Mopzv+wt0kdesgvD81rU887nyH2yRpbOiKmKXrsQk3ifDN+mXHK0FjauMvI0+gcgHNCv930iEsX
 aP0GP1EdkYIdKLotxpGZPSuZSNJgxzJMVWc5/wAJBpGK6DECMxSsN7GEKdw/Lf7kIvF+CMYk1hP
 jFDzD4tRtBbheT2vsh8+beGD6tUdLGHPaJz4nhjK9sFepbw7ndbBWop4xW9BqZ/iWvFwvr22G6u
 8Z2GUAeJ1BVW/ivWG+A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 suspectscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0
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

Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Reviewed-by: Song Gao <17746591750@163.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/loongarch64/Makefile.softmmu-target | 33 -------------
 tests/tcg/loongarch64/meson.build             |  2 +
 tests/tcg/loongarch64/system/meson.build      | 48 +++++++++++++++++++
 3 files changed, 50 insertions(+), 33 deletions(-)
 delete mode 100644 tests/tcg/loongarch64/Makefile.softmmu-target
 create mode 100644 tests/tcg/loongarch64/system/meson.build

diff --git a/tests/tcg/loongarch64/Makefile.softmmu-target b/tests/tcg/loongarch64/Makefile.softmmu-target
deleted file mode 100644
index 6d4a20fde73..00000000000
--- a/tests/tcg/loongarch64/Makefile.softmmu-target
+++ /dev/null
@@ -1,33 +0,0 @@
-#
-# Loongarch64 system tests
-#
-
-LOONGARCH64_SYSTEM_SRC=$(SRC_PATH)/tests/tcg/loongarch64/system
-VPATH+=$(LOONGARCH64_SYSTEM_SRC)
-
-# These objects provide the basic boot code and helper functions for all tests
-CRT_OBJS=boot.o
-
-LOONGARCH64_TEST_SRCS=$(wildcard $(LOONGARCH64_SYSTEM_SRC)/*.c)
-LOONGARCH64_TESTS = $(patsubst $(LOONGARCH64_SYSTEM_SRC)/%.c, %, $(LOONGARCH64_TEST_SRCS))
-
-CRT_PATH=$(LOONGARCH64_SYSTEM_SRC)
-LINK_SCRIPT=$(LOONGARCH64_SYSTEM_SRC)/kernel.ld
-LDFLAGS=-Wl,-T$(LINK_SCRIPT)
-TESTS+=$(LOONGARCH64_TESTS) $(MULTIARCH_TESTS)
-CFLAGS+=-nostdlib -g -O1 -march=loongarch64 -mabi=lp64d $(MINILIB_INC)
-LDFLAGS+=-static -nostdlib $(CRT_OBJS) $(MINILIB_OBJS) -lgcc -Wl,--no-warn-rwx-segments
-
-# building head blobs
-.PRECIOUS: $(CRT_OBJS)
-
-%.o: $(CRT_PATH)/%.S
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -x assembler-with-cpp -Wa,--noexecstack -c $< -o $@
-
-# Build and link the tests
-%: %.c $(LINK_SCRIPT) $(CRT_OBJS) $(MINILIB_OBJS)
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
-
-memory: CFLAGS+=-DCHECK_UNALIGNED=0
-# Running
-QEMU_OPTS+=-serial chardev:output -kernel
diff --git a/tests/tcg/loongarch64/meson.build b/tests/tcg/loongarch64/meson.build
index 209179fd96c..1d62de64ed6 100644
--- a/tests/tcg/loongarch64/meson.build
+++ b/tests/tcg/loongarch64/meson.build
@@ -2,6 +2,8 @@ cc = 'loongarch64-unknown-linux-gnu-gcc'
 cc_dockerfile = 'debian-loongarch-cross'
 cc_docker_host_arch = ['x86_64']
 
+subdir('system')
+
 tests = []
 
 tests += tcg_tests['multiarch-linux-user']['tests']
diff --git a/tests/tcg/loongarch64/system/meson.build b/tests/tcg/loongarch64/system/meson.build
new file mode 100644
index 00000000000..5bf4c56e385
--- /dev/null
+++ b/tests/tcg/loongarch64/system/meson.build
@@ -0,0 +1,48 @@
+tests = []
+
+minilib_dir = meson.current_source_dir() / '..' / '..' / 'minilib'
+minilib_printf = files(minilib_dir / 'printf.c')[0]
+link_script = files('kernel.ld')[0]
+boot = files('boot.S')[0]
+cflags = ['-nostdlib',
+          '-ffreestanding',
+          '-Wa,--noexecstack',
+          '-I', minilib_dir, minilib_printf, boot,
+          '-Wl,-T', link_script,
+          '-march=loongarch64',
+          '-mabi=lp64d',
+          '-Wl,--no-warn-rwx-segments',
+          '-lgcc']
+qemu_def_args = ['-display', 'none',
+                 '-serial', 'stdio',
+                 '-kernel']
+
+# Multi arch tests
+multi_src = []
+foreach t: tcg_tests['multiarch-softmmu']['tests']
+  foreach src, setup: t
+    new_cflags = cflags
+    if fs.stem(src) == 'memory'
+      new_cflags += '-DCHECK_UNALIGNED=0'
+    endif
+    if src not in multi_src
+      setup += {'cflags': [new_cflags]}
+      multi_src += src
+    endif
+    tests += {src: setup + {'qemu_args': qemu_def_args}}
+  endforeach
+endforeach
+
+if 'qemu-system-loongarch64' in emulators
+  tcg_tests += {
+    'loongarch64-softmmu': {
+      'cc': cc,
+      'cc_dockerfile': cc_dockerfile,
+      'cc_docker_host_arch': cc_docker_host_arch,
+      'folder': 'loongarch64/system',
+      'gdb_arch': 'loongarch64',
+      'qemu': emulators['qemu-system-loongarch64'],
+      'tests': tests,
+    }
+  }
+endif
-- 
2.43.0


