Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDD46CCA472
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 07:35:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4DpP-00043d-R3; Thu, 02 Oct 2025 03:34:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1v4DpM-00043V-Af
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 03:34:12 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1v4DpI-0007up-CF
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 03:34:11 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-368348d30e0so6332661fa.1
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 00:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759390441; x=1759995241; darn=nongnu.org;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ei5hri8GsRIEFPpEv/7Nz/nPxR7vyTwAM5TTfLk0evw=;
 b=ZvoL/OVtZsOsVkhc5RDExC9KkBMQrHihxvGI0zyqJDtMKttMD6BvF6ttd0xU7eGj+2
 lbZEyCERwuNzVBPrXllCcv0ThuBSBrRVgucBKKugc5X7p4H514yPXsfa5caW40Fz3jsR
 UCX76VLwua5Z6cOKenuG5cRW334UAklGTZeqA1O1Fwzw7OYFm2pCWCK9C5YgwD0sEY22
 MfLvC2woUJZ1FCaFdAHZmOWXTHRBOqJoS9YFn2ZE29vgKsVVhheI/gGjbYbQk60iOEi6
 0x8EzqM+LrLONHCnPZK1t6QrLYVQYiz2nwG4fuG8eN+1Y8sPSo/ES1GjOJi1tXxZk9Vh
 iQdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759390441; x=1759995241;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ei5hri8GsRIEFPpEv/7Nz/nPxR7vyTwAM5TTfLk0evw=;
 b=Jx5rjN2no3iRszAIFamFmHSm1jDgQ+cFy1Yd8E/4Mq1bqQmzTLm7MgT/lS9ESM7ulO
 wKXVsdrWFT22rK685QVnEY4EVFSEmn3E5akJr6BisSi2dxTStoSO3cbVt8YzOMqvcFPa
 jjKq6cxeNrhM4vOzx8K+yAZTg0PH7H/1Je5XiFTpDPk+rFoB8Qf8U+Q4BAP/7grLbhCR
 +lUgeKb0qDObt7xI0lK7tIzI5jfWbj4BE0mdilZHnRfNkPWHH/jmUMq7woS5cm2nHVTy
 tO5Z7V9IBZVJGg9oZhNBtLWTZvwvhOmb+7a2eIVAz9+C2o7LRjBXVqwnk4m7xoVRtJI0
 ljxQ==
X-Gm-Message-State: AOJu0Yzfi0+N/RU01Ry5Zdyuly8vo1/HdjNGs+eBrOKgZHCKo2GAb+eI
 u5Js0BB6SioiL8gk2eYvf+XztVcA+JqOpClX9ProFsgqyRLW8XRz/9l5
X-Gm-Gg: ASbGncuLKaGM1ar4ARjY/40YCQZymiuFCWmiSu8P0bMLnfet73a4TDe4IcWAjGb8jk+
 QkzMb2AunP3F2S+0LG8YyB40epDkqJB3bX7WKzGNENo88DLG3nbYYdkVLMfc/weni3KZ6BR2HSg
 MdyRZueR3Ze003g/xMjkMP4tzHlOr0Fv++v7UGQ8tL6Fh/rvlMsxda3H+srfNFjJOiZAC2xj6Hk
 F66qHpTbWyi+mek8EqIzV3Cr1+YDsaY0yCgDP4aHDK7+eKbgkBOfCkMCcT9/SNE6/3Bjm1dTwHx
 BWdbc8sGavezZE/QnCfm0K/7tMg6Yzn+O3Fpq+iU0Aieb8FCVfvzU2Z8Mtk6kqmOxD1fOHmrJx7
 LQB8WPoC76ebcDW3bXi64NHSB6ATNk5bc5q4NrA8RMH+Hrid2TQRcHD8kCdMlsdZjiS4dkvn16k
 ceF4gWXz8=
X-Google-Smtp-Source: AGHT+IGbEzvxzeRniuCXp5pi8Yv7+yk+U7MOSb1ZBYe46ZTMnvXOmaz12kfdQRLrDx8qn7TVoajubw==
X-Received: by 2002:a2e:a88a:0:b0:336:9427:3527 with SMTP id
 38308e7fff4ca-373a742da79mr14882371fa.21.1759390440691; 
 Thu, 02 Oct 2025 00:34:00 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-373ba274b6fsm4962731fa.5.2025.10.02.00.33.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 00:33:59 -0700 (PDT)
Date: Thu, 2 Oct 2025 09:33:58 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: =?iso-8859-1?Q?Cl=E9ment?= Chigot <chigot@adacore.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 alistair@alistair23.me
Subject: Re: [PATCH 1/3] hw/arm/xlnx-zynqmp: move GIC_NUM_SPI_INTR define in
 header
