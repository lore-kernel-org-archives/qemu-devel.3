Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E333C27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 04:41:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sK9bq-0004nC-Ci; Thu, 20 Jun 2024 00:41:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sK9bj-0004mj-2x
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 00:41:12 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sK9bh-00084U-JO
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 00:41:10 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7061365d2f3so369406b3a.3
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 21:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718858468; x=1719463268; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lu8rJ6r7nPMlvNnHFcTtIOCItHTW7QTi8MCBXF9EjL8=;
 b=Bg+nS2CSEeFVLVt27Fecp6boB7j5zp4gqexjlOvH4M3R+oFs3azwbiTTE+axwQthHS
 RTwMmW5avjkSOFFnqwBufrUjuhyDvKsLaAIPtRHYceI4QoLZo3nEplJI4jx6o9eii6yt
 8fbnW+Ew8dZS5/7ZCgsBHoJv5Hj74pxmIzraGNdwuFH3YsnAH3v19JkIVL9aOVryH0JV
 McGlq3/fxWxgcKUoXmqV2S4gb7eBn58KsFVWLpFNpnCnTJvXrFLvxHdwIrh8rBG5w2bT
 P+RXg2TcWYRuFtsCQrC3Bko6LUoxFyODoeQrFlGqBYKsrn8+Cx5Kbv5+XsQ4bNMShrOP
 sXVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718858468; x=1719463268;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lu8rJ6r7nPMlvNnHFcTtIOCItHTW7QTi8MCBXF9EjL8=;
 b=PFEB/23dt1oBVrq0b8o1RGFCsZQERtzyckL5vDv1rxTGvttzRinQWaPEr/VQIgjICa
 EOSlLM29f5hrqthsek9nO93ARFl45xTmYSsNzZTuW+T/vqNrp5quFjaaMIknUrg0TwmP
 PmdYPt2CDnox1AYHUJSHfwDRyWwX2Y4NC324+M94p6VvPb30pey1b04ocmHcv+B5cSSs
 ujJmwDBfQdIRbvoZj7eCCLC5g44MZEyXGoVW37Uy353jAZwVits3yXIbs5BdfOi+LDEg
 g69klYpcaLIwJC3d7rV/KuiHhXbazEqzLyJijfKEJD0mXtaAR/er0Yo4+QMUCDTDPuDS
 woww==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0mEIuYMP0W5Jfb9cnwTMWNgAoJX7N1cTab+oX5AnphMKO+lTGJrmlMcrrenewy5+lKJ6un76SI3hBHxE5Zpvpardag30=
X-Gm-Message-State: AOJu0YwTNTKOGMGTSB2jG8BQfxQ3m+jSul8xATbM0Alp8FlOzA0kNin/
 RFydSBzWFR/wKoraMDLAN+sVwyWcJTd6IAkyImmko7pReTJGOUVkrGIMBGnaknY=
X-Google-Smtp-Source: AGHT+IE65bXSTGakoVBJGgy+atxig5hzJ0gc2RYqJH8Ou8wkCbZQYbhWY6YNS6boLQnoBjRXGT0Tng==
X-Received: by 2002:aa7:8c04:0:b0:706:3329:5533 with SMTP id
 d2e1a72fcca58-70633295798mr3831081b3a.24.1718858467840; 
 Wed, 19 Jun 2024 21:41:07 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70644fe0d63sm287710b3a.12.2024.06.19.21.41.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Jun 2024 21:41:07 -0700 (PDT)
Message-ID: <936bcf68-d080-46dc-bf53-5bcc326fd063@linaro.org>
Date: Wed, 19 Jun 2024 21:41:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 2/5] target/riscv: rvv: Provide a fast path using
 direct access to host ram for unmasked unit-stride load/store
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20240613175122.1299212-1-max.chou@sifive.com>
 <20240613175122.1299212-3-max.chou@sifive.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240613175122.1299212-3-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

On 6/13/24 10:51, Max Chou wrote:
> +#define GEN_VEXT_LD_ELEM(NAME, ETYPE, H, LDSUF)                         \
> +static void NAME##_tlb(CPURISCVState *env, abi_ptr addr,                \
> +                       uint32_t byte_off, void *vd, uintptr_t retaddr)  \
> +{                                                                       \
> +    uint8_t *reg = ((uint8_t *)vd + byte_off);                          \
> +    ETYPE *cur = ((ETYPE *)reg);                                        \
> +    *cur = cpu_##LDSUF##_data_ra(env, addr, retaddr);                   \
> +}                                                                       \
> +                                                                        \
> +static void NAME##_host(void *vd, uint32_t byte_off, void *host)        \
> +{                                                                       \
> +    ETYPE val = LDSUF##_p(host);                                        \
> +    uint8_t *reg = (uint8_t *)(vd + byte_off);                          \
> +    *(ETYPE *)(reg) = val;                                              \
> +}

Why are you casting to and from uint8_t* ?

Surely this is cleaner as

     ETYPE *cur = vd + byte_off;


r~

