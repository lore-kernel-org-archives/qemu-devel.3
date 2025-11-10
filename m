Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D9EECCFA13
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 11:26:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIQ2w-0006Yk-8o; Mon, 10 Nov 2025 06:26:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1vIPmj-0004RS-5x
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 06:10:09 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1vIPmh-0004Gi-6E
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 06:10:08 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b714b1290aeso471794066b.2
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 03:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1762773005; x=1763377805; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OuqJpYoHuR2zBWeqRiofDYPVTNH7pBLQ/mXtbQSlLng=;
 b=UN+xycFCUkijVnALE9/SEFmOZWHbmbz3y54nqy6dP6Y5kSNwhX768626Zc5Jz6WqHF
 vJiLcKgZBxk8J3NSDFebeuTf6RRB7ZoJerTSTAtxUNXLQS5qcFxgx0g1PoRmdRxF7/hO
 uZJGtIx8VdReOylrjrXD0irYwzTGXQJ7sRpmdcSj6PVW30Q8mJWLOBw0tydj4MlMJ+Ej
 WsfSZA0B1vMWlDLO96a0DiLLseM4lAQQUU1X+8102NDj7c+dRBgz3eWn70Pf9wuY/exG
 aimrrvMTbC+5h15HjWRtERPksABGXKZMPpmKyU71ArCuk4RKGe1eicCsr+unLcNT8rm1
 84fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762773005; x=1763377805;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OuqJpYoHuR2zBWeqRiofDYPVTNH7pBLQ/mXtbQSlLng=;
 b=Mqz21MgB7X57SEOla8Zy+741QH2FF4xSLzCdiKNOlOqE9P9rmHZBsctzr2trfgnBPz
 gVVCvIlOk+x81eUuirEzLwzKwvwlqgLYPNIsAy08/STVB6qAOXqRQ42B2a9KItWuLml2
 ZiO1DcaZ2695g2LkTVh0XZj+t6niT2S10VxfwYTMi2OllXrkuHJ1KCYbOCecGaO6F0ZG
 WEuVJ3gMGnhqzvPxHW0VOHE8ZeacmrLie3x6cVbZmAhkCH+hf3TbZ3qs5L+wQi/VxBD6
 nJ6QfBxINkX1xlppOA/e62tW6TtbDFaaRQhibFban9AhO+AcOJHcAWtMsIDZ14Jfz3aS
 8S0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRuZ7pyAp4JxBRKG4FHJmy20FJQacYs0zYrrDkPfDU4zGYItcpknNjFgUTl8YcDXvjXVjcin6S5qYk@nongnu.org
X-Gm-Message-State: AOJu0Yz3CUqrACQ3zw4/0oYoC+qFxlFE2g/hx+I5MLhdBjeP+y9Zhgew
 NjjKtMDXw0w7UHTGpM3sNCMeiW7PBEQAAY0jhl9aY2XxvkklmCuqD3iL3bFDuCh8PVY4MaCjduF
 AmzGAtsE49Ln48XOg7tq/3NRTwgeNmUoKzMsFKc9h
X-Gm-Gg: ASbGncvQ5gmmQGjT3viSyd/H3qSLUEM642N5szA/UrguKCCDp0DRl42GbfhSivVEkqH
 zRYEZxKO/qZeGb6WIk2IgEWVym6HKG1jOwcVNnogl1tl5mzCbg2DUljO+1MT4nOlThni2GQtroX
 vPCMKtf3HQ3VOWaSeaJ5KgpmvjMzIJJH9KbW7m0w+Zrf8lnLVEKqSAZMaN1c7VBf/6U78EnZ231
 FIzNrWWeH/aL57z8YqnWZkwvF0vtWDfO9XOXDEGxnsP+JUZkD6yoDOolc7A
X-Google-Smtp-Source: AGHT+IHsyOyzPJCwZ+Rs6Wy5jRmTyOXcdTeeSxO+PCH3fLqLiiXyHK2Gy7iRHi29ttUHZcfyPirYH7JyfzsVQPvhzG4=
X-Received: by 2002:a17:906:eecb:b0:b72:d6a9:e1d9 with SMTP id
 a640c23a62f3a-b72e0560451mr638064866b.41.1762773004618; Mon, 10 Nov 2025
 03:10:04 -0800 (PST)
