Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66E96C48260
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 08:27:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXzk6-0007Vx-Ic; Thu, 08 Feb 2024 03:26:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rXzk4-0007Vn-Rw
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 03:26:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rXzjo-0006eQ-Li
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 03:26:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707380787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yd9VCyxzaht9p98pU0W4nVHjXCqEheeMpg1R9/PpZog=;
 b=eibUjKzO3tgt0us/IxCrb4MGIeNQFGulSgK+4zxG5+mtXeo7QP+JrI6FDWAlenFs61aqCU
 YC6Y8bF2HLfDhSNgKiSghHv0gdmUNOxZSvyQ2eJNFmO6lxO6pE1lgpBQR3MZO6AMlbvWxh
 AfLsyYznhRqg8E81IaHn0geqcrHVO5I=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-U9U0BgSlPJerRC8b7AowsQ-1; Thu, 08 Feb 2024 03:26:26 -0500
X-MC-Unique: U9U0BgSlPJerRC8b7AowsQ-1
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-466eef433c1so443978137.0
 for <qemu-devel@nongnu.org>; Thu, 08 Feb 2024 00:26:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707380785; x=1707985585;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yd9VCyxzaht9p98pU0W4nVHjXCqEheeMpg1R9/PpZog=;
 b=GE0jxLht5icJMxdc7NI7moFhKMT3Puz4KJqDgmwlYGe7jWM2ICH52zmiZ0H83PgOG5
 /01uq+1JYT+UE5LiRkj0lnVqBe2L4rg0WUbHfawopB3i8AFWQbjz5piutUvTTgd9w7FT
 U0aGO9+vMwTMsAavTc1UBsRiEP51X7OjGH3uTs/tU59awvE5M1dJAXC3V3oO/V8E1E5J
 TK2efyVWKaX+z52n017/P6SIg0VuaVj3B9wD7gQEvknA7z+PXzDBDj9/fzv+tl/yeCbV
 0FHVetoX89oMFtTXjjsbc/gUPtCdajGvkTcnZIc2ubinIH23TmLRxM8K5hQrpnvIRNpG
 qAMw==
X-Gm-Message-State: AOJu0YyZ0nXVyuJ7Pi1r2g37NJVD66eSiDXg7vB/APJA11anTduCd6pj
 pDRXei9IU/kY0X6yPfzNCvDktTLQEADpHZ2g+qrcBSakoqdo6ObhxdD3On1gabAtwc8mgmE2uS1
 lw13qZOt45iCRD+b0CKmNd2qHWB0rgGrrA3JN2/B0VQS3X6Yo6+wbrTKWYE0oXx+H7jgko7FIO4
 Jx8q6YJwmGsRv7rqhHTkr81clJ9Lg+jyNVeWw=
X-Received: by 2002:a05:6102:3224:b0:46d:1f64:96aa with SMTP id
 x4-20020a056102322400b0046d1f6496aamr4087992vsf.34.1707380784938; 
 Thu, 08 Feb 2024 00:26:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMIDe2akPd2fq8ncYzkFfRQm87vRCyZmSQl5OFd4H04SF2zw8fwwj/05mzNqYaDnNpNPv7Fm1+TFyjvuI1Kzw=
X-Received: by 2002:a05:6102:3224:b0:46d:1f64:96aa with SMTP id
 x4-20020a056102322400b0046d1f6496aamr4087987vsf.34.1707380784636; Thu, 08 Feb
 2024 00:26:24 -0800 (PST)
MIME-Version: 1.0
References: <20240207111411.115040-1-pbonzini@redhat.com>
 <20240207111411.115040-8-pbonzini@redhat.com>
 <81d117a3-ed1d-4023-a9ce-128729ec2e73@linaro.org>
In-Reply-To: <81d117a3-ed1d-4023-a9ce-128729ec2e73@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 8 Feb 2024 09:26:12 +0100
Message-ID: <CABgObfaop4uLqpjt8bXaL6=WoAz+M-sLiU0U+F=gtHkZMTo8aw@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] mips: allow compiling out CONFIG_MIPS_ITU
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, shentey@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.106,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_SORBS_WEB=1.5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Wed, Feb 7, 2024 at 8:12=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org> wrote:
>
> Hi Paolo,
>
> On 7/2/24 12:14, Paolo Bonzini wrote:
> > itc_reconfigure() is referenced from TCG, provide a stub if needed.
> > This makes it possible to build a QEMU binary that only includes
> > boards without a CPS device (only Malta and Boston create one).
> >
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >   hw/mips/mips_itu-stub.c | 26 ++++++++++++++++++++++++++
> >   hw/mips/meson.build     |  1 +
> >   2 files changed, 27 insertions(+)
> >   create mode 100644 hw/mips/mips_itu-stub.c
> >
> > diff --git a/hw/mips/mips_itu-stub.c b/hw/mips/mips_itu-stub.c
> > new file mode 100644
> > index 00000000000..4cc82b8461f
> > --- /dev/null
> > +++ b/hw/mips/mips_itu-stub.c
> > @@ -0,0 +1,26 @@
> > +/*
> > + * Inter-Thread Communication Unit emulation.
> > + *
> > + * Copyright (c) 2016 Imagination Technologies
> > + *
> > + * This library is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU Lesser General Public
> > + * License as published by the Free Software Foundation; either
> > + * version 2.1 of the License, or (at your option) any later version.
> > + *
> > + * This library is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> > + * Lesser General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU Lesser General Public
> > + * License along with this library; if not, see <http://www.gnu.org/li=
censes/>.
>
> This is your code addition, so "Inter-Thread Communication Unit stubs" /
> RH / SPDX GPLv2-or-later.
>
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "hw/misc/mips_itu.h"
> > +
> > +void itc_reconfigure(MIPSITUState *tag)
> > +{
> > +    abort();
>
> As Zoltan suggested, g_assert_not_reached(). Indeed this path
> can't be reached without ITU, TCG won't emit anything and will
> call instead:
>
>      qemu_log_mask(LOG_UNIMP, "mthc0 %s (reg %d sel %d)\n",
>                    register_name, reg, sel);
>
> I'm reluctant to add stubs, but since it helps you (hoping we
> can figure a clean way to split architectural access to hw/ from
> tcg/ one day):

Not sure how it's reached anyway, because the saar field of
DisasContext is never written...

Paolo


