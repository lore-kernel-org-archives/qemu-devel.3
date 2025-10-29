Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB105CCF9E9
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 08:38:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE1gs-00034k-En; Wed, 29 Oct 2025 04:37:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1vE1gq-00034T-2a
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 04:37:56 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1vE1gh-0008Dx-T0
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 04:37:55 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-63c0eb94ac3so12323204a12.2
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 01:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1761727062; x=1762331862; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IAj5q2MlI4lmTPSZDdjjNqSm2uN6G39gDegHSkDmL1g=;
 b=ZiQ8+XV14xQN97Vl3mpm4fLOEEs7UT70uXqxEM2mD8mdhhnmC1mb9R15quQDyGImSf
 BQRVbU6EH82vYObrlUgY/PbYOaVhxoXRisNB9iwTaZ3k44o/ZAgVJnb48nwsrk4wkx/U
 bTK91kHoJajngSGH10/FBsqQAZrjKVn6cIGAUue1TZX/Nq5MszQjpNVByzhlg5l2fSl1
 A/LwBhyZpTQbZdMN+aOifBJqQfXdkrWg00U9K1TFgtw/72g6LTRYQZEmmJAH6chw3TNE
 Dn1+xiG7PbfRTiojxLLUAHXdone8achNDBc0ZrFm0IjwiALYypyuIjJIEPniWUtFjv8R
 6Xew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761727062; x=1762331862;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IAj5q2MlI4lmTPSZDdjjNqSm2uN6G39gDegHSkDmL1g=;
 b=iser94vSx6JFG3q/Ir4wSOF/NG32ckc2pEWd/C4+ZoOr5jwU8AvrRIcN73bdDuif2j
 dg2Xz26KljR830t8m3FMF7ZXZOew5qgQU1+5dJNanPHAL2jMcW64Q8FcOSMp3/hmuDF3
 Eo1wsb8WvJYD/ZLjXjDmox5gYLZdhw0m40JmxHNhFnfudfxsmLPBBU4dMsF58qRB4O0w
 X8vPaYEA2vKRgUQIuQODORVj4PvkJ8ioxt9jPYI8N7iJmRhjdz8cesGp2K7qggW34zgX
 45b2V//o5UsRRiwn5A1fcQCNZ3oe4TQ6MHG+P0Y2ZaVnVVqakWYg/hqSqaeau/RF5vd1
 t5Kw==
X-Gm-Message-State: AOJu0Yw58jBkVCRsW5ZZTeArIorZitWhtfVsz75ghYY8DKCfMmLx/5vk
 VFVYILObpApPhPAmPv6UCC9qVuCSvFHumKAi74PVg0cRh01VitvuJ6ngJt1oaEJlYb8spBuksQd
 stT5S/bkArCagRotk773ecA5Ft8tAL2+6SE6eo715
X-Gm-Gg: ASbGncsxYZdh1xCA1hUSzWEaKsO5uQgHIwx9oGmecr/WB5UsKhrQTswU0Fqs79DNaht
 oLleUB3OagMLrq/4HhSiqP7ebDm8/zlmu1yYsyHBrBcSsV5R2UfgdSuYTq8f72qMfPymlWjhHBh
 Cl6rIYotsh14GyG7x1UxOR4RShjIXR1DVp6+Mz5mjT8WlbcriYY3W5jUE3N6M/3BTimPALt8Wb2
 7QUxRNhwkk6mwlFdwrmMoE1qdwMK2cC9yuxHfkzu7qom53J942n5ze6LWvgzzOLO1//8HyETd0w
 XSmvDIUrtHNXNV3r05Y=
X-Google-Smtp-Source: AGHT+IH30tWFrH5owADjartT9FwbMyBJC0TiZCg4wKSfHfCPhYiYRmE+urH/mb4rJpTaEEUUfCjaGOxKxd2mESFfS4k=
X-Received: by 2002:a05:6402:90d:b0:639:720d:743 with SMTP id
 4fb4d7f45d1cf-64044260d18mr1379278a12.31.1761727061790; Wed, 29 Oct 2025
 01:37:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250903075721.77623-1-chigot@adacore.com>
 <20250903075721.77623-2-chigot@adacore.com>
 <aPpyAzn7abZZ5WNv@redhat.com>
