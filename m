Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 302B4CA5FEE
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 03:36:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhfx1-00075L-Ci; Sun, 18 Jan 2026 22:29:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1vhfwm-000748-2z
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 22:28:59 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1vhfwi-0004Cg-AE
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 22:28:55 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-64d02c01865so6496042a12.1
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 19:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768793331; x=1769398131; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3ccX8SbNnP4SV6GDDNR9pdOOe2R1U/S1clK/q9e/aU8=;
 b=jb6nnph8QcJxt6Ixcqk9+V4wUYWQNEkrlQKS4Cfn03swfMwGHfQ9JPX0CHTt7cIerJ
 wVX+3TEKiQ1ocvjd/QJo/l6FHfcp4Pyw5JW7epOj7N5ajcW1FDEVOevkzF0DZIdB+5px
 pXSQxnqnEcp/WmJYmqZSITAaN+6do2NDTXH2gbCoKCIrOoxPU6w/9ARJ0z6qa3/HpI61
 8q1eCx8lfuCNBZ32FJWWSq2qgU/wA+mGALLyuIcgb+ECTUKS8aPpShTbVlnKpyQOFSlL
 /GIN43gmqpkQdnMRBMqGuPVqbZAcQWLmITGZFWAFsypPhzFYjz2hcS3tUAQV0ppgSZuK
 OYDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768793331; x=1769398131;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3ccX8SbNnP4SV6GDDNR9pdOOe2R1U/S1clK/q9e/aU8=;
 b=QaXtH2EC1E45Az3nn7sdaZvzOfv/TztSARY+Ggw042AnuMgxcRrT8Aix1xax7+jv4a
 jtq7Ml2+LSxxtWWooNPUOG7KhuLFLjYdilO7RsmkWOEbiIJ+NXQdMLGGzYG/6cgTaNhL
 S2NY4DDDVFikpLHUCAmhWmXRHWlNuYoJ5nMYsZFz94Jot8dO5h0M8uvadJZRUrnDJiOo
 zVVfJ3xLydOwATlTRvAJ2rFvDzw3NdXStv/2mNUL6ZTEBF5SQl7J/BSxiPK5jflf5qMO
 9xpSTXfHqmHqYjGWBlgW+eJ02A6AjBJMmAWEohocBatY2e0bb+ch7Gq30IyPP7LtY0h7
 KkYQ==
X-Gm-Message-State: AOJu0YxZHNrIG6Sz5A1lhcJAQ+VQ+BWbMgVRWNdAsqewjo5+uLWTVFly
 1if9vTOEKLcSuzvNAm5Fy9g7QtVzGZ81qBXYYD4H24RVCIJ336I4qcAu
X-Gm-Gg: AY/fxX4kthGTsaOslZ+UgC174148uSbTprxt0M3Lpw8GJr2gPwgknB5WElqugIjY0cj
 DYrkWQcjGnoT55/4QbvaqNvZ8abfEJDtqfwrL+NpORTaYJHMT77V4eIPhX+3CChWpuU2Yo8Y89F
 YxyiHVXVuV7wGaNgEZpgxSwmTPsMe7u9qH/E/5A99YLRvfRMORrGaNUc4PXVU5ANAc9BZ8wR70L
 CCLX3PPgmTL/Dnk0ta3aI/C6GVRpPvTzxjJ+QTecbn8lcizg40FpP9AZUdTJWacETqOKIg5Z5Hk
 /y6OnxQG1mxts9qzTY9vd1vnG2/oG+7a4iP2LfNgQdHQ7rJ5OKQb0ANGhTgaz9JfKuV4w6PEJgn
 9M+ItrScGDay3jiCS/9wfW98Zq/rxfEzJcdlwJybU2mGKbDCqJXW7xBLnOB2fLAIc/6/9EFcOfd
 JZl9fM7J4AnXH3ful9RgYD6rsXrhiz079ddu+CqtzRnsJooQjGp/g=
X-Received: by 2002:a17:907:2d9f:b0:b76:49ae:6ee6 with SMTP id
 a640c23a62f3a-b87968e2ff6mr870006866b.15.1768793330664; 
 Sun, 18 Jan 2026 19:28:50 -0800 (PST)
Received: from localhost (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8795168ca9sm966509766b.15.2026.01.18.19.28.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 19:28:50 -0800 (PST)
From: Filip Hejsek <filip.hejsek@gmail.com>
Date: Mon, 19 Jan 2026 04:27:55 +0100
Subject: [PATCH v6 12/12] ui/gtk: forward gtk console size to vc chardev
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260119-console-resize-v6-12-33a7b0330a7a@gmail.com>
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
 Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768793314; l=2089;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=onVJev5hnhhvDji7FBeNtwJXm35eSOe23V9pX3vYCpw=;
 b=1rmmpafUxV+d1rso7iajSxmc8ch24IJuraZR4/1OFphPEMarjSF4ix1eYjM5BDMbU6UaigB81
 De2lcQLNw96D9plRP+803s4vQCyaX/AUJ0MzQecDjK1FKlOPftNgpC+
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=filip.hejsek@gmail.com; helo=mail-ed1-x52c.google.com
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
index e83a366625..471528362f 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -2029,6 +2029,28 @@ static gboolean gd_vc_in(VteTerminal *terminal, gchar *text, guint size,
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
@@ -2094,6 +2116,12 @@ static GSList *gd_vc_vte_init(GtkDisplayState *s, VirtualConsole *vc,
 
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
2.52.0


