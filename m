Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C1EDC3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 12:05:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU3Of-0000mz-PU; Wed, 17 Jul 2024 08:04:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sU3Oc-0000i7-Vn
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 08:04:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sU3OT-00035W-Ai
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 08:04:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721217864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2pUE+T5kXt2vezvqzz45odUPwf1QNuMOfFNa515TT8Y=;
 b=Z0/3PlwP7UhmCNdQxcfOIHssqMWjxli/JAPl83PDJjN9kw4LQZj5On33j/tUepcOI2po5+
 BTJMod2ccdwKkxxbHkxihGvMOn+BFb/Zu53tq9DhdFJpJ3/QSyGzyMHfBPVLETurVLTviK
 /WtXJk+eyvodNsR1UYBWsfSrZAjNFIk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-rSQjBHF9MHenbw8FwLuykg-1; Wed, 17 Jul 2024 08:04:22 -0400
X-MC-Unique: rSQjBHF9MHenbw8FwLuykg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-367963c4f52so4545979f8f.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 05:04:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721217861; x=1721822661;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2pUE+T5kXt2vezvqzz45odUPwf1QNuMOfFNa515TT8Y=;
 b=dB+Hyo074O8jDFuHLvdfgkUQQ0ov9TgpkkP3r/Qt8643/Z0ESxIMKhrr+iz2hoRzXb
 TWDujD8FPs8HOynHxIwu4s4+d9hQiEuERUea2tzGvbJP8NO/HrW8AQsuc8KKiFtDVwo0
 7QtF6uzUKomce+chsdBXZm3NyNIHsx9ahE/bLXDRcBHDpk3GcoN0YMIJumaENibpkwSp
 eAW7hmhdRiB0GcETX2upHu4wuWHwb0wVGVEGgaSUoQoAl+C4vQiE4MyfXT2PH1pPfpHL
 pEx6yP4nIC157lnk7GpbhtofL9rl9ZfmE+mEPLRbsJr+D1ueJ0W88B5hMBs+c4t8F6zF
 KV5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRRjkbizslVTtfeanl0wl2UqfzAEyoxtEfBkMgEBouvDRnpr/NCxlx25g5tuOs5gJXDn4eDUYxV8EO552MB2oi7s8zgew=
X-Gm-Message-State: AOJu0Yx6Ryd/mV+wIQODKIvTtQ29tfHY6JtKqRbgCe1wcmcX1KUWEt3i
 Y00KI/9BnYvVwEs9jqlZBI2o/EHgCRmzf1dgDHWY0Vk4go230d5zN8YV082+KWQafrDV6IWBlPI
 xlTHxXWGgf5nSDwlEPcsDp0ydlYRyCB4nYVWlHIm/KJxVSqUL1cNQ
X-Received: by 2002:adf:ee52:0:b0:367:9299:46dd with SMTP id
 ffacd0b85a97d-36831605ac2mr942460f8f.24.1721217861212; 
 Wed, 17 Jul 2024 05:04:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJfiWanD2O/xnWvOGnjGd5Jg6+V542aZojbyzuLVoqPFulTjxxmF5kY/e95GHHUXpBEYtOXw==
X-Received: by 2002:adf:ee52:0:b0:367:9299:46dd with SMTP id
 ffacd0b85a97d-36831605ac2mr942438f8f.24.1721217860425; 
 Wed, 17 Jul 2024 05:04:20 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:c194:849d:f1e:3618:dc03])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3681c30a024sm7236655f8f.96.2024.07.17.05.04.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 05:04:19 -0700 (PDT)
Date: Wed, 17 Jul 2024 08:04:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yao Xingtao <yaoxt.fnst@fujitsu.com>
Cc: marcel.apfelbaum@gmail.com, qemu-devel@nongnu.org,
 jonathan.cameron@huawei.com
Subject: Re: [PATCH v2] pci-bridge: avoid linking a single downstream port
 more than once
