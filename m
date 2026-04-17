Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15635F4368A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 10:14:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDgDN-0006Q8-Ju; Fri, 17 Apr 2026 06:14:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDgDL-0006Ps-OQ
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 06:14:19 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDgDJ-000122-TZ
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 06:14:19 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-43d43e09de5so278514f8f.1
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 03:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776420856; x=1777025656; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=k33/9nrABq1Qa6/alBsId1LxOaZ5spKdpRIQfsn+1dw=;
 b=x91wMKk/d2dtk6UZmWIpADthD6t5Aas048lfgHBmRL+4DdBAXk36gAWNAxj+4j+GWL
 nSUrq5q318XNwrFnoHNMQNqqyXA7/aALd4yR4M+QkRKndxAMO3JWK3j8wNNCU6nuc6/P
 jbIyepFnTCMATh6Q2eaew/I1PZydIr4fPbdZp6kcCSA5GDb3ge7TZqZlUFql94e2KGpE
 etO4gFBgo9PL33adsX3ueXI5VBQ/74gx+pRVVlK5q0Qqg5PcvQJaxO1ns2KFXKLChZee
 qhfSx2GRzKshkNgB6syhVlf67I29iZ+XTDzPupBJxiAQdkXB6xQUAcd7OkjExdp6MIWu
 nf7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776420856; x=1777025656;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k33/9nrABq1Qa6/alBsId1LxOaZ5spKdpRIQfsn+1dw=;
 b=XW2SD0vve4+Ehmwr8oUS2IvwxiwmJfwIwrpoZb7GII16KACZS2JX1GPXHJ3sSui3jY
 89mkCZd5glcWEI9FCEgFgnzb/Jws+W7GXbhoq9DYrEuzhx31hZiZyQWAvUjoOhdM37el
 m2fUSqZWGz4c2W09GcynrkOlfHDVkBlaH64m5eEo5/dJveSKIC4kp5G9veUxT3sSZKoO
 ksSKELm9iWHpHxeLvmwWNGEbPNVPdqciKGob0Twuk0+K+ph+AuYYalVQyjMjVrDgUnfW
 d82Fs7IZW9bkNC3o0bnkDciNs6illvD33zLFTAuqib+LPT1II1xukXiBQE3rcxOjOHbD
 Dnqg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+1rVQOGKAMMEIkfYmxIEBOxI/f9IlqvQrF9BgSV6Pfo0pdOoUWcatAx7oQqR5NXR74VxZIEXalssXN@nongnu.org
X-Gm-Message-State: AOJu0YwPi5PcWmnNvEXceW+jazs5jhAPfjJIlN6hJD7am8glgCE65Pp8
 LdwYVhxiS7kWEO3hPJljozRd4tqyS2CAH300DwMGzG6EdCUax4mS/avFltjgSnmLt18=
X-Gm-Gg: AeBDies1pnXE8hc9L5rDJ7+WJALsJ+Wb57dlSE9MMddtDMCRpfWB0jLeWkQhPZkYzdB
 z1VactsQ8rPdglZbcUCmdoewgSpM7MfKTnrZXDIBsuyPRtQk0wvo3MRNWR/lWTJdBz39Cy9zscY
 XJsSalRVqK5sb+akOX0WP7qsW8pm7hxdYoIRyKEqk94VJ5G8Cr4N24KqPfU/HlAUighfUjobXZW
 pvcirAm7hcer10bFH+QMxYVfpfN0Dkrtqkt+Au55/n/vi+2stJSMyKgBhcmwCKmLuS4HPp4xYkX
 HunBAY00FzAdjFGw6H5voKujCFAEbkQCvOCVHrm/cHCEKdn9+fgTYV5zCazqKurycpgKA5O09Ky
 1oMez7dWRaMNxDVU3j89WJFTYxCynis9exOzGG+crP+J0QpP+P+ipzCLLJYwjOuT8SQhYptZQAL
 h76wek/6PqceNDtcjZYL+Vg7aVwIgIiYQQnvYXonQlB5jzQvpcW2V+uKOIKxyE5vA7Fg7dTsoJl
 zcAgmjHCOzxNzg=
X-Received: by 2002:a05:6000:1a8e:b0:43d:30af:a173 with SMTP id
 ffacd0b85a97d-43fe3dbd824mr3324471f8f.5.1776420855711; 
 Fri, 17 Apr 2026 03:14:15 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4cb13a0sm3492270f8f.8.2026.04.17.03.14.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Apr 2026 03:14:14 -0700 (PDT)
Message-ID: <8fda6a95-3a39-489f-9be0-8895c5016835@linaro.org>
Date: Fri, 17 Apr 2026 12:14:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/6] target/riscv: Add big-endian CPU property
Content-Language: en-US
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Chao Liu <chao.liu.zevorn@gmail.com>
References: <20260417100302.162260-1-djordje.todorovic@htecgroup.com>
 <20260417100302.162260-3-djordje.todorovic@htecgroup.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260417100302.162260-3-djordje.todorovic@htecgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 17/4/26 12:03, Djordje Todorovic wrote:
