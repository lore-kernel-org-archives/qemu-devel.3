Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57786CD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 09:13:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rraC2-0003ZU-W7; Tue, 02 Apr 2024 05:12:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rraC1-0003Ys-M4; Tue, 02 Apr 2024 05:12:33 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rraBy-0000uP-Sx; Tue, 02 Apr 2024 05:12:33 -0400
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3c3d3710018so3358026b6e.0; 
 Tue, 02 Apr 2024 02:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712049149; x=1712653949; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pmRLkFPcCYGEbzXm5XIvm2bNH7RrJifMQvB8jaCAK3g=;
 b=mNkPislyrPX/j9aORuOQ7GhFWUTWSDetRvgx0B/69/OD3Mw+vQcQqt+1kkauG6/hLf
 8wtK5NAXCNT1qA5Sq1hbQwjUTmkR4SB9QaZwu60oQ2Fe78rXHGB7YI9fVt9m0FycjlS0
 g9AGL+ajvqOaN72jTjzHt6oUzbUUm6yqibFrucvEzQKSW3pNQ6qy0RyIWWtMwDtwAU52
 cq4aKRd0Be+Hlb4IVbUdW1CWQzUIYhCoInVul/BIx0Zts2oQH84yGG5NG6QcDP0MfMyl
 esZaRezcsXMrJcM+LDSZT4o4bZuTJhaMZn+qwje3iDUhlKnJtyGJuVqXRcUr5UyEBZs/
 gLxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712049149; x=1712653949;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pmRLkFPcCYGEbzXm5XIvm2bNH7RrJifMQvB8jaCAK3g=;
 b=YmnuPVVmsU+/dQdHgtmci3ZFxJ0Q4aoYA+qJAn97gG+X5/AIKP44lSnuEoJUvToFKu
 SU4HzPvJN1VKjEjBO3kcEocwVz8+TqUnfi63J4pMw7zy85XIWfaNgOcwRnGrJfTg1Z2K
 RDBkJ2LtWsE2EVGvmra7AZ6kzhfdkw6VznMIg7VhMAiTTp23DKha9/rv8+1QnNv/if/0
 einJASN0v3qsdpwWXuOZdOiPFaWAMedTMcXNGWHfnr5FUr3VLzqqTPSBbx+7iVrp2iAK
 V6/xnWdpZSyvdtjlR9rmL2VMW+5NYeFui/gpVlIxj8VHaZQ87S33yr/kH3NejiDsG5+/
 YNow==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaF1z+mQlx0fU72Ytauw0SHqYaTZGujAuYAs8gu1kUFZsKQbaoR8qAVYEa2zYQRxNReL7dBT1CZZ+Bc95IEMfd579Ga/I=
X-Gm-Message-State: AOJu0YwRYFmtNIYfbVTJdH0YHxcHi6Srx5atvA9LiI/KNcuL71y1lRup
 gp/xyet2VayHyEkH+OmMkfzBux0QpjkXI3MODAhtoDk7st4NVGHsfWtluw7ELmc4Rb0siayLrj2
 K8UA9sHn8GRZLegkrM90/esnAv7A=
X-Google-Smtp-Source: AGHT+IGkfwcQFoS80Mg0yb+NWY8d5sY7qP9BwK6vS3Ki+AsD59hHnXXAVj2q74bSUXAPrL2wltPIzlN9SSzdpFUyYJU=
X-Received: by 2002:a05:6808:1385:b0:3c3:e81f:a2b0 with SMTP id
 c5-20020a056808138500b003c3e81fa2b0mr15502495oiw.36.1712049148974; Tue, 02
 Apr 2024 02:12:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240328102052.3499331-1-marcandre.lureau@redhat.com>
 <20240328102052.3499331-7-marcandre.lureau@redhat.com>
 <65d791e4-6c68-4b6d-b181-bc3886745ce3@yandex-team.ru>
