Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47D04C3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 11:09:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sObMv-00076c-9v; Tue, 02 Jul 2024 07:08:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sObMj-00073L-EK
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 07:08:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sObMf-0005sB-L1
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 07:08:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719918479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/kSRGVRDdr1le02ZG9KrHjf+TWvB9bDKFetcTryVnGs=;
 b=Oc7X8RXx8KEK+hVbMyowEgCh0fIeBOWL+BYcH20/Tf/WtMAUxr6DL1y+Ud9GlPZZceJK/6
 bvXw4a4s71WXLybmoBN47cCLoBYmj/NIbQUlzS+Tf4P/LH93MeMTpOg6mV8TqIp6AO5Ygy
 vz8+qkECpL1RDHz63wGr/+k5y1b+KLI=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-nGS5zcPbPui3-wl55Ok0mw-1; Tue, 02 Jul 2024 07:07:56 -0400
X-MC-Unique: nGS5zcPbPui3-wl55Ok0mw-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-52ce1688931so3796208e87.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 04:07:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719918475; x=1720523275;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/kSRGVRDdr1le02ZG9KrHjf+TWvB9bDKFetcTryVnGs=;
 b=xTIx5Tt4WQx0X9HkI0GymxLBX2oANer+Tqc5t1NfINP7Y24HVLM6Bx+eHpOGSPsv08
 5vPl4wOEJUJMZXjIVQ48vdkkAKy18pD+9EEJ0FuJ65fy1abqxD2W6/Z5gSrloyyQFDYd
 PFkqFhHpEmkd6RqHVPfexmg1ghdvaBstf4tD0b7Lz0N8epHtRGybVsGb4vJu+LEY/FWB
 UdcaFyfsZjNHlPUdz3OQvQMkjaYNRPRqNoNeNF47haNtq8mc/qCioYOmi+Lb+CZZ8had
 rvlp6+0LULDU0mCGXi46fdnjkzaSGmviB+pPit20SaCg5m+Byz97dXqSWKTYYVP0FyHK
 +mBg==
X-Gm-Message-State: AOJu0YyExjrtGGNMUdNWSRQ6XtJtE0rwYqc4ra47xKIq1qB1DTDd3Kz/
 +5lGdAQDTms+YbFVAWmBs+/N0lxUHrHVhdONOCaXw/XUuD8F4OCr2G+kDIDWzfizdt7ND2jMbpQ
 AEabNtpkeIHEVWhLF9T77a2dCPA4lNm+ZuOyvmFOF9LMDmQQP5d1S
X-Received: by 2002:a05:6512:15a3:b0:52c:e326:f4cf with SMTP id
 2adb3069b0e04-52e82643b81mr6554391e87.3.1719918475282; 
 Tue, 02 Jul 2024 04:07:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1zoA2OCel2pr7DS9/8ql46EfIxVDhjq2ALucDKkPjNpTDOPavC6yNld17rZYSHTF1gWvlkQ==
X-Received: by 2002:a05:6512:15a3:b0:52c:e326:f4cf with SMTP id
 2adb3069b0e04-52e82643b81mr6554332e87.3.1719918473561; 
 Tue, 02 Jul 2024 04:07:53 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:55d:614d:9fb:6fdd:72a4:f3d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b0c0f26sm191311055e9.39.2024.07.02.04.07.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 04:07:53 -0700 (PDT)
Date: Tue, 2 Jul 2024 07:07:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Chen, Jiqian" <Jiqian.Chen@amd.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Huang, Ray" <Ray.Huang@amd.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH v11 2/2] virtio-pci: implement No_Soft_Reset bit
Message-ID: <20240702070728-mutt-send-email-mst@kernel.org>
References: <20240606102205.114671-1-Jiqian.Chen@amd.com>
 <20240606102205.114671-3-Jiqian.Chen@amd.com>
 <BL1PR12MB5849BFAF241DE61E6F166861E7C92@BL1PR12MB5849.namprd12.prod.outlook.com>
 <BL1PR12MB5849B84143E04A429E23AB81E7DC2@BL1PR12MB5849.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL1PR12MB5849B84143E04A429E23AB81E7DC2@BL1PR12MB5849.namprd12.prod.outlook.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

