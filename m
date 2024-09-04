Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EA30CD3431
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 09:12:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slm3e-0000hv-VO; Wed, 04 Sep 2024 05:12:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1slm3c-0000hQ-MY
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 05:12:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1slm3Z-0002Ky-Ar
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 05:12:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725441123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NijQoI7ejI0b8Hs5QXP6zg52p9lYhpA000fOZRU6W3U=;
 b=PZqY8/I/OqLAQ/JzqkFBCLQ9d29WoTjJfZ+D0zagISYPkO6u0pIbl7Acm7Z6nXsnZTYT9T
 pmTlEjxrsC+2ojtQ7MmC5W1cBdwars2f47myyy1hErUk6338l3XoXuki2VlgDZ+xdPz1Yz
 LsIC7cHGgYnjDsFl72aakRH5yq1CajE=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-5ugeda_xPFa6elq7rV_5qA-1; Wed, 04 Sep 2024 05:05:44 -0400
X-MC-Unique: 5ugeda_xPFa6elq7rV_5qA-1
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-7142fc79985so6376047b3a.2
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2024 02:05:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725440742; x=1726045542;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NijQoI7ejI0b8Hs5QXP6zg52p9lYhpA000fOZRU6W3U=;
 b=irBLTfRHPcaYVpz2hScA4wczrnxsjbUF2Xb26JWgmksS/7e8Ee6+Jz3tezhxciRNL9
 nq1r8x7nGi2Rqs6PRnDVYW682tEW729fbAVAkFqY9EDU8gmgPzTtQND1knd/ljeWRJhb
 3QokxfjV5mX3nx2y5EOUq38mRmib4aGKmQWW8oB8q+RK7Flu4PEkQQ0PscXyB5X6sl7D
 YmzesmBu7sAhnb6Ay1KBcBuY9Db5pdyxYBx7U1MV2O2sudUIGavoNDqt/zb89pxZg6/V
 rrCQtNRvFOWgHSMb1g8cWc7YjuJOxHKNeO7Akug3MCVzK9v4reEqtpRDpsTiBZcdMJ0U
 4x0w==
X-Gm-Message-State: AOJu0YxQAPzIUbn3i9NJ9FgDQWoQZEtb+SKu6pHU+5XW7DMYrjfVLc5s
 0tvteXiYLUWbDL/V8sTuwWbtobv6l7eudweZZe1A2PaWXKE5NVjnQkqZa1ZBoE5dpWx+osd629u
 lMqYbNm3EHt3zLYq/CalJFXk2t9PAtjg+9sohSCXfQ8TJHGPKu+ibarqDP2zcDE9N31hwpEZ4jW
 gfzytkbErAWouPH8c5LW/1Fd2NnGk=
X-Received: by 2002:a05:6a00:919b:b0:704:2696:d08e with SMTP id
 d2e1a72fcca58-7173b607623mr14558595b3a.13.1725440742115; 
 Wed, 04 Sep 2024 02:05:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMTX9ZRhH5fdBR5zYf2fZ4vppQwp/zRUFIKl1qgSK5Dfd+b9aiSTDp4Trv4+A1zxrLFz6b868U1qrgpwJr8j8=
X-Received: by 2002:a05:6a00:919b:b0:704:2696:d08e with SMTP id
 d2e1a72fcca58-7173b607623mr14558573b3a.13.1725440741655; Wed, 04 Sep 2024
 02:05:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240628145710.1516121-1-aesteve@redhat.com>
 <20240628145710.1516121-3-aesteve@redhat.com>
 <20240711081036.GD563880@dynamic-pd01.res.v6.highway.a1.net>
In-Reply-To: <20240711081036.GD563880@dynamic-pd01.res.v6.highway.a1.net>
From: Albert Esteve <aesteve@redhat.com>
Date: Wed, 4 Sep 2024 11:05:29 +0200
Message-ID: <CADSE00+4HwrKd3Y_S=tnzu4j=Vsu6UVER=x1-qF_ZvEJg4EDUA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/5] vhost_user: Add frontend command for shmem
 config
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com, david@redhat.com, 
 slp@redhat.com, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000007cdb130621477a46"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--0000000000007cdb130621477a46
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 10:10=E2=80=AFAM Stefan Hajnoczi <stefanha@redhat.c=
om>
wrote:

