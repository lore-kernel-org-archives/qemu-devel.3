Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82B4DC47258
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jan 2024 22:30:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSPHA-0001YD-Al; Tue, 23 Jan 2024 17:29:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSPH8-0001XY-ST
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 17:29:47 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSPH6-0001X8-P8
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 17:29:45 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1d75ea3a9b6so19743515ad.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 14:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706048983; x=1706653783; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XKLK09p76OFrlEMEdT0CRSC/S1YG67lzO9BeYJfSxP4=;
 b=cITSfz7oAqFfPDtZL4HZKCuuOgN7LcDP1yrLwhgQqDqDU5qPE5LEWztiZuPJn7cluW
 Qmiqf73WjlgR3CQmQqYIyn6G2MvdcZS5E/Zz0TtjDtAoiaN+4rNZ8jzuTRwQpEXEdQKK
 P1tUSBgJQ21j16bx8aPP2PYsyB0h0mfgBN/Qiu7axiRTjBzQxpf3fdtTKR1A1ygBvZUT
 XGSd/BfHC3gHRV2tyb0jV/aNo0zVguhtigtyp+M9h3nGei2q6SpFGF6ErkIKncvAU402
 rFlc/hzF5q/9PreUo6dG83hCTfE5NRUcnFIfCFZrvUveB5dgJ92wSTwAZTRKqPEHW6BO
 AsEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706048983; x=1706653783;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XKLK09p76OFrlEMEdT0CRSC/S1YG67lzO9BeYJfSxP4=;
 b=BDrr3sZk70O7CENgF2E1pn9ocyjWwbCZ/kkL8KPYDd6W48Z5x6AbjXqwyUPBXCFQT+
 B9QT9n6JdkaT6H67rchsyW0hT/CcSKuoFJlr9o301VI209YQuHdGP4sZpKfjxc+3KJXc
 ppu/7syPJmqLevy6fu1rmpIIt/UvWDddBiz7YsBGcCuX1kOcXMIrbVT/29zqaMDVNeud
 jS8DgdikgPXsH3MtpDAVHEt93snQdgpfs1W6Q9NDv+Sb/101TewEm349EP5LMvedXbNY
 hMDzR4WxEIgQ1AF6h414NWLeapNrvwaqLXSjeYCZ0q4zyhcQxo+eH8N5JPWabF4H+iV7
 tiwg==
X-Gm-Message-State: AOJu0YxxRyOhVEollKC9aAh01q+lPlJk6qVNuG8hD4HPHXeboMtEAQi1
 tmOy9hMxKd5eVQHeESC8o1ikE0wPXcOShJhnYj+11qMfzkf9tXKasVTotYrOEXo=
X-Google-Smtp-Source: AGHT+IFZEUXkypx7WRHm/qoWLS+CvvvwcxwyRNfRoi0tOp8EbRu0oaUrabmyYDilTvpmnppfM94Dfw==
X-Received: by 2002:a17:903:2305:b0:1d7:17e6:44e1 with SMTP id
 d5-20020a170903230500b001d717e644e1mr8656109plh.73.1706048983242; 
 Tue, 23 Jan 2024 14:29:43 -0800 (PST)
Received: from ?IPV6:2001:44b8:2176:c800:dd1:291f:3c3c:2485?
 (2001-44b8-2176-c800-0dd1-291f-3c3c-2485.static.ipv6.internode.on.net.
 [2001:44b8:2176:c800:dd1:291f:3c3c:2485])
 by smtp.gmail.com with ESMTPSA id
 v7-20020a170903238700b001d73702e0b7sm5357798plh.212.2024.01.23.14.29.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jan 2024 14:29:42 -0800 (PST)
Message-ID: <d7493d88-45ab-4bd8-b8e3-89e096ba862c@linaro.org>
Date: Wed, 24 Jan 2024 08:29:37 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 05/34] target/tricore: [VADDR] Use target_ulong for EA
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, philmd@linaro.org
References: <20240119144024.14289-1-anjo@rev.ng>
 <20240119144024.14289-6-anjo@rev.ng>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240119144024.14289-6-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 1/20/24 00:39, Anton Johansson wrote:
> Prepares target for typedef'ing abi_ptr to vaddr.  Fixes sign extension
> bug that would result from abi_ptr being unsigned in the future.
> 
> Necessary to make memory access function signatures target agnostic.
> 
> Signed-off-by: Anton Johansson<anjo@rev.ng>
> ---
>   target/tricore/op_helper.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

