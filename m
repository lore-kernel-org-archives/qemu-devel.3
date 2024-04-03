Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 846E1CD1288
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Apr 2024 09:24:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrwr7-0007av-6T; Wed, 03 Apr 2024 05:24:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rrwr5-0007ab-F4; Wed, 03 Apr 2024 05:24:27 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rrwr3-0001k2-Mc; Wed, 03 Apr 2024 05:24:27 -0400
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3c4f23d23d9so1063172b6e.3; 
 Wed, 03 Apr 2024 02:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712136264; x=1712741064; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FfvDl/wUq9YrTXMjg6ReoE+YL5Xyy0nNJVJn3ta9FnU=;
 b=IRWhxqbQmhvTwAN/n2uTkl2GUIM1xVfhG+VYxEiLaTZwM2f6qUt2G5Ftgx6Gg/jFVo
 WUwF8fL8I/w4QGDtTJjeu6aAYah+d9HKXN+ygEo3YlnX5x41UK+G8xSOgjgBB9zX7H+4
 QpamIZH/CDQ96sXKLgZqFZMw32wv2eGz4K/jDhX1YCo33q9/eDWSr4PYDa1ZSLO/URBl
 AdxHne1c00E65cbJezME2/K4xk4tKNI0vnkJ+RL4vqBoW3YzD/rgUmXavVp429BEz212
 l5VmD5jhQJB2+0Yr9DL9hSdxvMNSbDLXZgPTahIdLOWomSvArChTG3MTw2AxV1MDfY2A
 hsqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712136264; x=1712741064;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FfvDl/wUq9YrTXMjg6ReoE+YL5Xyy0nNJVJn3ta9FnU=;
 b=c7k61sS4lkyYCwKnQG2iVPYO1JgSaoRc7PhBjANOuRy49E4Yyw3FGY5r3WbKbsawNq
 G0N5IhhTG49yYvZEYHFwTtbvk6FWfYuy+KdS88YKSGiQFqsr9cIXyzzn9ldHu9O/iH0X
 w/n7yFQ/1vnwODEjckAiL1hVuF+XlMlEYI7GVUKO86SYh5peqRnttDPFpfsPyZxQ7/B6
 Gy7yNjDrqd/BzXIXNQ58ObSvP42jvQoshlOBP/TV3qg/Xb8W0aY7/xsmt5iKbCrVqPCs
 TdDBpetwxiin9pRurmELa5iu4kuTxsLj/qQYwW3dLsO/KYIS2zm3P5uRC8Bzq5MSMtpX
 3MNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2RGf+5WEa4AcdVewo2uq+Vc6mYtJDWxifu069KtK0ViKqGWICszDrXLu7SsNGO7QTIliJoYhmJV/8fwcoCB3ko7rpkCbLGFs8TVAjQ4XmPWtlBXeNbdEwDrbUlw==
X-Gm-Message-State: AOJu0Yxv1KBGMDr6Kvs1oLN2fEx6cOx8aiZbK4aUg62VxhpzzLfIpN9s
 5F9AkRm8/Uq/+wOU09z7aIaXacEiuubufQbPgH9PfOgGwprkKTl+ESoerYlDTMklga2HltsUTUK
 MK1RyFaynW2iMuKMkLF77llY+Xss=
X-Google-Smtp-Source: AGHT+IG0tlFbimNdmUBHcbrItV+nhHI5eJkKmJSeg18RVxZbBs4TwKx4D22Vu29I1lYit/o+5fZTtXDfe0rgEpbuPn4=
X-Received: by 2002:a05:6808:11cc:b0:3c3:c0e5:8d47 with SMTP id
 p12-20020a05680811cc00b003c3c0e58d47mr748087oiv.31.1712136263942; Wed, 03 Apr
 2024 02:24:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240328102052.3499331-1-marcandre.lureau@redhat.com>
 <20240328102052.3499331-7-marcandre.lureau@redhat.com>
 <65d791e4-6c68-4b6d-b181-bc3886745ce3@yandex-team.ru>
 <CAJ+F1CLbjZG24rMKwA20NFM=6sTE4CRAaGt4Vha+bP8i=+on-A@mail.gmail.com>
 <0d7344c2-b146-44cf-a911-21fa5e556665@yandex-team.ru>
 <mzls26xlctld3fd5fl3h5wdrbh6hb5i3xcakeslwzny5tva7ch@w6wnruxtefkl>
 <3064bc69-3d8e-4d7c-b640-a7ab703f9575@yandex-team.ru>
 <CAJ+F1CLG+7BT8wLFmmJ0t8NvMu2a2Vp1+p6gUuBTch9haYP8LQ@mail.gmail.com>
 <ba76742d-4fa1-4120-98ad-944845a37ad6@yandex-team.ru>
