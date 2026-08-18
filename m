Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86894C5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:28:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPTl-0004Fi-2E; Tue, 18 Aug 2026 15:28:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPTe-0003rU-8A
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:28:03 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPTc-0007Rw-Ab
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:28:01 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IHJG2p735618
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:27:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=K6SqjwE6Qbc
 p1IA3clkBgomlMnHmyLB0NSKKiEwbRgM=; b=GWEQpS4NjISMtDOATVV5TftRt/v
 1hFYFfxCTCrh7ZociVlh/ajJXTP+DUZD0K1yIGr6tblabPnwkx8Yl0xYSJ2GMhya
 GR9vncFtHZLi3Bm/dlJaGFZ3Jpmc59zpzcSVYLE8BsaQ9vTveVQEQUDqnSKSAcNZ
 YBWH2LJ2pqi+t8qLOpvBJ4WKSzfwRreWGjsHFIZMWalFsCVVwuV8sGNu16PALWBT
 BmisDdnkfuaT7MWf8MV2aZYbOkRawKiu3QiS+/x1ivhMMpirA9IWflDQixIjFFMe
 UWaFw0b+T7xNDJ0OEvR66IY4eq1Z6hW2gw4ONKQK5AtXXjFDrl471pdKREA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4reshmab-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:27:56 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38e7ff7b375so407092a91.1
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787081276; x=1787686076; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=K6SqjwE6Qbcp1IA3clkBgomlMnHmyLB0NSKKiEwbRgM=;
 b=McM/lseQ5GNFzrO4VvOM5El3fwjdp5oEn2Nn3nfrMeoop04zffCISiSk6VVN3Omx4V
 WCF9Nr8bPP/UBtFwX/OKdrn3yuWxQ2B8dFw0Qa9NAAIjP+H38T18RBPhy/KI4mO6Gqu0
 TBjnkWa3YCbyz0qrePCFpV3BhFin5EIqEeVhSrLz1aNIUsnyKrLFbsoQzAVKx7BbfKL7
 Oe5vuAu54kybmWP8/1RJw9VVDIEcXvsGK/PTad2ebUF0byfe2cZR2v/ruHaHJWInlQ5H
 I9waI4V1pOL7aYnlrtw24vE14FObegQXitS9IFpzoS0kUO0pa1i23IsGNixs9B8AZFNN
 BBHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787081276; x=1787686076;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=K6SqjwE6Qbcp1IA3clkBgomlMnHmyLB0NSKKiEwbRgM=;
 b=LMsqgx4Fy0tpNJ6RlTQ8dIf2zZMi9nSfrUfAcYwA4qBHcOrUjznEKZFPBVo7jLgGit
 inqTHVcyJqT4yaFNrKt8a7QNAbYBBQh9UHUkNETKSMrBs5RiIkckfD2zLBc9wEoK+HU4
 M4cj9nJN0LbvOsfjzKFd1fUn+qhrCikxJhU5Tnby27lkAWoqtzsw76cEmK5lQb6z8W5k
 x3apZxz7wz9e2GctEbf5bZap/3ArHvxCk1aY3b+TO6yhvsvvN7kPeezIHf8rdh2QY9CF
 vNUOEZAgkVzrJ4E8ZCz4/K8fZsyAec4EHi/WH6a4pSrEFZH9u2YUGSpg4od/VqNEHuIY
 WD9A==
X-Gm-Message-State: AOJu0Yy+EWBdLvylGkqcOZwNFEoRFeUYbN5QxOxPc0/U1R4wnApUk1CY
 zcTsu1BHtRoCmOkCdGjaIemTfmQS5g8bBM5h9oiQna/HCMWZzthDA730/eA7FL6pJvNwtA7M2NT
 OlONrSWolFW9qqTsdBxEDbRpZ2ujqXrzhZPgKa4nliRmjAfJt1q8LLcGvdghVbBK15g==
X-Gm-Gg: AR+sD13cNETsDxARt3XipwSdc3y75e08UIoM7Smgmk1nd2xuJT3bDCyX/vq9at1pgrC
 h565wpPwEmb0IOHOmXzpGEKrIjtOLra7SfbcNAvoBfVZjGkfjxg/0U9JW/dg5WnFw+Rs+xLoiN8
 XcEBc4PO2QANz6uQutAQADho5MUq7JBboUjXtw3flnQJl43gvGgIOQ/HU4fIC7va5IsaUagocGI
 X/t4PA9NZ9ZFXWvfwS6ra9qu5DDlGYi7OyaNlNDhBB21ZOFTsFMmZERpBS6vfQoAwlcwxlgK9co
 +WgXBnSB0D3M4wfq+gWSeY/t1fHNwjHf+LWmkgYW3ZFNP+g9gWi7Xua+NxKQZv3MmaNf8UNuEN+
 myXw4YqeemmtuTbjsawYpgRuDwoNBXslMcI0ahT+haYCV/GqNxtuR2GW3yPI=
