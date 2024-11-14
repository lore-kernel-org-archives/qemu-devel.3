Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8B06D68B02
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 12:55:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBZLl-0003ST-Ky; Thu, 14 Nov 2024 07:53:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tBZLj-0003SB-Rj
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 07:53:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tBZLi-0005Ts-AF
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 07:53:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731588805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+4yTvy80KY6bq2Hy/8wzgdIbcV2RnH4YcyMQ6f0g3Ts=;
 b=QCZs+RLo8aQOhdtMzReFajteRvrzTxUB1C35A0+sklb2+g8UndwGOkDhd+aEFz+KuXROqq
 U0K1yU7m5hFMZcWPZlJZaClAKVLcl3cOpi3aB54Qa1ZkOIsRNOGdMtjn3cpmBKJj0i9ca6
 8MEXIRb5eTFmGrT4/6DPw0qdl5hGIXs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-dd7_r216Ov29OSEGb52deA-1; Thu, 14 Nov 2024 07:53:24 -0500
X-MC-Unique: dd7_r216Ov29OSEGb52deA-1
X-Mimecast-MFC-AGG-ID: dd7_r216Ov29OSEGb52deA
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43159603c92so4365905e9.2
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 04:53:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731588802; x=1732193602;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+4yTvy80KY6bq2Hy/8wzgdIbcV2RnH4YcyMQ6f0g3Ts=;
 b=bc8HN6z3xJVdtUhQJ3Ubt2gC0xvpkFuHHBJpN/qGt1GkTdslYpE8TTUCEoBk8K2tVo
 1rleQBtorSFcODZMVwIA5i7APO0mughXpF3rODmHo6LGZ+N7rwAgFzaIUGZyp9hB5ady
 dWLc0Y5gii+XRbqWGrgmgbWtBa/IBv3KGs2G/i0BbEfGlcS+Blz0rlD3+lW1JN127E8p
 qoLa5bseu3HmSJuZsqdcIWMRh6wCPCOF3g7EATCC9q/yujEp+Ak9kYW7xH8wr4c35dof
 RfRg21NlTPNOsFDVrRYyA4yFz1mU82xUr5HVVrGAJ7oWMxGzBtBoRtbp5c8XLfUTIWc0
 PXiQ==
X-Gm-Message-State: AOJu0YyNAM8ZqaWdi03RvdIuftjOXWNjiNwfyQBQE6sm1qIjRbALZXCT
 dcF2WjqEG+9wXbRpFVrhBWVr7tE6VD1tBtU7WvjOCpbGyX4xjXfy7T6gdXEgeqIP/1H+FKmBah6
 qgidlmqakx8TMOUpecQFFEtA/6uTHJSX97671QBXxGbSZsEnn6Ip4SKNbSSHjywRR639YhSNM5r
 Bp6P7KIfH0l0qn7i+aisJA24XNoJXKPM1lscFM8pk=
X-Received: by 2002:a05:600c:40c4:b0:431:5f3b:6ae4 with SMTP id
 5b1f17b1804b1-432da79140dmr21241615e9.17.1731588802501; 
 Thu, 14 Nov 2024 04:53:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH0gOvK7eoSRWBPQVdCVvg9zGwumWDO6wen2xPVNiofPry/26oWGtRru72x1xuAujVYWxVmLQ==
X-Received: by 2002:a05:600c:40c4:b0:431:5f3b:6ae4 with SMTP id
 5b1f17b1804b1-432da79140dmr21241355e9.17.1731588802018; 
 Thu, 14 Nov 2024 04:53:22 -0800 (PST)
Received: from [192.168.10.3] ([151.49.84.243])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432dab78897sm19435305e9.16.2024.11.14.04.53.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 04:53:20 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-stable@nongnu.org
Subject: [PATCH 1/2] Revert "hw/audio/hda: fix memory leak on audio setup"
Date: Thu, 14 Nov 2024 13:53:17 +0100
Message-ID: <20241114125318.1707590-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241114125318.1707590-1-pbonzini@redhat.com>
References: <20241114125318.1707590-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.69,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This reverts commit 6d03242a7e47815ed56687ecd13f683d8da3f2fe,
which causes SPICE audio to break.  While arguably this is a SPICE bug,
it is possible to fix the leak in a less heavy-handed way.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2639
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/audio/hda-codec.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
index bc661504cf4..74c0292284e 100644
--- a/hw/audio/hda-codec.c
+++ b/hw/audio/hda-codec.c
@@ -472,24 +472,6 @@ static void hda_audio_set_amp(HDAAudioStream *st)
     }
 }
 
-static void hda_close_stream(HDAAudioState *a, HDAAudioStream *st)
-{
-    if (st->node == NULL) {
-        return;
-    }
-    if (a->use_timer) {
-        timer_free(st->buft);
-        st->buft = NULL;
-    }
-    if (st->output) {
-        AUD_close_out(&a->card, st->voice.out);
-        st->voice.out = NULL;
-    } else {
-        AUD_close_in(&a->card, st->voice.in);
-        st->voice.in = NULL;
-    }
-}
-
 static void hda_audio_setup(HDAAudioStream *st)
 {
     bool use_timer = st->state->use_timer;
@@ -502,7 +484,6 @@ static void hda_audio_setup(HDAAudioStream *st)
     trace_hda_audio_format(st->node->name, st->as.nchannels,
                            fmt2name[st->as.fmt], st->as.freq);
 
-    hda_close_stream(st->state, st);
     if (st->output) {
         if (use_timer) {
             cb = hda_audio_output_cb;
@@ -760,11 +741,23 @@ static void hda_audio_init(HDACodecDevice *hda,
 static void hda_audio_exit(HDACodecDevice *hda)
 {
     HDAAudioState *a = HDA_AUDIO(hda);
+    HDAAudioStream *st;
     int i;
 
     dprint(a, 1, "%s\n", __func__);
     for (i = 0; i < ARRAY_SIZE(a->st); i++) {
-        hda_close_stream(a, a->st + i);
+        st = a->st + i;
+        if (st->node == NULL) {
+            continue;
+        }
+        if (a->use_timer) {
+            timer_free(st->buft);
+        }
+        if (st->output) {
+            AUD_close_out(&a->card, st->voice.out);
+        } else {
+            AUD_close_in(&a->card, st->voice.in);
+        }
     }
     AUD_remove_card(&a->card);
 }
-- 
2.47.0


