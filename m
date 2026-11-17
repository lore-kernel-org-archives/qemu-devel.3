Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533DA606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 09:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=VeFQeyDM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTFpI-0000hC-19; Tue, 17 Nov 2026 04:50:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xTFpF-0000h0-Sv
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 04:50:05 -0500
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xTFpD-0006AB-QM
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 04:50:05 -0500
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-67be1e468a8so3433786d50.0
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 01:50:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794909002; cv=none;
 d=google.com; s=arc-20260327;
 b=d2y6Q5zk0XnBeGR5ERPoK7NQitzn2i97PzGEntGF28mCB2CKEHNakjXoMA+Y4BErdb
 fFZbu/hEIQVaGS4P4nCdR6/7mKRZZr9WjLCxA5G7ii6XrxhkN3X/kAD4yhIGk6hCB2r9
 ZC6BqzHrbvYoLSz6Vx3u4cpp68JYww8+PPUwblwqWjjcOsVV8ps/q0ofAhhyW/y+SKUI
 G1E9FOMZKtXQ8oxFuL5gb0ebvfHjWBfqCXpjMiPiENWoDnCk/G+T55alG6Iri0dkY1R7
 J55vQ8yA9iFGA/VHSSsDI7IXQUU9Gf/7dPjC6YSlAoKkBoIbThbrrknHekd++nNpuKoz
 eQeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=E3CNOD8dA5ZafE+nxPTtNWf0ATM8QrOkHaNcJSHg1ZU=;
 fh=MrV9cXt2uLRQ8LpXiA2NOxutgQNP8RXusX5akFbzq8A=;
 b=UNtK+uqSkAxUu+b+wb1X2FiRYfNvsNwa1uW3CceMXCdrnu366ytId/DYXutzKL1V7k
 97l5E+0yPizFqeABriiU4yfRP4mR4M5vy2DN0HQzyTMQUcv96D0zeDPLIgGbhNn4sCGo
 fgZF6uzC524chuFpirNZ47Aju2kYXnC1g4bmRn4AtGcJEIS8jgLV9Xr5iW7H9AvhCeRs
 XpYgjzY6cjXoXTfjww/T67+ZoJU0qaKiUvci15O06ebZGt31FQe3g0Mn5LSj1NhxmsX4
 ZQqFuLlLBf4S46A5jHdPe6jBmFZpTytE0pr7ZSUPvx/LdL3xulslLaMtRCsZwSKRddDO
 Xi9g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794909002; x=1795513802; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=E3CNOD8dA5ZafE+nxPTtNWf0ATM8QrOkHaNcJSHg1ZU=;
 b=VeFQeyDMoqDykRi8grRh3dQ6Q700wR6WnESrXtPIK+8YenLMI1Go6LE+1UwWPKhU34
 Dzq9vbiOjgFIHLdeN5PZ3AphBUG8Q0UrGdijk6pGQ6DaS5vf+o7wYb/CvK2MZexl7S5k
 MsijSMM0cio7JoGY/6OEFp34JbFmEeO0ZNQ1LLqJ+O9PV9FiZ3swXKGYMoLd+AtTTNqo
 wnJqqkyEEGPJ5WHpI7Z8qdbaEDgpWmLnppEgvbQa57GtLphdh4XHxpscmK5XN1Qc59e0
 YCHhu5jB0zqfRRIdDTNUMzrbZKFT5rwGAXWZyoNd7jD/nYXK/fV8lg23FuFtiwBs4rG6
 /Vyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794909002; x=1795513802;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=E3CNOD8dA5ZafE+nxPTtNWf0ATM8QrOkHaNcJSHg1ZU=;
 b=lHBF2X2TKukQyGFKv/jklqlqw8u5VwwQms/fUQ7b0pHOSgNr6hYXBU3jLrcyayTrVq
 sAhtE6CbzGhNHFkNmDxErWhtW6PtK0hQ6+CVxUaQgOJecAehHOn+mTRz3eLrGS1WtWoy
 WdbHzk9Pxx7kuruI9goGPKN+QaAPgEnnpNWifT1HOQFAf/0jHxduAZljKyd3ykXmlfED
 MrQriFMBhqP8qoIMAEHr2g8WLqDNVnP5w0VmBRsx6reevN/4CcRbjvmJXxHWhoJD0nab
 KypXkTx/LXqtyrJmzwFb4fAioqz5YRWtpnMmig9LCVCiCkP53VHii8mhzbVDMyE+p5c2
 OdVQ==
X-Gm-Message-State: APuU4Z9V/bfWHJRxTkU3npXCR0dbipu6QGAXpK1lZ0oR1Qlg6SeYDdZD
 gvlJdu7tamoRZbpNhffcjBLTtEx8OnLYaWCXPd4a5l77Sq0KZDrg8qe2WutKNtN+UtXTI8VUZA5
 vaAMZ+yKPUUCGYlBfRuT0/n7DTOb4OxS0knUoxU3/mg==
X-Gm-Gg: AZFdTZffdrkaTkyS6U8acqmUu14gbtoqimkam+BJMpx5WYweXqybbNdfsALJjm4WRVB
 ZDDrvF1TCLY0RprP4XJo0vCQYKTBc1ipRLGGN3h3TnZuFEe0yhxYDHpIdy2pjVIW/Upk4ypnjYJ
 4FVQyW8cIHnfWzYEqqbLFU9MvxZgDRj5SCQF5pBdlh6ARqSkO9fgRudnEzIVH3soNuO6ISpxsBL
 VGhFqundIJDbbeYGlqNCr5gRL5Y92mLRr/gX+MqINRmOOf1HG43f7TUeICm0aP4x8T3OnwGCFGo
 cPFJju3tTriLLcuise0/2z4dtCdnd5htKM5iPpS/1eoyWwWfqs2xr6XdaXW/dsG+p+n9vm3XwFd
 VrquX4YMSbPwmWizWuxo19tm2KUQn0yt6eo0km4cWO1PJ867xZ5I8QQjiYv/+a8Xnu2MX6pOmaO
 gpPK0XxtKMQMKRmfN3cew1
