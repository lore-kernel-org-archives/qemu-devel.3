Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF0D6C67861
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 10:55:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rshDN-0006du-5g; Fri, 05 Apr 2024 06:54:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rshDK-0006cK-Fv
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 06:54:30 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rshDI-0000qT-Sn
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 06:54:30 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-56c404da0ebso3053164a12.0
 for <qemu-devel@nongnu.org>; Fri, 05 Apr 2024 03:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712314464; x=1712919264; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=TBrlIqTRebU7cBT6Kdo/fxzyBa52MWs6t9oNTe37Jk4=;
 b=esV98N/5NtpRvAplncNwTWF8jyeo6wHiBTPcKPcMylVeOvSx64sz8XPkgiVJ9ZCZaT
 nzFM3gN3yIcfQ32jujdSLKppymTpZApqgZDVpiGm4fI+Oa3RW7ZzkZzgkGWtr2LAa8aJ
 fttYHMYvVxuIeG/czGacLmwNrK1MsJeWKcD0Ay57nc+anyr/5aZjt0m0gWGeaGQxpDzs
 UjQlGxfqwxnskBtalOIxGJyJEAkVrkLBssk3COWYZe3tbzHwg0UaDIbTwEhYTVnxI85j
 LiAlwqBy5wWWzbsEhWp4iCJqE6aUJar8FOZNyoWO1jVcpkPw2DGrhSjSzfZIUGz8NJmF
 +01w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712314464; x=1712919264;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TBrlIqTRebU7cBT6Kdo/fxzyBa52MWs6t9oNTe37Jk4=;
 b=QwOa38cD75bYd7QexrJee0kzaqPVo6wO/z5o2PxhxuWkNBcitXo3UiPN80TdRRKYVk
 F+VtpAz+SRcKVH5p1TFNjoVuIrfSiDnQ7UJ2kC/soGUnm3J2CGaYUB+zlv795yKtOBnR
 uAzYuyVHq0Os2+CIFBsLoDuqHe1J/91bxkNtjH3dR/rE9n1buz/oZPtouTS+TUnU6yqS
 WHJjrFWHCF9Y6/tx55FYOCqvyxRqWCwu28zH7tFe5vToxqZDEXLGkYTUDsYAKyUQxOGj
 Zo6mo/kw+syBAOTlIccs7W7PI2MbmvnQw55TPGub83VDhe8vfEFGI0dfFpoQly1OupdI
 0cbg==
X-Gm-Message-State: AOJu0YxYB5EiOXQhftSKufpRX944mqzGl4s9CJ/ehYz5TyMe7kPX9O/L
 Jsgzb/F9WD+Dcg4f4z71B9VTpPXAG2Rs6i6UoOMAm9kAS7WOtayU878yM08LyYU=
X-Google-Smtp-Source: AGHT+IHljwDlpPoDzY1ZYbaCFOsC+XZJc5r6TWjF7+mkcWNsxv2QFAeQf+hS0eb/k2M8WcCiTNbrnw==
X-Received: by 2002:a50:9f83:0:b0:56e:3034:1d49 with SMTP id
 c3-20020a509f83000000b0056e30341d49mr1027319edf.0.1712314464242; 
 Fri, 05 Apr 2024 03:54:24 -0700 (PDT)
Received: from meli-email.org (adsl-197.37.6.0.tellas.gr. [37.6.0.197])
 by smtp.gmail.com with ESMTPSA id
 q22-20020a056402033600b0056c5d0c932bsm662947edw.53.2024.04.05.03.54.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Apr 2024 03:54:24 -0700 (PDT)
Date: Fri, 05 Apr 2024 13:52:46 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: kraxel@redhat.com, mst@redhat.com
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 Zheyu Ma <zheyuma97@gmail.com>
Subject: Re: [PATCH v2] virtio-snd: Enhance error handling for invalid
 transfers
