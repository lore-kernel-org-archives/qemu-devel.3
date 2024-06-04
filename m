Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77BC1C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 13:24:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEU9S-0008RQ-TV; Tue, 04 Jun 2024 09:24:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEU9Q-0008Q9-Rr
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 09:24:32 -0400
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEU9P-0002OX-8a
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 09:24:32 -0400
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-5ba1f60eb96so1789027eaf.3
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 06:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717507470; x=1718112270; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=z/daZY3Yx3leGGGdcM5uK0m8fIwHxFgIS5Xm8YFqT5s=;
 b=mQ2ZvROkaCDMH+NZJxIWQOStYQ69TcXrbXbrlGio3VPY2dhGgFA8crUtHPquX+LhLG
 7R2negFtaA2JmZhfLkeUT0NA34raXs6KRwqBk6F+77gBamAiOI8C6zGNBmxbFpPLYgiR
 1SAovz8GFX1SdoPK2TOgArdk83j79Qp+E2GX8h8CzxYUarerJKurOTj98xA2uW9kRvyO
 /yU90WJsphuqArMUSwisfZIE8X3ocCI7VbgDBugWmzk0Rar6APlJVYzdxCsUV5k5wB3T
 j1FN2wFSzEJCX7isrjgfOwTmGYREQ7heVWl1HMCI6bdo96umR9xEEhRlGN0W7pHIyKK7
 A3DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717507470; x=1718112270;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z/daZY3Yx3leGGGdcM5uK0m8fIwHxFgIS5Xm8YFqT5s=;
 b=T/FWRjYW58lbcF+LprpoWeRQvN0fOhPoihbGZoNA6pPYTNd4kBndz5fv+I2RX5E18e
 YKimkUMTM3thf7dqinrJLAzAOzgi/dcr5u5YE8Idx0BZtxReFR8ll9U7flox6inseWEy
 KvJD4eSwrz7BacxlbcdoW/cvhLrbCwoQdrqx+7qiyGRStbVorp2kqrZPYyqrc0sNhDEl
 +XaYSqqiDoTIkCOsAOgt19i3Rc5jRmLa64IAKXokslCxdSJPdG1tAT4pOkk1nLfQRKZz
 nCzWvNpAAo6o11HFtzdUfjuuu9txuvu81RWTs7luYVNlemFJuLkXTlIYC0ERyT0WRiWK
 7hRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYauzV71xi5diL8S9SdKCYt+c46gW2f+nCVRgm65EW6Y7DZ38vTmjvGqLHDec8jC7hj5lPitlo5qWOz1bCB9lE4b5wac0=
X-Gm-Message-State: AOJu0Yw4ucgGeB2+XjTA4jeTdyZO7EfCfDyRzbTM5YXvruL6Gcesjqzz
 rCrVFtwz2la9yIh+/NZi6Z3sr6dr5oqc36AyblxMAs55LrrYdPMua26TOqlmAlOdPHUbRb8X67O
 u
X-Google-Smtp-Source: AGHT+IGQYFAzb8N8KWxn8SXyi8BIZkLuuVMX30I+JqjfJzBkn7agIJfoPmmkiSCj948dYSf13wAObw==
X-Received: by 2002:a05:6820:616:b0:5b9:fc11:1fb5 with SMTP id
 006d021491bc7-5ba05914fefmr11463499eaf.0.1717507469677; 
 Tue, 04 Jun 2024 06:24:29 -0700 (PDT)
Received: from ?IPV6:2607:fb91:1aca:c697:b7cb:e0ad:8679:2c14?
 ([2607:fb91:1aca:c697:b7cb:e0ad:8679:2c14])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5ba768b985esm9153eaf.43.2024.06.04.06.24.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jun 2024 06:24:29 -0700 (PDT)
Message-ID: <86932024-d1df-4065-b61e-f82dde111fe8@linaro.org>
Date: Tue, 4 Jun 2024 08:24:26 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/11] target/i386: disable/enable breakpoints on
 vmentry/vmexit
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240604071833.962574-1-pbonzini@redhat.com>
 <20240604071833.962574-7-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240604071833.962574-7-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2d.google.com
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

On 6/4/24 02:18, Paolo Bonzini wrote:
> If the required DR7 (either from the VMCB or from the host save
> area) disables a breakpoint that was enabled prior to vmentry
> or vmexit, it is left enabled and will trigger EXCP_DEBUG.
> This causes a spurious #DB on the next crossing of the breakpoint.
> 
> To disable it, vmentry/vmexit must use cpu_x86_update_dr7
> to load DR7.
> 
> Because cpu_x86_update_dr7 takes a 32-bit argument, check
> reserved bits prior to calling cpu_x86_update_dr7, and do the
> same for DR6 as well for consistency.
> 
> This scenario is tested by the "host_rflags" test in kvm-unit-tests.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/sysemu/svm_helper.c | 25 +++++++++++++++----------
>   1 file changed, 15 insertions(+), 10 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

