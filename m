Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44F3FC54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 21:26:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk9cx-0005U4-8x; Tue, 12 Mar 2024 17:25:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rk9cs-0005Tp-9Z
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 17:25:34 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rk9cp-0001Ct-B8
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 17:25:33 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1dd922cbcc7so22121225ad.2
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 14:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710278729; x=1710883529; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=j5JrVxYy+obXv7d2K5l9mDVpuft+Js5ChOayDs7VpbY=;
 b=aMDGItZwP2rzFuvE6TjzLnFwbNhCUnOrE+pz/I2UIOGl64h0gra+Yi4253TYsunZbN
 +Jm/bZD1b/j12iGors5jNcjMCKTsORTXXQo+svCDZ8YItGPCdnaOovEOO+elqqO0E7Ii
 kSUAjtDcPLkR3prvJlpEpFFEuCKnEb/0LIydrnqsUhnjnuUsdCWNOrkycqAUYWrHR0dn
 xz6poaE5vHG6QHOOt0+iflQwJDhngnkjI+9xM7ZAK7GQNdW0JTwmrTuEvy6+jkKRZkzn
 doyh6m7D7bDLaB/jqK+KpFKpXDJYuPYMdbvgH1mj+q47ni9bGtu9m/StMHulTvz4tmal
 ozgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710278729; x=1710883529;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j5JrVxYy+obXv7d2K5l9mDVpuft+Js5ChOayDs7VpbY=;
 b=iqpzNw5meDgkHpstRsgU6vhJBlvY0MHMXHY3UdGFyVeb+3sc2nOLcoOf21GWDY72+g
 eiM8z2b8mc3uOUGcy/p3JQN7JqXomPQhhwZHVpxJdAVXaV9Jr/hR4aDxEPHEDJyCBHan
 IBzL6OvrvqIxY7tT71+H5RT0F/l6HH9VjgFKoQtW9DwtwmHc8xFSAlVsUk5Jbbphp1SL
 to2PBFFv8+Nwg6CaZvUt8vnD/lGXHqphbdS1lAuYU/xd9xMbhpH4JRhrDUagShrYrXuw
 PnGoYh33ms+Lo5iYZv5G2ZQnPDgFNNl8l37cRUDH/4U5lifaGe8Dw5BAc1LhzNdagyjy
 4QoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsuyZe9N88LVS2aAtYCX3CSuTy1NnN2WSTaT6udWtvZwsen+9JzCxMM614jDXT9VbvXOozCqcHjfPqL9ApTf5MtfQYsio=
X-Gm-Message-State: AOJu0YxGj0ti4nM4Z1C85aqR1pNuNin3ifwb7Ep4BCIqWdFFTZFDVFRj
 URgw/YlcBkT/duHepNUH19VZHbdka0JfCw4GbSwlbw9ACyvkuDyyC8aRVayISB0=
X-Google-Smtp-Source: AGHT+IEhTlIOpQ0WFkaXVW8K5EM6QVHMenPp+uPN6LxIhXHgwLtoB5mOns+e+IwQIMGIsehG1xGQeQ==
X-Received: by 2002:a17:902:ce90:b0:1dd:8df3:1727 with SMTP id
 f16-20020a170902ce9000b001dd8df31727mr11990223plg.44.1710278729262; 
 Tue, 12 Mar 2024 14:25:29 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 ja11-20020a170902efcb00b001db8a5ea0a3sm7227254plb.94.2024.03.12.14.25.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 14:25:28 -0700 (PDT)
Message-ID: <e1618313-4698-4661-b5d5-dcb38f60ed52@linaro.org>
Date: Tue, 12 Mar 2024 11:25:25 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] plugins: conditional callbacks
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20240312075428.244210-1-pierrick.bouvier@linaro.org>
 <20240312075428.244210-5-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240312075428.244210-5-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 3/11/24 21:54, Pierrick Bouvier wrote:
> +/**
> + * enum qemu_plugin_cond - condition to enable callback
> + *
> + * @QEMU_PLUGIN_COND_NEVER: false
> + * @QEMU_PLUGIN_COND_ALWAYS: true
> + * @QEMU_PLUGIN_COND_EQ: is equal?
> + * @QEMU_PLUGIN_COND_NE: is not equal?
> + * @QEMU_PLUGIN_COND_LT: is less than?
> + * @QEMU_PLUGIN_COND_LE: is less than or equal?
> + * @QEMU_PLUGIN_COND_GT: is greater than?
> + * @QEMU_PLUGIN_COND_GE: is greater than or equal?
> + */
> +enum qemu_plugin_cond {
> +    QEMU_PLUGIN_COND_NEVER,
> +    QEMU_PLUGIN_COND_ALWAYS,
> +    QEMU_PLUGIN_COND_EQ,
> +    QEMU_PLUGIN_COND_NE,
> +    QEMU_PLUGIN_COND_LT,
> +    QEMU_PLUGIN_COND_LE,
> +    QEMU_PLUGIN_COND_GT,
> +    QEMU_PLUGIN_COND_GE,
> +};

Do you really need to expose ALWAYS/NEVER?
I guess these are all unsigned?  Would it be clearer to add "U" suffixes?


r~

