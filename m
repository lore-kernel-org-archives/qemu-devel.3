Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21ED4C3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 00:24:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVgk7-00049c-U9; Sun, 21 Jul 2024 20:17:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVgk6-00044g-L2
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:17:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVgk4-0005lj-Tg
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:17:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721607448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zREGtvMmaAWc2fUmFmGbArMdM6d/DlgtDgvgzTwqaes=;
 b=NkrJvr+zWpDePBJnoWnPCbBzrxT/5qEptLqK3hRCmH4+PU3yJoQDkrlkxZ1b3Gl2FNp3Rw
 Qy8uGoco14pn55lNshfkojpkZQMBLQBnbkHaW09mZSwd/9EFbr3rKIRQsAgq5vsh5iY48b
 mskTv/wtNy4Luu4wpdAPMniOCsshOjU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-uJShbmzxOB2RLQ6p_99-Tw-1; Sun, 21 Jul 2024 20:17:26 -0400
X-MC-Unique: uJShbmzxOB2RLQ6p_99-Tw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-42666ed2d5fso25930155e9.3
 for <qemu-devel@nongnu.org>; Sun, 21 Jul 2024 17:17:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721607445; x=1722212245;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zREGtvMmaAWc2fUmFmGbArMdM6d/DlgtDgvgzTwqaes=;
 b=oidGNEsuWkU7wfajMCoKAfuOJdRFwn8NPnX7yQ8LcWG6pd2TXEM+aX17YnWUk76NoD
 bnC32n6iaMmXokvBUYvZOhTL5D7EObDQws126mWo5VHQ7ZZCwCK7f//bLYKfe/SoVvOx
 0BaPphOuyPcL5Mb/MUzzVDYYaJBGcWwB9cie7GE0PtvsNw/uhUNMRw+bjly/rupDyjMp
 kbjhnkthvvzc6Tfi/1+lglOERFHphMgGKLcUXOzUXHgnQyCm5UzYVvibScvshVOws8A0
 KHD02zNmSUky+QWbwbLhpTyOiAvBBFcOX3lbvjKpsxEOyUYm0Xd/SYJJtrO3Z6MX8jfP
 lfSQ==
X-Gm-Message-State: AOJu0Yy6pmrTQ8F4XagefCVRv53etNeqodwprV70lyltUtm3faw37EOw
 x/D8pHBjzWieyB+Mw/1CR9rpt6Y+AeiZOS5PkPW1V0N39GSpLcX32VV8vBTTlLt7NSs/+edaiqC
 np7Bm48vFcQWKdzioD0pATN4SxDMUcP0jH/erR/KULnlon5Q+AQs3OSOEaJlH/NMTy7Vu4DzT+Y
 3ygL/sJT4pQEJcc86bEROhAxQ9FzDUqQ==
X-Received: by 2002:a05:600c:46c3:b0:426:5416:67d7 with SMTP id
 5b1f17b1804b1-427dc565861mr32833425e9.27.1721607445077; 
 Sun, 21 Jul 2024 17:17:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEX+7jt/cKkCQuWa6td34PAuX1JghZUy/71bqc+4lPplwNpiM5yyty1WbRkja1b74Z//mY+7A==
X-Received: by 2002:a05:600c:46c3:b0:426:5416:67d7 with SMTP id
 5b1f17b1804b1-427dc565861mr32833255e9.27.1721607444382; 
 Sun, 21 Jul 2024 17:17:24 -0700 (PDT)
Received: from redhat.com (mob-5-90-113-158.net.vodafone.it. [5.90.113.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a94c30sm134759845e9.47.2024.07.21.17.17.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jul 2024 17:17:23 -0700 (PDT)
Date: Sun, 21 Jul 2024 20:17:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Zheyu Ma <zheyuma97@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 16/63] virtio-snd: add max size bounds check in input cb
Message-ID: <98e77e3dd8dd6e7aa9a7dffa60f49c8c8a49d4e3.1721607331.git.mst@redhat.com>
References: <cover.1721607331.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1721607331.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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


