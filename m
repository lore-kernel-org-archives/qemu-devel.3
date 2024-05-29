Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D782C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 17:41:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCNIg-0004W0-9F; Wed, 29 May 2024 13:41:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sCNIf-0004V0-Nw
 for qemu-devel@nongnu.org; Wed, 29 May 2024 13:41:21 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sCNId-0002CR-Gc
 for qemu-devel@nongnu.org; Wed, 29 May 2024 13:41:21 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2bfffa3c748so2020266a91.3
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 10:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717004478; x=1717609278; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=b+WoHtz4vE6xWrKK0TBOqE8cQGWXNl9o2CRoQ99BKEs=;
 b=a6B0z1pZmsiVq7SIPqgFUx/vHdxAsI9X/Oq8JymVkdYuIenKCIBtChbvXJ5+jafu8e
 P3y4ZMBHcqWzAaNAdmJEayquDlRqXSAGlj/oflKdbOM2zymishMJmRD/YkF47fWBxonV
 RwWwKG6P6Sgg2mXLptKH1VrAJAUW0fiSvlD4IugVv38KbgkJCnTgq4LXwoD/jl8mOYD3
 A2DG3QMYH2ZWLSgHASYEgnvhIuoUu969ENGBDfN8rV0UQl32YMMKeoENlHHqc6ISUwrg
 Zdkzmpgh41e7w6eKgkSZQZV9oJwp4wHzmjoY1k8pFi+5hL6qvulX0IRZ0ZXJXjm561M5
 t9JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717004478; x=1717609278;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b+WoHtz4vE6xWrKK0TBOqE8cQGWXNl9o2CRoQ99BKEs=;
 b=jUhNUn9mOdVMI7cMzSRib2DoLsHf3ViE9IRmaihjTyW26p1JYeqDxmOKFptYEqSCoj
 XlXbEQj2w8L7AwdDs1cBiUgzpf6yo3fAuQZoezM9jxgYyhoKMm3GUzGJPYsKLRxicwjg
 6y/tknkJksxEGqsUzhI/kDUPQsMAMcy10N1wN7K4CMKsvDdXH2gBdC9z823232eZul1Q
 fliJJrQYir9NTgvN2EMPQAstDANcWvSS5xjwQZp8Bxu3GJ3VzmCPhGpZS0i4NSLasrer
 2V61EDWlaByEt2cwaQU4NzzkIXFPzoxnoSGNoRFYOej7w3E6BXgFZzOtZfzNDQDJmwYd
 c1Eg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+47V45DNVK7rjzyhCIi33Fa4ZMJE5afT+NdF5FPrIC5EhRZ37JBp1xShi0K1o0S6/wKTyDDeNs1jjK33TIGROzPNDsWU=
X-Gm-Message-State: AOJu0Yy9eHAdewUQS/06HnKcLYtXy4a/WNKWcFVgLk1+9HSan7D2Arke
 N83R4DfBjxlDpIt8bQx5F6RkSM8EPwJN2kS0+KfYeHBSp+omPovGsMBdNv4HhpA=
X-Google-Smtp-Source: AGHT+IFnSVKAMXNFw7cPfrLcrepnGOZMmHQUfGwtKS3PKpVmaq7ctK1CwuHtuwU31mYJ+aYP/9hDdw==
X-Received: by 2002:a17:90a:fb4c:b0:2bf:7d99:9ee1 with SMTP id
 98e67ed59e1d1-2bf7d999f48mr11956924a91.30.1717004478145; 
 Wed, 29 May 2024 10:41:18 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c1a7772c07sm38268a91.15.2024.05.29.10.41.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 May 2024 10:41:17 -0700 (PDT)
Message-ID: <e4d6b490-ffd0-4082-ae77-b5ecc203d0de@linaro.org>
Date: Wed, 29 May 2024 10:41:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel: Restrict probe_access*() functions to TCG
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20240529155918.6221-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240529155918.6221-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

On 5/29/24 08:59, Philippe Mathieu-Daudé wrote:
> This API is specific to TCG (already handled by hardware
> accelerators), so restrict it with #ifdef'ry. Remove
> unnecessary stubs.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
> Based-on:<20240529155548.5878-1-philmd@linaro.org>
> ---
>   include/exec/exec-all.h |  7 ++++++-
>   accel/stubs/tcg-stub.c  | 14 --------------
>   2 files changed, 6 insertions(+), 15 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

