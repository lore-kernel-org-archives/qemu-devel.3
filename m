Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33C9EC4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 09:38:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raYBP-00085P-Vt; Thu, 15 Feb 2024 04:37:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1raYBO-00085G-HC
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 04:37:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1raYBM-00069A-JH
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 04:37:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707989847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Gpd4lECPFg6xf2HFCyQKksU/50mjjHc6aADDlYkeaUs=;
 b=ANFbkz+IloMyl6FElx1kWcuB/KyJNRb2BaofV8O13f9lWh5B8Suk6rxmFopRXT0Uj889MJ
 8EQEdHbXbVz88Cs0bMsZ1wu6qUcmjk+SFcIBOlG/2FJxe2PHMDgR/YmdKzQrcOGir5SoLO
 nDhjYByznl+riC7uLCCiPHAT6csDZOo=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-Q7-uEGayPEqfoDrxVV7xzg-1; Thu, 15 Feb 2024 04:37:25 -0500
X-MC-Unique: Q7-uEGayPEqfoDrxVV7xzg-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-29608f00cbbso556444a91.2
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 01:37:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707989844; x=1708594644;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Gpd4lECPFg6xf2HFCyQKksU/50mjjHc6aADDlYkeaUs=;
 b=KWLH4WggLpTH4OjYIr4Fz+SZl98ZfUfFYtrJFCJl5MwObE30PHrV6oEBf2n4e/4lsp
 lKBwLITRDUfFYZ0k1aL4H796ohW/5WbUkBebTggKXK04hZMhqz6EXabWs1JeKKgOiyWB
 WnVu1pjzo4VHmoQkxWf+7b2OO6YhdCJuQcJvMuqHc5h0W7Z1iYKdSqxWxZau53Af9hcx
 ids0u6ONbZFUpNeo4F86KIZHX18czCYvsLzfMWqDLbndX1DZ8MF8KOy+ZzxWntueNwhj
 TslRRfoxrYgZYY6xfaFfJhg7FQjHP+JYljaNCoKE4eVkZOmFzXp5rKaOqkdWxOT/GmxW
 kxMQ==
X-Gm-Message-State: AOJu0Yw9mnhEeC0hXfCxXvltRYkkHa5FFqZt9QB1f5xLhUxMWyBxy7L5
 kmokqgcdFJg4Xc01i5zAxk0I4KAld0EDWzt2w3kbEgh4cFm+3jRf0TS/izrGXhJ0hlSU75B/cPH
 zLcW3elvu+9t/zqpyvGRh2NVnjibWBcAk84Gd2qDTkMZRgGfDD3nHqqrxpUR5HPSF9TMHDzIKqP
 4bE1YgIEB8hKdRsjgF2wA/b8Iv+kY=
X-Received: by 2002:a17:90b:10e:b0:297:22a3:43f2 with SMTP id
 p14-20020a17090b010e00b0029722a343f2mr1064944pjz.41.1707989844383; 
 Thu, 15 Feb 2024 01:37:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjkhYBDvsa/o5k2H85fUe/dEOwZCwcUuabyH4HhQAbuuRGEgsFcEdaGBUAS4y4D2U/gpzPO7n9tVMMVaJEXoc=
X-Received: by 2002:a17:90b:10e:b0:297:22a3:43f2 with SMTP id
 p14-20020a17090b010e00b0029722a343f2mr1064935pjz.41.1707989844127; Thu, 15
 Feb 2024 01:37:24 -0800 (PST)
MIME-Version: 1.0
References: <20240109125614.220293-1-aesteve@redhat.com>
 <20240109125614.220293-2-aesteve@redhat.com>
 <87a5off4qe.fsf@draig.linaro.org>
