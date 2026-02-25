Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91944F5543A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 02:34:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv4j1-0008Is-I9; Tue, 24 Feb 2026 21:34:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vv4iz-0008Ij-RG
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 21:34:05 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vv4ix-0004a4-My
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 21:34:05 -0500
Received: by mail-wr1-x442.google.com with SMTP id
 ffacd0b85a97d-43991064db8so9233f8f.2
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 18:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771986841; x=1772591641; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:cc:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uDexrxt1FOH2vl5/ko4n+wLCXBAqyhanvkh9YVnK27M=;
 b=F4roSDIfkJ96aOfk3LRB9TPDCcv9dv/CC5iw6p5JNN5Zwz5q4PATutym9ot2nVYi9u
 HVpMjew7Q2PJtpjtLt1pW/gjodV98VKJ8WJSpaaE2vOTEs/x4ZMLIqWKC9531xBWPdlB
 oRCSXg0rg7YyCpt7+uJ4hFJVUyv30hbubMuofepk2r2wIdOJCMhbaBn9MUfdT9x5DdPp
 QEdsrVlLemIB9tUTMJ0Q+s7Yotq9krhZJcRgYZkMs98AYhkcwvOXQU9djw1PDiSRnvj4
 /GRkxcL4QZqLmvE06WI3CAXqjBpD+VS9MsH5oeBwvRnZ60Faq7X6jHAzNjivVBIaw69/
 RZ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771986841; x=1772591641;
 h=content-transfer-encoding:in-reply-to:cc:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uDexrxt1FOH2vl5/ko4n+wLCXBAqyhanvkh9YVnK27M=;
 b=cMrLwD8YrXdnvNa/i66XxhixZjH6iSdDS0LXJcM1jRK8MSCNQ39mWJrvl5BTWRwCTA
 ROGWAlf8/YI8VZQu2liUoK6xihkmAXtGYglE4tX3WvgpzCjFMuNb7Wk4D5scV5uRWw9R
 tUMjsDV5BGzh8S1czDHx3hjnYTJdG7deelVAqUHrL0qzREmVX/v1/QcvRN+jUmfn53xC
 +BEPz2DCUZpmfSYp8uiYqUsnTfvgL7irlaDlFdG2WbNSBg1jZlOo8p/N0kXdD7R09JrG
 Sj97cinHiWUgRL1oNpJsNDxDiesHQXizVeNvNIbgwGwSf/Ie8DWyzNVDjictwJdUFlHE
 m0og==
X-Gm-Message-State: AOJu0YzIqVJWANQrZOYVFRHyckQa5/z+AI9QgTiTrD8rMQ+dPYwleqeG
 4wnuu8SHbP+R8m4k9PMqWNbcw0M5fNdKQlZuT0vP4Him8PMHU/oqQYOEGzV/sSyszpH90XqrhAM
 yBUwibVA=
X-Gm-Gg: ATEYQzzmuAR4LCxYtAeAnKwU6avxm0rUtD0u3nz5jGdQHpPxiL6v7D296S/EKLQyr7C
 5FHuTlazEEGH93lpPJyj8M8PfMLNk0xn4z++hbnDa7OP9R93SaZeOMYnFWNKmDehu/HjygIlCPL
 cpg6O4vhCQIRubZJaDQB+6N68Tpg/XzB24T0cz1M4wMj2iQHeozQfzGZilxBjo3F63PVLbMXwCk
 0wwyYr5+x4zBnrWqQSQpU7+nWaLsNaANqL3U6BC5YcigSPgSR5xwG87JYQ1hjl6545Fuy5zhGMF
 bAsNDnFXcjTx0gX2+mcCzClJl9wn3OKV1uol+6F2uDhFKr4e+S0+3o6sVdH2Yida6qZV5/l8Wzk
 J1xstuF/X9akprulLh04AYroGdIP2A0HJqPt7+yVJI7ndSHUy4kdxvNd52CbgpKNJ9u8cGyt9wA
 vY2nZCXvha4zlFQo8uA/IYi9x/p0HNDdDPNRQyOmhd5cYBDCUG89Q0uQf2uesWj5va4Q==
X-Received: by 2002:a5d:588a:0:b0:435:9144:1417 with SMTP id
 ffacd0b85a97d-4396f183942mr23826875f8f.49.1771986841199; 
 Tue, 24 Feb 2026 18:34:01 -0800 (PST)
