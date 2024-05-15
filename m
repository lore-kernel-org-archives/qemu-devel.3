Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25E7CC25B79
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 13:00:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7EEb-0006pP-H4; Wed, 15 May 2024 08:59:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7EEa-0006op-6d
 for qemu-devel@nongnu.org; Wed, 15 May 2024 08:59:52 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7EEY-0003kH-Da
 for qemu-devel@nongnu.org; Wed, 15 May 2024 08:59:51 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-42011507a57so29624405e9.1
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 05:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715777989; x=1716382789; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OydvQDSzCnzd9CbKCqGEfdIw0ifrVrIvu1oqswH0H8U=;
 b=nAfmCrZ4zw3UVVzffT8Ag5jPaRrhf40L1TdRcZpA4AGrhpgt6gpcxL1bFya87ARM92
 FF/yKsRSaMST8zxDa5GynmYKs8ZW5eVBx4dsZw2nAKEVsO9DX5AQFChmrlktAuTmJBy2
 XXU3e5FUcmylkgf5SD7aPvj3OOYy82WBEffwJ1Pu0E5OW+Gwvs8mZ5qHQ3MV25vCqC2t
 tQ0DPfrwCPdBnwPlPuNDT9rWjIihA2nGz6yexNkAhm6P1DKNYep7fOHw3pcOZtOtNOWW
 ZpH7qBkHMvbSXe+pbVUD871HOEHlrU7nMeC+b+hmoAXhfkJgdRBBLtAXHIkFWBX7DXIi
 8mHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715777989; x=1716382789;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OydvQDSzCnzd9CbKCqGEfdIw0ifrVrIvu1oqswH0H8U=;
 b=S1aCG9sLVDok9jlQ9GKiLiFtxp9ehobRmT9Ip06dcZbZaEXqEjFGm5eF0sGt44oO7R
 /KPC0O2RN7kN4P5SK1t7F443yKo+JgBn9HNfJXppmIbQzJHLVfpfqaAfasqgoqnSjRY1
 Fn1hAe0GJqZC4s2srrLg0GdkP9ji8TULRi6Qmmu+djGdgDSGj6Cd+R3sDhFURtm1lvwd
 LGuGIkAfrt9ACaSW8zCk38U46ezO4PPv3d8eNPfS7N0H7P0Lp/gFfjLDbtj2HqQ5gDm8
 qEwKa8U+1O3BAXMkaUO4gn5vaiYRS8LHZbGCZl2eQa3QarjATjD2rGdsTaS5QntPIe/l
 5y9A==
X-Gm-Message-State: AOJu0YzkQIVc0kXklisJK/iIeNoCNCGPJ5lA6GsT2udGm+fSayppI1Kl
 4aPu03uqpr6JBn/lRb22fYYsVIGMZTxMRdLO67G/8borxx+Sq1zoVp5LBIi3Y/rggOSAjUt+zyz
 blxk=
X-Google-Smtp-Source: AGHT+IHzgEBIfeWyvX4ta37u6UMJB+giA/SFZNeI5Qiu21v590oGzjupe8um5uFTnkL2vWb+WrF/FQ==
X-Received: by 2002:a05:600c:1c16:b0:418:df5a:3fba with SMTP id
 5b1f17b1804b1-41feac4927emr105539095e9.32.1715777989076; 
 Wed, 15 May 2024 05:59:49 -0700 (PDT)
Received: from [10.91.1.91] ([149.14.240.163])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42015deac1asm112035345e9.17.2024.05.15.05.59.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 May 2024 05:59:48 -0700 (PDT)
Message-ID: <74ec5d36-b2d7-4c46-a8f9-03ff700aa836@linaro.org>
Date: Wed, 15 May 2024 14:59:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/43] target/hppa: Misc improvements
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20240515094043.82850-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20240515094043.82850-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x330.google.com
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

On 5/15/24 11:40, Richard Henderson wrote:
> The following changes since commit 3d48b6b687c558a042d91370633b91c6e29e0e05:
> 
>    Merge tag 'pull-request-2024-05-14' ofhttps://gitlab.com/thuth/qemu  into staging (2024-05-14 17:24:04 +0200)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/rth7680/qemu.git  tags/pull-hppa-20240515
> 
> for you to fetch changes up to 9e035f00788c52a6f51529c54371a611d9f8b089:
> 
>    target/hppa: Log cpu state on return-from-interrupt (2024-05-15 10:03:45 +0200)
> 
> ----------------------------------------------------------------
> target/hppa:
>    - Use TCG_COND_TST where applicable.
>    - Use CF_BP_PAGE instead of a local breakpoint search.
>    - Clean up IAOQ handling during translation.
>    - Implement CF_PCREL.
>    - Implement PSW.B.
>    - Implement PSW.X.
>    - Log cpu state on interrupt and rfi.

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


