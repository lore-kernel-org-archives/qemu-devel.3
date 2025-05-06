Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E99CC3ABB6
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 00:12:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC5tw-0004Yj-0D; Mon, 05 May 2025 20:11:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uC5tu-0004YM-SM
 for qemu-devel@nongnu.org; Mon, 05 May 2025 20:11:10 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uC5ts-00008E-Cx
 for qemu-devel@nongnu.org; Mon, 05 May 2025 20:11:10 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2254e0b4b79so75544975ad.2
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 17:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746490265; x=1747095065; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rMlrkoDSa1JV/ScygbYcd3JhEPUBHPR5an3220OLAoU=;
 b=hrv+oGIYinvIpSi250ODmaWhDPpA0HIenKAeQpy1xtCLG17jv5qqrrVjkdKw21oKuD
 i7dQxAbjfy2q06MvpKCSQIs7DLX1Byl75V0AKcuutiEPLrnVEM2hxccXBaOEHZ2YFh9U
 e7je1bDKqYHgXlR6YP0XEoLayqrM+SLQKGIR1nq93pmztZnaiuDN8HC+fgOcDdMJBn8h
 TcKlc92/KDZNoTRDDt0lsgRqjbLHf8RfCW8FM+uHZUTTLPs5wWkbQ1Tu4odiMNMSzAa+
 1m3Ozr0Nw3alCRwDlEfJ3rA8wQFd1eaTcjagummB72EiXCb4R4+QFGfL6MmbduYSiGp9
 K67Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746490265; x=1747095065;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rMlrkoDSa1JV/ScygbYcd3JhEPUBHPR5an3220OLAoU=;
 b=UHR3+oo2nNH0gQgbt3iYMduT2VUo4t6EjwBLJXmxNepRqUQPEwEcZrHqMzttCAJqB6
 MGxirkxfcY0Ai2zXd67/6pDftCLi3yiCRIOZWfb17nkTgbN23elQk63OKVuPOVvJQRZA
 FdJJjQNI0neBGXIO7aL8s4AjbRMbe/RerOtW7sCs8wsgU7TqidvJP8e+3saKR86w0ZIt
 iu7w541DI7T3gxCjdTotKrcVmeQBxApnJJM99gApyNrOArEeMxH7CskWBrnm890diKBe
 kCwWAw8B45/4mhXm+Ud2VimzedhaegXPGT9gh4OWyNWvS+ASClWeg5BiNFteNr7NhWx1
 ZmqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUd52rhFW+yqtkT4n3ILccKFMTScqb1C+En8EYa2/Xeslw9r0ZOymN/s88Cfeco2Xi222VoaYytVlOb@nongnu.org
X-Gm-Message-State: AOJu0YxjCUd1ST0HIdsH0HHUL4Be8qYpqMiWq9DsP+0ld/ZNIXBNzhGK
 pi+VuHjbI8lk3XjGkLFC0HFnRBAKPXELtIqPOfFB2zTYsq13milqWdgvdU3+Rj4=
X-Gm-Gg: ASbGncsAgg8cHIwDoraPZj7P5qEErjKfnaLtX9BrMBlX4ofpJ4T3YWdZEEMJvTme5XP
 Af/44JmGhRcPwJWN0NuF9m26GxfDlAPWctiUyVa+Ecy1x77UNgTZMhZkai2/PRFISCxJQzYra4K
 1IVrVNq2AbCAuu7kjhEaIV67M2XKUuMfHB0z3JxCR0n3eYnOaUiUntuy4ZMo/xPD7bVzhXjMyXn
 HrtICVZIuLpbqZA7ltdMf9T8/waNI9/8wBb0fq2umVUyd40lkLROJ6sxnvpRZ2ON7iz2WdNUg2c
 VyKTLgOo8jk5du++sgwh4bIAdurxsbQie5OUfcWGXo1ZbeFbxa1R03rhog1nc/fEy6ehp5c//1K
 In4im1NWpu81jkspjD5I=
X-Google-Smtp-Source: AGHT+IHbcYSIIohp615rCZ8MyauwJAEMni+aPPKpnDh0PCp8ZLxeT6rTMFGBjCPkhuPTkSolYSxcUA==
X-Received: by 2002:a17:902:ce02:b0:223:536d:f67b with SMTP id
 d9443c01a7336-22e1eaaf8ccmr172686835ad.38.1746490265450; 
 Mon, 05 May 2025 17:11:05 -0700 (PDT)
Received: from ?IPV6:2804:7f0:b400:8604:71fc:f75a:e2f5:e7b5?
 ([2804:7f0:b400:8604:71fc:f75a:e2f5:e7b5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e151e9f39sm61573215ad.84.2025.05.05.17.11.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 17:11:05 -0700 (PDT)
Message-ID: <9d4514ad-5b23-44a9-9b3e-77fce9066092@linaro.org>
Date: Mon, 5 May 2025 21:11:00 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Gustavo Romero <gustavo.romero@linaro.org>
Subject: Re: [RFC 01/24] hw/pci/pcie_port: Fix pcie_slot_is_hotpluggbale_bus
 typo
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 imammedo@redhat.com, anisinha@redhat.com, mst@redhat.com,
 shannon.zhaosl@gmail.com
Cc: pbonzini@redhat.com, Jonathan.Cameron@huawei.com
References: <20250428102628.378046-1-eric.auger@redhat.com>
 <20250428102628.378046-2-eric.auger@redhat.com>
Content-Language: en-US
In-Reply-To: <20250428102628.378046-2-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>   hw/pci/pcie_port.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/pci/pcie_port.c b/hw/pci/pcie_port.c
> index c73db30e98..072500ed34 100644
> --- a/hw/pci/pcie_port.c
> +++ b/hw/pci/pcie_port.c
> @@ -188,7 +188,7 @@ int pcie_count_ds_ports(PCIBus *bus)
>       return dsp_count;
>   }
>   
> -static bool pcie_slot_is_hotpluggbale_bus(HotplugHandler *plug_handler,
> +static bool pcie_slot_is_hotpluggable_bus(HotplugHandler *plug_handler,
>                                             BusState *bus)
>   {
>       PCIESlot *s = PCIE_SLOT(bus->parent);
> @@ -221,7 +221,7 @@ static void pcie_slot_class_init(ObjectClass *oc, void *data)
>       hc->plug = pcie_cap_slot_plug_cb;
>       hc->unplug = pcie_cap_slot_unplug_cb;
>       hc->unplug_request = pcie_cap_slot_unplug_request_cb;
> -    hc->is_hotpluggable_bus = pcie_slot_is_hotpluggbale_bus;
> +    hc->is_hotpluggable_bus = pcie_slot_is_hotpluggable_bus;
>   }
>   
>   static const TypeInfo pcie_slot_type_info = {

Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>


Cheers,
Gustavo

