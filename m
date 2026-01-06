Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7081C47BDD
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 10:28:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vd4IM-0007A7-Ao; Tue, 06 Jan 2026 05:28:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1vd4IK-00073x-Te
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 05:28:08 -0500
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1vd4IJ-0002IQ-5q
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 05:28:08 -0500
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b7cee045187so145763966b.0
 for <qemu-devel@nongnu.org>; Tue, 06 Jan 2026 02:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1767695285; x=1768300085; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kSSs9beRMhW/VutY5+dUKOYTxE1T5AMH5INA8hisjbI=;
 b=f7NLLWIYwXwtOOt2Tq9qaIxq/AE4ozjLVO++yYFHoNtlirK9Q/NZVFQGjybIMBumq2
 JTjmu4kyssvNNqdI5wjQkVVcRJb9egGobQ39FesuNGY2MmEz8ANm1ZSpzahx20kmwOgE
 NNIB8pp6i3T4c0jHMFuIa/PHOV72yt6w+RwU4nbesXZbPMCA/NN/GhBCHwWEhTop22r+
 V0NaMUn78rFqnr1GbXYuwNr+BmAqLqPd9NSxQEEjvpcVysIsWdgLJmYOZHitep0mgito
 4h6OvVF6bMnHQ717TCnXrwr3dYtvoxssHtne8N7NAd4conRYpqV8t1JznY2v5DXWnkS8
 PiSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767695285; x=1768300085;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kSSs9beRMhW/VutY5+dUKOYTxE1T5AMH5INA8hisjbI=;
 b=qtb49rakeSUMrXKTQwmK2Ts6vimc3XOYIil7aIfDjPzgD1urjSSb+f3hCzh9zamRCS
 dEe9fTer8GzaX+/re8Yevxy4WvN7gLVYHal56fCPhET9gv3U18/3nKftqPFZUOfD5tjK
 angoNile4QxIG0JBsE0ze6OcIJKrFAr1eiS2Xunwnh8Qin9jBxU/GNbQsWgcHT7VaM96
 w5Yk/PNj8/V52J2oUc2uJNm6Lu8B11RGfVBp2Xe6SK0Qt9I7hTkubKRyGUiYmyXPmarq
 /Bw5+dceok8OEpgJruObHm5eXf0FMY8x26yWheWhrbU/+KCmULsy7Sm+ip4RRZkmXVqS
 Edyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWx/rnChH+xc9AvTOjJ31f+tPyi+oXCIIiCgMUUFrqUg2GuY2Ajwt5LATx2UVcYs7NeWBYRvHDLyTS4@nongnu.org
X-Gm-Message-State: AOJu0Yw6nCFGBqdTtyveQW0aKfhCaLqk6lZF9xSjgoHQswhFIEjmMEba
 UNu0NUjlc8lZqhqqlzhHzP/LYmDuk2mghsLdQPOx3yGf3bQQKkzF8fh4mngv+7e6ZIJaPKKbPiK
 lVnWQlWHEoVisP/QsVYi38kxxI3v8eqXBvstCYYdU
X-Gm-Gg: AY/fxX7brZpbschhag3tJLKJfec2ThCTJfZ8Cs/6e6l05VMUYYeVH0tUd86G3BkV2TR
 IxFh+s35nTSYzvDo8A31Oknc+0mSrhbTVMZzyaEjF3V+llClLM5k2QVcfCSuEE1GjJMGBFoevIP
 yajuyIMfVXktKpK7Pv1KVQhJM48Nd7dnF0cKPH+n7T2VUk69B13WerNfJLLycYBKBfrFlHtQQ5Z
 pEc2MzEwO2/o0EKsTK96RzbghXoP/So1sGxkxgGTD8Xap4GT5/eDzOd7BVtjRAhj1YkP0Jc4AHH
 bayLQdVhbuYbWcfq1+tXvhxc/lUVXQ==
