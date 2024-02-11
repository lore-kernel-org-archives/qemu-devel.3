Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FBB5C4829C
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Feb 2024 00:30:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYxj4-0006Td-Mp; Sat, 10 Feb 2024 19:29:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rYxj3-0006TV-2y
 for qemu-devel@nongnu.org; Sat, 10 Feb 2024 19:29:41 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rYxj1-0001Vf-Ma
 for qemu-devel@nongnu.org; Sat, 10 Feb 2024 19:29:40 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1d73066880eso19854595ad.3
 for <qemu-devel@nongnu.org>; Sat, 10 Feb 2024 16:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707611378; x=1708216178; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EoECAKShEinauTNIiDXdDSm28uuGirZCGhxydM3IWG4=;
 b=tdzHuL/hdOXHu8UJBz52E1H27Yvz1dSi7F92w3TEgG4ZE8as7pzbQp2I70pnXyltyK
 Zo9ZLG2gwPXz6A2eBctBo9mcauJAbAxbUWkmGgY4NWPQkeoNKGx/GOeSE+oZYLI2NMpU
 YHAVpHT0S+Q5SIIEJsUK2fHL+5b8jvdruYN5rRqdNLCSOU8OmTZWpuFmG+OOhSuswNBz
 ClOMWnOtii0Ma3K6reh3kp039rQbYzbtnJzBTV2BOyL5aoNVBmg8vqGIPp37oQBG5DM8
 kOPXonQKroKGL2bi8T1N9oDkVH4Slv0VchLAMohzHgheujlALnOcrylGSQcqtRMIetbr
 T4Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707611378; x=1708216178;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EoECAKShEinauTNIiDXdDSm28uuGirZCGhxydM3IWG4=;
 b=fOFEt0cMFzJhRKdA5KWVpSPVOb/pvnqkovUbtNvndDHYTFuP1ihmB84bvAP+7vkZaP
 lIyJIRDRVvo+gsSVW1kx0Hrx7+B026Rg+lTxtKAOE5syR98/qmZ9UrD96lNN7jr0NXDN
 L9EaqXZa+/W+7i/8pz4Fvs4JFT+nm7FqmKBLnbIqm6PbTJ5sQQSrVLhcas1Lg/XK3oUt
 EZdLkwjqcz7rCBqBqaEz3bQRlC34pbSmsEUUUQAccizjRtdgIbyvYRcN8elmAsra1tiR
 vsDU97XgeGjOzPGVkGtC185oDHmJj70N4dIoQ8WPPfSS4W6Sld68oGGWmx3WzfCxpB0v
 P6Rg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcSoChjHfreEbUgtPAt6ZLxEnMmVXa+BzVd6Xft5BNo4RhGfyQFZQn76giRHia1/ovwJ5QQmTHDkGzMU/ajaZarcd/9NA=
X-Gm-Message-State: AOJu0YzQygmZh3zfr7TdpzeIQDItx+2nAftX7T95KaNreZCpNygP3PA+
 1RNeOhMZKF0cPAIM82ljfUKR6YdNFUw/nPc7ssiXw+25W7AKn/LocUE5bpdF9Og=
X-Google-Smtp-Source: AGHT+IFHBOuuzmfZQbVPrjOry7mb/kDCJeRpxgWYTGRNzZ+W55WTfVSe5jK6Ee+JMr1IKAFUz9Ylrw==
X-Received: by 2002:a17:903:1110:b0:1d9:b6a1:1fe4 with SMTP id
 n16-20020a170903111000b001d9b6a11fe4mr4600173plh.18.1707611377835; 
 Sat, 10 Feb 2024 16:29:37 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWliyjN6s8M4RLa3rECTrWbw0KdnkDK96Z+OuZlCXKUPPNHJqxQn4ceIdCHP6lYCgTcTzpODeEv3GE56ZE++PepdsYeoGHzSC/NfNBM8XOGct9ZeyARzYui3stM5xWmr3B2OeWmKkMbV2UDOrjnki3oQL4jmDyMWXKXPuGRMw/R8MFD+hLZgzK5WOnz+WTJl9ogAIvwU+kXzpbwp5sYxQuPNyne5CL4EWjwKZ19/ChE8NkTIm34XTuhkKAEi8dY27I9ds18n529cE7B4hy+V2uem6OW4FuIr4AJd56+CigiZ9oS++xjdhYW/ccKrw==
Received: from ?IPV6:2607:fb90:bde1:38:fbe0:8943:a8ed:9394?
 ([2607:fb90:bde1:38:fbe0:8943:a8ed:9394])
 by smtp.gmail.com with ESMTPSA id
 t11-20020a170902bc4b00b001d6ee9d8957sm3502695plz.281.2024.02.10.16.29.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 Feb 2024 16:29:37 -0800 (PST)
Message-ID: <f3457ee9-6228-4230-bb9c-6d43a478190f@linaro.org>
Date: Sat, 10 Feb 2024 14:29:31 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/11] target/mips: Remove I6500 CPU definition
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Laurent Vivier <lvivier@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Huacai Chen <chenhuacai@kernel.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
References: <20240209090513.9401-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240209090513.9401-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 2/8/24 23:05, Philippe Mathieu-Daudé wrote:
> Philippe Mathieu-Daudé (11):
>    target/mips: Remove helpers accessing SAAR registers
>    hw/misc/mips: Reduce itc_reconfigure() scope
>    target/mips: Remove MIPSITUState::itu field
>    target/mips: Remove CPUMIPSState::saarp field
>    hw/misc/mips_itu: Remove MIPSITUState::cpu0 field
>    hw/misc/mips_itu: Remove MIPSITUState::saar field
>    target/mips: Remove CPUMIPSState::CP0_SAAR[2] field
>    target/mips: Remove helpers accessing SAARI register
>    target/mips: Remove CPUMIPSState::CP0_SAARI field
>    target/mips: Remove the unused DisasContext::saar field
>    target/mips: Remove I6500 CPU definition

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

