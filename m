Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DCF8C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 16:12:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raeL8-0006yL-28; Thu, 15 Feb 2024 11:11:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raeL7-0006yC-5A
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 11:11:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raeL5-0004MX-HU
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 11:11:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708013514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lzY7IDUdcAxUniLLkkMGJRvisr0M+0m9/4Bx06+xM1k=;
 b=CEl9E7/K+Gkouts83FwD9A1iKS+Pfhg/PAqAMRrTMfyHf9Emawx61rgc2fG2jIsmddg0j/
 0cnFUAXo3v8z79NHneYh+N5EjnO/7c2nihT78Fh1mj3eRXLNpAJER/RPj9Q4SLxcm+X8X4
 wN7TyN1ffd2rLJIR7oARGYLQkhKAuEo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-mJ73LIKeMLmTPIfjADYTSg-1; Thu, 15 Feb 2024 11:11:53 -0500
X-MC-Unique: mJ73LIKeMLmTPIfjADYTSg-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5611e1da4c6so730039a12.1
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 08:11:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708013512; x=1708618312;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lzY7IDUdcAxUniLLkkMGJRvisr0M+0m9/4Bx06+xM1k=;
 b=wVaXAGC+BBOAY8cn/j2kbyxGKvbrman6iMt6zMviQc/A7jU4EARbsTeoV1Xjnw+L9R
 vrc8xyit0TTu/I5Red5OjPJp1nZL5DKu9QH10l5CTNkT+iluvTWRQwWl6vwlak4MKSYI
 W+EdqglHUIqz6d6mzqZ32VnXFHx4GOidnT8HeB9xJZC0EEbGmP0/MxAg8f8vNXpWeFbr
 IgFKAeHYzvnadny0G2UjiygwiTPb0u8fzO2sv3mKnnsMjluLT3hIl0rBr2dNsQCVA5eZ
 EOI2L5IEVIGnB3F4i1us669FGnSU08fQjSWam/XfjDTedCuZiNGqxKjR+uc91bL3bNdn
 XMPA==
X-Gm-Message-State: AOJu0Yz+1ObvzIl6NqSaj2oSKII6JCqRx+jJphMmYY/N1jTQIS0Fp1fJ
 KygqWYm92EJfpqV8HniYTu8xaXZfkNuVM1zsJhkvKdVg/Z1/SUya2YTKhdvUu/9vFYKR+7sIO2v
 EPSaUvdHiqxDl63qyXNG3h3E1Gud/0nSlGzLQVopeYisLnt1qf0WJ
X-Received: by 2002:aa7:c655:0:b0:561:8918:9f5d with SMTP id
 z21-20020aa7c655000000b0056189189f5dmr1977385edr.20.1708013511985; 
 Thu, 15 Feb 2024 08:11:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHvjBbm9OaqwxpikSO5sj9WOmhPay0asdnhbSR49JEmAaBkiD3BApC42ulKBswKxKdBrPp0VQ==
X-Received: by 2002:aa7:c655:0:b0:561:8918:9f5d with SMTP id
 z21-20020aa7c655000000b0056189189f5dmr1977377edr.20.1708013511706; 
 Thu, 15 Feb 2024 08:11:51 -0800 (PST)
Received: from redhat.com ([2.52.14.124]) by smtp.gmail.com with ESMTPSA id
 g20-20020a056402091400b00563a86979dcsm690941edz.42.2024.02.15.08.11.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 08:11:51 -0800 (PST)
Date: Thu, 15 Feb 2024 11:11:47 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, Fan Ni <nifan.cxl@gmail.com>,
 linuxarm@huawei.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH qemu] hw/pci-bridge/pxb-cxl: Drop RAS capability from
 host bridge.
Message-ID: <20240215111117-mutt-send-email-mst@kernel.org>
References: <20240215155206.2736-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215155206.2736-1-Jonathan.Cameron@huawei.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.772,
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

