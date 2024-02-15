Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD8AEC48BEB
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 08:59:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raXaJ-00043m-3x; Thu, 15 Feb 2024 03:59:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1raXaH-00043b-Ct
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 03:59:09 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1raXaF-0005u7-SP
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 03:59:09 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-411a5b8765bso3343445e9.1
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 00:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707987545; x=1708592345; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+JzC7gCOLxP4J0TkH94d/D8It8NOd9Yvzsqw3umppRE=;
 b=rAjlIvfMry5iO9/m2WJZkV2nZKN61NIeMR8/vXlFFIiUrmPc0RZtP3NL8odsGWhzaJ
 u92XUExwhXkEbVs7CIUWvVJcp3kTyqPrKxmzqE5cojwVySFrub+14l0rqitRK4S7FjC2
 VaJRgjkPTDKssKboPxI6aInCKACBjMExMGdAPSYJbcsQlB3W3rDpqZLbQ4e2jOFEgWFy
 zl9FVlkNbzCXD7LuB9FYtf28RTzX+gNGe3W9oFziD90gkzzbYgGczq97oM7a0ukq7zJX
 q4y2mdOg1F6G323MxaC09zuHY8JA5zoHnn+Qka0Nd+dZxR78ExqcEmNHMniGtn87aSO6
 4PNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707987545; x=1708592345;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+JzC7gCOLxP4J0TkH94d/D8It8NOd9Yvzsqw3umppRE=;
 b=eCHhkIvCuT2PtQxj31MVeCXE2+VFlN6mMpJ9GCTWRsbN2Oa4/Zg00Lbbbf82HW+x6U
 EQCnbpFwBLhxRf1adbE8gVP5x40jLOfTwHtT+KDZlXs3TlzuKBd9TFYyMTdYZX+n5yLp
 nQXDW0p1/pqRTmHWeGjJnJOBmCRUwhxmY3qpF47RkCFmLnBYSKRaq4d+l9HN5YECuDmT
 kI3YxOQCngAZKZS9hw5Cz1Vr20S/t0q+P3aIs20mTeywS3pYGS2/jMJPc3O5M9+Edq+g
 dK0OK/lt1pNx5BCEP+jgEAVj0MBIboati7/zYiMkCVEKF8/JHGCBzKzfaD7CjsRLWuYA
 dGLA==
X-Gm-Message-State: AOJu0Yxr4iUd4D87TI72g+7zxMfVl4UzokU8B2RnUkIDfgCl49oKu6za
 AaiWPJj7gXkXFu2mOfarVEFPZjUq6rKNWGaaphdxv4WeEjhpmo/SgvjXhZjzrYqtPYCyhyfs5p6
 PukY=
X-Google-Smtp-Source: AGHT+IHruBK5fFXjvnLie8pFtL+faakgJNY4c53KRADaVZyLlfXHOxYhDUbhSj0wh+scstVetSFh4g==
X-Received: by 2002:a05:600c:4511:b0:40f:bbdb:4f2b with SMTP id
 t17-20020a05600c451100b0040fbbdb4f2bmr4015781wmo.19.1707987545042; 
 Thu, 15 Feb 2024 00:59:05 -0800 (PST)
Received: from [192.168.124.175] (14.red-88-28-17.dynamicip.rima-tde.net.
 [88.28.17.14]) by smtp.gmail.com with ESMTPSA id
 n12-20020adff08c000000b0033cf60e268fsm1079851wro.116.2024.02.15.00.59.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Feb 2024 00:59:04 -0800 (PST)
Message-ID: <1354d323-2aae-4cb1-8289-58238ad5785e@linaro.org>
Date: Thu, 15 Feb 2024 09:59:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/mips: Use qemu_irq typedef for CPUMIPSState::irq
 member
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20240130111111.6372-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240130111111.6372-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 30/1/24 12:11, Philippe Mathieu-Daudé wrote:
> Missed during commit d537cf6c86 ("Unify IRQ handling")
> when qemu_irq typedef was introduced for IRQState.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/mips/cpu.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Patch queued.


