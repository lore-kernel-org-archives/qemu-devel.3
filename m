Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AA8FC25B5F
	for <qemu-devel@archiver.kernel.org>; Sat, 11 May 2024 11:55:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5lJ3-0000Oe-5m; Sat, 11 May 2024 07:54:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s5lJ1-0000Nj-GI
 for qemu-devel@nongnu.org; Sat, 11 May 2024 07:54:23 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s5lIz-00071b-H2
 for qemu-devel@nongnu.org; Sat, 11 May 2024 07:54:23 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-42011507a57so1010625e9.1
 for <qemu-devel@nongnu.org>; Sat, 11 May 2024 04:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715428460; x=1716033260; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gCHqJdB9ixZnMzJUa7fmPKgSiCmh3gi3e9Ib/ZnK7PQ=;
 b=Gk3hBFc1fwY4kmjOxkUp2fuK/DVt7CdZ08AzShOwLu4i8VCGn193rLhkE9eoKHWqTf
 h6LcTRayyzWw6quagaSU95DjEdNKjsbpJPFa92y3k3B7BR8FkZt2WtEVnNF+k9nhGz/U
 X4YgOimSW77vLv5KMwiHT26F2MK5SfJDbYp5U7uLtnP2CNFvBSY4AUYT9vIgRISXtAkA
 8uTF8OcBX5AjxWGOReTTYOHaA4vb+UuSuJBbRQB92eoL5RbP3KYHAFLisG4zAvBqdTZq
 g0rbEmjOLDsEvcZeQY+GYWvBEY4UUUPjHr8WukiQISlOvbq/d4j7f72V5Krrl8zVf1yd
 YnHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715428460; x=1716033260;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gCHqJdB9ixZnMzJUa7fmPKgSiCmh3gi3e9Ib/ZnK7PQ=;
 b=W+ivb8OCjQb7LwupR0VhCl/Aclc7W4slhx7PBqFZ1nZjt66OfCTPsSGSH8v0tGjYDq
 mEIadIM6BVYpY83lGy18eb41+RZtw1Xbyc2ufRbXKxpIniry+TjvNSX/4X4ZCJ+M3bEg
 W1EybgrNVsKvbEJl7VGa72Wv8G6aiusyUGf5CjJRmLBk2GY5F3gupdDBzvhIoubHDD5c
 pkB6cFsps3cERcOqgFtHSi5/1+Ir6R4n6JS0PlcGUKX5AJJP7ceMZEmjx0kxw7+Fh1Cp
 /8XkTX4aNilA48Ws0TXRtMi9Tz3YdvPcqIs5vRQK7RApCer4nUO3nNX/PSok0IPq8pXU
 DRLQ==
X-Gm-Message-State: AOJu0YzHc8EWaJTaGtniYjlwiwP60tcxftJQD9htp0CeuZNmxB1ygFla
 JU1sOcjovC1a7lwSN77NoFqiLOY6/yL1nk7zIFtz2HBxdBrHVySp6UC1afUDrEQjYTWqrmYISYT
 uQBs=
X-Google-Smtp-Source: AGHT+IGq8X4lk2DcwJEgT85HN3jMTQ5QCFvjiCA3kHJXqYEuMkjg0CFOMAfL8PjWIlICp6dD+gmgsA==
X-Received: by 2002:a05:600c:a45:b0:416:bc18:2a00 with SMTP id
 5b1f17b1804b1-41feac5a4d9mr42804905e9.38.1715428460156; 
 Sat, 11 May 2024 04:54:20 -0700 (PDT)
Received: from stoup.. ([195.76.196.165]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502bbbbf20sm6764797f8f.93.2024.05.11.04.54.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 May 2024 04:54:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH 17/17] Build elf test cases instead of raw binaries
Date: Sat, 11 May 2024 13:54:00 +0200
Message-Id: <20240511115400.7587-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240511115400.7587-1-richard.henderson@linaro.org>
References: <20240511115400.7587-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 Makefile       | 19 ++++++++++---------
 test.ld        | 12 ++++++++++++
 test_aarch64.s |  4 ++--
 test_arm.s     | 16 +++++++++++-----
 test_i386.S    |  4 +++-
 5 files changed, 38 insertions(+), 17 deletions(-)
 create mode 100644 test.ld

