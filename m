Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93681606A322
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 14:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KkHB9Bpg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQQTp-00080M-V0; Mon, 09 Nov 2026 09:36:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xQQTm-0007zc-CQ
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 09:36:14 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xQQTk-0004ve-AM
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 09:36:14 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4a1b07c3c5fso9248005e9.1
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 06:36:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794234970; cv=none;
 d=google.com; s=arc-20260327;
 b=obOcZwQhPszzQF7EhIlCJkpb0jnmSyY15YAs7+daZYsJKGh7zPIx6S4+hdtqwAwHXs
 Ze+nn0umiq2+aDrGLKFy3osONOAyNRU08woYrDWNfF8DufZMmbRA+b4T2nX19LBgrZyj
 jBEtA74aAfIb7BdWXz1YWa2Dafnnbm6/T7aR+YtiMlGArq0TgG6X10B3cR/mVig2XfiG
 blnJoGmApZRyuNCvJdOVHOTW/jTilDfgEmWwWXw+pzteGlt3kGGW4d4g/Au6aa9j5Ok4
 bq3Upda5x5i3PdViShYkH7u5+MmlyEr8d2tu8TRCVNctlDzlZnfV/sHxSkSRrKNLBMsa
 rajg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=TVBu8g/B5Kvwm6IESzpiTvkWGu1aiceIrlaNOatg2jY=;
 fh=loEMbKDD5hcr9tXwr/SzxPa+U6G9WdqDQr7s3W5lPHc=;
 b=aelTFbO0xFOCIIXCkSCNeZfZyg1Ck83+cNQAe877e6G2MxQBLvcH+y9Gajw52oXb7N
 kKM61D+6xZYZhzVX9l0P0v/3KAkE7dp/3mRJnFjSxAisgiIvmGxxIxArXi/vVohDgG/W
 YK/OolZQwogPLArAgnjBcDdcxvIl60NsI2UoKjLi9eb3SIYHP30aCX03XSdlIYia4kTL
 Ju2lrTs6y5SgyWslaEjNGzRdfIrraSfPeo0So4P3cIqrWZ8RrCTrP2+vgfYrZTUwrflp
 rFwr6vNcRJzyaBZVs2HpW2RPJvFDfnnhox6SP8Q9L9XOkWsswiIJ3OFbuBj+AY3et0l7
 VfRQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794234970; x=1794839770; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TVBu8g/B5Kvwm6IESzpiTvkWGu1aiceIrlaNOatg2jY=;
 b=KkHB9Bpgmb47xAMWMtSgJT+cId6K7lT2VzCnNJVzVC85SIylTiRfKDqrCSXtLHRGNs
 JxqdN8y82r5UmlM+2Q6mfVX1kwbV2Tur+QXwJtihy9O774odt+OfjNju3nEcnuNh9b8+
 XdTpRYv3JTvULaYOvk9icR+zmGPwGKaVpV9ly2zA+1oggWYuXMXIZ95kgWXSxo+g5jnH
 kyjE1ShsV/v3ufuu0q/mzWTo+zhDi5cT0rIMBFaHdADYnxCLXcdFvKv6YVEffqva2xJK
 V2mLwc4dTScE2xy0AZ4thDxSxGWWh0mERexxElSsq68H4e9+iqpfPpEY+KNTwiiFTB0M
 22cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794234970; x=1794839770;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TVBu8g/B5Kvwm6IESzpiTvkWGu1aiceIrlaNOatg2jY=;
 b=TTf1RmPSRPVqof/FhweVNSRPFptHUIsA5m2rYDTB0PB2fnKfbBA4Qw5wl09yCAcyzB
 kBvdMXu5s59Xr30qWe6jVdrR+/eNkY3Wq+KBPY89is74ZZA8M12uiJ64yiGOM1QcBHoA
 6GW3INxYxCtuTDTnXRTwzRjpZ4xHAJBvO2fPAbhOxfJzAdw4ZO4gT2aMvmzfl6tlN7rt
 /TCYC7aeD47nGpOGvnmrUj0g43Mbg/2JaVQ6P9fN1zYPE6A6AUXOmCEXY6IkOZZE5lG6
 Dqc8EMUwRcg3KMA91yT/GwQjKEcldwBSc1KrryjiW5u/9CqHlk1eEqgclqOvv3Fg9KVA
 ERiw==
X-Forwarded-Encrypted: i=1;
 AL+hErGzQKwQpCQc2XyyJSyCaWEDQXy71FKV71Q/MwkDZffcmCGf8Eyd5zzXPdfPTqIwH2taqVCzDzbJeMFL@nongnu.org
X-Gm-Message-State: APuU4Z+TaEdeO1dKWabg001hcY4qxPay80jffLyCZ4iHxDc1OPFAkwBX
 /6MIw5WFPcuMkuECoaCcZcN82jrQQO0paBIV274OiJuawB0hxg7hGENKvVNjmjkp19WF08vsr6D
 ux1+4XU3QdTGy6kxDGUgDeSULlvk0b0s=
