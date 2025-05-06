Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 938B9C3ABBF
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 00:13:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC5vt-0007Lq-DC; Mon, 05 May 2025 20:13:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uC5vq-0007J4-TW
 for qemu-devel@nongnu.org; Mon, 05 May 2025 20:13:10 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uC5vp-0000Da-4V
 for qemu-devel@nongnu.org; Mon, 05 May 2025 20:13:10 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-3081fe5987eso4882800a91.3
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 17:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746490387; x=1747095187; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=O5h+weRUpIyp3LtfV3HPJjNoq4ysHtbEcilsgOgzGAE=;
 b=dwA1s4lJS1dHxFzqI42gg0knqdsuqKhA8AXlBE5xnj5/UUtR40byryGbKf4YSJUJN1
 W2egVifr29YXDTB+VuM8tJmC5eEzCZjpD2c6vzvY4YdoRCjudwC0eCtle1Puhzq55QiG
 /nUcAL7hf3gzwAx9HkswOJNJloUw978q2YbzEQxUKAtzdPwRxHG/i5ml2dsgsPUDaeGr
 ScIZeMpZB74Jq7hc9r/7UFloKJcJTo4wdTAy0VMeYjnYc7miTNWdOqNJXqFvr57uCo6g
 NFKBuZUyu4jke6dVoCBh+0eT7Uk4c3ieBEun1Q1wVtU+uu9WzHXt+yVWuAcOq68COGVe
 OltQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746490387; x=1747095187;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O5h+weRUpIyp3LtfV3HPJjNoq4ysHtbEcilsgOgzGAE=;
 b=NhlVkGAxEw2MztslXNXQ5csOS8dl/XxzAJBlCLVhMHYx5jYpv4stUf3pfThvmB5rvV
 75cnAJ/oOT41iA2PaiVNBM9qfOdOSygbni6geu5FVSinBOeckmqiBXa7BTWcoR3JNQL+
 5EwDH/7of67EJHjOrvNqD0OQmSDEuIzkBLWTskMdt1fuafuq9+ubmZKnKxR9zVcSEM5Y
 B1MWXI3Ex3Sx7dg1aOM/hVxU+3WUhOyRV0X5s4yW+fV8jR1O9Ggo7xqzg1Ufwgm2e2Lr
 Y1BfpSsqQAKqI40gzUeRQAuPiOkLkq9FuvQ528NoYgR5uhtR7nIDfe77Uv/WH+LbOtyx
 kODw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8EK9cJL0DbKm6E+yG5A9svFQ6eBgVlbFCaQAB5iOiBCeNTd6HBRYSGTMYCdcCqy+SxPtm4cqMu1mQ@nongnu.org
X-Gm-Message-State: AOJu0YzWA45xvPo6MrUZcZi9t9Gr8/3X+zyPKXUCLShWnOwBJCGXVJgh
 Iucyye4f+9oAxLglL0E/IydFYNpSEUvKT5CXCpyWA7rn3m3fUS5YYzWXN2qPTQw=
X-Gm-Gg: ASbGncuKvRSZXw+ZjwsXegq8K7Pzc76FWJiB+k3uvotJe+WIMU11BTVFZ40WzDWuOia
 cCl/AYRNGwwOmGvw96Qs95JKad4pCvViZwO4dPRHQlG7oJlAb4K3xkSyEHpTa1fUlra3XeGmvOe
 eMBkemGwG0g6TH3o3sxvy/8xrQJiSQJFAZsj/K5SkbzZ4XiFJdEyK0mpR4RanC7LBwHO4vO/5nZ
 QKyK43hVa4Db7auAkiKVfjL6t8lbc8o0SUvU/gVhLaXOBvE35HBf3Jj8I/EIuvY8pUp12JGtE96
 /fQnjjceOwJ+Iesk5NDka0muNxb+yUAC/OT6gY/5lhbr2tG1o//pkE83HiahmDYToOyMSFv/BN6
 ASxNTxJDagnrOOxsKtkzKs34rETdA7Q==
