Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F481C3DA61
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 04:34:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYeYH-0005bI-5M; Tue, 30 Jul 2024 00:33:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYeYF-0005aa-8B
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 00:33:31 -0400
Received: from mail-yb1-xb32.google.com ([2607:f8b0:4864:20::b32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYeYD-0004tI-LL
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 00:33:31 -0400
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e0b10e8b6b7so2916977276.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 21:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722314008; x=1722918808; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QYObzjnNlHSujQNul0zX96y4V6r9EQNx+pRw0AsjtNs=;
 b=hHB0QM5bdQeexbpHRK4G9anFiY4skjdOta67gIjv8XE7d0P1fbfP0errYRhEhbPy9c
 p44tQpA8egoowFZamNSsMBj0yk1ZiV2jr63kEd/wTLlrTtjBotCnWb7xMcXYEEOAb70E
 6fqfaudECszx56GGQ1RefUQbXmXmeiDuT5YVp928YJM1x++o5TzNile5vt2hptOnkl8Z
 pr1xY6OkmEfMYPtVZSrii2fSlPcbmurrboFotxVLxpQGLeLTWX6zuCr259QlhlPPbT8h
 GF1YjZ7QpBiWZz/YabBO8zvNubfMcUnm1KILgNaBzHRlUjlLicUe2ieO2N5dZIVDQRac
 wMNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722314008; x=1722918808;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QYObzjnNlHSujQNul0zX96y4V6r9EQNx+pRw0AsjtNs=;
 b=VrCzyjtFkxlhp1USdRt7MGKLElp33g55F6Ea6HYacjRNNtYZu0uhnogaoyEc6jd4xn
 j62TAIcUuBYMTkRrabFUzDeA8A+LwZ/DMez8SIKIR02BlW8SxP1Zhwt8aGpwXguaJNMQ
 LRW4NeuypcrlZ1iD6fNN7/0NZef5w8Y/rcmgr9IHt2SJvCxhrvXwYohIPoayXvW3mQQg
 E9QF+887yRsoM5/OHfV6eyzaW0qvG5tMb6YqcHGP9kofndUyfDZATZAio+oXKeP8WQgX
 yfixZ6txCsrpum541gSnlpAr2Fa0djcw3l0lcIrQ9EOJAzlRf+SYv/3lzAm8ha/lR5RN
 ByQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuaekGgugLc409uKdKJQCvyEwTfQJpmpsxH9NZ6AXo8ClOWXtczllC0XND1TsTaBQfQVBMLw2OEQ9iWxGO4cV/z9iXX1Y=
X-Gm-Message-State: AOJu0YzoKUGahmZHj79Eaz3qQZwR0Byd92P9AAM8H0MlHqihJKtMawhM
 27ktAa4rS6WUWth9L+1oI/CMcs63bOhSFHZn9UG6Y8c65PBReKQeRpDHgDKx9lJXhQmg9T8agil
 0jCuQVQ==
X-Google-Smtp-Source: AGHT+IFrWtu1+xmA0UTs1Wy1P5WdC2EAmeAg1AmeOPBLqKVrvwc/tkpqxIxGjmnJt4597cz59R44jg==
X-Received: by 2002:a17:90b:3d2:b0:2c4:dfa6:df00 with SMTP id
 98e67ed59e1d1-2cf7e098515mr6852460a91.8.1722292233986; 
 Mon, 29 Jul 2024 15:30:33 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cdb7389fafsm11315894a91.1.2024.07.29.15.30.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jul 2024 15:30:33 -0700 (PDT)
Message-ID: <faff8df2-d725-4d7a-88d4-7f8eaca26008@linaro.org>
Date: Tue, 30 Jul 2024 08:30:28 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/14] contrib/plugins/cache.c: Remove redundant check of
 l2_access
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20240729144414.830369-1-alex.bennee@linaro.org>
 <20240729144414.830369-12-alex.bennee@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240729144414.830369-12-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b32;
 envelope-from=richard.henderson@linaro.org; helo=mail-yb1-xb32.google.com
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

On 7/30/24 00:44, Alex Bennée wrote:
> From: Peter Maydell<peter.maydell@linaro.org>
> 
> In append_stats_line(), we have an expression
>     l2_access ? l2_miss_rate : 0.0
> But this is inside an if (l2_access && l2_misses) { ... } block,
> so Coverity points out that the false part of the ?: is dead code.
> 
> Remove the unnecessary test.
> 
> Resolves: Coverity CID 1522458
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> Reviewed-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Message-Id:<20240725164851.1930964-1-peter.maydell@linaro.org>
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> ---
>   contrib/plugins/cache.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

