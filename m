Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B57FC25B7A
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 11:28:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9k7w-00024u-8Q; Wed, 22 May 2024 07:27:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1s9k7r-00022t-Nz
 for qemu-devel@nongnu.org; Wed, 22 May 2024 07:27:20 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1s9k7o-0001YQ-94
 for qemu-devel@nongnu.org; Wed, 22 May 2024 07:27:17 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1ecd9a81966so5580255ad.0
 for <qemu-devel@nongnu.org>; Wed, 22 May 2024 04:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1716377233; x=1716982033; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bCiwcr3BC98IUvU80cUNNmD1mZSliUq/337Wrtxnoqs=;
 b=O/9ns5vlCHuzGETOK1ybP/YVZrKnz+xYutx8+41pbs0UICyjJk2+Q1Vz/+cyRXWkLG
 /+j7LkvOB2bDe8REurPM4PLB3/b2f1uDrgyROpraTJpYHRIR7X9f+Odeq4LpQ/Xoh0eq
 /eOu7udp/ZSK6mSvTZ2+O9s2G6j4vR5GPMhyAk3YW/x3F9MKUke+uO5On2CT75Mjgd9n
 f/XGbu9VXtnR5A4iECGcKkCCsRYkHj2qtseCYkoxZ38cidssVuJXQyzT36QggCtIqHgP
 xtnimPCUjQN16zJG/1dQZIMEjqqNtZoSpJxnr43fI4T1COech8aoWlpl4idzYsvPVTPg
 ZlcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716377233; x=1716982033;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bCiwcr3BC98IUvU80cUNNmD1mZSliUq/337Wrtxnoqs=;
 b=a7K+fHJMKsi8ankRivgKqfCVw6dfPCyiayQwWljNptiCp+EjZXvfq5txn6AjXVQdAI
 RNGy8k5DeVCJoVCxEv4DzCQNLdwWLcXW6frsuHKzcvN/qviB9bV3HRxdU3uWMMwMcJwe
 5PuZpP1pg0poQh2t8/K95TD5l/Z3Xd2meNaXOe33MF2/Xr6JbGLRXhl7s4rm2qEZxN7i
 5PVLWsQYBtYosmQt2RUjSAqZpWul/2VP+vowMaRYRCb89fRPIIICSJjXKVxRCVabWBuG
 G/8iQwZcoXrxxG7GQ1MYk+hICwjjYCym2YQyTFpv4Uqz2iqdl1p6/J6swhE7Lhn5CXIN
 XFUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgIaH3UabcOmZMS9gbBXUCQLGPL9+m46X3ECl/6vZxGEvZRXdERWq+mE21yKhLaLKReglZDUzYeKmpEeXQAwSolPSpygI=
X-Gm-Message-State: AOJu0YzAKqxvCpqFQmtt8qaQrhVrB9PoZzfUDGYtK7AhPfK/TEjyCJut
 jFtDC7Lb40BNjGPYGRAgtuTorqN2zKDiMHaz1zm7qpQQqpA6kepVGrnU5oxYUis=
X-Google-Smtp-Source: AGHT+IGR9nMmrTsT1ueVNGHvIQnLIMIxe68jzyEEPySyU0xZOIqJbv4SKpw/lBTy9p3w39k3WXH1sw==
X-Received: by 2002:a17:902:d484:b0:1f3:2451:8de8 with SMTP id
 d9443c01a7336-1f32451a471mr20793915ad.7.1716377233417; 
 Wed, 22 May 2024 04:27:13 -0700 (PDT)
Received: from ?IPV6:2804:7f0:bdcd:fb00:6501:2693:db52:c621?
 ([2804:7f0:bdcd:fb00:6501:2693:db52:c621])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f32219b224sm10630335ad.294.2024.05.22.04.27.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 May 2024 04:27:12 -0700 (PDT)
Message-ID: <c74c6bb2-d7fd-4f11-9abe-158c1b48f7e2@ventanamicro.com>
Date: Wed, 22 May 2024 08:27:08 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] target/riscv: Move Guest irqs out of the core
 local irqs range.
To: Rajnesh Kanwal <rkanwal@rivosinc.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn,
 zhiwei_liu@linux.alibaba.com, atishp@rivosinc.com, apatel@ventanamicro.com
References: <20240520125157.311503-1-rkanwal@rivosinc.com>
 <20240520125157.311503-3-rkanwal@rivosinc.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240520125157.311503-3-rkanwal@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62f.google.com
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



On 5/20/24 09:51, Rajnesh Kanwal wrote:
> Qemu maps IRQs 0:15 for core interrupts and 16 onward for
> guest interrupts which are later translated to hgiep in
> `riscv_cpu_set_irq()` function.
> 
> With virtual IRQ support added, software now can fully
> use the whole local interrupt range without any actual
> hardware attached.
> 
> This change moves the guest interrupt range after the
> core local interrupt range to avoid clash.
> 
> Fixes: 1697837ed9 ("target/riscv: Add M-mode virtual interrupt and IRQ filtering support.")
> Fixes: 40336d5b1d ("target/riscv: Add HS-mode virtual interrupt and IRQ filtering support.")
> 
> Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/cpu_bits.h | 3 ++-
>   target/riscv/csr.c      | 9 ++++++++-
>   2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index 74318a925c..a470fda9be 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -695,7 +695,8 @@ typedef enum RISCVException {
>   #define IRQ_M_EXT                          11
>   #define IRQ_S_GEXT                         12
>   #define IRQ_PMU_OVF                        13
> -#define IRQ_LOCAL_MAX                      16
> +#define IRQ_LOCAL_MAX                      64
> +/* -1 is due to bit zero of hgeip and hgeie being ROZ. */
>   #define IRQ_LOCAL_GUEST_MAX                (TARGET_LONG_BITS - 1)
>   
>   /* mip masks */
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 152796ebc0..464e0e57a3 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -1148,7 +1148,14 @@ static RISCVException write_stimecmph(CPURISCVState *env, int csrno,
>   
>   #define VSTOPI_NUM_SRCS 5
>   
> -#define LOCAL_INTERRUPTS (~0x1FFF)
> +/*
> + * All core local interrupts except the fixed ones 0:12. This macro is for
> + * virtual interrupts logic so please don't change this to avoid messing up
> + * the whole support, For reference see AIA spec: `5.3 Interrupt filtering and
> + * virtual interrupts for supervisor level` and `6.3.2 Virtual interrupts for
> + * VS level`.
> + */
> +#define LOCAL_INTERRUPTS   (~0x1FFFULL)
>   
>   static const uint64_t delegable_ints =
>       S_MODE_INTERRUPTS | VS_MODE_INTERRUPTS | MIP_LCOFIP;

