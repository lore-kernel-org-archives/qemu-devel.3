Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98236C83F04
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 14:53:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWypn-00021A-2g; Wed, 02 Jul 2025 10:53:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWypm-00020A-1f
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 10:53:14 -0400
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWypk-0001bR-4Z
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 10:53:13 -0400
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-611f48c6e30so996122eaf.0
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 07:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751467989; x=1752072789; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kwWpTNjg5xC74r+Bbkg5UnuBhFFvSK+AVJZR1e1fL7M=;
 b=qa0LweD/CPX6Y1lHAL2feLOpzoq66+z39hDF+/EnFf1VCSTwYfp0vKnDZOD+KKdi/6
 DThjM6riz3Fhk90wRtggCISL5jCMV3YHkQWb5mmW6813aWEq4c3eISAaZUsKZVPRz2mE
 mHb5KOSZRUHw+9rGclTNl1lDvRnC3CtzZGaShwB/MdPuDqvuM3Rp9L6VO7+RpuKdWzxJ
 Rc5avcwug1yKlBmwen814M3vbXDz2KIeaPdEPmRrspVUfSO5pzAYj/3qYUq9BzRA7j8X
 kPbWTUbNYAnLX9SkxhDk8dGje+ulGeonpICejw7vinomXq8IA373r/sCpHps4K88Aw0y
 BXmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751467989; x=1752072789;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kwWpTNjg5xC74r+Bbkg5UnuBhFFvSK+AVJZR1e1fL7M=;
 b=Ih7DEc0Kv/NN8DRBVSAoZIZRxy4rqlHupueBrECAxfQDGfZEr7Ez2xnBe9Zl6tT3bz
 8C3ANcEICISq/AhoztrNTkGAya/nOtE1fbX9kC41CqyQ2hlkNB1VSN1nJGQz3j3FrBAX
 tgbg+jX5/lo92iNmcVnYRN6AR5oQj99acgiwyGHbkINJsaXjE0MqwMQkFa0Gxtm2/dTe
 vQGaNWiLPNUAdzjsrilBkVsl3mCYeugbswYxwGYOaWg1+6i+4ShYYjP1UstrPrIrRiop
 7m1GPbAfkCaa+U/7kKNwIVTWsECqhvJFvZnvCBY/wVpYL8XM3DjaLQxZ1vRD1fC84wnw
 HomQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnLM1/gcIqThfg8W8NhTRKQv7X/oN9we+jLWtOev/WKLZsVT2E9YCJ9guBFE8w8iLtNrgPi7oeR0GH@nongnu.org
X-Gm-Message-State: AOJu0YyiT31d6Yvv1HQ/PvR8a4pCe1f1wVPCdt0n5q8clger1TmhRzl2
 wTHfpFUU7bLpV52ztucmtWMk3tusoX3DUdMt2WwePBNsiYHROqPzD5xgeJLHHbOjyRo=
X-Gm-Gg: ASbGncsr/br8w16rrhJvkZHnJmkVF9KP9PIPlp3D58EB4oj7mKXojUdSUWvUyfWscCs
 vh4iUz7dfLaHlcDS1KmOnUHn5Sp+/G1lsPv7oF+5UuqD7UR8aKHVSZHPGQJKXlQjEvY/xB4nXdW
 CFldVjv4HB/7MYoM6QTk6UEevFDtRf6RZDulCmvaeEpKFRZc+N9nKc9vHYlu9rMBkcvOV5G4za2
 encJQkaByyKsZTjvIBM17RNbvr5Fuf01QzfsLUN+gwbIPJ6qI5fZxrrD0yGDSN8bcw8QuNLMMzq
 sfq8YhGlarQOMvYA9Qecthx0kf+i2s09INIGgNG4tPS0hAHAgjrryU1pTxH1/ntbMmbBCtRcjay
 4
X-Google-Smtp-Source: AGHT+IEIf4wrctTVyvlSdRA1bVn4/fX6bXq34dom8b3e3VKZJxAijnW37aQDC+yNlXLwsVMGDu9pYg==
X-Received: by 2002:a05:6820:a09:b0:611:ab35:8025 with SMTP id
 006d021491bc7-61200e1610fmr2203009eaf.0.1751467989058; 
 Wed, 02 Jul 2025 07:53:09 -0700 (PDT)
Received: from [10.25.7.74] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-611b859fb13sm1694908eaf.29.2025.07.02.07.53.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jul 2025 07:53:08 -0700 (PDT)
Message-ID: <7847dd0b-271c-4e1d-93ba-605630464ef7@linaro.org>
Date: Wed, 2 Jul 2025 08:53:06 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/12] target/arm: Fix helper macros indentation in
 mve_helper.c
To: William Kosasih <kosasihwilliam4@gmail.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20250702111954.128563-1-kosasihwilliam4@gmail.com>
 <20250702111954.128563-13-kosasihwilliam4@gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250702111954.128563-13-kosasihwilliam4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2a.google.com
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

On 7/2/25 05:19, William Kosasih wrote:
> Recent helper function load and store alignment fix caused the continuation
> backslashes in those macro definitions to shift out of alignment.
> This patch restores a uniform indentation for those trailing backslashes,
> making them consistent.
> 
> Signed-off-by: William Kosasih <kosasihwilliam4@gmail.com>
> ---
>   target/arm/tcg/mve_helper.c | 268 ++++++++++++++++++------------------
>   1 file changed, 134 insertions(+), 134 deletions(-)

I'd fix these within the patch that breaks the alignment or not at all.


r~

