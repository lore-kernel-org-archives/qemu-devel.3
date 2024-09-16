Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31058C3ABA2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 11:45:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqA9z-00086b-PP; Mon, 16 Sep 2024 07:44:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sqA9w-00085q-K9
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 07:44:50 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sqA9s-0005CU-GT
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 07:44:47 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5c255e3c327so5609421a12.1
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2024 04:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726487082; x=1727091882; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7eibDQlWIgO5xr8jmaJAJnFY9I6atBDKIO/XJGulGKY=;
 b=coXkMw16IorgR6Wc3RxOaBZhy9DNDR3b9zJRYO6fTr07dgyPkgyiRjsIZpZohvmvsm
 HHeqRDmteptC1dKtRASx62ugy5bAgqX9HH+rMkZj+tKQkQr0tqqy8GZJgMVK8VuZwBU9
 r/jMTJQWLLmhqdCbmJqfFiolocSfdywJ/OnWHZnGsiDepcJgbKy3fXfjIV0Dl11lgten
 REwGo6cteIZOoZQ51znZsNa36Y0EJ/e4j2Kmh1aCenDiyQVMR7j86MR7UPfK0mQvz2Wk
 TMUprjPeCSEUGX86Gx5NME8mPbvjTJtXP4stbxS3Kr1kZ1VFh+/7/R5922IqAYP/rBFb
 UTww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726487082; x=1727091882;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7eibDQlWIgO5xr8jmaJAJnFY9I6atBDKIO/XJGulGKY=;
 b=u6n1dJHU2sl4B8/TS4UVpJAAOze5P21xyJALfZfisGiZtWXhyKvIJ7c29tuAxmNsZY
 UTResE7GInmuNJDW4klnMiJY/CUl8LjjHnyI081G7JjsxKrRuAwij1XR8RKSm8JbDZUN
 RTQwKGjbp7fz0ByMK5KDPI9AVkVZbGeFEtG5ZgBeAR/Sh3q/WthZxHv43EE+qdKIHLO5
 72GtVroB3TiwAuBRrhD/kMVfatnPzkWmsEJhxvfsavmaNYQxa3U1YxG7Ju00j1xTryXe
 3ltQfHjM96j6u1i5vPrfjpBNUftM9lR4KbrbOEsRxSs0ha8iFfx0XRueMq4yZqP/Rc3v
 frwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAdwq+hCXKECGygAnDeP4UwENp0x2Vb0CWf+xvwB570aCuJiGw34FjfFSJwm9TsNQ3A6FWgZ5FQObL@nongnu.org
X-Gm-Message-State: AOJu0Yxdt4BAp4EBY1kJA8hxvbBt5sAlfrAwetH19yqx8leRqavxU/Pa
 4qQ7OvIEFUZiQqt9kXIqOffr4MSI7O9CAcOCTMJfNKHMxDo9vOC0xzSj65vUNnkXI5p/NrmJ+7E
 vz7FLHwq1Gx6xWgxbN+kcz8o95/12DthVvPASmw==
X-Google-Smtp-Source: AGHT+IHohvvMvNVfWf/lTPJwAcVqLhCgWRLLrUs1vERd1oCXtug/JTPOm7UYYjn3wXbGCZ6ZSg1eQhbQ61NulZgyIjQ=
X-Received: by 2002:a05:6402:500c:b0:5c0:bba5:60d2 with SMTP id
 4fb4d7f45d1cf-5c413e2cf48mr13263389a12.21.1726487082094; Mon, 16 Sep 2024
 04:44:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240909201147.3761639-1-peterx@redhat.com>
 <20240909201147.3761639-2-peterx@redhat.com>
 <441f797f-a377-45de-bfe6-042542c917d8@kaod.org> <ZuRQirmjwWGj1N2D@x1n>
 <CAGNS4TaDVs9eqb9jO5kgi9bL1t1tmc-GywiyP3xpbgFGgvbkLg@mail.gmail.com>
 <0d4c42a4-352d-4b14-905d-ef4839c68ad1@ilande.co.uk>
