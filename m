Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3800BC5475B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 18:53:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcVF9-00087u-Hr; Tue, 20 Feb 2024 13:53:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rcVF7-00087N-Pu
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 13:53:25 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rcVF3-0000Ud-59
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 13:53:25 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1d51ba18e1bso58518815ad.0
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 10:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708455199; x=1709059999; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9WRxfNS8ky+LWLtjpbsHz7PlF4GYzFG3M6+KW00Isbo=;
 b=A/mNRuItPHhJEoDADiNzsOXoNS2S8oblGYrXY+aHvFttp0gjJqe+4FNEWqz6kwL3GL
 fy9eU9cYC8GENwKsbx7nJVTwkd6SafNjW6W13JiY4jSg7+SIJmGRNpk2YnXb1PBJosBu
 BHuBsOM9csnuPbUxqipupkQcNjLuqedQn1q/Z1ih8okYlRgBPahPb3bOzbOm0MGxKDcI
 DFe4Zylb51g1OrSEdipJh7k6ehJIYAXrNMVDPLdjS42PNGHwNOdn+fIT/ueMG3rh/uDi
 afOjo1z/Mttnk/SCoKpGTOXt+bm72mVi9K7reXeQ+LfNxvyqhytCQkLgSnk/tRJpALqY
 81Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708455199; x=1709059999;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9WRxfNS8ky+LWLtjpbsHz7PlF4GYzFG3M6+KW00Isbo=;
 b=n45/W7eCdwUIr0jQ1NXrrvWdXWzwwFa1lz8y57gLU6T1+teOneni5nm3Xy8avQWL+r
 nm6Lkhu5dKh164ZG6iytLqrXyhRLc/6VTbFvjDyV2huMkJHkE5mziOhbC6fG7C9aa4qr
 qSz9GslrfAVjkN4SHXYhF01dJdda7hipXhqqlSPMYY7k82Jw1a+H0NTO1+0ApmK4ee1r
 rkRiCD1QchWf6SFKqcI7VL05cXVM75wljvFiJT/xVuqCweFzrBhq2IgYvgW7B7JXPqIj
 nWpBIIEwA2qaUP5I+lPMRqHC80Pz5GvtNa/vJmF6Sm/WByMwB7tpJwl/0cha8VNHFp0M
 eV8Q==
X-Gm-Message-State: AOJu0YzUrP2vfPdTG30YduimNw8nb/Mh1VYHrcCJnh43qVvKo+zjlYsT
 ACeZSg9y+0pJNFZP3OBm1XsCAyOun2zVwOPe5cnBBQ4d6JRQrlWolbjJRTB2fL4=
X-Google-Smtp-Source: AGHT+IHyzDU3pvU1r/O1dNN0bhXdE17RQ5MmhmpBmzyxjYyb76GTEQmA7kozT4V3OwssMtz7BuulYQ==
X-Received: by 2002:a17:902:ea08:b0:1dc:19d6:bd25 with SMTP id
 s8-20020a170902ea0800b001dc19d6bd25mr2917290plg.14.1708455199682; 
 Tue, 20 Feb 2024 10:53:19 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 p3-20020a170902c70300b001d92a2b258esm6565449plp.118.2024.02.20.10.53.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Feb 2024 10:53:19 -0800 (PST)
Message-ID: <9c6c2c17-aa06-4c29-b0cc-742b641f813e@linaro.org>
Date: Tue, 20 Feb 2024 08:53:16 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/3] tcg: add a ll/sc protection facility
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org
References: <20240220041922.373029-1-npiggin@gmail.com>
 <20240220041922.373029-3-npiggin@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240220041922.373029-3-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 2/19/24 18:19, Nicholas Piggin wrote:
> +    bool llsc_prot =
> +#ifdef TARGET_HAS_LLSC_PROT
> +        cpu_physical_memory_get_dirty_flag(addr, DIRTY_MEMORY_LLSC_PROT);
> +#else
> +        false;
> +#endif

We're trying to get rid of all target-specific adjustments to TCG.
We are not keen to introduce another.
Just drop the ifdefs.

> @@ -355,6 +379,8 @@ uint64_t cpu_physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
>       unsigned long hpratio = qemu_real_host_page_size() / TARGET_PAGE_SIZE;
>       unsigned long page = BIT_WORD(start >> TARGET_PAGE_BITS);
>   
> +    assert(0);

Left over debugging?

> +
>       /* start address is aligned at the start of a word? */
>       if ((((page * BITS_PER_LONG) << TARGET_PAGE_BITS) == start) &&
>           (hpratio == 1)) {
> @@ -396,6 +422,12 @@ uint64_t cpu_physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
>                       if (tcg_enabled()) {
>                           qatomic_or(&blocks[DIRTY_MEMORY_CODE][idx][offset],
>                                      temp);
> +#ifdef TARGET_HAS_LLSC_PROT
> +			/* XXX? */
> +                        qatomic_or(&blocks[DIRTY_MEMORY_LLSC_PROT][idx][offset],
> +                                   temp);
> +#endif
> +			assert(0);

Again.

> +++ b/include/hw/core/cpu.h
> @@ -489,6 +489,11 @@ struct CPUState {
>       uint64_t random_seed;
>       sigjmp_buf jmp_env;
>   
> +    int llsc_prot_block_size;
> +    bool llsc_prot_active;

Is active identical with block_size != 0.

> +    bool llsc_resolving;

I'm not following the logic around resolving and locks...


r~