> On Fri, Jun 28, 2024 at 04:57:07PM +0200, Albert Esteve wrote:
> > The frontend can use this command to retrieve
> > VIRTIO Shared Memory Regions configuration from
> > the backend. The response contains the number of
> > shared memory regions, their size, and shmid.
> >
> > This is useful when the frontend is unaware of
> > specific backend type and configuration,
> > for example, in the `vhost-user-device` case.
> >
> > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > ---
> >  docs/interop/vhost-user.rst       | 31 +++++++++++++++++++++++
> >  hw/virtio/vhost-user.c            | 42 +++++++++++++++++++++++++++++++
> >  include/hw/virtio/vhost-backend.h |  6 +++++
> >  include/hw/virtio/vhost-user.h    |  1 +
> >  4 files changed, 80 insertions(+)
> >
> > diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> > index d52ba719d5..51f01d1d84 100644
> > --- a/docs/interop/vhost-user.rst
> > +++ b/docs/interop/vhost-user.rst
> > @@ -348,6 +348,19 @@ Device state transfer parameters
> >    In the future, additional phases might be added e.g. to allow
> >    iterative migration while the device is running.
> >
> > +VIRTIO Shared Memory Region configuration
> > +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > +
> > ++-------------+---------+------------+----+------------+
> > +| num regions | padding | mem size 0 | .. | mem size 7 |
> > ++-------------+---------+------------+----+------------+
>
> 8 regions may not be enough. The max according to the VIRTIO spec is
> 256 because virtio-pci uses an 8-bit cap.id field for the shmid. I think
> the maximum number should be 256 here.
>

Ok, I'll set it to 255, as it starts at 0.


>
> (I haven't checked the QEMU vhost-user code to see whether it's
> reasonable to hardcode to 256 or some logic if needed to dynamically
> size the buffer depending on the "num regions" field.)
>
> > +
> > +:num regions: a 32-bit number of regions
> > +
> > +:padding: 32-bit
> > +
> > +:mem size: 64-bit size of VIRTIO Shared Memory Region
> > +
> >  C structure
> >  -----------
> >
> > @@ -369,6 +382,10 @@ In QEMU the vhost-user message is implemented with
> the following struct:
> >            VhostUserConfig config;
> >            VhostUserVringArea area;
> >            VhostUserInflight inflight;
> > +          VhostUserShared object;
> > +          VhostUserTransferDeviceState transfer_state;
> > +          VhostUserMMap mmap;
>
> Why are these added by this patch? Please add them in the same patch
> where they are introduced.


For object and transfer_state that's a ship that already sailed.
In order to still align the excerpt with the actual code, I will
split them into their own commit to avoid confusion.


> > +          VhostUserShMemConfig shmem;
> >        };
> >    } QEMU_PACKED VhostUserMsg;
> >
> > @@ -1051,6 +1068,7 @@ Protocol features
> >    #define VHOST_USER_PROTOCOL_F_XEN_MMAP             17
> >    #define VHOST_USER_PROTOCOL_F_SHARED_OBJECT        18
> >    #define VHOST_USER_PROTOCOL_F_DEVICE_STATE         19
> > +  #define VHOST_USER_PROTOCOL_F_SHMEM                20
> >
> >  Front-end message types
> >  -----------------------
> > @@ -1725,6 +1743,19 @@ Front-end message types
> >    Using this function requires prior negotiation of the
> >    ``VHOST_USER_PROTOCOL_F_DEVICE_STATE`` feature.
> >
> > +``VHOST_USER_GET_SHMEM_CONFIG``
> > +  :id: 44
> > +  :equivalent ioctl: N/A
> > +  :request payload: N/A
> > +  :reply payload: ``struct VhostUserShMemConfig``
> > +
> > +  When the ``VHOST_USER_PROTOCOL_F_SHMEM`` protocol feature has been
> > +  successfully negotiated, this message can be submitted by the
> front-end
> > +  to gather the VIRTIO Shared Memory Region configuration. Back-end
> will respond
> > +  with the number of VIRTIO Shared Memory Regions it requires, and eac=
h
> shared memory
> > +  region size in an array. The shared memory IDs are represented by th=
e
> index
> > +  of the array.
>
> Is the information returned by SHMEM_CONFIG valid and unchanged for the
> entire lifetime of the vhost-user connection?
>
> I think the answer is yes because the enumeration that virtio-pci and
> virtio-mmio transports support is basically a one-time operation at
> driver startup and it is static (Shared Memory Regions do not appear or
> go away at runtime). Please be explicit how VHOST_USER_GET_SHMEM_CONFIG
> is intended to be used.
>

