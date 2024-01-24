Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B341C47258
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 01:21:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSRx6-000259-Kb; Tue, 23 Jan 2024 20:21:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSRx5-00024w-Dy
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 20:21:15 -0500
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSRx3-0002oO-Uk
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 20:21:15 -0500
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3bda4bd14e2so3840330b6e.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 17:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706059272; x=1706664072; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Nhu158olSy7CgqPygzqLrLO7rNNRfWscSC7uax+EUig=;
 b=FQxFgPXBrHWSZrD6qlkGtnzcdHtmNdvw49q1s7VM6Ct/4fA6Na9g13k/j7uLYDmlMt
 /PzRMMEClg8Ap1MfJRLvgH9wGPUfuPzqBkyBJANxM2SdQ1p8zygsKMFv6Y1dgbL2YLY/
 vi9I+rKtEmIyn8szCx2cnho78xQQWBb+eiNb1EI9K+G+GoJoeRvwmsCr2wY77o17on3G
 6pw+uaUmpPMLh/W7yYSu8d05ItENPhsZY076KSnkv2TD4XrNlFS9Ss91LY8jnhhUNdvu
 faVHgmHzA/P3RnPUdwsd2jUxRiiyoWZ5wqSqi5EoBg18Qdfum7n9472R8ujTZzRAoMF2
 +PSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706059272; x=1706664072;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Nhu158olSy7CgqPygzqLrLO7rNNRfWscSC7uax+EUig=;
 b=ZLT8DMkNgEFLSJZekSlky2wJ4+CcYUqoDIPahOLkyGh1Q+bHxrsB8Qu566AdJntWAb
 xqejkjFjFFTDm2CYIqjKmqQUdays8EPd/+6vetXZN80TgzN2qto6OPWRt4Y84mFDCC1N
 RBej/2iVxJ+MEKPtqVOIKUVpWW1r96A35ejQAcOmSf5+Uf8SkXGWHP0rB4Rg1WjvKe/p
 UgWAWdP1jJuoVcS1PHbRZ1oHDdepnX5hIO8ggU1WmRaL62XDq5GvKVTsSd+ewh3nDA+J
 DoBM5sioHvrIPayNleeWzVUMAVI4O76SedmwtTVtwFSUm/Od/Ed8H+UXMguOj+E4ygJY
 D7pA==
X-Gm-Message-State: AOJu0YwF/u663IkQOUMyTCfR1UAZrbELkjpZ7BhhYMTKjlqcIhjqZDCK
 kFepJdC90uT2DOQ1BQ6YXzQAGurGZ+pCdfx3xua3huofnlTCMHr2ILYPIjZRQ7Y=
X-Google-Smtp-Source: AGHT+IHRzYmINcKv+D5nrUd8lAUBCzfF0qtXuLRnfaonbiHgXEIrqeVwA30t7cN0JrQurUvMoX4NOg==
X-Received: by 2002:a05:6808:2e92:b0:3bd:252d:70cc with SMTP id
 gt18-20020a0568082e9200b003bd252d70ccmr1248901oib.62.1706059272450; 
 Tue, 23 Jan 2024 17:21:12 -0800 (PST)
Received: from ?IPV6:2001:44b8:2176:c800:dd1:291f:3c3c:2485?
 (2001-44b8-2176-c800-0dd1-291f-3c3c-2485.static.ipv6.internode.on.net.
 [2001:44b8:2176:c800:dd1:291f:3c3c:2485])
 by smtp.gmail.com with ESMTPSA id
 i10-20020a65484a000000b005b458aa0541sm9171832pgs.15.2024.01.23.17.21.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jan 2024 17:21:12 -0800 (PST)
Message-ID: <92cc9335-10bf-4a74-9eb4-249de5545dc5@linaro.org>
Date: Wed, 24 Jan 2024 11:21:07 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 20/34] accel/tcg: [CPUTLB] Use TCGContext.guest_mo for
 memory ordering
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, philmd@linaro.org
References: <20240119144024.14289-1-anjo@rev.ng>
 <20240119144024.14289-21-anjo@rev.ng>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240119144024.14289-21-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x231.google.com
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
> +#define tcg_req_mo(type) \
> +    ((type) & tcg_ctx->guest_mo & ~TCG_TARGET_DEFAULT_MO)

Again, no, value is out of scope.


r~

