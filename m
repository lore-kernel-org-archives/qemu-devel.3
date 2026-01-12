Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9975CF45BB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 17:44:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfLxl-00045I-BD; Mon, 12 Jan 2026 12:44:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vfLxW-00042t-PC
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 12:44:08 -0500
Received: from mail-qk1-x729.google.com ([2607:f8b0:4864:20::729])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vfLxT-0003xH-KZ
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 12:44:05 -0500
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-8bb6a27d390so423955385a.3
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 09:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1768239841; x=1768844641; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RwDJcnt+66sKzxf4sdoBbIOri4nf70Oxl7LXtmQV8ac=;
 b=oZKvDCFqIbpc7BG5bkHS/nh3tU3PU9RgIl9SSxGFaBLHKzzCLo2mnsWPQbqkc+JJ2O
 sHyDOBtqR9VE9sgAPU5D38IK4ZLbLs8ob1ibSFnIQ5jqtW83DSfrkVc/3guujJoo1GHa
 GsOpeZlSyi9gBA1RSPhORGVX0OI/9FcpoUnDjTSTjsvcmpxsBV0B/vF7A+ULHLlvk6iC
 PJrDSIVRrjsn/EJOjP3kbyqYfppgtSM4s6X6Vdq5nAEmyZtDH2U4l3EF1yquHRJCFzeL
 JgYhDxUZbsx+H3m6hM/LYGRwSg8ti+0DoiBjby0fH84/YauBQhf1Sbp4yigMgBj3w64t
 sgaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768239841; x=1768844641;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RwDJcnt+66sKzxf4sdoBbIOri4nf70Oxl7LXtmQV8ac=;
 b=Sa/s52ApX+7yx/siShMnDtXv0kpNvLeSpKwIkqN1/tHTcVpRWK1nLewbYgMXIpOyAJ
 2wXtdxsDpmRdcJSNyMgiWcRM64Ia6zLnrZdlT2PISwAsIgNMi3hfXpuXq9RabY62XnR0
 BDsmbfXR8NfJyT8QnZXMFKIVsEMAI4HGX1SLHiXgl6+lEQIkKBW14MQhKOkgNRBpwHJy
 Ld6GWthxFZ3IJp308W2pxmB7pomOzyUcT0qVNRY9JjoMjBXXzuF8vZe3zgfLV5SEWYHx
 hG2cxqTQDj2k3hQk1caHt9uLwAc2jaRlk57J8Iq/oitqk040pk8qJSmXIYvo3tRe45eO
 n3iw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgBKSdZIPZNVUIzdZPH/NfRSxl1YM5MOYMpXWAxYrS7+EAnL9JlsJPKf+ueQv0oW6DOK4cV87YTjQ4@nongnu.org
X-Gm-Message-State: AOJu0YxXr4XPtl5t7HwvKuTiIgO7WA+vYyy3hawIES08wDDoiuIqLzUm
 783vlcrhCF84gPsyc6zlFU6VtIp2UMo0SOIbX9mWGElPNRZx3g8tQZBCHKd8UsRg86Q=
X-Gm-Gg: AY/fxX4p6kJVKL4NOHJPrpT1rtVF0YbHeHc6NKWmz//Kmp4f+vErsGSq/u2hPLa/RvP
 FPSFfX+34wehAXyto2EnQ1blHqVN4lKWHtDBjeWuhieY/RiX8MeXjAP898+GFd7oBT+m7BZXdfY
 zAj+mEA8lJHtjTw5jPshFJ6dMZV6y6EMGPocWB+ceUUmSO/4fGfCqp5cWS7S2maiZc1+sbqtqo/
 LkxKcz22gkBQySKJE8Tu+t7O3x/sn+E3huI39MalHHaWI1/BFB3ie30ZEZ7s7WWbcZw+6gE8hUE
 E7PWsiZNclcV0F65nehtdcky1znjr3LAcCzHMgAo9q0fl5RtiByzqPTkQhn7yjN5+6l742Inq+s
 XXH0MiW7rfWv26tq3ZyJ0+5czyHCBC6Iw/c7iiUyN5/+f3qr4a7uiZX+qVvzWR1sxfBe4FFgjGB
 fR8VP7eWzueEypcJfFQwQk9HBQuoPShxm+AubznIPw
X-Google-Smtp-Source: AGHT+IGCXDfcTe5gWzHgP7VfajKrhECowWzis+J6KZi5+DLTF+DIM3zF2jsm972L4eoQZpyiHLlecA==
X-Received: by 2002:a05:620a:1a90:b0:8c1:7dc7:5065 with SMTP id
 af79cd13be357-8c389356782mr2896277585a.7.1768239841528; 
 Mon, 12 Jan 2026 09:44:01 -0800 (PST)
Received: from [192.168.68.103] ([152.234.121.223])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c37f4b90c3sm1590113385a.19.2026.01.12.09.43.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 09:44:00 -0800 (PST)
Message-ID: <18949efe-3610-40df-8911-ef8d66ac7f2d@ventanamicro.com>
Date: Mon, 12 Jan 2026 14:43:56 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: Fix build errors
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20260112161626.1232639-1-clg@redhat.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20260112161626.1232639-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::729;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-qk1-x729.google.com
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



On 1/12/2026 1:16 PM, Cédric Le Goater wrote:
> Newer gcc compiler (version 16.0.0 20260103 (Red Hat 16.0.0-0) (GCC))
> detects a truncation error:
> 
>    ../target/riscv/cpu.c: In function ‘riscv_isa_write_fdt’:
>    ../target/riscv/cpu.c:2916:35: error: ‘%d’ directive output may be truncated writing between 1 and 11 bytes into a region of size 5 [-Werror=format-truncation=]
>     2916 |     snprintf(isa_base, maxlen, "rv%di", xlen);
>          |                                   ^~
>    ../target/riscv/cpu.c:2916:32: note: directive argument in the range [-2147483648, 2147483632]
>     2916 |     snprintf(isa_base, maxlen, "rv%di", xlen);
>          |                                ^~~~~~~
> 
> Since the xlen variable represents the register width (32, 64, 128) in
> the RISC-V base ISA name, mask its value with a 8-bit bitmask to
> satisfy the size constraints on the snprintf output.
> 
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Alistair Francis <alistair.francis@wdc.com>
> Cc: Weiwei Li <liwei1518@gmail.com>
> Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>


>   target/riscv/cpu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index ffd98e8eed468645b8ceb8a7adb45718bdc4444d..e95eea024939d2cbb5747781c291fed0e1b07bb9 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2913,7 +2913,7 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
>       riscv_isa = riscv_isa_string(cpu);
>       qemu_fdt_setprop_string(fdt, nodename, "riscv,isa", riscv_isa);
>   
> -    snprintf(isa_base, maxlen, "rv%di", xlen);
> +    snprintf(isa_base, maxlen, "rv%di", xlen & 0xFF);
>       qemu_fdt_setprop_string(fdt, nodename, "riscv,isa-base", isa_base);
>   
>       isa_extensions = riscv_isa_extensions_list(cpu, &count);