In-Reply-To: <aPpyAzn7abZZ5WNv@redhat.com>
From: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Date: Wed, 29 Oct 2025 09:37:30 +0100
X-Gm-Features: AWmQ_bkRxnT9_s2GQjt-jMrya_MaB0BXCGfNmYdK5t2bR1ySUzpcAj1iQYv-5GU
Message-ID: <CAJ307Egx3tcg6BLpZFV+7PcbiqMp6pADTz0nPTPLppFodifYyw@mail.gmail.com>
Subject: Re: [PATCH 1/5] vvfat: introduce no-mbr option
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=chigot@adacore.com; helo=mail-ed1-x530.google.com
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

On Thu, Oct 23, 2025 at 8:21=E2=80=AFPM Kevin Wolf <kwolf@redhat.com> wrote=
:
>
> Am 03.09.2025 um 09:57 hat Cl=C3=A9ment Chigot geschrieben:
> > This option when set prevents a master boot record (MBR) to be
> > initialized. This is mandatory as some operating system don't recognize=
d
> > mounted disks if a MBR is present.
> >
> > Signed-off-by: Cl=C3=A9ment Chigot <chigot@adacore.com>
>
> Can we actually give an example of such an OS in the commit message?
>
> > ---
> >  block/vvfat.c | 16 +++++++++++++++-
> >  1 file changed, 15 insertions(+), 1 deletion(-)
> >
> > diff --git a/block/vvfat.c b/block/vvfat.c
> > index 814796d918..0220dd828b 100644
> > --- a/block/vvfat.c
> > +++ b/block/vvfat.c
> > @@ -1082,6 +1082,11 @@ static QemuOptsList runtime_opts =3D {
> >              .type =3D QEMU_OPT_BOOL,
> >              .help =3D "Make the image writable",
> >          },
> > +        {
> > +            .name =3D "no-mbr",
> > +            .type =3D QEMU_OPT_BOOL,
> > +            .help =3D "Do not add a Master Boot Record on this disk",
> > +        },
>
> Let's keep option names positive to avoid double negations like
> 'no-mbr=3Dfalse'. We can have an 'mbr' option that defaults to true. Or i=
n
> fact, maybe calling it 'partitioned' would be easier to understand.
>
> You need to update BlockdevOptionsVVFAT in qapi/block-core.json, too, to
> make the new option work with -blockdev. You should update the
> description for @floppy there, too, because it says that hard disks are
> always partitioned.
>
> It should also be added to vvfat_strong_runtime_opts because the value
> of this option changes the data that the guest sees.

Just to keep you updated, I've seen your comments. I'm just waiting to
see where the discussion of patch 5 leads before pushing v2.

> >          { /* end of list */ }
> >      },
> >  };
> > @@ -1092,6 +1097,7 @@ static void vvfat_parse_filename(const char *file=
name, QDict *options,
> >      int fat_type =3D 0;
> >      bool floppy =3D false;
> >      bool rw =3D false;
> > +    bool no_mbr =3D false;
> >      int i;
> >
> >      if (!strstart(filename, "fat:", NULL)) {
> > @@ -1116,6 +1122,10 @@ static void vvfat_parse_filename(const char *fil=
ename, QDict *options,
> >          rw =3D true;
> >      }
> >
> > +    if (strstr(filename, ":no-mbr:")) {
>
> In the string, the negative form can stay (because the positive one
> doesn't exist here).
>
> > +        no_mbr =3D true;
> > +    }
> > +
> >      /* Get the directory name without options */
> >      i =3D strrchr(filename, ':') - filename;
> >      assert(i >=3D 3);
> > @@ -1131,6 +1141,7 @@ static void vvfat_parse_filename(const char *file=
name, QDict *options,
> >      qdict_put_int(options, "fat-type", fat_type);
> >      qdict_put_bool(options, "floppy", floppy);
> >      qdict_put_bool(options, "rw", rw);
> > +    qdict_put_bool(options, "no-mbr", no_mbr);
> >  }
> >
> >  static int vvfat_open(BlockDriverState *bs, QDict *options, int flags,
> > @@ -1196,7 +1207,10 @@ static int vvfat_open(BlockDriverState *bs, QDic=
t *options, int flags,
> >          if (!s->fat_type) {
> >              s->fat_type =3D 16;
> >          }
> > -        s->offset_to_bootsector =3D 0x3f;
> > +        /* Reserver space for MBR */
> > +        if (!qemu_opt_get_bool(opts, "no-mbr", false)) {
> > +            s->offset_to_bootsector =3D 0x3f;
> > +        }
> >          cyls =3D s->fat_type =3D=3D 12 ? 64 : 1024;
> >          heads =3D 16;
> >          secs =3D 63;
>
> Kevin
>

