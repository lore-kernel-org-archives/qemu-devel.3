Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5735D3A672
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 16:38:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5pER-0002s3-3S; Tue, 29 Oct 2024 12:38:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1t5pEL-0002rI-BY
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 12:38:05 -0400
Received: from mail-yb1-xb2f.google.com ([2607:f8b0:4864:20::b2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1t5pEJ-0001ZC-Pm
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 12:38:05 -0400
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-e2903a48ef7so5759312276.2
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 09:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730219882; x=1730824682; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ODbIuKIbS3Koe9iJM7c0d89FHdP+CQz1EaZMkqKeLSk=;
 b=CdLrZxV4lGqiHccB9YxRfYyY0y3uxyl12hvqrDusC95h5yJyURNlqU2ecHv6SxmmTc
 J+Hy1xfn9C65HDMBZh6aLD6/2L6xRKGjxQqxH6wZX4a7Y5BjCy/DfYsD2VIKq8OGFTOe
 KT8lnyR3q8EgHGIARNXp1fpX37Lp6uXC1iw9sSceakhhm8yMCOkEbUiLSdHU8yNZTY6S
 /O72kuCJGhaEpDa4K++65WcHi5Du1GG6lOX5KkwpJHe/9n4bddTBg5QugFTFv4JU/AzN
 9GKfIDld8WmLdXjcFbzCi4phMD6yqXFe0mVAZIYLNMbXgag/B9sKlc2UsfVQPLRyDxF1
 pTyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730219882; x=1730824682;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ODbIuKIbS3Koe9iJM7c0d89FHdP+CQz1EaZMkqKeLSk=;
 b=S1s5Hz2eSWfacx0MZK3HjLDxZZm+k7xhC+LFd8DXU08uWvZHguOWNe3R/pHo8Icmta
 mits/5ZISN2tlKStSfsTLSDwSpEanz62XpI8L/R5aHEYbVsVDAJ/cddpFYqJHEg2cyCH
 24sSXsImYv3unYZZYa0tjo0Ae3cxqPXMqSaVRayT4b0GGmMHAX6noKjUjXsfN2MWXJp+
 gTUaw6y1Xv7eWBpy+NqV+SRwW7wY4WRzuz/ijhFQYyrvO8N/N8jqBDTYdBdZiFjmeg6J
 n5xM1Ju7IYmmgdt30bxm+RQnL8IDwnwIwbOiDSesiE05EM8coeG3meVJVBy+aDZVUeVI
 QU1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3i7IqDCCNiVvYXFoIFiuUEi/qenJVEzlqI0tHSunqYMtyVV9L4rWmy/Iz9GurTQ0X4vLS2JR4Luok@nongnu.org
X-Gm-Message-State: AOJu0Yy2U2iaJsbJwh88FrNJmWknFU6W28+FhPIW9stbuWU8Ou5++z/U
 aTKb3H13hewjAx0wxE7O15lAc03k4+9ojZTZUEJR2GjnPujyKqbx
X-Google-Smtp-Source: AGHT+IFnVZUsHRC+i95gktwWpb3xO12II0RNnDwtijDwQMaKuwGfCJwjoG3wajgf/4kSEjUmC+5ojw==
X-Received: by 2002:a05:6902:2482:b0:e28:e576:f712 with SMTP id
 3f1490d57ef6-e3087a49591mr10540327276.1.1730219882507; 
 Tue, 29 Oct 2024 09:38:02 -0700 (PDT)
Received: from fan ([50.205.20.42]) by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e307a01fae9sm1946377276.42.2024.10.29.09.38.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 09:38:02 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Tue, 29 Oct 2024 09:37:59 -0700
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: mst@redhat.com, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, linuxarm@huawei.com,
 linux-cxl@vger.kernel.org, marcel.apfelbaum@gmail.com,
 Dave Jiang <dave.jiang@intel.com>, Huang Ying <ying.huang@intel.com>,
 Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH 2/6] hw/pci-bridge/cxl_upstream: Provide x-speed and
 x-width properties.
Message-ID: <ZyEPZyUMMo-Vlgpz@fan>
References: <20240916173518.1843023-1-Jonathan.Cameron@huawei.com>
 <20240916173518.1843023-3-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240916173518.1843023-3-Jonathan.Cameron@huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2f;
 envelope-from=nifan.cxl@gmail.com; helo=mail-yb1-xb2f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Sep 16, 2024 at 06:35:14PM +0100, Jonathan Cameron wrote:
> Copied from gen_pcie_root_port.c
> Drop the previous code that ensured a valid value in s->width, s->speed
> as now a default is provided so this will always be set.
> 
> Note this changes the default settings but it is unlikely to have a negative
> effect on software as will only affect ports with now downstream device.
> All other ports will use the settings from that device.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  hw/pci-bridge/cxl_downstream.c | 23 ++++++++++-------------
>  1 file changed, 10 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/pci-bridge/cxl_downstream.c b/hw/pci-bridge/cxl_downstream.c
> index 4b42984360..c347ac06f3 100644
> --- a/hw/pci-bridge/cxl_downstream.c
> +++ b/hw/pci-bridge/cxl_downstream.c
> @@ -13,6 +13,8 @@
>  #include "hw/pci/msi.h"
>  #include "hw/pci/pcie.h"
>  #include "hw/pci/pcie_port.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/qdev-properties-system.h"
>  #include "hw/cxl/cxl.h"
>  #include "qapi/error.h"
>  
> @@ -210,24 +212,20 @@ static void cxl_dsp_exitfn(PCIDevice *d)
>      pci_bridge_exitfn(d);
>  }
>  
> -static void cxl_dsp_instance_post_init(Object *obj)
> -{
> -    PCIESlot *s = PCIE_SLOT(obj);
> -
> -    if (!s->speed) {
> -        s->speed = QEMU_PCI_EXP_LNK_2_5GT;
> -    }
> -
> -    if (!s->width) {
> -        s->width = QEMU_PCI_EXP_LNK_X1;
> -    }
> -}
> +static Property cxl_dsp_props[] = {
> +    DEFINE_PROP_PCIE_LINK_SPEED("x-speed", PCIESlot,
> +                                speed, PCIE_LINK_SPEED_64),
> +    DEFINE_PROP_PCIE_LINK_WIDTH("x-width", PCIESlot,
> +                                width, PCIE_LINK_WIDTH_16),

Not sure why. For the root port, we use PCIE_LINK_WIDTH_32, and here it is
PCIE_LINK_WIDTH_16?

Fan

> +    DEFINE_PROP_END_OF_LIST()
> +};
>  
>  static void cxl_dsp_class_init(ObjectClass *oc, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(oc);
>      PCIDeviceClass *k = PCI_DEVICE_CLASS(oc);
>  
> +    device_class_set_props(dc, cxl_dsp_props);
>      k->config_write = cxl_dsp_config_write;
>      k->realize = cxl_dsp_realize;
>      k->exit = cxl_dsp_exitfn;
> @@ -243,7 +241,6 @@ static const TypeInfo cxl_dsp_info = {
>      .name = TYPE_CXL_DSP,
>      .instance_size = sizeof(CXLDownstreamPort),
>      .parent = TYPE_PCIE_SLOT,
> -    .instance_post_init = cxl_dsp_instance_post_init,
>      .class_init = cxl_dsp_class_init,
>      .interfaces = (InterfaceInfo[]) {
>          { INTERFACE_PCIE_DEVICE },
> -- 
> 2.43.0
> 

-- 
Fan Ni

