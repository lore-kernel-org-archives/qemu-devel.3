Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73BE6C27C77
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 12:38:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHNEa-0006TK-Vq; Wed, 12 Jun 2024 08:37:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sHNES-0006SJ-BZ
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 08:37:41 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sHNEQ-0003UL-Pv
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 08:37:40 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a6f13dddf7eso472525966b.0
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 05:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718195857; x=1718800657; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wXULtP5u80zE6dfwGbbH16ulqchPjjATeK5JB0svpMA=;
 b=HMwWATqs45c2uGA2524xjFqU1njre0WNDTdJIfup6GGNjurRqyG9G3PtgwWfl10jMJ
 Czr7TXghfws8aAm7bFOz8GzGrxJPn6cAUee88FXJ4yImz4vk/0IRdcH6Uk/bwdKADfe/
 IrISt6qUw7D+gQCNSgeaYrbdhRZNVBPpyFB0dZCbNYzLhQMHcpt0GRHl1+FEJDVHQtTt
 jiUVpYvfMcD8soTszi4uiODcqAWnmjY680tnqiiwLqlO53KcInVr/Z+3EmTjEUke7UCx
 KJz5CB9kZHmsIH3Ndhh0Oijbu/61EZ1t15uHYnF+L2ImphbArzgDZNxfVLEx9ILQGLdR
 HfGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718195857; x=1718800657;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wXULtP5u80zE6dfwGbbH16ulqchPjjATeK5JB0svpMA=;
 b=vrg7bzd4tExsC4AmGZDkQCTAGQMBJIalxPwEpLM4vHP2iZVhbnWikbsEcAAgLVCR7z
 zbtIvrw0wjZlJuyHd+RP8FqWIixa2o88tDRi5N01UrJmkxKwpDZ6ajgQihVVVbeqfEFB
 LMlir6If53rVzrQoi7y6P4EerT2kGG6JoWQNrqOHsG0lNBuBWjHqTYKBTcL++1gnskg8
 zyW35hDvVEUrKtiKJ123lxM4hvbgmxYptFB9JdgDjS92koBx/m4GxyGZU6nAZ2yyKYIJ
 3mNRjTwUYtfJL9rDruT1BXzi9/R+z/Ns3cfPbZYM+APDb4mSW39njUOKu60Yzv+q+UqT
 px1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmg3Rb9jj2AJ8nAYWN3qyXOq8c7UrmZK33MX9mDjWUYsvuPzt/5+jIh8L+M3SlRGz06xAiA/a8E8zi0eGV0LLsRo3A79A=
X-Gm-Message-State: AOJu0Yy8JjzVUJ6xnnc+Sadr6UhSHYQtTxQO83CN7osD3ngxeTm8XtCC
 HeUvPGa91ZwRnekAfhf3t3Swt8oPWC+Bk4vKl6moLVCT5TUleAIieyhgI5xTnDLgNyUZzCPwSSs
 n
X-Google-Smtp-Source: AGHT+IH3rnXMg+cV+bNwN5oqh8YYaaLPEqS3aSWc1dyCR0wwKWfVlmnqhah33OODMYa+Oe+N5g5zQQ==
X-Received: by 2002:a17:906:f190:b0:a68:e335:3e62 with SMTP id
 a640c23a62f3a-a6f480268admr101258066b.72.1718195857218; 
 Wed, 12 Jun 2024 05:37:37 -0700 (PDT)
Received: from [192.168.69.100] (ram94-h02-176-184-0-172.dsl.sta.abo.bbox.fr.
 [176.184.0.172]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f13e08c89sm481365166b.88.2024.06.12.05.37.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Jun 2024 05:37:36 -0700 (PDT)
Message-ID: <63fc5141-00c2-404e-9c29-5a2c805c474a@linaro.org>
Date: Wed, 12 Jun 2024 14:37:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/tcg: Fix typo causing tb->page_addr[1] to not be
 recorded
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
References: <20240611215814.32752-1-anjo@rev.ng>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240611215814.32752-1-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
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

On 11/6/24 23:58, Anton Johansson via wrote:
> For TBs crossing page boundaries, the 2nd page will never be
> recorded/removed, as the index of the 2nd page is computed from the
> address of the 1st page. This is due to a typo, fix it.

Cc: qemu-stable@nongnu.org
Fixes: deba78709a ("accel/tcg: Always lock pages before translation")

> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   accel/tcg/tb-maint.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


