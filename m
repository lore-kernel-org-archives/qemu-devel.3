Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2736CCF9E9
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 13:45:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE6TY-0004yQ-9W; Wed, 29 Oct 2025 09:44:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1vE6TV-0004wO-Q0
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 09:44:29 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1vE6TP-0002jl-8K
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 09:44:29 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-63c2d72582cso11573825a12.1
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 06:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1761745458; x=1762350258; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bndmBYkqvlVjgTRbYRQiJEYS+aYsxp3enG0L5CPA9jY=;
 b=Zc+fdG66BTeMdW0ALwKgXSf4G94XmGznAtM3m5gwpxAHYjry+CbEn8mbhxGS7AOmB3
 UO6w89BM7Zi21gDD7P6hvMllj66ndcQuSzCmdhrRJSQvjgVo2cG9pLW+rJtGs0pLhjMX
 YhTUyH2JoVTwUhyToO87P5HKX/LvnGdwpRYbSj5l/iEPr63hh4I+dMA5ON94058RaHGA
 7QwAQziK9y9ZOO1w/73d7DEt0BjI9rAbX1F5snXMROTmduDW9jPy6GpE0MY+4wlcCWKg
 Bqjg0ZNJvK/erhixPQ069uub9s3mJGwlrRGpEnbMgRjEBLFftC8wvlFKczZr5QbUda83
 /i9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761745458; x=1762350258;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bndmBYkqvlVjgTRbYRQiJEYS+aYsxp3enG0L5CPA9jY=;
 b=g+6X/tDzui9o6I5F7lj5uDa8dlTn89N1BvQpHZKlfuOTF5Aj5/Ueswtebl/qD/ege4
 qAX8RxSEFzb2zx/bh3cp7Gw1dMtz5vnR+21hFUnZtypx8nOZSVemyq8Pzyts/CXexOjm
 uP8f0u8D/bncnjB3uzdmkI00svKoz7qwJOv3MDsCWJuAfkbvJrvAnfhz8QApphpKTf1t
 NOiZ0yIUXsoCBjIQ2rnLQkccUoMSBWyNxp9tExDzs6w38IRvInaov5SHMeGnF0l78xQb
 3it03ShncuBJ4EmSm8A/XiTTgtmgwUlTAGKPrWTIVRjRGs7DGAtXNAAGjvhfzx/4QCct
 WVEg==
X-Gm-Message-State: AOJu0YypUM1lTUPr1jj0TuMUKiUZq0zIbV4rxRevuenJ8uq4l10fLZXF
 FTM+MyfLoDiN7BOnAkuzJirC4+2wLObgKdbiF9/gY2hQLV47bM6t6khMzZCcrGPi+J9ivb0Dp3t
 Y1LSwHX8YvTJ3LodHB14FB7Jj/3LlwumpJV0mGFr0
X-Gm-Gg: ASbGncv7uglijQPUiI24MzgyM9rLY8i/G6R1FM3jmouhxMk/sl77ovOpSX46MFArIip
 QSrLhBGiIJRdx/ZRiwsJEy8boTHEXbudfh+aGwyBM+S+odl0a1BxuzfMy9YFIf8a3nmzBd2wlMD
 DRrPVPUmFOdvo/YLUp62VL51aRECq5qW/okQiimZr13KW8ZxjbG9PUELdOEGVbGiFFoYiqz2RL9
 gnsDc/UKuU3fyz0QeuhS01Y4PSG738LObxZdTC56sd9WPIo9fHq4t4QF4A5XvVod0PiMfhyLPIB
 IMuv2Zj+BWNLMCkvOQY=
