Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DDFACCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 14:38:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6rmn-0000N3-Nn; Thu, 09 Oct 2025 10:38:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6rml-0000L7-OZ
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 10:38:27 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6rme-0003u1-Ep
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 10:38:26 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-46e37d10ed2so8649865e9.2
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 07:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760020697; x=1760625497; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=N131MOr7NWc0jNY7I6e5tMt4UpjjgLVLMhM85UNdrCM=;
 b=XN0ePUZ0fKiMoKr+TcVyXQY73QHszXXwpi4vJvmowcAdCVNzavF6KEXgYj9mpXb7pY
 fTctvhJpUTTBuATqUNKnJUM3SuiG9sPXLnwzPHGLATW5LE/4JAx69BS1No6fdGnOjG5W
 g23xuPZMGBiF/O0x9FiYOUT7cJABNrwiuLxWLzZlDPo6xWWiXbkj7zWuG5m/xtF1ozE1
 ird1zTc2q+v+OwyUAaqYhwFf2oPLaot7SfKImnMrtoDTBRKsqRdk2XqB/Owp8phTvKnE
 EWVSkuReDEmG8KzfOQ6GMnqF9AgxYmGzhliDcgJ8Mzvn/G4EskpJIOE3J9ckxVVBEZqG
 C7Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760020697; x=1760625497;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=N131MOr7NWc0jNY7I6e5tMt4UpjjgLVLMhM85UNdrCM=;
 b=IvG0BE0dvHXZcx7fb3RtBBn/4afc7BpNdV0VhngpYw9SrvksCN5MDCyyzJfVVFZQR0
 fndVWXu/u8v1rp807WiWHDQ1rM6Jp6J8nVfJ+CMZbhSxAqzCXucmdyfxRH3KaFPSTjYW
 SBZS3Ib8tPAfoZ2Kg3s4hLwyRV/FyqEok8itiBuGyD9bEfh0tBQ4vQxhPKJophrga6bh
 ekYCtWwWVSdQ7MZkO2SlxlZEdMr5VACJJWPWFlnTSd8B/Ux72X4z5Bec77+zBr5AfRXU
 nUu4NPptmteopHcPuvRZLT8oiqRi0Zrqty3s1IodnRsgbRlL2hB3ONmrYbB+Hg0WVCAu
 bTOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTFHVBDWJHgO2kVwoED6aGJ0ql6s87ufDQvdDOENRSqgOogcTw5kMAQ/l+aDLTlRFxbzHWZPSSfnWH@nongnu.org
X-Gm-Message-State: AOJu0YykdrHsrfifj9hB78S76lpvE9bbHu/OgxPTf67jj3EP46V5DWeZ
 ac73BhCvUWpEDXt02pTMKpU1QE68KchBkyWatjJQEB9aXT4suVVWNa0hb9Mt9a/VXYg=
X-Gm-Gg: ASbGncufbYFg7HT8tQvnYsU+Y6r3yA6YsnjR6HiXPuQ5+v2YRlDYAj5tPdZawNxA3mk
 VupKCvAWbwdQFYzyBpzm/zW8hip5YqlKDyxHDBc/ZKVng4NkBkYrcPmf5O+tn8JDqvMTUuVrplF
 JXgpRf6B00IsJwANq7G/zGDk7dSc07OedS+rQblsN3UhaIjPl9z8JqTLvwMryUWxnaxK2EyLTVM
 mBsWXVMiIXMozFAkYDQqbXT7e8mJYE6/M0lRiCBMvKp9dHSfwmZrrjxMyHuzuuEdA5J7qzpgkxQ
 Zp5kj9vQj6d8eJakaPO1OMcgOpjOtGk1swF5oaVJvZ5nWo21R6Luw2Br2mPaHHyCqAp8ZeoRhar
 JsjMVI3nfYQ3P4oTo1L1mG+db2U+zYivVrhey3KC/fGJSeL752ozVmbB7S6glWCQ7Hf/ZQQIFRk
 E01A+tOJnfp6nY5U2InA==
X-Google-Smtp-Source: AGHT+IEZ5MBGVJ+e3E55+kDgbd9Ko5L87LHqB3gQeXKv02ACzq8/7QbzOuezihUdf2FEwgfJCyGEKQ==
X-Received: by 2002:a05:600d:8221:b0:46f:aa02:98b1 with SMTP id
 5b1f17b1804b1-46faa02ec6emr42930995e9.21.1760020697141; 
 Thu, 09 Oct 2025 07:38:17 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb48503e9sm433825e9.19.2025.10.09.07.38.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Oct 2025 07:38:16 -0700 (PDT)
Message-ID: <c971a473-fa19-4017-891d-cb14f3bf5c83@linaro.org>
Date: Thu, 9 Oct 2025 16:38:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 34/73] target/arm: Make helper_exception_return
 system-only
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20251008215613.300150-1-richard.henderson@linaro.org>
 <20251008215613.300150-35-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251008215613.300150-35-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 8/10/25 23:55, Richard Henderson wrote:
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/helper-a64.h    | 5 ++++-
>   target/arm/tcg/helper-a64.c    | 2 ++
>   target/arm/tcg/translate-a64.c | 8 ++++++++
>   3 files changed, 14 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


