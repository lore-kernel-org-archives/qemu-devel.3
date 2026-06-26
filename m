Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 851CDCDE00E
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 12:36:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd5mu-0004bP-HZ; Fri, 26 Jun 2026 08:36:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wd5mb-0004U5-T8
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 08:35:50 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wd5mY-0002zP-Vg
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 08:35:45 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-46f34d8f888so554193f8f.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 05:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1782477339; x=1783082139; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KFd85FRhGIbup+/VfXI75bIlDOMkEy7XmtIzQK1BDKE=;
 b=E2LCRvo/bNznbq5ZpUvsxY8RvZy3EFD8v4+lqpJM6TfyuuJ9IpxrcLac49dKEOM5j+
 4MRjHsqQSIAmUfcmyPCUdCNB0GMGRIRDB8Hq0OVv/HVVBY5wDNENAnGh/GFSn1Thwy0c
 tb2Bi6MR/Ak6FNCTPbQYj7oPkJhU+rWp4C4qM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782477339; x=1783082139;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KFd85FRhGIbup+/VfXI75bIlDOMkEy7XmtIzQK1BDKE=;
 b=S9+Zfl5h014Gx1L5Va9UX6nAKQyo9ZYwO2AK8w10caBL2e2Fh8dI214YQvr+eBKrQa
 mmX/9COtfHesQcLlbmPL6ol8U7VmhOhrxiAA4yefrWUgTinA+/FeRc3D5akoGjcx2Bue
 tRaw0ZOBOW5ks+88IbzpNv4aVU78c/ljSdTPhllzxHVnLmUQExc9wJPhwl/MJjFniz78
 63Mwl/AC/M5sX1ZkHOuqVjNtagx9pXsUhE1tOR5n7he0d2lG4hIO/qEln/WG7ChGWI52
 RoOuulxMiPEkvbS9MEhhdfGS7ocnU1KaRnUdfHV+qmK6ryLD15M4Fj9BeQVdpvXUpLy/
 UrbA==
X-Gm-Message-State: AOJu0YwMYdt7pJSJX+1qg/flSuQWUSZUlqXJtgFb3M8eH4nuyZL30gRU
 i8uk6Npqd9xpDBhQwq1TW+jl0lrnBy/iqRQNhPyKXqb8BGBJlpEd5p66R5cih6qwLsryo7Ntgj1
 yUIluGpg=
X-Gm-Gg: AfdE7clF1l2oPLTHtSYw0VO/Q701W95YPLo9w1g0g3i0uibeTd8JQT57uiwP+Q7Yl/c
 zNubu7C3Vyk2b/hpu65786qpJSbxH4Ze+QMTwVbzOprOSPVhdvcEeYLYIlnMl2tTW8IrhEUeMzW
 54GgbJ8pS496HXZTLKbfvQ+isIOoRtW0vd7cJIUqPB7o85SIzoowCiFUkaY6bf1nk5ilNcnK1nm
 ETLdJJydsTSyz/QlK4o6Epu4chkQ9v+OVt+qA5y8LAy6feXxVoZSz99bJnlDwCvjhn7+1UYsW1O
 LrYMfcGOTJS7CHgO5UnEglCYRIxm2lxrOX/g2df+Czvl49n/+dkofJjRv8a3awd9Qx4cI04q8di
 biQtjhIXrkTpYktBYxeiUCYe5yGu+5ZP3rtsBgN23lHNYKZJlCUhlBszHFJNoNNVCowTb+UStR1
 oVKuVe43bVMKAwaiiUTd9hh5g9Oxrb8113/sfnPS5od9IS1EI5Gr7eT1NIjeUOh2Cf4/mZ1TGWl
 CMIPdhyk+5j
X-Received: by 2002:a5d:5846:0:b0:460:2eee:4e21 with SMTP id
 ffacd0b85a97d-46dbfca2c90mr10486647f8f.17.1782477338560; 
 Fri, 26 Jun 2026 05:35:38 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf574a7200aa896c1ac04cb1b2.dip0.t-ipconnect.de.
 [2003:cf:574a:7200:aa89:6c1a:c04c:b1b2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46efd7ee1c7sm7373757f8f.14.2026.06.26.05.35.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 05:35:38 -0700 (PDT)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH v3 6/9] hw/audio/virtio-sound: introduce virtio_snd_pcm_open()
