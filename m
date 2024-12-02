Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7490D78339
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 17:34:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIAJ3-00010u-6t; Mon, 02 Dec 2024 12:33:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tIAJ2-00010i-Af
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:33:56 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tIAJ0-0002Jc-ST
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:33:56 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2155312884fso28305515ad.0
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 09:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733160833; x=1733765633; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Xtg3i1AVd58qb/9RHgv2gvLH1lXXGrGHzc3ZJoeIZf8=;
 b=Z2PqTwDNvD+UwxXobrYVTAayKa4QtB9Spotb7snkcZWbVrtH1wcqwfACISFw+3/9t1
 ifsKed0PqWaLukku6QD0Q+8j4k/ljmyiSVk0v3G62TwWduZnBaoYgc8OcZOa5iu2JbyI
 lOX17/bURAcQxb5hKCqXMA3aBBNBjcmvZOBTQChNaFx+BmjWo7ruRfX6VPIvSHtzHVcu
 ALkVXIsqcTRrkda1J1cNQxcymPh/zElzJE9s+jqT0CkiIBB5p/x9/BChdQB8SDoHIeFF
 GSx2RXapfuFy9fgoQwq+aw9uSxzhr3Fj1QQ1786VAb8mKNvmWgnE1es6esR4xT2Ib4Kc
 IiAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733160833; x=1733765633;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Xtg3i1AVd58qb/9RHgv2gvLH1lXXGrGHzc3ZJoeIZf8=;
 b=NLLUAq+vcAidaHLPaEqMGuOUuN8WslhyD6NevmXQIeow30jGNoS3lH5VyHblJdI0yR
 F8dUiUb2XFIuys+sQ1fRNyxmk82bakgMpbZx26zX4Tnqas8aYvUe70b+d8+gYT+SaZRz
 Sxopk7BmCJqNooEibV4+JSFBlTzk6U1vo7t+16+ahkUvIIz8D9qL8Iby1vIHt/oChzdl
 noRLsB8GeinkY5tqLYKYrawW+GHVm/HXP5+gKrkycC5gI6+Vskhxru74tEa9fnEHzO/u
 H1YiY51q8y2K4Kh8TsYbCQlTS2+FoZ6ULEiUMLRjLtyTi4mqFBcCCvxB3OCHQTsSu4Vr
 BnUw==
X-Gm-Message-State: AOJu0YwYNKGViNmbM0HcGUd6sFIM212Dw4eKBZMalOg8LsPQGSmxq9Ud
 rKRZ1NxKUuInlwdQ1YQJkryYbKmfN62gSDwA3KQlEUdBUkayWUy8yzSnpi4GMyI=
X-Gm-Gg: ASbGnctSzE9Vtrxs40flri5F41aOcVy41CsL+r/lWvOvZ9odVqWG7WD7+aIaENR/+BT
 eimMmvplHLf/DeIEYbMGw39bkH0ZZAFQ3Gzd3OYUzfM1H0nsTFJHTZlb9YfNJCWXJaHn2mQ498d
 b3i2XExvXUIX3CKT+zKba4prdin/GvOhWXb/r4ogD6eIeySZNW4fgXKQ9sogtnX0Dmf6d+n1oUl
 aKayOthS1Y+U+QJap5A0SE01z0OcpbcVp8a6p8xnbqYW3H/aCuiOHCO8+E5mJbIz0QGjJNCf4Yx
 IxT4XgQ163Vegl/LUHT6tQ==
X-Google-Smtp-Source: AGHT+IFmNMZT/3DIWt22rznR4CoBP51jtbDXLLhy9SbzCGhIclEDiQEDmeCdu+vXwyiAiG5Vlqj0XQ==
X-Received: by 2002:a17:902:e54f:b0:215:9a6a:63cb with SMTP id
 d9443c01a7336-2159a6a6775mr55650265ad.28.1733160833376; 
 Mon, 02 Dec 2024 09:33:53 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-215219c5533sm79437925ad.256.2024.12.02.09.33.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 09:33:52 -0800 (PST)
Message-ID: <6cd6b3fd-8362-4fa8-b6e5-e0e3aded3215@linaro.org>
Date: Mon, 2 Dec 2024 09:33:52 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tests/functional/aarch64: add tests for FEAT_RME
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Troy Lee <leetroy@gmail.com>, Alistair Francis <alistair@alistair23.me>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, alex.bennee@linaro.org,
 Jamin Lin <jamin_lin@aspeedtech.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, Joel Stanley <joel@jms.id.au>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20241128213729.1021961-1-pierrick.bouvier@linaro.org>
 <4b3180bd-8054-4431-a594-0445ce4837aa@linaro.org>
 <5620efa2-98c6-4613-b866-67e91ac6acf8@linaro.org>
 <21d8399a-91bf-4599-a73d-351f9f0c147c@linaro.org>
 <CAFEAcA-4_tnm9iPCf_3E4HKKXJ9h6w9oMiYaN0Y4s9wmpji3Jg@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <CAFEAcA-4_tnm9iPCf_3E4HKKXJ9h6w9oMiYaN0Y4s9wmpji3Jg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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

On 12/2/24 03:04, Peter Maydell wrote:
> On Mon, 2 Dec 2024 at 10:58, Marcin Juszkiewicz
> <marcin.juszkiewicz@linaro.org> wrote:
>>
>> W dniu 1.12.2024 o 19:09, Pierrick Bouvier pisze:
>>> Hi Marcin,
>>>
>>> On 12/1/24 05:34, Marcin Juszkiewicz wrote:
>>
>>>> So RME tests probably need longer timeouts or would not run at all.
>>>>
>>>
>>> By any chance, are you running those tests in debug mode?
>>
>> zOMG, thanks! Turned out that I left "--enable-debug" in my local build
>> and forgot to remove it.
>>
>> 90s vs 2974s is a difference ;D
> 
> That is a particularly awful debug-to-non-debug performance
> difference; it might be worth looking into what exactly
> is causing it.
> 

Indeed.

This test boots a nested VM (using kvm, not tcg), do you any idea why 
such use case could be so slow with QEMU?

> -- PMM


