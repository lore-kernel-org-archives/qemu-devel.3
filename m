Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8417FC037F
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 16:04:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFwX1-0002Rw-2L; Thu, 23 Apr 2026 12:03:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFwWv-0002HN-OF
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 12:03:55 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFwWs-0007Dz-MV
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 12:03:52 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-488ad135063so60794445e9.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 09:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776960229; x=1777565029; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tui3QU7lec5GZ9QoBbSAta/edat1YRWXP0zG0BdtgTg=;
 b=pvqecMl0w2LvthN4dBHPCfPPH3zeJydjTTn+tYg9CCYoNgvSoP5jE0FgLNAWB5i+1h
 m2EUCsuLHzP17CLG89MSV0D5HBoPnlG7FzG6v0aM3J6uQiKT0vEBW3XKVDcsLOqTfJUE
 uHAopoVNs564r1WIF1zti83QuM4A3UXNAgG21NzlkZ+3tjdetCGJWTbZXKIyb67/j0Rc
 xadWBsR4F+Se7UyEfl0tb2+QqUYPMioNeb5TOwhFc0xqPjbGX++K8gHJCwZjXw4VrhBr
 H1rMT3uKWqnQYNUutDQtIhEHyg7DN/jlbt1DsWym6WJiWmpykyUEh6jf0vUj13V2gpFG
 YsWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776960229; x=1777565029;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tui3QU7lec5GZ9QoBbSAta/edat1YRWXP0zG0BdtgTg=;
 b=CjIFsvUnKBs6f/8cNmdgipety+WxkvDf0PXCRCEh4uwpMvjQXN/GGtCDPEdLGhqEUw
 6ZPlx0UfY4NEO9PdS/FgKXKvjylujuUIK1641sCJe1bFR2MPl006VwTTze/6bKhNpnGA
 bALgY1xj/M2Clc4pfAVPl4jM9CruyI9Y3Fia0gfDhLogCzktD3bHpmwyUBjh3rzllR5F
 r9a/JjLBb/PTvtKuq32vYOmfzfxAWa44SqdcVjGetBE6nRSAghFEX1LQO/5DuYPZTkBr
 Y2+8N6CyrtTrBdwBrg1qJFDS5A9slu2BWVl+OiWlU4DFRgJF40GcWZhPzymvrxs4bO7O
 M4JQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9WOCgSzTPyYWRQAn7uKgJ4OxnqhXkFlmLow76uvDeRSrSpwK4C7tNb+jXeFimNpUgT8zatjU2EFFAW@nongnu.org
X-Gm-Message-State: AOJu0YzT06gbtsz6MeyfkS3YNIqwUj/HzIp3Xn3R/ab0zy2/WucvE+Yd
 OGnRxEdfhd90OsJkAEDGv4uOXdXJUhxtmwedJ7FCjruFzfFcgXNYCuOIm60w32oMhVg=
X-Gm-Gg: AeBDievqnSCmZXfkIX+hZy9j3JsuojSF15vjQxmz7PoKt+RZf69sTukLyR7+ecw+kcw
 z4VmgUvCZQ0/1L6JE1GYuJmDuzXdE0ELI28lf+H92WSJKHUH/uy7TxV48aReQdWdZl+etnKP9xO
 dwAiSk7GFsVP44hDL2FA9jFVBKa/3EmIlLsbbDyp1tcq3BAnJKnyb+HZdO1PSSmBcd2iPoD9Xtp
 9zZRJdpPb9y3za1puYFBtlMQYjzvK/R+VrHAhlgqaCFvrKGAgsHq0fPYjRiXgyOtnMXswVVj6D0
 xwkqT7JFQuppukWoM6YhV7GlqfU9WDYEAABJ4kwRl787hcEdGet0nGEFv3ysNgFZSRoWkf4CEeV
 nzr3g1x7hXKvhH8gnFTZTwmMVdLuJo9J+hOYPPRMbUu0tP2hz1M7SkWX6uoPm80w3khbzmK+zvV
 2Qn0r3u4AAYNocSkb1/5OR1YcFPQ7UmAEaKijJQ2yT8r8DO0g8qzsyWmoUilYNsqehuZQweudwl
 Hzr
X-Received: by 2002:a05:600c:a108:b0:480:69b6:dfed with SMTP id
 5b1f17b1804b1-488fb78ba6fmr336770505e9.24.1776960228749; 
 Thu, 23 Apr 2026 09:03:48 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a5c4b9e8dsm34136825e9.7.2026.04.23.09.03.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Apr 2026 09:03:46 -0700 (PDT)
Message-ID: <22d286a4-52bf-4f50-85de-b238ee8671dd@linaro.org>
Date: Thu, 23 Apr 2026 18:03:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 08/15] hvf: arm: allow exposing minimal PMU when
 running with nested virt on
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Phil Dennis-Jordan <phil@philjordan.eu>
References: <20260316130642.13246-1-mohamed@unpredictable.fr>
 <20260316130642.13246-9-mohamed@unpredictable.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260316130642.13246-9-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 16/3/26 14:06, Mohamed Mediouni wrote:
> When running with the Apple vGIC, a minimum PMU is exposed by Hypervisor.framework
> if a valid PMUVer register value is set. That PMU isn't exposed otherwise.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   target/arm/hvf/hvf.c | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

