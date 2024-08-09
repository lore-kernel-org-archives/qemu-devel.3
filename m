Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48B85C52D71
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 09:15:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scLiK-0000eZ-OF; Fri, 09 Aug 2024 05:15:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1scLiJ-0000aK-Lp
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 05:15:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1scLiH-0006dQ-5r
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 05:15:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723194906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BMm3j86St4HUTLBSN7/QTAk7p9d9mYyoYAay5Rel5PE=;
 b=PTulxZFVNruldUPLRJ7s49VEoHXJnlV6LqPJvXnZZqpB/fDiZAZ1/c9d3To2wiBZzmAkpB
 hENABaDJKeVd5asg2KSGbUW5w+MYTaQMae7HEHiXmyYSvJ3Dhv693ucqqscI1kDUxx4Kdy
 5j6qGM4DZc6LAziuNh1iBtTC0w3fmkc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-yw82AN5YNq-fz0Iv609Fog-1; Fri, 09 Aug 2024 05:15:05 -0400
X-MC-Unique: yw82AN5YNq-fz0Iv609Fog-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a7d6a72ad99so153064466b.2
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2024 02:15:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723194904; x=1723799704;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BMm3j86St4HUTLBSN7/QTAk7p9d9mYyoYAay5Rel5PE=;
 b=wR/4ArOna6R4CD1IAC9uAPNzegoN3E1ZrvNzJENdti5AGNUAqkixhnZm2+TvVuBlZ5
 fLRrLGoDk3D6OENEPN51BAnJo0Sp3yMFQcIO6fer7tq5SR0xYmc7D1Q1eY59GCSjdHgY
 QQ9D8qgpbiGni9ab9ReR6d3vSD9cDBhJh1CVXQOFDR4aTm5MIPqiRD3ePQSlV9vLdmSK
 OxhIKOX9xeJf1/5wDEz3dM+d84on282CFtszrzp4tAmBThnIV+bcAI7bdnI9SxORcRQU
 k19ew++BQPzBJ8OXBiyPFC7UJk7+pOhiwVWNVmPdNNDosyf3iR6YjX5fzggPpVQ+nYbn
 Fg/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXr2cczwv+Gnl9dcOVKnTComRrH3SxwDj/+zol0ABUUBYGBpXIZ5KZkraRpN/ypcVkPuqS5qSYwXPW+EGc86y8dUs5WVMA=
X-Gm-Message-State: AOJu0Yw/Ct0vWVSiMWBSg305453z9fOzzGyLV4wQNj6c5AjKIkVhlZPG
 3L/BZRWdiD7E1xu0mAkZF2A9/HoP57FtOqqKZKSQy3t4welp/VaDJtCq8nPePBwXBxFsyeEeawM
 Jf8S/ZSoeuOubyGu+WeHdUZiSUSAcu2dJMGaUPAZQAM+zzKPxxjyT2eNNXiCjAn0VX2mkNuTNts
 jk9/kcgWYrRlTXCvTnmw8eTFmMNbM=
X-Received: by 2002:a17:907:f165:b0:a6f:ddb3:bf2b with SMTP id
 a640c23a62f3a-a80aa6097f7mr77363766b.41.1723194903949; 
 Fri, 09 Aug 2024 02:15:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyoN2ZElhARxoNE5HwO/Si/v2U8kZWSBbspCaVHHNkKgH5+39cuc4gejphhaWlDTgJGE4L+J23tJkogzxJhTA=
X-Received: by 2002:a17:907:f165:b0:a6f:ddb3:bf2b with SMTP id
 a640c23a62f3a-a80aa6097f7mr77361766b.41.1723194903432; Fri, 09 Aug 2024
 02:15:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240806005814.51651-1-lulu@redhat.com>
 <CACGkMEuCJT8KYsDgJaXzvy1Fhm6+tJinowdTtoAngsnvYjB54Q@mail.gmail.com>
 <CACLfguU47TPw5=GpS93AMWEYcy95JJ6+uG-PYpdmeD=hrKGa1Q@mail.gmail.com>
 <CAGoVJZw5=1nsdpJu86QTQqc-2nuWjwRGpe1qaO1wvQF4u=9L4Q@mail.gmail.com>
In-Reply-To: <CAGoVJZw5=1nsdpJu86QTQqc-2nuWjwRGpe1qaO1wvQF4u=9L4Q@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Fri, 9 Aug 2024 17:14:26 +0800
Message-ID: <CACLfguWujXpPiU1AL_98hsNFAUZMKPxsqt57Oq5jipoUne0Ttg@mail.gmail.com>
Subject: Re: [PATCH 1/3] virtio_net: Add the check for vdpa's mac address
To: Yan Vugenfirer <yvugenfi@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, mst@redhat.com, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000193394061f3c94e5"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

