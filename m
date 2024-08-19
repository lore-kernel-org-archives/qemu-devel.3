Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24D47C52D7C
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 03:09:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sfslQ-0007ze-Dx; Sun, 18 Aug 2024 23:09:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sfslO-0007z3-NH
 for qemu-devel@nongnu.org; Sun, 18 Aug 2024 23:08:58 -0400
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sfslL-0004Ei-7c
 for qemu-devel@nongnu.org; Sun, 18 Aug 2024 23:08:58 -0400
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-27012aa4a74so1585661fac.0
 for <qemu-devel@nongnu.org>; Sun, 18 Aug 2024 20:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724036933; x=1724641733; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3quSi+Bjh2Et+PjGH24MAS2lg53pDLpOc660RB905ew=;
 b=ppswRCErkTkTjyDRyxeo8Ll0HZmLZKmzD2Gcl498IEnpLo/Wj+ZmhcvYSBmjc1p+q0
 Ege0SPZs93neLsJ19/Tfy//cJvt8ArcyE6BmiimLGt+2h41s1Oho/U3zyJPHzkjdL9eI
 cnv+Ojfh2ySftjdAuNMILZmagrS3+ZTPVPOY34K6Rf3QOAdkX52QZgvphvRNENdeyjOM
 vR07YH9tyf3vT0amhXOqiEBKAyliDLkPHxW84AIej8ZuBrNpOgA2vFkrmadw+OOCrNBR
 1ciGvBuRWpT6sFCgJSEWlnnqf8C7W4zpwLogUkqMjt83g2iE5v52WBpVCS+/9kRFgb1J
 pBWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724036933; x=1724641733;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3quSi+Bjh2Et+PjGH24MAS2lg53pDLpOc660RB905ew=;
 b=vpZYcbR+Q4T+bYBQ96h5m87oQSTECT6TmNWomJF2RKZVWO7ALa+LAba0iyvegNBHDG
 tVxaK8/Z8zk6AUSrbPP47CNPOArp6Fc8tG8YdFpY+jXt6VgHX31HPIuW4lab+50Mb6tq
 EJjOiXSwUsEszQMOM2kOxaqI3RhHNDIwxnXneEy3RziO+UOwcvC4LbEFetaahpYqAT/B
 3EA2PXXktu90yfStsnkNQqXh6H2aVtmTxEqWgee/7ILCsZGpU2tiX568nN/R9kTAadtf
 Deh4j+u4dC144ajjGYFCGYZ05QXjO+JQs8U4QQ8Y+bEz9M9kOpDKf/rTtni9AYq8MdIv
 XyIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCTp3ybIepk8SVRVyXyxaln2I8yB219NVhkdRLNNRQY21MVlhibtm6s4IuqQ0Pr9kuJ9gjYv6H5DQcDduVkvbfcFVWdsg=
X-Gm-Message-State: AOJu0YxT2caBRUE3vhNikZC8Dk4i5hrVXZ5K7T0mMN0E10/LcmWf+aGA
 tPdpGwgIoleJPZZ4Ly9jAeeSKJ00fcUlnaI87upH2hIJuyQe/VO89OfXnYOJxLE=
X-Google-Smtp-Source: AGHT+IFeiaf0yAjtsBWkwSWwalsdOPQlJzrhkVNo8uQgYDpiqdi+kXCxhgGTaE+u9kCKQc3q+AXJxA==
X-Received: by 2002:a05:6870:ec91:b0:261:164e:d12a with SMTP id
 586e51a60fabf-2701c3d9df5mr10860987fac.22.1724036933418; 
 Sun, 18 Aug 2024 20:08:53 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.109])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7127add6d82sm6002148b3a.10.2024.08.18.20.08.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 18 Aug 2024 20:08:52 -0700 (PDT)
Message-ID: <69dc62df-92d6-4dc1-8907-4f4533a08b36@linaro.org>
Date: Mon, 19 Aug 2024 13:08:45 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/17] bsd-user: Add RISC-V thread setup and
 initialization support
To: Ajeet Singh <itachis6234@gmail.com>, qemu-devel@nongnu.org
Cc: Mark Corbin <mark@dibsco.co.uk>, Warner Losh <imp@bsdimp.com>,
 Ajeet Singh <itachis@FreeBSD.org>, Jessica Clarke <jrtc27@jrtc27.com>,
 Kyle Evans <kevans@FreeBSD.org>
References: <20240816170949.238511-1-itachis@FreeBSD.org>
 <20240816170949.238511-10-itachis@FreeBSD.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240816170949.238511-10-itachis@FreeBSD.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2b.google.com
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

On 8/17/24 03:09, Ajeet Singh wrote:
> From: Mark Corbin <mark@dibsco.co.uk>
> 
> Implemented functions for setting up and initializing threads in the
> RISC-V architecture.
> The 'target_thread_set_upcall' function sets up the stack pointer,
> program counter, and function argument for new threads.
> The 'target_thread_init' function initializes thread registers based on
> the provided image information.
> 
> Signed-off-by: Mark Corbin <mark@dibsco.co.uk>
> Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
> Co-authored-by: Jessica Clarke <jrtc27@jrtc27.com>
> Co-authored-by: Kyle Evans <kevans@FreeBSD.org>
> ---
>   bsd-user/riscv/target_arch_thread.h | 47 +++++++++++++++++++++++++++++
>   1 file changed, 47 insertions(+)
>   create mode 100644 bsd-user/riscv/target_arch_thread.h
> 
> diff --git a/bsd-user/riscv/target_arch_thread.h b/bsd-user/riscv/target_arch_thread.h
> new file mode 100644
> index 0000000000..4596d3d51f
> --- /dev/null
> +++ b/bsd-user/riscv/target_arch_thread.h
> @@ -0,0 +1,47 @@
> +/*
> + *  RISC-V thread support
> + *
> + *  Copyright (c) 2019 Mark Corbin
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
> +#ifndef TARGET_ARCH_THREAD_H
> +#define TARGET_ARCH_THREAD_H
> +
> +/* Compare with cpu_set_upcall() in riscv/riscv/vm_machdep.c */
> +static inline void target_thread_set_upcall(CPURISCVState *regs,
> +    abi_ulong entry, abi_ulong arg, abi_ulong stack_base,
> +    abi_ulong stack_size)
> +{
> +    abi_ulong sp;
> +
> +    sp = (abi_ulong)(stack_base + stack_size) & ~(16 - 1);

ROUND_DOWN(stack_base + stack_size, 16)

r~

