Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61EE4C3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 18:10:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTmcd-00066s-V7; Tue, 16 Jul 2024 14:09:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTmcb-0005xF-FR
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 14:09:53 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTmcZ-0000tk-Ga
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 14:09:53 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-367990aaef3so3475527f8f.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 11:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721153389; x=1721758189; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+SuZjNq7VfYR+yUP5NB/Weekc2q9mEwEfGGbbLYskCs=;
 b=W68+pylefKOECTzT1CgRHZKODUyNXt3jPtJpGUG6pySLu+m+K5C+Bsuge3vNS2o5hK
 2iJ07klONyCnmYKnCf0wgGiee99h4j6pqwxkY9PUM2Vq1yqoAoORhZ8mX+ifu0WYGAfo
 Wc+73quMWAOTyjqyD0cwOuZmTiNpXxq0KQwdL1CDBgIKrc2oJoaId+uUMweVBvEpgdNe
 LR2wdiDOBr9N7jX/UN/IRY762swzHGypvei6SPsCFRJ8yxaA/qVvYh+RHcJYiH+O69SP
 W9oTGzHP/KOLU4kIQFAYYyHIHeK9o6yLYP2JGBD8NvwemXJ8gfsnNTG6wcnHTkt8E8W6
 LsGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721153389; x=1721758189;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+SuZjNq7VfYR+yUP5NB/Weekc2q9mEwEfGGbbLYskCs=;
 b=NiUfW/HqyOr4KN94j3QStXcc02w41oEebqQGby5l/E+AlUH4yHVkxSmjPySVs2OuV/
 mF8f2/dqyvWvSpt6Nu8CcqC4BxJDDIz6kt6NBYHr5e6UIEpydGej1l57HhMJ1zBun1lx
 MhkWcmv3NrE+fyzejLyWfXnVGORT4r7S8w50/aJCyNniuvQvIbsAT6LsS3aNah0bcXl1
 yu0dIftrZwtcKKVaGqHh2VW3ZN7Q40AjIEzNsK+4uu5OlLjxh0EJ1Q+tXluCYPdQ4P+g
 Dsd4qZS7aQPC75vhTK5KhgVuj3lTOFlfEewGaBUjSFRdZ/ySWqhl2LzXrIS+FDK+uxZE
 nVeA==
X-Gm-Message-State: AOJu0YzB3Qnq6TwCCNjsteu/ftYAu6FpLXJYTYEoxEfpuHs/JwXGML0k
 KlRxRzOeEg/jZsSBLUeBsV3fGgjGcBsoxqiPUUB1dsYvulV5flqQhnd1RVJsXXfLV2y6DulW7hd
 M1t5RmA==
X-Google-Smtp-Source: AGHT+IEKkaHmsJNvgtJPh1NAzyJERJ2LC57+in97IzNkfAUXYvu3XPwo79A9B2TCdTdUNqq+Fa11ig==
X-Received: by 2002:adf:dd83:0:b0:364:3ba5:b629 with SMTP id
 ffacd0b85a97d-3682610f680mr1966923f8f.20.1721153389591; 
 Tue, 16 Jul 2024 11:09:49 -0700 (PDT)
Received: from localhost.localdomain ([176.187.209.82])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427ba20aaf8sm29584465e9.0.2024.07.16.11.09.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 16 Jul 2024 11:09:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gregor Haas <gregorhaas1997@gmail.com>,
 Xingtao Yao <yaoxt.fnst@fujitsu.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 01/13] hw/core/loader: allow loading larger ROMs
Date: Tue, 16 Jul 2024 20:09:28 +0200
Message-ID: <20240716180941.40211-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240716180941.40211-1-philmd@linaro.org>
References: <20240716180941.40211-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

From: Gregor Haas <gregorhaas1997@gmail.com>

The read() syscall is not guaranteed to return all data from a file. The
default ROM loader implementation currently does not take this into account,
instead failing if all bytes are not read at once. This change loads the ROM
using g_file_get_contents() instead, which correctly reads all data using
multiple calls to read() while also returning the loaded ROM size.

Signed-off-by: Gregor Haas <gregorhaas1997@gmail.com>
Reviewed-by: Xingtao Yao <yaoxt.fnst@fujitsu.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240628182706.99525-1-gregorhaas1997@gmail.com>
[PMD: Use gsize with g_file_get_contents()]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/core/loader.c | 32 +++++++-------------------------
 1 file changed, 7 insertions(+), 25 deletions(-)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index a3bea1e718..39bd8f9e4d 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -1076,8 +1076,8 @@ ssize_t rom_add_file(const char *file, const char *fw_dir,
 {
     MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
     Rom *rom;
-    ssize_t rc;
-    int fd = -1;
+    gsize size;
+    g_autoptr(GError) gerr = NULL;
     char devpath[100];
 
     if (as && mr) {
@@ -1095,10 +1095,10 @@ ssize_t rom_add_file(const char *file, const char *fw_dir,
         rom->path = g_strdup(file);
     }
 
-    fd = open(rom->path, O_RDONLY | O_BINARY);
-    if (fd == -1) {
-        fprintf(stderr, "Could not open option rom '%s': %s\n",
-                rom->path, strerror(errno));
+    if (!g_file_get_contents(rom->path, (gchar **) &rom->data,
+                             &size, &gerr)) {
+        fprintf(stderr, "rom: file %-20s: error %s\n",
+                rom->name, gerr->message);
         goto err;
     }
 
@@ -1107,23 +1107,8 @@ ssize_t rom_add_file(const char *file, const char *fw_dir,
         rom->fw_file = g_strdup(file);
     }
     rom->addr     = addr;
-    rom->romsize  = lseek(fd, 0, SEEK_END);
-    if (rom->romsize == -1) {
-        fprintf(stderr, "rom: file %-20s: get size error: %s\n",
-                rom->name, strerror(errno));
-        goto err;
-    }
-
+    rom->romsize  = size;
     rom->datasize = rom->romsize;
-    rom->data     = g_malloc0(rom->datasize);
-    lseek(fd, 0, SEEK_SET);
-    rc = read(fd, rom->data, rom->datasize);
-    if (rc != rom->datasize) {
-        fprintf(stderr, "rom: file %-20s: read error: rc=%zd (expected %zd)\n",
-                rom->name, rc, rom->datasize);
-        goto err;
-    }
-    close(fd);
     rom_insert(rom);
     if (rom->fw_file && fw_cfg) {
         const char *basename;
@@ -1160,9 +1145,6 @@ ssize_t rom_add_file(const char *file, const char *fw_dir,
     return 0;
 
 err:
-    if (fd != -1)
-        close(fd);
-
     rom_free(rom);
     return -1;
 }
-- 
2.41.0


