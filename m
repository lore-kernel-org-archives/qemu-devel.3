Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BCD2D116EA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Nov 2025 18:28:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vP3CX-0006qb-Sf; Fri, 28 Nov 2025 13:28:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vP3CV-0006q6-Lv
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 13:28:11 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vP3CT-0003w7-6N
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 13:28:10 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-477632b0621so12687785e9.2
 for <qemu-devel@nongnu.org>; Fri, 28 Nov 2025 10:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764354486; x=1764959286; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XSLzWMev1mGSNW6H+kOR5vQL7S5T/OdIECxTto6U7ms=;
 b=wDx0n5lKjxnqfX4GzLuXfaFmrALnJy4Kp/OnSmArvu5B8hISmx+WiySdQXK5VZI6JD
 Rto6+jSDJ1K2s66RhRKcZNiRydwF5K3FlDAg7hALUTedYa0ThAZJcvi1lG9I68+r/ats
 dm1Z9VIEUvV1+G+WRRfzMA4w3FHVpIgV7Qf8fL26/k0To97x0kDvH8vA7VYRG2hm4mql
 EKQe2+p8gluqd0U1i2vhK3beeTJ+x3G9Fl+Y/ab2xFV9dBP9rv4zfLoJ7uxl1g/yMcg5
 O6l1tuC2efWxmEmCkLK6L99bbg+OpSmbKUGQN+h5GQu+txM7aGiifByyBTdqYuPaKfvb
 o7QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764354486; x=1764959286;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XSLzWMev1mGSNW6H+kOR5vQL7S5T/OdIECxTto6U7ms=;
 b=smMe53+HNjXim2pzN0Qd2ZDYkQR/qX6Oema6G4gsrWOM/KOi50YU5nbcy6lKcjQVEj
 7djBLiAYw+w3LJLHhQ/jFnDcZKmfCxWvTp5xA/galZfrfYM9WZcw/k4UDzRBQjUtSga2
 5fmT+IMX0lp2+/wx3MYA+F2gBDpVTjCIIf6Lom/Oc3out7VR3oIF5RXiTaZffpGX3DJf
 /DtzHDo36f4FJUiWensnVkR14k2uhDhgaXOIUNottLoyA07WQdD/6yZvu5MVrhiif2gG
 /D0sgjNVcjC3gNelM5DSAQV7JGrRQ29NGZF6/Qf/SV4c7MCiT2bRouluAL52fSoe9Wyh
 qM3g==
X-Gm-Message-State: AOJu0Yw2SqzPILcfDnpp6O/fS+5yTCEbY1xpyd5Bkda8ZVsYoEk8oq+T
 mUHMcDsQy0Vxyffy/w1sPpaFul/DuhjfWkBFSZgih1goplJe7ewIOY0z+1cezyB7b7ty/eWeu4I
 5eZtN
X-Gm-Gg: ASbGncv/3un9nH6+adgwGibG9VGX1JGAm0DFuEi6zvQFB9ZHfURo8pjOERcjNiJ3QDs
 ez8ZPeN+LT6+XAbeoBPg/AMT1VleuAfWiIQAiLvj9sWPapdvgGeKj7jaGtpM3Kn/J0DmcskViIy
 dxnh85c606I3O/F3cr4RRvDAi8WDe1Qnre30/BKw3zQUW3En4UHt7H6AUI8Qvm5DcbutdlDba1p
 ELvVBbnBiiDJTnzTr6YF+CnBlOXIE/lS+fSRhIyDyoLI6fEZWoAWCoVq407AE3Fw2AQdYoFIfmu
 l6GO4swx4Eb8rjDkfSfE0RPca3wC9Rt9roviLUAiuPfVa6PkBDB2TF71ZXHU8m5Q/x0BT41Sgo4
 4sB9TOamlftO4TrfEBOo3cTXH2ZvzxqespGbAvKn9PstpGckcYMz+c7TYPh3C7Ji4/TA9202bR7
 hkq5EpsRHMlR5YwDLaOLfBtkWWxrQvBFjzZKmE7Tzg8xMegH3tvPIFhPp9sjvYUEU=
X-Google-Smtp-Source: AGHT+IGsfzfcMTQfldaCjtWQHZseJJtNb7R4jC/WFPS+sZaXv/Gphann4D48WuMvTAQAjzZWzbs3UQ==
X-Received: by 2002:a05:600c:a07:b0:477:a219:cdb7 with SMTP id
 5b1f17b1804b1-477c10523aamr331264595e9.0.1764354485926; 
 Fri, 28 Nov 2025 10:28:05 -0800 (PST)
Received: from [10.26.52.213] (36.red-88-29-191.dynamicip.rima-tde.net.
 [88.29.191.36]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4790ade13ddsm161349425e9.8.2025.11.28.10.28.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Nov 2025 10:28:05 -0800 (PST)
Message-ID: <cef1fec7-d50b-44b0-95e9-fb087987e50c@linaro.org>
Date: Fri, 28 Nov 2025 19:28:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.2 v2] accel/hvf: Fix i386 HVF compilation failures
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Cameron Esfahani <dirty@apple.com>,
 Mads Ynddal <mads@ynddal.dk>, Nguyen Dinh Phi <phind.uet@gmail.com>
References: <20251126134434.14355-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251126134434.14355-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 26/11/25 14:44, Philippe Mathieu-Daudé wrote:
> From: Nguyen Dinh Phi <phind.uet@gmail.com>
> 
> Recent changes introduced build errors in the i386 HVF backend:
> 
> - ../accel/hvf/hvf-accel-ops.c:163:17: error: no member named 'guest_debug_enabled' in 'struct AccelCPUState'
>    163 |     cpu->accel->guest_debug_enabled = false;
> 
> - ../accel/hvf/hvf-accel-ops.c:151:51
>    error: no member named 'unblock_ipi_mask' in 'struct AccelCPUState'
> 
> - ../target/i386/hvf/hvf.c:736:5
>    error: use of undeclared identifier 'rip'
> 
> - ../target/i386/hvf/hvf.c:737:5
>    error: use of undeclared identifier 'env'
> 
> This patch corrects the field usage and move identifier to correct
> function ensuring successful compilation of the i386 HVF backend.
> 
> These issues were caused by:
> 
> Fixes: 2ad756383e1b (“accel/hvf: Restrict ARM-specific fields of AccelCPUState”)
> Fixes: 2a21c9244740 (“target/i386/hvf: Factor hvf_handle_vmexit() out”)
> 
> Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> [PMD: Keep setting vcpu_dirty on AArch64]
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Per 
https://lore.kernel.org/qemu-devel/c4f85e7d-6311-4b27-b29c-58ad102bda41@gmail.com/:

Tested-by: Nguyen Dinh Phi <phind.uet@gmail.com>

> ---
> Superseeded: <20251126094601.56403-1-phind.uet@gmail.com>
> 
> Untested. Once tested, worth to apply as buildfix before tagging?
> ---
>   accel/hvf/hvf-accel-ops.c | 5 ++---
>   target/i386/hvf/hvf.c     | 6 ++----
>   2 files changed, 4 insertions(+), 7 deletions(-)


