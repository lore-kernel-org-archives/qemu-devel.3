Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67DC4C54E64
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 10:58:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpnSW-0004NY-2o; Thu, 28 Mar 2024 06:58:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rpnSR-0004KV-EN
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 06:58:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rpnSP-0006Xq-Ji
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 06:58:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711623484;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KYmc/I9rlrQdCrDUUtljH4x20yOweqh6U2gRnxVZuYE=;
 b=iTGBokDGkWRwPTDBhjVnMs0voVMmJybhjfJLIivCcToVzPFaxXc+fj0lT079u46oCopnSY
 jLLHLfsI/Yl49Ut80cl0CGU62lVQeVXLuhR/edLYTjaBAF0FpqFhtUO5A+HnbhKJgVb+av
 EolrqYTUkXlSBVVm1LV/sr+uTE4vZ9Q=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-XyIWfNWYMfaZCmvzz3D0fg-1; Thu, 28 Mar 2024 06:58:03 -0400
X-MC-Unique: XyIWfNWYMfaZCmvzz3D0fg-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a4e220b135eso33976666b.3
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 03:58:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711623480; x=1712228280;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KYmc/I9rlrQdCrDUUtljH4x20yOweqh6U2gRnxVZuYE=;
 b=V0nIsqKVTngAthzStbDsVNJpULNVvg/myvmjF0dEDEpLMKvWHKJnH3T+82EcTMoHof
 MzUX2e4VFlefxIFVz/TlRdMgN/+uB6pCTBsAqqpaVPLIkivpdRPGU3Bbde8mF/gOPOfK
 6HjPh2xE3Iih0mrbF6coLF9Xax2f5ocPF5KDdTRzQWvqtYwtdngUl5apOiDEIem8cH7O
 VtWSAYxmdlFTZXtnM4RuKfV/or0jLhmgccRebAWb9ZN1Q9bB1T7vYAZQVAxgyyPMzsfj
 HWjnp6422w1+mu1Et7zL01szezwin7ZpPSdznzQ2E3u0mlmmre76ksqusmxehqxJpiUW
 oQ9g==
X-Gm-Message-State: AOJu0YxmvzyHq+ciXncJ23dgtjxYp1+gevLnBvd2Z8CvQuEf2SxKH6Ef
 Nyag5Pa1Qi/PCRmN8ZT6ceslxl/gJ3zbqIZpMRN2fErljtEOTfEpb71lJTm+1fUfzoqbahAKk2r
 QCWFU0y4ZsvW8C5gOD5OYvVkaXHgXxRf4K9Ukn0NtJQlQOxAwsLjb
X-Received: by 2002:a17:906:a008:b0:a46:1426:f7c with SMTP id
 p8-20020a170906a00800b00a4614260f7cmr1399808ejy.63.1711623480501; 
 Thu, 28 Mar 2024 03:58:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNB2ji6KIcZXMY3ukwPyiZUmLmeS0xTQ2vvDznUeLVFdIiGpp7yUDYQuiTFNlqPpAcAL9H7w==
X-Received: by 2002:a17:906:a008:b0:a46:1426:f7c with SMTP id
 p8-20020a170906a00800b00a4614260f7cmr1399792ejy.63.1711623479904; 
 Thu, 28 Mar 2024 03:57:59 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f0:5969:7af8:be53:dc56:3ccc])
 by smtp.gmail.com with ESMTPSA id
 b22-20020a170906d11600b00a46f95f5849sm610624ejz.106.2024.03.28.03.57.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Mar 2024 03:57:59 -0700 (PDT)
Date: Thu, 28 Mar 2024 06:57:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiqian Chen <Jiqian.Chen@amd.com>
Cc: qemu-devel@nongnu.org, Huang Rui <Ray.Huang@amd.com>
Subject: Re: [RFC QEMU PATCH v8 2/2] virtio-pci: implement No_Soft_Reset bit
Message-ID: <20240328065606-mutt-send-email-mst@kernel.org>
References: <20240328103903.408290-1-Jiqian.Chen@amd.com>
 <20240328103903.408290-3-Jiqian.Chen@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328103903.408290-3-Jiqian.Chen@amd.com>
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

