Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E73FC54E64
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 12:37:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpozv-0006ew-Tv; Thu, 28 Mar 2024 08:36:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rpozs-0006e9-Mc
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 08:36:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rpozp-0008Oe-1z
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 08:36:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711629399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=12sRaVkT+NSQsmMhtp0Gxqf3Fb/eth14Y5kVcZtF8TY=;
 b=SEqnESwvYPfbObP0vpOY6jGSzWu827K7l85vpAx9NaCezJNf4hcAJLB+2qAviTlsUlO3Yi
 5VUeyjfGXq5Q9KS54zfhuIVhTArhAfuUuHhOYXjGxHvteXwryEpvkNt83rplMe7i7qwBxg
 ACyM1zDMF+Izs327oQV6icn3Q7ZwOSE=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-D24AbSAsOdmKfqubM1Pz7Q-1; Thu, 28 Mar 2024 08:36:37 -0400
X-MC-Unique: D24AbSAsOdmKfqubM1Pz7Q-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-513d125058eso871401e87.2
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 05:36:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711629396; x=1712234196;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=12sRaVkT+NSQsmMhtp0Gxqf3Fb/eth14Y5kVcZtF8TY=;
 b=fpok4yJhujuLPB58xZGq3skNU4dAI0KpkWw93XQ9h5tfyEXy02iuRTjJKlS7GqofjN
 ayMOdX+V7OrL1rlksZ43kWRKuZsaubd+TlMNl1VndYA0GAXRCYY7oSJayjJpNaGcJXSm
 GfOf1Q9nDcKP2r5ImKIZvRtmrpPMdRXsiTOWABdbeuoRxSJVhgkYj7M805fo7sdjyFrG
 gJWvy7Y+J/I3b/I5k9+ur4QFY9zy421HRhZCxlRoDKCBJ8pv/clKzZUT9aiMWA+Vj5bg
 xZPWiEdBxFjV9pwfly3aMQUhK7i7hnqeOgupjAr9cYH+WbuX/bS4155ab2CG4eMwcNf7
 ZRMw==
X-Gm-Message-State: AOJu0YzER87YpG5uYyRCdi7G2USPcqdooQYbvkzvHjp2HhwjWTNxl00I
 yNUA7RK1ayGN8+7acR4KP8b/v6rk4WxpzC3Cb82/bX6+T5ToUtaEtkaAh3oabXtImojOkdOrHoY
 HkmtiwRoTyDjheZkE5ysAXqNQSRE90Y+y8BEV+UtNZtL7Leuu+mh1
X-Received: by 2002:ac2:4c9a:0:b0:515:9d9e:7339 with SMTP id
 d26-20020ac24c9a000000b005159d9e7339mr2186755lfl.20.1711629395753; 
 Thu, 28 Mar 2024 05:36:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwPaPpdJAshUrBtWQrrMao+9jnQu68dafH2WmGUuxIWLDD0f1NvIUSC0/djrlZiVUyIYcc3A==
X-Received: by 2002:ac2:4c9a:0:b0:515:9d9e:7339 with SMTP id
 d26-20020ac24c9a000000b005159d9e7339mr2186724lfl.20.1711629395056; 
 Thu, 28 Mar 2024 05:36:35 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f0:5969:7af8:be53:dc56:3ccc])
 by smtp.gmail.com with ESMTPSA id
 f25-20020a170906561900b00a461b1e814asm699712ejq.130.2024.03.28.05.36.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Mar 2024 05:36:34 -0700 (PDT)
Date: Thu, 28 Mar 2024 08:36:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Chen, Jiqian" <Jiqian.Chen@amd.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Huang, Ray" <Ray.Huang@amd.com>
Subject: Re: [RFC QEMU PATCH v8 2/2] virtio-pci: implement No_Soft_Reset bit
Message-ID: <20240328083503-mutt-send-email-mst@kernel.org>
References: <20240328103903.408290-1-Jiqian.Chen@amd.com>
 <20240328103903.408290-3-Jiqian.Chen@amd.com>
 <20240328065606-mutt-send-email-mst@kernel.org>
 <BL1PR12MB5849ACCD6602EAB88BE2FED9E73B2@BL1PR12MB5849.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL1PR12MB5849ACCD6602EAB88BE2FED9E73B2@BL1PR12MB5849.namprd12.prod.outlook.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.08,
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

