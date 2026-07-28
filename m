Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5619C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:53:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZnt-0005o0-TO; Tue, 28 Jul 2026 00:52:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZnk-0005bv-3T
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:52:24 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZnh-0002Vg-Q9
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:52:23 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S40iGk1594052
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:52:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=hhGBQeQs+Lx
 r/lvJppeyIgOXovAu7tjMnbbbFZCRSA4=; b=VDP6i3Yy1vR4U0bJRczoL5DmKYQ
 yJZs0nmPUuLSAQR2SlWHdzT7/nUQoCI3edkES8nBgE4x+3puILwh6J4F1U63+vky
 eIdfQh/sM6WLvLDOxCtSQAqUJLYmQqXOl+eUsgHw1PdfiG5brYrZracIv0t+DAPX
 saMoVOmagIQit2G7wP3B8mw3uHwtd/jnGUx/U8FP1FI4/zyjY5cfGHLW0fgFPmr8
 y1W33G6w66894xLthaZjCycaEvp8EOKq6Zx6UlvBDOwZlhrPz/LIhHQ50iU+Wdoy
 PMBQGlS0NsmiO/f2rZhJH9FKCh2qtGWqlc9BmNKQ4N13KS+KYIvyBrqV5SQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpn19g52r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:52:20 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cb6ef846b33so484011a12.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785214340; x=1785819140; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hhGBQeQs+Lxr/lvJppeyIgOXovAu7tjMnbbbFZCRSA4=;
 b=Cd/xBgGNNklNtvx1iFdDjUv1zQgg+yxutVceKHOexW5omM3M7hh6aXnnJSPBIMkVqH
 GmJCuB6JBjMsRqDLxUL22Q5SU1EKsDkbUTHDUn6MTLl+5lDGsGjIZ+NSXsC3+350ERE2
 kTMocWwL2N0jSZfWHC/kKTtqUSRRTa9gtMglyFZcLvhFjOopyYZ5Ud3dd828NryTmFx3
 dkBll7X/OgG4irPpfHTnTK+bhVTU60TPtHcMfAyBDJBJLttepSoB2+Ib0Ywt+RdSZHv6
 O21lIYnokB8IQ+u/4YHR5DRWwOwvqxeqvL7Xosb2ylLHN4tXk6OrNTxiPtHEdS+2V2+u
 C77w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785214340; x=1785819140;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hhGBQeQs+Lxr/lvJppeyIgOXovAu7tjMnbbbFZCRSA4=;
 b=pm6yPvL9xnvEln6N7zEfJqajilA/x4AlRNOgM5MZePSApNq9goPIt9dapvROXI3uRI
 8aHzo7gPPXFddnJAfMmdWsf2OO1SrA8HpJ4UTsvfYRHr1PMjFOEkKvwf5CxeLeZdNiIU
 4IiLt2hqKA0yNZme9qbB54DyAohnc9tss7LWsRZEQn/uhM8lIaZFT/Z0G/IwyiifHCjL
 ppTO9jrVXiStWaGDYFxZAH/WK+panF8w9NfILI8Ie/YKR82eVLSUIybkLD32QB98Br5G
 8WMbRqF9mR0kmZC7yBwiQKuufKrjWWjAu9ZOHUw2ayabnU658D71mS2NWP6dMzRNptSb
 aZCg==
X-Gm-Message-State: AOJu0YzYYtcYPPjBZSCFi+L8RFoMq8P2qdQereIVL922s8NkU5WxHxO0
 Ys8utmB2IYbimfGlrx1xhGhXDMnmIS9/QO/qxKS1gMl7l/Av9USOL9wvQkeMbyhJtSj4T9QUMGC
 MZf52mCjAhuYtmIy9Hu4X38a1f9bYv2bqDJ9VjlFUKCUf0SW7Hz5dSqInP3K8P/6ihA==
