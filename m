Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19BA4CCD192
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 13:56:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8fUu-0006CM-Cg; Tue, 14 Oct 2025 09:55:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1v8fUr-0006Bt-Uj
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:55:25 -0400
Received: from mail-qv1-xf36.google.com ([2607:f8b0:4864:20::f36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1v8fUn-0003py-HJ
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:55:25 -0400
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-78f58f4230cso61530266d6.1
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 06:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760450114; x=1761054914; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eqM2n9ouX3W8TRjEET6p8zyITW3j0B6dn6O/k5mtSKo=;
 b=iY2/ie+xRdSAd0oTiBFa/ey7Rpw9qvOQQtpDYBFGi3xxGcVrTEbPoCIBq95HOnVcOz
 fDWI1vd4NPWiHO3aF9/pDTPLPdTJ7d1j+2Lx0xGiH4R2+omATYL08auxPARdwfkw5vO6
 HpRmz+kvkGq5f/stGHcMmjU6Tb7jT+9T5K1jQHhBOkTd8Mrjb3sUE4hUvDC43q6sZo2E
 MPZOBDQOjyrNZJCS8CYYVCpWztSIMFEEGAe0dj+wgNrOKQMayqDWfHlMaFeojpyUe+Kb
 +ulGF+0semUlYynuPU1iKSEU6dfEoCHBbbSfFdLBgY3CVCnGcxbVBOI+bC02NFSN8cg1
 zXIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760450115; x=1761054915;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eqM2n9ouX3W8TRjEET6p8zyITW3j0B6dn6O/k5mtSKo=;
 b=Wl/tI48AU0llrc3/ctMPGm/pruSsYyjavHwEixjnjF5SPuX2YqXV0vOOc/tquovs9e
 tPiOPKTkITCjEJl31iNqeSjkqEZaoURNbS/4z/bZGTd1JGxUmUELnfkuRLM9i8f/1i3t
 K8dfPD+E+xgRxBySM+RRZb2/NU/mYzRNuGqWh2vKebXsP/CWIIMEcXejjbMC5k1iqTtr
 8/GF1IJISyTaCLqNdR47Ec8blvDRkdn58jJgfziOeXOwr5ZsXva5y/I248oTd5jcNLDy
 1vlPeh/lsjD0mdPGyuv9RVugrA29D67RmP9uxtLKpzAaoUQMZJNdss2+45I/z0DQNqqo
 CZXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWA4cYX2l+xCNa6FxcoBy1mutlCSdLBMhN38b0VX2xRJk3Rmaiz+RUZ+oFpBDqjR9+zpWMxcHOcRLGm@nongnu.org
X-Gm-Message-State: AOJu0Yy7Me8SAmLwCg0Ai203bq4jGCabqRJaOpP3Dp5zZHIY46Kvh82w
 fngLC9uP0IUyCPYNObUqE9ifJ78Khw89m5+pGc4Th5EwrcPvYhxdnz33aPoITkGWBiFZOQNFH7A
 KouKitJxoR6mWXSF6aXMTkfE1q5e9evg=
X-Gm-Gg: ASbGncu2a/1ZLq72vP0H7zXhEA13A5vWynlWyV+6R8A4iucWleq9fMu6eq8VULkzWyS
 iCUT/NkrPQNTlms3bbxQKJMkstXY0MfSAHWMxC6OUnZoOwDenMCfy6GladtwP9a/wkaM7Bh2btE
 omcfyW374oseFOoAwfbvTLPIPVzuDxg2d+w8PNWlw38O4V3Qy5hN2VDKs+JSInusHUEk/k/x6J9
 HKOU1rRKrIPjFJulREGoi6dDO+C7dgGSR2eLmZ+EZdP6h/bE8RiiCyQDzmWJ92RMKPD
X-Google-Smtp-Source: AGHT+IEZn83oHu9ZaLOZ4DeES5MQDbQlBVLpssZWqPqoKQVivfjEgDtY2HgC51w+dmHEVC5YqyKHLdCn2FJEx4Vx3/E=
X-Received: by 2002:ad4:5f4b:0:b0:820:a83:eaec with SMTP id
 6a1803df08f44-87b2efb961amr360633176d6.35.1760450114567; Tue, 14 Oct 2025
 06:55:14 -0700 (PDT)
MIME-Version: 1.0
References: <20251013133836.852018-1-vsementsov@yandex-team.ru>
 <20251013133836.852018-3-vsementsov@yandex-team.ru>
 <CAJ+F1C+W+hUuu--QopWqB14w2VWeiPkOxxGdS-v2K7MB4eye-A@mail.gmail.com>
 <6c5f3a6a-b237-4352-810e-345eb0f36904@yandex-team.ru>
In-Reply-To: <6c5f3a6a-b237-4352-810e-345eb0f36904@yandex-team.ru>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 14 Oct 2025 17:55:03 +0400
X-Gm-Features: AS18NWDqU25wkwfWepnzp2ddgbPc4RExqepzAM2xJ67aLGjkyXQjAfljLdiQq4w
Message-ID: <CAJ+F1CKhMu4RHsC22e_JfgCXLZHkuucux=VfTamx0_4yEJaR-Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] chardev/char: split chardev_init_logfd() out of
 qemu_char_open()
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net, 
 qemu-devel@nongnu.org, raphael@enfabrica.net, armbru@redhat.com, 
 yc-core@yandex-team.ru, d-tatianin@yandex-team.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::f36;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qv1-xf36.google.com
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

Hi

On Tue, Oct 14, 2025 at 1:21=E2=80=AFPM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> On 14.10.25 10:30, Marc-Andr=C3=A9 Lureau wrote:
> > On Mon, Oct 13, 2025 at 5:41=E2=80=AFPM Vladimir Sementsov-Ogievskiy
> > <vsementsov@yandex-team.ru> wrote:
> >>
> >> We are going to share new chardev_init_logfd() with further
> >> alternative initialization interface. Let qemu_char_open() be
> >> a wrapper for .open(), and its artifacts (handle be_opened if
> >> was not set to false by backend, and filename).
> >>
> >> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru=
>
> >
> > Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> >> ---
> >>   chardev/char.c | 49 +++++++++++++++++++++++++++++++-----------------=
-
> >>   1 file changed, 31 insertions(+), 18 deletions(-)
> >>
> >> diff --git a/chardev/char.c b/chardev/char.c
> >> index a43b7e5481..d5a2533e8e 100644
> >> --- a/chardev/char.c
> >> +++ b/chardev/char.c
> >> @@ -250,22 +250,6 @@ static void qemu_char_open(Chardev *chr, ChardevB=
ackend *backend,
> >>                              bool *be_opened, Error **errp)
> >>   {
> >>       ChardevClass *cc =3D CHARDEV_GET_CLASS(chr);
> >> -    /* Any ChardevCommon member would work */
> >
> > maybe keep that comment?
>
> I a bit don't follow it, honestly.. What it mean? That we should
> handle members of common structure here?

The ChardevBackend type is a union, and all the members inherit from
ChardevCommon. Ideally, we wouldn't cast this way, but that would
require some changes in code generator...

>
> Not a problem to put it back to chardev_init_logfd().. But maybe, it
> then should be renamed to chardev_init_common()
>
> >
> >
> >> -    ChardevCommon *common =3D backend ? backend->u.null.data : NULL;
> >> -
> >> -    if (common && common->logfile) {
> >> -        int flags =3D O_WRONLY;
> >> -        if (common->has_logappend &&
> >> -            common->logappend) {
> >> -            flags |=3D O_APPEND;
> >> -        } else {
> >> -            flags |=3D O_TRUNC;
> >> -        }
> >> -        chr->logfd =3D qemu_create(common->logfile, flags, 0666, errp=
);
> >> -        if (chr->logfd < 0) {
> >> -            return;
> >> -        }
> >> -    }
> >>
> >>       if (cc->open) {
> >>           cc->open(chr, backend, be_opened, errp);
> >> @@ -1000,6 +984,28 @@ void qemu_chr_set_feature(Chardev *chr,
> >>       return set_bit(feature, chr->features);
> >>   }
> >>
> >> +static bool chardev_init_logfd(Chardev *chr, ChardevBackend *backend,
> >> +                                Error **errp)
> >> +{
> >> +    ChardevCommon *common =3D backend ? backend->u.null.data : NULL;
> >> +
> >> +    if (common && common->logfile) {
> >> +        int flags =3D O_WRONLY;
> >> +        if (common->has_logappend &&
> >> +            common->logappend) {
> >> +            flags |=3D O_APPEND;
> >> +        } else {
> >> +            flags |=3D O_TRUNC;
> >> +        }
> >> +        chr->logfd =3D qemu_create(common->logfile, flags, 0666, errp=
);
> >> +        if (chr->logfd < 0) {
> >> +            return false;
> >> +        }
> >> +    }
> >> +
> >> +    return true;
> >> +}
> >> +
> >>   static Chardev *chardev_new(const char *id, const char *typename,
> >>                               ChardevBackend *backend,
> >>                               GMainContext *gcontext,
> >> @@ -1020,11 +1026,14 @@ static Chardev *chardev_new(const char *id, co=
nst char *typename,
> >>       chr->label =3D g_strdup(id);
> >>       chr->gcontext =3D gcontext;
> >>
> >> +    if (!chardev_init_logfd(chr, backend, errp)) {
> >> +        goto fail;
> >> +    }
> >> +
> >>       qemu_char_open(chr, backend, &be_opened, &local_err);
> >>       if (local_err) {
> >>           error_propagate(errp, local_err);
> >> -        object_unref(obj);
> >> -        return NULL;
> >> +        goto fail;
> >>       }
> >>
> >>       if (!chr->filename) {
> >> @@ -1035,6 +1044,10 @@ static Chardev *chardev_new(const char *id, con=
st char *typename,
> >>       }
> >>
> >>       return chr;
> >> +
> >> +fail:
> >> +    object_unref(obj);
> >> +    return NULL;
> >>   }
> >>
> >>   Chardev *qemu_chardev_new(const char *id, const char *typename,
> >> --
> >> 2.48.1
> >>
> >>
> >
> >
> > --
> > Marc-Andr=C3=A9 Lureau
>
>
> --
> Best regards,
> Vladimir



--=20
Marc-Andr=C3=A9 Lureau

