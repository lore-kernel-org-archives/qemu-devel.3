Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43E88C25B7E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 07:01:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEOA5-0006nD-R8; Tue, 04 Jun 2024 03:00:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1sEOA5-0006mR-25
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 03:00:49 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1sEOA2-0005gX-3p
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 03:00:48 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-52b9d062526so1701305e87.3
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 00:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1717484444; x=1718089244; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EVFS1V1Jr3n4q5IrQ6sWamwvxjqhFYZLkf5F/jnZC2A=;
 b=dZi1/UN/qyzPOH6+P+mvb+3wrvm2JFbVHSjtZUqEPdtY+XyALZzBqz2aKB5gESKMbE
 xF+tWoXBcO3+Ttbkp1iZBMbDCQl39acXEtLX9fhTcUlq0k4YcJhNDIA8D2LhNvjkLUbi
 YMvo9KAm+NF3C3Va0AtsMoBqsJcwiTuuvP9K4eNK4y5M0H+tAJM4tiRxQsDp3u2q3S1V
 UyxCdODcN8UtV/QZB66bq84vYoCMNDKq9OuvgV4O2ZjYilmo6uLjzBo+qAgJWOr/UWHr
 U1w6uI0bWrYm3XF771+vNuCJJfnCIMwiVwnahhd0czryCVteoI3WhD1VkNgrnqe4hKp3
 Jejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717484444; x=1718089244;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EVFS1V1Jr3n4q5IrQ6sWamwvxjqhFYZLkf5F/jnZC2A=;
 b=ucFPPxmNOL68fy2v+UNgxlTSYmgXdLSRUm6tj5tlebq/Km1gInusLOUm4VdD9caDda
 ZHNApq8tEBTnKLcAWvmBMfrsKz/dnhSCJMrk31PTyAshtBdv5MJzGYkUj23PwjwlwBVl
 S1atnkuDZfd6wqSo4rDAKhrIseam/VctchQnIIOIZKLnRkHyUj3c39xH72XyK1MgRoyT
 8wIIXJmxYiR+1jQVclLIw2TxNOLw54sLs8ta/FUfOS0gCYg4Hg1GDiGPX1+yM8t8hKXA
 yVPPH8MOZirAOTrgYx1M0UcEQMgDxnzx/HE6MUlLPwVyL1s+zVDckb83nhNNiLLqM7V0
 eiMw==
X-Gm-Message-State: AOJu0YwYjldJe/ZPw/JCf5m91tVJRfqQ78Yi8pIgNmdurEGjLVypC7lz
 m0nZIWADpQBSU/62Ot9pcjdeJ13A3kUjVQoT8af4ah2aKCoHWocSSbRi/9qxzvADQuSgR5zJp1S
 CTZrTeKxdEdZTJ17Bq7kK9ZldJ7NtgHF1kf0fcH8tqdHah7bmTwq7qr9OBmJ+qS6WdLvRgmxeqR
 uoDeS7CQkDJs8VjgcCt1JT0fC0Qdm115DDc+50eFM=
X-Google-Smtp-Source: AGHT+IG4tlGM2QIEQ/+dKRQSFGGUNpaW4pxAtTid+diZ2ZmkUdz0VsBRPVXmK+G8onCwIozEfuHGGg==
X-Received: by 2002:ac2:48ae:0:b0:51e:245a:8ed3 with SMTP id
 2adb3069b0e04-52b8958d8f8mr7422869e87.28.1717484442873; 
 Tue, 04 Jun 2024 00:00:42 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com.
 [209.85.208.171]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-52ba00e0b74sm187261e87.295.2024.06.04.00.00.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jun 2024 00:00:42 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id
 38308e7fff4ca-2eab0bc74cdso20404821fa.3; 
 Tue, 04 Jun 2024 00:00:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCVsBcjO/ZzQxTScbu9V1PzZXTR025imM7DzMtLBN0BkynL+WJiml2GJ3a1wCq5gm5ngSDhLZ9vCQ8zIfr+HvcQczfShBLLsS26ZolGuwCO+87wZ/0jIKx+5CGs=
