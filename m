Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F96DC27C54
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 14:03:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEUjZ-00088G-Fv; Tue, 04 Jun 2024 10:01:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEUjY-00087h-1K
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 10:01:52 -0400
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEUjU-0008Pn-V4
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 10:01:51 -0400
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-24c10207d15so2708834fac.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 07:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717509704; x=1718114504; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=deVCfZ8TNlDqnQFUiyi0hUfmNgfiAhKhUCDxHipBq9s=;
 b=ifARyX5TP9EuKG/IJ4eNbrOzOVarPPHdTl6rkWxUs7IWat8LbjNMCnI1Nm+BXPeXul
 WLC8znpVYZyTHlqfy3mJBSQWiR2zfxLAa4EwZrZdHCxA7qvaZGJ2FBx+aRyKVVEJUW5c
 3uvMftkdpocTI9Q9P3V9cmkTV/qfWfemcotZXEWy609BRWcUE84LejptO3ViPEu5SCdC
 WSg7TdSFhCErN28R3nzZyuSvcs7B+1H9eiIq8O35WprRyLXCZV/H4QyjBcch+AiF/jnH
 zTX7zagcf0GPOdwQbaZueH3FoMZdvA9l77yJuzUTOvaXMKAGTmhH/tokN42UmNnDyoFU
 K8mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717509704; x=1718114504;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=deVCfZ8TNlDqnQFUiyi0hUfmNgfiAhKhUCDxHipBq9s=;
 b=qMMvRz+0/tuazLsSj0B7oxmcuipdptj2Ku4VSWlKY79uh69cdSRYaUVwtuu3GxE9rW
 BP6TU8IaT0C8Xzky4d1p1gQzEHUIMkadTVgLGTy0bb01noCTkLA8FizPCTj+X7ZoTY2I
 FUpJEXx2KTNfdOHeAljmwrH6Tg6SY/D74RJOYRl/tr7rvx13ztD9HwWuJQBG4IWnwqKa
 sjNbt/fay6U4d/B2M8WRl75cNqCpM57tO0yu1zYm/vZzfJyHrPGmq1zPJ6xN6y95yS36
 wNAS5UIrNkSLn72HDtAo6nx7yZl00iyz0jAtMtszQa5JG+MjeRSuNtcN0AqXY2cbQmO2
 Q9YA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEO23I98tjxrOb6pgABQBz3+ZOLYd5QBvxgCcGawIY3mchh+pCpC7KDvvOzu8+WUOgOfCzmi4P9qCZUJZaX1MMVmpkJKU=
X-Gm-Message-State: AOJu0YynESKBAH3gy+SGW55vkw7XCP9mPraa5ltje0kqF8aA3UdrLKKw
 C74ObxQ6djUZofTHWUiglRbzwPH16r+wjUdm3PCUDB7nWX7U5b28PWjA2cUwo98=
X-Google-Smtp-Source: AGHT+IEvFO1KooSNJTUx3kFwd0zJr5QQGrhZEQNSbqVsQdnIonphqRNNm09qK0qeN+ozHh0ysc9BWQ==
X-Received: by 2002:a05:6870:291:b0:24f:d502:297f with SMTP id
 586e51a60fabf-2508bbe6661mr12737040fac.47.1717509704087; 
 Tue, 04 Jun 2024 07:01:44 -0700 (PDT)
Received: from ?IPV6:2607:fb91:1aca:c697:b7cb:e0ad:8679:2c14?
 ([2607:fb91:1aca:c697:b7cb:e0ad:8679:2c14])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-25084ee6b24sm3318426fac.8.2024.06.04.07.01.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jun 2024 07:01:43 -0700 (PDT)
Message-ID: <d789f648-542f-44c1-a400-71c82cff27e2@linaro.org>
Date: Tue, 4 Jun 2024 09:00:41 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/loongarch: fix a wrong print in cpu dump
To: lanyanzhi22b@ict.ac.cn, qemu-devel@nongnu.org
Cc: gaosong@loongson.cn
References: <20240604073831.666690-1-lanyanzhi22b@ict.ac.cn>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240604073831.666690-1-lanyanzhi22b@ict.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::32;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x32.google.com
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

On 6/4/24 02:38, lanyanzhi22b@ict.ac.cn wrote:
> From: lanyanzhi<lanyanzhi22b@ict.ac.cn>
> 
> description:
>      loongarch_cpu_dump_state() want to dump all loongarch cpu
> state registers, but there is a tiny typographical error when
> printing "PRCFG2".
> 
> Signed-off-by: lanyanzhi<lanyanzhi22b@ict.ac.cn>
> ---
>   target/loongarch/cpu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

