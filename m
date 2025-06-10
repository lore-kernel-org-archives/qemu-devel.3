Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFCDEC5B552
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 07:39:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOtZT-000261-H6; Tue, 10 Jun 2025 03:38:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uOtZR-00025N-Tu
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 03:38:57 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uOtZO-0003hh-OA
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 03:38:57 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-450ce671a08so32214105e9.3
 for <qemu-devel@nongnu.org>; Tue, 10 Jun 2025 00:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749541132; x=1750145932; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OmjqimiYwzed4B4B7G/iirdNDRyc8e2ThwK55eRiVE4=;
 b=cIDsTTaCMWSVlclXfzwGUtv1apOO1kqMPxV580EuR+58D0sHt9JkkweLpGtkbGCDh1
 fjMNRYxZ4sTOVfC/kWpqNMF/JpmeeOXLTxG6JLKvVe/7kXP5cHLCYW8jWCEIek23Hoyl
 aiy5HFKrcYNwvgLP9COkDpBRZg/a/AGrpcfxxfeWqmo4wgxW1HkUTXzFvXMZqZALSbn0
 JLhsnEMuy0f3lo9lkNM2PilIf/ay2NqCVcSKPO+MC8F7Sk9lvcxne40a5RsLldX6XFMu
 2pgJm8ey/WG5cZF37qfJ+5faOVVeoiHcl8qxLUQ4WixQpq+cM6XqJC5OigqRq9OVh5jh
 Vhng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749541132; x=1750145932;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OmjqimiYwzed4B4B7G/iirdNDRyc8e2ThwK55eRiVE4=;
 b=XNvzFHoxg9jfZU1qDdtPRGneY64qrK23p7etGQA4nFwG1txCb6QeK4MrKHw4LHHW60
 uGRWGcnOUEKE7GGjIrqGDoVn2Qh/+1XVV9fOQu0yFwAV3CTUf+F0lTyyur/BMQdgHUbM
 TTWISrbqFB3T2e5KikX/ZiHQMYvKABWdSHD9EiOY3FMPYj12rn9ATopZ90FKf8oT+oBM
 6LdLLc/9VyHUpUFzSUMdxRsMlOONLEiVK8co4Gnz8UcyR6DU2TY9oc0aUQ7RgU5ri1nh
 6EA7O8t0UsfqiuHckv5sqrrRA4h1CkZZlW0+K6hdyw3mmH4zl7xA6e9vJzxlWGrOPGMx
 Ob9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/8bbakBAOmoJSu2iI44erlLpcKlR7PCJQ7cJdG2bvfyUtqIZaVJQrz/ufR8zk30o/s3XIXWJ/6KxK@nongnu.org
X-Gm-Message-State: AOJu0YwaPrjBWxlM/KBePr1M4s4wYNW/vj5rqYPsqUeXFbLj3AyZbeX2
 AmXNjk32mtvmcEQHeJHj0e4oPDgycv+oa3tlgTXt5Ri1Lznj7b+A091lclyUeGpskYxhdXP7gp2
 cpD8DOzE=
X-Gm-Gg: ASbGnctEgl9AE47BgbqCCBHw6uQPewus3e+vOQD014GJ+lcJR/kAAUEjBBmUBhAaauu
 wAkuEiTy1F9JglaqjpowltErTBdpAhnIAtJ4celK3srWe89nLMruUhOpM51beliHAEC+vn1kjeW
 kUlvmQtMdW/HmYhAXfhHCcsGhmJ91SwxQOwEGPTmZ8jDqMZCOQwqoYOMOS7X4F5rBitAWI3TeIw
 QIGYPR0gR7EyAFWxbrenOS9PNoZXMIsmZImd0BAWY3LOfTPWTpN0sLI2S4kCz+Wwbp1A2smnrX6
 PPpsSTUYEJZemaDvdS+YPWR/IzKl6vLYFpiICNP0jIgz0LSJMBJVT+0M8Gu+FNNGFkXhR4I82IP
 /55Rjz1UQ8jJUGv2SaChBed9LpkD6CVYtzK8=
