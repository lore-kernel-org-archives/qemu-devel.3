Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37601C2A06C
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Jan 2026 05:49:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcGzI-0007I1-V2; Sun, 04 Jan 2026 00:49:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vcGzF-0007HU-Pl
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 00:49:10 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vcGzE-00083P-2n
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 00:49:09 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b83b72508f3so415893366b.2
 for <qemu-devel@nongnu.org>; Sat, 03 Jan 2026 21:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767505746; x=1768110546; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nENu6SBK3HiL7EzgDaTaflqo4atWWzKNUKJjLoyN+F4=;
 b=I4ASqE/ll30bhNpxMKcSu6BtVckAD6QtZj7gOSpWPWWykiqUN9bVa/TRoaOv8BMi5F
 wCkjsaqBTCZOfdzEd4wKDXPDArDTbbJnyR+/UVUyioIq5B8rKjgRB/SBQ6Tkfj1FttNp
 TpsCmqAG07zk/oeANHzKT0iNNmQCwxM9VSwKpfC6zpe+7xuwei4rA9qd+i4alTXsRPgt
 Rg5ho6/q4Q47Mg79246Q2ty3bQgPsrGBDZqpYUD8eRjMg1/LkrUgW4kIILQ0xiSnOzdQ
 m35EJ6xLRe/fR7MjTXsJJc5xADpXCkPy3sRfIGuxeK9+ImfsKqX/+KOknbaEyeG7bYVl
 ypcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767505746; x=1768110546;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nENu6SBK3HiL7EzgDaTaflqo4atWWzKNUKJjLoyN+F4=;
 b=g56U+gXJ0+5bkPjRj/4JneSsZph9r8+JiuDfTjnpUlcsvK5qpnVkufUuUm0RprF/7j
 OaDoLUAZmbn+VlshM+BfNs6FZjUipWEqvtfaQCji6X64J1RP0LqKfsr9uIxxp8fn38Nc
 LM70l0WDHz2R8dkXiskkx2rOf51jLs0+dW7RV1W/Y8jOlHWnxCM6GAf+KPtlELi32qAL
 7vz/q13xSwGrCH9qH0jA8dTTONbl3lt31jLZXm0TLyzWlQxavbAwUw72yp4zvS/V5IHO
 jGsXgYxd7nizRWqivW87QnqmWxk5E8jwnt7tCSK4679VfvCOU1+T0FIzLFIZZ2LiP0JY
 SgCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdsFrHJad7xBQMKLTKYVuBRTr432epwqGHmtsrGwoaQk2Z/oua/f8mjzjbDVxGi94awyywXEeVOUYc@nongnu.org
X-Gm-Message-State: AOJu0YyYvptyLYRX80+sHwRpdK36SYUP5OrDjlTIfZWOcW+331QfNON3
 /tIgNxgRX9BaAgFEZDMrV/yLFPf4b00DfDnK6uET7sO8QI9/QlsEVCGNr6C0Gea8zcxTt3FKZpM
 Up+BoToz7jLEFtBNRQY5pDn7z29vKmdY=
X-Gm-Gg: AY/fxX4pgrHRU8VLfo8wdwgVBxVFN3YBnnHwnVO+Fzwd6+zqltrzODM2hYaMVtEpmpB
 xYTCY/778s6nj/aPMF2Q+eSnohbAtvNvjxIfqZJarAma6o3V/prSuMUqAU6GD/KYd73uESheteU
 bDJ9f01vNHcYJ/3EXOwb9wn0o7CFKY9zxNyCyU29f5upv410jPbDNbKJuRLn6haLoZRrRXGyXqC
 HNmMnrOjB68AD1ZO3uL6WTDzScEK9Z1nLlSm92R+PNJvDv1FQZaG0X2v+/xK8PYgtRWrnw=
X-Google-Smtp-Source: AGHT+IG4jFPQbuOm6H3FkJm8ei7CLn4q++k6XjO7eN7s+bDtX1rcv86Rf+tUD2fVBBSj64Odx7EdTFF1ztnAIfNiHIY=
X-Received: by 2002:a17:906:f5a3:b0:b73:1baa:6424 with SMTP id
 a640c23a62f3a-b8037185956mr4566489966b.55.1767505746140; Sat, 03 Jan 2026
 21:49:06 -0800 (PST)
MIME-Version: 1.0
References: <20251230-colo_unit_test_multifd-v1-0-f9734bc74c71@web.de>
 <aVPpg_LwlGFIPfen@x1.local>
 <CAK3tnv+f8b9fd_n9_6Od3f__ZuNUtuT2Q_MXszam_k=ooRPqyQ@mail.gmail.com>