On Tue, Jul 02, 2024 at 02:36:14AM +0000, Chen, Jiqian wrote:
> On 2024/6/21 17:20, Chen, Jiqian wrote:
> > Hi MST,
> > 
> > On 2024/6/6 18:22, Jiqian Chen wrote:
> >> In current code, when guest does S3, virtio-gpu are reset due to the
> >> bit No_Soft_Reset is not set. After resetting, the display resources
> >> of virtio-gpu are destroyed, then the display can't come back and only
> >> show blank after resuming.
> >>
> >> Implement No_Soft_Reset bit of PCI_PM_CTRL register, then guest can check
> >> this bit, if this bit is set, the devices resetting will not be done, and
> >> then the display can work after resuming.
> >>
> >> No_Soft_Reset bit is implemented for all virtio devices, and was tested
> >> only on virtio-gpu device. Set it false by default for safety.
> >>
> >> Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
> >> ---
> >>  hw/core/machine.c              |  1 +
> >>  hw/virtio/virtio-pci.c         | 29 +++++++++++++++++++++++++++++
> >>  include/hw/virtio/virtio-pci.h |  5 +++++
> >>  3 files changed, 35 insertions(+)
> >>
> >> diff --git a/hw/core/machine.c b/hw/core/machine.c
> >> index 77a356f232f5..b6af94edcd0a 100644
> >> --- a/hw/core/machine.c
> >> +++ b/hw/core/machine.c
> >> @@ -36,6 +36,7 @@
> >>  GlobalProperty hw_compat_9_0[] = {
> >>      {"arm-cpu", "backcompat-cntfrq", "true" },
> >>      {"vfio-pci", "skip-vsc-check", "false" },
> >> +    { "virtio-pci", "x-pcie-pm-no-soft-reset", "off" },
> >>  };
> >>  const size_t hw_compat_9_0_len = G_N_ELEMENTS(hw_compat_9_0);
> >>  
> >> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> >> index 1b63bcb3f15c..c881f853253c 100644
> >> --- a/hw/virtio/virtio-pci.c
> >> +++ b/hw/virtio/virtio-pci.c
> >> @@ -2230,6 +2230,11 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
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
> >> @@ -2292,11 +2297,33 @@ static void virtio_pci_reset(DeviceState *qdev)
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
> >> +    return (pmcsr & PCI_PM_CTRL_NO_SOFT_RESET) &&
> >> +           (pmcsr & PCI_PM_CTRL_STATE_MASK) == 3;
> >> +}
> >> +
> >>  static void virtio_pci_bus_reset_hold(Object *obj, ResetType type)
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
> >> @@ -2336,6 +2363,8 @@ static Property virtio_pci_properties[] = {
> >>                      VIRTIO_PCI_FLAG_INIT_LNKCTL_BIT, true),
> >>      DEFINE_PROP_BIT("x-pcie-pm-init", VirtIOPCIProxy, flags,
> >>                      VIRTIO_PCI_FLAG_INIT_PM_BIT, true),
> >> +    DEFINE_PROP_BIT("x-pcie-pm-no-soft-reset", VirtIOPCIProxy, flags,
> >> +                    VIRTIO_PCI_FLAG_PM_NO_SOFT_RESET_BIT, false),
> >>      DEFINE_PROP_BIT("x-pcie-flr-init", VirtIOPCIProxy, flags,
> >>                      VIRTIO_PCI_FLAG_INIT_FLR_BIT, true),
> >>      DEFINE_PROP_BIT("aer", VirtIOPCIProxy, flags,
> >> diff --git a/include/hw/virtio/virtio-pci.h b/include/hw/virtio/virtio-pci.h
> >> index 59d88018c16a..9e67ba38c748 100644
> >> --- a/include/hw/virtio/virtio-pci.h
> >> +++ b/include/hw/virtio/virtio-pci.h
> >> @@ -43,6 +43,7 @@ enum {
> >>      VIRTIO_PCI_FLAG_INIT_FLR_BIT,
> >>      VIRTIO_PCI_FLAG_AER_BIT,
> >>      VIRTIO_PCI_FLAG_ATS_PAGE_ALIGNED_BIT,
> >> +    VIRTIO_PCI_FLAG_PM_NO_SOFT_RESET_BIT,
> >>  };
> >>  
> >>  /* Need to activate work-arounds for buggy guests at vmstate load. */
> >> @@ -79,6 +80,10 @@ enum {
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
> > I have added compatibility for old machine.
> > Do you have any other concerns about this patch?
> > 
> If you don't have other concerns. May I get your Review-by?

I'm testing this, and if ok will include it in the pull request.

> -- 
> Best regards,
> Jiqian Chen.


