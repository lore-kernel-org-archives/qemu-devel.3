Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75AD9C54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 11:28:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhSx3-0006By-6d; Tue, 05 Mar 2024 06:27:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhSwe-00063F-4S
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 06:26:54 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhSwa-0000LB-9B
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 06:26:51 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-565ef8af2f5so6908861a12.3
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 03:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709638005; x=1710242805; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FnDBqsGz8bfkBseet1BwqCO81AeEJ7WQFTGnqgQLWGw=;
 b=HIpbvEhoC8NA81wdxlBpWgR34n9cPH5hw38Kufvu+Nnn1CY3+nwuVHPWfHA1kPFM/C
 ZfgHZwS9y6e5JAy6yN9iCK/IYRXnkeHUgNlDUk2NaN7h/Bnk9PJPRm+UiuW3J0Gep4mH
 KH1M41aaxO3e7TxurSqNINjYH87p1nymChczfwHehb6vQESuKEeBqZBvEhmvPAkkkfVx
 CRERa5QAE3VD/v7yO/WU4F37tWvT3U+C9qqEcynv9dRnjjJGx5QW/EclQsZVEHX3qHbw
 5PYZaHHJFhF/Lz/XvAeyv4jzzC9VpgH9/zcCSiRl1zSG1sFzmez7eyTnv6fQz1J6IqOj
 oaeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709638005; x=1710242805;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FnDBqsGz8bfkBseet1BwqCO81AeEJ7WQFTGnqgQLWGw=;
 b=kPEJM4aUAIrvuypzhvtFOIse1A597evApT2mNcDqPWjxZynQq5En8qrXdMfDREbvsr
 8QsVg4R8A/atFKTBuVFjvMAYwNItim7WundkQUNq2B+rfQqRnwoGM60fOt6YgTYHfvje
 U/t9l9cAtxPrvPhfXEs1JHiRWBFdYdIYeqeI9lA3PnJo87MApRUDWmMTd47pVp3Ej3tp
 /kZbIxfoRqMmmEWZQdbvhJEG/u9Jc87e9ccAF1YbdM6k6JoWHQQvN0aHPlPGn2It7dQ5
 2KjY25HLBNu3WI83UKfyPsR5DKYS+qpHtIYlAsX2WHu8FvUDq+uOmu2Kcu7tXgKef55P
 Yv0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJCfWV2RYbGbxAGQKqLUzNCHBl98O1roaB4639hiVQMDhlmbjxkgsUXNkoj3ZS1NelynTqIytXEILO/vOCpB36BmZy2tM=
X-Gm-Message-State: AOJu0YxJk25rJNGI2V/DhKMdF3nKH0bjaztM+22tdbpvz/XxpQlQYje0
 PXyHm/trx9Vlxr9msp0Acwx1h67eMuPh/B7jI16gRDhTViJKOKXiuR3pWJ9hRNHTeXdGIL9FPlH
 I
X-Google-Smtp-Source: AGHT+IF1ZNBt/UYTfp3Lj0IDYBRLI9FA5XwQiTCIKHSZclzOqvxczJlCHQyFn+d8k5nxsAT2BUTLHw==
X-Received: by 2002:a05:6402:202e:b0:565:9ac6:a9e5 with SMTP id
 ay14-20020a056402202e00b005659ac6a9e5mr9126971edb.21.1709638004880; 
 Tue, 05 Mar 2024 03:26:44 -0800 (PST)
Received: from [192.168.69.100] ([176.176.177.70])
 by smtp.gmail.com with ESMTPSA id
 ev16-20020a056402541000b0055d333a0584sm5725718edb.72.2024.03.05.03.26.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Mar 2024 03:26:44 -0800 (PST)
Message-ID: <8d819438-6671-4846-aafe-76c5e353fdf2@linaro.org>
Date: Tue, 5 Mar 2024 12:26:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/rtc/sun4v-rtc: Relicense to GPLv2-or-later
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost
 <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20240223161300.938542-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240223161300.938542-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52c.google.com
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

On 23/2/24 17:13, Peter Maydell wrote:
> The sun4v RTC device model added under commit a0e893039cf2ce0 in 2016
> was unfortunately added with a license of GPL-v3-or-later, which is
> not compatible with other QEMU code which has a GPL-v2-only license.
> 
> Relicense the code in the .c and the .h file to GPL-v2-or-later,
> to make it compatible with the rest of QEMU.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> ---
> Before we can commit this to either head-of-git or any stable branch,
> we need a Signed-off-by: from everybody who's touched this file (or,
> for corporate contributions, from somebody from the relevant company
> who can confirm that the company is OK with the licensing, which is
> RedHat and Linaro in this case).
> 
> The full list of people who've made changes to the file is:
>   Artyom Tarasenko <atar4qemu@gmail.com>
>   Philippe Mathieu-Daudé <philmd@linaro.org>
>   Markus Armbruster <armbru@redhat.com>
>   Eduardo Habkost <ehabkost@redhat.com>
> 
> (Artyom is the original author; everybody else's changes are largely
> mechanical, refactoring, etc.  We've done some behind-the-scenes
> coordination so I don't anticipate any problems getting the
> signoffs.)
> ---
>   include/hw/rtc/sun4v-rtc.h | 2 +-
>   hw/rtc/sun4v-rtc.c         | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/hw/rtc/sun4v-rtc.h b/include/hw/rtc/sun4v-rtc.h
> index fc54dfcba47..26a9eb61967 100644
> --- a/include/hw/rtc/sun4v-rtc.h
> +++ b/include/hw/rtc/sun4v-rtc.h
> @@ -5,7 +5,7 @@
>    *
>    * Copyright (c) 2016 Artyom Tarasenko
>    *
> - * This code is licensed under the GNU GPL v3 or (at your option) any later
> + * This code is licensed under the GNU GPL v2 or (at your option) any later
>    * version.
>    */
>   
> diff --git a/hw/rtc/sun4v-rtc.c b/hw/rtc/sun4v-rtc.c
> index e037acd1b56..ffcc0aa25d9 100644
> --- a/hw/rtc/sun4v-rtc.c
> +++ b/hw/rtc/sun4v-rtc.c
> @@ -5,7 +5,7 @@
>    *
>    * Copyright (c) 2016 Artyom Tarasenko
>    *
> - * This code is licensed under the GNU GPL v3 or (at your option) any later
> + * This code is licensed under the GNU GPL v2 or (at your option) any later
>    * version.
>    */
>   


