Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20A8ED232E8
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 08:02:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve7Rs-0004KE-Bu; Fri, 09 Jan 2026 03:02:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ve7Rp-00049R-8A
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 03:02:19 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ve7Rm-0006Iy-CD
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 03:02:16 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-47d63594f7eso24132805e9.0
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 00:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767945731; x=1768550531; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wLPJbCzip1NseTTMZm/m+PIkt/cEDYmfF2cWEm/RX9c=;
 b=AqeVY5v6iUhBQwPPzOpjcMxppq2r//nBvzUo6U19zBbeGEGoP+f2b04a8892rtwmP7
 XLTqNmtkWKemW6IdJAvKOxQ2adnyhSXVOCnL35G7HgCuJcTmsha3e02DTJZR/yNnmxPU
 MktKemgthLh7FhP8QBq5DJ/2eFBOoxbu/Q42vfUTuKF4272+LEC8JJo97LnwwwyzzqS8
 K1ll5HVygV4y9lEpZ+MdZi8/+i1rHoOFkKyeOFhn4RAYkEqpJYcZlf3XtE/XbccJ1s7r
 ESP6qtl9gjYxaIG+XGfHPNbRnVxTUb6iNuPySoZOciTq1u5RMHfzfYMmYdJZLtMKyVMv
 agsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767945731; x=1768550531;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wLPJbCzip1NseTTMZm/m+PIkt/cEDYmfF2cWEm/RX9c=;
 b=iVIQcKqY19uPMb6M8qSaHvgtQOpOXWISxwRz3AiM1qeUIL0CnhLLI+QghFq35PVKdk
 6WyAnYuRkSg/W/H3HBguqhGVsiEtBXjdU4IKQSvTqkp2tUaIVDxCQho9l0YTWyMs1UhH
 5A6PzGkYZrFF3cOdtgGZ8kj/ngr1CFg9OA5F97KYlDk9QiUQw0tJsybgAzCPr6RLOjI1
 e5OeFq7/xmOmYTg24VvjVOidIoHomFbmLXV+POgrV2iCZg7q1cVI0Rt/tVEDLhtzVfR2
 KUC8aS9TscRPDspY7S0KlLT04J6Ll/xGQ0ijJXQmXfdaS+ObmUH8Yr5Pe1b4f8cmjaJs
 wAAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFMn+jyAbYYjns//UukdBE5OeEy9/VmU4s+cXwbBGfnOfVeLeNvFQmKOq1tNZ80PuTue+7MVgzDi/W@nongnu.org
X-Gm-Message-State: AOJu0YxDzs7uvurGjdXj3jj3XUu25kHKBYUC4LV/yU7cPsmo4tZ8Ie2U
 40HWYQ/o1LLwHJz61oHHRbrnHG+qJugOhHNLtuOXFruekEeog8DCPnH2KfoegobUJfg=
X-Gm-Gg: AY/fxX49oFrPXxX/Of9HIjSu1WfMT+Onl2TD/V6eWMw+il7LVp5ZDQAf1tLBArOs/Y6
 /zOrxZ6mHuRbwLPhg6g/H69T6wyj5YVI+PWmOeVvxJvYAR5voBKKwUiQFFq3qMtY++c9LzQOGDi
 U9YGyZQodOKqiw5k661db9YfNTozZFzFXme60xYKX8mlWSvAgUKQio9OtB9J7GB4O9lnGdwGBd8
 TjqzUREj25TDj3xwaAo/eBKauS//nRCWfRTjVa/qbVXjAmRo5TSNyrcua2pNuKdPm9g/tUtTrjC
 FL/XM8kfbzfhJ1mEscEaTc/+139o9L/7MdVT4b4h5VK+X1ib6/Zt0l33grg6ZA5VdzhOtQyexDc
 61oL2i4Lpo8KLt2+FrT+8vX1UVtAOOGzizOGGm5Jv7siVE3lWxhun/Dx/4JhX/uLi7Y1hvXT2vt
 D9GDn14Ofgqvyvt13SY0damvEOjxu9fEd2uD2izKA9rs5DZ+OMesXaYQ==
X-Google-Smtp-Source: AGHT+IFL4t6RE3Bv6D4RVdEFKwVAqMpYkz3T2tpAfd5uCLgyh4oHkqMxrL639k346SV4FSDk/XwzBw==
X-Received: by 2002:a05:600c:8b2c:b0:477:76cb:4812 with SMTP id
 5b1f17b1804b1-47d849bd639mr93949285e9.0.1767945731597; 
 Fri, 09 Jan 2026 00:02:11 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f6f0e15sm190166495e9.10.2026.01.09.00.02.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 00:02:11 -0800 (PST)
Message-ID: <347ae217-134a-4181-9a31-c5ff8c83d7f7@linaro.org>
Date: Fri, 9 Jan 2026 09:02:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/29] include/tcg/tcg-op.h: introduce TARGET_ADDRESS_BITS
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Jim MacArthur <jim.macarthur@linaro.org>,
 anjo@rev.ng
References: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
 <20260109053158.2800705-15-pierrick.bouvier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260109053158.2800705-15-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 9/1/26 06:31, Pierrick Bouvier wrote:
> This define will be used to replace TARGET_LONG_BITS in tcg-op-*
> headers. The goal here is to allow a compilation unit to set explicitely
> which variant of the arch it's targeting (32 vs 64 bits).
> 
> By default, we simple let it defined as TARGET_LONG_BITS, so existing
> code does not need to be changed, and we can progressively convert new
> files.
> 
> target/arm/tcg/* files are cleanly splitted between 32 and 64 bits (with
> some TARGET_AARCH64 defines). For other arch, this is a work that will
> have to be done before converting them.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   include/tcg/tcg-op-address-bits.h | 21 +++++++++++++++++++++
>   include/tcg/tcg-op-gvec.h         | 11 +++--------
>   include/tcg/tcg-op.h              | 22 +++++++---------------
>   3 files changed, 31 insertions(+), 23 deletions(-)
>   create mode 100644 include/tcg/tcg-op-address-bits.h

Nice.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


