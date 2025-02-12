Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4137FC02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 07:25:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ti77F-0004dp-IZ; Wed, 12 Feb 2025 02:25:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ti772-0004bs-Nx
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 02:24:50 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ti76x-0002y0-NV
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 02:24:47 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-38dcac27bcbso289981f8f.0
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 23:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739345082; x=1739949882; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FRLeCSWBIVH/W4K3GexWn5MklPm6gk4UkMtlzRoCG04=;
 b=R0upp4ERNhg8r2qokx45Q+//E89OF7NB3ARWKLNKYC0A0t9jb8Ut8kd04KgMDG3PJa
 02Q53lFriGscZVQUqO+J/qV+sSdr+7PV6c9AdmgR806BMfmTxbF3PkzB53Wzzgk3TNDd
 8+p0QbudBewndabKXqCfgGrzjJH73EHrSPInX9TFUgz8sGiqnycJ2TtdUOoRSw/SUk7S
 Px9mZWJ+SMxaus4yv+E25lvH8FruC9Rl8PkSxOhcE73qeDAOm2asB5RVRcDlJw5fNLMD
 8bOlJeiKvSERAe5qU6yd6x1J2IQqcRnj5FH3hMcx46Nk8OX1krWx4iQ8PZ5xn0uahaCW
 yjQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739345082; x=1739949882;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FRLeCSWBIVH/W4K3GexWn5MklPm6gk4UkMtlzRoCG04=;
 b=tlea1qPBpVTbcp4Q5WtP8fb+SYi1kPLTgOV/gyB44OYO6YUKsXBKJBa1qLY6A9xMfl
 1K5jrOqsI84MoEzH6CQtGDPPk377Ib9j5gEEmF1KEdxUO3hWkgyJVThnDC6Pwo6D+3xF
 ejM1SKPy1XOtGHh1SMrA+tdP6zoHIE7/yrdSm4QiLdxkd1aJ7Ymfc36PcT2l+t9AxtT3
 tzTLqaeyeoCWttJEjZtDNVe6OuGqJctvvcgcVCIVoP/E+2pM6lLndrrHuPb9Upj599N4
 mmw26ETdM8iN1gXSW8oHmjodNvtPgDi2ALFQhOF8YrSxpVH7DHbeGtxw4tJmM0C33h01
 Aa5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXp83kMHTdReilh+XJcjvZNBAVdytCpvCO7MdLoe921GJ812Z34YALQTKLrWgoZsgLqiYhZOcckx6s8@nongnu.org
X-Gm-Message-State: AOJu0Yx+Ub00hJ+1Okfgy8DJAzy+HO0h7MKqXXspI6COZIgWezj2FDD/
 A2+Rtk2ir4shPKbujG99GnM+oXmGotUtLCywojoInCQHmsKcY1SCAcKCbBh3qhZzkldOwTKS8wu
 mKRs=
X-Gm-Gg: ASbGncsJCiz2u6SbkDjy4IMpfP+J79tyJkxxF2p2zj1jnSa2iVvA1XS6JIaEfa/apD7
 /ToFhAKz8H35Dw7M6ftmrrFmlcDBu7kO443PzA6Zwwgf4h8Ewntt8pinBk19NrItgeg04y6RFPR
 yzLutU3xGBNDH6tN1BKAfgME5rbGd4BhQq131fQT09Pzm5IX++zQHA3T2qcieiPjt2kdLDlG4fb
 3yGBaqh9wGt/oSyXh9TSFsSmDdvywHTtiNAPTE+v6oHRERS9vRwwwB/ZSqY3Vq3/dwJsO7isAMH
 ABB7jfco6vCRxuGKKVlhmbT6zXg0H+KBseNk8xyHo2lj9S12mfezMNR8bqo=
X-Google-Smtp-Source: AGHT+IG52041boup/UjvMnX3ZDAeRUxua4Rj23pjl0+Jlph7fCbKN74nPC30yjVHq5fFsALIVRAuvg==
X-Received: by 2002:a5d:6c6e:0:b0:38d:cc9c:630c with SMTP id
 ffacd0b85a97d-38dea1e10cbmr1269288f8f.10.1739345081972; 
 Tue, 11 Feb 2025 23:24:41 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dd02e2a90sm12626969f8f.98.2025.02.11.23.24.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Feb 2025 23:24:41 -0800 (PST)
Message-ID: <6d2d7ed7-c346-4844-bab7-5a7f947efc70@linaro.org>
Date: Wed, 12 Feb 2025 08:24:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/11] include/exec: Change vaddr to uintptr_t
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250205040341.2056361-1-richard.henderson@linaro.org>
 <20250205040341.2056361-11-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250205040341.2056361-11-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 5/2/25 05:03, Richard Henderson wrote:
> Since we no longer support 64-bit guests on 32-bit hosts,
> we can use a 32-bit type on a 32-bit host.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/vaddr.h | 16 +++++++++-------
>   1 file changed, 9 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


