Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28979C02192
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 21:15:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfmk8-0008O3-DL; Wed, 05 Feb 2025 16:15:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfmk6-0008ND-DJ
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 16:15:30 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfmk4-000658-S3
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 16:15:30 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-38db10ab86cso139062f8f.3
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2025 13:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738790126; x=1739394926; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tSqoYh5XJi2Rp7FPDr7DWDeYczzR/hUtqpgseuFuFkA=;
 b=qXUFkdYL1y4rql6zXZR9d3XUZJdLQaNA/TEsiWki0B+YJP0Q43VtH2g/nkRkfs1JEW
 LzCKWhk6z8TOqNMWKoy3Qv8u8+hWRNP81Se4NxR7SXitlXnquan25Zo5TnaTBZp3RpMX
 UHvBGopEnFXQx0qq/n3JPC5ZYSk8K3Bwcd4VzaSxab5iHoHryX73gmePz7KMyI4YsJrP
 ThpamHdRlQKVC3QEMYkbWRsnfAeCjdYeuwIjBAhiERQue6TV3Z0aBv+/sMvDYVnXrd5J
 yFnfUG/1BRJ3uujEMsitieJ6VJnJ3R7CuUuUm0OajEjfsUBHadiXVLwKtslNtXEgL32W
 Q2bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738790126; x=1739394926;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tSqoYh5XJi2Rp7FPDr7DWDeYczzR/hUtqpgseuFuFkA=;
 b=ExvAwYRejCloMxreidD5dqe7sZ/0TzaQWplq/LjDvPW2NLciPICaWuxWZU32oZbu18
 8z/EQBTordVeiATnTeuXlZxVDpEgzwt2IinyYbYa7/vgMSKSuhYhOBFxzNK1ZfEe8t4x
 KpzXfu7Lvc7lLLcdhbMqnpqHzUewr7JnKcN5+EE+JPp5jFU8mKAsT+gvc5j+37e6JTbP
 TUAXLnbHICjFVK+EC2BMH1zV3eDJcmMUzYxEq8up+CwHh9692jXpuWNkCLg29gSsdU+a
 p/tUee2rlJhKtjI729J37t+JGvvmiCLssVibqp/HEgSQ2alHiaoEF9H2Attf0mcVDIfX
 RnQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsowlG+mam3h8gzeXXz5LaVZCWAiI6ST8HHCq8ei7pz2UuO/xRy9hCL7oVDl06UqZwB1W4AUfW5q9u@nongnu.org
X-Gm-Message-State: AOJu0Yxhh7FVEp3FeKpQu5RoIeR48uHYsWrfZkZc9Na/T8mN4AvzmLkm
 3LVl8OestnhRGKQ13X1Acz2QgrsT1jo9R91nFXQyqKO9dFvmHMW3/2ZbCy8wOr4=
X-Gm-Gg: ASbGncsL3qTAUhREPpRDN18Zvz9bvygmKZYpDLdEtEMoQ/CRNJuzQWWpj3if9Uv+pNB
 sr5do4h+sOinri/0m5QAVqJMN60If0eqwczzYWBvb6NxNjGQI+1a2EaYcky6LTXWVNYQ+Xg6BJm
 hTN1GTyGv54V5cTDm7qvEEWXPayazDaW3QUlowLZt2aoQLkVbrAvum2dG3eOhe/znecZN6sssKr
 fz8mmgX9gBT7RDq6udZWgjnm2KDoyDEx/7xpA+vdUQ029tI9SGSD+Poem8U0MbkSP4TBBx/aitt
 svbwlfHWhDEzYvJ11KDgsQbyFjL54RrrMpM5dJ2ZDqyG0SH9G8mUyGHLItU=
X-Google-Smtp-Source: AGHT+IExb7pi7PJuAI191QPhaEuzZjJrduVThYogwHUWTLCe0HiIW757vuVmOrWDQt7DDzjpXBBb8A==
X-Received: by 2002:a5d:5987:0:b0:386:2d40:a192 with SMTP id
 ffacd0b85a97d-38db493e813mr2770428f8f.34.1738790126137; 
 Wed, 05 Feb 2025 13:15:26 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38da1a11f16sm8845137f8f.14.2025.02.05.13.15.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Feb 2025 13:15:24 -0800 (PST)
Message-ID: <feb213dc-c61d-4217-8edf-b1c6833178f2@linaro.org>
Date: Wed, 5 Feb 2025 22:15:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/12] tcg: Move stubs in tcg/perf.h to tcg/perf-stubs.c
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mark.cave-ayland@ilande.co.uk, berrange@redhat.com,
 thuth@redhat.com, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250204215359.1238808-1-richard.henderson@linaro.org>
 <20250204215359.1238808-3-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250204215359.1238808-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 4/2/25 22:53, Richard Henderson wrote:
> These are not called so frequently as to be performance sensitive.
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/perf.h | 23 -----------------------
>   tcg/perf-stubs.c   | 26 ++++++++++++++++++++++++++
>   tcg/meson.build    |  2 ++
>   3 files changed, 28 insertions(+), 23 deletions(-)
>   create mode 100644 tcg/perf-stubs.c

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


