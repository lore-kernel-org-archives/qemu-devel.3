Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7283BCED240
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 21:27:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxvGM-0006lH-SF; Mon, 07 Oct 2024 17:27:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sxvGK-0006kp-Tq
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 17:27:28 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sxvGI-0002N0-47
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 17:27:28 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-71dfc250001so1464174b3a.2
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 14:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728336444; x=1728941244; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CqgDnhxYcJfnpmb7/gzzhepYKSy48HDyjJmQSXhkl3Q=;
 b=hIhYOSP22K5quLEdSUWsP5nPedUF1KUAvV3rbg22/Bh5tVR8LkrZh/fzEt3H0lybXh
 eTX5XJ0rXB8NTKlq0y7JIbXZEQoRdDDCYwRSTNhse8qOBRZtgawMerJzDyE+v6QA7Dof
 PAFhY2LB5E6MSsOlbcS8jNe0QfPeiq8Lqne+SSX5q1mRMQZE2bV6GkDt1GatAokTYV4x
 4wZz4iezJgE1kip2ytGn6AVG7PibpHUs0eJY9oG5KPMUSf6upGXtrRJCANgg5EpveEwS
 7t3rn+JEtWP5TUqHHc2XWHsrRftGczo8z3YJLzepx0gdyaw7skpsV2AF0Nkergmtlsv6
 8ASA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728336444; x=1728941244;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CqgDnhxYcJfnpmb7/gzzhepYKSy48HDyjJmQSXhkl3Q=;
 b=lYUaah9QJy9NX8RXYvO+JYRDw9cPpTtjXewDmFr+EnS+34Ln0Op9/BdmelDEcXQarr
 +u0CYPD4vmeopSE2vT7gmPxmcUHEEMj46YavSSJKNGY74KCOR7hAIJVI3wsvH8l5YPzA
 PEXz8qG67x/N1BodITyBFbTYGerIJj0RYxXk9t4ivquVpuwt7vyNR9aF7SgOs+wCl7mw
 0f8YS6XFmXzOkSQ8XgzLfJTUvONAdik8LU+VOEAXRGW8fpq8Lxfs/Tx3OrtKX5Tdd3Y5
 qiiYCC56qW7JOH/vC/pXL/yNR6vdzn8oN8AcHlobH925rLC2fK6RkjL9vrlQNmU1lS6O
 I3jw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBJUeGFitu19GxIIkc+JLo13QQ+8T9U+YpkkL99DcDVmq7G+aO2FQ1iuOdatJCVBV3vv2pSBzRlU7Y@nongnu.org
X-Gm-Message-State: AOJu0YwZkiccpYFfP0CRmOBC1UGabLY9ozQWUC8PwN8LfALLooGLrsOi
 hOSxCY/BoUo+1CKfrng76zQ/y9Ee0pVh+IhSmYLjlio1ObYkSXjfaSw/ItCcVdQ=
X-Google-Smtp-Source: AGHT+IFUSSiKDp/IPG9C3v8HSFzU/o5Dij/QuIbYEIpT+b52zosK/b8fiUgzmvLLH64t7gKuN+CCOA==
X-Received: by 2002:a05:6a00:391b:b0:718:e062:bd7e with SMTP id
 d2e1a72fcca58-71de24600e1mr20318300b3a.24.1728336444536; 
 Mon, 07 Oct 2024 14:27:24 -0700 (PDT)
Received: from [192.168.100.35] ([45.176.88.163])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71df0ccea54sm4890081b3a.68.2024.10.07.14.27.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Oct 2024 14:27:24 -0700 (PDT)
Message-ID: <a3f85304-e14e-42d0-b913-f551702ea6db@linaro.org>
Date: Mon, 7 Oct 2024 18:27:20 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/20] target/hppa: Add MemOp argument to
 hppa_get_physical_address
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: deller@kernel.org, peter.maydell@linaro.org, alex.bennee@linaro.org,
 linux-parisc@vger.kernel.org, qemu-arm@nongnu.org
References: <20241005152551.307923-1-richard.henderson@linaro.org>
 <20241005152551.307923-9-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241005152551.307923-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-pf1-x430.google.com
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

On 5/10/24 12:25, Richard Henderson wrote:
> Just add the argument, unused at this point.
> Zero is the safe do-nothing value for all callers.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/hppa/cpu.h        | 2 +-
>   target/hppa/int_helper.c | 2 +-
>   target/hppa/mem_helper.c | 9 +++++----
>   target/hppa/op_helper.c  | 2 +-
>   4 files changed, 8 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


