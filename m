Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46FAEC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 06:17:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seqGI-0003OJ-S5; Fri, 16 Aug 2024 02:16:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1seqGF-0003Me-NP
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 02:16:32 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1seqGC-0003qZ-QP
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 02:16:30 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5bb85e90ad5so1432840a12.3
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 23:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723788986; x=1724393786; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ns6Qg3OYWk3Ry63Tz1spLZGvUKGI1mzJjq2PdU/zuZk=;
 b=G6I8An9uJxw4W7Oo7praY5HASHuXitmoi56H2vMjYgkrCFjeKMBUQrBwJPAuQkMkXF
 MiecevRFr5XEnfKjTIiSNgZYjzhRfzPQ30QtY5siQfjebYrEepN7pX4178LqbYn6M7Fb
 b5elB6hG8ahMHo4ZwVEnNaznDwsLelSP+B0IHGrLY1HMLRmaqEnsPx1BGBOXTQmnA2BM
 Q875kQUfrkCMKCTiRiS7jk6ML/faghHLjNegVACEfmOQa0QOkf049bqgagqgObHBmC7G
 ysg9d9adb+ndJXkmwoT7pyXlA4jE76/6WJL0mP7Umx+H6Q/ITvgFjlk38/dtUepWz2+7
 AT2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723788986; x=1724393786;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ns6Qg3OYWk3Ry63Tz1spLZGvUKGI1mzJjq2PdU/zuZk=;
 b=uhangVHPSkJMw/BVL1IdnCcqBpxKifztzYRk+9j744CZfQGibghSaerLmPN6Hiign1
 frnI2FHCl1M8WTDOxnEosGspLo7pJ2fsyoTYjTMG9Nl1woms9ZCE5FItqLWam8DKQHSB
 yFkz2SIP7RweDVXGNMuTqrhgGoaXCwg0xj1be3vF2HoUGSevSgZq/hVSUiZC7DnoO6Gb
 a/dLeWbuOflB6WoTXc6y/iXfRTWWObEQ+8nK6nfN58RU7nvebe//eC2W1dUYP+1ppkXP
 kPqvFMpDYSaZ7wKaX/yn/tgkk/2o2QKRQEiIuznqr+LLQILRBYDkN5Br8dEz737oIbM4
 Tc8Q==
X-Gm-Message-State: AOJu0Yw5U9hB3einrvexYAOAphliKIM/Gpg+jxqZDM38Ni0ilEyE5kqb
 CoiXhIzuj4h0V3Hiy/YF91piJtOddikyqNXt88V7t9Ps6AI81aGZhUFZCHOLSAOu91D9H/vK6zw
 c3/M=
X-Google-Smtp-Source: AGHT+IHD3sPtCXYPHNcRxHO2B7A/PXZHd+mNUc9+6oQ5HZSckKZ77gDOWZHty647GSfEVcSMFUgpLw==
X-Received: by 2002:a17:907:94ce:b0:a7a:b9dd:775f with SMTP id
 a640c23a62f3a-a8392a2241cmr112907766b.55.1723788986018; 
 Thu, 15 Aug 2024 23:16:26 -0700 (PDT)
Received: from [192.168.69.100] (cor91-h02-176-184-30-185.dsl.sta.abo.bbox.fr.
 [176.184.30.185]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a83839471c0sm205263966b.182.2024.08.15.23.16.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Aug 2024 23:16:25 -0700 (PDT)
Message-ID: <8e386637-3481-4eaa-b19f-70187924d817@linaro.org>
Date: Fri, 16 Aug 2024 08:16:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1? v2] hw/pci/pci-hmp-cmds: Avoid displaying bogus
 size in 'info pci'
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20240801131449.51328-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240801131449.51328-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

ping

On 1/8/24 15:14, Philippe Mathieu-Daudé wrote:
> When BAR aren't mapped, we get:
> 
>    (qemu) info pci
>      Bus  0, device   0, function 0:
>        Host bridge: PCI device dead:beef
>          ...
>          BAR4: 32 bit memory at 0xffffffffffffffff [0x00000ffe].
>          BAR5: I/O at 0xffffffffffffffff [0x0ffe].
> 
> Check the BAR is mapped comparing its address to PCI_BAR_UNMAPPED
> which is what the PCI layer uses for unmapped BARs.
> See pci_bar_address and pci_update_mappings implementations and
> in "hw/pci/pci.h":
> 
>    typedef struct PCIIORegion {
>        pcibus_t addr; /* current PCI mapping address. -1 means not mapped */
>    #define PCI_BAR_UNMAPPED (~(pcibus_t)0)
>        ...
> 
> This improves the logging, not displaying bogus sizes:
> 
>    (qemu) info pci
>      Bus  0, device   0, function 0:
>        Host bridge: PCI device dead:beef
>          ...
>        BAR4: 32 bit memory (not mapped)
>        BAR5: I/O (not mapped)
> 
> Remove trailing dot which is not used in other commands format.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/pci/pci-hmp-cmds.c | 26 ++++++++++++++++++--------
>   1 file changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/pci/pci-hmp-cmds.c b/hw/pci/pci-hmp-cmds.c
> index b09fce9377..fdfe44435c 100644
> --- a/hw/pci/pci-hmp-cmds.c
> +++ b/hw/pci/pci-hmp-cmds.c
> @@ -83,15 +83,25 @@ static void hmp_info_pci_device(Monitor *mon, const PciDeviceInfo *dev)
>           monitor_printf(mon, "      BAR%" PRId64 ": ", region->value->bar);
>   
>           if (!strcmp(region->value->type, "io")) {
> -            monitor_printf(mon, "I/O at 0x%04" PRIx64
> -                                " [0x%04" PRIx64 "].\n",
> -                           addr, addr + size - 1);
> +            if (addr != PCI_BAR_UNMAPPED) {
> +                monitor_printf(mon, "I/O at 0x%04" PRIx64
> +                                    " [0x%04" PRIx64 "]\n",
> +                               addr, addr + size - 1);
> +            } else {
> +                monitor_printf(mon, "I/O (not mapped)\n");
> +            }
>           } else {
> -            monitor_printf(mon, "%d bit%s memory at 0x%08" PRIx64
> -                               " [0x%08" PRIx64 "].\n",
> -                           region->value->mem_type_64 ? 64 : 32,
> -                           region->value->prefetch ? " prefetchable" : "",
> -                           addr, addr + size - 1);
> +            if (addr != PCI_BAR_UNMAPPED) {
> +                monitor_printf(mon, "%d bit%s memory at 0x%08" PRIx64
> +                                   " [0x%08" PRIx64 "]\n",
> +                               region->value->mem_type_64 ? 64 : 32,
> +                               region->value->prefetch ? " prefetchable" : "",
> +                               addr, addr + size - 1);
> +            } else {
> +                monitor_printf(mon, "%d bit%s memory (not mapped)\n",
> +                               region->value->mem_type_64 ? 64 : 32,
> +                               region->value->prefetch ? " prefetchable" : "");
> +            }
>           }
>       }
>   


