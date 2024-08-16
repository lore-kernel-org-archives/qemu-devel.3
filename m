Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 062A7C531DC
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 05:44:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sepkA-0002FJ-7C; Fri, 16 Aug 2024 01:43:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sepk9-0002EK-9W
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 01:43:21 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sepk7-0007ZQ-Ik
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 01:43:21 -0400
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7093472356dso900315a34.0
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 22:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723786998; x=1724391798; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Vq4mUPgtZZVsmG3dzx1X5+gSOFWScO0Ahy9DY51xQbQ=;
 b=Dyc36wA4ITLzhQ9KR9dqOOV67NRd+k3+/+YY/ltQamj2U7otId2jtxid+3jQ13TeTY
 JpNSXkr1xp5YhgAIVnFM9KnM/6hZFzZ/9Mv1pnNc/ji8VXkpkGLvGbEB+xtR8qMrGOzn
 3YjsmHPFN08Dku0evIy55Q/6K3TRZQDCHbvcRp+LjhmXBdOoHk7Di2AmXK9HK2QpPiHg
 W1+ZycKi3GebB5yg7OKmk64RscECZEkHus5oeAjJrmYGbX3tBKTH3aYjHjjO3on9tj85
 3uuVWzRmNKtE4j+qLlS1zlk+evb5QD1mVDSVtUZrGqfji8KO9+VJERciCTiSnRxnHSNx
 VZJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723786998; x=1724391798;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Vq4mUPgtZZVsmG3dzx1X5+gSOFWScO0Ahy9DY51xQbQ=;
 b=rgYZ+Dy+liIdhixvFvpOI3p6N9+NGI1cL5MD2OPB99Mx9BXU8YkCdI6q4NDamYN/gN
 /aY3mCJ/DGGtGPaUMry414QY6rTMJ+LRjKs0Psnw2eFQ048mnYW6tiF6WPEnAxrJwTmk
 9lKPiQz/loq7hgidYf4Mns3xmOYNBNqWKSCB/XYnhr5alLfJ5QO7K+MlNg6zARKEjGhE
 oHohp0tdukHnZcJBBJbvjY1h6kjtdB5bEp1qi86ePzHry19+NxMQgZ7+25K3oVViShoV
 tKmJ8iKHvnu9hERk2yG7YiFGG7eWWjvzTqntkblMtVWptfBANf5XKozNYyMgoHHj9Nj1
 KRPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+s4q5qdduh5tX6fsLvm1CPJ89AcY973nHtk+NsufEv/Tf4goVhT/1CUW3gJhmJLy8qYC7d/mYCNFg4oc0f1wTd4Dxdkg=
X-Gm-Message-State: AOJu0Yztr+NnF5cQ4hS1g++kCJwK+ILAScyE8680ll6RrGUUEs9dQZkd
 OPjy56pDTcW/UbBDjaDUfln0VOtf1omxtC3BDOsSNZ2q2f75Fr64INu5WmkQOds=
X-Google-Smtp-Source: AGHT+IHWqeaayeU7wabRVZtltx2c9GXhSYuEoqLtfwBk5cB/0aNuDvQ7Pwx0Kr3pVMTiYJm2fNyL2Q==
X-Received: by 2002:a05:6358:b3d6:b0:1aa:b887:2386 with SMTP id
 e5c5f4694b2df-1b39319974bmr272057055d.10.1723786997526; 
 Thu, 15 Aug 2024 22:43:17 -0700 (PDT)
Received: from ?IPV6:2403:580a:f89b:0:1b6b:8c7b:90f9:144f?
 (2403-580a-f89b-0-1b6b-8c7b-90f9-144f.ip6.aussiebb.net.
 [2403:580a:f89b:0:1b6b:8c7b:90f9:144f])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7127af3ab4asm1894355b3a.187.2024.08.15.22.43.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Aug 2024 22:43:17 -0700 (PDT)
Message-ID: <9e2597e6-9f97-4065-9d05-75b6a2550ddc@linaro.org>
Date: Fri, 16 Aug 2024 15:43:08 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/16] target/riscv: implement zicfiss instructions
To: Deepak Gupta <debug@rivosinc.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, pbonzini@redhat.com, jim.shu@sifive.com,
 andy.chiu@sifive.com, kito.cheng@sifive.com
References: <20240816010711.3055425-1-debug@rivosinc.com>
 <20240816010711.3055425-13-debug@rivosinc.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240816010711.3055425-13-debug@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x335.google.com
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

On 8/16/24 11:07, Deepak Gupta wrote:
> +static bool trans_ssamoswap_w(DisasContext *ctx, arg_amoswap_w *a)
> +{
> +    REQUIRE_A_OR_ZAAMO(ctx);
> +    /* back cfi was not enabled, return false */
> +    if (!ctx->bcfi_enabled) {
> +        return false;
> +    }

Please drop all of these comments which exactly mirror the code and provide no additional 
insight.

> +static bool gen_sspopchk(DisasContext *ctx, int rs1_reg)
> +{
> +    /* back cfi was not enabled, return false */
> +    if (!ctx->bcfi_enabled) {
> +        return false;
> +    }
> +
> +    /*
> +     * sspopchk can only compare with x1 or x5. Everything else defaults to
> +     * zimops
> +     */
> +
> +    assert(rs1_reg == 1 || rs1_reg == 5);

These asserts seems redundant.  Yes, this is true and a result of the encoding, but 
nothing in this function would misbehave if some future extension allowed any other 
register number.


r~