X-Gm-Gg: AYBFou1zpDk/XrokhLYCQLsbhkE4x1yt5GjV1X7CByQGFDqePNdiOHy7f77yAJ+gXvr
 7wOyBB6IzOeDCqC6jgQMa93OKDt1U2vsAVNM7LijobpgExg9WadB5SMhovrjnycuBelvHkkz9bg
 FIYx4jM6G/FfflZ6/BE6TM0of/JXuIju76ZPEgzRCqzmvwi4tJcamUZ1lwPRrEGq6QV8hovAnvA
 u7JbSq+Q2YzrjnLkcPxwA0kTMYtK4eZF0/P/hCnBsMgKPQzuVzVXXpSLivlAMnQCmQ+cxxhCDge
 gdDGpBKeIrvkmMclLPoEwy0rCtrLkVfD5qhZSNbz8toWnzhmq6ubNRJmkno2vGXdCvz0y2Y/OXY
 /MnYSkKYk8RoA7PQb5httoBqIJTPoPmlV3EywTKoZjfduhcHROSYumM2EFlOQXzdq9JBuZaJDsw
 vv
X-Received: by 2002:a05:600c:3b8e:b0:4a7:9006:b176 with SMTP id
 5b1f17b1804b1-4b9633cf5b0mr99246795e9.7.1794234970303; Mon, 09 Nov 2026
 06:36:10 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260927075108.3621107-1-bin.meng@processmission.com>
 <6047095a-2957-4d8d-99aa-055a63d753e8@oss.qualcomm.com>
In-Reply-To: <6047095a-2957-4d8d-99aa-055a63d753e8@oss.qualcomm.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 9 Nov 2026 22:35:53 +0800
X-Gm-Features: AclHuK_73O5XZBJwLrja-nTfhBi1T3yczL4izwOEthIrvrEZtdSUsx5R4gUt_jA
Message-ID: <CAEUhbmU7McatVYi4ONnsc2hGbiQy1wzbNGPTk2O+CDGDdyyZNQ@mail.gmail.com>
Subject: Re: [PATCH v2] hw/net: cadence: Honor subword lanes in the GEM
 registers
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>, 
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Jason Wang <jasowangio@gmail.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=bmeng.cn@gmail.com; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Philippe,

