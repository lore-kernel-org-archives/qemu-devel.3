Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 848C6C021AB
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 16:38:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk47v-0008Vt-Hz; Mon, 17 Feb 2025 11:37:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tk47u-0008Vb-TI
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 11:37:46 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tk47s-0007CV-UX
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 11:37:46 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2fc0d44a876so6465220a91.3
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 08:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1739810263; x=1740415063; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QJAnQ6KSRQeLxo5DrQ1/+9lnEZmxA9TeBMNZXMAlfU0=;
 b=lYMAMOo1PDKIprCi+ln56C8KezYkmuTof5syGHbP3RySZBJNgS/wgNdHPkVp9BDeu8
 ebVg/Uq8fIuMXhOTUgiWn7hMKrVB7AShppijPlXeH52IGZAvKC3ukqq3Oql0ca3RG0xe
 yaRwyPYrWcltan65T7P0fgbEEByukEKJHeoPFzDRe2rioK99JDZsgIvMFcw+wGnwMVwH
 nkKTRZQVnY1osHO4AX18Km9Rzah0ABbnVc89dabRq7YSk8+lbqznBotd9mFe5TjUxvDx
 m+FC44f6UY5q2zLvEHxBfPKAcR2Q8h0EX+hSDslydfB7DUcMaBgwINa1/nUFjDQj6T9g
 ZRNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739810263; x=1740415063;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QJAnQ6KSRQeLxo5DrQ1/+9lnEZmxA9TeBMNZXMAlfU0=;
 b=uYntY2MB562gZhGuCf/lvk2+erPNJx8oiHvL2jd3OZg3pmmbwXf9eaTsHYLU6kfB6P
 vhq+61f/R284MpKACPz6UpewY/UC5hj+DD4HtirsuInz030YfZ2Hn/BTEC866EfTfrIT
 Hf88DGwV3FoU/W7oWQNn6Btwlib9IQ2w/piArB2Mr5iGCV7ihlFlHAwtCaoAfUTZAQAu
 izT4jA6azcYrZ0hzXu5jN9GKbz8SzbWIx2yHG4vSvkK7Yl9WMtA6KyxTTWKEcb1BwkkM
 jg6eyaqwaVeojiFOzecPbmVmL3GRvUTDjgLjwUngSRx/cboIktUCv5WV7SrUIaiNEm4g
 oMDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1WISwIBM0280hqll5TNMWNaKNQ12DBwE5UMfKujsBl45WjNpIb6T+SyjrM2z7Uls8eFnAWpoz5Fqs@nongnu.org
X-Gm-Message-State: AOJu0Ywa6LNHoEeKSwRfW2HzFcFPzMgMnyIfmYAo0nseHDUC1BpjMH5Q
 XQl/bXVaz0i/PqwsJRK5p3IDaxwoAY9gd1Mhi6hJbuBfJvN30qpRu4EbRDLOj34=
X-Gm-Gg: ASbGncv9FhVXzcr1bwnncgrejpRaZ1NM3V78KilYLMdraoVvrtFHA7vKTYagisW5hbB
 f3wCkf/uS5vC95IQnVzYUxrexhi8fj+141XcbKlQmvfTTYcrMkjo+9DnLgk297p1oCV+uvo2uq6
 SbAf68WH01smTc39yJqc9SnbuFy/7shyrqe3MIQOqQT+Z34zmxip6eg0eNbm0aP1tPf/ERE9v6E
 YOa+DLdDq2OYrU3+NdzkVhOUHbrQbYnDLhiLl+aOhQRB081ht4+3PWPZyihQlWaqUlQZg8P5kqE
 GpZOhfq7yFLL5GrEiyZk0j935HOrx/sJfkOBlcVPl2AI32hBHp3TVALUvcCaVRAT
X-Google-Smtp-Source: AGHT+IH825bkQck0StXWlhdENnRDaIpTJwiimi1Dj/JaAOoL82WE1H6EdtnQ4gFWPg4gqpDGSSMl3g==
X-Received: by 2002:a17:90b:2e46:b0:2ee:b6c5:1def with SMTP id
 98e67ed59e1d1-2fc40f0f46dmr14739663a91.8.1739810262960; 
 Mon, 17 Feb 2025 08:37:42 -0800 (PST)
Received: from [192.168.68.110] (201-68-240-180.dsl.telesp.net.br.
 [201.68.240.180]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fc13ac19aesm8301249a91.17.2025.02.17.08.37.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2025 08:37:42 -0800 (PST)
Message-ID: <ca0c6853-2968-4e3c-84ef-6656b33a51e2@ventanamicro.com>
Date: Mon, 17 Feb 2025 13:37:37 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: Respect mseccfg.RLB bit for TOR mode PMP
 entry
To: Rob Bradford <rbradford@rivosinc.com>, qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>
References: <20250210153713.343626-1-rbradford@rivosinc.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250210153713.343626-1-rbradford@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x102b.google.com
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



On 2/10/25 12:37 PM, Rob Bradford wrote:
> When running in TOR mode (Top of Range) the next PMP entry controls
> whether the entry is locked. However simply checking if the PMP_LOCK bit
> is set is not sufficient with the Smepmp extension which now provides a
> bit (mseccfg.RLB (Rule Lock Bypass)) to disregard the lock bits. In
> order to respect this bit use the convenience pmp_is_locked() function
> rather than directly checking PMP_LOCK since this function checks
> mseccfg.RLB.
> 
> Signed-off-by: Rob Bradford <rbradford@rivosinc.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>


>   target/riscv/pmp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
> index a185c246d6..85ab270dad 100644
> --- a/target/riscv/pmp.c
> +++ b/target/riscv/pmp.c
> @@ -524,7 +524,7 @@ void pmpaddr_csr_write(CPURISCVState *env, uint32_t addr_index,
>               uint8_t pmp_cfg = env->pmp_state.pmp[addr_index + 1].cfg_reg;
>               is_next_cfg_tor = PMP_AMATCH_TOR == pmp_get_a_field(pmp_cfg);
>   
> -            if (pmp_cfg & PMP_LOCK && is_next_cfg_tor) {
> +            if (pmp_is_locked(env, addr_index + 1) && is_next_cfg_tor) {
>                   qemu_log_mask(LOG_GUEST_ERROR,
>                                 "ignoring pmpaddr write - pmpcfg + 1 locked\n");
>                   return;


