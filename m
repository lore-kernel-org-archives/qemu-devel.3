Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C469C2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 17:36:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM9xb-0001TE-Qc; Tue, 25 Jun 2024 13:28:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbouman03@gmail.com>)
 id 1sM7Ys-0003e6-Qa
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 10:54:22 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbouman03@gmail.com>)
 id 1sM7Yr-0003Gl-4O
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 10:54:22 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-57cbc66a0a6so399786a12.1
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 07:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719327259; x=1719932059; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rbbUSVqqZXzZF+3uTUU0bNtjkD7QAaruiWfpJ52dpCQ=;
 b=k0CWagpBtv4+5W0IJODAw9qwFKM9Z9PZAEy3SD0nHKZ5K95Je7Jttffjs7J3NZCDqp
 q5FWBr7/FjovZgraXAhAwVBl5E0PDw21Rtjr3jgXRS8g4Q2iJPTj7JftKcHJMHMuMrOS
 +r0stSr/Xhy4hSa+qWXhdmFV72Q/P+9ZKqXWbJaRu81HzG/5iRZdchSDmXztcltaYun1
 c4iE/dZjMnetc40mrM5nN+1mu6bRh06ebeSChJlTCWrs5BxejjPknMIKRf/y/udCcbgW
 R3llabukIbOjKtl/tzkEBQABJVymlv/SSQ9BoTpEqFyEqNhdNmANixPMfBVpuLnivXmK
 hzog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719327259; x=1719932059;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rbbUSVqqZXzZF+3uTUU0bNtjkD7QAaruiWfpJ52dpCQ=;
 b=FAxIV1wp4efuX4gLTc7lADwYqV53iozV21BCTql9nDaES5nMJPD6UjvycvAgcq0UsB
 UABquyY8W9v8FZwW4TTLyJPG4sj0B6m+6F4C0+g3PQzIhp71NURle7M17xH0pgb1YEDJ
 xXW1unKzx+w25LXOXhDYZ6a2DKTvG7djEOUn3+z6e1lYdwG65kpll0/n+nRK/q/UyOhj
 NeUzYQqwtRXmosl1kwajEhwjnAMIDqsgA2kNH1NVqRxcVdU6VaqUKaTvBAu6fWoe5sZ+
 weh0225AiukMMyDpEdFkxI6bwrxbjvRVPJdcuswX7NhZfHn6gtChup0GxIo86qnB6QvO
 9Ang==
X-Gm-Message-State: AOJu0Yyl+qYie8zZ5iRrXz3ZnWYwdEQn12+nhLFc6cFx7EMZZLOrR+12
 CFz6Z/upwws7Dr+2YHuDIDsnvp+lgDcDycqLiRiyC+Qpmc9RGGGcaMFTzw==
X-Google-Smtp-Source: AGHT+IExjcGqP/+Yp+argbQqFMrMDhox0o8HA00ZaFqhGJVKN1W1DTcm4/KzQKeeuJ+pIrMnTlt14Q==
X-Received: by 2002:aa7:d6cd:0:b0:57d:22a1:25cc with SMTP id
 4fb4d7f45d1cf-57d447e24f5mr6569334a12.8.1719327259154; 
 Tue, 25 Jun 2024 07:54:19 -0700 (PDT)
Received: from 41414141.home (84-82-177-210.fixed.kpn.net. [84.82.177.210])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57d3042d421sm6092740a12.42.2024.06.25.07.54.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jun 2024 07:54:18 -0700 (PDT)
From: David Bouman <dbouman03@gmail.com>
To: qemu-devel@nongnu.org
Cc: David Bouman <dbouman03@gmail.com>
Subject: [PATCH 2/4] hw/usb/u2f-passthru: Do not needlessly retain handle to
 hidraw chardev
Date: Tue, 25 Jun 2024 16:53:48 +0200
Message-Id: <20240625145350.65978-3-dbouman03@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625145350.65978-1-dbouman03@gmail.com>
References: <20240625145350.65978-1-dbouman03@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=dbouman03@gmail.com; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 25 Jun 2024 13:25:46 -0400
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

The Linux kernel presumes a hidraw device to be "active" as long
as an open handle to its character device exists, and during that time
will actively poll its bus for new messages.

The u2f-passthru device keeps an open handle to the hidraw character device
for its entire lifetime, wasting power and causing its queue to be
clogged with irrelevant packets that were not initiated by the guest.

To mitigate this, use the u2f `start` and `stop` callbacks to
dynamically open the handle when the guest is about to use the
u2f-passthru device (start callback), and close it again whenever
the guest stops using it (stop callback).

Signed-off-by: David Bouman <dbouman03@gmail.com>
Fixes: 299976b050bf (hw/usb: Add U2F key passthru mode)
---
 hw/usb/u2f-passthru.c | 84 +++++++++++++++++++++++++++++++------------
 1 file changed, 61 insertions(+), 23 deletions(-)

