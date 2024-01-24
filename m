Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E26C7C47258
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 01:19:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSRue-0000I4-AQ; Tue, 23 Jan 2024 20:18:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSRub-0000Hc-Md
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 20:18:41 -0500
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSRuY-0002Uf-Le
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 20:18:41 -0500
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3bd884146e9so3895620b6e.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 17:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706059117; x=1706663917; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jlwHxnYTelKImYkHHzfzeO8DIN7ErB5+rYvEzxnoGVQ=;
 b=NAAbhqQ+ZDmklY5u+269yWqLGoLQO2NjlPJKlRJtE5fhWKKylR+kkJkUEQ8VpfNUyt
 RZvoSTXg4N1rRM6b8N7EvCUDbGAA8Fn+UI7oF2ok6DeJzL1wFFPZENdkdY++l4YEXEWy
 3OB15+tE8s312qdRyJG3hz0TtXhqp7Mios4H8WVq9jdaoFyD0Tkz3Y250yZ7yKYsgmUH
 PHTrZS+PWYBtrBQnfwVyTao7UPXqcDxrU5U8FPYUpX9NqsLopI1vtJzUa0MYAWs0hw/4
 bUY4vEN5HLQ0Q6qQXOIKSDjiosdIgJqrNSUu3ltQVhT0K+q1NTObfl4DooUxZiDImkXH
 gKTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706059117; x=1706663917;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jlwHxnYTelKImYkHHzfzeO8DIN7ErB5+rYvEzxnoGVQ=;
 b=PIGYZrJgs/al7XYYkY/qckMP68R9zKn8bbCGuGsNTooRGZRGNtUu+8c1hPbMA5a09n
 XPEuK+R7jxcztG9hGMyjSnhCJsc3xzrUFi0GOeuqrvQQKjqztVWX5NaVJfUJUvz5nyQd
 KcRUhdCl6dKEd/euU/+F6x2MxuWryd3Od7VoCflijaeSe7XyKTwZq/BufK2R/lLJBrbf
 ULQQEUppv03poBJvXdyg7e1+pXlQWKU5c8PDqBpLElGLA/ybYPD0k4XeFY1/R3KPd5YG
 FX7V6SBSmPdWqPZMIbdTIQrkYQNhjyEPF5XZQQayv5hF3Z2WktmSNxjqyXcCZfULdmbp
 bX9Q==
X-Gm-Message-State: AOJu0YweXPZ9DwnDB/PIpQOQVBF6FrNSXuu0XO2TCd83LetIn/meXJnT
 CL32ooYd9cgK+IahAsxcgw2OB/kkSdbNRk6YwaBSAaF5a/B24Vzvj3xcIUEgZ0Bd9TTSBCmxmTs
 /
X-Google-Smtp-Source: AGHT+IEVeJPAuvRTDexqrc3cFgXQBCVcKQS40tYqEUOmAYFPlk8SIacO0K55hn+xgTOvQc7C0A5hRg==
X-Received: by 2002:a05:6870:f61c:b0:205:da63:2e12 with SMTP id
 ek28-20020a056870f61c00b00205da632e12mr2523606oab.101.1706059116855; 
 Tue, 23 Jan 2024 17:18:36 -0800 (PST)
Received: from ?IPV6:2001:44b8:2176:c800:dd1:291f:3c3c:2485?
 (2001-44b8-2176-c800-0dd1-291f-3c3c-2485.static.ipv6.internode.on.net.
 [2001:44b8:2176:c800:dd1:291f:3c3c:2485])
 by smtp.gmail.com with ESMTPSA id
 u33-20020a631421000000b005cdad153d84sm10729818pgl.90.2024.01.23.17.18.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jan 2024 17:18:36 -0800 (PST)
Message-ID: <c7c7c7a5-e099-47e2-92ae-6822cd13868e@linaro.org>
Date: Wed, 24 Jan 2024 11:18:31 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 19/34] accel/tcg: [CPUTLB] Use TCGContext.addr_type
 instead of TARGET_LONG_BITS
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, philmd@linaro.org
References: <20240119144024.14289-1-anjo@rev.ng>
 <20240119144024.14289-20-anjo@rev.ng>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240119144024.14289-20-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x236.google.com
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

On 1/20/24 00:40, Anton Johansson wrote:
> @@ -815,12 +815,13 @@ void tlb_flush_range_by_mmuidx(CPUState *cpu, vaddr addr,
>                                  unsigned bits)
>   {
>       TLBFlushRangeData d;
> +    const unsigned long_bits = (tcg_ctx->addr_type == TCG_TYPE_I32) ? 32 : 64;

No, this value isn't initialized at the correct time.
We are out of scope here.


r~