X-Google-Smtp-Source: AGHT+IHtx1JvsGsTWns6adaSWF+4mroAXMKIDGF8ZwWFHCJ2fj2h5tz/19c83J1OCTIipM3ING/ikQ==
X-Received: by 2002:a17:90b:1f8d:b0:308:2b5b:d67f with SMTP id
 98e67ed59e1d1-30a7c080700mr2205527a91.9.1746490387238; 
 Mon, 05 May 2025 17:13:07 -0700 (PDT)
Received: from ?IPV6:2804:7f0:b400:8604:71fc:f75a:e2f5:e7b5?
 ([2804:7f0:b400:8604:71fc:f75a:e2f5:e7b5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e152309e5sm61216735ad.235.2025.05.05.17.13.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 17:13:06 -0700 (PDT)
Message-ID: <4bd4aa37-1edf-4660-b415-2b2c3c184e30@linaro.org>
Date: Mon, 5 May 2025 21:13:01 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Gustavo Romero <gustavo.romero@linaro.org>
Subject: Re: [RFC 07/24] hw/pci-host/gpex-acpi: Add native_pci_hotplug arg to
 acpi_dsdt_add_pci_osc
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 imammedo@redhat.com, anisinha@redhat.com, mst@redhat.com,
 shannon.zhaosl@gmail.com
Cc: pbonzini@redhat.com, Jonathan.Cameron@huawei.com
References: <20250428102628.378046-1-eric.auger@redhat.com>
 <20250428102628.378046-8-eric.auger@redhat.com>
Content-Language: en-US
In-Reply-To: <20250428102628.378046-8-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pj1-x1033.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi Eric,

On 4/28/25 07:25, Eric Auger wrote:
> Add a new argument to acpi_dsdt_add_pci_osc to be able to disable
> native pci hotplug.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>   hw/pci-host/gpex-acpi.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/pci-host/gpex-acpi.c b/hw/pci-host/gpex-acpi.c
> index e8b4c64c5f..4016089893 100644
> --- a/hw/pci-host/gpex-acpi.c
> +++ b/hw/pci-host/gpex-acpi.c
> @@ -50,7 +50,7 @@ static void acpi_dsdt_add_pci_route_table(Aml *dev, uint32_t irq,
>       }
>   }
>   
> -static void acpi_dsdt_add_pci_osc(Aml *dev)
> +static void acpi_dsdt_add_pci_osc(Aml *dev, bool enable_native_pcie_hotplug)
>   {
>       Aml *method, *UUID, *ifctx, *ifctx1, *elsectx, *buf;
>   
> @@ -80,8 +80,9 @@ static void acpi_dsdt_add_pci_osc(Aml *dev)
>        * Allow OS control for all 5 features:
>        * PCIeHotplug SHPCHotplug PME AER PCIeCapability.

This comment is no longer true for PCIeHotplug, which now can be
controlled by the platform, and so needs to be updated, although
it's going to go away in the series.
  
Otherwise:

Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>


Cheers,
Gustavo

>        */
> -    aml_append(ifctx, aml_and(aml_name("CTRL"), aml_int(0x1F),
> -                              aml_name("CTRL")));
> +    aml_append(ifctx, aml_and(aml_name("CTRL"),
> +               aml_int(0x1E | (enable_native_pcie_hotplug ? 0x1 : 0x0)),
> +               aml_name("CTRL")));
>   
>       ifctx1 = aml_if(aml_lnot(aml_equal(aml_arg(1), aml_int(0x1))));
>       aml_append(ifctx1, aml_or(aml_name("CDW1"), aml_int(0x08),
> @@ -192,7 +193,7 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
>               if (is_cxl) {
>                   build_cxl_osc_method(dev);
>               } else {
> -                acpi_dsdt_add_pci_osc(dev);
> +                acpi_dsdt_add_pci_osc(dev, true);
>               }
>   
>               aml_append(scope, dev);
> @@ -267,7 +268,7 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
>       }
>       aml_append(dev, aml_name_decl("_CRS", rbuf));
>   
> -    acpi_dsdt_add_pci_osc(dev);
> +    acpi_dsdt_add_pci_osc(dev, true);
>   
>       Aml *dev_res0 = aml_device("%s", "RES0");
>       aml_append(dev_res0, aml_name_decl("_HID", aml_string("PNP0C02")));


