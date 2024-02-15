Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A77AC4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 09:46:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raYJd-0004Rr-5Q; Thu, 15 Feb 2024 04:46:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1raYJb-0004RJ-7Y
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 04:45:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1raYJY-0007xy-UL
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 04:45:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707990355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P56UE4Cf6BBb6x3KEjRsvmcuYwnXrp8Qo6qVp07HgqU=;
 b=DIlFcIQqRZeLZDOZPZu3YIx0vBtZ0DFCwDmtJRMR4aC59FsguvY9cZnFrMNHJXp7208HIH
 i31TWxysKHiuDfQ2fBrRSe9B5OSwXwzjWvGmgXxvhRx6WDCxoxD/kPVNDeMs5pDATFka50
 862+uHhffD3oWzcvQxEDwcFD/6b7SsA=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-N8zw_RdhPPOEdIacOup3Kg-1; Thu, 15 Feb 2024 04:45:53 -0500
X-MC-Unique: N8zw_RdhPPOEdIacOup3Kg-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-5d8dc8f906aso643205a12.2
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 01:45:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707990352; x=1708595152;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P56UE4Cf6BBb6x3KEjRsvmcuYwnXrp8Qo6qVp07HgqU=;
 b=kgWBVw4b6CzNhpSi+6XhkDRR7k4AzFjAsIi0c9qU6MWbJh6J4mY4QfNLBwqeiEKooE
 hwPssdkAeH2K4aiNLDIoDR7S01t5CMd18S44J0koHZo/r7fsK6YGY0JpHWfHsfMw/WAD
 wT8PT/4WFJYUDIZZ30weNmfwqS8SDuunujYFdg3PtiK4HmKDPg7emmAmkpP10ncWLvbd
 RZlaSEk5ezk1yykI3ZwnJaVzonIipuYE4NPuiQU0bgVKNCr6clRH9c/8BmqZlcJgVcx6
 spMWzzLpD93u8sik3WLQR08cSVo93B3NXZRbfKVCxPvP0hM5CxHrq/kwdBJGA/b72hnA
 ZShQ==
X-Gm-Message-State: AOJu0YxLHuICLZPHBzySfGtOxk1GCf1ECw2q8n+PqBtJktSGm8J5XFkR
 Zt/GusGvLi68sJLA7eLvsiBwWwWILyLMZltILyLn7aseHaq99SPI3b2kWM+2HDoQRZ0LB7ePsPm
 8xIp1oycBRjSsJph67ql6fxqeE4lD9ZLNNnMIsfTwmq/O+fkluh5J7+saMvT6I0/Z3OFe+muMaF
 AJV1qUiqTGL4V4Uw+Txgpnl47Djeo=
X-Received: by 2002:a05:6a21:3417:b0:19e:982e:c3f3 with SMTP id
 yn23-20020a056a21341700b0019e982ec3f3mr1592580pzb.51.1707990352664; 
 Thu, 15 Feb 2024 01:45:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFjxU7ThJCe4INzfI3AvjwRReAtZZd6hlNH8hxFUfq6Q58hwfaSJZFzRWFlwH0STUs1s6TvTt4RrLF4mBqN62Y=
X-Received: by 2002:a05:6a21:3417:b0:19e:982e:c3f3 with SMTP id
 yn23-20020a056a21341700b0019e982ec3f3mr1592564pzb.51.1707990352384; Thu, 15
 Feb 2024 01:45:52 -0800 (PST)
MIME-Version: 1.0
References: <20240109125614.220293-1-aesteve@redhat.com>
 <20240109125614.220293-3-aesteve@redhat.com>
 <87le7ymrqg.fsf@draig.linaro.org>
