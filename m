Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CA88C3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 15:24:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYSDy-0007Mo-M0; Mon, 29 Jul 2024 11:23:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYSDs-0007KB-PG
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 11:23:41 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYSDk-0007Pk-N7
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 11:23:38 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2eeb1ba0481so57494711fa.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 08:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722266611; x=1722871411; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qzM61U8fDoolnr+6t8nBL4raAeC7Mlar50RUt9YjfR8=;
 b=uycKZzGBtomJyMfCJvPtlAfyGVfyXgCPrpDJ9Zu3xmwNV5r0QWnYA3Ze4pZDDzegdJ
 QWEXR7bF509d9485qV2VTEXzYUr6DAXe2bF3DkzNUcYgZfQ9EkKqhZobMKqwyaQYvNyY
 rYwK3Yc7LIrzd6mvqd1SKDdMP4OW/bUroArEHWzPi3q/IuXP/Mlfu5O2LWc+2nkuShoA
 VXvx2xapjA4JpZt1tT8bpIN0Xa9WRtXWO1r4JcbFVLm6xqR0tSsSSvdwNnhdg3g5xj1Q
 5Du0FYd+2T9yEduQP3ShOM1pBq2UVYCrkiVEvm0uNx5e7YapjGvkdFASP56avwKIGoFn
 Hl9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722266611; x=1722871411;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qzM61U8fDoolnr+6t8nBL4raAeC7Mlar50RUt9YjfR8=;
 b=cub7hdpbHSr3sSOQdsumi62lNwimLbi2HPptODQHwC1QiI8XIGOTH8J+ZdHCz76U52
 U2gZ/gw9y4NYMySAWB7TCoigcU8lFISo2/ZhL9qqRTjGHfyzVx2TigSzIVbDFOZw1TmV
 o2vj6uDw0zMT2AZrd0224H4ZY7qEI2VyXjUwfHbmse6IAXiRdAXQrmDRMWrhMTXJOCNc
 EK3+TBqI0JlsyK0dbvf6dZX7BqTgNCBpwbJXAZ1+va8YypDcQSvbNf/0OBRUHIOsyNuK
 iHCtGqvE5o4FO34/lmDlG2yZqUaV0iEZtdCJrL07Bll0YDNHsKiU8m02IBavubflqDbq
 c32A==
X-Gm-Message-State: AOJu0Yzg/ufXmOX91rx4rIAO7Qc1VqtPGfcpq421CN/SQN5u9oNNw18s
 bpnuzjAe/Y7o+L5HbnFCJzNDfi8R+epV8LeweOFuZtnkUk1YyimNduJNOPJX+pXKl86WAPa89n1
 j4lMMLdKXcjV2VAi/Leas9teGhM1QzvDeQSuH5w==
X-Google-Smtp-Source: AGHT+IGxsY8/23FThVyYyBTYqT11EyFxkbIxJ1cET1ZkoeqRa2V4jgE1Tl92/WmX3H4qAKKdrNlkQYNQM/aZ+NJd2Hs=
X-Received: by 2002:a2e:a495:0:b0:2ef:232c:6938 with SMTP id
 38308e7fff4ca-2f12ebcae5amr53080841fa.6.1722266610591; Mon, 29 Jul 2024
 08:23:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240726055933.817-1-jim.shu@sifive.com>
 <20240726055933.817-4-jim.shu@sifive.com>
In-Reply-To: <20240726055933.817-4-jim.shu@sifive.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Jul 2024 16:23:19 +0100
Message-ID: <CAFEAcA-ZkcJvFkYyHGi9bXoPvqEzvV0b_z6xaQPLMK9qNHSdCA@mail.gmail.com>
Subject: Re: [PATCH 3/4] hw/dma: xilinx_axidma: Reset qemu_irq when DMA/Stream
 is reset
To: Jim Shu <jim.shu@sifive.com>
Cc: qemu-devel@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Alistair Francis <alistair@alistair23.me>, Jason Wang <jasowang@redhat.com>, 
 "open list:Xilinx Zynq" <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x234.google.com
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

On Fri, 26 Jul 2024 at 06:59, Jim Shu <jim.shu@sifive.com> wrote:
>
> Current DMA/Stream reset will clear interrupt pending bit of DMA device.
> The qemu_irq of device should be updated at the same time.
>
> Signed-off-by: Jim Shu <jim.shu@sifive.com>
> ---
>  hw/dma/xilinx_axidma.c | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
>
> diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
> index 728246f925..beb3fbf1d5 100644
> --- a/hw/dma/xilinx_axidma.c
> +++ b/hw/dma/xilinx_axidma.c
> @@ -177,11 +177,24 @@ static inline int stream_halted(struct Stream *s)
>      return !!(s->regs[R_DMASR] & DMASR_HALTED);
>  }
>
> +static void stream_update_irq(struct Stream *s)
> +{
> +    unsigned int pending, mask, irq;
> +
> +    pending = s->regs[R_DMASR] & DMASR_IRQ_MASK;
> +    mask = s->regs[R_DMACR] & DMASR_IRQ_MASK;
> +
> +    irq = pending & mask;
> +
> +    qemu_set_irq(s->irq, !!irq);
> +}
> +
>  static void stream_reset(struct Stream *s)
>  {
>      s->regs[R_DMASR] = DMASR_HALTED;  /* starts up halted.  */
>      s->regs[R_DMACR] = 1 << 16; /* Starts with one in compl threshold.  */
>      s->sof = true;
> +    stream_update_irq(s); /* Clear interrupt */
>  }

The general rule of thumb in QEMU is not to call
qemu_set_irq() from a DeviceState::reset function,
and xilinx_axidma_reset calls stream_reset. I think
probably the best thing is to separate out whether
this is a DeviceState::reset or a software-triggered
reset, and only call qemu_set_irq() in the latter case.

thanks
-- PMM

