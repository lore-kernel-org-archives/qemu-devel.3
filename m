Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04491104C00D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 12:10:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0INk-0007xa-Ba; Wed, 11 Mar 2026 08:09:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0INf-0007uF-Bl
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 08:09:41 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0INY-0007Gs-MP
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 08:09:36 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-48539cbb7b1so23173305e9.3
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 05:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773230971; x=1773835771; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OYQKN7/JZQcImipPMxWO15cDyaAQMxMX8aUfy3Nm90o=;
 b=PV0Bc+MkXSUHTKILkOxKo4tTVfoBLxDoFu1Kv8MKstZO/vUG2K1FlUjc9e9J/MkfxR
 dpRJhekaTu1Kp/0ET4mIYlRA9/LkS6ZZ/OHafN4WvONNcDk8o3jfjYmhxFyF4v2EZ5JV
 wYPVBqWsrRPYZ/1bQPgpBNY/6FX3xaxFpMiR93wFp2mgO9f9HPSe+idqvke3uYsuojRE
 Ah3WDuwsuqhl9lOyVSbdnFryr1aee1DHqq0XmLrVnuMtTWW71ODpCtlWVULEAoFjjVJr
 Dm/UnF08OxE88MJxbooLeNElT3kTbHxG/SCdekfCUNOTRWN+aBGzBeTcNiel1zni3J8L
 IZ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773230971; x=1773835771;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OYQKN7/JZQcImipPMxWO15cDyaAQMxMX8aUfy3Nm90o=;
 b=WkCb4avIN2gR4crTGPe2ItD3DFF3OQXnfysHExHBz2L/FcQYV7wqKwhvABC9Vv69+x
 ZYTlEUYaTgPTP01+Q0jAXHFMxcpUUeO2twnPMds6wOLfnDLpLGxBgbGyHX4cNbjvQ3vI
 oGWOgKe1FzKMqf8qM35ZiXkW0kvTlO7D2FaNLzRAXwubTzUvPv5cfN5kel6qXeZnVPO3
 oW+FxUk/nBJB6aota0VzuwbBZGClNMK57yNJKLOcwTYC2P1U6MgF2encJUh+4yGn0h7g
 Py8jVG+sXOeDl8pwvTxsG5WOU5bv6FqjuUhnXZVvp9pJCsO77CBJjrfbnYTgU4zeiOd9
 z88g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5KZU1//uAKUNNK2ntcQhlRrzpFsHbx40VqnEpfCsGhH8ZL2+1bl5OASxOR8wX9CbIPXg9FlanoMwi@nongnu.org
X-Gm-Message-State: AOJu0YzayVoe1WC9zycbblHc2y3BTbdNf3bPjwNqYiDUc6RaOeYB+UPa
 wtOvG6SlY87LHqA7X4hAhZEhzoTacP80JNrlQWU/cjME4RxdnpyrESsZsHuOPxt6cvs=
X-Gm-Gg: ATEYQzwcsKmvf+ZkiHZhE/QSlpelsWA7D5SZx+6tGj6lyzyqAu7893zEz3SXcSnTCrg
 lcujX/048FaWtjDkzH2Kwy1qVhuMdxWS7/Bcy3v5gFmwHciq/MYbsZzEVWV9UBgASmkCliVnCxM
 +4zwdAmwc3Zu0PdyIRJXqBinIcwQu3jfMy8p4wGQktshXZ5GUapAYhlgE7k9233LiK5yfzW2R5z
 Vk0CO3U2Y/8cRBFmnTezDF0/G9KCRDONF0ddM1QaJDSICPCfCEaKJbVyHEAR/xFZNfDa/V/bR0F
 HF+eyQwkLnlPxAwFrcl+bzGLDpl2ReFCn/8x+Va9cy6LgFavuAABTJd4OLm/AZwYsx8zHTFzhqu
 mZa4SbVAwNnC2e8/wKEGvmxhU24lmwPdzN4URO3SzPnT55serYo80lJgob2E60gW3FJInPvINVA
 KrsLYMHO5tP1SL3dCjx2zxulhAAgTBUHPKCbJ7o3izhgrjfqLJeVrca4EjmmtlRoLypg==
X-Received: by 2002:a05:600c:8b45:b0:47d:8479:78d5 with SMTP id
 5b1f17b1804b1-4854b0ac451mr36311635e9.7.1773230970517; 
 Wed, 11 Mar 2026 05:09:30 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439f8200606sm5214253f8f.27.2026.03.11.05.09.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Mar 2026 05:09:30 -0700 (PDT)
