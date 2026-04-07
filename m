Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94305FF5136
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:23:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABVR-00076u-HC; Tue, 07 Apr 2026 14:50:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wABTG-0003JL-K4
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 14:48:20 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wA7D6-0004bF-Rv
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 10:15:22 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-43d43e09de5so830368f8f.1
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 07:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775571318; x=1776176118; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DNZ/CMikeddU++bT8Tqf83R6u8cFZQfLnZtVDaWY/8I=;
 b=kUk9fsjjs0PLji+IZ4YXD9Rl23CjDDi2Yl+zR2lC5hKRrkz8MM6w/0tGTdK6PpOXHF
 eoxDEm389IHzINlQEjt7yU+hqEOoYB59tYUSR+HpLOoZkkC4HfZ67DI36CAQPPnKoPSf
 pBVmpjCnTpOCvwD+nrGDAU7DvO9Yz62HXr5J3XY/8L7W3GJQywmi4QD8XL/3xvsVtQ7w
 0A5BvG6vPBPPZqmFthUAgEbLj9oyUbKyOUMQ47VZZE1LoCzAHsHO94pTgwXLVERZRT5t
 uanK0ZNaa/OAT7Sbx/SXqGkAiZPAzEpZQn+zG5t88T1mA8bDIQGct1Cysadz9N0Ihdc3
 +OUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775571318; x=1776176118;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DNZ/CMikeddU++bT8Tqf83R6u8cFZQfLnZtVDaWY/8I=;
 b=emzyI3tkqIEImhqYAZrBjEmX+ipCx9pWDJZa0vyGkL6R1zqUN+LvE8uF6Vf3m/LjAc
 a/MFGOnCiOhCJCzLTtIXWflBL/mlJLs8yIcQT3aG2GDZduYaezrRptq/gGY0OtFQUfh+
 B3kefYLRRdTAc1jLQMt69QjGgpe94ZKkfT+NkrTcgbA7gF7PMyzHzdFvFCh+qfvRORTg
 QYD7GweMZLbYl6OBCyT/hm2YMY6VJK/j0KffUxW1IvHCgkiMqjW+R85UWiEpdu+3aFbr
 xup5xIZFuZLXNMkCJpUCmXZhT0MNBOIskvnozsePbBRgReQd/ORgQ/Vx9rB2EUxKGT6A
 FWvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmuj0aTgl/0eJVecQorUQQQODuDS49q9cThyhUsoJXN0+p+4SUHdzPLm/CsXrSxMsjKXaFFptwf77n@nongnu.org
X-Gm-Message-State: AOJu0YyJpbLhTf86we31WvV3wVFjsxECUxbSpAwG13SYIAzXYIcoUCwp
 v3cjTrsziu7rgmL0tG9Rd0DrGcpnNKYrsbrR/3vOCzg9JGlXGoHx5gRgx3yOSBKVxcU=
X-Gm-Gg: AeBDietPXtAECJTPHx0mTkQz+ZLIlPO9gmlmMhKydYMdv00YP1/w/zzLC4icCMQqgz3
 j2fZQlmRJYbAwr+Gts+pbXuIaMf1BVNVCpG/hJT5XHX01u3cFcuUQdGoQMWeR4fxwo+ZljffCz5
 zneTLUw2PycoSYBnpi6xEmcVjyPl/bGXRX6jQTn3DYnEawtgIThaqSyB5Ht9fcdesQ6+Jexip38
 oBDq7pLq6dqjSzlhs8vm5SQ4UzLFfuMc0yQ4IlEHpy05lRAcyV5KuTGt4GJOhTgLmJ13a9T0rCa
 VIv7CVNcPK6Nqi5HsvlBKLo/GUMwVFIyfpTjzLSHYtSUqZGF0imDBSHydSXX17iK0rumLNv1VYY
 AnS0m9bkhXmrkXi93Y+bYyhPvqJH1HPRXyIliqyGinHMKEUPmkwy1Z/vJmnYivmNxS7zLpgoupj
 VEiAu9QfDLLjjfs6M7HpkWX+5uz85ZyAQ+qUs=