X-Received: by 2002:a17:90b:2d03:b0:381:528a:808c with SMTP id
 98e67ed59e1d1-3957b336667mr73405a91.12.1787081275330; 
 Tue, 18 Aug 2026 12:27:55 -0700 (PDT)
X-Received: by 2002:a17:90b:2d03:b0:381:528a:808c with SMTP id
 98e67ed59e1d1-3957b336667mr73327a91.12.1787081274808; 
 Tue, 18 Aug 2026 12:27:54 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-326794c0c94sm36782451eec.9.2026.08.18.12.27.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:27:52 -0700 (PDT)
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
Subject: [PATCH v7 048/104] tests/tcg/arm: system tests
Date: Tue, 18 Aug 2026 19:22:12 +0000
Message-ID: <20260818192309.22169-49-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Ne/WEWD4 c=1 sm=1 tr=0 ts=6a84b23c cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VnNF1IyMAAAA:8
 a=EUspDBNiAAAA:8 a=7m_YixJVTNSDrcG_JfQA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: iE4O31X-pJ5DIkThiWd8c19Tb_9dBon-
X-Proofpoint-ORIG-GUID: iE4O31X-pJ5DIkThiWd8c19Tb_9dBon-
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX1xYi1HGosodb
 4WaxFf2S9q3zuN5d2Ozy0vuKEzlOEp1y+DoefAgEzJ7qQrGNnsstIOMundlLQ9IPcoev57+PN+J
 FGWlAjs3yYt0j3MFGY/zrsHZqTtJSnw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfXyk+map/CWrLN
 DCnbaAbqeH6Ljz/V6Cqq8fhLbjz24QFyDx89yZpOuuSM35O8V/eJ2EqxLJgNd1s7NrcG/XEMZkC
 rS1jQLwXl6nMi/1apO2QDx8hBiVc6oBTzG55Jx8q2z4A+wyN9GIeCmVWs1AGNdIgkV96pjyrvda
 zyyXO4TvMGve+gxg4Yo8QN6dQHeHD/lInUmLGg8+rqB9E8JEuM3FZDqVuLrrUYjMJnKYi00kiky
 Kpqgqg1USkd3TvXyb8c3/3QDvX5YdYz671vF3CUfZkwLpB8biqnmktdHc7XvLYR1QXs4e3KVCpT
 4KqKogBGFWRCJUye7M67gVynqIUgr3to/p/8KcjHFb4jvWhbUGHDP+WQXJBthRPn3HFCYPDKYqx
 zpo2zZBsvRiJSIT91VSKSe3aGb/YHpK3rfMdlnOSpbqC/cznk95ensdIh1ozsSAvKeHfMywCGjx
 SiTtskxoZ5TWmYFSCtA==
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
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/arm/Makefile.softmmu-target | 80 ---------------------------
 tests/tcg/arm/meson.build             |  2 +
 tests/tcg/arm/system/meson.build      | 68 +++++++++++++++++++++++
 3 files changed, 70 insertions(+), 80 deletions(-)
 delete mode 100644 tests/tcg/arm/Makefile.softmmu-target
 create mode 100644 tests/tcg/arm/system/meson.build