Message-ID: <20240717080308-mutt-send-email-mst@kernel.org>
References: <20240717085621.55315-1-yaoxt.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717085621.55315-1-yaoxt.fnst@fujitsu.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Wed, Jul 17, 2024 at 04:56:21AM -0400, Yao Xingtao wrote:
> Since the downstream port is not checked, two slots can be linked to
> a single port. However, this can prevent the driver from detecting the
> device properly.
> 
> It is necessary to ensure that a downstream port is not linked more than
> once.
> 
> Links: https://lore.kernel.org/qemu-devel/OSZPR01MB6453BC61D2FF4035F18084EF8DDC2@OSZPR01MB6453.jpnprd01.prod.outlook.com
> Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>

You also need to take ARI into account.
That can look like slot != 0.

> ---
> V1[1] -> V2:
>  - Move downstream port check forward
> 
> [1] https://lore.kernel.org/qemu-devel/20240704033834.3362-1-yaoxt.fnst@fujitsu.com
> ---
>  hw/pci-bridge/cxl_downstream.c     | 5 +++++
>  hw/pci-bridge/pcie_root_port.c     | 5 +++++
>  hw/pci-bridge/xio3130_downstream.c | 5 +++++
>  3 files changed, 15 insertions(+)
> 
> diff --git a/hw/pci-bridge/cxl_downstream.c b/hw/pci-bridge/cxl_downstream.c
> index 742da07a015a..af81ddfeec13 100644
> --- a/hw/pci-bridge/cxl_downstream.c
> +++ b/hw/pci-bridge/cxl_downstream.c
> @@ -142,6 +142,11 @@ static void cxl_dsp_realize(PCIDevice *d, Error **errp)
>      MemoryRegion *component_bar = &cregs->component_registers;
>      int rc;
>  
> +    if (pcie_find_port_by_pn(pci_get_bus(d), p->port) != NULL) {
> +        error_setg(errp, "Can't link port, error %d", -EBUSY);
> +        return;
> +    }
> +
>      pci_bridge_initfn(d, TYPE_PCIE_BUS);
>      pcie_port_init_reg(d);
>  
> diff --git a/hw/pci-bridge/pcie_root_port.c b/hw/pci-bridge/pcie_root_port.c
> index 09a34786bc62..a540204bda27 100644
> --- a/hw/pci-bridge/pcie_root_port.c
> +++ b/hw/pci-bridge/pcie_root_port.c
> @@ -67,6 +67,11 @@ static void rp_realize(PCIDevice *d, Error **errp)
>      PCIERootPortClass *rpc = PCIE_ROOT_PORT_GET_CLASS(d);
>      int rc;
>  
> +    if (pcie_find_port_by_pn(pci_get_bus(d), p->port) != NULL) {
> +        error_setg(errp, "Can't link port, error %d", -EBUSY);
> +        return;
> +    }
> +
>      pci_config_set_interrupt_pin(d->config, 1);
>      if (d->cap_present & QEMU_PCIE_CAP_CXL) {
>          pci_bridge_initfn(d, TYPE_CXL_BUS);
> diff --git a/hw/pci-bridge/xio3130_downstream.c b/hw/pci-bridge/xio3130_downstream.c
> index 907d5105b019..63f6baa615fd 100644
> --- a/hw/pci-bridge/xio3130_downstream.c
> +++ b/hw/pci-bridge/xio3130_downstream.c
> @@ -69,6 +69,11 @@ static void xio3130_downstream_realize(PCIDevice *d, Error **errp)
>      PCIESlot *s = PCIE_SLOT(d);
>      int rc;
>  
> +    if (pcie_find_port_by_pn(pci_get_bus(d), p->port) != NULL) {
> +        error_setg(errp, "Can't link port, error %d", -EBUSY);
> +        return;
> +    }
> +
>      pci_bridge_initfn(d, TYPE_PCIE_BUS);
>      pcie_port_init_reg(d);
>  
> -- 
> 2.37.3


