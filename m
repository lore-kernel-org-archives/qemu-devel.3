Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A39F6CF45D5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 22:43:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfQcs-0003uK-L5; Mon, 12 Jan 2026 17:43:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQcr-0003tM-Mm
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:43:05 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQcq-0001XY-0b
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:43:05 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-430f57cd471so3423360f8f.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 14:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768257782; x=1768862582; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fv85atVjcLmPGtEGVqXBgFWkBkwpFvu4smo66CFa4Xg=;
 b=samSIi2DTSA//+3CabshN8iPXR7ttrZC5HcQaT9e2UN1OlfLFvnDChtyasvy5ISl3O
 07YkxLnLIFBabBSs5b/2m/LB4gJAlFypYJL8tdhfvbEqpoKIZKjyuVTyQwLIgEhnHmN4
 CyqpdEgIa45hsnR1ZeCQ+nNDjDulRZaNMTN61WmauYHmIckCAct+IVBzyFaZ/8XAsyRP
 GwsJCCzoi8/4WjdHCx1V8eTbbBga1Jm/v6Nf3EcBbVs/DLtwUiN8lfcBwUNM9ab2KjTM
 aNcxvZ3ujdlFRTHSb1sTnnfRvvxzVZNwP1XYRj+G4CMQ/RD2WA+7npT0AnQ8JhgDeCyw
 p3RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768257782; x=1768862582;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fv85atVjcLmPGtEGVqXBgFWkBkwpFvu4smo66CFa4Xg=;
 b=k8dgHHfaUpfVAxGS2DTU0/JwbuWCFZB/GkAhkrXpPHxgR+Bse7ZJiU0uLfC7hDJGK0
 vj03svk8OKNl9Dg6RE3taAN6f505ObPEAP5ioVmgtJodCz19Cwj7rn7/NFCHVJjyVqDJ
 doNauo6fZbLf2YnHxnvaMnyTxsb+Wm+zOed1KxwyB6x0XpxSxLOtpXuvsPpE/zUDnpkr
 iGskMm53Q1PHfUanXTq4vFLYtKL/gOPGk5wbWPjWOM895M3vLbi7SwTKr73qBW6kwZVd
 FNEPoQ+gEfjDSUJQKb3b5fJuP8Ui0pP0kItHQmNNY5L5cQMBeoI9oKRlczDq3Nsnz6uS
 swRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8OzpLY/Iq3Mf8onIxHPF1pjnbX9dwHF9+KiVjtreT5XXeCtcorjEy5qdkg7gGNPy5NyuYrb8TK+oq@nongnu.org
X-Gm-Message-State: AOJu0YxpcWFUvtab0nmoQlGiSASwkWzeXTJej2+xQE4XdZ3X2FyWfvZ4
 YxfAo2imaljpbSAR5W1286EAw60XzL+rAM9qZzNYZFAwJmrWetaBEDJI3PltSWkTE5k=
X-Gm-Gg: AY/fxX6P6tj80rel1GThX9eoApitThwhCklLyF6FLNzYhWpuxo6/CgGFE52+KndJQxN
 RNpC24E2Gb9lnyYgIPGsCaBavqh2P5s/PhNfpHtqM0SK4jyYvPdnNHasHahu0ggny3YN4Sob2xK
 OL8oGYotJ8YyaXRshbf9SEUUdaUPtdWVNDBUUPoiR6UU83z70EaI9pjHM3w5FQmV+vv8P9P4Djb
 TJ2AZScHAQ6SRJQ5UDfqsSLBeZ8M0OPIoY55Y9qpgmOE/Ze1onxUTLw7DDfU9Z1ZIgGFhkHqJzs
 KR0N28umPQdvkso+QPiz3vsVBTaOPh7CFk5yEjGWuYO/fenJe6TRmO8TQa0oxreNL26Ys7Iytzv
 dbPADmGS/5z2HkpridY3fzZp+xt1i3WPPm0aywYzeOVcayMuqvTJ8meD9A29vKbGPDdX4ea95o5
 G52tyAAXF3uUAgJp42FPlVyy8TxMxuXH1hpfJzMyCbVQTogSq0dOZGcQ==
X-Google-Smtp-Source: AGHT+IGzYnhyRyXvET05JE1mtc+zybcNdP4CQH174Km2AkC3lssB+T7Vg5zSLjPNNPOsVn2iSC9xmQ==
X-Received: by 2002:a05:6000:188e:b0:430:f2ee:b220 with SMTP id
 ffacd0b85a97d-432c3632beemr26044580f8f.19.1768257782193; 
 Mon, 12 Jan 2026 14:43:02 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0e16f4sm41762598f8f.11.2026.01.12.14.43.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 14:43:01 -0800 (PST)
Message-ID: <a96d6954-4242-4358-ad85-cc170749e736@linaro.org>
Date: Mon, 12 Jan 2026 23:42:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/7] target/hppa: Define PA[20|1X] physical address
 space size
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org,
 Helge Deller <deller@gmx.de>
