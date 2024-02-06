Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C5DFC48297
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 22:29:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXTwF-0002uq-BF; Tue, 06 Feb 2024 17:29:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rXTw9-0002ub-Jh
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 17:29:06 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rXTw6-0005th-AU
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 17:29:03 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2907a17fa34so5257645a91.1
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 14:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707258540; x=1707863340; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=h2ftN6EYno3st+TquCdN+VzNqndBsQ2s0pMELCUm/sU=;
 b=qri47zmh1pKsHd9Nv3gFzwbG2PsWti8gMeLSsyyiDbeeC4Jbxfc8Z5aOsDS5Gtflnq
 hLYZ7ReXTnu9dnl2jSOsmtU3OqiHt5U4m38t2PhmEdq6K5yF6cd7szvLo4/i9qpPwADR
 /g/0Zh/zM7brdqii1he620s3TvsCS8g/52HpN5SDAM8d0KgKvhW0t7otH2tMGSL8uKp6
 AHPjjaQU/fmdq6TxOM4Z9JMlxP4+0lRirxPkF62wkcXIGeV2BC7wEoAQVvPlY/y3SMVl
 8n2A4VZReNO384/3nqYHt/xR7gk93iWwCtARijkVNuoToY5yExhiJrh+VCbQGc3lBsIo
 kdMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707258540; x=1707863340;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h2ftN6EYno3st+TquCdN+VzNqndBsQ2s0pMELCUm/sU=;
 b=EWYkqvso0PW4JIVhTiKUpC4gFixTGeZz4lSs27PZJFBN9pTIihZImdSr7ag5Z372k1
 KwJHovpbEf9JuGitHqHZMpgJTyfIeLkmbc2Lkk/NnxKkifP+WgwKQa+YwlFZVzeDOnUw
 Yk1kiOfUedFUA/DIHki1EGYhK+3dbraFsYf9na25IpCX5uyFUOtNifqzC90RFNwA4AiK
 eNfz2LYO+0o6xgnPyYd5TOJTm3VmTkbQ4zSpKuLPl18qAlUs7F0jnOv+frOxsva2paFK
 EuVn4srVfYSfb6G1OVO/21jdHki+Mms+BcEa8wdI6oAlIYP7j0njhL/2hWjDKnpjnJgJ
 2MPw==
X-Gm-Message-State: AOJu0YwxSRdlEe2vCjbvocBW+hxGTYEhaRjgOhozp11O93fqIqkvOczf
 i34btUPhf7jrZDVsfHB08JWz4g+LypINV7RJSbt97o06c7wqq+845+scvbDNVv0=
X-Google-Smtp-Source: AGHT+IFjrxeE8AyMh0nlSoN1Gg4vBJMqvyNROqakI3fFoNbjr7WUAhNsMov0jzxji+Pu+MWccKCC4w==
X-Received: by 2002:a17:90a:c683:b0:296:865d:e0c0 with SMTP id
 n3-20020a17090ac68300b00296865de0c0mr991397pjt.45.1707258533716; 
 Tue, 06 Feb 2024 14:28:53 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUcgk1ab06WhF1P27YMhgxt0072hCj4dWBtM6Th8/gLL1otu5XH+zmAHVIElkGmSDrNAzGi19JoV57iz3me+S9aB8HVtD/7hxIhuZBtrWfyTLlX6c0EFFJTB2A=
Received: from [192.168.0.100] ([43.252.112.200])
 by smtp.gmail.com with ESMTPSA id
 sy7-20020a17090b2d0700b00296ca138c96sm31105pjb.26.2024.02.06.14.28.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Feb 2024 14:28:53 -0800 (PST)
Message-ID: <2263455d-7f03-48fb-ab0b-f2a6100edcc8@linaro.org>
Date: Wed, 7 Feb 2024 08:28:48 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] util/bufferiszero: remove AVX512 variant
Content-Language: en-US
To: Alexander Monakov <amonakov@ispras.ru>, qemu-devel@nongnu.org
Cc: Mikhail Romanov <mmromanov@ispras.ru>, Paolo Bonzini <pbonzini@redhat.com>
References: <20240206204809.9859-1-amonakov@ispras.ru>
 <20240206204809.9859-4-amonakov@ispras.ru>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240206204809.9859-4-amonakov@ispras.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

On 2/7/24 06:48, Alexander Monakov wrote:
> Thanks to early checks in the inline buffer_is_zero wrapper, the SIMD
> routines are invoked much more rarely in normal use when most buffers
> are non-zero. This makes use of AVX512 unprofitable, as it incurs extra
> frequency and voltage transition periods during which the CPU operates
> at reduced performance, as described in
> https://travisdowns.github.io/blog/2020/01/17/avxfreq1.html
> 
> Signed-off-by: Mikhail Romanov<mmromanov@ispras.ru>
> Signed-off-by: Alexander Monakov<amonakov@ispras.ru>
> ---
>   util/bufferiszero.c | 36 ++----------------------------------
>   1 file changed, 2 insertions(+), 34 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Although I think this patch should be ordered second.


r~

