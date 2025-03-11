Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14E4CC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 17:41:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts3ak-0002mh-Br; Tue, 11 Mar 2025 13:40:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ts3aS-0002ZJ-Kl
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 13:40:17 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ts3aE-0007Kp-T4
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 13:40:14 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2ff6a98c638so10939926a91.0
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 10:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741714790; x=1742319590; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IulK9oSX1fmlHAF2PB0d2Tk0XU1yXWYTsZ0D9dWgkCk=;
 b=NjJwho1d6a3BYVkG8uZk+gXwBLnhQdS9gs2p4RgU9rRyUAiUenricYmLSeSa76wSiM
 YIoN8psOhmQYs4tal2FElm/1k6Q9IwYb4tAcaAUTVeBygOyC7Qgc0ssyH5D7iS0aSsR3
 EKLUKzPhajKPI9bo4CXVTG7DEb9ysD8FTSnqLWVMp9In+rFECXZVi2ueDP2b251eKv51
 qD7VAWAw6EOYTjwCvnWoCWvkDzY5CCLwZBCmSKe3N632Jw8sM9Vpw6C4xyqMkfZi2R7Q
 J/e8ICycDrCwhyjykWh6cXsbSsp6GEozXZyGsJIYif5emr9SyVBdKe2yEZ7Lena6eeac
 Rw8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741714790; x=1742319590;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IulK9oSX1fmlHAF2PB0d2Tk0XU1yXWYTsZ0D9dWgkCk=;
 b=a9Ipo5MBXL0yr82nCbRw4taoZMI1UVdTVRhtRmYW8oBBD5FByUiEZlFqqgz5tINfyc
 gaKN7JYjPOOZoHz5hF0tfnF2dQu+9lXCEI2XpjYWUjHWJinItnWExB0bsJPwqmY0fZWT
 FH/jaRnAPFI9HRCAGVzpFs3tpypapn0KrtoDj+x6pzKUVipg1LVrwwokZxQ0VtqMX2CD
 cvorxMhsPA35/1veepjOAQDPuT7n+ppVq5D/ptCtpt2ATadQlMTkfckTtZGE6kAbMuO7
 V5JGYRXMnb8scc4FUE1iq7mobtsgsBU2ZM55YGnfNEUwAtGg6/z3/lqzkhi+gTg0H6W0
 hWJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIoiADGUimCEoibnjNtmXz0srpS5jCqxULgfFfIfYXA+DobBaFE/AQD4XyWulk2yQfSAqeSA/riM0i@nongnu.org
X-Gm-Message-State: AOJu0YzcTTQ2sz2xdWuStFaHAQ1IUSBR/l2/FJ8PN1VzSGbclrDAeImH
 1CUL2H3sUAXGYt56ZCt+4rgYuQ1C7BA5Cs2O+4bydeGqPzhiTIF7J973RumCBqw=
X-Gm-Gg: ASbGncsTjidjXAudp/avuR7X9r3K4/PDGRZpR4UkKb+XjGQsCcSNa4amrpFtrynzjWD
 zKGDmNuXSQkPGbcKG76JUeOeBZ9hDim2/8XwtAmZRCV5B69vtnWivA5JpPX9Gw2aKPOECf9u12M
 Z/pEyIdgtSm8p/svi9nzEbkPfVz1kX3VF8fb74BhBBjZ+hBwiX0b6PXKUvQH3T1nLHDIqi+D/HP
 pQixsjV8lWOhJfm8N9ACSE7WN+SuOaNn9Iy/shkbb67waesV9+2AUR0KYbEu5+mrFh5TKWcPR/o
 rCFyKIVDXF7L0r4a8G/uIYGXAxmHODeHb5TbMOMx+pxU/HcYO63e4+GitzWFB4A8tQ3SSW9PXv0
 efWCAPc2x
X-Google-Smtp-Source: AGHT+IFtUwoTgphZdxHED/xz+kHxBykcRSZJ7Lw2JMN9Wv5Od3oTPmsm1Y42/tjEXRSNVy9vWWKNag==
X-Received: by 2002:a05:6a21:68a:b0:1f5:8eec:e50a with SMTP id
 adf61e73a8af0-1f58eecec3amr6186663637.31.1741714790580; 
 Tue, 11 Mar 2025 10:39:50 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736dd702c4fsm4166211b3a.18.2025.03.11.10.39.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Mar 2025 10:39:50 -0700 (PDT)
Message-ID: <3b8c9531-b770-4ab2-8c33-8d3bfce03eb6@linaro.org>
Date: Tue, 11 Mar 2025 10:39:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/14] arm/cpu: Add sysreg definitions in cpu-sysregs.h
To: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
References: <20250311162824.199721-1-cohuck@redhat.com>
 <20250311162824.199721-2-cohuck@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250311162824.199721-2-cohuck@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 3/11/25 09:28, Cornelia Huck wrote:
> From: Eric Auger <eric.auger@redhat.com>
> 
> This new header contains macros that define aarch64 registers.
> In a subsequent patch, this will be replaced by a more exhaustive
> version that will be generated from linux arch/arm64/tools/sysreg
> file. Those macros are sufficient to migrate the storage of those
> ID regs from named fields in isar struct to an array cell.
> 
> [CH: reworked to use different structures]
> [CH: moved accessors from the patches first using them to here,
>       dropped interaction with writable registers, which will happen
>       later]
> [CH: use DEF magic suggested by rth]
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>   target/arm/cpu-sysregs.h     | 37 +++++++++++++++++++++++++++
>   target/arm/cpu-sysregs.h.inc | 35 ++++++++++++++++++++++++++
>   target/arm/cpu.h             | 49 ++++++++++++++++++++++++++++++++++++
>   target/arm/cpu64.c           | 22 ++++++++++++++++
>   4 files changed, 143 insertions(+)
>   create mode 100644 target/arm/cpu-sysregs.h
>   create mode 100644 target/arm/cpu-sysregs.h.inc
> 
> diff --git a/target/arm/cpu-sysregs.h b/target/arm/cpu-sysregs.h
> new file mode 100644
> index 000000000000..b95320b5b595
> --- /dev/null
> +++ b/target/arm/cpu-sysregs.h
> @@ -0,0 +1,37 @@
> +#ifndef ARM_CPU_SYSREGS_H

All new files should have a SPDX-License-Identifier tag.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

