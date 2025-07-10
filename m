Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9D35C83F17
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 10:53:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZouP-0004Mz-U8; Thu, 10 Jul 2025 06:53:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZouM-0004Kv-3G
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 06:53:42 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZouJ-0000HK-Vm
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 06:53:41 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-45363645a8eso5900115e9.1
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 03:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752144818; x=1752749618; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/2D9KdryDH9w3+FY3OKYsbitqI0vEstXZC8lyCAA7DQ=;
 b=aPjKaUFyUwBaAmF1FQLiwwkZA6JgAdZvPQkBY7IYIJL11LYMjwmxoFZe6H1tdfyzvW
 hePXYYzoKvzSJOYKgIPF+yEWNa1nShM4HGoxSl8ZnfmXUdRaBYESvGBbIjNsyP2p3BiY
 /7SjJh1isjV45iMr/cI1xtioTj9HSfl/FzmhpeGO/MxvBtx3Qse8N34XImXuHRImVVUg
 SvNWeYDyqXOcQ+KXbCOSWeORCvPX+rWvPkwDVl5rUHuTT/OyuvJ3aiUSM2i3s2yEr3Np
 n1LuvebbwCXwC9T16gRa21N3rwRPZqSgp4fPsIvGBRwu4Box2kJSRjn/jDccnr91oiNG
 +5aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752144818; x=1752749618;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/2D9KdryDH9w3+FY3OKYsbitqI0vEstXZC8lyCAA7DQ=;
 b=aGm51dHExcYZAaP86yKfl0q/Yq7lGJIPo7Rml0e3hHPSypdw046XmBdiJh/TYa40CN
 cS9kg8pXNF5nOgx+QJE0R3IhXC7+AEN9bOSkofAMu7znR/jfy3U0Kpq+ZxSBgebeQW4U
 c0mSNNpn9R2Pu7fcg+WStcUI4gRnJXNA7ShAPewONulj466hYlJs5h8mFsOb0iVhy1Vo
 9h4mL4jXOZqMyU/Vi9QpovJJoIFhUSyvLupKLdldI1fIfxXv1Bmq6vrxsi1n+10rvVvk
 UpLxe4Oa6fXHM/7ejhxNWCEClcpVrhF8ICYGNBQDSp7A6ZWWE/k9ejq+2pZ/n8uecyIA
 2jqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVR6wW+vzLimyZ8d4FbOaT6WZUbabtspyUmXzrhL11jfZSRcjfx3hKx9Uh6JJut4G3WSC/QRaDSywB5@nongnu.org
X-Gm-Message-State: AOJu0Yw8AkBrR8i+Rmsppq8CX7Ht9EyDxx5ZoXPu1HeMeg92ku6QkISg
 k6f2VJ12FFuEeHbU0PjjOs7cLwjDNn73nxWhiShqR7MyJSJ8BSWi2nB3ylttW5Burow=
X-Gm-Gg: ASbGnctTRNYAZ94UU7bAtfW2vYsTb4YHGt4NW1M98piGtH4hZVfbC1ZDzXZz3nlat78
 xtmXkH2nJzKRY59zomUGhmphP1x2VpsDmIhf+ipKlpXop8lrixZ2zgvQadNcrM2ldCju+0tbtyS
 e6cO4fzcN7XeGCna9lsoTpxt1NUWZZ0Gxltm2e4hOmGKwKTQxti8Oz0QureJ7/4TuQqfeFaJK1V
 zidRWO+Dd3h6trEBEQKPzHD6vzilD+J3oGjkDVn3SOpyzlG9Sk0F5MB4BaKpRN7MUiy+ZF/E+PQ
 bmsfJxhNJonH5a4UQd6w4Df8EuittxVwfKIZzlaWlrCYuY2BHk8/auX3YFBc4lhWLTjkKCETJje
 bhIMrP1DyNfCCKjnWWtVeuQ+N+3xy8/98cqconkCnpNgaLXYqRAkxpw==
X-Google-Smtp-Source: AGHT+IGWDK7HS76gTXznsmssW6+DUnZ9WwCwZxyYP/5PLa6m+Dkn5sjnPtHEj95t1Ix16zxSrbZhnA==
X-Received: by 2002:a05:600c:8717:b0:453:483b:6272 with SMTP id
 5b1f17b1804b1-454db7e8730mr30714355e9.7.1752144817772; 
 Thu, 10 Jul 2025 03:53:37 -0700 (PDT)
Received: from [192.168.1.117] (lfbn-mon-1-970-120.w86-227.abo.wanadoo.fr.
 [86.227.5.120]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454dd540a95sm16198805e9.29.2025.07.10.03.53.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Jul 2025 03:53:37 -0700 (PDT)
Message-ID: <8e9e90f3-eb41-47db-8286-9d96a97c9cac@linaro.org>
Date: Thu, 10 Jul 2025 12:53:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 18/18] hw/i386/isapc.c: replace rom_memory with
 system_memory
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, pbonzini@redhat.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com, eduardo@habkost.net,
 imammedo@redhat.com, qemu-devel@nongnu.org
References: <20250710085308.420774-1-mark.caveayland@nutanix.com>
 <20250710085308.420774-19-mark.caveayland@nutanix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250710085308.420774-19-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 10/7/25 10:52, Mark Cave-Ayland wrote:
> Now that we can guarantee the isapc machine will never have a PCI bus, any
> instances of rom_memory can be replaced by system_memory and rom_memory
> removed completely.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>   hw/i386/isapc.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/hw/i386/isapc.c b/hw/i386/isapc.c
> index bb22083821..27c075b5f3 100644
> --- a/hw/i386/isapc.c
> +++ b/hw/i386/isapc.c
> @@ -35,7 +35,6 @@ static void pc_init_isa(MachineState *machine)
>       ISABus *isa_bus;
>       GSIState *gsi_state;
>       MemoryRegion *ram_memory;
> -    MemoryRegion *rom_memory = system_memory;
>       DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
>       uint32_t irq;
>       int i;
> @@ -73,7 +72,7 @@ static void pc_init_isa(MachineState *machine)
>   
>       /* allocate ram and load rom/bios */
>       if (!xen_enabled()) {
> -        pc_memory_init(pcms, system_memory, rom_memory, 0);
> +        pc_memory_init(pcms, system_memory, system_memory, 0);

I'd prefer just call here:

   x86_bios_rom_init(X86_MACHINE(pcms), "bios.bin", rom_memory, true);

and in pc_system_firmware_init(): assert(pcmc->pci_enabled).

WDYT?

>       } else {
>           assert(machine->ram_size == x86ms->below_4g_mem_size +
>                                       x86ms->above_4g_mem_size);


