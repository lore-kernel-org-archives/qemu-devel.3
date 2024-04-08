Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C7CCC67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 07:30:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtjSF-0003cy-HS; Mon, 08 Apr 2024 03:30:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rtjSC-0003cT-Nn
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 03:30:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rtjS9-00011J-P1
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 03:30:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712561404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PKkE09D30QjVtMV8loqtF/SA8OQynMaIghqXIAXdWVU=;
 b=G3VVQ9PbYM825lHVDiOE+TZUi4HYcsxaUS9ZX0ONfuncbSMIKYQLpEdCDauNoxMOgxG0XH
 sPPkLxBObumN3bDzNhWs0B6MkkAMEopsz6pNtpBnrXAAXL8JlqWKHolj1ysUTxEgu4bGdn
 so1okNwWo516XFfkRNTipmXulgbXuyE=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-BreT-on6NFCuzevRUFf6Hw-1; Mon, 08 Apr 2024 03:30:02 -0400
X-MC-Unique: BreT-on6NFCuzevRUFf6Hw-1
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-6ed25eb8e01so196490b3a.1
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 00:30:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712561401; x=1713166201;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PKkE09D30QjVtMV8loqtF/SA8OQynMaIghqXIAXdWVU=;
 b=JG7Gl2Pa3xr1W16Twjk+hi2Bh95ypqiJmbc77XGYnad5jGIj13H4wUVsa8se+uoEHZ
 HtXCZp3iFqTk7ueo+Ihk9PghzekIlrS3VMZXRc1MbtOIAFkp2AOLoXlmXB10RtMAXEUQ
 GXJ3fkBopIpxOxh6bR/4bQNRATtaFQ6H0Yc79OqQIbsYYzfyGHN0tmxfHl5YBvmaUJfI
 RTpuLJiiQ9NhM6DzFIkmL6imcRmvHlA3HIszeoBLJp+7qclwkSRwZehogl8p2Dx2MGWD
 Ss4RQ3wBs4M6ygjOTnKHLedF7iNBRQRFmHTvs8hM2Sz/BynTc4wXvdMdj919e30EvDE5
 k/pA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8Rf1HbVm7G9/AfOdm5u54dpZT722sG/mCsqsCDECHoXLjW6YbVBK7gNGpUcJmk0OXOVO4pKKiZlpwS3+GScxTwUUl31I=
X-Gm-Message-State: AOJu0YzyHnFiyOga/OQ/H6LbXC4ZS03MR1WbZWzqoml5E70edYaCfAqO
 k3XI2jQ97QHCHNBKA/HkkRdEsA8DXHw5KHSPBTk+DL8/RXgftxsue/7qzIKg+jP2igWCuMGPPaf
 Dlh65RhadSgLqS/wJSjZR2vM5SBDB7+ZzcLu+yI0sSwC21bmtmSaXmFA7Pxf12/mVKHfm49gdHB
 M+it5Xm2zoA9VV7UDIGGu/Ejb9QEk=
X-Received: by 2002:a05:6a20:6f8a:b0:1a7:5fbf:36a6 with SMTP id
 gv10-20020a056a206f8a00b001a75fbf36a6mr2832202pzb.53.1712561401770; 
 Mon, 08 Apr 2024 00:30:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0N0eYeq3it6FBDVj8uSELmfKyltNPWBfeafbzF+KCAKw/f/D6XLBfccsxl0OajT6Cr9OBtXZap4BE7uhcGVY=
X-Received: by 2002:a05:6a20:6f8a:b0:1a7:5fbf:36a6 with SMTP id
 gv10-20020a056a206f8a00b001a75fbf36a6mr2832184pzb.53.1712561401471; Mon, 08
 Apr 2024 00:30:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240221073802.2888022-1-chenh@yusur.tech>
 <d9e4f3b4-9c2e-466c-b5f4-3387ce88c6b9@t-8ch.de>
 <20240313155136-mutt-send-email-mst@kernel.org>
 <CACGkMEtSSb-9PsmQKPA4i-UWVJJ4ZVog8rt+1PKoqE+ABhpRTA@mail.gmail.com>
 <20240318083932-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240318083932-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 8 Apr 2024 15:29:50 +0800
