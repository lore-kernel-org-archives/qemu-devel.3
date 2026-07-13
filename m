Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B76B0C44501
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 08:44:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjCG2-0004U9-Ok; Mon, 13 Jul 2026 04:43:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wjCG1-0004RS-CZ
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 04:43:21 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wjCFz-0003Cd-K6
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 04:43:21 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4921eed3fa2so26741905e9.0
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 01:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1783932198; x=1784536998; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Z40N7IFAqv4R1i4Jwz+zlPB/t3WRplA9W3n4ztoBvbo=;
 b=HAyRcn03Ow+SkrVu9MbxQFEkM+L/6eANl6YK6Q4A9521+GzNRKL74PhPrRJUBGQfRr
 UOx2u79lwBvTtbesfJzVe9VC8Ubwf84gn3IPNTd5ZbY2wADkcPmalra/99WOqj0eK4hN
 WMuDqYUA5giNxYaqm/SHmHHCp2cSq3oCHpVds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783932198; x=1784536998;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Z40N7IFAqv4R1i4Jwz+zlPB/t3WRplA9W3n4ztoBvbo=;
 b=jZMX6vk3m/0tApnm5CN7PQ5QzzZJKyUTl7ogLpc5ATy+wL0bs/OGi5Hrjoe/xzcdGq
 mrhXrXSzj/24XiImtVR0mVBJbWAmdSox15eGNc75j5/NvDAFXQ3p2Jr5k+CbIf6RBpWG
 rDDHv8eS9mby5kHfP0aZvyRKzfb4U5ti6r2E/LkvObWO3EauxFFf27xZmK6alUIxeL1Z
 o77bdxgBhnkVu9HE9FnlUn9vjls/fSk7kcUUgbpsff3XADi8k3g38GQwoftaws8ViR9r
 ecVzTHhv+WSpJa2e+TgiTiL/87b2uajr2W9Qvmu62aheLrMWaZxUqxDoGWZ7wjun5289
 sE0g==
X-Gm-Message-State: AOJu0YwQIX7cXdS8ScIFdh4al5zSXGqnF4TD40WJad18ODtOcePtsN+E
 iQfftZWxpqvXdZzsapPK+kFK4glW0bw88yNZaorZ3r1O0JF+wamdYuWgUj3Xm33JknREUUGgchp
 NS7lDDy7a1w==
X-Gm-Gg: AfdE7cnC/OUkegweOA2Wjvh5ATpJEdfVvrWmHFKvXIYY6nOG6agBlJmdTBNFDPLV6on
 InCzVjtVoaoWOBWijt2Ke1yjxGP5WMPFJyWPENf0ukCTx+7kAqdx7uXDxdvFF3uunsmoNojBxq1
 uYDEOLffD1IBhMNlo4+kmc9wDd5iXAMs64b35DAqoxBrd0Lfc1QKieDog+oh9CSqWzEtyybxjjZ
 oL5kT7zQFLiVJm8WhszRTbxK0ZC8kIos9uSpSZpeQFPavSFlz7qBEWK794GboKScOmgyyotnDhB
 9touL7NsjQCF1sS6MVzWlRugTaEnXP9jjfLY0Tp8RlT+SaKgaKYWclT3z9l6DZNE1mJfrM6KL0K
 lNhr7xXi0SFGl7igcR9as9L5Ve2GwRRdeIjB2vD6eoM+JTTllqDrjJJ5LU9u4yyQ+2gzUKFyzvQ
 PQPA1LXANqUII2LuOto7OfnG5wl1Z6bENsK/icxnqS1LOCGqK7TASdtyuuk9XV5hM0EHtnxBB4j
 H96nFaIBXXLHs+nQgGtTA0=
X-Received: by 2002:a05:600c:c042:b0:493:f7d9:8183 with SMTP id
 5b1f17b1804b1-493f8834eb1mr54275495e9.39.1783932198081; 
 Mon, 13 Jul 2026 01:43:18 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf574a7200912ca59176a42017.dip0.t-ipconnect.de.
 [2003:cf:574a:7200:912c:a591:76a4:2017])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493f2d97527sm287254815e9.2.2026.07.13.01.43.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 01:43:17 -0700 (PDT)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH v4 09/10] hw/audio/virtio-sound: introduce
 virtio_snd_set_active()
Date: Mon, 13 Jul 2026 10:43:06 +0200
Message-ID: <20260713084307.79593-10-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260713084307.79593-1-alexander@mihalicyn.com>
References: <20260713084307.79593-1-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alexander@mihalicyn.com; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Volker Rümelin <vr_qemu@t-online.de>

Split out the function virtio_snd_pcm_set_active() from
virtio_snd_pcm_start_stop(). A later patch also needs this
new funcion. There is no functional change.

Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
[AM: trivial rebase changes]
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/audio/virtio-snd.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index af50ab4c14a..5efedd6896a 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -459,6 +459,21 @@ static void virtio_snd_pcm_open(VirtIOSoundPCMStream *stream)
     }
 }
 
+/*
+ * Activate/deactivate a stream.
+ *
+ * @stream: VirtIOSoundPCMStream *stream
+ * @active: whether to activate or deactivate the stream
+ */
+static void virtio_snd_pcm_set_active(VirtIOSoundPCMStream *stream, bool active)
+{
+    if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
+        audio_be_set_active_out(stream->s->audio_be, stream->voice.out, active);
+    } else {
+        audio_be_set_active_in(stream->s->audio_be, stream->voice.in, active);
+    }
+}
+
 /*
  * Close a stream and free all its resources.
  *
@@ -605,11 +620,7 @@ static uint32_t virtio_snd_pcm_start_stop(VirtIOSound *s,
         stream->state = VIRTIO_SND_PCM_STATE_STOPPED;
     }
 
-    if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
-        audio_be_set_active_out(s->audio_be, stream->voice.out, start);
-    } else {
-        audio_be_set_active_in(s->audio_be, stream->voice.in, start);
-    }
+    virtio_snd_pcm_set_active(stream, start);
 
     return cpu_to_le32(VIRTIO_SND_S_OK);
 }
-- 
2.47.3


