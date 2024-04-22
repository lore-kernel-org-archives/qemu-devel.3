Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93CF3C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 12:53:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rytAJ-0001tU-Gk; Mon, 22 Apr 2024 08:52:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rytAC-0001gK-60
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 08:52:53 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rytAA-0006Rg-Jh
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 08:52:51 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a52582ecde4so397775366b.0
 for <qemu-devel@nongnu.org>; Mon, 22 Apr 2024 05:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713790368; x=1714395168; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c44BPLf1Z01NnuVhiMEI0qHANuUe6ukUP9XCsdX0lnk=;
 b=Qu01Zx1Y6xmnvTLH5mrX4ESSJEDVWpni7DDJgj8Ab2rNBKMA3XvAfQrZe0ClsLUJfW
 Mz6eIev7DKcZZB16qz6pfmQfRjaVKUboIXWe+EmrQwQVYVRV9qM82xowzUHTmxpcl92j
 aMW6yEcX9FHqGoj55zEUqCd+/TR30rfu6RhreCKHjpUpQ9bsuSlZcHnTwrTPKIZleM+a
 +ltGEGCzzxCy3078Aa5a0vZuM6HGHTrPCIfslThNhYGZUlKzs6iHYi/DK/5w1WR1g+UJ
 fF27ANMPZdJ68NlQsU9VpFqkMdEcuJjMzK4yQ3vTqzoI7EFEphOv5TVUvhX2N3wwUc0b
 +xDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713790368; x=1714395168;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c44BPLf1Z01NnuVhiMEI0qHANuUe6ukUP9XCsdX0lnk=;
 b=EaFtoU/mOTNlcpCp5vsYtH1WvuYo5Gogc1I/F3DpVy+fjunVN/7l9vEA0tcMDdpqMa
 jAiAG7Czjb6XWb/UMjQ6n5JR7wOPJMMLTFGzfUsgnOzVqQT7a5WNeOZkrOgpwCtd3UnI
 tsfEz1uibAPFyc6L+ssJih2jw2UdTFkH53ACuYf6TJg7h9osEBHQaINz/D/rWG0exzUK
 MDhFi5n6TO2KzybwRwp3Cryx+hw/82s889MZBSWvhiAhKxbUT+nKbke1U5BM0dkJsbrw
 CXkrrKoocF5AORwXTn00/drx8NTRtRucHXHh4cVGvEkJ1qFWwEGXE2unLXceC0Tew2lB
 S52w==
X-Gm-Message-State: AOJu0YwOcNVg7iwx6VB0lv407lmNHx/1jp/V/pvslWVQsC1KzOcecToF
 +uyWXPWSqfCC/q9151dXi9BW4x+jBc0L+Thzwbxh+IEGITXXrNZjn30l2Bp9gt0RJkS+a+uSn20
 6
X-Google-Smtp-Source: AGHT+IHmc571ZQcgoOY4LtDDjS88Bv5wTliE2gTONxVrPXOUIHum4ymmxpJkXlUnq+5Fu/DEybIk2w==
X-Received: by 2002:a17:906:5f89:b0:a55:5ba6:ace9 with SMTP id
 a9-20020a1709065f8900b00a555ba6ace9mr6214121eju.9.1713790368772; 
 Mon, 22 Apr 2024 05:52:48 -0700 (PDT)
Received: from localhost.localdomain (adsl-53.37.6.0.tellas.gr. [37.6.0.53])
 by smtp.gmail.com with ESMTPSA id
 l10-20020a1709066b8a00b00a55bfb4e3b6sm593574ejr.217.2024.04.22.05.52.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Apr 2024 05:52:48 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org,
	qemu-stable@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Zheyu Ma <zheyuma97@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v1 3/4] virtio-snd: factor card removal out of unrealize()
Date: Mon, 22 Apr 2024 15:52:13 +0300
Message-ID: <2231ee9229ba7259763c9814e6ec119d8954b81c.1713789200.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1713789200.git.manos.pitsidianakis@linaro.org>
References: <cover.1713789200.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Extract audio card removal logic out of the device unrealize callback so
that it can be re-used in follow up commits.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/audio/virtio-snd.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index 82dd320ebe..a9cfaea046 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -1343,15 +1343,11 @@ static inline void virtio_snd_pcm_flush(VirtIOSoundPCMStream *stream)
     }
 }
 
-static void virtio_snd_unrealize(DeviceState *dev)
+/* Remove audio card and cleanup streams. */
+static void virtio_snd_unsetup(VirtIOSound *vsnd)
 {
-    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
-    VirtIOSound *vsnd = VIRTIO_SND(dev);
     VirtIOSoundPCMStream *stream;
 
-    qemu_del_vm_change_state_handler(vsnd->vmstate);
-    trace_virtio_snd_unrealize(vsnd);
-
     if (vsnd->pcm) {
         if (vsnd->pcm->streams) {
             for (uint32_t i = 0; i < vsnd->snd_conf.streams; i++) {
@@ -1370,6 +1366,18 @@ static void virtio_snd_unrealize(DeviceState *dev)
         vsnd->pcm = NULL;
     }
     AUD_remove_card(&vsnd->card);
+}
+
+static void virtio_snd_unrealize(DeviceState *dev)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VirtIOSound *vsnd = VIRTIO_SND(dev);
+
+    qemu_del_vm_change_state_handler(vsnd->vmstate);
+    trace_virtio_snd_unrealize(vsnd);
+
+    virtio_snd_unsetup(vsnd);
+
     qemu_mutex_destroy(&vsnd->cmdq_mutex);
     virtio_delete_queue(vsnd->queues[VIRTIO_SND_VQ_CONTROL]);
     virtio_delete_queue(vsnd->queues[VIRTIO_SND_VQ_EVENT]);
-- 
γαῖα πυρί μιχθήτω


