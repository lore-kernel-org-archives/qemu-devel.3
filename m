Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E04B4FF886D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 17:58:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHmhe-0001hT-Ac; Tue, 28 Apr 2026 13:58:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHmhM-0001fY-CU
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 13:58:17 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHmhJ-0005aR-CB
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 13:58:15 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-43d73352cf2so9856329f8f.1
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 10:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777399091; x=1778003891; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3Aq2Gil1AMXyD/F9EJ4y46TV8rTmmGtXbXlr2sBHriQ=;
 b=PvQ52J+2I1VPjV+rC4vwcwqIcQYEA9JpBeekkOH/KzdAJ9+dRW5kByHCQAddsP2Yk1
 s/uEbLh34+bw8o0b1omAmAphuxA17haSowh5zv34o35ZtlY/XvhRFR9A7g1vba3bN67s
 7qyukaEbM4FBH98mR+PLi30ltOpK+7KmRLFyCEwrBFsVwG2uFuMTGwkkf9afmXnCJx1d
 +ifhWqr3mIZzLuDV8j6SDMX3H+NPhgXq94WT2Cxt1GM4FQ+C6ZZBT3vma/dtDWRRU43f
 wdzA6e9uyFcC9FInIlTeSUyawinxl3XKeWAi8rqE7RiJWPYqoW0Fc7p5Z7KjJIdFixGC
 VPtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777399091; x=1778003891;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3Aq2Gil1AMXyD/F9EJ4y46TV8rTmmGtXbXlr2sBHriQ=;
 b=Ij6QVjpevBsnFvTaXdOOAFQKgx34DdowOIjL3y4EtHDWK1P4IbUSYFAH9C15+fV6LW
 VDgV7PK/OR3+ZvnTKh/PW7auP2hdYFUhimYixpBzlp30qF01TYoApdOmI7u7MH0oHJEz
 zkKDCKWq8p2oOgM+T6CHn6y8vAO9UZEGqRhRbrlw/KZxc9/Z+xeIvuIoitsFM5V6kZDp
 MKFFAOrwxDQiZawVyVKIq43ku/5c5TR7rSkKbE+8Nx/oLnc/wOzBUns45H73pTfNOQ3w
 KCAoT/YdI8rUrO4zQNnCcesSPARKCqRA2yqxdWCGK8gt2OmAZI3W4PWb5P7vup5JRgdP
 /TpQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8kw6X5GWRGEtKK4WGvEVxNF9UMYx0fqV7G8IPZqYrGc7IZ/uPOoDKvzSbpG0Y7fuqbYKdBp0023rKU@nongnu.org
X-Gm-Message-State: AOJu0Yw5LVL7xGPlthRU529qGjowZ9skQguDDn8I9st0yRuIU3C1kzu1
 CTHO8tcZRGAC38ntSNWxFsDdPHyMwXuo4adDkRSoKBvMOiRMcPscGbamhM6BOd8p9c0=
X-Gm-Gg: AeBDietm0dP0xZDnqnahECFNlr3vvSLf5G9hFt+qEtls5cAmUorbF2iZDhsf3534EQw
 yc4whanEaGdxbcPz8XHpmXE7k5D1UMJFzbBLznhc3T1pTYah8W39NRH77mCA7hMjd0k2FWsFSiL
 yuRZibVGS3O77Szyn+997NxWJF2Wfw9YWiF1JRfxxLIUwBcXufJvrF5AUsZ1PDf9ddzosabnChn
 /7ng2mtO0vKgtLKl+ZweZQXEZO/w0z2JdNj59kqEuhLagYa4O3/bjZUy2/6LU9GuVQ4iIPTCZBe
 L87ndD2xeU7Lf9p0RdYS/GRgB612SpNC0qVnvet6ublfTd2y7nqsBCAp4ZopgRUGs45xrK9R+Lo
 y3Mi9Z5mb6vD+LnWX5ty4PPoLu2f2hQgSNXTNufkkcVsyn11lschzzZIdU8aMmSSczrI8tnpwwN
 xfYLR7hJrfGqi575vxzgWs1Vk6Ql83+bwdliEp0yfxstxJWivHi52M+Y+ieDaWrVgs/DG1AzgvT
 jX4
X-Received: by 2002:a05:6000:250f:b0:43f:e41d:85f2 with SMTP id
 ffacd0b85a97d-4464839c9bcmr7788263f8f.2.1777399091141; 
 Tue, 28 Apr 2026 10:58:11 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4463f4c07a2sm8261041f8f.20.2026.04.28.10.58.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Apr 2026 10:58:10 -0700 (PDT)
Message-ID: <e991f3fc-9a82-4383-bf11-13e39e2995e2@linaro.org>
Date: Tue, 28 Apr 2026 19:58:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/vfio: Drop superfluous inclusion of hw-error.h
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>, Tomita Moeko <tomitamoeko@gmail.com>, 
 qemu-trivial@nongnu.org
References: <20260428163702.3224323-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260428163702.3224323-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 28/4/26 18:37, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> None of these files use the hw_error() function, so there is no
> need to include hw-error.h here.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/vfio/device.c      | 1 -
>   hw/vfio/helpers.c     | 1 -
>   hw/vfio/igd.c         | 1 -
>   hw/vfio/kvm-helpers.c | 1 -
>   4 files changed, 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