In-Reply-To: <ba76742d-4fa1-4120-98ad-944845a37ad6@yandex-team.ru>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 3 Apr 2024 13:24:11 +0400
Message-ID: <CAJ+F1CKAWpeOKe=8YM38_H6xP5cvDJ0RQXcSvm9LUMLpyo4ndw@mail.gmail.com>
Subject: Re: [PATCH 06/19] block/stream: fix -Werror=maybe-uninitialized
 false-positives
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, 
 Hyman Huang <yong.huang@smartx.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 John Snow <jsnow@redhat.com>, 
 Klaus Jensen <its@irrelevant.dk>, Fam Zheng <fam@euphon.net>, 
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Bin Meng <bin.meng@windriver.com>, Hanna Reitz <hreitz@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yuval Shaia <yuval.shaia.ml@gmail.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Jesper Devantier <foss@defmacro.it>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Keith Busch <kbusch@kernel.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::229;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-oi1-x229.google.com
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

On Wed, Apr 3, 2024 at 12:31=E2=80=AFPM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> On 03.04.24 11:11, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Tue, Apr 2, 2024 at 11:24=E2=80=AFPM Vladimir Sementsov-Ogievskiy
> > <vsementsov@yandex-team.ru> wrote:
> >>
> >> On 02.04.24 18:34, Eric Blake wrote:
> >>> On Tue, Apr 02, 2024 at 12:58:43PM +0300, Vladimir Sementsov-Ogievski=
y wrote:
> >>>>>> Again, same false-positives, because of WITH_GRAPH_RDLOCK_GUARD().=
.
> >>>>>>
> >>>>>> Didn't you try to change WITH_ macros somehow, so that compiler be=
lieve in our good intentions?
> >>>>>>
> >>>>>
> >>>>>
> >>>>> #define WITH_QEMU_LOCK_GUARD_(x, var) \
> >>>>>        for (g_autoptr(QemuLockable) var =3D \
> >>>>>                    qemu_lockable_auto_lock(QEMU_MAKE_LOCKABLE_NONNU=
LL((x))); \
> >>>>>             var; \
> >>>>>             qemu_lockable_auto_unlock(var), var =3D NULL)
> >>>>>
> >>>>> I can't think of a clever way to rewrite this. The compiler probabl=
y
> >>>>> thinks the loop may not run, due to the "var" condition. But how to
> >>>>> convince it otherwise? it's hard to introduce another variable too.=
.
> >>>>
> >>>>
> >>>> hmm. maybe like this?
> >>>>
> >>>> #define WITH_QEMU_LOCK_GUARD_(x, var) \
> >>>>       for (g_autoptr(QemuLockable) var =3D \
> >>>>                   qemu_lockable_auto_lock(QEMU_MAKE_LOCKABLE_NONNULL=
((x))), \
> >>>>            var2 =3D (void *)(true); \
> >>>>            var2; \
> >>>>            qemu_lockable_auto_unlock(var), var2 =3D NULL)
> >>>>
> >>>>
> >>>> probably, it would be simpler for compiler to understand the logic t=
his way. Could you check?
> >>>
> >>> Wouldn't that attach __attribute__((cleanup(xxx))) to var2, at which
> >>> point we could cause the compiler to call xxx((void*)(true)) if the
> >>> user does an early return inside the lock guard, with disastrous
> >>> consequences?  Or is the __attribute__ applied only to the first out
> >>> of two declarations in a list?
> >>>
> >>
> >> Oh, most probably you are right, seems g_autoptr apply it to both vari=
ables. Also, we don't need qemu_lockable_auto_unlock(var) separate call, if=
 we zero-out another variable. So, me fixing:
