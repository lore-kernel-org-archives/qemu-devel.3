Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3D1AFA3737
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 09:40:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp2m9-0005WD-E9; Fri, 13 Sep 2024 05:39:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sp2m7-0005Ud-Kr
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 05:39:35 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sp2m5-0005gI-LE
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 05:39:35 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2f66423686bso18852761fa.3
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2024 02:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726220371; x=1726825171; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/sWnZZniD5N4YAmwhhyXimt4P8f16W5Xc/DMCmomqCE=;
 b=rIQWAzsaPcwJOblhtfG6hs0TPh9auoBN6VERe55RxmwNaj6CU5NYrI/eFwQ8PgUCim
 R2NP2A5Ti9Ofli1XhoK6TwS2pboqrK4PcKnkZDMOiE3zoFJ97RXk9c00JvIMxmwwlizU
 aL6SCmQdC4bgSkV5bSrAC0tX4pxFu+vF5tD7uFvOQ3/llKtqsX995RvQn6NFXjJFKBcI
 j7/C5oUSM0dsnwt5YCeag5DFzdIdAQud8fBoMEob7PT7q6kRWcUH4ZMv3sgmHZSfj6fQ
 CQV1Sqc67/q4myKwz8PTPWGOnUYdgykbbHmReiXDyK8ZZyrIf7mtxZnQ3cmKdGOda4mw
 XLrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726220371; x=1726825171;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/sWnZZniD5N4YAmwhhyXimt4P8f16W5Xc/DMCmomqCE=;
 b=atXmrO5I90BhaKj18VNT9oCskH8MJTa84VWel9Mdj3LOqsgSbpbukeu5+4+0Yvd7IM
 vd/ce3eGRkFqoPPxBY8PlvVc9lFC8ZuDdZ378siayQYeG2YoJ/VLjuBT4RRBg8noarLz
 Ut30sH1tuT6LLxVPQ4NyuR2WxZQfmu6GDN0Eobzkr8FxEUYfpQbCmv8uoP4RsYygJ1z8
 VcWrJ2ubI6q5ko5Too/UM/oeKvodl93CvkxtpCktJAqtm2TVmmdJfHBigxi/LWEVBUty
 4eqds6ua9jC1lvwQGWodP7jk6z1cEMepG2sr3Bzl/1YbbQolZiNxJvleHhQ6uiy7V4oB
 J3RQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuhqIiRpwMX3B9mnH+/wGGdpmfgLxjg47qMJ0832Gs53R0LKSdfFlvqHoP+GuJ5cys+pot6jL/3mHi@nongnu.org
X-Gm-Message-State: AOJu0YySCY1VFM3I5d4F9tTUqGwxpojVgIw7GFcBpgYnaIoCIH7R1tzH
 WlNrPprMunc/GbeMbVcpk+m7eGRezmWfDgqsVIRcRTGLoFICkZ+0ADcNfgdjYyX5fEAAu1EmJty
 Rlqpq55miF/kkaqKOx0tcu162WFGFyzpV+1zSjA==
X-Google-Smtp-Source: AGHT+IFbWeB35WVWIfooMX/9F/+Z/j3ZmfNUGa6rA7mKWIuGFnsk08X+Nmp9f9PK0GUNunZXlnW3RvzeNBJXMVKhLb8=
X-Received: by 2002:a05:6512:281e:b0:536:14a1:d645 with SMTP id
 2adb3069b0e04-53678feb713mr3787929e87.44.1726220371299; Fri, 13 Sep 2024
 02:39:31 -0700 (PDT)
MIME-Version: 1.0
References: <20240903200446.25921-1-philmd@linaro.org>
 <20240903200446.25921-2-philmd@linaro.org>
 <CAFEAcA_Yfcjuz+3KfiKPDY2aVU1OuJ3B-9q9F82-fGCS9PTi+Q@mail.gmail.com>
 <87bk0s2c04.fsf@pond.sub.org>
