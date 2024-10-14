Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46D93D18156
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 22:11:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0TGk-0006bm-Jz; Mon, 14 Oct 2024 18:10:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t0TGj-0006bT-8G
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 18:10:25 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t0TGg-0007iu-Ah
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 18:10:24 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-7ea7e2ff5ceso1124186a12.2
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 15:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728943821; x=1729548621; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6foHWMQ5t7ne0oD832tUelyfBPGQRbcmp0VAxOlB/5Y=;
 b=AjV2QwEpAMDK9ozZlmFfWgY6w0jchzkS4eJCfCErnxecDBBnuGyUTFoNORZ/aC2JJn
 q3LmukhdhhKvXQji1fcPRveNxhAsQhWy4ItJT+rbz+Ba0W6UKDUbOCRmRoxyWDBfWq8m
 7BAFZAlUE3SspzorI+K7+1ZuZqMg8QpSlGwb2V94ttIIO/cGW8lvdB++MEz6mTmFF5/X
 8aGIsgonbagFDqwZolspaNSAoJgS1/g85NPGFNJHRe/oYEXdjMDGyd9VMgGfRbm4GcYh
 8dSZjX72d9Uy9nmyxq7YpFb6UsXoHG3o0x0261dzhaSwshrVLtIKX5SmaaW3D4J015/t
 yEOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728943821; x=1729548621;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6foHWMQ5t7ne0oD832tUelyfBPGQRbcmp0VAxOlB/5Y=;
 b=L4UZ4PJDIQyMz9vVZEEiiCB8R7ffb22XkT8zGRyYiw10KjtOmyThf18+WteqszC3/J
 SsQeQHJwOHfUW/8MVavbf1JR72oiBv1kPG6V/huc68Ux/MXNfvCdYEbvBOoMHeR7SCQK
 W6x1xwLfDfPf/nyo2JKfTHmzxjOCPPx92tHFzYIBxYmzqsFbqb7M5lOmhkYrQ0yPt6+w
 PRrrRGkiEmGZkejSMfcCWhB6ZHogdGJv5OJ1uPgmYAxDaXO73eCOEMNMpxINF9P1uHVq
 zpqGnEnamBSDZaRRxj4S9wl2CTpEy67+78Il6Ufha+/6CjKAvlqwCseRnggqGwe14wIm
 FnOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKPiAxy0M6uRfGiUgcIJ7BFAmOmdBX6mwI7z3LRad68OXDZuqetluan2OXoIDm5fDrPwaj/6VVsB5C@nongnu.org
X-Gm-Message-State: AOJu0Yxrsb0Z4ThV0d0UQs+vuBFTReCnrsqEqjqv5dG4Y0vxYqJjDLMf
 D3xYa5COCXbrGErP8YeHvUR9qnJhf30RHWYcNyB9icL9Xxg8qIZJeEbZLwDfhto=
X-Google-Smtp-Source: AGHT+IFU2+0SOcsjZyB4csJArN6teNpYKRyRmhpfNWARNjhsX+viQJGweQXliItH/68WdjSjs5CtrQ==
X-Received: by 2002:a05:6a20:c89c:b0:1d7:7ea:2f35 with SMTP id
 adf61e73a8af0-1d8bcefde00mr17121191637.5.1728943821018; 
 Mon, 14 Oct 2024 15:10:21 -0700 (PDT)
Received: from [192.168.100.35] ([45.176.88.167])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ea9c6d3eb7sm15388a12.45.2024.10.14.15.10.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Oct 2024 15:10:20 -0700 (PDT)
Message-ID: <76c0c76e-3506-4c0d-8633-6f130a9dbd2d@linaro.org>
Date: Mon, 14 Oct 2024 19:10:18 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] target/i386: Remove ra parameter from ptw_translate
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241013184733.1423747-1-richard.henderson@linaro.org>
 <20241013184733.1423747-4-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241013184733.1423747-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=philmd@linaro.org; helo=mail-pg1-x52d.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 13/10/24 15:47, Richard Henderson wrote:
> This argument is no longer used.
> 
> Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/i386/tcg/sysemu/excp_helper.c | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


