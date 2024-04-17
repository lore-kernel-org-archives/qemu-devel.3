Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82452C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 19:26:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxAuT-0000VI-GW; Wed, 17 Apr 2024 15:25:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rxAuP-0000V3-H9
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 15:25:29 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rxAuN-0007ZV-UM
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 15:25:29 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1e51398cc4eso1007405ad.2
 for <qemu-devel@nongnu.org>; Wed, 17 Apr 2024 12:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713381926; x=1713986726; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NRfnxlsN15CLRf0ms5hTidgfbhzn8gd6ITWjZBiKVY8=;
 b=NtrIaXYQSEZGwMZLU/wqWSMiKyq+w563HeY2OjAIGRj1YTDKLDR4OoleeFqCmPkx+c
 33k2PeNddnO7P6evPRuVzkFiy568tpXydq0n9zE9OwcYc7+l4uVjnjzEE4e8wohUWl/+
 gUY7FjeBUWp9DdgYIbwTRSdtNBp47ch6whdZz71NUfDwdEhVcrmcYBgmzxI5c4RfwAJW
 P3UlvJbvQ/aWob9JiyT/HNaNG77oAfcrvegdE30ZD2ndFj4IZ3UbYE4vJRFIgRRtzjrP
 nKjCPbZFSUa8sqU88mh4Q+NAvgKirlpwiM3XvZ4cZOYq209POsFF89zY+5ZG99xfV/tS
 8fcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713381926; x=1713986726;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NRfnxlsN15CLRf0ms5hTidgfbhzn8gd6ITWjZBiKVY8=;
 b=bAjxFtlu02XhcJZpQE4rsnLGEHX6Zd4aqvSg8HkdXdIcX1lGKnCN3FgO2AvSjL64eG
 klb4BVr6F+lzH24oPZuSyvHwxSdWJR3hlZw4+LQwArbCTqwBsOlRMoQAtnTHoor1HC2s
 ba7sFuoE4HRqHwRzVQQAavdJkIwjQ7gLnqE2bbR7u+AhVJRhdLNZcsjCGaEXnL6BkX7d
 vh//XMi+VcS9kRROa81OyJkol9VqpZsLMJoV1A4b6iRMlAbOtDftswyzQPlNWBo5q0Jy
 ex/Q4gQfNhv7IWfo46txUKnigwi6xIe1x0gLHKKpvowLfBeZouBUAKrEGW1+lLVud+Lk
 9Emw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQSADGTHaVubaLibH0GdM+/FYkF8GR9eqqTNYbngOSooGtm6mOiK4THgmVs6qyTfxwmolrQwok3Ca8B7B5HegSOL2xaGE=
X-Gm-Message-State: AOJu0YzOkzU0QFK9B5KwYe5gYBQlXrUmzv9U71HBBvOTEAigftQZTAih
 jSWx3ERLTyZ4gohTlN0Gq/GKXlH3UQxbSMP2NUYETMLKMVQ7OyVpTFYx8qp1rS0=
X-Google-Smtp-Source: AGHT+IFogHj14Km9OWt2Kdv/7fn/3rffwrWT+/oFCVP9G1D3Eao6wjyrPIu77XR0dmzwm5mqfIecCw==
X-Received: by 2002:a17:90b:3848:b0:2a2:a10a:77b8 with SMTP id
 nl8-20020a17090b384800b002a2a10a77b8mr405179pjb.2.1713381926275; 
 Wed, 17 Apr 2024 12:25:26 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 z17-20020a170903019100b001dddcfca329sm11920734plg.148.2024.04.17.12.25.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Apr 2024 12:25:25 -0700 (PDT)
Message-ID: <5f3d7a71-e1ab-4d16-b2f4-d3c04183baf3@linaro.org>
Date: Wed, 17 Apr 2024 12:25:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/21] accel/tcg: Include missing 'hw/core/cpu.h' header
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
References: <20240417182806.69446-1-philmd@linaro.org>
 <20240417182806.69446-16-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240417182806.69446-16-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 4/17/24 11:28, Philippe Mathieu-Daudé wrote:
> tcg_cpu_init_cflags() accesses CPUState fields, so requires
> "hw/core/cpu.h" to get its structure definition.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Anton Johansson<anjo@rev.ng>
> Message-Id:<20231212123401.37493-12-philmd@linaro.org>
> ---
>   accel/tcg/tcg-accel-ops.c | 2 ++
>   1 file changed, 2 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

