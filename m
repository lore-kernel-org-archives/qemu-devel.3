Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDDFFCE7B0D
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 13:48:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJu9I-000268-AQ; Fri, 14 Nov 2025 08:47:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1vJu98-00021c-6K
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 08:47:26 -0500
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1vJu96-0005dp-92
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 08:47:25 -0500
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b713c7096f9so252661266b.3
 for <qemu-devel@nongnu.org>; Fri, 14 Nov 2025 05:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1763128043; x=1763732843; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7QeCUzPIjowysenan5aJzwzCsbmrTStS16DSCZP3f/o=;
 b=EePFNFPUqKmA04pQ6XROntEgTgjQiBOKZuc7i27693dbgHl6jB1sJCqQuxH3j/Eozl
 5BFVcCf52U3ogJN+cSBsidG8CvT3tR/T9landK2nXQz9IbkZPn9PSCs8ijFpACPtXgE2
 lg0It6xxG42nyhMyGzkCviEClPSJbKOooElrM1ltfANIh8kIenWcoVoIqwkOoeCD3KJS
 zS20iOrNRCWdjZQudMZQdMyiqjBV2FkKJVKcu66LzkEcKryEzkZitvMa8pdy5DEyhl+h
 dtPZCfJeO2s9Uu5DQxyyaYVR2cnH0zBkFFXpdzpzu2pVcDgzc93dHudfCezodWWDLTHC
 8zng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763128043; x=1763732843;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7QeCUzPIjowysenan5aJzwzCsbmrTStS16DSCZP3f/o=;
 b=LxFB3pOg3mSptw9V6TYWe4fDmvMDeQ9mtdkFzh9jQF65lP5xzABEBdsTIHiMAYT0Eo
 i2N9nM0SGsKtPPSYT7ZF+zF6dKFH0vrR+Db3TwiDF34PirN0xz9rFaLE1wS/adZLlEIl
 SPHqVVgElBacsITOIBN9XYzQsDg4Q44QmB2ilt/3jilGy9UhfHzYp57ZhRK7ccmooGnM
 te1rx3kgOu4+KcyUSm1TEZPzAXLc/rpsmeNzNGvd98cM2MPv2gJhQk5mbvEr0t5uoUGF
 nAlSrfSxA3TFTznPxaariexx9D8WJ1Xv+tqv+dr8Ghe/ZYKJY1v01sQB2fDPJt1Qq4+9
 WTow==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmuOdwcktGOT6RLYabS1Jwi0xQJKineCBvmQUOr4aV2lkgARKGJ2F1rzDU/xNP+hJlhZnuvR2R8XlB@nongnu.org
X-Gm-Message-State: AOJu0YzCOvAGNk9f9I0Y6EoT4+ZoZeFkRiSC3V4/cYQGNUHwFGxZSsID
 dMlAYIsh4EKd+RAzQo5kE4DSPMO7/M3racogv0aGZiRUrhYSq25ROTrRKY8WC8SrcXUaPPycqKB
 GCxy/XssDjyo17XkTiJgMU4Ovnlg/Z1fEB2y3jbFq
X-Gm-Gg: ASbGncvap7xinwt0uoG2odyKeB0iGfv4Xf87xvd1718IWSgjzgLpML2Obdke27GKWsR
 OPlAuhXdOeRui9MdkmuJJLR5etDBPl+xTxLlbTARDg4v985LmTYiu6yuI45cg7JoGyMcofwOajH
 03sCzhYPVAYPqPhwTXdemU++tcEvmCrJh1IyAlcLRzRhWJY9b/zTCsUORemzDbe6njpOGBoZvDK
 lphYzYhITArJ7fjLhDq/iKGYpRsbQ8rl4RmJ061B1LgbN9OIGPYJv3odPXPX8Y23QC9an1/tAen
 DOYMImAzSTAEl//RSKzHfVN3V+ksfg==
X-Google-Smtp-Source: AGHT+IHFN63jHvAY4YV1tm+ebCUjb9Pg53jn2LHxiOKXPGBuquYwNOHwZQnedCRkZzlrXFBgCwcXZ/ncIMospiTxegc=
X-Received: by 2002:a17:907:7f07:b0:b70:b5b9:1f82 with SMTP id
 a640c23a62f3a-b73678eac95mr345494366b.31.1763128042555; Fri, 14 Nov 2025
 05:47:22 -0800 (PST)
