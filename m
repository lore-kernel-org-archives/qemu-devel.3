Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EA93C48297
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 21:51:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXTLR-0007wq-5W; Tue, 06 Feb 2024 16:51:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rXTLP-0007wC-JZ
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 16:51:07 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rXTLN-00086i-35
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 16:51:06 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1d93edfa76dso8725ad.1
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 13:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707256263; x=1707861063; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lO1js4YTTotuzqoFGlHNRmsl+7c1P8LmWDHVkpLbSHI=;
 b=lbtlw7KmMi20NjBqpOVD9+xyoIddHpaQZyFHIkyQkSAZIABPrP5Sr0nxz/TG3ThoEv
 ThXX1N/40J5XfWgk96fv0SjF72v0tqm/t3u49fZMM3PoF4SBhdjsFeiP2DQUHOZnDhl4
 pFCxzEXTVIXVBnZGIF+0PbtuDHzoskyBghxz3Xc9IC5Lx35mUtENxdhC/r+dQfOIZZXN
 YpL7LMku2k4vtXPKYzIHmhCdCYtgyeU4+U++e2rojckuO9Ph+MaN2Y5i1Ik+KDW70aFJ
 wcr/30jQqGsxGwhSn1sYYxH8UdOGsGpP3iLM+jRpytFjd5E2yaPRosPrBPGeBFQDDubf
 Fk1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707256263; x=1707861063;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lO1js4YTTotuzqoFGlHNRmsl+7c1P8LmWDHVkpLbSHI=;
 b=qWO2fpwwj0+JsFArJnsz9aPp6unMiYpF3zpGdlBSYdXhubn5MUvB38AfI6uE4l0Zo1
 a3dQycPOqzVTT+2EzpV7LtusiAN/ildEGppO6a2nPj+L0qsPbvwVazvhgVOx9O1++qpc
 0lc53DxmUxSuIKwAhRyjeoCJr7L1S7n1TTjdidDRpArMrVxs9mKFmVU0ETTXwRUvCiNl
 Zpo1GhppzK1FOIlCEX1JGtMZx5oKF8UMrQba2iIw1aQhsl88h+3g9ggatayR2hhcdclE
 w5zWSMbXX7KtKEHbrtbrJ4CSuJmSL6K8FkNGX722V+dWV+s8/X9UG2uRU/m8dQkiyneV
 nAgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVV1mzXebNBWplciZLGcJ1+iF4llbktVJDhJ70QRrkYDv4k+o2RLyWclVbUNe4cRA/w1o+igPkGcKb9ktC8XEOcsDvaDcc=
X-Gm-Message-State: AOJu0Yz50M9Tg7eSh4TH0/h2PNjfZ3ePdBVbpfXw/UFdeHUuWUMW3U5B
 kuR8wAHLZEB2g7lT6DTwUsJo/F3HnheZJrlx10JeH5azb939F87NmDtwdzhE+2E=
X-Google-Smtp-Source: AGHT+IEDMDHcUmUOvYS/3nReiYVopWTOOH/b6dJ+5JlL8vYSAs5DaR808NlPjys2MtU/tb7YgAubIA==
X-Received: by 2002:a17:902:ebcd:b0:1d9:df9d:bcd3 with SMTP id
 p13-20020a170902ebcd00b001d9df9dbcd3mr2959332plg.46.1707256263382; 
 Tue, 06 Feb 2024 13:51:03 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXGYuJvgQhJAFPd1hdveV1BRy/oT3lQISqzU7j+vB/SnKytt98ny8Ch3LxXSrIrOdAOTIgxKKXyreOwibEHF02ubfjOHdfkTRZ9uG2zBXHISza/WAhL8t+bDJQ=
Received: from [192.168.0.100] ([43.252.112.200])
 by smtp.gmail.com with ESMTPSA id
 o9-20020a17090323c900b001d94a3f3987sm2356974plh.184.2024.02.06.13.51.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Feb 2024 13:51:03 -0800 (PST)
Message-ID: <94d96365-1d93-40f4-96ee-e3fcb14a8040@linaro.org>
Date: Wed, 7 Feb 2024 07:50:57 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/13] hw/misc/mps2-scc: Make changes needed for AN536
 FPGA image
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240206132931.38376-1-peter.maydell@linaro.org>
 <20240206132931.38376-8-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240206132931.38376-8-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 2/6/24 23:29, Peter Maydell wrote:
> The MPS2 SCC device is broadly the same for all FPGA images, but has
> minor differences in the behaviour of the CFG registers depending on
> the image. In many cases we don't really care about the functionality
> controlled by these registers and a reads-as-written or similar
> behaviour is sufficient for the moment.
> 
> For the AN536 the required behaviour is:
> 
>   * A_CFG0 has CPU reset and halt bits
>      - implement as reads-as-written for the moment
>   * A_CFG1 has flash or ATCM address 0 remap handling
>      - QEMU doesn't model this; implement as reads-as-written
>   * A_CFG2 has QSPI select (like AN524)
>      - implemented (no behaviour, as with AN524)
>   * A_CFG3 is MCC_MSB_ADDR "additional MCC addressing bits"
>      - QEMU doesn't care about these, so use the existing
>        RAZ behaviour for convenience
>   * A_CFG4 is board rev (like all other images)
>      - no change needed
>   * A_CFG5 is ACLK frq in hz (like AN524)
>      - implemented as reads-as-written, as for other boards
>   * A_CFG6 is core 0 vector table base address
>      - implemented as reads-as-written for the moment
>   * A_CFG7 is core 1 vector table base address
>      - implemented as reads-as-written for the moment
> 
> Make the changes necessary for this; leave TODO comments where
> appropriate to indicate where we might want to come back and
> implement things like CPU reset.
> 
> The other aspects of the device specific to this FPGA image (like the
> values of the board ID and similar registers) will be set via the
> device's qdev properties.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   include/hw/misc/mps2-scc.h |   1 +
>   hw/misc/mps2-scc.c         | 101 +++++++++++++++++++++++++++++++++----
>   2 files changed, 92 insertions(+), 10 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

