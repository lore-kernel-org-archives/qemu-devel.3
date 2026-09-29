Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66D8BCA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 16:41:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBasj-00057a-7G; Tue, 29 Sep 2026 12:40:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xBasg-00057C-Kb
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 12:40:38 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xBase-0006MB-7F
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 12:40:38 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912d37b6so24397215e9.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 09:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790700035; x=1791304835; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BDO7HoZUC0vaCcSc1ZJEVSQSCXum+jLLbmSe/0aiZnY=;
 b=f4VNVVyFNi02oYnzm3IOVFifHYuw0EOvaLW8zrcarkkwr2GKdmmDxgVrWs9o7mRtfq
 BfAU7Hx/5itI3h3wEOsOx2aYB57i28zYg+SiB4wMIbucKwXqd7SS+oX/ipmBdl9kmVLK
 3JKwt2+7fKIxs4xKraJfWZXygGZIxgm6jw5AD+1BFLjx/eCRAH3bnryRinBm/wUE7GIT
 bU7ansOpdrs4g9ahDesc59WP4MQHuexG6j1BUtiN7/N0VrP0ywye3z+L4yVjFUb9L78W
 aW6yueW8hSLnKmdDNdJhUEsOKB4mmhJ6a7A31FTcG8306JrwoSsYnTl+37IfN1oAYiP/
 kZcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790700035; x=1791304835;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BDO7HoZUC0vaCcSc1ZJEVSQSCXum+jLLbmSe/0aiZnY=;
 b=PNGeDn+/DY3xIUCWX5nzfk8p+i9SuTAtVOuxCD4kDF316qBvoRORyvdkubpoSLvtWr
 gW+Qo1rOYRxewvepDxCXJP6B2YK0HCTdJbCYQuQgZg4DSsNe0MEo7RBOLMo2hMBZcCAR
 QRiQ+Un91YaBbR5qmKnioHoEeXiddhOwlOXRr+Kom1ilQSysMUB+MZFPVoYoL9hlBwtk
 6XxoNuhtbceLo4dt5o8RJU6yp7G/ZgGx2ZPUF1F4okWmSgAhpH34RyYBFOOxxW/erHLa
 GqLh0OZ9nQhY/bq7WcC6kXLuaG//bL2QK+v8BXmBXE8XFpDIzcvlM6Y7RgVbolA42OlA
 jdVQ==
X-Gm-Message-State: AFuF++nuP0UY15e5ldXBKiBpbdHrpIrHLY+7qw+FvLdg5rKVNb7TLk7X
 0X+iL9gKrGoJZ/e1sjJH13DKkPUJfdu0qM1OwGoLgtgdhH4pL8Q+B0+5
X-Gm-Gg: AYBFou23U6+ZIpsG+p3Qd+A/snNfyqXPqbJwv6hbd7mf3Vfhbz7rg+ae1PBLF+BbX+y
 enI29UsEJYPAw8Z36DoafEE5AFVw0wrjtrehpGGKXY5i/r12rHpKX6n4HQZ6ENu9bjcU4W1yPl8
 qzPXWj1n2lSPaIQ5ziSn6C3nDWH/5nFS8IHVjhMLsqw+METJGn12YksxzraCFrvPotMNCoDQT8T
 CHxiKgImc504gvI8Q8C3jzfkVqTqkTBdGaETkNElT71PyxEyzjIinLN4iF0paS7wP/lFH2ME1M7
 Dss3+EeMJco54CQlDVneKPe1O6YglIM++rDe26EixuaP04pZXCNs8qr2POB7ACllHLH2x26Do3t
 eAb5pG/bQFt5OBR6ToKHKZy3RoEpsyQubFTqOidT4E8tgUNaK2Z7R27WR5FANbhR5pGGCSPnFG6
 syMUqXt8XpEgHuO0WhqGHb3lapBPKmDzMmpgbBZkAWDxciYBohS/lWIrTaR+riwcdgEUiR+GM/z
 RwlYqW6iKJ6JROFcpEVXHCrzqI=
X-Received: by 2002:a05:600c:698d:b0:49f:ff32:803c with SMTP id
 5b1f17b1804b1-49fff32848dmr135382165e9.16.1790700034825; 
 Tue, 29 Sep 2026 09:40:34 -0700 (PDT)
Received: from localhost (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af502cf08sm5948283f8f.9.2026.09.29.09.40.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 09:40:34 -0700 (PDT)
From: Filip Hejsek <filip.hejsek@gmail.com>
Date: Tue, 29 Sep 2026 18:38:32 +0200
Subject: [PATCH v8 04/12] char-mux: add support for the terminal size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260929-console-resize-v8-4-2ff9183f8750@gmail.com>
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
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Szymon Lukasz <noh4hss@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790700030; l=1674;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=XIo18sGrguMXRnYff57wk94laXzZTbeg8upSKiNp6+Q=;
 b=XXvK5neTkleB8mB1Nm0cQcNd2TflHgUO8uPAU9A22BxbGJCB9dVCYT6VGXd1jmD3jWcW5l49o
 mzOoStvVyypDTqBMre+qTc7Lix0hZXkgo7uEeAPHtfOs3B3riQt8fZe
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wm2-x10.google.com
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
2.55.0


