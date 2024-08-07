Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75A0DC3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 23:10:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbpnT-0001uX-U0; Wed, 07 Aug 2024 19:10:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sbpnR-0001tR-4A
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 19:10:21 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sbpnP-00031L-A9
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 19:10:20 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-76cb5b6b3e4so288001a12.1
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 16:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723072218; x=1723677018; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=q8pse+1FAe/ZQ8DqSCOcd62zDS/a3TyP6fOlnI2w/Gg=;
 b=UAqH6bo1PnclslMkiZIPTwR9SEzGb+eVtiHJWyyc5bDpsP0EdRiCQKQYAMJPyX+m5D
 L0B0XR20bSzb5mtRITYlnArJDy9UQ2bmE0BRuCSZ+hCbqArNO65qmCNQ6z4NLHJaAePE
 p39OcfvkaGNNMFesAh9NTzu85osGwbiE411OdYnqlk0rj6HrwhAIarpn8Va+5JGrnmB+
 neE6m9Dh7wY9WeFzXqdccqWA0KZWQMabV5WitEG5gUih5+V3Fsu/TZP/Li155Fxc2sf+
 2j5632oaDFyGw+Dov1tv4+zMPK4EeUlfhNxRp/TznhMTe51BYjbjO2BVAIGy6Fvh8gan
 EJTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723072218; x=1723677018;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q8pse+1FAe/ZQ8DqSCOcd62zDS/a3TyP6fOlnI2w/Gg=;
 b=fEvxr14CX4oy1RY81XVWP9OnzXmYF/IjGkA3waXLgSH3NQX4RuF63bWi8VSeKefvNH
 hye4JOOG2L1h16y4EAPwYoepq/IlB1cB7GV7rZ3EE5Kzj2S8iDV5nb+q3H+KqK7gFrFA
 gb0RWSOm1+qpnirfOdRdFdS5GJaOHBdPf6+moXblZh7Aa+PJmdaimONjUePydl3I8gGC
 ZT/7dQVAZ7O2AEO1Il3iJ7MfiLdeaWvWzwscThQRrVxOSJ+sa7ssZaGHeRG5XVGBM0XD
 DtXiC6qVoWkpQ6sqfpI4uoSxPQfZ/uDztIvolw6qG5gVBdphjAUwWLxh9gA4IifIrq1f
 ExUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUmEAH8f6bwDVjqsrK6JMs7N5TLHyWHNVopSMLFhjWdu+j0y/KZ0Dnr0pgbQGxfsSX0IA/xKNhkBVAHLlmLRVAdQ2QtwM=
X-Gm-Message-State: AOJu0YwmfRtOYbT3wFkrOAmhBcYjtFAl3iSoyWuw/2smFBzoDg7Dd8et
 fpRgPvUA2YWxChSoKHChTFsLQB3knDYOgq4qVlg+Pf1dYKKEDtJzK8sf3uHAhjg=
X-Google-Smtp-Source: AGHT+IG3HEi6/MdjnZMMkAIr12+goMK+JAoRVuYevuFvqziZbhaJxwPfCS+BXCpyXPlQmNUj/vAMcw==
X-Received: by 2002:a05:6a21:7896:b0:1c2:8c32:1392 with SMTP id
 adf61e73a8af0-1c69955f4bamr22504857637.22.1723072217624; 
 Wed, 07 Aug 2024 16:10:17 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.111])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-710cb20a030sm37215b3a.12.2024.08.07.16.10.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Aug 2024 16:10:17 -0700 (PDT)
Message-ID: <3fb9f760-4eaa-4a81-a500-89d340fc1376@linaro.org>
Date: Thu, 8 Aug 2024 09:10:09 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] target/i386: allow access_ptr to force slow path on
 failed probe
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
References: <20240807160236.2478459-1-alex.bennee@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240807160236.2478459-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
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

On 8/8/24 02:02, Alex Bennée wrote:
> When we are using TCG plugin memory callbacks probe_access_internal
> will return TLB_MMIO to force the slow path for memory access. This
> results in probe_access returning NULL but the x86 access_ptr function
> happily accepts an empty haddr resulting in segfault hilarity.
> 
> Check for an empty haddr to prevent the segfault and enable plugins to
> track all the memory operations for the x86 save/restore helpers.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2489
> Fixes: 6d03226b42 (plugins: force slow path when plugins instrument memory ops)
> ---
>   target/i386/tcg/access.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/target/i386/tcg/access.c b/target/i386/tcg/access.c
> index 56a1181ea5..8ea5c453a0 100644
> --- a/target/i386/tcg/access.c
> +++ b/target/i386/tcg/access.c
> @@ -58,6 +58,10 @@ static void *access_ptr(X86Access *ac, vaddr addr, unsigned len)
>   
>       assert(addr >= ac->vaddr);
>   
> +    if (!ac->haddr1) {
> +        return NULL;
> +    }
> +
>   #ifdef CONFIG_USER_ONLY
>       assert(offset <= ac->size1 - len);
>       return ac->haddr1 + offset;

You need to remove the test_ptr macro below as well.


r~

