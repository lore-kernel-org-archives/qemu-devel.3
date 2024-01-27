Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40350C46CD2
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jan 2024 09:06:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTedG-0000iu-A5; Sat, 27 Jan 2024 04:05:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTedE-0000ax-F2
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 04:05:44 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTedB-0007wI-Sz
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 04:05:44 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6d9f94b9186so1261832b3a.0
 for <qemu-devel@nongnu.org>; Sat, 27 Jan 2024 01:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706346337; x=1706951137; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=H9kNcvnnoWmT+bdlD7RWVRdeMqv7i4Kpo37ZDgInJqM=;
 b=gpO1c/RS3kLRzv1CdicXE+xfHzxIOfOXJAueYczOc6wCDvCIXvQZEfKkAOE2WVes+h
 bVVVbtpzdMsZlutR+WjB6VpQQCJMJqo5ugUDV6ivYbIIdwzjWH6WmoKipsPJ0h+7EHmO
 1MOZuWL2Qc69Dgo9LzfQRwmpFDK6LL+ydDcwJe8L5txek5SXGgaeYGQXpntJqD+X7ppH
 cxX5PBxLH6Hu2x+zMnx9vHn6q+rRAfVjRS2uvVH3TeDoXYo51QFfLZPY6D/zWsnqQNg2
 Qi0xX26w8reNxUtFZVrQMB6S5Qj5/Di4E2MQdyOmWEUvGp/qIZBak4sCZdkUzgz2tRkl
 DSXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706346337; x=1706951137;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H9kNcvnnoWmT+bdlD7RWVRdeMqv7i4Kpo37ZDgInJqM=;
 b=BycQSboEdH6On8BnSBZayxL/zRNTdhz191hlDRYxDc4T6ULLiZ9Kflq9bkuMQSSBbw
 ILUiwAuyl6fsHljHlkAdGTgXMJRx2b3kZvCThPQWKb2/ZX4x9m6MlsvdvUFDj7zQh6b6
 LgsYf3IotaRnZhVZBxgo4Mk/aVkfvTdmwYcd5zw2LghhnIP15sWkaEHqHhK4gVYw+/yi
 qIT1Q+XaTBFcvZdBOeYSFg+scnQpO9wFy4XxgJ0gdK7p4WQSRUgSNy86dxrqRkmRA5cT
 u5JpyCWsS41pKN35Ndig3bv5bnG7ZDW7022VVbyyJ5b2l5vVS6RLNRewMHk5eJhLaKJF
 Oepw==
X-Gm-Message-State: AOJu0Ywiaeg9VW4wTV6bZTl7DmWPmmRUJHle3qIKIHm5NBrgaTuNaaIt
 9f2OJMKLa5FdoSYndgrSqiasMDzzugcEJCzM/x3+2sBJHZPBMVDEPf5iT6EUVFw=
X-Google-Smtp-Source: AGHT+IFlxBjjEUtv5jPduluWhdBxleFL4Fojj/ph2yEiryVHzsYDMTGY4rgYZQp9MC1tMLqf0mDSsg==
X-Received: by 2002:a05:6a00:848:b0:6db:c5e6:8a46 with SMTP id
 q8-20020a056a00084800b006dbc5e68a46mr1456909pfk.58.1706346337086; 
 Sat, 27 Jan 2024 01:05:37 -0800 (PST)
Received: from ?IPV6:2001:8003:c96c:3c00:af6d:99b9:66ea:c79a?
 ([2001:8003:c96c:3c00:af6d:99b9:66ea:c79a])
 by smtp.gmail.com with ESMTPSA id
 b123-20020a62cf81000000b006d9a6039745sm2435671pfg.40.2024.01.27.01.05.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 27 Jan 2024 01:05:36 -0800 (PST)
Message-ID: <1c59c875-b2db-4c94-b6b2-792a3c134aef@linaro.org>
Date: Sat, 27 Jan 2024 19:05:32 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 08/34] target: [VADDR] Use vaddr in
 gen_intermediate_code
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, philmd@linaro.org
References: <20240119144024.14289-1-anjo@rev.ng>
 <20240119144024.14289-9-anjo@rev.ng>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240119144024.14289-9-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

On 1/20/24 00:39, Anton Johansson wrote:
> Makes gen_intermediate_code() signature target agnostic so the function
> can be called from accel/tcg/translate-all.c without target specifics.
> 
> Signed-off-by: Anton Johansson<anjo@rev.ng>
> ---
>   include/exec/translator.h     | 2 +-
>   target/alpha/translate.c      | 2 +-
>   target/arm/tcg/translate.c    | 2 +-
>   target/avr/translate.c        | 2 +-
>   target/cris/translate.c       | 2 +-
>   target/hexagon/translate.c    | 2 +-
>   target/hppa/translate.c       | 2 +-
>   target/i386/tcg/translate.c   | 2 +-
>   target/loongarch/translate.c  | 2 +-
>   target/m68k/translate.c       | 2 +-
>   target/microblaze/translate.c | 2 +-
>   target/mips/tcg/translate.c   | 2 +-
>   target/nios2/translate.c      | 2 +-
>   target/openrisc/translate.c   | 2 +-
>   target/ppc/translate.c        | 2 +-
>   target/riscv/translate.c      | 2 +-
>   target/rx/translate.c         | 2 +-
>   target/s390x/tcg/translate.c  | 2 +-
>   target/sh4/translate.c        | 2 +-
>   target/sparc/translate.c      | 2 +-
>   target/tricore/translate.c    | 2 +-
>   target/xtensa/translate.c     | 2 +-
>   22 files changed, 22 insertions(+), 22 deletions(-)

Queued, thanks.

r~

