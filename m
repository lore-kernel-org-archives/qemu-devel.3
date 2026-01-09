Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97139D26D77
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 16:54:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veFjx-0000wO-UO; Fri, 09 Jan 2026 11:53:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1veFjq-0000iE-M8
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 11:53:29 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1veFjo-0007dZ-OR
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 11:53:26 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-42fed090e5fso2508415f8f.1
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 08:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767977602; x=1768582402; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nbBzGEvp7uU7FunAVjhxKmGIPX914MoXiFSBgfcwfeU=;
 b=Nc1nCcaLLx5rnrHMHrxdqgNU9C6xf/Jvo7JaRjMqKap8TnSLLcLUYfo2XDExhex6RK
 OUwfM3ffyeaBL53mekmORnhMQZKr1FxkW1TgIL1Pd6Z5+8TFDghH0g0ukNSMX2L+GTG7
 TLD7bLkIA0Pu7egRCBu78WM6AJTgrLi5rDDjLbN8Tuq9zZ0dfZIV4Dv/fZf9WPDJhdNX
 8xoieH32HYAZUtz142owaKEpu8PkTi9Wyg4ahqcv7ODr27zkb7xAJpufQS3rakX32ubl
 36Phn/sXnLep6vpneXZczmUKg3zSFXD7RpnwQWCJR9+1lbIx0wYoV0tgv5qZKI3EaKXx
 6nUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767977602; x=1768582402;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nbBzGEvp7uU7FunAVjhxKmGIPX914MoXiFSBgfcwfeU=;
 b=EES8oa9JS0Dylqzi//pqobEC++F2SbbIVoWJNqtDl/DUyCcv4f8CPqxGLXx+c0Rk/J
 rHujas11lVVi8/PlthiMGxl+PtC0a0++OEqE0flmgFbKi9MDbH9Y5knI6I02ARKqxRNy
 J1uy84swMJTLOvUJNS2oFodw9qO0UP3zni1tgY0mRysHUT4ywi5ugc3DnFwqclLk6tOB
 8WZj1lbLEOgUFk+qrGhOUbZahpMjv5sgGnAINHlkhdP0FMyYKy66wyGDI5PQSMMa3m5R
 WbrfrMQEhem5aACjc+LnjYGhuPiPIOYZGm6+sqSNLIMMOrNJMub4Ks6le/HApdHbJ0VJ
 VQJg==
X-Gm-Message-State: AOJu0YzDvhgwH2AOYJ8LBDx3YAH7dtqLMLFgcDO4GB9cDxuWeyi3IYdd
 OjTqCUICgHS/cVO5H9Poj4VAVJWsvvkerEUar+MUF6rJlrYePXDiO24q214efLppiSpK3komyZZ
 f95CqJo4=
X-Gm-Gg: AY/fxX7QiinZ8DTBsgLq69HUZR73y+CEJX/9Yp8iFUtdD6NFA9DgMqTnwcmlh+Px4He
 pRy9bhYNUn52wZ7A2F4u0JlKCWOaNlUGZsjXrsof/xH8NnnMGoon9vN1OsX/Hg5463jlw8Ofk57
 ZHsHKFbGDFr2sjezDoZPjx0ba/DMzMWH0SuagSpBUg04BK5crhT17/qPyisg3UsHd1FHRAfrvak
 0s3JmanwGZNXsKzgd/6+JoX2pNU24cTu32iFCevu0fouhZtJyG4DaEABYO4bHWPX4ienBw3AUdH
 tYwzJaTgFdS1c1JLXGI1lPH7DDz9cvADsV+OKxZU7Au4wBQT+fqipyqZfKyHivoKWUSl03ZyLjW
 csfXGhDbeKfO4p+Y1Bs1HYcfVvMqUz8da6kcityUe6cSZj4cyi20+/1gpZLRUS+z6rN18jV1cbf
 oDr0z0S61uTlo2g10PQM3q6Lzd+jrOOUW6j+nYNXhrApv6LpCakKZtPyxMoh8c
X-Google-Smtp-Source: AGHT+IEamCBM6DB7n93fi4v326V/ekjVbLx/2r2TNxgAm55V9q/DRQcm6eC1kWmyR4vI13M0w3O2bg==
X-Received: by 2002:a05:6000:2311:b0:432:aa61:a06e with SMTP id
 ffacd0b85a97d-432c374fc59mr12893755f8f.32.1767977602381; 
 Fri, 09 Jan 2026 08:53:22 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5edb7esm22988667f8f.30.2026.01.09.08.53.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 09 Jan 2026 08:53:21 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v5 21/22] system/ioport: Declare x86-specific I/O port in
 little-endian order
Date: Fri,  9 Jan 2026 17:50:57 +0100
Message-ID: <20260109165058.59144-22-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109165058.59144-1-philmd@linaro.org>
References: <20260109165058.59144-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

X86 in/out port (related to ISA bus) uses little endianness:
- enforce little endianness in x86 cpu_in/out() accessors,
- serialize QTest in/out port accesses as little-endian.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 system/ioport.c               | 10 +++++-----
 tests/qtest/endianness-test.c | 10 ++++++----
 tests/qtest/libqtest.c        | 13 +++++++++----
 3 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/system/ioport.c b/system/ioport.c