X-Gm-Gg: AR+sD13adad4WC1pSZPfyhxDa5jGZk3ZReAHR0aXoRWnq+U56yL9OUIVCn900HOUYe3
 noYiUuWFs5C6NXZijRqc9UHG20J6e3faUh1XLn2FgNOasbx6ivy15r32H9/UuxUyH7EdxveSEDi
 2cTPZFq0EIyPTvDPo6C/CqPpya2mS70GaB5PKtF80kqvhan5Q+30Cx3hUBYxVqAsvQzyIpb7TdP
 Xx0I/wlsFr26GPv6nk2GpPLpN6QUzzMEVq7P4NTYT4vEL4k2Ifs/EqGjMeVXIkMr4OHK8KZcKFL
 A+I+DvgYaPiqF7HPg6cyvR5f2oorRcVX+Gh9ltdHnfYAhSzNxWDQeOIyIp0rCv+Vowb8uIlU5yU
 1intZT2sC1VdBX1UgFnrpEbu+eXqiUk6dkIyDDebLvvvh3DSv+v2AGtcXPTj5lisKCx0+p4g=
X-Received: by 2002:a05:6a21:4cca:b0:3a0:c246:bb98 with SMTP id
 adf61e73a8af0-3c8ba630309mr1164210637.29.1785214339864; 
 Mon, 27 Jul 2026 21:52:19 -0700 (PDT)
X-Received: by 2002:a05:6a21:4cca:b0:3a0:c246:bb98 with SMTP id
 adf61e73a8af0-3c8ba630309mr1164171637.29.1785214339405; 
 Mon, 27 Jul 2026 21:52:19 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc3e878esm38900559eec.3.2026.07.27.21.52.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 21:52:18 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v6 080/103] tests/tcg/riscv64: system tests
Date: Mon, 27 Jul 2026 21:42:24 -0700
Message-ID: <20260728044248.137626-81-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=TJV1jVla c=1 sm=1 tr=0 ts=6a683584 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=zzQR_8oM-p7h9UWrr-IA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MiBTYWx0ZWRfX6ZXqhW0gMo5k
 95KAZUS3aX02WWN8Dgh070yaR/OubZ5V/Ko5oRWY/3jRKWtdyWSDKaTZ5XCw1TCxOT/KFwlNdai
 PMqJ1KsoDafPRIXetBujM6LBk7U5V5LXSgX6LKVN6BGRXy0gpQCVryQbZrPx/bj8Bud5jidHfrn
 SJ7cpspspNdCchn2CarxWT9Z2BElLHGYRvFQ06ja6QAgqhkob6w5nStViJa089URAFELe5Xqq5A
 0tV7/YwQ+RUUOO9xjZMtLQvodROC4g+SfIEjNbVBWSN0UFoT6y8F64+ZEU6VC080CGDyMi2uPzi
 +VT70+Ybu/JC/vSzYJl8bCaCPrGoOCrcj09ozH7dBpaUlzU7kNmkMuOfKHCDhQKPb8HDLAiaAHA
 cksWrJDj78722g3rgRH6aKV6l0Cx/RIh+QasYUYgVuA6+w2O3oeWw3rhASZcPN8Uqh0H70E0kwz
 pNGjdTzFKHeiJ7tHWeQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MiBTYWx0ZWRfXwXDl9dUl2xUb
 Em/Ym8UC4rLVxwVaBrnNLkJff/V0jCunOLPy8Q0WDey4fWd7tA4XMI9UUoQ8yLEUSyzgvWjIvyt
 tGaJDs4Qzp84urrSVPhaFBlaqtPCA/o=
X-Proofpoint-GUID: Nmstf-EEPrbJgDH6_SazhYdqEbhBOIqI
X-Proofpoint-ORIG-GUID: Nmstf-EEPrbJgDH6_SazhYdqEbhBOIqI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607280042
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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
 tests/tcg/riscv64/Makefile.softmmu-target | 45 -----------------------
 tests/tcg/riscv64/meson.build             |  2 +
 tests/tcg/riscv64/system/meson.build      | 38 +++++++++++++++++++
 3 files changed, 40 insertions(+), 45 deletions(-)
 delete mode 100644 tests/tcg/riscv64/Makefile.softmmu-target
 create mode 100644 tests/tcg/riscv64/system/meson.build