On Thu, Mar 28, 2024 at 06:39:03PM +0800, Jiqian Chen wrote:
> In current code, when guest does S3, virtio devices are reset due to
> the bit No_Soft_Reset is not set. After resetting, the display resources
> of virtio-gpu are destroyed, then the display can't come back and only
> show blank after resuming.
> 
> Implement No_Soft_Reset bit of PCI_PM_CTRL register, then guest can check
> this bit, if this bit is set, the devices resetting will not be done, and
> then the display can work after resuming.
> 
> Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
> ---
>  hw/virtio/virtio-pci.c         | 29 +++++++++++++++++++++++++++++
>  include/hw/virtio/virtio-pci.h |  5 +++++
>  2 files changed, 34 insertions(+)
> 
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index 05dd03758d9f..8d9fab855c7d 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -2378,6 +2378,11 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
>              pcie_cap_lnkctl_init(pci_dev);
>          }
>  
> +        if (proxy->flags & VIRTIO_PCI_FLAG_PM_NO_SOFT_RESET) {
> +            pci_set_word(pci_dev->config + pos + PCI_PM_CTRL,
> +                         PCI_PM_CTRL_NO_SOFT_RESET);
> +        }
> +
>          if (proxy->flags & VIRTIO_PCI_FLAG_INIT_PM) {
>              /* Init Power Management Control Register */
>              pci_set_word(pci_dev->wmask + pos + PCI_PM_CTRL,
> @@ -2440,11 +2445,33 @@ static void virtio_pci_reset(DeviceState *qdev)
>      }
>  }
>  
> +static bool virtio_pci_no_soft_reset(PCIDevice *dev)
> +{
> +    uint16_t pmcsr;
> +
> +    if (!pci_is_express(dev) || !dev->exp.pm_cap) {
> +        return false;
> +    }
> +
> +    pmcsr = pci_get_word(dev->config + dev->exp.pm_cap + PCI_PM_CTRL);
> +
> +    /*
> +     * When No_Soft_Reset bit is set and the device
> +     * is in D3hot state, don't reset device
> +     */
> +    return ((pmcsr & PCI_PM_CTRL_NO_SOFT_RESET) &&
> +            (pmcsr & PCI_PM_CTRL_STATE_MASK) == 3);


No need for () around return value.

> +}
> +
>  static void virtio_pci_bus_reset_hold(Object *obj)
>  {
>      PCIDevice *dev = PCI_DEVICE(obj);
>      DeviceState *qdev = DEVICE(obj);
>  
> +    if (virtio_pci_no_soft_reset(dev)) {
> +        return;
> +    }
> +
>      virtio_pci_reset(qdev);
>  
>      if (pci_is_express(dev)) {
> @@ -2484,6 +2511,8 @@ static Property virtio_pci_properties[] = {
>                      VIRTIO_PCI_FLAG_INIT_LNKCTL_BIT, true),
>      DEFINE_PROP_BIT("x-pcie-pm-init", VirtIOPCIProxy, flags,
>                      VIRTIO_PCI_FLAG_INIT_PM_BIT, true),
> +    DEFINE_PROP_BIT("x-pcie-pm-no-soft-reset", VirtIOPCIProxy, flags,
> +                    VIRTIO_PCI_FLAG_PM_NO_SOFT_RESET_BIT, false),
>      DEFINE_PROP_BIT("x-pcie-flr-init", VirtIOPCIProxy, flags,
>                      VIRTIO_PCI_FLAG_INIT_FLR_BIT, true),
>      DEFINE_PROP_BIT("aer", VirtIOPCIProxy, flags,

I am a bit confused about this part.
Do you want to make this software controllable?
Or should this be set to true by default and then
changed to false for old machine types?


> diff --git a/include/hw/virtio/virtio-pci.h b/include/hw/virtio/virtio-pci.h
> index 4d57a9c75130..c758eb738234 100644
> --- a/include/hw/virtio/virtio-pci.h
> +++ b/include/hw/virtio/virtio-pci.h
> @@ -44,6 +44,7 @@ enum {
>      VIRTIO_PCI_FLAG_AER_BIT,
>      VIRTIO_PCI_FLAG_ATS_PAGE_ALIGNED_BIT,
>      VIRTIO_PCI_FLAG_VDPA_BIT,
> +    VIRTIO_PCI_FLAG_PM_NO_SOFT_RESET_BIT,
>  };
>  
>  /* Need to activate work-arounds for buggy guests at vmstate load. */
> @@ -80,6 +81,10 @@ enum {
>  /* Init Power Management */
>  #define VIRTIO_PCI_FLAG_INIT_PM (1 << VIRTIO_PCI_FLAG_INIT_PM_BIT)
>  
> +/* Init The No_Soft_Reset bit of Power Management */
> +#define VIRTIO_PCI_FLAG_PM_NO_SOFT_RESET \
> +  (1 << VIRTIO_PCI_FLAG_PM_NO_SOFT_RESET_BIT)
> +
>  /* Init Function Level Reset capability */
>  #define VIRTIO_PCI_FLAG_INIT_FLR (1 << VIRTIO_PCI_FLAG_INIT_FLR_BIT)
>  
> -- 
> 2.34.1


