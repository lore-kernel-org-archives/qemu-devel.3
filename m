Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53023D1D494
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 21:01:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdx80-0001EG-9J; Thu, 08 Jan 2026 16:01:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdx7z-0001C8-1C
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 16:01:07 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdx7x-0003fS-Lr
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 16:01:06 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2a0834769f0so28048855ad.2
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 13:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767906064; x=1768510864; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=O6vj0S6ZEexJEEoY9KckdEU4QUwOlorsGa+rnzI+KqA=;
 b=oyjYVGyQ2K+xIPv/1JD0g3Ry6Fbz3wJKmIhHyFJjaJiz0fkcW0ukNQwGQu+7AMqpze
 fnsxJA8KUjtoWxJoz5pdOjv/YNv9O3cMOWhqkuhz22x/lyEv4udDNq+LWzDm1QlyK2Nu
 ldF/7CejtJOFTRnn2QGyPcPqZmb5TrrKJ5rFBE0WLjqjx+EWyYqnHqdV1FaUdvUhCuny
 OrljVn/v5dgY8/w8zD56NAyi3ooqrwY/lbxg+fWWZLD6gjGGu2r7QHqnl37FUJTkcJ+w
 MDLy+XAzLXuSoJI9eIGHFrtHu4ZVlRSl1+skOiEowQxuHuV9TcGnJ0ZBJKvJpDKJi9ef
 m8QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767906064; x=1768510864;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O6vj0S6ZEexJEEoY9KckdEU4QUwOlorsGa+rnzI+KqA=;
 b=FMCwyBVgUt2j7+Lpt8E+aXoqfEUGThPZduhL5XVqRia0xIvdqCLaH4KULo90nST/Vw
 xmYgCvBNfmwN7DmY0kPl6ht6vAKSbkWTkcd6LItLqY+XPgLHOlmG0ZSEGYj+0Ik2q/Et
 0NxfZMLk0zKujqglkJqAGa7YLE/qx/WhLzLc8y3zfoyWXEA+EepYbMD2eE58dHZvD8T3
 2LIPOXvk7oYZiQE6A2U7ElV1yPQK3X5oyRofR1W9WSv2nPpHM9a+WKLMm83T4eAaUJf3
 FMJx+T7qsbvx3V+Uz9MAvE+rKELCUVJJAgjRYHUhYd0NC++1ijc1X7HJ4m3mGSkPn0tg
 ferw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7IIR4LS/n00Pl/lLVCGyEdjGsTv6JkFbGQLGB0HZsGlxPufaBOxsqznZGF6P86z4FCq3/p3YLbV74@nongnu.org
X-Gm-Message-State: AOJu0Yw9l48bEsfV5yv962iGh0y8h7DumKZgreMb9zRVGcwn/k5uXPQk
 e/Px7sP4/w3qO5AntpYa7du8LJN3tG79sQQ1OilaCBFMJKgxMvgWIwl5XvOmr4RH620=
X-Gm-Gg: AY/fxX6pw7qkh571dKIQG3VugYaISS7R1MJaMH5XxY1YbmeHRkgX+WZwdOXOXekQo3H
 1//BxC+RYnM7T+dAqmMMsVDJ/7iKGVwcbYoYd+eU+SwI0ZWIBzcoB8plXeFenKqC4VeivkxAVAg
 TsO/MHsJMe3ltGHSaHlH2abA0tXQicgDy95a7M1UGyfV2DyjtrskKqur+eJ7hZ7pRYMufIC/FKg
 p4i/RO9/rlkGJs2aF9xft7/nQZ1jMwYf+0Ht0AhajYVBsTWitN90WKRRUEaYhOTDzFkgXhFs2AE
 a5XEkVVI9r19YvjfYWXeo8my/yQjpjpNZQ1xWjCucJBxwD4qUxcxtFu92nkqmqi35NAr3VROwSw
 pAAERcYo4bauy8XFLzYCCM4otI36PrLOcy9RoMLNFe5aMgh/EkJTcR2sIfGEdT+eymO6qQqxNuJ
 ZqV82Wp4w/l5MDXDWmwXiRW7D5Ku8d3l2+tXoDpw9Vjz6I25OSgGOeka1s
X-Google-Smtp-Source: AGHT+IGgLBS0Mmdh/DmBHaURXyz0llS7LsqtkOBwYjGalOTlfBuZRAgxwc2o7OhdMdrN1CFvZXXf6A==
X-Received: by 2002:a17:903:230c:b0:295:5945:2930 with SMTP id
 d9443c01a7336-2a3ee41d27fmr77412305ad.2.1767906063748; 
 Thu, 08 Jan 2026 13:01:03 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-819c52fd904sm8443266b3a.33.2026.01.08.13.01.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 13:01:03 -0800 (PST)
Message-ID: <39e136bf-fc80-465c-9081-630dfe7eb4b1@linaro.org>
Date: Thu, 8 Jan 2026 13:01:02 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 30/50] tcg: Drop TCG_TARGET_REG_BITS test in tcg-has.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260108053018.626690-1-richard.henderson@linaro.org>
 <20260108053018.626690-31-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20260108053018.626690-31-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
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

On 1/7/26 9:29 PM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tcg-has.h | 5 -----
>   1 file changed, 5 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

