Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 598BCCA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 10:09:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEOaX-0008Jn-IB; Wed, 07 Oct 2026 06:09:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xEOaW-0008Ii-0Y
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 06:09:28 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xEOaU-00045m-Hb
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 06:09:27 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-8aea7b7ca0cso16082577b3.2
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 03:09:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791367765; cv=none;
 d=google.com; s=arc-20260327;
 b=jImaGNw2DBPoXA2RR5mTqyvkD8FGGRXM2hZiHM8Ks1Tyelsw292werGvBoGMHIzPVt
 D+XBnUfOF606kAfw0MzTrvbWZRom2zRr9rAJLxcM5Dy8PjVRH1I5SRWL/0AHszyYzXtJ
 32H5+iCnD02K0NrMnJqXhb5WRAgC9JFuKKfpI22znHKh3vZZwJPe06n8JGITl9oDBgvS
 gpNTpWed22R0wfy8Lmf5Nk4T+l4KLm4t+tEduCMxDfMPAu0xe/lFVY6Rh4o/BEc5t4mw
 5bS3VWvaONHXy4KYwlpIjGZNqhLvKoZOG7NbApthqFhsDqd52MUpjQ2qcm2wW8FoL2xD
 L6UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ZIgJ4Torh+ZfX/aU5V1SR2C2Y88pcVBPp0ItlG1t/C0=;
 fh=lwZ1tDgvKxBvFCD1ogU9hoBYmLUvJI5VH4rKkBPnHgc=;
 b=QH3jCKGSC1kJmmNVg3q3pji/YvFDGSQu/S51OgCiZXDlShv/X+2qnSl54c6ikgELhc
 1ei/VdtaLvrfK6f+NeFxf6S0qt39N2SD2B4pdIh8TSZB7y5XInm3ii6XJyGu9PWgCRsj
 PtbpHUIhE1R0kTLgg3aid1Y5AFmBxG/sblSdsClnLaGuitFjD6hk52mScW0irexaeOx6
 wOEXd5mEnmnuU5PE5xJogoBNeIT8UTnjVpfL6YzOj2mtkyLOClg7qgSCyaYWYOKO+Hlc
 2mRp3lDtPLWKVVF/nLcX5wQfgwDba5YZlUab4Emw/JvCRPD/qZotnvzjTtro+gJqkbca
 mEow==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791367765; x=1791972565; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZIgJ4Torh+ZfX/aU5V1SR2C2Y88pcVBPp0ItlG1t/C0=;
 b=HHBxF019qTILRloQC+y9TTZAT02+Ox9igpSO+O7AMB+i6n3E8PRS+NOsDvoP3D3Zyn
 1HCYEJpAWe8ChJ1wEjyuAzoqWVe5PAhnbV5uUgUhTh4M3v3NGTMb32RhWdODsCXrvqvZ
 Tc62PYMSRL0RSqn1uxXZCUzodnHclEc8rnehgJkyCDuqB1fMQxV2bgCJbaujU62Wjozw
 qPJ/6kD0MYu/lLA++GmtLFuuUBTXnzkQj3taXUfcPHIWMAV++6Y/jRlpD470PV0bpe5c
 7inUCX2kR8cNWhkc/HJxuw/MtdUJ3O6eS8kr+/acgSw8g1uDSyJAaeRsQdAunG6Kc/jz
 rjmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791367765; x=1791972565;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZIgJ4Torh+ZfX/aU5V1SR2C2Y88pcVBPp0ItlG1t/C0=;
 b=xj9fVjyWbt/zjRTdKyOemXe+KY+69uEzYsrzxBIILV5HG/8KDbvWjrGAzDdqTu5V/O
 u5YWyqMoqzb9jZQBUpq1fjFXwsm6u6sonLKueyK3h6eUoafn8gSPQSHw1WnRKtUahM9M
 9tW/s1h7K6OthigZEssJ6oatC22RFOw91REV40Vgx8zPvrbO1SvZavP8+C5DJnwXy+sD
 h4wSzgtCO8VXw268gXLJvP6nhBGAQE09v2NmhLkP9QQBlz/MicdBRJkQ+woLTfbAzTvC
 M2P66s1+Kb3A/obWwGf3+idT3FK8a1e5AQGqCvY+lo/Gxgo89ndk3GErkjxlThMZTx9Q
 bfvA==
X-Forwarded-Encrypted: i=1;
 AKwUvBypoVQJqvKT0DImbdOr3i2KjeyrZQqJt1MDFVuTmKLSw++NSPB2nViYbPjWjqLvtnLLT22fprUJJtKx@nongnu.org
