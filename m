Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27F38C98315
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 03:36:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhfx7-00076A-VI; Sun, 18 Jan 2026 22:29:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1vhfwg-00073B-7Z
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 22:28:51 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1vhfwb-0004Av-HK
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 22:28:48 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b876f3f603eso654791166b.0
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 19:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768793322; x=1769398122; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cRRADiWlTCAiWD1WrIJ36o9Cqy9BLTfn45MABBKJyUk=;
 b=WKxhBTRebWp84VoFod4Xb5w4a0bkndsQrbu2bEDydzsBvz0fo0pEt2XVa4t8IKT0qh
 F1CcEOHkbWZGNpwD+XGP/esbEdnKnKKW5qCxS56dGlT/Xu7oQ0rD86CAi8pTwhOcb0IL
 bgNvoAB7Hs1wynKJMg2ZlZhvqBaUHDtJAPrKqemwnFvboIJGj+sYnuDm4gMD+GVl+1hr
 1DCk9MhzHjGjXH+MCiUyfrbDu3QgcNxcNZh6wc9f0v1GW+upJnf0jnic6BZUEvg5O7Ag
 B9lGKbqgh7EaJJI2MG1+oiVqE+QQvPLe8ybBZCMwBuL07v6TuxQ64nW7EThj0YCJt+39
 KlRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768793322; x=1769398122;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=cRRADiWlTCAiWD1WrIJ36o9Cqy9BLTfn45MABBKJyUk=;
 b=OfIJgED/HtlDBCjRNMQuzcekNCM/sjTPQnyMl7gTH94fYy9/RMWF54vaW3BjxRUFUH
 rs2tQ4QkhtoH4SVrk5AqtHnmvLgZV3zhzi3gRKF2r1e5AFf4yVtE31WiAaQlNmUf7WET
 RQAVOjpemEQB3b/zVZYGkUiEImGSSiB0U/hUGPJopqUjdWQcqRxN6eKpdvXpFNrGtxi4
 dII5qeFQe0eS19PTqkkXQKUAy2P0U/uc5CxJxKfYJtmzbl9SRxPMKEUavJ8TvdZMn4de
 S2VC+LEMFoFRooKqr/HhhxMl50RSrwL/7P7y8oIvtSR2yBMWyeSqUW5h5YS7y6B+aXMo
 SprA==
X-Gm-Message-State: AOJu0YwIcvOAMEuQeYEOt+gP45/OUrxfJjUDsmlMgTsK/QvBdCi4D9Uu
 /90vCgaJYFF5ULAdqsUwOlhbgiuO3rNQWWpPoSMg3GGrM1J6BKcEmOYl
X-Gm-Gg: AY/fxX58wQUpWIZtVOZRtmvd0YkiiO5Ch+IyReAs7dcPrmDL9Yehb9oTbetUrPAKWQe
 MQTOGnc+bMU8MaEdpHEaM7su9aH7mAfxCMPotOzDGXrY0zy2lfrXueMY2nDjBMkbkwTMWpc9gV0
 PSkOIRrXYmY5UyJevfYefg6EkmGANW3gu0wSpClfTTg1mFEBdKs5iw+VBa4te/DhXlO593AdHYK
 b583NrnlCmqSLnDlvlhJQVe5QjYb3WpBbJgc1hTmxs00ahrUakrFjIDeZ0PviX6fcyx7AUXJNKf
 V4A5MKTy7vdvK4Fr5bWr1rsSWeNiGRFBti7Ff9QrD9bEnfWpdtZYU6XbNc1/fGoT7vym8KIByvk
 eUBKuXFwUgKflIyLvf14ustKtJC+Z/ag3WA4wotSLrgj3VwBsw3M4ThOcYV+hojh+zjN7mq/W69
 x3VP3qFiqJorFUNzhwVWi9Hf/reU09QhYTQc6j+Iep
X-Received: by 2002:a17:907:dac:b0:b87:15a7:85ee with SMTP id
 a640c23a62f3a-b8796b7a7a0mr820881466b.47.1768793321520; 
 Sun, 18 Jan 2026 19:28:41 -0800 (PST)
Received: from localhost (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b87959f6e53sm995408966b.47.2026.01.18.19.28.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 19:28:41 -0800 (PST)
From: Filip Hejsek <filip.hejsek@gmail.com>
Date: Mon, 19 Jan 2026 04:27:47 +0100
Subject: [PATCH v6 04/12] char-mux: add support for the terminal size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260119-console-resize-v6-4-33a7b0330a7a@gmail.com>
References: <20260119-console-resize-v6-0-33a7b0330a7a@gmail.com>
In-Reply-To: <20260119-console-resize-v6-0-33a7b0330a7a@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>, 
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>, 
 Szymon Lukasz <noh4hss@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768793314; l=1672;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=3wWLS/HKH+JZqQjYYiweTGheV16LmdX9qVrBSfd2a/s=;
 b=1eXM9/LIGtrPi9YsYlSD9dU3DfVU2dPHa95QdDmmKUdpyjpLlDFOjAtki3L02C+EooyvB0EC6
 y0XH5CuYfVeASLpphtCWaZPwg1jcR6HA9AzYHbcs4IhjIoGv/v0/SBJ
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=filip.hejsek@gmail.com; helo=mail-ej1-x62f.google.com
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

From: Szymon Lukasz <noh4hss@gmail.com>

The terminal size of a mux chardev should be the same as the real
chardev, so listen for CHR_EVENT_RESIZE to be up to date.

We forward CHR_EVENT_RESIZE only to the focused frontend. This means
frontends should update their view of the terminal size on
receiving CHR_EVENT_MUX_IN.

Signed-off-by: Szymon Lukasz <noh4hss@gmail.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
---
 chardev/char-mux.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/chardev/char-mux.c b/chardev/char-mux.c
index db9e89f441..b23fedbcfe 100644
--- a/chardev/char-mux.c
+++ b/chardev/char-mux.c
@@ -264,9 +264,24 @@ void mux_chr_send_all_event(Chardev *chr, QEMUChrEvent event)
     }
 }
 
+static void mux_update_winsize(Chardev *chr)
+{
+    MuxChardev *d = MUX_CHARDEV(chr);
+    uint16_t cols, rows;
+
+    qemu_chr_fe_get_winsize(&d->chr, &cols, &rows);
+    qemu_chr_resize(chr, cols, rows);
+}
+
 static void mux_chr_event(void *opaque, QEMUChrEvent event)
 {
-    mux_chr_send_all_event(CHARDEV(opaque), event);
+    Chardev *chr = CHARDEV(opaque);
+
+    if (event == CHR_EVENT_RESIZE) {
+        mux_update_winsize(chr);
+    } else {
+        mux_chr_send_all_event(chr, event);
+    }
 }
 
 static GSource *mux_chr_add_watch(Chardev *s, GIOCondition cond)
@@ -382,6 +397,7 @@ static void qemu_chr_open_mux(Chardev *chr,
      */
     *be_opened = muxes_opened;
     qemu_chr_fe_init(&d->chr, drv, errp);
+    mux_update_winsize(chr);
 }
 
 static void qemu_chr_parse_mux(QemuOpts *opts, ChardevBackend *backend,

-- 
2.52.0