X-Received: by 2002:a2e:b54b:0:b0:2ea:7ccd:10a7 with SMTP id
 38308e7fff4ca-2ea951d85ffmr63070621fa.45.1717484442103; Tue, 04 Jun 2024
 00:00:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240603055248.3928469-1-fea.wang@sifive.com>
 <20240603055248.3928469-2-fea.wang@sifive.com>
In-Reply-To: <20240603055248.3928469-2-fea.wang@sifive.com>
From: Frank Chang <frank.chang@sifive.com>
Date: Tue, 4 Jun 2024 15:00:30 +0800
X-Gmail-Original-Message-ID: <CANzO1D3u9cvOtEGmUorq3FwBNn71ana5prOTx_=oEFOHDB=kLQ@mail.gmail.com>
Message-ID: <CANzO1D3u9cvOtEGmUorq3FwBNn71ana5prOTx_=oEFOHDB=kLQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] hw/dma: Enhance error handling in loading description
To: "Fea.Wang" <fea.wang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, 
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>, 
 "open list:Xilinx Zynq" <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=frank.chang@sifive.com; helo=mail-lf1-x133.google.com
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

Reviewed-by: Frank Chang <frank.chang@sifive.com>

Fea.Wang <fea.wang@sifive.com> =E6=96=BC 2024=E5=B9=B46=E6=9C=883=E6=97=A5 =
=E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=881:48=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Loading a description from memory may cause a bus-error. In this
> case, the DMA should stop working, set the error flag, and return
> the error value.
>
> Signed-off-by: Fea.Wang <fea.wang@sifive.com>
> ---
>  hw/dma/xilinx_axidma.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
> index 0ae056ed06..4b475e5484 100644
> --- a/hw/dma/xilinx_axidma.c
> +++ b/hw/dma/xilinx_axidma.c
> @@ -71,8 +71,10 @@ enum {
>  enum {
>      DMASR_HALTED =3D 1,
>      DMASR_IDLE  =3D 2,
> +    DMASR_SLVERR =3D 1 << 5,
>      DMASR_IOC_IRQ  =3D 1 << 12,
>      DMASR_DLY_IRQ  =3D 1 << 13,
> +    DMASR_ERR_IRQ  =3D 1 << 14,
>
>      DMASR_IRQ_MASK =3D 7 << 12
>  };
> @@ -190,17 +192,27 @@ static inline int streamid_from_addr(hwaddr addr)
>      return sid;
>  }
>
> -static void stream_desc_load(struct Stream *s, hwaddr addr)
> +static MemTxResult stream_desc_load(struct Stream *s, hwaddr addr)
>  {
>      struct SDesc *d =3D &s->desc;
>
> -    address_space_read(&s->dma->as, addr, MEMTXATTRS_UNSPECIFIED, d, siz=
eof *d);
> +    MemTxResult result =3D address_space_read(&s->dma->as,
> +                                            addr, MEMTXATTRS_UNSPECIFIED=
,
> +                                            d, sizeof *d);
> +    if (result !=3D MEMTX_OK) {
> +        s->regs[R_DMACR] &=3D ~DMACR_RUNSTOP;
> +        s->regs[R_DMASR] |=3D DMASR_HALTED;
> +        s->regs[R_DMASR] |=3D DMASR_SLVERR;
> +        s->regs[R_DMASR] |=3D DMASR_ERR_IRQ;
> +        return result;
> +    }
>
>      /* Convert from LE into host endianness.  */
>      d->buffer_address =3D le64_to_cpu(d->buffer_address);
>      d->nxtdesc =3D le64_to_cpu(d->nxtdesc);
>      d->control =3D le32_to_cpu(d->control);
>      d->status =3D le32_to_cpu(d->status);
> +    return result;
>  }
>
>  static void stream_desc_store(struct Stream *s, hwaddr addr)
> --
> 2.34.1
>
>

