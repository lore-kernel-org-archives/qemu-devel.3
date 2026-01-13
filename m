Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24780D29DEC
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 09:22:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfabC-0006RL-Fb; Tue, 13 Jan 2026 04:22:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vfabA-0006QT-7l
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 04:22:00 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vfab6-0000P0-Ef
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 04:21:59 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-64b8123c333so11634757a12.3
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 01:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768296114; x=1768900914; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WEY5EqjzbiXCkJ2L9TDplMOaGKehcEgYOjDv2F9dCos=;
 b=hHag6o/6+OoxxN5f+jgfCG+zW5SV2zMxb9M6NrkBfI/EZ/wXHWj8qorq+NWyfwhZYf
 IGU2sFDRNELg5sMTZ1FJBUXqCdAKuA0q+ugzwU1E+h7EJkY3V2Yn+WsKvYPCTz9NU8lp
 vXDDksuRyhUCaMmSB/MwdebGxu0NDGRIOpJpso6I/d15XwnMFWssARRb1AkS19rk0cml
 RdMbwbBX1FCJluGBD2dcdzd2augJtnc7L7zF7ep928+XqYaOuU+ypG+38eGn+nZY1uwI
 D2ExUFAtUnPDWimiZMRmgZzcHzXkUEUAVTjDwnIIz0+6/5tRe7Twh86HP0+qoCDa8SPj
 cXKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768296114; x=1768900914;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WEY5EqjzbiXCkJ2L9TDplMOaGKehcEgYOjDv2F9dCos=;
 b=lDJlWMapSirvnv41qXgCYbSYsjKoUlG+V4JmQzbjyoZFGGj5oCaZM+hRagV0+m7Eqo
 lsis+TKBDgFqmJS1eYvnhKoe/1ISnWxlcQ2WZH2iiwMeLKe87sUkuNZRXv4qxOHft/6e
 lNnb8zAFtE/TF2IvYZGxJOnMdSOmXx9tTjbKhlrLhD6DnRymAEbcCdLA971oUBcNgxha
 DC+k8nqQDXoHtPA0R49B+0KX0twS9Euls0JT3oLLhxFR92uK79LtcIpdxseLqvRiqdTp
 ewBvrMEZPJ4ut+49fZnKn/1EN8d9RBojqWaAVxeSfpqTC9w6CqL/8osR6grb8JBtoOtz
 HuYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpG1CdmdGAMTYWKYlPjNlCq2A9JaKNzhLSHtvSSqUX1L/XElVLLTUJTVDG2BZSAvQJ7s8qzj8nIRVE@nongnu.org
X-Gm-Message-State: AOJu0Yz9qruMwRHQi+NhTIIIqpc2SkleJ4FpHiV7QUqnMsjZ9/XStg42
 dqMlAlXmykkNLO6E1HO1UySD0B3WZMDVW3pwCrRMskYmQHv7HjUvrGq1P2gUljClMHtk3Wri8t3
 zWVtqI7juwn0RqlqPFIVlLXFSGvtVHBw=
X-Gm-Gg: AY/fxX45yKTMezZJNnvmFKecLkOmbYy7478F5RGtMNbFMt+LmqUK92va4JhhuCVir/2
 SBcjyc/5vzoVTUR2HNZRnpNmCdJH4jGNC0LWS56eVjNY6+KxSvK2at/Dsscep19pyJCZX/n2Bgy
 QKTtacYROVWZ7Fg7zYg09wd4Mkk4QLG1AmaayssbzBv0ODNLE3n2mbXIw2UEnkTh2erWsAb0tdB
 goKj4d082rKAiq4Iich2LDPEyA6EcioUFlUzU47e+Lr9FaOhTa4fkwd+CXDb+Tn/B+D3CJxaDk4
 gdPfvA==
X-Google-Smtp-Source: AGHT+IEhl1YGCNDolpudFeyh/zCSZJTyW5pLw0WceFOfArkcIg1hD9fnRXIW4P/IePG9MKbyBwGmua49OQumZFku2EE=
X-Received: by 2002:a17:907:2d06:b0:b87:324b:9acb with SMTP id
 a640c23a62f3a-b87324ba3aemr299398966b.33.1768296114016; Tue, 13 Jan 2026
 01:21:54 -0800 (PST)
MIME-Version: 1.0
References: <20260104075412.1262-1-jasowang@redhat.com>
 <20260104075412.1262-2-jasowang@redhat.com>
 <CAK3tnv+97kgSAt-do3BwhzFewy+A3rcMrJj8K5r7hvSJag_tgA@mail.gmail.com>
 <CACGkMEsA4hoTWqetffmfJEZ7Jq5=6gQ1ik+UznXgSGiyhE_Hqw@mail.gmail.com>
 <CACGkMEs08wX5yBWcs05wiUmReb7boxTNy4+Br0dDUi=npfo1Cg@mail.gmail.com>
In-Reply-To: <CACGkMEs08wX5yBWcs05wiUmReb7boxTNy4+Br0dDUi=npfo1Cg@mail.gmail.com>
From: Zhang Chen <zhangckid@gmail.com>
Date: Tue, 13 Jan 2026 17:21:17 +0800
X-Gm-Features: AZwV_Qg__I8QOoI0H6jVoDztqtB_XKzlm6H-KgiPee_PRLCDI9j2pOct_X5wyPk
Message-ID: <CAK3tnv+j_7s5JhPb32C9FK565B6M2V9gRsGkg6x_J0YesEmgFQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] net/filter-redirector: add support for dynamic status
 on/off switching
