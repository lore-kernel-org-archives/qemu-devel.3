Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB611C41513
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 12:38:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4gYT-00031A-Af; Wed, 08 May 2024 08:37:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4gXn-0002lT-DF; Wed, 08 May 2024 08:37:20 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4gXl-0005JZ-P0; Wed, 08 May 2024 08:37:11 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6f43ee95078so3829885b3a.1; 
 Wed, 08 May 2024 05:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715171826; x=1715776626; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7VXByjdim0aNjUK7fR6kAyAUSfQPZjwFoKkgzvwvfQI=;
 b=IN9zJLGma0ACo9HbFBG6NJKDrsJTA3SLs9ARI7/OlGWW/qydkdBdcAMx0fWX5HvJTp
 fxQlmxsUnkk76HjrIW1K+uhmcUDy1wE1qyzM9sMtLpJvlIlhceAtGZRyN0fHGSyFtiZN
 BrIQMPXb/+3APL10hV2JcAgYeIGfFGRiyp1aEzNvR4D7g8XPPElzdWCcFE41yeY853T1
 F/p+mIA2XQ1d4BRWgolBualCjG2Hb8FKgjy2JoKWJUHklNZMK+oJ8EndVyRJ5pB41Ztu
 533Ed1/wS6FAmqSZkmOvq91OtAKF/Yx6Y0OwMBPOlWabrFCFAXudr/SECadQGJZaS3Gv
 Y9dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715171826; x=1715776626;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7VXByjdim0aNjUK7fR6kAyAUSfQPZjwFoKkgzvwvfQI=;
 b=PbvgZ8hKTsuZyms3pvYdUqR8slrt/cfkGIZTC9rECGXcKg04QwKNdoSvlPKq4j//iw
 rtnrUKtyCE3ztJEZKb2F/5tPff2ErvX3KkY9wT6dbULoevWsIKvh5ThgqTyjSgG22Piz
 /AmX7Jm1h0YVdaOzMBy+DJ+Rklotb8skwXR+Yckt5YAN/T+H5kzyaCsmVTJaMz7PcVPZ
 k1vBgRW/rT3p936YZxqMApFoU0VZmuEo6a+Y5+KkLqYtPY8MHbhaYSnoBJYFs5fErkUW
 tyCFW8P4RczqwWtXPMNv3FF6B7qBHMeK3cWWT6lQyCXBYgavfWQCl/vKBvqM2O3qaGqx
 StfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxKcCZZg64ByUbj1RAnAK6SrlV46R+i9uVNWrYjI8txbpAuEHVWP9nNg8Kx0CKuVBe6uChfDYp3OYSoc4uW5jTc6cW
X-Gm-Message-State: AOJu0YxudsohAUhiUHk7IwGO33V9N/UsofXRNY7RV4vrphEoiYyhmqWP
 bd074N1fqMi+aYwviInKRf4cMy/tMg+9CjJJr5+erNJiwGRpU9m+
X-Google-Smtp-Source: AGHT+IFy1bPi5jejFOOr8LIKN0uOy6IFs74x2Ut8nT0S4mLXC0y1pc9ZkTQfiU9tap+ylKeC/nd+Xg==
X-Received: by 2002:a05:6a21:3948:b0:1af:cefe:dbab with SMTP id
 adf61e73a8af0-1afcefedc59mr537335637.5.1715171825863; 
 Wed, 08 May 2024 05:37:05 -0700 (PDT)
Received: from localhost ([1.146.8.34]) by smtp.gmail.com with ESMTPSA id
 t4-20020a170902a5c400b001e7b82f33eesm11689985plq.291.2024.05.08.05.37.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 05:37:05 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 May 2024 22:37:00 +1000
Message-Id: <D149O0V77ABT.1ODT0ZNPBL9WK@gmail.com>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>, "Daniel Henrique
 Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH v2 27/28] target/ppc: Remove id_tlbs flag from CPU env
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>
X-Mailer: aerc 0.17.0
References: <cover.1714606359.git.balaton@eik.bme.hu>
 <5a24db3d48babe4e855707a01954b1827712772f.1714606359.git.balaton@eik.bme.hu>
 <D13EWAGCZ9F6.1LCJ4K7W21C3L@gmail.com>
 <11d79524-f9d1-6200-0889-515c9d0dbf9c@eik.bme.hu>
In-Reply-To: <11d79524-f9d1-6200-0889-515c9d0dbf9c@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed May 8, 2024 at 2:02 AM AEST, BALATON Zoltan wrote:
> On Tue, 7 May 2024, Nicholas Piggin wrote:
> > On Thu May 2, 2024 at 9:43 AM AEST, BALATON Zoltan wrote:
> >> This flag for split instruction/data TLBs is only set for 6xx soft TLB
> >> MMU model and not used otherwise so no need to have a separate flag
> >> for that.
> >>
> >> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> >> ---
> >>  hw/ppc/pegasos2.c        |  2 +-
> >>  target/ppc/cpu.h         |  1 -
> >>  target/ppc/cpu_init.c    | 19 +++++--------------
> >>  target/ppc/helper_regs.c |  1 -
> >>  target/ppc/mmu_common.c  | 10 ++--------
> >>  target/ppc/mmu_helper.c  | 12 ++----------
> >>  6 files changed, 10 insertions(+), 35 deletions(-)
> >>
> >> diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
> >> index 04d6decb2b..dfc6fab180 100644
> >> --- a/hw/ppc/pegasos2.c
> >> +++ b/hw/ppc/pegasos2.c
> >> @@ -984,7 +984,7 @@ static void *build_fdt(MachineState *machine, int =
*fdt_size)
> >>                            cpu->env.icache_line_size);
> >>      qemu_fdt_setprop_cell(fdt, cp, "i-cache-line-size",
> >>                            cpu->env.icache_line_size);
> >> -    if (cpu->env.id_tlbs) {
> >> +    if (cpu->env.tlb_type =3D=3D TLB_6XX) {
> >
> > Want to just add the standard comment here?
> >
> >    /* 6xx has separate TLBs for instructions and data */
>
> I think that comment would be redundant here because it's clear from the=
=20
> i-tlb, d-tlb this adds so I can do without a comment in this machine if=
=20
> you don't mind. (If this was not in my machine I would not mind adding a=
=20
> comment but I'd keep this one simple.) I think comments should only be=20
> added for things that are not clear from code.

Yes. "Obvious" stuff just builds up until it's not.

If you make a simple inline function to test if tlb is split and it can
est TLB_6XX then you don't need the comment.

Thanks,
Nick