MIME-Version: 1.0
References: <20251107145327.539481-1-chigot@adacore.com>
 <20251107145327.539481-2-chigot@adacore.com>
 <878qgenqum.fsf@pond.sub.org>
 <CAJ307Eg7x_rKb5qybgW3XxAKLP=1ds524gqgXettv2cZ8WTMww@mail.gmail.com>
 <757f66d0-625c-9d1b-5090-3d5210903173@eik.bme.hu>
 <87346mkos9.fsf@pond.sub.org>
 <aRH_2gcYOH31UB38@redhat.com> <87ecq5f201.fsf@pond.sub.org>
 <CAJ307EjFMrXOmQMF5YckQ6hMGdFGtdYdAH3fWShcvwEXAtBrrw@mail.gmail.com>
 <87c7d0d6-8f8f-b6f2-3c81-0b0572dbad2c@eik.bme.hu>
In-Reply-To: <87c7d0d6-8f8f-b6f2-3c81-0b0572dbad2c@eik.bme.hu>
From: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Date: Fri, 14 Nov 2025 14:47:11 +0100
X-Gm-Features: AWmQ_bkt_9RjftV3ikBtnsE9XlHXKd9OSuPP92vIPiPXpNNYsUFFsEvWaKdlSLc
Message-ID: <CAJ307Eg74VNkYvewc5bnhafD+ccXzALmvS400Gz++8Mx5gcKkQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] vvfat: introduce partitioned option
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, 
 qemu-devel@nongnu.org, hreitz@redhat.com, eblake@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=chigot@adacore.com; helo=mail-ej1-x634.google.com
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

On Fri, Nov 14, 2025 at 2:25=E2=80=AFPM BALATON Zoltan <balaton@eik.bme.hu>=
 wrote:
