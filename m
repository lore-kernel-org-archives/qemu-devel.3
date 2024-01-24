Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70A8EC46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 09:17:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSZNK-0002vW-T5; Wed, 24 Jan 2024 04:16:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rSZNF-0002qP-AE
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 04:16:47 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rSZND-0001aO-RP
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 04:16:45 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a3109a489d9so40099166b.3
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 01:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706087801; x=1706692601; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Umezlf82cNEXBsnuAmwJCiCK+rbSn5pyORAh9dMUNJU=;
 b=ovXEdq7EfUoeWHJc58dEs7ayX3ew3Rw3VS9UTYEP9Kw6nJPzp2MGtVyhna/LXTt/oF
 W/G/nlMuECr2qVmhE3yZDJ9QR6qTjYB5o7t3h3WSSB6lDXwtD+mDHXmxndTI3zPyyc0x
 wvXmYBIV7oQp20Px+Fe+rVpzVHVLhTfIA5CTijn2HfLd0Hwlo6zYj0uwuffvOX5BC8c9
 vYAvyZGaQDiXMrvUJ/AkXRM7pukLwvPHODCv88x/Zodhe4+yP7ZjRfERksOuRj6nhTP9
 U+ekQRKoe5BLnWD4Fa1w5P4zCAFtJfeztrfKZnWQ6WBbFy6xyR5EMQ0Mz8X1MVeaJ5gk
 D3nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706087801; x=1706692601;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Umezlf82cNEXBsnuAmwJCiCK+rbSn5pyORAh9dMUNJU=;
 b=W31whGDthqad4KLqQLfEdf6HA3btjCRBrwX3keIpnFQGHhdGLuDQhczQfk2f5hRBRs
 PnzyNkGHnFXgXiLb14LcmQny3D87Cuz5TD272JEtDRDoVat6S/pY9P6/zmkaO9Uo+ZO4
 9KgPFeZxs26v/7AxafXVLCekeubjGXcmUEMdN2E/Tuv4sL1KlUgMTS2CBF5L0t6hWUwW
 2s5a1EnyO9w8v/4UIYSeRBhpeIH6Xk6y8HUvQqTc2B/iZDhCEtWW4YFSBCpQ4uDnDw7J
 9GvpeHneVmDxOALQSEsOotmTFcYG9yVJVN2mFgd8+ckvpm1gEstIJQPpRr3FOuf14Ck/
 oHWA==
X-Gm-Message-State: AOJu0YwWEN7Kpwc2NPktW/1nX1Ny+2vw/b1mu09fatNyPn2GeX4wQKc1
 463A9UGGeuqY9C0Y3iPBB5jQwoeCC3xzOKkxvj47kmWhDx5L0p9ZhnPM7UBp7E+uo9QXc49st00
 penA=
X-Google-Smtp-Source: AGHT+IHFbX/gqrdhwgsvxpJdZt6WWh0Bx3V0Rt7c8JwbBX/5xHVf77BhFNvczUcRgOAp/3rr5veDQQ==
X-Received: by 2002:a17:906:b817:b0:a2f:d7b2:ec89 with SMTP id
 dv23-20020a170906b81700b00a2fd7b2ec89mr748160ejb.18.1706087801623; 
 Wed, 24 Jan 2024 01:16:41 -0800 (PST)
Received: from meli.delivery (adsl-114.109.242.225.tellas.gr.
 [109.242.225.114]) by smtp.gmail.com with ESMTPSA id
 k6-20020a170906128600b00a2b0b0fc80esm15143513ejb.193.2024.01.24.01.16.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jan 2024 01:16:41 -0800 (PST)
Date: Wed, 24 Jan 2024 11:15:44 +0200
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Fam Zheng <fam@euphon.net>,
 Greg Kurz <groug@kaod.org>, Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 C=?UTF-8?B?w6k=?= dric Le Goater <clg@redhat.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>
Subject: Re: [PATCH 6/6] hw/virtio/vhost: Use RCU_READ macro
User-Agent: meli 0.8.5-rc.3
References: <20240124074201.8239-1-philmd@linaro.org>
 <20240124074201.8239-7-philmd@linaro.org>
In-Reply-To: <20240124074201.8239-7-philmd@linaro.org>
Message-ID: <7rdrr.x7htvdbn5hy9@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, 24 Jan 2024 09:42, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>Replace the manual rcu_read_(un)lock calls by the
>WITH_RCU_READ_LOCK_GUARD macro (See commit ef46ae67ba
>"docs/style: call out the use of GUARD macros").
>
>Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>---
> hw/virtio/vhost.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>
>diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>index 2c9ac79468..1f5ecb843e 100644
>--- a/hw/virtio/vhost.c
>+++ b/hw/virtio/vhost.c
>@@ -186,12 +186,12 @@ static int vhost_sync_dirty_bitmap(struct vhost_dev *dev,
>             hwaddr phys, s, offset;
> 
>             while (used_size) {
>-                rcu_read_lock();
>-                iotlb = address_space_get_iotlb_entry(dev->vdev->dma_as,
>+                WITH_RCU_READ_LOCK_GUARD() {
>+                    iotlb = address_space_get_iotlb_entry(dev->vdev->dma_as,
>                                                       used_phys,
>                                                       true,
>                                                       MEMTXATTRS_UNSPECIFIED);
>-                rcu_read_unlock();
>+                }
> 
>                 if (!iotlb.target_as) {
>                     qemu_log_mask(LOG_GUEST_ERROR, "translation "
>-- 
>2.41.0
>

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

