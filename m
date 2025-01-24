Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC1A3C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 17:00:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbN2O-0005qd-55; Fri, 24 Jan 2025 12:00:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbN2C-0005mf-VS
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:59:57 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbN2A-0003nX-9W
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:59:56 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2f43da61ba9so3348579a91.2
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 08:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737737992; x=1738342792; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EyzSLdrnSlaoLoH41d7rkDSokRQub3XCHwJ1/lPMyoo=;
 b=rPYo7O+E5o+E3v27qPXz6j3mePiRSHT5oEhMzMsveR+wPja7Xzslei/Cdj/5IHrabz
 y3yM38OW5/kVGIymjO6zO8wGe1GIn47qn2lm7yox62ulr4c6i0oQHo43cp+UWpH5aVWs
 qdd/YxCKGZMRRZyyBtPaeCMbvv4VfLsEjaYcRAPgREdE6mxx7Wd+3ub0RjQ7kF5zC0mC
 sdeUcVX7E7ohS2Gz0rJslpOQSgm2YLCgTzf20UG1bvL6pvp8ubMF1ADw4VkznZ2HZsV2
 P8atb4Cs6IqewB/90XVMMQQcrcjYUU49UrDF4qWgJlnKauDYJ6XVddw6S1IW9QcBh1Ew
 wbpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737737992; x=1738342792;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EyzSLdrnSlaoLoH41d7rkDSokRQub3XCHwJ1/lPMyoo=;
 b=BujFYHfd7HR1WgDHol+fT48yx33a7MEG+WNwQIx2u8FPmszBgglCxrKlPTOGzIzZDG
 N1yJlYwO7wcRgvTZ7UDTJq7JXj/7xGiul8+1x/7GgFyMedSKsKDmmoB2xFbs8G4/Pcdm
 dKtBG0hYFQNKunkUTqtuTZdOEdBHOuswMfyFgYppfnJ80oBUI5bM3N/t6DRCfVHdNvUI
 VQIUPeQSgpCWcK0xdvvV5jPT+lSe18iugnwCoZPGknlaPPirWlbWs3KF4d3y5VsFFPKK
 PSf3/XTrMtv0HVDv8LwS6q9unezt+hr5QAnv6O4/ZtWXAmlszxh28PGQXZ0X4KYaEK0z
 5NpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlcyfdAHJ6nwe4M6l0b4fhogtt5VydG4Ll02Z2gfCfnUlax1QSjFHW0jWl4AqzdGKlHMpai7b/KyU6@nongnu.org
X-Gm-Message-State: AOJu0YwUwH++V9eXitek9S249ANwN41tg0wzIz96tT0nQktr+gQbKABs
 P0pSGqh3AAZHz7Ui92G/UhOqfRSlam50QpN6vAnjYJlMCpKCPPaTCeLpWiztsZM=
X-Gm-Gg: ASbGnctltIJCzTrWg3jWUjbMO+1hh8YDpdR5kVr3IIpltxtXHcKYoVJr3woZcvuekEF
 SYnxOd0sU+ARidBGTci/I+ujyJbuh9yB6WHL6LjjxLCIPuiqDz8iMveGxttMWZ080rR+IqWFxMF
 IHAvRtCxLe/LgMu0TvvpsGwy9+MPykPplmHl+afcHBa9ZiHz4ClxlI5kp94vkasxuopveKioUac
 v46azdyMJE0vOARUd96piulxDpAMGlmZfooqMqwXhJen+d9dIFAGAjd8CAtOE/WibUL11pTe57Y
 KkJd5gmarVsZPTRwnIkrvJq2
X-Google-Smtp-Source: AGHT+IFOVYlVzFkm1eGbZH6NyuseSSNXBSdAKJExMQXd2ARtNWYSmvU/KGoBB4vcws2TjmiJfRVY5A==
X-Received: by 2002:a17:90b:3a05:b0:2ee:c9b6:4c42 with SMTP id
 98e67ed59e1d1-2f782cb68fbmr48395990a91.16.1737737992611; 
 Fri, 24 Jan 2025 08:59:52 -0800 (PST)
Received: from [192.168.163.227] ([75.147.178.105])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f7ffa5700bsm1990591a91.17.2025.01.24.08.59.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jan 2025 08:59:52 -0800 (PST)
Message-ID: <9afcb089-2d40-4b0b-84fd-479e8cef831d@linaro.org>
Date: Fri, 24 Jan 2025 08:59:50 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/28] cpus: Un-inline cpu_has_work()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20250121142341.17001-1-philmd@linaro.org>
 <20250121142341.17001-7-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250121142341.17001-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 1/21/25 06:23, Philippe Mathieu-Daudé wrote:
> In order to expand cpu_has_work(), un-inline it.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/hw/core/cpu.h | 6 +-----
>   hw/core/cpu-system.c  | 6 ++++++
>   2 files changed, 7 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

