Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E8BFFF885D
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Apr 2026 09:39:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGZTG-000598-AI; Sat, 25 Apr 2026 05:38:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <makovick@gmail.com>)
 id 1wGZTC-00058O-Qz
 for qemu-devel@nongnu.org; Sat, 25 Apr 2026 05:38:39 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <makovick@gmail.com>)
 id 1wGZTB-0005zy-8Q
 for qemu-devel@nongnu.org; Sat, 25 Apr 2026 05:38:38 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-43d7badbd7dso4258769f8f.2
 for <qemu-devel@nongnu.org>; Sat, 25 Apr 2026 02:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777109915; x=1777714715; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KS523ZuLQajlqaW9nRPPvwWPNkbM/GgW7sZV4UtjmFI=;
 b=DQwBF1cdpNJ7X3gGxp/0T7KgDci8YTFf2yjND2VjMRKwwWlSHXlpGXgnuDrtWcIm7g
 bHZceUQkrfSNPBT6ykH7JrlaNX+zSxkhnhGDZjhwGsfrUMPEq+i2tvjPcFlTKd5vYs1H
 XBPq3gSh2LhJNQ9jrGtlIhKksiMpcUX4FWWzntShRudhb4qLFw4GVg8heIEfNEQbjYDc
 AHeDRpEls+y//XGAnpohQ8oeg8UCw+v0zaT+LgWtx6sJV/6LxNMjr93XXXUxCbWVCMu5
 pgmLIE/O/eI/QRvc2gslcKEgrf0NI67x4wDg5VfPs9PXxxAd3doXEVmxAKwJt+msNxTr
 gNHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777109915; x=1777714715;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=KS523ZuLQajlqaW9nRPPvwWPNkbM/GgW7sZV4UtjmFI=;
 b=bZAcJBbtDWTpB1YQVtgSTqQYCItqT06Iaeqo3yYwOIbovl9FqBIzbqlOn54Z0NfMvB
 kKLmDw9tFXzR3o0w4o3UvN5qmdi7Xx9wZkOwUH3loyS5SrfCTbjJOmj/9MhSWWC101Ph
 MsZUsADcgm4SwFgOmJVI3vJ7NL4qFw0mN4SA5n2uI/yizOT6VUelJOD85EID5PBWnsBJ
 nNe1H1ERfY19A9bc4p7r11csppZ1zgvTfLLDSfXvpyITDM68EMm2rK1U5pkhmtvtUeWf
 cs1OJlk3yS7ZBn4ZrPsvma/bNtvfk3FbPgQ3dfqFeb+vrzFhLe6+hHG08dUX4F6xidIj
 2lsA==
X-Gm-Message-State: AOJu0YyUpCB2kh9RI+AoY/mRMYQRwTwaYIgmCMwGbipau9FKnHtEC6Sf
 jU+yQuBgJ7Nn1nsWXkuEMoa/9xxdHWEKNj/EOEx1BdvDz3xXogMvQN5zgbc5s59mnqc=
X-Gm-Gg: AeBDievsX1XT2g0meT2NKdJ3yfhdBig5Zx0r3DrFvqvQVoGWBkvv9jTtBaG/wdA3z/a
 9sIIccKMoeXmzZGDbuTaMQ90wyHL2TKQQcHyHlSIbFW0lMowiXkAocjEprhdwhY++M9MBRAgrMU
 Xh9vJfWN47cBzadZCRxSltowLSeUdJo8s6TNdUh0hs1bs4227ATlj943yAgXTD3YcrqehBplQnN
 W12KbSFxgcdbbJaSBFGv4UvkSjCi6ILlx5xOsd1dOM+HnV5fA70JjMFeaqi4tQWRU1+jB5Uy0zd
 I+MPQDAt+7KehntNdf8QLEQb4dWzA8CrX7M5RWglCIRjJpAlcxX67aUHSzgtFu1jWwicumLq3O5
 /BRGEGxjjvz76KY/BNoAZooffBfZniK5T/rCrvZgajQL0dWNzfUsfyyHHwpBjoFw5+X3XNjkPH7
 J9gUKlyNbXXapVFeOvkCospa0abdtnXVtWD4gSF3Y=
