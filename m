Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86883C5DF86
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:28:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPTU-00039W-Rl; Tue, 18 Aug 2026 15:27:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPTS-00030V-Ne
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:27:50 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPTQ-0007PF-93
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:27:50 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IHHANF1454293
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:27:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=aXh34rpLCW9
 LDz8DJxVQE+1sZsfg0zvj9w+DytsPIKk=; b=YASyHoEZ74XSIRM6rGkaxoeVG7v
 Ha2dec1Nh4zhkSAvJroW4edJVnwsFbJIqGLNCvP8Q9WcqNHTPaBhqrN1JwUqhKKO
 VBeu3HtGYNA+o125Bp8OKP1fa4X5qVfKv2IUK5atyfY3FXW7PJ6McrmO02Yw0x88
 e16FSNKMLEngkCksVLxCr7K1U7gRqPcw/sG/jl/tlg81TYhcFh5iVho2XPF587JS
 xPXIoY/BZU26t834btW3H847heERLISMOmv5aG1WcFNW/9/CeREHda/CTZzjiczE
 O9id+/PNldTPO8Q7Boi7I8uxgzAA7xs/lb1bbnKVagtKO/QB+qzRTiL62Yg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4qxj1uvj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:27:46 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c85798977dcso215777a12.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787081265; x=1787686065; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aXh34rpLCW9LDz8DJxVQE+1sZsfg0zvj9w+DytsPIKk=;
 b=B79d5r6nWvfiyABLSt45BKBq6zj5NglnRNseEzFHECO1q/7HXGwWf+CfnekHJUIN/t
 C+bGfwGe6bKNI127SePfiUQZ9pxhOoRWi9S4sVaD6qOMnUPmCxcr342n6NKHd6oqVq9d
 FO6VQWjvUPQGYG5NPWCcIsrGoHGZgkqBlShzPndXTmbPUiKSobtQfVTi1z/FhaI+L5mD
 4FpqM1c2SwaNFyICUdnzf76H1Hf1Ix7u5MkH02VrEiufEqkOpzzPD2pjGAiuORnIRlwq
 9V4cJSi4cvRE4+tMGiRzky5bgEtrOP3n7w4qSIWjdarnZZFXU6rKyGax4iYIfv6RRM95
 CHBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787081265; x=1787686065;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=aXh34rpLCW9LDz8DJxVQE+1sZsfg0zvj9w+DytsPIKk=;
 b=bEwFYZ4r4Juv9+JeYZj0Md6jezNPgIsWIKNlZX/XyEVnstXhVfwuTCUpYBHdkREYjV
 4LtDqC1P3RMQp7m/mNtUHqFD383ugLdvieyk7gQN/DU3Pct8Bvnqt55vvmDK+XRLj/ul
 ATaE98I5v2EmGzysB5NXBBOctbFodMlRe7YSWbC3nJrejsn7Ns1s19zT5OmaSpavG6N0
 PFQ9HTcMw+8/LxVZmHzVOvUewPY8lH6U36cNNXRKesmoIdACYJjgcMzNiaG/2wS4/0fw
 lJ0EIEW13WWBHlrVVCvnEiAgQbiZh9BSC8xHQnjaypvQT2E2DOtTQ/X8WHMvUc3+/4fo
 tKxA==
X-Gm-Message-State: AOJu0Yxo5VrnEMQhubXQT9g7XaiDfJMPbDsxtMBkgGCxg8WX5MzvI+yz
 m+dwpgbYQxUgw3CF82nOwXNDf1LJ7aOl6R5+qBH0Q5U2J5d8AJE2OUhozrwqZlAiks9xlWDkRCu
 ApjB6K4rd1u0hQvG9YRddNu3IUfxrwrRHXuraZMQsuBkdZInRETrrdGJ5bm7vY07tKA==
