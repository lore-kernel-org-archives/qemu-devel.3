Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA7ECC3ABC3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 23:01:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEycE-0001aF-3U; Tue, 13 May 2025 19:00:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEycC-0001Qd-AM
 for qemu-devel@nongnu.org; Tue, 13 May 2025 19:00:48 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEycA-0004Aq-0i
 for qemu-devel@nongnu.org; Tue, 13 May 2025 19:00:47 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-73712952e1cso6226580b3a.1
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 16:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747177244; x=1747782044; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ir/1/tsToGqifehU7CVjcVeSXnS6KPaYprIQaDhJFKc=;
 b=fvgXj35PWWiCirIHY/+HajZOj4wr2OpxbAbdcmke1CMNA4VLIABuXtlaqja4v3kZ+e
 qlcw+bZVVysvmYjcIRgplZEJsqp5OX2zOX7l7VtAKZHRoFjfXXAQX5SW3eYoaL2LeldB
 d7acntt+VNzT751CipgqwD4/3wMVKqVK/T+01iE6I2Fukmg1OQ6Wt2CcXvzpVCLAgLB/
 VviHtQa9OWna/pBMK+QWkAbk4Rr94b4mBXdAKOLll8UV4RZ4ho8Vodb+KGSuxWga8U43
 Di+KxGgvfUcuHKLq/dsWwC+1agi9P//+hdY5Pnad2GZAUwyzXYwKyrBeN1twSXahgF3w
 7x8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747177244; x=1747782044;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ir/1/tsToGqifehU7CVjcVeSXnS6KPaYprIQaDhJFKc=;
 b=gIIEpD8GEuJ2Jl/a4Nnzq3rlIZkhtMujEV48NsmQoFKIjAi6AR+dKDv5HeECKiwP6W
 /wvlMpDl8PHQoVrFxxnYxMBOPCMuPnwKkUAe04AYYFrHPiuvTTnX00g1Ju+iOgrFF9Kg
 4TdqaCO+iakj+e1snmExb04YPGyzNLtYI2OQ0ukVBxg8K4j+RjA+msSPIoqskm3P5tSU
 ofHokjpe/kECevSDfKSWADjYujvyj0Nxll5lp4q61+oIfE2zwI0w4Tm3o5CSQy3qpjRF
 owdPlahdPAyGvoAye/FMt6mhWp99yAcCi6OIOWrSq4Tt2/StQzWHWy3kuajG6s01f5Q9
 Pssw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVT4bZMKRW4YBNEc9CBDKBVlYcOtzxJIgXM7cHo3NwodsYCj4lgE0GHMhzCzM3IHMzgUygVc6omhgIJ@nongnu.org
X-Gm-Message-State: AOJu0YwgXmNiSlLkK7r4mvr92XeHyrGNSec2Fb8t/b2zShk+rOVfOdPB
 3QG3mKLeYZtmeXZnIlOxFgXspygkqCYarzY51183rV1TKoJXvg6Qk931QHbfknM=
X-Gm-Gg: ASbGncuOEwIXpPptPLImiYXXOBEih/DjgBcENGKi0YnP0v+Pbg8vhF/IiOxbSp9imRi
 y2GY4+6snJ1qUn8csD70VCXYmxZ+3Asbxo85PKqP5zjjB/AI5Ay3NlZmRjUe4pUz75+3etPx2Hl
 hRWgyqjSFMIety2E/EwYu42PXwobEaYojyBbd8O9ZEixiM/ReWz6hwDErn+OwTCMszhDlWEmWHf
 F2kbYPkKAPa+MIF0XvO28UbXwpx1vtgq8oViDePaHQnEkgHO9KOpVM/A3FErcfcecY/o3LLVCBD
 mgBZKk8AZ1Ziu5hRJt+Ab51c2VDZRKbobRrLAfH8/cWqWyePRQH22z4yn4OqwXsmWTyfYj5USjE
 =
X-Google-Smtp-Source: AGHT+IF0Of5YuIpJJCbtenvRP2Bc5Eh74V2IHQ/560/CALeetL/sH2E0bKZ/MKWfJAG8CLHU4da7rw==
X-Received: by 2002:a05:6a00:194f:b0:734:b136:9c39 with SMTP id
 d2e1a72fcca58-74289346a5fmr1607132b3a.19.1747177244526; 
 Tue, 13 May 2025 16:00:44 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74237a3d1e7sm8131395b3a.126.2025.05.13.16.00.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 May 2025 16:00:44 -0700 (PDT)
Message-ID: <1af32893-0f49-4a0e-9ed1-80c0592eaa58@linaro.org>
Date: Tue, 13 May 2025 16:00:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/19] target/arm: More header rework around arm_feature()
 & multiprocessing.h
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250513173928.77376-1-philmd@linaro.org>
 <d05792d0-3164-4504-91b9-1570d668653d@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <d05792d0-3164-4504-91b9-1570d668653d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42f.google.com
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

On 5/13/25 10:42 AM, Philippe Mathieu-Daudé wrote:
> On 13/5/25 19:39, Philippe Mathieu-Daudé wrote:
> 
>> Philippe Mathieu-Daudé (19):
>>     target/arm/tcg-stubs: compile file once (system)
>>     target/arm/hvf_arm: Avoid using poisoned CONFIG_HVF definition
>>     target/arm: Only link with zlib when TCG is enabled
> 
>>     target/arm: Always include full path to 'cpu.h'
> 
> Missing review: 1-3 & 19

Thanks Philippe,
hopefully it can be pulled at the same than its base series.

Pierrick

