Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09883C54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 17:10:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhumA-0006Ru-Tp; Wed, 06 Mar 2024 12:09:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rhum2-0006PV-6S
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 12:09:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rhum0-0004Ih-JD
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 12:09:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709744983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=5EmdcjZxxcTELhcgKNZsmmIH4DnyepdDP+0fkoCuKew=;
 b=C6w5qD0BwiY5ZmT+86ZWdelm0jqfrnnmKL5D7+eQDqdOz6/1jTvsfcErlMrrtahM27o2aG
 Z9BQacqvpdgW2pBshxgxc63g2tj8XBQ1/PfvkKrHBcf3rQ8rDN8lthNSmPBg+Q0boKadTE
 OuC2BNzY9MuPzVbSvC5uVX4pRa9IssE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-jkL4JaopPfGD3GiCtMZcpA-1; Wed, 06 Mar 2024 12:09:42 -0500
X-MC-Unique: jkL4JaopPfGD3GiCtMZcpA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a457ac99155so1494166b.2
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 09:09:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709744981; x=1710349781;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5EmdcjZxxcTELhcgKNZsmmIH4DnyepdDP+0fkoCuKew=;
 b=bZdqkLyTqcL0mVjRjjHi4zsV/7gJC3DaFZb16FW+yJzTsPKnQtVF7c0LHCYtkaSYc2
 bU1B3LizV962PwxeLhdHArJ1i7OaBi2VIJ+hyiMhpn74Q8xn2gBAxZJg23xLCUTMsbFK
 xZ9U4s2dQK28iYwf4U+xSyAIaLF+a0urMUAlHgadvXBXZ2FjjFb2hQvId0I1uCLnIkNh
 h9YpTcVtY0bziQKpJNddJ0vJP95wjszn8WIV3W2+cyeArnVV2hoZWBiyufq3t5Xs2H0V
 VM54pNoWoj+dC9aq6AjCGiHMMmuFX34GPqctTc/pScB9B1HShPHwf/wMP7TMFUAnDyzu
 uTzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuBJ/lZ760J3Lmyv3vvLN5GbX/sC8QWeM5nBBfyyZz8EQRxKUljmKBZ6cfGwloHh7FvnRneQDu2xfkuxEpWnetSkyFgrc=
X-Gm-Message-State: AOJu0YwV1YS+bAar2SRpKjhmJ9ZPWCnk121/MFBvwkAc7VYm6mmYmFE8
 PcO24jTIggpy1wnRQKT7brweIWfw8fvPscxpCLx7xUY+YeP4EYqe4mEAIab6qZ++ooozSc9+5tb
 3AftUC5GM4mXqcLxmCcVmm3HEEXV9L5YSS/3NVTSEIriqrOZgmYKX
X-Received: by 2002:a17:906:68cc:b0:a45:c0ea:6578 with SMTP id
 y12-20020a17090668cc00b00a45c0ea6578mr1118044ejr.77.1709744981088; 
 Wed, 06 Mar 2024 09:09:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHpIe/qqOwKEc1vh5HWW1iN3F16MTS8h9DCAeb1JCRT2jW+22cjkhRU2vXDTWDonoRSXLqxzA==
X-Received: by 2002:a17:906:68cc:b0:a45:c0ea:6578 with SMTP id
 y12-20020a17090668cc00b00a45c0ea6578mr1118023ejr.77.1709744980793; 
 Wed, 06 Mar 2024 09:09:40 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-178-151.web.vodafone.de.
 [109.43.178.151]) by smtp.gmail.com with ESMTPSA id
 cx4-20020a170907168400b00a43a5bdd58bsm7309682ejd.211.2024.03.06.09.09.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Mar 2024 09:09:40 -0800 (PST)
Message-ID: <96c13ebb-563e-4b5e-9d84-54b2970a4d6e@redhat.com>
Date: Wed, 6 Mar 2024 18:09:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 13/18] hw/i386/pc: Remove
 PCMachineClass::resizable_acpi_blob
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, kvm@vger.kernel.org,
 Marcelo Tosatti <mtosatti@redhat.com>, devel@lists.libvirt.org,
 David Hildenbrand <david@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20240305134221.30924-1-philmd@linaro.org>
 <20240305134221.30924-14-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240305134221.30924-14-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.365,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 05/03/2024 14.42, Philippe Mathieu-Daudé wrote:
> PCMachineClass::resizable_acpi_blob was only used by the
> pc-i440fx-2.2 machine, which got removed. It is now always
> true. Remove it, simplifying acpi_build().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/i386/pc.h | 3 ---
>   hw/i386/acpi-build.c | 9 ---------
>   hw/i386/pc.c         | 1 -
>   3 files changed, 13 deletions(-)
> 
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index f7a5f4f283..be3a58c972 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -124,9 +124,6 @@ struct PCMachineClass {
>       /* create kvmclock device even when KVM PV features are not exposed */
>       bool kvmclock_create_always;
>   
> -    /* resizable acpi blob compat */
> -    bool resizable_acpi_blob;
> -
>       /*
>        * whether the machine type implements broken 32-bit address space bound
>        * check for memory.
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 8c7fad92e9..a56ac8dc90 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -2688,15 +2688,6 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
>        * All this is for PIIX4, since QEMU 2.0 didn't support Q35 migration.
>        */
>       /* Make sure we have a buffer in case we need to resize the tables. */

Should the above comment be removed now, too?

> -    if ((tables_blob->len > ACPI_BUILD_TABLE_SIZE / 2) &&
> -        !pcmc->resizable_acpi_blob) {
> -        /* As of QEMU 2.1, this fires with 160 VCPUs and 255 memory slots.  */
> -        warn_report("ACPI table size %u exceeds %d bytes,"
> -                    " migration may not work",
> -                    tables_blob->len, ACPI_BUILD_TABLE_SIZE / 2);
> -        error_printf("Try removing CPUs, NUMA nodes, memory slots"
> -                     " or PCI bridges.\n");
> -    }
>       acpi_align_size(tables_blob, ACPI_BUILD_TABLE_SIZE);

  Thomas


