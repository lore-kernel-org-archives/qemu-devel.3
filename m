Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9483D26283
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 18:31:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viGVe-0001Jb-05; Tue, 20 Jan 2026 13:31:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viGVc-0001Ih-U8
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 13:31:20 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viGVa-0004mz-Vb
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 13:31:20 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-432755545fcso3299571f8f.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 10:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768933877; x=1769538677; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8l7DjF7gyDSglpKq646fLnuvHs25JxjRrZEp3/D9DPQ=;
 b=L5DVDaIQNfQEeEGHtBuqpJiCBM/DolmfJerTMcpC6g35yLaZinZG4mWLmbugh/jwVz
 WLh8DH4vMrbqJZKGuON286k/ZYsrf/ub34GI+yi8f2oOrh7396qnsqPwNWEe2IqWf14i
 jOfj7fPtJXCIyzQ0bcFerarLZK8M1rY3QHc9SiuTNeRazQ+zmZz6iNeGUoRGA1oiYlWP
 Q1E4pjr8GkKDYi14PxeKm5Cfuj5aSWfFVShMBmU25OshvKPcI6t8N11Lnjo4NwN8zd8t
 mYv5X7POdu76wsk0h7CAWqMTYMsLHzpCIhgcdr/HbvxPZDorJ7xBYotYoeeX6dNHQQJw
 sHNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768933877; x=1769538677;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8l7DjF7gyDSglpKq646fLnuvHs25JxjRrZEp3/D9DPQ=;
 b=R/S5kHVI1g9UrNylX7l1oKsruuMqLiYWuUBnz7xnt3sao15GJYdEY1tuk/7x79cwtG
 ZhMm/+Z7S83fSFI3ObLloJMMqeSQGGInT1+yWO08ZG7I3hhu/Ws434kPOFSsmEtNsD39
 GNmyeN20KJxS6GZ0KgUJw9JEnV2fdjtbVy3awI8b8AR04mLuxHUcF845M4AFKqWKAhyu
 Q37bbh4sFW7OLIBnfwnU4Vdx7cXc9mx8+LdLGNB3G6DBFVWkNF592aWuioPdTQYC51dA
 +F17txkQE255jD/Y10HZaKwvy97uYlqt/Udnt+ibiz0PNO6JkqNq67Zz9whuuTsq8brv
 jVTQ==
X-Gm-Message-State: AOJu0YwxsxQnIUVo6WaAwRA1eAjrLrD3p03s6lezlSphPEgusMK98e5Z
 TE0ACLn57CADu5Jfk5mwRcdjjcfobrx9d9C0yRE897R/0xTthfoZmahCUU1z/BgeTgc=
X-Gm-Gg: AZuq6aLpYqf41olTeSgft3GM78hgFQLJJhfg7l/fqi2yVvr1ELzI0xwZQuQOSB8pOxR
 YTi364AGaEYY6qLuJoyIbWSgfVZ/HtsyOhLNDo9tYQxuCynLEFgcbG0ffRROdhrtrJH38ymd0K/
 75LfS9SIJJiw4GpRqI5G0Ar5xs2eGBe1S7k3wYPfwoK3KIfKdB5DUnBWTlmvfBYVDn+regMGoC/
 ndWJ/S9o2sDCYxQdAgL9W1VckocT/Vez5iUD3sspTJz1L/wxCZm0APuG+5J25MgWxrZAZ9r56DE
 KmGSzFpXxUYL1rpCV+MvuyETCuL+3eub4Pp0sHDH/1sFWvIRGrMgQ4ZrHr9XStivjVcb3YEbmFL
 Yfnj96H34G8Y7+Z2kmXZ2o9ur8CruFH/739SFQddshk1F1hJcvTB5E15jnl2VDh6SEamFSfwjc3
 xtyt7U5Z2MOhcHawlI/PZ7ViMMg+U22avMSuunVysfPPUGXjDWon1MuIuNnMIRjs7U
X-Received: by 2002:a05:6000:2085:b0:435:907f:e439 with SMTP id
 ffacd0b85a97d-435907fe6bfmr3786416f8f.18.1768933876915; 
 Tue, 20 Jan 2026 10:31:16 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356996dad0sm30652245f8f.27.2026.01.20.10.31.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jan 2026 10:31:16 -0800 (PST)
