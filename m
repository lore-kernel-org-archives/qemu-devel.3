Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 947CBC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 12:13:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sevpL-0001dJ-7E; Fri, 16 Aug 2024 08:13:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sevpI-0001bz-Od
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 08:13:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sevpH-0004K9-50
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 08:13:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723810381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HIVtaWB0H5VhVsjQLWxG1WVJMydNn1qp3YeDj0hgyPo=;
 b=V0EJh7Hg92/LdFf4+CaRVFNCgj/e7XwfcUHkOEskhXZn/qCz8+zBvsjwzi/qrBQZ82twCI
 5K7OPXxjqjvnPfIhQALVsN6jOowBM3hlF5wTBh+CR43/bdiLeLPQ6mFb+hzulVXKL9TOqo
 trBlcVuONXx72gLkib5fLeQQxyogE3I=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-Kf_j10o2MV6aJ-eJSpSgxg-1; Fri, 16 Aug 2024 08:12:59 -0400
X-MC-Unique: Kf_j10o2MV6aJ-eJSpSgxg-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2d3efe18d05so408338a91.3
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 05:12:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723810378; x=1724415178;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HIVtaWB0H5VhVsjQLWxG1WVJMydNn1qp3YeDj0hgyPo=;
 b=DTONNyEgbnvjMMl9zoangK+9yMwSfl0BuYZQHj5FUJ8mKnPSM2YNOzO+5dz3dLmNpc
 rUQ1qggWUKhaeKQA0VigPxspbF5vqwN+9vIbS/iF4Z89H+BAxzDxZ8gmYhzhzYnWG8Vu
 dyGzz/TKy5fKUjRZEnKYz921ejgiWLq61PZ/6ofxyPkzlmPqQk+xpz7mvDFFKNRa5N2V
 i+q7+pdM22sDG5O88ZUbbWTBKWwzz6nBvOWY7NMinpi+NF/Y1Bi7KtMD8EDF4FxIjwAn
 /0L+n1zJjNAwGQMB2JcV38XcgDkMUapDiQepKP/irRrfYCA63SdZzwUafOjoIMvgIQnf
 KBgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/VsBZKfERNWpvc6VKl5ESfcY9ztVc1b+0OoGrXoIVlg5fuKR5WLxH1Crw/drkfK5kGZObhJ8cJsiW64ahYQKbk01UQ0A=
X-Gm-Message-State: AOJu0YxvOLEHZs5GkUMBbo71medL1kQSkdi3TiCxzdDjwYSd5nD8VZPr
 wAKS34KzSBnJom4PLPdX9sGrX92JY0OgMWRER6+4wZe29izaUYYnCKt5dVpO+twuO/NMWEUnxEH
 5I1Pa899Vkgqu8WDsJ6YYw5X8xZm362D4bR11AOe2fPIw6z4zpyIY5NPRdC80/0CXGQYNWYk7yg
 IwIXpXnsltbezDNyUzT638PeEemFo=
X-Received: by 2002:a17:90b:ed0:b0:2c7:22d6:98e with SMTP id
 98e67ed59e1d1-2d3dffe221bmr2723414a91.19.1723810378388; 
 Fri, 16 Aug 2024 05:12:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEY9CLvCttj+ob6aNFEUhVWuxC7nD/ai+XnDuwKq3fkb0pXKm6IcP2uj/U4Z9duuHk2MhjVXCYPXYfhiviS6HU=
X-Received: by 2002:a17:90b:ed0:b0:2c7:22d6:98e with SMTP id
 98e67ed59e1d1-2d3dffe221bmr2723388a91.19.1723810377889; Fri, 16 Aug 2024
 05:12:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240812122027.65600-1-gaoshiyuan@baidu.com>
 <20240816061647-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240816061647-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 16 Aug 2024 20:12:46 +0800
Message-ID: <CACGkMEvcnhe6JW-b0GzMYXzAdGftb1Zk-_L_xi8d==w99t2-xQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] virtio-pci: return RAM device MR when set host
 notifier success
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Gao Shiyuan <gaoshiyuan@baidu.com>, Tiwei Bie <tiwei.bie@intel.com>,
 zuoboqun@baidu.com, 
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Aug 16, 2024 at 6:29=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Mon, Aug 12, 2024 at 08:20:27PM +0800, Gao Shiyuan wrote:
> > When vhost-user backend register memory region based host notifiers,
> > we should return RAM device MR of notify region MR's subregion in
> > virtio_address_space_lookup.
> >
> > In seabios, it will use virtio PCI Configration Access Capability
> > access notify region when assign notify region above 4GB. This will
> > exit to QEMU and invoke virtio_address_space_write. When vhost-user
> > backend register memory region based host notifiers, return RAM device
> > MR instead of notify region MR is suitable.
>
>
> I can't really parse this.
>
> > Co-developed-by: Zuo Boqun <zuoboqun@baidu.com>
> > Signed-off-by: Gao Shiyuan <gaoshiyuan@baidu.com>
> > Signed-off-by: Zuo Boqun <zuoboqun@baidu.com>
>
> CC Jason
>
> > ---
> >  hw/virtio/virtio-pci.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> > index 9534730bba..167ac9718a 100644
> > --- a/hw/virtio/virtio-pci.c
> > +++ b/hw/virtio/virtio-pci.c
> > @@ -610,13 +610,22 @@ static MemoryRegion *virtio_address_space_lookup(=
VirtIOPCIProxy *proxy,
> >  {
> >      int i;
> >      VirtIOPCIRegion *reg;
> > +    MemoryRegion *mr, *submr;
> >
> >      for (i =3D 0; i < ARRAY_SIZE(proxy->regs); ++i) {
> >          reg =3D &proxy->regs[i];
> >          if (*off >=3D reg->offset &&
> >              *off + len <=3D reg->offset + reg->size) {
> >              *off -=3D reg->offset;
> > -            return &reg->mr;
> > +            mr =3D &reg->mr;
> > +            QTAILQ_FOREACH(submr, &mr->subregions, subregions_link) {
> > +                if (*off >=3D submr->addr &&
> > +                    *off + len < submr->addr + submr->size) {
> > +                    *off -=3D submr->addr;
> > +                    return submr;
> > +                }
> > +            }
> > +            return mr;
> >          }
> >      }
>
> Poking at internals of MR like this is not nice.
> Doesn't memory_region_find work for this?

Or I wonder if this is a side effect of:

commit a93c8d828af186d9a6a1c915a1be8ba22fb89849
Author: Alexey Kardashevskiy <aik@ozlabs.ru>
Date:   Mon Oct 9 14:19:41 2017 +1100

    virtio-pci: Replace modern_as with direct access to modern_bar

    The modern bar is accessed now via yet another address space created ju=
st
    for that purpose and it does not really need FlatView and dispatch tree
    as it has a single memory region so it is just a waste of memory. Thing=
s
    get even worse when there are dozens or hundreds of virtio-pci devices =
-
    since these address spaces are global, changing any of them triggers
    rebuilding all address spaces.

    This replaces indirect accesses to the modern BAR with a simple lookup
    and direct calls to memory_region_dispatch_read/write.

    This is expected to save lots of memory at boot time after applying:
    [Qemu-devel] [PULL 00/32] Misc changes for 2017-09-22

    Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
    Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
    Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Thanks


