Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C56A7C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 10:58:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWDCO-0004tG-Nz; Tue, 23 Jul 2024 06:56:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDCJ-0004Ki-99
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:56:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDCH-0001kH-BJ
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:56:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721732204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zREGtvMmaAWc2fUmFmGbArMdM6d/DlgtDgvgzTwqaes=;
 b=ew+8NrDRlBjXidqWohQvNRrzbxcDmLes9Hq4DFgMTMbrNmx6ZZWh1L+qVoihYTYk+5ZA9W
 7psABuKMZZOO9CkDzASsNL6/Ogt0BaE5j9MJFtj1LMZ3cl4ECVK/MS5h+bVHYXTlkrEL8O
 yxA3DEQPNFZ/DyOJMMQprM30L95/01o=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-aDQvbWMrMYW28nFPRlKDGA-1; Tue, 23 Jul 2024 06:56:43 -0400
X-MC-Unique: aDQvbWMrMYW28nFPRlKDGA-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2ef2018bb2dso26349621fa.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 03:56:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721732201; x=1722337001;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zREGtvMmaAWc2fUmFmGbArMdM6d/DlgtDgvgzTwqaes=;
 b=qGveR6qTQ1nUswJh8BlzjvgKZy1sZF6T799WosWZensOMpGHTKgi/7Vrdko9+lWY+w
 18+rGkdEVhT4D7KNKdsS5BA97DrVfKDwL5jYZr+QX+3gTVqV8o6Iw0yaB+AUk/veRgBX
 ao7449TVje0LFKrOqXlKxd0Rl/JUIkh3XwfefcbNnwSfxFMdOy8/MlJSchrO0i2h3GmN
 jIaWlwluARtIsTBkDoFHSe5I0HM0NoHDT5vK+QB1dj49H0R76otTIbV0lC8ZWvCr101/
 Mf2zngg4LUMCSuX9OtBQ0FG27m6maC1ON/95SmbfP4sJ8qrdWvhqORkqxufZ3WujQGCE
 jU1A==
X-Gm-Message-State: AOJu0YwnE6wv3UUJ7niSUZlhex7+8O1xLUNKIHyOWfv1YVhEEs4fKL6g
 xeIgUMIHnpACchlt8WneVdw1UgwFm56KYhD5CdeA7T8vNdcZ3LTDhq2fz/nlSPP1xPoXk31vKZB
 5795E570S95IdqAg4MPOZCzGqVUjLv27EZuUEIKTonsM/svNy/XzwzJpbBWue5/dA6lOojJpZ9A
 XxVlsiTXv3YV+u+Xg81Ff0kS6MCqabsA==
X-Received: by 2002:a2e:b554:0:b0:2ef:2dfd:15dc with SMTP id
 38308e7fff4ca-2f01ea4b5f7mr17443541fa.9.1721732201291; 
 Tue, 23 Jul 2024 03:56:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5HdpyqHIKsj0FNrdF5wVYLLwxlqzQkGqXzwbx3/cb8qu/uj4paqtIC0zuSfQoowfZM50yKw==
X-Received: by 2002:a2e:b554:0:b0:2ef:2dfd:15dc with SMTP id
 38308e7fff4ca-2f01ea4b5f7mr17443251fa.9.1721732200568; 
 Tue, 23 Jul 2024 03:56:40 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:440:9c9a:ffee:509d:1766:aa7f])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5a30a4d6c17sm7384250a12.5.2024.07.23.03.56.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 03:56:40 -0700 (PDT)
Date: Tue, 23 Jul 2024 06:56:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Zheyu Ma <zheyuma97@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL v2 16/61] virtio-snd: add max size bounds check in input cb
Message-ID: <98e77e3dd8dd6e7aa9a7dffa60f49c8c8a49d4e3.1721731723.git.mst@redhat.com>
References: <cover.1721731723.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1721731723.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

When reading input audio in the virtio-snd input callback,
virtio_snd_pcm_in_cb(), we do not check whether the iov can actually fit
the data buffer. This is because we use the buffer->size field as a
total-so-far accumulator instead of byte-size-left like in TX buffers.

This triggers an out of bounds write if the size of the virtio queue
element is equal to virtio_snd_pcm_status, which makes the available
space for audio data zero. This commit adds a check for reaching the
maximum buffer size before attempting any writes.

Reported-by: Zheyu Ma <zheyuma97@gmail.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2427
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-Id: <virtio-snd-fuzz-2427-fix-v1-manos.pitsidianakis@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/audio/virtio-snd.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index 5993f4f040..e6432ac959 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -1261,7 +1261,7 @@ static void virtio_snd_pcm_in_cb(void *data, int available)
 {
     VirtIOSoundPCMStream *stream = data;
     VirtIOSoundPCMBuffer *buffer;
-    size_t size;
+    size_t size, max_size;
 
     WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
         while (!QSIMPLEQ_EMPTY(&stream->queue)) {
@@ -1275,7 +1275,12 @@ static void virtio_snd_pcm_in_cb(void *data, int available)
                 continue;
             }
 
+            max_size = iov_size(buffer->elem->in_sg, buffer->elem->in_num);
             for (;;) {
+                if (buffer->size >= max_size) {
+                    return_rx_buffer(stream, buffer);
+                    break;
+                }
                 size = AUD_read(stream->voice.in,
                         buffer->data + buffer->size,
                         MIN(available, (stream->params.period_bytes -
-- 
MST


