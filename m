Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68ABDC3DA7F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 13:36:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWFgW-0002sN-EV; Tue, 23 Jul 2024 09:36:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWFgV-0002n3-0m
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 09:36:07 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWFgS-0006jU-BJ
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 09:36:06 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2ef2ed59200so28433821fa.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 06:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721741762; x=1722346562; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=azOBo8n7PTI1z8TaVTvpugK+dx9lsNzTIbJJ+xk/hOc=;
 b=BKveFRRgXA5nOM4Ayok8cVE7e1kKr6bxmmR0096RwL2MgGMchWE4BbFXM3z8Qch6eH
 DKJBNw4q/xueZ0ia0cxalZ7mUcLvY7xdx1NnCnyreYQleoERNMmxPrfb9xkvQfLEX4Z0
 giyk1pZyTjy/3l5Wqcq4JMOnOPEWUiyoe2RskWqyrqG1U1ADEQ3oHZJSzSihTZiNp79i
 1mt/I2iErcV62mMVsqA/X48B6dxyPnDIbNLykQVu1nfL9eAr/EVtnAq6QG5gv5OZ2myt
 LWNuVnf3uQF9b0vvH8cdB/BE1SANYvzCoc3foBcAkfMOG7RlLUKjHb9TKeEdBcPMjfLp
 TsWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721741762; x=1722346562;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=azOBo8n7PTI1z8TaVTvpugK+dx9lsNzTIbJJ+xk/hOc=;
 b=fMghdE+VVURXPP904Jpeo0JAOPM6te8HfN6LL8VgYiF5XCEnDVujXwUfpqC0kqM5WV
 +f3HtF+S27qGEQANwLZpJf//YTsBBre3wMO07g8Kkc3VaxS7gVxQTxq+grletjSJ91m7
 9mdw3flSwL6SPnr5O6xo7K0/VFME0d3osar139L2RXT1XqPPyYpySq47AGNQmKTsTBsW
 K1pactQ3mSVBQmodWxWi3gLZTCI7jQHaZx0JxZSQYTJfzbQ6mh5whu3oIjWpFVebMyzP
 jfpmFxJFuPL3S/JP13MMLNWo12dyUNLy2NTsdJrZq60NcAwU2RMTsqHiRRSmDRGXLqxg
 4jjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKCFccDs5QXt4EfurFJTC82XxbJ1EKi9g0sc+YsoXLgwaRWvRoQ/pbi6r5yGbhob6TGcmxyXkeMscGtg4zlIyoiZYqXqo=
X-Gm-Message-State: AOJu0YzK5d2I+8M4vIV/nXGv1lc3N35ybahWC22gkcPaqIGzV/Eav2yA
 GTvehwDbNWaAt+X81t4fRqJx36MTKwM5YmATlyymsTEAhyayV4a4gd6IMExUQ50=
X-Google-Smtp-Source: AGHT+IGYr8mbOlChhljYpDlrWpLH9oe8lvXe9307lziGOLW2iXNL5kziXjQtJrvtHuluQAwMuurIlA==
X-Received: by 2002:a2e:bc26:0:b0:2ef:316e:8930 with SMTP id
 38308e7fff4ca-2f01eacebe2mr26197591fa.42.1721741762348; 
 Tue, 23 Jul 2024 06:36:02 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.208.14])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a94380sm202242665e9.39.2024.07.23.06.36.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jul 2024 06:36:01 -0700 (PDT)
Message-ID: <16970204-0835-4747-a8f1-798d77a74f42@linaro.org>
Date: Tue, 23 Jul 2024 15:36:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] hw/misc/bcm2835_property: Restrict scope of
 start_num, number, otp_row
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20240723131029.1159908-1-peter.maydell@linaro.org>
 <20240723131029.1159908-4-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240723131029.1159908-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x233.google.com
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

On 23/7/24 15:10, Peter Maydell wrote:
> In the long function bcm2835_property_mbox_push(), the variables
> start_num, number and otp_row are used only in the four cases which
> access OTP data, and their uses don't overlap with each other.
> 
> Make these variables have scope restricted to the cases where they're
> used, so it's easier to read each individual case without having to
> cross-refer up to the variable declaration at the top of the function
> and check whether the variable is also used later in the loop.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/misc/bcm2835_property.c | 34 ++++++++++++++++++++--------------
>   1 file changed, 20 insertions(+), 14 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


