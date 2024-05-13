Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB2AAC25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 10:34:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6T00-0005KT-Sw; Mon, 13 May 2024 06:33:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s6Szv-0005KC-L4
 for qemu-devel@nongnu.org; Mon, 13 May 2024 06:33:35 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s6Szt-0002db-4A
 for qemu-devel@nongnu.org; Mon, 13 May 2024 06:33:34 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-420180b59b7so4108405e9.0
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 03:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715596411; x=1716201211; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=J/jPb7mL02Lw7CgzB5EqiNnA42gqjysYn2kWMDhNjrs=;
 b=qupkwgkzDc4AI+tMBcYrjO1VUc/1TXK14oRoekWyTesIl8PwZBn1IeEyT3ItZfE/6p
 rV8cIdBr8WpkWM4ixWi9U36QjnGjf0+klk5eJjLzJJbc2eTctnDE2YIUNPg1u3otZhX+
 BAnp9MQRHIpYpyJ2rHVNJJWWpuXVqFgM+3JEPAgfFzMNBfLDdwwsXrFE+2Rlcd52c2d+
 4tAgSMjIxz58PvhVEtCCsbMh5eqq8tLUl5TA7LLr8HCWVToGPFR+2fr5crcWZediRk6U
 MkQ2DLLSfGsg4Y6q7EX/yWniZ36IcScEZ67lS3FaTjLJ1PgE48bsEO3uBsI8GuRS+CsO
 R6dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715596411; x=1716201211;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J/jPb7mL02Lw7CgzB5EqiNnA42gqjysYn2kWMDhNjrs=;
 b=w7X7M2fMn6IikROF45L1QGISAZJjCUlJJOLiPR9FzbR2wH3VwJs1m9iAVkGZplRZ6x
 K4dTVpWJYhqMqtc6oNG0zrXhKZld0WKc5tN4VaXywhXuv40TlspnKNZBMfEBoDk+IsaS
 gfPBbA4R4fvmXmPsuss5wPy10U1YFNxswkoloS2zeyJhEpeCGTfivFduK32kQP3F2L+a
 hhWew4fdZVQil9qIdLkD4OjmtZ3ak2RyHVW255CwjEFOpZKTAOqG6S6xnH61LTcr128B
 ObfKdG1W4KOXeaXDKujReFXCuRpQGagX9sCgfyoHOm9k3KRqy+rWzNmvWxhmMzF9FHKk
 W9Jw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZJAfOaPnORPwwYmhmoVFK/q0zWpGGlvY0aBR92yK2lcWWLOoF5f2bc3pvfl3ohsCKNTPVa4lo7y2zgD8njAEQLSWgmec=
X-Gm-Message-State: AOJu0YyixybPSKIYnTRqUKIV1txAa9RoUwuYi3bClj8qR+D3eBimfwfc
 Q5lS/vw3ed4jXdgUiMH9/VAnDRkiLa0JkGTDKb8ws1XIpnunVXFyO98Hc+GRKa8z9K9TwdagMrr
 ybuw=
X-Google-Smtp-Source: AGHT+IEn8oSKhoxmej6eqzE7yIFg88vscvEmnz5rLPiSXrB96gpf/pEpbCbTVA+F2ZbNlpcD/ZBPrw==
X-Received: by 2002:a05:600c:3589:b0:41b:aa11:29b3 with SMTP id
 5b1f17b1804b1-41fead697aamr64929995e9.35.1715596410923; 
 Mon, 13 May 2024 03:33:30 -0700 (PDT)
Received: from [10.1.2.72] ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41f88110fedsm189372405e9.31.2024.05.13.03.33.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 May 2024 03:33:30 -0700 (PDT)
Message-ID: <4dfba13f-67af-43b5-9baa-1383150a8972@linaro.org>
Date: Mon, 13 May 2024 12:33:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/45] target/hppa: Always make a copy in
 do_ibranch_priv
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: deller@gmx.de
References: <20240513074717.130949-1-richard.henderson@linaro.org>
 <20240513074717.130949-17-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240513074717.130949-17-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 13/5/24 09:46, Richard Henderson wrote:
> This simplifies callers, which might otherwise have
> to make another copy.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/hppa/translate.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



