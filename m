Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04242C54791
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 20:33:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkVGv-0001a4-W8; Wed, 13 Mar 2024 16:32:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rkVGu-0001Zp-Ik
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 16:32:20 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rkVGk-0005Xv-73
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 16:32:20 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-29be5386b74so251042a91.3
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 13:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710361928; x=1710966728; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8EQXYdw1C35y+BpHN8LByykkB6qNlkLOnhOrcNRY5ig=;
 b=plA5r4CB1GPXZsh+KnF6QbX3tyHYcBN9LimjgaRDtLOheEbqbgr+8Sv8xPapgW2qEZ
 x62giLdGFWeQjX3up8CoEUiZ7TSm+HAb22V3gfWEDAfsPZYD6a7aZIooiv3DL97itSnU
 q9LaFSPMW23RDug6lEQnNiCq85dAfjQJm3bduny6OzDiGF6zOIZLaIP0YzHbFD6xqF+D
 EbS1N4WWr3TICfApf+7kew70MBdE46FGr0AgMyXBNPGDAmbJFEaGWq2uEjitWgx4Fe0H
 pyhAMS7ad9/XEKbtQbpO9kzzwdZKqabEy4ckRP8v7vINtQ2wvSW9hiGHCU4PA/Z1JHsy
 NmKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710361928; x=1710966728;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8EQXYdw1C35y+BpHN8LByykkB6qNlkLOnhOrcNRY5ig=;
 b=cdYjfLo5bVaGkPIQ1iNItyvzszpbqJLiCut5vo/FFR9mJIx7QRALfZMIfEIhEwXe8+
 R+ACvSkioTrK5IhE3oRYBcHecynrxTrHGCPXVKvTzrN66rrDWScGwBlfXS3ZyBWf4Mr+
 uDTlmtGHenN3AswEzAcTNzJUYiFHDhSzNbpDVnMzVQrrpMiT8RptiHjOI7C6ZHeVyhez
 xgCoMuIeaoXSbeyv2nCxkfiEz/tWfA5Oy/9aK4Me+DvQNdWTzpOHcBSp8510RtxoPkKU
 8DOTLnHkVADcxqQqTyULxZVkKVxOl8acHDZ59YBktY7g/2et+6DeIaoACm59Xx72jNVa
 BTXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWH6oOqxtKl0BMvGhExs+WmOsWk2LOOpMcahQAgtB7gOI3l8NVa5XdC0oPwTJMYal+ApfQ6WbtAff4/4RPr1fz6o8u3dS4=
X-Gm-Message-State: AOJu0YydozLQqSefz1NO2LHcgZ5t50t70IHzp3Jomx1QyN6MBSkqY6x5
 zEJPpxozE9GEoGZSOZpiGCo9HoNPAyBhJgFScPXFljJ5KJ1Hs4zzj8LkHCDIiAE=
X-Google-Smtp-Source: AGHT+IHOvPyJsyxMuZdgCvX0ijZastQiKUrIpxrb9mMNRmvNV/9XZhe5ptw7sYDsgKLCyHTOEohdBw==
X-Received: by 2002:a17:90b:a15:b0:29c:7582:7de with SMTP id
 gg21-20020a17090b0a1500b0029c758207demr592100pjb.39.1710361928574; 
 Wed, 13 Mar 2024 13:32:08 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 i6-20020a17090a718600b0029bafbdcfbesm1758490pjk.46.2024.03.13.13.32.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Mar 2024 13:32:08 -0700 (PDT)
Message-ID: <4040e1dc-d856-4718-8b6a-9856b1521b1d@linaro.org>
Date: Wed, 13 Mar 2024 10:32:03 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] target/riscv: Implement dynamic establishment of
 custom decoder
Content-Language: en-US
To: Huang Tao <eric.huang@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bin.meng@windriver.com,
 alistair.francis@wdc.com, palmer@dabbelt.com,
 Christoph Muellner <christoph.muellner@vrull.eu>
References: <20240313095715.32811-1-eric.huang@linux.alibaba.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240313095715.32811-1-eric.huang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 3/12/24 23:57, Huang Tao wrote:
> In this patch, we modify the decoder to be a freely composable data
> structure instead of a hardcoded one. It can be dynamically builded up
> according to the extensions.
> This approach has several benefits:
> 1. Provides support for heterogeneous cpu architectures. As we add decoder in
>     RISCVCPU, each cpu can have their own decoder, and the decoders can be
>     different due to cpu's features.
> 2. Improve the decoding efficiency. We run the guard_func to see if the decoder
>     can be added to the dynamic_decoder when building up the decoder. Therefore,
>     there is no need to run the guard_func when decoding each instruction. It can
>     improve the decoding efficiency
> 3. For vendor or dynamic cpus, it allows them to customize their own decoder
>     functions to improve decoding efficiency, especially when vendor-defined
>     instruction sets increase. Because of dynamic building up, it can skip the other
>     decoder guard functions when decoding.
> 4. Pre patch for allowing adding a vendor decoder before decode_insn32() with minimal
>     overhead for users that don't need this particular vendor deocder.
> 
> Signed-off-by: Huang Tao<eric.huang@linux.alibaba.com>
> Suggested-by: Christoph Muellner<christoph.muellner@vrull.eu>
> Co-authored-by: LIU Zhiwei<zhiwei_liu@linux.alibaba.com>
> ---
> 
> Changes in v3:
> - use GPtrArray to save decode function poionter list.
> ---
>   target/riscv/cpu.c         | 18 ++++++++++++++++++
>   target/riscv/cpu.h         |  2 ++
>   target/riscv/cpu_decoder.h | 34 ++++++++++++++++++++++++++++++++++
>   target/riscv/translate.c   | 29 +++++++++++++----------------
>   4 files changed, 67 insertions(+), 16 deletions(-)
>   create mode 100644 target/riscv/cpu_decoder.h

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

