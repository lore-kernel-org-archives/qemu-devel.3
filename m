Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C468C54ED1
	for <qemu-devel@archiver.kernel.org>; Sat, 24 May 2025 17:21:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIsYf-0001iE-BI; Sat, 24 May 2025 13:21:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uIsYa-0001gh-DA
 for qemu-devel@nongnu.org; Sat, 24 May 2025 13:21:12 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uIsYY-0007Np-G6
 for qemu-devel@nongnu.org; Sat, 24 May 2025 13:21:11 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-443a787bd14so13650695e9.1
 for <qemu-devel@nongnu.org>; Sat, 24 May 2025 10:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748107269; x=1748712069; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Be4+7hek/QsHOyqxzJeZCEJHPLxeI3xnrZdwFnJ+qSI=;
 b=TkOISN+coVwxbacFGevmphsCwCbfGoWQ55R4079wEzpRQuLIiFDTiPX3WSHjLYdhYs
 D8ewfaVYg7Z5okX/X5RlN7RZhd/apK2A5BrFnm8mwbhAl4V5nBzItZzpWPoWxMqE2ZF1
 arK/QIsJD1PdFz09aqor7cOyGnCXo4dQJKvIbksMCwK+aCRhfvFO/8pOgSxyP/2fpiCR
 TdQC/x3JIGQKRaC/pZoySa0lPYIV68bnPsfCWVnn3Kp3mqVFLr6ynLFb64gg9gU/8IPr
 hCC08AFt2y7+CI+Aje543VF6jrbCMrXxVxmndD1dHvfFtJxJ8WqpXLXCYP5laxHxFgBG
 fk5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748107269; x=1748712069;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Be4+7hek/QsHOyqxzJeZCEJHPLxeI3xnrZdwFnJ+qSI=;
 b=A3xwdRJlu69s49zBDzx/2UqEY6Q2yUycSIig5pnU35wwvpPzbB36jmCSRdP3sRXUzc
 ryL1x2BGqIgIJ2jCyhorapp8prgAjCT21g/eUpQDtx8UtLhwVLzSU96CvACwE0Esi4JZ
 BXXIVVnnsznVbn3qIAWBzYeeHrogU1XU/IdLQvZzYiDFlLDSo3i7ABe+NXHm+ZJ0Vvwv
 QKyAp5cyUjQfvrBqcmxaDQCGsZNDGdPGij17JudIaP7TVTuHxTb0jwHAfU0AGoUfuGEs
 id1xTLpa9erqaH+ykERfDZsO8trWCDtIcIijloYHu5eiGQo7rmRMtcOvBSoevu0lbnh9
 WvPg==
X-Gm-Message-State: AOJu0YzwcDaTB3+2LRgcL4Ya4rK/jA1awFgfQm6JyDVTpBYZxGMmCBsV
 fOPnzFuLCuAR7Oyr1YaZeOmuS/cll6gbfxZ3+ORmO+5MRORETh/HuNDaQg099xOwFv2naCv+eHR
 rEYejZRrxRQ==
X-Gm-Gg: ASbGncvygr+DVgP/lQPX0OdbEE/UZl1SsvHSB84BwZpicPPARRvypev3K2KiOSos3R9
 csHEEkfTPvECxy4KcR/lZTokAKBKRN4DCkQ1bCi8i7t4cu3VMjP3bJ4rgruUtfhOJusGQhBHtQr
 RuoWRCbLpGNNw0iCMTUjDVd7mz9dMTLUn049jqrKgxM2lB1QbcqDGOhq0wjHa5hl4FUfQ4pWnGz
 dLGa11DEBRz3LlNYq9s3sFPUL3p3YqSQe329Kacg4BGkgHQpedhKJMsfRy5upL5DnRs9hAQmXR4
 lYaZmwTBjM3dEuBi1gtcRma/bXKiHD79oX013QsYm9lQmdYmvZ/dciebViwuDmpF1g==
X-Google-Smtp-Source: AGHT+IEKCkpUyZqCR3qzM/3FSJLSKAXmqkrHH/j6fe87+Vq/fq3qDhx6GlR1t8TH0QLuVF2j6Ff6WQ==
X-Received: by 2002:a05:6000:430c:b0:3a3:6915:33a6 with SMTP id
 ffacd0b85a97d-3a4c1558debmr7718989f8f.23.1748107268902; 
 Sat, 24 May 2025 10:21:08 -0700 (PDT)
Received: from [172.16.25.47] ([195.53.115.74])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca4d1basm30706030f8f.15.2025.05.24.10.21.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 May 2025 10:21:08 -0700 (PDT)
Message-ID: <b9e67190-9cab-493c-b59d-c61cab1e77df@linaro.org>
Date: Sat, 24 May 2025 18:21:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 12/25] target/microblaze: call plugin trap callbacks
To: qemu-devel@nongnu.org
References: <cover.1747666625.git.neither@nut.email>
 <06617de4780ef33abf7a04b108ed8aff70a96eea.1747666625.git.neither@nut.email>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <06617de4780ef33abf7a04b108ed8aff70a96eea.1747666625.git.neither@nut.email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x330.google.com
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

On 5/19/25 16:19, Julian Ganz wrote:
> We recently introduced API for registering callbacks for trap related
> events as well as the corresponding hook functions. Due to differences
> between architectures, the latter need to be called from target specific
> code.
> 
> This change places the hook for MicroBlaze targets. This architecture
> has one special "exception" for interrupts and no host calls.
> 
> Signed-off-by: Julian Ganz<neither@nut.email>
> ---
>   target/microblaze/helper.c | 8 ++++++++
>   1 file changed, 8 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

