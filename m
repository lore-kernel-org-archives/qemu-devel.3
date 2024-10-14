Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47367D1624A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 11:46:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0JUa-0006dj-GL; Mon, 14 Oct 2024 07:44:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1t0JUW-0006cq-OK
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 07:44:00 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1t0JUU-00056k-MG
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 07:44:00 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a994cd82a3bso623078066b.2
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 04:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728906227; x=1729511027; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QKeU6Sst3mOvcdt2OZL+D4LtHqpR806Hah+uBtunjhM=;
 b=IDkvsGCMFGzbIRRW3Obqdkw+svsn4s1yquSnc9hqpGuiOogFpqI/sA0cYdNpQehShX
 Sa/vRpzIImkALgLV+IChBRKcaOvKq3ms8+3XwdsNuanCyWGhuz8Z0c4JYCtyC9Iqg8gx
 YxIgTqF9q9SckAiuvt6+UZ/NXf63Qf2wWinE/UnYQmQ5ftP1pLKS8uKScmz2eTcBdDtG
 9jn4JpY0vb557YiDLEOPtueos4n3EEKBBvol4/fvixfHUsWy0BY9bcFIu+xUAt+yLtCk
 az0gA2KDRCO5x2MSPVBDwf6vZ0Pi/FESOzsN9feiJfD6tZvEFjoQ4yQDr21/2PCmfO1G
 qYvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728906227; x=1729511027;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QKeU6Sst3mOvcdt2OZL+D4LtHqpR806Hah+uBtunjhM=;
 b=mJonC7sLMT7Dk9HQaMETMXoG0lRnvpEJ50fa4AaF6Dy+PaqUQ4lkk59kJsqHbXDpZI
 yd4Ny7bqDvCYQb+xpMNBk22TprWjhMN/++l9lYMxbcZ2Xv3CI6zdK4YiHVMxprM+01OI
 uC1c7BBlGOwhKOWjh38EbfGBJWfwXiXauG59UA3nPjf2ELUVJyb5WRxKUR5y2SPDo7EL
 hqGntyscEj232RHR2OKRY6cn4VNtZmXNngW5yQAsiiUtnKgabmSMz5+ZCd8ccMCsk6VY
 5C9dHeHuV1TYsVcnrWPc3nEOAzdQrEx6qMbKkLn7rGIGi+X21hDuRNBQlasEzPtsujKG
 YelQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgx10l2c+ljnfvIseZ7KpVQQTDmjwdZKWolQD8m1NvlUW1s4yrBb49vXUfZXbagNJfuMGMI2W3t5jr@nongnu.org
X-Gm-Message-State: AOJu0Yxb04SmnIADktGHzyKCT52OPcBakhV5UkiiZP+fqXQXXwkFbT9f
 dPaFdZpgeIrss7Mo+nY37B4LMIPHHt+mqOIzLwWSiV7swCUYUsvklQIcAQ==
X-Google-Smtp-Source: AGHT+IF20XS3rMdTFBDoqNVmpTk8olWOkaedW8omauTVzVXigYa9CsUsFbkXovYHWkRjVGQcwz9TUA==
X-Received: by 2002:a17:906:99c4:b0:a99:5f16:3539 with SMTP id
 a640c23a62f3a-a99b8e9f11bmr1087525766b.0.1728906226629; 
 Mon, 14 Oct 2024 04:43:46 -0700 (PDT)
Received: from finn.fritz.box ([2a02:8109:8384:1400:eb7f:8fd0:f96c:766b])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99fcb2765asm247764666b.64.2024.10.14.04.43.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 04:43:45 -0700 (PDT)
From: Roman Penyaev <r.peniaev@gmail.com>
To: 
Cc: Roman Penyaev <r.peniaev@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH 3/8] chardev/mux: use bool type for `linestart` and
 `term_got_escape`
Date: Mon, 14 Oct 2024 13:41:30 +0200
Message-Id: <20241014114135.389766-4-r.peniaev@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241014114135.389766-1-r.peniaev@gmail.com>
References: <20241014114135.389766-1-r.peniaev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=r.peniaev@gmail.com; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Those are boolean variables, not signed integers.

Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
---
 chardev/char-mux.c         | 10 +++++-----
 chardev/chardev-internal.h |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/chardev/char-mux.c b/chardev/char-mux.c
index ee2d47b20d9b..728596c6f346 100644
--- a/chardev/char-mux.c
+++ b/chardev/char-mux.c
@@ -73,11 +73,11 @@ static int mux_chr_write(Chardev *chr, const uint8_t *buf, int len)
                  * qemu_chr_fe_write and background I/O callbacks */
                 qemu_chr_fe_write_all(&d->chr,
                                       (uint8_t *)buf1, strlen(buf1));
-                d->linestart = 0;
+                d->linestart = false;
             }
             ret += qemu_chr_fe_write(&d->chr, buf + i, 1);
             if (buf[i] == '\n') {
-                d->linestart = 1;
+                d->linestart = true;
             }
         }
     }
@@ -145,7 +145,7 @@ static void mux_chr_be_event(Chardev *chr, QEMUChrEvent event)
 static int mux_proc_byte(Chardev *chr, MuxChardev *d, int ch)
 {
     if (d->term_got_escape) {
-        d->term_got_escape = 0;
+        d->term_got_escape = false;
         if (ch == term_escape_char) {
             goto send_char;
         }
@@ -175,11 +175,11 @@ static int mux_proc_byte(Chardev *chr, MuxChardev *d, int ch)
         case 't':
             d->timestamps = !d->timestamps;
             d->timestamps_start = -1;
-            d->linestart = 0;
+            d->linestart = false;
             break;
         }
     } else if (ch == term_escape_char) {
-        d->term_got_escape = 1;
+        d->term_got_escape = true;
     } else {
     send_char:
         return 1;
diff --git a/chardev/chardev-internal.h b/chardev/chardev-internal.h
index c3024b51fdda..975c16de803e 100644
--- a/chardev/chardev-internal.h
+++ b/chardev/chardev-internal.h
@@ -39,7 +39,7 @@ struct MuxChardev {
     CharBackend chr;
     int focus;
     int mux_cnt;
-    int term_got_escape;
+    bool term_got_escape;
     /* Intermediate input buffer catches escape sequences even if the
        currently active device is not accepting any input - but only until it
        is full as well. */
@@ -49,7 +49,7 @@ struct MuxChardev {
     int timestamps;
 
     /* Protected by the Chardev chr_write_lock.  */
-    int linestart;
+    bool linestart;
     int64_t timestamps_start;
 };
 typedef struct MuxChardev MuxChardev;
-- 
2.34.1


