Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBC7606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 11:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=CWprE/EK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTH2q-0000M8-24; Tue, 17 Nov 2026 06:08:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xTH2k-0000Lu-IY
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 06:08:06 -0500
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xTH2i-0000uu-AI
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 06:08:06 -0500
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-67c0ffaae1dso725040d50.1
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 03:08:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794913683; cv=none;
 d=google.com; s=arc-20260327;
 b=S5I+Km0SXH2GmaGC17proMksuimTxfUSpoBZyxXszlByq8HYdHIV566gv5MnCN4ZB6
 DFXa/mv3Jf1Q9EejX4RU71HxnXSR/FswabNLvT4GmPv3N1n4Zw/jQQLyM9U0G3MZvGyr
 PxtZoYPBpYiDx3jNrbb43pE1swqcmqYSlDS4fk3NE925+MlbGbCHXyphGJu/ySUfSGVx
 9m+3kAQVf0bc1QBaO00W5QjxFx/+he2g+4dpvb2nPsn5tGdlojS1BfjzPVeHUvS3MF5S
 GAas6hyaVUlk4VuLm+Yfz9IOvswRksr/UU2noKyaL82OfUBUKOiorElO9a0RqYboxaTD
 Txew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ajuChSvi+Y0knblgUHlccGlvTxckcqioEsf+0rpegKc=;
 fh=43uPrQiE41v1lD+S+Pe1AOaz2boj03UOZVxoQZi8n/A=;
 b=oGVGmUiG4qUfVQkQR+F3B570stT1vM1OhYFqfQuIF69y4uzUXtvuxFYRTRXZ0jT5Ag
 of7BgEiw56ogwEFp152APNTyELvSzjgiDLM7+70nj9fRrpyyviksVNHxmEo6RqAlNRoS
 lzmmjZTOY1iBs2eiUSNkYUiIpGm0sZWh6vuoMmNlSI1nOS9Vb6jCyLm77CNH4qJNOgqK
 ZA2FMkd5Fknr0ntd5wkbOXAbR/Ruf44A/Fhbb2oRSoglgXK89fS3pjEbTrOjsdonq0wO
 APsgxItcQGJBjxFR9d8no8pUhNuYjP9YfE/R99Qm7xQbrQiM3fD4tV8LuDy/PZFU1ZAt
 t5XA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794913683; x=1795518483; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ajuChSvi+Y0knblgUHlccGlvTxckcqioEsf+0rpegKc=;
 b=CWprE/EKFseVufSwRIEczRIyQhZLn47+wpHnbg/TyraKM+99x6n2q1BieF0pvc1E1l
 l1mts5kRK0kaDZXJbbqwByItyFM9Wv4E65ixNPBbdLRfunWJx34c8MR3aoYHi53eJ9pd
 iLzRPs//Qt2blKVl+h5dHBX2WtvHHY9+9pQujYERZ07F/ddUS74JUpu6vA1jNlnvpsQQ
 ifencjiwvYnhtVBho0AZbgeFzHTzf9Ohlqnp8qBWlijwjTUFDXidBnEfLJsHmqNVfsqO
 LoNIwk5fSyVED6Xm9B32YYVtsoCMr9T38dTtwyPULmKIw4GHIoh0SMNUSbEXmQN6lObF
 jX8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794913683; x=1795518483;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ajuChSvi+Y0knblgUHlccGlvTxckcqioEsf+0rpegKc=;
 b=ytd3/Ju5j0Ky9U8FIub2KrpiGzJWIckpSdf159x/dfBro1Iw7EWlLXFcRRPwQh5KOi
 Dhij4deozs+zWR3JUZhawcernaTT9agM3/Atrq1zLsUgrsiiHjzoReOKdIIp2bNgE/c5
 ZHr5XbEu9cFXXftIVfrPtYD1qaHJ/mWSkhvZxFp97i6mDtyImIiJXHV6AAR9uMWT1XAO
 6+pkj1J9IIyKY+y7MUzkCcOpOtTI2RgckRqKQAZ/9y2bdre7TfI5CiUDMqhKwaLCW5WV
 TbSyr7Rfr72lC4vmt/RKmZGmKWp3FN1dJZupp+ukHTXibRksRVyLiueR7QIz13AtHdjg
 u5AQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHN7ImBoJKhpr5zsGq47rEujLph+lzbJ5wnBLROMHByY00PC/Ul+V8+jZeSctM9OaWBf7XtOB3h7tGW@nongnu.org
