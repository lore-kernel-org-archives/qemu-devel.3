Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33CF0CA9ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 14:05:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGGeh-0000Ib-LR; Mon, 12 Oct 2026 10:05:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xGGeZ-00006a-BD
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 10:05:27 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xGGeX-00068A-KQ
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 10:05:23 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-48870973bddso1165143f8f.1
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 07:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791813920; x=1792418720; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3889ddvtYewtgzDptQRS0YLOr3tptxcTWtw3BhYQAjo=;
 b=EikZufbooZ4bXgLVrgGKv1HTmsnOosZuFd68fEkYhhcM062pyTwQuCeP9BfmwVlDTc
 GIsLCfj01pJcGTY2DaZJhdYvEEWOwHlWnSLBKeH6dHnyT4XLNyiqd5CIrZy5zIr11Eyg
 9fKyOyemjScIZIVR70/4hChBxAIRpJlR3fxIz2NioihnotFqpmEOf8h9gMnYiEcMQ9/O
 3vJ7H491Vo0s4RbHiyedn8K3mHZ+RfKVlgWvou6/5Dg+OOShPpbk70mOkJNY6llsWgso
 JjovU7ppvU3R3/WqShmhVClgjr8LwR80b0NUCnjEqvzc/+n7jzA7wBobpRJ7CUA72ycn
 nGZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791813920; x=1792418720;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3889ddvtYewtgzDptQRS0YLOr3tptxcTWtw3BhYQAjo=;
 b=KgD0e2KLjdO3RmmXZ7ehiQolZIYHoepoojc6el5Gu/Drgi/Owruuo2rC7BTom5SchP
 AlTpgZ1V2tTAst4+HbuKCIgMvWHR/snz7GdgfLwpnChOryaQIMlvANO8bLHhDsRHIJx2
 yuu8ks90lNdS5T7/WaCTyPPhRQsJAjpHBOUPffC+zPJKLZ49lUQKJ/91+R39LFiZ1SJk
 W4/jQuoM4iJVKFpRQbT7ZcSKN+kB1+bSigQvSmAd/gvbsw8gUJ3hHik5qonei9iF7OU3
 PRUq55Iu1XMfiPbkPUDyETuB6NVPpNbSSxN1IJp7VHoIUg6v9bCN3PREuKdH03xDNpUa
 4Wkw==
X-Gm-Message-State: AFq9FYJwdrSgRj/k55GoXbm7O8z2dpdqBmusvMw3UXBLHY1wjlvUTPnZ
 KALHU/JNuiic8ZWmEV49xSLKrlKA0aBqwv7BGGKDpN8SRKLZ91yHkpVt
X-Gm-Gg: AYBFou0nUTZxkdsXCcJRpWW98LuQSVJ9VeMy9j65Tij5p66aLXCwB2ek0JZpRoRn0rE
 rbCe5ukPwIVnoe82/2ZNBJAuChhxrT/Mi5k6CCSpR1RmkfUkzYLhIqgASe9xOGbYdFCDy3APdEi
 wTTe0JDAZgfd1L9FMrjwn8ZRiJYa6dW75iQhpIYpVjrJhx84TFx0fokX/3FarL4++JW83gbfHKz
 NmXEWsRn4FbZXRkfMuAE+gcr8oe3dwT/wKkbWHZBnN8Wb3HSZ/AN67jrVJ7V5Rpos135kj+TIIe
 MHNHG8rfD/NdxdKQWYNWn35qGTOBt8VENANrtzQHFGl50q0KEWCFrV+3BpfigDCl2+ujwRW8WoQ
 pV2wb1O81fjXsqdnpC6l5VaduDQ4bmSRKepuG8O7h7IVlHdHQFLUo1DkRghLVcYv9DNzs6XKn4j
 8NrMEZXqTF1fF5BlyDjym7f6ltbAGnh4bp8JHRtWSSmU3hLHZWlC+ufTN0sN7i3NE0usxRdVCEn
 gk729si0bZHu5geW0xsyR6viA==
X-Received: by 2002:a05:6000:200f:b0:48c:5669:747b with SMTP id
 ffacd0b85a97d-48db9465ffdmr21905104f8f.8.1791813919749; 
 Mon, 12 Oct 2026 07:05:19 -0700 (PDT)
Received: from localhost (ip-78-44-39-34.bb.vodafone.cz. [78.44.39.34])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db9462ebcsm20298679f8f.8.2026.10.12.07.05.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 07:05:19 -0700 (PDT)
From: Filip Hejsek <filip.hejsek@gmail.com>
Date: Mon, 12 Oct 2026 16:05:03 +0200
Subject: [PATCH v10 04/12] char-mux: add support for the terminal size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261012-console-resize-v10-4-2c3b10d829b3@gmail.com>
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
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Szymon Lukasz <noh4hss@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791813907; l=1674;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=hijD+b/Ci5+qYvNQp74WkoQOH4Pd8NDM9yoQj0qQIc4=;
 b=gTQ2OY6RkGp9T0JEhTxmRGJM+MzSdvU5dLvtf00j5nMcBMvVrMYwcmHW6V5AvFSI2PCURkknH
 e7yE0vDg2EoDtPaHa0dvtqn4u6SHH8lhnNMDVgsbL+lmHPyRJFqwh5S
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wr1-x431.google.com
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


