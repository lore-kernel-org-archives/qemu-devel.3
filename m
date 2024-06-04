Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0BD9C27C53
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 07:02:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEOAw-0007lK-H7; Tue, 04 Jun 2024 03:01:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1sEOAq-0007TY-K2
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 03:01:36 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1sEOAo-0005pU-5q
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 03:01:36 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2e6f2534e41so45087291fa.0
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 00:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1717484492; x=1718089292; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DiU0YKK7Q5ypPT4YZX1jyasIzmH7VE8jWS1mXL4ANBg=;
 b=XPpWvkJ+cSSHBwic9DHiGN9mhBePFwI/VUd8RTOjwIjlV8McNApIzbE28Y7lMgqC+j
 FqvSDSCa9pVhWb2GvU44S/JUKRxjtU4a1Rwc3OGTVzjorK68lUtPc70SZGe9xybt6di1
 1WW3SF4xYuI8TyE0BJfXR01LgdznJOg7GwLNY3aujKLN4fIAPZ/2gjxqAlXUIN3DGVOg
 tk3LHC1p160v+A01s5KdW8D1mccyZwM0uJ/GBS1wwu76+mRJLd1gRC10EHE9fOqHqgC6
 CrGN0/T6m7Cs3FtzrQyqpOfGdi5fpQC8DBeMTGtn0neC3Syy+5nKWIc1s/ZO2MKbyqfK
 UDww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717484492; x=1718089292;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DiU0YKK7Q5ypPT4YZX1jyasIzmH7VE8jWS1mXL4ANBg=;
 b=skamX0nGA5ECUnbjp2i3wL50MlM3bbMNp3cdaDXClVDmjx/tLGynzSolb4CATA6Tbd
 FxYLFqAR/BMmd0uE8SdZ06qmbbEeATFU0aDsBDIzv4OJbHLRjQLss5caqlsFgBiECIMe
 zcOTajH/5eGTAYDNQlq5t3GlW2jTNYxqgI7MiJu3X2OSriRAn7QrflBUPkU4hyicnoiv
 iywr5YepW02XbzlFO0y6sHpt5km5Wm8/0eEOdvxtiOa4vnD/mQhTwxOdDQCSww3y2d74
 wwrWV4wfaC8VTpN0KCCVLeG+EhGeWTsGW6iveMKyNGkZctJT4rUIXfo1JMODN1XHLp2+
 jxYQ==
X-Gm-Message-State: AOJu0Yyx7enV056zM7kk6jvoVD3gri0caOZCKHeR9d9ja9t1OthfQikD
 +x8DQRBfMnOWNFKiKJot3T82i8EWabkFZYjjxVZSbnxiXaPt9QhmGgTXFgYEFoOUXV1PRW6cNPw
 dSiNb3vfdJvEnTJYgYUbhczEwuLYKKjVAeAGNaWugCvWtR8iZLEU9FxTpstHxWWqNhaW86gMRPE
 Mbm68/8dGYWPIRxXZ3UZuZim700fEko/S4hayP0LcxDQ==
X-Google-Smtp-Source: AGHT+IHSJKLf3Gu/5kj+drkV/ozoiGQnz0XLzwdELpEDUr6BM+qFJfZSg7VvQEbx3uQJpCsd1fkAGg==
X-Received: by 2002:a05:6512:2308:b0:523:99a4:a187 with SMTP id
 2adb3069b0e04-52ba858c5f3mr161566e87.26.1717484491673; 
 Tue, 04 Jun 2024 00:01:31 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com.
 [209.85.208.178]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-52b84d34addsm1434175e87.27.2024.06.04.00.01.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jun 2024 00:01:31 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id
 38308e7fff4ca-2e6f2534e41so45086701fa.0; 
 Tue, 04 Jun 2024 00:01:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCWDIUQNS5lRFJJvYKomnZie3FeDK1ENR9Ua/i461z/E/VB29Dw+y97rT10d/eh8ReK7dOhx6P8yq4Dy8J+qWWqrRhsqzOT2s9ehsD3L0RnjKBX7PjJjSaCBIZ4=
X-Received: by 2002:a2e:7d19:0:b0:2ea:75c5:69cb with SMTP id
 38308e7fff4ca-2ea9510daa9mr61174501fa.27.1717484489907; Tue, 04 Jun 2024
 00:01:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240603055248.3928469-1-fea.wang@sifive.com>
 <20240603055248.3928469-4-fea.wang@sifive.com>
In-Reply-To: <20240603055248.3928469-4-fea.wang@sifive.com>
From: Frank Chang <frank.chang@sifive.com>
Date: Tue, 4 Jun 2024 15:01:18 +0800
X-Gmail-Original-Message-ID: <CANzO1D2yBbu1hWD3AqTJkNQoN_OZdeWhn4HP8O0Am0xFS=RBfQ@mail.gmail.com>
Message-ID: <CANzO1D2yBbu1hWD3AqTJkNQoN_OZdeWhn4HP8O0Am0xFS=RBfQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] hw/dma: Add a trace log for a description loading
 failure
To: "Fea.Wang" <fea.wang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, 
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>, 
 "open list:Xilinx Zynq" <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=frank.chang@sifive.com; helo=mail-lj1-x231.google.com
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
=E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=881:49=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Due to a description loading failure, adding a trace log makes observing
> the DMA behavior easy.
>
> Signed-off-by: Fea.Wang <fea.wang@sifive.com>
> ---
>  hw/dma/trace-events    | 3 +++
>  hw/dma/xilinx_axidma.c | 3 +++
>  2 files changed, 6 insertions(+)
>
> diff --git a/hw/dma/trace-events b/hw/dma/trace-events
> index 3c47df54e4..95db083be4 100644
> --- a/hw/dma/trace-events
> +++ b/hw/dma/trace-events
> @@ -44,3 +44,6 @@ pl330_debug_exec_stall(void) "stall of debug instructio=
n not implemented"
>  pl330_iomem_write(uint32_t offset, uint32_t value) "addr: 0x%08"PRIx32" =
data: 0x%08"PRIx32
>  pl330_iomem_write_clr(int i) "event interrupt lowered %d"
>  pl330_iomem_read(uint32_t addr, uint32_t data) "addr: 0x%08"PRIx32" data=
: 0x%08"PRIx32
> +
> +# xilinx_axidma.c
> +xilinx_axidma_loading_desc_fail(uint32_t res) "error:%d"
> diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
> index b8ab5a423d..1bbb9d6c4c 100644
> --- a/hw/dma/xilinx_axidma.c
> +++ b/hw/dma/xilinx_axidma.c
> @@ -36,6 +36,7 @@
>  #include "sysemu/dma.h"
>  #include "hw/stream.h"
>  #include "qom/object.h"
> +#include "trace.h"
>
>  #define D(x)
>
> @@ -200,6 +201,8 @@ static MemTxResult stream_desc_load(struct Stream *s,=
 hwaddr addr)
>                                              addr, MEMTXATTRS_UNSPECIFIED=
,
>                                              d, sizeof *d);
>      if (result !=3D MEMTX_OK) {
> +        trace_xilinx_axidma_loading_desc_fail(result);
> +
>          s->regs[R_DMACR] &=3D ~DMACR_RUNSTOP;
>          s->regs[R_DMASR] |=3D DMASR_HALTED;
>          s->regs[R_DMASR] |=3D DMASR_SLVERR;
> --
> 2.34.1
>
>

