Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A59A7C48BC4
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 13:27:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raFHw-0005WH-BX; Wed, 14 Feb 2024 08:27:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1raFHu-0005Vz-Rg
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 08:26:58 -0500
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1raFHt-0005zY-39
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 08:26:58 -0500
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-5dc4a487b1eso3917940a12.1
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 05:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1707917215; x=1708522015; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JkKIIyyayaWmaZiTpC42WkmMQCYGzUnrOFt0aLIAKNU=;
 b=Q3qTsQ2leCZh1r3tQ/L64fhBY0/+lM2PCdgeX6ooWa8E2a8dHCgc+l+AHq5TFwfqJA
 ZMrVDXbbgM63dfrHDwaUbAsmi5NdecqzhgLCCOvbL4xAh/aQ6AKQBe7jg+B6nKHZXzlO
 jZC30B3Eikt2S8wrjtabyWUqdT5RK41NORHTg4ao85FFDU+xwXOsSNfsUIpjxj86/do5
 vZXUUfF7mJVKRkQOUe9oLHZnC69BNACR96aKYMtgG3gSpLj6VNh8rT1eGUcktvLg0Tvs
 M/Alb/VRxp/gKJumB0zRFGnxO8+8nR8EhgS1MAYxaVOvFLdZQ4VDqmIASUvjCP6jo309
 VDvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707917215; x=1708522015;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JkKIIyyayaWmaZiTpC42WkmMQCYGzUnrOFt0aLIAKNU=;
 b=jNTfUJ2izBKpfyynmh2yui9j1iw4PD9WMOcyvnLcsmZJSVVumRRKea+oh9U+hSNVbh
 ffEN7tzUUQY3ox354OQ8CyER1d70jdQ7vCrM+kRkrJegBVj9TkC+qLG/MNXedDk3gwCD
 KsxVECZugqxGWLfSJqQCaHjphqeoFe9ePD/nbkyjeHvx1AwCsFkUUfcJNEmmmG1Dh+GB
 O+mYaMfrSw8CTZig6AyUSUH8pTOvhaRanYW/KRmFsY/fYSsLjTeDRzZq+p+JclriF6bZ
 RXtOkhTJMolndaTAKnvJIjhz21xniX6GG+9gZCGeUhwEAbYc7vxDDXI3nGxE8CMMJ6IM
 bkHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEKd4QTL0PzBoxiQjioChE+qeyJS2rz7OQVggRPBJnvIJUGhFA+Ql+QU8TQ5syLlW8VPicxBQDUG5HXa4GdvvsvWwOUOg=
X-Gm-Message-State: AOJu0Yz6sgqhwnkzN1yF0T+r09ynyBbvCC2Ei3HFaCRH9qXz9n/eHTaW
 77VoyF10ELwJFQR8ybmUs5eRPR48EyScCGxmbA4/argp/mhuJUmwoAPSNKHleGY=
X-Google-Smtp-Source: AGHT+IE61nr7P5rfweEeh9XjbRtVWcdhx9wZzuPvK/T1vroTWA+U1NrAyyDA/ZieNoIY4GuoKVdb8Q==
X-Received: by 2002:a05:6a21:8ccc:b0:19c:a4d3:2041 with SMTP id
 ta12-20020a056a218ccc00b0019ca4d32041mr3037088pzb.42.1707917215682; 
 Wed, 14 Feb 2024 05:26:55 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCV4aNHvT2moCOE4xPueHFtK8S4vmrt0w+JscyjyhOqgj+Yqtk/Se694CossDLbGyQUl8+uEg1t71DeMOBhFgDjFUybZgXNT92vADBw1J+uQsPDk7wS2BlbP6KGHnVPqzy6skJEk3xiasthw4v43/X/k6aV1WMavtuCBXxoxpxAw9zUWqIXNq/Cziti+1UOpbb8cJzl8tEFlPhE1nBf6dQBo8sZgrL5Ev7eK8VsxVDh9PHAamDS6DjtpuMeXYbSEdU/g3QvPEwPuwHUQWaYrLLKvuxozsccIy+PN2TAxvp/vH7sd7H/UW7l4CCXyXWWmIejXH/0=
