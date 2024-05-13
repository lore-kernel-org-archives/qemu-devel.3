Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0FC9C25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 09:22:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6Rsl-0003WE-Df; Mon, 13 May 2024 05:22:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s6Rsj-0003UV-VO
 for qemu-devel@nongnu.org; Mon, 13 May 2024 05:22:05 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s6Rsi-0004Or-CW
 for qemu-devel@nongnu.org; Mon, 13 May 2024 05:22:05 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-51fdc9af005so6495828e87.3
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 02:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715592122; x=1716196922; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oZrQWtxU52idxp5eYbhcQHiiBGL/BJdP6x1q+TfBDHU=;
 b=kG9GSI+BwDElSSoEzNyH1b3a4p8fpX+wb5RDnYL2w25wmr427ZUq1Hozmh7JpHCx+O
 M3yZJa33DECzzq3mloCuyOu2INIdoZNP0cLa97k1HElHOnDueGFhHDa2R41K65gYbeSr
 Bz1NKuPlR7WaMZwe5Ud3PMB0ttvbXkA1w5Ghh9DXOwQOWIhuA1nwZl6IkOJUPPGUJql0
 2wmJaKge8E7Bfj/m50xx1HXpEwhqcyhJoVHZhzmD89fLNGQa+vwAZYPR0jMLm2ZbAnEc
 2zAv0d7t+2m7YMdjnCgxnLYM75gaW9jgHPtFoDNkDmH18DCgVGK1KfFUH4+FqWUs7XQE
 WeSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715592122; x=1716196922;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oZrQWtxU52idxp5eYbhcQHiiBGL/BJdP6x1q+TfBDHU=;
 b=A9emJIvb/R9yUpchGUQldDlCrUkvcGZ/tYoWmMDKJ9pymiIG0WzCjWLxTzz/x7WcsL
 Qd/qKBxwnzfu6qdxKi/LqdcKVyY1XhkcmbQAq+Jnh0dVVE/NBlX8IsGxZYXjcccbCHzO
 uTZ4qN6LxAJyw9tBrd4YlGVSwwUWkBApX3QV+HHBks2T6RXsscz+0OfRhMkXksqxS1Tb
 GrjpbgYzdlF423X4RANx0Wj273Ukf/aEoWBPO4zalpfkQahP9vKeJl4lXKUegI899rvG
 4ZzYiulrjykcdV0oCn7mCrYojtNLDhRjls3lVgx1cDU/Ib/KKoNEtsypqoUOCsxHct5k
 UFng==
X-Forwarded-Encrypted: i=1;
 AJvYcCVw1j1ZibadtoGHZRO3o8zEQKYMYvl9x6ZFaeF0FdAZz2la13Zft4JoNkzmXkNeJJtLq+lxpldvX+lS9duxRyTQhoO5nAw=
X-Gm-Message-State: AOJu0YwFKN+Lyj1hISb8o6E5uGHJ0ppiD638+YlIirS6hfQ3Nmei7+TE
 0XH2uGhZTJgk5S5bws1QYnHu4gjPWtZKYmFKymM3A+SVCVLDwKg6tAR34p1t99Q=
X-Google-Smtp-Source: AGHT+IGiteA84IGmFjZ9bQl5x4IbBwzqk4HlaAadFJhLHxUVeKqjgLxN+4TZLwlCeYtSkYOKYHrRwg==
X-Received: by 2002:a05:6512:149:b0:51d:4c8a:bbdb with SMTP id
 2adb3069b0e04-5220fc7d133mr7285327e87.3.1715592121768; 
 Mon, 13 May 2024 02:22:01 -0700 (PDT)
Received: from [10.1.2.72] ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-521f35ba739sm1702167e87.101.2024.05.13.02.22.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 May 2024 02:22:01 -0700 (PDT)
Message-ID: <1ffddbe0-12eb-4220-9920-28310ce55a46@linaro.org>
Date: Mon, 13 May 2024 11:21:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/system: Remove ADC from raspi documentation
To: Rayhan Faizel <rayhan.faizel@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 "open list:Raspberry Pi" <qemu-arm@nongnu.org>
References: <20240512085716.222326-1-rayhan.faizel@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240512085716.222326-1-rayhan.faizel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12e.google.com
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

On 12/5/24 10:57, Rayhan Faizel wrote:
> None of the RPi boards have ADC on-board. In real life, an external ADC chip
> is required to operate on analog signals.

Oops.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Signed-off-by: Rayhan Faizel <rayhan.faizel@gmail.com>
> ---
>   docs/system/arm/raspi.rst | 1 -
>   1 file changed, 1 deletion(-)




