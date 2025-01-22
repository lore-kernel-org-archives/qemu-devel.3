Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BF3BC02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 09:07:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taWgK-0004rR-MO; Wed, 22 Jan 2025 04:05:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taWgI-0004qm-Le
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 04:05:50 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taWgH-0000oS-3H
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 04:05:50 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4361b6f9faeso3846415e9.1
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2025 01:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737536747; x=1738141547; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=77/1Bz7P9AdJWLHOi9IRZtlPTzWr+Gq8S8Ogq1MdxEo=;
 b=maMOZtEp9Nr5HKpKErRbiST0BCsJcKEW0pjFZKwAlCzONxftmUXxOuz50MBIMCGBqZ
 yaTm0LPZwI5qBvYwK3VmFEYQmBQvJHKuHvjRDVzOCH0jFmOA+v4QaVu5J+oWLW6Lk6/m
 GFC8XNsvKXgbckVyaoTyJfIDy0x43XGLDZ8pZCcuYp98UraND3RaRFFwztX8Wu7Iwyal
 eyrX0RZhDpoZRVGqRTZUtsH4B5S7KyMayobRhc12CoiqHfIoJ06SRg1RuC3afglIZ5ej
 Ubbnprp2PuWJKDfZXPcKBNAoetYA6OZ73g0QbasZBgHKYzuzeOOizmObCE0V2wrPwP8K
 OcxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737536747; x=1738141547;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=77/1Bz7P9AdJWLHOi9IRZtlPTzWr+Gq8S8Ogq1MdxEo=;
 b=pn4U/UC2Aho0JXegxN2jI9FbbhulaSbOfV9fEx4q0sEpOWd7UmC0vfygRDD/Qi8DqY
 Imm49XVpsQuP9VBwg2HUqZ/CdJX+rciotHAkoyeHzbumtTdOhAch3VNdTlQ2tx5Co4MF
 kafpHUiuBbFDblqCfZrwIyEHdICoLLffRGOxoZu6eopPlLMS5nzTRGOPa7NAxQ3p7Xoq
 Ls+f2iNKDLICUrCk/lftaZz0SLSJ467bW75qFP/wQooRePjMR2jlRTkfpcuIgf34vG6y
 xkOqGWeQdfYzcvB4IukjhWvXfjtiE9lM8A2cI+AS1q6OByRS8GICGqNcgF7C6c/lnBM+
 wfYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaDqt28LN9OlZGf3/gf2PLlOP8uNKrnbxJMtp9gYWyHyb+dg84BbkAou9OyI3nApbyVAaNmC+0lfOy@nongnu.org
X-Gm-Message-State: AOJu0YzbwucjacHSKMoJsNSecyX+wqMq142syLBfB0gu8ossnwmnCdZ0
 BHrwPDpz4uVR5xTMDfwInNSt+s/2sAYZ8zjFBHRArHCeK900w/hgmQWO4iuwjrw=
X-Gm-Gg: ASbGncti4PnY4oeJrfjUhYNbjNvYYFs5GU6zngVQfYfrSHkE/fCvCycC309HQqry0uC
 myASQc438wBIIYcR0V9do2Fv6R7j0tdDYpizJXofPUX55+N+jERkEODK7eS8FuqK6LAK/Gp6XPS
 A10/p0Z0mOhoc+JRHx9Ueku2J2X3OuBZJhIzgqXUxe+U3EPx+9I+0/BXBPJ01TCPEVjTr6VHZJ3
 M5G2hNdxwq1OSa0+d9ctJ8de2txh8wUjg0ic5qQzevcE3W8524fMiyMAwTJ8UHoRjx0YiLXt/eO
 ChDOvZG490x+BfiQeUwKYHv0wk5akg//cVtpgQ==
X-Google-Smtp-Source: AGHT+IFXFt2cC14JEHtA4BXBbh3B1z+FcmtgDaUhUBX0VAdxCWCbzQwSwquv1YOQRT/b5jzXLNr1zQ==
X-Received: by 2002:a05:600c:4e0c:b0:436:e69a:7341 with SMTP id
 5b1f17b1804b1-438918b966emr181292175e9.3.1737536747305; 
 Wed, 22 Jan 2025 01:05:47 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438b31b7655sm16204585e9.30.2025.01.22.01.05.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jan 2025 01:05:46 -0800 (PST)
Message-ID: <012e9d08-883e-490d-b591-feea8ade9d86@linaro.org>
Date: Wed, 22 Jan 2025 10:05:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] aspeed: Create sd devices only when defaults are
 enabled
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Troy Lee <troy_lee@aspeedtech.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Steven Lee <steven_lee@aspeedtech.com>
References: <20250122070909.1138598-1-clg@redhat.com>
 <20250122070909.1138598-10-clg@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250122070909.1138598-10-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 22/1/25 08:09, Cédric Le Goater wrote:
> When the -nodefaults option is set, sd devices should not be
> automatically created by the machine. Instead they should be defined
> on the command line.
> 
> Note that it is not currently possible to define which bus an
> "sd-card" device is attached to:
> 
>    -blockdev node-name=drive0,driver=file,filename=/path/to/file.img \
>    -device sd-card,drive=drive0,id=sd0
> 
> and the first bus named "sd-bus" will be used.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/arm/aspeed.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

For SDHCI:
Acked-by: Philippe Mathieu-Daudé <philmd@linaro.org>


