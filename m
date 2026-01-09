Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C697BD26D6C
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 15:58:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veEs4-0004Eq-2R; Fri, 09 Jan 2026 10:57:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1veEs2-0004EY-6v
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 10:57:50 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1veEs0-0005uP-Lx
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 10:57:49 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-34c565b888dso3764653a91.0
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 07:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767974267; x=1768579067; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=K50ZKhdkfR8rYaEc+1+Euk0YNaMcEClcWpeJPGFNzuU=;
 b=MhKVvMt4EkzsP/UEDFmNp6wGA9jLt0uxfwiWo4XTI6ay3/y89w+ZVK3lkVAr3dk7O3
 RRgn1cc2QWGN/ld7DInnVNDRep0q7Wnd7hQRczdqtzJqlzfX4KbHMeZHCzsAea6yFnlv
 t956WN9bYUKoEe3i+7z3IeD8eviRkOOLCK+jMkgLrW1UvwKHPMAXXjT7ojTC8ftUKzH8
 hFBXGj0e16I23P31a/biyn3PS/Dm7nXedz6vZau/EzAyUenBSbkARhQ73qXeQjGDZfQq
 hqO5JYx1CjrOv1TMPg07elbfCiwItvGTug7MKroMRM7AN72kNverEX0KHdam+nqJ5Fpw
 pelQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767974267; x=1768579067;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=K50ZKhdkfR8rYaEc+1+Euk0YNaMcEClcWpeJPGFNzuU=;
 b=jqWEoNeOcNDGASYwFhEwQMCEn1c+JImacqN5npKzZqIlgwlwqHtZwiwiBf44UVv/XQ
 kUBwfV2Xnxe5RtEg5dipmVj8bP2rX/YTIziIilsDlT87HqmzUDCqYtqHE0FgV9cxwK17
 0g2FZv7zMh6qoAqHFWQrKN9axnJ4A3rxRRXU8R1vmWu+RkwH9saSb7jQ3t8u4SMe16ER
 i5lCfMbG+LNEf6RTkW87pQWF8cze8LydJrhME0fdyfBl2j/qmqjjDbrnGPJWcjXRZwaA
 e76+0hbkxHiBfQTH272nK/aoXyw3wRxtEdYK16HpnvOfB+1Xm+gHNaB1LbibeRworA69
 wuFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLXfwobvtc8U3QLz/h+jCWLkdvHVA/ApKjf3DZ6isYA4CgFtFxdOHsTAAt0F1oGJ5LVyvhCUShOT+e@nongnu.org
X-Gm-Message-State: AOJu0YwjKsk86qmVQQhqtO11fk/PBOEu6QD5wOq9BV9CBXWXUy0rYoKv
 Xc2N2Nua4sGhXCbFs2LMLXbHh99CTw9ehXt0UtZp8AslPey2IJUivzQcWgxPdaUSvqY=
X-Gm-Gg: AY/fxX52fsOvl0q+UxzuwxIQKgaEbzqN3Ot01i9LtiMcnATnUxUvScyWz9jGuiJvNej
 N9nDhgLZ8nn2OFNk7JdvXYYRin5Ub1KUkaR4rBR2BULX47DuTUO7ScZWu00uNDregFZFjQgOcxM
 WNpS7DPd2ynR1jqZS/CXOFJ9Ywb0MOthT7pvnUpB8GgQjiyUYaP0J89i2eIuhv7ac3g6IHJnJCK
 6rjxSlQw3m9Quu5jzo3+L6W+Bb7/tDV9dMk8zj34TJs/XsaXPr+43xb/FtFACfDWGjxY8TCnYHA
 2RzDftdADUuUT4S6IakoYp+zGuCsFEHq96nPyzdJIByj4Iu8PkNLWiiC4cmkd3aLslPwQvt8dd6
 Hx2hFnf7VnyJaVJT1ConsSu40venX7Ju05olL+Ie+xAejRyacZXwfJEjoPcMtR0AdPr3i1cjCEH
 SHjVXMCtqCgA0Eqoxo96frN9AdO9sNMsFL51rOO3jopD0k0+xoklUl8B7cgw3acov5Ok8=
X-Google-Smtp-Source: AGHT+IFPNu1xoliq9qwTvrakjKW20akit9uZ+PJ96WYHjqhhHKvBTnfSKRAPm0bATurHLnaW/ZIKLA==
X-Received: by 2002:a17:90b:1d0d:b0:343:6a79:6c75 with SMTP id
 98e67ed59e1d1-34f68c62a3emr10043564a91.29.1767974266985; 
 Fri, 09 Jan 2026 07:57:46 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f6b10a44asm3053269a91.5.2026.01.09.07.57.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 07:57:46 -0800 (PST)
Message-ID: <7c061acd-b1d1-446e-876e-b6c9a3f118b1@linaro.org>
Date: Fri, 9 Jan 2026 07:57:45 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] linux-user: implement epoll_pwait2 syscall
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
References: <20260109090937.599881-1-mjt@tls.msk.ru>
 <20260109090937.599881-3-mjt@tls.msk.ru>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
In-Reply-To: <20260109090937.599881-3-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1033.google.com
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

On 1/9/26 1:09 AM, Michael Tokarev wrote:
> epoll_pwait2 is the same as epoll_pwait but with timeout being
> (a pointer to) struct timespec instead of an integer.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3210
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>   linux-user/syscall.c | 29 +++++++++++++++++++++++------
>   1 file changed, 23 insertions(+), 6 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

