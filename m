Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20AECC5B542
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 12:34:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJtUz-0000Ec-Je; Tue, 27 May 2025 08:33:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uJtUc-0008Vz-1l
 for qemu-devel@nongnu.org; Tue, 27 May 2025 08:33:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uJtUU-00018o-Vb
 for qemu-devel@nongnu.org; Tue, 27 May 2025 08:33:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748349186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JSyA17JcwDw+hVT8HzCGm3EhKp0MKE0IgjhRLkchdwk=;
 b=G59XgEby6qrGU/zP54zD6zO8Iy8pA2yoRDTR9IxV8oGmUmOd4vE+76PCRULfvCdIOxGsZL
 nvhG5nnxwYdQPuPHNaDgn4n+UHYuIYS2WZv+p6vu59YZ6wD4iw0mzm2T3B/10BCaDX/NZv
 nd6bqpYyEHA5AWb4WacNDg4nlrODa9E=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370-gXiO77jEMhOS4wmxtmfv8w-1; Tue, 27 May 2025 08:33:05 -0400
X-MC-Unique: gXiO77jEMhOS4wmxtmfv8w-1
X-Mimecast-MFC-AGG-ID: gXiO77jEMhOS4wmxtmfv8w_1748349184
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43d4d15058dso24902375e9.0
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 05:33:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748349184; x=1748953984;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JSyA17JcwDw+hVT8HzCGm3EhKp0MKE0IgjhRLkchdwk=;
 b=PrixtKYW5U540jMyVvMmI93tCNFV/E6NVwQ8BGARvuMfIm8OBtYBrF63bPzvssE9Wf
 mvf0k7/50n51ZbcjbfCeGwdYpc6vEl5YGl0oqqY2/aa8lSVKXATTKPKOQ0oiuzEFI5/1
 Pdq7yFeLqfgYMQI9wXz25WWcrlSG2r/UJ9zBbWtL7AMcwSK8QoaBpTH6f1tEejnJXPOb
 lDCtKJZ009yXQ25PtM/CNfwXhjzBW8ONwS0jKhm2GBg6oPu3xRqTi7c6/if2jMEPs3Uf
 rjEbeK8AyohcsosTcTOpnkECCDG0IHmkkPsqfCt9qfO4b5u4nUpPuz1BEK/nX5LrKFWH
 8oNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDs9AGP8TRTdC9rKc4vyESzfq0dq+XObWQWw4EY0d0aqhJhQxFnN05M28qX8IjW36hH/TlW0rMjFGW@nongnu.org
X-Gm-Message-State: AOJu0YzsfmBNs/WSbGXy48dixTy612WDFRpVWl+iJxjuYa0OCFCwlG1E
 UK65POAGsd3/Z986lyCSKQzo/G/Igp0RomcVC+34WwLxW3VfQBuM2zbj+bIPErFPy6dWa6KNB9r
 cpzGjf1Q5MwGmE9engx37DxNTCEJACI8d5/KD6xxLxu74Ag9SIiBIlvAw
X-Gm-Gg: ASbGncuiCkTPr+ojgUzxiggMOn/6hLYc7B0AQMDdOTgFGvLzSwErJ/nYZICecSiSFHP
 U1HbVZ8XlBuDsqWITAYAuCjGWSOI0IFAcWS20JpyfeJvO24zAnOb6XsPwk6aqo6zsBZaO0Lxzv1
 mEWLuvqluG+oeKuilWiT6cpKQtEkcVEyH2alksSiqS8UitIL5huqyRqcDUYFmAkPvEndRqJfDGg
 SUdNA0Gi+EnUQxdiiQkNL5KzHYjzCOfGqZPwEdSSC1BUVz+OMvi0DV6EG+0D8IqITZXM81KCtA7
 7UiN8TlXD9cBElhBUeBM+g9cy6uAawi5