On Thu, Mar 28, 2024 at 11:08:58AM +0000, Chen, Jiqian wrote:
> On 2024/3/28 18:57, Michael S. Tsirkin wrote:
> > On Thu, Mar 28, 2024 at 06:39:03PM +0800, Jiqian Chen wrote:
> >> In current code, when guest does S3, virtio devices are reset due to
> >> the bit No_Soft_Reset is not set. After resetting, the display resources
> >> of virtio-gpu are destroyed, then the display can't come back and only
> >> show blank after resuming.
> >>
> >> Implement No_Soft_Reset bit of PCI_PM_CTRL register, then guest can check
> >> this bit, if this bit is set, the devices resetting will not be done, and
> >> then the display can work after resuming.
> >>
> >> Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
> >> ---
> >>  hw/virtio/virtio-pci.c         | 29 +++++++++++++++++++++++++++++
> >>  include/hw/virtio/virtio-pci.h |  5 +++++
> >>  2 files changed, 34 insertions(+)
> >>
> >> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> >> index 05dd03758d9f..8d9fab855c7d 100644
> >> --- a/hw/virtio/virtio-pci.c
> >> +++ b/hw/virtio/virtio-pci.c
> >> @@ -2378,6 +2378,11 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
> >>              pcie_cap_lnkctl_init(pci_dev);
> >>          }
> >>  
> >> +        if (proxy->flags & VIRTIO_PCI_FLAG_PM_NO_SOFT_RESET) {
> >> +            pci_set_word(pci_dev->config + pos + PCI_PM_CTRL,
> >> +                         PCI_PM_CTRL_NO_SOFT_RESET);
> >> +        }
> >> +
> >>          if (proxy->flags & VIRTIO_PCI_FLAG_INIT_PM) {
> >>              /* Init Power Management Control Register */
> >>              pci_set_word(pci_dev->wmask + pos + PCI_PM_CTRL,
> >> @@ -2440,11 +2445,33 @@ static void virtio_pci_reset(DeviceState *qdev)
> >>      }
> >>  }
> >>  
> >> +static bool virtio_pci_no_soft_reset(PCIDevice *dev)
> >> +{
> >> +    uint16_t pmcsr;
> >> +
> >> +    if (!pci_is_express(dev) || !dev->exp.pm_cap) {
> >> +        return false;
> >> +    }
> >> +
> >> +    pmcsr = pci_get_word(dev->config + dev->exp.pm_cap + PCI_PM_CTRL);
> >> +
> >> +    /*
> >> +     * When No_Soft_Reset bit is set and the device
> >> +     * is in D3hot state, don't reset device
> >> +     */
> >> +    return ((pmcsr & PCI_PM_CTRL_NO_SOFT_RESET) &&
> >> +            (pmcsr & PCI_PM_CTRL_STATE_MASK) == 3);
> > 
> > 
> > No need for () around return value.
> Ok, will delete in next version.
> 
> > 
> >> +}
> >> +
> >>  static void virtio_pci_bus_reset_hold(Object *obj)
> >>  {
> >>      PCIDevice *dev = PCI_DEVICE(obj);
> >>      DeviceState *qdev = DEVICE(obj);
> >>  
> >> +    if (virtio_pci_no_soft_reset(dev)) {
> >> +        return;
> >> +    }
> >> +
> >>      virtio_pci_reset(qdev);
> >>  
> >>      if (pci_is_express(dev)) {
> >> @@ -2484,6 +2511,8 @@ static Property virtio_pci_properties[] = {
> >>                      VIRTIO_PCI_FLAG_INIT_LNKCTL_BIT, true),
> >>      DEFINE_PROP_BIT("x-pcie-pm-init", VirtIOPCIProxy, flags,
> >>                      VIRTIO_PCI_FLAG_INIT_PM_BIT, true),
> >> +    DEFINE_PROP_BIT("x-pcie-pm-no-soft-reset", VirtIOPCIProxy, flags,
> >> +                    VIRTIO_PCI_FLAG_PM_NO_SOFT_RESET_BIT, false),
> >>      DEFINE_PROP_BIT("x-pcie-flr-init", VirtIOPCIProxy, flags,
> >>                      VIRTIO_PCI_FLAG_INIT_FLR_BIT, true),
> >>      DEFINE_PROP_BIT("aer", VirtIOPCIProxy, flags,
> > 
> > I am a bit confused about this part.
> > Do you want to make this software controllable?
> Yes, because even the real hardware, this bit is not always set.

So which virtio devices should and which should not set this bit?

> > Or should this be set to true by default and then
> > changed to false for old machine types?
> How can I do so?
> Do you mean set this to true by default, and if old machine types don't need this bit, they can pass false config to qemu when running qemu?

No, you would use compat machinery. See how is x-pcie-flr-init handled.


> > 
> > 
> >> diff --git a/include/hw/virtio/virtio-pci.h b/include/hw/virtio/virtio-pci.h
> >> index 4d57a9c75130..c758eb738234 100644
> >> --- a/include/hw/virtio/virtio-pci.h
> >> +++ b/include/hw/virtio/virtio-pci.h
> >> @@ -44,6 +44,7 @@ enum {
> >>      VIRTIO_PCI_FLAG_AER_BIT,
> >>      VIRTIO_PCI_FLAG_ATS_PAGE_ALIGNED_BIT,
> >>      VIRTIO_PCI_FLAG_VDPA_BIT,
> >> +    VIRTIO_PCI_FLAG_PM_NO_SOFT_RESET_BIT,
> >>  };
> >>  
> >>  /* Need to activate work-arounds for buggy guests at vmstate load. */
> >> @@ -80,6 +81,10 @@ enum {
> >>  /* Init Power Management */
> >>  #define VIRTIO_PCI_FLAG_INIT_PM (1 << VIRTIO_PCI_FLAG_INIT_PM_BIT)
> >>  
> >> +/* Init The No_Soft_Reset bit of Power Management */
> >> +#define VIRTIO_PCI_FLAG_PM_NO_SOFT_RESET \
> >> +  (1 << VIRTIO_PCI_FLAG_PM_NO_SOFT_RESET_BIT)
> >> +
> >>  /* Init Function Level Reset capability */
> >>  #define VIRTIO_PCI_FLAG_INIT_FLR (1 << VIRTIO_PCI_FLAG_INIT_FLR_BIT)
> >>  
> >> -- 
> >> 2.34.1
> > 
> 
> -- 
> Best regards,
> Jiqian Chen.


