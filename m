Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28645FF885A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 13:37:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHibX-0005YQ-Cm; Tue, 28 Apr 2026 09:35:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ewandevelop@gmail.com>)
 id 1wHeyh-0000JJ-He
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 05:43:39 -0400
Received: from mail-dl1-x122b.google.com ([2607:f8b0:4864:20::122b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ewandevelop@gmail.com>)
 id 1wHeye-0003Oj-GK
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 05:43:39 -0400
Received: by mail-dl1-x122b.google.com with SMTP id
 a92af1059eb24-12c6df0b9bbso2687965c88.1
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 02:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777369414; x=1777974214; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=E+2aQrESKSPjXIMgAlPSq2BTaZgqO5ydTBn6YvPyGsg=;
 b=eZhHxGmi+60vkcJ0zBylLbBYEZQW+9Nt1vTzNHNUGvg81UTunlKMvk/o3gsfmyLPCo
 wzT85c1i42Jf9D2jcv2b/b9d4RdBzIJO2I82SM4xhRAn10GAJZ/NBZwQndf2tWPPA3zo
 gdFRRdOvSTBdsDHAP0Qnk04Pi68P8aKzjbPdB8csNdxEcxPYW6sNmVnV0WeBeHW9RJ4e
 X84X/l8qg+d0NGfaspnd/NCR9t3ucXFTP3pHHRHPV+jQXSBYHeh3X4PVxw6AaCau7rhg
 RT3CNWaboSltGXguYUUoGStobXSdy1VR2S2iWAm/MT2mP5wLD8as3xIUdrIjGKQXNnKP
 T9wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777369414; x=1777974214;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E+2aQrESKSPjXIMgAlPSq2BTaZgqO5ydTBn6YvPyGsg=;
 b=huAS3dLdC/tSSaoml6KRUVhijjte2WREmSdeDySNiAIzTWZh5ydiLM4FVR86XidyRQ
 JC4a+fuRAFOKgttNA/b/K2aJ/Z2u0XDwKnGBfpiyR/LdZKgiEedlaNudLU224b9l6UGt
 7KxEnTijbr/5mXJDy6khsYjYpbnxfFXbx0glA5Co30rqA0AGE8kL6eCHBJF6eFWZ8VGT
 MjYhM9aYNA3G8w++RHl1xE5zqj7hfLoxx6wVyak/Hod7wzTci+dIxxRmMJ1UVQeEVTst
 CgQVmfpH2XKFyK8aNtUa19OfsioZ2C5/FnIXiE1dUy+dP7TmKKpoHMjRO4Dn+iBujr7r
 spEA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9k79Ymhu+zaNdf7Q7a/cQKNbHMDjj1xjVOeIQW6BvNEXq2Spx9xV984cY/3fu7twe91t/8Zp12+CXz@nongnu.org
X-Gm-Message-State: AOJu0YwkOBYnTo0uy0HCW4OaqnAxtAfL2OX0FYPGIcOsr6bVG/AL7w7r
 XgEY67Koccg4lu1ppN37fr0L7cWtz02qBTJo3798MFZ0hydrrC3fMPnE
X-Gm-Gg: AeBDietMEpVp+T0L0yOxAinxlZrgbdjC68ulBEtTYe83jON/vB1dfFcRg6OHUirB6a7
 VdyNBvMQuXI6WMO5F9LvMzz6z8dPNZ2oeaAWAM+mO7vN+33QqfMBV0pYRitsH4jopXbt9Yzoual
 2hDPd64iT23+bdfZ2z/vMtKXU5IGcOd2ZL1nknHmeOM2r854D8odsbOXfI3ZDsk1LONX62wzEGW
 Gts8+LRDeMMGq1IzPXePwaIkvVTYDSuMbAqXrqE9QVCZ+g6GmFPpyLG79eOU9tAIMA7qExvHoLk
 k8ldfjdjHS/01cerv50Mwk6l842dlPGzVzjiLxTuGbHkXpN0Uixmfm6H2kDbnccZiZuRpMtPY3X
 47CIfQTM0VS11jaIYISXo3smWUMIdKewjSn7XcIw+airbpqO/+Y9r6WSE61kKgsImaqYDM7OOEa
 XuKsG1+JrHlxd9z/nMFI3yiPXLOOSxPtLfSpjm
X-Received: by 2002:a05:7022:621:b0:119:e56b:957b with SMTP id
 a92af1059eb24-12ddd90e40amr1289308c88.0.1777369413478; 
 Tue, 28 Apr 2026 02:43:33 -0700 (PDT)
Received: from [198.18.0.1] ([154.26.185.247])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12ddd9be1f9sm1811919c88.15.2026.04.28.02.43.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Apr 2026 02:43:33 -0700 (PDT)
Message-ID: <4b66c381-09c5-496e-b95e-100d1ba20dc5@gmail.com>
Date: Tue, 28 Apr 2026 17:43:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/9] hw/core: Make CPU topology enumeration
 arch-agnostic
To: Zhao Liu <zhao1.liu@intel.com>, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>,
 Alireza Sanaee <alireza.sanaee@huawei.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Yongwei Ma <yongwei.ma@intel.com>
References: <20241101083331.340178-1-zhao1.liu@intel.com>
 <20241101083331.340178-3-zhao1.liu@intel.com>