diff --git a/hw/usb/u2f-passthru.c b/hw/usb/u2f-passthru.c
index b7025d303d..54062ab4d5 100644
--- a/hw/usb/u2f-passthru.c
+++ b/hw/usb/u2f-passthru.c
@@ -118,7 +118,10 @@ static inline uint16_t packet_init_get_bcnt(
 static void u2f_passthru_reset(U2FPassthruState *key)
 {
     timer_del(&key->timer);
-    qemu_set_fd_handler(key->hidraw_fd, NULL, NULL, key);
+
+    if (key->hidraw_fd >= 0) {
+        qemu_set_fd_handler(key->hidraw_fd, NULL, NULL, key);
+    }
     key->last_transaction_time = 0;
     key->current_transactions_start = 0;
     key->current_transactions_end = 0;
@@ -456,47 +459,79 @@ static int u2f_passthru_open_from_scan(void)
 }
 #endif
 
-static void u2f_passthru_unrealize(U2FKeyState *base)
-{
-    U2FPassthruState *key = PASSTHRU_U2F_KEY(base);
-
-    u2f_passthru_reset(key);
-    qemu_close(key->hidraw_fd);
-}
 
-static void u2f_passthru_realize(U2FKeyState *base, Error **errp)
+static int u2f_passthru_open_hidraw(U2FPassthruState *key, Error** errp)
 {
-    U2FPassthruState *key = PASSTHRU_U2F_KEY(base);
     int fd;
-
     if (key->hidraw == NULL) {
 #ifdef CONFIG_LIBUDEV
         fd = u2f_passthru_open_from_scan();
-        if (fd < 0) {
+
+        if (fd < 0 && errp) {
             error_setg(errp, "%s: Failed to find a U2F USB device",
                        TYPE_U2F_PASSTHRU);
-            return;
         }
 #else
-        error_setg(errp, "%s: Missing hidraw", TYPE_U2F_PASSTHRU);
-        return;
+        if (errp) {
+            error_setg(errp, "%s: Missing hidraw", TYPE_U2F_PASSTHRU);
+        }
+        return -1;
 #endif
     } else {
         fd = qemu_open_old(key->hidraw, O_RDWR);
-        if (fd < 0) {
+
+        if (fd < 0 && errp) {
             error_setg(errp, "%s: Failed to open %s", TYPE_U2F_PASSTHRU,
                        key->hidraw);
-            return;
-        }
 
-        if (!u2f_passthru_is_u2f_device(fd)) {
+        } else if (!u2f_passthru_is_u2f_device(fd)) {
             qemu_close(fd);
-            error_setg(errp, "%s: Passed hidraw does not represent "
-                       "a U2F HID device", TYPE_U2F_PASSTHRU);
-            return;
+            if (errp) {
+                error_setg(errp, "%s: Passed hidraw does not represent "
+                           "a U2F HID device", TYPE_U2F_PASSTHRU);
+            }
+            return -1;
         }
     }
-    key->hidraw_fd = fd;
+
+    return fd;
+}
+
+static bool u2f_passthru_start(U2FKeyState *base)
+{
+    U2FPassthruState *key = PASSTHRU_U2F_KEY(base);
+
+    if (key->hidraw_fd < 0) {
+        key->hidraw_fd = u2f_passthru_open_hidraw(key, NULL);
+    }
+    return key->hidraw_fd >= 0;
+}
+
+static void u2f_passthru_stop(U2FKeyState *base)
+{
+    U2FPassthruState *key = PASSTHRU_U2F_KEY(base);
+
+    u2f_passthru_reset(key);
+    if (key->hidraw_fd >= 0) {
+        qemu_close(key->hidraw_fd);
+        key->hidraw_fd = -1;
+    }
+}
+
+static void u2f_passthru_unrealize(U2FKeyState *base)
+{
+    u2f_passthru_stop(base);
+}
+static void u2f_passthru_realize(U2FKeyState *base, Error **errp)
+{
+    U2FPassthruState *key = PASSTHRU_U2F_KEY(base);
+    int fd = u2f_passthru_open_hidraw(key, errp);
+
+    /* we only open the fd to error at start */
+    if (fd >= 0) {
+        qemu_close(fd);
+    }
+    key->hidraw_fd = -1;
     u2f_passthru_reset(key);
 }
 
@@ -531,6 +566,9 @@ static void u2f_passthru_class_init(ObjectClass *klass, void *data)
     kc->realize = u2f_passthru_realize;
     kc->unrealize = u2f_passthru_unrealize;
     kc->recv_from_guest = u2f_passthru_recv_from_guest;
+    kc->start = u2f_passthru_start;
+    kc->stop  = u2f_passthru_stop;
+
     dc->desc = "QEMU U2F passthrough key";
     dc->vmsd = &u2f_passthru_vmstate;
     device_class_set_props(dc, u2f_passthru_properties);
-- 
2.34.1


