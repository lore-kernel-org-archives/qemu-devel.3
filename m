Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71CEFC27C53
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2024 06:13:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFSqD-0003W7-UZ; Fri, 07 Jun 2024 02:12:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sFSqC-0003UI-6R
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 02:12:44 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sFSqA-0005tn-G5
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 02:12:43 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a68c8b90c85so213170966b.2
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 23:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717740760; x=1718345560; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gOTPnRnckfXvjO0O7bBnuiFS+/3GTfBKm+5B1Iph7pk=;
 b=N9EF0BFa1QYO8a/pH32KvW3t0HSm/sf7ozSlO3Wj126AcTiXapPAayAswE+xCyry3/
 p/j16gbw6TK0+P5jT02d4bFNInUZwtFVVfyv0b75+/sHR4WeJwkJSHdICeI/qum133xY
 A9olw5MO+GBzljMJRU/5BR9EX/oIC72AYIPANjSLnYLd06zF/PrtgF1wMBu2RzW2oYXi
 XqrMl/n4Vdy+NBlk6/klQ2KyqetHYCgxY5C/rWUBzd1t99Z2Ym+2CPHs6rtyfnJ8wC+A
 n5X3hvjZZjSz9XDygNvAJ1vQpaYDab6DH1bdvgymfBxYzO5oxtDak2xbGU/QrX91HpO/
 TBdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717740760; x=1718345560;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gOTPnRnckfXvjO0O7bBnuiFS+/3GTfBKm+5B1Iph7pk=;
 b=hjoNpkl4Fv6VFj78hj/GEfxO8q5GiUMCDnmszTIdSI+aP0l9GKQIINa2SKUYrrPmGG
 /QBCthc9TBXVEQ93wnpN9ebmeC/ECNvDt8GLBLTR3OYN6Z4urDDCyGNtsFd69Mc85zaY
 bDwyt82A63lNwqDb8XEScX5rLgJBfcDOEXubEEVtYfE3YL+0o85j5rbhY+/RJvII9LmD
 7k3Nm7sTB38qp2fwlUdnlrQynxrMLkHb+4dWfMbqfMMwXLAYOjuDkRuMfGpjvTHygOiA
 JS2qGNY3AJRA5lwupGA4o9E3dyrnn6ItkkAHkolK3nbV0nS+NmnZiH0TBxtmzcBl+Ya8
 Pp5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMPVK4A6wJciecUsxpyNqkNEXZxrpd5X6EMuk2O8mMGu8HYvdhzBmxJFUMI+fPfruAKCxyDsjPZI8vQRPHUa8TFiVXDMc=
X-Gm-Message-State: AOJu0Yy7Kd2gUjIbc7mNQ8Y1vGk05uXINK8XiZA4cKcgD0QURfxnhwdD
 LuBKzEVQf8gPNh35jNk3WE5cIt4NQRyEhILM6wrU/Mx+dOoFPs5HOSLFZeuH3Kc=
X-Google-Smtp-Source: AGHT+IH9rZnmxxqhPDhz6Rqf1IsuD8cPb8RYWJsFw5Js19OG/POvRo1v7z+uzkYjLODUdVsXr/IbbQ==
X-Received: by 2002:a17:906:71db:b0:a68:2d37:fb5a with SMTP id
 a640c23a62f3a-a6cd560f9f6mr128265366b.4.1717740760592; 
 Thu, 06 Jun 2024 23:12:40 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.196.231])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6c80581892sm199077066b.12.2024.06.06.23.12.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jun 2024 23:12:40 -0700 (PDT)
Message-ID: <00ee7754-f3a6-4fd6-9bd2-e5903049e403@linaro.org>
Date: Fri, 7 Jun 2024 08:12:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] Move tcg implementation of x86
 get_physical_address into common helper code.
To: Don Porter <porter@cs.unc.edu>, qemu-devel@nongnu.org
Cc: dave@treblig.org, peter.maydell@linaro.org, nadav.amit@gmail.com,
 richard.henderson@linaro.org
References: <20240606140253.2277760-1-porter@cs.unc.edu>
 <20240606140253.2277760-6-porter@cs.unc.edu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240606140253.2277760-6-porter@cs.unc.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
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

On 6/6/24 16:02, Don Porter wrote:
> Signed-off-by: Don Porter <porter@cs.unc.edu>
> ---
>   target/i386/cpu.h                    |  42 ++
>   target/i386/helper.c                 | 515 +++++++++++++++++++++++++
>   target/i386/tcg/sysemu/excp_helper.c | 555 +--------------------------
>   3 files changed, 562 insertions(+), 550 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


