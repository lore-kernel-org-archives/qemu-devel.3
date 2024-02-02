Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAA14C47DB3
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 11:26:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVrfu-00085m-BR; Fri, 02 Feb 2024 06:25:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rVrfX-0007yQ-Bz
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 06:25:15 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rVrfR-0008HH-W5
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 06:25:14 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1d944e8f367so17025535ad.0
 for <qemu-devel@nongnu.org>; Fri, 02 Feb 2024 03:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1706873105; x=1707477905; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MborO2rMcbSTqP8xRrok/OXEmozBvlokRufEJZoYoEw=;
 b=I6gjmckEm7i9YDShTtDhHBFY51FoxiNj95yb/5rAOooHccVGrOc6GxkjSHeQ3OnZrE
 zC5JowYstXAPW+UUoyE4LZl3FEuM+NFqMndDT1eNFiE9aKktBHgXhj3H4xMkLeh0uhRT
 A3cQDIboKWQzeO/8nfaLjRqF9xRz6nov78GMdEHislYepwk+NZ4lwpBhCGeiK5XehiLs
 KMy+NozetYuH3VjdrEkB8QrcCxuhwBAZ0yqVnybXM6ALty3oZcbGrI+kzXDK954UP3AD
 DgjRVRlClWkKutUcz75xaq6RhNGqKTOw6ZePpt0b8T3I8YZdLiogejCjU1SxEJCmyiF4
 hbLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706873105; x=1707477905;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MborO2rMcbSTqP8xRrok/OXEmozBvlokRufEJZoYoEw=;
 b=uVeDCF+Z7L2aH7qsXubqMTctPHPLus5Iiw+DvKimjaVDwrRSFQ0h41ocTtoBrFYKRu
 VslNLTxG9YP3RhNjOpAX84XJHd6B6p74oCg6/l36AH9dnSUcQGrkF0bSjK/OfRhw6bKI
 +13gbCzKAeQGDVYiY9QYA6Pvxr8+AJOtcn1XByD7OVs4rYRzgMJ+Ztslemvtv2zFpFx7
 dA2oiY93Pr7++wMj19R+QDWKWjW+fcL+9+pUvCWeMbNoKCDisuhN2nIQBQ1I51X5QUri
 JvzgkW4PRnA3CSD1RFoAapkhh68DKR04fTwCtxGVmorPeQ8hxNVtFmy6ngxohQN6/UiJ
 QKBw==
X-Gm-Message-State: AOJu0Yyy8IlOVKf3Q17rcB94Qnb7xCcheIz5wJ7AX9NnrdRgW/4EDifZ
 TDFqPJOLJwE3gIi8xWcx11n6wkqPv3Sovw3HAZ/udf8Hw929tzyns6N6rxNdQ5o=
X-Google-Smtp-Source: AGHT+IE0FU43neWal0G+GotsVmwgDleGyz/jNNKPBZJYLLB8f/9zNoxDOrG0GVumNZH//IfSWv6GZQ==
X-Received: by 2002:a17:902:f7c7:b0:1d9:462f:99cf with SMTP id
 h7-20020a170902f7c700b001d9462f99cfmr5113488plw.5.1706873105079; 
 Fri, 02 Feb 2024 03:25:05 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCWRKEs9V/tVNhDl0MhCxBrNmm+Ctn2vZ4PaQapAr116d+U8jCw4kYgNBtiyWkV7PnEd+bFkZCXpC4Lr+fFcEgpMYyUaL+Y=
Received: from [192.168.68.110] ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 mn16-20020a1709030a5000b001d8aa88f59esm1396265plb.110.2024.02.02.03.25.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Feb 2024 03:25:04 -0800 (PST)
Message-ID: <3eef812a-1b64-44f2-9eea-844542b67ee0@ventanamicro.com>
Date: Fri, 2 Feb 2024 08:25:02 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RISC-V: Report the QEMU vendor/arch IDs on virtual CPUs
Content-Language: en-US
To: Palmer Dabbelt <palmer@rivosinc.com>, qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org
References: <20240131182430.20174-1-palmer@rivosinc.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240131182430.20174-1-palmer@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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



On 1/31/24 15:24, Palmer Dabbelt wrote:
> Right now we just report 0 for marchid/mvendorid in QEMU.  That's legal,
> but it's tricky for users that want to check if they're running on QEMU
> to do so.  This sets marchid to 42, which I've proposed as the QEMU
> architecture ID (mvendorid remains 0, just explicitly set, as that's how
> the ISA handles open source implementations).
> 
> Link: https://github.com/riscv/riscv-isa-manual/pull/1213
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---

This patch doesn't compile in my env:

../target/riscv/cpu.c: In function ‘riscv_any_cpu_init’:
../target/riscv/cpu.c:439:26: error: ‘QEMU_MVENDORID’ undeclared (first use in this function); did you mean ‘CSR_MVENDORID’?
   439 |     cpu->cfg.mvendorid = QEMU_MVENDORID;
       |                          ^~~~~~~~~~~~~~
       |                          CSR_MVENDORID
../target/riscv/cpu.c:439:26: note: each undeclared identifier is reported only once for each function it appears in
../target/riscv/cpu.c:440:24: error: ‘QEMU_MARCHID’ undeclared (first use in this function); did you mean ‘QEMU_ARCH’?
   440 |     cpu->cfg.marchid = QEMU_MARCHID;
       |                        ^~~~~~~~~~~~
       |                        QEMU_ARCH


In the patch where I changed 'marchid' (d6a427e2c0b2) I removed the following macro:

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 477f8f8f97..9080d021fa 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -39,11 +39,6 @@
  #include "tcg/tcg.h"
  
  /* RISC-V CPU definitions */
