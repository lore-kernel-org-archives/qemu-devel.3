Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAC01CD11DD
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 13:25:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp6nM-00063C-Gg; Tue, 26 Mar 2024 09:24:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rp6nK-00062v-QO
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 09:24:50 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rp6nJ-000285-2N
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 09:24:50 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-513e6777af4so9977806e87.2
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 06:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711459485; x=1712064285; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=65XCfs/Ir1b0ose9yizR8ZF74ipSKqjZB2NspdFF4rA=;
 b=Cr3BLN++lSQC5MYwOXH2iX889srEtnbBwVkvLCk5jqwnxK+1iHNHjpxXSRuIHXS+av
 zGoUGZV8jsUGByZaGw5hgsuj49YORg0fjRHdUrJb6YiPvZSLd+d+/o0Q/mfTP21I8EQM
 ppaVOvLPlhiQgmGAkiOF35AOQMuz+4U6CqbSxoq0APOwZSdVVARPj8ZsvwvrUuwxLY0A
 oPEGomq9cIljs3UtKX8U5R29n+4oXhJd7ubZUY6gdfSlcZJPp7IUyyXfuis97dldLZu2
 VkCl40Ycgb77HqsgTRWzMTx2GACTWIjBHlZ10GBAUKRIhKTrE08Ml23u2AiaiaXmPizr
 Xn+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711459485; x=1712064285;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=65XCfs/Ir1b0ose9yizR8ZF74ipSKqjZB2NspdFF4rA=;
 b=FVit686FKdmmqP46F1nbmg295q3wqZAj4fpG6EOyQ/rP8bBHDVjQ+0q7qBbjUOOlrt
 3tfPXbajtnegky/S554UlpNkXe2yrm3CxKf1rG20CkeFYT3Xh0HBvyTRosKIeRvXUa/J
 ADzxLkvU0fvE/i+mWKXzIuicxKfgCaLQLN68dyVUUJt9zESqszUEcY1StCX5UREaMoRt
 9IVaBOFfGiONMitS85cxg5TLwSIaVNGhkFB0FdXrCfoXEos0ja0HAS9dr4xKGbjkmeFy
 jm4TrSpX74zgSy5cc9Dq5dIPXw+7uXj6iTLF5CRgEKw2Z7br6Yrmf9oYIEi+3OtBJzRR
 C5Cg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlPmFdXrf0Fi1QdG/oi+F9ukpgZGR/BGxVWNUL3M9e4E0mBz2juhoLiE0FSW48hllGeISC/t0wvSl8JKCEB4G2U7+rMN0=
X-Gm-Message-State: AOJu0YyMXvhhguwMk0qaojnSNcIFcKbjI8BSLa7YHsLp0oGM17FnikCX
 SUMwWjrdQL8FQRX+JzajnbKGXlSaThWexuVk6eEtStSzoE9a1iXRrNWayyxsoQg=
X-Google-Smtp-Source: AGHT+IH1iTUMdcXa+WUVnWYmXr5yZegTAh8tkbTdmz1d5+tuRcPDZUqjaO3imi6C/Nn/EjgDpyPTFg==
X-Received: by 2002:a05:6512:39d2:b0:515:bb3a:10ae with SMTP id
 k18-20020a05651239d200b00515bb3a10aemr950782lfu.13.1711459485057; 
 Tue, 26 Mar 2024 06:24:45 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.155.229])
 by smtp.gmail.com with ESMTPSA id
 xj8-20020a170906db0800b00a4a33a9f077sm2435772ejb.11.2024.03.26.06.24.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Mar 2024 06:24:44 -0700 (PDT)
Message-ID: <2614452e-d07c-4ed5-aa0f-2550dcaabbfd@linaro.org>
Date: Tue, 26 Mar 2024 14:24:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/1] target/i386: Fix page walking from MMIO memory.
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 qemu-devel@nongnu.org, richard.henderson@linaro.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Gregory Price <gregory.price@memverge.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, linuxarm@huawei.com
References: <20240307155304.31241-1-Jonathan.Cameron@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240307155304.31241-1-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x135.google.com
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

On 7/3/24 16:53, Jonathan Cameron via wrote:
> Previously: tcg/i386: Page tables in MMIO memory fixes (CXL)
> Richard Henderson picked up patches 1 and 3 which were architecture independent
> leaving just this x86 specific patch.
> 
> No change to the patch. Resending because it's hard to spot individual
> unapplied patches in a larger series.

Thanks, patch queued!


