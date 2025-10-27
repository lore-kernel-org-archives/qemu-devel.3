Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B049CCF9EB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 19:37:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDT0a-00005w-8G; Mon, 27 Oct 2025 15:36:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDT0X-00005P-6a
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 15:35:57 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDT0N-0007ts-T3
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 15:35:56 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-47112edf9f7so31820885e9.0
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 12:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761593741; x=1762198541; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rq9McUYcA2663ggQwnVLUVi1Gll9sS+Csapci13wf94=;
 b=qs2tro4jHquGyOEdwlrE2114sbuu1a0/D2lqOSmR7pP8HmJix8NBeN6RgEZdDL62qc
 gw5I0TNPaU+ckw9xtATZAz9WdLtk4i+0FuRChb87cUO2yPnNPpDCEh2EP6epXhFKK6kL
 w125bA6/ase0jqyEdvED5yofITgXMLSpGqHYJcnQQt6HjsipcEZuQh13Q1HyG+IgOrMk
 V1omoNrRBX5p2MZUQZ4dNuqjWwHK8Ilf9ocF0B3IyQSZpVwSNTQW/068uGxp+95ukEE6
 JsWni+Ghkcl4f+t1SU2xih2bvVuIMm3BIYkTzgGfyaTszx575IBL9u4ZpJPwASSSVFFs
 j0rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761593741; x=1762198541;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rq9McUYcA2663ggQwnVLUVi1Gll9sS+Csapci13wf94=;
 b=qdxk2ZuFZ3soneAFh7pUrAWXzPBanUgC7Pep1TznGQ9ioHHGXlcfvetEDQxBgLHGVW
 r5ixk3NCLZr9GK5XQnWjeulWA7AaS0TqUjg1UbZnQCBgMHWThH6eiyDNtv722N70eBUx
 c6oPfca47Q+RrXNd1g88yBOFu5TogMkSdfSH/nN9pmxgzLTRkUynFUC99LU9UmDLWt3a
 LIcL61NZWrJ5yMWATfQyiLI8c9PFb1CQudYsL4t/4tXQ8KPQV4JPoqdqbl/n3w42kRLW
 vEUron84Cpltp1VS6JfFnFKDug2ydfGGTJQUBQMRsxqlJjPkcmgxkzTWEotoI9zTaphW
 qqsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1oLEFQcflsh+bfnUIzt2gePEBXe1oa7UEhKLAEQy6aAIsDEjgzx3dRRAbNZf1DcX3nubAuAw98LwS@nongnu.org
X-Gm-Message-State: AOJu0YzYRbh/6Jj0iTt5ltNXqqSnbjhGytoIjR6hQvqIikF9mbKMxnwd
 JDPiyyHAYbtS9umgibRxgjgWIsFvUNu9JHh0skRjKAG4/65Lv1nVlyUdbk8BFnsWbWA=
X-Gm-Gg: ASbGncsTYsw5L5YOnq06DF5LZtOcZY6SKJC7hsbuHxkrJ7DNYi+0k33PT4hr5sv95A+
 VkHzNxR5wycLkJ/VdR+1yMslQk7z+tHwcRvrMJBoKfpFd3ZYqj+1d5Ve17bjOT/Azb2SNpj+k62
 LQJUrdmPTgTmL4ChtCnDE6dHiqA4HivENLxJDvQPVcTm5mz5pTTmmc0Fr1nArzz/JjUk1CRrwUM
 1V7R7qFlkA8cvzN5rEg3/ApNFV8Ud4riAwQPkF2VGtqofUfyflIuzbnz2AQslufhOUsmVjOwThq
 eudgKZkKnZM3nqz6GJmNBneJ2/6rOKahMu6sRYmmxGUXbo5aT2CXhDzNH9htnpbCNwk/jl2X62E
 RyStXrn3fTUPVfwK2kKgNSjQFbOcoVaQGCrzbQGgAeq5pHLqM84FYF/Pg1muCg6dAXT5ScxbLyx
 0oQvC2niKADIgRQxLuNQBYX83eAlDlOD5OswI+U7C/t0A=
X-Google-Smtp-Source: AGHT+IEOj6fd5vTsHHDM4GVjydxYRU5o5RW4YwvJW9eL9ZNFkLLG22JwDoCcbsBFmJeW2y4g5CxG2w==
X-Received: by 2002:a05:600c:45c5:b0:471:1337:7220 with SMTP id
 5b1f17b1804b1-47717df6931mr8384255e9.3.1761593741266; 
 Mon, 27 Oct 2025 12:35:41 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475dd47853csm154236525e9.13.2025.10.27.12.35.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Oct 2025 12:35:40 -0700 (PDT)
Message-ID: <7747275c-8e0a-4983-8613-fc39fc03bb39@linaro.org>
Date: Mon, 27 Oct 2025 20:35:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] hw/pci-host/articia: Map PCI memory windows in realize
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <cover.1761346145.git.balaton@eik.bme.hu>
 <ceda4c28887c40e1c8eae3f561ee381ca98b0484.1761346145.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ceda4c28887c40e1c8eae3f561ee381ca98b0484.1761346145.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 25/10/25 01:31, BALATON Zoltan wrote:
> These memory windows are a result of the address decoding in the
> Articia S north bridge so better model it there and not in board code.
> 
> Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/pci-host/articia.c | 15 ++++++++++++++-
>   hw/ppc/amigaone.c     | 28 +++++-----------------------
>   hw/ppc/pegasos2.c     | 13 -------------
>   3 files changed, 19 insertions(+), 37 deletions(-)


> @@ -169,6 +174,7 @@ static void articia_realize(DeviceState *dev, Error **errp)
>   {
>       ArticiaState *s = ARTICIA(dev);
>       PCIHostState *h = PCI_HOST_BRIDGE(dev);
> +    MemoryRegion *mr;
>       PCIDevice *pdev;
>   
>       bitbang_i2c_init(&s->smbus, i2c_init_bus(dev, "smbus"));
> @@ -180,6 +186,14 @@ static void articia_realize(DeviceState *dev, Error **errp)
>       memory_region_init_io(&s->reg, OBJECT(s), &articia_reg_ops, s,
>                             TYPE_ARTICIA, 0x1000000);
>       memory_region_add_subregion_overlap(&s->reg, 0, &s->io, 1);
> +    mr = g_new(MemoryRegion, 1);

Won't Coverity or other analysis tools complain about the leak?
(this is why we usually keep a reference in the device state, here
ArticiaState). Otherwise:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +    memory_region_init_alias(mr, OBJECT(dev), "pci-mem-low", &s->mem,
> +                             0, PCI_LOW_SIZE);
> +    memory_region_add_subregion(get_system_memory(), PCI_LOW_ADDR, mr);
> +    mr = g_new(MemoryRegion, 1);
> +    memory_region_init_alias(mr, OBJECT(dev), "pci-mem-high", &s->mem,
> +                             PCI_HIGH_ADDR, PCI_HIGH_SIZE);
> +    memory_region_add_subregion(get_system_memory(), PCI_HIGH_ADDR, mr);

