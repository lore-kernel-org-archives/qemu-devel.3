Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA393606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 22:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=nxASy8QL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVylW-0000S7-TH; Tue, 24 Nov 2026 17:13:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xVylR-0000R7-6k
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 17:13:25 -0500
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xVylP-0004Fp-4n
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 17:13:24 -0500
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-3ae6b4c669fso4959782a91.0
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 14:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795558401; x=1796163201; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2KQUHy7122zoT3r3imAFaNEEyFG9iak03VpkK+4oius=;
 b=nxASy8QLE1GJodepdRveiqK41nVhGi1XT4oy1IC0q+ZDgu9baJoup236meCP48wic2
 GHRT3qI4T7krQgk63dhYD6YX68gJZiIqyeJjrwcSuXH/inouYoNJZ85RBSD3TXfsu+2L
 IIVfqtBJ0Xlc+ks9xKb7LMEIs4NzW8VKmSSjScKNHzAe2Ovq65Xdt86/EBh2ZtFpCGiI
 uCRIXLervn0tPybBBmv3vSA/dmuFEo+WPb4V27M8FYWih3ZmOhGY2cx+5/ktQopbW0cA
 CR5B5zfpLSQ0HktJDmkxfvtfkT+jCl6rG2QGw46Bv/4LNfxv0y0+sDqUaymAhYabwrd0
 ADyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795558401; x=1796163201;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2KQUHy7122zoT3r3imAFaNEEyFG9iak03VpkK+4oius=;
 b=vB/j5F3tkwKowOocRP4SB0/lJE+DXrTXFI5CFypTVJw4vhvRBO57uhNlTiSpN/FGhY
 HwYbEMZAWjORgryxr5z1Inisr76L6HkUPTRWN2cjQaGUqSnbNfv9u759mES583StoyBm
 xshKFv/h4OdQ7TUq+A8LsVV+zVLxzGrOWm2Y5joV8iR8P4gUie1Sqc+FRXfR3lfeO+aE
 cm8s5RL15qYO5j9i7IFxHcV3sOUK19ooNXR4l/vR/zeBzGDI0bC0IHcV93OCLqZzNUmt
 KJHQ7wlKCn0CGjWfSxgltjZ2bBLtjT4vlD5j1p6gmLgDjBqcqUC2DhoNfJrP1p5s01Op
 /rEA==
X-Forwarded-Encrypted: i=1;
 AL+hErGAG3cb/+Z7LJkmF5ZT3jBeDVs3SLmza3b66l5DM5eE4YfeKOMt2B+AOylJQnXWpJJavOb0clciEpWD@nongnu.org
X-Gm-Message-State: APuU4Z+qiwmZ3rkG6PbjXBhkZenwnPKi+YzvfkWSc+0bJ2rwwXnQ6eho
 H5k7E8qyndsBCHAh7MN6K9sr3B3+4HAJKG86+iKD2kV1dAe+lTVCrwV0FymkAuDolrE=
X-Gm-Gg: AZFdTZeQLgJBcTEcNg1NhHcVQjOju9YPHwcQSgDK58tOMF+gmDPkEYscPxYrPWfp+SD
 9srYcWxyhF+t+z1P3+/A6l/Cegb06h3AQ3dxn7DR8mo3vdZHh7Iu+xoU2OFEgW/b9e4ifRhygsO
 2jQ9GurCmI/dF07yu6HGE6CyBedciIjVHTALcoCgttoJyGEIUxeammh8m7qmHtFOW6UiUe30vEA
 sG2zE8reAyz/J/Z9EJr+U3YpRcXjc7Yvs1ajj7k0WfmBpPY3Z36o3llmEIyRgr5zkMRYZ36LuvW
 BIiz139/PC+OxRqLQ/GPOBoPom1tq9e/23rMeeyoqCl1bnW8Z1NHdkHNPd27sxxjfHQJVEWA8kM
 XpqGJuCeJiALUb55DkEqzaYpDAqlPzE6+9QaqZi5rfhbhjmnThKGE3j8BOcb8Ezm4WoGl6hKlen
 PzqqhDpnrJnYdaFZUasBEFH0UhwYf7TKVg+kExmpNhy02V6YcPG8A8C4SrHey0ukOBd2fTpC21T
 FeeH2xpS0/JBhX1vUI2CTmQfjktlIVOEYo0851ND396TOeAwmufn34A3UFFcIkOdOo7fLwaRKCI
 lxDc/w4SLgreFO86QkXCIi9gXXTJDKYgKzROhZK/pg8=
X-Received: by 2002:a17:90a:e710:b0:39e:6c68:fd91 with SMTP id
 98e67ed59e1d1-3b41c96151cmr10028418a91.38.1795558401107; 
 Tue, 24 Nov 2026 14:13:21 -0800 (PST)
Received: from [172.20.3.121] ([156.19.246.27])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b44b8c2fcesm8677271a91.4.2026.11.24.14.12.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Nov 2026 14:13:20 -0800 (PST)
Message-ID: <dd1f86fc-bc32-4a9c-9908-31d5ff0d442d@linaro.org>
Date: Tue, 24 Nov 2026 14:12:43 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/tcg: Enforce .valid.unaligned for MMIO accesses
To: Mingjie Zhu <zhumingjie.123@picoheart.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Ziang Wang <wangziang.ok@picoheart.com>
References: <20261123090355.30085-1-zhumingjie.123@picoheart.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261123090355.30085-1-zhumingjie.123@picoheart.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/23/26 01:03, Mingjie Zhu wrote:
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index d79eae58df..6a174d12a6 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -1896,6 +1896,10 @@ static uint64_t int_ld_mmio_beN(CPUState *cpu, CPUTLBEntryFull *full,
>                                   int mmu_idx, MMUAccessType type, uintptr_t ra,
>                                   MemoryRegion *mr, hwaddr mr_offset)
>   {
> +    if (!mr->ops->valid.unaligned && (mr_offset & (size - 1))) {
> +        cpu_unaligned_access(cpu, addr, MMU_DATA_LOAD, mmu_idx, ra);
> +    }
> +
>       do {
>           MemOp this_mop;
>           unsigned this_size;
> @@ -2410,6 +2414,10 @@ static uint64_t int_st_mmio_leN(CPUState *cpu, CPUTLBEntryFull *full,
>                                   int mmu_idx, uintptr_t ra,
>                                   MemoryRegion *mr, hwaddr mr_offset)
>   {
> +    if (!mr->ops->valid.unaligned && (mr_offset & (size - 1))) {
> +        cpu_unaligned_access(cpu, addr, MMU_DATA_STORE, mmu_idx, ra);
> +    }
> +

This is incorrect in general.

This raises an unaligned access fault from the cpu side, as if the cpu 
is using an instruction that requires alignment.

What you're describing, however, is an access fault from the device 
side.  This is done by generating a bus fault, via io_failed().

That said, I do not believe for one moment that .valid.unaligned is set 
everywhere that it would need to be set.  I suspect this patch breaks 
x86 emulation at every turn.  In fact, it's only set 3 times in the 
entire code base.


r~