Date: Fri, 26 Jun 2026 14:35:28 +0200
Message-ID: <20260626123531.132078-7-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626123531.132078-1-alexander@mihalicyn.com>
References: <20260626123531.132078-1-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alexander@mihalicyn.com; helo=mail-wr1-x434.google.com
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

Split out the function virtio_snd_pcm_open() from
virtio_snd_pcm_prepare(). A later patch also needs
the new function. There is no functional change.

Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
[AM: trivial rebase changes]
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/audio/virtio-snd.c | 60 ++++++++++++++++++++++++-------------------
 1 file changed, 33 insertions(+), 27 deletions(-)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index 68d737478f5..d5242a5c761 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -429,6 +429,38 @@ static void virtio_snd_get_qemu_audsettings(audsettings *as,
     as->big_endian = false; /* Conforming to VIRTIO 1.0: always little endian. */
 }
 
+/*
+ * Open a stream.
+ *
+ * @stream: VirtIOSoundPCMStream *stream
+ */
+static void virtio_snd_pcm_open(VirtIOSoundPCMStream *stream)
+{
+    virtio_snd_get_qemu_audsettings(&stream->as, &stream->params);
+    stream->positions[0] = VIRTIO_SND_CHMAP_FL;
+    stream->positions[1] = VIRTIO_SND_CHMAP_FR;
+
+    if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
+        stream->voice.out = audio_be_open_out(stream->s->audio_be,
+                                         stream->voice.out,
+                                         "virtio-sound.out",
+                                         stream,
+                                         virtio_snd_pcm_out_cb,
+                                         &stream->as);
+        audio_be_set_volume_out_lr(stream->s->audio_be,
+                                   stream->voice.out, 0, 255, 255);
+    } else {
+        stream->voice.in = audio_be_open_in(stream->s->audio_be,
+                                        stream->voice.in,
+                                        "virtio-sound.in",
+                                        stream,
+                                        virtio_snd_pcm_in_cb,
+                                        &stream->as);
+        audio_be_set_volume_in_lr(stream->s->audio_be,
+                                  stream->voice.in, 0, 255, 255);
+    }
+}
+
 /*
  * Close a stream and free all its resources.
  *
@@ -454,8 +486,6 @@ static void virtio_snd_pcm_close(VirtIOSoundPCMStream *stream)
  */
 static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
 {
-    audsettings as;
-    virtio_snd_pcm_set_params *params;
     VirtIOSoundPCMStream *stream;
 
     stream = virtio_snd_pcm_get_stream(s, stream_id);
@@ -472,31 +502,7 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
         return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
     }
 
-    params = virtio_snd_pcm_get_params(s, stream_id);
-
-    virtio_snd_get_qemu_audsettings(&as, params);
-
-    stream->positions[0] = VIRTIO_SND_CHMAP_FL;
-    stream->positions[1] = VIRTIO_SND_CHMAP_FR;
-    stream->as = as;
-
-    if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
-        stream->voice.out = audio_be_open_out(s->audio_be,
-                                         stream->voice.out,
-                                         "virtio-sound.out",
-                                         stream,
-                                         virtio_snd_pcm_out_cb,
-                                         &as);
-        audio_be_set_volume_out_lr(s->audio_be, stream->voice.out, 0, 255, 255);
-    } else {
-        stream->voice.in = audio_be_open_in(s->audio_be,
-                                        stream->voice.in,
-                                        "virtio-sound.in",
-                                        stream,
-                                        virtio_snd_pcm_in_cb,
-                                        &as);
-        audio_be_set_volume_in_lr(s->audio_be, stream->voice.in, 0, 255, 255);
-    }
+    virtio_snd_pcm_open(stream);
 
     stream->state = VSND_PCMSTREAM_STATE_PREPARED;
 
-- 
2.47.3


