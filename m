Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B44BC369C2
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 07:22:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBq8m-0003RA-63; Mon, 05 May 2025 03:21:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uBq8g-0003QA-BJ
 for qemu-devel@nongnu.org; Mon, 05 May 2025 03:21:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uBq8e-0003jR-JW
 for qemu-devel@nongnu.org; Mon, 05 May 2025 03:21:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746429679;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b//fbySjHm3bLNfXSHOGOw1La097DJfwWu5YGhpcH0o=;
 b=Nz/wuTs7GoB26vQzuNolPZti1ut9a5E6JraUrRUUVrkhPXkxMB9JhgaQ6kternjXDKNQPf
 5t66oq4zUsL7v1bkntmFzemyIQfvs0XJRKYKvDqRyXFTPBs9tfUEVB7NwYmWQLKgwPB6GK
 GiTsuX2D3iz6rwo1NfJcT/VnaDTjBqg=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-vfMO3w8MM2uuO1eaQ-3WiQ-1; Mon, 05 May 2025 03:21:17 -0400
X-MC-Unique: vfMO3w8MM2uuO1eaQ-3WiQ-1
X-Mimecast-MFC-AGG-ID: vfMO3w8MM2uuO1eaQ-3WiQ_1746429677
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-ace942ab877so92351266b.1
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 00:21:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746429676; x=1747034476;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=b//fbySjHm3bLNfXSHOGOw1La097DJfwWu5YGhpcH0o=;
 b=vLVEh+APrxUXsy6k2hIpgm4HMVj1q7OxdjhHU+OGmvip69jmAfd1FB6L2V0gvjO6Li
 VUdHC0wfdqbeiJ+9pMWWXllKjlu3RdpOHKNkBiniZ2I+drpHoX8KOXpLmWOMvWNbqaTc
 IJG6Nms5xuPfizfmkI0Nfwv8qDCNqM+kPDg55otcLsqNDF94pve3Zg0KjBNXyuJ9bFoV
 CGhdPix5UQSotu8/DzIO+OM/DpzMD1G31PFKZj7VLSe47L88d5XElxIldl8ZX5oO9tyG
 K1Z/kEpGV201MiT9sHCl+v9xVj44DLg9+nkkIDPG1cBb96R7SYSm4+MnMNWvF8X9l2X6
 qXEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkqSXW6Hfhe2sfxFwgmcZxvF8Ac2YJPmp6AoO/SJVTiYo4sItev7J7HlcMCJkHf/BOAVcwKp6ND6fe@nongnu.org
X-Gm-Message-State: AOJu0YwDeOBB0f9NpcNh5wkH5zc7Rdz5OlOjpshQQYGD+5tDTpVX+lLE
 0Up+lvzjkrfFHAz0Y8L+rkr41Tw0eBbSL0iyyLUR7o6Yu/EaBZHKX1QjSi/gJRywGv+Bs06DdUs
 5zwdjC/tPPF3r+NR7haiCo0IdlVTQe+qvBTMn/ayhTmnJAt7xr0bmes80CP2S
X-Gm-Gg: ASbGncvggDcv6oJufjAIuMvhvMAngJIJgkD6ke9oNo5u7YJP1nNpdMq9kHNrOuuc50E
 1oJpGw6SV92A6b7aa/Ml8tULLiHGUIVgW+CdGpD4vGM5/qqISnMMg6ZsDpAumw/VKEk1ozga4TU
 UB9Dh2i7yW3H1H6g+fBJDCloCMTZvTBB5zx0dnMBdrI43bWRLTxPU6HQnKSeyt7at9CG5EdoKpf
 q70ASgrGa0eKZLUz7Rt3auphsd/1oJUEHzlNFLEwjGNBs772ojKeaZbuDnenp1YwY2oNzOmzVXU
 mn96jElTMlh8t8PQGgxErUABuqt/fRd2PDylkHH6cWNpm6HeCDx1s7cnRBM=
X-Received: by 2002:a17:907:9689:b0:acb:711d:36c8 with SMTP id
 a640c23a62f3a-ad1a4abde03mr537862366b.38.1746429675933; 
 Mon, 05 May 2025 00:21:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+OWmoDyFCF7MXWeB95vy1Sv1AFrs62hh705IW+Nh6PIBIwDP//xCnZpU4nohTUtdkg6ESxA==
X-Received: by 2002:a05:600c:1914:b0:43d:47e:3205 with SMTP id
 5b1f17b1804b1-441c48bca55mr37301895e9.11.1746429231369; 
 Mon, 05 May 2025 00:13:51 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441bc264e2dsm101857215e9.12.2025.05.05.00.13.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 00:13:49 -0700 (PDT)
