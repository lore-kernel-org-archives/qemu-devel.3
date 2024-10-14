Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE0F8D18128
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 15:27:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0Mxm-0006Gm-OE; Mon, 14 Oct 2024 11:26:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1t0Mxj-0006FG-9o
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 11:26:23 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1t0Mxc-0000vO-EZ
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 11:26:18 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a9a0ef5179dso167698766b.1
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 08:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728919573; x=1729524373; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p4v/fGpWXC16nH9NFmBVigHbrDSRKiF2Owvw6nK5eQE=;
 b=BlAXfwq0bKM7PW6MaK14P+kt2FWZdsv7CRfyariz+zKePLKPCyLf/R60ie8u1w2woQ
 aj2WQUxgew0mLVMb1cypbhfFkJEVM1kCFFAT8Y5Fk/sO4EPtN+8zy3qvyDNEpm7Qtq2+
 fP7COyZxzOzpsk/gBYexpXufktnueRY15e2zzjigsoox9SI+T3qa/OpYpY4Gd0ycgoEh
 VlPDgELZg4zGUfasGNjRggTzVV6Vf2HhITMM/4SKxrjYbsm5B3bjcXFhuYEKa6Pt9lPT
 ny5YajJjVaFc/6QoeUcLmHA8QNvj7vdYZuA2FcZf1qdDfnz0kcqgyrWifdICcewhwTuE
 /dVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728919573; x=1729524373;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p4v/fGpWXC16nH9NFmBVigHbrDSRKiF2Owvw6nK5eQE=;
 b=VcxSzraylr0TJxCvuCSnIhGtoGghs7Bc1v1Jf7n0lj6yqOwb9LI2zH9tgiLl2ixLoS
 cAl3EiimgNGSUq3UbuMIbYy33Aq61HCaETFsNbJMhqsmxOIkXLHAKsMqsKQXl4SI+mVk
 crBaynmgZel4y01j47TQqDOfNYOZBHiX29BDZW+VIaSkgDwJGlYat10xsNPie4ZzAASb
 a1bKR4WiM2moV11ku2fwntl8/d+YVBulFv2ZU1v2kjgX7CLBZbtcQTDAc1mhc8DnD71l
 4UZ4z3glXZ5YEeVlLyyc4+I6JB2GXuL4ykqm51u6Yd2LgchKk5eNUGixFbycRF2eG4CV
 9tgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUb6UWwXq+oEEHMwH9ukygdnVqPqjQja1UqQb/5SnKqaJT1rXX9j7RGledThB/5/lDGiPfai43wUqh0@nongnu.org
X-Gm-Message-State: AOJu0YyQUfR/BoPRsQlXMCZAG+Dqyv7NI8wWw9eKlEMr0y0d2Htqn140
 VwJixzrcx8asUUydHjC9Qk3YmNabyLDSqsfWiBUzdd5E4qelTI54yHsLcA==
X-Google-Smtp-Source: AGHT+IH6xZspJLTMXg0JJ2OXjDRqc9eNq2O9vblLh71wlHqNiGq6yzsrHvnmljocaRvPwFhONjvX2w==
X-Received: by 2002:a17:907:7206:b0:a99:509b:f524 with SMTP id
 a640c23a62f3a-a99b95af331mr1159730266b.57.1728919572908; 
 Mon, 14 Oct 2024 08:26:12 -0700 (PDT)
Received: from finn.fritz.box ([2a02:8109:8384:1400:eb7f:8fd0:f96c:766b])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a13396603sm133689966b.169.2024.10.14.08.26.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 08:26:12 -0700 (PDT)
From: Roman Penyaev <r.peniaev@gmail.com>
To: 
Cc: Roman Penyaev <r.peniaev@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v2 4/8] chardev/mux: convert size members to unsigned int
Date: Mon, 14 Oct 2024 17:24:04 +0200
Message-Id: <20241014152408.427700-5-r.peniaev@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241014152408.427700-1-r.peniaev@gmail.com>
References: <20241014152408.427700-1-r.peniaev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=r.peniaev@gmail.com; helo=mail-ej1-x634.google.com
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

There is no sense to keep `focus`, `mux_cnt`, `prod`, `cons`
and `tag` variables as signed, those represent either size,
either position in array, which both are unsigned.