> Add a "big-endian" boolean property to the RISC-V CPU configuration,
> defaulting to false (little-endian). When enabled, this models a
> big-endian-only RISC-V implementation as described in section 3.1.6.5
> of the RISC-V Privileged Specification ("Memory Endianness"), where
> the MSTATUS MBE/SBE/UBE bits are hardwired to 1.
> 
> This is a static, per-CPU hardware configuration option, not a runtime
> switch. It is intended for modeling RISC-V CPU variants whose data
> endianness is fixed to big-endian at the hardware level. Instructions
> remain little-endian regardless, per the RISC-V ISA specification.
> 
> When cfg.big_endian is set, riscv_cpu_reset_hold() writes 1 into the
> MSTATUS UBE/SBE/MBE fields; otherwise it writes 0. The assignment is
> done with set_field() so the reset value is deterministic on both
> cold and warm reset, rather than depending on the pre-reset state.
> The MBE/SBE/UBE bits are not included in the writable mask of any
> mstatus/mstatush/sstatus CSR write path, so the value chosen at reset
> effectively hardwires them. The actual effect of those bits on data
> accesses, page-table walks and boot code is implemented by the
> subsequent patches in this series.
> 
> Also update the disassembler comment to clarify that BFD_ENDIAN_LITTLE
> is correct because RISC-V instructions are always little-endian per
> the ISA specification.
> 
> No upstream CPU currently defaults to big-endian; the property can be
> enabled from the command line, e.g.:
> 
>      -cpu <cpu>,big-endian=on
> 
> Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
> Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
> ---
>   docs/system/target-riscv.rst      | 24 ++++++++++++++++++++++++
>   target/riscv/cpu.c                | 11 ++++++-----
>   target/riscv/cpu_cfg_fields.h.inc |  1 +
>   3 files changed, 31 insertions(+), 5 deletions(-)
> 
> diff --git a/docs/system/target-riscv.rst b/docs/system/target-riscv.rst
> index 3ad5d1ddaf..7798184ebe 100644
> --- a/docs/system/target-riscv.rst
> +++ b/docs/system/target-riscv.rst
> @@ -95,3 +95,27 @@ the images they need.
>   * ``-bios <file>``
>   
>   Tells QEMU to load the specified file as the firmware.
> +
> +RISC-V CPU endianness
> +---------------------
> +
> +The RISC-V ISA specifies that instruction fetches are always little-endian,
> +while data accesses can be either little-endian or big-endian under control
> +of the MSTATUS ``MBE``/``SBE``/``UBE`` bits (see section 3.1.6.5, "Memory
> +Endianness", in the RISC-V Privileged Specification).
> +
> +QEMU implements the full data-endianness behaviour described by those bits.
> +In addition, the RISC-V CPU object exposes a ``big-endian`` boolean property
> +which models a big-endian-only hardware implementation, where the
> +``MBE``/``SBE``/``UBE`` bits are hardwired to 1. When the property is set,
> +the CPU is reset with all three bits initialised to 1, so the guest starts
> +executing in big-endian data mode from the reset vector. The property is a
> +static, per-CPU hardware configuration option and is not meant to be toggled
> +at runtime.
> +
> +The property can be enabled from the command line, for example::
> +
> +    -cpu <cpu>,big-endian=on
> +
> +No upstream CPU model currently defaults to big-endian; the property is
> +provided so that big-endian-only RISC-V CPU variants can be modelled.

This doc ...

> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index e56470a374..c39500cb3f 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -716,6 +716,9 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
>               env->mstatus = set_field(env->mstatus, MSTATUS_MDT, 1);
>           }
>       }
> +    env->mstatus = set_field(env->mstatus, MSTATUS_MBE, cpu->cfg.big_endian);
> +    env->mstatus = set_field(env->mstatus, MSTATUS_SBE, cpu->cfg.big_endian);
> +    env->mstatus = set_field(env->mstatus, MSTATUS_UBE, cpu->cfg.big_endian);
>       env->mcause = 0;
>       env->miclaim = MIP_SGEIP;
>       env->pc = env->resetvec;
> @@ -803,11 +806,8 @@ static void riscv_cpu_disas_set_info(const CPUState *s, disassemble_info *info)
>       info->target_info = &cpu->cfg;
>   
>       /*
> -     * A couple of bits in MSTATUS set the endianness:
> -     *  - MSTATUS_UBE (User-mode),
> -     *  - MSTATUS_SBE (Supervisor-mode),
> -     *  - MSTATUS_MBE (Machine-mode)
> -     * but we don't implement that yet.
> +     * RISC-V instructions are always little-endian, regardless of the
> +     * data endianness configured via MSTATUS UBE/SBE/MBE bits.
>        */
>       info->endian = BFD_ENDIAN_LITTLE;
>   
> @@ -2641,6 +2641,7 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
>   
>   static const Property riscv_cpu_properties[] = {
>       DEFINE_PROP_BOOL("debug", RISCVCPU, cfg.debug, true),
> +    DEFINE_PROP_BOOL("big-endian", RISCVCPU, cfg.big_endian, false),

... and exposing the CPU property should be in a distinct patch, placed
last (just before the test). Otherwise the series isn't bisect-able.

OK for the other changes (introducing cfg::big_endian) in this patch.

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


