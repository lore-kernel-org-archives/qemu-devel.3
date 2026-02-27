Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EA03104891E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 23:01:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw6od-0004sN-IA; Fri, 27 Feb 2026 18:00:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vw6oc-0004rl-1g
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 18:00:10 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vw6oa-0006JU-8N
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 18:00:09 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-48069a48629so27382785e9.0
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 15:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772233206; x=1772838006; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=o9Ks98ZNloGmG6DU0aYfv8Is98tsLjcjELiRaXehnTI=;
 b=iqiMck8XY2EQ3mTvqAnJ/+l2HsQrjgFUmGGGKesPEuxcAbTV5DYyxtdUUFjgdLubGY
 7c1G/XJhyUcjfAd6eW2f0UkzZH+73MK9H+f8VXzSr2vzQfECKbYjAMB1775/Wmsv4BOc
 aqjpHKTtU23ZeTBrirVCc/CvEG05G41DZxGnCUw9e7FuiGMKvIex2AGbK1aP6Z3n2qNw
 8xHIuLtFp1MAcNoeohvefYtHSGhBn+0mhHrLjp0XlWCHwsZHgEqBvLFuDiJUQ2gilZLn
 PdYbPodruy7pKIcCWdHjfu7+hy2fQUOm6yHr6NvkTS/BS/lQCZ09P7uob8ew+wliI58i
 Bueg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772233206; x=1772838006;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o9Ks98ZNloGmG6DU0aYfv8Is98tsLjcjELiRaXehnTI=;
 b=VH/cBivt9S6aRFe3lWYVBDbo0Y+LEroqwWrEXFsGkCixitUTainZQfocHvSnf/p49D
 OEknvxlLUpGq+SABgt2cSmzldzfVEfYuvnjtXa8l0KllISt0F4WivzjG4izUBSyGrpCy
 NH0gkG5YzwjTtUMo2D60+N6/BytrruVCukX0w6NILk4IWaZgjuKkdOamuv2aSljp9VAb
 UzAVy9Ie8N6ptsErGflDvaEeVL+pvUtnl0JHmt8wznISGmygDshlZe8NkxNzEmwAy9oe
 O02xaz5t7i/FgUhr//fwv0TApAOEtM0/7644d+IdYTssHzxJkWpIwpZA0c6b/zRdRpq/
 mh6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU72l7H0LHRpxubaiqMO3s9krmNBmdUZYrE8RD3BiHlZzBkFCOk2fIvNa4DKOskZ9eOs85Gf64oeqRc@nongnu.org
X-Gm-Message-State: AOJu0YwPEtye6Y+EdjUvo8WK4g5f61K4zLap16HjfX2NhQaocXTiHP9I
 F1G4ifsiIcLzq2UG/5YVxRZfi5q8y+7Q6KCUTMHu6geYJtZ5aiu40f3QUiRnp+EYMpU=
X-Gm-Gg: ATEYQzw4wD0J7pG+jCV827/HYDNzqY8teApVlUW5XFhcqTN6BpqEnF7O1X1n5L3DAkR
 TRpAhlRsDBOy11ROZwRncMx4vjGsN4YQwtjowUcxODK127lGFU1XmjDwg/eM3LKsKmIEw6rTpz+
 t0d5Xeu1YUDa4BWAYX3LiLMVLXFO4oUBbm1PdqPqtGYuMoVGuCa7gs/6Yo9YhnN638WDXmmB500
 ADr/Vf/IROg1egU5VowhVtmY2uMx3ajTS83tTBPATR2AueyLUR1Lic9UVLtSZySiEIh0Fkyijo4
 pBS55X9bA9WgG2DRwJtJLpE1im9x1Dzgd6n9Na3h8KU4ATcW6eRoybC277W5vMrKb7GiZI1QAeS
 1jASE8azP1M3HPD/9nQKFTA8QaOll51tzFRCze99Lv56nQMMQNuFxg/Fus1PCgB+jUaZ0afPxQX
 Q4ToRxO2N+X+V4DLHkkYuSH6negh0Nk0Otzta6pxLrt7yFoyC8BfXQpFr+jGMrAEl2Rg==
X-Received: by 2002:a05:600c:1f83:b0:483:8062:b43 with SMTP id
 5b1f17b1804b1-483c9c031e6mr84172795e9.19.1772233205900; 
 Fri, 27 Feb 2026 15:00:05 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c76c49fsm10259404f8f.38.2026.02.27.15.00.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Feb 2026 15:00:05 -0800 (PST)
Message-ID: <a8e08773-6f21-409f-91aa-6283f696019e@linaro.org>
Date: Sat, 28 Feb 2026 00:00:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/16] target/riscv: Fix PTE A/D atomic update
 endianness
Content-Language: en-US
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>
References: <20260225102016.200654-1-djordje.todorovic@htecgroup.com>
 <20260225102016.200654-14-djordje.todorovic@htecgroup.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260225102016.200654-14-djordje.todorovic@htecgroup.com>
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

On 25/2/26 11:20, Djordje Todorovic wrote:
> From: djtodoro <djordje.todorovic@htecgroup.com>
> 
> Use tswap32/tswap64 instead of hardcoded cpu_to_le32/le64 for PTE
> atomic compare-and-swap updates, so the encoding matches how PTEs
> are read via address_space_ldl/ldq (target endian).
> ---
>   target/riscv/cpu_helper.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index dd6c861a90..f6990b2dfa 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -37,6 +37,7 @@
>   #include "debug.h"
>   #include "pmp.h"
>   #include "qemu/plugin.h"
> +#include "exec/tswap.h"
>   
>   int riscv_env_mmu_index(CPURISCVState *env, bool ifetch)
>   {
> @@ -1567,11 +1568,11 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
>               target_ulong *pte_pa = qemu_map_ram_ptr(mr->ram_block, addr1);

Should we use address_space_ld[l/q]_le() with the HART AS (via @env)
here instead of accessing the RAMBlock manually?

>               target_ulong old_pte;
>               if (riscv_cpu_sxl(env) == MXL_RV32) {
> -                old_pte = qatomic_cmpxchg((uint32_t *)pte_pa, cpu_to_le32(pte), cpu_to_le32(updated_pte));
> -                old_pte = le32_to_cpu(old_pte);
> +                old_pte = qatomic_cmpxchg((uint32_t *)pte_pa, tswap32(pte), tswap32(updated_pte));
> +                old_pte = tswap32(old_pte);
>               } else {
> -                old_pte = qatomic_cmpxchg(pte_pa, cpu_to_le64(pte), cpu_to_le64(updated_pte));
> -                old_pte = le64_to_cpu(old_pte);
> +                old_pte = qatomic_cmpxchg(pte_pa, tswap64(pte), tswap64(updated_pte));
> +                old_pte = tswap64(old_pte);
>               }
>               if (old_pte != pte) {
>                   goto restart;