Received: from [192.168.68.110] ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 u16-20020a056a00099000b006e054704c7dsm1388142pfg.123.2024.02.14.05.26.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Feb 2024 05:26:55 -0800 (PST)
Message-ID: <fed6e86a-c982-4701-8935-df11cc5cf2ed@ventanamicro.com>
Date: Wed, 14 Feb 2024 10:26:52 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] linux-user/riscv: Sync hwprobe keys with Linux
Content-Language: en-US
To: =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Andrew Jones <ajones@ventanamicro.com>
Cc: Laurent Vivier <laurent@vivier.eu>
References: <20240207115926.887816-1-christoph.muellner@vrull.eu>
 <20240207115926.887816-3-christoph.muellner@vrull.eu>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240207115926.887816-3-christoph.muellner@vrull.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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



On 2/7/24 08:59, Christoph Müllner wrote:
> Upstream Linux recently added many additional keys to the hwprobe API.
> This patch adds support for all of them with the exception of Ztso,
> which is currently not supported in QEMU.
> 
> Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   linux-user/syscall.c | 98 ++++++++++++++++++++++++++++++++++++++++----
>   1 file changed, 91 insertions(+), 7 deletions(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 43467c9707..3ba20f99ad 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -8793,13 +8793,41 @@ static int do_getdents64(abi_long dirfd, abi_long arg2, abi_long count)
>   #define     RISCV_HWPROBE_BASE_BEHAVIOR_IMA (1 << 0)
>   
>   #define RISCV_HWPROBE_KEY_IMA_EXT_0     4
> -#define     RISCV_HWPROBE_IMA_FD       (1 << 0)
> -#define     RISCV_HWPROBE_IMA_C        (1 << 1)
> -#define     RISCV_HWPROBE_IMA_V        (1 << 2)
> -#define     RISCV_HWPROBE_EXT_ZBA      (1 << 3)
> -#define     RISCV_HWPROBE_EXT_ZBB      (1 << 4)
> -#define     RISCV_HWPROBE_EXT_ZBS      (1 << 5)
> -#define     RISCV_HWPROBE_EXT_ZICBOZ   (1 << 6)
> +#define		RISCV_HWPROBE_IMA_FD		(1 << 0)
> +#define		RISCV_HWPROBE_IMA_C		(1 << 1)
> +#define		RISCV_HWPROBE_IMA_V		(1 << 2)
> +#define		RISCV_HWPROBE_EXT_ZBA		(1 << 3)
> +#define		RISCV_HWPROBE_EXT_ZBB		(1 << 4)
> +#define		RISCV_HWPROBE_EXT_ZBS		(1 << 5)
> +#define		RISCV_HWPROBE_EXT_ZICBOZ	(1 << 6)
> +#define		RISCV_HWPROBE_EXT_ZBC		(1 << 7)
> +#define		RISCV_HWPROBE_EXT_ZBKB		(1 << 8)
> +#define		RISCV_HWPROBE_EXT_ZBKC		(1 << 9)
> +#define		RISCV_HWPROBE_EXT_ZBKX		(1 << 10)
> +#define		RISCV_HWPROBE_EXT_ZKND		(1 << 11)
> +#define		RISCV_HWPROBE_EXT_ZKNE		(1 << 12)
> +#define		RISCV_HWPROBE_EXT_ZKNH		(1 << 13)
> +#define		RISCV_HWPROBE_EXT_ZKSED		(1 << 14)
> +#define		RISCV_HWPROBE_EXT_ZKSH		(1 << 15)
> +#define		RISCV_HWPROBE_EXT_ZKT		(1 << 16)
> +#define		RISCV_HWPROBE_EXT_ZVBB		(1 << 17)
> +#define		RISCV_HWPROBE_EXT_ZVBC		(1 << 18)
> +#define		RISCV_HWPROBE_EXT_ZVKB		(1 << 19)
> +#define		RISCV_HWPROBE_EXT_ZVKG		(1 << 20)
> +#define		RISCV_HWPROBE_EXT_ZVKNED	(1 << 21)
> +#define		RISCV_HWPROBE_EXT_ZVKNHA	(1 << 22)
> +#define		RISCV_HWPROBE_EXT_ZVKNHB	(1 << 23)
> +#define		RISCV_HWPROBE_EXT_ZVKSED	(1 << 24)
> +#define		RISCV_HWPROBE_EXT_ZVKSH		(1 << 25)
> +#define		RISCV_HWPROBE_EXT_ZVKT		(1 << 26)
> +#define		RISCV_HWPROBE_EXT_ZFH		(1 << 27)
> +#define		RISCV_HWPROBE_EXT_ZFHMIN	(1 << 28)
> +#define		RISCV_HWPROBE_EXT_ZIHINTNTL	(1 << 29)
> +#define		RISCV_HWPROBE_EXT_ZVFH		(1 << 30)
> +#define		RISCV_HWPROBE_EXT_ZVFHMIN	(1 << 31)
> +#define		RISCV_HWPROBE_EXT_ZFA		(1ULL << 32)
> +#define		RISCV_HWPROBE_EXT_ZACAS		(1ULL << 34)
> +#define		RISCV_HWPROBE_EXT_ZICOND	(1ULL << 35)
>   
>   #define RISCV_HWPROBE_KEY_CPUPERF_0     5
>   #define     RISCV_HWPROBE_MISALIGNED_UNKNOWN     (0 << 0)
> @@ -8860,6 +8888,62 @@ static void risc_hwprobe_fill_pairs(CPURISCVState *env,
>                        RISCV_HWPROBE_EXT_ZBS : 0;
>               value |= cfg->ext_zicboz ?
>                        RISCV_HWPROBE_EXT_ZICBOZ : 0;
> +            value |= cfg->ext_zbc ?
> +                     RISCV_HWPROBE_EXT_ZBC : 0;
> +            value |= cfg->ext_zbkb ?
> +                     RISCV_HWPROBE_EXT_ZBKB : 0;
> +            value |= cfg->ext_zbkc ?
> +                     RISCV_HWPROBE_EXT_ZBKC : 0;
> +            value |= cfg->ext_zbkx ?
> +                     RISCV_HWPROBE_EXT_ZBKX : 0;
> +            value |= cfg->ext_zknd ?
> +                     RISCV_HWPROBE_EXT_ZKND : 0;
> +            value |= cfg->ext_zkne ?
> +                     RISCV_HWPROBE_EXT_ZKNE : 0;
> +            value |= cfg->ext_zknh ?
> +                     RISCV_HWPROBE_EXT_ZKNH : 0;
> +            value |= cfg->ext_zksed ?
> +                     RISCV_HWPROBE_EXT_ZKSED : 0;
> +            value |= cfg->ext_zksh ?
> +                     RISCV_HWPROBE_EXT_ZKSH : 0;
> +            value |= cfg->ext_zkt ?
> +                     RISCV_HWPROBE_EXT_ZKT : 0;
> +            value |= cfg->ext_zvbb ?
> +                     RISCV_HWPROBE_EXT_ZVBB : 0;
> +            value |= cfg->ext_zvbc ?
> +                     RISCV_HWPROBE_EXT_ZVBC : 0;
> +            value |= cfg->ext_zvkb ?
> +                     RISCV_HWPROBE_EXT_ZVKB : 0;
> +            value |= cfg->ext_zvkg ?
> +                     RISCV_HWPROBE_EXT_ZVKG : 0;
> +            value |= cfg->ext_zvkned ?
> +                     RISCV_HWPROBE_EXT_ZVKNED : 0;
> +            value |= cfg->ext_zvknha ?
> +                     RISCV_HWPROBE_EXT_ZVKNHA : 0;
> +            value |= cfg->ext_zvknhb ?
> +                     RISCV_HWPROBE_EXT_ZVKNHB : 0;
> +            value |= cfg->ext_zvksed ?
> +                     RISCV_HWPROBE_EXT_ZVKSED : 0;
> +            value |= cfg->ext_zvksh ?
> +                     RISCV_HWPROBE_EXT_ZVKSH : 0;
> +            value |= cfg->ext_zvkt ?
> +                     RISCV_HWPROBE_EXT_ZVKT : 0;
> +            value |= cfg->ext_zfh ?
> +                     RISCV_HWPROBE_EXT_ZFH : 0;
> +            value |= cfg->ext_zfhmin ?
> +                     RISCV_HWPROBE_EXT_ZFHMIN : 0;
> +            value |= cfg->ext_zihintntl ?
> +                     RISCV_HWPROBE_EXT_ZIHINTNTL : 0;
> +            value |= cfg->ext_zvfh ?
> +                     RISCV_HWPROBE_EXT_ZVFH : 0;
> +            value |= cfg->ext_zvfhmin ?
> +                     RISCV_HWPROBE_EXT_ZVFHMIN : 0;
> +            value |= cfg->ext_zfa ?
> +                     RISCV_HWPROBE_EXT_ZFA : 0;
> +            value |= cfg->ext_zacas ?
> +                     RISCV_HWPROBE_EXT_ZACAS : 0;
> +            value |= cfg->ext_zicond ?
> +                     RISCV_HWPROBE_EXT_ZICOND : 0;
>               __put_user(value, &pair->value);
>               break;
>           case RISCV_HWPROBE_KEY_CPUPERF_0:

