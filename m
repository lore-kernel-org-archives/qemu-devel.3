Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9528C67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 14:35:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruCZH-000239-DV; Tue, 09 Apr 2024 10:35:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ruCZF-00020P-Ab
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 10:35:21 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ruCZ9-0002aU-Ne
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 10:35:21 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-56e56ee8d5cso3451722a12.2
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 07:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712673314; x=1713278114; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GxP/xLOSQE4DlqjS6hxD6RpV28qNSWUAHdA1VliyOg0=;
 b=fOdHwRh1nO9VX8hVXwjkQO2kSdO5IBzjUMH7jZLKw+tmGY+i3gfMXqEe6hiB7dUbSX
 5PJ1AC5fSwcRJ2ScvXNZKcsEzaMh8Mid73izpsfPj70W+UAe6wZe6FwhVdpVAgN65dS9
 cqEi3EIY94HuwGcYik912cLcVFojAL2Bqv5jORm9qw4QRSpqwWcPyO0hjZuqgkWn23Cx
 UKXzboTA7wYk+pg7QuksZArWTe2R1anf4OIi+bup2FvCR0vDmcREjmcHzWVpB3A3kjdD
 nuVyvB81VL9Vui5/ZjRAGBmnPbzPloDw2KfQWtSv7mwTqUetWK9Ct5+iVKYQCLQV6ezt
 k8jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712673314; x=1713278114;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GxP/xLOSQE4DlqjS6hxD6RpV28qNSWUAHdA1VliyOg0=;
 b=MnG5GVrazpI6IhjYzF4JnA2xpX+Bv05OIkhBEwPM2DdssNn8lvnuMYDjFXu3IGYZrL
 gLahkd7j0qS/D/AXhm0+zi43JpeFPrxRFuohPS5v6GftGvEwvgi3f3w706w7fXttdvhJ
 JZhhGFflYM5Q1saYu4tHrrHWderrhMwYWDg7Hf3WavsairYMZbKnNoyUrbjnJg6/VLo0
 8R3I/07VBxpo3onAncpCp/VPfKYY/Dubc1QNY/5q/OFKG2hxhFjgQI57oNUKRYHfAWc6
 RhIc/BBNFdiCS8xUMjexBSC/sqeuQzY3PPIQQkknsLIIxdc8diaEaefpBskPa9/9+djH
 jZiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJFCvB1Ms+l7YTdEG/JqoUL4VOKxyK9g/S18jztpasO7FrpZ66URqYA5rv676t/kkz/VaapaUGGewKrzqhBbKrj7JNAwo=
X-Gm-Message-State: AOJu0YwEGpEBE6VS44dNDuzCg8ery6chtBen0GfGbaE0FcresAsS922A
 ayzjMDAMUoGsLQL97QhEXu+XaTRKTzf2ooTtG1UwzZuDnPAdRGcy53Csrru3U01vMFIoeYlXVgg
 GZO2DerpJNOTqgr48xylWsX1nxHSWU4Qv8Xz0Mw==
X-Google-Smtp-Source: AGHT+IECGSkbWKFSnYTrHx1muxALrruUoMZs6nDrfynceIA6/aSeJRRdgHOQklv/+WejsjqIX4AQOqSvzB4xb/UQwsE=
X-Received: by 2002:a50:cd5d:0:b0:56e:2464:7c41 with SMTP id
 d29-20020a50cd5d000000b0056e24647c41mr9418694edj.19.1712673314113; Tue, 09
 Apr 2024 07:35:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240404140833.1557953-1-ross.lagerwall@citrix.com>
 <90f07634-1600-4654-8e36-7ac9e2f457e8@perard>
 <CAG7k0EqJvVZJUNaf31Jd1ZfwvOon8saNbtHofon=VvB6gpj9qw@mail.gmail.com>
In-Reply-To: <CAG7k0EqJvVZJUNaf31Jd1ZfwvOon8saNbtHofon=VvB6gpj9qw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Apr 2024 15:35:03 +0100
Message-ID: <CAFEAcA9LzTTO=H6CB26-wVAFJg5xvq8tpkrKOY_D57376NNfkw@mail.gmail.com>
Subject: Re: [PATCH] xen-hvm: Avoid livelock while handling buffered ioreqs
To: Ross Lagerwall <ross.lagerwall@citrix.com>
Cc: Anthony PERARD <anthony.perard@cloud.com>,
 Stefano Stabellini <sstabellini@kernel.org>, 
 Paul Durrant <paul@xen.org>, xen-devel@lists.xenproject.org,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, 9 Apr 2024 at 15:20, Ross Lagerwall <ross.lagerwall@citrix.com> wro=
te:
>
> On Tue, Apr 9, 2024 at 11:20=E2=80=AFAM Anthony PERARD <anthony.perard@cl=
oud.com> wrote:
> >
> > On Thu, Apr 04, 2024 at 03:08:33PM +0100, Ross Lagerwall wrote:
> > > diff --git a/hw/xen/xen-hvm-common.c b/hw/xen/xen-hvm-common.c
> > > index 1627da739822..1116b3978938 100644
> > > --- a/hw/xen/xen-hvm-common.c
> > > +++ b/hw/xen/xen-hvm-common.c
> > > @@ -521,22 +521,30 @@ static bool handle_buffered_iopage(XenIOState *=
state)
> > [...]
> > >
> > >  static void handle_buffered_io(void *opaque)
> > >  {
> > > +    unsigned int handled;
> > >      XenIOState *state =3D opaque;
> > >
> > > -    if (handle_buffered_iopage(state)) {
> > > +    handled =3D handle_buffered_iopage(state);
> > > +    if (handled >=3D IOREQ_BUFFER_SLOT_NUM) {
> > > +        /* We handled a full page of ioreqs. Schedule a timer to con=
tinue
> > > +         * processing while giving other stuff a chance to run.
> > > +         */
> >
> > ./scripts/checkpatch.pl report a style issue here:
> >     WARNING: Block comments use a leading /* on a separate line
> >
> > I can try to remember to fix that on commit.
>
> I copied the comment style from a few lines above but I guess it was
> wrong.

Yes, this is one of those cases where we've settled on a
style choice but there's still quite a lot of older code
in the codebase that doesn't adhere to it. Checkpatch
usually will catch this kind of nit for you.

thanks
-- PMM

