Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF400C52D7C
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 22:44:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sddlX-0000z5-5v; Mon, 12 Aug 2024 18:43:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sddlV-0000xg-0i
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 18:43:49 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sddlR-0007Xt-8e
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 18:43:48 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7106cf5771bso3744417b3a.2
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2024 15:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723502623; x=1724107423; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nUBF1RDA6I+rlXnJDzrClDIca2uMvK1AXwLTq3Be6BA=;
 b=FAIIY9m1v7RHAajE2qARxCn6EfJ6BLNdAaVXTB5zsio7jrFJYOtNxVPsUBGgQluCR9
 T68WqmWrFsTtZDetWL1RrsKCgKvBo/nDhwMy/S/t2HUVSH0P39ryxRAn37shu7t3lSx5
 UtlBKfa/BatcsQo3d6nQv98+wid9MUZTPuGf0FGjZq2NtT4hkvZiKsDZh1dCHgMbMfSh
 A9icajJNv6L1qNZxaH8BSCL5Zdvjmp+s6rqVCfri2jX4jaKF7bxbk8Cla8uHt0TXQ5Ef
 Ej+0PTupgIGknwK8t1JcutztQMrBzBrlsilh66+RX6SGiK/WbpGJ+IrphfHcJvCCwsjw
 FTMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723502623; x=1724107423;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nUBF1RDA6I+rlXnJDzrClDIca2uMvK1AXwLTq3Be6BA=;
 b=wa1czdKn+HE2fivuhsd2rrZEODonGhvg7sHoCQrAjf8ClzxLo9ZR2DR+np84WAffL4
 Nq85Bmxg10sb5TjnEhl4Tb/e1nTwnwMoq6eIvqCExJEhhsXHmiSM1aMtfeaXnxlY4IgE
 d0/BGv+djM5JWa28tRe0VlZbXdUCixsu/jJm1kvTVdfkypwJWw/OQAyafzGp4nX5rWWK
 yiRuiBOuIHUKySDfOM7+MZKI7zFUIZwNa3haUXabfd7cVq629S+nGDb1mbDwWr0J1Qpq
 ex38yEnnEBnks4ZvW0DRDGh8F8yFD3ke3c+2t5j52fSAcvUX8ReoaOZc2bCmTjA/hLqm
 gEzQ==
X-Gm-Message-State: AOJu0YxrYsy6KzcQNa7Jo54zfDuhJ3et6deopOfhubtpPVqLBmTDBiA0
 GXTob8UjZVdeSr0fM2kKqoI1+a4zmM7BE1WmKJzeTgc7SUWoAS/slBEIsTFcmd4qFQDOQZ3ThWw
 1ebc=
X-Google-Smtp-Source: AGHT+IG2xAfbk3jcK9dTlkLpyAGgeCyUFXgtR/lNjhKLzaTC9C30JeYrBlwjhbEzBNHkVyXHT413cQ==
X-Received: by 2002:a05:6a00:22c4:b0:710:d745:6f3c with SMTP id
 d2e1a72fcca58-71255114c85mr2096045b3a.8.1723502623354; 
 Mon, 12 Aug 2024 15:43:43 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.111])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-710e58a46a5sm4502323b3a.63.2024.08.12.15.43.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Aug 2024 15:43:42 -0700 (PDT)
Message-ID: <f73d3122-28f1-42dc-afaa-453cd2cfb6b7@linaro.org>
Date: Tue, 13 Aug 2024 08:43:37 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 03/23] scripts: add script to generate C header files
 from SVD XML files
To: Octavian Purdila <tavip@google.com>
Cc: qemu-devel@nongnu.org
References: <20240805201719.2345596-1-tavip@google.com>
 <20240805201719.2345596-4-tavip@google.com>
 <CAFEAcA82c_RZ6512dB1OxpAtinRctkZK7ZyjpxX16Wk7DYZDPg@mail.gmail.com>
 <CAGWr4cSiNOm1mL6ZC+Dr8bFHz9Dx2R78_we9wL=W6f3FExb-kQ@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAGWr4cSiNOm1mL6ZC+Dr8bFHz9Dx2R78_we9wL=W6f3FExb-kQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

On 8/13/24 03:56, Octavian Purdila wrote:
>>>    typedef struct {
>>>      ...
>>>      union {
>>>        uint32_t PSELID;              /* 0x00000FF8 Peripheral Select and
>>>                                       * Flexcomm module ID */
>>>        struct {
>>>          uint32_t PERSEL : 3;        /* [2..0] Peripheral Select */
>>>          uint32_t LOCK : 1;          /* [3..3] Lock the peripheral select */
>>>          uint32_t USARTPRESENT : 1;  /* [4..4] USART present indicator */
>>>          uint32_t SPIPRESENT : 1;    /* [5..5] SPI present indicator */
>>>          uint32_t I2CPRESENT : 1;    /* [6..6] I2C present indicator */
>>>          uint32_t I2SPRESENT : 1;    /* [7..7] I2S Present */
>>>          uint32_t : 4;
>>>          uint32_t ID : 20;           /* [31..12] Flexcomm ID */
>>>        } PSELID_b;
>>>      };
>>
>> Bitfield layout in C isn't portable, so don't generate this kind
>> of union-of-a-integer-and-some-bitfields, please. You can
>> generate FIELD() macro invocations (see include/hw/registerfields.h)
>> which define shift/mask/length macros that can be used with
>> FIELD_EX*/FIELD_DP* to do extract/deposit operations.
>>
> 
> I see that C bitfields are already used in a few places in qemu. Could
> you please elaborate on the portability issue?

Bitfields are fine, so long as you're only using them for storage compression and do not 
care about the underlying layout.

The moment you put them into a union with an integer, clearly you are expecting the 
bitfields to be in some particular order with respect to the integer, and that is the 
portability issue.

In particular, big-endian hosts will generally flip the order, layout starting at the most 
signifiacnt bit and work down.  Other compilers will pad bits for alignment in ways that 
you do not expect.

Just Don't Do It.


r~