To: Jason Wang <jasowang@redhat.com>
Cc: lizhijian@fujitsu.com, qemu-devel@nongnu.org, lulu@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=zhangckid@gmail.com; helo=mail-ed1-x531.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Jan 13, 2026 at 2:43=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Tue, Jan 6, 2026 at 4:09=E2=80=AFPM Jason Wang <jasowang@redhat.com> w=
rote:
> >
> > On Mon, Jan 5, 2026 at 9:19=E2=80=AFPM Zhang Chen <zhangckid@gmail.com>=
 wrote:
> > >
> > > On Sun, Jan 4, 2026 at 3:54=E2=80=AFPM Jason Wang <jasowang@redhat.co=
m> wrote:
> > > >
> > > > Currently, filter-redirector does not implement the status_changed
> > > > callback, which means the 'status' property cannot be used to
> > > > dynamically enable/disable the filter at runtime. When status is
> > > > set to 'off' via QMP/HMP, the filter still receives data from the
> > > > indev chardev because the chardev handlers remain registered.
> > > >
> > > > This patch adds proper support for the 'status' property:
> > > >
> > > > 1. Implement filter_redirector_status_changed() callback:
> > > >    - When status changes to 'off': remove chardev read handlers
> > > >    - When status changes to 'on': re-register chardev handlers
> > > >      (only if chardev is already open)
> > > >
> > > > 2. Update filter_redirector_setup() to respect initial status:
> > > >    - If filter is created with status=3Doff, do not register handle=
rs
> > > >    - This allows creating disabled filters via command line or QMP
> > > >
> > > > 3. Handle chardev OPENED/CLOSED events to re-arm handlers on reconn=
ect:
> > > >    - Keep the chr_event callback installed on CLOSE so a later OPEN=
ED
> > > >      can re-register the read handlers when nf->on
> > > >    - Use qemu_chr_fe_set_handlers_full(..., set_open=3Dfalse, sync_=
state=3Dfalse)
> > > >      instead of qemu_chr_fe_set_handlers() because the latter force=
s
> > > >      sync_state=3Dtrue and may emit CHR_EVENT_OPENED for an already=
-open
> > > >      backend. Doing that from inside the chr_event callback would c=
ause
> > > >      recursive/re-entrant OPENED handling.
> > > >
> > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > ---
> > > >  net/filter-mirror.c | 38 +++++++++++++++++++++++++++++++++-----
> > > >  1 file changed, 33 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/net/filter-mirror.c b/net/filter-mirror.c
> > > > index 8e01e98f40..aa2ab452fd 100644
> > > > --- a/net/filter-mirror.c
> > > > +++ b/net/filter-mirror.c
> > > > @@ -179,9 +179,16 @@ static void redirector_chr_event(void *opaque,=
 QEMUChrEvent event)
> > > >      MirrorState *s =3D FILTER_REDIRECTOR(nf);
> > > >
> > > >      switch (event) {
> > > > +    case CHR_EVENT_OPENED:
> > > > +        if (nf->on) {
> > > > +            qemu_chr_fe_set_handlers_full(&s->chr_in, redirector_c=
hr_can_read,
> > > > +                                          redirector_chr_read, red=
irector_chr_event,
> > > > +                                          NULL, nf, NULL, false, f=
alse);
> > > > +        }
> > > > +        break;
> > > >      case CHR_EVENT_CLOSED:
> > > > -        qemu_chr_fe_set_handlers(&s->chr_in, NULL, NULL, NULL,
> > > > -                                 NULL, NULL, NULL, true);
> > > > +        qemu_chr_fe_set_handlers_full(&s->chr_in, NULL, NULL, redi=
rector_chr_event,
> > > > +                                      NULL, nf, NULL, false, false=
);
> > > >          break;
> > > >      default:
> > > >          break;
> > > > @@ -306,9 +313,11 @@ static void filter_redirector_setup(NetFilterS=
tate *nf, Error **errp)
> > > >              return;
> > > >          }
> > > >
> > > > -        qemu_chr_fe_set_handlers(&s->chr_in, redirector_chr_can_re=
ad,
> > > > -                                 redirector_chr_read, redirector_c=
hr_event,
> > > > -                                 NULL, nf, NULL, true);
> > > > +        if (nf->on) {
> > > > +            qemu_chr_fe_set_handlers(&s->chr_in, redirector_chr_ca=
n_read,
> > > > +                                     redirector_chr_read, redirect=
or_chr_event,
> > > > +                                     NULL, nf, NULL, true);
> > > > +        }
> > > >      }
> > > >
> > > >      if (s->outdev) {
> > > > @@ -324,6 +333,24 @@ static void filter_redirector_setup(NetFilterS=
tate *nf, Error **errp)
> > > >      }
> > > >  }
> > > >
> > > > +static void filter_redirector_status_changed(NetFilterState *nf, E=
rror **errp)
> > > > +{
> > > > +    MirrorState *s =3D FILTER_REDIRECTOR(nf);
> > > > +
> > > > +    if (!s->indev) {
> > >
> > > It's better to add a error here, for example:
> > >
> > >         error_setg(errp,  "filter_redirector_status_changed failed fo=
r
> > > the s->indev cleared" );
> >
> > Will do.
> >
>
> I think it's probably wrong to return an error here as we may only use
> outdev but not indev, in this case status_changed doesn't need to do
> anything.

This confuses me. The filter_redirector_status_changed code focus on
how to read the the indev, it looks not affect the outdev.
If we just return without any error, the user is unsure whether the attempt
was successful.

Thanks
Chen

>
> Thanks
>