index 801e2490c36..4b94f2f8111 100644
--- a/system/ioport.c
+++ b/system/ioport.c
@@ -56,7 +56,7 @@ static void unassigned_io_write(void *opaque, hwaddr addr, uint64_t val,
 const MemoryRegionOps unassigned_io_ops = {
     .read = unassigned_io_read,
     .write = unassigned_io_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 void cpu_outb(uint32_t addr, uint8_t val)
@@ -71,7 +71,7 @@ void cpu_outw(uint32_t addr, uint16_t val)
     uint8_t buf[2];
 
     trace_cpu_out(addr, 'w', val);
-    stw_p(buf, val);
+    stw_le_p(buf, val);
     address_space_write(&address_space_io, addr, MEMTXATTRS_UNSPECIFIED,
                         buf, 2);
 }
@@ -81,7 +81,7 @@ void cpu_outl(uint32_t addr, uint32_t val)
     uint8_t buf[4];
 
     trace_cpu_out(addr, 'l', val);
-    stl_p(buf, val);
+    stl_le_p(buf, val);
     address_space_write(&address_space_io, addr, MEMTXATTRS_UNSPECIFIED,
                         buf, 4);
 }
@@ -102,7 +102,7 @@ uint16_t cpu_inw(uint32_t addr)
     uint16_t val;
 
     address_space_read(&address_space_io, addr, MEMTXATTRS_UNSPECIFIED, buf, 2);
-    val = lduw_p(buf);
+    val = lduw_le_p(buf);
     trace_cpu_in(addr, 'w', val);
     return val;
 }
@@ -113,7 +113,7 @@ uint32_t cpu_inl(uint32_t addr)
     uint32_t val;
 
     address_space_read(&address_space_io, addr, MEMTXATTRS_UNSPECIFIED, buf, 4);
-    val = ldl_p(buf);
+    val = ldl_le_p(buf);
     trace_cpu_in(addr, 'l', val);
     return val;
 }
diff --git a/tests/qtest/endianness-test.c b/tests/qtest/endianness-test.c
index 222d116fae2..2b2f92099d0 100644
--- a/tests/qtest/endianness-test.c
+++ b/tests/qtest/endianness-test.c
@@ -65,8 +65,9 @@ static uint16_t isa_inw(QTestState *qts, const TestCase *test, uint16_t addr)
         value = qtest_inw(qts, addr);
     } else {
         value = qtest_readw(qts, test->isa_base + addr);
+        value = test->bswap ? bswap16(value) : value;
     }
-    return test->bswap ? bswap16(value) : value;
+    return value;
 }
 
 static uint32_t isa_inl(QTestState *qts, const TestCase *test, uint16_t addr)
@@ -76,8 +77,9 @@ static uint32_t isa_inl(QTestState *qts, const TestCase *test, uint16_t addr)
         value = qtest_inl(qts, addr);
     } else {
         value = qtest_readl(qts, test->isa_base + addr);
+        value = test->bswap ? bswap32(value) : value;
     }
-    return test->bswap ? bswap32(value) : value;
+    return value;
 }
 
 static void isa_outb(QTestState *qts, const TestCase *test, uint16_t addr,
@@ -93,10 +95,10 @@ static void isa_outb(QTestState *qts, const TestCase *test, uint16_t addr,
 static void isa_outw(QTestState *qts, const TestCase *test, uint16_t addr,
                      uint16_t value)
 {
-    value = test->bswap ? bswap16(value) : value;
     if (test->isa_base == -1) {
         qtest_outw(qts, addr, value);
     } else {
+        value = test->bswap ? bswap16(value) : value;
         qtest_writew(qts, test->isa_base + addr, value);
     }
 }
@@ -104,10 +106,10 @@ static void isa_outw(QTestState *qts, const TestCase *test, uint16_t addr,
 static void isa_outl(QTestState *qts, const TestCase *test, uint16_t addr,
                      uint32_t value)
 {
-    value = test->bswap ? bswap32(value) : value;
     if (test->isa_base == -1) {
         qtest_outl(qts, addr, value);
     } else {
+        value = test->bswap ? bswap32(value) : value;
         qtest_writel(qts, test->isa_base + addr, value);
     }
 }
diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 622464e3656..132aa511375 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -31,6 +31,7 @@
 #include "libqtest.h"
 #include "libqmp.h"
 #include "qemu/accel.h"
+#include "qemu/bswap.h"
 #include "qemu/ctype.h"
 #include "qemu/cutils.h"
 #include "qemu/exit-with-parent.h"
@@ -1190,12 +1191,12 @@ void qtest_outb(QTestState *s, uint16_t addr, uint8_t value)
 
 void qtest_outw(QTestState *s, uint16_t addr, uint16_t value)
 {
-    qtest_out(s, "outw", addr, value);
+    qtest_out(s, "outw", addr, qtest_big_endian(s) ? bswap16(value) : value);
 }
 
 void qtest_outl(QTestState *s, uint16_t addr, uint32_t value)
 {
-    qtest_out(s, "outl", addr, value);
+    qtest_out(s, "outl", addr, qtest_big_endian(s) ? bswap32(value) : value);
 }
 
 static uint32_t qtest_in(QTestState *s, const char *cmd, uint16_t addr)
@@ -1220,12 +1221,16 @@ uint8_t qtest_inb(QTestState *s, uint16_t addr)
 
 uint16_t qtest_inw(QTestState *s, uint16_t addr)
 {
-    return qtest_in(s, "inw", addr);
+    uint16_t v = qtest_in(s, "inw", addr);
+
+    return qtest_big_endian(s) ? bswap16(v) : v;
 }
 
 uint32_t qtest_inl(QTestState *s, uint16_t addr)
 {
-    return qtest_in(s, "inl", addr);
+    uint32_t v = qtest_in(s, "inl", addr);
+
+    return qtest_big_endian(s) ? bswap32(v) : v;
 }
 
 static void qtest_write(QTestState *s, const char *cmd, uint64_t addr,
-- 
2.52.0