In-Reply-To: <0d4c42a4-352d-4b14-905d-ef4839c68ad1@ilande.co.uk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Sep 2024 12:44:30 +0100
Message-ID: <CAFEAcA80SmMbNOhUqgB8h+16RR+d_hOeoVqUCJQZJHvDUtCaYw@mail.gmail.com>
Subject: Re: [PULL 1/9] softmmu: Support concurrent bounce buffers
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Mattias Nissler <mnissler@rivosinc.com>, Peter Xu <peterx@redhat.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Mon, 16 Sept 2024 at 12:29, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
>
> On 16/09/2024 09:23, Mattias Nissler wrote:
> > Looking at the code, the dma_memory_unmap calls in hw/ide/macio.c seem
> > to be passing buffer=3DNULL unconditionally, since the dma_mem field in
> > struct DBDMA_io is never set to anything non-zero. In fact, I believe
> > after commit be1e343995ef81fc05d9a4e1ec263ca171d842e7 "macio: switch
> > over to new byte-aligned DMA helpers", the dma_memory_unmap calls in
> > hw/ide/macio.c aren't doing anything and should probably have been
> > removed together with the dma_mem, dma_len and dir fields in struct
> > DBDMA_io. Speculative patch:
> >
> > diff --git a/hw/ide/macio.c b/hw/ide/macio.c
> > index e84bf2c9f6..15dd40138e 100644
> > --- a/hw/ide/macio.c
> > +++ b/hw/ide/macio.c
> > @@ -119,9 +119,6 @@ static void pmac_ide_atapi_transfer_cb(void
> > *opaque, int ret)
> >       return;
> >
> >   done:
> > -    dma_memory_unmap(&address_space_memory, io->dma_mem, io->dma_len,
> > -                     io->dir, io->dma_len);
> > -
> >       if (ret < 0) {
> >           block_acct_failed(blk_get_stats(s->blk), &s->acct);
> >       } else {
> > @@ -202,9 +199,6 @@ static void pmac_ide_transfer_cb(void *opaque, int =
ret)
> >       return;
> >
> >   done:
> > -    dma_memory_unmap(&address_space_memory, io->dma_mem, io->dma_len,
> > -                     io->dir, io->dma_len);
> > -
> >       if (s->dma_cmd =3D=3D IDE_DMA_READ || s->dma_cmd =3D=3D IDE_DMA_W=
RITE) {
> >           if (ret < 0) {
> >               block_acct_failed(blk_get_stats(s->blk), &s->acct);
> > diff --git a/include/hw/ppc/mac_dbdma.h b/include/hw/ppc/mac_dbdma.h
> > index 4a3f644516..c774f6bf84 100644
> > --- a/include/hw/ppc/mac_dbdma.h
> > +++ b/include/hw/ppc/mac_dbdma.h
> > @@ -44,10 +44,6 @@ struct DBDMA_io {
> >       DBDMA_end dma_end;
> >       /* DMA is in progress, don't start another one */
> >       bool processing;
> > -    /* DMA request */
> > -    void *dma_mem;
> > -    dma_addr_t dma_len;
> > -    DMADirection dir;
> >   };
> >
> >   /*
> >
> > C=C3=A9dric, can you try with the above patch and/or share more details=
 of
> > your setup so I can verify (I tried booting a ppc64el-pseries dqib
> > image but didn't see the issue)?
>
> I'm fairly sure that this patch would break MacOS 9 which was the reason =
that
> dma_memory_unmap() was added here in the first place: what I was finding =
was that
> without the dma_memory_unmap() the destination RAM wasn't being invalidat=
ed (or
> marked dirty), causing random crashes during boot.

dma_memory_unmap() of something you never mapped is
definitely wrong. Whatever is going on here, leaving the unmap
call in after you removed the dma_memory_map() call is just
papering over the actual cause of the crashes.

> Would the issue be solved by adding a corresponding dma_memory_map() befo=
rehand at
> the relevant places in hw/ide/macio.c? If that's required as part of the =
setup for
> bounce buffers then I can see how not having this present could cause pro=
blems.

The only purpose of this API is sequences of:
  host_ptr =3D dma_memory_map(...);
  access the host_ptr directly;
  dma_memory_unmap(...);

The bounce-buffer stuff is an internal implementation detail
of making this API work when the DMA is going to a device.

We need to find whatever the actual cause of the macos failure is.
Mattias' suggested change looks right to me.

I do wonder if something needs the memory barrier than
unmap does as part of its operation, e.g. in the
implementation of the dma_blk_* functions.

-- PMM