--000000000000193394061f3c94e5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 6 Aug 2024 at 19:13, Yan Vugenfirer <yvugenfi@redhat.com> wrote:

> Do we check that the MAC from the command line or HW was formed
> correctly and doesn't include multicast bit?
>
> Best regards,
> Yan.
>
> I didn't include a check for this, but it seems the vhost also doesn't
have this kind of verification. I will double check this
Thanks
Cindy

>
> On Tue, Aug 6, 2024 at 12:45=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
> >
> > On Tue, 6 Aug 2024 at 11:07, Jason Wang <jasowang@redhat.com> wrote:
> > >
> > > On Tue, Aug 6, 2024 at 8:58=E2=80=AFAM Cindy Lu <lulu@redhat.com> wro=
te:
> > > >
> > > > When using a VDPA device, it is important to ensure that
> > > > the MAC address in the hardware matches the MAC address
> > > > from the QEMU command line.
> > > > This will allow the device to boot.
> > > >
> > > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > > ---
> > > >  hw/net/virtio-net.c | 33 +++++++++++++++++++++++++++++----
> > > >  1 file changed, 29 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > > > index 9c7e85caea..7f51bd0dd3 100644
> > > > --- a/hw/net/virtio-net.c
> > > > +++ b/hw/net/virtio-net.c
> > > > @@ -3579,12 +3579,36 @@ static bool
> failover_hide_primary_device(DeviceListener *listener,
> > > >      /* failover_primary_hidden is set during feature negotiation *=
/
> > > >      return qatomic_read(&n->failover_primary_hidden);
> > > >  }
> > > > +static bool virtio_net_check_vdpa_mac(NetClientState *nc, VirtIONe=
t
> *n, MACAddr *cmdline_mac,
> > > > +                                     Error **errp)
> > > > +{
> > > > +       struct virtio_net_config hwcfg =3D {};
> > > > +       static const MACAddr zero =3D { .a =3D { 0, 0, 0, 0, 0, 0 }=
 };
> > > > +
> > > > +       vhost_net_get_config(get_vhost_net(nc->peer), (uint8_t
> *)&hwcfg, ETH_ALEN);
> > > > +
> > > > +    /*
> > > > +     * For VDPA device: Only two situations are acceptable:
> > > > +     * 1.The hardware MAC address is the same as the QEMU command
> line MAC
> > > > +     *   address, and both of them are not 0.
> > >
> > > I guess there should be a bullet 2?
> > >
> > yes, there is a section 2, will change this code here
> > Thanks
> > cindy
> > > > +     */
> > > > +
> > > > +       if (memcmp(&hwcfg.mac, &zero, sizeof(MACAddr)) !=3D 0) {
> > > > +               if ((memcmp(&hwcfg.mac, cmdline_mac,
> sizeof(MACAddr)) =3D=3D 0)) {
> > > > +                       return true;
> > > > +               }
> > > > +       }
> > > > +       error_setg(errp, "vDPA device's mac !=3D the mac address fr=
om
> qemu cmdline"
> > > > +                        "Please check the the vdpa device's
> setting.");
> > >
> > > For error messages I think it's better to use english instead of "!=
=3D"
> > > to describe the issue.
> > >
> > > >
> > > > +       return false;
> > > > +}
> > > >  static void virtio_net_device_realize(DeviceState *dev, Error
> **errp)
> > > >  {
> > > >      VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> > > >      VirtIONet *n =3D VIRTIO_NET(dev);
> > > >      NetClientState *nc;
> > > > +    MACAddr macaddr_cmdline;
> > > >      int i;
> > > >
> > > >      if (n->net_conf.mtu) {
> > > > @@ -3692,6 +3716,7 @@ static void
> virtio_net_device_realize(DeviceState *dev, Error **errp)
> > > >      virtio_net_add_queue(n, 0);
> > > >
> > > >      n->ctrl_vq =3D virtio_add_queue(vdev, 64, virtio_net_handle_ct=
rl);
> > > > +    memcpy(&macaddr_cmdline, &n->nic_conf.macaddr, sizeof(n->mac))=
;
> > > >      qemu_macaddr_default_if_unset(&n->nic_conf.macaddr);
> > > >      memcpy(&n->mac[0], &n->nic_conf.macaddr, sizeof(n->mac));
> > > >      n->status =3D VIRTIO_NET_S_LINK_UP;
> > > > @@ -3739,10 +3764,10 @@ static void
> virtio_net_device_realize(DeviceState *dev, Error **errp)
> > > >      nc->rxfilter_notify_enabled =3D 1;
> > > >
> > > >     if (nc->peer && nc->peer->info->type =3D=3D
> NET_CLIENT_DRIVER_VHOST_VDPA) {
> > > > -        struct virtio_net_config netcfg =3D {};
> > > > -        memcpy(&netcfg.mac, &n->nic_conf.macaddr, ETH_ALEN);
> > > > -        vhost_net_set_config(get_vhost_net(nc->peer),
> > > > -            (uint8_t *)&netcfg, 0, ETH_ALEN,
> VHOST_SET_CONFIG_TYPE_FRONTEND);
> > > > +          if (!virtio_net_check_vdpa_mac(nc, n, &macaddr_cmdline,
> errp)) {
> > > > +                  virtio_cleanup(vdev);
> > > > +                  return;
> > > > +          }
> > >
> > > Any reason we remove vhost_net_set_config() here? It is not described
> > > in the commit or does it belong to another patch?
> > >
> > > Thanks
> > >
> > as we discussed before=EF=BC=8C the MAC address in hardware should have=
 a
> > "higher priority"
> > than the MAC address in qemu cmdline. So I remove the set_config there,
> > the MAC address from the hardware will overwrite the MAC in qemu
> > cmdline. so don't need to set_config to hardware now
> > Thanks,
> > cindy
> > > >      }
> > > >      QTAILQ_INIT(&n->rsc_chains);
> > > >      n->qdev =3D dev;
> > > > --
> > > > 2.45.0
> > > >
> > >
> >
> >
>
>

--000000000000193394061f3c94e5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, 6 Aug 2024 at 19:13, Yan Vuge=
nfirer &lt;<a href=3D"mailto:yvugenfi@redhat.com">yvugenfi@redhat.com</a>&g=
t; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Do we =
check that the MAC from the command line or HW was formed<br>
correctly and doesn&#39;t include multicast bit?<br>
<br>
Best regards,<br>
Yan.<br>
<br></blockquote><div>I didn&#39;t include a check for this, but it seems t=
he vhost also doesn&#39;t have this kind of verification. I will double che=
ck this<br></div><div>Thanks</div><div>Cindy=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
<br>
On Tue, Aug 6, 2024 at 12:45=E2=80=AFPM Cindy Lu &lt;<a href=3D"mailto:lulu=
@redhat.com" target=3D"_blank">lulu@redhat.com</a>&gt; wrote:<br>
&gt;<br>
&gt; On Tue, 6 Aug 2024 at 11:07, Jason Wang &lt;<a href=3D"mailto:jasowang=
@redhat.com" target=3D"_blank">jasowang@redhat.com</a>&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt; On Tue, Aug 6, 2024 at 8:58=E2=80=AFAM Cindy Lu &lt;<a href=3D"ma=
ilto:lulu@redhat.com" target=3D"_blank">lulu@redhat.com</a>&gt; wrote:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; When using a VDPA device, it is important to ensure that<br>
&gt; &gt; &gt; the MAC address in the hardware matches the MAC address<br>
&gt; &gt; &gt; from the QEMU command line.<br>
&gt; &gt; &gt; This will allow the device to boot.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Signed-off-by: Cindy Lu &lt;<a href=3D"mailto:lulu@redhat.co=
m" target=3D"_blank">lulu@redhat.com</a>&gt;<br>
&gt; &gt; &gt; ---<br>
&gt; &gt; &gt;=C2=A0 hw/net/virtio-net.c | 33 +++++++++++++++++++++++++++++=
----<br>
&gt; &gt; &gt;=C2=A0 1 file changed, 29 insertions(+), 4 deletions(-)<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c<br>
&gt; &gt; &gt; index 9c7e85caea..7f51bd0dd3 100644<br>
&gt; &gt; &gt; --- a/hw/net/virtio-net.c<br>
&gt; &gt; &gt; +++ b/hw/net/virtio-net.c<br>
&gt; &gt; &gt; @@ -3579,12 +3579,36 @@ static bool failover_hide_primary_de=
vice(DeviceListener *listener,<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 /* failover_primary_hidden is set during=
 feature negotiation */<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 return qatomic_read(&amp;n-&gt;failover_=
primary_hidden);<br>
&gt; &gt; &gt;=C2=A0 }<br>
&gt; &gt; &gt; +static bool virtio_net_check_vdpa_mac(NetClientState *nc, V=
irtIONet *n, MACAddr *cmdline_mac,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Er=
ror **errp)<br>
&gt; &gt; &gt; +{<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct virtio_net_config hwcfg =
=3D {};<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0static const MACAddr zero =3D { =
.a =3D { 0, 0, 0, 0, 0, 0 } };<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0vhost_net_get_config(get_vhost_n=
et(nc-&gt;peer), (uint8_t *)&amp;hwcfg, ETH_ALEN);<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 /*<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0* For VDPA device: Only two situations =
are acceptable:<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0* 1.The hardware MAC address is the sam=
e as the QEMU command line MAC<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0*=C2=A0 =C2=A0address, and both of them=
 are not 0.<br>
&gt; &gt;<br>
&gt; &gt; I guess there should be a bullet 2?<br>
&gt; &gt;<br>
&gt; yes, there is a section 2, will change this code here<br>
&gt; Thanks<br>
&gt; cindy<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (memcmp(&amp;hwcfg.mac, &amp;=
zero, sizeof(MACAddr)) !=3D 0) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (=
(memcmp(&amp;hwcfg.mac, cmdline_mac, sizeof(MACAddr)) =3D=3D 0)) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0return true;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br=
>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp, &quot;vDPA devi=
ce&#39;s mac !=3D the mac address from qemu cmdline&quot;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Please check the the vdpa device&#39;s setti=
ng.&quot;);<br>
&gt; &gt;<br>
&gt; &gt; For error messages I think it&#39;s better to use english instead=
 of &quot;!=3D&quot;<br>
&gt; &gt; to describe the issue.<br>
&gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
&gt; &gt; &gt; +}<br>
&gt; &gt; &gt;=C2=A0 static void virtio_net_device_realize(DeviceState *dev=
, Error **errp)<br>
&gt; &gt; &gt;=C2=A0 {<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 VirtIODevice *vdev =3D VIRTIO_DEVICE(dev=
);<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 VirtIONet *n =3D VIRTIO_NET(dev);<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 NetClientState *nc;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 MACAddr macaddr_cmdline;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 int i;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 if (n-&gt;net_conf.mtu) {<br>
&gt; &gt; &gt; @@ -3692,6 +3716,7 @@ static void virtio_net_device_realize(=
DeviceState *dev, Error **errp)<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 virtio_net_add_queue(n, 0);<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 n-&gt;ctrl_vq =3D virtio_add_queue(vdev,=
 64, virtio_net_handle_ctrl);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 memcpy(&amp;macaddr_cmdline, &amp;n-&gt;nic_c=
onf.macaddr, sizeof(n-&gt;mac));<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 qemu_macaddr_default_if_unset(&amp;n-&gt=
;nic_conf.macaddr);<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 memcpy(&amp;n-&gt;mac[0], &amp;n-&gt;nic=
_conf.macaddr, sizeof(n-&gt;mac));<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 n-&gt;status =3D VIRTIO_NET_S_LINK_UP;<b=
r>
&gt; &gt; &gt; @@ -3739,10 +3764,10 @@ static void virtio_net_device_realiz=
e(DeviceState *dev, Error **errp)<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 nc-&gt;rxfilter_notify_enabled =3D 1;<br=
>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0if (nc-&gt;peer &amp;&amp; nc-&gt;peer-&g=
t;info-&gt;type =3D=3D NET_CLIENT_DRIVER_VHOST_VDPA) {<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_net_config netcfg=
 =3D {};<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 memcpy(&amp;netcfg.mac, &amp;n-=
&gt;nic_conf.macaddr, ETH_ALEN);<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 vhost_net_set_config(get_vhost_=
net(nc-&gt;peer),<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (uint8_t *)&amp;n=
etcfg, 0, ETH_ALEN, VHOST_SET_CONFIG_TYPE_FRONTEND);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!virtio_net_check_vd=
pa_mac(nc, n, &amp;macaddr_cmdline, errp)) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 virtio_cleanup(vdev);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 return;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;<br>
&gt; &gt; Any reason we remove vhost_net_set_config() here? It is not descr=
ibed<br>
&gt; &gt; in the commit or does it belong to another patch?<br>
&gt; &gt;<br>
&gt; &gt; Thanks<br>
&gt; &gt;<br>
&gt; as we discussed before=EF=BC=8C the MAC address in hardware should hav=
e a<br>
&gt; &quot;higher priority&quot;<br>
&gt; than the MAC address in qemu cmdline. So I remove the set_config there=
,<br>
&gt; the MAC address from the hardware will overwrite the MAC in qemu<br>
&gt; cmdline. so don&#39;t need to set_config to hardware now<br>
&gt; Thanks,<br>
&gt; cindy<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 QTAILQ_INIT(&amp;n-&gt;rsc_chains);<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 n-&gt;qdev =3D dev;<br>
&gt; &gt; &gt; --<br>
&gt; &gt; &gt; 2.45.0<br>
&gt; &gt; &gt;<br>
&gt; &gt;<br>
&gt;<br>
&gt;<br>
<br>
</blockquote></div></div>

--000000000000193394061f3c94e5--