Cc: Richard Henderson <richard.henderson@linaro.org>, palmer@dabbelt.com,
 alistair.francis@wdc.com, pbonzini@redhat.com, gaosong@loongson.cn,
 maobibo@loongson.cn
References: <20260112-phys_addr-v3-0-5f90fdb4015f@rev.ng>
 <20260112-phys_addr-v3-2-5f90fdb4015f@rev.ng>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260112-phys_addr-v3-2-5f90fdb4015f@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 12/1/26 13:22, Anton Johansson wrote:
> When converting virtual to physical addresses,
> TARGET_PHYS_ADDR_SPACE_BITS is used under PA-RISC 2.0, and an explicit
> cast to uint32_t is used under PA-RISC 1.X.  Replace the former with a
> more specific macro limited to mem_helper.c, and make the latter
> conversion explicit by defining the size of the physical address space
> for PA-RISC 1.X.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/hppa/mem_helper.c | 23 ++++++++++++++++++-----
>   1 file changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
> index cce82e6599..8563bb0e2a 100644
> --- a/target/hppa/mem_helper.c
> +++ b/target/hppa/mem_helper.c
> @@ -29,6 +29,19 @@
>   #include "hw/core/cpu.h"
>   #include "trace.h"
>   
> +/*
> + * 64-bit (PA-RISC 2.0) machines are assumed to run PA-8700, and 32-bit
> + * machines 7300LC.  This gives 44 and 32 bits of physical address space
> + * respectively.
> + *
> + *   CPU model        Physical address space bits
> + *   PA-7000--7300LC  32
> + *   PA-8000--8600    40
> + *   PA-8700--8900    44
> + */
> +#define HPPA_PHYS_ADDR_SPACE_BITS_PA20 44
> +#define HPPA_PHYS_ADDR_SPACE_BITS_PA1X 32
> +
>   hwaddr hppa_abs_to_phys_pa2_w1(vaddr addr)
>   {
>       /*
> @@ -42,8 +55,8 @@ hwaddr hppa_abs_to_phys_pa2_w1(vaddr addr)
>        * Since the supported physical address space is below 54 bits, the
>        * H-8 algorithm is moot and all that is left is to truncate.
>        */
> -    QEMU_BUILD_BUG_ON(TARGET_PHYS_ADDR_SPACE_BITS > 54);
> -    return sextract64(addr, 0, TARGET_PHYS_ADDR_SPACE_BITS);
> +    QEMU_BUILD_BUG_ON(HPPA_PHYS_ADDR_SPACE_BITS_PA20 > 54);
> +    return sextract64(addr, 0, HPPA_PHYS_ADDR_SPACE_BITS_PA20);
>   }
>   
>   hwaddr hppa_abs_to_phys_pa2_w0(vaddr addr)
> @@ -67,7 +80,7 @@ hwaddr hppa_abs_to_phys_pa2_w0(vaddr addr)
>            * is what can be seen on physical machines too.
>            */
>           addr = (uint32_t)addr;
> -        addr |= -1ull << (TARGET_PHYS_ADDR_SPACE_BITS - 4);
> +        addr |= -1ull << (HPPA_PHYS_ADDR_SPACE_BITS_PA20 - 4);
>       }
>       return addr;
>   }
> @@ -217,7 +230,7 @@ int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
>               if (hppa_is_pa20(env)) {
>                   phys = hppa_abs_to_phys_pa2_w0(addr);
>               } else {
> -                phys = (uint32_t)addr;
> +                phys = extract64(addr, 0, HPPA_PHYS_ADDR_SPACE_BITS_PA1X);
>               }
>               break;
>           default:
> @@ -558,7 +571,7 @@ static void itlbt_pa20(CPUHPPAState *env, target_ulong r1,
>       /* Align per the page size. */
>       ent->pa &= TARGET_PAGE_MASK << mask_shift;
>       /* Ignore the bits beyond physical address space. */
> -    ent->pa = sextract64(ent->pa, 0, TARGET_PHYS_ADDR_SPACE_BITS);
> +    ent->pa = sextract64(ent->pa, 0, HPPA_PHYS_ADDR_SPACE_BITS_PA20);
>   
>       ent->t = extract64(r2, 61, 1);
>       ent->d = extract64(r2, 60, 1);
> 

Patch LGTM but fails on CI on 2 distinct jobs...

166/793 func-quick+func-hppa - qemu:func-hppa-seabios 
          TIMEOUT         90.05s   killed by signal 15 SIGTERM

209/276 qemu:func-quick+func-hppa / func-hppa-seabios 
                      TIMEOUT         180.04s   (exit status 143 or 
signal 15 SIGTERM)

Works with:

-- >8 --
diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index 40d28435aa8..e7a26398c5a 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -82,3 +82,3 @@ hwaddr hppa_abs_to_phys_pa2_w0(vaddr addr)
          addr = (uint32_t)addr;
-        addr |= -1ull << (TARGET_PHYS_ADDR_SPACE_BITS - 4);
+        addr |= -1ull << (HPPA_PHYS_ADDR_SPACE_BITS_PA20 - 8);
      }
---

PA-8000--8600 case with 40 bits?

