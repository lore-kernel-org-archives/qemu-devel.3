Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03586C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 19:43:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8OxM-00037x-NP; Fri, 25 Apr 2025 15:43:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u8OxG-0002xZ-4z
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 15:43:23 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u8OxE-0007fI-EI
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 15:43:21 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-309f3bf23b8so2414960a91.3
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 12:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745610198; x=1746214998; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aCLLcRmOYOePq/kj6riTcuh/lr+GtrAx5LXkbL19reI=;
 b=YL1iF79tV+sSyY6dIafqTogIWQ8D3SOi1n/rMFyWlfVj3fy62ltp4XP2X2/LJ97xty
 BFh5cgmyHufiAfA3Jsu+fsA/Xho7Ls5fIAK0oWXpZgrTUkA4uhDMflR/uZ+qvHITVngb
 tKEfuOq/l8SwtQe7QWMEVb92Z+vo5Y11Vtm3vVCZNrbvFx8ZS2MYij1KM1swMkEBOSCW
 GqBCYz+YlJj1bB7Oatn5BJHM6baFQredSDMC4UCTyJJFT4v3d4t6f/nUGml6XAnBAZwb
 oExfFG6RUJc0qIxXW3aRQbtgizf5UKlrzkboNQOYzgfJLG+RMPfI5FS6RBgLfGOxM149
 a+Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745610198; x=1746214998;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aCLLcRmOYOePq/kj6riTcuh/lr+GtrAx5LXkbL19reI=;
 b=Leq99oRHtSdMYMJNLiu06SXSglaGMKcdt6xZVZgGUTPmnUn4kZgUsYHKdGqdKzb0uN
 o5NKbLfxWb6Uof49OlJXaUjz3i/+ZcysL7eXypiC/8Z9FZ/HHJP+2N/mDeXVav3poNBT
 DTSTjzht6Y5TyHPzRKdXHaPLXhDh2dLWYHTm2AQd2mtKCOCRbgkn2yZ/jJBSfgn500cb
 W1l9dZ6SBUkjF64IDBSCKn+NoT5TYSWDHU3q+F2Je1SHZMezQyFWSj5xO5aGQd+sFNBP
 EKw2FqKQww7rdYIhM7be3RE2aRipTvyMSHXwXsKlhR7ZlfYn6japeZVaMj3GId26ybgP
 EX8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJynLhNIWz5xUrU89LNbWS6K9AqcWTTVV4ngCgQJRR0hBOtb/ITVAo++VqxONNEmj+w2F9d+5nZt0b@nongnu.org
X-Gm-Message-State: AOJu0YyakwZdebJMIrKEP1CWL3ZK1eC60oUT3n4MSGuMZtuU3Xa6D3Z0
 6ehScMhO4LHcranJOe7ryVnhGsKkh4Zhqw17kj6y5rRbKS2u7DpuCjSKRJyt0nfA5oanQksdyDL
 azjIx0g==
X-Gm-Gg: ASbGncsKRb1r7AtzU7igc2GZ/D3ropccII6ML/xNtabfbRB9839GbfZwjm1z9HMhx+r
 cuMzuSNhb8h/3Vt2aJFZyEgtFhXqmO3vXPALfndYAt+KSVuHziKfn9R7SYFz4EZwz4XujyWsxzU
 bnO9z8TrDtKGkIeAjGHaKUSIy799CakTZRarTUWScLJfnH+L6tQRuo60DW57P89WIYe6S8ocDRC
 8xofB870R0h8JRgZq1uSHUkvoy80QAXEmH6/Ej6cUoy3TGLGzCxoMLrd1ZSDWROU0H6skFo0Zwh
 3sIO1fs2T1VHA/iE1Jsf40yqT/y0WnxGHc0aQPmqTskxJe20jaAWD8XUGVkULK5X
X-Google-Smtp-Source: AGHT+IGX27FpCss2QxAlK4q3wYdlC7YjCOxNjf36vuo4kfuwt5t9T5s1h2iW4DLsogXu+B4vD74tXQ==
X-Received: by 2002:a17:90b:1f89:b0:2ff:6af3:b5fa with SMTP id
 98e67ed59e1d1-30a013b185amr948132a91.22.1745610198716; 
 Fri, 25 Apr 2025 12:43:18 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-309d5e18130sm5670298a91.1.2025.04.25.12.43.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Apr 2025 12:43:18 -0700 (PDT)
Message-ID: <f21baece-2dfc-49bd-b60d-74236e12fc80@linaro.org>
Date: Fri, 25 Apr 2025 12:43:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/15] accel/tcg: Reduce scope of tb_phys_invalidate,
 tb_set_jmp_target
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250424011918.599958-1-richard.henderson@linaro.org>
 <20250424011918.599958-12-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250424011918.599958-12-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102d.google.com
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

On 4/23/25 18:19, Richard Henderson wrote:
> Move the declarations of these functions out of exec/exec-all.h
> to accel/tcg/internal-common.h.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/internal-common.h | 3 +++
>   include/exec/exec-all.h     | 2 --
>   2 files changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


