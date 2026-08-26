Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8063C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 19:23:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzJD0-0007qy-PX; Wed, 26 Aug 2026 15:22:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ralerrdirsardx@gmail.com>)
 id 1wzHFL-0006Px-1o
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 13:17:07 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ralerrdirsardx@gmail.com>)
 id 1wzHFI-0008LD-MR
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 13:17:06 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-5b14d1f9315so836412e87.2
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 10:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787764621; x=1788369421; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Yg93GYCE6k1Y4/DR7+dQ9qAd3uQUgCnZ6ZWzQS0cH/8=;
 b=nRxPKhvo3f7Q9PzOR8yui9xLFDjvpE4i9iuKz/8OkoC8NDLB1t8BQtbh8wQ+qHj+jH
 PQrHVLzqQN4/8dKCnzcB9g1pgqhNqnTPnaQQQeioqKDZM/cDctxasVynJg2QnlUJV0uo
 6/HkDI7qhv3Kmsz0T9UWlVt8LeDdXLfxtgqvfQW6UEwTPE334LwTAsmAsWIaJF9QZRly
 qcNyV0dvKeHJW5XZU75CVK5IgU2lOXrs94J7tbNFE5SfT6NOCBygjBaKe4cl6vtG7YzR
 29nYZMaMLWk13zvNMV5iiCQkQRwFEdoQAV11kg9E5mm0P39Pe8uYnbGvpS6BmcpLTSMR
 naIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787764621; x=1788369421;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Yg93GYCE6k1Y4/DR7+dQ9qAd3uQUgCnZ6ZWzQS0cH/8=;
 b=c+8qZmwT8vFV0MXF4chOrHAs5E+LCquKijPwQTRtbv3anUlxn2yWMLwMv2zeffqpRy
 IrFv/N0ru0YC3arjfpJ+JqnKbDpulnHx4mx13YUhEzU2SZ7VUH7M1A3CDyjpvHbh9JX6
 KAhfDqWikaZQePVotgFrDt4cbddwYUaa7k9YDGSoERsZwWo9xpZuiwZsbr5dyn7tcCjk
 xmWHjI60Zp2Vdd321gJDd8zoU9QWJZQ11koT+Osxth20AdbFFgT+ISYYyZeC4KUIEOeX
 JeY0mH+F0JVCnHBT9n0nBMiJgHUdLsJlq9s8iIR46G+DAw8Ed3KH6fyE+i4NM+fwkGzx
 2/CA==
X-Gm-Message-State: AFuF++kSqw44h+qijhISeFDMt50JLKi2/7MUdtzbNiJCOqbaGaANL6hA
 n2C75i2PaVDvPXfL1tIQK5I2YeL8+3hvJsyQptDg3E7EJiPCorNdJOzobkRkKQ==
X-Gm-Gg: AR+sD10MvZ6EhVxA6IFmJ51EpCziYwSL0ik9HMRhxJv/OIDcrfR0yPgr8AynN/0rM+L
 2D7RqMe6rubLaymfbTpLy3n+JFJuKaQB8rs/Sslz7y3fE1L7M8tlsQqcimv6Qy6d/2fbrLuOdP9
 E/s/V8PaS6VVJj1WvxLZMOH/14Z02nCWePZmtuGYGaSEvGbpsvG02YcDPJ1LdljB3oOqsrtJq0n
 bVGoEkgPtt/q9d1Ro1wh+zO4kTNqQWZFiU+yuHQ+AnUoa/b3G3OHX62lnf47g4Bcll2ro5l+67f
 eszV8/1ikGvl4u8Tapu2k+olAgLXGw/rfF/bmITfzinDHy10T54Js9H9K3pU4LZRxIG0s0UT7dk
 wUEAMqVYWwhxx/M1DAAr8dRQ4mVcbtTQXYdu0Vl9t7VXWUAQktoyvVJ1BMbiqwWwj7XylazmYah
 EuLmWu5BRWAXl7CersOwtx62xwg7aw5v01QQ0HozuXINK7/5RM687c4pXupVBDdKp+AgfoMYX3y
 O+hVw8z/7VJrMgoHPbL1Bf+7NU=
X-Received: by 2002:a19:5206:0:b0:5b4:9d34:eb67 with SMTP id
 2adb3069b0e04-5b4a908dde8mr2382627e87.24.1787764621417; 
 Wed, 26 Aug 2026 10:17:01 -0700 (PDT)
