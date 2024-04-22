Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FE1BC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 17:46:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ryxjs-0006SP-Rr; Mon, 22 Apr 2024 13:46:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1ryxjq-0006RP-Qi
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 13:45:58 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1ryxjn-0003Ld-Jg
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 13:45:58 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1e65b29f703so34320065ad.3
 for <qemu-devel@nongnu.org>; Mon, 22 Apr 2024 10:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1713807954; x=1714412754; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EkhEUXLvkEhJV4EAA971TCPVFPdq4TAhUcXXh0AmYYQ=;
 b=NxlPEuLnks1VM8vDDnmyl5SZ0Ex9twIFtBmLuWGdA6ENMOdMY9Gf1w2J8SAZSx1YHy
 NuletjHHv5GJ1vmu73fHS9mXdgvtFRokcgRLf33vJ4BSbbUtCp5qRtls3WzUJppkY8nQ
 1C7j7P7JRPVYDUXgIMyqidTHnvuAgjzlWJmyoyLMwUOvSiXiTpNs4jhcKeDJd8BqcPTu
 gp4pWnRno3WDX6T92HrKgX/No2GoTh018oLvTpIjeWg9fIbrpnFHorVPXjORa5kZbU5l
 CjhycYvN6V2eGUqiPjudy6WXw3SmbGPH7PUKP8pphNQPn3fNrd5ZB9vL6MA1JWmqEgGb
 31aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713807954; x=1714412754;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EkhEUXLvkEhJV4EAA971TCPVFPdq4TAhUcXXh0AmYYQ=;
 b=a99sT8+4nuUV051KVaqykyC4vplFVi1RpvqhswCeYDLMDpGmHAqqYaXErK8HnWEYzF
 RLg0puo6x9ZT5E+ebed/yVzbgCowDfb42Mk2iAmFyrVsv21bwfH58NYHijAs1tjM/4XI
 GeME5AzDbSU9wRMrhc/3kXpP+Q/ldD1Mihb3IxZcg6+wz3W/PfyFUv+VYLsEN+RI1SRm
 sZMrIf344iu7r/JjBPQk4pRQrcxRUXv0KnSkZNNnUcUMIVg46ZlbM7q+F+KZHvTwjge3
 la658cb2IQFdtZVfDlOmah//dd+lpeut18hafzN7YSiIdyVJJKm+AsVqPZck1z7AO2jX
 /5VQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2jSl4KwPFaEcNvwxQRpmizOH8c2s2+Hd/qp0mlnY2UTb9l0S3IuXlgz1jUnEB20TCBNKGl6GILr/hAIVV1oIyDGp3TB4=
X-Gm-Message-State: AOJu0YwvMm4f9zXUV88MnSLDVh6B086IVF2nhhERtAAzxmCUQNcve091
 IDlMSK9bYDWIoFKJqzCoKGfVMheShC/jjG22kqUgrqyY+gWzo81z+zjQ39HbuqI=
X-Google-Smtp-Source: AGHT+IHvgzUBExmsMyH1Qmn6TrAKFYshrHV192wjRwoRgbnxu8UVZsPc3XxE4V3DRAlyHWL2JKA1lQ==
X-Received: by 2002:a17:902:cec2:b0:1e2:36d1:3015 with SMTP id
 d2-20020a170902cec200b001e236d13015mr13405570plg.8.1713807954081; 
 Mon, 22 Apr 2024 10:45:54 -0700 (PDT)
Received: from [192.168.68.110] ([191.255.35.121])
 by smtp.gmail.com with ESMTPSA id
 t6-20020a170902e84600b001e604438791sm8387584plg.156.2024.04.22.10.45.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Apr 2024 10:45:53 -0700 (PDT)
Message-ID: <b0fcb589-9217-4d30-8b72-5b0210ea871f@ventanamicro.com>
Date: Mon, 22 Apr 2024 14:45:48 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: change RISCV_EXCP_SEMIHOST exception number
 to 63
Content-Language: en-US
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, qemu-riscv@nongnu.org
Cc: Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org,
 Anup Patel <apatel@ventanamicro.com>
References: <20240422135840.1959967-1-cleger@rivosinc.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240422135840.1959967-1-cleger@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62e.google.com
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

Palmer, Anup,

On 4/22/24 10:58, Clément Léger wrote:
> The current semihost exception number (16) is a reserved number (range
> [16-17]). The upcoming double trap specification uses that number for
> the double trap exception. Since the privileged spec (Table 22) defines
> ranges for custom uses change the semihosting exception number to 63
> which belongs to the range [48-63] in order to avoid any future
> collisions with reserved exception.


I didn't find any reference to a number for the SEMIHOST exception here:


https://github.com/riscv-non-isa/riscv-semihosting


Do we have any potential candidates? I would like to avoid, if possible, setting
RISCV_EXCP_SEMIHOST to 63 as a band-aid just to replace it later on by the real
value.


Thanks,

Daniel

> 
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> 
> ---
>   target/riscv/cpu_bits.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index fc2068ee4d..74318a925c 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -670,11 +670,11 @@ typedef enum RISCVException {
>       RISCV_EXCP_INST_PAGE_FAULT = 0xc, /* since: priv-1.10.0 */
>       RISCV_EXCP_LOAD_PAGE_FAULT = 0xd, /* since: priv-1.10.0 */
>       RISCV_EXCP_STORE_PAGE_FAULT = 0xf, /* since: priv-1.10.0 */
> -    RISCV_EXCP_SEMIHOST = 0x10,
>       RISCV_EXCP_INST_GUEST_PAGE_FAULT = 0x14,
>       RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT = 0x15,
>       RISCV_EXCP_VIRT_INSTRUCTION_FAULT = 0x16,
>       RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT = 0x17,
> +    RISCV_EXCP_SEMIHOST = 0x3f,
>   } RISCVException;
>   
>   #define RISCV_EXCP_INT_FLAG                0x80000000

