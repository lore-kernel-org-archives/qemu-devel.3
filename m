Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D374C52D71
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 05:48:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZl8O-0004Fj-ES; Fri, 02 Aug 2024 01:47:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZl8N-0004DO-4z
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 01:47:23 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZl8K-0007mW-8S
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 01:47:21 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1fd65aaac27so21004595ad.1
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 22:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722577638; x=1723182438; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NA9yoEiqAzlDlgq8llosU7uQpxWALWO5qSqAsJIr38k=;
 b=qPLbXzPnqz1QOUH1CpbFxvQQ2pQymx36rTzW9Shi56zWWjgqAt5cq4Kh0MZl18UjfC
 ohS9iHpgSgMN7FUntsS/RpaR5Jq5wQnR1P1YRax7T4I+k06dBRcgkPhdS7Brh2JAUF+0
 /EKfBTFWjJqPhl9voXFDSGiDIACxC1XOL1nuXqpqmMWWD1K+d/eTGgwUqBub2n7kSQy8
 FvXTjUw4Yf2PMqqoARVisxpAENfGcP1BiIs4JE3P/YpFN3gW5svUkLP2PpNbk8bXcW+c
 uTw+830R2C8rBVpDgLoX/rFinnOA6w6a+TuTToLaUKQZjf+l8DgMFXysW+djd6UTJRs0
 y/3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722577638; x=1723182438;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NA9yoEiqAzlDlgq8llosU7uQpxWALWO5qSqAsJIr38k=;
 b=MiHeBnP8ap3kjzdT+rVl5tZVkr73Cjn0bRYI9IjCm5xBsmj8MpwVU9voYTLDyY7AH7
 3+GebyIYIkM3Xbi3+PiLwD8ZD8BYwIcgmOzTFpoEaZjnz90MmQyoS4I89QAoEVcyWtfT
 0XJUr6CMH8FFcDNYSdXQ4cjJps6UdLBHGsoJuaz0qijbteh+alH/EKsaOXhB4u+NxvTg
 ZtfNUrXVrT6NxJj4gN86PWk4PysDdMC8WBdL8ZyIvJINo5fXjMujtn6GTk6o7KC30cm1
 fFKujxK2VvjsL0ECCdamAo26433aJ0werKP/FbbzVLsBOYYfrBXfUtIstKS9okSX5ccT
 WIaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4+2sQlh0vxVJFtZqFfCiTauqwtSmPm5g22sNXE8o43CixT1Jh+uyvYR9PG4pLfmq3WPfvnlhR1lnH/QEQJXlbdOHX6x8=
X-Gm-Message-State: AOJu0YwkKZREw9unEBNQ0b5VoAvM6urgPMyLrIl97/Kdb6ZNfmqbupkO
 MtCtqmNJJDc44prx/I6p2fOc/+IpqjVIn7uFiLsMNGqxmkewlwOyxU0gHoPKTMwl63LS9l2KbHP
 ZYU1uJA==
X-Google-Smtp-Source: AGHT+IG5xOJtCuPl0cNx7aW6wo5OEb/fHZhcXqsBstBVk/Y14uaJQ7PSwYP9Hp1hcAHx4nyWR3fFoQ==
X-Received: by 2002:a17:902:e548:b0:1fb:8e29:621f with SMTP id
 d9443c01a7336-1ff57bc50demr34033075ad.16.1722577638401; 
 Thu, 01 Aug 2024 22:47:18 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff5917496fsm8494985ad.182.2024.08.01.22.47.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Aug 2024 22:47:18 -0700 (PDT)
Message-ID: <e565894d-8378-4dbe-92ef-afd54d864810@linaro.org>
Date: Fri, 2 Aug 2024 15:47:11 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] target/riscv: Add MXLEN check for F/D/Q applies to
 zama16b
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com
References: <20240802031612.604-1-zhiwei_liu@linux.alibaba.com>
 <20240802031612.604-3-zhiwei_liu@linux.alibaba.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240802031612.604-3-zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 8/2/24 13:16, LIU Zhiwei wrote:
> Zama16b loads and stores of no more than MXLEN bits defined in the F, D, and Q
> extensions.
> 
> Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> ---
>   target/riscv/insn_trans/trans_rvd.c.inc | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/riscv/insn_trans/trans_rvd.c.inc b/target/riscv/insn_trans/trans_rvd.c.inc
> index 2be037930a..dbe508c7e0 100644
> --- a/target/riscv/insn_trans/trans_rvd.c.inc
> +++ b/target/riscv/insn_trans/trans_rvd.c.inc
> @@ -52,7 +52,7 @@ static bool trans_fld(DisasContext *ctx, arg_fld *a)
>        * in the F, D, and Q extensions. Otherwise, it falls through to default
>        * MO_ATOM_IFALIGN.
>        */
> -    if ((ctx->xl >= MXL_RV64) && (ctx->cfg_ptr->ext_zama16b)) {
> +    if ((ctx->misa_mxl_max >= MXL_RV64) && ctx->cfg_ptr->ext_zama16b) {
>           memop |= MO_ATOM_WITHIN16;
>       }
>   
> @@ -72,7 +72,7 @@ static bool trans_fsd(DisasContext *ctx, arg_fsd *a)
>       REQUIRE_FPU;
>       REQUIRE_EXT(ctx, RVD);
>   
> -    if (ctx->cfg_ptr->ext_zama16b) {
> +    if ((ctx->misa_mxl_max >= MXL_RV64) && ctx->cfg_ptr->ext_zama16b) {
>           memop |= MO_ATOM_WITHIN16;
>       }

I guess this is ok, because MXL cannot currently be changed. But since that is a possible 
future enhancement, perhaps add a get_mxl(ctx) accessor anyway, for documentation purposes.


r~

