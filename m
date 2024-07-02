Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BA71C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 14:37:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOede-00018c-3v; Tue, 02 Jul 2024 10:37:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sOedc-00017q-RH
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:37:44 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sOeda-0000al-5z
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:37:44 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-70a078edb8aso2342124b3a.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 07:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719931060; x=1720535860; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SWtwqGaaAU9znATjDZLEHjLHq+ubVWP9uIPlnYfZH40=;
 b=TBDsNSe6l8Q9PJmP0t4xOI/+oPNuzI8oRrQhlxHp3aMwCnYg4NH2vpaa2IfPzlsSZK
 8ioCKGhDCCegMhA+Io8zPThMKNmrmJYKPL5xlFmUZcs2UVjX55HHPJ0D7l8TRkxDZEYH
 0uICkzcfJRQqtVZYMBwBNzdfpI9DzLe/n2GWHQyCxatPbbWcrGAi+UOULlJBc8tKfBkm
 1F/15ZNrE+Hey7DCVl9Wukc87gcWiIimL3A95V/hXStRfS8/jOG2XQh/7Tk582GERmoK
 tyUpQH8MMpKwYk7PyPAXhBXtIxuba6L5MAuEjrHxrMPUvYZ9cS+WbacGKZuk/1fW6PfK
 yzSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719931060; x=1720535860;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SWtwqGaaAU9znATjDZLEHjLHq+ubVWP9uIPlnYfZH40=;
 b=mJId2K46KiBjej7YnCc4BjVLmRF6eqeyBtv6pdSpAmwNVJrU+ehx7XeCcHnhiCRtFa
 D8YBoDvLvzYhifaAmPLCWtCA7n9l0XoxEZGkGXVh1GTLFgHVdz3zGMla/WqlHTk1o6O7
 86ZjdMJfEK4MCZeW1uAGqDqUf3gxjvEnj/3Z9iTGG89ASwczf0GF7hs2+AyDGM7nI/23
 yqdtAFlKBjqyP3swce2WoRB7YRZAhEcZQUMgwKWIHgPOEjp9GdoHKAihUk7r1CVxWWaF
 DUAConjJctMoOFTmM4QLLA6NgjkhggWzatOzMDO1p8aXC2jIBgXcPK+uO8TqvaPesDKR
 LqKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpmjca8Nak8iCA4ubKgv7QWFK3FEFHLwf09uSrZ9dpeEu1zHvy7vdloOp0+DeLV6MdNwwwa5NZnP7fQ3svMQxczxmJE4s=
X-Gm-Message-State: AOJu0Yw0JTPUne07EzKFsFblPJejq8TqCPIsXIHKyO1eBczyWLg0UX/v
 +4k3a5C0aNHL1NLW7tzkeOhFL3EO8ylgZ4Ezty+WWAPlglpncHecs62irsBBKJwXO5vzR3QN2Od
 4
X-Google-Smtp-Source: AGHT+IFeYk/Pmo8uOAPE8P0e1bluL4xaGwOytvbKUXq2Jkhk3LdNVoeKpTyzaaiFYSDIDum1vbuXqA==
X-Received: by 2002:a05:6a00:98f:b0:706:3f17:ca2 with SMTP id
 d2e1a72fcca58-70aaa95bfd8mr14003745b3a.0.1719931059940; 
 Tue, 02 Jul 2024 07:37:39 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-708044b1112sm8577697b3a.182.2024.07.02.07.37.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jul 2024 07:37:39 -0700 (PDT)
Message-ID: <02506c92-df4e-4616-9fd7-02e9d2a204a4@linaro.org>
Date: Tue, 2 Jul 2024 07:37:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/13] target/arm: Fix SQDMULH (by element) with Q=0
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-stable@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20240625183536.1672454-1-richard.henderson@linaro.org>
 <20240625183536.1672454-3-richard.henderson@linaro.org>
 <f65e6448-cfd2-425c-853a-5a4ae5cf2a8c@tls.msk.ru>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <f65e6448-cfd2-425c-853a-5a4ae5cf2a8c@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

On 7/1/24 23:48, Michael Tokarev wrote:
> 25.06.2024 21:35, Richard Henderson wrote:
>> The inner loop, bounded by eltspersegment, must not be
>> larger than the outer loop, bounded by elements.
>>
>> Cc: qemu-stable@nongnu.org
>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   target/arm/tcg/vec_helper.c | 24 ++++++++++++++++--------
>>   1 file changed, 16 insertions(+), 8 deletions(-)
> 
> If my understanding is correct, this one
> 
> Fixes: f80701cb44d3 ("target/arm: Convert SQDMULH, SQRDMULH to decodetree")
> 
> and before this commit, there was no issue.
> 
> Is my understanding correct?

Yes.  So, not as old a bug as I thought.


r~

