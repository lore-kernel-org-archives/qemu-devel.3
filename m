Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBE02C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 08:32:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXbqQ-0004qk-Kd; Fri, 04 Jul 2025 04:32:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXbqO-0004qW-E3
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 04:32:28 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXbqI-0001FO-F8
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 04:32:25 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3a4f379662cso562188f8f.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 01:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751617940; x=1752222740; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LNRFm4DpSiJ4w69Kjp9TondYYaGPSu18RIpRtHTS29o=;
 b=oHlO/fGKb0qOyLoPk8qKjDKCBVQ/Y6PBT29X7tZonmVgiml+CmE+76bvF1olbek7AJ
 26YLiA9CGhECCyflaCz+qWR0N3ukcUlVF8z2/8b7EnqiPqxx1C8zTv9uBU11IsXiAHAS
 4WQ//HzDMcAspx7zA5CS9pnPuvt3T29SCmv4hecAS/zWbFWc47sw26mgO0MiH3MRM2z9
 C1CxSizNmbWX7/025iYbzfRFe4Vb4WVYh3J9FbP/br3/FTRxq8NscuHmCLZO1koJKpdK
 ONb9fUsRf44yIMC46IvHWiaZTVem88oQNmbt4VUgJo6sJ85P8zH+BElCQ67P4VgYflHg
 OpHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751617940; x=1752222740;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LNRFm4DpSiJ4w69Kjp9TondYYaGPSu18RIpRtHTS29o=;
 b=YDXq9NLT2Eln7y64WdSVwL/Erlumi6U2svRbsElXBHLvox8hkJytfeN3nEq2ZiKb3t
 deYBFIzWjmWE7wD8L0c5aCudPepasBAjmdrahviLwhwIZOEtLQVSyr/aE73oXZ685kgf
 8B0Ipp0Un07OLaNITqQ0h2kpJ83OgHwK2fE7zVLrCNN1yPRf0PMu8J4NBBux8yCeJcbk
 PDoGfcJbnqtmbX4SaQ7JJ2NA53TIk//IPMrEikU22WWGxAomWMQxSbnrHYFktmjMtue9
 tlRnsccFQTxQ6RzOoGDHnhxRZxpdfB/fSteKL2VF7FbpLjy189mB8dUmVeXDQ6sD9Td2
 SHwg==
X-Gm-Message-State: AOJu0Yw7zVQES5TAkLlmFxr3Pp7DIrxfoXatsq3jTfX6EgAX3UbuhNnt
 VUm5kRlZyo6cZJ4FWMGJ77zzsm+fdw49ayVKp3D+2/I55vj3Iv6rpyyvLafncDKZ4YvykMJdjfb
 LzYfHVYA=
X-Gm-Gg: ASbGncuJdJzEr7OyPQdV8l1Kl60UEcP67179beptgMSjMWRxG4zMT+bXcuF7QxHY4Kr
 evgoXe7jCoxj1hmCpWeD176HYkY6cEtSWZC4MmPDQ3mVjeAzqG/784FokOFIkdT1coNMGknQG0a
 UGoPCugImgnWFNDs0mQJf5XH3YxipnP1daRc8mFy7olIBqDITREnuvVWAGieX9bQrhN0D+Pldlu
 xvLTcXaFNY4w23v4UnlC2++cmL6S0rjXXf7nBI4pe6V8aJVvrpsEvwKFgMaLAxWgJXKrq+7fSEO
 mbfbiujpr2spsOICTH7Ep7fBZvG/1HcNmpxzPodLw91CHjHLFfpG4G7LHuLcHi74oZg6P+y5nKf
 vm/CY5PkohfcADtJFoEU3ugkFp2IO7A==
X-Google-Smtp-Source: AGHT+IHVjRWZI7TIh0eKGPguez3Ohh+8H60DhsXyidR6HkftxDz2Jjoq2aSI+J9nfsupGGd13SAI8w==
X-Received: by 2002:a05:6000:4009:b0:3b4:6577:eed5 with SMTP id
 ffacd0b85a97d-3b496fef620mr1040578f8f.12.1751617939845; 
 Fri, 04 Jul 2025 01:32:19 -0700 (PDT)
Received: from [192.168.69.218] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b9736bsm1896801f8f.60.2025.07.04.01.32.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Jul 2025 01:32:19 -0700 (PDT)
Message-ID: <f97f016b-7e84-47f4-9ec6-654a5f9e6a63@linaro.org>
Date: Fri, 4 Jul 2025 10:32:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 24/39] accel/nvmm: Expose nvmm_enabled() to common code
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Reinoud Zandijk <reinoud@netbsd.org>
References: <20250703173248.44995-1-philmd@linaro.org>
 <20250703173248.44995-25-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250703173248.44995-25-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 3/7/25 19:32, Philippe Mathieu-Daudé wrote:
> Currently nvmm_enabled() is restricted to target-specific code.
> By defining CONFIG_NVMM_IS_POSSIBLE we allow its use anywhere.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/system/nvmm.h       | 23 ++++++++++++-----------
>   accel/stubs/nvmm-stub.c     | 12 ++++++++++++
>   target/i386/nvmm/nvmm-all.c |  8 +-------
>   accel/stubs/meson.build     |  1 +
>   4 files changed, 26 insertions(+), 18 deletions(-)
>   create mode 100644 accel/stubs/nvmm-stub.c


> diff --git a/accel/stubs/nvmm-stub.c b/accel/stubs/nvmm-stub.c
> new file mode 100644
> index 00000000000..cc58114ceb3
> --- /dev/null
> +++ b/accel/stubs/nvmm-stub.c
> @@ -0,0 +1,12 @@
> +/*
> + * NVMM stubs for QEMU
> + *
> + *  Copyright (c) Linaro
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "system/hvf.h"

"system/nvmm.h" ;)