Received: from qblck ([188.130.155.185]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b4a41b7f05sm725195e87.70.2026.08.26.10.16.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 10:16:59 -0700 (PDT)
From: Artemii Mashanov <ralerrdirsardx@gmail.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	richard.henderson@linaro.org
Subject: [PATCH] target/i386/tcg: zero FXSAVE FOP and reserved slot bytes
Date: Wed, 26 Aug 2026 20:16:55 +0300
Message-ID: <20260826171655.117679-1-ralerrdirsardx@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=ralerrdirsardx@gmail.com; helo=mail-lf1-x12d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 26 Aug 2026 15:22:47 -0400
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

TCG's do_xsave_fpu() omitted writing the FOP field and the reserved
bytes (10..15) of each x87 register slot. Those parts of
the destination buffer retained their previous contents.

The reserved bytes of all eight slots are zeroed. TCG does not
yet track the actual FOP value, this patch stores a fixed zero instead.

Add a regression test in tests/tcg/x86_64/fxsave.c. It fills the
FXSAVE area with 0xcc, executes FNINIT and FXSAVE64, then verifies that
FOP and all reserved slot bytes are zero.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3522

Signed-off-by: Artemii Mashanov <ralerrdirsardx@gmail.com>
---
 target/i386/tcg/fpu_helper.c     |  3 ++
 tests/tcg/x86_64/Makefile.target |  1 +
 tests/tcg/x86_64/fxsave.c        | 66 ++++++++++++++++++++++++++++++++
 3 files changed, 70 insertions(+)
 create mode 100644 tests/tcg/x86_64/fxsave.c

diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index b812125efa..9a2be488ef 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -2601,6 +2601,7 @@ static void do_xsave_fpu(X86Access *ac, target_ulong ptr)
     access_stw(ac, ptr + XO(legacy.fcw), env->fpuc);
     access_stw(ac, ptr + XO(legacy.fsw), fpus);
     access_stw(ac, ptr + XO(legacy.ftw), fptag ^ 0xff);
+    access_stw(ac, ptr + XO(legacy.fpop), 0);
 
     /* In 32-bit mode this is eip, sel, dp, sel.
        In 64-bit mode this is rip, rdp.
@@ -2613,6 +2614,8 @@ static void do_xsave_fpu(X86Access *ac, target_ulong ptr)
     for (i = 0; i < 8; i++) {
         floatx80 tmp = ST(i);
         do_fstt(ac, addr, tmp);
+        access_stw(ac, addr + 10, 0);
+        access_stl(ac, addr + 12, 0);
         addr += 16;
     }
 }
diff --git a/tests/tcg/x86_64/Makefile.target b/tests/tcg/x86_64/Makefile.target
index c48767fef8..0f8f48b1a5 100644
--- a/tests/tcg/x86_64/Makefile.target
+++ b/tests/tcg/x86_64/Makefile.target
@@ -20,6 +20,7 @@ X86_64_TESTS += test-1648
 X86_64_TESTS += test-2175
 X86_64_TESTS += cross-modifying-code
 X86_64_TESTS += fma
+X86_64_TESTS += fxsave
 TESTS=$(MULTIARCH_TESTS) $(X86_64_TESTS) test-x86_64
 else
 TESTS=$(MULTIARCH_TESTS)
diff --git a/tests/tcg/x86_64/fxsave.c b/tests/tcg/x86_64/fxsave.c
new file mode 100644
index 0000000000..d08a4e8a0e
--- /dev/null
+++ b/tests/tcg/x86_64/fxsave.c
@@ -0,0 +1,66 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * See https://gitlab.com/qemu-project/qemu/-/issues/3522
+ */
+
+#include <stdint.h>
+#include <stdio.h>
+#include <string.h>
+
+#define FXSAVE_FOP_OFFSET      6
+#define FXSAVE_X87_OFFSET      32
+#define FXSAVE_SLOT_SIZE       16
+#define FXSAVE_RESERVED_START  10
+#define FXSAVE_NUM_SLOTS       8
+
+struct fxsave_area {
+    uint8_t raw[512];
+} __attribute__((aligned(16)));
+
+_Static_assert(sizeof(struct fxsave_area) == 512,
+                "FXSAVE area must be exactly 512 bytes");
+
+static uint16_t u16_le(const uint8_t *p)
+{
+    uint16_t v;
+    memcpy(&v, p, sizeof(v));
+    return v;
+}
+
+int main(void)
+{
+    struct fxsave_area area;
+    uint16_t fop;
+
+    memset(&area, 0xcc, sizeof(area));
+
+    __asm__ volatile(
+        "fninit\n\t"
+        "fxsave64 %0"
+        : "+m" (area)
+        :
+        : "memory"
+    );
+
+    fop = u16_le(&area.raw[FXSAVE_FOP_OFFSET]);
+    if (fop != 0) {
+        fprintf(stderr, "FOP: expected 0, got 0x%04x\n", (unsigned)fop);
+        return 1;
+    }
+
+    for (int slot = 0; slot < FXSAVE_NUM_SLOTS; slot++) {
+        int base = FXSAVE_X87_OFFSET + slot * FXSAVE_SLOT_SIZE;
+        for (int b = FXSAVE_RESERVED_START; b < FXSAVE_SLOT_SIZE; b++) {
+            uint8_t val = area.raw[base + b];
+            if (val != 0) {
+                fprintf(stderr,
+                        "Slot %d byte %d (offset %d): expected 0x00, "
+                        "got 0x%02x\n",
+                        slot, b, base + b, (unsigned)val);
+                return 1;
+            }
+        }
+    }
+
+    return 0;
+}
-- 
2.54.0


