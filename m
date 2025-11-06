Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE3AACCFA13
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 19:16:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vH5TI-0005O1-KF; Thu, 06 Nov 2025 14:16:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1vH5TH-0005Na-4N
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 14:16:35 -0500
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1vH5TE-0006sE-4T
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 14:16:34 -0500
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-37a2d9cf22aso14327241fa.1
 for <qemu-devel@nongnu.org>; Thu, 06 Nov 2025 11:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762456589; x=1763061389; darn=nongnu.org;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D59605l+8Sn7tgyb1D1dh8hKak98HQtqQtnzVzLz2/U=;
 b=JbOadrF75otPxV4phlGX73O0elEQCF4BmmYlUg69T22MCa8UmU38gty1hQNN+7zaJ6
 o8OPyqrrhpftvlq/IXQ9Kk3Riqybz/WcfclliCC68jbyPkXXVMZO3LwvmtToSqryLEeY
 S0PjsmcctTpgmKb6FKwC8Ec+UneTxr7DB2sEkd71JwZRaB6fzv10S9N0LyVoqE+URhhm
 5gH7h5geFVILhkxaikNac65b9nu1tOx/+azttH7aDm7WmaBOAXK2t7HuTZQUB7UFcwHF
 XCVGqTefGSM2OLmjkFZuxoGsJKcblYw3O5nomx6hoFKbZmQH7BqibpoyOS6jSStIemeg
 e2Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762456589; x=1763061389;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=D59605l+8Sn7tgyb1D1dh8hKak98HQtqQtnzVzLz2/U=;
 b=D/Y4naeoeVdXwh432XVHaVNmHp6gxHruAvN3gB1CAJznQ/Q+DXUxKpOZK4Ne5im56W
 X1NfCA7JoQeofrgcPW/YB7LXq+tyvoGosA0lQiO1CJl2UvLqK73wJZixXzzv5/BOaFJu
 h3rnQ44fv+0CZm7c0QfkWUPpMFQqZeQTp7vvlqn9r5u/3bMP5834tCNPKcBi86Graz1L
 lUjQI+OzelxvpW5ffoaX1QNM1BxVpuQ1Wrah4hf6xW68PfnzyFyqDdX1pGHlg65KoS1/
 8rG0h+nonRvgipxvXlOW6wQ/LXBbEg0uLusGFUpQlqnWt4WqdhnfImfxU4eDO+qmq1Mz
 0qxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3P2nvX6MdiJUjVoYUh+L8F3mB+90BH/gkIfWIzh+SVbTPxsR52X2QcQ7oe871IhOKQbGlrmoRBji0@nongnu.org
X-Gm-Message-State: AOJu0YzfgPaF89YzekXnJ5EBlUYfO+NjyPpBAHwYKa/05FN4J33KRuYm
 pkD4YFIeIwxGT/qCRZkKtQoyesK/ajzP2cTbJ6SL9wuJtSNMwaFSYRcp
X-Gm-Gg: ASbGncsLVJyO3RuPURyyf8vmnsqhAOqHg27r53eGaZsAxMRf1m7lU0NreXR/lxTWQXt
 uQrvfoo2t2PGqKDPxjVngas3LHQAWk5GEUxM+od7+0Rtelko9Aedbl40hfpIEhMf/r9ohfHjifa
 U8E1gJIw/YRs0YNpXo4K+otA14iOXIi//vQ/W0/PzT8CT/3BECKT1d0/J3rxZ5ciAEo8/+oRKy1
 jvZH8A1Wl8EXRzN2/6aRe+UPAhgfjnGuL/11b2Lz6LGgi1qCF7lAA+od+Wiyiich+23KXjtik2Y
 jMnW+yc+tXYq+ZTThM3/BU6bRKDbrGYWGQoE/hryYbT0yJ2g5QaPLcgi3iFJz0hZdlQLguEe0w3
 UkI5nWdfB6D5dh9Wsamry4aQOceQRxKjsJG47F7FvJH9jmkmLbJPM1xoqHBcnlmaL6FJiD6rlAG
 yqCB2QGn8a+HUiuoP0K64SZ+FKGj5GVDZO88r7
X-Google-Smtp-Source: AGHT+IFD4aE71hsW9zrv0X3ad5coCl5EtUekd0/IFzesAE4+9gyjfeL9/vLvgEkj6nByjZcL6vH5/w==
X-Received: by 2002:a2e:a4dc:0:b0:378:d020:b6b3 with SMTP id
 38308e7fff4ca-37a5dca31d5mr10966961fa.7.1762456589188; 
 Thu, 06 Nov 2025 11:16:29 -0800 (PST)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-37a5f0ee99csm8166941fa.45.2025.11.06.11.16.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Nov 2025 11:16:28 -0800 (PST)
Date: Thu, 6 Nov 2025 20:16:26 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Ilya Repko <i.repko@syntacore.com>, fea.wang@sifive.com
Cc: Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 "open list:Xilinx Zynq" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Subject: Re: [PATCH] Revert "hw/net: Fix the transmission return size"
Message-ID: <aQz0CiFKPCNbO76m@zapote>
References: <20251106094837.431976-1-i.repko@syntacore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106094837.431976-1-i.repko@syntacore.com>
User-Agent: Mutt/2.2.14+84 (2efcabc4) (2025-03-23)
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x230.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Thu, Nov 06, 2025 at 12:48:37PM +0300, Ilya Repko wrote:
> This reverts commit 3a6d374b754b4b345195ff6846eeaffedc96a7c5.
> 
> During axienet_eth_rx_notify(), s->rxpos is modified to indicate how much
> data was pushed to AXI DMA. eth_rx() would then return this value.
> If at 0, network subsystem would consider packet reception as failed
> and put the packet in a queue for later.
> 
> Before we attempt to push packet data to AXI DMA, the packet is stored
> in s->rxmem buffer. If an attempt to push data fails, we will reattempt
> to deliver it from s->rxmem buffer once s2mm stream gets a new descriptor.
> s->rxmem would not be overwritten by a subsequent eth_rx() call, because
> eth_can_rx() protects it in case it has any data at all. Leaving the packet
> in a NetQueue though effectively duplicates it.
> 
> Therefore, eth_rx() must indicate successful packet reception in case
> data push to AXI DMA fails.

Hi,

Adding Fea since we're reverting his patch, he may have some insights.

What you describe sounds reasonable but I think we've seen issues with
both your version (the original one) and Fea's version.

What machine are you running? Are you running Linux guests?

Cheers,
Edgar




> 
> Signed-off-by: Ilya Repko <i.repko@syntacore.com>
> ---
>  hw/net/xilinx_axienet.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/net/xilinx_axienet.c b/hw/net/xilinx_axienet.c
> index 31e7708082..101b3f260a 100644
> --- a/hw/net/xilinx_axienet.c
> +++ b/hw/net/xilinx_axienet.c
> @@ -867,7 +867,7 @@ static ssize_t eth_rx(NetClientState *nc, const uint8_t *buf, size_t size)
>      axienet_eth_rx_notify(s);
>  
>      enet_update_irq(s);
> -    return s->rxpos;
> +    return size;
>  }
>  
>  static size_t
> -- 
> 2.51.1
> 

