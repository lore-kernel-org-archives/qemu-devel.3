Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 203E3CA9EC5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 14:07:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGGej-0000O2-ID; Mon, 12 Oct 2026 10:05:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xGGeg-0000Gp-23
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 10:05:30 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xGGee-00069T-FR
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 10:05:29 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-48c4649b35bso1796961f8f.3
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 07:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791813927; x=1792418727; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5s++mRNWS3BGHoHyzQWaCzI6IE1E0l6YOw9tCdjQpEc=;
 b=dO0PsABXp8DviIFep5o0QEmXw095MwX3kuM5HyXzUUmfUOEZoB6GYFE1Jnty2YLftg
 fBwrSRyRjvJHTLVy0507Z7f1JJcCIcSmBNFi24sAVx6zSPsmgU76NtzwLDVypwUCFfEx
 xwZvCZBggE8lhNRpeuBF/W4h+63Uw1Rg15WS7reoh3hbU1JP1lnDsTljq3z6vri2SsDE
 N7mmgoe9yY/FrLdMklU6XGm8kKkGQyCR3bPplzHTt9LImwg7cVXWMToDCQPVMHa7duGe
 6oHG9oGZBLj/DuaVN1CWwQMi0pJlINXK0RkYdV915b387uh1R7gZ1ycXiDaTCOr5nFL0
 vDDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791813927; x=1792418727;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5s++mRNWS3BGHoHyzQWaCzI6IE1E0l6YOw9tCdjQpEc=;
 b=PTcFLk72Hx0IR7IZijxYawovdS1/ZBeqH+bFFrkXDnqlS2uqtD/0F0/DPbmuGDkelo
 ZFKsxjT9oqm8ilSsgidInyjUe85hRNvq+xitIbCiabDm5/wt14BmbBWQ/v8h68CllXoW
 lHkpK0CozVd8BnTpdlMBWhB4Ji/3Nmj46HTk0CNhkIRj6/uNGFwpql2obXOJiR5yRfa3
 Xd2nuEcTVLaSaNWSie+NOuSlnTRDQi5acxNREG6guQJe2w1+PF0gW4IsDaiPT/03nBpN
 +51GaOVmT5+PlvjGLW4UydwXN9vVVy8v+Bahp7rSc8OxDfpLCFzEpFxiLIyLr4IWf3tn
 zvmg==
X-Gm-Message-State: AFq9FYIiAgOFzRUzcyEkEpVRz2NCjFxlAyrisaBEBwHAqq4vm2qs4wrG
 iB4Za2Vf7alS+XYjzUK2Trah7DS0Yerh6CwoGwEhZq25GrjuwKG6Rr5l
X-Gm-Gg: AYBFou3vXt8NIamX8WkSa4ydfDOeZMJn4nOCT703Xp5uS7nYauYWYAVu6VA2bYF5e+V
 7OF2NIBPPuARv2X6WqYDe/PZQAh1m3U6kWr6vEAOq4jvR+FVnyd3U0SefzdFY3eiCi20mmd04lc
 JnQFhZ/lWqRuR+uvUBRihX2W+ynewaOiIopnFI6uRMRIl84OmGAlOzFouI24VsNditF11wV9Orx
 ujkTZ0pJJAn3zJeF+UB5SnlT8ay9DsAgeNh+OfkKTOATB8uOXU+yNFRNuwKfDPYhyE3UHcYZ3DA
 dyGyDS2bYsmaw9Cjj9YqQL78yDLVojjYR8UIt3/yMJw8e3ZyydUWOrteg0PbpIm1uY1fy4lI9Wk
 BcYMH5Jvh0FdG4shRuwOIRpFUwvMQUqJc38qVDkRVTSen5GGcfcsOdw9P3p+RV1fsXZ8A4IBYXB
 rtDKnx5cbBEHamtgVtYUdwGJhZXY9q02VRdA+Ci41RXJ/0dBnC8IMrtcOB7BysS9WMXCcMkWGXY
 EP7QYTrFcVVREXmAwhf9b/MDQ==
X-Received: by 2002:a5d:4748:0:b0:488:8111:6f4e with SMTP id
 ffacd0b85a97d-48dbaaddd64mr12819572f8f.9.1791813926809; 
 Mon, 12 Oct 2026 07:05:26 -0700 (PDT)
Received: from localhost (ip-78-44-39-34.bb.vodafone.cz. [78.44.39.34])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db9acf092sm19671709f8f.45.2026.10.12.07.05.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 07:05:26 -0700 (PDT)
From: Filip Hejsek <filip.hejsek@gmail.com>
Date: Mon, 12 Oct 2026 16:05:08 +0200
Subject: [PATCH v10 09/12] ui/gtk: forward gtk console size to vc chardev
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261012-console-resize-v10-9-2c3b10d829b3@gmail.com>
References: <20261012-console-resize-v10-0-2c3b10d829b3@gmail.com>
In-Reply-To: <20261012-console-resize-v10-0-2c3b10d829b3@gmail.com>
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
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791813907; l=2096;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=8S5WnWDAWZYMyedDb0jD3hexh3AtPXvSKaEysmxUaFw=;
 b=30BjitS8ZdQmK2QG9vaUtuDtAWlSdM7Sx7pGDKcv4RVeiNTlJYAbOf5WBlj7Zf7+6nUJZUAyr
 H0m5Z8Qq5h2BhWEAscjuTeCBxOgf2lS3MdMO/ckqTk4rQHxGnJhUlbk
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wr1-x432.google.com
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
index ed7ffc06b1..8d312d6a4b 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -2196,6 +2196,28 @@ static gboolean gd_vc_in(VteTerminal *terminal, gchar *text, guint size,
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
 static void gd_vc_vte_init(GtkDisplayState *s, VirtualConsole *vc,
                            Chardev *chr, int idx)
 {
@@ -2258,6 +2280,12 @@ static void gd_vc_vte_init(GtkDisplayState *s, VirtualConsole *vc,
                              gtk_label_new(vc->label));
 
     qemu_chr_be_event(vc->vte.chr, CHR_EVENT_OPENED);
+
+    g_signal_connect(vc->vte.terminal, "size-allocate",
+                     G_CALLBACK(gd_vc_size_allocate), vc);
+    g_signal_connect(vc->vte.terminal, "char-size-changed",
+                     G_CALLBACK(gd_vc_char_size_changed), vc);
+    gd_vc_vte_update_size(vc);
 }
 
 static void gd_vcs_init(GtkDisplayState *s)

-- 
2.56.0


