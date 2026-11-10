Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D0E606A32A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 10:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=cVQa4wQX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQj8j-0007s3-3f; Tue, 10 Nov 2026 05:31:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1xQj8g-0007r8-70
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 05:31:43 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1xQj8e-0001AQ-HT
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 05:31:41 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-4922dbcee23so957846f8f.0
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 02:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794306699; x=1794911499; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vljIAdkLgSSCSZRHPZJWBNwo7eqzG0bIyrMigVuydgw=;
 b=cVQa4wQXezdHSYvSinoXilvpX/mcL3hqvxe8+szF6QRRAEOOEeKexGStdlwdI0UlGY
 Mz3FFKo/hAmWROcGAwLR82lCl1L0ZdscNW11j9Te8atjM+97M44UBYn7ZvN+XKpWzv7H
 /FS888v7E/hVtE+5MfRI6mkAYxN8uQbeqxaPQiKenuiKtJhUwgY2S2pI0A5JZmnaBUJy
 vPiDPYLuzcdFurJl6qfIUsnhaN2fm4gQglWZzFA6Upwm9aYCroDQfPgaHsHcTtl9MnUS
 h5fGQefTqCtJox8k2Q1IT+ySMRZg+70aCUV4FSebfAJv2L7toqZD2hIoXAeJ72RVmvXa
 m8Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794306699; x=1794911499;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vljIAdkLgSSCSZRHPZJWBNwo7eqzG0bIyrMigVuydgw=;
 b=DBiOcSKXtONZ2TT4dhl0TjRiHEfuZzTJ6oYM6LMIOKse+/0AdGTEAP+lz1PGZ8TuBV
 BjNVKiAALA/HwEvUOzkiIGQdlZZWbiBz+dfDEl07XF0ZrrvilXWZaPrCd4lnc4QKbjec
 YlTTfx46urcval6+YGLF/aaRuPYVDGm7CEXIodaNnWhvxmKs4mUoKYF8qAe88cv2Lc+Z
 cDirydKFlUciEKrqHjkFX5Svvex4hLgznw47BFiKfIeQ5falAuEHAAFDskEBJKp7i7uR
 hpMdo9zOqkGfrdxIS0ApkyEALB4SZZmsI4N3S+FRaieyNb7udI538fdUwF9TBdDNd9pv
 k0KA==
X-Gm-Message-State: APuU4Z/e4Yq3MdM726rYXrXY+j3foHxlgCB/PjTbfmgfVFcqTETxMzJM
 8rD2icBPFMm91KxaPtvd7XGg96gY5VDxUaePlqwPNEljloJDc+0+voQqnumRyZ6BcpqoIzTzeWU
 DcaA1
X-Gm-Gg: AYBFou04lqD4ukBl9fzGHY79SFlFT2Q1MScKzMiCCDD1dRde42kKPuyZM/Jq+EEaarJ
 6y9oZm9oCFe6RYEmgxE/VATmzd5AjudzqvA7itD7tfHeT29R1sUF49s2d9NhD7hu9atLW2Xjgap
 LO+LCrJbjHPZj2c/oEgHnka8CmkiMHOpyGdZGVhEi+8Y3zCAn1inM1SkZJrL2/Wws1Q1cO7Avk1
 2HA9v7HmGL4h5P09/YjHVnVVhDN92TtwcWOVE9PqGatDVfCOrUnW99owKSPhctwtopjlT2ZYWLi
 BoU/CUNQIDYZTX9WCvhMbPZsbG+WdoUs4Ukr09Rt4PPpysTRZJxf1J1N8Lc56scjlW+UaHBJOr7
 PCCzx3L4UKm2KPAnCf/ID0Uox+CfaTtFDo8NeWseEKuZoVVsrJ5Pi7Rgjv6sko9Ii/eyuYttDRW
 VopqwLTvvMOJrwqq0VxnE+bczrChEAt4akl0/HOvCeWioNcFr1Qi7gjOL4VhafyqcNE6KylbXn9
 rf8yMVd4ON6Ay3tsN25Y/4T38NrKRp+QxOXbUhs/rITfNqrlGnmE+s8iIHcNCmW4h7gP6Wuxi/s
 /aoGuZW7QwT0hbz5EVL1meNvMgJJYRXZFwrXuPkkavJZ2IVanb+9hYn/vxYGm3o0Lz4V3585oXM
 WX71tYT/4eoPhB6BsHQSuKUaz8ounP59nb1TKRjdlEVWLIdgX0xZ5O5Kq0aaFUDoNeYA+kDWDXr
 YJmuoHafhC8q/hev2+OHAcAdLH/+LIVwWa/Ugkx4p0ilTe1U9eM8y81kn2A1i7dLE=
