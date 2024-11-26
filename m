Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C3E7D6554E
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 19:03:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tG0pq-00027Q-DP; Tue, 26 Nov 2024 14:02:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tG0po-00024w-8c
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 14:02:52 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tG0pl-00038I-GG
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 14:02:51 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-724d8422dbaso4700862b3a.0
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 11:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732647767; x=1733252567; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2xtpQTZ3jJBT2lPJuVieDDPYS52EIBxy/etYrma13P8=;
 b=MBZ6p3OZixdNFIqLCq3FhRbEy+uZzhXV33u6ox8ZcRt96kc5EwUKnQHpiQkZamkQzK
 378K9SEI+o9Nv/uhISv8Hj2rd1nrEU8dGzBDBrZENQrYXIUYYGfR0mjjwb/+V6puCOJx
 zcs2JE0UlzbnwavCycgU9ccrscxBj5RFIGR9cBVz4QNyz0SrBD0Rg/GYmTYomzyjtDeK
 BN1BYGVH+ODi1doNVDK+cobllVrjaN92yR5JsI6+8zKBcTUVKqseCBP30sFA/AoB1js3
 QOP46UWm4RMbw3GGFl1tO4HchOAZUUAE7o/N4iszQi5lpXT34iGb5Zo4BYc2XkzH/cR9
 hcgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732647767; x=1733252567;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2xtpQTZ3jJBT2lPJuVieDDPYS52EIBxy/etYrma13P8=;
 b=jnYQfv6FkvKepf7wa4QwjCzqjOPUk3SSaFuTXKOArp7zLbmReIQ0wslzC57STiCiXu
 0w8/pN70CmLD0xq6vMSFv5MusgrA035l/d3+zUBsXLkVwRojYOKQmEX6j4AMrwje19d5
 hOt50zv88XH+y1xy7YIuJxK3hQHu+jtgaIZ5zq9bGI2lXyuhoG42lwnx1XpP9Aj+Z6D1
 VUxXFtIwUUhWONRcCjtLkE9189eosy/b5Y0NvjxhvsQFVSE3wSa5EcDIegylENKOtivx
 3qnTMznPESZ8brO+ya0aaJRNY5mLF9mw6hnVt5SEwA0e6ZK73fLOTKzzwGWuP2DRSbOC
 z80w==
X-Gm-Message-State: AOJu0YzbR+Gh7v7oNl8MTogqE8kNs8/gabFjZ9Jruix80x+FNkY41got
 b0pRdaSEhMGswCaadiGNiD2NSaLjS41Ejw3p5I//TY989wHOfpr/+95M98V5AwahatG0LmQ7vP3
 u1Kc=
X-Gm-Gg: ASbGnctw8YGva9Kpi7C4uzoBYjHbbIw5gAqoK3ZeFdsRo4pKwVkAtMoVSiabEkVwdP+
 sQe0Xs7wPRmi/b7AJYQGuJzKvd2+Lp6Lcpr3GnXR4pJUI4tACYuo8ZDCY0nDKco9AXhJZX6Qo4M
 K829KyR3qa+kDCxRDn49UX//0dA3zBGliPs62f4dza0jiJi70Qyj1UIgVR/vs/Y4LptKwGMT5Bs
 zw0C34B/9OoWsHiMHaKqmYAK7doRkvAKJwf9nYd7tCE8lE3aGvccUHuFEPXcvD7HOMT5obh2zMs
 LpEqh8UhXdrx9fDcOLI9Zw==
X-Google-Smtp-Source: AGHT+IHz/Cy8qrcMrcNQGIbd751FQhYHv7agT++WgNzcMfXQwMOq2WJdBQymedaOQwsBZ+SokYcAQw==
X-Received: by 2002:a05:6a00:2d18:b0:724:5815:5e62 with SMTP id
 d2e1a72fcca58-72530010ec8mr460012b3a.8.1732647767410; 
 Tue, 26 Nov 2024 11:02:47 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-724de575d2asm9015050b3a.181.2024.11.26.11.02.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Nov 2024 11:02:46 -0800 (PST)
Message-ID: <abe8d008-ca2a-42ac-8f12-de076f3693ed@linaro.org>
Date: Tue, 26 Nov 2024 11:02:45 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] plugins: optimize cpu_index code generation
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>
References: <20241126190203.3094635-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241126190203.3094635-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x433.google.com
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

On 11/26/24 11:02, Pierrick Bouvier wrote:
> When running with a single vcpu, we can return a constant instead of a
> load when accessing cpu_index.
> A side effect is that all tcg operations using it are optimized, most
> notably scoreboard access.
> When running a simple loop in user-mode, the speedup is around 20%.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   accel/tcg/plugin-gen.c |  7 +++++++
>   plugins/core.c         | 13 +++++++++++++
>   2 files changed, 20 insertions(+)
> 
> diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
> index 0f47bfbb489..2eabeecbdcf 100644
> --- a/accel/tcg/plugin-gen.c
> +++ b/accel/tcg/plugin-gen.c
> @@ -102,6 +102,13 @@ static void gen_disable_mem_helper(void)
>   
>   static TCGv_i32 gen_cpu_index(void)
>   {
> +    /*
> +     * Optimize when we run with a single vcpu. All values using cpu_index,
> +     * including scoreboard index, will be optimized out.
> +     */
> +    if (qemu_plugin_num_vcpus() == 1) {
> +        return tcg_constant_i32(0);
> +    }
>       TCGv_i32 cpu_index = tcg_temp_ebb_new_i32();
>       tcg_gen_ld_i32(cpu_index, tcg_env,
>                      -offsetof(ArchCPU, env) + offsetof(CPUState, cpu_index));
> diff --git a/plugins/core.c b/plugins/core.c
> index bb105e8e688..8e32ca5ee08 100644
> --- a/plugins/core.c
> +++ b/plugins/core.c
> @@ -266,6 +266,19 @@ static void qemu_plugin_vcpu_init__async(CPUState *cpu, run_on_cpu_data unused)
>   
>       assert(cpu->cpu_index != UNASSIGNED_CPU_INDEX);
>       qemu_rec_mutex_lock(&plugin.lock);
> +
> +    /*
> +     * We want to flush tb when a second cpu appear.
> +     * When generating plugin code, we optimize cpu_index for num_vcpus == 1.
> +     */
> +    if (plugin.num_vcpus == 1) {
> +        qemu_rec_mutex_unlock(&plugin.lock);
> +        start_exclusive();
> +        qemu_rec_mutex_lock(&plugin.lock);
> +        tb_flush(cpu);
> +        end_exclusive();
> +    }
> +
>       plugin.num_vcpus = MAX(plugin.num_vcpus, cpu->cpu_index + 1);
>       plugin_cpu_update__locked(&cpu->cpu_index, NULL, NULL);
>       success = g_hash_table_insert(plugin.cpu_ht, &cpu->cpu_index,

This patch is for 10.0.

