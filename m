Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACCACC04FFE
	for <qemu-devel@archiver.kernel.org>; Sat, 11 May 2024 14:44:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5nvn-0000SM-Qz; Sat, 11 May 2024 10:42:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liwei1518@gmail.com>)
 id 1s5nuT-0000I3-Ms; Sat, 11 May 2024 10:41:13 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liwei1518@gmail.com>)
 id 1s5nuQ-0002rS-MM; Sat, 11 May 2024 10:41:12 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-5d81b08d6f2so2020298a12.0; 
 Sat, 11 May 2024 07:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715438468; x=1716043268; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ow12iNDRPOo0ZKTkxNNess96Ou/IKCUWN0i1g+fyGMg=;
 b=cd5PClLF/Blf3z70Oi/g9dHG/LOq8CVxD/8RMz/x6einS8torD3BISKft+D2jgFkYp
 kRx/JvuPvghMtEubeR/uzXwGD/4LQ5sKiiuSmRfdpGuY42o3l6GIZMMrh0bAH8MEWQgb
 BGW+gtt/ZfQg69Q3rQd6X/OW5JkjLIdEVo+7tugSI/MU29Pz3VhTyDBHnxD5IwKk+EBJ
 7vaSprPKJ0jVzbTtTm5lCaW+9aXXVwwS5fPjP2pGlO06Vsix05V8fIE2QjRnwSHTisQJ
 J0TaDrBP+i3V7bhKBDo9a3KTTZZ/XtUwKTwOygBZHIDmwrbv322PUzOZGVz2WZoDuMaI
 2Grw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715438468; x=1716043268;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ow12iNDRPOo0ZKTkxNNess96Ou/IKCUWN0i1g+fyGMg=;
 b=XN7/ylKvdiQvRiHehWiRxFS7EW7soCZi8jCLjSxEf47dXkBdoXhqy/xQOVx45x823H
 EubrETkAqJmTu6fyt9hJ7MAg2FHcAqi+6IKDxyXC8w21S78ad27rQzTc42k98WgadUPp
 JX4yDitHDuvBkor/AHD7hCr7xbCtUzWCzEpUpF17Ln4sd/bd7palsvfZHq99fJZ2bdNa
 Ra+Cdfl97mvAG5hVGFfcout/jydExZhc1P3rWe7jzTJZouz8jg2e3ivbihsl61N22I03
 eeHWhq+oJlNrEKX7bSwB+AcE5/lj922mZJ21YvFY4IhBF1iKSJDEatLj+aMx1Y0elIpm
 U2Eg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnFojxa+pHr6Tm5VnZDn5Wc4VM8y6IgAkek277RP4rY8rGmTFLF8pM3C71By4WDsjPCRdg8nPC3WNGtyZU420X8KZizJ7AlFwcqPfdTUGQKt51hFhYEu6GuYfzEA==
X-Gm-Message-State: AOJu0YwKHNoxboGL8DRDOesq+ZLu430um76giBXDOaPimoshrGBU21Be
 frPDl5D4uDuoChXty7/djIjTgfHLkztu8sguCYcJV5CVpq9shgbS
X-Google-Smtp-Source: AGHT+IFeo6WITafvO6/AnDAPJVrGCyL5xshUswj704Js30KHcX+bwpAui863BuL4zPJGobpxRtWS0w==
X-Received: by 2002:a17:902:cf10:b0:1e2:ae83:3197 with SMTP id
 d9443c01a7336-1ef43d155a4mr64425675ad.10.1715438467726; 
 Sat, 11 May 2024 07:41:07 -0700 (PDT)
Received: from [192.168.0.120] ([114.95.238.28])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ef0bf31000sm49535505ad.145.2024.05.11.07.41.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 11 May 2024 07:41:07 -0700 (PDT)
Message-ID: <11addfd0-d350-4c73-a856-8b7dec2f8ffa@gmail.com>
Date: Sat, 11 May 2024 22:41:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] target/riscv: Reuse the conversion function of
 priv_spec and string
To: "Fea.Wang" <fea.wang@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Jim Shu <jim.shu@sifive.com>, Frank Chang <frank.chang@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Andrew Jones <ajones@ventanamicro.com>, Max Chou <max.chou@sifive.com>
References: <20240510065856.2436870-1-fea.wang@sifive.com>
 <20240510065856.2436870-2-fea.wang@sifive.com>
Content-Language: en-US
From: liwei <liwei1518@gmail.com>
In-Reply-To: <20240510065856.2436870-2-fea.wang@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=liwei1518@gmail.com; helo=mail-pg1-x529.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 11 May 2024 10:42:31 -0400
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


On 2024/5/10 14:58, Fea.Wang wrote:
> From: Jim Shu <jim.shu@sifive.com>
>
> Public the conversion function of priv_spec and string in cpu.h, so that
> tcg-cpu.c could also use it.
>
> Signed-off-by: Jim Shu <jim.shu@sifive.com>
> Signed-off-by: Fea.Wang <fea.wang@sifive.com>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>
> ---
>   target/riscv/cpu.c         |  4 ++--
>   target/riscv/cpu.h         |  3 +++
>   target/riscv/tcg/tcg-cpu.c | 13 +++++--------
>   3 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index a74f0eb29c..b6b48e5620 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1769,7 +1769,7 @@ static const PropertyInfo prop_pmp = {
>       .set = prop_pmp_set,
>   };
>   
> -static int priv_spec_from_str(const char *priv_spec_str)
> +int priv_spec_from_str(const char *priv_spec_str)

This change seems unnecessary in this patch.

Regards,

Weiwei Li

>   {
>       int priv_version = -1;
>   
> @@ -1784,7 +1784,7 @@ static int priv_spec_from_str(const char *priv_spec_str)
>       return priv_version;
>   }
>   
> -static const char *priv_spec_to_str(int priv_version)
> +const char *priv_spec_to_str(int priv_version)
>   {
>       switch (priv_version) {
>       case PRIV_VERSION_1_10_0:
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index e0dd1828b5..7696102697 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -829,4 +829,7 @@ target_ulong riscv_new_csr_seed(target_ulong new_value,
>   uint8_t satp_mode_max_from_map(uint32_t map);
>   const char *satp_mode_str(uint8_t satp_mode, bool is_32_bit);
>   
> +const char *priv_spec_to_str(int priv_version);
> +int priv_spec_from_str(const char *priv_spec_str);
> +
>   #endif /* RISCV_CPU_H */
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 4ebebebe09..faa8de9b83 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -76,16 +76,13 @@ static void riscv_cpu_write_misa_bit(RISCVCPU *cpu, uint32_t bit,
>   
>   static const char *cpu_priv_ver_to_str(int priv_ver)
>   {
> -    switch (priv_ver) {
> -    case PRIV_VERSION_1_10_0:
> -        return "v1.10.0";
> -    case PRIV_VERSION_1_11_0:
> -        return "v1.11.0";
> -    case PRIV_VERSION_1_12_0:
> -        return "v1.12.0";
> +    const char *priv_spec_str = priv_spec_to_str(priv_ver);
> +
> +    if (priv_spec_str == NULL) {
> +        g_assert_not_reached();
>       }
>   
> -    g_assert_not_reached();
> +    return priv_spec_str;
>   }
>   
>   static void riscv_cpu_synchronize_from_tb(CPUState *cs,

