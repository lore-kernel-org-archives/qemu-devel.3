Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CE87C021B3
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Feb 2025 14:55:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmDNI-0007qm-HN; Sun, 23 Feb 2025 09:54:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1tmDNA-0007p4-Gj
 for qemu-devel@nongnu.org; Sun, 23 Feb 2025 09:54:25 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1tmDN8-0007eR-BF
 for qemu-devel@nongnu.org; Sun, 23 Feb 2025 09:54:23 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5deb1266031so6607518a12.2
 for <qemu-devel@nongnu.org>; Sun, 23 Feb 2025 06:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740322461; x=1740927261; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qlkiO7qYj5+41IEd2vHxj8OZTpyw2odXgSQfKCBV+pM=;
 b=fFPe9G28NzXhSrAWNPrlnc12+pZskXRzinLRmjhXWkVmzeGQbnHJqMND/ZcyZMxsZL
 rBaWjUs81WjFXbdp8iZ3a6qG/yOjCaU5si1s4+kp8HgqfWOMJ0psESBG3mM7TySChA1Y
 K5AC5AFJJHZ891QIBQLvrQ5Ml3xKOMAGnypHFYNJjwcmze7QDsiZL2Mqahi11bfTmISr
 dWJSdQ2yZD3SJJKPZpteP+ERQviOF3d8ExJy7yAKh6F0RRipa8dQt5J3iEbDuaDR3W5t
 4yD9OxVA3m4+67a74JDwwfz10zgcWmSyv1M4ahTz2Exnl4Z6a0fiJmGlKKDGE4qwZ7Nt
 vyIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740322461; x=1740927261;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qlkiO7qYj5+41IEd2vHxj8OZTpyw2odXgSQfKCBV+pM=;
 b=NaXR+7q/RftcfQ0Mq1qkym37BWe7sqXMGWhpfBOMGIAc8B+149cvlr/tstNdHSv/Ye
 c/Vej0GsuB4n4BEMqjAb66CkLt1IHKhKFhjvX6KnsGeYnx5OdV4nv6MoDsRYGl60biOF
 JEKkjpo3qNhvvfYXqMuHOYiHimXNrfSWHq4uNbtQAadFTxSrA5NCMLA8iXMJnA/6ioqK
 PPV0W9cM0/5p2Tvhwhlbv3p0HdKSTpBehpRauh3jBNVRUS5Nl6BOyYe4ScsLFHl3kCne
 CNDg66sa8rY5TumOZQ5ngz8Jki4aHMDRHbtKToatpLZczBHJD/lJeRxBR7hHNqQ4mwrl
 Z7Eg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxs/T9pM8s+HFfGo7362GKifbqMfE3D7B18nmr7iB7ZAnzdcNx+m458oE1IrFc6xfOOYpmJPex0TGk@nongnu.org
X-Gm-Message-State: AOJu0YzbD8t4rHQu6bMiaqJhqC5OdYWP0u7f9pc+mJEO/NGnmYRthWx9
 29aNbgwAYwNfYhgiIf0B2N4x0mTYjmrDNrQBVZ2AdxZw0Ug2nh5osNn1gw==
X-Gm-Gg: ASbGncslPawDE7dGftFwLXWROngLdpfx47MJ3SDpsAZ+BWXJYxaZ0G9r9I3CSyatIhj
 X3pJakUABiqTkXueaJntfVbd1OnDFTqNGFfWF6xiRNGXir10SGwnnZrHKdATZv9J1euA29qHGIy
 Lvy4MN/89P+wJpehPUh/VR0zxRLiISGm/BLBy0XjNB2qFAaGBlK8ihCd5+N6hod/FLkcaj/FEYB
 SaEq5Uq1otSQM8cubiNfUIVDWc//ftrwfvJWZdpvXrhQqCLh81iD9ms3pOL5B/B9ci2CrcoMkHy
 R1vMoS4gYnsnNaYv7XlIC8a7XM1sIPyJvzw=
X-Google-Smtp-Source: AGHT+IGwlpGLJMymcQmKnHxvt+6dfornRgVDkEolcde+LA78oGI9KApPhqSzHOEfIdqH8yBzd6SKdA==
X-Received: by 2002:a05:6402:3583:b0:5dc:cf9b:b048 with SMTP id
 4fb4d7f45d1cf-5e0b70cb80bmr8898270a12.1.1740322460423; 
 Sun, 23 Feb 2025 06:54:20 -0800 (PST)
Received: from think.fritz.box ([2a02:8109:8384:1400:1283:abda:b08f:72e4])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e0a0310f66sm6431580a12.81.2025.02.23.06.54.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Feb 2025 06:54:19 -0800 (PST)
From: Roman Penyaev <r.peniaev@gmail.com>
To: 
Cc: Roman Penyaev <r.peniaev@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH 5/5] ui/console-vc: implement DCH (delete) and ICH (insert)
 commands
Date: Sun, 23 Feb 2025 15:54:02 +0100
Message-ID: <20250223145407.259924-6-r.peniaev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250223145407.259924-1-r.peniaev@gmail.com>
References: <20250223145407.259924-1-r.peniaev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=r.peniaev@gmail.com; helo=mail-ed1-x52a.google.com
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

This patch implements DCH (delete character) and ICH (insert
character) commands.

DCH - Delete Character:
   "As characters are deleted, the remaining characters between the
    cursor and right margin move to the left. Character attributes move
    with the characters. The terminal adds blank spaces with no visual
    character attributes at the right margin. DCH has no effect outside
    the scrolling margins" [1].