X-Received: by 2002:a05:6000:4696:b0:498:2754:6a80 with SMTP id
 ffacd0b85a97d-4982fe32930mr2417021f8f.28.1794306698699; 
 Tue, 10 Nov 2026 02:31:38 -0800 (PST)
Received: from satan.lan (ppp-2-86-138-39.home.otenet.gr. [2.86.138.39])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498366c43f4sm5279060f8f.47.2026.11.10.02.31.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 02:31:38 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 10 Nov 2026 12:31:30 +0200
Subject: [PATCH 1/6] virtio-snd: convert virtio_error to error_report
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-virtio-snd-fixes-v1-1-544d6f9eca38@linaro.org>
References: <20261110-virtio-snd-fixes-v1-0-544d6f9eca38@linaro.org>
In-Reply-To: <20261110-virtio-snd-fixes-v1-0-544d6f9eca38@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4217;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=pz69gFiFH0eYhwxowWXjkndE5bzKGEn0L87jqHFcBZI=;
 b=owEBiQJ2/ZANAwAKAXcpx3B/fgnQAcsmYgBq8vKHRmExBcUwtwv6J+HwnFUhxfEXTb7N/XyjX
 fCPXdAuraSJAk8EAAEKADkWIQTMXBtORKBW84dwHRB3Kcdwf34J0AUCavLyhxsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwwLDMACgkQdynHcH9+CdC86w/6A1M2uBtZCEVepcZCO1dAE3VB/uQHSAI
 ZD90PQ98nJauapyJ4eyFtH/egwJmp4pksm2iL/y9y0apUi6bK0N/UG1w68vlyfDrwSzTXsScc6n
 mZUuwN6ZmTZ6YvTRiWgejOwf+iDYSe6HjVaZ2gJYd1LlW4Nu5PkfkskXqQXSJjSMkwkqZkD/1UZ
 7dvNHQ0bTwjcHR1RHqewuPVHjvQoBuDuzg2Cu0ZeWrM52zwCfu/jqn+G7nBCPkJuuy7kgdsckNO
 5E47hOm9sYuOEZO5v0q3Mhoavgb1nvOXbC3kKiPsa0gCACHjY52dzPgGKb4DVyEOSA2bAmQe0wK
 LjDUDp2h4yOHiD3w/S4phblQqCQ7FMKiaZXBkNyvd40R6gCqrNjVQLMVOGmqDq9XTdfnzVqH+pz
 Op6P0E4pVE9tHBLGzt4+Ks3R4eSHUdzR7PewyTr7daKvwKQhfOo9Rzvt2uSqAJ9+0dgIq3BFJdM
 ZW9CG84p/VxWlbLYFxc50UrN1/1iU4IxCOdiTQ4nGURkudpzJXOmMIAw0t6q00BZU5va8ON9tax
 AkxQmWK8gtNRfCnyjAcvfnsLgLkkc0iuGEyjeBVBhq6kbWUDkeduG6EMsW3Majkz0Bw5CgU1JYO
 5M41Aq0FNF1QxqRjZUFopkz3R/zCl+DXIikdAyqULeDnnwxsbays=
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x436.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

