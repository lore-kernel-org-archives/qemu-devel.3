Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A555FC47DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 11:10:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnclo-00064l-OK; Fri, 22 Mar 2024 07:09:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zheyuma97@gmail.com>)
 id 1rncln-00064V-Ax; Fri, 22 Mar 2024 07:09:07 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zheyuma97@gmail.com>)
 id 1rncll-0008W3-Kl; Fri, 22 Mar 2024 07:09:07 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a44f2d894b7so255398066b.1; 
 Fri, 22 Mar 2024 04:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711105743; x=1711710543; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MmXgrfR0PwZLkf57JdAzUrgZNflsq2QJp6ex0Mo1jes=;
 b=mafesdhLPLdKrsYIXzFKd5UQjWGRwtGFZH2t+5BUU5CgmFXxQqfai9LpqfjDHvPKeq
 nmMUmz+IaaNA7o++zl+4nfCocTSGwl9x4md+FBFcPDlqbCY5MHb+ayxt+ggWuR2URaV7
 FS+lS8cihtwCaN8LBZeSjnS+rYxpv+/VBIWdzIuQC/LcfSrJPpnH31VHf10pcb2I0i+M
 QXdLs4pM5oUlhGDEvJAmmQIj53qbTDI4h2dH1PN7Y4e44kNaINHhfjlzT/AI4+fvGnPk
 TTTWiZSETBUNHbvXeSB28GfRl8UEW0ihkuEIsDWXM8VYnQmxuMuFTYPiTG99Y/9hnLfk
 683Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711105743; x=1711710543;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MmXgrfR0PwZLkf57JdAzUrgZNflsq2QJp6ex0Mo1jes=;
 b=SBxhczwdiCJ2UghYNFrILQjWMu6RdfeCYEbunc5Zj67HZRb/C6oI/lSgrlM8HK0UFW
 CHcrdoyS0POBq+CFv8jUG+hk+wRzeF3K4f+Guf2rJitz/iWjn35WYEMWt14MRgp60Z1T
 AX09+ASsx24qimMJCkJ4ILnNq+i0CqXCAxSwxmGGcNi4T5smLSkVFDCTUUbhQaIg2KjR
 z37cTKe6wlwKJfjiaGc/196qdOn8DZZPcGkyjLceF0LZbfRrYktRgGDNtmaHmOWbXlUX
 /YABkZ8YwoAQyqzZCZHfbzVb6qQoyv+MnPXOovwZQ5xESK8cU5vec3w5KqimVOt3mvg4
 +w1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSp5BGoEcCVbYIgyMT6wzBWPJopdWHbVUPRS1N1tpl71WuV7uI1+NVOR9XawQbik7A1l9QemGaU3cbuLn74h63IhK36qeO
X-Gm-Message-State: AOJu0Yxycl8ZwN+2xf/heUPuvTZJdqA1FjpgiEztAqbcfDCnchJt5R7f
 f16bKPN6xhnaazj7iNdXSuifAw7wsfmLgimfYla1FfJic5ObjIc=
X-Google-Smtp-Source: AGHT+IGbHFeSX2JWFekHGqYu/frrgVQ6uMfHFbnAulVBGGQYeo7TLsSPSjYZqBBczqZMxGpMCSHDaw==
X-Received: by 2002:a17:906:1917:b0:a44:dc35:df19 with SMTP id
 a23-20020a170906191700b00a44dc35df19mr1374510eje.67.1711105743139; 
 Fri, 22 Mar 2024 04:09:03 -0700 (PDT)
Received: from wing.epfl.ch (dhcp-122-dist-b-021.epfl.ch. [128.178.122.21])
 by smtp.gmail.com with ESMTPSA id
 bl4-20020a056402210400b0056bafdda14bsm909570edb.28.2024.03.22.04.09.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Mar 2024 04:09:02 -0700 (PDT)
From: Zheyu Ma <zheyuma97@gmail.com>
To: kraxel@redhat.com,
	manos.pitsidianakis@linaro.org,
	mst@redhat.com
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH v2] virtio-snd: Enhance error handling for invalid transfers
Date: Fri, 22 Mar 2024 12:08:27 +0100
Message-Id: <20240322110827.568412-1-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=zheyuma97@gmail.com; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This patch improves error handling in virtio_snd_handle_tx_xfer()
and virtio_snd_handle_rx_xfer() in the VirtIO sound driver. Previously,
'goto' statements were used for error paths, leading to unnecessary
processing and potential null pointer dereferences. Now, 'continue' is
used to skip the rest of the current loop iteration for errors such as
message size discrepancies or null streams, reducing crash risks.

ASAN log illustrating the issue addressed:

ERROR: AddressSanitizer: SEGV on unknown address 0x0000000000b4
    #0 0x57cea39967b8 in qemu_mutex_lock_impl qemu/util/qemu-thread-posix.c:92:5
    #1 0x57cea128c462 in qemu_mutex_lock qemu/include/qemu/thread.h:122:5
    #2 0x57cea128d72f in qemu_lockable_lock qemu/include/qemu/lockable.h:95:5
    #3 0x57cea128c294 in qemu_lockable_auto_lock qemu/include/qemu/lockable.h:105:5
    #4 0x57cea1285eb2 in virtio_snd_handle_rx_xfer qemu/hw/audio/virtio-snd.c:1026:9
    #5 0x57cea2caebbc in virtio_queue_notify_vq qemu/hw/virtio/virtio.c:2268:9
    #6 0x57cea2cae412 in virtio_queue_host_notifier_read qemu/hw/virtio/virtio.c:3671:9
    #7 0x57cea39822f1 in aio_dispatch_handler qemu/util/aio-posix.c:372:9
    #8 0x57cea3979385 in aio_dispatch_handlers qemu/util/aio-posix.c:414:20
    #9 0x57cea3978eb1 in aio_dispatch qemu/util/aio-posix.c:424:5
    #10 0x57cea3a1eede in aio_ctx_dispatch qemu/util/async.c:360:5

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
Changes in v2:
    - Applied similar error handling logic to virtio_snd_handle_rx_xfer()
for consistency.
---
 hw/audio/virtio-snd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index e604d8f30c..30493f06a8 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -913,13 +913,13 @@ static void virtio_snd_handle_tx_xfer(VirtIODevice *vdev, VirtQueue *vq)
                             &hdr,
                             sizeof(virtio_snd_pcm_xfer));
         if (msg_sz != sizeof(virtio_snd_pcm_xfer)) {
-            goto tx_err;
+            continue;
         }
         stream_id = le32_to_cpu(hdr.stream_id);
 
         if (stream_id >= s->snd_conf.streams
             || s->pcm->streams[stream_id] == NULL) {
-            goto tx_err;
+            continue;
         }
 
         stream = s->pcm->streams[stream_id];
@@ -995,13 +995,13 @@ static void virtio_snd_handle_rx_xfer(VirtIODevice *vdev, VirtQueue *vq)
                             &hdr,
                             sizeof(virtio_snd_pcm_xfer));
         if (msg_sz != sizeof(virtio_snd_pcm_xfer)) {
-            goto rx_err;
+            continue;
         }
         stream_id = le32_to_cpu(hdr.stream_id);
 
         if (stream_id >= s->snd_conf.streams
             || !s->pcm->streams[stream_id]) {
-            goto rx_err;
+            continue;
         }
 
         stream = s->pcm->streams[stream_id];
-- 
2.34.1