Message-ID: <28989705-0466-477a-8299-569d434edb54@linaro.org>
Date: Wed, 11 Mar 2026 13:09:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/9] target/riscv: Add big-endian CPU property
Content-Language: en-US
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20260311115910.564481-1-djordje.todorovic@htecgroup.com>
 <20260311115910.564481-4-djordje.todorovic@htecgroup.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260311115910.564481-4-djordje.todorovic@htecgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 11/3/26 12:59, Djordje Todorovic wrote:
> Add a "big-endian" boolean property to the RISC-V CPU configuration,
> defaulting to false (little-endian). This property allows machine
> models to configure individual HARTs for big-endian data operation.
> 
> The RISC-V ISA supports big-endian data accesses via the mstatus
> SBE/MBE/UBE bits, while instructions remain always little-endian.
> This property provides the configuration interface; subsequent
> patches will connect it to the CPU state and translation logic.
> ---
>   include/qemu/target-info.h        | 9 +++++++++
>   target-info-stub.c                | 8 +++++++-
>   target/riscv/cpu.c                | 6 ++++++
>   target/riscv/cpu_cfg_fields.h.inc | 1 +
>   4 files changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
> index 23c997de54..1701cc1c9d 100644
> --- a/include/qemu/target-info.h
> +++ b/include/qemu/target-info.h
> @@ -50,6 +50,15 @@ const char *target_cpu_type(void);
>    */
>   bool target_big_endian(void);
>   
> +/**
> + * target_set_big_endian:
> + * @big_endian: the new endianness setting
> + *
> + * Set the target endianness at runtime. Used by bi-endian targets
> + * (e.g. RISC-V) where data endianness is a runtime CPU property.
> + */
> +void target_set_big_endian(bool big_endian);
> +
>   /**
>    * target_base_arm:
>    *
> diff --git a/target-info-stub.c b/target-info-stub.c
> index f5896a7262..b6532c419a 100644
> --- a/target-info-stub.c
> +++ b/target-info-stub.c
> @@ -22,7 +22,7 @@ QEMU_BUILD_BUG_ON(offsetof(ArchCPU, env) != sizeof(CPUState));
>   QEMU_BUILD_BUG_ON(TARGET_PAGE_BITS < TARGET_PAGE_BITS_MIN);
>   #endif
>   
> -static const TargetInfo target_info_stub = {
> +static TargetInfo target_info_stub = {

NAck. This structure must stay const. (this change isn't even
documented / justified).

What is the problem you are trying to resolve here?

>       .target_name = TARGET_NAME,
>       .target_arch = glue(SYS_EMU_TARGET_, TARGET_ARCH),
>       .long_bits = TARGET_LONG_BITS,
> @@ -44,3 +44,9 @@ const TargetInfo *target_info(void)
>   {
>       return &target_info_stub;
>   }
> +
> +void target_set_big_endian(bool big_endian)
> +{
> +    target_info_stub.endianness = big_endian
> +        ? ENDIAN_MODE_BIG : ENDIAN_MODE_LITTLE;
> +}
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index e56470a374..305a8d73ad 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -34,6 +34,7 @@
>   #include "system/device_tree.h"
>   #include "system/kvm.h"
>   #include "system/tcg.h"
> +#include "qemu/target-info.h"
>   #include "kvm/kvm_riscv.h"
>   #include "tcg/tcg-cpu.h"
>   #include "tcg/tcg.h"
> @@ -941,6 +942,10 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
>           return;
>       }
>   
> +    if (cpu->cfg.big_endian) {
> +        target_set_big_endian(true);
> +    }
> +
>       riscv_cpu_register_gdb_regs_for_features(cs);
>   
>   #ifndef CONFIG_USER_ONLY
> @@ -2641,6 +2646,7 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
>   
>   static const Property riscv_cpu_properties[] = {
>       DEFINE_PROP_BOOL("debug", RISCVCPU, cfg.debug, true),
> +    DEFINE_PROP_BOOL("big-endian", RISCVCPU, cfg.big_endian, false),
>   
>       {.name = "pmu-mask", .info = &prop_pmu_mask},
>       {.name = "pmu-num", .info = &prop_pmu_num}, /* Deprecated */
> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
> index 70ec650abf..51436daabf 100644
> --- a/target/riscv/cpu_cfg_fields.h.inc
> +++ b/target/riscv/cpu_cfg_fields.h.inc
> @@ -154,6 +154,7 @@ BOOL_FIELD(ext_xmipscbop)
>   BOOL_FIELD(ext_xmipscmov)
>   BOOL_FIELD(ext_xmipslsp)
>   
> +BOOL_FIELD(big_endian)
>   BOOL_FIELD(mmu)
>   BOOL_FIELD(pmp)
>   BOOL_FIELD(debug)


