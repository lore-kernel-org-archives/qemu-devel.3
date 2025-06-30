Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA146C83030
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 12:09:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWDJs-0008Pf-8K; Mon, 30 Jun 2025 08:09:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1uWDJj-0008Ng-Vw
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 08:09:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1uWDJZ-0001y2-Go
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 08:08:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751285324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WJOAFNow4V2hcxo4fZUgJ931Bq5F3Mkn//kUrnuCO9o=;
 b=DWbYrDV7KTvJx4JSw0Yyguwn4Pe6VNzBUr7qtOU+9D8/tWa/3V9u6doP1Lc+/kwH0Ou0RE
 T/jimNqagAI/zYQrVJR1SvKuz0fgW1D1yj+2PaySzX37tLUIxcKpGNmyO3y1oyzUX5qFjm
 GD+GxV4rC00KWeLEfPirReYEUzBhvM8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-cLsUKBEBOMigo5SM545zaw-1; Mon, 30 Jun 2025 08:08:43 -0400
X-MC-Unique: cLsUKBEBOMigo5SM545zaw-1
X-Mimecast-MFC-AGG-ID: cLsUKBEBOMigo5SM545zaw_1751285322
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4a587c85a60so106635011cf.2
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 05:08:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751285322; x=1751890122;
 h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WJOAFNow4V2hcxo4fZUgJ931Bq5F3Mkn//kUrnuCO9o=;
 b=IPXRn7aiUOzcYBw2gIfIpfAk7bAHafNFI3tp5TR0YYzc1fUJyfF/LNk+5cRWrNtFrj
 lGm9vSiolns9jT79/y2sDhFNWoj3hNpeTWO/QB0J9nEeVZQXP1wbaZZPllhQAN8nNiCh
 tLuuWuYpojW6PikHP45kYBKxPHYTqVlR7yNknO4MhYuo8AHw+PyOipB2QwedI+n8fMyE
 UBolRGpl4o5Dr1Yywa0i+b5jgcFc0qmzOLHUk/XjpSa0ek1gPD5epZcJEUv87If6p6Hh
 2/uO4nFRTmKGTUGFKnrKTmDMvmtgooqzB/fQ+IhQzQOYgD+qfMA84+bEoLn/ru7Nazad
 3R0w==
X-Gm-Message-State: AOJu0YxA8W420xSK+LDzFkDZF8NN32h2Dgd18pSK5BYrIyxQPJfbLHr7
 LYEDsIkeTu53Ir+mYawoYFCVtGwqFv4L1icnuDS/xVb/1BcOIOjDQYea3C8WELMpyXxobXQH5oX
 nIze2zXv5PwOesfFwVJNV7OjJX8npLWhl5PdoIv9VdC0LQl6EhoG1aYmY2Nwi+sELp0rTW8i8AY
 cJkiedewJmzCqW4KSqzRi+xSf+GT0igNW0O5zmXPU=
X-Gm-Gg: ASbGncukQtFscpXDRQK7CSRazDt5d3bkVaNHFGvHEmYLqAU2Fqzj1kYCCaAp1x+VrwZ
 Egwj5rU9VoMEhwEExYGC7oVgS6J/KrKN8LIToNa4cZhFsbYO//SrMRGaeU4GtIQyziC37mrv6hf
 4=
X-Received: by 2002:a05:622a:110b:b0:4a5:a96d:6068 with SMTP id
 d75a77b69052e-4a7fcde957cmr226795701cf.37.1751285322134; 
 Mon, 30 Jun 2025 05:08:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkyLWeQcRYHD2wdXKJblO55FQcIW457Umuqwg96C03yv8794rfhTwpXFJ0x08iRLuB221VBFAww0bcfj8p/hY=
X-Received: by 2002:a05:622a:110b:b0:4a5:a96d:6068 with SMTP id
 d75a77b69052e-4a7fcde957cmr226795201cf.37.1751285321750; Mon, 30 Jun 2025
 05:08:41 -0700 (PDT)
Received: from 744723338238 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 30 Jun 2025 08:08:40 -0400
From: Andrea Bolognani <abologna@redhat.com>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-94-richard.henderson@linaro.org>
 <CABJz62OFyaXitSdge4M9_oTk34a5aocLJLFYfkOGXc0BToOgVA@mail.gmail.com>
 <CABJz62OMmmbDjWpp6YkXu2d+hB4HeShgqaa05ZigAVqNQSwjZA@mail.gmail.com>
 <c3a2c4f9-c750-4a0a-b6bc-e94b55784952@linaro.org>
