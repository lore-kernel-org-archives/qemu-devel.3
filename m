Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89793C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 10:41:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7XXK-0005NI-Q7; Wed, 23 Apr 2025 06:41:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7XXI-0005Kl-R2
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 06:41:00 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7XXH-0006aw-6v
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 06:41:00 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-39c0dfba946so4262473f8f.3
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 03:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745404857; x=1746009657; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fD0g+KEn8dLycF4KuclQsN4knM3X4Rdlw+AKDOn1nxc=;
 b=wrS/5SdlwiAyoaeByRAMYeoGib8xaKsDRegd7aOYynLn+0+3JF/KluuxsArYHN0/cv
 d5NYdCH91aHZFDqptW0aRRjBosAzCULXcNqLIknValE/1/ewALFtNQgXDCnNA5PHX99K
 YebrJsKtDx1Q0qzCJNAXRZLP/6Flxv1REE9pqemVshafB+VDuMkdoxdlDhpszc4CQWqU
 id+qFFqPsy5z8eTfUEXVMDC8F77/RHCs9bY6Pm38wltAkW2dTehMqXE8qC3CCz2Owpj+
 hQJ+tr314W18L57Pyqzy+1Ygb1a8UY98T/T/Ir/Xsgg8GuCxP45zboxcEr5YJmuwUzTw
 NDug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745404857; x=1746009657;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fD0g+KEn8dLycF4KuclQsN4knM3X4Rdlw+AKDOn1nxc=;
 b=VO0D+/djhejJV2zHD4VpoYfOSGDDiF/ddWt5Rk6feGtZeNjd5V+tRWyLUjFDq7pFSf
 SLEFAkdnWaQq6wsm1x5Kz5nX8v5hDkoXfRYzhHhYBIcJvPZqFgRMoPzwVl759UWK8lEN
 iBNailSd6ZWrV6yFbqZqvZ5Gj/XDKHmovskKDKv1lA+gWuX56Zryaq4eaf43wI/MPhIx
 JxwO24463Tc5kROPda6BaWvL6FvKcU8S3R6fcbbBGVX68u4YuAYf3P55Qz1W9jnDOidV
 VelT3mdpgFWkqFaKBLkAh4NcdSYjU6UcfiEnBrHGf44RxrFR89DHl3rxLXk6cN1+ZP7t
 aI/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxhw1kTDtl8GUMJXELFNnTlKkQDYCCSddviJ2mgRAAmb1zEbXez/rAMic0uPdy5V6znSkscY68M+8c@nongnu.org
X-Gm-Message-State: AOJu0YyNfOOmSAtBBdHco1tkUeB3cUqA8KEagCcmDBegNcsw6z69CYRB
 6pl3VPNfeasKIK/jb6kZDAJ+hk9/YXT3NJiEqUig64kyhNlTcHGjkl69LKp/0/jTD4/bGWgsbmF
 1
X-Gm-Gg: ASbGnctuQhx0+qxMBzqFLWUoIiji8b9Y8XSLRATtoEPvUcZaGQFsZhMA6RMvx5U/O6/
 X4pV434wSwdJvXlxMGGeT8GywQSqeTWjYPGZvhQcXjYAIuLEjAA9cY9LZ9Dei1h7a92RzwyY+zR
 nlt+s7jkClxTw0qxeK9ksFH/9nIi8pnUcbztBro2I+VHwgVeCktKpX8UnqFg0M9mxjryVrVB4MT
 tRMmIAojTiF309y6gOQ4rdy2Dss9/YPi+98DkyamvKxTD9QDXqF4x6Y+jEH3+lruHNHVobl64L7
 iC4xmvwnA92xNOn573n5uT3z4PaTWfUmwF5p4kwN/OVAIZNMx8QEYMZ48ojIlPRlBB1PZ0Kd0rk
 eO73hg9G+
X-Google-Smtp-Source: AGHT+IGQNIjVtH24FtrWRVing+47so1DKjsMmYIjUfOQhwpQpInx5ciA6I0aoio4POGJ7UwSZ6yILQ==
X-Received: by 2002:a05:6000:1ace:b0:39a:c6c1:3408 with SMTP id
 ffacd0b85a97d-39efbad4ea3mr13943237f8f.37.1745404857606; 
 Wed, 23 Apr 2025 03:40:57 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa43330esm18035006f8f.21.2025.04.23.03.40.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 03:40:56 -0700 (PDT)
Message-ID: <ee80e39b-ae51-4b0c-90d3-07b04981f0b7@linaro.org>
Date: Wed, 23 Apr 2025 12:40:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 123/147] hw/arm/xlnx-versal: prepare compilation unit to
 be common
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
 <20250422192819.302784-124-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250422192819.302784-124-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 22/4/25 21:27, Richard Henderson wrote:
> From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 
> Remove kvm unused headers.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Message-ID: <20250325045915.994760-29-pierrick.bouvier@linaro.org>
> ---
>   hw/arm/xlnx-versal.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
> index 278545a3f7..f0b383b29e 100644
> --- a/hw/arm/xlnx-versal.c
> +++ b/hw/arm/xlnx-versal.c
> @@ -17,9 +17,7 @@
>   #include "hw/sysbus.h"
>   #include "net/net.h"
>   #include "system/system.h"
> -#include "system/kvm.h"
>   #include "hw/arm/boot.h"
> -#include "kvm_arm.h"
>   #include "hw/misc/unimp.h"
>   #include "hw/arm/xlnx-versal.h"
>   #include "qemu/log.h"

Copy/pasted from xlnx-zynqmp.c (previous commit) I presume.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