Yes, I will be explicit.


>
> > +
> >  Back-end message types
> >  ----------------------
> >
> > diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> > index 7ee8a472c6..57406dc8b4 100644
> > --- a/hw/virtio/vhost-user.c
> > +++ b/hw/virtio/vhost-user.c
> > @@ -104,6 +104,7 @@ typedef enum VhostUserRequest {
> >      VHOST_USER_GET_SHARED_OBJECT =3D 41,
> >      VHOST_USER_SET_DEVICE_STATE_FD =3D 42,
> >      VHOST_USER_CHECK_DEVICE_STATE =3D 43,
> > +    VHOST_USER_GET_SHMEM_CONFIG =3D 44,
> >      VHOST_USER_MAX
> >  } VhostUserRequest;
> >
> > @@ -138,6 +139,12 @@ typedef struct VhostUserMemRegMsg {
> >      VhostUserMemoryRegion region;
> >  } VhostUserMemRegMsg;
> >
> > +typedef struct VhostUserShMemConfig {
> > +    uint32_t nregions;
> > +    uint32_t padding;
> > +    uint64_t memory_sizes[VHOST_MEMORY_BASELINE_NREGIONS];
> > +} VhostUserShMemConfig;
> > +
> >  typedef struct VhostUserLog {
> >      uint64_t mmap_size;
> >      uint64_t mmap_offset;
> > @@ -245,6 +252,7 @@ typedef union {
> >          VhostUserShared object;
> >          VhostUserTransferDeviceState transfer_state;
> >          VhostUserMMap mmap;
> > +        VhostUserShMemConfig shmem;
> >  } VhostUserPayload;
> >
> >  typedef struct VhostUserMsg {
> > @@ -3136,6 +3144,39 @@ static int vhost_user_check_device_state(struct
> vhost_dev *dev, Error **errp)
> >      return 0;
> >  }
> >
> > +static int vhost_user_get_shmem_config(struct vhost_dev *dev,
> > +                                       int *nregions,
> > +                                       uint64_t *memory_sizes,
> > +                                       Error **errp)
> > +{
> > +    int ret;
> > +    VhostUserMsg msg =3D {
> > +        .hdr.request =3D VHOST_USER_GET_SHMEM_CONFIG,
> > +        .hdr.flags =3D VHOST_USER_VERSION,
> > +    };
> > +
> > +    if (!virtio_has_feature(dev->protocol_features,
> > +                            VHOST_USER_PROTOCOL_F_SHMEM)) {
> > +        return 0;
> > +    }
> > +
> > +    ret =3D vhost_user_write(dev, &msg, NULL, 0);
> > +    if (ret < 0) {
> > +        return ret;
> > +    }
> > +
> > +    ret =3D vhost_user_read(dev, &msg);
> > +    if (ret < 0) {
> > +        return ret;
> > +    }
> > +
> > +    *nregions =3D msg.payload.shmem.nregions;
>
> Missing input validation from the untrusted vhost-user backend. nregions
> may be out of range.
>
> > +    memcpy(memory_sizes,
> > +           &msg.payload.shmem.memory_sizes,
> > +           sizeof(uint64_t) * VHOST_MEMORY_BASELINE_NREGIONS);
> > +    return 0;
> > +}
> > +
> >  const VhostOps user_ops =3D {
> >          .backend_type =3D VHOST_BACKEND_TYPE_USER,
> >          .vhost_backend_init =3D vhost_user_backend_init,
> > @@ -3174,4 +3215,5 @@ const VhostOps user_ops =3D {
> >          .vhost_supports_device_state =3D vhost_user_supports_device_st=
ate,
> >          .vhost_set_device_state_fd =3D vhost_user_set_device_state_fd,
> >          .vhost_check_device_state =3D vhost_user_check_device_state,
> > +        .vhost_get_shmem_config =3D vhost_user_get_shmem_config,
> >  };
> > diff --git a/include/hw/virtio/vhost-backend.h
> b/include/hw/virtio/vhost-backend.h
> > index 70c2e8ffee..f9c2955420 100644
> > --- a/include/hw/virtio/vhost-backend.h
> > +++ b/include/hw/virtio/vhost-backend.h
> > @@ -159,6 +159,11 @@ typedef int (*vhost_set_device_state_fd_op)(struct
> vhost_dev *dev,
> >                                              int *reply_fd,
> >                                              Error **errp);
> >  typedef int (*vhost_check_device_state_op)(struct vhost_dev *dev, Erro=
r
> **errp);
> > +typedef int (*vhost_get_shmem_config_op)(struct vhost_dev *dev,
> > +                                         int *nregions,
> > +                                         uint64_t *memory_sizes,
> > +                                         Error **errp);
> > +
> >
> >  typedef struct VhostOps {
> >      VhostBackendType backend_type;
> > @@ -214,6 +219,7 @@ typedef struct VhostOps {
> >      vhost_supports_device_state_op vhost_supports_device_state;
> >      vhost_set_device_state_fd_op vhost_set_device_state_fd;
> >      vhost_check_device_state_op vhost_check_device_state;
> > +    vhost_get_shmem_config_op vhost_get_shmem_config;
> >  } VhostOps;
> >
> >  int vhost_backend_update_device_iotlb(struct vhost_dev *dev,
> > diff --git a/include/hw/virtio/vhost-user.h
> b/include/hw/virtio/vhost-user.h
> > index d7c09ffd34..e1b587a908 100644
> > --- a/include/hw/virtio/vhost-user.h
> > +++ b/include/hw/virtio/vhost-user.h
> > @@ -32,6 +32,7 @@ enum VhostUserProtocolFeature {
> >      /* Feature 17 reserved for VHOST_USER_PROTOCOL_F_XEN_MMAP. */
> >      VHOST_USER_PROTOCOL_F_SHARED_OBJECT =3D 18,
> >      VHOST_USER_PROTOCOL_F_DEVICE_STATE =3D 19,
> > +    VHOST_USER_PROTOCOL_F_SHMEM =3D 20,
> >      VHOST_USER_PROTOCOL_F_MAX
> >  };
> >
> > --
> > 2.45.2
> >
>

--0000000000007cdb130621477a46
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div><div dir=3D"ltr" class=3D"gmail_sign=
ature"><div dir=3D"ltr"><p style=3D"color:rgb(0,0,0);font-family:RedHatText=
,sans-serif;font-weight:bold;margin:0px;padding:0px;font-size:14px"><br></p=
></div></div></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" cl=
ass=3D"gmail_attr">On Thu, Jul 11, 2024 at 10:10=E2=80=AFAM Stefan Hajnoczi=
 &lt;<a href=3D"mailto:stefanha@redhat.com" target=3D"_blank">stefanha@redh=
at.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">On Fri, Jun 28, 2024 at 04:57:07PM +0200, Albert Esteve wrote:<br>
&gt; The frontend can use this command to retrieve<br>
&gt; VIRTIO Shared Memory Regions configuration from<br>
&gt; the backend. The response contains the number of<br>
&gt; shared memory regions, their size, and shmid.<br>
&gt; <br>
&gt; This is useful when the frontend is unaware of<br>
&gt; specific backend type and configuration,<br>
&gt; for example, in the `vhost-user-device` case.<br>
&gt; <br>
&gt; Signed-off-by: Albert Esteve &lt;<a href=3D"mailto:aesteve@redhat.com"=
 target=3D"_blank">aesteve@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 docs/interop/vhost-user.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0| 31 +++++=
++++++++++++++++++<br>
&gt;=C2=A0 hw/virtio/vhost-user.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
| 42 +++++++++++++++++++++++++++++++<br>
&gt;=C2=A0 include/hw/virtio/vhost-backend.h |=C2=A0 6 +++++<br>
&gt;=C2=A0 include/hw/virtio/vhost-user.h=C2=A0 =C2=A0 |=C2=A0 1 +<br>
&gt;=C2=A0 4 files changed, 80 insertions(+)<br>
&gt; <br>
&gt; diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst=
<br>
&gt; index d52ba719d5..51f01d1d84 100644<br>
&gt; --- a/docs/interop/vhost-user.rst<br>
&gt; +++ b/docs/interop/vhost-user.rst<br>
&gt; @@ -348,6 +348,19 @@ Device state transfer parameters<br>
&gt;=C2=A0 =C2=A0 In the future, additional phases might be added e.g. to a=
llow<br>
&gt;=C2=A0 =C2=A0 iterative migration while the device is running.<br>
&gt;=C2=A0 <br>
&gt; +VIRTIO Shared Memory Region configuration<br>
&gt; +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^<br>
&gt; +<br>
&gt; ++-------------+---------+------------+----+------------+<br>
&gt; +| num regions | padding | mem size 0 | .. | mem size 7 |<br>
&gt; ++-------------+---------+------------+----+------------+<br>
<br>
8 regions may not be enough. The max according to the VIRTIO spec is<br>
256 because virtio-pci uses an 8-bit <a href=3D"http://cap.id" rel=3D"noref=
errer" target=3D"_blank">cap.id</a> field for the shmid. I think<br>
the maximum number should be 256 here.<br></blockquote><div><br></div><div>=
Ok, I&#39;ll set it to 255, as it starts at 0.</div><div>=C2=A0</div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">
<br>
(I haven&#39;t checked the QEMU vhost-user code to see whether it&#39;s<br>
reasonable to hardcode to 256 or some logic if needed to dynamically<br>
size the buffer depending on the &quot;num regions&quot; field.)<br>
<br>
&gt; +<br>
&gt; +:num regions: a 32-bit number of regions<br>
&gt; +<br>
&gt; +:padding: 32-bit<br>
&gt; +<br>
&gt; +:mem size: 64-bit size of VIRTIO Shared Memory Region<br>
&gt; +<br>
&gt;=C2=A0 C structure<br>
&gt;=C2=A0 -----------<br>
&gt;=C2=A0 <br>
&gt; @@ -369,6 +382,10 @@ In QEMU the vhost-user message is implemented wit=
h the following struct:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VhostUserConfig config;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VhostUserVringArea area;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VhostUserInflight inflight;<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VhostUserShared object;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VhostUserTransferDeviceState trans=
fer_state;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VhostUserMMap mmap;<br>
<br>
Why are these added by this patch? Please add them in the same patch<br>
where they are introduced.</blockquote><div><br></div><div>For object and t=
ransfer_state that&#39;s a ship that already sailed.</div><div>In order to =
still align the excerpt with the actual code, I will</div><div>split them i=
nto their own commit to avoid confusion.</div><div>=C2=A0</div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VhostUserShMemConfig shmem;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 };<br>
&gt;=C2=A0 =C2=A0 } QEMU_PACKED VhostUserMsg;<br>
&gt;=C2=A0 <br>
&gt; @@ -1051,6 +1068,7 @@ Protocol features<br>
&gt;=C2=A0 =C2=A0 #define VHOST_USER_PROTOCOL_F_XEN_MMAP=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A017<br>
&gt;=C2=A0 =C2=A0 #define VHOST_USER_PROTOCOL_F_SHARED_OBJECT=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 18<br>
&gt;=C2=A0 =C2=A0 #define VHOST_USER_PROTOCOL_F_DEVICE_STATE=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A019<br>
&gt; +=C2=A0 #define VHOST_USER_PROTOCOL_F_SHMEM=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 20<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 Front-end message types<br>
&gt;=C2=A0 -----------------------<br>
&gt; @@ -1725,6 +1743,19 @@ Front-end message types<br>
&gt;=C2=A0 =C2=A0 Using this function requires prior negotiation of the<br>
&gt;=C2=A0 =C2=A0 ``VHOST_USER_PROTOCOL_F_DEVICE_STATE`` feature.<br>
&gt;=C2=A0 <br>
&gt; +``VHOST_USER_GET_SHMEM_CONFIG``<br>
&gt; +=C2=A0 :id: 44<br>
&gt; +=C2=A0 :equivalent ioctl: N/A<br>
&gt; +=C2=A0 :request payload: N/A<br>
&gt; +=C2=A0 :reply payload: ``struct VhostUserShMemConfig``<br>
&gt; +<br>
&gt; +=C2=A0 When the ``VHOST_USER_PROTOCOL_F_SHMEM`` protocol feature has =
been<br>
&gt; +=C2=A0 successfully negotiated, this message can be submitted by the =
front-end<br>
&gt; +=C2=A0 to gather the VIRTIO Shared Memory Region configuration. Back-=
end will respond<br>
&gt; +=C2=A0 with the number of VIRTIO Shared Memory Regions it requires, a=
nd each shared memory<br>
&gt; +=C2=A0 region size in an array. The shared memory IDs are represented=
 by the index<br>
&gt; +=C2=A0 of the array.<br>
<br>
Is the information returned by SHMEM_CONFIG valid and unchanged for the<br>
entire lifetime of the vhost-user connection?<br>
<br>
I think the answer is yes because the enumeration that virtio-pci and<br>
virtio-mmio transports support is basically a one-time operation at<br>
driver startup and it is static (Shared Memory Regions do not appear or<br>
go away at runtime). Please be explicit how VHOST_USER_GET_SHMEM_CONFIG<br>
is intended to be used.<br></blockquote><div><br></div><div>Yes, I will be =
explicit.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">
<br>
&gt; +<br>
&gt;=C2=A0 Back-end message types<br>
&gt;=C2=A0 ----------------------<br>
&gt;=C2=A0 <br>
&gt; diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c<br>
&gt; index 7ee8a472c6..57406dc8b4 100644<br>
&gt; --- a/hw/virtio/vhost-user.c<br>
&gt; +++ b/hw/virtio/vhost-user.c<br>
&gt; @@ -104,6 +104,7 @@ typedef enum VhostUserRequest {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VHOST_USER_GET_SHARED_OBJECT =3D 41,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VHOST_USER_SET_DEVICE_STATE_FD =3D 42,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VHOST_USER_CHECK_DEVICE_STATE =3D 43,<br>
&gt; +=C2=A0 =C2=A0 VHOST_USER_GET_SHMEM_CONFIG =3D 44,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VHOST_USER_MAX<br>
&gt;=C2=A0 } VhostUserRequest;<br>
&gt;=C2=A0 <br>
&gt; @@ -138,6 +139,12 @@ typedef struct VhostUserMemRegMsg {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VhostUserMemoryRegion region;<br>
&gt;=C2=A0 } VhostUserMemRegMsg;<br>
&gt;=C2=A0 <br>
&gt; +typedef struct VhostUserShMemConfig {<br>
&gt; +=C2=A0 =C2=A0 uint32_t nregions;<br>
&gt; +=C2=A0 =C2=A0 uint32_t padding;<br>
&gt; +=C2=A0 =C2=A0 uint64_t memory_sizes[VHOST_MEMORY_BASELINE_NREGIONS];<=
br>
&gt; +} VhostUserShMemConfig;<br>
&gt; +<br>
&gt;=C2=A0 typedef struct VhostUserLog {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 uint64_t mmap_size;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 uint64_t mmap_offset;<br>
&gt; @@ -245,6 +252,7 @@ typedef union {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VhostUserShared object;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VhostUserTransferDeviceState transfe=
r_state;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VhostUserMMap mmap;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VhostUserShMemConfig shmem;<br>
&gt;=C2=A0 } VhostUserPayload;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 typedef struct VhostUserMsg {<br>
&gt; @@ -3136,6 +3144,39 @@ static int vhost_user_check_device_state(struct=
 vhost_dev *dev, Error **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; +static int vhost_user_get_shmem_config(struct vhost_dev *dev,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int *=
nregions,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint6=
4_t *memory_sizes,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Error=
 **errp)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 int ret;<br>
&gt; +=C2=A0 =C2=A0 VhostUserMsg msg =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .hdr.request =3D VHOST_USER_GET_SHMEM_CON=
FIG,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .hdr.flags =3D VHOST_USER_VERSION,<br>
&gt; +=C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!virtio_has_feature(dev-&gt;protocol_features,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VHOST_USER_PROTOCOL_F_SHMEM)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 ret =3D vhost_user_write(dev, &amp;msg, NULL, 0);<br>
&gt; +=C2=A0 =C2=A0 if (ret &lt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 ret =3D vhost_user_read(dev, &amp;msg);<br>
&gt; +=C2=A0 =C2=A0 if (ret &lt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 *nregions =3D msg.payload.shmem.nregions;<br>
<br>
Missing input validation from the untrusted vhost-user backend. nregions<br=
>
may be out of range.<br>
<br>
&gt; +=C2=A0 =C2=A0 memcpy(memory_sizes,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;msg.payload.shmem.memor=
y_sizes,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sizeof(uint64_t) * VHOST_MEM=
ORY_BASELINE_NREGIONS);<br>
&gt; +=C2=A0 =C2=A0 return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 const VhostOps user_ops =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .backend_type =3D VHOST_BACKEND_TYPE=
_USER,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .vhost_backend_init =3D vhost_user_b=
ackend_init,<br>
&gt; @@ -3174,4 +3215,5 @@ const VhostOps user_ops =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .vhost_supports_device_state =3D vho=
st_user_supports_device_state,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .vhost_set_device_state_fd =3D vhost=
_user_set_device_state_fd,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .vhost_check_device_state =3D vhost_=
user_check_device_state,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .vhost_get_shmem_config =3D vhost_user_ge=
t_shmem_config,<br>
&gt;=C2=A0 };<br>
&gt; diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vho=
st-backend.h<br>
&gt; index 70c2e8ffee..f9c2955420 100644<br>
&gt; --- a/include/hw/virtio/vhost-backend.h<br>
&gt; +++ b/include/hw/virtio/vhost-backend.h<br>
&gt; @@ -159,6 +159,11 @@ typedef int (*vhost_set_device_state_fd_op)(struc=
t vhost_dev *dev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 int *reply_fd,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 Error **errp);<br>
&gt;=C2=A0 typedef int (*vhost_check_device_state_op)(struct vhost_dev *dev=
, Error **errp);<br>
&gt; +typedef int (*vhost_get_shmem_config_op)(struct vhost_dev *dev,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0int *nregions,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0uint64_t *memory_sizes,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0Error **errp);<br>
&gt; +<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 typedef struct VhostOps {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VhostBackendType backend_type;<br>
&gt; @@ -214,6 +219,7 @@ typedef struct VhostOps {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 vhost_supports_device_state_op vhost_supports_devi=
ce_state;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 vhost_set_device_state_fd_op vhost_set_device_stat=
e_fd;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 vhost_check_device_state_op vhost_check_device_sta=
te;<br>
&gt; +=C2=A0 =C2=A0 vhost_get_shmem_config_op vhost_get_shmem_config;<br>
&gt;=C2=A0 } VhostOps;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 int vhost_backend_update_device_iotlb(struct vhost_dev *dev,<br>
&gt; diff --git a/include/hw/virtio/vhost-user.h b/include/hw/virtio/vhost-=
user.h<br>
&gt; index d7c09ffd34..e1b587a908 100644<br>
&gt; --- a/include/hw/virtio/vhost-user.h<br>
&gt; +++ b/include/hw/virtio/vhost-user.h<br>
&gt; @@ -32,6 +32,7 @@ enum VhostUserProtocolFeature {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 /* Feature 17 reserved for VHOST_USER_PROTOCOL_F_X=
EN_MMAP. */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VHOST_USER_PROTOCOL_F_SHARED_OBJECT =3D 18,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VHOST_USER_PROTOCOL_F_DEVICE_STATE =3D 19,<br>
&gt; +=C2=A0 =C2=A0 VHOST_USER_PROTOCOL_F_SHMEM =3D 20,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VHOST_USER_PROTOCOL_F_MAX<br>
&gt;=C2=A0 };<br>
&gt;=C2=A0 <br>
&gt; -- <br>
&gt; 2.45.2<br>
&gt; <br>
</blockquote></div></div>

--0000000000007cdb130621477a46--


