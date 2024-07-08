Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C763C3DA42
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 07:10:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQiVm-0000zw-UL; Mon, 08 Jul 2024 03:10:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sQiVd-0000oq-R3
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 03:10:02 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sQiVb-0004ct-Pe
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 03:10:01 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-425809eef0eso24447675e9.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 00:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720422597; x=1721027397; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IdN9K/DtfMtQJGnCm5i+M1SvDXSAATG9d84fTUAOElM=;
 b=sOeUbQHppfut5sVWZLH38kJVSzAOIUtJ8G1GW1lRSOVfatgasyXl1/YZzGccFQOUKs
 s4oj62tzCU/tVtDtD3+ZW1Wfj8PRV8dW44yxh0npVZb2iE6vmFUk2fclT9YorXhb9pzT
 JdlbvvRw03baZGATDGAzr8Dy29dnOMaU2lGWDDHq0VROJdOnaQcGoV3ECA10mb5BkE+C
 pew/p902AZ7wFYqGneL1C0biktXCbcHC29s+tINn9IqVf+rh/CP45pBcIlM6Wc2B4vBG
 vBLL9nmBLm/b696OxcDKwPZRDt/x5V129tcUdvuGWwK46xrV8cRH3nlg7/S/BxLmgTp+
 d3Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720422597; x=1721027397;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IdN9K/DtfMtQJGnCm5i+M1SvDXSAATG9d84fTUAOElM=;
 b=JynuDrJSGLiH/joSPRGBJJzgmQOXBBExurHLHy7ge0LarT5XdlI6dXwXclIYBChT9U
 +cMi7LOYgq1r1z37ucVDVzB8rgKY0hHNYXlCvBPsSnzlvx5o9Shv9y0G74AJ9HCdBh9e
 9HWJbomGWB8JKqcP+1VDdLml48t22cu9JRUONA+IGFISJj9oU3pEhRiMZdwWxAfODSAu
 wlkmFai+3X07EywB+huAvTbc39OAZ6nadE5yMDVYwKlkMZ0OzA11DCx+AVWYBgpbvUyT
 T/Yux24HArdBUK4pTjBUFBeaVDfMsiA8gVvTV3sMYo2CPeNrNkQnp+uYQ1xxSbQz15dz
 msvQ==
X-Gm-Message-State: AOJu0YzJsTVaURu4gPoMOE8xP7i8vFeJR+1iRH4g+iPSg/UgDQEduBLa
 e9p5VxmG30nOKR8wt6UXSDuuuI004SF4eFc6FsLld79YNLyb9d07m2mvbAmUMidfUxfmaFUjn/9
 bFDc=
X-Google-Smtp-Source: AGHT+IHKas5Ffzy6UMFXmv6WhukUK3L0ZUfhvdojrNHUVwG5o+q4RcMOjSxZSokkGkzyzgcnLsgsIg==
X-Received: by 2002:a05:600c:3005:b0:426:602d:a243 with SMTP id
 5b1f17b1804b1-426602da3f1mr34182055e9.16.1720422597204; 
 Mon, 08 Jul 2024 00:09:57 -0700 (PDT)
Received: from localhost.localdomain (adsl-147.37.6.160.tellas.gr.
 [37.6.160.147]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4266cc7af06sm9571535e9.27.2024.07.08.00.09.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jul 2024 00:09:56 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zheyu Ma <zheyuma97@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v1 1/1] virtio-snd: add max size bounds check in input cb
Date: Mon,  8 Jul 2024 10:09:49 +0300
Message-ID: <virtio-snd-fuzz-2427-fix-v1-manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x334.google.com
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

base-commit: b9ee1387e0cf0fba5a73a610d31cb9cead457dc0
-- 
γαῖα πυρί μιχθήτω