In-Reply-To: <87le7ymrqg.fsf@draig.linaro.org>
From: Albert Esteve <aesteve@redhat.com>
Date: Thu, 15 Feb 2024 10:45:41 +0100
Message-ID: <CADSE00+fCX_w_CyyRmXTJw3WTY-Z-uM+WkOf+yzLKuffUdOB+w@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] hw/virtio: cleanup shared resources
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, stefanha@gmail.com, 
 "Michael S. Tsirkin" <mst@redhat.com>, marcandre.lureau@gmail.com,
 kraxel@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000003be77b0611687e10"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.531,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

--0000000000003be77b0611687e10
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 12:11=E2=80=AFAM Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:

> Albert Esteve <aesteve@redhat.com> writes:
>
> > Ensure that we cleanup all virtio shared
> > resources when the vhost devices is cleaned
> > up (after a hot unplug, or a crash).
> >
> > To do so, we add a new function to the virtio_dmabuf
> > API called `virtio_dmabuf_vhost_cleanup`, which
> > loop through the table and removes all
> > resources owned by the vhost device parameter.
> >
> > Also, add a test to verify that the new
> > function in the API behaves as expected.
> >
> > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  hw/display/virtio-dmabuf.c        | 22 +++++++++++++++++++++
> >  hw/virtio/vhost.c                 |  3 +++
> >  include/hw/virtio/virtio-dmabuf.h | 10 ++++++++++
> >  tests/unit/test-virtio-dmabuf.c   | 33 +++++++++++++++++++++++++++++++
> >  4 files changed, 68 insertions(+)
> >
> > diff --git a/hw/display/virtio-dmabuf.c b/hw/display/virtio-dmabuf.c
> > index 3dba4577ca..6688809777 100644
> > --- a/hw/display/virtio-dmabuf.c
> > +++ b/hw/display/virtio-dmabuf.c
> > @@ -136,6 +136,28 @@ SharedObjectType virtio_object_type(const QemuUUID
> *uuid)
> >      return vso->type;
> >  }
> >
> > +static bool virtio_dmabuf_resource_is_owned(gpointer key,
> > +                                            gpointer value,
> > +                                            gpointer dev)
> > +{
> > +    VirtioSharedObject *vso;
> > +
> > +    vso =3D (VirtioSharedObject *) value;
> > +    return vso->type =3D=3D TYPE_VHOST_DEV && vso->value =3D=3D dev;
>
> It's a bit surprising to see vso->value being an anonymous gpointer
> rather than the proper type and a bit confusing between value and
> vso->value.
>
>
It is the signature required for this to be used with
`g_hash_table_foreach_remove`.
For the naming, the HashMap stores gpointers, that point to
`VirtioSharedObject`, and
these point to the underlying type (stored at `vso->value`). It may sound a
bit confusing,
but is a byproduct of the VirtioSharedObject indirection. Not sure which
names could be
more fit for this, but I'm open to change them.


> > +}
> > +
> > +int virtio_dmabuf_vhost_cleanup(struct vhost_dev *dev)
> > +{
> > +    int num_removed;
> > +
> > +    g_mutex_lock(&lock);
> > +    num_removed =3D g_hash_table_foreach_remove(
> > +        resource_uuids, (GHRFunc) virtio_dmabuf_resource_is_owned, dev=
);
> > +    g_mutex_unlock(&lock);
>
> I'll note if we used a QemuMutex for the lock we could:
>
>   - use WITH_QEMU_LOCK_GUARD(&lock) { }
>   - enable QSP porfiling for the lock
>
>
Was not aware of these QemuMutex's. I wouldn't mind changing the mutex in
this
file in a different commit.


> > +
> > +    return num_removed;
> > +}
> > +
> >  void virtio_free_resources(void)
> >  {
> >      g_mutex_lock(&lock);
> > diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> > index 2c9ac79468..c5622eac14 100644
> > --- a/hw/virtio/vhost.c
> > +++ b/hw/virtio/vhost.c
> > @@ -16,6 +16,7 @@
> >  #include "qemu/osdep.h"
> >  #include "qapi/error.h"
> >  #include "hw/virtio/vhost.h"
> > +#include "hw/virtio/virtio-dmabuf.h"
> >  #include "qemu/atomic.h"
> >  #include "qemu/range.h"
> >  #include "qemu/error-report.h"
> > @@ -1599,6 +1600,8 @@ void vhost_dev_cleanup(struct vhost_dev *hdev)
> >      migrate_del_blocker(&hdev->migration_blocker);
> >      g_free(hdev->mem);
> >      g_free(hdev->mem_sections);
> > +    /* free virtio shared objects */
> > +    virtio_dmabuf_vhost_cleanup(hdev);
> >      if (hdev->vhost_ops) {
> >          hdev->vhost_ops->vhost_backend_cleanup(hdev);
> >      }
> > diff --git a/include/hw/virtio/virtio-dmabuf.h
> b/include/hw/virtio/virtio-dmabuf.h
> > index 627c3b6db7..73f70fb482 100644
> > --- a/include/hw/virtio/virtio-dmabuf.h
> > +++ b/include/hw/virtio/virtio-dmabuf.h
> > @@ -91,6 +91,16 @@ struct vhost_dev *virtio_lookup_vhost_device(const
> QemuUUID *uuid);
> >   */
> >  SharedObjectType virtio_object_type(const QemuUUID *uuid);
> >
> > +/**
> > + * virtio_dmabuf_vhost_cleanup() - Destroys all entries of the shared
> > + * resources lookup table that are owned by the vhost backend
> > + * @dev: the pointer to the vhost device that owns the entries. Data i=
s
> owned
> > + *       by the called of the function.
> > + *
> > + * Return: the number of resource entries removed.
> > + */
> > +int virtio_dmabuf_vhost_cleanup(struct vhost_dev *dev);
> > +
> >  /**
> >   * virtio_free_resources() - Destroys all keys and values of the share=
d
> >   * resources lookup table, and frees them
> > diff --git a/tests/unit/test-virtio-dmabuf.c
> b/tests/unit/test-virtio-dmabuf.c
> > index a45ec52f42..1c8123c2d2 100644
> > --- a/tests/unit/test-virtio-dmabuf.c
> > +++ b/tests/unit/test-virtio-dmabuf.c
> > @@ -103,6 +103,38 @@ static void test_add_invalid_resource(void)
> >      }
> >  }
> >
> > +static void test_cleanup_res(void)
> > +{
> > +    QemuUUID uuids[20], uuid_alt;
> > +    struct vhost_dev *dev =3D g_new0(struct vhost_dev, 1);
> > +    struct vhost_dev *dev_alt =3D g_new0(struct vhost_dev, 1);
> > +    int i, num_removed;
> > +
> > +    for (i =3D 0; i < ARRAY_SIZE(uuids); ++i) {
> > +        qemu_uuid_generate(&uuids[i]);
> > +        virtio_add_vhost_device(&uuids[i], dev);
> > +        /* vhost device is found */
> > +        g_assert(virtio_lookup_vhost_device(&uuids[i]) !=3D NULL);
> > +    }
> > +    qemu_uuid_generate(&uuid_alt);
> > +    virtio_add_vhost_device(&uuid_alt, dev_alt);
> > +    /* vhost device is found */
> > +    g_assert(virtio_lookup_vhost_device(&uuid_alt) !=3D NULL);
> > +    /* cleanup all dev resources */
> > +    num_removed =3D virtio_dmabuf_vhost_cleanup(dev);
> > +    g_assert_cmpint(num_removed, =3D=3D, ARRAY_SIZE(uuids));
> > +    for (i =3D 0; i < ARRAY_SIZE(uuids); ++i) {
> > +        /* None of the dev resources is found after free'd */
> > +        g_assert_cmpint(virtio_lookup_dmabuf(&uuids[i]), =3D=3D, -1);
> > +    }
> > +    /* uuid_alt is still in the hash table */
> > +    g_assert(virtio_lookup_vhost_device(&uuid_alt) !=3D NULL);
> > +
> > +    virtio_free_resources();
> > +    g_free(dev);
> > +    g_free(dev_alt);
> > +}
> > +
> >  static void test_free_resources(void)
> >  {
> >      QemuUUID uuids[20];
> > @@ -131,6 +163,7 @@ int main(int argc, char **argv)
> >                      test_remove_invalid_resource);
> >      g_test_add_func("/virtio-dmabuf/add_invalid_res",
> >                      test_add_invalid_resource);
> > +    g_test_add_func("/virtio-dmabuf/cleanup_dev", test_cleanup_res);
> >      g_test_add_func("/virtio-dmabuf/free_res", test_free_resources);
> >
> >      return g_test_run();
>
> --
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro
>
>