Message-ID: <CACGkMEv4J1ZyK9cadVFr5BjZwA7edL7d+yqUuJqa+x8zyQpbBw@mail.gmail.com>
Subject: Re: [PATCH] hw/virtio: Add support for VDPA network simulation devices
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>, 
 Hao Chen <chenh@yusur.tech>, qemu-devel@nongnu.org, cohuck@redhat.com, 
 pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.355,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, Mar 18, 2024 at 8:41=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Thu, Mar 14, 2024 at 11:24:33AM +0800, Jason Wang wrote:
> > On Thu, Mar 14, 2024 at 3:52=E2=80=AFAM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Wed, Mar 13, 2024 at 07:51:08PM +0100, Thomas Wei=C3=9Fschuh wrote=
:
> > > > On 2024-02-21 15:38:02+0800, Hao Chen wrote:
> > > > > This patch adds support for VDPA network simulation devices.
> > > > > The device is developed based on virtio-net and tap backend,
> > > > > and supports hardware live migration function.
> > > > >
> > > > > For more details, please refer to "docs/system/devices/vdpa-net.r=
st"
> > > > >
> > > > > Signed-off-by: Hao Chen <chenh@yusur.tech>
> > > > > ---
> > > > >  MAINTAINERS                                 |   5 +
> > > > >  docs/system/device-emulation.rst            |   1 +
> > > > >  docs/system/devices/vdpa-net.rst            | 121 +++++++++++++
> > > > >  hw/net/virtio-net.c                         |  16 ++
> > > > >  hw/virtio/virtio-pci.c                      | 189 ++++++++++++++=
+++++-
> >
> > I think those modifications should belong to a separate file as it
> > might conflict with virito features in the future.
> >
> > > > >  hw/virtio/virtio.c                          |  39 ++++
> > > > >  include/hw/virtio/virtio-pci.h              |   5 +
> > > > >  include/hw/virtio/virtio.h                  |  19 ++
> > > > >  include/standard-headers/linux/virtio_pci.h |   7 +
> > > > >  9 files changed, 399 insertions(+), 3 deletions(-)
> > > > >  create mode 100644 docs/system/devices/vdpa-net.rst
> > > >
> > > > [..]
> > > >
> > > > > diff --git a/include/standard-headers/linux/virtio_pci.h b/includ=
e/standard-headers/linux/virtio_pci.h
> > > > > index b7fdfd0668..fb5391cef6 100644
> > > > > --- a/include/standard-headers/linux/virtio_pci.h
> > > > > +++ b/include/standard-headers/linux/virtio_pci.h
> > > > > @@ -216,6 +216,13 @@ struct virtio_pci_cfg_cap {
> > > > >  #define VIRTIO_PCI_COMMON_Q_NDATA  56
> > > > >  #define VIRTIO_PCI_COMMON_Q_RESET  58
> > > > >
> > > > > +#define LM_LOGGING_CTRL                 0
> > > > > +#define LM_BASE_ADDR_LOW                4
> > > > > +#define LM_BASE_ADDR_HIGH               8
> > > > > +#define LM_END_ADDR_LOW                 12
> > > > > +#define LM_END_ADDR_HIGH                16
> > > > > +#define LM_VRING_STATE_OFFSET           0x20
> > > >
> > > > These changes are not in upstream Linux and will be undone by
> > > > ./scripts/update-linux-headers.sh.
> > > >
> > > > Are they intentionally in this header?
> > >
> > >
> > > Good point. Pls move.
> >
> > Right and this part, it's not a part of standard virtio.
> >
> > Thanks
>
> I'm thinking of reverting this patch unless there's a resolution
> soon, and reapplying later after the release.

I think we need to revert this and re-visit in the next release.

Thanks

>
>
> > >
> > > > > +
> > > > >  #endif /* VIRTIO_PCI_NO_MODERN */
> > > > >
> > > > >  #endif
> > >
>


