Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2571C3DA70
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 06:55:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVmwn-0004NP-Dk; Mon, 22 Jul 2024 02:55:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sVmwm-0004IM-9E
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 02:55:00 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sVmwk-000593-Ko
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 02:55:00 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2ee9b098bd5so50884071fa.0
 for <qemu-devel@nongnu.org>; Sun, 21 Jul 2024 23:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721631297; x=1722236097; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=suY8gqgezLbAE9TOVB83qdEPUeM3qcUTVHktutxGJAg=;
 b=dHD6rEFPhgZOlLY8SPvKjZxkr9HJJg48ZxDxJVFAfsz8fS1Br4+IX0wbntmI+D5o9c
 JLYOM2l90Bomaj82+41yU9GKn1hq84fyheFKwP4OtrZgZe+/gk8stXkeqEpoM9Kj55hL
 nqAt+sfE1Ze5BJBIOUGqNVytl4lmcJouHVkl2VaBGxq3Mb9vuzQwVQSVQCfdqJFvSJhC
 CSRQdRVcWXN02REdthslsbxenjBB2ALrUbZgIMfS2GwNjC5MrK6havyenYpYQFFnpWCW
 X7T5hwmD51WCF5rBfIza1d9bkEErnCGhXXkzcJrFBx9oBYMn5FHhfwgR2qk+EPxtkmdp
 hLGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721631297; x=1722236097;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=suY8gqgezLbAE9TOVB83qdEPUeM3qcUTVHktutxGJAg=;
 b=nKpfg6p3Mjb0aEyPV43Ap4gRokOApZ139oCiTtBrbxr4m71eI2fUUT7M2LJyqBK3Je
 wqgAKCa2KZ1G2UH5uTWv92s3DJ/3YNWECDSB0zWz1mUALuos5NBqi2nXttslIeHcsdva
 EUkhe2php6Do3ntO5r6uVEAsVDmzrhzxPAjM3GJ4Yj4pfcoovP1bL8GJKhJIP787Xqei
 r52UC3Rwk2fO84MCpYWX3AZAopRecicwXOOc1HBrJdvw4MyoXFQbwOtVthoyGFsnhBHV
 SazVibHBfjJdsVgdpIPfAHCIz4z4K+kVSDxH7I16lbBRvhkh0v12vjxziUvshIME2TcE
 p1kw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfJVa8xl/flOITUVsZnDB7pAVedKfEupVT2ykVcbACpxhFLYIoo/5X3n5agVH/Xb1jg49ZJl23R5LcpY8dJhQwC56Pm0A=
X-Gm-Message-State: AOJu0YzwzL1HspMlxsB7LFTCxSeLek3+Dt25SOQ/baZU5O10WaprhUJz
 iYtuzcTHSNANn2kDVOT1IePGdeGsnycQxG8FMh+bZIF5EIlQ9R/l0Y+iYdLRsFA=
X-Google-Smtp-Source: AGHT+IFgSREL1nTqizZ601MjRN/ad6zdu68ok3HivnSpWgTSIEhUQcS4XC/sMkPzOunOOHX2AFJrLA==
X-Received: by 2002:a2e:9e02:0:b0:2ef:2580:c0c6 with SMTP id
 38308e7fff4ca-2ef2580c2d4mr32061231fa.14.1721631296664; 
 Sun, 21 Jul 2024 23:54:56 -0700 (PDT)
Received: from [192.168.69.100] (gen92-h02-176-184-20-254.dsl.sta.abo.bbox.fr.
 [176.184.20.254]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d6936d62sm112532305e9.42.2024.07.21.23.54.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 21 Jul 2024 23:54:56 -0700 (PDT)
Message-ID: <42f92293-2c7e-4ab0-920d-f81da79f550c@linaro.org>
Date: Mon, 22 Jul 2024 08:54:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/13] arm/boot: make range overlap check more readable
To: Yao Xingtao <yaoxt.fnst@fujitsu.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org
References: <20240722040742.11513-1-yaoxt.fnst@fujitsu.com>
 <20240722040742.11513-3-yaoxt.fnst@fujitsu.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240722040742.11513-3-yaoxt.fnst@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22c.google.com
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

On 22/7/24 06:07, Yao Xingtao via wrote:
> use ranges_overlap() instead of open-coding the overlap check to improve
> the readability of the code.
> 
> Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
> ---
>   hw/arm/boot.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
> index d480a7da02cf..a004a90e87be 100644
> --- a/hw/arm/boot.c
> +++ b/hw/arm/boot.c
> @@ -26,6 +26,7 @@
>   #include "qemu/config-file.h"
>   #include "qemu/option.h"
>   #include "qemu/units.h"
> +#include "qemu/range.h"
>   
>   /* Kernel boot protocol is specified in the kernel docs
>    * Documentation/arm/Booting and Documentation/arm64/booting.txt
> @@ -238,8 +239,8 @@ void arm_write_secure_board_setup_dummy_smc(ARMCPU *cpu,
>       assert((mvbar_addr & 0x1f) == 0 && (mvbar_addr >> 4) < 0x100);
>   
>       /* check that these blobs don't overlap */
> -    assert((mvbar_addr + sizeof(mvbar_blob) <= info->board_setup_addr)
> -          || (info->board_setup_addr + sizeof(board_setup_blob) <= mvbar_addr));
> +    assert(!ranges_overlap(mvbar_addr, sizeof(mvbar_blob),
> +           info->board_setup_addr, sizeof(board_setup_blob)));

Indentation is of, otherwise:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


