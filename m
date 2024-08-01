Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C7DDC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 13:56:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZWHP-0006mY-Oh; Thu, 01 Aug 2024 09:55:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1sZWHK-0006in-7C
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 09:55:38 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1sZWH8-0002ka-PE
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 09:55:28 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-52efa16aad9so10134307e87.0
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 06:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1722520524; x=1723125324; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0MZp10X+tqR0pGIQSfiNJKCWljR+FU4ph0z8rqaSaxI=;
 b=Sp5EDIRbZgXOK2dlk+r6TibCqDtaP/H5cIhNOogu6nrgGeStrmnO0JnPL/o0KKXQoo
 FCivTyt9Lb4WFzQkYzixHYqdcw6fUQ44st+67N6XkQ81BgFqQCTIsdMG3P+Z3qX7sMAB
 tbvAbDtTA9OVOYtmD1ytMh3kvDkB7SwVdFfEfc3CsRyhn9SNjmTSC3q1pQYYrulDUjpi
 PAgpdD1873gWfHVgF+/9EJUxwSHMer9oOTFPbVn414KbYq5QvcEMAFSXIAKzmmpC7vzH
 IWU+7UwM8TCOiKCFfQtHWnx6PM9icoWqMEoiorjwrR06Fe+iH57iskCffmB/xJGrjRkD
 JR+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722520524; x=1723125324;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0MZp10X+tqR0pGIQSfiNJKCWljR+FU4ph0z8rqaSaxI=;
 b=tnZuwDKB4JE66X9EaKBWoIuB3uQGLwcoVXV9mIKusiU/NIAdWRdbZ+G1XBjCvnmxqo
 AG8wG3pN4Dhox7KE1WMWyPcFVMKckqHlzDE9/YURqE8wtbCRyzXuXCulDGck+ZX6EzdL
 W2zxrmI4mHxiHtbc2TOH9i+aaowf0qfSxFEuIcf9OLZFYRtb3ybxiIrJqN/OVUUi/3XZ
 c6bc/zghUhHSWC+hiwcl1aknBxgr4FTGJ+bzuoo1dwYDaooQDL4GBC+jOd1gNpkqfLDO
 S9ECKSgl5FzSogLh0TIs/vwrrs879Gtu/iuY8TnLOQlAntbTANYFISejG2ySJzDc8Ujn
 xfBQ==
X-Gm-Message-State: AOJu0YwJTLdnbxqrUdDevhyYDbbHjaLPqrW2DCkSzwXpMdG1skGj/HK1
 MDk9yKpptzkJpCWkQnK57r+F06sjLAaofhZN4XKf31SoPLI2Vlc1oVXzJ30lR6yFSY8qYMs7k1b
 OheafR1X/89L3XR88fid47WKtcfYuZEcMA+1Icg==
X-Google-Smtp-Source: AGHT+IHfX7a8uakm6dXY8HZDKoDTAwMEJDMWCBu2MDYl5wCN1PQ26MyOg/ovo6iNcOOGYCpJzxnnZ4elH7VawSGzFkg=
X-Received: by 2002:a05:6512:2c03:b0:52e:9ac6:a20f with SMTP id
 2adb3069b0e04-530b61ed13bmr1557976e87.37.1722520523597; Thu, 01 Aug 2024
 06:55:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240726055933.817-1-jim.shu@sifive.com>
 <20240726055933.817-4-jim.shu@sifive.com>
 <CAFEAcA-ZkcJvFkYyHGi9bXoPvqEzvV0b_z6xaQPLMK9qNHSdCA@mail.gmail.com>
In-Reply-To: <CAFEAcA-ZkcJvFkYyHGi9bXoPvqEzvV0b_z6xaQPLMK9qNHSdCA@mail.gmail.com>
From: Jim Shu <jim.shu@sifive.com>
Date: Thu, 1 Aug 2024 21:55:12 +0800
Message-ID: <CALw707rwo8w3kFaga_17H+7JPneA7kahqBiLqwo6KGohLV0_SA@mail.gmail.com>
Subject: Re: [PATCH 3/4] hw/dma: xilinx_axidma: Reset qemu_irq when DMA/Stream
 is reset
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Alistair Francis <alistair@alistair23.me>, Jason Wang <jasowang@redhat.com>, 
 "open list:Xilinx Zynq" <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=jim.shu@sifive.com; helo=mail-lf1-x132.google.com
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

Hi Peter,

Except DeviceState::reset(), stream_reset() is only used in
axidma_write() and axidma_write() has qemu_set_irq() at the end of
function.
I think this commit could be dropped. I will remove it in the v2 patchset.


Thanks,
Jim Shu



On Mon, Jul 29, 2024 at 11:23=E2=80=AFPM Peter Maydell <peter.maydell@linar=
o.org> wrote:
>
> On Fri, 26 Jul 2024 at 06:59, Jim Shu <jim.shu@sifive.com> wrote:
> >
> > Current DMA/Stream reset will clear interrupt pending bit of DMA device=
.
> > The qemu_irq of device should be updated at the same time.
> >
> > Signed-off-by: Jim Shu <jim.shu@sifive.com>
> > ---
> >  hw/dma/xilinx_axidma.c | 25 +++++++++++++------------
> >  1 file changed, 13 insertions(+), 12 deletions(-)
> >
> > diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
> > index 728246f925..beb3fbf1d5 100644
> > --- a/hw/dma/xilinx_axidma.c
> > +++ b/hw/dma/xilinx_axidma.c
> > @@ -177,11 +177,24 @@ static inline int stream_halted(struct Stream *s)
> >      return !!(s->regs[R_DMASR] & DMASR_HALTED);
> >  }
> >
> > +static void stream_update_irq(struct Stream *s)
> > +{
> > +    unsigned int pending, mask, irq;
> > +
> > +    pending =3D s->regs[R_DMASR] & DMASR_IRQ_MASK;
> > +    mask =3D s->regs[R_DMACR] & DMASR_IRQ_MASK;
> > +
> > +    irq =3D pending & mask;
> > +
> > +    qemu_set_irq(s->irq, !!irq);
> > +}
> > +
> >  static void stream_reset(struct Stream *s)
> >  {
> >      s->regs[R_DMASR] =3D DMASR_HALTED;  /* starts up halted.  */
> >      s->regs[R_DMACR] =3D 1 << 16; /* Starts with one in compl threshol=
d.  */
> >      s->sof =3D true;
> > +    stream_update_irq(s); /* Clear interrupt */
> >  }
>
> The general rule of thumb in QEMU is not to call
> qemu_set_irq() from a DeviceState::reset function,
> and xilinx_axidma_reset calls stream_reset. I think
> probably the best thing is to separate out whether
> this is a DeviceState::reset or a software-triggered
> reset, and only call qemu_set_irq() in the latter case.
>
> thanks
> -- PMM

