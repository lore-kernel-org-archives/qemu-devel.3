Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 978C7C3ABA3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 16:04:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAWOV-00046J-54; Thu, 01 May 2025 12:04:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uAWNL-0002z5-Ed
 for qemu-devel@nongnu.org; Thu, 01 May 2025 12:03:08 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uAWNH-0004lK-CN
 for qemu-devel@nongnu.org; Thu, 01 May 2025 12:03:00 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-af589091049so856895a12.1
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 09:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746115377; x=1746720177; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nVZIgaivXdTH70jUHc1a8cRycDy0pU5w+uOOp/ZybP4=;
 b=MVkhy/R/JYdw6KDjvn6bs6/7Tp3PeE+dpZziI7qGQ/GlQlVWCkW/zVBVKl4dn8zNuk
 fxm1fQ1mk0zIT5w8+Rsno9KOKXHx6cpI764FFWts3QVR5Eve+aAXeZ7mFg0RqWao22Aw
 qBB7I7ru/9IX7cZLQx5fTbKWrluXkLONjhABzX7QoO0K7Wj+2X4ntIAj0+tjI2DopYa4
 CrmxvL2vD/5DS5fZUco7vdkQEBulioJ+Wlpwt/7jEKtV8ZWcHfTKUHD7e/8ekpbZG5EJ
 nxbeRB+JLOkM7vA2OFNmUiDqxMeaX0AWqUW+kZIjc03OiWW5clYgilQWFI5fMXdIWMEk
 H5ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746115377; x=1746720177;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nVZIgaivXdTH70jUHc1a8cRycDy0pU5w+uOOp/ZybP4=;
 b=eoLu9YuKwEdyYJ5+z4HikpxAjf0hVIdvA+wOnZaCCsF1DkXlLMQGXvS1tpdG2EmTxg
 1wNygEO/5zFn48SulKgmzJjvICB5hHjN0iyBu2WqkE+Dr4pWh0rPrvbkU5hZrusIrxFb
 ZBSPAISz7tOcsHFwmbZ1xLNjWIuN8ZQU6yOpHogFHBd/+v4HOnOOVYDtehNz5pN1Mz1h
 BHLlTo1NW8XGgMRcCgtpWRqR3roXskESyJVpvJd6M0G2QDC06eCW6P0ZxJnvRelU2vBn
 8zQnDzXwb60Ql1EVqiYnQp/4jBexaoKxe807z6lG+6pN3i1FKEWAlP2UXSO86m5yCOyM
 HuLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVS5B2PA+i1KZN/YE0ELqSTYGTLHlXxsY3qDrd9d3un2mm6kRGS/CYLTXWJwYU72XDhDAeqg+obFgj7@nongnu.org
X-Gm-Message-State: AOJu0YxnFtV2OHvhPhfKYj52KPkFG97xb7mIqYalqFoN+klHHLJpxn8o
 TKY5jwSCZOAOSjLBkW+xs43UZWqTdma+GbDo8MlNFk4uZpiBWw6aJSAVWCgoSK7qKLB6d8yZdbN
 Q
X-Gm-Gg: ASbGnctK6P2873VI07AlQ/ySv59kf21dEjFVVxM3JRTwriMaX5KjmRHReI/qNKXCe0X
 YvpOaCv0hSTgkUCNeXKRrAqoU4pFa+pi1FCR5zhTRu1b7AHRalLwSRpCo64NXGtEFUxpiYCnNhL
 dhcoxsao5aG6Q11aBdOWjQT1FCn9iggIFnotIi6JBxkAKhe7fSusQLYXhIqgpRR/P2PknISeLLg
 cDLy03Xm5F8gBB4Y5FQl4xSIEcbh6Ak/KGSMznIBkdp90iYpy/cwFbnYHNdTNBJs9dXsl25qlZt
 l4V/SHU0s/Ry7Y4Wncucp19fOb0r+7zFjedrdQJnESW85VGn5MA61g==
X-Google-Smtp-Source: AGHT+IFhnyr8Dr9u4Kb5QkIX8bXgYNLyclfJogZmelcnCnZsXnHQNzqAalzVs1p0pBIGfQMSSx8H3Q==
X-Received: by 2002:a17:90b:2d4d:b0:2f4:49d8:e6f6 with SMTP id
 98e67ed59e1d1-30a43181512mr4000032a91.3.1746115377184; 
 Thu, 01 May 2025 09:02:57 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a347221a9sm3774128a91.1.2025.05.01.09.02.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 May 2025 09:02:56 -0700 (PDT)
Message-ID: <48a3f1ca-92ba-4b6e-b5f4-a09f494c2c86@linaro.org>
Date: Thu, 1 May 2025 09:02:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/11] include/user: Convert GUEST_ADDR_MAX to a variable
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250501145520.2695073-1-richard.henderson@linaro.org>
 <20250501145520.2695073-7-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250501145520.2695073-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x535.google.com
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

On 5/1/25 7:55 AM, Richard Henderson wrote:
> Remove GUEST_ADDR_MAX and add guest_addr_max.
> Initialize it in *-user/main.c, after reserved_va.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/user/guest-host.h | 27 +++++++--------------------
>   accel/tcg/user-exec.c     |  4 ++--
>   bsd-user/main.c           |  8 ++++++++
>   linux-user/main.c         |  8 ++++++++
>   4 files changed, 25 insertions(+), 22 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


