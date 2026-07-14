Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57E40C44508
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 14:17:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjdwY-00068W-PZ; Tue, 14 Jul 2026 10:17:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wjdwW-00068L-Q4
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 10:17:05 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wjdwV-0002bu-6n
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 10:17:04 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-c85b73ffb52so2369737a12.3
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 07:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784038621; x=1784643421; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eYsZovgQobkBQ5sRuVVBlvzxAKOeE/rlJyGitsyhKOw=;
 b=QQx0IoL8iu+6xXXMnxpd/h3UvdH3jRyiwIs7U2qKDoMWSAlYuSTdrlQkaxpEotOMic
 VY+5NFV3vznWniUqHUqDCMavFEnNLdTzXcMxRQkIbGBlAMnTOJyr1zlXb/JDydHYyE1d
 UuPzbvvYim4AjQtJJ7b4MWfXdtwws24bfhkPLJldhW8T4wb0v1lbzJAwLWwKwKxRdFgR
 xOc7PR4SfWOsREEAOTqDH/+RefXtkj5g/+U6tCLZAoHcGx9WqOaHk5FImJL3b7P83GDt
 48pdTR9l+arwlZ1M9Ulr9yTZqeuZU+zbdJOKI/V/Qs2Q4ZZ7Xm+MsvzL9afTFt7nce0e
 uesw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784038621; x=1784643421;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=eYsZovgQobkBQ5sRuVVBlvzxAKOeE/rlJyGitsyhKOw=;
 b=Xqc6gSYL6p9YNbb/3a7H6DJsl0msZPfDzNkrPVDq6vOnV80RuLPgSjRYIx0NXFITEQ
 qwCKhF/lyPuK/Y6G5t3Pw+YomC8C5jhKMHrWdEjKD7qR/DOPgjx1VMZBYUoZUMpnwKJD
 +wqUUwUqkAAWffkXkgm03W9cNOYNLC9O/flOFJDOpHO/FXRrrgj7c32y+cHQpEp6jeb3
 6vjHIyZcFr5wqXTcBDnJpp+GurI0cAZk/NxGgzi69KGg0MF9iaVQPPjw9ZDd8oKscqZi
 oPK+Xk1o8s2wtgUMc8eNJ7aXwUzbMZk5a9yb9E+STSHJHoNKXWVupAAzdDySjGMIriQW
 43XA==
X-Gm-Message-State: AOJu0YyXWsVfVQ2d4ZwoihbCULSF9EZ+1uxtqHYSwOnoAZJq+ukNOAIM
 NqLLLrQ4Z5pMVtBCnGNNx/Xe/VtdBlsFavwKmBlL6Kw5Zj+FQgacrTI+fXi738U8
X-Gm-Gg: AfdE7ck7tNhJFWE/WQV7j3TIQdNp8n2uTqisBKQNFxwqhitlT/OsCq/wfaywq/R2lb2
 7JPkZFxeH4pk7sCTcAX1PG0IBxreI9r+aoZZVWjF1YQvag/L9cGwfzrPfVYeFbbDBNxV7Dr2A8L
 tsNL/svEyJutWe8Y5bpJOVK+mc5qjbLzFOZbAVh2AN2sPU7qbEylEoDuCth2BgdVL7s7uHp2arY
 8c+9+fd3krR+Z7gdbg+L3Q5q5BEYqKlECEQHSRFBLH7+Saql6i3kXFkwCvOWk+WQX2Gpivmx7aP
 6nIfisEexmYd84i0taXGlBFRsZjL63yJzFxWOe+AZZsBiYswBcsZBEPJ2lKjUlhQVmEoJ8ymIz3
 U2wrJaejh6HzhO3kSOytxBa+51HZao7A+PCNqxPhxaNTZsKlS1/QQaZX8GUSCRcwKO05kFCIlCM
 vgchLLxWz7TdFXj5xM7jpZKRVkh9qK/HsaYYzayvh95A==
X-Received: by 2002:a05:6300:670e:b0:3c0:9c19:659e with SMTP id
 adf61e73a8af0-3c110b7ee4fmr15291939637.70.1784038621185; 
 Tue, 14 Jul 2026 07:17:01 -0700 (PDT)