ICH - Insert Character:
   "The ICH sequence inserts Pn blank characters with the normal
    character attribute. The cursor remains at the beginning of the
    blank characters. Text between the cursor and right margin moves to
    the right. Characters scrolled past the right margin are lost. ICH
    has no effect outside the scrolling margins" [2].

Without these commands console is barely usable.

[1] https://vt100.net/docs/vt510-rm/DCH.html
[1] https://vt100.net/docs/vt510-rm/ICH.html

Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
---
 ui/console-vc.c | 108 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 102 insertions(+), 6 deletions(-)

diff --git a/ui/console-vc.c b/ui/console-vc.c
index 522adc2806c8..bc667897d1bc 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -598,21 +598,29 @@ static void vc_clear_xy(VCChardev *vc, int x, int y)
     vc_update_xy(vc, x, y);
 }
 
-static void vc_put_one(VCChardev *vc, int ch)
+static void vc_insert_xy(VCChardev *vc, int ch, int x, int y)
 {
     QemuTextConsole *s = vc->console;
     TextCell *c;
     int y1;
+
+    y1 = (s->y_base + y) % s->total_height;
+    c = &s->cells[y1 * s->width + x];
+    c->ch = ch;
+    c->t_attrib = vc->t_attrib;
+    vc_update_xy(vc, x, y);
+}
+
+static void vc_put_one(VCChardev *vc, int ch)
+{
+    QemuTextConsole *s = vc->console;
+
     if (s->x >= s->width) {
         /* line wrap */
         s->x = 0;
         vc_put_lf(vc);
     }
-    y1 = (s->y_base + s->y) % s->total_height;
-    c = &s->cells[y1 * s->width + s->x];
-    c->ch = ch;
-    c->t_attrib = vc->t_attrib;
-    vc_update_xy(vc, s->x, s->y);
+    vc_insert_xy(vc, ch, s->x, s->y);
     s->x++;
 }
 
@@ -645,6 +653,88 @@ static void vc_set_cursor(VCChardev *vc, int x, int y)
     s->y = y;
 }
 
+/**
+ * vc_csi_P() - (DCH) deletes one or more characters from the cursor
+ * position to the right. As characters are deleted, the remaining
+ * characters between the cursor and right margin move to the
+ * left. Character attributes move with the characters.
+ */
+static void vc_csi_P(struct VCChardev *vc, unsigned int nr)
+{
+    QemuTextConsole *s = vc->console;
+    TextCell *c1, *c2;
+    unsigned int x1, x2, y;
+    unsigned int end, len;
+
+    if (!nr) {
+        nr = 1;
+    }
+    if (nr > s->width - s->x) {
+        nr = s->width - s->x;
+        if (!nr) {
+            return;
+        }
+    }
+
+    x1 = s->x;
+    x2 = s->x + nr;
+    len = s->width - x2;
+    if (len) {
+        y = (s->y_base + s->y) % s->total_height;
+        c1 = &s->cells[y * s->width + x1];
+        c2 = &s->cells[y * s->width + x2];
+        memmove(c1, c2, len * sizeof(*c1));
+        for (end = x1 + len; x1 < end; x1++) {
+            vc_update_xy(vc, x1, s->y);
+        }
+    }
+    /* Clear the rest */
+    for (; x1 < s->width; x1++) {
+        vc_clear_xy(vc, x1, s->y);
+    }
+}
+
+/**
+ * vc_csi_at() - (ICH) inserts `nr` blank characters with the normal
+ * character attribute. The cursor remains at the beginning of the
+ * blank characters. Text between the cursor and right margin moves to
+ * the right. Characters scrolled past the right margin are lost.
+ */
+static void vc_csi_at(struct VCChardev *vc, unsigned int nr)
+{
+    QemuTextConsole *s = vc->console;
+    TextCell *c1, *c2;
+    unsigned int x1, x2, y;
+    unsigned int end, len;
+
+    if (!nr) {
+        nr = 1;
+    }
+    if (nr > s->width - s->x) {
+        nr = s->width - s->x;
+        if (!nr) {
+            return;
+        }
+    }
+
+    x1 = s->x + nr;
+    x2 = s->x;
+    len = s->width - x1;
+    if (len) {
+        y = (s->y_base + s->y) % s->total_height;
+        c1 = &s->cells[y * s->width + x1];
+        c2 = &s->cells[y * s->width + x2];
+        memmove(c1, c2, len * sizeof(*c1));
+        for (end = x1 + len; x1 < end; x1++) {
+            vc_update_xy(vc, x1, s->y);
+        }
+    }
+    /* Insert spaces */
+    for (x1 = s->x; x1 < s->x + nr; x1++) {
+        vc_insert_xy(vc, ' ', x1, s->y);
+    }
+}
+
 /**
  * vc_save_cursor() - saves cursor position and character attributes.
  */
@@ -847,6 +937,9 @@ static void vc_putchar(VCChardev *vc, int ch)
                     break;
                 }
                 break;
+            case 'P':
+                vc_csi_P(vc, vc->esc_params[0]);
+                break;
             case 'm':
                 vc_handle_escape(vc);
                 break;
@@ -870,6 +963,9 @@ static void vc_putchar(VCChardev *vc, int ch)
             case 'u':
                 vc_restore_cursor(vc);
                 break;
+            case '@':
+                vc_csi_at(vc, vc->esc_params[0]);
+                break;
             default:
                 trace_console_putchar_unhandled(ch);
                 break;
-- 
2.43.0


