Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB9B2C52D7C
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 01:56:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1se3Eo-0006gs-NE; Tue, 13 Aug 2024 21:55:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1se3Em-0006dt-3Q
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 21:55:44 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1se3Ek-0004qm-B1
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 21:55:43 -0400
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3db50abf929so4487278b6e.2
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 18:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723600540; x=1724205340; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rEzRA37auQQgy7VMIIOgkwnZ5mNeTU3fq31TXk/HhIA=;
 b=ku6TpqyvB8e0PEKNwTqBIloKZ4QvZZfC2TtZ14CuZTT3gAj4EkAQrd1HJezAX9Ld5Y
 EFiMGBHfs2+7GRV/gFwT5C6YpQ6ArjZn+FV7eV4M40krIqpF/3A0CZs0Q4Hdcfone5FG
 276mG/jOafvsGRBBRnPBz+KBE4v6HGCD+ROaElKnpP859XbDh/gucJOl1lxRIr8KDH/p
 5KviTynCWXxs1jkiLhWB1nz7urUfG7tSqK7E62q6hPrav5NdQ4KI1TYGkWcs4hDKDxJE
 i/zgssa9oLusOfBxZPMTwBsbrzk+EhXseF5P/5ejLTuJxkLgqLL9Q7M82L0E3BzdH279
 92AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723600540; x=1724205340;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rEzRA37auQQgy7VMIIOgkwnZ5mNeTU3fq31TXk/HhIA=;
 b=gJQtYDiAwkpv5siSsBZzs+PbpaddoJIAaAFOpxRKiMQh3AFPxgHGxBgyVYm/p3pgFy
 +aVo1KVdJe7xfTr2WoA5sAhfMmDEGk7MzX48BaALO0H9irTHZcjfdTfnVQbGlaaE2fGr
 3UAaPWM+v+I4Gge+h94Q251LPCSH9C2jPOnfUvsutbpknI1Fky44gHGpyMjyl7oFguxv
 SgtdEARozuTfa2Qm8g0Yf9qdZ/q3QXWBYz1cVefWTot83S1Z9G8QP45ssAwF5DHLaoYF
 DFiCEbcy2BZQfCofTTNBGr6wrLy7gqDnyfKbdn17AeipoqXji1YlJoeSsFopHeqODEbh
 hVGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIURLGUux9XMljP3nGObgqw9SQmlSBl7Tl0r1FNhUaoPQz3etQIvdUegsWMnA7Q4AAOwdA2u4Kow2bKKsDmubR/Ux9TTs=
X-Gm-Message-State: AOJu0YwGEitJzk/w0au6m02ru04uBJC+faE4I8pD4CCv8V9z/0xRX4YG
 ljyWnX262HgG4Jsx2rV47DMGY/ksZ/Z1dRq51LO5kKr5Qyj0jm0yHZ25eddc/rs=
X-Google-Smtp-Source: AGHT+IHFiHuLSyFZrjl4djsPKdMtszCDKNNy3EDdAjHA0M/I4oYsN/xrtrt/I7AklcHiwe6b1fTLWQ==
X-Received: by 2002:a05:6871:814:b0:260:f1a8:a64b with SMTP id
 586e51a60fabf-26fe5aaf81dmr1729587fac.24.1723600540118; 
 Tue, 13 Aug 2024 18:55:40 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.111])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-710f65cddd7sm4798228b3a.72.2024.08.13.18.55.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Aug 2024 18:55:39 -0700 (PDT)
Message-ID: <1d3e1536-9d74-4abc-919d-f28195e0439b@linaro.org>
Date: Wed, 14 Aug 2024 11:55:34 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/21] target/i386: allow access_ptr to force slow path
 on failed probe
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20240813202329.1237572-1-alex.bennee@linaro.org>
 <20240813202329.1237572-8-alex.bennee@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240813202329.1237572-8-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x230.google.com
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

On 8/14/24 06:23, Alex Bennée wrote:
> When we are using TCG plugin memory callbacks probe_access_internal
> will return TLB_MMIO to force the slow path for memory access. This
> results in probe_access returning NULL but the x86 access_ptr function
> happily accepts an empty haddr resulting in segfault hilarity.
> 
> Check for an empty haddr to prevent the segfault and enable plugins to
> track all the memory operations for the x86 save/restore helpers. As
> we also want to run the slow path when instrumenting *-user we should
> also not have the short cutting test_ptr macro.
> 
> Resolves:https://gitlab.com/qemu-project/qemu/-/issues/2489
> Fixes: 6d03226b42 (plugins: force slow path when plugins instrument memory ops)
> Reviewed-by: Alexandre Iooss<erdnaxe@crans.org>
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> Message-Id:<20240807160236.2478459-1-alex.bennee@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