Received: from [192.168.69.208] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43970d3fdd0sm30108464f8f.19.2026.02.24.18.33.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Feb 2026 18:33:58 -0800 (PST)
Message-ID: <64330c92-b154-4b1c-a52f-3debf253b0fc@linaro.org>
Date: Wed, 25 Feb 2026 03:33:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 05/43] hw/arm/smmuv3-accel: Introduce smmuv3 accel device
Content-Language: en-US
To: qemu-devel@nongnu.org
References: <20260129160917.1415092-1-peter.maydell@linaro.org>
 <20260129160917.1415092-6-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Shameer Kolothum <skolothumtho@nvidia.com>
In-Reply-To: <20260129160917.1415092-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x442.google.com
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

+Pierrick

On 29/1/26 17:08, Peter Maydell wrote:
> From: Shameer Kolothum <skolothumtho@nvidia.com>
> 
> Set up dedicated PCIIOMMUOps for the accel SMMUv3, since it will need
> different callback handling in upcoming patches. This also adds a
> CONFIG_ARM_SMMUV3_ACCEL build option so the feature can be disabled
> at compile time. Because we now include CONFIG_DEVICES in the header to
> check for ARM_SMMUV3_ACCEL, the meson file entry for smmuv3.c needs to
> be changed to arm_ss.add.
> 
> The “accel” property isn’t user visible yet and it will be introduced in
> a later patch once all the supporting pieces are ready.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Tested-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> Message-id: 20260126104342.253965-6-skolothumtho@nvidia.com
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/arm/Kconfig          |  5 ++++
>   hw/arm/meson.build      |  3 ++-
>   hw/arm/smmuv3-accel.c   | 59 +++++++++++++++++++++++++++++++++++++++++
>   hw/arm/smmuv3-accel.h   | 27 +++++++++++++++++++
>   hw/arm/smmuv3.c         |  5 ++++
>   include/hw/arm/smmuv3.h |  3 +++
>   6 files changed, 101 insertions(+), 1 deletion(-)
>   create mode 100644 hw/arm/smmuv3-accel.c
>   create mode 100644 hw/arm/smmuv3-accel.h
> 
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 97d747e206..c66c452737 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -626,8 +626,13 @@ config FSL_IMX8MP_EVK
>       depends on TCG
>       select FSL_IMX8MP
>   
> +config ARM_SMMUV3_ACCEL
> +    bool
> +    depends on ARM_SMMUV3
> +
>   config ARM_SMMUV3
>       bool
> +    select ARM_SMMUV3_ACCEL if IOMMUFD
>   
>   config FSL_IMX6UL
>       bool
> diff --git a/hw/arm/meson.build b/hw/arm/meson.build
> index aeaf654790..c250487e64 100644
> --- a/hw/arm/meson.build
> +++ b/hw/arm/meson.build
> @@ -84,7 +84,8 @@ arm_common_ss.add(when: 'CONFIG_ARMSSE', if_true: files('armsse.c'))
>   arm_common_ss.add(when: 'CONFIG_FSL_IMX7', if_true: files('fsl-imx7.c', 'mcimx7d-sabre.c'))
>   arm_common_ss.add(when: 'CONFIG_FSL_IMX8MP', if_true: files('fsl-imx8mp.c'))
>   arm_common_ss.add(when: 'CONFIG_FSL_IMX8MP_EVK', if_true: files('imx8mp-evk.c'))
> -arm_common_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmuv3.c'))
> +arm_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmuv3.c'))
> +arm_ss.add(when: 'CONFIG_ARM_SMMUV3_ACCEL', if_true: files('smmuv3-accel.c'))

Unfortunately we didn't eradicate arm_ss[] in time due to the raspi /
aspeed SoC 32/64 distinct use of CPU types [*] and we failed to notice
developers are re-introducing its use.

>   arm_common_ss.add(when: 'CONFIG_FSL_IMX6UL', if_true: files('fsl-imx6ul.c', 'mcimx6ul-evk.c'))
>   arm_common_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_soc.c'))
>   arm_common_ss.add(when: 'CONFIG_XEN', if_true: files(

[*] 
https://lore.kernel.org/qemu-devel/CAFEAcA961WKB4fxwAS0WHXXKwYEO7TnmovD4z-BPGehr6sxBQw@mail.gmail.com/