MIME-Version: 1.0
In-Reply-To: <c3a2c4f9-c750-4a0a-b6bc-e94b55784952@linaro.org>
Date: Mon, 30 Jun 2025 08:08:40 -0400
X-Gm-Features: Ac12FXyaTpUe0-wGYzdUKf5dbYUnko60cgMD8f2dtsUl20XXeMHzpWW6IsCORmw
Message-ID: <CABJz62Ntvsj6PDRoor=Wy5x603buuBopqPcX8cEAsfhGiX6WvA@mail.gmail.com>
Subject: Re: [PATCH v4 093/163] tcg: Convert extract to TCGOutOpExtract
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=abologna@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Fri, Jun 27, 2025 at 06:16:56AM -0700, Richard Henderson wrote:
> On 6/26/25 09:20, Andrea Bolognani wrote:
> > On Mon, Jun 09, 2025 at 06:52:21AM -0700, Andrea Bolognani wrote:
> > > On Tue, Apr 15, 2025 at 12:24:04PM -0700, Richard Henderson wrote:
> > > > Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> > > > ---
> > > >   tcg/tcg.c                        | 20 +++++++++
> > > >   tcg/aarch64/tcg-target.c.inc     | 28 +++++++-----
> > > >   tcg/arm/tcg-target.c.inc         | 23 +++++-----
> > > >   tcg/i386/tcg-target.c.inc        | 77 +++++++++++++++++---------------
> > > >   tcg/loongarch64/tcg-target.c.inc | 33 +++++++-------
> > > >   tcg/mips/tcg-target.c.inc        | 35 +++++++--------
> > > >   tcg/ppc/tcg-target.c.inc         | 35 +++++++--------
> > > >   tcg/riscv/tcg-target.c.inc       | 54 +++++++++++-----------
> > > >   tcg/s390x/tcg-target.c.inc       | 14 +++---
> > > >   tcg/sparc64/tcg-target.c.inc     | 16 ++++---
> > > >   tcg/tci/tcg-target.c.inc         |  8 ++--
> > > >   11 files changed, 191 insertions(+), 152 deletions(-)
> > >
> > > Hi Richard,
> > >
> > > this seems to have introduced a regression when running on a riscv64
> > > host.
> > >
> > > Before the change:
> > >
> > >    $ timeout --foreground 1 \
> > >      ./build/qemu-system-riscv64 -machine virt,accel=tcg \
> > >      -display none -serial stdio 2>&1 | grep -i opensbi
> > >    OpenSBI v1.5.1
> > >
> > > After the change, no output is produced.
> > >
> > > This causes the
> > >
> > >    qemu:func-quick+func-riscv64 / func-riscv64-riscv_opensbi
> > >
> > > test to stall and eventually fail due to the built-in test suite
> > > timeout kicking in.
> > >
> > > Interestingly, I can't reproduce this by running the exact same
> > > commands and using the exact same git commits on an x86_64 host.
> > >
> > > Do you have any idea what could be going wrong? I'll happily
> > > investigate further if you give me pointers.
> >
> > Hi,
> >
> > this is still an issue as of f9a3def17b2a.
> >
> > Any idea where to look?
>
> tcg/riscv/tcg-target.c.inc, tgen_extract(), must be at fault.
>
> Oh, I see it:
>
> --- a/tcg/riscv/tcg-target.c.inc
> +++ b/tcg/riscv/tcg-target.c.inc
> @@ -2502,7 +2502,7 @@ static void tgen_extract
>          }
>      }
>      if (ofs + len == 32) {
> -        tgen_shli(s, TCG_TYPE_I32, a0, a1, ofs);
> +        tgen_shri(s, TCG_TYPE_I32, a0, a1, ofs);
>          return;
>      }
>      if (len == 1) {
>
>
> Please test.

This indeed seems to do the trick, I get output from OpenSBI now.

  Tested-by: Andrea Bolognani <abologna@redhat.com>

Thank you!

-- 
Andrea Bolognani / Red Hat / Virtualization


