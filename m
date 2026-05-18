Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1327CD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 12:33:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOx8J-0003lP-BF; Mon, 18 May 2026 08:31:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wOx85-0003hX-1m
 for qemu-devel@nongnu.org; Mon, 18 May 2026 08:31:37 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wOx80-0004Au-DF
 for qemu-devel@nongnu.org; Mon, 18 May 2026 08:31:27 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-43fe62837baso1188330f8f.3
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 05:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779107480; x=1779712280; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rnmPHNPmta8CCozdFB65/vpV59t/dWrCTqBol6zfTRA=;
 b=AclMVsRYVrvoPHrBzWqBadJOpO8QT7NZtLKRavP6LQpIq/h8TLFbvdbnuSwb2fZZ0A
 v/RYo2c7fcxiFImGvbXUbWWBR8rubM3zg25ImYdN+YI6/8Y+4+8/kDjTSArKnk/2eATH
 tUGhejKYm0XRpx8DCGkydyXH/0U2A8oGrFaSSaMXgcl92JoTkvj3FQaL5l0oydR/ZO3T
 4iUli4d0dgASJEbN+E4egu3zjKdw918xS+h5IBYrn7Y1nDWnV6+ttPL38vAqJhuv7T7t
 e3L1l4h6O3ha+xNSLhYLHbKDZ21SpT+dr0/AbeP5hEHI2yhzQrtnzMexdx9evyNcQUGM
 lxMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779107480; x=1779712280;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rnmPHNPmta8CCozdFB65/vpV59t/dWrCTqBol6zfTRA=;
 b=InRSvreYObi/EhJbpB/cmcCdfRlrv/EMVJpw9+FUOeRD68UoYx4EwwowyQ1WuS6bfJ
 CeXTjgYlq87mEl8x53eTR4AVsUqdPgCy6H/utPlyBx3n8veSfUB+pQhKDNzlfp3IFk4J
 HzMG96QVyr3tTLEDJ641FFPxNWIfw/RZ7pyHPw4b3HwtYAkNITrCgywYRkoPDnuCQ5zn
 7clFVPj2aJNEcNg53VgBqED1jlUymx7n2I9kHX09h51jyws/nnRBEr9d6T5IpXyMzrj2
 AX01/capoO9vBDkp5r28iwIMq3ZzC5MKgtBW8ze2wZLUKsM0Y6vu2NpFlR74UA5MfAXk
 cseQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8M3h2TZuU6rOmmDfVkgKpjFe/91pQqkvNxiwE9fHYc/UgEX8VY+Qht5CUlC17WKcCxJTPXcS2tK1pj@nongnu.org
X-Gm-Message-State: AOJu0Yyi8F/KI/ggIgwAVJGWJ2qKFFHn0oOeVcQaWjQgMFDydKZ+6KMo
 tbjpZ2dlOo2mOSubqFqeDDKywl3/Sx2C1df8Hy6/MdpIOKxIcYoq1JCW5Hxxo0lBWwI=
X-Gm-Gg: Acq92OG/j8kRlzOmza6L2R6NC+JckuJHIEyipjZ9o/xS0CuRzFBUz8NNDtjj53s8ap0
 b2jZQRP0AYTwmu9X0VSNmSHeHtgUFCvKhaIqlIdHvYlaJP1hon25J2uBDdnHons5MBDjqkvrHod
 e6j+/zHX8Rf9eBdz89jbAl7iEM2RdEzKeagKYt+L5ghyGaawUCNcPjC17FzQrKpK7i2Sx0O5e7P
 bq4/p+817BvswQpaqDvQ2O2gbViHz2oyB460B64BwHybDggiW1tHYdG6D3eo4+nT2LY7uVqMwPM
 RjTsRR5Ic2giI5MI+voX1XZ/GuP3jJ9V36KkCs/PqY2P7daZPxQeM/+X6IvmPwIU4SEufWKJQu7
 rxmaGsdvLFbbGjtqfgZBb2cKOuOO8yZAd4keR7vJnaCcyIKQxTRf+narpsnWO3AViW6LCZqCDnv
 ILPQ2YDCnW92y58cIbNzzuylqTubf4i1jnES7TwwT6IUTRa7gae8uK4B1JR32vExlzhPxyBhtbJ
 leM404TF0VCFHQ=
X-Received: by 2002:a05:600c:1f8c:b0:489:1f08:91b with SMTP id
 5b1f17b1804b1-48fe6323821mr208173365e9.16.1779107478848; 
 Mon, 18 May 2026 05:31:18 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48ff43f213esm102074095e9.1.2026.05.18.05.31.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 05:31:18 -0700 (PDT)
Message-ID: <a216d6b7-7101-4352-bca1-eba4383255f7@linaro.org>
Date: Mon, 18 May 2026 14:31:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] system/vl: Free allocate memory for pid file name in
 case realpath() failed
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, f.ebner@proxmox.com
References: <20260518114514.684401-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260518114514.684401-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 18/5/26 13:45, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> In case realpath() fails, the code returns early in the function
> qemu_maybe_daemonize(), without freeing the allocated memory. Add
> a g_free() here to fix it.
> And while we're at it, also free the memory in the qemu_unlink_pidfile()
> function - it's not that important since QEMU is going to terminate anyway,
> but some malloc sanitizers might still complain if we don't free it.
> 
> Fixes: dee2a4d4d2f ("vl: defuse PID file path resolve error")
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   v2: Free memory in qemu_unlink_pidfile(), too
> 
>   system/vl.c | 3 +++
>   1 file changed, 3 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

