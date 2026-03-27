Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E477C10F287A
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 23:25:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6GYq-0007IF-BG; Fri, 27 Mar 2026 19:25:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w6GYk-00078o-82
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 19:25:47 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w6GYi-000729-OC
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 19:25:45 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-486fe655187so30961445e9.2
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 16:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774653943; x=1775258743; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Xl3xeWk/amskwF/NXuAie++rDm6J2kgdPA15m364cHE=;
 b=EKV+dKA6X/h/JdVnS+noMFtPNqwjeDKTZ/JIWW+RyruERYsWcHLrnYTG/WKB6X+mmm
 fdH12KfU0CSW+QW1VYHxGuD/xmkf9WMr6pS8WkhIZaouO+MYjXTCGecYl5fuLXX34/k9
 Y5iSUCJmuEwN8usJKR2KGU768EAA5Rn4VQjOKXn9TysKEzBptLPsvhDsaEw9sqCtDc3b
 VWc5Gea8KOg4fdSJ0H7YMvEdQY8JyzyZpZtikt61/8K217zcUXMxB6c86Ojzra3Aonbz
 pdMwo+0D5lvWSQjS6hHneiImw5NtRf2fpfTbFbxYs0Zekf7gSdBvTe25fHBv+Rya+vIY
 dXKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774653943; x=1775258743;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Xl3xeWk/amskwF/NXuAie++rDm6J2kgdPA15m364cHE=;
 b=ouKy+3YYwbOTAVzPY2KkNDGG0imsfVpzBmb4NIzPTjVuQfDkAd1tQLw7g787mMXtLz
 85OTVMii7oy9CUNIcSJc96AlxKEFbOyqrJe4d+MH4HmcolODQDqGzeUppDlc/LNdCPDy
 fhzhWkFj4YU4POtlB0xu0c4EzIogEVB54ZazBYENX34/U+suvs4visguz1B0j+OFQ6HZ
 KfMroT/ryGRclA0JL8HFZeq8ho+m1DQ1zuiEURdLhmtA2lN/WdKU/zr8Ff+1YH1LDZFB
 dIUMDHx+cDIWS71ct7kM92DfMwSeP8MvEUlL2Q6pyWvdQmPnY8WBQWLOPlitavmCsh8B
 5r6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmtTNeNHzikgbW8eonymcKqXUKC8jJc+ENUL9C8N22QQGC8Rsown4kjVPFfUwKWjBm525vE6ahIHEg@nongnu.org
X-Gm-Message-State: AOJu0YyE42oKQXMJWNjE4Qbcy0Wgn0NBj9ILGZ+bxNu/R6J4lwwrR0SM
 n3xzg1aKDx6BLFXz9xXcclXgbzGMmx7ecauP1ec7wGId+SlT9hPiLAZLiakzijH0UVg=
X-Gm-Gg: ATEYQzwIoOvXn6XPWYDTdQr41vQ9VDRh50nxRwpV9tCob0K9zbvD+wx4xbsb2VNo3qz
 b66k8PmzyYE9HKpfZaHgr9ifd+WmdKZ+VkOHmCZ/oUw70Rk3ipIDeTBA7y7B1coHw+LqmrFeBod
 j0oSsAL7tOcF+d4aNvhnfT8mdiUmLVMBSJ+7/hC9ItEJeZn17bk/wN2OF4SitN2tY5hrDUJQxEc
 J05FBw3PsfkYn/gVkhmGKMqDrHL0LpfjGQSbwUwOT1WNpo2CQ2MrYGpYaJ5HtGohi4awJ4Liavl
 lyVK8gTG3eLBKu03HCGit896WQQe2r3x85bDsqc0B38tXeFeTdTMWJKbAhY1oNpz/UMpgSbQ1uy
 0s/aXEN06BSjqBuH5feIK+xlEo2haNd9aoRkq4WGZeJ3CAyLdsaoa+BirN3FO89C39Iq48TaQyX
 T3vtoOfcd46anvnY27klxW3n4MHyJSOotwba71yQm/d+0D1WCwtMTVQHfSbM6fYg==
X-Received: by 2002:a05:600d:8451:b0:485:40db:d40c with SMTP id
 5b1f17b1804b1-48727d4596dmr61518595e9.3.1774653943179; 
 Fri, 27 Mar 2026 16:25:43 -0700 (PDT)
Received: from [10.202.147.66] (147.149.216.82.rev.sfr.net. [82.216.149.147])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-487278c71f4sm44409505e9.0.2026.03.27.16.25.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Mar 2026 16:25:41 -0700 (PDT)
Message-ID: <acf34f79-5713-42a9-b841-ca3b17d77190@linaro.org>
Date: Sat, 28 Mar 2026 00:25:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/12] target/arm/translate.h: remove tcg-op.h include
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, jim.macarthur@linaro.org
References: <20260327165042.604105-1-pierrick.bouvier@linaro.org>
 <20260327165042.604105-3-pierrick.bouvier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260327165042.604105-3-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 27/3/26 17:50, Pierrick Bouvier wrote:
> Include tcg-op-common.h instead, and include target specific tcg-op.h in
> files needing it. This intermediate step allows to clean up every file
> (TCGv, tcg_gen.*_tl.*) in separate commits.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/tcg/translate.h     | 2 +-
>   target/arm/tcg/translate-a64.c | 1 +
>   target/arm/tcg/translate-sme.c | 1 +
>   target/arm/tcg/translate-sve.c | 1 +
>   target/arm/tcg/translate.c     | 1 +
>   5 files changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

