Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62BB6C4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 07:23:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXFnS-0003Io-Cc; Tue, 06 Feb 2024 02:23:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rXFnF-00030g-Tw
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 02:22:58 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rXFnE-0006yM-Ez
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 02:22:57 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-55a5e7fa471so6722656a12.1
 for <qemu-devel@nongnu.org>; Mon, 05 Feb 2024 23:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707204173; x=1707808973; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=DF5EPuaq6xivmvUQkDeVu/7GgnWWxGPZlyA4mhP6s1Q=;
 b=JrGPncbeWiSOKlYnBDXcdKvKvcDlfzn+axjQf5/GpgiUrVNAk5KkjUO8F+7xCmUhOE
 00dgNG76yh8D5sksj7jNwVSaVYNxpvHtXpP+ZeIfCfbjZxJFkVHWOQwsTgUgQfEi6AYo
 ANnUABY69awrYtSG4isvXlrr+UV4QLfY4KaCjfydDX2zr4OMFxfwbh/yfiq2jsJehfma
 sOutqoaFNnx6hrV/dK4V2Oq1Td/3keANrDoUV4vygm4ssfnjMi4SsHHrOwMmA4WkhHH3
 Baf7ntzDLFy7PPD/bmqzfhjSgUHRtfIBF62erzEz4oQ3C8WsizSEh/66ShKfHxI8t3ML
 fWjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707204173; x=1707808973;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DF5EPuaq6xivmvUQkDeVu/7GgnWWxGPZlyA4mhP6s1Q=;
 b=t0j6G+MHcgb42A3gaox/jsPFSrXIWXdIin+Zrrb0ibfg0epCK1hT7jl+uhcTHaVz+z
 0GepsRvsvkXTAcXGSrBax1qs4hgll2QAIebv9ZkZdhdOssQoHgSebup2YzlIRzI+Ohzz
 RNXWpsRucAkFAXSyXMEm2FEogHcJnFOpzewNpXNta5LTdX5S/+b7sWN/wLxVj0N41kzv
 mWDkBkGkmvrzfn5SmLSMViGno2ZQa6Rui+SYdLw0ltMwU4L/3JlgZp3cBm9/o5I7jnny
 XiEyUGytqWj7l9tz/TFd1cDKxgBBt2C1yEm6gOs6KL6jtXD0wqHQyRhC1sJ4a17kh2tD
 r55Q==
X-Gm-Message-State: AOJu0Yz7C9kriMNVqRHre5QR8Kc9k24sAE5EN+8lSZGrLYPRCWrCq+5u
 FOV3Y+Cj6M+igf8C9KfNo+0QjFWzk0xuj93n5EcA14pCpmsKgCL4b2hOO0AH0XPkgxi8fmM0V2F
 P
X-Google-Smtp-Source: AGHT+IG+0MH6TJhwvFrMvgTnvbvnUrEHcTTDSfs6tbguqt3IPMAUG+LkwF6Xm4Pur4E5txLN3PHtmw==
X-Received: by 2002:aa7:d654:0:b0:55e:f52d:1825 with SMTP id
 v20-20020aa7d654000000b0055ef52d1825mr993578edr.35.1707204173492; 
 Mon, 05 Feb 2024 23:22:53 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCWN1bCyrraDQwnHw5dyVwM9TFkvrwQ5esYwuJuYay7Hl96rOAVoN6j6+TjfHoVgkleLt2sTF57qmQn6XJpoLXd9CG51xCecbs0ywT+/5UfytVYm3AisumU8/3YUPELjMMXJDS5SyFk3yoggOOW7Zq1rvYKWhqqZJLT6zIKu4CqGXVEDg/xY9A5GnLA5Xes/mWGhJSS3ggz/yc37U4NhRV9VWhqLG4zj
Received: from meli.delivery (adsl-245.37.6.163.tellas.gr. [37.6.163.245])
 by smtp.gmail.com with ESMTPSA id
 c3-20020a0564021f8300b0055fef53460bsm752661edc.0.2024.02.05.23.22.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Feb 2024 23:22:53 -0800 (PST)
Date: Tue, 06 Feb 2024 09:20:08 +0200
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-block@nongnu.org
Subject: Re: [PATCH 3/5] virtio-blk: add vq_rq[] bounds check in
 virtio_blk_dma_restart_cb()
User-Agent: meli 0.8.5-rc.3
References: <20240205172659.476970-1-stefanha@redhat.com>
 <20240205172659.476970-4-stefanha@redhat.com>
In-Reply-To: <20240205172659.476970-4-stefanha@redhat.com>
Message-ID: <8fb60.m9gtpx2hueq@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, 05 Feb 2024 19:26, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>Hanna Czenczek <hreitz@redhat.com> noted that the array index in
>virtio_blk_dma_restart_cb() is not bounds-checked:
>
>  g_autofree VirtIOBlockReq **vq_rq = g_new0(VirtIOBlockReq *, num_queues);
>  ...
>  while (rq) {
>      VirtIOBlockReq *next = rq->next;
>      uint16_t idx = virtio_get_queue_index(rq->vq);
>
>      rq->next = vq_rq[idx];
>                 ^^^^^^^^^^
>
>The code is correct because both rq->vq and vq_rq[] depend on
>num_queues, but this is indirect and not 100% obvious. Add an assertion.

This sentence could be useful as an inline comment too.

>
>Suggested-by: Hanna Czenczek <hreitz@redhat.com>
>Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>---
> hw/block/virtio-blk.c | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
>index a0735a9bca..f3193f4b75 100644
>--- a/hw/block/virtio-blk.c
>+++ b/hw/block/virtio-blk.c
>@@ -1209,6 +1209,7 @@ static void virtio_blk_dma_restart_cb(void *opaque, bool running,
>         VirtIOBlockReq *next = rq->next;
>         uint16_t idx = virtio_get_queue_index(rq->vq);
> 
>+        assert(idx < num_queues);
>         rq->next = vq_rq[idx];
>         vq_rq[idx] = rq;
>         rq = next;
>-- 
>2.43.0
>

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

