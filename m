Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A1B5F531DC
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 23:16:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCQVm-0004A1-7A; Mon, 13 Apr 2026 19:16:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCQVf-00048R-VM
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 19:16:05 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCQVc-0001lc-Ri
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 19:16:03 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-488d2079582so44104565e9.2
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 16:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776122159; x=1776726959; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xKsNNPYiO52rsK47bvfVpQ37esKQecELlA775ulScZQ=;
 b=pjuATN7NTU+TUr2ph5r9w5jE7g4IJkuF7eFwfieIDxRE57G8WFkOZyus+JfIYUeZNh
 lp6vCnEcVZyCyvq3bxHkhtj7A1IREtyGhMGvAFbta3QovlTcRMrwHrJl2MTHVJZa43Pc
 dSaSrRrVR3XH410Yx0KV4VbPMbZ8sfSBtq4pHityXMiL/5oF0jDbqL8iqr/0mE6TjGfu
 CSVpQ90DlWCXjuMAdb+Gws3FGMK3Nqw8lf1/t69QAmDF3iI2aIAazONowNzotwUesy+N
 pJw0yjWmaOiD2t8QAA+UvVlvK8KSfhYdd8WTNg9rYYdrTEI6fM4u95mhsw6eyWWMhdSv
 oYHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776122159; x=1776726959;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xKsNNPYiO52rsK47bvfVpQ37esKQecELlA775ulScZQ=;
 b=bjV+Hw5l2TxUSbLDeBO0FFmHOsqLSQdD+qyfkltJNrm5WFCCPVTKA7KYDLz+UdTvS8
 Jb9XUUz32idYvXZ/flasAgTc8aOxMtpuYeZ/Eup50xR2Kw86QJxJDrqK7Pcyy4hsVz1Q
 h0e8Lw1CwtU2ZPYfzNa9C3VF7+IxHG1t9cZ6Xra56SpRR//pTgADplYBAnhbxG7Uv52U
 fCQkxdo7QPxHJw29nqvAJHrV1OMJJOd14f7vu3vt7lzuU4phva4gFb/jAPUZt2KPWj1v
 saqJbJiOoCz0YQ9iPQaPSnEZhfFqeWC3cYQ2OQaql7QhopMwjE/5M49P9SoGKilGgmYr
 /SuA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/cnRTe4mgGWxHUoVd8MnXqWhZUDFJFSb3gip4jC8OQYyUgV8b9dq89acF+eyEYh9dFbD9zPM6Nip51@nongnu.org
X-Gm-Message-State: AOJu0Yw4IAiWOpSzr9HsC5LaTvsGu4gubYjkwDTaMcxgojkeyCZXOqdW
 6XP1ZR7Wq6BHhZ5zEj6hn8a9BJhmSIcEZ4C69/irgECCJ+At//BzBGy+ybzlbA9NbQM=
X-Gm-Gg: AeBDies1bBa7xiqu1HPn6QfggZ30i0JBXvruaerSEyfdUZzEJXm3KBT+7DgEVCRW/YG
 XQiIkvNXLCUgVy2wHjJa48AG//gPHD8lppUEDs57n5Wux4afKhmb7bl8CMTgipxjOXW+QvxDTSF
 k/HjVG3EJf0uC3GSxGKvqftFjXOg1tFDQiqxPykdRwHvDFt/prY4HIAvWH9rp0B06XC07V/Q+kS
 raV8yt5ULBeYOLi1ps10k6XQ6m5X9axXzaHMTkWqGa4KlO5sKEAxrVqODXPn6joyXi3GrPVJ5O8
 YUzbEDPtZgm+j7vFRVmGETWHepp7bQnZtPrCVVCslHW70RyvVIvS3/Ob1JiqOBlRywyLoCqMHxy
 8skH7BVESCUKH8Ttd3XsOtrRXFo5O2wUkKwV7eGrG4WCqVhJdwsNMfVd9DDdiSeGDTdmggiRNSy
 vMEFj+p1PuGaIs8jlKu10u3dZlQrQx/PaErNlg1DCH+NfYRur9MBG+lyfQScD3Aez62A==
X-Received: by 2002:a05:600c:c16d:b0:488:be21:54ae with SMTP id
 5b1f17b1804b1-488d66504bfmr220136705e9.0.1776122158904; 
 Mon, 13 Apr 2026 16:15:58 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d6839981sm106683235e9.21.2026.04.13.16.15.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Apr 2026 16:15:57 -0700 (PDT)
Message-ID: <b198f9ef-d80b-476c-accd-e6dede79976f@linaro.org>
Date: Tue, 14 Apr 2026 01:15:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] linux-user/arm/nwfpe: Replace user_registers with
 current_cpu
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20260413230251.22537-1-richard.henderson@linaro.org>
 <20260413230251.22537-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260413230251.22537-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 14/4/26 01:02, Richard Henderson wrote:
> Use the thread-local variable current_cpu instead of
> a global variable to access the general registers.
> This also means we don't need to pass env to EmulateAll.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/arm/nwfpe/fpa11.h | 23 +++++++----------------
>   linux-user/arm/cpu_loop.c    |  2 +-
>   linux-user/arm/nwfpe/fpa11.c |  9 +--------
>   3 files changed, 9 insertions(+), 25 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

