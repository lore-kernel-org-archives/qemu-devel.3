Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C2E8C52D6F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 13:35:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sc3Ho-0001yl-CD; Thu, 08 Aug 2024 09:34:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sc3Hm-0001xT-Iw
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 09:34:34 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sc3Hj-0006vm-Sx
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 09:34:34 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5a1c496335aso360305a12.1
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2024 06:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723124070; x=1723728870; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7mupvbCJcyz6isLouCWHfgC0dhkqotIHCHjM8LurwjM=;
 b=CyNVnnI9+h54WnL4/0OtYAO67KqS24uAoV2aU4BW3zkVU642ZYeLGB9AAwBjZsqhYY
 hfTrzA7zZ49370VYo4oGf+5+ioNCxfNS7I1f70i0mohoPDW76PaIoFTInZhhHZEiru+B
 I1P+nTiiAzOJ3e+iK5PQMA3pKcDOfE5Cb5LAT7Bn76Xrbj5tAu9D/2y4MS2lKST3WLK0
 UonO76s6C0T5TSDEdv6ua/Q9ChmBAgF5EBNr1Y55t/yBzsF4WGPj01eV72WrhFblL6KM
 MCwfyTFF6lWJQzgGlzYRWp8n4r6B2fuCEWy/anVesXTtV+eMFxGlowmTKDrrGkju+1/5
 Fv4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723124070; x=1723728870;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7mupvbCJcyz6isLouCWHfgC0dhkqotIHCHjM8LurwjM=;
 b=ihbz7wuBoHHqYWMO1MXUFM+b4pfSm5d3IWnDysJbxyngHOne+qgJalDc85nArQ6anF
 g1Glr2hTP7zvjEj/a+b+ba/OrVxA3mAfKq/CADn/UwMUvQIr1UrmPGenvXR+dYDE+qhi
 oTCRXijMY53PHi1w15e7j+Yqg/0usNXssF24B7V9WZYbJqT15GJISLkxwAvn2WXJYvbc
 CR6XuCOaAPiXlKicqNkDGTKgf+GboXnM9bs6+VzIAf/uIuNk52neaD5YKTWjef7f3iOD
 KqKDVoDzxw2snnKqy2IxEgFufiqmL1Hhiq0kU1QJ4TF25HSn38odD9NVbGwwXvTV/hDp
 yLlg==
X-Gm-Message-State: AOJu0YywRHWJ6HSX3QbhNAgc80DSQhP4n5llIRFP+qGwz0cmw+3Ual5q
 TX+QEXutXIfU/qBAQyS2vzOUpO5JRDJXRS+aXJIYX6umdKCCUQww4a9vXKOgVN7jmDYkpwn11tA
 6zkAYGysJwd4mwfs/2C7xYlxa6pKrWmm7mzD7oQ==
X-Google-Smtp-Source: AGHT+IGqszMt4krRUlH5RzR1bVfIu28eBJ3aCuZ04JC7IPQD7ey2vFeMydUch/kqca6Q2PNMm39P3B1PzMn/YP0JbEU=
X-Received: by 2002:a05:6402:2228:b0:5a1:5692:b5f9 with SMTP id
 4fb4d7f45d1cf-5bbb24c3de4mr1495228a12.38.1723124069815; Thu, 08 Aug 2024
 06:34:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240801140609.26922-1-jim.shu@sifive.com>
 <20240801140609.26922-3-jim.shu@sifive.com>
In-Reply-To: <20240801140609.26922-3-jim.shu@sifive.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Aug 2024 14:34:18 +0100
Message-ID: <CAFEAcA9aOGichd7qL914QvS841gpTnwQjvR+ujv+91Qu12VJ=Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] hw/dma: xilinx_axidma: Send DMA error IRQ if any
 memory access is failed