X-Gm-Message-State: APuU4Z8ylxt390oZr9ONK42p6OHlvjdMFvpqjxAXA43ar4lPBolc3jGq
 SRaPiij3ubq6ocA0F3WrRZx8PcZPCvX908T6PDivRObWutkRM49pCFNUbp4Xptb6egtRlI+Nl64
 L1Tsra9XrKIoRc+TGibW60nEzSwihvyPoiJyJHdAe0g==
X-Gm-Gg: AZFdTZdRged++1lQ9w4vL+w6TbU0d6RYaznKXo3P419rd0aOSE4YkBHO6DwVTFxMC5V
 riVxKvVbOgCVU6t6vUzNGZW/lDjOfUZnYqb48FYenI7jWadTkaHSGzUBPIheAV83m63bYws/bvv
 GK9AdNwYRnbsXwzn5S6jei4/Nrvl0PLYuhdeGv/Ixd7koW2pmf6fhe3GcYOYJzKu37YY3vhSG/v
 dtD3d2f3I7qGkhYLDOdbNhqKJULZIcuTOQdlVqpOi0kORpsh9OgpdNdMSZlbgK/rPRLtcwmPS+H
 Nli23RB4LgpfaecHocSxvSYdgbjrQ+yYiL+WiXB+NOs4Pogl9ljIIO2xsaLj1p626muCr5JJMkj
 TheYE6IIpQKHEbti8yOd9msiWRziyp1udLOwiKn8yZgQs2xBzIhHK2Em3YfX+py9Jl9YV1On6TV
 mdIyJ90OMG1R6S1QNHlTPm
X-Received: by 2002:a05:690e:408c:b0:67d:a3c2:c95 with SMTP id
 956f58d0204a3-67dc76ab90cmr1557950d50.3.1794913682761; Tue, 17 Nov 2026
 03:08:02 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261113165015.1150646-1-peter.maydell@linaro.org>
 <66899f0f-8f36-4963-a899-6a960dd3f963@oss.qualcomm.com>
 <CAFEAcA-YC4siSNtZUXdMzFWh6fZWPKBbQKctX9rUWT9hghduBA@mail.gmail.com>
 <f04c5eb3-80c0-424c-a9ed-3a1f7df3922c@redhat.com>
In-Reply-To: <f04c5eb3-80c0-424c-a9ed-3a1f7df3922c@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Nov 2026 11:07:51 +0000
X-Gm-Features: AclHuK8daTyxKt_QKcjsJ7s4F6CyuNVGsPb8thEONxbDFTFUWb_5ze5J5OhoLeY
Message-ID: <CAFEAcA9xg-xvk7f8XVmq=QjWBcDThwwE6TZM=Xg6e9qPCAUD5Q@mail.gmail.com>
Subject: Re: [PATCH] hw/net/rtl8139: Limit DMA transfers to plain memory
To: Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 qemu-devel@nongnu.org, Jason Wang <jasowangio@gmail.com>
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

