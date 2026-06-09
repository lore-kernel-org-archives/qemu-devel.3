Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81BB6CD8CAD
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 19:17:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX1wo-00069T-3J; Tue, 09 Jun 2026 15:17:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1wX1wY-00063O-AF
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:16:58 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1wX1wV-0006RF-El
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:16:57 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-490b7866869so66344105e9.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 12:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781032614; x=1781637414; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6iqHGexK+vCP754AjDTgGogqrGkh9urwL3DyWoOCneM=;
 b=TVNtu+NP+wAcIO9AOKurMjN+1lEI+mDT10vyNfisviwqbmAlwhLX7tl9u5pPnOYxbb
 9v4g8FT3oeA4t8KHHbZ7oLtttzLsIua/370qsWXPr8kIYm5MC/Abc5eXsmbHmesJhlF/
 DwNQRlUWrlAUoa20ERb0RHtFja7xDqIajb56eb+6Zg3rlYnEWtQo01YgvnFKgqvUm8vg
 C9kmOCP+03ziTztl9fiFDei7OcCFP9Bh+017k7tBhxCRyaevdIFKDjgKB3fNtw2qbgB2
 a02WfuBd5ftv4HHuZMkUY0ZTK30iaaxkbZky2F51Gj9dYBjDW1xR6Cl2GmzdH1lw9SXV
 +Grw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781032614; x=1781637414;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6iqHGexK+vCP754AjDTgGogqrGkh9urwL3DyWoOCneM=;
 b=nTe9nA0TeQM+ChZEhFHoEnj4oeRLIPfs91hVzFxr0cdF2RGZp87Pc5OJ3qwfdpaJDw
 UpCCGvaxsrG4lCblN4S1Ui0ntxDAdJhWgbqk0c/1sMXCWQIkZG7Cj8pyW/DD4Et2mFra
 OHQ58H25bnpgoO2aiFWMmw12wMRNgUwO7ZOqPi4E/4NL4ko4dvKwHy6F3Pcd8M6qngr7
 UKNp3JnWJYa6upO9G9dj1dFU9rVDjh346MvwOgXLQ28Eshx61VElB4P1V+P7Npfl2qQX
 VlNR6tzMuT0wn+T76QKwY9Hpv/7VzLUnNx6mEnAP1e1j2zMqx/WnzMVfMM45YcUBXpp1
 5lAA==
X-Gm-Message-State: AOJu0YzqiHPBqQlSQJZBEist4CY2sDQuXmulMyKk5fqoGadD/e4ZfxM7
 CrVcLZFMjepN/bJloVXU9tnVxFrBntg13v8tCh5Odxf8y7Vb3TLqCl0s
X-Gm-Gg: Acq92OEEo+8pPfQMrw9Eu/F26q4AX6gMp5Vz7k2XUdTNA7gocEKwN8fbiYlHkImwcx7
 13eM0TX3jRnNGNHPDfTs68ou1NzyZnvd2PdLuY0TeVeTyaGv5ofnL9P3EyH+7FpExJqopA9uMym
 zcAQ+W4US2cvOQdgshcZLqh1zYt64lYJd4lOOGkVwddMX+yYjURpqW84oAC4hqHwy4EW858TE3n
 Q967MrqlyApXl5UrLYT2bNds0vJ+8QKrOz/qxVNLg5+eHmkXQyUO0hpzy+i7sq4Kd1HBMz7oWlN
 2D+1xwhNXCr8N57uWgwjdyA2K0yI+RbKVJdAlSe6cfgYERDJSLlCF6HSKSbikEqxNz30K6iqzx0
 EEj1Qihb/ItElA5JKa/beNs0/Ca5yJdreVd3dqK0a8e/1tjASAu8jZvdYV6v5zQNjvThUm6I/6M
 s1zSTCiL01e+z2qBmPoc6dNoh46NLTXQQugafCT2etw5YYliGWaDcu7C1XPfaz4mI=
X-Received: by 2002:adf:e906:0:b0:44f:da08:18f2 with SMTP id
 ffacd0b85a97d-46030507507mr25315840f8f.12.1781032613955; 
 Tue, 09 Jun 2026 12:16:53 -0700 (PDT)
Received: from localhost (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f344558sm62088214f8f.18.2026.06.09.12.16.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 12:16:53 -0700 (PDT)
From: Filip Hejsek <filip.hejsek@gmail.com>
Date: Tue, 09 Jun 2026 21:16:19 +0200
Subject: [PATCH v7 09/12] ui/gtk: forward gtk console size to vc chardev
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260609-console-resize-v7-9-0c550fdcec15@gmail.com>
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
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781032602; l=2089;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=jrD1GBiOkHpgLl9ivCJc+GAm0IqpUnS1q9BucxS0ujw=;
 b=YOhkIUlHtyq90OzshcPLLxgYeAWj5zZbBC0BcU8+lumgX3oQhJDfNVr1E6KKZALVpTXhAtWFC
 FWczqgXp6+xAAYCWZY5jLS7kx1GF8kKbsEWAkXZHuR7YMRI2xnyMIgq
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wm1-x32f.google.com
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

Query the terminal size from the vte library when creating the console
and every time it might change. Vte doesn't send any signal specifically
for terminal size changes, so instead we register callbacks for
size-allocate and char-size-changed.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
---
 ui/gtk.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/ui/gtk.c b/ui/gtk.c
index 4f706c6bbb..2863082a24 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -2040,6 +2040,28 @@ static gboolean gd_vc_in(VteTerminal *terminal, gchar *text, guint size,
     return TRUE;
 }
 
+static void gd_vc_vte_update_size(VirtualConsole *vc)
+{
+    uint16_t cols, rows;
+    cols = vte_terminal_get_column_count(VTE_TERMINAL(vc->vte.terminal));
+    rows = vte_terminal_get_row_count(VTE_TERMINAL(vc->vte.terminal));
+    qemu_chr_resize(vc->vte.chr, cols, rows);
+}
+
+static void gd_vc_size_allocate(VteTerminal *terminal,
+                                GtkAllocation *allocation, gpointer user_data)
+{
+    VirtualConsole *vc = user_data;
+    gd_vc_vte_update_size(vc);
+}
+
+static void gd_vc_char_size_changed(VteTerminal *terminal, guint width,
+                                    guint height, gpointer user_data)
+{
+    VirtualConsole *vc = user_data;
+    gd_vc_vte_update_size(vc);
+}
+
 static GSList *gd_vc_vte_init(GtkDisplayState *s, VirtualConsole *vc,
                               Chardev *chr, int idx,
                               GSList *group, GtkWidget *view_menu)
@@ -2105,6 +2127,12 @@ static GSList *gd_vc_vte_init(GtkDisplayState *s, VirtualConsole *vc,
 
     qemu_chr_be_event(vc->vte.chr, CHR_EVENT_OPENED);
 
+    g_signal_connect(vc->vte.terminal, "size-allocate",
+                     G_CALLBACK(gd_vc_size_allocate), vc);
+    g_signal_connect(vc->vte.terminal, "char-size-changed",
+                     G_CALLBACK(gd_vc_char_size_changed), vc);
+    gd_vc_vte_update_size(vc);
+
     return group;
 }
 

-- 
2.54.0