--0000000000003be77b0611687e10
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div><div dir=3D"ltr" class=3D"gmail_sign=
ature"><div dir=3D"ltr"><br></div></div></div></div><br><div class=3D"gmail=
_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Feb 6, 2024 at 12:11=
=E2=80=AFAM Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org">=
alex.bennee@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">Albert Esteve &lt;<a href=3D"mailto:aesteve@redhat.co=
m" target=3D"_blank">aesteve@redhat.com</a>&gt; writes:<br>
<br>
&gt; Ensure that we cleanup all virtio shared<br>
&gt; resources when the vhost devices is cleaned<br>
&gt; up (after a hot unplug, or a crash).<br>
&gt;<br>
&gt; To do so, we add a new function to the virtio_dmabuf<br>
&gt; API called `virtio_dmabuf_vhost_cleanup`, which<br>
&gt; loop through the table and removes all<br>
&gt; resources owned by the vhost device parameter.<br>
&gt;<br>
&gt; Also, add a test to verify that the new<br>
&gt; function in the API behaves as expected.<br>
&gt;<br>
&gt; Signed-off-by: Albert Esteve &lt;<a href=3D"mailto:aesteve@redhat.com"=
 target=3D"_blank">aesteve@redhat.com</a>&gt;<br>
&gt; Acked-by: Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@redhat.com" t=
arget=3D"_blank">stefanha@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 hw/display/virtio-dmabuf.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 22 +++++=
++++++++++++++++<br>
&gt;=C2=A0 hw/virtio/vhost.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 3 +++<br>
&gt;=C2=A0 include/hw/virtio/virtio-dmabuf.h | 10 ++++++++++<br>
&gt;=C2=A0 tests/unit/test-virtio-dmabuf.c=C2=A0 =C2=A0| 33 +++++++++++++++=
++++++++++++++++<br>
&gt;=C2=A0 4 files changed, 68 insertions(+)<br>
&gt;<br>
&gt; diff --git a/hw/display/virtio-dmabuf.c b/hw/display/virtio-dmabuf.c<b=
r>
&gt; index 3dba4577ca..6688809777 100644<br>
&gt; --- a/hw/display/virtio-dmabuf.c<br>
&gt; +++ b/hw/display/virtio-dmabuf.c<br>
&gt; @@ -136,6 +136,28 @@ SharedObjectType virtio_object_type(const QemuUUI=
D *uuid)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return vso-&gt;type;<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; +static bool virtio_dmabuf_resource_is_owned(gpointer key,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 gpointer value,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 gpointer dev)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 VirtioSharedObject *vso;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 vso =3D (VirtioSharedObject *) value;<br>
&gt; +=C2=A0 =C2=A0 return vso-&gt;type =3D=3D TYPE_VHOST_DEV &amp;&amp; vs=
o-&gt;value =3D=3D dev;<br>
<br>
It&#39;s a bit surprising to see vso-&gt;value being an anonymous gpointer<=
br>
rather than the proper type and a bit confusing between value and<br>
vso-&gt;value.<br>
<br></blockquote><div><br></div><div>It is the signature required for this =
to be used with `g_hash_table_foreach_remove`.</div><div>For the naming, th=
e HashMap stores gpointers, that point to `VirtioSharedObject`, and</div><d=
iv>these point to the underlying type (stored at `vso-&gt;value`). It may s=
ound a bit confusing,</div><div>but is a byproduct=C2=A0of the VirtioShared=
Object indirection. Not sure which names could be</div><div>more fit for th=
is, but I&#39;m open to change them.</div><div>=C2=A0</div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">
&gt; +}<br>
&gt; +<br>
&gt; +int virtio_dmabuf_vhost_cleanup(struct vhost_dev *dev)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 int num_removed;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 g_mutex_lock(&amp;lock);<br>
&gt; +=C2=A0 =C2=A0 num_removed =3D g_hash_table_foreach_remove(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 resource_uuids, (GHRFunc) virtio_dmabuf_r=
esource_is_owned, dev);<br>
&gt; +=C2=A0 =C2=A0 g_mutex_unlock(&amp;lock);<br>
<br>
I&#39;ll note if we used a QemuMutex for the lock we could:<br>
<br>
=C2=A0 - use WITH_QEMU_LOCK_GUARD(&amp;lock) { }<br>
=C2=A0 - enable QSP porfiling for the lock<br>
<br></blockquote><div><br></div><div>Was not aware of these QemuMutex&#39;s=
. I wouldn&#39;t mind changing the mutex in this</div><div>file in a differ=
ent commit.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return num_removed;<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 void virtio_free_resources(void)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 g_mutex_lock(&amp;lock);<br>
&gt; diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c<br>
&gt; index 2c9ac79468..c5622eac14 100644<br>
&gt; --- a/hw/virtio/vhost.c<br>
&gt; +++ b/hw/virtio/vhost.c<br>
&gt; @@ -16,6 +16,7 @@<br>
&gt;=C2=A0 #include &quot;qemu/osdep.h&quot;<br>
&gt;=C2=A0 #include &quot;qapi/error.h&quot;<br>
&gt;=C2=A0 #include &quot;hw/virtio/vhost.h&quot;<br>
&gt; +#include &quot;hw/virtio/virtio-dmabuf.h&quot;<br>
&gt;=C2=A0 #include &quot;qemu/atomic.h&quot;<br>
&gt;=C2=A0 #include &quot;qemu/range.h&quot;<br>
&gt;=C2=A0 #include &quot;qemu/error-report.h&quot;<br>
&gt; @@ -1599,6 +1600,8 @@ void vhost_dev_cleanup(struct vhost_dev *hdev)<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 migrate_del_blocker(&amp;hdev-&gt;migration_blocke=
r);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 g_free(hdev-&gt;mem);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 g_free(hdev-&gt;mem_sections);<br>
&gt; +=C2=A0 =C2=A0 /* free virtio shared objects */<br>
&gt; +=C2=A0 =C2=A0 virtio_dmabuf_vhost_cleanup(hdev);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (hdev-&gt;vhost_ops) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hdev-&gt;vhost_ops-&gt;vhost_backend=
_cleanup(hdev);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; diff --git a/include/hw/virtio/virtio-dmabuf.h b/include/hw/virtio/vir=
tio-dmabuf.h<br>
&gt; index 627c3b6db7..73f70fb482 100644<br>
&gt; --- a/include/hw/virtio/virtio-dmabuf.h<br>
&gt; +++ b/include/hw/virtio/virtio-dmabuf.h<br>
&gt; @@ -91,6 +91,16 @@ struct vhost_dev *virtio_lookup_vhost_device(const =
QemuUUID *uuid);<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt;=C2=A0 SharedObjectType virtio_object_type(const QemuUUID *uuid);<br>
&gt;=C2=A0 <br>
&gt; +/**<br>
&gt; + * virtio_dmabuf_vhost_cleanup() - Destroys all entries of the shared=
<br>
&gt; + * resources lookup table that are owned by the vhost backend<br>
&gt; + * @dev: the pointer to the vhost device that owns the entries. Data =
is owned<br>
&gt; + *=C2=A0 =C2=A0 =C2=A0 =C2=A0by the called of the function.<br>
&gt; + * <br>
&gt; + * Return: the number of resource entries removed.<br>
&gt; + */<br>
&gt; +int virtio_dmabuf_vhost_cleanup(struct vhost_dev *dev);<br>
&gt; +<br>
&gt;=C2=A0 /**<br>
&gt;=C2=A0 =C2=A0* virtio_free_resources() - Destroys all keys and values o=
f the shared<br>
&gt;=C2=A0 =C2=A0* resources lookup table, and frees them<br>
&gt; diff --git a/tests/unit/test-virtio-dmabuf.c b/tests/unit/test-virtio-=
dmabuf.c<br>
&gt; index a45ec52f42..1c8123c2d2 100644<br>
&gt; --- a/tests/unit/test-virtio-dmabuf.c<br>
&gt; +++ b/tests/unit/test-virtio-dmabuf.c<br>
&gt; @@ -103,6 +103,38 @@ static void test_add_invalid_resource(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; +static void test_cleanup_res(void)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 QemuUUID uuids[20], uuid_alt;<br>
&gt; +=C2=A0 =C2=A0 struct vhost_dev *dev =3D g_new0(struct vhost_dev, 1);<=
br>
&gt; +=C2=A0 =C2=A0 struct vhost_dev *dev_alt =3D g_new0(struct vhost_dev, =
1);<br>
&gt; +=C2=A0 =C2=A0 int i, num_removed;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; ARRAY_SIZE(uuids); ++i) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_uuid_generate(&amp;uuids[i]);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_add_vhost_device(&amp;uuids[i], de=
v);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* vhost device is found */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert(virtio_lookup_vhost_device(&amp;=
uuids[i]) !=3D NULL);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 qemu_uuid_generate(&amp;uuid_alt);<br>
&gt; +=C2=A0 =C2=A0 virtio_add_vhost_device(&amp;uuid_alt, dev_alt);<br>
&gt; +=C2=A0 =C2=A0 /* vhost device is found */<br>
&gt; +=C2=A0 =C2=A0 g_assert(virtio_lookup_vhost_device(&amp;uuid_alt) !=3D=
 NULL);<br>
