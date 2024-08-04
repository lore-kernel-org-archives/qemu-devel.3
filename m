Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFF70C3DA7F
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Aug 2024 07:27:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1saVeh-0007w2-3K; Sun, 04 Aug 2024 03:27:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1saVeg-0007ss-8W
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 03:27:50 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1saVee-0005Q0-Mt
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 03:27:49 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-67682149265so78185877b3.2
 for <qemu-devel@nongnu.org>; Sun, 04 Aug 2024 00:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722756467; x=1723361267; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bgVSXfPavHCdHWfidzj5WorDJapaUZ4NG5qpIWpkBdo=;
 b=eSusGVJYgWtBFJqoAIxONtX4QhdMHDIHJduMNmNOXECsK2ALG0peOG2b74naxnaDfT
 zeXrfoCbJPBYa0dT5ZxF8MMwwwS+fAzTsp2gCRGeZ28o3ehxN7Oim2gipu1JRPKq7ziC
 w4JcDYN3oh7ZRnMQ3e1I0yn3I2ZfWuP3pT1gkPyTHLhC91kSvY8AasetUtM2HtrcnX0H
 tIzx9AYaOsUHqr5+OeklCB+bVya7gN5f+sKNi6L7k/VnGPaRVmUsvmveIeheKSuYGSg0
 T0wB1BElsiIdfrqusu/Tv7A3LKmyYbwdGki/JbBRIECWTpUG8NZwHzJIq8BI6hbPc9Z3
 dVGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722756467; x=1723361267;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bgVSXfPavHCdHWfidzj5WorDJapaUZ4NG5qpIWpkBdo=;
 b=Narh2gapm2QNORJweScGd8aii3z/VK1MWQ0pyjmjj//dZ+XaHufxD9XVZmYrg5leA8
 riX49VuNpNDjZSZAFl1J8vkb5HL5o56SYj6efdf9W4yZMo/SV+DQ0dza7dSE4o88+jy3
 zpGKKVuCvhLtUSXWPPStj3JOPA13Q1n+TnciEmkphU7cOUxIoYpt1XGbKk5UgJuS6siJ
 uRrwa2ZywUqr2QFYmrpbr0i49fAGAOqsqrPWPxzsqpZU6QyxPOpRgkLvwV7gusf9q33G
 1Qm3dLXGYmAJW1804J65yMAggIcpm/hqivuw2uvxAaB4QHOhBitrXZcJFHEn/yJwIOGK
 xP0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVI7qmnK9peHTBfDzhW7wOMP0KGxw+UPAEk3DZBnfCXJ7l220WFv/1J5ns1ZWuS/BiZ0aENLK0Ct/1h5u0B5alGsN2raBY=
X-Gm-Message-State: AOJu0YwaPTuMI9JVQ/ptVjN1qaf6bL0e9NNn2Fy9//pp4qUft9F1jvdU
 l77WoFvjnpCQ9Z3l78gC7de1rQ4pAnQu/gTwSJFEV9QF/2NZUXMcg0tBT+Jv+DE=
X-Google-Smtp-Source: AGHT+IGL+DoeUtgM8qlWusxIZakssnLd9kjqww/xUfqHdezOwr/sYnn6RlbNXoAMmDUNyxEi/W5j0w==
X-Received: by 2002:a05:6902:1207:b0:e02:3e43:f1c7 with SMTP id
 3f1490d57ef6-e0bde32787bmr10153631276.13.1722756467102; 
 Sun, 04 Aug 2024 00:27:47 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cffaf69d54sm4643790a91.12.2024.08.04.00.27.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Aug 2024 00:27:46 -0700 (PDT)
Message-ID: <694ea475-f6f4-4208-a2c8-3657404e9171@linaro.org>
Date: Sun, 4 Aug 2024 17:27:41 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/17] bsd-user: Eliminate unused qemu_uname_release
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Jessica Clarke <jrtc27@jrtc27.com>
References: <20240802235617.7971-1-imp@bsdimp.com>
 <20240802235617.7971-9-imp@bsdimp.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240802235617.7971-9-imp@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=richard.henderson@linaro.org; helo=mail-yw1-x1130.google.com
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

On 8/3/24 09:56, Warner Losh wrote:
> bsd-user has never supported this, and FreeBSD make it easy to set this
> on a per-jail basis, so that the normal reporting routines that we pass
> through just work. Since this was never used, and never even in the
> usage(), retire it to cut down on the clutter. It was literally just a
> write-only variable.
> 
> Signed-off-by: Warner Losh<imp@bsdimp.com>
> ---
>   bsd-user/main.c | 3 ---
>   bsd-user/qemu.h | 1 -
>   2 files changed, 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

