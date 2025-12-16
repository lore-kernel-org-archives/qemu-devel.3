Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F32D8D637DB
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 22:53:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVdut-0005W6-L9; Tue, 16 Dec 2025 17:53:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vVdus-0005VJ-6G
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 17:53:14 -0500
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vVduq-0000fP-Id
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 17:53:13 -0500
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-bfb84c2fe5eso3952a12.1
 for <qemu-devel@nongnu.org>; Tue, 16 Dec 2025 14:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765925591; x=1766530391; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=97eb24TtJtzRV8hQQfX2roM76MdnXtCmhpyJRZkPRwg=;
 b=Mvr86p17am9WlJQ2ZmcaWLVAk2CUkZU4T8vGA/My3PHOmys5aqfGrYSLMIjTep0sw6
 xg0mEbXdy2faYATcnEaCFlbA3fgk+Gn6hdV453TjI7BnJFhtqLl/Il5DLjAL7XpdwsCA
 62rReWLEvPzY7lRjIqDmLEatyXDFqqJsYLnir/U6nGTum9GRw7OyuIU9hFmtUklgCMWp
 uVYsdtclKeWKv/HR6E1wHhs/F5wCDyuwqxNX+ySP25YgZnbHjXZaLSmd/uZ8p7WjEXLq
 UpWQqShEE9J3xYQJ55LbChIlQnJ6yIHlPN8WpMig3tAqCurpcCEZV1IJ/QT1BP14gTD4
 3Vow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765925591; x=1766530391;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=97eb24TtJtzRV8hQQfX2roM76MdnXtCmhpyJRZkPRwg=;
 b=wcQITFEb5QVJiwG3g6BQSroK6gczV+ruVInCqlcMhkXm9zt00Q5dj7ZPkWszm8cRya
 VvP0WxIPZ9TuuAMI8MWIuaR85+Gc1mey9v5b+cRMWRiz0dZfJhvAWACdtOOMDLZ2ONq1
 KPzG/audt0caTeN/GO1RC20lKAo2INQ2UmHDq8yuRv5voXpueamnSUEn36dPEIHOFiPR
 J9C69aXBbMi4A+RaUMttiNCD2amxKIj0ymxiRj5RFaZmlSdQFfGMm9SRp8J3HzGK1htu
 qrjq3xOa+DDmsGAaR0aTNOjpFCq+VuGQqCGnufAn8nZ8YSaNvlY8LtHMLw23twEPBT0o
 0QCA==
X-Gm-Message-State: AOJu0YzM3DBGDRHUu6NCRZETfiIxbdusaf28ahjIQ+PfQtbrjC2y6/tz
 Gfcfjg0C3Dy07gnJo+SRgeHCMTeg6t9FyFpVkH4FSRvhc5NtzhRIS3oveAJ3vyi5Y4fdv2T9BnP
 JXqzgCwYPIg==
X-Gm-Gg: AY/fxX6+6j6TldMX5gFz7PK/f4lQoka6TyxDautyTatlvEieICntoNnWW3RyfhMdhsX
 e7dsfUyQdZHAH0S0WYucCO6Tr4wG8taN6Uz/esRlVLAC8Adp/hyDvzZSAghSrxlsR9c30kNsna3
 +tRPxOU1H4sH5R5R8P2/mjNsOTOUZfbjR8ufLPaSZL8t2w5tl84rhQ6S+5loFG8wJOsIE1rmdTL
 +arnv0gcVB6MVYC4/6JVwvtJhH8H0bMF6Xbuh9j3MDXQgoL4gqQnfZZN/4Bcaxz4pIZE4c+GfgW
 iWx6Wp/DPHZshPHegcbiLf9lrNmb7IvaSlGc9A4E4qKL4K7gQsUJHQv5rehsXqFWkWi/KOd4UHe
 GWcoss29x33nQEblN0FQAnBgcaaJtLaipXmXCgtqni4QrrTwrHUgi3kIuzZ2mEY2x90k752ejko
 9C1bKnAS3QmLNPPRrMKKKAU0B2gu7HAOtKVSBuHI3wZrAEoiqgt6d5ZZA=
X-Google-Smtp-Source: AGHT+IEfYMNZIgogrzbvjAAtbewpeuKdsv9i0n9MTGYfb0NHhiR9o4yNvtiMsDPpAUdWrdHTjcvAnA==
X-Received: by 2002:a17:902:ef02:b0:2a0:835f:3d5b with SMTP id
 d9443c01a7336-2a0835f40dbmr148489965ad.6.1765925591099; 
 Tue, 16 Dec 2025 14:53:11 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a099e77889sm108331505ad.22.2025.12.16.14.53.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Dec 2025 14:53:10 -0800 (PST)
Message-ID: <a82b26be-9671-4a5e-80b3-81bc6cc40e15@linaro.org>
Date: Tue, 16 Dec 2025 14:53:09 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] hw/arm/smmu: add memory regions as property for an
 SMMU instance
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: tangtao1634@phytium.com.cn, Peter Maydell <peter.maydell@linaro.org>,
 richard.henderson@linaro.org, Eric Auger <eric.auger@redhat.com>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>
References: <20251216224845.1673051-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251216224845.1673051-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x536.google.com
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

On 12/16/25 2:48 PM, Pierrick Bouvier wrote:
> This will be used to access non-secure and secure memory. Secure support
> and Granule Protection Check (for RME) for SMMU need to access secure
> memory.
> 
> As well, it allows to remove usage of global address_space_memory,
> allowing different SMMU instances to have a specific view of memory.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   include/hw/arm/smmu-common.h |  4 ++++
>   hw/arm/sbsa-ref.c            | 16 ++++++++++++----
>   hw/arm/smmu-common.c         | 27 +++++++++++++++++++++++++++
>   hw/arm/virt.c                | 16 +++++++++++-----
>   4 files changed, 54 insertions(+), 9 deletions(-)
v3
--

- solved issue with user creatable smmuv3 (found with 
qtest/bios-tables-test, subtest smmuv3-dev), which is not created by 
board file. In this case, smmu->memory is not set, so just use global 
get_system_memory() instead.

v2
--

- Fix rebase on top of master
- rename memory and secure-memory address space with
    "smmu-memory-view" and "smmu-secure-memory-view".
    If someone prefers any other name, I can change it.


