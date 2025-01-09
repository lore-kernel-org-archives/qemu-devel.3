Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABE94E77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 14:59:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVu0V-0008P5-60; Thu, 09 Jan 2025 09:59:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVu0S-0008Jw-QR
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 09:59:33 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVu0R-0001Hs-5S
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 09:59:32 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3862b40a6e0so590655f8f.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 06:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736434769; x=1737039569; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=t152XkAFiZPQBcHwoyLO5eQljKyBORLxn2F4A1VMNuw=;
 b=LLmn2QvX3eNo7Kzvg3v7YYfuhe4dGt6+4xULMedtTa2T7uANFjRDIcCBPU3IgTJ4J/
 l/0VUagjc751rSy1oRMNuXrHF7SkWaPImN6NPQRRhd4qM181hQXVMQ0oT23WpsSaJAKW
 Ie6kw5DaWQv3xfph+skEpe7+eRQ/FvnPhqSH9oTrKqntudHkZ+pBR20LdN6ngsNR4JTS
 bfMuQz7L7dwxf4VFao94PkE1JIDThxa7Z5LCWn1Sy+CDteyzU8RZox74LTTApIDgUDfm
 jxhdeWq07yI9EaT2rflBzFRkz53VgHO6O7YbZDssEvfbU1ZOr2lSPY8nI2p3ChKeUQMi
 GDpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736434769; x=1737039569;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t152XkAFiZPQBcHwoyLO5eQljKyBORLxn2F4A1VMNuw=;
 b=QiRzqvNJ+DsiQjfZCb0EKkAFD/RzzYSE5/QtaOZTiq1K6bhT40IwYZgH9sVUBvHq+S
 Hsa8VYZtJUWvatTt0ABJcONzDygmhrNjyJFvZAI5gWlVOItPSM0iLS5QsqhrbEyhQW2m
 wswteZRZuF/SqUpL+cflfbX6kIZ6epyPx2b/UnylyH8tGWNMjAA8RIgbrkFwyUiD6pbo
 gCIFnQ2/92GquT6sROOm6C8DNFDXiTchNc6lJhwiAi3oywvg4nKAwvKGqxc1OwOQs9p5
 fyADxJYobYBg03SwjfhflRgSod3vwgdS0075Tfn26YIxxPjrqyl2C7O4OGwFzeyMfWft
 VzAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXU3AV+v3d2TOWLYKmqR60n6ijkKfscpWUqi876pYPJW9iOQOfVLtnJd2RhUK+YWK971Qys/Y1k/gDT@nongnu.org
X-Gm-Message-State: AOJu0YwhGAhkhdA4W0Xk7xu6LJxnOn1i29aTaPoPemQi2098asp8dl1K
 HDj2fvSAMe+L0ac4A5ubO/t/stZPatXRhcajYkuM1zrVYSoTbDm7kftQD/aCpRg=
X-Gm-Gg: ASbGncuZZlwPivJ2v1GF/pcxJNrgfqTjqT7xn8k5fm/CWdzFWwSBHV1oEhzCieYYhl1
 MYl7YrqMheo1KpzRlKhqV5gmuxsO/XaZUB21kUprPRg8D5ksrLTA3F/iQLjpFnOBiarrA7oBsa4
 fItcDQJuyzA5CurxNOkd3H8ft+HI2L4aymL1/9xoMVGxPM5o4Fdb57izevQHHezdT9DX8elMh+x
 MtDbxGshmSFwqSuwx1A+UYqFcoOJZFJMuIIo4Sb2HkHvzbBBXUHzpU8yLt5YZPHzEBZLj/KylEe
 wAYztX0u7UNYccoVhUm93KDBN8M=
X-Google-Smtp-Source: AGHT+IH1MtCwfebZIs+KMCfSmxgIK2AMKX+amqcPaWG2NW7N0FIQWCSNlYvG8bHm4p0nwWSe2szGxg==
X-Received: by 2002:a05:6000:4913:b0:385:fbb7:672d with SMTP id
 ffacd0b85a97d-38a8735638dmr6197267f8f.52.1736434768928; 
 Thu, 09 Jan 2025 06:59:28 -0800 (PST)
Received: from [192.168.1.74] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e4b8214sm2032034f8f.78.2025.01.09.06.59.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jan 2025 06:59:28 -0800 (PST)
Message-ID: <ec028eff-764f-46e4-abd4-319e15a6bee1@linaro.org>
Date: Thu, 9 Jan 2025 15:59:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] backends/cryptodev-vhost-user: Fix local_error leaks
To: Gabriel Barrantes <gabriel.barrantes.dev@outlook.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "arei.gonglei@huawei.com" <arei.gonglei@huawei.com>,
 "pizhenwei@bytedance.com" <pizhenwei@bytedance.com>
References: <DM8PR13MB50781054A4FDACE6F4FB6469B30F2@DM8PR13MB5078.namprd13.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <DM8PR13MB50781054A4FDACE6F4FB6469B30F2@DM8PR13MB5078.namprd13.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 28/12/24 02:16, Gabriel Barrantes wrote:
>  From 532af9eecee4695abb02b40f2c18b711370aa7d2 Mon Sep 17 00:00:00 2001
> From: Gabriel Barrantes <gabriel.barrantes.dev@outlook.com>
> Date: Fri, 27 Dec 2024 18:02:32 -0600
> Subject: [PATCH v2] backends/cryptodev-vhost-user: Fix local_error leaks
> 
> Do not propagate error to the upper, directly output the error to
> avoid leaks.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2714
> Fixes: 2fda101de07 ("virtio-crypto: Support asynchronous mode")
> 
> Signed-off-by: Gabriel Barrantes <gabriel.barrantes.dev@outlook.com>
> ---
> Changes in v2:
> 
>   *
>     Add full link to issue.
>   *
>     Add reference to first bad commit.
> 
> ---
> backends/cryptodev-vhost-user.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

Patch queued adding zhenwei pi R-b tag from v1, thanks.