Received: from setun ([2405:201:502b:3014:cc0c:536:1b1e:6def])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3118ee6091dsm97329733eec.14.2026.07.14.07.16.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 07:17:00 -0700 (PDT)
From: Aadeshveer Singh <aadeshveer07@gmail.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, pbonzini@redhat.com, philmd@mailo.com,
 lvivier@redhat.com, ayoub@saferwall.com, pierrick.bouvier@oss.qualcomm.com,
 Aadeshveer Singh <aadeshveer07@gmail.com>
Subject: [PATCH v3 05/11] migration: Make qemu_get_buffer_at() thread-safe
Date: Tue, 14 Jul 2026 19:45:41 +0530
Message-ID: <20260714141547.1268000-6-aadeshveer07@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260714141547.1268000-1-aadeshveer07@gmail.com>
References: <20260714141547.1268000-1-aadeshveer07@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=aadeshveer07@gmail.com; helo=mail-pg1-x52a.google.com
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

Remove the internal QEMUFile error state modification from
qemu_get_buffer_at(). This function is called by two functions, both of
which already check for unexpected return values and handle their own
error reporting.

Removing this shared state modification makes qemu_get_buffer_at()
strictly thread-safe for concurrent disk reads, serving as a
preparatory change for the upcoming fast snapshot load feature.

Removed local error by passing errp to improve on error handling,
consequently also change caller to use error_prevent and not error_setg.

Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>
---
 migration/qemu-file.c | 9 +++------
 migration/qemu-file.h | 4 ++--
 migration/ram.c       | 6 +++---
 3 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index d5a48115bd..0c28c878a9 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -550,17 +550,14 @@ void qemu_put_buffer_at(QEMUFile *f, const uint8_t *buf, size_t buflen,
 }
 
 
-size_t qemu_get_buffer_at(QEMUFile *f, uint8_t *buf, size_t buflen,
-                          off_t pos)
+size_t qemu_get_buffer_at(QEMUFile *f, uint8_t *buf, size_t buflen, off_t pos,
+                          Error **errp)
 {
-    Error *err = NULL;
-
     if (f->last_error) {
         return 0;
     }
 
-    if (qio_channel_pread_all(f->ioc, buf, buflen, pos, &err) < 0) {
-        qemu_file_set_error_obj(f, -EIO, err);
+    if (qio_channel_pread_all(f->ioc, buf, buflen, pos, errp) < 0) {
         return 0;
     }
 
diff --git a/migration/qemu-file.h b/migration/qemu-file.h
index 8f824c124d..966766788d 100644
--- a/migration/qemu-file.h
+++ b/migration/qemu-file.h
@@ -76,8 +76,8 @@ void qemu_set_offset(QEMUFile *f, off_t off, int whence);
 off_t qemu_get_offset(QEMUFile *f);
 void qemu_put_buffer_at(QEMUFile *f, const uint8_t *buf, size_t buflen,
                         off_t pos);
-size_t qemu_get_buffer_at(QEMUFile *f, uint8_t *buf, size_t buflen,
-                          off_t pos);
+size_t qemu_get_buffer_at(QEMUFile *f, uint8_t *buf, size_t buflen, off_t pos,
+                          Error **errp);
 
 QIOChannel *qemu_file_get_ioc(QEMUFile *file);
 int qemu_file_put_fd(QEMUFile *f, int fd);
diff --git a/migration/ram.c b/migration/ram.c
index 4728f14d73..967db7c0db 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -4127,7 +4127,7 @@ static bool read_ramblock_mapped_ram(QEMUFile *f, RAMBlock *block,
                                               block->pages_offset + offset);
             } else {
                 read = qemu_get_buffer_at(f, host, size,
-                                          block->pages_offset + offset);
+                                          block->pages_offset + offset, errp);
             }
 
             if (!read) {
@@ -4196,8 +4196,8 @@ static void parse_ramblock_mapped_ram(QEMUFile *f, RAMBlock *block,
     bitmap_size = BITS_TO_LONGS(num_pages) * sizeof(unsigned long);
 
     if (qemu_get_buffer_at(f, (uint8_t *)block->file_bmap, bitmap_size,
-                           header.bitmap_offset) != bitmap_size) {
-        error_setg(errp, "Error reading dirty bitmap");
+                           header.bitmap_offset, errp) != bitmap_size) {
+        error_prepend(errp, "Error reading dirty bitmap");
         return;
     }
 
-- 
2.55.0