virtio_error() also signals a RESET, which is not what we want: we want
the guest driver to read the VIRTIO_SND_S_BAD_MSG response.

If a guest sends an invalid command and we do virtio_error() and reply
with a BAD_MSG response, the guest needs to detect the device reset
otherwise it hangs forever waiting for the response.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/audio/virtio-snd.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index fb22d79949..bed36203f2 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -298,8 +298,8 @@ uint32_t virtio_snd_set_pcm_params(VirtIOSound *s,
 
     stream = virtio_snd_pcm_get_stream(s, stream_id);
     if (!stream) {
-        virtio_error(VIRTIO_DEVICE(s), "invalid stream id: %"PRIu32,
-                     stream_id);
+        error_report("%s invalid stream id: %"PRIu32,
+                     VIRTIO_DEVICE(s)->name, stream_id);
         return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
     }
 
@@ -310,8 +310,8 @@ uint32_t virtio_snd_set_pcm_params(VirtIOSound *s,
     case VIRTIO_SND_PCM_STATE_RELEASED:
         break;
     default:
-        virtio_error(VIRTIO_DEVICE(s), "unexpected stream state: %"PRIu32,
-                     stream->state);
+        error_report("%s unexpected stream state in %s: %"PRIu32,
+                     VIRTIO_DEVICE(s)->name, __func__, stream->state);
         return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
     }
 
@@ -535,8 +535,8 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
     case VIRTIO_SND_PCM_STATE_RELEASED:
         break;
     default:
-        virtio_error(VIRTIO_DEVICE(s), "unexpected stream state: %"PRIu32,
-                     stream->state);
+        error_report("%s unexpected stream state in %s: %"PRIu32,
+                     VIRTIO_DEVICE(s)->name, __func__, stream->state);
         return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
     }
 
@@ -624,8 +624,8 @@ static uint32_t virtio_snd_pcm_start_stop(VirtIOSound *s,
         case VIRTIO_SND_PCM_STATE_STOPPED:
             break;
         default:
-            virtio_error(VIRTIO_DEVICE(s), "unexpected stream state: %"PRIu32,
-                         stream->state);
+            error_report("%s unexpected stream state in %s start: %"PRIu32,
+                         VIRTIO_DEVICE(s)->name, __func__, stream->state);
             return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
         }
 
@@ -635,7 +635,8 @@ static uint32_t virtio_snd_pcm_start_stop(VirtIOSound *s,
         case VIRTIO_SND_PCM_STATE_STARTED:
             break;
         default:
-            virtio_error(VIRTIO_DEVICE(s), "unexpected stream state: %"PRIu32,
+            error_report("%s unexpected stream state in %s stop: %"PRIu32,
+                         VIRTIO_DEVICE(s)->name, __func__,
                          stream->state);
             return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
         }
@@ -724,10 +725,8 @@ static void virtio_snd_handle_pcm_release(VirtIOSound *s,
     trace_virtio_snd_handle_pcm_release(stream_id);
     stream = virtio_snd_pcm_get_stream(s, stream_id);
     if (stream == NULL) {
-        error_report("already released stream %"PRIu32, stream_id);
-        virtio_error(VIRTIO_DEVICE(s),
-                     "already released stream %"PRIu32,
-                     stream_id);
+        error_report("%s already released stream %"PRIu32,
+                     VIRTIO_DEVICE(s)->name, stream_id);
         cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
         return;
     }
@@ -737,8 +736,8 @@ static void virtio_snd_handle_pcm_release(VirtIOSound *s,
     case VIRTIO_SND_PCM_STATE_STOPPED:
         break;
     default:
-        virtio_error(VIRTIO_DEVICE(s), "unexpected stream state: %"PRIu32,
-                     stream->state);
+        error_report("%s unexpected stream state in %s: %"PRIu32,
+                     VIRTIO_DEVICE(s)->name, __func__, stream->state);
         cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
         return;
     }

-- 
2.56.0