X-Google-Smtp-Source: AGHT+IEMusiH1lzAB4BWJlrkkeBDoTTNX8Z93x+j6+APT5i3JUVZwAEXdKy+M1hrXTWVXRCKPKcUQrhnJtGtDr1mecw=
X-Received: by 2002:a05:6402:1d4d:b0:634:ab34:ed40 with SMTP id
 4fb4d7f45d1cf-64043f3e702mr2088711a12.0.1761745458108; Wed, 29 Oct 2025
 06:44:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250903075721.77623-1-chigot@adacore.com>
 <20250903075721.77623-2-chigot@adacore.com>
 <aPpyAzn7abZZ5WNv@redhat.com>
 <CAJ307Egx3tcg6BLpZFV+7PcbiqMp6pADTz0nPTPLppFodifYyw@mail.gmail.com>
 <aQHy7ERcW289V9E1@redhat.com>
In-Reply-To: <aQHy7ERcW289V9E1@redhat.com>
From: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Date: Wed, 29 Oct 2025 14:44:07 +0100
X-Gm-Features: AWmQ_bk2FNypncC4zjHLfxEqgihej8z7Z6OdbSXIuTbtKuID4AGAKOrImSwbeao
Message-ID: <CAJ307Ehx0qSTVWz+fF5X52bjZLebc+Ssv69moBGyzV9s9PnKFQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] vvfat: introduce no-mbr option
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=chigot@adacore.com; helo=mail-ed1-x52f.google.com
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

On Wed, Oct 29, 2025 at 11:56=E2=80=AFAM Kevin Wolf <kwolf@redhat.com> wrot=
e:
>
> Am 29.10.2025 um 09:37 hat Cl=C3=A9ment Chigot geschrieben:
> > On Thu, Oct 23, 2025 at 8:21=E2=80=AFPM Kevin Wolf <kwolf@redhat.com> w=
rote:
> > >
> > > Am 03.09.2025 um 09:57 hat Cl=C3=A9ment Chigot geschrieben:
> > > > This option when set prevents a master boot record (MBR) to be
> > > > initialized. This is mandatory as some operating system don't recog=
nized
> > > > mounted disks if a MBR is present.
> > > >
> > > > Signed-off-by: Cl=C3=A9ment Chigot <chigot@adacore.com>
> > >
> > > Can we actually give an example of such an OS in the commit message?
> > >
> > > > ---
> > > >  block/vvfat.c | 16 +++++++++++++++-
> > > >  1 file changed, 15 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/block/vvfat.c b/block/vvfat.c
> > > > index 814796d918..0220dd828b 100644
> > > > --- a/block/vvfat.c
> > > > +++ b/block/vvfat.c
> > > > @@ -1082,6 +1082,11 @@ static QemuOptsList runtime_opts =3D {
> > > >              .type =3D QEMU_OPT_BOOL,
> > > >              .help =3D "Make the image writable",
> > > >          },
> > > > +        {
> > > > +            .name =3D "no-mbr",
> > > > +            .type =3D QEMU_OPT_BOOL,
> > > > +            .help =3D "Do not add a Master Boot Record on this dis=
k",
> > > > +        },
> > >
> > > Let's keep option names positive to avoid double negations like
> > > 'no-mbr=3Dfalse'. We can have an 'mbr' option that defaults to true. =
Or in
> > > fact, maybe calling it 'partitioned' would be easier to understand.
> > >
> > > You need to update BlockdevOptionsVVFAT in qapi/block-core.json, too,=
 to
> > > make the new option work with -blockdev. You should update the
> > > description for @floppy there, too, because it says that hard disks a=
re
> > > always partitioned.
> > >
> > > It should also be added to vvfat_strong_runtime_opts because the valu=
e
> > > of this option changes the data that the guest sees.
> >
> > Just to keep you updated, I've seen your comments. I'm just waiting to
> > see where the discussion of patch 5 leads before pushing v2.
>
> Yes, that makes sense. So this means that for all the other patches, you
> agree with my comments and it's clear to you what to change in v2?

Globally yes. I'm still unsure about patch 2 (I'll answer directly on
this patch). But for patch 1 and, yes clearly.

