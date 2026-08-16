Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AF08C5DF6D
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 17:48:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvexE-00086N-M9; Sun, 16 Aug 2026 13:47:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wvexC-000801-EE
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 13:47:26 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wvexA-00038y-Kc
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 13:47:26 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-38759bcd877so3015480a91.2
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 10:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786902443; x=1787507243; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LEb4IeU8xhFAOEs1BVpDht8XPPtt6nino35RRBxs/u4=;
 b=R2HUu3Mb1BlMdIwuMD/uBm4BQ+xdCFoALR1rMo6DhaLiHaoJgSX3kWtfyuzBl/sJOL
 7W/jmaFn6ppOX4fBo6Y8N2Y6VzluUCp0iX6jaYxkJC73pFMO7NfUiFfm92tq5B7koc+R
 sCe1pEo3oeUGIX8VjCwBqiqYJgdUqHOmY41KJpSTCgErxINagBPk2ORjb6U/hr08G75o
 kNDzFaqsTqfq7i+q8rKLJnRP00QJAo/Z4VehVrJD350W2w/mwn4xn4+s7AafvikmKjux
 QRfUBGxNp09sRw7H8k8UP8eF+LfOqMgcwo/9VaGMhHhe/3do8eWQqj9hc+0ODS0WK7wh
 F2NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786902443; x=1787507243;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=LEb4IeU8xhFAOEs1BVpDht8XPPtt6nino35RRBxs/u4=;
 b=hFiohO+00KX+uYKYzebexLHSYH3ZzD5e65gvUL3sWhdXGX8q/+xSMBNKqDHmU67+2j
 aY2IjXL8NM1IC/+W1CQXpNkFmUvMDzuxzZINWTNJZMm7XGorfLnB3fqmJ9lNmslYBfw2
 YixtYyU5Wgy19IK9QnGxXd3ubxikIUDIT9AbeEd8xQR5dDdfbDVzRs1i7T/ohrQOZn0g
 gP4JIyKIlcWyRdLL7t/rOXDnBu26saMEeyOY6Fi09FMGdA+yuFXhnwCcgkszpZbKwm1M
 8kWZ7xZi3PWP4UZNbVR++UvOiMo5ygveBneuyFohJQdXo15Kz99yE8PHu6mwWfvn+qXG
 j7Xw==
X-Gm-Message-State: AOJu0YzIpgoColtW4+ZCjZ0abgB8Oc4SPg5rOeeSkXzUy5JLs861ZtZG
 6N8Jf4L4CZIrUnWWoMxn5sBC1Za6gQn5QMtK9BvOwfsg0PCCtHnMKGBnr+NfWAAr
X-Gm-Gg: AR+sD10IdeNGFQxrlk4Qi3eCNbt/e6CDrbMorsBWQy5bBRtIYdWCdtJZWa/DdSZYIOI
 QHWFp1fLXcaiuM4y4JT8/0xm5L4yUgQ/oLLvLuZMd1CtQ6nFGfJtEz62fSvTqaxHFJuJ2WjXxPX
 UKlfwi/L9pEHFCg7uYXSa+oCYRsCV7c+ppOXVWfLtvlrb7vHS4X2kjQ6VHXmePp6Nl6BLtboe0h
 fGE8XKfXF+xGSi/GUZs+HRy2G6ZtMhMCT2EYs9yGdFDMY30BNBpaG3pPybVBS/E5RET5qCdClxK
 KJOw17510+1OeXoGPa/vatQO8bxk3t5F/PdQFhAembnJ2GJP8PYyGXCbvPKpXDgPmVlF0ZSzK2a
 WeAVysWEFM7R0fskv3r02FxkbP7dNx10vP+SQrkmneyxgGK5MDRxzt4KoHH2zA+OKxYEC6kBAKt
 IR8uucp5fOix3PV09wkzkkkPQtaEUV9bz1kCO2P5prQKtngwzL9U+USuhUwXnEHuzfTWq3yCnkD
 kDa+pkbECh2TjY=
X-Received: by 2002:a17:90b:384f:b0:390:b41a:b92f with SMTP id
 98e67ed59e1d1-3933e648702mr19122496a91.18.1786902442753; 
 Sun, 16 Aug 2026 10:47:22 -0700 (PDT)
Received: from setun ([223.228.54.80]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-320ead105a9sm28343674eec.31.2026.08.16.10.47.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Aug 2026 10:47:22 -0700 (PDT)
From: Aadeshveer Singh <aadeshveer07@gmail.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, pbonzini@redhat.com, philmd@mailo.com,
 lvivier@redhat.com, ayoub@saferwall.com, pierrick.bouvier@oss.qualcomm.com,
 Aadeshveer Singh <aadeshveer07@gmail.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH v5 05/11] migration: Make qemu_get_buffer_at() thread-safe
Date: Sun, 16 Aug 2026 23:16:25 +0530
Message-ID: <20260816174631.1547811-6-aadeshveer07@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260816174631.1547811-1-aadeshveer07@gmail.com>
References: <20260816174631.1547811-1-aadeshveer07@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=aadeshveer07@gmail.com; helo=mail-pj1-x102c.google.com
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

Set errp in case of f->last_error as function should set errp in case it
fails, and caller can simply use error_prepend without checking errp in
case of error.

Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
---
 migration/qemu-file.c | 11 +++++------
 migration/qemu-file.h |  4 ++--
 migration/ram.c       |  6 +++---
 3 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index d5a48115bd..2feaeb8982 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -550,17 +550,16 @@ void qemu_put_buffer_at(QEMUFile *f, const uint8_t *buf, size_t buflen,
 }
 
 
-size_t qemu_get_buffer_at(QEMUFile *f, uint8_t *buf, size_t buflen,
-                          off_t pos)
+size_t qemu_get_buffer_at(QEMUFile *f, uint8_t *buf, size_t buflen, off_t pos,
+                          Error **errp)
 {
-    Error *err = NULL;
-
     if (f->last_error) {
+        error_setg(errp, "Cannot read from file: stream is in error state %d",
+                   f->last_error);
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