Message-ID: <aN4q5uBfbvkI54Cc@zapote>
References: <20250930115718.437100-1-chigot@adacore.com>
 <20250930115718.437100-2-chigot@adacore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250930115718.437100-2-chigot@adacore.com>
User-Agent: Mutt/2.2.14+84 (2efcabc4) (2025-03-23)
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x231.google.com
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

On Tue, Sep 30, 2025 at 01:57:16PM +0200, Clément Chigot wrote:
> This define will be needed in a later patch in XlnxZynqMPState
> structure, hence move it within xlnx-zynqmp header.
> 
> Add XLXN_ZYNQMP prefix as it's now public.
> 
> Signed-off-by: Clément Chigot <chigot@adacore.com>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>



> ---
>  hw/arm/xlnx-zynqmp.c         | 11 +++++------
>  include/hw/arm/xlnx-zynqmp.h |  1 +
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
> index ec96a46eec..d7adc070f8 100644
> --- a/hw/arm/xlnx-zynqmp.c
> +++ b/hw/arm/xlnx-zynqmp.c
> @@ -26,8 +26,6 @@
>  #include "target/arm/cpu-qom.h"
>  #include "target/arm/gtimer.h"
>  
> -#define GIC_NUM_SPI_INTR 160
> -
>  #define ARM_PHYS_TIMER_PPI  30
>  #define ARM_VIRT_TIMER_PPI  27
>  #define ARM_HYP_TIMER_PPI   26
> @@ -206,7 +204,7 @@ static const XlnxZynqMPGICRegion xlnx_zynqmp_gic_regions[] = {
>  
>  static inline int arm_gic_ppi_index(int cpu_nr, int ppi_index)
>  {
> -    return GIC_NUM_SPI_INTR + cpu_nr * GIC_INTERNAL + ppi_index;
> +    return XLNX_ZYNQMP_GIC_NUM_SPI_INTR + cpu_nr * GIC_INTERNAL + ppi_index;
>  }
>  
>  static void xlnx_zynqmp_create_rpu(MachineState *ms, XlnxZynqMPState *s,
> @@ -454,7 +452,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
>      int num_apus = MIN(ms->smp.cpus, XLNX_ZYNQMP_NUM_APU_CPUS);
>      const char *boot_cpu = s->boot_cpu ? s->boot_cpu : "apu-cpu[0]";
>      ram_addr_t ddr_low_size, ddr_high_size;
> -    qemu_irq gic_spi[GIC_NUM_SPI_INTR];
> +    qemu_irq gic_spi[XLNX_ZYNQMP_GIC_NUM_SPI_INTR];
>      Error *err = NULL;
>  
>      ram_size = memory_region_size(s->ddr_ram);
> @@ -502,7 +500,8 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
>          g_free(ocm_name);
>      }
>  
> -    qdev_prop_set_uint32(DEVICE(&s->gic), "num-irq", GIC_NUM_SPI_INTR + 32);
> +    qdev_prop_set_uint32(DEVICE(&s->gic), "num-irq",
> +                         XLNX_ZYNQMP_GIC_NUM_SPI_INTR + 32);
>      qdev_prop_set_uint32(DEVICE(&s->gic), "revision", 2);
>      qdev_prop_set_uint32(DEVICE(&s->gic), "num-cpu", num_apus);
>      qdev_prop_set_bit(DEVICE(&s->gic), "has-security-extensions", s->secure);
> @@ -613,7 +612,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
>          return;
>      }
>  
> -    for (i = 0; i < GIC_NUM_SPI_INTR; i++) {
> +    for (i = 0; i < XLNX_ZYNQMP_GIC_NUM_SPI_INTR; i++) {
>          gic_spi[i] = qdev_get_gpio_in(DEVICE(&s->gic), i);
>      }
>  
> diff --git a/include/hw/arm/xlnx-zynqmp.h b/include/hw/arm/xlnx-zynqmp.h
> index c137ac59e8..6a407c2962 100644
> --- a/include/hw/arm/xlnx-zynqmp.h
> +++ b/include/hw/arm/xlnx-zynqmp.h
> @@ -67,6 +67,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(XlnxZynqMPState, XLNX_ZYNQMP)
>  #define XLNX_ZYNQMP_OCM_RAM_SIZE 0x10000
>  
>  #define XLNX_ZYNQMP_GIC_REGIONS 6
> +#define XLNX_ZYNQMP_GIC_NUM_SPI_INTR 160
>  
>  /*
>   * ZynqMP maps the ARM GIC regions (GICC, GICD ...) at consecutive 64k offsets
> -- 
> 2.34.1
> 

