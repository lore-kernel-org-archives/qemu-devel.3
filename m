Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 254FACA9EC5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 11:57:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGEeA-0003XE-VS; Mon, 12 Oct 2026 07:56:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xGEe0-0003TB-7i
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 07:56:41 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xGEdy-0002Mr-M0
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 07:56:40 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4a02667ccebso12064565e9.0
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 04:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791806197; x=1792410997; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3889ddvtYewtgzDptQRS0YLOr3tptxcTWtw3BhYQAjo=;
 b=iIRVvcztBtQ1nS0U0vxQuLlApAbewJewH/daCQWYSpnB3Q5d0EI05jQe/p+xyQhW/p
 1XIpuoylnH6fdDA4asPg1eQkopOx5D+8Ath8Cz2JRJiM2s9GGlu2LYNxSU3i5ibC3VvM
 EG0wpdf8ZXULLz2+biaihaiy2lZ+oUVtzzoG1SaKZzVgbXl/Gz+A6ok0wJ5iubF9YpDP
 QwEb0jRgnDKRLbUpTGU2oiTuwPeEOuCSdqTnezR3QVDl2ckRaQAMY2RSmPzblkqmCmV0
 QXe2lVMLRFW+KtBknBToFPjayWjggOlgf/8ruWl64PKGBuUAfOggU8Klebwy/8afI9Sd
 q6sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791806197; x=1792410997;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3889ddvtYewtgzDptQRS0YLOr3tptxcTWtw3BhYQAjo=;
 b=TqTzAfmaKE841k49PS0wL5fwh92HzxntA2993G9REKMw9sF9dKQxPdcURCD/ICxaAD
 Lj1ZEW5SaL3yZ3Ol4/V1xvoysUucPZRqkY1tq1rnfbOc7p05BB3jQSR4Og8pKHLD9BCM
 wOyjL/6RdUHH3oJXfjoJNgIOujDP41exEot3XtMudjNE7FULRg1NKZW8LpSLwx5GwX+l
 XiVIm9L+J6ySBQ1ILiZB+PSh67OifVld67srQuP8n/U40BmtsAWWD7LVAJZwAgGgoNGz
 SQbGpN6dpnwOsriKEIC3DjMe+7wJuaCmclVeEfz7TA3A6HU839LOVa/9zaHiEnlG+YlG
 ZqQw==
X-Gm-Message-State: AFq9FYL8vvEEvDnDzM/TyOwsbKvfZezrM1/temH5uCwccLGL9NPQWRmy
 QiV6sastZL2soYL69gu9EAN8LO1JrPjGvf1NxJA6iw3bIoWjzoBuUxYk
X-Gm-Gg: AYBFou2jPRlqSHn/brHQyaSZIZz/NKU1pZtRp9jPW2SeAY3bHi1617NzS0HHQehjxDv
 Dup9Zx9VOiATK4Jov9xtKkqpu3SkT8bWC3acQN99zn7zYhIrWe5OsLJmol6eXy+hs549+bQV00s
 omhX4A7jb0CG6qZr0TE3kbbaMSiSTGPdWwSO6a8qz1aP/RKhMbzF58Ge4MZBc6FTaYoT16cvUnl
 6ajMbcnlz98Ykdd0RSKUHCFqr0XqG2P6W5MjiTbqxHu8iGE4lPfBMfaIrkmgCi2BFqMJmJm9KOC
 OZsPMwhKuv75Lvee4/XliZeQb9zJQGn7b6il/tDQNj/mnZF762M/OWi+WutqxWTxuRjMwsQgiuE
 Zd/V58/1ggl0OvFfT4IxKlLkV2Qb4/rHMglXG9V6lkD56lIASo0hYbzX9MeWKgP6DSvfpFJ/yvj
 fn9R6zTc73p/3cOo0o6WlIxNXN6UQquhwjp/lnHoMJK1f/f77sor0ylCr3SruZkVbA7H8wURvpu
 JW1mfzA4UXuKwBFQk4fnWHMdC8=
X-Received: by 2002:a05:600c:8b28:b0:49f:ff7b:f056 with SMTP id
 5b1f17b1804b1-4a18e4a3c24mr152330695e9.9.1791806196759; 
 Mon, 12 Oct 2026 04:56:36 -0700 (PDT)
Received: from localhost (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db9acf092sm19128828f8f.45.2026.10.12.04.56.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 04:56:36 -0700 (PDT)
From: Filip Hejsek <filip.hejsek@gmail.com>
Date: Mon, 12 Oct 2026 13:55:55 +0200
Subject: [PATCH v9 04/12] char-mux: add support for the terminal size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261012-console-resize-v9-4-8db78320ba81@gmail.com>
References: <20261012-console-resize-v9-0-8db78320ba81@gmail.com>
In-Reply-To: <20261012-console-resize-v9-0-8db78320ba81@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>, 
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Szymon Lukasz <noh4hss@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791806189; l=1674;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=hijD+b/Ci5+qYvNQp74WkoQOH4Pd8NDM9yoQj0qQIc4=;
 b=DBY7KWsHr3UjN41oWM0IK0eL6NF2j4XbqOOWvvv8hCXE16rcXRYpoarQewBMOGZtTqYV27PP0
 8lpp3cI9gqPDHjjIrZe7MljcmOm7c9Jdl+RUwgUjy2rpYxxNAFp0sP3
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wm1-x32b.google.com
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
 chardev/char-mux.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/chardev/char-mux.c b/chardev/char-mux.c
index 881443d869..5a90f0221b 100644
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
@@ -378,6 +393,8 @@ static bool mux_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
         return false;
     }
 
+    mux_update_winsize(chr);
+
     /*
      * Only move to opened state if we've realized
      * the initial set of muxes:

-- 
2.56.0