>
> On Fri, 14 Nov 2025, Cl=C3=A9ment Chigot wrote:
> > On Tue, Nov 11, 2025 at 8:43=E2=80=AFAM Markus Armbruster <armbru@redha=
t.com> wrote:
> >>
> >> Kevin Wolf <kwolf@redhat.com> writes:
> >>
> >>> Am 10.11.2025 um 14:20 hat Markus Armbruster geschrieben:
> >>>> BALATON Zoltan <balaton@eik.bme.hu> writes:
> >>>>
> >>>>> On Mon, 10 Nov 2025, Cl=C3=A9ment Chigot wrote:
> >>>>>> On Mon, Nov 10, 2025 at 11:07=E2=80=AFAM Markus Armbruster <armbru=
@redhat.com> wrote:
> >>>>>>>
> >>>>>>> Cl=C3=A9ment Chigot <chigot@adacore.com> writes:
> >>>>>>>
> >>>>>>>> This option tells whether a hard disk should be partitioned or n=
ot. It
> >>>>>>>> defaults to true and have the prime effect of preventing a maste=
r boot
> >>>>>>>> record (MBR) to be initialized.
> >>>>>>>>
> >>>>>>>> This is useful as some operating system (QNX, Rtems) don't
> >>>>>>>> recognized FAT mounted disks (especially SD cards) if a MBR is p=
resent.
> >>>>>>>>
> >>>>>>>> Signed-off-by: Cl=C3=A9ment Chigot <chigot@adacore.com>
> >>
> >> [...]
> >>
> >>>>>>> Not sure I like "partitioned".  Is a disk with an MBR and a parti=
tion
> >>>>>>> table contraining a single partition partitioned?  Call it "mbr"?
> >>>>>>
> >>>>>> It used to be called "mbr/no-mbr" but Kevin suggested renaming it =
in
> >>>>>> V1. Honestly I'm fine with both options:
> >>>>>> - Technically, the option prevents MBR which has a side effect for
> >>>>>> preventing partition tables
> >>>>
> >>>> Yes, because the partition table is part of the MBR.  I'd rather nam=
e
> >>>> the option after the entire thing it controls, not one of its parts.
> >>>>
> >>>>>> - Even it has a single partition, I think it makes sense to call a
> >>>>>> disk "partitioned" as long as it has a partition table
> >>>>>>
> >>>>>> But I'm not that familiar with disk formats, etc. I'll let you dec=
ide
> >>>>>> with Kevin, which one you prefer.
> >>>>
> >>>> Kevin is the maintainer, I just serve as advisor here.
> >>>
> >>> I figured that the meaning of "partitioned" is easier to understand f=
or
> >>> a casual user than having or not having an MBR ("I don't want to boot
> >>> from this disk, why would I care about a boot record?").
> >>
> >> Fair point.
> >>
> >> Possible counter-points:
> >>
> >> * The default is almost always right for the casual user.  The
> >>   exception, as far as I understand, is certain guest OSes refuse to
> >>   play ball with certain devices when they have an MBR.
> >>
> >> * The configuration interface isn't exactly casual-user-friendly to
> >>   begin with.  @fat-type, what's that, and why do I care?  @floppy,
> >>   what's that, and why do I care?
> >>
> >> Anyway, you decide.
> >
> > AFAICT, there are two open questions for that patch:
> >
> > 1. "mbr" vs "partitioned".
> > I do think "partitioned" is clearer, a bit more casual friendly. "mbr"
> > requires knowledge about FAT format, while what's a partition should
> > be known by a wider audience.
> > Side note, in V3, I'll remove the "unpartitioned" keyword to simply
> > replace it by "partitoned=3Dfalse" (I wasn't aware such an obvious
> > possibility was working...). So we might even call it
> > "partition/partitions=3Dtrue|false".
> >
> > 2. The default value. Should it be "false" for @floppy ?
> > IMO, having a default value independent of other arguments is always
> > better. Hence, I'll push for keeping "partitioned=3Dtrue" as the
> > default, and having users forcing "partitioned=3Dfalse" for floppy (an
> > error being raised otherwise). As we'll probably change the default
> > behavior with floppy anyway (cf patch 2), I don't think it will hurt a
> > lot to make users passing a new flag.
>
> Combined with the option called partinioned=3Dfalse that's quite unfriend=
ly
> for users trying to type a command line. Maybe not many do but those who
> don't also don't care about what are the defaults or if it's called mbr o=
r
> partitioned as whatever generates the command line for them takes care
> of that. So I'm still for user friendly CLI but I also don't care enough
> to insist more if others don't think it's worth to keep this user friendl=
y
> for command line users.
>
> There was another question if the fat-size option is really needed or it
> could just use size if the default format=3Draw was changed to behave lik=
e
> format=3Dvvfat if file=3Dfat: is given which I think would make more sens=
e
> than only truncating the underlying raw format that's not even needed to
> be there but I don't know how difficult it is to implement this or the
> default format=3Draw is hard coded and hard to change for fat: protocol.
>
>
> So in summary:
>
> 1. format=3Dvvfat,size=3DxMB was said to work so could file=3Dfat:/dir,si=
ze=3DxMB
> imply format=3Dvvfat so it would also work? Then no other size option is
> needed.

Well, that discussion was related to patch 5 and my understanding is that:
 1. Having @format=3Draw,size=3DxMB forwarding the size to the underlying
VVFAT is not easily doable with our current block architecture.
 2. The @size option for format=3D"raw" is misleading. It should have
been @sliced-size or something close to it. However, it's too late to
change it (or we need to deprecate it in a few releases, but then
outside the scope of this patch).
 3. We want to avoid confusing mistakes, such as forgetting
@format=3Dvvfat and having @size then recognized by @format=3Draw (the
default). Naming the new option differently ensures a clear error.

Side note, I agree that @fat-size is confusing so I'll rename it @fs-size i=
n V3.

> 2. Having different defaults for floppy or disk would keep existing
> command lines working. Otherwise why not make partitioned=3Dfalse the
> default and let users who need it set explicitly. That would also work fo=
r
> most cases without having to type out this option.

Yes, I forgot about that one (though linked to patch 2). If we don't
change the default size of floppy, the existing command lines will
stay as is, hence introducing a new mandatory option is a bad idea.
Overall the tradeoff is "simple default CLI" vs "non-conditional
defaults". Both have pros and cons and I don't have a strong feeling
about which ones should be prefered. So, I'll let you, the
maintainers, decide which one is the best for QEMU, its block devices
and vvfat future ;)

> Regards,
> BALATON Zoltan

