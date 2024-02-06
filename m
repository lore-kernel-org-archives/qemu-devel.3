Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4522DC4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 07:28:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXFry-0007Jw-Bs; Tue, 06 Feb 2024 02:27:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rXFrv-0007JC-2u
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 02:27:47 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rXFro-0007gp-Eo
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 02:27:46 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a26ed1e05c7so726967066b.2
 for <qemu-devel@nongnu.org>; Mon, 05 Feb 2024 23:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707204457; x=1707809257; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=sZGjv6520p6xOKilSULwx8n/6DaCrkA7yqkUD/ca9mY=;
 b=XnsiBJav5akMB6u9C6u+j2RcUshtr8pFam/N/D2qfzHlSswG0XTX/gJB3xOcghHPRp
 tVkcYrmKPLfidMhs4vJZX+EuLO3kAZcRgRXYyPMqE8k2tW2dc82h29foGG5Gj6WCt6Oa
 W32D1vZ6aMcCMOy2lV6POFGMH64dLir38BvoOzJPJ3JcYFRigTgdjG6X9mzglKh/UgwI
 ippMrzlQgjchWw0oiYh/YI4QG/Ex8gbu0Q3m6LdjRCLjlYYJ9Ftyd09hlgKdL9Q0RpzY
 mlD89Gt/RFm3ERq2QTt7oKyWTMMYYdBta7VaLcCLNyoV4R4r6LnQTmzHG/km07ik2WGZ
 Xz/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707204457; x=1707809257;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sZGjv6520p6xOKilSULwx8n/6DaCrkA7yqkUD/ca9mY=;
 b=rMWaBk74DPBFdS/92EudBzzip4JOxjvpk+VPzhdlSE4P2mgK2VCWa7fxhsnMEH55IY
 x9sIoHk1SBqt9zH1ZPvPm8X2cluP35I1wgOMLwwdeCvkM9BJHz8m4/nyZvEx810cFuk9
 XEHoMrsuYS1tmJ+w2/GBfM3ct8kOgPy1AmwK2EjVERUzkJkbz1aPqzrfRd/CNJQh2h7x
 SMtydSG5Dsugw5HbS2/cDrxeWhf5Sp3u7YUdkv6abBR+/ymTAnDh1eKqTt81ra7biS4i
 zrbCXpV0apNlgF9dt523rFZyc4DmOd7TKaG8S5aFzF1q7QVfluA+U8N40fjk/v4T7y87
 6LhQ==
X-Gm-Message-State: AOJu0YyIjHZ3qfduMo0N2k/awImXPf5WqaZKOn8j8ME8wSAc3Gii9bmc
 GriR0P3mm6qVOBjLOISSVKnXi2OY/rXvX3gdDWF4LpkVUuEfh4HTe0X74JZaTgRefSOQzj89UMr
 V
X-Google-Smtp-Source: AGHT+IFmnyv1MVi+2S9vSv91EPCbU0NDbZQ6Xfb1QS5f3Ctix2n28TW/GsnWwc5reKw6zcE3yQAJ5w==
X-Received: by 2002:a17:906:dd0:b0:a37:f77f:3d6c with SMTP id
 p16-20020a1709060dd000b00a37f77f3d6cmr1164710eji.25.1707204457156; 
 Mon, 05 Feb 2024 23:27:37 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXUliJ5Jy6QCRx3PMAclQgoH+6gx/Wh4O+XPwrxMpwxqMDENuz5m1AnFYqCwKx+PrHv//Pa059CcEyAwfET4I/JnhiqfkXAlRipXJbd5vDUqu8gWkfNsH4dGE9poENqRHAsUAh73Kwu9v4C7vRuHxHK2/CTcQBm7xR+IkRYCGCanv0mra9L79oS+U/AfwWFn2wtCybjH1BmfPR8XH5h66XWY3YMgUMt
Received: from meli.delivery (adsl-125.37.6.3.tellas.gr. [37.6.3.125])
 by smtp.gmail.com with ESMTPSA id
 hu17-20020a170907a09100b00a360239f006sm784375ejc.37.2024.02.05.23.27.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Feb 2024 23:27:36 -0800 (PST)
Date: Tue, 06 Feb 2024 09:23:08 +0200
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-block@nongnu.org
Subject: Re: [PATCH 2/5] virtio-blk: clarify that there is at least 1 virtqueue
User-Agent: meli 0.8.5-rc.3
References: <20240205172659.476970-1-stefanha@redhat.com>
 <20240205172659.476970-3-stefanha@redhat.com>
In-Reply-To: <20240205172659.476970-3-stefanha@redhat.com>
Message-ID: <8fbdy.hdn7svf206al@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x633.google.com
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
>It is not possible to instantiate a virtio-blk device with 0 virtqueues.
>The following check is located in ->realize():
>
>  if (!conf->num_queues) {
>      error_setg(errp, "num-queues property must be larger than 0");
>      return;
>  }
>
>Later on we access s->vq_aio_context[0] under the assumption that there
>is as least one virtqueue. Hanna Czenczek <hreitz@redhat.com> noted that
>it would help to show that the array index is already valid.
>
>Add an assertion to document that s->vq_aio_context[0] is always
>safe...and catch future code changes that break this assumption.
>
>Suggested-by: Hanna Czenczek <hreitz@redhat.com>
>Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>---
> hw/block/virtio-blk.c | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
>index e8b37fd5f4..a0735a9bca 100644
>--- a/hw/block/virtio-blk.c
>+++ b/hw/block/virtio-blk.c
>@@ -1825,6 +1825,7 @@ static int virtio_blk_start_ioeventfd(VirtIODevice *vdev)
>      * Try to change the AioContext so that block jobs and other operations can
>      * co-locate their activity in the same AioContext. If it fails, nevermind.
>      */
>+    assert(nvqs > 0); /* enforced during ->realize() */
>     r = blk_set_aio_context(s->conf.conf.blk, s->vq_aio_context[0],
>                             &local_err);
>     if (r < 0) {
>-- 
>2.43.0
>

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

