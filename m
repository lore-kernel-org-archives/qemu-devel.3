Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A5E2D2FFE0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 10:24:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1k9U-00074v-6o; Fri, 18 Oct 2024 06:24:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1t1k9T-00074k-1J
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 06:24:11 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1t1k9R-00063B-9I
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 06:24:10 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a99f1fd20c4so247559266b.0
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2024 03:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729247046; x=1729851846; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=INGV9KzC5f6hrYPoxXcFsvd/m0jgAMt8zZSiwBoIaqw=;
 b=zZre1xEDxI2s5Z6aqqKGagx6QVaPRQ3hWGL6C39IYabi40Aintu21XkB1BoPajUa0T
 psu157aM34wodcLKYeix0PoH39LoYszyB0I4Su1Z0qmkooqhZoKkpsKKs3x553VgSzHC
 6a5SeQqYjQi37P3Fxc5S+DBxo4U5gX96WlhJrh2G84lDWowWXXtae6Xn81gjxdV279fl
 SwzEg4brXzKVcSExr08GGq/G1d1YG3GOyObB+YTTfxj+S7cjeHGVwH3pCe9F+kzsJyop
 2HlDD/L3NXNbbs42uyOLi+YVP98s4H9esfHbS0t+SXhJDxyDqbHop9y4gROuXj5OhJFA
 pGkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729247046; x=1729851846;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=INGV9KzC5f6hrYPoxXcFsvd/m0jgAMt8zZSiwBoIaqw=;
 b=tuegC5N1t6kEoIEgrZak6lXlyOQA5oyIw9is2dOrR3gRrhB5REpwvtkueO2dcjBm86
 grjQiF7GbOQBCsdFAuuSlSqW3w/tOMKZ9LBXrJaSsJNdntq2rncGEIQ6Zzqz+EUB0w1f
 0g/BmJXWpF1cNtdIpmwkeoFjib9VvYjt7Fy/V23S9KqdodFgPfZnHyVtyK1VKHVIuElJ
 eQCPEzjoSWW+wt146/kc4CUmzj9NYjOWeNTUr0mlQ7Qyz0PSz3CcH3bBLl+WyVXGQqgW
 V3JbXjU67qlayBGos5IV0dKbG+l/hR1UQ3CsletrqeyoeUR1UbI+v3QGRNv/ELo6f8J7
 ji5Q==
X-Gm-Message-State: AOJu0Yz5I9BEV9CJ8ivKpIsqzxspnPC0sBwupzzrdt6CVlb8ZUjjrUbJ
 Hg2dObEVLDW34sUga+1swS4o8IucBq2UvNZCtixcuGTe9fxrs9uVZrkLRKEvnt0=
X-Google-Smtp-Source: AGHT+IGISMHKkxTDrcAhHVaRLycNM4Fhwm3HRo28XWAmYgbm17RRBkkOL6ScnCwBwZa5wXz537vokw==
X-Received: by 2002:a17:906:c150:b0:a9a:478:2ee3 with SMTP id
 a640c23a62f3a-a9a69c970f3mr151802966b.40.1729247046538; 
 Fri, 18 Oct 2024 03:24:06 -0700 (PDT)
Received: from [192.168.210.26] (83.11.13.124.ipv4.supernova.orange.pl.
 [83.11.13.124]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a68ae54b2sm74805966b.78.2024.10.18.03.24.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Oct 2024 03:24:06 -0700 (PDT)
Message-ID: <560a13ec-3954-45b6-a3b7-85c106b36eaf@linaro.org>
Date: Fri, 18 Oct 2024 12:24:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pcie: enable Extended tag field capability
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20241017-pcie-extend-v1-1-03eb1029f4ca@linaro.org>
 <20241017125724-mutt-send-email-mst@kernel.org>
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Language: pl-PL, en-GB
Organization: Linaro
In-Reply-To: <20241017125724-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-ej1-x62b.google.com
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

W dniu 17.10.2024 o 18:58, Michael S. Tsirkin pisze:
>> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
>> index 4b2f0805c6..54c0f1ec67 100644
>> --- a/hw/pci/pcie.c
>> +++ b/hw/pci/pcie.c
>> @@ -86,7 +86,8 @@ pcie_cap_v1_fill(PCIDevice *dev, uint8_t port, uint8_t type, uint8_t version)
>>        * Specification, Revision 1.1., or subsequent PCI Express Base
>>        * Specification revisions.
>>        */
>> -    pci_set_long(exp_cap + PCI_EXP_DEVCAP, PCI_EXP_DEVCAP_RBER);
>> +    pci_set_long(exp_cap + PCI_EXP_DEVCAP, PCI_EXP_DEVCAP_RBER |
>> +                 PCI_EXP_DEVCAP_EXT_TAG);
>>   
>>       pci_set_long(exp_cap + PCI_EXP_LNKCAP,
>>                    (port << PCI_EXP_LNKCAP_PN_SHIFT) |
> 
> We can't change capabilities unconditionally.
> It needs at least a machine type compat thing.

Started looking and wonder how to pass it from MachineClass level down 
to pcie.c/pcie_cap_v1_fill() level.

hw/arm/sbsa-ref.c (the machine I know best) has create_pcie() which 
allocates PCI_HOST_BRIDGE and then creates 2 pcie devices (default_nic 
(e1000e) and bochs-display gfx).

If I add "pcie_uses_ext_tags = true" to SBSAMachineState then I need to 
have it stored in PCIBus structure so pci_create_simple() will know. 
This function would copy it into "dev" (PCIDevice) to make it pass to 
pcie_cap_v1_fill() function.

But that's not right way because other PCIe devices are created in other 
places.

Need to dig deeper.

