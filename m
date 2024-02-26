Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C89AC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 14:52:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rebDK-0007TX-S3; Mon, 26 Feb 2024 08:40:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rebDI-0007Sv-7Y
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 08:40:12 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rebDG-000561-Io
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 08:40:11 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-565d1656c12so2283068a12.1
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 05:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708954809; x=1709559609; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jieytYaQ+nN4bXnK0Fs+GW555aeEe4W+nRHFe6bD0Og=;
 b=UqQWX75R4GRiaj4lmFuDFlBtOrb0408soJhfPLMeuc8l1OBvVCOcIja7D/KRtnyihl
 BUvyJaZGNvGPY10KG3EI/GqB78w3esR6noZ9/G4qpdXUBPHDvW7p2b4JOb4UF7NYmANL
 yCfVaJ3sRSaNIM6HNaPsoUEGFibc3uxAwk2P4Fu0OfqWmkadEOM7zyy0omzwifxrv5ZF
 EjezDVQgvuGPncWvXkqyYmT68kQTrYCTEg6v6jaCNWaEpvPsI1otiLD3DnAydh1ZOQEA
 b8BNIbd8Ki+VSCx6u4z5lJ6RYmIhmnqd3F7/sqUx8ETSBSFKQdMpmtoQxWOgZ9r1/blV
 buMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708954809; x=1709559609;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jieytYaQ+nN4bXnK0Fs+GW555aeEe4W+nRHFe6bD0Og=;
 b=cl+F0MswdoUeociYSccJOEGHDgEZ6ZxBTOvo4rIQlxUrJJYqkEjJQ1oNUM0wQr2zB4
 G5pvRkY74pQHNmVAhyDBj8nPL1O72WZQEagRB72WVAEhXv9hVWT/Jr64/BFlzw35C/1H
 TVOQipKOHTnnDVxahuj1YfXYtnN6XJxfth2SPBCRqOnByp4DcAgCRlM114N0FzEROpFx
 JZmU3R2gPWkxERVVXx6pg0VRr85H5nIwBMfJZfrSCJrJIqVMCrU6A12quS73T2f8eMok
 a+Y9js8EqgIDb2H3hUHBBLoygLofVtIDPjjXpZ7vqaSrmeteXOmsX5IHcZhV6eibBveq
 1yFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVaoxr2ol9fNAo3RbCsynKttYXPjBx4vQhZMh0+Lg3X6wrp/4rdefiJeLJ+zfWW3erG3I5Q+2mYXLk0mhl1AR/xWWoYUJ0=
X-Gm-Message-State: AOJu0Yz+/e2eGhLRwuqADt7LUGV0EXa5auDkt1ZB0/BtDHvqcuHbh4D5
 SGhBIaGxgHGAP6WJWc2iBmRtcJZ7ueXIn3D7q7xSZiG0NrtGhyVLnDUTGA/5vwplU99CvsRxDEM
 8ar7ne9LBgiph4y+Dszino1kRKMq2AcLcfK1OWg==
X-Google-Smtp-Source: AGHT+IHgjTPGTFL2ihz6/yzk90+fMvUcQtdar+Sa9NHW9hg0wabtmAYo8QQaqQSxQJRhT2alxcq+ulvMUrNSRfjnR2c=
X-Received: by 2002:aa7:c39a:0:b0:565:ff41:472f with SMTP id
 k26-20020aa7c39a000000b00565ff41472fmr1624282edq.21.1708954808876; Mon, 26
 Feb 2024 05:40:08 -0800 (PST)
MIME-Version: 1.0
References: <20240226000259.2752893-1-sergey.kambalin@auriga.com>
 <20240226000259.2752893-12-sergey.kambalin@auriga.com>
 <2ab7b523-816b-409b-a58a-f09e3f71ff8e@linaro.org>
In-Reply-To: <2ab7b523-816b-409b-a58a-f09e3f71ff8e@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Feb 2024 13:39:58 +0000
Message-ID: <CAFEAcA-WwWQnAQTmoCixaW5aeRWrdx__YoSHp_VyGEbk-rOkpg@mail.gmail.com>
Subject: Re: [PATCH v6 11/41] Temporarily disable unimplemented rpi4b devices
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Sergey Kambalin <serg.oker@gmail.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Sergey Kambalin <sergey.kambalin@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Mon, 26 Feb 2024 at 13:35, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> On 26/2/24 01:02, Sergey Kambalin wrote:
> > +static void raspi4_modify_dtb(const struct arm_boot_info *info, void *=
fdt)
> > +{
> > +    uint64_t ram_size;
> > +
> > +    /* Temporarily disable following devices until they are implemente=
d */
> > +    const char *nodes_to_remove[] =3D {
> > +        "brcm,bcm2711-pcie",
> > +        "brcm,bcm2711-rng200",
> > +        "brcm,bcm2711-thermal",
> > +        "brcm,bcm2711-genet-v5",
> > +    };
> > +
> > +    for (int i =3D 0; i < ARRAY_SIZE(nodes_to_remove); i++) {
> > +        const char *dev_str =3D nodes_to_remove[i];
> > +
> > +        int offset =3D fdt_node_offset_by_compatible(fdt, -1, dev_str)=
;
> > +        if (offset >=3D 0) {
> > +            if (!fdt_nop_node(fdt, offset)) {
>
> Peter, I remember a discussion where you wre not keen on altering DTB
> for non-Virt machines.
>
> Since these devices are all implemented at the end of the series, why
> not add the devices then the raspi4 board at the end, so this patch is
> not even required?

I'm not super-keen on it, but as you say it goes away once all
the devices are implemented, so I'm not too worried.

Doing it this way around would let us take the first 11 patches
in the series into git now (they've all been reviewed), which
gives us (I think) a functional raspi4 with some missing devices,
which seems useful in the interim until the rest of the series
gets reviewed and committed.

-- PMM

