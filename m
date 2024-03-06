Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8FC2C54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 13:14:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhr5W-0001VG-3e; Wed, 06 Mar 2024 08:13:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1rhr5T-0001V2-Lb
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 08:13:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1rhr5R-0005mH-ME
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 08:13:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709730812;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jXipuQrGzrStoMcAX5OWKliHtrcuCbZ9M+lD+wEtmuU=;
 b=bnv8oCmCPJqeguJT7fty1gNtaM4FxZj/KvHwS55buuJkM76PwuFLAJWgHdsSkQveKx7dHj
 OiFBZD/hENAP7IElU2gEzOPkBQrea6z/323Ke22jM5tCWkugFwdHUJY5TCkGuTJTuqDxco
 ttVls2XJ2+gb1x2xxA9DgFN1BvGW4Nk=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-YRuTgFTRPl2D0JNlVeVpOQ-1; Wed, 06 Mar 2024 08:13:31 -0500
X-MC-Unique: YRuTgFTRPl2D0JNlVeVpOQ-1
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-6e58ec82581so1585540b3a.2
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 05:13:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709730810; x=1710335610;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jXipuQrGzrStoMcAX5OWKliHtrcuCbZ9M+lD+wEtmuU=;
 b=XvXHZ/ZY7xXFXWfgfNswfRlTdsbNk626J3FksUwm7DI+YVnYlaF3t/XJI6o3K4c6Dv
 iVWFtviMeB8nAibMyGNwBjz9wDgexBhj7yLq7UCsjSxBJKEIlNgUKo3jKHr2g8oWu07u
 rF0Ak6a1+C7b9EYwncmecFTKvl7QWSfasvyg9P6jtD7peT2XKa8weyqK6GhsesMynbPd
 l7ZfvXYIM1AHq7dP7koxhWp4W6TRFkYCmMJD6dZun2fnG3HAXGHKFaZzA1Outrck6Z8O
 ZsykOfQvKRcUQ9BEpkuu4LC5Nj2wcsmzJcVNm6a7r1BkJwToS3btbR25PnfmL3FpWfkP
 eBgQ==
X-Gm-Message-State: AOJu0YxuuiWTbBFyCny+a8Q2zYXb19BButRZaOcYRxQYK7fl+BQPMdtK
 CD4ZLKuXWedP9WFZBqryRNphCAtiRM3kg8MgXCssNGtJKIgUFPOXvZHzcmacYq273uvLNr+yt7j
 ykRtwLd9k2PwOHW4TNhduP033UsHvpV9d26lgP+xwxv3luwqjQTnawEllZjasjY/feIiFawcvM1
 QYUuWGB6NZHhB/TiSiJfNlPh9VEL4=
X-Received: by 2002:a05:6a20:9f03:b0:1a1:56aa:bf66 with SMTP id
 mk3-20020a056a209f0300b001a156aabf66mr6847649pzb.13.1709730810085; 
 Wed, 06 Mar 2024 05:13:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IESBpw9mRkzL8tBhDbZLl1Kvc9NokwjnpZKGkOn/cBfhAM2oXDJvQOlQipDu1COswKzlGNncHbQ3rAHEfLtxd8=
X-Received: by 2002:a05:6a20:9f03:b0:1a1:56aa:bf66 with SMTP id
 mk3-20020a056a209f0300b001a156aabf66mr6847604pzb.13.1709730809480; Wed, 06
 Mar 2024 05:13:29 -0800 (PST)
MIME-Version: 1.0
References: <20240219143423.272012-1-aesteve@redhat.com>
 <20240219143423.272012-3-aesteve@redhat.com>
 <95hcp.21l4vcaudvyq@linaro.org>
In-Reply-To: <95hcp.21l4vcaudvyq@linaro.org>
From: Albert Esteve <aesteve@redhat.com>
Date: Wed, 6 Mar 2024 14:13:18 +0100
Message-ID: <CADSE00+FJ-NzKvkufbyTia40P0ndQeqmzWs8BeAcKoyNcO3WKw@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] hw/virtio: document SharedObject structures
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 stefanha@gmail.com, 
 alex.bennee@linaro.org, philmd@linaro.org, kraxel@redhat.com, 
 marcandre.lureau@gmail.com
Content-Type: multipart/alternative; boundary="0000000000008f9aac0612fdb9cc"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.365,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--0000000000008f9aac0612fdb9cc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 11:34=E2=80=AFAM Manos Pitsidianakis <
manos.pitsidianakis@linaro.org> wrote:

