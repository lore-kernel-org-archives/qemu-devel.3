Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90B31E73158
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 11:28:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vms6b-0000KA-B7; Mon, 02 Feb 2026 06:28:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vms6a-0000Jt-CA
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 06:28:32 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vms6Y-0004EM-Jm
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 06:28:32 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4806fbc6bf3so46348395e9.2
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 03:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770031708; x=1770636508; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8S74Wzl0i9P/za3Xu286f2tD0emvsrMYLtpoufvR6J0=;
 b=h5Ww+I6EwLtJR/bPrNmbSr82oK4RPLpQrMOKZfABo0O6s65IY0Ah2VSz0cXNA2/tbp
 Ng08lluKTGHh0lkO+5X3J/eILFZp8vFDKwmXEXOGrLx7qv+ewTBrIRHfqiRIJMt635W5
 /3LfDcMzDbozDL8P02xBlbJdPMFL8Y+GobX+8yGtC1+S/aFGq40wCj3fnbJ2w7ZmGry4
 lfprw9rITk9Vz0Kt4Kh3+Dm09oUT8nNsOT2MYYx19JRbkN0ACvbc6AV/pqGh/rFrCUaM
 +1SjUZkwne8LvphUODFGz3NCxDpzxDobtg/wore5zpjafGTIDiZEuf0ByZnVr1WPfklH
 K5QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770031708; x=1770636508;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8S74Wzl0i9P/za3Xu286f2tD0emvsrMYLtpoufvR6J0=;
 b=JMP+HKRU0/mZcc5upjkJ89dYwGdXsDvT6EfdoqCMDVTVoy4PAAkIFnhf+VZ0d2jtHP
 bXKEzZlWwMH8/ti5S37MvmW58GPVkBGSf8U5cP0TcVNAhz4lsEdBrt94qsGou3vJqswL
 WXmYV2NTDwhSgPJgdY5TMxD+BSBbotlBhVsUKABgd0Z2opPv+dHlRPW8Equ62FMvWybD
 QRaRuVvRHPEUYX7AIBO+1Qe2yv09EPJD9OI4Wx1mCxQdwuJAx7i2Xs8o34HCnXsr4XKt
 gpkibzY6Ldp51HescAgUPA+zYb6LDWT6UCVtiMCzMVt5lAt6lVV+XmVt3akk4g0EZe+e
 c4WQ==
X-Gm-Message-State: AOJu0YzHYu0bZDpM19I9hkc/eP0BftTRS5+BFEvSkRyNiTzBmEWjKnAq
 5Aiyrw9fMnLlHYiOzsgTD9nDjsbqXdImFzdNxR4AMDnZkOcb4yKebyEnU4xRo/lhnqCColsSg2+
 RrDj0xQM=
X-Gm-Gg: AZuq6aKUid4NPf6BrlNom4aabPy78jnGwU7PX+VaNTwosfiqCUYdt3JsnpsOp4a9PB0
 0Z8fyBR4BqqwRq0RY1m4H0mBa5AqRcQBRpVSMvH19RnuD2Av4ypadGUp7hIvew5JgWzlHReoYrv
 Q7gn1RBHBowv3J2kWV4LBoAyFN1+qkM8Rx+SdrfyNmP8BIQ22E+S0fdBmlQTyQLO2Ow9cUL2PjT
 i/6Y4TXQSlQ76QDfd/9Z/g+ocUJh8edWv/Z/xJil0tL11V5PpgSqxxZxPrxTw6J5E469GS8+H3h
 KfYWQcH6rXjcbGF5baIKNzoJdsM8XJ5hlUri06AAOuQ3IknZIHR2eQSdrTrR7BsX6a2bcAxhrMc
 yhvFz8BX8+8hXDOGCdnNwcTxpQXg+cuJZLDO7MSfVCmRobeSIH5Ruip+0DNvQ2e8KMe7X6UJ50v
 yXxYAQLcpAxb11zueeJhZXepalM+z/8BMgx4VF0xkgPIKbI7spfKqiu8mFrjjt
X-Received: by 2002:a05:600c:3f0d:b0:480:1e9e:f9d with SMTP id
 5b1f17b1804b1-482db45deccmr135725885e9.8.1770031708406; 
 Mon, 02 Feb 2026 03:28:28 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10e483asm41558788f8f.3.2026.02.02.03.28.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 02 Feb 2026 03:28:27 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v7] tests/unit: add unit test for qemu_hexdump()