User-Agent: meli 0.8.5-rc.3
References: <20240322110827.568412-1-zheyuma97@gmail.com>
In-Reply-To: <20240322110827.568412-1-zheyuma97@gmail.com>
Message-ID: <bgual.qrsgx92i9kxc@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x530.google.com
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

ping

On Fri, 22 Mar 2024 13:08, Zheyu Ma <zheyuma97@gmail.com> wrote:
>This patch improves error handling in virtio_snd_handle_tx_xfer()
>and virtio_snd_handle_rx_xfer() in the VirtIO sound driver. Previously,
>'goto' statements were used for error paths, leading to unnecessary
>processing and potential null pointer dereferences. Now, 'continue' is
>used to skip the rest of the current loop iteration for errors such as
>message size discrepancies or null streams, reducing crash risks.
>
>ASAN log illustrating the issue addressed:
>
>ERROR: AddressSanitizer: SEGV on unknown address 0x0000000000b4
>    #0 0x57cea39967b8 in qemu_mutex_lock_impl qemu/util/qemu-thread-posix.c:92:5
>    #1 0x57cea128c462 in qemu_mutex_lock qemu/include/qemu/thread.h:122:5
>    #2 0x57cea128d72f in qemu_lockable_lock qemu/include/qemu/lockable.h:95:5
>    #3 0x57cea128c294 in qemu_lockable_auto_lock qemu/include/qemu/lockable.h:105:5
>    #4 0x57cea1285eb2 in virtio_snd_handle_rx_xfer qemu/hw/audio/virtio-snd.c:1026:9
>    #5 0x57cea2caebbc in virtio_queue_notify_vq qemu/hw/virtio/virtio.c:2268:9
>    #6 0x57cea2cae412 in virtio_queue_host_notifier_read qemu/hw/virtio/virtio.c:3671:9
>    #7 0x57cea39822f1 in aio_dispatch_handler qemu/util/aio-posix.c:372:9
>    #8 0x57cea3979385 in aio_dispatch_handlers qemu/util/aio-posix.c:414:20
>    #9 0x57cea3978eb1 in aio_dispatch qemu/util/aio-posix.c:424:5
>    #10 0x57cea3a1eede in aio_ctx_dispatch qemu/util/async.c:360:5
>
>Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
>Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>---
>Changes in v2:
>    - Applied similar error handling logic to virtio_snd_handle_rx_xfer()
>for consistency.
>---
> hw/audio/virtio-snd.c | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>
>diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
>index e604d8f30c..30493f06a8 100644
>--- a/hw/audio/virtio-snd.c
>+++ b/hw/audio/virtio-snd.c
>@@ -913,13 +913,13 @@ static void virtio_snd_handle_tx_xfer(VirtIODevice *vdev, VirtQueue *vq)
>                             &hdr,
>                             sizeof(virtio_snd_pcm_xfer));
>         if (msg_sz != sizeof(virtio_snd_pcm_xfer)) {
>-            goto tx_err;
>+            continue;
>         }
>         stream_id = le32_to_cpu(hdr.stream_id);
> 
>         if (stream_id >= s->snd_conf.streams
>             || s->pcm->streams[stream_id] == NULL) {
>-            goto tx_err;
>+            continue;
>         }
> 
>         stream = s->pcm->streams[stream_id];
>@@ -995,13 +995,13 @@ static void virtio_snd_handle_rx_xfer(VirtIODevice *vdev, VirtQueue *vq)
>                             &hdr,
>                             sizeof(virtio_snd_pcm_xfer));
>         if (msg_sz != sizeof(virtio_snd_pcm_xfer)) {
>-            goto rx_err;
>+            continue;
>         }
>         stream_id = le32_to_cpu(hdr.stream_id);
> 
>         if (stream_id >= s->snd_conf.streams
>             || !s->pcm->streams[stream_id]) {
>-            goto rx_err;
>+            continue;
>         }
> 
>         stream = s->pcm->streams[stream_id];
>-- 
>2.34.1
>