> On Mon, 19 Feb 2024 16:34, Albert Esteve <aesteve@redhat.com> wrote:
> >Change VirtioSharedObject value type from
> >a generic pointer to a union storing the different
> >supported underlying types, which makes naming
> >less confusing.
> >
> >With the update, use the chance to add kdoc
> >to both the SharedObjectType enum and
> >VirtioSharedObject struct.
> >
> >Signed-off-by: Albert Esteve <aesteve@redhat.com>
> >---
> > hw/display/virtio-dmabuf.c        |  8 ++++----
> > include/hw/virtio/virtio-dmabuf.h | 25 ++++++++++++++++++++++++-
> > 2 files changed, 28 insertions(+), 5 deletions(-)
> >
> >diff --git a/hw/display/virtio-dmabuf.c b/hw/display/virtio-dmabuf.c
> >index 3dba4577ca..497cb6fa7c 100644
> >--- a/hw/display/virtio-dmabuf.c
> >+++ b/hw/display/virtio-dmabuf.c
> >@@ -57,7 +57,7 @@ bool virtio_add_dmabuf(QemuUUID *uuid, int udmabuf_fd)
> >     }
> >     vso =3D g_new(VirtioSharedObject, 1);
> >     vso->type =3D TYPE_DMABUF;
> >-    vso->value =3D GINT_TO_POINTER(udmabuf_fd);
> >+    vso->value.udma_buf =3D udmabuf_fd;
> >     result =3D virtio_add_resource(uuid, vso);
> >     if (!result) {
> >         g_free(vso);
> >@@ -75,7 +75,7 @@ bool virtio_add_vhost_device(QemuUUID *uuid, struct
> vhost_dev *dev)
> >     }
> >     vso =3D g_new(VirtioSharedObject, 1);
> >     vso->type =3D TYPE_VHOST_DEV;
> >-    vso->value =3D dev;
> >+    vso->value.dev =3D dev;
> >     result =3D virtio_add_resource(uuid, vso);
> >     if (!result) {
> >         g_free(vso);
> >@@ -114,7 +114,7 @@ int virtio_lookup_dmabuf(const QemuUUID *uuid)
> >         return -1;
> >     }
> >     assert(vso->type =3D=3D TYPE_DMABUF);
> >-    return GPOINTER_TO_INT(vso->value);
> >+    return vso->value.udma_buf;
> > }
> >
> > struct vhost_dev *virtio_lookup_vhost_device(const QemuUUID *uuid)
> >@@ -124,7 +124,7 @@ struct vhost_dev *virtio_lookup_vhost_device(const
> QemuUUID *uuid)
> >         return NULL;
> >     }
> >     assert(vso->type =3D=3D TYPE_VHOST_DEV);
> >-    return (struct vhost_dev *) vso->value;
> >+    return (struct vhost_dev *) vso->value.dev;
>
> Is the casting still required?
>
> You're right, probably not anymore. I'll remove it.