diff --git a/Makefile b/Makefile
index ad7f879..2bd08aa 100644
--- a/Makefile
+++ b/Makefile
@@ -22,7 +22,8 @@ ALL_CFLAGS = -Wall -D_GNU_SOURCE -DARCH=$(ARCH) -U$(ARCH) $(BUILD_INC) $(CFLAGS)
 PROG=risu
 SRCS=risu.c comms.c risu_$(ARCH).c risu_reginfo_$(ARCH).c
 HDRS=risu.h risu_reginfo_$(ARCH).h
-BINS=test_$(ARCH).bin
+BINO=test_$(ARCH).o
+BINE=test_$(ARCH).elf
 
 # For dumping test patterns
 RISU_BINS=$(wildcard *.risu.bin)
@@ -30,7 +31,7 @@ RISU_ASMS=$(patsubst %.bin,%.asm,$(RISU_BINS))
 
 OBJS=$(SRCS:.c=.o)
 
-all: $(PROG) $(BINS)
+all: $(PROG) $(BINE)
 
 dump: $(RISU_ASMS)
 
@@ -43,17 +44,17 @@ $(PROG): $(OBJS)
 %.o: %.c $(HDRS)
 	$(CC) $(CPPFLAGS) $(ALL_CFLAGS) -o $@ -c $<
 
-%_$(ARCH).bin: %_$(ARCH).elf
-	$(OBJCOPY) -O binary $< $@
+%_$(ARCH).o: %_$(ARCH).s
+	$(CC) -o $@ -c $<
 
-%_$(ARCH).elf: %_$(ARCH).s
-	$(AS) -o $@ $<
-
-%_$(ARCH).elf: %_$(ARCH).S
+%_$(ARCH).o: %_$(ARCH).S
 	$(CC) $(CPPFLAGS) -o $@ -c $<
 
+%_$(ARCH).elf: test.ld %_$(ARCH).o
+	$(LD) -o $@ -T $^
+
 clean:
-	rm -f $(PROG) $(OBJS) $(BINS)
+	rm -f $(PROG) $(OBJS) $(BINO) $(BINE)
 
 distclean: clean
 	rm -f config.h Makefile.in
diff --git a/test.ld b/test.ld
new file mode 100644
index 0000000..eb0a76a
--- /dev/null
+++ b/test.ld
@@ -0,0 +1,12 @@
+ENTRY(start)
+
+PHDRS {
+    text PT_LOAD FILEHDR PHDRS;
+}
+
+SECTIONS {
+    . = SIZEOF_HEADERS;
+    PROVIDE(start = .);
+    .text : { *(.text) } :text
+    .data : { *(.data) } :text
+}
diff --git a/test_aarch64.s b/test_aarch64.s
index f75d588..88902c6 100644
--- a/test_aarch64.s
+++ b/test_aarch64.s
@@ -80,6 +80,6 @@ fmov d31, #31.0
 /* do compare.
  * The manual says instr with bits (28,27) == 0 0 are UNALLOCATED
  */
-.int 0x00005af0
+.inst 0x00005af0
 /* exit test */
-.int 0x00005af1
+.inst 0x00005af1
diff --git a/test_arm.s b/test_arm.s
index 49552f2..62582e7 100644
--- a/test_arm.s
+++ b/test_arm.s
@@ -9,20 +9,26 @@
  *     Peter Maydell (Linaro) - initial implementation
  *******************************************************************************/
 
+.text
+
 /* magic instruction to force ARM mode whether we were in ARM or Thumb before */
-.int 0xe0004778
+.inst 0xe0004778
+
 /* Initialise the gp regs */
 add r0, pc, #4
 ldmia r0, {r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,r14}
-b next
+b 1f
+
 .int 0,1,2,3,4,5,6,7,8,9,10,11,12,14
-next:
+
+1:
 msr CPSR_fs, #0
+
 /* do compare.
  * The space 0xE7F___F_ is guaranteed to always UNDEF
  * and not to be allocated for insns in future architecture
  * revisions.
  */
-.int 0xe7fe5af0
+.inst 0xe7fe5af0
 /* exit test */
-.int 0xe7fe5af1
+.inst 0xe7fe5af1
diff --git a/test_i386.S b/test_i386.S
index 05344d7..2e2b090 100644
--- a/test_i386.S
+++ b/test_i386.S
@@ -13,6 +13,7 @@
 
 /* Initialise the registers to avoid spurious mismatches */
 
+.text
 #ifdef __x86_64__
 #define BASE	%rax
 	lea	2f(%rip), BASE
@@ -71,7 +72,8 @@
 /* exit test */
 	ud1	%ecx, %eax
 
-	.p2align 16
+.data
+	.balign 16
 2:
 	.set	i, 0
 	.rept	256
-- 
2.34.1