-
-#define RISCV_CPU_MARCHID   ((QEMU_VERSION_MAJOR << 16) | \
-                             (QEMU_VERSION_MINOR << 8)  | \
-                             (QEMU_VERSION_MICRO))
-

So I believe you can re-introduce it as '42' and use it. If you want to be really
explicit you can also re-introduce RISCV_CPU_MVENDORID and RISCV_CPU_MIMPID and
set them all to 0 and use them to assign all machine IDs.

The macro name doesn't matter but I'd not use 'VIRT' in the name. This marchid is
going to be used by any board that uses the CPU, not just the 'virt' board.

One more thing:


>   target/riscv/cpu.c          | 16 ++++++++++++++++
>   target/riscv/cpu_vendorid.h |  3 +++
>   2 files changed, 19 insertions(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 8cbfc7e781..1aef186f87 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -415,6 +415,9 @@ static void riscv_any_cpu_init(Object *obj)
>       cpu->cfg.ext_zicsr = true;
>       cpu->cfg.mmu = true;
>       cpu->cfg.pmp = true;
> +
> +    cpu->cfg.mvendorid = QEMU_MVENDORID;
> +    cpu->cfg.marchid = QEMU_MARCHID;


Instead of repeating this code in every cpu_init() I would just change post_init():

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 88e8cc8681..f6ef50bb20 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1293,6 +1293,12 @@ static bool riscv_cpu_is_dynamic(Object *cpu_obj)
  
  static void riscv_cpu_post_init(Object *obj)
  {
+    if (!riscv_cpu_is_vendor(obj)) {
+        RISCV_CPU(obj)->cfg.mvendorid = RISCV_CPU_MVENDORID;
+        RISCV_CPU(obj)->cfg.marchid = RISCV_CPU_MARCHID;
+        RISCV_CPU(obj)->cfg.mimpid = RISCV_CPU_MIMPID;
+    }
+
      accel_cpu_instance_init(CPU(obj));
  }

This will change the machine IDs for all CPUs that aren't vendor CPUs, which will
retain whatever value it was set in their cpu_init().


Thanks,


Daniel

>   }
>   
>   static void riscv_max_cpu_init(Object *obj)
> @@ -432,6 +435,8 @@ static void riscv_max_cpu_init(Object *obj)
>       set_satp_mode_max_supported(RISCV_CPU(obj), mlx == MXL_RV32 ?
>                                   VM_1_10_SV32 : VM_1_10_SV57);
>   #endif
> +    cpu->cfg.mvendorid = QEMU_MVENDORID;
> +    cpu->cfg.marchid = QEMU_MARCHID;
>   }
>   
>   #if defined(TARGET_RISCV64)
> @@ -445,6 +450,8 @@ static void rv64_base_cpu_init(Object *obj)
>   #ifndef CONFIG_USER_ONLY
>       set_satp_mode_max_supported(RISCV_CPU(obj), VM_1_10_SV57);
>   #endif
> +    cpu->cfg.mvendorid = QEMU_MVENDORID;
> +    cpu->cfg.marchid = QEMU_MARCHID;
>   }
>   
>   static void rv64_sifive_u_cpu_init(Object *obj)
> @@ -569,6 +576,8 @@ static void rv128_base_cpu_init(Object *obj)
>   #ifndef CONFIG_USER_ONLY
>       set_satp_mode_max_supported(RISCV_CPU(obj), VM_1_10_SV57);
>   #endif
> +    cpu->cfg.mvendorid = QEMU_MVENDORID;
> +    cpu->cfg.marchid = QEMU_MARCHID;
>   }
>   
>   static void rv64i_bare_cpu_init(Object *obj)
> @@ -591,6 +600,8 @@ static void rv64i_bare_cpu_init(Object *obj)
>   #ifndef CONFIG_USER_ONLY
>       set_satp_mode_max_supported(RISCV_CPU(obj), VM_1_10_SV64);
>   #endif
> +    cpu->cfg.mvendorid = QEMU_MVENDORID;
> +    cpu->cfg.marchid = QEMU_MARCHID;
>   }
>   #else
>   static void rv32_base_cpu_init(Object *obj)
> @@ -603,6 +614,8 @@ static void rv32_base_cpu_init(Object *obj)
>   #ifndef CONFIG_USER_ONLY
>       set_satp_mode_max_supported(RISCV_CPU(obj), VM_1_10_SV32);
>   #endif
> +    cpu->cfg.mvendorid = QEMU_MVENDORID;
> +    cpu->cfg.marchid = QEMU_MARCHID;
>   }
>   
>   static void rv32_sifive_u_cpu_init(Object *obj)
> @@ -672,6 +685,9 @@ static void rv32_imafcu_nommu_cpu_init(Object *obj)
>       cpu->cfg.ext_zifencei = true;
>       cpu->cfg.ext_zicsr = true;
>       cpu->cfg.pmp = true;
> +
> +    cpu->cfg.mvendorid = QEMU_MVENDORID;
> +    cpu->cfg.marchid = QEMU_MARCHID;
>   }
>   #endif
>   
> diff --git a/target/riscv/cpu_vendorid.h b/target/riscv/cpu_vendorid.h
> index 96b6b9c2cb..486832cd53 100644
> --- a/target/riscv/cpu_vendorid.h
> +++ b/target/riscv/cpu_vendorid.h
> @@ -7,4 +7,7 @@
>   #define VEYRON_V1_MIMPID        0x111
>   #define VEYRON_V1_MVENDORID     0x61f
>   
> +#define QEMU_VIRT_MVENDORID     0
> +#define QEMU_VIRT_MARCHID       42
> +
>   #endif /*  TARGET_RISCV_CPU_VENDORID_H */