X-Received: by 2002:a05:600c:a13:b0:43d:160:cd9e with SMTP id
 5b1f17b1804b1-44c91fbb448mr122826895e9.17.1748349183860; 
 Tue, 27 May 2025 05:33:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDkjQ/gTUtOR9V+UfXzAV3boJyM9kg8mFBxkEnwYtVzG+Fs4iF3wBmt2jjV0fO4eGx24oaqQ==
X-Received: by 2002:a05:600c:a13:b0:43d:160:cd9e with SMTP id
 5b1f17b1804b1-44c91fbb448mr122826535e9.17.1748349183416; 
 Tue, 27 May 2025 05:33:03 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f6b29619sm280797635e9.7.2025.05.27.05.33.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 05:33:03 -0700 (PDT)
Date: Tue, 27 May 2025 14:33:01 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, gustavo.romero@linaro.org, anisinha@redhat.com,
 mst@redhat.com, shannon.zhaosl@gmail.com, pbonzini@redhat.com,
 Jonathan.Cameron@huawei.com, philmd@linaro.org, alex.bennee@linaro.org
Subject: Re: [PATCH v2 06/25] hw/pci-host/gpex-acpi: Propagate hotplug type
 info from virt machine downto gpex
Message-ID: <20250527143301.77f5bfd1@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250527074224.1197793-7-eric.auger@redhat.com>
References: <20250527074224.1197793-1-eric.auger@redhat.com>
 <20250527074224.1197793-7-eric.auger@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, 27 May 2025 09:40:08 +0200
Eric Auger <eric.auger@redhat.com> wrote:

> Propagate the type of pci hotplug mode downto the gpex
> acpi code. In case machine acpi_pcihp is unset we configure
> pci native hotplug on pci0. For expander bridges we keep
> legacy pci native hotplug, as done on x86 q35.

this is not needed if done as suggested in 2/25

> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>  include/hw/pci-host/gpex.h | 1 +
>  hw/arm/virt-acpi-build.c   | 1 +
>  hw/pci-host/gpex-acpi.c    | 3 ++-
>  3 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/pci-host/gpex.h b/include/hw/pci-host/gpex.h
> index 84471533af..feaf827474 100644
> --- a/include/hw/pci-host/gpex.h
> +++ b/include/hw/pci-host/gpex.h
> @@ -45,6 +45,7 @@ struct GPEXConfig {
>      MemMapEntry pio;
>      int         irq;
>      PCIBus      *bus;
> +    bool        pci_native_hotplug;
>  };
>  
>  typedef struct GPEXIrq GPEXIrq;
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 7e8e0f0298..be5e00a56e 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -129,6 +129,7 @@ static void acpi_dsdt_add_pci(Aml *scope, const MemMapEntry *memmap,
>          .ecam   = memmap[ecam_id],
>          .irq    = irq,
>          .bus    = vms->bus,
> +        .pci_native_hotplug = !vms->acpi_pcihp,
>      };
>  
>      if (vms->highmem_mmio) {
> diff --git a/hw/pci-host/gpex-acpi.c b/hw/pci-host/gpex-acpi.c
> index 1aa2d12026..f1ab30f3d5 100644
> --- a/hw/pci-host/gpex-acpi.c
> +++ b/hw/pci-host/gpex-acpi.c
> @@ -204,6 +204,7 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
>              if (is_cxl) {
>                  build_cxl_osc_method(dev);
>              } else {
> +                /* pxb bridges do not have ACPI PCI Hot-plug enabled */
>                  acpi_dsdt_add_host_bridge_methods(dev, true);
>              }
>  
> @@ -279,7 +280,7 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
>      }
>      aml_append(dev, aml_name_decl("_CRS", rbuf));
>  
> -    acpi_dsdt_add_host_bridge_methods(dev, true);
> +    acpi_dsdt_add_host_bridge_methods(dev, cfg->pci_native_hotplug);
>  
>      Aml *dev_res0 = aml_device("%s", "RES0");
>      aml_append(dev_res0, aml_name_decl("_HID", aml_string("PNP0C02")));


