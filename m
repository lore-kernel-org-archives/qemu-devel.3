Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A976AF327A6
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 05:48:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wF3xl-0008CG-1d; Tue, 21 Apr 2026 01:47:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wF3xh-0008BS-F2
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 01:47:53 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wF3xf-0001CJ-No
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 01:47:53 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-43cf7683a28so2547502f8f.2
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 22:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776750469; x=1777355269; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=R8OedVllihglM+y9ap3EYInstQNG4ta9jLhH5XuJjGw=;
 b=SLCCKum/JadZ51IBvMBQMiuKH2y0E8y2NxfZwACpUzjhJ/PX08i8xhxSBfSXitY0tI
 +Nh0d6yGDLM5IezCuX7H+w5+LGS0FG1kxmdiRSbpeODIAXzbJCDkcrPD+OCRUPBtt/Pg
 GZhtD/9lT787QChv/Vjqd2CulDho1lZY4uGvCikrqeCPz4UBO4grAr6PtMcnPZdVzskV
 HVTdCmf2nTulPJq7JGp8b0w3PTERO/Tq64xJt8wkGXzo8zCpEY4t8DEmbAtIdzFdSnMP
 S++E/+aSGwJ3G3IffYonBD8xLPtW1swDCKHMJVOPRR1u6+Cg1GcHcPw7IfGGnKcrJFev
 bqXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776750469; x=1777355269;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R8OedVllihglM+y9ap3EYInstQNG4ta9jLhH5XuJjGw=;
 b=HUgMBv/34OEkZtaH8jxnvRtLDQBLWScmeP2L0L6bIBzcswA80K61fXxhVOcleZdMpc
 qcrQmN4EomUjFZ6CjYYqi/3OXK9dRCDSdW0Kcb/qP3sK5SE7KYH7nIBhlWlVWGY+hSvB
 /3D7eqC5NdwzEuAabID/6ekbXtUOKSPKaicVdY4EntC84W33LtYAu2TJagqPbR5MflBx
 kTT7ixZSE5HNRrENaWVadoytkX0fqpVMXM9T0WHF5Ziinhmsmyd6NyvXU9JLKFDrFCil
 /vOTK9mfGSLr7UkaNO0TiSccmyFC+wcxx4U7QGnblymd9DuN2lbxDMgRNSKnjSubyl7T
 gd7w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Mlu6mh+w1aiIjkuNymVAMsQQMRYPj/KYAPQkdyzGOH6+puJPgy6Vdh/xqj20ZSzRhR/HuLsJ7dfMj@nongnu.org
X-Gm-Message-State: AOJu0YyV8lP8cJISXBqhlTz/EOsJEcnT07af+mDCoDRv13SwkKw8W0XV
 vTfM2me0o8fqHL8ZoL80eoqLt7rp1A7zjzh2PR/XTuNRqYCJitvFYTJeoljTfqAZIRk=
X-Gm-Gg: AeBDiesTrKu9zJrMwKb4Ea6OxF//inOS4MOa448xjZBXwMrPCWbGI4DwnQZ1aFJScdy
 e5Sq+5Eb08eaGP2lsXwZZl/+LMq5wgeZSsssB+8IoycSBJcc+E77v+72LUUoXr5BP46PmIpvsXk
 rrE33Glnv6Q3+d29NmWqM3e6cOpZfZKVu1seyQMXsiRxg6IdTdIdacvOgyqrzz3/uN3LkIxnniU
 5jI1YGtouHPAUu9/wWNjYAIeUG0BVXN70pQ8/FB2+uD6xc+m4IYduU4gl/xWV712IaM3IrhT7h6
 NCzzZYikFIIWbSwOiw4kjpJSboRXT7nCK44dwo4nFuVQcuj7cfKrs3OKDnJhNGeUtrvvgy4yYeZ
 LJteBjTfdO1EGVkiYumyexqHC7dGMMXEQ01HMmQaQuiPEaHrFooN5quUu19KuF9iBzOVH1dZMaC
 SyFFCQF0WFYSHWnIeDdzt95VfbJArjxAB1c/mETLr//pPABNLwsW6m2I4yJbU1I6265m6q8+l7k
 gw1
X-Received: by 2002:a05:6000:178a:b0:43d:a58:b076 with SMTP id
 ffacd0b85a97d-43fe3e1e252mr26382243f8f.44.1776750468492; 
 Mon, 20 Apr 2026 22:47:48 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4cb11b4sm35518745f8f.2.2026.04.20.22.47.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Apr 2026 22:47:47 -0700 (PDT)
Message-ID: <9dde1635-ea18-4abd-8ce5-24ac73f21198@linaro.org>
Date: Tue, 21 Apr 2026 07:47:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/13] hw/riscv/boot: Account for discontiguous memory
 when loading firmware
To: Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@kernel.org>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
References: <20260421053140.752059-1-joel@jms.id.au>
 <20260421053140.752059-4-joel@jms.id.au>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260421053140.752059-4-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 21/4/26 07:31, Joel Stanley wrote:
> From: Nicholas Piggin <npiggin@gmail.com>
> 
> This loads firmware into the first (low) memory range,
> accounting for machines having discontiguous memory regions.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
> v3: Call riscv_boot_info_init before riscv_find_and_load_firmware in
>      sifive_u
> ---
>   include/hw/riscv/boot.h    |  5 ++++-
>   hw/riscv/boot.c            | 18 ++++++++++++------
>   hw/riscv/microchip_pfsoc.c |  6 ++++--
>   hw/riscv/opentitan.c       |  6 ++++--
>   hw/riscv/shakti_c.c        |  6 +++++-
>   hw/riscv/sifive_u.c        |  6 ++++--
>   hw/riscv/spike.c           |  6 ++++--
>   hw/riscv/virt.c            |  7 ++++---
>   hw/riscv/xiangshan_kmh.c   |  6 +++++-
>   9 files changed, 46 insertions(+), 20 deletions(-)
> 
> diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
> index 115e3222174f..fb90bf12399e 100644
> --- a/include/hw/riscv/boot.h
> +++ b/include/hw/riscv/boot.h
> @@ -53,13 +53,16 @@ void riscv_boot_info_init_discontig_mem(RISCVBootInfo *info,
>   vaddr riscv_calc_kernel_start_addr(RISCVBootInfo *info,
>                                      hwaddr firmware_end_addr);
>   hwaddr riscv_find_and_load_firmware(MachineState *machine,
> +                                    RISCVBootInfo *info,
>                                       const char *default_machine_firmware,
>                                       hwaddr *firmware_load_addr,
>                                       symbol_fn_t sym_cb);
>   const char *riscv_default_firmware_name(RISCVHartArrayState *harts);
>   char *riscv_find_firmware(const char *firmware_filename,
>                             const char *default_machine_firmware);
> -hwaddr riscv_load_firmware(const char *firmware_filename,
> +hwaddr riscv_load_firmware(MachineState *machine,
> +                           RISCVBootInfo *info,
> +                           const char *firmware_filename,
>                              hwaddr *firmware_load_addr,
>                              symbol_fn_t sym_cb);

Except in _init(), this structure should be const, so preferably
'const RISCVBootInfo *info'. Can be done on a cleanup patch of
course.

