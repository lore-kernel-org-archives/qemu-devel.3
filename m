Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6173BC87FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 21:28:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhELZ-0000ji-S9; Wed, 30 Jul 2025 17:28:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhELQ-0000dN-Kn
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 17:28:17 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhELO-0002mc-U3
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 17:28:16 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-24014cd385bso3743265ad.0
 for <qemu-devel@nongnu.org>; Wed, 30 Jul 2025 14:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753910893; x=1754515693; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=v78dqCYWBiNRyb3HUPd8tmeHfEqRKcyHyBF1df/n5Vg=;
 b=OOqebQZ5WRro59RQDpRnnvA/eCXNleSjLIVnysUcdo4Irr8LRjeZTRn7BqaWCHzDDj
 VJSgSY3hyAWgGQeSqNn26c4MOAZIBo0i5dhmIO8IZeus07Z9xQ3LfTc4ltNIJ4kgy38g
 yrWTg3XXWWaVw8/0158oQtM/jdOLHBtvK/dCHmJEnxtPiRC50F2CmtRbRWqgr3Fiab6v
 el8qKudDo7CXyPPrztMdNrBcz7kSgAY7+6JVs4LgH2OSk/DwygeUG5fhZDjaP2S2qvRS
 1sZX87soOv3uIzr//VdKPDvKoDfe0Pe4rEFTwvRBHQ0he37WFhqr5uAbcRqdcoupDPbm
 hbDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753910893; x=1754515693;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=v78dqCYWBiNRyb3HUPd8tmeHfEqRKcyHyBF1df/n5Vg=;
 b=cHRvyBHZOvC4F1ohEMlfLYqgS9sGkTsdKeE9vAOwoGzrcQrfCOhQkthyebIkOwl0zr
 H9hVQcvZiaDb6Vsc5Gwc6UfPbU5zYoGRUZDOe499mc/vHPm/TsXpxz3qresFEyPIhV8A
 fhjG4lVUcqtLQSTpUwYp2I7PkhinYPMbVJsNAAU0ag8J2H+yBpQDpM21jNukBhJ67nYN
 UrdWpISDf9RlEBwYzjTOwEKoyq8MimV+U5uqWdC/uI6QMlAYbG8dMRa+Gj+aXsdJAR81
 HpNm5mqk5bEHHxD4T2w3a62KhS0YraQ1ch4b7nWbM0MNQOasdsx0b0RihygCOdGR5SfK
 ITZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNFTJp/ua+axLyAa5B33VvVyBhjuF4xZtzKQwC0vV4sepb8p5VPilWoLXGQNTLiSZMUkRlHGaVcbeY@nongnu.org
X-Gm-Message-State: AOJu0Yy9zvCrA34GrUtQ1akFzNlsBoC6yFA5bKidkLgclpkDVEQ2OdKM
 7HXQgNMnKokRQHzeg9pUaGFgdtw7i21nSmPPtzEwGk5X7ueZ3T8XL0wbJD/ehX/Zq80=
X-Gm-Gg: ASbGncttsvaYIlWuOljMLVBH0D8KrwsHLzWw2FL/iuCCaIWbblzZKpvr+72VP68gqWs
 NcwiSuuTY/loYE7F1+E7TVKQ1mj0h96J8XCaXmP1BmkWdpgkq9NsJrGSx0okoIgCkmh2k3seJ4K
 qPmw1UFhlunw3ngEVFSdWqD/Qy7+v+BfICxe/BVZG+NelLJioySa55cN2EoCkCXbPPTf35tRbaJ
 lj4BHX5qkQJTeAuOpBJX7vvf+CuqpVKItv5iRgkLRRg0UNyOz9jN7acgWCr+I8fWdoKq9yRkjKC
 Tc8w6UJRFBiLZc66uJiDfjWcw3RLHO8Qq5ZglKqwnhnBNeyGVkAUPJyyfbzoghEy7kW6TtV/62l
 fy3ZWcAFJDkG3O59uS42lV90gHWsQ52DBh+M=
X-Google-Smtp-Source: AGHT+IFMhkMJ21N/PEKv8S/xGcu/Q9yOzH5z+FRDhuZXEl3Zqbj/lF53jLIgAT1Q/lXRgqdFWrpedg==
X-Received: by 2002:a17:903:22d0:b0:240:1850:cb18 with SMTP id
 d9443c01a7336-24096bcc7a9mr64400015ad.53.1753910893425; 
 Wed, 30 Jul 2025 14:28:13 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e8aaf87csm551995ad.176.2025.07.30.14.28.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Jul 2025 14:28:13 -0700 (PDT)
Message-ID: <4382eb8b-9399-49bb-bb60-56334fa38ec8@linaro.org>
Date: Wed, 30 Jul 2025 14:28:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 40/82] target/arm: Introduce mmu indexes for GCS
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-41-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250727080254.83840-41-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
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

On 7/27/25 1:02 AM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/hw/core/cpu.h        |  5 ++-
>   target/arm/mmuidx-internal.h |  8 ++++
>   target/arm/mmuidx.h          | 71 ++++++++++++++++++++++++------------
>   target/arm/helper.c          | 15 ++++++--
>   target/arm/mmuidx.c          |  9 +++++
>   target/arm/ptw.c             | 20 ++++++++++
>   target/arm/tcg/tlb-insns.c   | 47 ++++++++++++++++--------
>   7 files changed, 132 insertions(+), 43 deletions(-)

Finally getting there :)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