diff --git a/tests/tcg/riscv64/Makefile.softmmu-target b/tests/tcg/riscv64/Makefile.softmmu-target
deleted file mode 100644
index 82be8a2c915..00000000000
--- a/tests/tcg/riscv64/Makefile.softmmu-target
+++ /dev/null
@@ -1,45 +0,0 @@
-#
-# RISC-V system tests
-#
-
-TEST_SRC = $(SRC_PATH)/tests/tcg/riscv64
-VPATH += $(TEST_SRC)
-
-LINK_SCRIPT = $(TEST_SRC)/semihost.ld
-LDFLAGS = -T $(LINK_SCRIPT)
-CFLAGS += -g -Og
-
-%.o: %.S
-	$(CC) $(CFLAGS) $< -Wa,--noexecstack -c -o $@
-%: %.o $(LINK_SCRIPT)
-	$(LD) $(LDFLAGS) $< -o $@
-
-QEMU_OPTS += -M virt -display none -semihosting -device loader,file=
-
-EXTRA_RUNS += run-issue1060
-run-issue1060: issue1060
-	$(call run-test, $<, $(QEMU) $(QEMU_OPTS)$<)
-
-EXTRA_RUNS += run-test-mepc-masking
-run-test-mepc-masking: test-mepc-masking
-	$(call run-test, $<, $(QEMU) $(QEMU_OPTS)$<)
-
-EXTRA_RUNS += run-plugin-doubletrap
-run-plugin-doubletrap: doubletrap
-	$(call run-test, $<, \
-	  $(QEMU) -plugin ../plugins/libdiscons.so -d plugin -D $<.pout \
-	  $(QEMU_OPTS)$<)
-
-EXTRA_RUNS += run-plugin-interruptedmemory
-run-plugin-interruptedmemory: interruptedmemory
-	$(call run-test, $<, \
-	  $(QEMU) -plugin ../plugins/libdiscons.so -d plugin -D $<.pout \
-	  $(QEMU_OPTS)$<)
-
-EXTRA_RUNS += run-test-crc32
-comma:= ,
-run-test-crc32: test-crc32
-	$(call run-test, $<, $(QEMU) -cpu rv64$(comma)xlrbr=true $(QEMU_OPTS)$<)
-
-# We don't currently support the multiarch system tests
-undefine MULTIARCH_TESTS
diff --git a/tests/tcg/riscv64/meson.build b/tests/tcg/riscv64/meson.build
index b5f574c1377..2292bf8ed1b 100644
--- a/tests/tcg/riscv64/meson.build
+++ b/tests/tcg/riscv64/meson.build
@@ -2,6 +2,8 @@ cc = 'riscv64-linux-gnu-gcc'
 cc_dockerfile = 'debian-all-test-cross'
 cc_docker_host_arch = ['aarch64', 'x86_64']
 
+subdir('system')
+
 tests = []
 
 # Multi arch tests
diff --git a/tests/tcg/riscv64/system/meson.build b/tests/tcg/riscv64/system/meson.build
new file mode 100644
index 00000000000..86ad66db358
--- /dev/null
+++ b/tests/tcg/riscv64/system/meson.build
@@ -0,0 +1,38 @@
+tests = []
+
+# Multi arch tests are not supported
+# tests += tcg_tests['multiarch-softmmu']['tests']
+
+link_script = files('../semihost.ld')[0]
+cflags = ['-nostdlib',
+          '-Wa,--noexecstack',
+          '-Wl,-T', link_script]
+qemu_args = ['-M', 'virt',
+             '-display', 'none',
+             '-serial', 'stdio',
+             '-semihosting',
+             '-bios']
+
+setup = {'cflags': cflags, 'qemu_args': qemu_args}
+
+tests += {
+  'doubletrap.S': setup + {'plugin_test': {'plugin': 'discons'}},
+  'interruptedmemory.S': setup + {'plugin_test': {'plugin': 'discons'}},
+  'issue1060.S': setup,
+  'test-mepc-masking.S': setup,
+  'test-crc32.S': setup + {'qemu_args': ['-cpu', 'rv64,xlrbr=true', qemu_args]},
+}
+
+if 'qemu-system-riscv64' in emulators
+  tcg_tests += {
+    'riscv64-softmmu': {
+      'cc': cc,
+      'cc_dockerfile': cc_dockerfile,
+      'cc_docker_host_arch': cc_docker_host_arch,
+      'folder': 'riscv64',
+      'gdb_arch': 'riscv64',
+      'qemu': emulators['qemu-system-riscv64'],
+      'tests': tests,
+    }
+  }
+endif
-- 
2.47.3


