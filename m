Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61BB6C55171
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Aug 2026 02:37:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpzbh-0001UA-Sq; Fri, 31 Jul 2026 22:37:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wpzbc-0001Hy-Fj
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 22:37:46 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wpzba-0002XD-9i
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 22:37:43 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-cbe431467e6so111651a12.1
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 19:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785551861; x=1786156661; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mRIiN4bf1GyXbgbG6arVWqnbJT+ocIWOAzhCW3OZ2/A=;
 b=lexT4aoHHVUduoFMwbZpH8ZrCs9cFjNIUiCYBSmOWDzHoZ2lvgbO3FFTG7AhWBFDdX
 ml1M4rZPQVV07zLdSQX675t8xQC1qduNjB42zlljmMQM1wn0eOPhSO4hPJJTpcRCFQsN
 WpIGkWZb0a/h/b2BuW6MtEPTNUkQkNDunb5wnqpeemVXKX2CAUOsrEerD/kZKjef4wvL
 fOyeXS559nSdjaXAN1LbZYoAtM3b36juEn4JcyeBRGTQcCOK8Qg/tOt626RwOfPKgEcL
 rbkyN+6wv6TMvGdRayo7feYOo7QhQNVwq2I0EtVL6hfE3IicgTH7I/fGXchi1xbr940Y
 ozxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785551861; x=1786156661;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mRIiN4bf1GyXbgbG6arVWqnbJT+ocIWOAzhCW3OZ2/A=;
 b=IcW9azbZ0oFV55LSJ66ziUYDaYhqhuW4pKwuZOdunEpvLf8JFfpbxGa5ViD+byU0P3
 hD4iGUnI0+Ui5p+iYNKsGDLi7PP5f3coy0jevwCOF/23FQxomBfBCkE8ic54HfAf2I1n
 vPUG3DbHUVBb4DMyyV+Ul8K+2AOWYYWMwp7+EBu3SYKfzbfDAsdi6/VXms3VLH09lGQm
 qHKLP1o+0syFQvtzd1ZyEmMbjsF9yDMGWlu0eENPeFXXt9CPSvdcqp9okIoGYErFnN1X
 R3CP6bNR2r2pd0scx08Ismw4s3Ufpb7beq2cQjV3rzSs2pKxULuJwuOtzcI2o9ZuRMep
 OoVw==
X-Gm-Message-State: AOJu0YwuqtL1zrIW80e4wFxuyFOo1zUJTw/SXeoKBeYcckO4+q1dN573
 AsHZcTlPndlF3Q38Y+5XiR0R4215A+rnxhysW7LD0GedI1gu9x6OciGUnyPHzaM7
X-Gm-Gg: AR+sD10aVGdbaTgXdKcnUWUK0jGv461ybL+FiY2LHKiNrZg035DCTtXihvQH/fYB9H+
 wqLzGkJOJ4lgm2zx8xi3Zyoykngk7Ith3/gCiD/qy36Bezn0v45CWIER1X25T3ovGk/6hiAb/9H
 7WvP+LThoeq0+e19e9WI39ROyLZajTBfGf/3FDUmq31Rivrwm29nUr/lfsJd0uGVsoFopmx2b/x
 zF7TO8ErptmS/mqjm20uBFlzafhzxfOXpNu25KJZHk2DGi/+nFsWt9qLET2W3zjKFaxyFwLiw8W
 nvwHrMtR78BvP+v2ZlHA9C3rHN/L3nF8OcV3HbfOM3LWWqoJkRj1qxcqzg2MZUrRbluM8MyzjCM
 StmbcIOaqyQH/wAKZfTgoe9D4S/te5HFKNIhyqWK2xdABrluMB3rlA/1HUO4IH9Tj+e/rixNzSe
 D7oyLcbAxbkqhsKkVcojoa4dCH0evcqULtgGPcIso/GOzP7n175LLVXpRE5asbnLfiTVN7m4mUS
 g99xsvYMzQExb3f
X-Received: by 2002:a05:6a21:4c06:b0:3bf:9e85:b423 with SMTP id
 adf61e73a8af0-3c91a9e1746mr4258320637.34.1785551860793; 
 Fri, 31 Jul 2026 19:37:40 -0700 (PDT)
Received: from setun ([223.228.61.127]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3153dd4e47dsm15678889eec.3.2026.07.31.19.37.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 19:37:40 -0700 (PDT)
From: Aadeshveer Singh <aadeshveer07@gmail.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, pbonzini@redhat.com, philmd@mailo.com,
 lvivier@redhat.com, ayoub@saferwall.com, pierrick.bouvier@oss.qualcomm.com,
 Aadeshveer Singh <aadeshveer07@gmail.com>
Subject: [PATCH v4 05/11] migration: Make qemu_get_buffer_at() thread-safe
Date: Sat,  1 Aug 2026 08:06:22 +0530
Message-ID: <20260801023628.22665-6-aadeshveer07@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260801023628.22665-1-aadeshveer07@gmail.com>
References: <20260801023628.22665-1-aadeshveer07@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=aadeshveer07@gmail.com; helo=mail-pg1-x52c.google.com
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