In-Reply-To: <87bk0s2c04.fsf@pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Sep 2024 10:39:20 +0100
Message-ID: <CAFEAcA_SvWnSy8gs0G5dK2rgCYX19yE-QBPaF5kWEqAXP53wsg@mail.gmail.com>
Subject: Re: [PATCH 1/2] hw/sd: Remove legacy sd_set_cb()
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, qemu-block@nongnu.org, Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22b.google.com
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

On Fri, 13 Sept 2024 at 09:28, Markus Armbruster <armbru@redhat.com> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > On Tue, 3 Sept 2024 at 21:04, Philippe Mathieu-Daud=C3=A9 <philmd@linar=
o.org> wrote:
> >>
> >> sd_set_cb() was only used by omap2_mmc_init() which
> >> got recently removed. Time to remove it. For historical
> >> background on the me_no_qdev_me_kill_mammoth_with_rocks
> >> kludge, see commit 007d1dbf72 ("sd: Hide the qdev-but-not-quite
> >> thing created by sd_init()").
> >>
> >> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> >> ---
> >>  include/hw/sd/sdcard_legacy.h |  1 -
> >>  hw/sd/sd.c                    | 30 ++++--------------------------
> >>  2 files changed, 4 insertions(+), 27 deletions(-)
> >>
> >> diff --git a/include/hw/sd/sdcard_legacy.h b/include/hw/sd/sdcard_lega=
cy.h
> >> index 0dc3889555..a121232560 100644
> >> --- a/include/hw/sd/sdcard_legacy.h
> >> +++ b/include/hw/sd/sdcard_legacy.h
> >> @@ -36,7 +36,6 @@ SDState *sd_init(BlockBackend *blk, bool is_spi);
> >>  int sd_do_command(SDState *card, SDRequest *request, uint8_t *respons=
e);
> >>  void sd_write_byte(SDState *card, uint8_t value);
> >>  uint8_t sd_read_byte(SDState *card);
> >> -void sd_set_cb(SDState *card, qemu_irq readonly, qemu_irq insert);
> >>
> >>  /* sd_enable should not be used -- it is only used on the nseries boa=
rds,
> >>   * where it is part of a broken implementation of the MMC card slot s=
witch
> >> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> >> index a140a32ccd..8a30c61ce0 100644
> >> --- a/hw/sd/sd.c
> >> +++ b/hw/sd/sd.c
> >> @@ -112,10 +112,6 @@ typedef struct SDProto {
> >>  struct SDState {
> >>      DeviceState parent_obj;
> >>
> >> -    /* If true, created by sd_init() for a non-qdevified caller */
> >> -    /* TODO purge them with fire */
> >> -    bool me_no_qdev_me_kill_mammoth_with_rocks;
> >> -
> >
> > Should we also remove the sd_init() function in this patch
> > (or patchset)? It was only used by the omap-mmc, and it's
> > because we have no uses of it that we can get rid of this kludge.
>
> sd_init() is a legacy initialization function for use by non-qdevified
> callers.  I'd *love* to finally get rid of it.  However, there seems to
> be a use left in tree even after "[PATCH for-9.2 00/53] arm: Drop
> deprecated boards": omap_mmc_init(), used by sx1_init() via via
> omap310_mpu_init().  This is machines sx1 and sx1-v1.

Ah, I hadn't noticed that. I'll have a re-read of this
patch based on that knowledge...

> Ignorant question: can we deprecate these?

We put them up as candidates when we were deprecating the
rest of this, but the feedback was that kernel developers
were still using sx1:
https://lore.kernel.org/qemu-devel/20240214012749.GA203324@darkstar.musicna=
ut.iki.fi/

It is indeed a bit of a pity from our end that we couldn't
drop all of the OMAP code entirely. We might get another
chance after the next round of kernel machine type culling
if they drop armv4t.

Once my patchset to drop all these Arm machines has got
code review and gets into git we can reassess what we
still have and look at modernising the stuff we've kept.

thanks
-- PMM