On Mon, Nov 9, 2026 at 9:58=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> Hi Bin,
>
> On 27/9/26 09:51, Bin Meng wrote:
> > The GEM MMIO callbacks ignored the low address bits and access size.
> > Byte reads therefore always returned lane zero, causing guest driver
> > that reads the station address byte by byte to turn four unique MAC
> > addresses into the same value. Partial writes had the corresponding
> > lane-selection problem.
> >
> > Extract the requested little-endian read lane and merge partial writes
> > with the current register value. Preserve the existing read-clear,
> > write-clear, and command side effects, including dynamic queue
> > pointers.
> >
> > Fixes: e9f186e514a7 ("cadence_gem: initial version of device model")
> > Signed-off-by: Bin Meng <bin.meng@processmission.com>
> >
> > ---
> >
> > Changes in v2:
> > - drop the gem_get_register() helper
> >
> >   hw/net/cadence_gem.c | 55 +++++++++++++++++++++++++++----------------=
-
> >   1 file changed, 34 insertions(+), 21 deletions(-)
>
>
> > @@ -1636,35 +1639,43 @@ static void gem_write(void *opaque, hwaddr offs=
et, uint64_t val,
> >           unsigned size)
> >   {
> >       CadenceGEMState *s =3D (CadenceGEMState *)opaque;
> > -    uint32_t readonly;
> > +    uint32_t access_mask;
> > +    uint32_t writable_mask;
> > +    uint32_t write_val;
> > +    unsigned shift;
> >       int i;
> >
> >       DB_PRINT("offset: 0x%04x write: 0x%08x ", (unsigned)offset, (unsi=
gned)val);
> > +    shift =3D (offset & 3) * 8;
> > +    access_mask =3D MAKE_64BIT_MASK(shift, size * 8);
> > +    write_val =3D (uint32_t)val << shift;
> >       offset >>=3D 2;
> >
> >       /* Squash bits which are read only in write value */
> > -    val &=3D ~(s->regs_ro[offset]);
> > -    /* Preserve (only) bits which are read only and wtc in register */
> > -    readonly =3D s->regs[offset] & (s->regs_ro[offset] | s->regs_w1c[o=
ffset]);
> > +    write_val &=3D ~(s->regs_ro[offset]);
> >
> > -    /* Copy register write to backing store */
> > -    s->regs[offset] =3D (val & ~s->regs_w1c[offset]) | readonly;
> > +    /* Copy writable bits in the accessed lanes to the backing store *=
/
> > +    writable_mask =3D access_mask &
> > +                    ~(s->regs_ro[offset] | s->regs_w1c[offset]);
> > +    s->regs[offset] =3D (s->regs[offset] & ~writable_mask) |
> > +                      (write_val & writable_mask);
> >
> >       /* do w1c */
> > -    s->regs[offset] &=3D ~(s->regs_w1c[offset] & val);
> > +    s->regs[offset] &=3D ~(s->regs_w1c[offset] & write_val);
> >
> >       /* Handle register write side effects */
> >       switch (offset) {
> >       case R_NWCTRL:
> > -        if (FIELD_EX32(val, NWCTRL, ENABLE_RECEIVE)) {
> > +        if (FIELD_EX32(write_val, NWCTRL, ENABLE_RECEIVE)) {
> >               for (i =3D 0; i < s->num_priority_queues; ++i) {
> >                   gem_get_rx_desc(s, i);
> >               }
> >           }
> > -        if (FIELD_EX32(val, NWCTRL, TRANSMIT_START)) {
> > +        if (FIELD_EX32(write_val, NWCTRL, TRANSMIT_START)) {
> >               gem_transmit(s);
> >           }
> > -        if (!(FIELD_EX32(val, NWCTRL, ENABLE_TRANSMIT))) {
> > +        if ((access_mask & R_NWCTRL_ENABLE_TRANSMIT_MASK) &&
>
> This new TX-enable check should either be in a distinct logical
> patch, or described in patch description.
>
> > +            !(FIELD_EX32(s->regs[offset], NWCTRL, ENABLE_TRANSMIT))) {
> >               /* Reset to start of Q when transmit disabled. */
> >               for (i =3D 0; i < s->num_priority_queues; i++) {
> >                   s->tx_desc_addr[i] =3D gem_get_tx_queue_base_addr(s, =
i);
> > @@ -1679,37 +1690,37 @@ static void gem_write(void *opaque, hwaddr offs=
et, uint64_t val,
> >           gem_update_int_status(s);
> >           break;
> >       case R_RXQBASE:
> > -        s->rx_desc_addr[0] =3D val;
> > +        s->rx_desc_addr[0] =3D s->regs[offset];
> >           break;
> >       case R_RECEIVE_Q1_PTR ... R_RECEIVE_Q7_PTR:
> > -        s->rx_desc_addr[offset - R_RECEIVE_Q1_PTR + 1] =3D val;
> > +        s->rx_desc_addr[offset - R_RECEIVE_Q1_PTR + 1] =3D s->regs[off=
set];
> >           break;
> >       case R_TXQBASE:
> > -        s->tx_desc_addr[0] =3D val;
> > +        s->tx_desc_addr[0] =3D s->regs[offset];
> >           break;
> >       case R_TRANSMIT_Q1_PTR ... R_TRANSMIT_Q7_PTR:
> > -        s->tx_desc_addr[offset - R_TRANSMIT_Q1_PTR + 1] =3D val;
> > +        s->tx_desc_addr[offset - R_TRANSMIT_Q1_PTR + 1] =3D s->regs[of=
fset];
> >           break;
> >       case R_RXSTATUS:
> >           gem_update_int_status(s);
> >           break;
> >       case R_IER:
> > -        s->regs[R_IMR] &=3D ~val;
> > +        s->regs[R_IMR] &=3D ~write_val;
> >           gem_update_int_status(s);
> >           break;
> >       case R_JUMBO_MAX_LEN:
> > -        s->regs[R_JUMBO_MAX_LEN] =3D val & MAX_JUMBO_FRAME_SIZE_MASK;
> > +        s->regs[R_JUMBO_MAX_LEN] &=3D MAX_JUMBO_FRAME_SIZE_MASK;
> >           break;
> >       case R_INT_Q1_ENABLE ... R_INT_Q7_ENABLE:
> > -        s->regs[R_INT_Q1_MASK + offset - R_INT_Q1_ENABLE] &=3D ~val;
> > +        s->regs[R_INT_Q1_MASK + offset - R_INT_Q1_ENABLE] &=3D ~write_=
val;
> >           gem_update_int_status(s);
> >           break;
> >       case R_IDR:
> > -        s->regs[R_IMR] |=3D val;
> > +        s->regs[R_IMR] |=3D write_val;
> >           gem_update_int_status(s);
> >           break;
> >       case R_INT_Q1_DISABLE ... R_INT_Q7_DISABLE:
> > -        s->regs[R_INT_Q1_MASK + offset - R_INT_Q1_DISABLE] |=3D val;
> > +        s->regs[R_INT_Q1_MASK + offset - R_INT_Q1_DISABLE] |=3D write_=
val;
> >           gem_update_int_status(s);
> >           break;
> >       case R_SPADDR1LO:
> > @@ -1725,7 +1736,9 @@ static void gem_write(void *opaque, hwaddr offset=
, uint64_t val,
> >           s->sar_active[(offset - R_SPADDR1HI) / 2] =3D true;
> >           break;
> >       case R_PHYMNTNC:
> > -        gem_handle_phy_access(s);
> > +        if (access_mask & (R_PHYMNTNC_OP_MASK | R_PHYMNTNC_ST_MASK)) {
>
> A byte write to another lane no longer starts a PHY operation;
> worth mentioning in the description?
>
> > +            gem_handle_phy_access(s);
> > +        }
> >           break;
> >       }
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
>

Thanks for the review.

I will add some descriptions in the commit message in v3.

Regards,
Bin