X-Google-Smtp-Source: AGHT+IGkzjkF5TkC4jvirEffu97W4MYuQCiQp9/MafEovkVDQwYo5NRoAeUPHrx+Qmlx/maSdsJqNzZuhpG0tmIgRhI=
X-Received: by 2002:a17:907:3e9b:b0:b82:f808:3eb9 with SMTP id
 a640c23a62f3a-b84298bda17mr237680666b.9.1767695284906; Tue, 06 Jan 2026
 02:28:04 -0800 (PST)
MIME-Version: 1.0
References: <20251127142417.710094-1-chigot@adacore.com>
 <2535802c-8b9a-bb83-b908-61df51aa8aa1@eik.bme.hu>
In-Reply-To: <2535802c-8b9a-bb83-b908-61df51aa8aa1@eik.bme.hu>
From: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Date: Tue, 6 Jan 2026 11:27:51 +0100
X-Gm-Features: AQt7F2oayIb-GVvRpJY-kouSjCPyZ8as8EP7FyXMiOYlaJuf8vPVinv1iWpQARc
Message-ID: <CAJ307EjmJSQ2RpE2sOAWC4ChQDTt+UbydGzeLzWGPJFvsFWMXA@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] block/vvfat: introduce "fat-size" option
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com, 
 hreitz@redhat.com, eblake@redhat.com, armbru@redhat.com
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

On Thu, Nov 27, 2025 at 3:53=E2=80=AFPM BALATON Zoltan <balaton@eik.bme.hu>=
 wrote:
>
> On Thu, 27 Nov 2025, Cl=C3=A9ment Chigot wrote:
> > The main goal of this series is to introduce a new option "fat-size"
> > within the vvfat backend (patch 5).
> >
> > This series also includes minor patches:
> > - patch 1 introduces another option to create unpartitionned disks.
> > - patch 2-4 are minor improvements easing the introducing of
> >   "fat-size" option
> >
> > This was tested on with a aarch64-linux kernel taken from
> > functional/aarch64/test-virt and on aarch64-qnx over raspi4b with a
> > workaround, not included here (the SD bus must be associated to the EMM=
C2
> > port instead of through GPIOs).
> >
> > Changes since v2:
> > - patch 1:
> >   - change default: true for hard disk, false for false.
>
> Typo: false for floppy
>
> >   - remove "unpartitioned" keyword within filename
> > - patch 5
> >   - rename option "fs-size"
>
> I'm still not sure if it could be done simpler without adding a separate
> fs-size option and fix size to apply to vvfat instead of raw so it works
> as expected not how it works now. The idea I proposed was to try to set
> format to vvfat if file or protocol contains fat: which was discussed
> here:
>
> https://lists.nongnu.org/archive/html/qemu-devel/2025-11/msg01487.html
>
> but I did not understand Kevin's reply if it's possible or why not.

My understanding is while it's possible to change the default format
dynamically, we'd rather not go in that direction. It's not that
trivial, meaning a much wider series of patches, and could change
existing behavior, meaning some warnings to be introduced before
making such changes.

Overall, I'd rather keep that series small (time you know...). So
@Kevin Wolf, would you mind making a review pass on the current V3 ?
The V4 has just a few comments/strings updates as per Zoltan
feedbacks.

TIA
Cl=C3=A9ment

> Regards,
> BALATON Zoltan
>
> > Cl=C3=A9ment Chigot (5):
> >  vvfat: introduce partitioned option
> >  vvfat: move fat_type check prior to size setup
> >  vvfat: add a define for VVFAT_SECTOR_BITS and VVFAT_SECTOR_SIZE
> >  vvfat: move size parameters within driver structure
> >  vvfat: add support for "fs-size" option
> >
> > block/vvfat.c        | 350 +++++++++++++++++++++++++++++++------------
> > qapi/block-core.json |  16 +-
> > 2 files changed, 270 insertions(+), 96 deletions(-)
> >
> >

