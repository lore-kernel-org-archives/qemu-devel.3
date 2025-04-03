Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DA6DC3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 05:47:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0DQ5-0001po-Bb; Thu, 03 Apr 2025 01:47:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1u0DQ3-0001pG-NG
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 01:47:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1u0DQ1-0008Gs-RM
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 01:47:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743659233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S3GI22OJj4rH+k+WlKeuO3VBbed+nBem+GBWDLCeAug=;
 b=jDn1IqlSS5IqV4tKO6+66fN7XQPCtsvfTCmblKsnaB83lMdg2Qxawuit7vIIuXgrWmKnHL
 5EsAgVDmrdbIInLvrk7IECIDIVwgtgg8QNVmzCYJ/a3XtUnc5WQ3PQ4TnIELoxJM7qAC6F
 A6nxO+WJFM3UMwWLTVuDUE5uTPg9mnw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-TkDL7GzKPTO-fFiaChkyZA-1; Thu, 03 Apr 2025 01:47:09 -0400
X-MC-Unique: TkDL7GzKPTO-fFiaChkyZA-1
X-Mimecast-MFC-AGG-ID: TkDL7GzKPTO-fFiaChkyZA_1743659228
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-ac6ce5fe9bfso49265466b.1
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 22:47:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743659228; x=1744264028;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S3GI22OJj4rH+k+WlKeuO3VBbed+nBem+GBWDLCeAug=;
 b=hMD20ZobtkQawN7ah6jOi8GcLsmF26xum1GS15cukEJjedqgqiSAtaoAQLjbTHb6TV
 E4YgU9cEvIAE7r+qjHBJ+C/O+pd5EOdn2q6YydVvsrbr1HtUGjBbL33355cr695uNKx7
 8liVGX+riawKcdHvzwX9RMjrDN554BH5Jo+KgPK0zNT3NEP+a9aNidgWCHwBd/ECnk6C
 GdtRXAYssPvrCAetdAElev+CuVa7fxADXmGNkNnMQtFZqUbob+xmsayvLvNbcy66fufI
 I0QrgtQZ0AZCGJKY6sCdc/09m/aHlDnDsbBvbwgARywgLC0fOSGF49M/UJjDrIREc4Yu
 EvrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXP2rPdqw/X+l27J/eJJ/dlcb8deUy1MBs3F+iJK/Soa/awlAnXFKHTL8w230N7UREj58ytek+u54MF@nongnu.org
X-Gm-Message-State: AOJu0YzW5oY6RmUGTayuB662DeYirBUtlix5VTMOnZVdUfFR260pEg4T
 N+0gYndd0dhCVGe1EIirfTI3anxl9n1Sqh8bTufmfDklL7UH/lLAUlbFB6BtUEb0ISDO2Sufqpe
 8JUcYEwDm0k4AT2MNVEjrVe7ME/dwZCcf9M/CiqafBfeIZAM+h6Pj7n0KE5M4nLW/uQ7BDpUvmI
 SB8fQAi+rtAfqwMSqKQ/N4I/1TxNs=
X-Gm-Gg: ASbGncv8MWsT0f8F8F9OLyZSu45RPdy+K55x7NuNjcKaA0PUAyhT3M3Hm2UAYKJ58ch
 7jMfhq4Y6XC9LCcTPf6ArgIFT1JccnrqT34rSl1E1uMVJR+bb6FYNRZJXs1xQY32XKZhcheTjug
 ==
X-Received: by 2002:a17:906:b1cb:b0:ac7:c54e:bb5f with SMTP id
 a640c23a62f3a-ac7c54ebe1fmr12286266b.10.1743659228479; 
 Wed, 02 Apr 2025 22:47:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpiMjqkkd/PIqkahnA8iAMWe8btBM/faMu47opLbYSWUvcj0yRwd/TO1ZoxuLqfSFxdqU7pXScAa7hwlk/Png=
X-Received: by 2002:a17:906:b1cb:b0:ac7:c54e:bb5f with SMTP id
 a640c23a62f3a-ac7c54ebe1fmr12285366b.10.1743659228159; Wed, 02 Apr 2025
 22:47:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250326132021.1215568-1-lulu@redhat.com>
 <20250326132021.1215568-5-lulu@redhat.com>
 <20250402123554-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250402123554-mutt-send-email-mst@kernel.org>
From: Cindy Lu <lulu@redhat.com>
Date: Thu, 3 Apr 2025 13:46:30 +0800
X-Gm-Features: ATxdqUFNrf9Yks8Dg9XkDFp8PCMWrGIPn6RM-6gUpZxaVHuczIBuHB41avHGEHQ
Message-ID: <CACLfguVYCh76NUMjw7kG5g4JAA6S2-KuPb2xSyTxPaRzeKiUFw@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] virtio_net: Add third acceptable configuration for
 MAC setup.
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
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

On Thu, Apr 3, 2025 at 12:36=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Wed, Mar 26, 2025 at 09:19:33PM +0800, Cindy Lu wrote:
> > For VDPA devices, Allow configurations where both the hardware MAC addr=
ess
> > and QEMU command line MAC address are zero.
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  hw/net/virtio-net.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > index 1fd0403d5d..d1f44850d5 100644
> > --- a/hw/net/virtio-net.c
> > +++ b/hw/net/virtio-net.c
> > @@ -3782,6 +3782,19 @@ static bool virtio_net_check_vdpa_mac(NetClientS=
tate *nc, VirtIONet *n,
> >              return true;
> >          }
> >      }
> > +    /*
> > +     * 3.The hardware MAC address is 0,
> > +     *  and the MAC address in the QEMU command line is also 0.
> > +     *  In this situation, qemu will generate a random mac address
> > +     *  QEMU will try to use CVQ/set_config to set this address to
> > +     *  device
>
> same comments. end sentences with a period.
>
sure. will fix this
Thanks
cindy
> > +     */
> > +    if ((memcmp(&hwcfg.mac, &zero, sizeof(MACAddr)) =3D=3D 0) &&
> > +        (memcmp(cmdline_mac, &zero, sizeof(MACAddr)) =3D=3D 0)) {
> > +        memcpy(&n->mac[0], &n->nic_conf.macaddr, sizeof(n->mac));
> > +
> > +        return true;
> > +    }
> >
> >      error_setg(errp,
> >                 "vDPA device's mac %02x:%02x:%02x:%02x:%02x:%02x"
> > --
> > 2.45.0
>


