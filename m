Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB3B9CD4F49
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 15:24:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOzpk-0005NB-NS; Mon, 18 May 2026 11:24:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOzpj-0005N3-RC
 for qemu-devel@nongnu.org; Mon, 18 May 2026 11:24:43 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOzpi-0008Uh-C0
 for qemu-devel@nongnu.org; Mon, 18 May 2026 11:24:43 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-836ed29d1e5so975725b3a.2
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 08:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779117881; x=1779722681; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=peJ3zYa0IY/wWSmv1ptMi5AxV0aHOvKrVOSHLnsQbkM=;
 b=YffpZ2NA/D8KgdxVXfPDfsX3hTOZI/ZWrlpW0YcNi189hX7lNEZj/YkbSR/6i9i4mj
 wPg7AKWfDhYhTtknomwBJAJGL71Qo2wLqrPsO1mm/QGeV20QhAOH+dgXGpYBIBTx/tmK
 /yCBxDIMn5hNTDchkNXvhj0/rEZjVA43jeLoExuG0X8Yd8eW6s5f7peeo4dvIPoh10BL
 bcYs4zvFQxlIkr0BvP1zWqocr+qhthv6FcFqBTBm7ZrlA9sy6Xqa21rgA18dfzyX0pLC
 8NhBQNzy/AtMnbWniFU5xZiFNiP7PqpZFsI+qIn2v/WwiV0k6U0XlYbptaG2p4GchM7o
 CjAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779117881; x=1779722681;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=peJ3zYa0IY/wWSmv1ptMi5AxV0aHOvKrVOSHLnsQbkM=;
 b=MAT14PQuq6eqAtBHWa2b1Hlwu9XLnVl8RCalZJH2rSdu5bajBHj2riLna5bAitICIA
 M+Wy2fVhAOXQe+ofrJriHiCGhrz4CFBgo7ZszQzcEyjuXHsX1kxW6ZJMBvnx+TCGAs2q
 ygVT6CkabvWZDW9MRgFBXLMxxV679IKOjBsk5UroWlubh97H+ZkZ145ILjYjU9foVLfc
 pp97eNZ26XI4t8WTdyyq9jiITIl+m2mqms62Vhtwk1as/iEV0BVeHqDLdGrue/yuW4o0
 xGCy6BN441EqX7rKmS8thgPdLAbpzEDF3G7f3KsvyEuznHQHMwR+8127tuoCbSUkoCvh
 vJBA==
X-Gm-Message-State: AOJu0YxKCaDaBMH1o7FpBojuid3d7nHCrUZSFReWn6D3grTmOVvPFrpn
 dlUyr+q/gG8gNTijI5sB8V0YRW5sQVR8Nc/ZA9RxBzKOIDY8U0etozckxfRREYg2MEwd8dQMvF1
 r5mifkPc=
X-Gm-Gg: Acq92OGvP99ixsoktO5dLIgt9xUz5McSwNlbew7M0ozQq115eOBaleMHw5W7iri6HRP
 O7E2YKollNpblDDUOrekBM8ELUHSXSCf7NO9eNS4n5Loa90eHH3szkPESbQoB1Iath7mOcs8HIC
 pmaOfBkI9iibfbwP1T6EGSCx0wbqXD1n53OOfRHlZyhqxgGhPijL+f72UF3Tm1vq7h2P58bcyZ2
 UCxissaFxRWBlIWECxM3hFCy5TZ5HRXJCgp0+Xkw5FkD1kw/6G5xrAz+ty9dpwmz3N9Dd7SYocz
 RnjIToOyFfmSJtHH0D2L1rkuA9d7PpDxwHYKKM4XKV3ybBoP6K69EO1NPU8BuhBAuQfu68KWGBf
 aNZL4xVELPy4ANVC1IpBZBzA3YSGQECLepwojRu662TyGRZDA/o/GcZBzIzbNLlASElgxAlf6MK
 FgJEkAkrqdsJjrWxaLPm6Aa31dMSyHcN61dxSh
X-Received: by 2002:a05:6a00:12cf:b0:83c:928:6e5a with SMTP id
 d2e1a72fcca58-83f33c8794dmr15510244b3a.13.1779117880782; 
 Mon, 18 May 2026 08:24:40 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f19c77162sm16362613b3a.40.2026.05.18.08.24.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 08:24:40 -0700 (PDT)
Message-ID: <44635c94-a555-47fa-8d78-98992fac2dc7@linaro.org>
Date: Mon, 18 May 2026 08:24:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 04/14] target/arm/ptw: Flip sense of get_phys_addr_v5
 return value
To: qemu-devel@nongnu.org
References: <20260515142541.571911-1-peter.maydell@linaro.org>
 <20260515142541.571911-5-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260515142541.571911-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 5/15/26 07:25, Peter Maydell wrote:
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/ptw.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

