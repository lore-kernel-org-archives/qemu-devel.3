Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A524C46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 03:30:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSTy2-0003Ts-Hn; Tue, 23 Jan 2024 22:30:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSTy1-0003Tj-5V
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 22:30:21 -0500
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSTxz-0004HQ-JU
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 22:30:20 -0500
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3bbbc6bcc78so4055964b6e.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 19:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706067018; x=1706671818; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=x/YI0aB/PdbV1/lqX0DBiaufc2+crh/Irvh0WQVv2dU=;
 b=tbz/hgGgXrydLJ5+Q9YzEy4g6n/Lpe2jK+uQiLAvE+rmQJxWid3KZ5P15T5QQbv9ap
 JFV2jFx2h88oXndCp31QhEwThXNkjJ2plTRAj+aTwrscFOd5UV0GicYe+pNIr0c9L++V
 FoLdesqzkQ2KZzfLCSEIIoRGviyTrEFqGk7NFO3QrxQgaq+qUwyTfgGtV2QmixHQ97gF
 3anekjINGcjnixYy9mCmB5DqJlZY+TJj7YEyxBEcAeZUJZGQhwqrepP9ZjlIEZtW+o5N
 eNq9Q/+yk6UgJ/yfCUXAiqgeO+lZn6l0z73e4eoTz6ggoBnohzsAeqCLWLH4CbqxM/X7
 Wjvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706067018; x=1706671818;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x/YI0aB/PdbV1/lqX0DBiaufc2+crh/Irvh0WQVv2dU=;
 b=DX7Q6Jek5TZn5RCTeUITMl0urPMWqReASZyhTWHsjb4S82brb2QSVm9NtN/an+6zVt
 67Qv1lzOQ0q0dr6Xs0TcMBgdLSotYGiv5JIR8RlKOGz5W67NzZrIeE0/py0j6ttE0oHn
 nFk3AnZ2BuVSFT9yuKULrIB/98PnyPMPC+7SbdHQzAjEMqBzsHkfAfLJsrHoWc3UR3KK
 Etaza1z/erJuA5xTjhhvqZM58W4outxQ+ajHzZuqDIEmQ+JyW/rSCJv4lK+tTrIY3d66
 JkljeFiHxTj0RyjaWlIpDLXc2iuPkMNJtAt2l0zPrIbPMYYxRLrvcgAY5d2pb3O6rwJa
 0K0A==
X-Gm-Message-State: AOJu0YzE3aM7DPFF0wK2tWE71dWPOwycwRAupaPO3fXHCZnd65xl+J1z
 QwuZHu+zE2YkML/0Lxl1JrcGjwC4bKg5KWSCHUHxVXl5mDtSgBQuZu+CLWeaTbA=
X-Google-Smtp-Source: AGHT+IHyMSz2WBka69Ru7D/TI8SxA0h4RG4qtdPJQpeAzWC8QYHUjbLyyfGiouKvCikV5earhBCqnA==
X-Received: by 2002:a05:6808:bd4:b0:3bd:ba63:221d with SMTP id
 o20-20020a0568080bd400b003bdba63221dmr996295oik.79.1706067018131; 
 Tue, 23 Jan 2024 19:30:18 -0800 (PST)
Received: from ?IPV6:2001:44b8:2176:c800:dd1:291f:3c3c:2485?
 (2001-44b8-2176-c800-0dd1-291f-3c3c-2485.static.ipv6.internode.on.net.
 [2001:44b8:2176:c800:dd1:291f:3c3c:2485])
 by smtp.gmail.com with ESMTPSA id
 sx14-20020a17090b2cce00b0028ce81d9f32sm12768401pjb.16.2024.01.23.19.30.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jan 2024 19:30:17 -0800 (PST)
Message-ID: <ef4a3a8a-66b2-481f-b87e-68b5212c7ce7@linaro.org>
Date: Wed, 24 Jan 2024 13:30:12 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 33/34] accel/tcg: Make translator.c (partially) target
 independent
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, philmd@linaro.org
References: <20240119144024.14289-1-anjo@rev.ng>
 <20240119144024.14289-34-anjo@rev.ng>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240119144024.14289-34-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x232.google.com
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

On 1/20/24 00:40, Anton Johansson wrote:
> Make CPUState offset calculations target independent by using that
> CPUState and CPUArchState are statically guaranteed to lie next to each
> other in memory.
> 
> Signed-off-by: Anton Johansson<anjo@rev.ng>
> ---
>   accel/tcg/translator.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