To: Jim Shu <jim.shu@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Thu, 1 Aug 2024 at 15:08, Jim Shu <jim.shu@sifive.com> wrote:
>
> The memory transactions from DMA could have bus-error in some cases. If
> it is failed, DMA device should send error IRQs.
>
> Signed-off-by: Jim Shu <jim.shu@sifive.com>
> ---
>  hw/dma/trace-events    |  1 +
>  hw/dma/xilinx_axidma.c | 69 ++++++++++++++++++++++++++++++------------
>  2 files changed, 50 insertions(+), 20 deletions(-)
>
> diff --git a/hw/dma/trace-events b/hw/dma/trace-events
> index 4c09790f9a..7db38e0e93 100644
> --- a/hw/dma/trace-events
> +++ b/hw/dma/trace-events
> @@ -47,3 +47,4 @@ pl330_iomem_read(uint32_t addr, uint32_t data) "addr: 0x%08"PRIx32" data: 0x%08"
>
>  # xilinx_axidma.c
>  xilinx_axidma_loading_desc_fail(uint32_t res) "error:%u"
> +xilinx_axidma_storing_desc_fail(uint32_t res) "error:%u"
> diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
> index 6aa8c9272c..728246f925 100644
> --- a/hw/dma/xilinx_axidma.c
> +++ b/hw/dma/xilinx_axidma.c
> @@ -194,6 +194,20 @@ static inline int streamid_from_addr(hwaddr addr)
>      return sid;
>  }
>
> +/* When DMA is error, fill in the register of this Stream. */
> +static void stream_dma_error(struct Stream *s, MemTxResult result)
> +{
> +    if (result == MEMTX_DECODE_ERROR) {
> +        s->regs[R_DMASR] |= DMASR_DECERR;
> +    } else {
> +        s->regs[R_DMASR] |= DMASR_SLVERR;
> +    }

The MM2S_DMASR described in this doc:
https://docs.amd.com/r/en-US/pg021_axi_dma/MM2S_DMASR-MM2S-DMA-Status-Register-Offset-04h
has both DMASlvErr/DMADecErr bits and also
SGSlvErr/SGDecErr bits. Is that the wrong documentation
for the version of the device we model, or is there
a situation where we should be setting the other
SlvErr/DecErr bits when we get an error from our
memory accesses? Similarly there's a separate
S2MM_DMASR in those docs which we don't model at all
(so maybe it is the wrong datasheet...)

> +
> +    s->regs[R_DMACR] &= ~DMACR_RUNSTOP;
> +    s->regs[R_DMASR] |= DMASR_HALTED;
> +    s->regs[R_DMASR] |= DMASR_ERR_IRQ;
> +}



