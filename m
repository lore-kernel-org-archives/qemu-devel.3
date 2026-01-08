Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1853D1D478
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 20:16:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdwQl-0007EM-TF; Thu, 08 Jan 2026 15:16:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdwQj-0007DI-Rf
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 15:16:25 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdwQi-0001fW-8u
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 15:16:25 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-34c84dc332cso2165433a91.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 12:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767903383; x=1768508183; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KueoSdHDozvrAcOf/4TffPnjefj4XwAMc0RRkckIDnM=;
 b=ICdpwBhpOAVmmTMFGmtBOk8vKEZeo9zObZXvaF5xSIGIDUACBg2Bz+Lig32CGVnEYR
 whVVHdtQ3Mea6cKef576H5KZc9oW1SQm3Cu83eEAiFLHMnsDkzTLIymU0XFS9qrXmKc3
 1V1aBZQ0WXCYZ9yIByVr0TckXMSEourxIiTWENda21+BCve1D2+Ue3QSnKpatXJBlu4m
 7B472OKypzMrrKHw03EU+dw3+lQ1/orwjLo1u7FU0rV3GWMdtcprl14e98VRZ/aWl2yT
 vH9VVM490B0Ep0Kt1sFmdOraAgxMZ2pMSyeah+yn68b9ROXqQ5VcmiUemlDKWoh0vbrJ
 r1NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767903383; x=1768508183;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KueoSdHDozvrAcOf/4TffPnjefj4XwAMc0RRkckIDnM=;
 b=rKAtZgveB5MhtnMqmbAgpbgYucsd30tFNMvGqZARFRshp+4IXE06T7sgIAbIUc2gxb
 Z4z08LcM90WYaetkKLnaJ4mZdtCwtyGg9KSkFKKLbWaYXaUXZ3VZqtJedExTk0xLOqBl
 3LbdyxdebeMpuvbBI6l7JZvbaofNBEmSTOxvjkBorJ8LiU8RxLHtwpq2FbPEjxCNuA0Y
 nVPwxrq7lsrcDvQ2J4qHaoEd5zIRktEwrXUGMjdrJFHj4x3SmA7pByFMfjdEWCzKRy6F
 4IShHSkb9iCbkT91F2IuAfCVndKnUNEYYoDZ9RpauZ4QFFQz1XeFuHcbIOevn2CEJAeF
 dOSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0Tpl5MCEYB9kusvcIsLOjWSpzlYq770Aa14evabs7IvKe6mav/xfaP4tFg69LRZZBG+uhGJqMrAhR@nongnu.org
X-Gm-Message-State: AOJu0Yy304pVwFw9lVYyzCyxEbdnWF7dHzeCs/XK+MCuKIHGYq0yNvzc
 x4ep1Csa5yLrH8/eEbrt5nceWhB3O27erXYNHdYct/uhw5ewWpF6eXDJe2ZEUcT08ls=
X-Gm-Gg: AY/fxX6oIGS1voO5bSmj6QRImx6lhd4xgFlUnHKFWaUsGtvDv0MY1rBMIsq7W5P7TTz
 789hg0QSxnEtwes/QyZ/wFL6W5o3zN9Z/R36bFWv2teSQrouBkhDMFE5cELwgr8+n6rP1Yq/FFx
 ytWcP/yAXn2gfZfanuAwaIuRs13NZo2H4PGNWNJHqUHp26qTHBmDRrYMhwyqafDdHNpRERfRHxe
 JKwTGKlQR0+ukyzTX7CC5XSZUr/+vlSLNnI+maGbxiA5Yjd09GM7LwJpFKI//OOtfU2FaY/kTYE
 pdwHc9InnmblMjrpDc2Qo6SY2WtJy+K6Pvq+YNHfwsVBm7JGTFOjzfb8S2fh0JGhRkCRT7RjE5Y
 e1qngqDGYO5IA9/18xIfXAVx+IWcSNn2ILUnp1UojoNTSUI+zeB3/TG3IWWL3OzjUWzHNlxpeCW
 HKnkVHzofRc1gHccgCT3ax5ErrJ7caISg0W5baamufSGufDEHfw/ls7nZ+u1laIDXfxKM=
X-Google-Smtp-Source: AGHT+IH5WeAlEvS4uSLRa7dXhmMXTs3NS6outow9Gdm1N3DU2LWMWaDIYQv73zJhW2GD6loQeC+a9Q==
X-Received: by 2002:a17:90b:5823:b0:34e:6b7b:ded4 with SMTP id
 98e67ed59e1d1-34f68ccceb1mr6159620a91.36.1767903382572; 
 Thu, 08 Jan 2026 12:16:22 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f6af4e14asm2583193a91.1.2026.01.08.12.16.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 12:16:22 -0800 (PST)
Message-ID: <edd5d088-4687-46ee-a807-90ae0cbbee69@linaro.org>
Date: Thu, 8 Jan 2026 12:16:21 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/50] tcg/x86_64: Rename from i386
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260108053018.626690-1-richard.henderson@linaro.org>
 <20260108053018.626690-12-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20260108053018.626690-12-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102a.google.com
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

On 1/7/26 9:29 PM, Richard Henderson wrote:
> Emphasize that we're generating 64-bit code.
> Drop the explicit rename from meson's cpu.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/{i386 => x86_64}/tcg-target-con-set.h  | 0
>   tcg/{i386 => x86_64}/tcg-target-con-str.h  | 0
>   tcg/{i386 => x86_64}/tcg-target-has.h      | 0
>   tcg/{i386 => x86_64}/tcg-target-mo.h       | 0
>   tcg/{i386 => x86_64}/tcg-target-reg-bits.h | 0
>   tcg/{i386 => x86_64}/tcg-target.h          | 0
>   MAINTAINERS                                | 4 ++--
>   meson.build                                | 2 --
>   tcg/{i386 => x86_64}/tcg-target-opc.h.inc  | 0
>   tcg/{i386 => x86_64}/tcg-target.c.inc      | 0
>   10 files changed, 2 insertions(+), 4 deletions(-)
>   rename tcg/{i386 => x86_64}/tcg-target-con-set.h (100%)
>   rename tcg/{i386 => x86_64}/tcg-target-con-str.h (100%)
>   rename tcg/{i386 => x86_64}/tcg-target-has.h (100%)
>   rename tcg/{i386 => x86_64}/tcg-target-mo.h (100%)
>   rename tcg/{i386 => x86_64}/tcg-target-reg-bits.h (100%)
>   rename tcg/{i386 => x86_64}/tcg-target.h (100%)
>   rename tcg/{i386 => x86_64}/tcg-target-opc.h.inc (100%)
>   rename tcg/{i386 => x86_64}/tcg-target.c.inc (100%)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

