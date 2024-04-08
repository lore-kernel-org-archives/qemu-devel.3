Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2779C67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 17:03:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtsOX-0008DM-Ah; Mon, 08 Apr 2024 13:02:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtsOV-0008D9-1d
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 13:02:55 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtsOT-0004pB-DE
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 13:02:54 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6ed0938cd1dso2664679b3a.2
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 10:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712595771; x=1713200571; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=p76AuJayCoePe6a3spdAnqPhR7tC1nBB5VopZ7P4sds=;
 b=igwZGWZ0tj/Oa7IJwJSONwIWqc4zYl4S4PcqTkqL2bEwc/tVeORv5/+QyViEF1phlB
 K4qaOxuilxxNzKYrfNshVvrtom1rB3VSi/PiPBqI6Ib072A9TBx4Bmt9oiam2ctzd5JD
 c4jZKonc2rVqdfdAsDs3PQquxaGyJX1bPg9pUeoJliCezEHvy2qECY0K+7uYUIA823TL
 tUfyH43NGJrCMaFX4uH8ZWwB5N4xE21HV/t1hEgE7JWS6Gc4egeUgDnsLC9eFRs+ya8E
 hfjiWToYNixn4kjazO6NQIcmqngP9iANHhcrB6byz5vFpKzeTs32IDWDx7FYVn8zYTHH
 TN6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712595771; x=1713200571;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p76AuJayCoePe6a3spdAnqPhR7tC1nBB5VopZ7P4sds=;
 b=RouDortDHsIqYmvdHHog62U+p5hiQT3eJrjsF//GKE/FvDQwO1LxDjn8FA9235EirR
 YDgnQNAXLN9QmFoFANXZOQ7MLYCcpZ5m56/Nx41ZGKOhq2336s6NzdFQrrwuFLV8NaJW
 eIab32lS1ODmyPUl7/HQ5elTt5KVXvwclEKj9BCRQT5xDpxDMo61TS+bKhsL2gU1a1rN
 SayYdzAb+VgoT+JSn0RQuFBff/++ujO+NmyX2+MQqNAraKk9MFgEG06Dm5rN9PV9CE8v
 76cARnHQQCz1A/CwlQoVOt3WpGgZIdkvCB8suXTxW9UH9GaCPgPLabhNRGKgzfCBV1qO
 Mb4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9GPJgWDUusibA6bEfLtRThbNiCZb79tGOIKcV3nz5K4VqJjgb7EAwuqXAU8RNfxn1CNA62LDZqWOP2mkCo5WVM3ACDyc=
X-Gm-Message-State: AOJu0YyWYAbntWU2gsu8hROdhTrYuEXu4mm7Uki4h9fvHkbG8aTKIvqU
 3y7HFsCjZQNvXdc4bhSCZ5RYhYm1kypZrnaI6PF56DNfX3gxoS6DKnB362ho3fA=
X-Google-Smtp-Source: AGHT+IEUj1rMt4rrkq6x1Ap4Zmm8j3R2jUxTxT4/Y9cLtJQQ2OYB+KVvJWVtCCtDQ9lYSuhEJrsz5g==
X-Received: by 2002:a05:6a20:3241:b0:1a7:807:ca2 with SMTP id
 hm1-20020a056a20324100b001a708070ca2mr9728269pzc.29.1712595770996; 
 Mon, 08 Apr 2024 10:02:50 -0700 (PDT)
Received: from [172.20.1.19] (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 kt6-20020a056a004ba600b006e697bd5285sm6800115pfb.203.2024.04.08.10.02.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Apr 2024 10:02:50 -0700 (PDT)
Message-ID: <991a55ad-663c-4bcf-ba3d-4a3f7ebc49ae@linaro.org>
Date: Mon, 8 Apr 2024 07:02:47 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 18/18] stubs: move monitor_fdsets_cleanup with other
 fdset stubs
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20240408155330.522792-1-pbonzini@redhat.com>
 <20240408155330.522792-19-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240408155330.522792-19-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

On 4/8/24 05:53, Paolo Bonzini wrote:
> Even though monitor_get_fd() has to remain separate because it is mocked by
> tests/unit/test-util-sockets, monitor_fdsets_cleanup() is logically part
> of the stubs for monitor/fds.c, so move it there.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   stubs/fdset.c            | 6 ++++++
>   stubs/monitor-internal.c | 5 -----
>   2 files changed, 6 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

