Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79DE5FD4F03
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 17:08:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w00YZ-0007qp-A6; Tue, 10 Mar 2026 13:07:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w00YX-0007pv-6Y
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 13:07:41 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w00YU-0001a6-As
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 13:07:40 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-662b42ca0daso3327263a12.3
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 10:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773162457; x=1773767257; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jhKSwfcWirkgW4OmEZzxqWnK9gWTQjeX5p0IlUVw/YE=;
 b=yw2zVSJ0doyC0jFaQ6kETcFkxK33vDcjWa0hB9qBqwBTkREfpd4gwqxP8Sczxydp0F
 qRxu733CTN0YNK20T+bCmS4c27FVdBl91dcQ3hgzgODqndrbdAv5p8MjIdO15Pk2IXOT
 i7jKLXLkRxKK+z0EQk9RvF4BJxUIRGAnHk/FOh/GyIcc1cqojnPgxEVZcCxTIQrO3pOX
 1rSmgjagn4MLh/+R2tAD+HA4NaZf6T6WR+fZiuLX3LAeOZ5BKts6c9ovVSe57Q6Lyyu9
 tWrHQdKGeU4V5P9+ug9yZt8qDiZbN9HqJjdgDBgKQLFUxuduFwkK/3FXh3n1LxJIZhXa
 G0DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773162457; x=1773767257;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jhKSwfcWirkgW4OmEZzxqWnK9gWTQjeX5p0IlUVw/YE=;
 b=WSf6Mqu84iqP/sBesgN5Hij00FIbG+2v3AOY3BuNdLrBJfAAE5grY0oUAUDJydel6k
 RTJohK4m3Q1LatHeiR4KMErwZRuSNeAP0n3qE3dTbiDI9x+TPjKmXhwvDBrt1TymNH6g
 N1s1+PQ1M6wzLT5p37x5Yk5DeBeJtLeDkyfasTiM0ICySC7V3Xzz2G1gRYkDLohL8Wa0
 n7cY7ROvxnR8QQuk6ynbZgrR1yc48kK9LDWUUNH9FCEAWA9/KhinUOhN4SN7to14zVcb
 fxltNnZOI0z1ZBM0ixey8SyLYoFBDNhxLaCHjj/Gvw9y5PdXOAoHqcgRkJ1u5JoNbm3x
 rgrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9LGO59YuauW+60UGRMXHGsJ24fbQhqbvxjAm0pGo7/OOUkUgWwYBMwzfn5fOotQzIJV4TV3OoWgXt@nongnu.org
X-Gm-Message-State: AOJu0YyoxIG2N4FT5HzWGI2pkPGAFoWR9QsEm7HU8Omvi7oKSN3K+Jue
 9ONdnIWxfUQGm4/HX9s83CluZv5RonUUnFNNZsAdAaqqh9BYHz7YDB9O/zDLHKlCF5g=
X-Gm-Gg: ATEYQzyVO8lFdGoa4DR0RyCMaVd8SZjqE1QGokPbqP4w1XEnWUqfFtKF9mfEBX3oWbY
 BE43h56VWircbGIlw792fo7BhqGXZDOqpSo/Rhj44okNts0ujv2B33vmg37zTWpTm+AyegHjDIH
 1E+AvmZCA6QdNYmA87pR4BLCY7/2bR6zUCE6C9GGUryeFGQyNqKTqJIvKfylekYcoOCBRAgh13s
 eY2nX2FYv6gnQYnzA7pAV8sxl1D4fd2NQ54l2N6qseB3USy/qwbDiSqoSBeEb3PlRED77uthnhQ
 aDUMDFRF8Br9ilic0t8lU0sTUUHimLjgl6Jkv+OufVjVexDhjbhsVLmh10jHsKcG8upnDreq4ug
 2UzaT4lSS91ce2wa5kweHeMwNs04dEwbpuH58PuOYNQWsWB4aWp5I8r2Nc5c7lpVg+eriYaBfWt
 leu+ZPgmsNrHWsaj6OZ8YtIZtthQZaRMc7bd821mrBcfPhqU9zUNHZ3IxOB4owYr0HQA==
X-Received: by 2002:a05:6402:278d:b0:65f:80cc:a47a with SMTP id
 4fb4d7f45d1cf-6619d45a9dbmr8919819a12.1.1773162456655; 
 Tue, 10 Mar 2026 10:07:36 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-661a559b222sm4526297a12.23.2026.03.10.10.07.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Mar 2026 10:07:35 -0700 (PDT)
Message-ID: <d63c29d6-5bd6-4bba-ad3c-525e2c3fe748@linaro.org>
Date: Tue, 10 Mar 2026 18:07:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] tests/qtest/aspeed_gpio-test: Use g_strdup_printf()
 instead of char arrays
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>
References: <20260310153334.3063224-1-peter.maydell@linaro.org>
 <20260310153334.3063224-3-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260310153334.3063224-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x535.google.com
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

On 10/3/26 16:33, Peter Maydell wrote:
> Older versions of gcc with -Wformat-overflow=2 don't like the usage of
> fixed size char arrays in this test; gcc 7.5.0 (SUSE Linux) says:
> 
> ../tests/qtest/aspeed_gpio-test.c: In function ‘test_set_input_pins’:
> ../tests/qtest/aspeed_gpio-test.c:149:36: error: ‘sprintf’ may write a terminating nul past the end of the destination [-Werror=format-overflow=]
>               sprintf(name, "gpio%c%d", c, i);
>                                      ^
> ../tests/qtest/aspeed_gpio-test.c:149:13: note: ‘sprintf’ output between 7 and 17 bytes into a destination of size 16
>               sprintf(name, "gpio%c%d", c, i);
>               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> This can't actually happen because of the limited size of the values
> being substituted in.  However rather than require readers to check
> whether the arrays really have been declared large enough, we prefer
> to use g_strdup_printf() for this kind of string work.
> 
> Reported-by: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   tests/qtest/aspeed_gpio-test.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

