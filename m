Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19FE5C47258
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 16:06:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVD6J-0002HN-3W; Wed, 31 Jan 2024 11:06:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rVD6G-0002Fz-6E
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 11:06:08 -0500
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rVD6D-0002b9-4Y
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 11:06:07 -0500
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-53fbf2c42bfso3679050a12.3
 for <qemu-devel@nongnu.org>; Wed, 31 Jan 2024 08:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1706717163; x=1707321963; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JV2znCq2trRBW5sN8vrXnJKuDRvit0Tozob7TGfGBT4=;
 b=Ls0XEe9pLOs2gHTGyJoI17RAidAkjxWFRF4u1NgI24dGUJNgT13KoG1ep1Dqq4XMsW
 y350bZnTvlCbUdFNZiYxt8kNUmtGoIKyzCGcBW2NrWDfEjui3m4I4k5AdPqmQCfpqQGi
 tE73GL2c/hvJ5xChQHyWyrk22kpq3Kc8zR+4nLUcf3QAIs+xQClfEfBYCfCh1AOnAFDQ
 p3Ro+L77KvkZPO1N9iAQCLCTrKSonsh6McnbJHoiohcRXygXZ7q6LSBTf67Hi2HIGqSn
 kzceOiQ1DP4gZLvXRDcyd/rPHGrRafgtS/EPliVaLF90JyLq+od+pZxRLqXNzeiVRKTi
 5w8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706717163; x=1707321963;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JV2znCq2trRBW5sN8vrXnJKuDRvit0Tozob7TGfGBT4=;
 b=oEPjpBMFBE8S6cHq9pzEKLQBaR3oFKPnB0hB5el3yL5sCTQsrd1sxwJV5kzRiFUQa3
 haOJ/0t33rE+j4tY3kCiKKTvIaNXn8p1SAvve+7+/ea3X1bk0lbl6PaGJk8mVB++pGfX
 VJOayxl+usD2aoMx35VsRZV0Nj+1sgrYZrbFts9yWpQTEejAne/5dVFqnT/bNugBAA5w
 13m0wFf3K1CUvi4kLAZZfhnmz3ALgVfdXZfZiMgNxEpjJ2TPynNghMBBjnNBGMC+MsKp
 TY+AUeQQI3+ZaPwbvmCHcOI9FcKMpHvw9Ziea3FW+Y1l09/3GaVacVd/72z9bO6wyFbh
 wX2Q==
X-Gm-Message-State: AOJu0YzzFs5qQcYQ/XNRcBTPWCVwqTfGDWpE14lXp/5KZjxKDeQGmXVD
 JUDvHFyh1BIu+BFiVK4bZqKV3v+0K/F2Kxcjwm8RlFd+WwUzt60TwcksY9gdRv8zn3bjeCjgq6l
 G
X-Google-Smtp-Source: AGHT+IHOCHxdRrnNNfCLdRgls2BDCeQT5TCv8TbsD//Vvrs2wvGwnmUqIfhsMTGWccoAauzLIuNMOg==
X-Received: by 2002:a05:6a20:7a06:b0:19c:aba2:69e5 with SMTP id
 t6-20020a056a207a0600b0019caba269e5mr1894812pzh.45.1706717163202; 
 Wed, 31 Jan 2024 08:06:03 -0800 (PST)
Received: from [192.168.68.110] ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 t12-20020a63460c000000b005d24e5ae4e3sm10645606pga.2.2024.01.31.08.06.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Jan 2024 08:06:02 -0800 (PST)
Message-ID: <04f277c2-fee2-44d5-a7a8-b5db6dca6b56@ventanamicro.com>
Date: Wed, 31 Jan 2024 13:05:58 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: FCSR doesn't contain vxrm and vxsat
Content-Language: en-US
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: Alistair.Francis@wdc.com, palmer@dabbelt.com, bin.meng@windriver.com,
 liwei1518@gmail.com, qemu-riscv@nongnu.org
References: <20240130110945.486-1-zhiwei_liu@linux.alibaba.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240130110945.486-1-zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 1/30/24 08:09, LIU Zhiwei wrote:
> vxrm and vxsat have been moved into a special register vcsr since
> RVV v1.0. So remove them from FCSR for vector 1.0.
> 
> Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>


>   target/riscv/cpu_bits.h | 8 --------
>   1 file changed, 8 deletions(-)
> 
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index ebd7917d49..e116f6c252 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -32,14 +32,6 @@
>   #define FSR_NXA             (FPEXC_NX << FSR_AEXC_SHIFT)
>   #define FSR_AEXC            (FSR_NVA | FSR_OFA | FSR_UFA | FSR_DZA | FSR_NXA)
>   
> -/* Vector Fixed-Point round model */
> -#define FSR_VXRM_SHIFT      9
> -#define FSR_VXRM            (0x3 << FSR_VXRM_SHIFT)
> -
> -/* Vector Fixed-Point saturation flag */
> -#define FSR_VXSAT_SHIFT     8
> -#define FSR_VXSAT           (0x1 << FSR_VXSAT_SHIFT)
> -
>   /* Control and Status Registers */
>   
>   /* User Trap Setup */

