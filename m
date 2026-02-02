Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4C52E7FDE2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 21:21:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn1LW-0004R4-KN; Mon, 02 Feb 2026 16:20:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn1LU-0004Qg-Rm
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 16:20:32 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn1LS-0007Jr-2E
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 16:20:31 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-47edd6111b4so52426515e9.1
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 13:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770067227; x=1770672027; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8U4A80jC7+/79AhHavykypKcf13HzhPLu4pYUv3S2WQ=;
 b=N/ZE3G/JP7wdIJ+hTbvHQtBrCVnczTskoZPO8Yhm5s7Fkz1E5i1Gs3X1aqcGKHFm8W
 1dpbLCRfLHAIYV+PLzcvtSzEMzXaiC1JXqWIzzAPzmzwNgvg71KoYcigOUkcsQewo6gs
 iUXostYWZ4S1UE/Sk/zccRQOozoRyFCNME/awnIwVmWNAaVKIqdJ2JUF4hVzAbwNM+mg
 WPOv8+iLUa9Y+qAjsqFyS6GGldQ5XAidxNjPRD/vB98xSdkGF+xalMymUWY8o7y6WKKy
 xSQbww0JnMmn2Z5N7WuKqFwFFlx+K6kLNWuZWatX50/TGcTtoP2ZDwScb+d0fc85w1GD
 wp6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770067227; x=1770672027;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8U4A80jC7+/79AhHavykypKcf13HzhPLu4pYUv3S2WQ=;
 b=kCex3BBtxxT9362QacZZdxkrq3+LuB3Y+Zf+nekX8eRXH+1685+XtmHxDw3P4opLA9
 vk8kdEVr+wVS8UcSFX99gJOknE6VPNiQJIzf8a6NLHJTl1FSqGkQ+ip9poRYvHfJ7z1g
 XJlLobfflDRLzgGS6TrP7rXThL9ZjsGFvcpJtho0u7xY1Rsu8h77D5tEu2lP+er7Hws+
 ChHsH+VEkf2NvR3guaSF42DObmmk7Lm4ahZsEuI8+CMJ38PgGRK2QnJxy7z2iXfv78dX
 746wWOL0LkkTj6X6dD2qU0l3wzGjlgjCvdF3Nj/751FLbI0EuQF14ZfyBHQEyVLLzl5g
 Y6lQ==
X-Gm-Message-State: AOJu0YwUCF4JZUkVTRCC51DAq6TuO/qHwG+1Er4AHHhXsiu6hOdLQYZz
 C/o7KjD4aLTDWZsWbD4uuPOtn3nWxGi5nzZhOMo6V9vpcrxuNs1saoMKM7MuA/nYBdqJpq8Tx4w
 4mnCvfXI=
X-Gm-Gg: AZuq6aK66KY3GPn5/16yQAFzUaheO+8OgRTFUo5WnlkMxBounvDlvAb6Wans4DkFCUG
 3reARTGZVRuzf4Q/2BdU//rF8L8rJVQKaJASmTkgcvJUYxmv1x/+ZmJymr0lEno5C2NzV0HqgfH
 jRzYRX7Q+wDauOJNuUy2rk+JEfYvThzWWrjg9vk2aED8gHeUCeNJ7kKY0rvqQ+tDviz2N7xArbL
 W8gwVcQ8K5i2Y8cZ/fE9XGBqs4EJ5EdHF5Y2g4Hp+aTX77p72zc36ujbeEPKqzRdp9EfrYJpwQD
 qCJO+kj2tGqIkbPevcRRH233s4FadvsUl78MBW0JiE2vD0wB8Ee7GvubfoZC2WxSVh84ploZcOU
 zPrPFzR11VKMxic3Nuz1Z0L7SQEfBRvQVeFVQg4HDtNqotf3ZSwDWqLRzQLVNrhYc0ZnkhVZeQ7
 0x3yJ6FKVR5XAfKLG9ksfy2ovOlHFE5A9FOUWXQuHuIt9MQpxqfN7kL2FBpoNf
X-Received: by 2002:a05:6000:3110:b0:435:db94:1933 with SMTP id
 ffacd0b85a97d-435f3a6b9e0mr18725439f8f.1.1770067227551; 
 Mon, 02 Feb 2026 13:20:27 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e132303fsm47077201f8f.36.2026.02.02.13.20.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 02 Feb 2026 13:20:26 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/16] tests/unit: add unit test for qemu_hexdump()
Date: Mon,  2 Feb 2026 22:20:04 +0100
Message-ID: <20260202212019.94205-2-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260202212019.94205-1-philmd@linaro.org>
References: <20260202212019.94205-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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
Message-Id: <20260202112826.38018-1-philmd@linaro.org>
---
 tests/unit/test-cutils.c | 66 ++++++++++++++++++++++++++++++++++++++++
 util/meson.build         |  2 +-
 2 files changed, 67 insertions(+), 1 deletion(-)

diff --git a/tests/unit/test-cutils.c b/tests/unit/test-cutils.c
index 75fae29003a..1fa4113ef4d 100644
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
+            "Hello World! Thi\n"
+        "test: 0010: 73 20 69 73  20                                      "
+            "s is \n";
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


