Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E258FEDF174
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 15:36:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqvD4-0004wU-Tj; Fri, 13 Feb 2026 10:35:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vqvD3-0004w7-7v
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 10:35:57 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vqvD1-000569-Pd
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 10:35:56 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-48371119eacso9918135e9.2
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 07:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770996954; x=1771601754; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EBOQrH1WHnP/C9v5VCYD6DlR5yXq0b/B8cy0t9Q9vVg=;
 b=i8KfDwQLMa9okSFEjP6HE5ZBVCq9Pu7SjDUNN/yDvJr6NiNOVkvKLrC6KjCkNu1ktH
 dYNO/mfBb1TjOSSTOjMCTpgYLgpVunKuT/AEi2PPi1/xdbZcvV9bakVba4PT21k924o5
 t56BGZZcKU3YIh8XUSWmih8LjAiE+mm+R2i1q6qIzd9AUsBq9lRMoq8ClAeeIr0fAcxg
 pHIzSrG3rPldMEnxoXmyNdJml2ctZWpEGv3BM7WkJeKj8HyLXFG1WMDEO2sqFy5JSjoa
 3cTVTm/3K8cVqHU8teMiIXnAwsNRS4iGHuoCmST5OMtpz7FmvfU9hMg1OneLzsH4GYUH
 mMsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770996954; x=1771601754;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EBOQrH1WHnP/C9v5VCYD6DlR5yXq0b/B8cy0t9Q9vVg=;
 b=BdcyU+hy0h95gau4zqAEsQ/15NCfTa0Um32JM6ktTFO+B3dimLVFXAZonPg4rK00Fu
 g2IthJThkVWTgV6fHKtPwN2xfqFN0XOGq796DlrIeL8uw/vHWgfKiVd3O7as/Hw3fbJm
 VSMuwh8Wg1QPCYnLpBURww7JRVOjKMTthzJYH0boV8YjmI4CoqqPFh5h4UOyrmNWsbJ6
 37NnrPQBy1RY6IlA0kjjpep3Wj+5paZ8ocNG7jKUIWL3RrYMJe53lQ1Z5Q2SVbd6Li9V
 Ot9vqSIVaCB5OBx5F0TVzcBqQELlvGi5Xifx9zChikTLCOiNHUW/i6UvpeqFvu6MTfvL
 mxdg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgb52lJw0OG+cizSYo8duA1mmxhV1Hi+W4ThKpoBfEQ0C+bjHw37k+4s/zUOg1A/UzI6bwCQoCEDZq@nongnu.org
X-Gm-Message-State: AOJu0Yy/C90KEOaGFPF6RVvTw7WQbHTaQv+h0NfteoMBLy+vw7STy15N
 vjFDB6+iWtUftZtH3vyd+7hf8qLmaoUTSOgPw0tmViJ9F6AnGNoDjdNjGfZPqtBwRqjk75Zvb5K
 XX3DySl0=
X-Gm-Gg: AZuq6aJacKSIL7aPCHEC3DEMoq0hBWwKGLcSSC3VtAWBw46pvwKv40fWJ7KB8EuCCw3
 cjQmv9sVYsZgOPJVSybmh2oGsqIr3/20igq2VWyh3MBmdJqF6AUzaQb4kCym9tmS00n79HtCEF8
 6s6kARBr6Dm0WipweOy+i9+Tr8T6oJ2E9YNuJ+kaKRacu/1oRLOnCdzbaPs4X8c9ONl/yWti62S
 4JcfrReJqVZmOqvuIx6Xw0o4wugqWBcL7nXaGf5FsvATxNkvBV2SsltRQygNfPQ329XPwpGQcxF
 KvXp4xbXxk7Fyu7WgXLCZYvcINZ2bmpzOp/DF2Su5CWl8nSXzRS6Wkv0BuvSeA7ESigFbQqSRHP
 nPxeUsd7zKdmF8oE1DhfNCL7JZdE2F+rx45GB+wqS/PMnvMNZfxxqv3zPHxOCvDaEf12WPJ74gb
 FRLTUQk71xeW2Xjv0Mg7SEy9jkZYVf9lR1EY4tSZsa/bm1JaFD00u945uj1wk0CQa6xQ==
X-Received: by 2002:a05:600c:4e49:b0:477:54cd:200e with SMTP id
 5b1f17b1804b1-48373a08300mr38245725e9.1.1770996954108; 
 Fri, 13 Feb 2026 07:35:54 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835d92267bsm293118335e9.0.2026.02.13.07.35.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Feb 2026 07:35:53 -0800 (PST)
Message-ID: <6286db8d-4506-4ec7-bacb-3d42fa63a2d8@linaro.org>
Date: Fri, 13 Feb 2026 16:35:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/10] whpx: re-enable guest debug support on x86
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Bernhard Beschow <shentey@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Wei Liu <wei.liu@kernel.org>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Cameron Esfahani <dirty@apple.com>, Peter Maydell
 <peter.maydell@linaro.org>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260213034556.13471-1-mohamed@unpredictable.fr>
 <20260213034556.13471-3-mohamed@unpredictable.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260213034556.13471-3-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 13/2/26 04:45, Mohamed Mediouni wrote:
> Fix what got broken several years ago by adding ops->supports_guest_debug
> support as an architecture-specific function.
> 
> arm64 WHP doesn't currently provide support needed for this.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   accel/whpx/whpx-accel-ops.c | 8 ++++++++
>   include/system/whpx-all.h   | 4 ++++
>   target/arm/whpx/whpx-all.c  | 5 +++++
>   target/i386/whpx/whpx-all.c | 5 +++++
>   4 files changed, 22 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

