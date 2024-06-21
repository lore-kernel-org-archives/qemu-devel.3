Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B13A7C2BA1A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 09:39:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKaj1-0004EA-Qw; Fri, 21 Jun 2024 05:38:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sKaj0-0004E1-JO
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 05:38:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sKaiy-0000H4-Mf
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 05:38:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718962707;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fsuhgBMOBEdIih3tFq5SLhRjeRxsaHGzJhO82gVw7a0=;
 b=HEVpBsfr3ZeHoDA0bfgOmHuPFaoeqtP+63dEH3VF9RPiNNQg7fI6kjoSBZbao1vFgezivu
 OaU1stYkajzxzbNZKblkG6Ja0cfTzYuyOcvaQTemq4pP7BZ0k3Y3WVDx/MzJC4592r8yU3
 drArxiTcWiobuYa/gKuXSTfw+EM0aKw=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-oI64IMlONIazTpS9H6e_YA-1; Fri, 21 Jun 2024 05:38:25 -0400
X-MC-Unique: oI64IMlONIazTpS9H6e_YA-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-57d1f998b44so1859648a12.0
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 02:38:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718962704; x=1719567504;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fsuhgBMOBEdIih3tFq5SLhRjeRxsaHGzJhO82gVw7a0=;
 b=qkb85H6sni3D6tCrt2GuTe/pI7O182GAW5usoRQ0U+gOuaoYQVjV8q27zcllYnijSv
 4wfI+MR81+QUpKHnl9JCpVeRqnotLXwdR2mz3tszobjQNcJSTybHdbt7uUZ0OinvjC1I
 aOOTsRPK8ApT02dggJiDNnFkj7H4COdCtYta2R8C2eTWMV4a52zV7s1vyqQYUL067+iR
 u2a7lXwK7k3MjBdNCI1tMj3Y8IbGS+xDZfR5J8te8ghDiY+Z4SQeq+42+5AA0c07m037
 FrTuynu7zyoeYOAobP+rvxgPz4pgjm+xTVwHBOGk+RDIYHsv9WZOgdqXEKHAW4/wNh8O
 5D5w==
X-Gm-Message-State: AOJu0YyejXxm4fJDYIexXm2LNbN8h7QjXbWxJFuLmHbV7479A0Ij4GXt
 aE/ET85B0OA126VFnfW5tYFcwAt/L5w8l6cLW34m8t9V14sU34POkno2dcCbeL98PAK7CefXdC7
 qSjAnZjSLVRP4BQ1IGTGTVedQfgcjZAT4j42qSkr5KZi+NkGjRiblDfIGOohI
X-Received: by 2002:a05:6402:1caa:b0:57c:f82b:d761 with SMTP id
 4fb4d7f45d1cf-57cf82c1ff3mr6657833a12.17.1718962704032; 
 Fri, 21 Jun 2024 02:38:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqs0I0JSqHqayIDDOUervu9wZ4gH3LQK10ox4QiH9mFeHCsZGgJWdshyg3ajIeBh6Wqzi4fw==
X-Received: by 2002:a05:6402:1caa:b0:57c:f82b:d761 with SMTP id
 4fb4d7f45d1cf-57cf82c1ff3mr6657813a12.17.1718962703158; 
 Fri, 21 Jun 2024 02:38:23 -0700 (PDT)
Received: from redhat.com ([2.52.146.100]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57d3048b87esm703271a12.58.2024.06.21.02.38.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 02:38:22 -0700 (PDT)
Date: Fri, 21 Jun 2024 05:38:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Chen, Jiqian" <Jiqian.Chen@amd.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Huang, Ray" <Ray.Huang@amd.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH v11 1/2] virtio-pci: only reset pm state during resetting
Message-ID: <20240621052334-mutt-send-email-mst@kernel.org>
References: <20240606102205.114671-1-Jiqian.Chen@amd.com>
 <20240606102205.114671-2-Jiqian.Chen@amd.com>
 <BL1PR12MB58491ED83770E67AC98633D7E7C92@BL1PR12MB5849.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL1PR12MB58491ED83770E67AC98633D7E7C92@BL1PR12MB5849.namprd12.prod.outlook.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
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

On Fri, Jun 21, 2024 at 09:19:11AM +0000, Chen, Jiqian wrote:
> Hi MST,
> 
> On 2024/6/6 18:22, Jiqian Chen wrote:
> > Fix bug imported by 27ce0f3afc9dd ("fix Power Management Control Register for PCI Express virtio devices"
> > After this change, observe that QEMU may erroneously clear the power status of the device,
> > or may erroneously clear non writable registers, such as NO_SOFT_RESET, etc.
> > 
> > Only state of PM_CTRL is writable.
> > Only when flag VIRTIO_PCI_FLAG_INIT_PM is set, need to reset state.
> > 
> > Fixes: 27ce0f3afc9dd ("fix Power Management Control Register for PCI Express virtio devices"
> > 
> > Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
> > ---
> >  hw/virtio/virtio-pci.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> > index b1d02f4b3de0..1b63bcb3f15c 100644
> > --- a/hw/virtio/virtio-pci.c
> > +++ b/hw/virtio/virtio-pci.c
> > @@ -2300,10 +2300,16 @@ static void virtio_pci_bus_reset_hold(Object *obj, ResetType type)
> >      virtio_pci_reset(qdev);
> >  
> >      if (pci_is_express(dev)) {
> > +        VirtIOPCIProxy *proxy = VIRTIO_PCI(dev);
> > +
> >          pcie_cap_deverr_reset(dev);
> >          pcie_cap_lnkctl_reset(dev);
> >  
> > -        pci_set_word(dev->config + dev->exp.pm_cap + PCI_PM_CTRL, 0);
> > +        if (proxy->flags & VIRTIO_PCI_FLAG_INIT_PM) {
> > +            pci_word_test_and_clear_mask(
> > +                dev->config + dev->exp.pm_cap + PCI_PM_CTRL,
> > +                PCI_PM_CTRL_STATE_MASK);
> > +        }
> >      }
> >  }
> >  
> I noticed that you merged this patch into the staging before, but then reverted it. Do you still have any concerns?
> 
> -- 
> Best regards,
> Jiqian Chen.

Sorry I don't remember at this point. Normally it's because of
test failures but I then also notify the authors ... 
I will try to re-merge and see.

-- 
MST


