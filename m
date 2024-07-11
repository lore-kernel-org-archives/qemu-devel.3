Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82564C3DA45
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 21:33:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sS1PB-0000Li-W6; Thu, 11 Jul 2024 17:32:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sS1P9-0000L1-VC
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 17:32:44 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sS1P4-0005er-5g
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 17:32:43 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1fb53bfb6easo10275865ad.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 14:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720733554; x=1721338354; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=00ogbnRPoirmBDe4vWDZhDoh2C9/ODS/D5DUIy7wYQk=;
 b=OwIkEG6uZLDHzOCVgOmCLwOJ+i2wa/cxO/jOdWKjurNy1OzqficjtOPUaW0ceynDKL
 rgnjAf6fAfjd+zlpoyefDWzdSaNfmhgT9dJqAkpJZYJmkK/erQjFKe++GxVD7CIPvo7e
 8YxWGEC7aoHdsVq1HS09SSclTvJdteejOAe4vC0gHM9J7Vs/HsINEY64sLzkqsU8p92M
 ctWoGTTyO4cAFDX+SkflSQFoqOzXRMUMJaYcG7awhb6JdZNEvAxc2tVaK6If7fsoZp0S
 HQsI5iJ9FXJ9RjjXqwJAzm/QANPi2b9m8zEmP3ZSBlYZs7ho6KY73qVx+VBFUGic0zQB
 hgXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720733554; x=1721338354;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=00ogbnRPoirmBDe4vWDZhDoh2C9/ODS/D5DUIy7wYQk=;
 b=wQcEwbm0lx72tgKUFtIkBwocuM2SpWHXJriaSdWciCb2PyIxwNwdc7nZGEju5WrV7a
 Egc0YasOMf3eL+QZCNmSBH6iyBgIHs8ZZKhdMEqwpyIlPsjuHck2IzYKejJPzEI+vEK2
 Wi2LWOfCXjOel6LtFethfbRRfYRItn8R/hs256diPXP2VTy7ivkEh8VP79Lte1uXqvsU
 /6hhsp+tSsJzlgPOUxtxEAIQgVNs3Ik0YczTFGKO5oaKNtucdrqhgpcBgG6ecWT1L998
 mrOt3ldckkGWobK6QXpkyzMKhEMDDrEWpI2ivK/x4tBZ/bp/CQh1LQC5zFNxyduBm6BE
 ic5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWavXlgs8zs0TmG7QTQAZdy7NJp7s+CNG5jk4apTXwMaH81fIen8Dx0i5qW1R12fWgcjElpcDTTuacgkoUcrf8yS9IHZaw=
X-Gm-Message-State: AOJu0YyJVEgxGvafm+/upsQmO6nDvyhPbE5VZfDgd+4EM5nBjlFwx1t+
 U2J/25Wvs6Dk44gebMjdk+ovKe62+6oT3H8AS2wikjeaIVamLu5WyOq0Qin3Bo0kgnUkBumT3ze
 LN4Q=
X-Google-Smtp-Source: AGHT+IEpJzjyA+LhIuF3+bY7VdfuNI4TCQq0eT2PvpC5Ft/JS8s/+fXP8A1fE/fpZl0GyQwtXbv4VQ==
X-Received: by 2002:a17:902:b202:b0:1f9:b9ed:e84e with SMTP id
 d9443c01a7336-1fbb6eb22a3mr62088455ad.58.1720733553678; 
 Thu, 11 Jul 2024 14:32:33 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fbb6a0fc38sm55190425ad.17.2024.07.11.14.32.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jul 2024 14:32:33 -0700 (PDT)
Message-ID: <48e00278-957b-4e02-9034-8f314736098e@linaro.org>
Date: Thu, 11 Jul 2024 14:32:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/24] target-arm queue
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20240711131822.3909903-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240711131822.3909903-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 7/11/24 06:17, Peter Maydell wrote:
> The following changes since commit 59084feb256c617063e0dbe7e64821ae8852d7cf:
> 
>    Merge tag 'pull-aspeed-20240709' ofhttps://github.com/legoater/qemu  into staging (2024-07-09 07:13:55 -0700)
> 
> are available in the Git repository at:
> 
>    https://git.linaro.org/people/pmaydell/qemu-arm.git  tags/pull-target-arm-20240711
> 
> for you to fetch changes up to 7f49089158a4db644fcbadfa90cd3d30a4868735:
> 
>    target/arm: Convert PMULL to decodetree (2024-07-11 11:41:34 +0100)
> 
> ----------------------------------------------------------------
> target-arm queue:
>   * Refactor FPCR/FPSR handling in preparation for FEAT_AFP
>   * More decodetree conversions
>   * target/arm: Use cpu_env in cpu_untagged_addr
>   * target/arm: Set arm_v7m_tcg_ops cpu_exec_halt to arm_cpu_exec_halt()
>   * hw/char/pl011: Avoid division-by-zero in pl011_get_baudrate()
>   * hw/misc/bcm2835_thermal: Fix access size handling in bcm2835_thermal_ops
>   * accel/tcg: MakeTCGCPUOps::cpu_exec_halt  mandatory
>   * STM32L4x5: Handle USART interrupts correctly

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.

r~

