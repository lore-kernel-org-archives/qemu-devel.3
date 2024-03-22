Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D0E4C47DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 09:35:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnbIO-0000DF-88; Fri, 22 Mar 2024 05:34:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rnbIM-0000CV-8d
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 05:34:38 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rnbIK-00087r-B7
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 05:34:37 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-565c6cf4819so5005503a12.1
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 02:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711100072; x=1711704872; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=848hfDMfHSWYM8SNdG3tbhtU2pCVUaSart0G0SSujnU=;
 b=RXFAemRd11Y825O+szmT4PA0TVAsnDRzB1fp35fD0ZsCK3XxU1VBBsnYokWZUdzZKq
 RtH83VAcXlhyuYrjMoCuwq+T47VPwVngm+4ToBlgshPqbLR1j/fxFfI2PSZ7wEQskhsb
 bRqDxYFQdHXqw0KTPImo2JqdmAhA6r8gEIhX6cU/TN3HhfV+iFc9/RIlMRurkZJpirmd
 d+G/+NYOdd5kBQxyvp56O6wgZcfyJpV2itUVRb03booNBnuzogjmZq44Tt6nF7wg/DBm
 thwPOQCxn+a2DuTnQ02g6CkyCq8d0z0QJgVJ3dgVsz8cazznEvzAr3/QdfENuxnbi8Rn
 l3KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711100072; x=1711704872;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=848hfDMfHSWYM8SNdG3tbhtU2pCVUaSart0G0SSujnU=;
 b=wHuLkuOjyqQkI9k6i1LTYWmFMtVbkI61OaKyLYT9uE8vDUNxMM3Gwqb97jxiNqMb5k
 5NkriFG/hmwKAaAyhpBzsCNhSpMxnlGpU5ymhTI4O8qrlUZeX2HtEWlk1+4y7H8fGUmU
 OoyTQEK8XzEdhMg8muq+rlw9CpKCFRyCAh3iOs2fn2JN/gnVeITne5SlDw9WJ7tAvnNZ
 EHWewstd4y7L/R+J+ifIqqdeexEQGy8A/pLIapecexjQaQg/+fc4VqSAVAisvFo2XqEY
 kpHW/F4Hp+xm0dFki5y8/NuW1Q+iBu+e9TldhpLI6viB1MbhkozXS2XqmBJkx68c3Fj7
 2yoA==
X-Gm-Message-State: AOJu0Yyptgr3WS1Zv4nO1+xCQSZMzyEXT/8o6pf/ovo+wurEQ0RYOHUt
 qJ5VCL4cCM1eLAB/MyKSFmgXjWma+TFgcrXiMJi6Q5Z5FZ7605qFNll6m7jdcgI=
X-Google-Smtp-Source: AGHT+IH/x6VQhwEZsm6gbBqlwFepg/w0s6iVrziCDNqseUb4DYgBD12AdGA/GBXxemRrHwgyT8m8IQ==
X-Received: by 2002:a17:907:7da7:b0:a47:3076:b572 with SMTP id
 oz39-20020a1709077da700b00a473076b572mr1081510ejc.18.1711100072119; 
 Fri, 22 Mar 2024 02:34:32 -0700 (PDT)
Received: from meli-email.org (adsl-53.37.6.2.tellas.gr. [37.6.2.53])
 by smtp.gmail.com with ESMTPSA id
 v23-20020a170906381700b00a46a9425fe5sm814999ejc.212.2024.03.22.02.34.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Mar 2024 02:34:31 -0700 (PDT)
Date: Fri, 22 Mar 2024 11:23:32 +0200
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Zheyu Ma <zheyuma97@gmail.com>, mst@redhat.com, kraxel@redhat.com
Cc: qemu-devel@nongnu.org, Zheyu Ma <zheyuma97@gmail.com>,
 qemu-stable@nongnu.org
Subject: Re: [PATCH] virtio-snd: Skip invalid message sizes and null streams
User-Agent: meli 0.8.5-rc.3
References: <20240321214259.518560-1-zheyuma97@gmail.com>
In-Reply-To: <20240321214259.518560-1-zheyuma97@gmail.com>
Message-ID: <aqt9h.5se3l02z75nv@linaro.org>
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

Hello Ma,

On Thu, 21 Mar 2024 23:42, Zheyu Ma <zheyuma97@gmail.com> wrote:
>This update changes how virtio_snd_handle_tx_xfer handles message size
>discrepancies and null streams. Instead of using error handling paths
>which led to unnecessary processing and potential null pointer dereferences,
>the function now continues to the next loop iteration.
>
>ASAN log illustrating the issue addressed:
>
>ERROR: AddressSanitizer: SEGV on unknown address 0x0000000000b4 (pc 0x57cea39967b8 bp 0x7ffce84d51b0 sp 0x7ffce84d5160 T0)
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
>---
> hw/audio/virtio-snd.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
>index e604d8f30c..d9e9f980f7 100644
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
>-- 
>2.34.1
>

While the bug is valid I think the fix is insufficient, but not because 
it is wrong. The invalid elements are leaked and the guest never gets a 
BAD_MSG response. The problem is in the error handling logic; I think 
the invalid queue should be moved to the device struct since it's not 
stream specific.

Cc'ing qemu-stable because this bug is present in current versions.

Please make the same changes to virtio_snd_handle_rx_xfer() as well and 
send a v2, cc'ing qemu-stable. With those changes you can add:

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

I will prepare a patch fixing the invalid element handling logic for 
when this fix is accepted.

Thanks,
Manos

