Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91384CF0435
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 03:41:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syNZG-0004GW-BX; Tue, 08 Oct 2024 23:40:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1syNZD-0004Fr-Pv
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 23:40:51 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1syNZC-0006jY-5m
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 23:40:51 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-208cf673b8dso70114325ad.3
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 20:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728445247; x=1729050047; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RKt0CbsfAcdMkUoCX2Z3cOUbh3EG8EBrzmLOqtRBQLM=;
 b=VYu46XN7F3+PwzWO2rPZ0rCnZQKpW0OI9UWKqpa8z1kApNRnNARNmJl+ucv7twvhXs
 Q3X5YuYue45tjJwegYsMO4BKkxy3YLk91jpM2mB39q0u6NoyF8hxcXTc1tYcrGadw9QD
 jOf6ul9ypNA4RTjlZDVXH7KclTW9qPhq8XFMJ4/OoQ4H8l1xoZxjRm8I42VbMnCThReC
 GAqe2Osp2ROkNCrxH3Nlva9uA0U1jxNvn9Aew7T/MD54lLPiaEIefD0hm5ySs9Un1C7n
 G/ouVK5m1Df3IDvN6XS640+gGrQiSqVmHBmwkgwa467g8c+sIzg9XT59SUN308SlTmbm
 Sshw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728445247; x=1729050047;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RKt0CbsfAcdMkUoCX2Z3cOUbh3EG8EBrzmLOqtRBQLM=;
 b=twgUcq/78TVXxrcV+YTvc6tKc9JnSCYHzBoZi5XGg+HpQidAtCKnU1twdICvzm3rG7
 ttii3QCIya7eDfjCsoFAvFKKw1n4LbnxFeM9phGZ42A36E6FUaleR5OaIlUM/1b4gTzv
 kcoJiUtaOYWrSsNWuCFcFohKQ4a4ODPrMoxl6scGV/7DWMzY2CiiCtbQfY1ABBZ3Aptf
 CLFPp5sumi80kFIX1VuBJdSZ0+w591OrO7pRYz2ZdAaBaQCRD9FdoeCWVh6KkGszIaMR
 +RZCvqiTMpnnRXKu9n+a/3o2NqZC5ydqQNhyExjUbZ2Q3T6Q+og+bL3OmpXKIQLeI6nM
 8TDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsiFfAb8f4biPay6ny5TAvSVYBLwhJjWXxQfd6uuQpNc3Zw8V9xiXOdIMcd/RZGdJt5ef5QU/IbKhz@nongnu.org
X-Gm-Message-State: AOJu0Yw/+x6oY319AFjHWsmhC0ZdPT2NYLYEURwBFg98F2Wmj96kOSkT
 /XkygbG2gK5TUX8vY/Gr2XC8jJczUVO/kmyRp18n4skwlOep5bSfwzI+pDzQVMM=
X-Google-Smtp-Source: AGHT+IEnXxYkTnzZ6fCRbF5ODI61ucDqNmRqOAbWRx4yDn8qIRSh0TDCzIdcxwx0NsQS5fNiqYSlLg==
X-Received: by 2002:a17:903:1c5:b0:20b:9e14:c138 with SMTP id
 d9443c01a7336-20c637351b3mr17261815ad.23.1728445247420; 
 Tue, 08 Oct 2024 20:40:47 -0700 (PDT)
Received: from [192.168.100.35] ([45.176.88.163])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c1393980asm62397195ad.143.2024.10.08.20.40.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Oct 2024 20:40:47 -0700 (PDT)
Message-ID: <c6faf1d9-5870-4407-9273-f28578ab4b2e@linaro.org>
Date: Wed, 9 Oct 2024 00:40:43 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net/tap-win32: Fix gcc 14 format truncation errors
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 qemu-stable@nongnu.org
References: <20241008202842.4478-1-shentey@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241008202842.4478-1-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x636.google.com
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

On 8/10/24 17:28, Bernhard Beschow wrote:
> The patch fixes the following errors generated by GCC 14.2:
> 
> ../src/net/tap-win32.c:343:19: error: '%s' directive output may be truncated writing up to 255 bytes into a region of size 176 [-Werror=format-truncation=]
>    343 |              "%s\\%s\\Connection",
>        |                   ^~
>    344 |              NETWORK_CONNECTIONS_KEY, enum_name);
>        |                                       ~~~~~~~~~
> 
> ../src/net/tap-win32.c:341:9: note: 'snprintf' output between 92 and 347 bytes into a destination of size 256
>    341 |         snprintf(connection_string,
>        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>    342 |              sizeof(connection_string),
>        |              ~~~~~~~~~~~~~~~~~~~~~~~~~~
>    343 |              "%s\\%s\\Connection",
>        |              ~~~~~~~~~~~~~~~~~~~~~
>    344 |              NETWORK_CONNECTIONS_KEY, enum_name);
>        |              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> ../src/net/tap-win32.c:242:58: error: '%s' directive output may be truncated writing up to 255 bytes into a region of size 178 [-Werror=format-truncation=]
>    242 |         snprintf (unit_string, sizeof(unit_string), "%s\\%s",
>        |                                                          ^~
>    243 |                   ADAPTER_KEY, enum_name);
>        |                                ~~~~~~~~~
> 
> ../src/net/tap-win32.c:242:9: note: 'snprintf' output between 79 and 334 bytes into a destination of size 256
>    242 |         snprintf (unit_string, sizeof(unit_string), "%s\\%s",
>        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    243 |                   ADAPTER_KEY, enum_name);
>        |                   ~~~~~~~~~~~~~~~~~~~~~~~
> 
> ../src/net/tap-win32.c:620:52: error: '%s' directive output may be truncated writing up to 255 bytes into a region of size 245 [-Werror=format-truncation=]
>    620 |     snprintf (device_path, sizeof(device_path), "%s%s%s",
>        |                                                    ^~
>    621 |               USERMODEDEVICEDIR,
>    622 |               device_guid,
>        |               ~~~~~~~~~~~
> ../src/net/tap-win32.c:620:5: note: 'snprintf' output between 16 and 271 bytes into a destination of size 256
>    620 |     snprintf (device_path, sizeof(device_path), "%s%s%s",
>        |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    621 |               USERMODEDEVICEDIR,
>        |               ~~~~~~~~~~~~~~~~~~
>    622 |               device_guid,
>        |               ~~~~~~~~~~~~
>    623 |               TAPSUFFIX);
>        |               ~~~~~~~~~~
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2607
> Cc: qemu-stable@nongnu.org
> 
> --

---

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> 
> This patch was just compile-tested (which fixes my issue). Testing TAP
> networking under Windows apparently requires extra drivers which I don't want to
> install (not my computer). So it would be nice if someone could give this patch
> a test ride. Thanks!
> 
> Changes since v1:
> * Use g_autofree and g_strdup_printf() rather than fixed size arrays (Peter)
> ---
>   net/tap-win32.c | 15 ++++++---------
>   1 file changed, 6 insertions(+), 9 deletions(-)