X-Received: by 2002:adf:ffd0:0:b0:43f:e413:f6fd with SMTP id
 ffacd0b85a97d-43fe413f7c0mr37696053f8f.0.1777109915063; 
 Sat, 25 Apr 2026 02:38:35 -0700 (PDT)
Received: from [192.168.0.10] ([2a03:ab00:1000:1b60:331a:b316:78f6:effc])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e3a18csm74965992f8f.20.2026.04.25.02.38.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Apr 2026 02:38:33 -0700 (PDT)
From: =?utf-8?q?Jind=C5=99ich_Makovi=C4=8Dka?= <makovick@gmail.com>
Date: Sat, 25 Apr 2026 11:38:31 +0200
Subject: [PATCH 1/2] ui/gtk: Use non-blocking clipboard retrieval
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260425-gtk-clipboard-v1-1-6bd99e708e14@gmail.com>
References: <20260425-gtk-clipboard-v1-0-6bd99e708e14@gmail.com>
In-Reply-To: <20260425-gtk-clipboard-v1-0-6bd99e708e14@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Jindrich Makovicka <makovick@gmail.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=makovick@gmail.com; helo=mail-wr1-x432.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Jindrich Makovicka <makovick@gmail.com>
---
 ui/gtk-clipboard.c | 47 ++++++++++++++++++++++++++++++++++-------------
 1 file changed, 34 insertions(+), 13 deletions(-)

diff --git a/ui/gtk-clipboard.c b/ui/gtk-clipboard.c
index 65d89ec601..23d32947cc 100644
--- a/ui/gtk-clipboard.c
+++ b/ui/gtk-clipboard.c
@@ -136,26 +136,50 @@ static void gd_clipboard_notify(Notifier *notifier, void *data)
     }
 }
 
+static void
+gd_clipboard_request_text_received_callback(GtkClipboard *clipboard,
+                                            const gchar *text,
+                                            gpointer data)
+{
+    QemuClipboardInfo *info = (QemuClipboardInfo *)data;
+    if (text) {
+        qemu_clipboard_set_data(info->owner, info, QEMU_CLIPBOARD_TYPE_TEXT,
+                                strlen(text), text, true);
+    }
+    qemu_clipboard_info_unref(info);
+}
+
 static void gd_clipboard_request(QemuClipboardInfo *info,
                                  QemuClipboardType type)
 {
     GtkDisplayState *gd = container_of(info->owner, GtkDisplayState, cbpeer);
-    char *text;
 
     switch (type) {
     case QEMU_CLIPBOARD_TYPE_TEXT:
-        text = gtk_clipboard_wait_for_text(gd->gtkcb[info->selection]);
-        if (text) {
-            qemu_clipboard_set_data(&gd->cbpeer, info, type,
-                                    strlen(text), text, true);
-            g_free(text);
-        }
+        qemu_clipboard_info_ref(info);
+        gtk_clipboard_request_text(gd->gtkcb[info->selection],
+                                   gd_clipboard_request_text_received_callback,
+                                   info);
         break;
     default:
         break;
     }
 }
 
+static void
+gd_clipboard_owner_change_text_received_callback(GtkClipboard *clipboard,
+                                                 const gchar *text,
+                                                 gpointer data)
+{
+    QemuClipboardInfo *info = (QemuClipboardInfo *)data;
+    if (text) {
+        info->types[QEMU_CLIPBOARD_TYPE_TEXT].available = true;
+    }
+
+    qemu_clipboard_update(info);
+    qemu_clipboard_info_unref(info);
+}
+
 static void gd_owner_change(GtkClipboard *clipboard,
                             GdkEvent *event,
                             gpointer data)
@@ -173,12 +197,9 @@ static void gd_owner_change(GtkClipboard *clipboard,
     switch (event->owner_change.reason) {
     case GDK_OWNER_CHANGE_NEW_OWNER:
         info = qemu_clipboard_info_new(&gd->cbpeer, s);
-        if (gtk_clipboard_wait_is_text_available(clipboard)) {
-            info->types[QEMU_CLIPBOARD_TYPE_TEXT].available = true;
-        }
-
-        qemu_clipboard_update(info);
-        qemu_clipboard_info_unref(info);
+        gtk_clipboard_request_text(clipboard,
+                                   gd_clipboard_owner_change_text_received_callback,
+                                   info);
         break;
     default:
         qemu_clipboard_peer_release(&gd->cbpeer, s);

-- 
2.53.0