In-Reply-To: <CAK3tnv+f8b9fd_n9_6Od3f__ZuNUtuT2Q_MXszam_k=ooRPqyQ@mail.gmail.com>
From: Zhang Chen <zhangckid@gmail.com>
Date: Sun, 4 Jan 2026 13:48:29 +0800
X-Gm-Features: AQt7F2p8JyMj91uC3oLM5IecY7-zVJNQ46qbzJ1k1qBPY0qcQXvrYoZw1EmzVl0
Message-ID: <CAK3tnvLQfmvvoQTBgTCPnajxGpc2W_gVV6yQhRtD1y403M48kw@mail.gmail.com>
Subject: Re: [PATCH 0/3] migration: Add COLO multifd support and COLO
 migration unit test
To: Peter Xu <peterx@redhat.com>
Cc: Lukas Straub <lukasstraub2@web.de>, qemu-devel@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@trasno.org>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=zhangckid@gmail.com; helo=mail-ej1-x636.google.com
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

On Sun, Jan 4, 2026 at 1:44=E2=80=AFPM Zhang Chen <zhangckid@gmail.com> wro=
te:
>
> On Tue, Dec 30, 2025 at 11:02=E2=80=AFPM Peter Xu <peterx@redhat.com> wro=
te:
> >
> > On Tue, Dec 30, 2025 at 03:05:43PM +0100, Lukas Straub wrote:
> > > Hello everyone,
> > > This adds COLO multifd support and migration unit tests for COLO migr=
ation
> > > and failover.
> >
> > Hi, Lukas,
> >
> > I'll review the series after the new year.
> >
> > Could you still introduce some background on how you're deploying COLO?=
  Do
> > you use it in production, or for fun?
> >
> > COLO is still a nice and interesting feature, said that, COLO has quite=
 a
> > lot of code plugged into migration core.  I wished it's like a multifd
> > compressor which was much more self-contained, but it's not.  I wished =
we
> > can simplify the code in QEMU migration.
> >
> > We've talked it through before with current COLO maintainers, it looks =
to
> > me there aren't really much users using it in production, meanwhile COL=
O
> > doesn't look like a feature to benefit individual QEMU users either.
> >
> > I want to study the use case of COLO in status quo, and evaluate how mu=
ch
> > effort we should put on it in the future.  Note that if it's for fun we=
 can
> > always use a stable branch which will be there forever.  We'll need to
> > think about QEMU evolving in the future, and what's best for QEMU.
> >
> > Thanks,
> >
>
> Hi Lukas and Peter,
>
> Thanks for this series, I will support for background info if Peter
> have any questions.
> And CC Hailiang Zhang, although he hasn't replied to emails for a long ti=
me.
> If no one objects, I think Lukas can replease Hailiang for COLO Framework=
.
>

S/replease/replace

> COLO Framework
> M: Hailiang Zhang <zhanghailiang@xfusion.com>
> S: Maintained
> F: migration/colo*
> F: include/migration/colo.h
> F: include/migration/failover.h
> F: docs/COLO-FT.txt
>
> Thanks
> Chen
>
> > >
> > > Regards,
> > > Lukas
> > >
> > > Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> > > ---
> > > Lukas Straub (3):
> > >       multifd: Add colo support
> > >       migration-test: Add -snapshot option for COLO
> > >       migration-test: Add COLO migration unit test
> > >
> > >  migration/meson.build              |   2 +-
> > >  migration/multifd-colo.c           |  57 ++++++++++++++++++
> > >  migration/multifd-colo.h           |  26 +++++++++
> > >  migration/multifd.c                |  14 ++++-
> > >  tests/qtest/meson.build            |   7 ++-
> > >  tests/qtest/migration-test.c       |   1 +
> > >  tests/qtest/migration/colo-tests.c | 115 +++++++++++++++++++++++++++=
++++++++++
> > >  tests/qtest/migration/framework.c  |  69 +++++++++++++++++++++-
> > >  tests/qtest/migration/framework.h  |  10 ++++
> > >  9 files changed, 294 insertions(+), 7 deletions(-)
> > > ---
> > > base-commit: 942b0d378a1de9649085ad6db5306d5b8cef3591
> > > change-id: 20251230-colo_unit_test_multifd-8bf58dcebd46
> > >
> > > Best regards,
> > > --
> > > Lukas Straub <lukasstraub2@web.de>
> > >
> >
> > --
> > Peter Xu
> >

