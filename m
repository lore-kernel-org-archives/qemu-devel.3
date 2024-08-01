Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C15F7C3DA64
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 13:35:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZVxE-0007jp-2w; Thu, 01 Aug 2024 09:34:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1sZVxD-0007iD-BJ
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 09:34:51 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1sZVx6-0003vu-DV
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 09:34:51 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5a1c49632deso9372608a12.2
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 06:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1722519282; x=1723124082; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O3r4St+ANSSVmc/HccXT4WRX1PGEnvGIq4Svs0tqE+0=;
 b=ZXPJIoZzipi97T45y+OsxxJa3sCmfFxAt8Og9VkwRKzvC70DXb6CUxLhsmr5b78XqL
 zlJ45kZIplOCdacCsYgpdnXOOTr4tY9J2CgH+ilST7+eMgg7Ti3gCSCsdGepGkvhRbcr
 nRcSGvuJaEESR2gQbCZHrTLGr8fBDmChtIcbc09UpyC0G9e+5z7SNIkCypLgccebKQVT
 fSivEwfzWg1Ge1mDf+CeN1uUWZPFU6JhUKzM5u7jhhjbxVF+KvEvhfGms8vtWrykD7A1
 urhuVSUVYitSjVeN/fM9QTg60ZTSdOIgwifBH5mHP3reihVXsWZkJCpaZWnkINXhO2Ne
 jcPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722519282; x=1723124082;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O3r4St+ANSSVmc/HccXT4WRX1PGEnvGIq4Svs0tqE+0=;
 b=fWHEwWH302LzouoIXhiv1n4YR2sbG7fiOmOnjbSvq1idMshl5NPjyLXVrweD+w9JXK
 /6ShWCYLadxY1eEMHUvEOuFMl/s2ShJx6t7E7X0MWZhp91mJxfNgP0gcyMAF95rrt4j9
 ekBcnmfNkSUie0NemMHYWIhD6qvwu3b5hWaGPUEhNW0H7IMkwi8ONY7QOnfz15gaGQI8
 hG1ofE2a4+SWUgtQwFdc9V7JYNIPjZFoEeRc9FPR2qRMSpUG1TUN88yRRjSuy5PvraT6
 ntel/uhM5ceu/G6MRC5SVaNtw8oTfpejzI4Fy1YkpZUBSmDjdmLc2d3MDOFo7yrdQyUD
 7BAg==
X-Gm-Message-State: AOJu0YxIw9ytGA2+cvO5t7Jj6ru1j9gPfgmoEgajYmqBHe/OI9zpoZzR
 3/T8GTwivt4eAVvYDYbBcJv33IA67Lg49lvo29M053TQsZ3s5rkl4Dfm7sMobPyMMYcUW8quvOR
 7LWvgqU/gDy9Z1JSvnYKG/Ktr4QknoeyIX/HGUQ==
X-Google-Smtp-Source: AGHT+IGawhApBW/OqohvK07L9a3RAWm362ldvB2vkQROcxuenxiGiTEj+xQ50EPn5xMW9Q7J0Ug+6Ei7uY8EtECzxaw=
X-Received: by 2002:a05:6402:457:b0:59e:686b:1874 with SMTP id
 4fb4d7f45d1cf-5b7f36f5040mr239688a12.6.1722519281771; Thu, 01 Aug 2024
 06:34:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240726055933.817-1-jim.shu@sifive.com>
 <20240726055933.817-5-jim.shu@sifive.com>
 <CAFEAcA_QmSdqTo4zmv=AKox2ZiJPt18vV4CwaLLp6VPLWBMcpA@mail.gmail.com>
In-Reply-To: <CAFEAcA_QmSdqTo4zmv=AKox2ZiJPt18vV4CwaLLp6VPLWBMcpA@mail.gmail.com>
From: Jim Shu <jim.shu@sifive.com>
Date: Thu, 1 Aug 2024 21:34:31 +0800
Message-ID: <CALw707pAUJWo8CytZ2ndK7fEQ9=rNVw1XVumLxX9y4VszWvVAg@mail.gmail.com>
Subject: Re: [PATCH 4/4] hw/net: xilinx_axienet: Fix DMA RX IRQ if ethernet
 disable RX
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Alistair Francis <alistair@alistair23.me>, Jason Wang <jasowang@redhat.com>, 
 "open list:Xilinx Zynq" <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=jim.shu@sifive.com; helo=mail-ed1-x52a.google.com
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

Hi Peter,

Thanks for the suggestion.

axienet_eth_rx_notify() is also called by axidma_write() as a notify()
callback, so we need to check RCW1_RX in the function.
I think I could remove RCW1_RX checking in the enet_write() to avoid
double checking.
I will fix it in the v2 patchset.


Thanks,
JIm Shu.

On Mon, Jul 29, 2024 at 11:31=E2=80=AFPM Peter Maydell <peter.maydell@linar=
o.org> wrote:
>
> On Fri, 26 Jul 2024 at 06:59, Jim Shu <jim.shu@sifive.com> wrote:
> >
> > When AXI ethernet RX is disabled, it shouldn't send packets to AXI DMA,
> > which may let AXI DMA to send RX full IRQs. It is aligned with real AXI
> > DMA/ethernet IP behavior in the FPGA.
> >
> > Also, now ethernet RX blocks the RX packets when it is disabled. It
> > should send and clear the remaining RX packets when enabling it.
> >
> > Signed-off-by: Jim Shu <jim.shu@sifive.com>
> > ---
> >  hw/net/xilinx_axienet.c | 71 ++++++++++++++++++++++++-----------------
> >  1 file changed, 42 insertions(+), 29 deletions(-)
> >
> > diff --git a/hw/net/xilinx_axienet.c b/hw/net/xilinx_axienet.c
> > index 05d41bd548..8428f10946 100644
> > --- a/hw/net/xilinx_axienet.c
> > +++ b/hw/net/xilinx_axienet.c
> > @@ -530,6 +530,40 @@ static uint64_t enet_read(void *opaque, hwaddr add=
r, unsigned size)
> >      return r;
> >  }
> >
> > +static void axienet_eth_rx_notify(void *opaque)
> > +{
> > +    XilinxAXIEnet *s =3D XILINX_AXI_ENET(opaque);
> > +
> > +    /* If RX is disabled, don't trigger DMA to update RX desc and send=
 IRQ */
> > +    if (!axienet_rx_enabled(s)) {
> > +        return;
> > +    }
>
> This checks s->rcw[1] & RCW1_RX, and does nothing if it's not set...
>
> >  static void enet_write(void *opaque, hwaddr addr,
> >                         uint64_t value, unsigned size)
> >  {
> > @@ -546,6 +580,14 @@ static void enet_write(void *opaque, hwaddr addr,
> >              } else {
> >                  qemu_flush_queued_packets(qemu_get_queue(s->nic));
> >              }
> > +
> > +            /*
> > +             * When RX is enabled, check if any remaining data in rxme=
m
> > +             * and send them.
> > +             */
> > +            if ((addr & 1) && s->rcw[addr & 1] & RCW1_RX) {
> > +                axienet_eth_rx_notify(s);
> > +            }
>
> ...but at this callsite we open-code a check on RCW1_RX and
> skip the call if it's not set. We don't need to check twice.
>
> >              break;
> >
> >          case R_TC:
>
> thanks
> -- PMM

