Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DDBEFCC04F
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 17:35:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyZ4h-0005CK-Io; Fri, 06 Mar 2026 12:34:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyZ4b-00059X-KT
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 12:34:53 -0500
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyZ4a-0004vL-5Y
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 12:34:49 -0500
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-3598581ed7bso2494250a91.2
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 09:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772818485; x=1773423285; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BUXgSYVW8LFw1wL5B1Mln1UoAQWWgbEqaD8czeelTYM=;
 b=Q8q+r0UwcM/rlx9YqCg/I9gGhdNwd4w0T81OixnxXdEmUOIzudueUtQoZi6ZPBRv8k
 vYm2h+mENYuqmVOaX7P61JgsT9lYXo+pOly589Mav8GW7ycnqCtU/9SMygl4Ym9u4u7o
 IwhkBwg9p4T5fCM42RfU6HY0jlwTV2QM/A3Dni4xGEN+aR4Ln15SfJQK9ujF8s1NmIwd
 Iw25bsF2JF+UAjiFFgF5+bDJVsNq33LH/NtVj5YROCvXTG7FUJS6Vha3xt8Gl/3YUQP/
 lWjJwmhSxGw85V7LKQ02feQ4geN4rWRyrmdpYhM4nY6yqNDT+dfMUXlFoKHtjiJid+p6
 4ZRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772818485; x=1773423285;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BUXgSYVW8LFw1wL5B1Mln1UoAQWWgbEqaD8czeelTYM=;
 b=Do1d7a+xZsQ+VLd8Vk71qVIUYNCd2ku4C3Qpmf65lN6ZWt7oAsermSSt1unnhaSkPk
 C1Tx9YOhDlcsjFq1avA/65QKxq/8PRfR722JOh5BBon94mLMj0YZyE0gfNgQSsrYjDI5
 OwUKMgdnfuF/a/Vk92aTewauBnoD/el0wRC3/1cu7kwxQ6fHPHlBYOZmEZsI8PmMYhwq
 8zc1Lripv/d235WUjCSq/W5eMmQKGGGnOLxw3sX1Qw507LKz34k1AV822pHLrdelHeus
 PexvKPDepD2myN0X0/ognOjxv6xys3PKhZLB3cyq026iWtuSqJt3HPlDvwjClmVGKCgh
 CPhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXby3n2K64FFiSWze/bhKXvir9C3/2xgy0sapZf8NEffdGBw2646jSlZz+XsF2HuNmjnLYR25hkTJ86@nongnu.org
X-Gm-Message-State: AOJu0Yxjl9WsbnCr59YEfP6zGRuKJk9tZXl07pwkztmJ6urcI7BQMKJW
 sWaa1Gw6ZdtOMUEDtwdpBaI2YmEYkJFDUgazAF9eazNZKcOjXIBBP/nVJFhq1mAHtEU=
X-Gm-Gg: ATEYQzznG/SJRbGt/WNWZiILdOOwU0DuEmg4A53ran3AIEirh32das/hDjVvsHZ9Mk7
 FEWamVOuK3KdYFpKu2pvMxHQNwuSPvKRshJZdbB9A1dCsSaPtiV7OC8oODoDObNFIxig5RR2I+j
 fCpBCchFKPUkjaoR47XGhrtUd2vzcv55yiw9DJ+mzPEQ9xB1o2QcD3rlu4UAdNy/5P/aJLozqUp
 2sjn9xAb/hZFGQQsUMaqw+YqfyFlo3f/D2hvYwosNokK/ETqmbrSb8AcgNFzSoUHSoFbUFfPdYn
 A2ObuYRgPd+o6KZKHmnIv46fY2mMZ1GNPSDJwPTP4+xZWGx1wAbdAXsFqoWDZKxGJmpMLQ4Mn9S
 LQURk+Cq2mwzZQokC9aO455n2zqyh5S87sKBY/8ZWZNh/Whf62x0R4mjA+0E2s2oOY5FdYhUQJs
 bRwZoeNX1MVAPM+yH2DAdg2LulzcG+LGmGNHFS8juOvmXlArQa7T6eN1Er3k6FhNBUMNue
X-Received: by 2002:a17:90b:5104:b0:359:8988:38bc with SMTP id
 98e67ed59e1d1-359be233210mr2687298a91.7.1772818485275; 
 Fri, 06 Mar 2026 09:34:45 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-359c4eb8c48sm1652339a91.10.2026.03.06.09.34.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Mar 2026 09:34:44 -0800 (PST)
Message-ID: <5342a38e-ee34-4d52-928c-e60028848e2b@linaro.org>
Date: Fri, 6 Mar 2026 09:34:44 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] tests/tcg: allow filtering of TCG tests
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Brad Smith <brad@comstyle.com>, qemu-arm@nongnu.org,
 Kyle Evans <kevans@freebsd.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Warner Losh <imp@bsdimp.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20260306161728.2657486-1-alex.bennee@linaro.org>
 <20260306161728.2657486-3-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260306161728.2657486-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 3/6/26 8:17 AM, Alex Bennée wrote:
> We have a lot of TCG tests now which can be fiddly if we just want to
> check one particular test type across the targets. Introduce
> TCG_TEST_FILTER to allow this:
> 
>    make check-tcg TCG_TEST_FILTER=gdb
> 
> to run all the gdb tests across the suites.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   tests/Makefile.include    |  8 +++++---
>   tests/tcg/Makefile.target | 12 +++++++++++-
>   2 files changed, 16 insertions(+), 4 deletions(-)
> 

Ideally, we should have a list command available also, so we don't have 
to guess what magic pattern names follow.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