&gt; +=C2=A0 =C2=A0 /* cleanup all dev resources */<br>
&gt; +=C2=A0 =C2=A0 num_removed =3D virtio_dmabuf_vhost_cleanup(dev);<br>
&gt; +=C2=A0 =C2=A0 g_assert_cmpint(num_removed, =3D=3D, ARRAY_SIZE(uuids))=
;<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; ARRAY_SIZE(uuids); ++i) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* None of the dev resources is found aft=
er free&#39;d */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert_cmpint(virtio_lookup_dmabuf(&amp=
;uuids[i]), =3D=3D, -1);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 /* uuid_alt is still in the hash table */<br>
&gt; +=C2=A0 =C2=A0 g_assert(virtio_lookup_vhost_device(&amp;uuid_alt) !=3D=
 NULL);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 virtio_free_resources();<br>
&gt; +=C2=A0 =C2=A0 g_free(dev);<br>
&gt; +=C2=A0 =C2=A0 g_free(dev_alt);<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 static void test_free_resources(void)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 QemuUUID uuids[20];<br>
&gt; @@ -131,6 +163,7 @@ int main(int argc, char **argv)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 test_remove_invalid_resource);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 g_test_add_func(&quot;/virtio-dmabuf/add_invalid_r=
es&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 test_add_invalid_resource);<br>
&gt; +=C2=A0 =C2=A0 g_test_add_func(&quot;/virtio-dmabuf/cleanup_dev&quot;,=
 test_cleanup_res);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 g_test_add_func(&quot;/virtio-dmabuf/free_res&quot=
;, test_free_resources);<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 return g_test_run();<br>
<br>
-- <br>
Alex Benn=C3=A9e<br>
Virtualisation Tech Lead @ Linaro<br>
<br>
</blockquote></div></div>

--0000000000003be77b0611687e10--


