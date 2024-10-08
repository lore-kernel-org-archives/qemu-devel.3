Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90E6FCEF14D
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 10:18:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sy7IC-00033x-Co; Tue, 08 Oct 2024 06:18:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sy7IA-0002yI-Ef
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 06:18:10 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sy7I8-0005fG-PS
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 06:18:10 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5c89f3f28b6so7846339a12.2
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 03:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728382687; x=1728987487; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dg9k//Tb6bvetg8nKBCCRpOzQt7qGhJ/Z9KCJ2/fWQg=;
 b=wjgIU9GikhCIDotDsPqf+sXaJOFicd0QY479hz6KobCEJBmbuHIFDEXJBUhnDZbqSQ
 hPQgpi9KWRoaiq971HsfHbR0U35EUeW6Jjn0Y89yRCPmyhOzxyaHrXUx1Jx/7Dao4M6K
 Wn0WgjzhnD9IVt8UhnjiaS5fsKdaZIMl0GmczB40pbh2tGQylSTSYS01tw2WO3ie4jpg
 +lDf+/QEGM4QrajdtXcIUI1wtEJJia+W+TkpD/eyRwfb2IMD1lEztYCO9e8UDwYaV+Fl
 VMzv6FOJNGtIUKu09fWta7c0Ojicqu52l+t+eIUi1WgN5akYUJeopLY1PjC/m+p3rRpE
 qeEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728382687; x=1728987487;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dg9k//Tb6bvetg8nKBCCRpOzQt7qGhJ/Z9KCJ2/fWQg=;
 b=ui7uhpPcMh02wBPdEIe2U1qFFcf4lMSEfPUsiHNXRG2P9Ew7jJa9T5Z6fvDsSxknPg
 GDaDH/uwNeMharzOHzP7D2yTOrAkDUSkF4cqP5ATwnAKeMCU/eCGKwZKTPDe11eXX5kb
 S4Rk2uhQ5CTOgHNkeY291Yc2gQNdU8Oy21zFfpOIPWkH+bkALZTOa19dvo8DTjTUEE1m
 eiq6T8yDjgnzyS7W2cXfoDUQM9T/vavPbypGmqt39W4hPzNGun/5LAA/p7XlTf649WZD
 1I4dCtHPnqHR4/CJii0F9QC9rLA0RVJ2O+kH9cfSrb+naN+KrbkP/5PVFsJScZf6ch9S
 QU4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWx2Ftr9DG73tXi8APseW2riHN9iJFE8Fpsu+vl4B2iotDV1577x50kSRzu/wXHCRkhRkoXMEJC2sOG@nongnu.org
X-Gm-Message-State: AOJu0YyoSW4JxMaFjE6V6MevuiP+2Nww4TjE6iiKv/zoghKEh/vDPxw6
 jlhNsZxUY+fz3XkAsGG9PCNjjg8uXPVKZvk4ia05X8ay9dwQSj9PIyCo/Q+Fj+NpcldnwTYQ3mH
 uAzabFp15l3OgRWjuIoIQw4b+HVJ9MzpTI+ESOQ==
X-Google-Smtp-Source: AGHT+IGyN/kH4639DPzKib/07WEDzlz1uPT3/kemy1gxIQIl8eqqpApliSzQB4/FXFAnHNrp/kAGJgo15YEw1fWTruU=
X-Received: by 2002:a05:6402:4313:b0:5c8:9f3e:1419 with SMTP id
 4fb4d7f45d1cf-5c8d2cff641mr13995527a12.5.1728382686411; Tue, 08 Oct 2024
 03:18:06 -0700 (PDT)
MIME-Version: 1.0
References: <20241008-dma-v1-1-c439c0fc5f3a@daynix.com>
In-Reply-To: <20241008-dma-v1-1-c439c0fc5f3a@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Oct 2024 11:17:54 +0100
Message-ID: <CAFEAcA-qEOUAGs8mDKwMKMWh+E4NXkm1kOPCeWrAQkYVaxWS7w@mail.gmail.com>
Subject: Re: [PATCH] dma: Fix dma_memory_map/dma_memory_unmap documentation
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Tue, 8 Oct 2024 at 07:54, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> Ensure the function names match.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  include/sysemu/dma.h | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/include/sysemu/dma.h b/include/sysemu/dma.h
> index a1ac5bc1b543..e132ece4510d 100644
> --- a/include/sysemu/dma.h
> +++ b/include/sysemu/dma.h
> @@ -189,7 +189,7 @@ MemTxResult dma_memory_set(AddressSpace *as, dma_addr_t addr,
>                             uint8_t c, dma_addr_t len, MemTxAttrs attrs);
>
>  /**
> - * address_space_map: Map a physical memory region into a host virtual address.
> + * dma_space_map: Map a physical memory region into a host virtual address.

The function is dma_memory_map ...

>   *
>   * May map a subset of the requested range, given by and returned in @plen.
>   * May return %NULL and set *@plen to zero(0), if resources needed to perform
> @@ -216,8 +216,7 @@ static inline void *dma_memory_map(AddressSpace *as,
>  }
>
>  /**
> - * address_space_unmap: Unmaps a memory region previously mapped
> - *                      by dma_memory_map()
> + * dma_space_unmap: Unmaps a memory region previously mapped by dma_memory_map()

...and this one is dma_memory_unmap.

>   *
>   * Will also mark the memory as dirty if @dir == %DMA_DIRECTION_FROM_DEVICE.
>   * @access_len gives the amount of memory that was actually read or written

thanks
-- PMM

