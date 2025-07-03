Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1165C77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 11:18:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXHkW-0007sp-A9; Thu, 03 Jul 2025 07:05:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHi8-0002Sq-7c
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 07:02:40 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHi4-0004IY-Na
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 07:02:35 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4537fdec33bso36045195e9.1
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 04:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751540550; x=1752145350; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=meZf1hVHaaxBu1fyzABE7Mgyq70ajpFE8FzWCylSOKM=;
 b=bBYfe6fidz/i2Bu7qCaHQzUi4DnVc+Jo9DU9Y0Ee7LzSKpgRahOzNx2kAgw/jKoJTX
 RA5UpINediYXvbiTRW7q3wpsoHoP5Sl4x6o1ObWAiVGaiYTFcmCHj+BHkEOeYKS/DRhG
 0ie97sYL4iGIDfPf0aXqgnNCSi1CVRn0y8reVZgDogZW/AYhrc1K2w7wRsCB0Bl49fl4
 evI9f3SLDj76uq1udpB7HboxowPDhpFWHbE+AeMyDUaRrnTEzrfh9eXBUJZhcv0enmjM
 BEmVREoNUpVhMziDx0Izi0ut3UdqPDwystBc/ZlcYvKYv0oMOBS29qtM/zYMBX8lW4fP
 xkyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751540550; x=1752145350;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=meZf1hVHaaxBu1fyzABE7Mgyq70ajpFE8FzWCylSOKM=;
 b=HWmRedRSJGQwrCTO2Aa3GUoju+wgPCgkuz5c+rqmMEneYt3n5cQZN7ifcCdIw+pKpK
 m0jZw/mTkb3oJ2OyN8rWqZA0M81L8AyrX/luG10Fk6ppUK77/sYHGj2bnc4qPqhFEdl3
 9HoK1CJoDNtflYQZgKR0b8aq7PPn6hq5jf0EUVmqbarsaMKnJMf9s4rM3QJwVP5eoUdF
 sgIxrH08oV0yAxokJowk0QGCUzcQ+BUUYVrw8NQvDTbB+Cgh2VojDyyoTiOukvP/uk+G
 Wd3SPV9rfefEmtqRfxPnTAHnRmvkSfZMObsn+7Q6ikujvScGeDsfYzErg1NV2TYQ0A2+
 V/hg==
X-Gm-Message-State: AOJu0YxejGYOBH0UjTeR2c5t/PrghdjNr4eHBvpT3lXTMOSSUvzGnQnG
 DKZ5fvh2nBNtW6eIYz/Xzrhlub8sMO58m+31OqEshhAaL4/pzs4+Um4cDXN5+Edi77J2D+gj2pV
 y4RD8th8=
X-Gm-Gg: ASbGncsSfoX/5v2vuV5BAv6Kt1IIdDTgnYU1jsj8FUU+entc358GF1gVAMpwN241L75
 Tq4dU9QaJw7fn5RKbSjfTI9haoZCfOJeQjTpFEWwbfxjRZEMrlQxP4z8tUxSNYbramDuL9j49dP
 8acMg2k2hWEPHUd3Mw4orvMKmbIrDEOT/LkDgiUn/3icSCJ4U0FsR9F0zG/WBmNS01sOfUtFYCZ
 4RZfQdlNW7AaNU+AVn1s+uUq+xMTYjkFBCApYskgQ0V3eECjq4SpXIWStrrESHoHVREoEf2Zo50
 QE9OCMfze6+ZBv+sGCtQ8fhIPaSFUR5rQ49MbOY0BECuYPjlT49m7eNx4gR+/4pEo0nxwHc83Ja
 t
X-Google-Smtp-Source: AGHT+IGOA9Ob4y6TwQ5oCy+TIN5OtIeanArU9CkD0fKkQN/9Okrbch/1y9NMbm9E19Sa1W0uY1YE2g==
X-Received: by 2002:a05:600c:4688:b0:453:81a:2f3f with SMTP id
 5b1f17b1804b1-454a372df70mr75702425e9.30.1751540550215; 
 Thu, 03 Jul 2025 04:02:30 -0700 (PDT)
Received: from [10.79.43.25] ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a99a35f9sm23430675e9.27.2025.07.03.04.02.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Jul 2025 04:02:29 -0700 (PDT)
Message-ID: <1ede3bf9-4afe-4616-8a2b-ec3a4087f941@linaro.org>
Date: Thu, 3 Jul 2025 13:02:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 45/69] accel/whpx: Expose whpx_enabled() to common code
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Sunil Muthuswamy <sunilmut@microsoft.com>
References: <20250703105540.67664-1-philmd@linaro.org>
 <20250703105540.67664-46-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250703105540.67664-46-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 3/7/25 12:55, Philippe Mathieu-Daudé wrote:
> Currently whpx_enabled() is restricted to target-specific code.
> By defining CONFIG_WHPX_IS_POSSIBLE we allow its use anywhere.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/system/whpx.h       | 27 ++++++++++++++-------------
>   accel/stubs/whpx-stub.c     | 12 ++++++++++++
>   target/i386/whpx/whpx-all.c |  5 -----
>   accel/stubs/meson.build     |  1 +
>   4 files changed, 27 insertions(+), 18 deletions(-)
>   create mode 100644 accel/stubs/whpx-stub.c
> 
> diff --git a/include/system/whpx.h b/include/system/whpx.h
> index 00ff409b682..00f6a3e5236 100644
> --- a/include/system/whpx.h
> +++ b/include/system/whpx.h
> @@ -16,19 +16,20 @@
>   #define QEMU_WHPX_H
>   
>   #ifdef COMPILING_PER_TARGET
> -
> -#ifdef CONFIG_WHPX
> -
> -int whpx_enabled(void);
> -bool whpx_apic_in_platform(void);
> -
> -#else /* CONFIG_WHPX */
> -
> -#define whpx_enabled() (0)
> -#define whpx_apic_in_platform() (0)
> -
> -#endif /* CONFIG_WHPX */
> -
> +# ifdef CONFIG_WHPX
> +#  define CONFIG_WHPX_IS_POSSIBLE
> +# endif /* !CONFIG_WHPX */
> +#else
> +# define CONFIG_WHPX_IS_POSSIBLE
>   #endif /* COMPILING_PER_TARGET */
>   
> +#ifdef CONFIG_WHPX_IS_POSSIBLE
> +extern bool whpx_allowed;
> +#define whpx_enabled() (whpx_allowed)
> +bool whpx_apic_in_platform(void);
> +#else /* !CONFIG_WHPX_IS_POSSIBLE */
> +#define whpx_enabled() 0
> +#define whpx_apic_in_platform() (0)
> +#endif /* !CONFIG_WHPX_IS_POSSIBLE */
> +
>   #endif /* QEMU_WHPX_H */
> diff --git a/accel/stubs/whpx-stub.c b/accel/stubs/whpx-stub.c
> new file mode 100644
> index 00000000000..c564c89fd0b
> --- /dev/null
> +++ b/accel/stubs/whpx-stub.c
> @@ -0,0 +1,12 @@
> +/*
> + * WHPX stubs for QEMU
> + *
> + *  Copyright (c) Linaro
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "system/whpx.h"
> +
> +bool whpx_allowed;

Consider this missing hunk squashed:

-- >8 --
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 1732d108105..faf56e19722 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -245 +245 @@ struct AccelCPUState {
-static bool whpx_allowed;
+bool whpx_allowed;
---