Message-ID: <b0faa0cf-8c68-4385-923c-e761b6582cc0@redhat.com>
Date: Mon, 5 May 2025 09:13:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/acpi/pcihp: Fix typo in function name
Content-Language: en-US
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, philmd@linaro.org, alex.bennee@linaro.org
References: <20250504215639.54860-10-gustavo.romero@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250504215639.54860-10-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 5/4/25 11:56 PM, Gustavo Romero wrote:
> Fix typo in QEMU's ACPI PCI hotplug API function name that checks
> whether a given bus is hotplug-capable.
>
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

For awareness, there is a similar typo in pci-port.
see
https://lore.kernel.org/all/20250428102628.378046-2-eric.auger@redhat.com/

another trivial indentation fix in generic_event_device.c
https://lore.kernel.org/all/20250428102628.378046-3-eric.auger@redhat.com/

Eric




> ---
>  hw/acpi/acpi-pci-hotplug-stub.c | 2 +-
>  hw/acpi/ich9.c                  | 2 +-
>  hw/acpi/pcihp.c                 | 2 +-
>  hw/acpi/piix4.c                 | 2 +-
>  include/hw/acpi/pcihp.h         | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/hw/acpi/acpi-pci-hotplug-stub.c b/hw/acpi/acpi-pci-hotplug-stub.c
> index b67b4a92da..b7bc6e40a1 100644
> --- a/hw/acpi/acpi-pci-hotplug-stub.c
> +++ b/hw/acpi/acpi-pci-hotplug-stub.c
> @@ -34,7 +34,7 @@ void acpi_pcihp_reset(AcpiPciHpState *s)
>  {
>  }
>  
> -bool acpi_pcihp_is_hotpluggbale_bus(AcpiPciHpState *s, BusState *bus)
> +bool acpi_pcihp_is_hotpluggable_bus(AcpiPciHpState *s, BusState *bus)
>  {
>      return true;
>  }
> diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
> index c7a735bf64..a07c9d115b 100644
> --- a/hw/acpi/ich9.c
> +++ b/hw/acpi/ich9.c
> @@ -570,7 +570,7 @@ void ich9_pm_device_unplug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
>  bool ich9_pm_is_hotpluggable_bus(HotplugHandler *hotplug_dev, BusState *bus)
>  {
>      ICH9LPCState *lpc = ICH9_LPC_DEVICE(hotplug_dev);
> -    return acpi_pcihp_is_hotpluggbale_bus(&lpc->pm.acpi_pci_hotplug, bus);
> +    return acpi_pcihp_is_hotpluggable_bus(&lpc->pm.acpi_pci_hotplug, bus);
>  }
>  
>  void ich9_pm_ospm_status(AcpiDeviceIf *adev, ACPIOSTInfoList ***list)
> diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
> index 5f79c9016b..aac90013d4 100644
> --- a/hw/acpi/pcihp.c
> +++ b/hw/acpi/pcihp.c
> @@ -371,7 +371,7 @@ void acpi_pcihp_device_unplug_request_cb(HotplugHandler *hotplug_dev,
>      acpi_send_event(DEVICE(hotplug_dev), ACPI_PCI_HOTPLUG_STATUS);
>  }
>  
> -bool acpi_pcihp_is_hotpluggbale_bus(AcpiPciHpState *s, BusState *bus)
> +bool acpi_pcihp_is_hotpluggable_bus(AcpiPciHpState *s, BusState *bus)
>  {
>      Object *o = OBJECT(bus->parent);
>  
> diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
> index b16d45f03e..d98b80df6d 100644
> --- a/hw/acpi/piix4.c
> +++ b/hw/acpi/piix4.c
> @@ -406,7 +406,7 @@ static bool piix4_is_hotpluggable_bus(HotplugHandler *hotplug_dev,
>                                        BusState *bus)
>  {
>      PIIX4PMState *s = PIIX4_PM(hotplug_dev);
> -    return acpi_pcihp_is_hotpluggbale_bus(&s->acpi_pci_hotplug, bus);
> +    return acpi_pcihp_is_hotpluggable_bus(&s->acpi_pci_hotplug, bus);
>  }
>  
>  static void piix4_pm_machine_ready(Notifier *n, void *opaque)
> diff --git a/include/hw/acpi/pcihp.h b/include/hw/acpi/pcihp.h
> index ac21a95913..a97904bada 100644
> --- a/include/hw/acpi/pcihp.h
> +++ b/include/hw/acpi/pcihp.h
> @@ -58,7 +58,7 @@ typedef struct AcpiPciHpState {
>  void acpi_pcihp_init(Object *owner, AcpiPciHpState *, PCIBus *root,
>                       MemoryRegion *io, uint16_t io_base);
>  
> -bool acpi_pcihp_is_hotpluggbale_bus(AcpiPciHpState *s, BusState *bus);
> +bool acpi_pcihp_is_hotpluggable_bus(AcpiPciHpState *s, BusState *bus);
>  void acpi_pcihp_device_pre_plug_cb(HotplugHandler *hotplug_dev,
>                                     DeviceState *dev, Error **errp);
>  void acpi_pcihp_device_plug_cb(HotplugHandler *hotplug_dev, AcpiPciHpState *s,


