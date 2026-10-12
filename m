Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABD68CA9ED0
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 11:58:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGEeE-0003Yn-IK; Mon, 12 Oct 2026 07:56:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xGEe7-0003Wv-DR
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 07:56:48 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xGEe5-0002Ob-Pi
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 07:56:47 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-48c4d99c32bso1738643f8f.1
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 04:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791806204; x=1792411004; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5s++mRNWS3BGHoHyzQWaCzI6IE1E0l6YOw9tCdjQpEc=;
 b=aGyYS/6IngEbaY55xBjY9848hpY27D/2Ah4HQS/W/1EQ3XiE0iSPRVz/SJViWDzLkr
 ILnjV37wwPv++e6IHkttZaMgGStt67Q8TF7KaxWx7+8ktGZuj6dJEKE79Nqs5HwRRvOB
 nrifrQrHiTNeFc1lmR1RCtxFCpAl3k71gFbTs6Fnqd6yUEfbDioFexXk0TBbcdN1fNMq
 rVtgGQ7ijx3eNi+t7Gw5E03/ITkmMYFwJ1fi9eJfS1S5uLS6Whe7jB4eEURQnkg2KHd7
 BSASCMxTAhCU4jDMgy2OW9AdWsbASh+20oUxrMgjFId7veB4oJ+8NwCFbYBWKBAI6mxe
 wgMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791806204; x=1792411004;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5s++mRNWS3BGHoHyzQWaCzI6IE1E0l6YOw9tCdjQpEc=;
 b=U9VUZxHulDayNBpgiJ4YDY9RXx9wH8ikyXYvcVtH+CHA3BjmsqmY3JULDqq8CkP+Mp
 p5mod07k3Tj3cBp8haATTBQyCVs1pJiYHgcSVzfbPxCIh2c5Q2GGHIphSV+xU4RpRcIG
 jFfWhh7KyoVsUoeftQcoY8JcBHGuGHHBb4npT4Jt7/0l/jKMsD7G1wz1jfLnqOK83m4X
 AM2WVJxmCNUQjTPrll6QiCDdvJs6wbR6jfHG+w3baUkztvtp5BwcmIb28jBSfrAn5MY0
 C1ZQlYKz7M7znJlIvBNZ8TQwaee0XoBNNDB4y2g/tCtU6Dx9cWn/q9oA6lnhAKep4aF8
 H7Bw==
X-Gm-Message-State: AFq9FYLeWAVtU0fBNOPQAcMeJiDY61REa0FpUWfJNgUNUH3gqqCw9ScO
 t221JyWKLXR0ViDbmdHyb5z9/nwfHAIhFZvu4NpmkJyAjilWt6sqxdcV
X-Gm-Gg: AYBFou1saB76pEzX4BIymk90TGrEd6FSdVd8AclY6G1sWWk2mnTMDkQw9nwwz1Ovbqm
 wbnRAjpOeNjz61l/8SlpbuGMjZBuMpcPskHtaRuer9X6rmZ/Wd6UIl+ziMLSvpocLUOxglyRuLo
 mtbJGVcht+13C+RGAFq5tAZoLGno6iOPJzSj06o+5r/VHZUF/9Gz78lAeP/TM9V2eM6sMbSn+LN
 GZjC+ZeNocpxbcpp+eTQNa8AQzkVUAH3JqWEjLC81hU+RD/aMnVJXW7D+zZZjh3KCnqcyPphLJH
 V/XboeE+AvW7h6oVi04libr/NYD+0no/T9Z8PE+nfm5pzVbtAI/oxtUG1IqTS2LNJX2tkxNRQ0i
 fWteDoELz4GrMdou4H8aOsFsXFsae9Ww9CBqoXrTLa6+s5UDRIGXF+Lz65pU+kBTbHXwslAjvPq
 QHDE8cZRhb+NT4u6D++dR6CrIqzCQppIrgXnW10fvQdtxQf9kFnvDTOncB38V/FnObDbKkkDkMq
 onLvR9JLfpy1EvcJ3EeQrchmPb/HoKSsEVgZg==
X-Received: by 2002:a05:600c:46cf:b0:499:b65e:49c9 with SMTP id
 5b1f17b1804b1-4a18e47ad5fmr196526565e9.10.1791806203946; 
 Mon, 12 Oct 2026 04:56:43 -0700 (PDT)
Received: from localhost (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a192d3efb6sm170603205e9.1.2026.10.12.04.56.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 04:56:43 -0700 (PDT)
From: Filip Hejsek <filip.hejsek@gmail.com>
Date: Mon, 12 Oct 2026 13:56:00 +0200
Subject: [PATCH v9 09/12] ui/gtk: forward gtk console size to vc chardev
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261012-console-resize-v9-9-8db78320ba81@gmail.com>
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
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791806189; l=2096;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=8S5WnWDAWZYMyedDb0jD3hexh3AtPXvSKaEysmxUaFw=;
 b=ONNVDnFxSTnEscAfkAnQ9UOGQHJmpuCSxf82Ih+8PjMErwOJq8mv5pzeOgk0C2C8p4u3BOqC5
 HyCO8+Ea27ABoTJJE+srFljSFvpjW53/QJiZRIYfF4l34Y60xiOtfEp
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wr1-x42a.google.com
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
2.56.0


