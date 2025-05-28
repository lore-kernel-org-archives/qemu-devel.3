Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BE87C54ED1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 03:06:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uK76d-0007GA-BJ; Tue, 27 May 2025 23:05:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1uK76U-0007Eh-ST
 for qemu-devel@nongnu.org; Tue, 27 May 2025 23:05:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1uK76S-000700-PS
 for qemu-devel@nongnu.org; Tue, 27 May 2025 23:05:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748401513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f1mP4/9Zk66AF1FfmhdSuToq0KetzH2Qqm/1TisdoP4=;
 b=ipS+eMRWPBs4M9PjcfPDcVY54dDjjGr0d1AlzOJ1PwkR7u1iuglftiyFstB9aA+jy1pPya
 03qOkd7ycvbqobN+/3LUyCnKts55jfNrxuXu0WKK6qTPhfK5o365d+IuuLq4/vmJ3Suw5b
 Ajb0ljrABP75YmhvArEzUjHTOoxMJfs=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-LTzb_m5KOmS0bTdLEWU8gw-1; Tue, 27 May 2025 23:05:12 -0400
X-MC-Unique: LTzb_m5KOmS0bTdLEWU8gw-1
X-Mimecast-MFC-AGG-ID: LTzb_m5KOmS0bTdLEWU8gw_1748401511
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-acb66d17be4so313693066b.2
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 20:05:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748401511; x=1749006311;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f1mP4/9Zk66AF1FfmhdSuToq0KetzH2Qqm/1TisdoP4=;
 b=b8N/N3yd7aPBIZ+j/lXOCKQ6pGOUzfAklYT9C3oKwRacSGO1A+HcO29p3lBjufDhyA
 Gt4TtHmV/zROoMNfbixL79oM+Z2Mevzl/akWjSbwq49/TXU6YTPLCx18Df4i/EBzv7fj
 1TYH9vZEAbxe0KfQJIJEl2eu8CA7/QhA+b7nOPMjYUSku0uSEqEi/AiE6nx6/DU429dK
 meomSFE/wYj9OvOdDIL0cnZTMg+ZU4usGoFK2ZmqhO7DsZ961ChO0wN2hceVBRbLw+ab
 ZGUnX9Lz9osfg8lqn7yItP/DQgUmLRMuHOTVtaMLtKAi+aqvLw2IysTfKLvZ1jGrpMkS
 q79Q==
X-Gm-Message-State: AOJu0YzcpzBBfBpluLbnnTC2N+dbQ5lFmx0Zpwly/mSQ/aXa2bYFsBvF
 p/N7qhCGHpbKWcOdhZxDLS0mQku8Juj6SuXbVDHhPosZFVOQqh83OXt7D/vu+xKFIzKDucrW+H3
 7Y++MDcuiCSAhbFDDF1Y4qNzxEy8r5ouCt6Dnx3wHncbPRrBzi8r3T5/iEJcbfjokWOqeZcdK0S
 9Z+DnHhYM6PiayulHAjdTaM5EEjyHxl2o=
X-Gm-Gg: ASbGnctRH9Y1Tt+aOa3WcrYpa4PfG9pUHkqy5KffF+tguVeofpSkfiQqnNR3hrulv4K
 r2Q/7R/dz6za/6PsiJ14BFcRhFC/6ezF7ryiqJhTq25BED2CUJvg6hOD4qcLjEAFO7tzguQ==
X-Received: by 2002:a17:906:dc8b:b0:ad8:8efe:31fc with SMTP id
 a640c23a62f3a-ad88efe3ddamr459347766b.41.1748401510757; 
 Tue, 27 May 2025 20:05:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdu9IJZCwFMw85XC+wGssG1IzVZyjRF6vafJ0cZHoZkZsqnRAbgLOC4dWlSH8+C1seZ9lRN/8ViI/uwfIaWcw=
X-Received: by 2002:a17:906:dc8b:b0:ad8:8efe:31fc with SMTP id
 a640c23a62f3a-ad88efe3ddamr459346766b.41.1748401510420; Tue, 27 May 2025
 20:05:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1747825544.git.pabeni@redhat.com>
 <87d85cd2c276a43d0f7ed2d27e00427b8f4a8243.1747825544.git.pabeni@redhat.com>
 <f824d42a-6b4e-4624-874c-bb8eddf663e2@daynix.com>
In-Reply-To: <f824d42a-6b4e-4624-874c-bb8eddf663e2@daynix.com>
From: Lei Yang <leiyang@redhat.com>
Date: Wed, 28 May 2025 11:04:33 +0800
X-Gm-Features: AX0GCFs8taL60GWquPJSn6lIMT2G1PfTK5dyutqVFDaz3-3gkztl1PI9RTyOPuU
Message-ID: <CAPpAL=wJNPnmvBE55K3+UZtnw1ZybffkJnwS0vdRKJ6f71sH+w@mail.gmail.com>
Subject: Re: [PATCH RFC 16/16] net: make vhost-net aware of GSO over UDP
 tunnel hdr layout
To: Paolo Abeni <pabeni@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Cornelia Huck <cohuck@redhat.com>,
 Luigi Rizzo <lrizzo@google.com>, 
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Vincenzo Maffione <v.maffione@gmail.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leiyang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Tested this series of patches with vhost-net regression tests,
everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Fri, May 23, 2025 at 4:24=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> On 2025/05/21 20:34, Paolo Abeni wrote:
> > When the GSO over UDP tunnel offload is enabled, the virtio net
> > header includes additional fields to support such offload.
> >
> > The vhost backend must be aware of the exact header layout, to
> > copy it correctly. The tunnel-related field are present if either
> > the guest or the host negotiated any UDP tunnel related feature:
> > add them to host kernel supported features list, to allow qemu
> > transder to such backend the needed information.
>
> s/transder/transfer/
>
> This patch should be squashed into the previous patch ("[PATCH RFC
> 15/16] net: implement tnl feature offloading") as QEMU only with the
> previous patch will incorrectly enable tunnel offloading even when vhost
> doesn't support it.
>
> >
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> >   hw/net/vhost_net.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> >
> > diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> > index 58d7619fc8..c8e02d1732 100644
> > --- a/hw/net/vhost_net.c
> > +++ b/hw/net/vhost_net.c
> > @@ -52,6 +52,10 @@ static const int kernel_feature_bits[] =3D {
> >       VIRTIO_F_NOTIFICATION_DATA,
> >       VIRTIO_NET_F_RSC_EXT,
> >       VIRTIO_NET_F_HASH_REPORT,
> > +#ifdef CONFIG_INT128
> > +    VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO,
> > +    VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO,
> > +#endif
> >       VHOST_INVALID_FEATURE_BIT
> >   };
> >
>
>