MIME-Version: 1.0
References: <20251107145327.539481-1-chigot@adacore.com>
 <20251107145327.539481-2-chigot@adacore.com>
 <878qgenqum.fsf@pond.sub.org>
In-Reply-To: <878qgenqum.fsf@pond.sub.org>
From: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Date: Mon, 10 Nov 2025 12:09:53 +0100
X-Gm-Features: AWmQ_bnpUUti63Ec_FT8CyxSnRWxbygoFjPA4YV57bbEu_bGJqzcCs7ulvg6GI0
Message-ID: <CAJ307Eg7x_rKb5qybgW3XxAKLP=1ds524gqgXettv2cZ8WTMww@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] vvfat: introduce partitioned option
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com, 
 hreitz@redhat.com, eblake@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=chigot@adacore.com; helo=mail-ej1-x630.google.com
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

On Mon, Nov 10, 2025 at 11:07=E2=80=AFAM Markus Armbruster <armbru@redhat.c=
om> wrote:
>
> Cl=C3=A9ment Chigot <chigot@adacore.com> writes:
>
> > This option tells whether a hard disk should be partitioned or not. It
> > defaults to true and have the prime effect of preventing a master boot
> > record (MBR) to be initialized.
> >
> > This is useful as some operating system (QNX, Rtems) don't
> > recognized FAT mounted disks (especially SD cards) if a MBR is present.
> >
> > Signed-off-by: Cl=C3=A9ment Chigot <chigot@adacore.com>
>
> [...]
>
> > diff --git a/qapi/block-core.json b/qapi/block-core.json
> > index b82af74256..8a479ba090 100644
> > --- a/qapi/block-core.json
> > +++ b/qapi/block-core.json
> > @@ -3464,8 +3464,8 @@
> >  #
> >  # @fat-type: FAT type: 12, 16 or 32
> >  #
> > -# @floppy: whether to export a floppy image (true) or partitioned hard
> > -#     disk (false; default)
> > +# @floppy: whether to export a floppy image (true) or hard disk
> > +#     (false; default)
> >  #
> >  # @label: set the volume label, limited to 11 bytes.  FAT16 and FAT32
> >  #     traditionally have some restrictions on labels, which are
> > @@ -3474,11 +3474,15 @@
> >  #
> >  # @rw: whether to allow write operations (default: false)
> >  #
> > +# @partitioned: whether a hard disk will be partitioned
>
> How does "partitioned" combine with "floppy": true?
>
> Is it silently ignored?
>
> Is it an error if present?
>
> Is it an error if true?
>
> Does it add a partition table if true?
>
> > +#     (default: true)
>
> Hmm, this suggests it's silently ignored.
>
> Silently ignoring nonsensical configuration is usually a bad idea.

True, but that would mean "unpartitioned" must always be passed when
"floppy" is requested. That would make such command lines a bit more
verbose, but otherwise I don't think there is any issue to that.

Note that I didn't add "partition" as a keyword in the command line.
Currently, it's either the default (thus partitioned) or
"unpartitioned" being requested. Do you think it makes sense to add it
as well, even if it's redundant ?

> > +#     (since 10.2)
> > +#
>
> Not sure I like "partitioned".  Is a disk with an MBR and a partition
> table contraining a single partition partitioned?  Call it "mbr"?

It used to be called "mbr/no-mbr" but Kevin suggested renaming it in
V1. Honestly I'm fine with both options:
 - Technically, the option prevents MBR which has a side effect for
preventing partition tables
 - Even it has a single partition, I think it makes sense to call a
disk "partitioned" as long as it has a partition table

But I'm not that familiar with disk formats, etc. I'll let you decide
with Kevin, which one you prefer.

> >  # Since: 2.9
> >  ##
> >  { 'struct': 'BlockdevOptionsVVFAT',
> >    'data': { 'dir': 'str', '*fat-type': 'int', '*floppy': 'bool',
> > -            '*label': 'str', '*rw': 'bool' } }
> > +            '*label': 'str', '*rw': 'bool', '*partitioned': 'bool' } }
> >
> >  ##
> >  # @BlockdevOptionsGenericFormat:
>

