Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EE50CAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 09:34:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v24pL-0002zD-Ok; Fri, 26 Sep 2025 05:33:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v24pG-0002yv-Ke
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 05:33:14 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v24p9-0008Kb-Nw
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 05:33:14 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-46e34bd8eb2so18247155e9.3
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 02:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758879180; x=1759483980; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XXJjlwJIO2SkGlw/DG6TsBIs0wt3U5ffGWZ/kSJUQdE=;
 b=M8BpylL8pe40yy5oEjFyPmHQGPkGqQEoIalSZWQUA/OXlZ5BSwKR2hu0UvTggAEW9z
 fsnOAu8Icxh1xaXOXda6onGC6dESXw5cPd8dwRLN8gFyV16MeKWBNk8Gk45EipMIlhbe
 z2c1z3jBBWCyg/uzG3OiBo5ugRbNOFdv5TkBPgcWyEkGJCgwz5/fFMxEwtz2+/mmirLQ
 gGaC/mVChDbWNA6MLEqi8WvPGOMwk2ZUCy4iFCT/kDHf7WUFqvQhJKbdWJc4VxsWLwC2
 xCnmSSPHLOYGvYDdcokoeDAMGOkRmZIeqaYkR9iVILMpgj15jc821soqZkyGDEoAHGz4
 cUEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758879180; x=1759483980;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XXJjlwJIO2SkGlw/DG6TsBIs0wt3U5ffGWZ/kSJUQdE=;
 b=foQ8aB5LKrPDPXmUTRSRRlzaW8FFj36zTF+TZC0GAPBRmwEmP1EAZQUhnYHlgwn44K
 rxhgAlnH/RkrnDCoaCZDMK4E7Tirkojy3QsTjZfiEKSB9zl3Zbwe5RiMuiBi4szftXhq
 dUMuyUdKwPjjNElENUCk4uwh7rVSlfyGjhXsX/3Nw8Ozrvcu+uI2tk6hA5xQZHKpo+Tx
 8Dpi74n9L7Sf9eWUTg0Q7XPP7pvXMxnmXAS4OHzuONK1vIj21MI145E297gbtAMYnEWK
 DFP4h0LsTGlnthR7JB6buFnn2izoHGGH/H9WGswyucP4j8ZBDfTC7LTTErDOyd0XlFWb
 QVdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4Uts1mrJ2L1oc2T2VhqKKFqHn+9Vfsu9UCXxRu0n613YppfXzN9uulByF664Nmp8nHYrnUoVoNDef@nongnu.org
X-Gm-Message-State: AOJu0YwmXszOhDJM7+apnC3hSyVKSgsoeQZriz8uqP+aAgn0MDkNFM6g
 HxunohT9uneCwz5JieeaCLV789Hi+jYnd1TVLsH2LtO0/jSnldDliS4fW7f/8LsCb5o=
X-Gm-Gg: ASbGncvEoA2x16GfkHibaL98xPTNkqviXUTuFFelQBZlOXFApNyuuoyLiSpF36jcnhi
 qwp976OjzHAU/V22tirfChPUh9Ngep+cURTgdfWm4vqG6rdQsiHqNJmANUivxpU9CIuzsx2H4rt
 amcq/IzwcGhIAh2wtCt03uCMCV8J8sB/OaFatIUF0i4LCKGFOkpnhAGXKg7SUcvA3ClcVxRG08O
 bcxN61d5V2OaLXqh5P5GBBhVkQDZ4n1rmpYwGEoQIr9DMDAxtr16xAtVMH9JHoU/BiXrLNBgo1F
 i4LjMyieVpEEM5HY1zvmpjroFUUoRImZluPJ+IG72WIMhNC2mK1SnoPGa6zgY4gg/JOuPBoR7QY
 bASiwp+gbvY8QUJjLF1MUDjcNMXKzcopmhfyKWiBFhKw0Cqdi+VA0CTYrn69H9ycBJdGyH+gUXG
 ae
X-Google-Smtp-Source: AGHT+IFWwLTGAxMBG/54brmlYi/DJ22wC2K7ObAbatPmfcIpd5SoEQsbAZXaBG8j1RxV9Ga87xNlPA==
X-Received: by 2002:a05:600c:4f07:b0:45c:d817:2a6a with SMTP id
 5b1f17b1804b1-46e329aa91dmr68161205e9.9.1758879179774; 
 Fri, 26 Sep 2025 02:32:59 -0700 (PDT)
Received: from [192.168.69.208] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e33b6da3dsm34641535e9.0.2025.09.26.02.32.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Sep 2025 02:32:59 -0700 (PDT)
Message-ID: <269cec44-b851-4b2e-a1f0-ae3a24cd97cf@linaro.org>
Date: Fri, 26 Sep 2025 11:32:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/9] tests/functional: Adapt reverse_debugging to run
 w/o Avocado
To: Thomas Huth <thuth@redhat.com>, Gustavo Romero
 <gustavo.romero@linaro.org>, qemu-devel@nongnu.org, alex.bennee@linaro.org,
 berrange@redhat.com
Cc: qemu-arm@nongnu.org, manos.pitsidianakis@linaro.org,
 peter.maydell@linaro.org
References: <20250926051542.104432-1-gustavo.romero@linaro.org>
 <f94da379-eee1-4375-95e6-7349c3c188ee@linaro.org>
 <1d096685-ada0-4c8a-b16a-ed8a5df7b90d@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <1d096685-ada0-4c8a-b16a-ed8a5df7b90d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 26/9/25 11:14, Thomas Huth wrote:
> On 26/09/2025 08.49, Philippe Mathieu-Daudé wrote:
>> Hi Gustavo,
>>
>> On 26/9/25 07:15, Gustavo Romero wrote:
>>> tests/functional: Adapt reverse_debugging to run w/o Avocado
>>>
>>> The goal of this series is to remove Avocado as a dependency for running
>>> the reverse_debugging functional test.
>>
>>
>>> Daniel P. Berrangé (2):
>>>    tests/functional: replace avocado process with subprocess
>>>    tests/functional: drop datadrainer class in reverse debugging
>>>
>>> Gustavo Romero (7):
>>>    tests/functional: Re-activate the check-venv target
>>>    python: Install pygdbmi in meson's venv
>>>    tests/functional: Provide GDB to the functional tests
>>>    tests/functional: Add GDB class
>>>    tests/functional: Add decorator to skip test on missing env vars
>>>    tests/functional: Adapt reverse_debugging to run w/o Avocado
>>>    tests/functional: Adapt arches to reverse_debugging w/o Avocado
>>
>> Out of curiosity, do you plan to post the final patch removing Avocado
>> use / dependency?
> 
> Which other uses of Avocado are you thinking about? AFAIK, this test 
> here is the last one that used Avocado.

Maybe I was not clear. After these tests conversion, I don't see any
more use of avocado, so we can remove its dependency on QEMU, right?
Basically, in a final patch I'd remove anything related to:

   python/setup.cfg:37:    avocado-framework >= 90.0
   python/tests/minreqs.txt:35:avocado-framework==90.0


