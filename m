Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5817AC5478C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 18:30:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1refjH-0005MI-UT; Mon, 26 Feb 2024 13:29:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1refjG-0005Ln-1s
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 13:29:30 -0500
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1refjE-0007WH-9u
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 13:29:29 -0500
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2d22b8c6e0dso35701821fa.2
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 10:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708972166; x=1709576966; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FI1hKicCK8zs/vgaF8e68TNy2vSotfEUghqqQ0cpDbY=;
 b=n5+aAJ+0fJys+s50CCE+tMhmvnzUDVsJCfUg8EB7/y25lK3O5ID5qGgKigQhizrOUN
 iuXn2/K0U6vJ05BnRx/t5VYhROFPWBOISdQ5A9owR+C2ykS35pvkM3m463fBB2E7n10u
 u3kX+w0QkPC1ZDVGyJXPf69T8sBL5uLB0im9UqvUPcQ/wPWhdE/T9YL+dGjLG6s5fkAl
 mhSVK7bw4ayFNw2omb5OVNLdJ40eSq8k7GKdjhzrqjtHOCs/YWP/S55Oao8jeVG9gQNS
 lKYmD8y8Ye0ogJu36uO81sQqkR+HVn0M9mnTaEdM2aV3AUnyI3Wugt72+AtKutGaQW08
 U78A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708972166; x=1709576966;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FI1hKicCK8zs/vgaF8e68TNy2vSotfEUghqqQ0cpDbY=;
 b=lMNy4C6+YzXz5Ewapfib1p0izXaxTeYB2dzseaBEiaYr8L2ENDbACUKOzWxMmY6I1E
 FH9teRkB/Br1NWVToyiDcFyWfRxm4mafKIrUXvJbShXO9MF38gAJ8jRCUT9/zDQ1azx3
 iNorctmmhu+xp2dG4KqQ/W0hv1vdumJT4NWFVGhvQVtD1tG7/4qkDvAKej/siLDIYoJH
 aUG1rPsCEqSENpDD1inqhMLuD/zikcRmjMkhPkPuYv5kt5mNJE5vbkO8HZkxCPzEgl+l
 QBhVYYbekS9IRLNVVOSobpX+pbOxNIpL5gtBcDQSonTecJ45yFgEMwzCBJdO30M2w+3u
 XfXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6FMEVhqaHj5BCZRLaFw2sfA1Yg6i1Ae47F+s7vtRNPZ79vIOU95jsn6oHzJLm4o/Ha+PmmO9O1d+z186FriY8aZCrv8g=
X-Gm-Message-State: AOJu0Yz3tmL2fzk5csBP4wBHrkuxymV3jHTR9neDnNAxqkQviq++SOY+
 9eMiSSsejzqIHJpiOqFtHls0egEDWVS/BtQWDpHYxDwePBNQCStYR0tZJ3SazH4=
X-Google-Smtp-Source: AGHT+IHsfksnUEgbCps88fZLjVDfkyacpYeqo6LPnUJvVvYLd9u34jxLU+RG+iMSRHrCw/9Qcg9vFg==
X-Received: by 2002:a19:f018:0:b0:512:b245:402b with SMTP id
 p24-20020a19f018000000b00512b245402bmr4232150lfc.17.1708972165811; 
 Mon, 26 Feb 2024 10:29:25 -0800 (PST)
Received: from [192.168.69.100] ([176.187.223.153])
 by smtp.gmail.com with ESMTPSA id
 p16-20020a056512313000b00512dfaf4399sm914696lfd.229.2024.02.26.10.29.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Feb 2024 10:29:25 -0800 (PST)
Message-ID: <0f4c424e-be6f-48b9-9c78-fcfa52594bbc@linaro.org>
Date: Mon, 26 Feb 2024 19:29:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] virtio-iommu: Add a granule property
Content-Language: en-US
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, mst@redhat.com,
 jean-philippe@linaro.org, peter.maydell@linaro.org, clg@redhat.com,
 yanghliu@redhat.com
Cc: alex.williamson@redhat.com, zhenzhong.duan@intel.com,
 jasowang@redhat.com, pbonzini@redhat.com, berrange@redhat.com
References: <20240226181337.24148-1-eric.auger@redhat.com>
 <20240226181337.24148-3-eric.auger@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240226181337.24148-3-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22f.google.com
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

On 26/2/24 19:11, Eric Auger wrote:
> This allows to choose which granule will be used by
> default by the virtio-iommu. Current page size mask
> default is qemu_target_page_mask so this translates
> into a 4K granule.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> v4 -> v5:
> - use -(n * KiB) (Phild)
> 
> v3 -> v4:
> - granule_mode introduction moved to that patch
> ---
>   include/hw/virtio/virtio-iommu.h |  2 ++
>   hw/virtio/virtio-iommu.c         | 28 +++++++++++++++++++++++++---
>   qemu-options.hx                  |  3 +++
>   3 files changed, 30 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