X-Google-Smtp-Source: AGHT+IEgdmEPIvO4liKVIRTae/QyrAhJdD/3eM6i6reXyJ1al5wSRfXwZxi8uugFgLlk98TGYRQS/w==
X-Received: by 2002:a05:600c:8716:b0:442:f4a3:8c5c with SMTP id
 5b1f17b1804b1-4520139a4b8mr178229515e9.10.1749541132382; 
 Tue, 10 Jun 2025 00:38:52 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-452137290b9sm132379475e9.34.2025.06.10.00.38.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Jun 2025 00:38:51 -0700 (PDT)
Message-ID: <37f95977-5d4e-4c58-bff8-f808aeaead07@linaro.org>
Date: Tue, 10 Jun 2025 09:38:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/9] target/riscv: Add MIPS P8700 CPU
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "cfu@mips.com" <cfu@mips.com>
References: <20250602131226.1137281-1-djordje.todorovic@htecgroup.com>
 <20250602131226.1137281-4-djordje.todorovic@htecgroup.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250602131226.1137281-4-djordje.todorovic@htecgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi,

On 2/6/25 15:12, Djordje Todorovic wrote:
> Introduce MIPS P8700 CPU and set reset vector to 0x1fc00000.
> 
> Signed-off-by: Chao-ying Fu <cfu@mips.com>
> Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
> ---
>   target/riscv/cpu-qom.h |  1 +
>   target/riscv/cpu.c     | 16 ++++++++++++++++
>   2 files changed, 17 insertions(+)
> 
> diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
> index 1ee05eb393..1e62b96094 100644
> --- a/target/riscv/cpu-qom.h
> +++ b/target/riscv/cpu-qom.h
> @@ -55,6 +55,7 @@
>   #define TYPE_RISCV_CPU_VEYRON_V1        RISCV_CPU_TYPE_NAME("veyron-v1")
>   #define TYPE_RISCV_CPU_TT_ASCALON       RISCV_CPU_TYPE_NAME("tt-ascalon")
>   #define TYPE_RISCV_CPU_XIANGSHAN_NANHU  RISCV_CPU_TYPE_NAME("xiangshan-nanhu")
> +#define TYPE_RISCV_CPU_MIPS_P8700       RISCV_CPU_TYPE_NAME("mips-p8700")
>   #define TYPE_RISCV_CPU_HOST             RISCV_CPU_TYPE_NAME("host")
>   
>   OBJECT_DECLARE_CPU_TYPE(RISCVCPU, RISCVCPUClass, RISCV_CPU)
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 629ac37501..519d2345b8 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -3167,6 +3167,22 @@ static const TypeInfo riscv_cpu_type_infos[] = {
>           .cfg.max_satp_mode = VM_1_10_SV39,
>       ),
>   
> +    // NOTE: When specifying CPU, specify `resetvec` as:
> +    //   -cpu mips-p8700,resetvec=0x1fc00000

Do you think users will go read the code for comments before using QEMU?
(please respect QEMU coding style).

Maybe resetvec has to be added to RISCVCPUProfile?

> +    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_MIPS_P8700, TYPE_RISCV_VENDOR_CPU,
> +        .misa_mxl_max = MXL_RV64,
> +        .misa_ext = RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU,
> +        .priv_spec = PRIV_VERSION_1_12_0,
> +        .cfg.max_satp_mode = VM_1_10_SV48,
> +        .cfg.ext_zifencei = true,
> +        .cfg.ext_zicsr = true,
> +        .cfg.mmu = true,
> +        .cfg.pmp = true,
> +        .cfg.ext_zba = true,
> +        .cfg.ext_zbb = true,
> +        .cfg.marchid = 0x8000000000000201,
> +    ),
> +
>   #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
>       DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE128, TYPE_RISCV_DYNAMIC_CPU,
>           .cfg.max_satp_mode = VM_1_10_SV57,