X-Received: by 2002:a5d:5f92:0:b0:43b:9a9f:8956 with SMTP id
 ffacd0b85a97d-43d2928fc60mr25080729f8f.22.1775571318370; 
 Tue, 07 Apr 2026 07:15:18 -0700 (PDT)
Received: from [192.168.69.228] ([88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d1e1fe0b0sm51565524f8f.0.2026.04.07.07.15.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Apr 2026 07:15:17 -0700 (PDT)
Message-ID: <9f333fd9-136f-45e5-a79a-e48735ea03a8@linaro.org>
Date: Tue, 7 Apr 2026 16:15:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/7] target/riscv: Implement runtime data endianness
 via MSTATUS bits
Content-Language: en-US
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>
References: <20260406154935.144674-1-djordje.todorovic@htecgroup.com>
 <20260406154935.144674-5-djordje.todorovic@htecgroup.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260406154935.144674-5-djordje.todorovic@htecgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 6/4/26 17:49, Djordje Todorovic wrote:
> Implement runtime big-endian data support by reading the MSTATUS
> UBE/SBE/MBE bits to determine data endianness per privilege level.
> 
> The key changes are:
> 
> - Add riscv_cpu_data_is_big_endian() helper in cpu.h that checks
>    the appropriate MSTATUS endianness bit based on current privilege
>    level (MBE for M-mode, SBE for S-mode, UBE for U-mode).
> 
> - Update mo_endian() in translate.c to return MO_BE or MO_LE based
>    on a new 'big_endian' field in DisasContext, rather than the
>    previous hardcoded MO_TE.
> 
> - Update mo_endian_env() in op_helper.c to call the new helper,
>    giving hypervisor load/store helpers correct runtime endianness.
> 
> - Pack the endianness flag into cs_base bit 32 (alongside misa_ext
>    in bits 0-25) in riscv_get_tb_cpu_state(), ensuring translation
>    blocks are correctly separated by data endianness.
> 
> Note: instruction fetches continue to use MO_LE unconditionally
> (from the previous patch), as RISC-V instructions are always
> little-endian per the ISA specification.
> 
> Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
> ---
>   target/riscv/cpu.h         | 28 ++++++++++++++++++++++++++++
>   target/riscv/internals.h   |  9 +--------
>   target/riscv/tcg/tcg-cpu.c |  7 ++++++-
>   target/riscv/translate.c   | 13 +++++--------
>   4 files changed, 40 insertions(+), 17 deletions(-)


> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 5df5b73849..77f36906e8 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -119,6 +119,8 @@ typedef struct DisasContext {
>       bool fcfi_lp_expected;
>       /* zicfiss extension, if shadow stack was enabled during TB gen */
>       bool bcfi_enabled;
> +    /* Data endianness from MSTATUS UBE/SBE/MBE */
> +    MemOp mo_endianness;
>   } DisasContext;
>   
>   static inline bool has_ext(DisasContext *ctx, uint32_t ext)
> @@ -128,14 +130,7 @@ static inline bool has_ext(DisasContext *ctx, uint32_t ext)
>   
>   static inline MemOp mo_endian(DisasContext *ctx)
>   {
> -    /*
> -     * A couple of bits in MSTATUS set the endianness:
> -     *  - MSTATUS_UBE (User-mode),
> -     *  - MSTATUS_SBE (Supervisor-mode),
> -     *  - MSTATUS_MBE (Machine-mode)
> -     * but we don't implement that yet.
> -     */
> -    return MO_LE;
> +    return ctx->mo_endianness;

Can we remove the helper and directly use the field?

>   }
>   
>   #ifdef TARGET_RISCV32
> @@ -1346,6 +1341,8 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
>       ctx->zero = tcg_constant_tl(0);
>       ctx->virt_inst_excp = false;
>       ctx->decoders = cpu->decoders;
> +    ctx->mo_endianness = (ctx->base.tb->cs_base & TB_CSBASE_BIG_ENDIAN)
> +                         ? MO_BE : MO_LE;
>   }
>   
>   static void riscv_tr_tb_start(DisasContextBase *db, CPUState *cpu)


