Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C32C0C67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 07:33:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru5y1-0006ff-5N; Tue, 09 Apr 2024 03:32:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ru5xz-0006cH-My
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 03:32:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ru5xy-0001ck-5S
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 03:32:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712647945;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=13FuLCNcJSjRaX6g3RxQK/vpt27WSempKd9hfNRZ2Ts=;
 b=Z1EpSMBbn90XZoutDIuNdhbZOlaWTtXR0S9uXW2MS3BmVdVkiXU+bE90MRLwhNaxTboUnz
 dZSDQlmVMpDF8J3amPm3wdWaRCY3sG0NTfG+12EBj/Qj7swE1q9OvyZpsFrX9xNrXOjvzv
 sWqHxw6GaB5i+EIn9pM99IxL8Ome0/M=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-q_LInYb5PlGzlb8exSaRJQ-1; Tue, 09 Apr 2024 03:32:24 -0400
X-MC-Unique: q_LInYb5PlGzlb8exSaRJQ-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2d87f5937fcso19555781fa.0
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 00:32:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712647942; x=1713252742;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=13FuLCNcJSjRaX6g3RxQK/vpt27WSempKd9hfNRZ2Ts=;
 b=IpQJYaEKnL3C8GVNTdwcVqEaH0jloKWzHbvXcZ4CUJ9sAOTlIMJD+KnWT0eEZLgWqU
 W+a9VjsjG58rFnXnjCK0VlQCsqGeqbLGFdmYo59gj6VGphp7+TdVGOo5v6JcWQ50yzQ6
 bnOpyEArtHp5YCIGxsaLOydUTfFifR3WjLq8hZLUGyJb9q5majx4RFqtZwZ6q2NqxU3h
 1n5gXNqK1bcDRIj4BaJD/Ufx0xuvsqEjoqAhH11uvwmDxrGvpXgjyQwkaW8aaQH6E8bb
 CQ0wurf4tgG5XlNMI/P3pMyovl2Nv/7GwEo/q/v+4IbrF6LhmfM3wo51xoJmWo/Cu3YY
 Hk+A==
X-Gm-Message-State: AOJu0YzCKixmO/jrdhRFj8p0AF8S9g1/bmq5ljHEVqA8bK+Ns6OXjXKJ
 JADRKz1ANJcolALKHXGG20KCHc13bbNvv6o1j8EZ9YmqNqG1blqHip2l5b+/zGugRi2M0q4enDU
 9v7tJCNcDekbu5gTlFAFGdodRozCyC+iUdu0ZbzD4Uyv/eNzBgk4r1U2HuGd+PZJN4RHkB/nIta
 bsszwFcsmx55VTIvdrELbBZHgprCMI4Q==
X-Received: by 2002:ac2:4c01:0:b0:515:ad59:d46a with SMTP id
 t1-20020ac24c01000000b00515ad59d46amr9200573lfq.21.1712647942010; 
 Tue, 09 Apr 2024 00:32:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEStqoInFBKTBk/e8ilFKodfzI6qXC+C2bEC/lO9gzdrEOvV+1zYd2Otq7jZgW+x2V5HTzwBA==
X-Received: by 2002:ac2:4c01:0:b0:515:ad59:d46a with SMTP id
 t1-20020ac24c01000000b00515ad59d46amr9200541lfq.21.1712647941283; 
 Tue, 09 Apr 2024 00:32:21 -0700 (PDT)
Received: from redhat.com ([2.52.134.26]) by smtp.gmail.com with ESMTPSA id
 g3-20020a170906394300b00a4e40e48f8dsm5294629eje.185.2024.04.09.00.32.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Apr 2024 00:32:20 -0700 (PDT)
Date: Tue, 9 Apr 2024 03:32:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Zheyu Ma <zheyuma97@gmail.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 2/7] virtio-snd: Enhance error handling for invalid transfers
Message-ID: <a45f09935c88ae352a5ec120418a8b2b36ec1daa.1712647890.git.mst@redhat.com>
References: <cover.1712647890.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1712647890.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.494,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Zheyu Ma <zheyuma97@gmail.com>

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
Message-Id: <20240322110827.568412-1-zheyuma97@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
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
MST


