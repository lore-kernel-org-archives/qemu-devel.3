Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 474BECA5FB1
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 16:41:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBasr-0005GZ-IY; Tue, 29 Sep 2026 12:40:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xBasm-00059J-1W
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 12:40:44 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xBasi-0006NZ-Pl
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 12:40:43 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-4a00d8bec5aso7213405e9.2
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 09:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790700039; x=1791304839; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=E9/8dlsF1f+rdUiyoMPrpivTOlrgDaaNH4vvswRj8HE=;
 b=qRLSfVvBLQrSqslBF7eUXAhnObt9nKVQqfhM7BI/r3o0TLxBCagzDn2ki8XYY5C7fX
 mSU8ZHUXAZpIfxjptGVBhwBHwObK6pKo/ZIUTMXVqBc+Dbbc88Z33g47cof/TQd06X6q
 3v2I6UieGNKPP+7rG4nBSod0OMwyr/inWn411P6sDNHIIVgRYIpQ5+smmQdE7X2yPT5L
 W4En0t36Z8yj0+/S/AR0mJRgM1Y1aEDM3xp6wF4WBY3sdgUY+K0j6s7nc0byBJc0YgTn
 5yYa0aW0oYXN0eGw0y6Fv1zw1xbbzJ5hIzmGowgMFmFYL0IvTKus1Q9ZQYsU12b9app1
 EzSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790700039; x=1791304839;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=E9/8dlsF1f+rdUiyoMPrpivTOlrgDaaNH4vvswRj8HE=;
 b=v/NLIPyE+1eWQ0x0CzG4DlxtyOWI6DBk8XnVr7BHTjGfZ8DxATiWu2AwTtdJs/R4fO
 RdYmWw9dhn0Qr5lhUGMRKEgv7EFldIKbL7VCJ3uGseoNCFybDsoNhJOlI/iYtyCIaZLl
 qQgaD3mtKa2eD/Ns8z/MwU0VSksEVfodXgh8QyoYgZCbRO7grs/PGCwe1MAP4aqlEHSb
 QPH/Tt2fi5LGa3cC/J3n+/2ytztvcB4DHPI3EulHLadnzpW2ULFLGUFZdqGo1eGiFKl8
 vJc8i3ySS0KsyMTDGSHhZuo0XJhb+eARm7GeeiMZlm/9oufwGIy08HVSzBeffUpkLSGS
 tGkg==
X-Gm-Message-State: AFuF++mRz51p1vVKKak1skXOTV6zdWBClNn0WJzWhYEFAtxyCMmahy94
 4QZWd5nDA+xpssD6z/m747eq3gMxFBJkuYGGL15rQs8cmYWfI7GoPM8oxB4nDVIk
X-Gm-Gg: AYBFou1gpbsvdwilFwnlhhVCzoDpRLZp1cRsWzUAu9bpLcL/Ptu1+ue9JeuUufllS8T
 zHayXRd2sHCsy6FCukyW4zzuM2FrYpuTUGQ8rky6lRf0fWkwWOuRGZkFSWhLnZuxNuffzAt5JJ6
 Z5JAu63rJAqjoOP60C63wu9wYrq4K2wOmrCIx+SCxibKHyIYYs8UdcrUziJ4xO65Oau2pUFIUFL
 BAIG63VJINrkWkgdkvNHCB0nYiB0GoATHY3jmdWNCRJw+NtsOVdWvV4cCuujo/bmTfJZhrrBtxY
 VhkNQEZOafMav/yzVeI7FYyInaShdZnxwsXDPVtvqp7dy1hnc+xW8vCU44rtt1uwm53VKaj6jED
 3kCcCgoGcu/OgGnKwYme/1sn5CZBQa0GBYu1WZv9EU5QiKdMYukitHmTRmcbFK16KQwMnUqaeu9
 CK/jlf30C4Jt/zKezAmUC4poAHRfKvgEjAxBJTzUNVibDGntVsZ9/H4Kx1vF5LOaB7PpotzGpQd
 AXmjxG70fIrnhNQFsgBmiTqU/4=
X-Received: by 2002:a05:600c:4ec8:b0:49f:dd10:3c71 with SMTP id
 5b1f17b1804b1-49fe66c61c4mr303969495e9.11.1790700039107; 
 Tue, 29 Sep 2026 09:40:39 -0700 (PDT)
Received: from localhost (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01489e092sm774815e9.0.2026.09.29.09.40.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 09:40:38 -0700 (PDT)
From: Filip Hejsek <filip.hejsek@gmail.com>
Date: Tue, 29 Sep 2026 18:38:37 +0200
Subject: [PATCH v8 09/12] ui/gtk: forward gtk console size to vc chardev
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260929-console-resize-v8-9-2ff9183f8750@gmail.com>
References: <20260929-console-resize-v8-0-2ff9183f8750@gmail.com>
In-Reply-To: <20260929-console-resize-v8-0-2ff9183f8750@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790700030; l=2096;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=tiBprBnqlulDBhTbq5UaQmZbu0dPfdJHhii8brLJ7Gc=;
 b=wj14ta37N58srsrvrbE9Y5bsWe7+Zgkzhpk0WWqHpMUVKdUJm0euDn1KmJznTsEp54zG6uLf0
 uGQlau3i8WgDNb3I8r4SQ2RU3Jiwx2FYJb3pho9O9X5nfZxFgBRvVSu
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wm2-x11.google.com
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
2.55.0