> +
>  static MemTxResult stream_desc_load(struct Stream *s, hwaddr addr)
>  {
>      struct SDesc *d = &s->desc;
> @@ -203,16 +217,7 @@ static MemTxResult stream_desc_load(struct Stream *s, hwaddr addr)
>                                              d, sizeof *d);
>      if (result != MEMTX_OK) {
>          trace_xilinx_axidma_loading_desc_fail(result);
> -
> -        if (result == MEMTX_DECODE_ERROR) {
> -            s->regs[R_DMASR] |= DMASR_DECERR;
> -        } else {
> -            s->regs[R_DMASR] |= DMASR_SLVERR;
> -        }
> -
> -        s->regs[R_DMACR] &= ~DMACR_RUNSTOP;
> -        s->regs[R_DMASR] |= DMASR_HALTED;
> -        s->regs[R_DMASR] |= DMASR_ERR_IRQ;
> +        stream_dma_error(s, result);
>          return result;
>      }
>
> @@ -224,17 +229,24 @@ static MemTxResult stream_desc_load(struct Stream *s, hwaddr addr)
>      return result;
>  }
>
> -static void stream_desc_store(struct Stream *s, hwaddr addr)
> +static MemTxResult stream_desc_store(struct Stream *s, hwaddr addr)
>  {
>      struct SDesc *d = &s->desc;
> +    MemTxResult result;
>
>      /* Convert from host endianness into LE.  */
>      d->buffer_address = cpu_to_le64(d->buffer_address);
>      d->nxtdesc = cpu_to_le64(d->nxtdesc);
>      d->control = cpu_to_le32(d->control);
>      d->status = cpu_to_le32(d->status);
> -    address_space_write(&s->dma->as, addr, MEMTXATTRS_UNSPECIFIED,
> -                        d, sizeof *d);
> +    result = address_space_write(&s->dma->as, addr, MEMTXATTRS_UNSPECIFIED,
> +                                 d, sizeof *d);
> +
> +    if (result != MEMTX_OK) {
> +        trace_xilinx_axidma_storing_desc_fail(result);
> +        stream_dma_error(s, result);
> +    }
> +    return result;
>  }
>
>  static void stream_update_irq(struct Stream *s)
> @@ -294,6 +306,7 @@ static void stream_process_mem2s(struct Stream *s, StreamSink *tx_data_dev,
>      uint32_t txlen, origin_txlen;
>      uint64_t addr;
>      bool eop;
> +    MemTxResult result;
>
>      if (!stream_running(s) || stream_idle(s) || stream_halted(s)) {
>          return;
> @@ -322,9 +335,14 @@ static void stream_process_mem2s(struct Stream *s, StreamSink *tx_data_dev,
>              unsigned int len;
>
>              len = txlen > sizeof s->txbuf ? sizeof s->txbuf : txlen;
> -            address_space_read(&s->dma->as, addr,
> -                               MEMTXATTRS_UNSPECIFIED,
> -                               s->txbuf, len);
> +            result = address_space_read(&s->dma->as, addr,
> +                                        MEMTXATTRS_UNSPECIFIED,
> +                                        s->txbuf, len);
> +            if (result != MEMTX_OK) {
> +                stream_dma_error(s, result);
> +                return;
> +            }

In this function we only use result in the immediately following
if(), so I think it would be slightly clearer to write them as
      if (stream_desc_store(...) != MEMTX_OK) {
          break;
      }

without the use of the variable.

> +
>              stream_push(tx_data_dev, s->txbuf, len, eop && len == txlen);
>              txlen -= len;
>              addr += len;
> @@ -336,7 +354,9 @@ static void stream_process_mem2s(struct Stream *s, StreamSink *tx_data_dev,
>
>          /* Update the descriptor.  */
>          s->desc.status = origin_txlen | SDESC_STATUS_COMPLETE;
> -        stream_desc_store(s, s->regs[R_CURDESC]);
> +        if (stream_desc_store(s, s->regs[R_CURDESC]) != MEMTX_OK) {
> +            break;
> +        }
>
>          /* Advance.  */
>          prev_d = s->regs[R_CURDESC];
> @@ -354,6 +374,7 @@ static size_t stream_process_s2mem(struct Stream *s, unsigned char *buf,
>      uint32_t prev_d;
>      unsigned int rxlen;
>      size_t pos = 0;
> +    MemTxResult result;
>
>      if (!stream_running(s) || stream_idle(s) || stream_halted(s)) {
>          return 0;
> @@ -375,8 +396,13 @@ static size_t stream_process_s2mem(struct Stream *s, unsigned char *buf,
>              rxlen = len;
>          }
>
> -        address_space_write(&s->dma->as, s->desc.buffer_address,
> -                            MEMTXATTRS_UNSPECIFIED, buf + pos, rxlen);
> +        result = address_space_write(&s->dma->as, s->desc.buffer_address,
> +                                     MEMTXATTRS_UNSPECIFIED, buf + pos, rxlen);
> +        if (result != MEMTX_OK) {
> +            stream_dma_error(s, result);
> +            break;
> +        }
> +
>          len -= rxlen;
>          pos += rxlen;
>
> @@ -389,7 +415,10 @@ static size_t stream_process_s2mem(struct Stream *s, unsigned char *buf,
>
>          s->desc.status |= s->sof << SDESC_STATUS_SOF_BIT;
>          s->desc.status |= SDESC_STATUS_COMPLETE;
> -        stream_desc_store(s, s->regs[R_CURDESC]);
> +        result = stream_desc_store(s, s->regs[R_CURDESC]);
> +        if (result != MEMTX_OK) {
> +            break;
> +        }

In these two places also we don't need the variable.

>          s->sof = eop;
>
>          /* Advance.  */
> --

thanks
-- PMM

