Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA8D2C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 10:30:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seuDK-0002aD-JU; Fri, 16 Aug 2024 06:29:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1seuDI-0002Y3-AE
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 06:29:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1seuDG-00051S-Nw
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 06:29:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723804181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9MnMphnsUo5fZBNhUymgzNdYcmv2xCiRrOwDkMc5yho=;
 b=ARP9KvmWFxdHCAY6eZT56MDAX3EElz2yOGUSCcgxsMab8H2TGg1qlH9y6pJbVQPEkok9bo
 2+quUXJYDnWrw3qrWsHabIUK6A2ogqKlvVllOCAWAmfECB9UDj7I4p10Ees+2TWL5oxsYc
 2yo3xTykhARhlf8+NkMv3lxzDYO2XcQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-Y3V6nA02NMafgeictI9bpw-1; Fri, 16 Aug 2024 06:29:39 -0400
X-MC-Unique: Y3V6nA02NMafgeictI9bpw-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5a2d4fb1e73so1511382a12.2
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 03:29:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723804178; x=1724408978;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9MnMphnsUo5fZBNhUymgzNdYcmv2xCiRrOwDkMc5yho=;
 b=C85r/QUFxiIB0TsSE61nIZpH1+UWTIqg2+GBT68bo+pWDSlH3WQtEYvc5xlHfJRTne
 ejYOOOPkc3XqlIxrJtCsF8h475N4JlU81edORau7kPl28yFZoGYUquEoN8cyLvGp0hJC
 9uPbJyw7LYF+G9aMZzehD+qKJAD0m0a/U73R2498qrBvZyzC7J9HT7MODY1fJCN35vZz
 y16AT5Phcf1Dd1nto5og4nxaAJaHzR62v12JhEsZAD+CQOL7xLUTNhJfgHUXW3AmrpLX
 qQxxrqIWudNIKZWD8qBMtNgDJiKw/ZvJ3QI09qBANzHDabtVwoxAO7dn04t2V7AI6TEB
 vm8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXC6kRwQRh1ls0PxsSsNFfg0QmtZUiRwgkZ8tb5emvgQB1ExHGavSWJSjL4Jt/IEzkDbeX1grRTEkrEhnIXmjOtFr4ZJ+8=
X-Gm-Message-State: AOJu0YyQTXKdh/pdExzSrW2A4DLA2vpAgZlhE33N7u7LE/94E8vnSAPz
 Sbpa7eK9JqzdA2x9wO2UHFEw8Fc2j1Ewd9X5x8hX4UTruqhOv6XfQHVByhNZOd5An3LTRdJh23f
 RN4tmZg3vdzWRftw1rDqp8JwdaMpaYppeo06mAM1qqFkozF6ozIQl
X-Received: by 2002:a05:6402:234d:b0:5be:9c84:a01 with SMTP id
 4fb4d7f45d1cf-5beca76d270mr1894794a12.29.1723804178654; 
 Fri, 16 Aug 2024 03:29:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhp1L7S4lXnr1obbcfXsEPZl5+N1CoUUtsYnQkyg8mrAXFKI+fc/e1wTiHWpcPoZOXU7TPCw==
X-Received: by 2002:a05:6402:234d:b0:5be:9c84:a01 with SMTP id
 4fb4d7f45d1cf-5beca76d270mr1894747a12.29.1723804177805; 
 Fri, 16 Aug 2024 03:29:37 -0700 (PDT)
Received: from redhat.com ([2a02:14f:17d:3378:6322:e9ee:713:b9ed])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5bebbde4b37sm2074074a12.34.2024.08.16.03.29.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 03:29:37 -0700 (PDT)
Date: Fri, 16 Aug 2024 06:29:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gao Shiyuan <gaoshiyuan@baidu.com>
Cc: Tiwei Bie <tiwei.bie@intel.com>, zuoboqun@baidu.com,
 qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 1/1] virtio-pci: return RAM device MR when set host
 notifier success
Message-ID: <20240816061647-mutt-send-email-mst@kernel.org>
References: <20240812122027.65600-1-gaoshiyuan@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812122027.65600-1-gaoshiyuan@baidu.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

On Mon, Aug 12, 2024 at 08:20:27PM +0800, Gao Shiyuan wrote:
> When vhost-user backend register memory region based host notifiers,
> we should return RAM device MR of notify region MR's subregion in
> virtio_address_space_lookup.
> 
> In seabios, it will use virtio PCI Configration Access Capability
> access notify region when assign notify region above 4GB. This will
> exit to QEMU and invoke virtio_address_space_write. When vhost-user
> backend register memory region based host notifiers, return RAM device
> MR instead of notify region MR is suitable.


I can't really parse this.

> Co-developed-by: Zuo Boqun <zuoboqun@baidu.com>
> Signed-off-by: Gao Shiyuan <gaoshiyuan@baidu.com>
> Signed-off-by: Zuo Boqun <zuoboqun@baidu.com>

CC Jason

> ---
>  hw/virtio/virtio-pci.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index 9534730bba..167ac9718a 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -610,13 +610,22 @@ static MemoryRegion *virtio_address_space_lookup(VirtIOPCIProxy *proxy,
>  {
>      int i;
>      VirtIOPCIRegion *reg;
> +    MemoryRegion *mr, *submr;
>  
>      for (i = 0; i < ARRAY_SIZE(proxy->regs); ++i) {
>          reg = &proxy->regs[i];
>          if (*off >= reg->offset &&
>              *off + len <= reg->offset + reg->size) {
>              *off -= reg->offset;
> -            return &reg->mr;
> +            mr = &reg->mr;
> +            QTAILQ_FOREACH(submr, &mr->subregions, subregions_link) {
> +                if (*off >= submr->addr &&
> +                    *off + len < submr->addr + submr->size) {
> +                    *off -= submr->addr;
> +                    return submr;
> +                }
> +            }
> +            return mr;
>          }
>      }

Poking at internals of MR like this is not nice.
Doesn't memory_region_find work for this?



>  
> -- 
> 2.39.3 (Apple Git-146)