In-Reply-To: <87a5off4qe.fsf@draig.linaro.org>
From: Albert Esteve <aesteve@redhat.com>
Date: Thu, 15 Feb 2024 10:37:12 +0100
Message-ID: <CADSE00LDa9ebDsnpMUKq8LzezWHZVpfg7K0VV4f8r-_ZjyC+8Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] hw/virtio: check owner for removing objects
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, stefanha@gmail.com, 
 "Michael S. Tsirkin" <mst@redhat.com>, marcandre.lureau@gmail.com,
 kraxel@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000f084990611685fb8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.531,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--000000000000f084990611685fb8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 1:57=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@linaro=
.org> wrote:

> Albert Esteve <aesteve@redhat.com> writes:
>
> > Shared objects lack spoofing protection.
> > For VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE messages
> > received by the vhost-user interface, any backend was
> > allowed to remove entries from the shared table just
> > by knowing the UUID. Only the owner of the entry
> > shall be allowed to removed their resources
> > from the table.
>
> Was this buggy behaviour on the part of the vhost-user daemon?
>

Yes, although the feature is not really used yet, and it requires to know
the UUID to be able to exploit it. But yes, any vhost-user backend could
remove any entry.


>
> > To fix that, add a check for all
> > *SHARED_OBJECT_REMOVE messages received.
> > A vhost device can only remove TYPE_VHOST_DEV
> > entries that are owned by them, otherwise skip
> > the removal, and inform the device that the entry
> > has not been removed in the answer.
> >
> > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  docs/interop/vhost-user.rst |  4 +++-
> >  hw/virtio/vhost-user.c      | 21 +++++++++++++++++++--
> >  2 files changed, 22 insertions(+), 3 deletions(-)
> >
> > diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> > index 9f1103f85a..60ec2c9d48 100644
> > --- a/docs/interop/vhost-user.rst
> > +++ b/docs/interop/vhost-user.rst
> > @@ -1839,7 +1839,9 @@ is sent by the front-end.
> >    When the ``VHOST_USER_PROTOCOL_F_SHARED_OBJECT`` protocol
> >    feature has been successfully negotiated, this message can be
> submitted
> >    by the backend to remove themselves from to the virtio-dmabuf shared
> > -  table API. The shared table will remove the back-end device
> associated with
> > +  table API. Only the back-end owning the entry (i.e., the one that
> first added
> > +  it) will have permission to remove it. Otherwise, the message is
> ignored.
> > +  The shared table will remove the back-end device associated with
> >    the UUID. If ``VHOST_USER_PROTOCOL_F_REPLY_ACK`` is negotiated, and
> the
> >    back-end sets the ``VHOST_USER_NEED_REPLY`` flag, the front-end must
> respond
> >    with zero when operation is successfully completed, or non-zero
> otherwise.
> > diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> > index f214df804b..1c3f2357be 100644
> > --- a/hw/virtio/vhost-user.c
> > +++ b/hw/virtio/vhost-user.c
> > @@ -1611,11 +1611,27 @@
> vhost_user_backend_handle_shared_object_add(struct vhost_dev *dev,
> >  }
> >
> >  static int
> > -vhost_user_backend_handle_shared_object_remove(VhostUserShared *object=
)
> > +vhost_user_backend_handle_shared_object_remove(struct vhost_dev *dev,
> > +                                               VhostUserShared *object=
)
> >  {
> >      QemuUUID uuid;
> >
> >      memcpy(uuid.data, object->uuid, sizeof(object->uuid));
> > +    switch (virtio_object_type(&uuid)) {
> > +    case TYPE_VHOST_DEV:
>
> It would be nice if we could add a kdoc annotation to SharedObjectType
> describing what the various types mean.
>

I can add it.


>
> > +    {
> > +        struct vhost_dev *owner =3D virtio_lookup_vhost_device(&uuid);
> > +        if (owner =3D=3D NULL || dev !=3D owner) {
>
> I dev is always set dev !=3D owner should also cover the NULL case.
>

True, I can remove the NULL case from the condition.


> However will we see uuid's that aren't associated with anything?
>

Theoretically, it shouldn't happen. Dmabufs in the host and the guest are
aligned,
and when one buffer is cleaned up it should not be requested anymore, as
the drivers
in the guest are aware. But a vhost-user backend could have buggy/malicious
requests, so worth the check.


>
> > +            /* Not allowed to remove non-owned entries */
> > +            return 0;
> > +        }
> > +        break;
> > +    }
> > +    default:
> > +        /* Not allowed to remove non-owned entries */
> > +        return 0;
> > +    }
> > +
> >      return virtio_remove_resource(&uuid);
> >  }
> >
> > @@ -1794,7 +1810,8 @@ static gboolean backend_read(QIOChannel *ioc,
> GIOCondition condition,
> >          ret =3D vhost_user_backend_handle_shared_object_add(dev,
> &payload.object);
> >          break;
> >      case VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE:
> > -        ret =3D
> vhost_user_backend_handle_shared_object_remove(&payload.object);
> > +        ret =3D vhost_user_backend_handle_shared_object_remove(dev,
> > +
>  &payload.object);
> >          break;
> >      case VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP:
> >          ret =3D
> vhost_user_backend_handle_shared_object_lookup(dev->opaque, ioc,
>
> --
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro
>
>

--000000000000f084990611685fb8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div><div dir=3D"ltr" class=3D"gmail_sign=
ature"><div dir=3D"ltr"><br></div></div></div><br></div><br><div class=3D"g=
mail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Feb 5, 2024 at 1:=
57=E2=80=AFPM Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org=
">alex.bennee@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">Albert Esteve &lt;<a href=3D"mailto:aesteve@redhat.=
com" target=3D"_blank">aesteve@redhat.com</a>&gt; writes:<br>
<br>
&gt; Shared objects lack spoofing protection.<br>
&gt; For VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE messages<br>
&gt; received by the vhost-user interface, any backend was<br>
&gt; allowed to remove entries from the shared table just<br>
&gt; by knowing the UUID. Only the owner of the entry<br>
&gt; shall be allowed to removed their resources<br>
&gt; from the table.<br>
<br>
Was this buggy behaviour on the part of the vhost-user daemon?<br></blockqu=
ote><div><br></div><div>Yes, although=C2=A0the feature is not really used y=
et, and it requires to know</div><div>the UUID to be able to exploit it. Bu=
t yes, any vhost-user backend could</div><div>remove any entry.</div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; To fix that, add a check for all<br>
&gt; *SHARED_OBJECT_REMOVE messages received.<br>
&gt; A vhost device can only remove TYPE_VHOST_DEV<br>
&gt; entries that are owned by them, otherwise skip<br>
&gt; the removal, and inform the device that the entry<br>
&gt; has not been removed in the answer.<br>
&gt;<br>
&gt; Signed-off-by: Albert Esteve &lt;<a href=3D"mailto:aesteve@redhat.com"=
 target=3D"_blank">aesteve@redhat.com</a>&gt;<br>
&gt; Acked-by: Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@redhat.com" t=
arget=3D"_blank">stefanha@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 docs/interop/vhost-user.rst |=C2=A0 4 +++-<br>
&gt;=C2=A0 hw/virtio/vhost-user.c=C2=A0 =C2=A0 =C2=A0 | 21 ++++++++++++++++=
+++--<br>
&gt;=C2=A0 2 files changed, 22 insertions(+), 3 deletions(-)<br>
&gt;<br>
&gt; diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst=
<br>
&gt; index 9f1103f85a..60ec2c9d48 100644<br>
&gt; --- a/docs/interop/vhost-user.rst<br>
&gt; +++ b/docs/interop/vhost-user.rst<br>
&gt; @@ -1839,7 +1839,9 @@ is sent by the front-end.<br>
&gt;=C2=A0 =C2=A0 When the ``VHOST_USER_PROTOCOL_F_SHARED_OBJECT`` protocol=
<br>
&gt;=C2=A0 =C2=A0 feature has been successfully negotiated, this message ca=
n be submitted<br>
&gt;=C2=A0 =C2=A0 by the backend to remove themselves from to the virtio-dm=
abuf shared<br>
&gt; -=C2=A0 table API. The shared table will remove the back-end device as=
sociated with<br>
&gt; +=C2=A0 table API. Only the back-end owning the entry (i.e., the one t=
hat first added<br>
&gt; +=C2=A0 it) will have permission to remove it. Otherwise, the message =
is ignored.<br>
&gt; +=C2=A0 The shared table will remove the back-end device associated wi=
th<br>
&gt;=C2=A0 =C2=A0 the UUID. If ``VHOST_USER_PROTOCOL_F_REPLY_ACK`` is negot=
iated, and the<br>
&gt;=C2=A0 =C2=A0 back-end sets the ``VHOST_USER_NEED_REPLY`` flag, the fro=
nt-end must respond<br>
&gt;=C2=A0 =C2=A0 with zero when operation is successfully completed, or no=
n-zero otherwise.<br>
&gt; diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c<br>
&gt; index f214df804b..1c3f2357be 100644<br>
&gt; --- a/hw/virtio/vhost-user.c<br>
&gt; +++ b/hw/virtio/vhost-user.c<br>
&gt; @@ -1611,11 +1611,27 @@ vhost_user_backend_handle_shared_object_add(st=
ruct vhost_dev *dev,<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static int<br>
&gt; -vhost_user_backend_handle_shared_object_remove(VhostUserShared *objec=
t)<br>
&gt; +vhost_user_backend_handle_shared_object_remove(struct vhost_dev *dev,=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0VhostUserShared *object)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 QemuUUID uuid;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 memcpy(uuid.data, object-&gt;uuid, sizeof(object-&=
gt;uuid));<br>
&gt; +=C2=A0 =C2=A0 switch (virtio_object_type(&amp;uuid)) {<br>
&gt; +=C2=A0 =C2=A0 case TYPE_VHOST_DEV:<br>
<br>
It would be nice if we could add a kdoc annotation to SharedObjectType<br>
describing what the various types mean.<br></blockquote><div><br></div><div=
>I can add it.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct vhost_dev *owner =3D virtio_lookup=
_vhost_device(&amp;uuid);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (owner =3D=3D NULL || dev !=3D owner) =
{<br>
<br>
I dev is always set dev !=3D owner should also cover the NULL case.<br></bl=
ockquote><div><br></div><div>True, I can remove the NULL case from the cond=
ition.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">
However will we see uuid&#39;s that aren&#39;t associated with anything?<br=
></blockquote><div><br></div><div>Theoretically, it shouldn&#39;t happen. D=
mabufs in the host and the guest are aligned,</div><div>and when one buffer=
 is cleaned up it should not be requested anymore, as the drivers</div><div=
>in the guest are aware. But a vhost-user backend could have buggy/maliciou=
s</div><div>requests, so worth the check.</div><div>=C2=A0</div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Not allowed to remove no=
n-owned entries */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Not allowed to remove non-owned entrie=
s */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return virtio_remove_resource(&amp;uuid);<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; @@ -1794,7 +1810,8 @@ static gboolean backend_read(QIOChannel *ioc, GI=
OCondition condition,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D vhost_user_backend_handle_sh=
ared_object_add(dev, &amp;payload.object);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 case VHOST_USER_BACKEND_SHARED_OBJECT_REMOVE:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D vhost_user_backend_handle_shared_=
object_remove(&amp;payload.object);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D vhost_user_backend_handle_shared_=
object_remove(dev,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&a=
mp;payload.object);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 case VHOST_USER_BACKEND_SHARED_OBJECT_LOOKUP:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D vhost_user_backend_handle_sh=
ared_object_lookup(dev-&gt;opaque, ioc,<br>
<br>
-- <br>
Alex Benn=C3=A9e<br>
Virtualisation Tech Lead @ Linaro<br>
<br>
</blockquote></div></div>

--000000000000f084990611685fb8--


