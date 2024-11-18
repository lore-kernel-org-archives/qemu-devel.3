Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A5FDD49205
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 10:30:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCz0V-0002CL-Pi; Mon, 18 Nov 2024 05:29:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tCz0T-0002Br-7r
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 05:29:21 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tCz0R-0001Lm-Ni
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 05:29:21 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43155abaf0bso16824215e9.0
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 02:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731925756; x=1732530556; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WXRCwCF/VmZ/rAZs82ftWfkBwfd+507ASeIJBUnFO5M=;
 b=lOUTN7e2AkADi3b4sU2H8lUmWGE1WZDuf84wlltjuUHkfQX6CkPA/XcKW8oiUXeuCT
 Dm3Vm4Jh0C5emVXvjjrb6ad75WXclSX82i1IlzocXVON/BEjN0j0nOBh3w60RlVZfk4a
 658MSQOYMtVPKPESQFL6KGNg+o599IFovyu6jDoN6uZS66HFTWZ6UsYJPgwuBuooLE4L
 3Hi7T6fLklJrF9wkWiROX4FU4tosaLlU6uni7WjKUFLeg0YPoby2/TuJvabWlZegT3pW
 j/Ocv6yVzSE4+yNQjTs8YUle8mECH0iBPUJ7nHWmfTU0biUGbUYF5T4IynLfn5YlCUaR
 A8BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731925756; x=1732530556;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WXRCwCF/VmZ/rAZs82ftWfkBwfd+507ASeIJBUnFO5M=;
 b=dI6GdyMOI2zqnrQuKAZHqnJ/e8btBnGyzLFsIBGXZUEeZkF2GVdGAh3kgsEEUY7oeL
 dAC0iKDN9FLrXyPRrWRHCJyy+QV95ooSHwHfer2la0MgXKg3wNlzpq9rUylS6Q8wCAXy
 0Xyl3Fx21mZNwujG1ZuIY47JVwO7C2EWmVoUmkgv0KXnJo4wCr2Xl6lJf264AKUOeJMF
 i6WEg8g2817rm1pzuLw6wrqvN7n1OLyZ694xntRPNZqQIZletYGAsg5lKJ/4T1cX2gMD
 2oeMPxOnv/B0mIxzT0JMV+kV0j+7yJv6Gd9mx9DnQKABRSxeBCrwetIbrFgJ3g2xZyJZ
 UHHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwQjuvcaYcyB9W1vVdMX9SHnhcmmTWYoNrEcLp6KswyRhBCx1z6xIK1qWxXoAZiVUEvCaBr+IHWxNs@nongnu.org
X-Gm-Message-State: AOJu0Yz4hHqs4XcO71w+MMAnE0rlyvbc7Gt9ONAGiHeNGCJCimPvdN+x
 r/iHDbtDCSPXlB7cQAEeoAifFcmGlPjkdeOFd7bwE5haqfKnsh8ivnvZHE7rGNE=
X-Google-Smtp-Source: AGHT+IGArsRRkQ+ubAbBFiNiWUYYRHp3kEhcO2qGz1YnIsFw8QOK81z2DjgmXCuRhfdo8nOQl74kdg==
X-Received: by 2002:a05:600c:524b:b0:431:586e:7e7 with SMTP id
 5b1f17b1804b1-432df7203bamr82007195e9.1.1731925756411; 
 Mon, 18 Nov 2024 02:29:16 -0800 (PST)
Received: from [192.168.69.197] ([176.187.198.1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432da298c81sm156463465e9.39.2024.11.18.02.29.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Nov 2024 02:29:15 -0800 (PST)
Message-ID: <ba8a9ce8-c941-4d41-8c8c-7ea936d42e80@linaro.org>
Date: Mon, 18 Nov 2024 11:29:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] tests/qtest: Use qtest_system_reset() instead of
 open-coded versions
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Roque Arcudia Hernandez <roqueh@google.com>
References: <20241115165041.1148095-1-peter.maydell@linaro.org>
 <20241115165041.1148095-3-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241115165041.1148095-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 15/11/24 16:50, Peter Maydell wrote:
> Use the qtest_system_reset() function in various tests that were
> previously open-coding the system-reset. Note that in several
> cases this fixes a bug where the test did not wait for the RESET
> QMP event before continuing.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I can split this patch up if people prefer, but for test code
> and given the size of the diffstat it didn't seem worthwhile.
> ---
>   tests/qtest/bios-tables-test.c      |  4 ++--
>   tests/qtest/boot-order-test.c       |  7 +------
>   tests/qtest/hd-geo-test.c           |  9 +--------
>   tests/qtest/q35-test.c              | 12 ++----------
>   tests/qtest/qos-test.c              |  3 +--
>   tests/qtest/stm32l4x5_gpio-test.c   | 10 +---------
>   tests/qtest/stm32l4x5_syscfg-test.c | 12 ++----------
>   7 files changed, 10 insertions(+), 47 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