X-Received: by 2002:a05:690e:4843:b0:67c:1383:1d68 with SMTP id
 956f58d0204a3-67d89707fd3mr5298046d50.76.1794909001609; Tue, 17 Nov 2026
 01:50:01 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261113165015.1150646-1-peter.maydell@linaro.org>
 <66899f0f-8f36-4963-a899-6a960dd3f963@oss.qualcomm.com>
In-Reply-To: <66899f0f-8f36-4963-a899-6a960dd3f963@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Nov 2026 09:49:49 +0000
X-Gm-Features: AclHuK_-4gRosQrz_MiG5q0ZVB3CuusV24KrBorHLhkeRrMtLC1TXb4Y6TtWoZY
Message-ID: <CAFEAcA-YC4siSNtZUXdMzFWh6fZWPKBbQKctX9rUWT9hghduBA@mail.gmail.com>
Subject: Re: [PATCH] hw/net/rtl8139: Limit DMA transfers to plain memory
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowangio@gmail.com>, 
 Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 16 Nov 2026 at 22:19, Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> On 13/11/26 17:50, Peter Maydell wrote:
> > There's no reason for the RTL8139 to be doing a DMA transfer to
> > something that isn't memory, and allowing it can cause weird
> > re-entrancy problems, such as a DMA to the PCI hot-unplug register
> > causing the device to be deleted while it's halfway through doing
> > something.
> >
> > Replace the calls to pci_dma_read() and pci_dma_write() with
> > local functions that are identical except that they pass
> > a MemTxAttrs that forbids non-memory accesses.
> >
> > This is the same approach we took to a similar problem with
> > the hcd-xhci USB controller in commit 89e653b7736 (but differs
> > from what we did for lsi53c895a in commit 4862d2c95104d).
> >
> > The known trigger for this bug requires that you turned off
> > ACPI hotplug on the QEMU commandline with
> >    -global ICH9-LPC.acpi-pci-hotplug-with-bridge-support=3Doff
> > so most configurations won't run into it.
> >
> > Cc: qemu-stable@nongnu.org
> > Fixes: 3ada003aee2004d24f2 ("rtl8139: Use PCI DMA stub functions")
> > Fixes: CVE-2026-128868
> > Reported-by: VictorCHEN <ahchen-yz@outlook.com>
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> > I'm also wondering whether there's an approach to this class of
> > bugs that would avoid us having to modify specific devices to
> > insist on DMA-to-memory. It seems a bit dubious that writing to
> > the PCI hot-unplug register can cause us to unrealize the plugged
> > device even if lots of other things are still holding a reference
> > to it. Or else we need to be more specific that you can still
> > validly (in the sense of "doesn't break things") do things on or
> > as part of an unrealized-but-not-yet-freed device, and move
> > things like pci_config_free() from unrealize to deinit.
>
> While still thinking about that, ...
>
> >
> >   hw/net/rtl8139.c | 98 +++++++++++++++++++++++++++++------------------=
-
> >   1 file changed, 60 insertions(+), 38 deletions(-)
> >
> > diff --git a/hw/net/rtl8139.c b/hw/net/rtl8139.c
> > index 16479284eea..6644c1b62c5 100644
> > --- a/hw/net/rtl8139.c
> > +++ b/hw/net/rtl8139.c
> > @@ -513,6 +513,28 @@ struct RTL8139State {
> >       int rtl8139_mmio_io_addr_dummy;
> >   };
> >
> > +/*
> > + * There's no reason for the RTL8139 to do DMA to something that
> > + * isn't memory, and it can cause weird re-entrancy problems if e.g.
> > + * a DMA write targets the PCI hot-unplug register for the device.
> > + * Set memory=3D1 in the memory attributes to avoid that kind of thing=
.
> > + */
> > +static MemTxResult rtl8139_dma_write(PCIDevice *dev, dma_addr_t addr,
> > +                                     const void *buf, dma_addr_t len)
> > +{
> > +    const MemTxAttrs attrs =3D { .memory =3D true };
> > +    return pci_dma_rw(dev, addr, (void *)buf, len,
> > +                      DMA_DIRECTION_FROM_DEVICE, attrs);
> > +}
> > +
> > +static inline MemTxResult rtl8139_dma_read(PCIDevice *dev, dma_addr_t =
addr,
>
> (drop inline)

Agreed. This was a cut and paste from the pci_dma_read() prototype.

> > +                                           void *buf, dma_addr_t len)
> > +{
> > +    const MemTxAttrs attrs =3D { .memory =3D true };
> > +    return pci_dma_rw(dev, addr, buf, len,
> > +                      DMA_DIRECTION_TO_DEVICE, attrs);
>
> ... these new helpers correctly return a MemTxResult but the
> callers still ignore it. I appreciate this would be a larger
> rework, unlikely worth it. What is your plan?

I don't care enough about the rtl8139 to do that kind of spring
cleaning on it (and a memory transaction error will only happen
if the guest is doing something stupid, in which case we don't
care as long as it doesn't cause actual security problems).
My aim at the moment is only to try to get our backlog of
"confidential" bugs down...

thanks
-- PMM

