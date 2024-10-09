Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC258CEE338
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 17:48:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syamT-0005Ys-5x; Wed, 09 Oct 2024 13:47:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1syamI-0005Wb-Hx
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 13:47:15 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1syamF-0003KY-In
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 13:47:14 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a9963e47b69so12734266b.1
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 10:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728496029; x=1729100829; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MstT7fIpz3HfCS05BstgUG2a/APv1YnSssiXd/WRhw4=;
 b=Ey9i0n8o8tMFvoNky5GH3QXc2ZHwLLh51vohht1a5uP/XLi2saNyFVhL3tI3TDLwJb
 xDZtS4Hvbbu0yhUVZnra2r0asSf0Van6mOuEuOLbcwfNTJKPvbRy57c4o+7GzlYX7xWk
 9idoGfT+xI1I1RfHF5+XZl0bmJOJEX4hhgW3JGFXwcfok11jsfhaEayiE43+nxAnavmb
 ufOVIdgPukQ/LJlpVWh1CSCS/a618+cntDGv2YLFM4+h5rafVZmJNdfrPL8F4oPCbohF
 QlL8G5mq6zK0yv5fn9JIGQPPZV2SPepDPiDoel+a+9Agbybl8Bm5gm3phk+MyZt9rZqF
 AerA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728496029; x=1729100829;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MstT7fIpz3HfCS05BstgUG2a/APv1YnSssiXd/WRhw4=;
 b=XXLsDRfB87idP+wm6FJGyo+9CIq5frv2L0581e29mNXee2fE9cEdEH8M9aNqwApx3M
 n5g7sgwcYMMKGvJNTf9KxHFLQITgqcZGZR4PUzAWLFTlz5D4mEfJS7MsRD0e8VDq+9t+
 VaXh+EVSCN9orlhJa5mgJqWdHR1MHIx5E9sdabWMHm8bGJikz3sJ6cOIvG2KSCKabIJe
 Nix4qDBD7/+z7y/kIXfz9e7khVvMmoEZQWF0AO1udtHvU90U//AwgyxVp9uQ2pC23dTL
 uTFp0E9FBpJIPZBIXIm0dCfj3SEa7w8Uy9IrJeT6uAMrj6/wrInWbaIYevpoj6cgS+F4
 +5OA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/k/uGUvfbMDYMBBAmYvv0aUU+P4Z/e1ifgL7iS5HkZjrZykNo8H+rMwow/qzmSoJ7OuYntqKE++Tj@nongnu.org
X-Gm-Message-State: AOJu0Yz3HcrYqtmaJiUmpRBdxwC8+h4422Ldm//4/wNh1CgCS/ZmiyLE
 gOFeyWqCpN1I8V4dNYB1Lv3nSOGHxMorv/C4kojxYu9CuSkCIDPl
X-Google-Smtp-Source: AGHT+IHaOoc3gGgx+kU3OFVC4xnqN5hiqfxIwn7LkH9mZdgqWrlRdn73BQlZndQYkZGWvPloq0pw3Q==
X-Received: by 2002:a17:906:f5a7:b0:a8d:29b7:ecf3 with SMTP id
 a640c23a62f3a-a999e628dd6mr81994466b.13.1728496029175; 
 Wed, 09 Oct 2024 10:47:09 -0700 (PDT)
Received: from finn.fritz.box ([2a02:8109:8384:1400:eb7f:8fd0:f96c:766b])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a994f38068fsm491667666b.40.2024.10.09.10.47.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 10:47:08 -0700 (PDT)
From: Roman Penyaev <r.peniaev@gmail.com>
To: 
Cc: Roman Penyaev <r.peniaev@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v2 2/5] chardev/char: rename `mux_cnt` to `fe_cnt` for the
 `MuxChardev`
Date: Wed,  9 Oct 2024 19:45:14 +0200
Message-Id: <20241009174517.286935-3-r.peniaev@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241009174517.286935-1-r.peniaev@gmail.com>
References: <20241009174517.286935-1-r.peniaev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=r.peniaev@gmail.com; helo=mail-ej1-x629.google.com
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

In the following patches `MuxChardev` struct will suport backend
multiplexing, the `mux_cnt` struct member has very common name
and does not reflect the actual meaning: number of frontends
attached to a mux. This patch renames the `mux_cnt` to `fe_cnt`.
No other functional changes made.

Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
---
 chardev/char-fe.c          |  7 +++----
 chardev/char-mux.c         | 12 ++++++------
 chardev/char.c             |  2 +-
 chardev/chardev-internal.h |  2 +-
 4 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/chardev/char-fe.c b/chardev/char-fe.c
