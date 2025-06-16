Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA0DDC71135
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 10:05:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uR6hd-0005u5-Js; Mon, 16 Jun 2025 06:04:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uR6hI-0005pv-2K
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 06:04:13 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uR6hC-0003mJ-Mw
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 06:04:09 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-451d54214adso33297795e9.3
 for <qemu-devel@nongnu.org>; Mon, 16 Jun 2025 03:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750068244; x=1750673044; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zJvo1d16AsUfmfb5Mgd3uKyRk+z+9hCt71bxkllUzzE=;
 b=LqysMhH1/qU643KVGkMAo96FQCyE7tZFlNd50JTAXCvxOOM+BHLFG0ESUAC7vA7XSI
 kXL8zCrjnpwFvC+5ZLJLVk19fDMRotueugk2ZoLhPdoZzkq2kzZJbHoSY1OGHIbCcR9M
 GTVXOWzhyDc+y60PkSJ4VWfAadM5h9TA87znyRZo8jIpL96f5sFX0fbNiMnwjFV48u3T
 YJW7Rq7O4AMiEjzKk4J+s+7TTZNZGXCcLENJ7DKrQzS2vp3fzd1jqrdjFx/b6i/yEHiz
 Gx8qCxfrnaGviFbhMeQgiIyXhVPdwsjg37OUxsqxkokYdjXJuPdO7BSKcB5WFbNfXH2T
 00gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750068244; x=1750673044;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zJvo1d16AsUfmfb5Mgd3uKyRk+z+9hCt71bxkllUzzE=;
 b=VGLwojI71JSbp+AIKrII9jGIQ4oyzGM+zHDiNm4YGOJo6dC3L7RWwa09M9n1iPXKtX
 /3wSj0jopMmEsR4DeEJ30D264aus1y9XAEN1ua8NRMFcXCHBRz5NP8lEKLqN9F/06dRF
 sdW8MKFir5lONQp78WhUP3jSqXyctPt4pW4zRYLVcAsiu9VoJWkk1ZCGSQ+/bRURdLdc
 FeXvWg1E7aUqPqHIm8wF6TCNdmn2CVVFXUhHkhyOUyvOiVaGtWhIJtmxqsArNRb1SgbN
 KFztOTXqTcUgjF53funVVEOwtJv3Cgt4YnC77lMi/bfePlU4DpuKrXzWqnHCwO1RQjD1
 n4DA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKRiSnK6s+22PpH86/g16oLI8ii8d/f5d4271zs/NkpDp3kZY5GxasqkL9V1JiIhKp0ArKBBTW4X8/@nongnu.org
X-Gm-Message-State: AOJu0YxokC1am4A2BPy/tnOzuiZog+bIFkDSMIWGVoI2KK/z9hdfVRzk
 juenYnxCcSW6mtOW1ABJIXCw7AyA2yh+e54VI9puVHZIYKIBZxhqbCCkH65hS1ZnfFA=
X-Gm-Gg: ASbGncs9vkqE33jkSvB5S9KuCTTTOVIsfBJyGAyGWg59gprBGFdY0R+FsJV5dNcKAlR
 dlEkG4/BW4/nIwpWw9QP+wV5UjLFlSnDuK3Vp/V80eq0Q5IfElLookK5cVoCaHX+LRoqjQqRFxV
 adpQ3WOcIzH0lR80GHzlRKstnlmUkHowfr4jdUZf4Rxa/A75q0eTRQeGKiusvnRnb19rTzDKMwP
 qvsL+2nyFErannFhF2Y05SVX2pncLzwOZNA8a4pEJyg7xu0LkHfrGW2vHhTeHYKYkPT9tdVHU6e
 VUMx5Biccn/vQbIPl+ps/8sScoQu9GuKfAUseSi9V/zM4e4XvOp/S5QpBJ5yAnVGX/uE3LB1BCR
 sXwO3TBfHB9/aR4TewITH4qUpX5KgmQ==
X-Google-Smtp-Source: AGHT+IHmdLtGbcmfgS2DDfFW02Dmt76wB6Looom8CNyrOTRcfADeKOHlA7Yb3uSfR4Jmi8izmuUxXw==
X-Received: by 2002:a05:6000:18ae:b0:3a4:d939:62f8 with SMTP id
 ffacd0b85a97d-3a5723a3f05mr5948569f8f.32.1750068244048; 
 Mon, 16 Jun 2025 03:04:04 -0700 (PDT)
Received: from [192.168.69.167] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a568a7ddefsm10663318f8f.39.2025.06.16.03.04.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Jun 2025 03:04:03 -0700 (PDT)
Message-ID: <469f3e5a-897a-4456-bd02-185435129ec4@linaro.org>
Date: Mon, 16 Jun 2025 12:04:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 15/23] hw/s390x: Build an IPLB for each boot device
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jared Rossi <jrossi@linux.ibm.com>
References: <20241023131710.906748-1-thuth@redhat.com>
 <20241023131710.906748-16-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241023131710.906748-16-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi,

On 23/10/24 15:17, Thomas Huth wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
> 
> Build an IPLB for any device with a bootindex (up to a maximum of 8 devices).
> 
> The IPLB chain is placed immediately before the BIOS in memory. Because this
> is not a fixed address, the location of the next IPLB and number of remaining
> boot devices is stored in the QIPL global variable for possible later access by
> the guest during IPL.
> 
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Message-ID: <20241020012953.1380075-16-jrossi@linux.ibm.com>
> [thuth: Fix endianness problem when accessing the qipl structure]
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/s390x/ipl.h              |   1 +
>   include/hw/s390x/ipl/qipl.h |   4 +-
>   hw/s390x/ipl.c              | 129 ++++++++++++++++++++++++++++--------
>   3 files changed, 105 insertions(+), 29 deletions(-)

> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index 656996b500..b9d741d0b0 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c


> +static uint64_t s390_ipl_map_iplb_chain(IplParameterBlock *iplb_chain)
> +{
> +    S390IPLState *ipl = get_ipl_device();
> +    uint16_t count = be16_to_cpu(ipl->qipl.chain_len);
> +    uint64_t len = sizeof(IplParameterBlock) * count;
> +    uint64_t chain_addr = find_iplb_chain_addr(ipl->bios_start_addr, count);
> +
> +    cpu_physical_memory_write(chain_addr, iplb_chain, len);

This patch introduces a call to a legacy API (documented since at least
2017 in commit b7ecba0f6f6: "docs/devel/loads-stores.rst: Document our
various load and store APIs"). Can we access the device address space 
instead?

> +    return chain_addr;
> +}