`focus` member of `MuxChardev` is kept signed, because initially
set to -1.

Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
---
 chardev/char-fe.c          |  2 +-
 chardev/char-mux.c         | 10 +++++-----
 chardev/chardev-internal.h |  8 ++++----
 include/chardev/char-fe.h  |  2 +-
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/chardev/char-fe.c b/chardev/char-fe.c
index b214ba3802b1..69b47d16bdfa 100644
--- a/chardev/char-fe.c
+++ b/chardev/char-fe.c
@@ -191,7 +191,7 @@ bool qemu_chr_fe_backend_open(CharBackend *be)
 
 bool qemu_chr_fe_init(CharBackend *b, Chardev *s, Error **errp)
 {
-    int tag = 0;
+    unsigned int tag = 0;
 
     if (s) {
         if (CHARDEV_IS_MUX(s)) {
diff --git a/chardev/char-mux.c b/chardev/char-mux.c
index 728596c6f346..b2d7abf2fc01 100644
--- a/chardev/char-mux.c
+++ b/chardev/char-mux.c
@@ -124,7 +124,8 @@ static void mux_print_help(Chardev *chr)
     }
 }
 
-static void mux_chr_send_event(MuxChardev *d, int mux_nr, QEMUChrEvent event)
+static void mux_chr_send_event(MuxChardev *d, unsigned int mux_nr,
+                               QEMUChrEvent event)
 {
     CharBackend *be = d->backends[mux_nr];
 
@@ -242,7 +243,7 @@ static void mux_chr_read(void *opaque, const uint8_t *buf, int size)
 void mux_chr_send_all_event(Chardev *chr, QEMUChrEvent event)
 {
     MuxChardev *d = MUX_CHARDEV(chr);
-    int i;
+    unsigned int i;
 
     if (!muxes_opened) {
         return;
@@ -275,7 +276,7 @@ static GSource *mux_chr_add_watch(Chardev *s, GIOCondition cond)
 static void char_mux_finalize(Object *obj)
 {
     MuxChardev *d = MUX_CHARDEV(obj);
-    int i;
+    unsigned int i;
 
     for (i = 0; i < d->mux_cnt; i++) {
         CharBackend *be = d->backends[i];
@@ -300,11 +301,10 @@ static void mux_chr_update_read_handlers(Chardev *chr)
                                   chr->gcontext, true, false);
 }
 
-void mux_set_focus(Chardev *chr, int focus)
+void mux_set_focus(Chardev *chr, unsigned int focus)
 {
     MuxChardev *d = MUX_CHARDEV(chr);
 
-    assert(focus >= 0);
     assert(focus < d->mux_cnt);
 
     if (d->focus != -1) {
diff --git a/chardev/chardev-internal.h b/chardev/chardev-internal.h
index 975c16de803e..ab93f6ea1720 100644
--- a/chardev/chardev-internal.h
+++ b/chardev/chardev-internal.h
@@ -38,14 +38,14 @@ struct MuxChardev {
     CharBackend *backends[MAX_MUX];
     CharBackend chr;
     int focus;
-    int mux_cnt;
+    unsigned int mux_cnt;
     bool term_got_escape;
     /* Intermediate input buffer catches escape sequences even if the
        currently active device is not accepting any input - but only until it
        is full as well. */
     unsigned char buffer[MAX_MUX][MUX_BUFFER_SIZE];
-    int prod[MAX_MUX];
-    int cons[MAX_MUX];
+    unsigned int prod[MAX_MUX];
+    unsigned int cons[MAX_MUX];
     int timestamps;
 
     /* Protected by the Chardev chr_write_lock.  */
@@ -59,7 +59,7 @@ DECLARE_INSTANCE_CHECKER(MuxChardev, MUX_CHARDEV,
 #define CHARDEV_IS_MUX(chr)                             \
     object_dynamic_cast(OBJECT(chr), TYPE_CHARDEV_MUX)
 
-void mux_set_focus(Chardev *chr, int focus);
+void mux_set_focus(Chardev *chr, unsigned int focus);
 void mux_chr_send_all_event(Chardev *chr, QEMUChrEvent event);
 
 Object *get_chardevs_root(void);
diff --git a/include/chardev/char-fe.h b/include/chardev/char-fe.h
index 3310449eaf03..8ef05b3dd095 100644
--- a/include/chardev/char-fe.h
+++ b/include/chardev/char-fe.h
@@ -20,7 +20,7 @@ struct CharBackend {
     IOReadHandler *chr_read;
     BackendChangeHandler *chr_be_change;
     void *opaque;
-    int tag;
+    unsigned int tag;
     bool fe_is_open;
 };
 
-- 
2.34.1