Message-ID: <c9308d86-889f-4ca3-8f67-eb6b253987da@linaro.org>
Date: Tue, 20 Jan 2026 19:31:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v9 3/8] hw/misc: Introduce iommu-testdev for bare-metal
 IOMMU testing
Content-Language: en-US
To: Tao Tang <tangtao1634@phytium.com.cn>, Paolo Bonzini
 <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mostafa Saleh <smostafa@google.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
References: <20260119161112.3841386-1-tangtao1634@phytium.com.cn>
 <20260119161112.3841386-4-tangtao1634@phytium.com.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260119161112.3841386-4-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 19/1/26 17:11, Tao Tang wrote:
> Add a minimal PCI test device designed to exercise IOMMU translation
> (such as ARM SMMUv3) without requiring guest firmware or OS. The device
> provides MMIO registers to configure and trigger DMA operations with
> controllable attributes (security state, address space), enabling
> deterministic IOMMU testing.
> 
> Key features:
> - Bare-metal IOMMU testing via simple MMIO interface
> - Configurable DMA attributes for security states and address spaces
> - Write-then-read verification pattern with automatic result checking
> 
> The device performs a deterministic DMA test pattern: write a known
> value (0x12345678) to a configured GVA, read it back, and verify data
> integrity. Results are reported through a dedicated result register,
> eliminating the need for complex interrupt handling or driver
> infrastructure in tests.
> 
> This is purely a test device and not intended for production use or
> machine realism. It complements existing test infrastructure like
> pci-testdev but focuses specifically on IOMMU translation path
> validation.
> 
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Reviewed-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> ---
>   MAINTAINERS                     |   7 +
>   docs/specs/index.rst            |   1 +
>   docs/specs/iommu-testdev.rst    | 138 ++++++++++++++
>   hw/misc/Kconfig                 |   5 +
>   hw/misc/iommu-testdev.c         | 318 ++++++++++++++++++++++++++++++++
>   hw/misc/meson.build             |   1 +
>   hw/misc/trace-events            |  10 +
>   include/hw/misc/iommu-testdev.h |  87 +++++++++
>   8 files changed, 567 insertions(+)
>   create mode 100644 docs/specs/iommu-testdev.rst
>   create mode 100644 hw/misc/iommu-testdev.c
>   create mode 100644 include/hw/misc/iommu-testdev.h


> diff --git a/docs/specs/iommu-testdev.rst b/docs/specs/iommu-testdev.rst
> new file mode 100644
> index 0000000000..e15f9a55a7
> --- /dev/null
> +++ b/docs/specs/iommu-testdev.rst
> @@ -0,0 +1,138 @@

Squashing 'SPDX-License-Identifier: GPL-2.0-or-later' like .c & .h.

> +iommu-testdev — IOMMU test device for bare-metal testing
> +=========================================================
> +
> +Overview
> +--------
> +``iommu-testdev`` is a minimal, test-only PCI device designed to exercise
> +IOMMU translation (such as ARM SMMUv3) without requiring firmware or a guest
> +OS. Tests can populate IOMMU translation tables with known values and trigger
> +DMA operations that flow through the IOMMU translation path. It is **not** a
> +faithful PCIe endpoint and must be considered a QEMU-internal test vehicle.
   ...

> diff --git a/hw/misc/iommu-testdev.c b/hw/misc/iommu-testdev.c
> new file mode 100644
> index 0000000000..15eb6de78a
> --- /dev/null
> +++ b/hw/misc/iommu-testdev.c
> @@ -0,0 +1,318 @@
> +/*
> + * A test device for IOMMU
> + *
> + * Copyright (c) 2026 Phytium Technology
> + *
> + * Author:
> + *  Tao Tang <tangtao1634@phytium.com.cn>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */


> diff --git a/include/hw/misc/iommu-testdev.h b/include/hw/misc/iommu-testdev.h
> new file mode 100644
> index 0000000000..338365947c
> --- /dev/null
> +++ b/include/hw/misc/iommu-testdev.h
> @@ -0,0 +1,87 @@
> +/*
> + * A test device for IOMMU
> + *
> + * Copyright (c) 2026 Phytium Technology
> + *
> + * Author:
> + *  Tao Tang <tangtao1634@phytium.com.cn>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */

