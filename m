Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA30FCD98CB
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 19:18:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX1wj-00068w-VU; Tue, 09 Jun 2026 15:17:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1wX1wR-00061K-MA
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:16:52 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1wX1wP-0006Fz-Vz
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:16:51 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-490ace40f4bso68729265e9.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 12:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781032608; x=1781637408; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=c+dr2YiBQ+7LoFZn8iiS6Nf0W/hS4pbeXFQ7c1bY7RU=;
 b=Q1nKdhyuIG1dGBUMrOBXpKWS3Y1HfZTBT/eHaC/xLBnfTG46WwD9iBYqaLQvTAUt90
 K7rx7+bfvUsGSw0XDR7jEswgWJKR5UWab1kUdq35uGiDO9sKhyCgFLyN013V6okM9rVk
 fBrcZSmrnd7ensZY6dLkjIjl1YcKc5Ah0p/6UkDZ7w/Ws7+ZrnsnTwuueEJv0ol3Moie
 nMASTvI0v4GSR+TDhaoLmZDLyR/8x7/FVUCzYAg+VjKdXRrrVMnu4RUYnbmuRpl/dnKC
 jqpcgCI3jhtWMHXYDDTViSsS7IIPenMbHOTUxuSse6mPltNAYeB5FbJFWS9EFt24scC7
 +mmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781032608; x=1781637408;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=c+dr2YiBQ+7LoFZn8iiS6Nf0W/hS4pbeXFQ7c1bY7RU=;
 b=llRd63MhjdwqkSbKqqTEEyyd1IjQfB3gowNQPgk9Xv6TKP6ESDFlN6ukMck7/wqxuZ
 9KDZWbwLSW5TX+6M+/uI9MUqHs0nRmtkSvtduL1UG1bONt5qNdYrLQEmUuc0lEFTQJ8N
 SETvd9LY7v2cqyDJsRTDDf2cYJqJZwOZKwrdlA2ThBRzAcTNUNjlEzNKxNHgAnJyM28D
 0hcMyEQsQGoCWNRFzA7pTsZ5bgyrd8SyXo9qQPwCIXsxuHKFQFLLcsW/lNWzltsQw1Y3
 qALCETbHAzf29oYk1nZ2Gw3xhEJ8XPEkKkjWqt1/9n1OVMf7a/lOZdfywP4kL+QWlzkR
 FT2Q==
X-Gm-Message-State: AOJu0YyahxZm/STlQa2u/ipzSADYJNhKvlCcpZEdV+eRr8En9SuGXYoq
 vvB7fF9Ls9XjiTplUS3I146bRD0xXecwNTZxTDNk/fqomz3IPMhv1o5L
X-Gm-Gg: Acq92OGS4Z885r3xtAO1gUidXyzBUv0ljoTN3wnTiBJyGt23pqIEYNMmthUJaqKMp1V
 Qzlkud4p9O1fmHPNJa5pe1vIj0uG3YDwHl6Gyx5NdsHXYmYxYcUpnyjuPKsuJPO8ptuoRXXTkqv
 pcBn++ANCTtYu3lWyabXgQVVsHxgkd9CBzwHktbK3qQ0wHEqQ8E/wYdj/Oiij14KtRlW84WJypv
 UkuXdzpeuZFjJJ/tG+kzvVN63oDBzLQEtcAyk8UsYdU177EFC5Rc8x+Idp8SwtSPDyrwCRrUxB4
 j9yZflgHcEkVg6W54l8s1PvuSZ0en95n8jYoVifOnZKYPwmw4RjkLmBOHIUmC06H72TcRQZzLRr
 5AYZgkIaiDKp8Y3FBbQ0f9RYfaVLTuTjFNQzASMj8fdZKN/blJUmBBP93/3KoSlRjLz4Fntmnyc
 h9s98rBRGFyy6L4XJu//+3+4oZNV5cGvKkQWCO8PrgLTRqXmbkuYZbLZEo02z0Ozo=
X-Received: by 2002:a05:600c:6792:b0:48a:f18:ece4 with SMTP id
 5b1f17b1804b1-490c25ee920mr364215185e9.24.1781032608249; 
 Tue, 09 Jun 2026 12:16:48 -0700 (PDT)
Received: from localhost (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f0a43e9sm64596889f8f.0.2026.06.09.12.16.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 12:16:47 -0700 (PDT)
From: Filip Hejsek <filip.hejsek@gmail.com>
Date: Tue, 09 Jun 2026 21:16:14 +0200
Subject: [PATCH v7 04/12] char-mux: add support for the terminal size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260609-console-resize-v7-4-0c550fdcec15@gmail.com>
References: <20260609-console-resize-v7-0-0c550fdcec15@gmail.com>
In-Reply-To: <20260609-console-resize-v7-0-0c550fdcec15@gmail.com>
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
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Szymon Lukasz <noh4hss@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781032602; l=1674;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=NeR36JL0tdGPnl41UctbgG46PQzdHkSZ0rBEOEK3RZQ=;
 b=AJ8qYSPUsd5BbjD9iBTMJCVPQaJaPPk/vjP5V1qnO0opjFSrSf6Yg3cktDmZ6RuQrUuTC7rrP
 W+0AhcTUzA0CsIcOo6QJFHodxyMH9esLGWjC27w7c0hp4KQi9s04bUX
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wm1-x333.google.com
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
2.54.0


