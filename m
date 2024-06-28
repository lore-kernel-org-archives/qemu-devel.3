Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD6BDC2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 18:28:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNGK7-0004qh-Cz; Fri, 28 Jun 2024 14:27:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gregorhaas1997@gmail.com>)
 id 1sNGK5-0004pg-Ci
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 14:27:49 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gregorhaas1997@gmail.com>)
 id 1sNGK3-0001If-SX
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 14:27:49 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1f480624d10so6494535ad.1
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 11:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719599265; x=1720204065; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ll/QqfYOXnmYqKu32rIS7F8RQ9Ulu9HE3aVWNiR5uao=;
 b=bNwU1f3uZy7DxcATigx+HJ6n8QAo6lVyA8/6bMnwMmIxbEq+hEtJ47Xzz4aAkz8Wnr
 P35hQKNsfmUUgEMEzq/WUI6Htb6WbOxDkVyX5XclsiOBu6+x/wZkrPzRMccgE+9Qf2K3
 NrbyE99Ne56XOTRo4VywYdvkxpizp5x0+KfQ1khT7Yktl7RYKfM7KJDYEaeyb7y7euAv
 T5eByRCUO3Gkkbrv9IwjI4GpBoDw3wPmWkO8II3dD5OQx14C4qUpJLefX1oklr2CpY3X
 6GyvUWAQZ7mZZOV4CT0hkdOff8b29Xrg7zFQdVCBgD2OIgxz8FNfCKjxen8YncJc6s79
 8OyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719599265; x=1720204065;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ll/QqfYOXnmYqKu32rIS7F8RQ9Ulu9HE3aVWNiR5uao=;
 b=CJMJGGFa8qI3MAsH3cBZcXefmtaSll1BfYU3xTSGM9qpI7WZLDCS1FXNxfEvzCqQrA
 ZYgKu7CjMD5c175UIqmz1SsRm0G6a+itgZKV87tPdfWk4gKHuAuQwwe8ih7HiUkJrXkd
 OAY89E+TIcADtcOG/mXH2RVUSRfDP3D+jfP5+opQBfVoNVI3QsjBlF83uFYjugRSPQQ1
 bLSyq3yZvtqDXvVoh8wNPsiKI5EsDqGNnF8qACWqy6r96SSdKWoxwWbAs0mGfc0qxzF/
 nZPBV0nm8X3fiHN4YQLaBkb5qDdljPeixAAdh2CgYAnTBXge4xmo4hrgxeue4TkezLjO
 /6Qg==
X-Gm-Message-State: AOJu0Yw+fCuW8g1c453MuXZo8hs+F9zSLkUf9tsPHaH8RdWHl+60avjP
 tYoEaBEEMOvah5GLe0/of9NM72XKE9F6Ai25H6EuwDHoQEejWTDe9CCHMJzz
X-Google-Smtp-Source: AGHT+IEfQO2T3T0BhSE22Ir2w1rpOFhdxAR29BRgsQZrc5iJUSdyr+SKGSGnihJmVlKJ+dgsu9p5Dw==
X-Received: by 2002:a17:902:bb97:b0:1f6:6426:8da4 with SMTP id
 d9443c01a7336-1fa1d6aa3b3mr129770105ad.66.1719599264817; 
 Fri, 28 Jun 2024 11:27:44 -0700 (PDT)
Received: from localhost ([136.27.11.53]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1fac1599d9dsm18443975ad.292.2024.06.28.11.27.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Jun 2024 11:27:44 -0700 (PDT)
From: Gregor Haas <gregorhaas1997@gmail.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, yaoxt.fnst@fujitsu.com,
 Gregor Haas <gregorhaas1997@gmail.com>
Subject: [PATCH v4] hw/core/loader: allow loading larger ROMs
Date: Fri, 28 Jun 2024 11:27:06 -0700
Message-ID: <20240628182706.99525-1-gregorhaas1997@gmail.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=gregorhaas1997@gmail.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

The read() syscall is not guaranteed to return all data from a file. The
default ROM loader implementation currently does not take this into account,
instead failing if all bytes are not read at once. This change loads the ROM
using g_file_get_contents() instead, which correctly reads all data using
multiple calls to read() while also returning the loaded ROM size.

Signed-off-by: Gregor Haas <gregorhaas1997@gmail.com>
---
 hw/core/loader.c | 30 +++++-------------------------
 1 file changed, 5 insertions(+), 25 deletions(-)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index 2f8105d7de..44444a5714 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -1075,8 +1075,7 @@ ssize_t rom_add_file(const char *file, const char *fw_dir,
 {
     MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
     Rom *rom;
-    ssize_t rc;
-    int fd = -1;
+    g_autoptr(GError) gerr = NULL;
     char devpath[100];
 
     if (as && mr) {
@@ -1094,35 +1093,19 @@ ssize_t rom_add_file(const char *file, const char *fw_dir,
         rom->path = g_strdup(file);
     }
 
-    fd = open(rom->path, O_RDONLY | O_BINARY);
-    if (fd == -1) {
-        fprintf(stderr, "Could not open option rom '%s': %s\n",
-                rom->path, strerror(errno));
-        goto err;
-    }
-
     if (fw_dir) {
         rom->fw_dir  = g_strdup(fw_dir);
         rom->fw_file = g_strdup(file);
     }
     rom->addr     = addr;
-    rom->romsize  = lseek(fd, 0, SEEK_END);
-    if (rom->romsize == -1) {
-        fprintf(stderr, "rom: file %-20s: get size error: %s\n",
-                rom->name, strerror(errno));
+    if (!g_file_get_contents(rom->path, (gchar **) &rom->data,
+                             &rom->romsize, &gerr)) {
+        fprintf(stderr, "rom: file %-20s: error %s\n",
+                rom->name, gerr->message);
         goto err;
     }
 
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
@@ -1159,9 +1142,6 @@ ssize_t rom_add_file(const char *file, const char *fw_dir,
     return 0;
 
 err:
-    if (fd != -1)
-        close(fd);
-
     rom_free(rom);
     return -1;
 }
-- 
2.45.2