> >>
> >> #define WITH_QEMU_LOCK_GUARD_(x, var) \
> >>       for (QemuLockable *var __attribute__((cleanup(qemu_lockable_auto=
_unlock))) =3D qemu_lockable_auto_lock(QEMU_MAKE_LOCKABLE_NONNULL((x))), \
> >>            *var2 =3D (void *)(true); \
> >>            var2; \
> >>            var2 =3D NULL)
> >>
> >> (and we'll need to modify qemu_lockable_auto_unlock() to take "QemuLoc=
kable **x" argument)
> >>
> >
> > That's almost good enough. I fixed a few things to generate var2.
> >
> > I applied a similar approach to WITH_GRAPH_RDLOCK_GUARD macro:
> >
> > --- a/include/block/graph-lock.h
> > +++ b/include/block/graph-lock.h
> > @@ -224,13 +224,22 @@ graph_lockable_auto_unlock(GraphLockable *x)
> >
> >   G_DEFINE_AUTOPTR_CLEANUP_FUNC(GraphLockable, graph_lockable_auto_unlo=
ck)
> >
> > -#define WITH_GRAPH_RDLOCK_GUARD_(var)                                 =
        \
> > -    for (g_autoptr(GraphLockable) var =3D graph_lockable_auto_lock(GML=
_OBJ_()); \
> > -         var;                                                         =
        \
> > -         graph_lockable_auto_unlock(var), var =3D NULL)
> > +static inline void TSA_NO_TSA coroutine_fn
> > +graph_lockable_auto_cleanup(GraphLockable **x)
> > +{
> > +    graph_lockable_auto_unlock(*x);
> > +}
> > +
> > +#define WITH_GRAPH_RDLOCK_GUARD__(var) \
> > +    GraphLockable *var \
> > +        __attribute__((cleanup(graph_lockable_auto_cleanup))) G_GNUC_U=
NUSED =3D \
> > +       graph_lockable_auto_lock(GML_OBJ_())
> > +
> > +#define WITH_GRAPH_RDLOCK_GUARD_(var, var2)                           =
  \
> > +    for (WITH_GRAPH_RDLOCK_GUARD__(var), *var2 =3D (void *)true; var2;
> > var2 =3D NULL)
> >
> >   #define WITH_GRAPH_RDLOCK_GUARD() \
> > -    WITH_GRAPH_RDLOCK_GUARD_(glue(graph_lockable_auto, __COUNTER__))
> > +    WITH_GRAPH_RDLOCK_GUARD_(glue(graph_lockable_auto, __COUNTER__),
> > glue(graph_lockable_auto, __COUNTER__))
> >
> > Unfortunately, it doesn't work in all cases. It seems to have issues
> > with some guards:
> > ../block/stream.c: In function =E2=80=98stream_run=E2=80=99:
> > ../block/stream.c:216:12: error: =E2=80=98ret=E2=80=99 may be used unin=
itialized
> > [-Werror=3Dmaybe-uninitialized]
> >    216 |         if (ret < 0) {
> >
> >
>
> So, updated macro helps in some cases, but doesn't help here? Intersting,=
 why.
>
> > What should we do? change the macros + cherry-pick the missing
> > false-positives, or keep this series as is?
> >
> >
>
> I think marco + missing is better. No reason to add dead-initializations =
in cases where new macros helps.

Ok

> Still, would be good to understand, what's the difference, why it help on=
 some cases and not help in another.

I don't know, it's like if the analyzer was lazy for this particular
case, although there is nothing much different from other usages.

If I replace:
for (... *var2 =3D (void *)true; var2;
with:
for (... *var2 =3D (void *)true; var2 || true;

then it doesn't warn..

Interestingly as well, if I change:
    for (... *var2 =3D (void *)true; var2; var2 =3D NULL)
for:
    for (... *var2 =3D GML_OBJ_(); var2; var2 =3D NULL)

GML_OBJ_() simply being &(GraphLockable) { }), an empty compound
literal, then it doesn't work, in all usages.

All in all, I am not sure the trick of using var2 is really reliable either=
.

--=20
Marc-Andr=C3=A9 Lureau

