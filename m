Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00428CF6497
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 11:29:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svEat-0002Wp-M9; Mon, 30 Sep 2024 07:29:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1svEar-0002V3-Rv; Mon, 30 Sep 2024 07:29:33 -0400
Received: from mail-qt1-x82a.google.com ([2607:f8b0:4864:20::82a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1svEaq-0004N6-7i; Mon, 30 Sep 2024 07:29:33 -0400
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-45826431d4bso30666871cf.0; 
 Mon, 30 Sep 2024 04:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727695770; x=1728300570; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oVEU7bG4R02SCFt4ngOdTUGBrQ/mta0OwcVD9bxyDOQ=;
 b=JZGf64XdtZlLkYB1WdoQUXbocGPhklaGWa0N114kIE5ZyvD49br6xn1gwlrQohV8Yd
 yrZHziJOCxguWk84vrFysvZSu1GsPHlYuKkTrjTZGeKtsbMhnRvBKwEq0DkIJKGfk1Lf
 TCFSDwhBkGZfbHCySV0H1sGGDnRqO3ObkF31W0gslRTV+iF0z05UfDV7gX4cZ+8UToIK
 Bh6VE0BQZUuGamMrSdUKH1jXrjlWy2sSsZDtuhoHS1CsmgcelpgssuJXBpZJMjERBZNk
 cLvLj1lnNu4IoLPFznayY5ci8swfvFcMc5EGFP1o6mEVuZ00aTL7vOb4gT7DOgpQNGpm
 xwmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727695770; x=1728300570;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oVEU7bG4R02SCFt4ngOdTUGBrQ/mta0OwcVD9bxyDOQ=;
 b=FZTo0bsNxI3a6vSqj/5+14HAT9ss6p0HK+mN/udCSz/7uw5CeJHSscftaDldpYweVG
 gRyglMr5PH9L4jhhd1Je2xZyhhrAoNwEg/ABC1xIMsJ64NZHNvt5wMLMC1kelpALtUzy
 n4BaC5Chp3EkoB7DpYrz7tpPSVvMGucUQjAN9rQr72C3Ns8BGfRZMZPKdF1yI04PSjri
 0ZHNmGUey0RNxhJhwzg7bSv9b/q1oa2EQXmn0JwytCK67rw4e0tXtQkC9kZS36yaAxfV
 yNlRnPRkW9f5DkP8fOXq5S6rDPvLN8rVfdMEkswwPcCxnhRiZh+39tAVsJU0BqgUG3ng
 sZJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrQtyzscame3sjT+MsvhH16MAUhfgDLddrH1dq5X/HWY/603HbuxkTA9m35sHlBeRmCyPUGf0xJ6n9@nongnu.org
X-Gm-Message-State: AOJu0YysGqTTFvvElL1JDwrcnvBYlhYGu1Fy7F1rPxSc3sHLPuu+/1EX
 ZP1CdnZE6c1aIHnoM2Xfo2QSOeg0h8u90Q+uWMtuKcjkQNJ1TU8arkPScx6oULc5M/u9ODIONv9
 iGGOq1FXilQFpHhrQ7eEX+QUEkT4=
X-Google-Smtp-Source: AGHT+IFHlky2Nx1dRpJHYVtNNS9AZ2d8rWmhw01YClVipKd2RUtyg1gHW0/JGXwliR5ib2/461YQ73rzHtMfaisE7Co=
X-Received: by 2002:ac8:7d82:0:b0:458:3986:1970 with SMTP id
 d75a77b69052e-45c9f1e788fmr200903361cf.14.1727695770587; Mon, 30 Sep 2024
 04:29:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240930081458.1926382-1-marcandre.lureau@redhat.com>
 <20240930081458.1926382-20-marcandre.lureau@redhat.com>
 <CAJaqyWf2OAy74jK6yBWiy9fZ-OL=v7V=A-60kViG5K8SM2qJDQ@mail.gmail.com>
 <CAJaqyWc0Fnnb96XUF7ra2MeLTOkWtREcjPch+kWC9p8P4Bh40Q@mail.gmail.com>
In-Reply-To: <CAJaqyWc0Fnnb96XUF7ra2MeLTOkWtREcjPch+kWC9p8P4Bh40Q@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 30 Sep 2024 15:29:18 +0400
Message-ID: <CAJ+F1CK2DLYoAdEYUF5kgFDSJujJROhwWxAD7j6N2a0it1bnWg@mail.gmail.com>
Subject: Re: [PATCH v3 19/22] RFC: hw/virtio: a potential leak fix
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Fam Zheng <fam@euphon.net>,
 Song Gao <gaosong@loongson.cn>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, 
 qemu-block@nongnu.org, Laurent Vivier <laurent@vivier.eu>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Greg Kurz <groug@kaod.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, 
 Eric Blake <eblake@redhat.com>, Hyman Huang <yong.huang@smartx.com>,
 Kevin Wolf <kwolf@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 John Snow <jsnow@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Jesper Devantier <foss@defmacro.it>, Peter Xu <peterx@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 Keith Busch <kbusch@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Yuval Shaia <yuval.shaia.ml@gmail.com>, Bin Meng <bin.meng@windriver.com>
Content-Type: multipart/alternative; boundary="000000000000af9db806235484e2"
Received-SPF: pass client-ip=2607:f8b0:4864:20::82a;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000af9db806235484e2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 3:05=E2=80=AFPM Eugenio Perez Martin <eperezma@redh=
at.com>
wrote:

> On Mon, Sep 30, 2024 at 1:02=E2=80=AFPM Eugenio Perez Martin
> <eperezma@redhat.com> wrote:
> >
> > On Mon, Sep 30, 2024 at 10:17=E2=80=AFAM <marcandre.lureau@redhat.com> =
wrote:
> > >
> > > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > >
> > > vhost_svq_get_buf() may return a VirtQueueElement that should be free=
d.
> > >
> > > It's unclear to me if the vhost_svq_get_buf() call should always
> return NULL.
> > >
> >
> > Continuing conversation of v2,
> >
> > Yes there are situations where vhost_svq_get_buf can return a valid
> > buffer here and we could leak memory, so this fixes a bug.
> >
> > So,
> >
> > Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> >
> > Thanks!
> >
>
> (I hit "send" too early)
>
> Wwe could use a better patch subject though. Even "Freeing leaked
> memory from vhost_svq_get_buf in vhost_svq_poll" would work better for
> me. What do you think?
>
> Thanks!
>

ok thanks!


>
> > > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > > ---
> > >  hw/virtio/vhost-shadow-virtqueue.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/hw/virtio/vhost-shadow-virtqueue.c
> b/hw/virtio/vhost-shadow-virtqueue.c
> > > index 3b2beaea24..37aca8b431 100644
> > > --- a/hw/virtio/vhost-shadow-virtqueue.c
> > > +++ b/hw/virtio/vhost-shadow-virtqueue.c
> > > @@ -414,6 +414,7 @@ static uint16_t vhost_svq_last_desc_of_chain(cons=
t
> VhostShadowVirtqueue *svq,
> > >      return i;
> > >  }
> > >
> > > +G_GNUC_WARN_UNUSED_RESULT
> > >  static VirtQueueElement *vhost_svq_get_buf(VhostShadowVirtqueue *svq=
,
> > >                                             uint32_t *len)
> > >  {
> > > @@ -528,6 +529,7 @@ size_t vhost_svq_poll(VhostShadowVirtqueue *svq,
> size_t num)
> > >      size_t len =3D 0;
> > >
> > >      while (num--) {
> > > +        g_autofree VirtQueueElement *elem =3D NULL;
> > >          int64_t start_us =3D g_get_monotonic_time();
> > >          uint32_t r =3D 0;
> > >
> > > @@ -541,7 +543,7 @@ size_t vhost_svq_poll(VhostShadowVirtqueue *svq,
> size_t num)
> > >              }
> > >          } while (true);
> > >
> > > -        vhost_svq_get_buf(svq, &r);
> > > +        elem =3D vhost_svq_get_buf(svq, &r);
> > >          len +=3D r;
> > >      }
> > >
> > > --
> > > 2.45.2.827.g557ae147e6
> > >
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--000000000000af9db806235484e2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Sep 30, 2024 at 3:05=E2=80=AF=
PM Eugenio Perez Martin &lt;<a href=3D"mailto:eperezma@redhat.com">eperezma=
@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">On Mon, Sep 30, 2024 at 1:02=E2=80=AFPM Eugenio Perez Martin<br>
&lt;<a href=3D"mailto:eperezma@redhat.com" target=3D"_blank">eperezma@redha=
t.com</a>&gt; wrote:<br>
&gt;<br>
&gt; On Mon, Sep 30, 2024 at 10:17=E2=80=AFAM &lt;<a href=3D"mailto:marcand=
re.lureau@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;=
 wrote:<br>
&gt; &gt;<br>
&gt; &gt; From: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lure=
au@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
&gt; &gt;<br>
&gt; &gt; vhost_svq_get_buf() may return a VirtQueueElement that should be =
freed.<br>
&gt; &gt;<br>
&gt; &gt; It&#39;s unclear to me if the vhost_svq_get_buf() call should alw=
ays return NULL.<br>
&gt; &gt;<br>
&gt;<br>
&gt; Continuing conversation of v2,<br>
&gt;<br>
&gt; Yes there are situations where vhost_svq_get_buf can return a valid<br=
>
&gt; buffer here and we could leak memory, so this fixes a bug.<br>
&gt;<br>
&gt; So,<br>
&gt;<br>
&gt; Reviewed-by: Eugenio P=C3=A9rez &lt;<a href=3D"mailto:eperezma@redhat.=
com" target=3D"_blank">eperezma@redhat.com</a>&gt;<br>
&gt;<br>
&gt; Thanks!<br>
&gt;<br>
<br>
(I hit &quot;send&quot; too early)<br>
<br>
Wwe could use a better patch subject though. Even &quot;Freeing leaked<br>
memory from vhost_svq_get_buf in vhost_svq_poll&quot; would work better for=
<br>
me. What do you think?<br>
<br>
Thanks!<br></blockquote><div><br></div><div>ok thanks!</div><div>=C2=A0<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; &gt; Signed-off-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marca=
ndre.lureau@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&g=
t;<br>
&gt; &gt; ---<br>
&gt; &gt;=C2=A0 hw/virtio/vhost-shadow-virtqueue.c | 4 +++-<br>
&gt; &gt;=C2=A0 1 file changed, 3 insertions(+), 1 deletion(-)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost=
-shadow-virtqueue.c<br>
&gt; &gt; index 3b2beaea24..37aca8b431 100644<br>
&gt; &gt; --- a/hw/virtio/vhost-shadow-virtqueue.c<br>
&gt; &gt; +++ b/hw/virtio/vhost-shadow-virtqueue.c<br>
&gt; &gt; @@ -414,6 +414,7 @@ static uint16_t vhost_svq_last_desc_of_chain(=
const VhostShadowVirtqueue *svq,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 return i;<br>
&gt; &gt;=C2=A0 }<br>
&gt; &gt;<br>
&gt; &gt; +G_GNUC_WARN_UNUSED_RESULT<br>
&gt; &gt;=C2=A0 static VirtQueueElement *vhost_svq_get_buf(VhostShadowVirtq=
ueue *svq,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0uint32_t *len)<br>
&gt; &gt;=C2=A0 {<br>
&gt; &gt; @@ -528,6 +529,7 @@ size_t vhost_svq_poll(VhostShadowVirtqueue *s=
vq, size_t num)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 size_t len =3D 0;<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 while (num--) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_autofree VirtQueueElement *elem =
=3D NULL;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int64_t start_us =3D g_get_mono=
tonic_time();<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t r =3D 0;<br>
&gt; &gt;<br>
&gt; &gt; @@ -541,7 +543,7 @@ size_t vhost_svq_poll(VhostShadowVirtqueue *s=
vq, size_t num)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } while (true);<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 vhost_svq_get_buf(svq, &amp;r);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 elem =3D vhost_svq_get_buf(svq, &amp=
;r);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 len +=3D r;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;<br>
&gt; &gt; --<br>
&gt; &gt; 2.45.2.827.g557ae147e6<br>
&gt; &gt;<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--000000000000af9db806235484e2--