In-Reply-To: <65d791e4-6c68-4b6d-b181-bc3886745ce3@yandex-team.ru>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 2 Apr 2024 13:12:17 +0400
Message-ID: <CAJ+F1CLbjZG24rMKwA20NFM=6sTE4CRAaGt4Vha+bP8i=+on-A@mail.gmail.com>
Subject: Re: [PATCH 06/19] block/stream: fix -Werror=maybe-uninitialized
 false-positives
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, Hyman Huang <yong.huang@smartx.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-block@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Mahmoud Mandour <ma.mandourr@gmail.com>, John Snow <jsnow@redhat.com>, 
 Klaus Jensen <its@irrelevant.dk>, Fam Zheng <fam@euphon.net>, 
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Bin Meng <bin.meng@windriver.com>, Hanna Reitz <hreitz@redhat.com>, 
 Eric Blake <eblake@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yuval Shaia <yuval.shaia.ml@gmail.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Jesper Devantier <foss@defmacro.it>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Keith Busch <kbusch@kernel.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-oi1-x22a.google.com
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

On Fri, Mar 29, 2024 at 12:35=E2=80=AFPM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> On 28.03.24 13:20, marcandre.lureau@redhat.com wrote:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > ../block/stream.c:193:19: error: =E2=80=98unfiltered_bs=E2=80=99 may be=
 used uninitialized [-Werror=3Dmaybe-uninitialized]
> > ../block/stream.c:176:5: error: =E2=80=98len=E2=80=99 may be used unini=
tialized [-Werror=3Dmaybe-uninitialized]
> > trace/trace-block.h:906:9: error: =E2=80=98ret=E2=80=99 may be used uni=
nitialized [-Werror=3Dmaybe-uninitialized]
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Again, same false-positives, because of WITH_GRAPH_RDLOCK_GUARD()..
>
> Didn't you try to change WITH_ macros somehow, so that compiler believe i=
n our good intentions?
>


#define WITH_QEMU_LOCK_GUARD_(x, var) \
    for (g_autoptr(QemuLockable) var =3D \
                qemu_lockable_auto_lock(QEMU_MAKE_LOCKABLE_NONNULL((x))); \
         var; \
         qemu_lockable_auto_unlock(var), var =3D NULL)

I can't think of a clever way to rewrite this. The compiler probably
thinks the loop may not run, due to the "var" condition. But how to
convince it otherwise? it's hard to introduce another variable too..

> Actually, "unused variable initialization" is bad thing too.
>
> Anyway, if no better solution for now:
> Acked-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>
> > ---
> >   block/stream.c | 6 +++---
> >   1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/block/stream.c b/block/stream.c
> > index 7031eef12b..9076203193 100644
> > --- a/block/stream.c
> > +++ b/block/stream.c
> > @@ -155,8 +155,8 @@ static void stream_clean(Job *job)
> >   static int coroutine_fn stream_run(Job *job, Error **errp)
> >   {
> >       StreamBlockJob *s =3D container_of(job, StreamBlockJob, common.jo=
b);
> > -    BlockDriverState *unfiltered_bs;
> > -    int64_t len;
> > +    BlockDriverState *unfiltered_bs =3D NULL;
> > +    int64_t len =3D -1;
> >       int64_t offset =3D 0;
> >       int error =3D 0;
> >       int64_t n =3D 0; /* bytes */
> > @@ -177,7 +177,7 @@ static int coroutine_fn stream_run(Job *job, Error =
**errp)
> >
> >       for ( ; offset < len; offset +=3D n) {
> >           bool copy;
> > -        int ret;
> > +        int ret =3D -1;
> >
> >           /* Note that even when no rate limit is applied we need to yi=
eld
> >            * with no pending I/O here so that bdrv_drain_all() returns.
>
> --
> Best regards,
> Vladimir
>
>


--=20
Marc-Andr=C3=A9 Lureau