X-Gm-Gg: AR+sD11ZHDO8hXDgIJkGGij2RbXbe4RzO3cDjqwnVhtKLtgBOqg7JL3nnT6ESsumnct
 vUbuyjqOe4LGSw8fuFrsRqe+GTgDL7DhmqnP82Zacyt2kpist8weOKOH8rjUJaF9c2l6p3XqWpq
 Tz6Q+8Uf3UUFAdlooARY0pcsnkSn3Bq1V7VaUOhbDwq4dutYCZa1lllmMQasNCL0hbiSJ1yvzUf
 2iMYXPMkm9Lu5OJSOQ1opGwihIl6vCWXPbw3d9CqCHYUIzcELaDtt7hSWzwJDIsz1XPDHyBKPs2
 Qnu08K51BllXzRfovmZiYub1J0LYEimOFAIDR6FrQzJE556zEvMZDz0Rdfx7KVfQVHML2fOHxc+
 E1cMV8ib1VTE/AMWjaav1HUbs7pS35t7d1Ts0IA1byS8bG05mi8aA1h/7BrQ=
X-Received: by 2002:a05:6a20:cd95:b0:3c4:1c9f:d7e with SMTP id
 adf61e73a8af0-3ccff33dd1fmr113969637.6.1787081265228; 
 Tue, 18 Aug 2026 12:27:45 -0700 (PDT)
X-Received: by 2002:a05:6a20:cd95:b0:3c4:1c9f:d7e with SMTP id
 adf61e73a8af0-3ccff33dd1fmr113888637.6.1787081264649; 
 Tue, 18 Aug 2026 12:27:44 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-326794c0c94sm36782451eec.9.2026.08.18.12.27.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:27:44 -0700 (PDT)
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
Subject: [PATCH v7 042/104] tests/tcg/aarch64: system tests
Date: Tue, 18 Aug 2026 19:22:06 +0000
Message-ID: <20260818192309.22169-43-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX2MWkasYKL3Eu
 yGebscegnHBbTFvWk9GSZ0RwFWrJRsAeR8uSmz9NNgGSJdAe5vGAxWoV4FsEwt94eZJqwO4tv8O
 GFAHIyHIjZEnqrpdsx3wdNNVIgHU3to=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX5GYPovOp9U9Q
 sEErqEab1xPj6aAkilwXGlccebKnd+8LHVXmDtbVg+xA+vHmaSUxsn1PAL4ca74bSBnaEYwlIZ5
 HJGW7ucjh/uNHjFOj9w1UOkUfLNt+atyCkfpMb7ezPIVoAPq6xWksuhoDJtXB9PjQZaSpCP5y+r
 Tamu/W7+N7A/Gf5dJyyKY5IuCmt98owc6sPW8Rv6X4bzcJGdQCJ5TnAIKkwRHK15MjKadALqd/a
 6xZPXUZ24QxtmvU0/f6yMKRRBsMdq7wFYAKDYZeRE33FLJPWnNmGgRzFBhZJfvayYAJLBwbg+55
 4YH0J5IAM53O+i/hfO334iPwt5PcFjnhDISHkORz9Wvh0zUM0mD0nH6sInXSJMAy8uEFqpJuQsQ
 6QI7qmbKg6gTS/dZtBeZPT67WrM0VGl++X4DEO22FIzB6plVm/N51uDSr0sAUZ6isaytoG6KvoT
 eRbpTzuYL2I3PKCtxdg==
X-Proofpoint-ORIG-GUID: B0uuovg9oe_l-9N63fleV3um7AjPcalu
X-Proofpoint-GUID: B0uuovg9oe_l-9N63fleV3um7AjPcalu
X-Authority-Analysis: v=2.4 cv=bvB8wkai c=1 sm=1 tr=0 ts=6a84b232 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VnNF1IyMAAAA:8
 a=EUspDBNiAAAA:8 a=lKJin8fYq-Jz0iZqabkA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 spamscore=0 phishscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180142
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

Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/aarch64/Makefile.softmmu-target | 147 ----------------------
 tests/tcg/aarch64/meson.build             |   2 +
 tests/tcg/aarch64/system/meson.build      | 109 ++++++++++++++++
 3 files changed, 111 insertions(+), 147 deletions(-)
 delete mode 100644 tests/tcg/aarch64/Makefile.softmmu-target
 create mode 100644 tests/tcg/aarch64/system/meson.build

