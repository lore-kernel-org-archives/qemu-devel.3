Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33A80D3A66F
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 16:27:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5p3W-0008RV-NC; Tue, 29 Oct 2024 12:26:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1t5p3U-0008RK-Tg
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 12:26:53 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1t5p3T-0008Jr-22
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 12:26:52 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-6ea0b25695dso18803437b3.2
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 09:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730219208; x=1730824008; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hNz7zvIV8dkYQqm5r25/46W/cbbWVnUCIgSSCm4lcoc=;
 b=FaXpl07+yFXAQIGQk5Abt+Z5aBPRVyOJ5Paxl8byUuqtAJlgmkIXp536CDXX2WPxEi
 eqMKrfhwBMaqu8kfGQqnAbd/iXBXqQNYpo4A0oJSfDY6qpqbJXbIwRDNdijF7h0lYQzF
 6pkYETzHC1O5eje9SE68+tminQwG35ymyP8a2RrSDYcIL5KkfzR97GOFUs72Se8pAwxF
 c2l9yHFL6ypok4n7aT4S7ieXy/HzGg24pZGlKfQFW15d2+AnH4WNS5y7HpJY9bQHTgAf
 8Dd9BHCs2C5v0x20HcE8DdbHGmdmITgbTpPmSrYPRSG5gRxUB+AO6xsh2SfWDSeJOl53
 VfXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730219208; x=1730824008;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hNz7zvIV8dkYQqm5r25/46W/cbbWVnUCIgSSCm4lcoc=;
 b=NPL9wZWx4TbZfgawves4NIpunBUmPVlLRBVrYlVXJherWPBGYXzyskSBQTTA7KmL4O
 ovp/qviWq09Dv06bzuB3kVhjHi4Uotu8PlYhbBVvsKWVxQuVk3XjepcRvPVcswChBqNZ
 DXa6od/Op3MFoUUQTNbsb+rZSUwp/enszZY+BZkB24P7T9VM3eBzJesUltr4fQcLUp3K
 hY7vladfwVf/bA/tO/og9QXmxzZc4VOEUz09O0yTTlwsOVz04Y34ZYL5B4a+6UmE5G6m
 jE5sJCJFjyvhZ8A3CGtYrZMCA1+eDv6sG6O01gv2iPttSrcFabc2FbjRM0oviHjVte0q
 mLlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmA9xn6A9nbd7InOMxiEDFSXMiW7wwo/kdJdXz2lxsC9ckBOelm7AZ7PD6vTciPBmuD5Pfnnju2bCC@nongnu.org
X-Gm-Message-State: AOJu0Yyo8HUP2nzADD95WjNTtv9Aj9L58aZ+Y3s/U4uxW3UkOp7k/cT0
 1N5Sz/a90JtQtzJqePQnksgVzF7+HA4HDSqhH1BcvrA7uvThb2U9
X-Google-Smtp-Source: AGHT+IEx5cx+H/vRnj3+XiSrvVcTyv5l1RSnPWY4t3VZwdC+aoAcizhYS0/Ff5Hx1OnoFRckiGxU1Q==
X-Received: by 2002:a05:690c:9c0f:b0:6de:a3:a7ca with SMTP id
 00721157ae682-6e9d8acb4a9mr154068787b3.32.1730219208085; 
 Tue, 29 Oct 2024 09:26:48 -0700 (PDT)
Received: from fan ([50.205.20.42]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-6e9c6bdd42esm20204777b3.47.2024.10.29.09.26.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 09:26:47 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Tue, 29 Oct 2024 09:26:41 -0700
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: mst@redhat.com, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, linuxarm@huawei.com,
 linux-cxl@vger.kernel.org, marcel.apfelbaum@gmail.com,
 Dave Jiang <dave.jiang@intel.com>, Huang Ying <ying.huang@intel.com>,
 Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH 1/6] hw/pci-bridge/cxl_root_port: Provide x-speed and
 x-width properties.
Message-ID: <ZyEMwUnnufY0bbvU@fan>
References: <20240916173518.1843023-1-Jonathan.Cameron@huawei.com>
 <20240916173518.1843023-2-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240916173518.1843023-2-Jonathan.Cameron@huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=nifan.cxl@gmail.com; helo=mail-yw1-x112b.google.com
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

On Mon, Sep 16, 2024 at 06:35:13PM +0100, Jonathan Cameron wrote:
> Approach copied from gen_pcie_root_port.c
> Previously the link defaulted to a maximum of 2.5GT/s and 1x.  Enable setting
> it's maximum values.  The actual value after 'training' will depend on the
> downstream device configuration.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  hw/pci-bridge/cxl_root_port.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/hw/pci-bridge/cxl_root_port.c b/hw/pci-bridge/cxl_root_port.c
> index 2dd10239bd..5e2156d7ba 100644
> --- a/hw/pci-bridge/cxl_root_port.c
> +++ b/hw/pci-bridge/cxl_root_port.c
> @@ -24,6 +24,7 @@
>  #include "hw/pci/pcie_port.h"
>  #include "hw/pci/msi.h"
>  #include "hw/qdev-properties.h"
> +#include "hw/qdev-properties-system.h"
>  #include "hw/sysbus.h"
>  #include "qapi/error.h"
>  #include "hw/cxl/cxl.h"
> @@ -206,6 +207,10 @@ static Property gen_rp_props[] = {
>                       -1),
>      DEFINE_PROP_SIZE("pref64-reserve", CXLRootPort, res_reserve.mem_pref_64,
>                       -1),
> +    DEFINE_PROP_PCIE_LINK_SPEED("x-speed", PCIESlot,
> +                                speed, PCIE_LINK_SPEED_64),
> +    DEFINE_PROP_PCIE_LINK_WIDTH("x-width", PCIESlot,
> +                                width, PCIE_LINK_WIDTH_32),
>      DEFINE_PROP_END_OF_LIST()
>  };
LGTM.

Reviewed-by: Fan Ni <fan.ni@samsung.com>

Fan
>  
> -- 
> 2.43.0
> 

-- 
Fan Ni