Date: Mon,  2 Feb 2026 12:28:26 +0100
Message-ID: <20260202112826.38018-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Test that the fix in commit 20aa05edc2c ("util/hexdump: fix
QEMU_HEXDUMP_LINE_WIDTH logic") make sense.

To not break compilation when we build without 'block', move
hexdump.c out of "if have_block" in meson.build.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
v7:
- no need for close(fd) (implicit via fdclose)
v6:
- mention commit 20aa05edc2c in desc
- wrap long lines for checkpatch.pl
- use g_file_open_tmp()
---
 tests/unit/test-cutils.c | 66 ++++++++++++++++++++++++++++++++++++++++
 util/meson.build         |  2 +-
 2 files changed, 67 insertions(+), 1 deletion(-)

diff --git a/tests/unit/test-cutils.c b/tests/unit/test-cutils.c
index 75fae29003a..61f53a0c393 100644
--- a/tests/unit/test-cutils.c
+++ b/tests/unit/test-cutils.c
@@ -3626,6 +3626,67 @@ static void test_si_prefix(void)
     g_assert_cmpstr(si_prefix(18), ==, "E");
 }
 
+static void test_qemu_hexdump_alignment(void)
+{
+    /*
+     * Test that ASCII part is properly aligned for incomplete lines.
+     * This test catches the bug that was fixed in previous commit
+     * "util/hexdump: fix QEMU_HEXDUMP_LINE_WIDTH logic".
+     *
+     * We use data that is not aligned to 16 bytes, so last line
+     * is incomplete.
+     */
+    static const uint8_t data[] = {
+        /* First line: 16 bytes */
+        0x48, 0x65, 0x6c, 0x6c, 0x6f, 0x20, 0x57, 0x6f,  /* "Hello Wo" */
+        0x72, 0x6c, 0x64, 0x21, 0x20, 0x54, 0x68, 0x69,  /* "rld! Thi" */
+        /* Second line: 5 bytes (incomplete) */
+        0x73, 0x20, 0x69, 0x73, 0x20                     /* "s is " */
+    };
+    char *fname = NULL;
+    int fd;
+    g_autofree char *output = NULL;
+    size_t size, bytes_read;
+    FILE *f;
+
+    fd = g_file_open_tmp("test-qemu-hexdump-alignment-XXXXXX", &fname, NULL);
+    g_assert(fd >= 0);
+    g_assert_nonnull(fname);
+    f = fdopen(fd, "w+");
+
+    g_assert_nonnull(f);
+
+    qemu_hexdump(f, "test", data, sizeof(data));
+
+    size = ftell(f);
+    fseek(f, 0, SEEK_SET);
+
+    output = g_malloc(size + 1);
+    bytes_read = 0;
+    while (bytes_read < size) {
+        size_t chunk = fread(output + bytes_read, 1, size - bytes_read, f);
+        if (chunk == 0) {
+            break;
+        }
+        bytes_read += chunk;
+    }
+    g_assert_cmpuint(bytes_read, ==, size);
+    output[size] = '\0';
+
+    fclose(f);
+    unlink(fname);
+    g_free(fname);
+
+    /* We expect proper alignment of "s is" part on the second line */
+    static const char *expected =
+        "test: 0000: 48 65 6c 6c  6f 20 57 6f  72 6c 64 21  20 54 68 69   "
+        "Hello World! Thi\n"
+        "test: 0010: 73 20 69 73  20                                      "
+        "s is \n";
+
+    g_assert_cmpstr(output, ==, expected);
+}
+
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
@@ -3995,5 +4056,10 @@ int main(int argc, char **argv)
                     test_iec_binary_prefix);
     g_test_add_func("/cutils/si_prefix",
                     test_si_prefix);
+
+    /* qemu_hexdump() test */
+    g_test_add_func("/cutils/qemu_hexdump/alignment",
+                    test_qemu_hexdump_alignment);
+
     return g_test_run();
 }
diff --git a/util/meson.build b/util/meson.build
index a0cfdc30ba6..7c9445615d7 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -33,6 +33,7 @@ endif
 util_ss.add(files('defer-call.c'))
 util_ss.add(files('envlist.c', 'path.c', 'module.c'))
 util_ss.add(files('event.c'))
+util_ss.add(files('hexdump.c'))
 util_ss.add(files('host-utils.c'))
 util_ss.add(files('bitmap.c', 'bitops.c'))
 util_ss.add(files('fifo8.c'))
@@ -90,7 +91,6 @@ if have_block
   util_ss.add(files('buffer.c'))
   util_ss.add(files('bufferiszero.c'))
   util_ss.add(files('hbitmap.c'))
-  util_ss.add(files('hexdump.c'))
   util_ss.add(files('iova-tree.c'))
   util_ss.add(files('iov.c'))
   util_ss.add(files('nvdimm-utils.c'))
-- 
2.52.0