>
> > }
> >
> > SharedObjectType virtio_object_type(const QemuUUID *uuid)
> >diff --git a/include/hw/virtio/virtio-dmabuf.h
> b/include/hw/virtio/virtio-dmabuf.h
> >index 627c3b6db7..891a43162d 100644
> >--- a/include/hw/virtio/virtio-dmabuf.h
> >+++ b/include/hw/virtio/virtio-dmabuf.h
> >@@ -16,15 +16,38 @@
> > #include "qemu/uuid.h"
> > #include "vhost.h"
> >
> >+/**
> >+ * SharedObjectType:
> >+ *
> >+ * Identifies the type of the underlying type that the current lookup
> >+ * table entry is holding.
> >+ *
> >+ * TYPE_INVALID: Invalid entry
> >+ * TYPE_DMABUF: Entry is a dmabuf file descriptor that can be directly
> >+ *              shared with the requestor
> >+ * TYPE_VHOST_DEV: Entry is a pointer to a vhost device that is holding
> >+ *                 the shared object.
>
>
> nit:
>
> + * TYPE_INVALID:   Invalid entry.
> + * TYPE_DMABUF:    Entry is a dmabuf file descriptor that can be
> + *                 directly shared with the requestor.
> + * TYPE_VHOST_DEV: Entry is a pointer to a vhost device that is holding
> + *                 the shared object.
>
>
> >+ */
> > typedef enum SharedObjectType {
> >     TYPE_INVALID =3D 0,
> >     TYPE_DMABUF,
> >     TYPE_VHOST_DEV,
> > } SharedObjectType;
> >
> >+/**
> >+ * VirtioSharedObject:
> >+ * @type: Shared object type identifier
> >+ * @value: Union containing to the underlying type
> >+ *
> >+ * The VirtioSharedObject object provides a way to distinguish,
> >+ * store, and handle the different types supported by the lookup table.
> >+ */
> > typedef struct VirtioSharedObject {
> >     SharedObjectType type;
> >-    gpointer value;
> >+    union {
> >+        struct vhost_dev *dev;  /* TYPE_VHOST_DEV */
> >+        int udma_buf;           /* TYPE_DMABUF */
> >+    } value;
> > } VirtioSharedObject;
> >
> > /**
> >--
> >2.43.1
> >
> >
>
>

--0000000000008f9aac0612fdb9cc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div><div dir=3D"ltr" class=3D"gmail_sign=
ature"><div dir=3D"ltr"><br></div></div></div></div><br><div class=3D"gmail=
_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Feb 20, 2024 at 11:34=
=E2=80=AFAM Manos Pitsidianakis &lt;<a href=3D"mailto:manos.pitsidianakis@l=
inaro.org">manos.pitsidianakis@linaro.org</a>&gt; wrote:<br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">On Mon, 19 Feb 2024 16:34, Albert =
Esteve &lt;<a href=3D"mailto:aesteve@redhat.com" target=3D"_blank">aesteve@=
redhat.com</a>&gt; wrote:<br>
&gt;Change VirtioSharedObject value type from<br>
&gt;a generic pointer to a union storing the different<br>
&gt;supported underlying types, which makes naming<br>
&gt;less confusing.<br>
&gt;<br>
&gt;With the update, use the chance to add kdoc<br>
&gt;to both the SharedObjectType enum and<br>
&gt;VirtioSharedObject struct.<br>
&gt;<br>
&gt;Signed-off-by: Albert Esteve &lt;<a href=3D"mailto:aesteve@redhat.com" =
target=3D"_blank">aesteve@redhat.com</a>&gt;<br>
&gt;---<br>
&gt; hw/display/virtio-dmabuf.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 8 ++++--=
--<br>
&gt; include/hw/virtio/virtio-dmabuf.h | 25 ++++++++++++++++++++++++-<br>
&gt; 2 files changed, 28 insertions(+), 5 deletions(-)<br>
&gt;<br>
&gt;diff --git a/hw/display/virtio-dmabuf.c b/hw/display/virtio-dmabuf.c<br=
>
&gt;index 3dba4577ca..497cb6fa7c 100644<br>
&gt;--- a/hw/display/virtio-dmabuf.c<br>
&gt;+++ b/hw/display/virtio-dmabuf.c<br>
&gt;@@ -57,7 +57,7 @@ bool virtio_add_dmabuf(QemuUUID *uuid, int udmabuf_fd=
)<br>
&gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0vso =3D g_new(VirtioSharedObject, 1);<br>
&gt;=C2=A0 =C2=A0 =C2=A0vso-&gt;type =3D TYPE_DMABUF;<br>
&gt;-=C2=A0 =C2=A0 vso-&gt;value =3D GINT_TO_POINTER(udmabuf_fd);<br>
&gt;+=C2=A0 =C2=A0 vso-&gt;value.udma_buf =3D udmabuf_fd;<br>
&gt;=C2=A0 =C2=A0 =C2=A0result =3D virtio_add_resource(uuid, vso);<br>
&gt;=C2=A0 =C2=A0 =C2=A0if (!result) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_free(vso);<br>
&gt;@@ -75,7 +75,7 @@ bool virtio_add_vhost_device(QemuUUID *uuid, struct v=
host_dev *dev)<br>
&gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0vso =3D g_new(VirtioSharedObject, 1);<br>
&gt;=C2=A0 =C2=A0 =C2=A0vso-&gt;type =3D TYPE_VHOST_DEV;<br>
&gt;-=C2=A0 =C2=A0 vso-&gt;value =3D dev;<br>
&gt;+=C2=A0 =C2=A0 vso-&gt;<a href=3D"http://value.dev" rel=3D"noreferrer" =
target=3D"_blank">value.dev</a> =3D dev;<br>
&gt;=C2=A0 =C2=A0 =C2=A0result =3D virtio_add_resource(uuid, vso);<br>
&gt;=C2=A0 =C2=A0 =C2=A0if (!result) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_free(vso);<br>
&gt;@@ -114,7 +114,7 @@ int virtio_lookup_dmabuf(const QemuUUID *uuid)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0assert(vso-&gt;type =3D=3D TYPE_DMABUF);<br>
&gt;-=C2=A0 =C2=A0 return GPOINTER_TO_INT(vso-&gt;value);<br>
&gt;+=C2=A0 =C2=A0 return vso-&gt;value.udma_buf;<br>
&gt; }<br>
&gt; <br>
&gt; struct vhost_dev *virtio_lookup_vhost_device(const QemuUUID *uuid)<br>
&gt;@@ -124,7 +124,7 @@ struct vhost_dev *virtio_lookup_vhost_device(const =
QemuUUID *uuid)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0assert(vso-&gt;type =3D=3D TYPE_VHOST_DEV);<br>
&gt;-=C2=A0 =C2=A0 return (struct vhost_dev *) vso-&gt;value;<br>
&gt;+=C2=A0 =C2=A0 return (struct vhost_dev *) vso-&gt;<a href=3D"http://va=
lue.dev" rel=3D"noreferrer" target=3D"_blank">value.dev</a>;<br>
<br>
Is the casting still required?<br>
<br></blockquote><div>You&#39;re right, probably not anymore. I&#39;ll remo=
ve it.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">
<br>
&gt; }<br>
&gt; <br>
&gt; SharedObjectType virtio_object_type(const QemuUUID *uuid)<br>
&gt;diff --git a/include/hw/virtio/virtio-dmabuf.h b/include/hw/virtio/virt=
io-dmabuf.h<br>
&gt;index 627c3b6db7..891a43162d 100644<br>
&gt;--- a/include/hw/virtio/virtio-dmabuf.h<br>
&gt;+++ b/include/hw/virtio/virtio-dmabuf.h<br>
&gt;@@ -16,15 +16,38 @@<br>
&gt; #include &quot;qemu/uuid.h&quot;<br>
&gt; #include &quot;vhost.h&quot;<br>
&gt; <br>
&gt;+/**<br>
&gt;+ * SharedObjectType:<br>
&gt;+ *<br>
&gt;+ * Identifies the type of the underlying type that the current lookup<=
br>
&gt;+ * table entry is holding.<br>
&gt;+ * <br>
&gt;+ * TYPE_INVALID: Invalid entry<br>
&gt;+ * TYPE_DMABUF: Entry is a dmabuf file descriptor that can be directly=
<br>
&gt;+ *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 shared with the req=
uestor<br>
&gt;+ * TYPE_VHOST_DEV: Entry is a pointer to a vhost device that is holdin=
g<br>
&gt;+ *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0the sh=
ared object.<br>
<br>
<br>
nit:<br>
<br>
+ * TYPE_INVALID:=C2=A0 =C2=A0Invalid entry.<br>
+ * TYPE_DMABUF:=C2=A0 =C2=A0 Entry is a dmabuf file descriptor that can be=
<br>
+ *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0directly s=
hared with the requestor.<br>
+ * TYPE_VHOST_DEV: Entry is a pointer to a vhost device that is holding<br=
>
+ *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0the shared=
 object.<br>
<br>
<br>
&gt;+ */<br>
&gt; typedef enum SharedObjectType {<br>
&gt;=C2=A0 =C2=A0 =C2=A0TYPE_INVALID =3D 0,<br>
&gt;=C2=A0 =C2=A0 =C2=A0TYPE_DMABUF,<br>
&gt;=C2=A0 =C2=A0 =C2=A0TYPE_VHOST_DEV,<br>
&gt; } SharedObjectType;<br>
&gt; <br>
&gt;+/**<br>
&gt;+ * VirtioSharedObject:<br>
&gt;+ * @type: Shared object type identifier<br>
&gt;+ * @value: Union containing to the underlying type<br>
&gt;+ * <br>
&gt;+ * The VirtioSharedObject object provides a way to distinguish,<br>
&gt;+ * store, and handle the different types supported by the lookup table=
.<br>
&gt;+ */<br>
&gt; typedef struct VirtioSharedObject {<br>
&gt;=C2=A0 =C2=A0 =C2=A0SharedObjectType type;<br>
&gt;-=C2=A0 =C2=A0 gpointer value;<br>
&gt;+=C2=A0 =C2=A0 union {<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct vhost_dev *dev;=C2=A0 /* TYPE_VHOST=
_DEV */<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int udma_buf;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0/* TYPE_DMABUF */<br>
&gt;+=C2=A0 =C2=A0 } value;<br>
&gt; } VirtioSharedObject;<br>
&gt; <br>
&gt; /**<br>
&gt;-- <br>
&gt;2.43.1<br>
&gt;<br>
&gt;<br>
<br>
</blockquote></div></div>

--0000000000008f9aac0612fdb9cc--


