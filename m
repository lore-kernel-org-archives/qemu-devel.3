Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8029FD1D48A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 19:59:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdwAN-0002Pr-Lv; Thu, 08 Jan 2026 14:59:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdwA8-0002Oc-VG
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 14:59:20 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdwA7-0006Sp-CO
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 14:59:16 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-81df6a302b1so154419b3a.2
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 11:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767902353; x=1768507153; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Asl3CeIcooj0xTHeOm+T6f+HfUc07vLWUNKAXBpKEYA=;
 b=C0ulm7gt45OdlfqGThG4kW7CXU8plhZtWAfT9ojKpd/98pNTk7gebtSqWW9K7cwqDS
 mnUG5KyQZ8HlEmd7Zmg6n8msfhVa8jxDfro+rkF8YLXWJcsBcWZDPVJrgu5Mdw6V8nN+
 wagjKQFTSqSP/fwOzzgWxm+7mxaaoTrfLleHBAG1TlEEAHqlbzmed6jKn8eChnJfhRY0
 w6p2+S0UkWvJxZTHK8FBbpqqq8IW2uJsnTMufzIEfGjvzeC12kqji5Rq0pMPsi56PuTz
 bTd+qo/T4gBhWtf/LpWO1joQvNwFMXnY+jqW2ctYGYtR0xh4sl/vtQTm9na5gnfn/gP/
 J4rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767902353; x=1768507153;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Asl3CeIcooj0xTHeOm+T6f+HfUc07vLWUNKAXBpKEYA=;
 b=ln7yHJUWDhRtnRwrWEAPGgncvYu1l/xGN3DIsuSnrO0wHxiITLGFl3ep68nRvZX+Pz
 8VGKkpwElxz6GeMcrSPArAQMXVCFOtFQ6M0j19ym3folRu6JUrIR384yB9lBdXsfDyHS
 8hNdDtGtr9Nkoa7fmZO40x+SxI3/0V0dr72x5GaHLIy9/Hx0pktp1X8c2tV6OvcydG9t
 1PYf5AR4aaRbF9WzuIemc8nfZ5Mcev3qNTER16sMAS4XBL+a5LXeWafwFNuBnxbTsOBu
 qSooGkYpVjDNOeDDaZr3IziD9BWMjEuFD4a705PapsfVv1GdUEVzLrbVerEh6hA8vbip
 yAdg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXK/L6+r5HYXggo89LHS7HVSDo1lr1naB7z+ac5NW8tY47u3A/y5roFtcN1NlyJ0FeLNlM4N3BEs8dL@nongnu.org
X-Gm-Message-State: AOJu0Ywe1xALcnSBOx6qncpxhlKGSStfIxvlHtgbCXtymu5AnkgV4Srv
 WeJVDjSrUlwXr17+c1WV6eRWHrODCzzJCX/nEi6NtXAQG8shpS1sRUsWgiNDKL8yl4ZFy3gZj+I
 wqBaS
X-Gm-Gg: AY/fxX6p7bwU76LKxkr8sdarDcEFhtLM7ZrzhRAetNQpBSwpN9vXxHqJF3xKW8LQ8r3
 TIJ6e25G6C9liI57QkrGE/mhqxTj3K4uD4EC3i3yrJQdbRvyWWM6DzNG6Ckbrj2XyLLnhDCZ6PU
 7bCRfjqEk7bne0lytDlAGHIr+zdvPBjxOp8mwiiIM3Z+uiPTjg8HID/GlWRDIYdkxNd7O//OaQh
 xJoTIwGnsN51vCZfLhBzQpkMij2lMyOaTCnRuT9u7YYclKCwLMgeVCfUwbazBUr1XCQMpdf5KPo
 8Fl2O/j2GC00vHoF7m+EFwESxJyOiUs/u0NaVP/TTvowc9LJNZwN7ivmNA/5amAO5eOeU++fAFS
 rkcD6jyt4Bi+u3YEb05Sj6wjBy455ScJCrKvsvF/UGyUMqoCRz/SKZbwpQgQo4AGwNc+nrpTp8f
 CzNTnTtHTkAl+NSMFNchZ8UJ8or95dvQMNawPz6TzLPEgvVe13WNTgTD2Z
X-Google-Smtp-Source: AGHT+IGiRgudW9a7O6opYuRv/nmZfnfD1U7oZ5ZWY1DdJljbhttBi6Om8NobIbR+GOFtDJLjL6QWmg==
X-Received: by 2002:a05:6a20:a10f:b0:370:73c1:6a87 with SMTP id
 adf61e73a8af0-3898f9bc643mr7657737637.58.1767902352687; 
 Thu, 08 Jan 2026 11:59:12 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cbf29086esm8839647a12.1.2026.01.08.11.59.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 11:59:12 -0800 (PST)
Message-ID: <0e3fd137-8535-415b-9520-8291d27b20f9@linaro.org>
Date: Thu, 8 Jan 2026 11:59:11 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] linux-user: implement epoll_pwait2 syscall
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
References: <20260108174317.239955-1-mjt@tls.msk.ru>
 <20260108174317.239955-3-mjt@tls.msk.ru>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20260108174317.239955-3-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x431.google.com
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

On 1/8/26 9:43 AM, Michael Tokarev wrote:
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

