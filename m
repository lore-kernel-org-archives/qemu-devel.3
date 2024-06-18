Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93A24C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 04:36:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJQZO-0005AV-UO; Tue, 18 Jun 2024 00:35:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJQZN-00059v-1F
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 00:35:45 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJQZL-0007om-A0
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 00:35:44 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1f7028196f2so41073285ad.2
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 21:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718685342; x=1719290142; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TUuL3CZtUWS03+DsGlAAAXR+jJ4iIqlvQVCs/VCDkq8=;
 b=b8BzS0uNJQ/OdwBbwJi0sz+0nHAhcPEZ/AsXcAFMiIrUkYkSSOKO5NQJCJvrdOncPO
 2MFCQJCSrVj+GoVaMxdLVHqxOQt9MV73yVkP/XwkRUqQmR88Ht8jyxOfhBXfaqtBGax+
 cZU3Lrs45YBVlokzo1apEylZ8QUnk9eMO7/77suXW98K5rNybtD5xMfPJBrFaV+jmCM2
 A5m+2fpxp4fpcJ3zZvMU0a3A3dmFsZdr2C7qCs9yV6w1GS4WfD/mbeIk4nv742p05xNw
 nyXdWtqinE56WpDJqYR13K7aeyv4qY9AAuTDT4jmCmFCUNVXlfG5/KN3WxrhQ3WaMVVk
 6x0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718685342; x=1719290142;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TUuL3CZtUWS03+DsGlAAAXR+jJ4iIqlvQVCs/VCDkq8=;
 b=JzvqTzaMPOmY9+gDNrom60eYFmfHO0CYqoym9TRy2Y4hNTkJTFC6cFZ6Ube+Gpy1Uq
 f/K2rpdldubYRUvqlSRVN78NUiSZycHimZq1aXXQCjgF1VeOVhpZK4AV4fGiUgDjls7y
 xcpue8xkH3tCr04u20CI4FfWyXFjMId1MRKazLugJzYcgp1KM/C4JEfH7pK9BI70WgkU
 rCQF2+H1br37uWIIEMITsdilKgZZ6LjSn1zhOS2B48TLlpX7Wxari6m2ZZSy7CYFY7RD
 /km5mLrDoWgOTLYPE1XLmXDrEyAsLzZDT7Lxkh35HJD6l+2pXNFoo6+jwme5i0Zvi4Xl
 TsAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvWJmBtmvBuXwDWMFNul7o4IpggVEGjdkhw0sPCEXck22YTDwUiiWGQbITiInHvtifKxcC0rP9vKMiucJcg8EVpvTFoWQ=
X-Gm-Message-State: AOJu0YycmDnS/iRjBryTCKPB4TQlGVnDG+MFFvtbBHiMsb2b05OPtokq
 RX+5SoXZ054ek5Xm85HuC96Oj9YeznZpulH629loWP7pjqObjgbf4MVg0wayd1M=
X-Google-Smtp-Source: AGHT+IFDdHMGk1/+F2ZNeJxAvyERRGIDn2DwlED4yxpksnr/0nS/rIMDVgaWrGUNVzzzLZPtSz1Z6Q==
X-Received: by 2002:a17:902:d482:b0:1f6:f336:899f with SMTP id
 d9443c01a7336-1f8628062bbmr117917935ad.54.1718685341653; 
 Mon, 17 Jun 2024 21:35:41 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f99b6fb565sm1514295ad.242.2024.06.17.21.35.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jun 2024 21:35:41 -0700 (PDT)
Message-ID: <c6e6100e-6837-4f47-bb8c-5db5c7ba3aaa@linaro.org>
Date: Mon, 17 Jun 2024 21:35:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/23] Add Aarch64 register handling
To: Ajeet Singh <itachis6234@gmail.com>, qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Ajeet Singh <itachis@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>
References: <20240617185804.25075-1-itachis@FreeBSD.org>
 <20240617185804.25075-7-itachis@FreeBSD.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240617185804.25075-7-itachis@FreeBSD.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 6/17/24 11:57, Ajeet Singh wrote:
> From: Stacey Son <sson@FreeBSD.org>
> 
> Header file for managing CPU register states in
> FreeBSD user mode
> 
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
> ---
>   bsd-user/aarch64/target_arch_reg.h | 56 ++++++++++++++++++++++++++++++
>   1 file changed, 56 insertions(+)
>   create mode 100644 bsd-user/aarch64/target_arch_reg.h
> 
> diff --git a/bsd-user/aarch64/target_arch_reg.h b/bsd-user/aarch64/target_arch_reg.h
> new file mode 100644
> index 0000000000..5c7154f0c1
> --- /dev/null
> +++ b/bsd-user/aarch64/target_arch_reg.h
> @@ -0,0 +1,56 @@
> +/*
> + *  FreeBSD arm64 register structures
> + *
> + *  Copyright (c) 2015 Stacey Son
> + *  All rights reserved.
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef TARGET_ARCH_REG_H
> +#define TARGET_ARCH_REG_H
> +
> +/* See sys/arm64/include/reg.h */
> +typedef struct target_reg {
> +    uint64_t        x[30];
> +    uint64_t        lr;
> +    uint64_t        sp;
> +    uint64_t        elr;
> +    uint64_t        spsr;
> +} target_reg_t;
> +
> +typedef struct target_fpreg {
> +    __uint128_t     fp_q[32];

I'm not keen on this, though possibly it doesn't matter for hosts that bsd-user is 
intended to support.  Better as either Int128 or uint64_t fp_q[32][2].

What is this structure used for within qemu?
Does freebsd support SVE yet?

It's certainly not used with this patch, so it's hard to tell, but can we omit it entirely 
for now?


r~