On Tue, 17 Nov 2026 at 11:02, Thomas Huth <thuth@redhat.com> wrote:
>
> Am 17.11.26 um 10:49 schrieb Peter Maydell:
> > On Mon, 16 Nov 2026 at 22:19, Philippe Mathieu-Daud=C3=A9
> > <philmd@oss.qualcomm.com> wrote:
> >>
> >> On 13/11/26 17:50, Peter Maydell wrote:
> >>> There's no reason for the RTL8139 to be doing a DMA transfer to
> >>> something that isn't memory, and allowing it can cause weird
> >>> re-entrancy problems, such as a DMA to the PCI hot-unplug register
> >>> causing the device to be deleted while it's halfway through doing
> >>> something.
> >>>
> >>> Replace the calls to pci_dma_read() and pci_dma_write() with
> >>> local functions that are identical except that they pass
> >>> a MemTxAttrs that forbids non-memory accesses.
> >>>
> >>> This is the same approach we took to a similar problem with
> >>> the hcd-xhci USB controller in commit 89e653b7736 (but differs
> >>> from what we did for lsi53c895a in commit 4862d2c95104d).
> >>>
> >>> The known trigger for this bug requires that you turned off
> >>> ACPI hotplug on the QEMU commandline with
> >>>     -global ICH9-LPC.acpi-pci-hotplug-with-bridge-support=3Doff
> >>> so most configurations won't run into it.
> >>>
> >>> Cc: qemu-stable@nongnu.org
> >>> Fixes: 3ada003aee2004d24f2 ("rtl8139: Use PCI DMA stub functions")
> >>> Fixes: CVE-2026-128868
> >>> Reported-by: VictorCHEN <ahchen-yz@outlook.com>
> >>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> >>> ---
> >>> I'm also wondering whether there's an approach to this class of
> >>> bugs that would avoid us having to modify specific devices to
> >>> insist on DMA-to-memory. It seems a bit dubious that writing to
> >>> the PCI hot-unplug register can cause us to unrealize the plugged
> >>> device even if lots of other things are still holding a reference
> >>> to it. Or else we need to be more specific that you can still
> >>> validly (in the sense of "doesn't break things") do things on or
> >>> as part of an unrealized-but-not-yet-freed device, and move
> >>> things like pci_config_free() from unrealize to deinit.
> >>
> >> While still thinking about that, ...
> >>
> >>>
> >>>    hw/net/rtl8139.c | 98 +++++++++++++++++++++++++++++---------------=
----
> >>>    1 file changed, 60 insertions(+), 38 deletions(-)
> >>>
> >>> diff --git a/hw/net/rtl8139.c b/hw/net/rtl8139.c
> >>> index 16479284eea..6644c1b62c5 100644
> >>> --- a/hw/net/rtl8139.c
> >>> +++ b/hw/net/rtl8139.c
> >>> @@ -513,6 +513,28 @@ struct RTL8139State {
> >>>        int rtl8139_mmio_io_addr_dummy;
> >>>    };
> >>>
> >>> +/*
> >>> + * There's no reason for the RTL8139 to do DMA to something that
> >>> + * isn't memory, and it can cause weird re-entrancy problems if e.g.
> >>> + * a DMA write targets the PCI hot-unplug register for the device.
> >>> + * Set memory=3D1 in the memory attributes to avoid that kind of thi=
ng.
> >>> + */
> >>> +static MemTxResult rtl8139_dma_write(PCIDevice *dev, dma_addr_t addr=
,
> >>> +                                     const void *buf, dma_addr_t len=
)
> >>> +{
> >>> +    const MemTxAttrs attrs =3D { .memory =3D true };
> >>> +    return pci_dma_rw(dev, addr, (void *)buf, len,
> >>> +                      DMA_DIRECTION_FROM_DEVICE, attrs);
> >>> +}
> >>> +
> >>> +static inline MemTxResult rtl8139_dma_read(PCIDevice *dev, dma_addr_=
t addr,
> >>
> >> (drop inline)
> >
> > Agreed. This was a cut and paste from the pci_dma_read() prototype.
> >
> >>> +                                           void *buf, dma_addr_t len=
)
> >>> +{
> >>> +    const MemTxAttrs attrs =3D { .memory =3D true };
> >>> +    return pci_dma_rw(dev, addr, buf, len,
> >>> +                      DMA_DIRECTION_TO_DEVICE, attrs);
> >>
> >> ... these new helpers correctly return a MemTxResult but the
> >> callers still ignore it. I appreciate this would be a larger
> >> rework, unlikely worth it. What is your plan?
> >
> > I don't care enough about the rtl8139 to do that kind of spring
> > cleaning on it (and a memory transaction error will only happen
> > if the guest is doing something stupid, in which case we don't
> > care as long as it doesn't cause actual security problems).
> Maybe you could change the return type to "void" if it's ignored anyway, =
and
> simply do a qemu_log_mask(LOG_GUEST_ERROR ...) in the new function in cas=
e
> the pci_dma_rw failed?

That's doing more work than I want to do in a CVE fix.
The wrapper should continue to return the error status
as pci_dma_read and pci_dma_write did. Eventually somebody
might want to fix up the handling in the callsites.

thanks
-- PMM