diff --git a/tests/tcg/arm/Makefile.softmmu-target b/tests/tcg/arm/Makefile.softmmu-target
deleted file mode 100644
index b66074b0b43..00000000000
--- a/tests/tcg/arm/Makefile.softmmu-target
+++ /dev/null
@@ -1,80 +0,0 @@
-# -*- Mode: makefile -*-
-#
-# ARM SoftMMU tests - included from tests/tcg/Makefile
-#
-
-ARM_SRC=$(SRC_PATH)/tests/tcg/arm/system
-
-# Set search path for all sources
-VPATH 		+= $(ARM_SRC)
-
-# Specific Test Rules
-
-test-armv6m-undef: test-armv6m-undef.S
-	$(CC) -mcpu=cortex-m0 -mfloat-abi=soft \
-		-Wl,--build-id=none -x assembler-with-cpp \
-		$< -o $@ -nostdlib -static \
-		-T $(ARM_SRC)/$@.ld
-
-run-test-armv6m-undef: QEMU_OPTS=-semihosting-config enable=on,target=native,chardev=output -M microbit -kernel
-
-ARM_TESTS+=test-armv6m-undef
-
-# These objects provide the basic boot code and helper functions for all tests
-CRT_OBJS=boot.o
-
-ARM_TEST_SRCS=$(wildcard $(ARM_SRC)/*.c)
-ARM_TESTS+=$(patsubst $(ARM_SRC)/%.c, %, $(ARM_TEST_SRCS))
-
-CRT_PATH=$(ARM_SRC)
-LINK_SCRIPT=$(ARM_SRC)/kernel.ld
-LDFLAGS=-Wl,-T$(LINK_SCRIPT)
-CFLAGS+=-nostdlib -ggdb -O0 $(MINILIB_INC)
-LDFLAGS+=-static -nostdlib $(CRT_OBJS) $(MINILIB_OBJS) -lgcc
-
-# building head blobs
-.PRECIOUS: $(CRT_OBJS)
-
-%.o: $(ARM_SRC)/%.S
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -x assembler-with-cpp -Wa,--noexecstack -c $< -o $@
-
-# Build and link the tests
-%: %.c $(LINK_SCRIPT) $(CRT_OBJS) $(MINILIB_OBJS)
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
-
-memory: CFLAGS+=-DCHECK_UNALIGNED=0
-
-# Running
-QEMU_BASE_MACHINE=-M virt -cpu max -display none
-QEMU_OPTS+=$(QEMU_BASE_MACHINE) -semihosting-config enable=on,target=native,chardev=output -kernel
-
-# console test is manual only
-QEMU_SEMIHOST=-serial none -chardev stdio,mux=on,id=stdio0 -semihosting-config enable=on,chardev=stdio0 -mon chardev=stdio0,mode=readline
-run-semiconsole: QEMU_OPTS=$(QEMU_BASE_MACHINE) $(QEMU_SEMIHOST)  -kernel
-run-semiconsole: semiconsole
-	$(call skip-test, $<, "MANUAL ONLY")
-	$(if $(V),@printf "  %-7s %s %s\n" "TO RUN" $(notdir $(QEMU)) "$(QEMU_OPTS) $<")
-run-plugin-semiconsole-with-%: semiconsole
-	$(call skip-test, $<, "MANUAL ONLY")
-
-# Simple Record/Replay Test
-.PHONY: memory-record
-run-memory-record: memory-record memory
-	$(call run-test, $<, \
-	  $(QEMU) -monitor none -display none \
-		  -chardev file$(COMMA)path=$<.out$(COMMA)id=output \
-		  -icount shift=5$(COMMA)rr=record$(COMMA)rrfile=record.bin \
-		  $(QEMU_OPTS) memory)
-
-.PHONY: memory-replay
-run-memory-replay: memory-replay run-memory-record
-	$(call run-test, $<, \
-	  $(QEMU) -monitor none -display none \
-		  -chardev file$(COMMA)path=$<.out$(COMMA)id=output \
-		  -icount shift=5$(COMMA)rr=replay$(COMMA)rrfile=record.bin \
-		  $(QEMU_OPTS) memory)
-
-EXTRA_RUNS+=run-memory-replay
-
-TESTS += $(ARM_TESTS) $(MULTIARCH_TESTS)
-EXTRA_RUNS+=$(MULTIARCH_RUNS)
diff --git a/tests/tcg/arm/meson.build b/tests/tcg/arm/meson.build
index 08a863699fb..1b491cea026 100644
--- a/tests/tcg/arm/meson.build
+++ b/tests/tcg/arm/meson.build
@@ -2,6 +2,8 @@ cc = 'arm-linux-gnueabihf-gcc'
 cc_dockerfile = 'debian-all-test-cross'
 cc_docker_host_arch = ['aarch64', 'x86_64']
 
+subdir('system')
+
 tests = []
 
 # Multi arch tests
diff --git a/tests/tcg/arm/system/meson.build b/tests/tcg/arm/system/meson.build
new file mode 100644
index 00000000000..e559131edd7
--- /dev/null
+++ b/tests/tcg/arm/system/meson.build
@@ -0,0 +1,68 @@
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
+          '-march=armv7-a+fp',
+          '-lgcc']
+qemu_base_args = ['-display', 'none',
+                  '-semihosting-config', 'enable=on',
+                  '-kernel']
+qemu_def_args = ['-M', 'virt', '-cpu', 'max', qemu_base_args]
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
+tests += {
+  'test-armv6m-undef.S': {
+    'cflags': ['-mcpu=cortex-m0', '-mfloat-abi=soft', '-nostdlib',
+               '-T', files('test-armv6m-undef.ld')],
+    'qemu_args': ['-M', 'microbit', qemu_base_args],
+  },
+  'semiconsole.c': {
+    'cflags': cflags,
+    'qemu_args': ['-serial', 'none', '-chardev', 'stdio,mux=on,id=stdio0',
+                  '-semihosting-config', 'enable=on,chardev=stdio0',
+                  '-mon', 'chardev=stdio0,mode=readline',
+                  qemu_def_args],
+    'wrapper': [prog_run_with_input, 'X']
+  },
+  '../../multiarch/system/memory.c': {
+    'test_name': 'memory-record-replay',
+    'qemu_args': qemu_def_args,
+    'wrapper': [prog_record_replay],
+  },
+}
+
+if 'qemu-system-arm' in emulators
+  tcg_tests += {
+    'arm-softmmu': {
+      'cc': cc,
+      'cc_dockerfile': cc_dockerfile,
+      'cc_docker_host_arch': cc_docker_host_arch,
+      'folder': 'arm/system',
+      'gdb_arch': 'arm',
+      'qemu': emulators['qemu-system-arm'],
+      'tests': tests,
+    }
+  }
+endif
-- 
2.43.0