index b214ba3802b1..e6f44801162a 100644
--- a/chardev/char-fe.c
+++ b/chardev/char-fe.c
@@ -197,16 +197,15 @@ bool qemu_chr_fe_init(CharBackend *b, Chardev *s, Error **errp)
         if (CHARDEV_IS_MUX(s)) {
             MuxChardev *d = MUX_CHARDEV(s);
 
-            if (d->mux_cnt >= MAX_MUX) {
+            if (d->fe_cnt >= MAX_MUX) {
                 error_setg(errp,
                            "too many uses of multiplexed chardev '%s'"
                            " (maximum is " stringify(MAX_MUX) ")",
                            s->label);
                 return false;
             }
-
-            d->backends[d->mux_cnt] = b;
-            tag = d->mux_cnt++;
+            d->backends[d->fe_cnt] = b;
+            tag = d->fe_cnt++;
         } else if (s->be) {
             error_setg(errp, "chardev '%s' is already in use", s->label);
             return false;
diff --git a/chardev/char-mux.c b/chardev/char-mux.c
index ee2d47b20d9b..eb72b3cdb80b 100644
--- a/chardev/char-mux.c
+++ b/chardev/char-mux.c
@@ -168,9 +168,9 @@ static int mux_proc_byte(Chardev *chr, MuxChardev *d, int ch)
             qemu_chr_be_event(chr, CHR_EVENT_BREAK);
             break;
         case 'c':
-            assert(d->mux_cnt > 0); /* handler registered with first fe */
+            assert(d->fe_cnt > 0); /* handler registered with first fe */
             /* Switch to the next registered device */
-            mux_set_focus(chr, (d->focus + 1) % d->mux_cnt);
+            mux_set_focus(chr, (d->focus + 1) % d->fe_cnt);
             break;
         case 't':
             d->timestamps = !d->timestamps;
@@ -248,8 +248,8 @@ void mux_chr_send_all_event(Chardev *chr, QEMUChrEvent event)
         return;
     }
 
-    /* Send the event to all registered listeners */
-    for (i = 0; i < d->mux_cnt; i++) {
+    /* Send the event to all registered frontend listeners */
+    for (i = 0; i < d->fe_cnt; i++) {
         mux_chr_send_event(d, i, event);
     }
 }
@@ -277,7 +277,7 @@ static void char_mux_finalize(Object *obj)
     MuxChardev *d = MUX_CHARDEV(obj);
     int i;
 
-    for (i = 0; i < d->mux_cnt; i++) {
+    for (i = 0; i < d->fe_cnt; i++) {
         CharBackend *be = d->backends[i];
         if (be) {
             be->chr = NULL;
@@ -305,7 +305,7 @@ void mux_set_focus(Chardev *chr, int focus)
     MuxChardev *d = MUX_CHARDEV(chr);
 
     assert(focus >= 0);
-    assert(focus < d->mux_cnt);
+    assert(focus < d->fe_cnt);
 
     if (d->focus != -1) {
         mux_chr_send_event(d, d->focus, CHR_EVENT_MUX_OUT);
diff --git a/chardev/char.c b/chardev/char.c
index 4b3e45b2a128..3f0fcc8b16f6 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -333,7 +333,7 @@ static bool qemu_chr_is_busy(Chardev *s)
 {
     if (CHARDEV_IS_MUX(s)) {
         MuxChardev *d = MUX_CHARDEV(s);
-        return d->mux_cnt >= 0;
+        return d->fe_cnt >= 0;
     } else {
         return s->be != NULL;
     }
diff --git a/chardev/chardev-internal.h b/chardev/chardev-internal.h
index 4e03af31476c..e8c3c29d1a59 100644
--- a/chardev/chardev-internal.h
+++ b/chardev/chardev-internal.h
@@ -38,7 +38,7 @@ struct MuxChardev {
     CharBackend *backends[MAX_MUX];
     CharBackend chr;
     int focus;
-    int mux_cnt;
+    int fe_cnt;
     int term_got_escape;
     int max_size;
     /* Intermediate input buffer catches escape sequences even if the
-- 
2.43.0