On Thu, Feb 15, 2024 at 03:52:06PM +0000, Jonathan Cameron wrote:
> This CXL component isn't allowed to have a RAS capability.
> Whilst this should be harmless as software is not expected to look
> here, good to clean it up.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Isn't this device migrateable? If yes you need compat
handling.


> ---
>  I've been carrying this on my tree for quite a while.
>  This wasn't in previous fixes set because it's low priority and
>  rebasing it across cleanup series that followed those fixes was
>  too fiddly to bother.
>  
>  include/hw/cxl/cxl_component.h      |  1 +
>  hw/cxl/cxl-component-utils.c        | 21 +++++++++++++++++----
>  hw/pci-bridge/pci_expander_bridge.c |  2 +-
>  3 files changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
> index 0e5d35c263..5012fab6f7 100644
> --- a/include/hw/cxl/cxl_component.h
> +++ b/include/hw/cxl/cxl_component.h
> @@ -25,6 +25,7 @@ enum reg_type {
>      CXL2_TYPE3_DEVICE,
>      CXL2_LOGICAL_DEVICE,
>      CXL2_ROOT_PORT,
> +    CXL2_RC,
>      CXL2_UPSTREAM_PORT,
>      CXL2_DOWNSTREAM_PORT,
>      CXL3_SWITCH_MAILBOX_CCI,
> diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
> index 84ab503325..cd116c0401 100644
> --- a/hw/cxl/cxl-component-utils.c
> +++ b/hw/cxl/cxl-component-utils.c
> @@ -297,6 +297,7 @@ void cxl_component_register_init_common(uint32_t *reg_state,
>          caps = 3;
>          break;
>      case CXL2_ROOT_PORT:
> +    case CXL2_RC:
>          /* + Extended Security, + Snoop */
>          caps = 5;
>          break;
> @@ -326,8 +327,19 @@ void cxl_component_register_init_common(uint32_t *reg_state,
>                         CXL_##reg##_REGISTERS_OFFSET);                         \
>      } while (0)
>  
> +    switch (type) {
> +    case CXL2_DEVICE:
> +    case CXL2_TYPE3_DEVICE:
> +    case CXL2_LOGICAL_DEVICE:
> +    case CXL2_ROOT_PORT:
> +    case CXL2_UPSTREAM_PORT:
> +    case CXL2_DOWNSTREAM_PORT:
>      init_cap_reg(RAS, 2, CXL_RAS_CAPABILITY_VERSION);
> -    ras_init_common(reg_state, write_msk);
> +        ras_init_common(reg_state, write_msk);
> +        break;
> +    default:
> +        break;
> +    }
>  
>      init_cap_reg(LINK, 4, CXL_LINK_CAPABILITY_VERSION);
>  
> @@ -335,9 +347,10 @@ void cxl_component_register_init_common(uint32_t *reg_state,
>          return;
>      }
>  
> -    init_cap_reg(HDM, 5, CXL_HDM_CAPABILITY_VERSION);
> -    hdm_init_common(reg_state, write_msk, type);
> -
> +    if (type != CXL2_ROOT_PORT) {
> +        init_cap_reg(HDM, 5, CXL_HDM_CAPABILITY_VERSION);
> +        hdm_init_common(reg_state, write_msk, type);
> +    }
>      if (caps < 5) {
>          return;
>      }
> diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
> index 535889f7c2..0411ad31ea 100644
> --- a/hw/pci-bridge/pci_expander_bridge.c
> +++ b/hw/pci-bridge/pci_expander_bridge.c
> @@ -290,7 +290,7 @@ static void pxb_cxl_dev_reset(DeviceState *dev)
>      uint32_t *write_msk = cxl_cstate->crb.cache_mem_regs_write_mask;
>      int dsp_count = 0;
>  
> -    cxl_component_register_init_common(reg_state, write_msk, CXL2_ROOT_PORT);
> +    cxl_component_register_init_common(reg_state, write_msk, CXL2_RC);
>      /*
>       * The CXL specification allows for host bridges with no HDM decoders
>       * if they only have a single root port.
> -- 
> 2.39.2