diff --git a/tests/tcg/aarch64/Makefile.softmmu-target b/tests/tcg/aarch64/Makefile.softmmu-target
deleted file mode 100644
index 3f30be6c5d6..00000000000
--- a/tests/tcg/aarch64/Makefile.softmmu-target
+++ /dev/null
@@ -1,147 +0,0 @@
-#
-# Aarch64 system tests
-#
-
-AARCH64_SRC=$(SRC_PATH)/tests/tcg/aarch64
-AARCH64_SYSTEM_SRC=$(AARCH64_SRC)/system
-
-VPATH+=$(AARCH64_SYSTEM_SRC)
-
-# These objects provide the basic boot code and helper functions for all tests
-CRT_OBJS=boot.o
-
-AARCH64_TEST_C_SRCS=$(wildcard $(AARCH64_SYSTEM_SRC)/*.c)
-AARCH64_TEST_S_SRCS=$(AARCH64_SYSTEM_SRC)/mte.S
-
-AARCH64_C_TESTS = $(patsubst $(AARCH64_SYSTEM_SRC)/%.c, %, $(AARCH64_TEST_C_SRCS))
-AARCH64_S_TESTS = $(patsubst $(AARCH64_SYSTEM_SRC)/%.S, %, $(AARCH64_TEST_S_SRCS))
-
-AARCH64_TESTS = $(AARCH64_C_TESTS)
-AARCH64_TESTS += $(AARCH64_S_TESTS)
-
-CRT_PATH=$(AARCH64_SYSTEM_SRC)
-LINK_SCRIPT=$(AARCH64_SYSTEM_SRC)/kernel.ld
-LDFLAGS=-Wl,-T$(LINK_SCRIPT)
-TESTS+=$(AARCH64_TESTS) $(MULTIARCH_TESTS)
-EXTRA_RUNS+=$(MULTIARCH_RUNS)
-CFLAGS+=-nostdlib -ggdb -O0 $(MINILIB_INC)
-LDFLAGS+=-static -nostdlib $(MINILIB_OBJS) -lgcc
-
-config-cc.mak: Makefile
-	$(quiet-@)( \
-	    $(call cc-option,-march=armv8.3-a, CROSS_CC_HAS_ARMV8_3); \
-	    $(call cc-option,-march=armv8.5-a+memtag, CROSS_CC_HAS_ARMV8_MTE)) 3> config-cc.mak
--include config-cc.mak
-
-# building head blobs
-.PRECIOUS: $(CRT_OBJS)
-
-vector_log_boot.o: $(CRT_PATH)/boot.S
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -DLOGGING_VECTOR_TABLE -x assembler-with-cpp -Wa,--noexecstack -c $< -o $@
-
-%.o: $(CRT_PATH)/%.S
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -x assembler-with-cpp -Wa,--noexecstack -c $< -o $@
-
-# Build and link the tests
-%: %.c $(LINK_SCRIPT) $(CRT_OBJS) $(MINILIB_OBJS)
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS) boot.o
-
-memory: CFLAGS+=-DCHECK_UNALIGNED=1
-
-memory-sve: memory.c $(LINK_SCRIPT) $(CRT_OBJS) $(MINILIB_OBJS)
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS) boot.o
-
-memory-sve: CFLAGS+=-DCHECK_UNALIGNED=1 -march=armv8.1-a+sve -O3
-
-gpc-test: gpc-test.c $(LINK_SCRIPT) vector_log_boot.o $(MINILIB_OBJS)
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS) vector_log_boot.o
-
-TESTS+=memory-sve gpc-test
-
-# Running
-QEMU_BASE_MACHINE=-M virt -cpu max -display none
-QEMU_BASE_ARGS=-semihosting-config enable=on,target=native,chardev=output
-QEMU_OPTS+=$(QEMU_BASE_MACHINE) $(QEMU_BASE_ARGS) -kernel
-
-# console test is manual only
-QEMU_SEMIHOST=-serial none -chardev stdio,mux=on,id=stdio0 -semihosting-config enable=on,chardev=stdio0 -mon chardev=stdio0,mode=readline
-run-semiconsole: QEMU_OPTS=$(QEMU_BASE_MACHINE) $(QEMU_SEMIHOST) -kernel
-run-semiconsole: semiconsole
-	$(call skip-test, $<, "MANUAL ONLY")
-	$(if $(V),@printf "  %-7s %s %s\n" "TO RUN" $(notdir $(QEMU)) "$(QEMU_OPTS) $<")
-run-plugin-semiconsole-with-%: semiconsole
-	$(call skip-test, $<, "MANUAL ONLY")
-
-# vtimer test needs EL2
-QEMU_EL2_MACHINE=-machine virt,virtualization=on,gic-version=2 -cpu cortex-a57 -smp 4
-QEMU_EL2_BASE_ARGS=-semihosting-config enable=on,target=native,chardev=output,arg="2"
-run-vtimer: QEMU_OPTS=$(QEMU_EL2_MACHINE) $(QEMU_EL2_BASE_ARGS) -kernel
-
-# gpc tests need EL3 and RME
-QEMU_EL3_MACHINE=-machine virt,virtualization=on,secure=on,gic-version=3 -cpu max,x-rme=on
-QEMU_EL3_BASE_ARGS=-semihosting-config enable=on,target=native,chardev=output,arg="3"
-run-gpc-test:  QEMU_OPTS=$(QEMU_EL3_MACHINE) $(QEMU_EL3_BASE_ARGS) -kernel
-run-gpc3-test: QEMU_OPTS=$(QEMU_EL3_MACHINE) $(QEMU_EL3_BASE_ARGS) -kernel
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
-ifneq ($(CROSS_CC_HAS_ARMV8_3),)
-pauth-3: CFLAGS += $(CROSS_CC_HAS_ARMV8_3)
-# This test explicitly checks the output of the pauth operation so we
-# must force the use of the QARMA5 algorithm for it.
-run-pauth-3: QEMU_BASE_MACHINE=-M virt -cpu max,pauth-qarma5=on -display none
-else
-pauth-3:
-	$(call skip-test, "BUILD of $@", "missing compiler support")
-run-pauth-3:
-	$(call skip-test, "RUN of pauth-3", "not built")
-endif
-
-ifneq ($(CROSS_CC_HAS_ARMV8_MTE),)
-QEMU_MTE_ENABLED_MACHINE=-M virt,mte=on -cpu max -display none
-QEMU_OPTS_WITH_MTE_ON = $(QEMU_MTE_ENABLED_MACHINE) $(QEMU_BASE_ARGS) -kernel
-mte: CFLAGS+=-march=armv8.5-a+memtag
-mte: mte.S $(LINK_SCRIPT) $(CRT_OBJS) $(MINILIB_OBJS)
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS) boot.o
-
-run-mte: QEMU_OPTS=$(QEMU_OPTS_WITH_MTE_ON)
-run-mte: mte
-
-ifeq ($(GDB_SUPPORTS_MTE_IN_BAREMETAL),y)
-run-gdbstub-mte: QEMU_OPTS=$(QEMU_OPTS_WITH_MTE_ON)
-run-gdbstub-mte: mte
-	$(call run-test, $@, $(GDB_SCRIPT) \
-		--output run-gdbstub-mte.out \
-		--gdb $(GDB) \
-		--qemu $(QEMU) --qargs "-chardev null$(COMMA)id=output $(QEMU_OPTS)" \
-		--bin $< --test $(AARCH64_SRC)/gdbstub/test-mte.py -- --mode=system, \
-	gdbstub MTE support)
-
-EXTRA_RUNS += run-gdbstub-mte
-else # !GDB_SUPPORTS_MTE_IN_BAREMETAL
-run-gdbstub-mte:
-	$(call skip-test "RUN of gdbstub-mte", "GDB does not support MTE in baremetal!")
-endif
-else # !CROSS_CC_HAS_ARMV8_MTE
-mte:
-	$(call skip-test, "BUILD of $@", "missing compiler support")
-run-mte:
-	$(call skip-test, "RUN of mte", "not build")
-endif
diff --git a/tests/tcg/aarch64/meson.build b/tests/tcg/aarch64/meson.build
index 959d1cf698f..7301d004606 100644
--- a/tests/tcg/aarch64/meson.build
+++ b/tests/tcg/aarch64/meson.build
@@ -21,6 +21,8 @@ gdb_feat_version = {
   'mte-baremetal': '16.0',
 }
 
+subdir('system')
+
 tests = []
 
 # Multi arch tests
diff --git a/tests/tcg/aarch64/system/meson.build b/tests/tcg/aarch64/system/meson.build
new file mode 100644
index 00000000000..94e16ba3300
--- /dev/null
+++ b/tests/tcg/aarch64/system/meson.build
@@ -0,0 +1,109 @@
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
+          '-Wl,-T', link_script]
+qemu_base_args = ['-display', 'none',
+                  '-semihosting-config', 'enable=on',
+                  '-kernel']
+qemu_def_args = ['-M', 'virt', '-cpu', 'max', qemu_base_args]
+
+# Multi arch tests - add cflags only once per src
+multi_src = []
+foreach t: tcg_tests['multiarch-softmmu']['tests']
+  foreach src, setup: t
+    new_cflags = cflags
+    if fs.stem(src) == 'memory'
+      new_cflags += '-DCHECK_UNALIGNED=1'
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
+  '../../multiarch/system/memory.c': {
+    'exe_name': 'memory-sve',
+    'cc_feat': 'sve',
+    'cflags': [cflags, '-DCHECK_UNALIGNED=1', '-O3'],
+    'qemu_args': qemu_def_args,
+  },
+}
+
+tests += {
+  'asid2.c': {'cflags': cflags, 'qemu_args': qemu_def_args},
+  'feat-xs.c': {'cflags': cflags, 'qemu_args': qemu_def_args},
+  'gpc-test.c': {
+    'cflags': [cflags, '-DLOGGING_VECTOR_TABLE',
+               '-Wno-main', '-Wno-unused-but-set-variable'],
+    'qemu_args': ['-M', 'virt,secure=on,virtualization=on,gic-version=3',
+                  '-cpu', 'max,x-rme=on',
+                  '-semihosting-config', 'enable=on,arg=3',
+                  qemu_base_args],
+  },
+  'rme_gdi.c': {'cflags': cflags, 'qemu_args': qemu_def_args},
+  'semiheap.c': {'cflags': cflags, 'qemu_args': qemu_def_args},
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
+  'vtimer.c': {
+    'cflags': cflags,
+    'qemu_args': ['-M', 'virt,virtualization=on,gic-version=2',
+                  '-cpu', 'cortex-a57', '-smp', '4',
+                  '-semihosting-config', 'enable=on,arg=2',
+                  qemu_base_args]
+  },
+}
+
+tests += {
+  'pauth-3.c': {
+    'cc_feat': 'v8.3',
+    'cflags': cflags,
+    'qemu_args': ['-M', 'virt', '-cpu', 'max,pauth-qarma5=on', qemu_base_args],
+  }
+}
+
+tests += {
+  'mte.S': {
+    'cc_feat': 'mte',
+    'cflags': cflags,
+    'qemu_args': ['-M', 'virt,mte=on', '-cpu', 'max', qemu_base_args],
+    'gdb_test': ['--test', files('../gdbstub/test-mte.py'), '--', '--mode=system'],
+    'gdb_feat': 'mte-baremetal',
+  }
+}
+
+if 'qemu-system-aarch64' in emulators
+  tcg_tests += {
+    'aarch64-softmmu': {
+      'cc': cc,
+      'cc_dockerfile': cc_dockerfile,
+      'cc_docker_host_arch': cc_docker_host_arch,
+      'cc_feat_cflags': cc_feat_cflags,
+      'folder': 'aarch64/system',
+      'gdb_arch': 'aarch64',
+      'gdb_feat_version': gdb_feat_version,
+      'qemu': emulators['qemu-system-aarch64'],
+      'tests': tests,
+    }
+  }
+endif
-- 
2.43.0


