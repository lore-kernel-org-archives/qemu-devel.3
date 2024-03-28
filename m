Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3CD5C54E67
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 09:57:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpmV7-00014b-NY; Thu, 28 Mar 2024 05:56:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rpmV6-00014S-Np
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 05:56:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rpmV4-0002fS-U7
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 05:56:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711619804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ML+vFvQNzjpxSaDKWHVNuAzhEKxA/p+Fdfk3ojquPwU=;
 b=ajR58SYtvV46DqFsXaOr7LtYyBbBArB8510J8hKB2QWGJSgnkRi2iYrJSEaA5yetio9KIo
 y+KaGil3iyhQL3ksNgcvgrFVdYVaMtHc7rW1M+uz6mXaYWfvVE9Et+ikkhnSCOWl71VkGp
 HvJf22Bb6I0bO6ppgDI2VAo9v1KEq9o=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-3rhFdjz-OqitrPJd_gdVBw-1; Thu, 28 Mar 2024 05:56:42 -0400
X-MC-Unique: 3rhFdjz-OqitrPJd_gdVBw-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a474bf2839dso15740166b.0
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 02:56:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711619800; x=1712224600;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ML+vFvQNzjpxSaDKWHVNuAzhEKxA/p+Fdfk3ojquPwU=;
 b=DTIWN3dPVpjjvvSZl54cWZhVcfXujaQN3ZMAtsEdvOzbcnoL7YizjViUDCEioOasX3
 kOAhU0p6Esti+K/X6Tm1ur7bvHGFn6FdjeIDZ8cW2XfjDLnHmbfqm5aB9wzJ6keBy59d
 tzfVXVlvRIYs6qG5tmligoOWgK5Zy9b0sQev48JZmzd8UZuOBY9PCwip921zWBf0u/Pg
 3a+r7iS8rlWa78Lljb+EDoD+noTfEKl8+iUnixQYGo28ZMRQbZclRbIvJa33PUm3nD4a
 gAAMLXkDgKjEQSkWYfOuZDKXN3zw9MglWhcGeZttwIVIpmY/jIzQTbeBUM3OBQJIFg5b
 SWZA==
X-Gm-Message-State: AOJu0YwRl54n0A5L61cidOiW/in78qOhYlwsOj17ESqvrIQAq0xc4jbw
 OjJY2h6WImBi9dodITcULZ6kCOXl8wEtJ4wqg6PBh85h2pamTTMF6NeGbWrzzMzxrV8DNV64b2J
 SvLls4+/QaglLZEAciG+YJ4Qxe7SHOEwCZrtvnpuApqStxw+8T0dBJL9MQqAb
X-Received: by 2002:a50:99d3:0:b0:568:3362:ccd1 with SMTP id
 n19-20020a5099d3000000b005683362ccd1mr2202403edb.1.1711619799933; 
 Thu, 28 Mar 2024 02:56:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSoX3chD5lwHZONgvOgP2EedF9Cyh052p95JnKy7aUVNRNNzpai4FDLssvi/65biqvgXxVjw==
X-Received: by 2002:a50:99d3:0:b0:568:3362:ccd1 with SMTP id
 n19-20020a5099d3000000b005683362ccd1mr2202381edb.1.1711619799522; 
 Thu, 28 Mar 2024 02:56:39 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f0:5969:7af8:be53:dc56:3ccc])
 by smtp.gmail.com with ESMTPSA id
 n17-20020a05640205d100b0056c55252b1csm306321edx.41.2024.03.28.02.56.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Mar 2024 02:56:38 -0700 (PDT)
Date: Thu, 28 Mar 2024 05:56:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Chen, Jiqian" <Jiqian.Chen@amd.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Huang, Ray" <Ray.Huang@amd.com>
Subject: Re: [RFC QEMU PATCH v7 1/1] virtio-pci: implement No_Soft_Reset bit
Message-ID: <20240328055609-mutt-send-email-mst@kernel.org>
References: <20240325070724.574508-1-Jiqian.Chen@amd.com>
 <20240325070724.574508-2-Jiqian.Chen@amd.com>
 <20240328034641-mutt-send-email-mst@kernel.org>
 <BL1PR12MB5849CC32915B97625156EAF7E73B2@BL1PR12MB5849.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL1PR12MB5849CC32915B97625156EAF7E73B2@BL1PR12MB5849.namprd12.prod.outlook.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Mar 28, 2024 at 09:02:28AM +0000, Chen, Jiqian wrote:
> 
> On 2024/3/28 16:11, Michael S. Tsirkin wrote:
> > 
> >> +        VirtIOPCIProxy *proxy = VIRTIO_PCI(dev);
> >> +
> >>          pcie_cap_deverr_reset(dev);
> >>          pcie_cap_lnkctl_reset(dev);
> >>  
> >> -        pci_set_word(dev->config + dev->exp.pm_cap + PCI_PM_CTRL, 0);
> >> +        if (proxy->flags & VIRTIO_PCI_FLAG_PM_NO_SOFT_RESET) {
> >> +            val |= PCI_PM_CTRL_NO_SOFT_RESET;
> >> +        }
> >> +        pci_set_word(dev->config + dev->exp.pm_cap + PCI_PM_CTRL, val);
> > 
> > 
> > There is no need to do it like this - only state is writeable
> > anyway. So simply
> > 	pci_word_test_and_clear_mask(dev->config + dev->exp.pm_cap + PCI_PM_CTRL, PCI_PM_CTRL_STATE_MASK)
> > 
> > 
> > maybe we should actually check here:
> >        if (proxy->flags & VIRTIO_PCI_FLAG_INIT_PM)
> > there's a chance commit 27ce0f3afc9 broke things for old machines
> > and we never noticed. If so that should be a separate bugfix patch though.
> Make sense. It is actually a bug imported by 27ce0f3afc9.
> According to your comments, I think here should be a separate patch, like:
>    if (pci_is_express(dev)) {
>         VirtIOPCIProxy *proxy = VIRTIO_PCI(dev);
> 
>         pcie_cap_deverr_reset(dev);
>         pcie_cap_lnkctl_reset(dev);
> 
>         if (proxy->flags & VIRTIO_PCI_FLAG_INIT_PM) {
>             pci_word_test_and_clear_mask(
>                 dev->config + dev->exp.pm_cap + PCI_PM_CTRL,
>                 PCI_PM_CTRL_STATE_MASK);
>         }
>     }
> Right?

Works for me.

> > 
> > 
> 
> -- 
> Best regards,
> Jiqian Chen.


