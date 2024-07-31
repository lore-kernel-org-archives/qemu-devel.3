Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B97A8C3DA64
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 21:51:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZHDj-0008Jf-UP; Wed, 31 Jul 2024 17:50:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZHDX-0008Im-FG
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 17:50:44 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZHDU-0005pP-B7
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 17:50:43 -0400
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3db14cc9066so3868741b6e.3
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 14:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722462639; x=1723067439; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GSCzhNRZuHQJAAGzM+2Htn4CgF+yNDQ9knZUK4QAgXA=;
 b=ahCwkoRkP6TQZQ+ZJJz3hlvmNSAz5zc0tRRL7TjkS6/Ux7Lq+Ax52d4aEdHH9evShV
 b174YvPIKGb8ACqyhuuYEssHMvvHM7eyUNw7eQXZoQhipElsUEWMXVe2E80SRjFTRwUr
 NA7d12dMIUcwJRiLV8S4hi2LlQqf/OJ2gTtrv+sMCUfbblYzMWCr6PFTJx6c8jidHYXm
 jkdzX5U1cg6Wu7PGG2x+sdWUnR07XGkpy7kP/Tzu3x4FreZNzEX9c3A/vfRLkqdPzhWb
 cLDdP6vt3JW6U2WkdseMlrPLs3cuyK4h3AaECNLFNmn4L1XZ3Pi8ZeQm1KqC22WniTUG
 ptdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722462639; x=1723067439;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GSCzhNRZuHQJAAGzM+2Htn4CgF+yNDQ9knZUK4QAgXA=;
 b=vkrcxSpR2qOndydWcjri1IKW9dLb7Paa58lyOWerjbk/+G3UyGSBqk0VD/B2AD/L4y
 Yz44GE+9T+y/Jey727AAySLprJm8aDWZBTLGC7IzzBSHzgC3WY9afwhO7i0x6NTTdfqI
 Fgl36yz2BdESDjgfHp2bTmsBRp6PpASXSPodgAJVVxC18gc2Gk4pM2nO76pKmRww6VZH
 PguPu1BL/Y0/GDtQDDvfqJyOuiDpS2kK0e3RockpDVrYCdph0qA6y2vSdt9cNpCazo2m
 QTFWvaNT1wSajAEJAObN/6EcX1DN90eHV0UvyAbaC5tHkS3X68Ge71zwGlY+mAAhY4Rn
 lWyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLDd7qEv0xDo3NHO8vzRIyekkjb//asrC4nn/tXL+YLe+NVIbmfIKV9XOBj91J3qlYPGUdeRfP8oM75Z+V8gkFLwM3/uo=
X-Gm-Message-State: AOJu0Yy1k1Mzbm8Tut3eTB0Y+EuDWfEvucDiwaLsKdxiECOvxC/PF7/t
 sxWXGAbobuCNp5fnSZxqb0f/+JrZPvcd/PnLm+XQkOMNxi6jCu6TEY0yDf+NSOo=
X-Google-Smtp-Source: AGHT+IGRz3LMAKGNWUQ2S12cU9xCRUs1/FuYAg79YnhceW9qeNj0TcYEVNJGLn7m3nD8Ec80cbvnMQ==
X-Received: by 2002:a05:6870:e312:b0:25e:1f67:b3c2 with SMTP id
 586e51a60fabf-2687a3bf1abmr467112fac.1.1722462638626; 
 Wed, 31 Jul 2024 14:50:38 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7a9f7c6fcefsm11102884a12.1.2024.07.31.14.50.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Jul 2024 14:50:38 -0700 (PDT)
Message-ID: <4c0aef28-5ee5-4f97-8768-01d61abd558a@linaro.org>
Date: Thu, 1 Aug 2024 07:50:30 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/5] qemu/osdep: Split qemu_close_all_open_fd() and add
 fallback
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20240731084832.1829291-1-cleger@rivosinc.com>
 <20240731084832.1829291-3-cleger@rivosinc.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240731084832.1829291-3-cleger@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x236.google.com
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

On 7/31/24 18:48, Clément Léger wrote:
> In order to make it cleaner, split qemu_close_all_open_fd() logic into
> multiple subfunctions (close with close_range(), with /proc/self/fd and
> fallback).
> 
> Signed-off-by: Clément Léger<cleger@rivosinc.com>
> ---
>   util/oslib-posix.c | 50 ++++++++++++++++++++++++++++++++++------------
>   1 file changed, 37 insertions(+), 13 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