X-Gm-Message-State: AFq9FYKJlMn4CfaaKRBe2KiTcs/nRBHmhInSTeEZkNmtakF9ploAgB1+
 mT8ZjmUa10Z2hTvGHsvIWoKODZJhKo1dDxQ/U7wAj5YzIXqnNCl6zJSZp415lKoiG3io45RgFHS
 l4xpzo5bmuS2CaYEoBHN8rsFcwbU1RK4=
X-Gm-Gg: AYBFou0PI1StilBs94D/rl6Zjxsi3+jXQu8egGoPLugpbZtrBfnyhMeiEphvSfEZpZD
 Plr9LAlQWeChs39jjpGkf+j6S4hsfsEw0nAJSYf43ZvnFpMY8clSVAoNMy4e8gco6vmGqISg72G
 B3VDeFb0P9aW4ApP09B1OjHI5kJsRSC4w/UaSbEj59BCotCu4jZ0KxCUNcpcg3qEqg+wrjMCDYu
 HRe6Tgehl39OCOJFVkj6t8pj9JtG1tmVyP1frvgHCOdGsOEPdfiEdoG0wzOyN0njKO50+0Expgh
 DD9qnjKC4a6nGT/3OEbmbQ33psReV/5MeNBypyNISaKWkN0Ir2cQkn4XiI3V2pcL7qbYLYRnGDw
 JXenhHlrq8E0J35Y=
X-Received: by 2002:a05:690c:10:b0:8ae:dfee:cd2d with SMTP id
 00721157ae682-8b05aff25bcmr13543247b3.66.1791367765124; Wed, 07 Oct 2026
 03:09:25 -0700 (PDT)
MIME-Version: 1.0
References: <20261004090500.3082641-1-bin.meng@processmission.com>
 <20261004090500.3082641-2-bin.meng@processmission.com>
 <CAFEAcA_U-Aoo1MmvAm61_HxhbA+1A-YX1g+oh=1THsi9QKBeOg@mail.gmail.com>
In-Reply-To: <CAFEAcA_U-Aoo1MmvAm61_HxhbA+1A-YX1g+oh=1THsi9QKBeOg@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Wed, 7 Oct 2026 18:09:12 +0800
X-Gm-Features: AclHuK-RAiyvgyHssYuZJo8Fm-r1oxm2Ng2UU8GMD6r6juHcb4JuJ9yaRlG7eF0
Message-ID: <CAEUhbmWxS3XRfP4-Uj8MuMoeBb05YCyhHAzJc+_My6kj7L_qKA@mail.gmail.com>
Subject: Re: [PATCH v3 01/10] hw/cpu: a15mpcore: Model the reserved page as
 RAZ/WI
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yw1-x112f.google.com
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

On Wed, Oct 7, 2026 at 4:41=E2=80=AFPM Peter Maydell <peter.maydell@linaro.=
org> wrote:
>
> On Sun, 4 Oct 2026 at 10:05, Bin Meng <bin.meng@processmission.com> wrote=
:
> >
> > U-Boot's shared i.MX6 identification code reads PERIPHBASE + 0x4 on
> > MCIMX6UL-EVK. The first private peripheral page is currently unmapped,
> > so that access causes a data abort before the console is ready.
> >
> > The GIC-400 register map reserves offsets 0x0000 through 0x0fff and
> > specifies read-as-zero, write-ignored accesses to reserved locations.
> > Model that page in the private peripheral device.
> >
> > Reference: GIC-400 TRM (ARM DDI 0471B), sections 3.1 and 3.2
> > https://documentation-service.arm.com/static/5e8f15e27100066a414f7424
>
> The Cortex-A15's internal GIC isn't a GIC-400, as far as I know.

The Linux kernel says it is a GIC-400 on i.MX6UL
https://github.com/torvalds/linux/blob/master/arch/arm/boot/dts/nxp/imx/imx=
6ul.dtsi#L158

intc: interrupt-controller@a01000 {
    compatible =3D "arm,gic-400", "arm,cortex-a7-gic";

>
> > Signed-off-by: Bin Meng <bin.meng@processmission.com>
>
> RAZ/WI doesn't match the documented behaviour of the Cortex-A15
> for this region in its TRM:
>
> https://support.arm.com/documentation/ddi0438/i/generic-interrupt-control=
ler/gic-functional-description/gic-memory-map?lang=3Den
>
> "Read access to reserved regions results in a Data Abort exception to
> the requesting processor. Write access to reserved regions results in
> the assertion of nINTERRIRQ."
>

It seems the A15 manual and GIC-400 manual are contradictory. I am not
sure how to proceed.

Regards,
Bin

