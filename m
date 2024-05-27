Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45A00C25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 12:01:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBZ2o-0006LD-Cm; Mon, 27 May 2024 08:01:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sBZ1x-0005rZ-Mj
 for qemu-devel@nongnu.org; Mon, 27 May 2024 08:00:58 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sBZ1l-0007AK-TP
 for qemu-devel@nongnu.org; Mon, 27 May 2024 08:00:44 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6f8f30712d3so1518846b3a.0
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 05:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1716811232; x=1717416032; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pc/Tkjis5XeImBvmJITZnH/KmPwAH0V1NbX3r/8OaGI=;
 b=KMAhHpOp/neMRefIR7dJPHEhiKv2GVd6Ip6TqpQ6es1sn++pW2F8xnaQGpL5ru9uu3
 G94jrjJ2XO5/e8pOS6cGteSU/g7YGW3JP9VhMD8XDO9v7l5Y7DrcfGmO7YKeJSYModIg
 TNvfZL7n9AdCnhblGZDKk0Hv2x4KWwP2o7FbiQkIUMVEOd48ex06y9kDdbKeqD44eyS6
 aS1JxjEnqT8Ch2jnYezjlu1E+KHO8yPvXX8+wFK9Rot1fwUFqrMTkdLbkO504LFtosC8
 XBCQOyM2GVUiz5UU1UdUTFX8br9+W2yPuVmeSc08E3XnSqKTDXK5Lg5n+lRVPPXjUBXC
 fy5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716811232; x=1717416032;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pc/Tkjis5XeImBvmJITZnH/KmPwAH0V1NbX3r/8OaGI=;
 b=wwxXpW3u8iif5pvNMHBJvXQDeXShC91oEXaGynUgtS4eiGRbnl3iFUBstJx58aPpHB
 lnvU4f63h/nYoZ3xRiSbWFrMQw2VqORRtBDFF3ZtmLL5eiZqmLKQl+DFCt/J15W0oO6j
 Hmi1VUL66Ri4JjrM4ckBSaWyDzD6chqxdFXTtf9ESBtE5Rq4d/UfEuOVe4zBeLNMQfGv
 9VxWq7QbCc401SFNPGKYPiZuxsWoc4mM02PWxViwAL3iGiJN68R/mPDz3DLSnoVicYHK
 CJAX3uWVBcylHd0mdRnhd0VgxycPagZ8iNg2LgtWHAung1pYyVCzWe32lA/pp4nnVZQW
 /Tgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcaQLOD0ROuVtgK7zOvhobrdrRg+QqinSEWlJcDTfKjuW1bwKoo3QAmxZemt8aWURmICdTPPo1BtNuzEswBvqeJVeEMcQ=
X-Gm-Message-State: AOJu0Yy2IdjiAh+ZhYjOFmTlKADKn51EiWQfhjNMnQ9CyWGwJkVt/T2m
 5hS8QV76IIt20mfBHX+CNHW3DTUdjtnKUGxFslfKkX072ahV5NkqkRBexEaCFOM=
X-Google-Smtp-Source: AGHT+IHlV7Zqu1Q4nmqAywDlRIr7g0SNFYXek06csnrV/su/EbTKHZo65v/Aun+fTZ8fQ7anihieoQ==
X-Received: by 2002:a17:903:22cd:b0:1f3:b71:7983 with SMTP id
 d9443c01a7336-1f339ef4895mr176356915ad.5.1716811232051; 
 Mon, 27 May 2024 05:00:32 -0700 (PDT)
Received: from ?IPV6:2804:7f0:bdcd:fb00:6501:2693:db52:c621?
 ([2804:7f0:bdcd:fb00:6501:2693:db52:c621])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c9a88e0sm59419045ad.231.2024.05.27.05.00.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 May 2024 05:00:31 -0700 (PDT)
Message-ID: <e2d5c607-cac3-44a5-88f5-0736332f4047@ventanamicro.com>
Date: Mon, 27 May 2024 09:00:24 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/4] target/riscv/kvm: implement
 kvm_arch_update_guest_debug()
To: Chao Du <duchao@eswincomputing.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, pbonzini@redhat.com, alistair23@gmail.com,
 bin.meng@windriver.com, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com,
 palmer@dabbelt.com, anup@brainfault.org, duchao713@qq.com
References: <20240527021916.12953-1-duchao@eswincomputing.com>
 <20240527021916.12953-3-duchao@eswincomputing.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240527021916.12953-3-duchao@eswincomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 5/26/24 23:19, Chao Du wrote:
> Set the control flag when there are active breakpoints. This will
> help KVM to know the status in the userspace.
> 
> Signed-off-by: Chao Du <duchao@eswincomputing.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/kvm/kvm-cpu.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index cba55c552d..0bc3348b91 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -2039,5 +2039,7 @@ void kvm_arch_remove_all_hw_breakpoints(void)
>   
>   void kvm_arch_update_guest_debug(CPUState *cs, struct kvm_guest_debug *dbg)
>   {
> -    /* TODO; To be implemented later. */
> +    if (kvm_sw_breakpoints_active(cs)) {
> +        dbg->control |= KVM_GUESTDBG_ENABLE;
> +    }
>   }

