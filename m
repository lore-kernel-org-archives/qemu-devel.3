Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6926DC36002
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 00:55:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twsZn-0004CG-33; Mon, 24 Mar 2025 20:55:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twsZl-0004Bz-5a
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 20:55:29 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twsZj-0002YS-GI
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 20:55:28 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-224341bbc1dso94810475ad.3
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 17:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742864125; x=1743468925; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ORM8RNkZLNCuZdeHngesF9J8K7XCfnD/wWWHWazEyAk=;
 b=JJk8lJni6D2qvTdtI5Tk0h5q44pNHKbHDQ5hJ7+1PR1C3s3488JhnzU0CYjY8lUboE
 /nrpgOmVdpcUv1yEgi9jgjaacwFZGWChy5cJhp6Pc+vbNVKlMGWDNLxvnb71mLvrif8O
 iGme8XaCGhLvIvmTZxaBFRX/0pT781Wif67SkMs0+DvnVFsCkmOz5CLdvQIIarSi/huc
 v8xClX07v/VoQXbikafGrbk25qYyC/w9+1tonUE4DxHj4/fc386c8ITpfmpbwT+G4PVC
 y+mjlDZMR1q2gJVXSmMYPs+yi5Buv3KL7LJ8kjRW2xKCnvTGaBkTZdj2ymY81oocbThU
 Y1mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742864125; x=1743468925;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ORM8RNkZLNCuZdeHngesF9J8K7XCfnD/wWWHWazEyAk=;
 b=KDkJ9fXof5w6rJ2cGXOhQMVBNW8pR9z3PgVl/vCAUHSUuBuL5CiD9ULx+z88IGSRVd
 tdQhQxEXheV97d2AKU+3DPWNjBRw6zfYO+fnDtM8kVmu6iHtix6X1fEX1q8i0mI/DT7y
 fFQdRhUBwX/G5Y3S/TxKIsDITTisIBoqWZniSnua375tye7203WmpEi4dPzCZUOpgS5C
 CIxC0j+SLKHLYeo/Iy1ifqjjgs7nNYTMeNl2B+BGHjWHO9AGeEhZT9ZBtHnXCMDZnMKl
 Eq+jRPnR8jUZ7RLsM4I3z2lGEY/UQpIWsRm6YagdGzd99ObQ7nFAdSNJcT3462gvsHc0
 5Pvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpeKrsrZ6VdCgLIu9u9boCu2p4MJwkZ/KZSyHNHlg0+yd/mXrXgf0M1nuVHyZTFzCX+YrfLcZwiJrP@nongnu.org
X-Gm-Message-State: AOJu0YzQ7nFk/3kVN5L26slVLSXfAQDVy5u0OsI4AhUe/8c4isNddoU9
 q1YFsy0CSat/VM5oGcIy4piIB0QMX3UvRXjKyjfNqdCSrXee9Dto/CeCSZSjWts=
X-Gm-Gg: ASbGncs1JwaYJJF4mk7qAhzx1qzdbHZErywp/RyZXuGwcpLsvM/4gAhemOAuQPcyoTR
 PIX2UY0XgYOpBlpyvaGoRsriznYvMUDKHnKsGWH+wY/TEjJH7rSo7hjtZXX4Oml2ujQwQBVD48s
 17yyG0Kb6nL2Ah+NP2H/pSRRqFFe/uenp5gAdrHhlm8PlmhjFqgm/sTb3kKqBEZKDWPuw8P7YC7
 1LuuST41zkFBJfzLH+elzqhg4gdp+nfwB6iWCCsWSzU+hsMDgILwlyXwqHGLBC/J+mJKKL2g5LQ
 D9ssq999TnpurzX2ZGfNzXpAOTMsSEuRrArrKf2H9t26R9ntemcdiZBojQ==
X-Google-Smtp-Source: AGHT+IGam2KnW3qnlD1SLFJo1FEFrTMDPn2aUbYAbmuk/72RF2cWlaqu25Hr0WOb49EsBGL6is86PQ==
X-Received: by 2002:a17:902:ebc9:b0:220:c63b:d93c with SMTP id
 d9443c01a7336-22780e234c5mr220985455ad.44.1742864124809; 
 Mon, 24 Mar 2025 17:55:24 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3030f5d8287sm8912429a91.15.2025.03.24.17.55.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Mar 2025 17:55:24 -0700 (PDT)
Message-ID: <4f4e9ddb-d93d-4780-9451-bb06ab4b7587@linaro.org>
Date: Mon, 24 Mar 2025 17:55:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/17] target/avr: Remove OFFSET_CPU_REGISTERS
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mrolnik@gmail.com, philmd@linaro.org
References: <20250323173730.3213964-1-richard.henderson@linaro.org>
 <20250323173730.3213964-5-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250323173730.3213964-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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

On 3/23/25 10:37, Richard Henderson wrote:
> This define isn't really used.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/avr/cpu.h    | 2 --
>   target/avr/helper.c | 3 +--
>   2 files changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/target/avr/cpu.h b/target/avr/cpu.h
> index 06f5ae4d1b..84a8f5cc8c 100644
> --- a/target/avr/cpu.h
> +++ b/target/avr/cpu.h
> @@ -60,8 +60,6 @@
>   #define OFFSET_CODE 0x00000000
>   /* CPU registers, IO registers, and SRAM */
>   #define OFFSET_DATA 0x00800000
> -/* CPU registers specifically, these are mapped at the start of data */
> -#define OFFSET_CPU_REGISTERS OFFSET_DATA
>   /*
>    * IO registers, including status register, stack pointer, and memory
>    * mapped peripherals, mapped just after CPU registers
> diff --git a/target/avr/helper.c b/target/avr/helper.c
> index 3412312ad5..e5bf16c6b7 100644
> --- a/target/avr/helper.c
> +++ b/target/avr/helper.c
> @@ -340,8 +340,7 @@ void helper_fullwr(CPUAVRState *env, uint32_t data, uint32_t addr)
>       env->fullacc = false;
>   
>       /* Following logic assumes this: */
> -    assert(OFFSET_CPU_REGISTERS == OFFSET_DATA);
> -    assert(OFFSET_IO_REGISTERS == OFFSET_CPU_REGISTERS +
> +    assert(OFFSET_IO_REGISTERS == OFFSET_DATA +
>                                     NUMBER_OF_CPU_REGISTERS);
>   
>       if (addr < NUMBER_OF_CPU_REGISTERS) {

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


