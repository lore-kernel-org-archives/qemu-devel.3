Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9EAEC46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 08:51:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUjpJ-00016O-13; Tue, 30 Jan 2024 03:50:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUjpC-000103-Nx
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 03:50:35 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUjp9-0007PJ-Fh
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 03:50:33 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40e913e3f03so41947185e9.3
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 00:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706604629; x=1707209429; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=n+eUWPQw5sZJqIXHPq8j4bHvrO/fOZg8dAdyEhNGWOg=;
 b=zW9F0PaQsurhOGxL2x6oODbDhnetcuf598qjW7k/YdyAyOkBn44aDihLIzg3oHaTVO
 HmBhnJGDHhkq011Kwq1IFBQhcTXE+H7TE6APe2lxc4Z8yTYwPVHrXSo5mqsQrwtsT64g
 ucXe6EcojbAD7z653iauQBoqQ1pSaPCOOLP3Aqv9jWE29DJbm0SVNmzZp/XQSLSGQ/2H
 GDwayGWjHRg+lpFEv9uXpqTJyRcF4oy3LPgfRDo4y6H5MkLd/EtzLspvahNGB0UWJYpZ
 j4OfLAQhmjDOFmcD1sdHUHWu8pYN50u3hjreXip5s7VKrVKdWio31xT6wuZyOPsm2NKR
 xNfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706604629; x=1707209429;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n+eUWPQw5sZJqIXHPq8j4bHvrO/fOZg8dAdyEhNGWOg=;
 b=j+fxtbMyjbqUcfVGnl93RlKJ0Tc/h+zAS/fN0Q81Huwrfh0p+ASiYzjuxQLltw17qt
 PaLaDx83cXpNqBkyi6UZZ2LH/oq/hp7/K5jtAPG97BuBa4snDMri2pCofZ95PhG0ahUs
 47jx94ocFu58FQZyI7y1F9l8ISIYPmaigd9gbPt0ypqv9MWdmANg9SOiWtljtpkjWKlp
 YT1xBcAmLEtJAvbPs5iwhR4/xNwRXXOXwRMUAvL/q1xAJEXevXZf0lhgWEl+SE5YBEHe
 q7i4ltKZ0DsIMI+ljXrlDlIH/3s7ATubuGY5YSdJEDcSE2rQ78gBszYxeRCxhWzPuhfn
 18zQ==
X-Gm-Message-State: AOJu0Yzh21p3cZLfgz5aGCMQXhoUgx15hjQ0H0WaaCi355EWuj17hj1y
 o4ghiSMFoZAahsZ4FkcxNEjDF3rdyaZcXA0DS9qFHH6ymYuv8qGt2yIaQoThYpnFgoGPwXXwv5w
 o
X-Google-Smtp-Source: AGHT+IEoSsk+x2OqCeMPCgMWWX9L+3bwvCSv9J0CVKfaOrUBAvtzyaLzBnf5/1FLSJSlCM2Ik6OCxg==
X-Received: by 2002:a05:600c:46d3:b0:40e:a255:8f53 with SMTP id
 q19-20020a05600c46d300b0040ea2558f53mr6515352wmo.13.1706604629298; 
 Tue, 30 Jan 2024 00:50:29 -0800 (PST)
Received: from [192.168.69.100] ([176.187.218.134])
 by smtp.gmail.com with ESMTPSA id
 u7-20020a05600c138700b0040d8ff79fd8sm12480423wmf.7.2024.01.30.00.50.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jan 2024 00:50:28 -0800 (PST)
Message-ID: <2088c49b-4e55-4e3c-b296-ce4f90e8e0eb@linaro.org>
Date: Tue, 30 Jan 2024 09:50:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] sparc/grlib: split out the headers for each
 peripherals
Content-Language: en-US
To: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>, qemu-devel@nongnu.org
Cc: Frederic Konrad <konrad.frederic@yahoo.fr>
References: <20240116130213.172358-1-chigot@adacore.com>
 <20240116130213.172358-2-chigot@adacore.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240116130213.172358-2-chigot@adacore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 16/1/24 14:02, Clément Chigot wrote:
> ... and move them in their right hardware directory.
> 
> Update Copyright and add SPDX-License-Identifier at the same time.
> 
> Co-developed-by: Frederic Konrad <konrad.frederic@yahoo.fr>
> Signed-off-by: Clément Chigot <chigot@adacore.com>
> ---
>   hw/char/grlib_apbuart.c                       |  6 ++--
>   hw/intc/grlib_irqmp.c                         |  6 ++--
>   hw/sparc/leon3.c                              |  8 +++--
>   hw/timer/grlib_gptimer.c                      |  6 ++--
>   include/hw/char/grlib_uart.h                  | 32 +++++++++++++++++++
>   .../hw/{sparc/grlib.h => intc/grlib_irqmp.h}  | 16 ++++------
>   include/hw/timer/grlib_gptimer.h              | 32 +++++++++++++++++++
>   7 files changed, 88 insertions(+), 18 deletions(-)
>   create mode 100644 include/hw/char/grlib_uart.h
>   rename include/hw/{sparc/grlib.h => intc/grlib_irqmp.h} (86%)
>   create mode 100644 include/hw/timer/grlib_gptimer.h

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