From: EwanHai <ewandevelop@gmail.com>
Content-Language: en-US
In-Reply-To: <20241101083331.340178-3-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::122b;
 envelope-from=ewandevelop@gmail.com; helo=mail-dl1-x122b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 28 Apr 2026 09:35:58 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Apologies for the noise, please ignore my previous reply, the corporate mailer
collapsed all the newlines. Resending in plain text below.

Zhao Liu wrote on 11/1/24 4:33 PM:
> Cache topology needs to be defined based on CPU topology levels. Thus,
> define CPU topology enumeration in qapi/machine.json to make it generic
> for all architectures.
> 
> To match the general topology naming style, rename CPU_TOPO_LEVEL_* to
> CPU_TOPOLOGY_LEVEL_*, and rename SMT and package levels to thread and
> socket.
> 
> Also, enumerate additional topology levels for non-i386 arches, and add
> a CPU_TOPOLOGY_LEVEL_DEFAULT to help future smp-cache object to work
> with compatibility requirement of arch-specific cache topology models.
> 
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> Tested-by: Yongwei Ma <yongwei.ma@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Acked-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---

...


> @@ -373,17 +373,17 @@ static void encode_topo_cpuid1f(CPUX86State *env, uint32_t count,
>      unsigned long level, base_level, next_level;
>      uint32_t num_threads_next_level, offset_next_level;
>  
> -    assert(count <= CPU_TOPO_LEVEL_PACKAGE);
> +    assert(count <= CPU_TOPOLOGY_LEVEL_SOCKET);
>  

Hi Zhao,

While booting Linux under TCG QEMU (-kernel + rootfs) with a CPU model that
enables cpuid_0x1f (e.g. Shijidadao-v2), I hit this assert: when the guest
queries CPUID.1F with a topology level greater than CPU_TOPOLOGY_LEVEL_SOCKET,
QEMU aborts. Under KVM the path isn't reached (CPUID is served from
KVM_SET_CPUID2), so this is TCG-only, which is probably why it hadn't been
caught earlier.

I'm not sure the assert is necessary: the code that follows already handles
the "input level out of range" case correctly. find_next_bit() returns SOCKET
once the bitmap is exhausted, the loop breaks with level = INVALID, and the
encoding path below produces the SDM-defined invalid-domain response (EAX=0,
EBX=0, ECX = count | INVALID_type, EDX = apic_id).

Per Intel SDM, CPUID Leaf 1FH does not constrain the input ECX value, so guest
software is free to query any sub-leaf index. Did the assert intentionally
protect an invariant I'm missing, or is it a leftover defensive check?

For reference, the KVM kernel side (arch/x86/kvm/cpuid.c kvm_cpuid()) has
explicitly handled out-of-range 0x1F subleaves this way since 2019:
    } else {
        *eax = *ebx = *ecx = *edx = 0;
        /*
         * When leaf 0BH or 1FH is defined, CL is pass-through
         * and EDX is always the x2APIC ID, even for undefined
         * subleaves. ...
         */
        if (function == 0xb || function == 0x1f) {
            entry = kvm_find_cpuid_entry_index(vcpu, function, 1);
            if (entry) {
                *ecx = index & 0xff;
                *edx = entry->edx;
            }
        }
    }
introduced in commit 43561123ab37 ("kvm: x86: Improve emulation of CPUID leaves
0BH and 1FH"). So KVM-accelerated guests already see the SDM-compliant response;
only TCG aborts.

Thanks,
Ewan


>      /*
>       * Find the No.(count + 1) topology level in avail_cpu_topo bitmap.
> -     * The search starts from bit 0 (CPU_TOPO_LEVEL_SMT).
> +     * The search starts from bit 0 (CPU_TOPOLOGY_LEVEL_THREAD).
>       */
> -    level = CPU_TOPO_LEVEL_SMT;
> +    level = CPU_TOPOLOGY_LEVEL_THREAD;
>      base_level = level;
>      for (int i = 0; i <= count; i++) {
>          level = find_next_bit(env->avail_cpu_topo,
> -                              CPU_TOPO_LEVEL_PACKAGE,
> +                              CPU_TOPOLOGY_LEVEL_SOCKET,
>                                base_level);
>  
>          /*
> @@ -391,20 +391,20 @@ static void encode_topo_cpuid1f(CPUX86State *env, uint32_t count,
>           * and it just encodes the invalid level (all fields are 0)
>           * into the last subleaf of 0x1f.
>           */
> -        if (level == CPU_TOPO_LEVEL_PACKAGE) {
> -            level = CPU_TOPO_LEVEL_INVALID;
> +        if (level == CPU_TOPOLOGY_LEVEL_SOCKET) {
> +            level = CPU_TOPOLOGY_LEVEL_INVALID;
>              break;
>          }
>          /* Search the next level. */
>          base_level = level + 1;
>      }
>  
> -    if (level == CPU_TOPO_LEVEL_INVALID) {
> +    if (level == CPU_TOPOLOGY_LEVEL_INVALID) {
>          num_threads_next_level = 0;
>          offset_next_level = 0;
>      } else {
>          next_level = find_next_bit(env->avail_cpu_topo,
> -                                   CPU_TOPO_LEVEL_PACKAGE,
> +                                   CPU_TOPOLOGY_LEVEL_SOCKET,
>                                     level + 1);
>          num_threads_next_level = num_threads_by_topo_level(topo_info,
>                                                             next_level);
...


