Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 240F3C44506
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:52:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJ6e-0001lg-No; Fri, 10 Jul 2026 17:50:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ6b-0001V5-Pq
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:49:57 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ6Z-0005Cb-JE
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:49:57 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AK3Ehn1892273
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:49:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=hhGBQeQs+Lx
 r/lvJppeyIgOXovAu7tjMnbbbFZCRSA4=; b=eokv3v/RISJAhiGy306j3XngLwd
 SWxAXi4nzmPH31IpQCZPzZ1rykHxeoxTfovpT22949frjvUSnLICBhy1tPtjjpm2
 5lm2Ahubvv/0PoXUCu+XLHyjbP+UQjUsoLktwnGeE6eet3fKnBZOpFI8RooNass6
 F/v1imowcbIWWflgtlpGI7gOjFEL8jDQwDMcngbn5S6dFzwe15BRWU/iav9Aycus
 tZE3x3HD+obunblGxhHjC6kxdUgWuzwMIPkfaBCZ8sdTne8arSbCQWv+B0azx0Al
 LFlFWJjXn2/7QUou7U9OUjX63mYnIqVbBLBIelAA9A9+cpNvy4SatWthsYQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb3xvs37t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:49:44 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38c7e2730d6so1661976a91.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783720183; x=1784324983; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hhGBQeQs+Lxr/lvJppeyIgOXovAu7tjMnbbbFZCRSA4=;
 b=MP5HvUde1XS0G6pIEBjgb6qouS46VddRugIIIXGlon7toMS2bdW7wdEuyH+n0I/Ni5
 TdYtaTCk3hKp55RPUmbEEa7KjyKDvczM5ExZDylkmYNwFpVtrhOPiB4Zx4mBSM/lxcaq
 N3lUgGoQYsYHfRy5rNrMn5gqjqHNJllqOfVbvV9+WN/MgoR91HNA9Mp8XnEQqWM2cx9S
 us5uV25VO8ZfaTLOayjzwqBdB3kO5HfFglzBaPiZsAyohagudVybyDFh4gll3Qy6VllG
 wVoBs4HK4kQJewlqIBRQ0cJ0cHcicc+U4HRjCrKgbIrtEZ4hOqgrqgvC32pxPVlTc+q7
 A10A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783720183; x=1784324983;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hhGBQeQs+Lxr/lvJppeyIgOXovAu7tjMnbbbFZCRSA4=;
 b=XQggRBYhGVk6XbOHRrTP4tDHij4e8GKJ/wHMbzY9adHLj41iC01CR2TB9EczHV4LI/
 cnYMQ6uxdpEzGMpLSjI5OkB7VHBRZ8U4RE5qHLI94dUeNWdq/5MIvnfMiW0eVNCNnmuf
 1acroqg6/AFWVZbOGAYaO+yR8CNBAjpyeFJJ9u7m7r3QcFk51TCpSVqxHbfv5bYZaFkJ
 Fp1R9P2EnO9OOAQZ4nUHQm/pD9W9GMNWu5PzzZqZ5uUpi+f4eNqIzlMn/1QYjCrqHK4Y
 riD/oPxDMA+JACh0MgZvn4APohobxpn/92dae4MCFhcngrfgE+7ydhNOiBqoR97G8eF8
 rBTQ==
X-Gm-Message-State: AOJu0YxtOlWgPR57soeSg58wEJn471cHbSeYK9OQvKP91umr+8c9/w4U
 w9KliL1e+Oz/vnqespq5GcQcE8/g2AEWlzUsp9TZ3dNCqYxF3AZj0cV6MzaKint76arvufYC76L
 pZSdSAY47QfJGmHRbsXV36ymNtO4N6Ez5q3frVSfXqke/0+KvctJaJzBoF4Zwk14XLg==
X-Gm-Gg: AfdE7clEdHfqWxmUDR1SIlfz6uCe61QIyBAA8P1VoqwFpkejBw6HlqaI1ZggHszPOuS
 RPEJxK0n9NBBdN5gWNrdUXSmWIcOlr6rOmiX/TW4Py4y+3bzy6tzBLCo2KWEXygHj+O1t9qrgAx
 OL1TJk4WH+eR2VW1/+y2wZdv79ZDzNZlGEkW4KqCkdMKtdfXSaMOXEQhWp0pauxod6m26w7ka0C
 bYHRSRHY1D7PI+Imeq2GJQwkMVyXeURTGryUvfb+6ei8v75bfarDx3k6TjoZJj4Trv6c9X5ovuZ
 CH/UYwAHyVkhtxynCe/cSHtWHdDGjA3/Dv+zwZ8YapIg0sJ5aKOv+pfXDVFAmCNgzRHSu0tWgBe
 HLZWQRBk6fcUBwk9RCYPB7W6KBgwkYvK8p9KKgbUYfWrR8Pn0z35FHjNGuGZkb5a2/QcwyJUwAq
 DijohbGg==
X-Received: by 2002:a17:90b:4a0c:b0:37f:ec5e:12d9 with SMTP id
 98e67ed59e1d1-38dc75f6500mr688562a91.16.1783720183540; 
 Fri, 10 Jul 2026 14:49:43 -0700 (PDT)
X-Received: by 2002:a17:90b:4a0c:b0:37f:ec5e:12d9 with SMTP id
 98e67ed59e1d1-38dc75f6500mr688538a91.16.1783720183092; 
 Fri, 10 Jul 2026 14:49:43 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311838c9235sm39886355eec.21.2026.07.10.14.49.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:49:42 -0700 (PDT)
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
Subject: [PATCH v5 79/98] tests/tcg/riscv64: system tests
Date: Fri, 10 Jul 2026 14:43:23 -0700
Message-ID: <20260710214343.2065491-80-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: kpEruQBwo_M64CQ9SifbhV326PvljMCY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIxOSBTYWx0ZWRfX51yNv1owoJn5
 itHnAgzIfrxYyik/jF6LY1rueGkaxCeYPhJWFQmsrNer4IrFNnNDlqBCp4sAfgWvGPW2SkP4UQ8
 oDEytseFxOIvmvRMhVetcXiS4k3i+OiwYQbf7aBDlS60q6j0+jMkxK7XVUUXtr7IQecdEx26cG0
 2j6gP5rYo/D+gOK04n1RV3a4a19GXyOxBQQm8oWoavxdj7drKYxJAQEytOjawLex8HViwBGnrGi
 DaD0t57SCKsX9PaREY2xfvy1y3SoDj9ldmzMkU2Iw7wqhSFIKuUb9FxV3C900zUGG2pDWUn+csr
 jQQKTOsFYYxaNt58Xs0Aw6HazAJqLMPr6va+toAXIEQAIKaqRqoZKA4JRPwnmJcIR9f+nlTIDQt
 khOdrM5nV/aqNyQiQEa4C3BtFP28D4i0V81HWeeADwo+85amnfYr2pra039vArD02Io5zeARUvk
 VFzx0S3juObQApjTS5A==
X-Proofpoint-GUID: kpEruQBwo_M64CQ9SifbhV326PvljMCY
X-Authority-Analysis: v=2.4 cv=HInz0Itv c=1 sm=1 tr=0 ts=6a5168f8 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=zzQR_8oM-p7h9UWrr-IA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIxOSBTYWx0ZWRfXyRy9FfAlOUi3
 sKeFCSzsp3fEYx8oSdLvbbSVqZFNdlN+ymeZyk7NitMCNwTqmFWYtCHWjHIx0Ra6vGB680OvGlA
 byI1tLa53R5MRFc5zXxfQ4P6uCrQiaI=
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


