Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1279EC48291
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 10:14:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWvyo-0001Iz-I6; Mon, 05 Feb 2024 05:13:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1rWvym-0001Ih-10
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 05:13:32 -0500
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1rWvyj-0002Wp-Pn
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 05:13:31 -0500
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-511538be947so438504e87.3
 for <qemu-devel@nongnu.org>; Mon, 05 Feb 2024 02:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707128008; x=1707732808; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lJgt+rIcf8cWWUzO6QfRYxI8XlavmPnLi44SsOqg38k=;
 b=IMNg5l/KI2VAr9tcM/MTFcb6ekGnExk7kKBSxzpiSvW/wWV6m28KTpJ18qNthzZb3F
 GABePjswG7EoESIyKoQXy/VFA3YXs7jBmADkCQSN48/Aa8soOI38CoTChlR8+pj84cnu
 SCcL/UqmSzsDbP9TKNVZEG2htYHc1mEwO3ptVLFQD/QyRCO5dFTZ8iVgkBGaqHnGeHpk
 j1VHsTOuevJpBGQKB8QXMYGMxGTb9ALj5Pqbz449OeUovS3i+8wm32d6meL4bALdYNvH
 /upsqd8sNLWtyiPa/bSoJjJvllOhp2Jbvgaxhm/gVPQHNfovZC3Z2eF/LVy1wXzIaaco
 kAKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707128008; x=1707732808;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lJgt+rIcf8cWWUzO6QfRYxI8XlavmPnLi44SsOqg38k=;
 b=nAN+fA5T5p94ihObSNJT2+wJNCkTYBCOfimbHuPJ3talvXHCnr8mljjZ1gVbc9C18R
 U7CbfvmvZyGLuFnjUdQ+IyMQQIxVsG6Pjclqzb+AmliSD8o2ew6jbPudZ8/cRedGNBq3
 yNmydpwvrwubuIuFAjoiAipK0I5yLoHkcq54aGWCK+Qhhxi+HiOK1CL5t3Y2VJYR6FCn
 DBBgt2ank39bFn09XTKKljACoH1afU7+q38cXndUWhtoYvfdZqZGKD3lH/RZHgd6RVV1
 pRUkyu+glxmbXGDuDgrcXcCl6TS27hmoIZt1efS+zSIw0vG0jeAf8RjPf5SjIraZKbe/
 F67A==
X-Gm-Message-State: AOJu0Yz/OVycc1XjrlFtJvYkOz1bchFuSlYJVWlMmZTNS+TMAgdkWOPg
 czxlh7m54qk0j/7YCvcNbP4HrgVzP750LYmkg5Ixtq2TB1bS1N9g5gdyopCTGI0=
X-Google-Smtp-Source: AGHT+IE1hf8bl/hcXBe5riN3fpOTSpj1HFZfJr+9BMC6CSNMEcUYckN7BqsN2jrBQ9H5AbKaa/rH8Q==
X-Received: by 2002:a05:6512:292:b0:511:4a3c:bc67 with SMTP id
 j18-20020a056512029200b005114a3cbc67mr2830078lfp.9.1707128007718; 
 Mon, 05 Feb 2024 02:13:27 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXJLQoDNi2Q2qdYX/U6PiMl9OFuceQBj+ZoVnehK6ZdPRkztc9BWnHpIaAJo2xn5XxbatbtAvXF+1qnuNLsiQ5oE0J/xt4h6/E1YvJjhbSzgzDoPQKykT5m4zC/OtwCh+MXGtC80JDctgE/Oegsj8OY8yzYnISMBHNqUB6y/nPyDFbX01oTnG/9O5+Pi72tcYIIn7A0iDopB7UlN+Vd2srdv/AfIoQwvWe1qbjpDHQC30YEreb+3qXu8HhHWfcaPrJu+4smUHnqcNp+YOCj1u0Lp82TE29mISyw0uBNXEv5R1S0UuJ3DKY0/ph8XsgcQeOkg+7X
Received: from myrica ([2.221.137.100]) by smtp.gmail.com with ESMTPSA id
 dw14-20020a0560000dce00b0033b26de0073sm6303131wrb.97.2024.02.05.02.13.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Feb 2024 02:13:27 -0800 (PST)
Date: Mon, 5 Feb 2024 10:13:22 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 alex.williamson@redhat.com, peter.maydell@linaro.org,
 zhenzhong.duan@intel.com, yanghliu@redhat.com, mst@redhat.com,
 clg@redhat.com, jasowang@redhat.com
Subject: Re: [PATCH v2 1/3] virtio-iommu: Add an option to define the input
 range width
Message-ID: <20240205101322.GA2086490@myrica>
References: <20240201163324.564525-1-eric.auger@redhat.com>
 <20240201163324.564525-2-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201163324.564525-2-eric.auger@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=jean-philippe@linaro.org; helo=mail-lf1-x12d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Hi Eric,

On Thu, Feb 01, 2024 at 05:32:22PM +0100, Eric Auger wrote:
> aw-bits is a new option that allows to set the bit width of
> the input address range. This value will be used as a default for
> the device config input_range.end. By default it is set to 64 bits
> which is the current value.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> 
> v1 -> v2:
> - Check the aw-bits value is within [32,64]
> ---
>  include/hw/virtio/virtio-iommu.h | 1 +
>  hw/virtio/virtio-iommu.c         | 7 ++++++-
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/virtio/virtio-iommu.h b/include/hw/virtio/virtio-iommu.h
> index 781ebaea8f..5fbe4677c2 100644
> --- a/include/hw/virtio/virtio-iommu.h
> +++ b/include/hw/virtio/virtio-iommu.h
> @@ -66,6 +66,7 @@ struct VirtIOIOMMU {
>      bool boot_bypass;
>      Notifier machine_done;
>      bool granule_frozen;
> +    uint8_t aw_bits;
>  };
>  
>  #endif
> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
> index ec2ba11d1d..7870bdbeee 100644
> --- a/hw/virtio/virtio-iommu.c
> +++ b/hw/virtio/virtio-iommu.c
> @@ -1314,7 +1314,11 @@ static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
>       */
>      s->config.bypass = s->boot_bypass;
>      s->config.page_size_mask = qemu_real_host_page_mask();
> -    s->config.input_range.end = UINT64_MAX;
> +    if (s->aw_bits < 32 || s->aw_bits > 64) {

I'm wondering if we should lower this to 16 bits, just to support all
possible host SMMU configurations (the smallest address space configurable
with T0SZ is 25-bit, or 16-bit with the STT extension).

Thanks,
Jean

> +        error_setg(errp, "aw-bits must be within [32,64]");
> +    }
> +    s->config.input_range.end =
> +        s->aw_bits == 64 ? UINT64_MAX : BIT_ULL(s->aw_bits) - 1;
>      s->config.domain_range.end = UINT32_MAX;
>      s->config.probe_size = VIOMMU_PROBE_SIZE;
>  
> @@ -1525,6 +1529,7 @@ static Property virtio_iommu_properties[] = {
>      DEFINE_PROP_LINK("primary-bus", VirtIOIOMMU, primary_bus,
>                       TYPE_PCI_BUS, PCIBus *),
>      DEFINE_PROP_BOOL("boot-bypass", VirtIOIOMMU, boot_bypass, true),
> +    DEFINE_PROP_UINT8("aw-bits", VirtIOIOMMU, aw_bits, 64),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> -- 
> 2.41.0
> 

