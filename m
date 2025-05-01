Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 383D3C3ABA3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 19:39:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAZkt-0008Ro-Lj; Thu, 01 May 2025 15:39:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAZkm-0008QX-8d
 for qemu-devel@nongnu.org; Thu, 01 May 2025 15:39:29 -0400
Received: from mail-il1-x12e.google.com ([2607:f8b0:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAZkk-00021t-Cq
 for qemu-devel@nongnu.org; Thu, 01 May 2025 15:39:27 -0400
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-3d9030c2b73so3037965ab.0
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 12:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746128365; x=1746733165; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nlq6iTf63SDAgmQyoUr4eQXZVo5JWhey+WvZC0D4jEM=;
 b=vQRT8NC0agTxaA3R7mUtOsAlmvUmX3jLlNXVWteSH9NWRwUTxQAO7mSTYV+uGraeOm
 YUApoOtcYD8A/9HIfBrDkYdmCICl2x9wXYzqJ6kXI93l47oR2uXkWEeINVDJAn9uSuTv
 BwVJUC9uIUfTCPUrehkMWtK/g17nVDRDBqbaRoJa8MbZmoYqtJfvkWZ+f0XXv10+RGHt
 X5kLSL+exRd4WPH1UyWexfwt4sSOudIkxEUagSueyKPaSyGBoAjdAia86j0/eSeKaY7F
 qAK1e0J3iUn4snIUv+AmvPRJyVCwu2JnIhjhQcod/nwmBE/ED/vGgkCOsTwpt90QEhEq
 lbtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746128365; x=1746733165;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nlq6iTf63SDAgmQyoUr4eQXZVo5JWhey+WvZC0D4jEM=;
 b=WnAiT4iLNavkB1rAteGnqeKssJ7QmtrDixJ61uehyyh234dh31oyfZPEUhyJgE4sCb
 JYA0KXHuqURramAc0VmGlJG+Lt8BBjKfoY6+o5Lu0jDRUBre/FCvuVlOaZ0gF1XvRmsF
 g5/GnafO6LgSXZGaMSrdDzVuAaQwRFDx/Ci8h3Zvj3YLoCe4FDaPhIt2mj4w9Pbd00n1
 qXkvO8Z9glJmLjA8Lfyz10+ic5oqs5P1/J3g+nXJLiMh+bzoV6Z2lfVn5RZ1i7Y3SCIm
 IoqeywmAXH7vYJ+gdPc/H9m5aBdGh6TA8ETVaSjX+ldBZvAesK9BpE4ixUQ4PW+V59no
 iKJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXd9xYoLzY5DgCWtB9sBAVogBtVll1/GwlZnxuxESPLHguapj7GwaC1/RHvHIuPrkPxtzN995pl2fhb@nongnu.org
X-Gm-Message-State: AOJu0YwtOETP+LUKFHUBA5zL/wEaDn74ooHiypWVyX8g1nMChI5E3+Ww
 AaODrh5ZkA+pKQ9IyJ8Dipj+9x2+O3mY/Ge3I+fLUWkYpomC7k5PI4eictWySy8=
X-Gm-Gg: ASbGncuYhIlhgkufCajUv66XyPd2QdEx9ZSri7i+ccNOe64oub+L01Q50nb7vEr4pI9
 W83BqI994uR2oq24mz+7DoRKJJ7KxGT2fVHSU1iokjyisLw+OFftcwdPRDhST1VBOm2E9Pw0pip
 K1bXwjMXDXmU2fWifvaqngSuaFbxgbMpqS1b8PTT4MD62CwnvoHEJ9dsWsvm4DMnYrG9mFduWzl
 lQo2BxK2kOHPhgbHuXXpjSh1MW6Iy7sZKDDPRb9KV4NwZVsiCnVGMukUO0YL4fQeyBJGaSjyxkk
 zYibZSnLo7NrQI3mfhqRrVD45088rfGbVPK4FQp+XhJsSUOpP926YW08CXuGEyuFEq3doNDvuqL
 z1tnXZJV6AhiPbA==
X-Google-Smtp-Source: AGHT+IF0DKU0vWDI27HBCLLqb3lF6PlydJ7jWJ16z0KomH5fVZrUvwSrBmzp9y9yr6yikCma7v0d5A==
X-Received: by 2002:a05:6e02:1a8f:b0:3d8:1a87:89ce with SMTP id
 e9e14a558f8ab-3d97c147d40mr2231665ab.3.1746128364823; 
 Thu, 01 May 2025 12:39:24 -0700 (PDT)
Received: from [192.168.69.244] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f88a8cde80sm16481173.5.2025.05.01.12.39.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 May 2025 12:39:24 -0700 (PDT)
Message-ID: <48fcb7b5-0f6c-4efd-b77e-ec86b5adc0cb@linaro.org>
Date: Thu, 1 May 2025 21:39:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] hw/core/cpu-common: Don't init gdbstub until
 cpu_exec_realizefn()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: "Edgar E . Iglesias" <edgar.iglesias@gmail.com>
References: <20250429132200.605611-1-peter.maydell@linaro.org>
 <20250429132200.605611-4-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250429132200.605611-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12e;
 envelope-from=philmd@linaro.org; helo=mail-il1-x12e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 29/4/25 15:21, Peter Maydell wrote:
> Currently we call gdb_init_cpu() in cpu_common_initfn(), which is
> very early in the CPU object's init->realize creation sequence.  In
> particular this happens before the architecture-specific subclass's
> init fn has even run.  This means that gdb_init_cpu() can only do
> things that depend strictly on the class, not on the object, because
> the CPUState* that it is passed is currently half-initialized.
> 
> In commit a1f728ecc90cf6c6 we accidentally broke this rule, by adding
> a call to the gdb_get_core_xml_file method which takes the CPUState.

Oops sorry I missed that.

> At the moment we get away with this because the only implementation
> doesn't actually look at the pointer it is passed.  However the whole
> reason we created that method was so that we could make the "which
> XML file?" decision based on a property of the CPU object, and we
> currently can't change the Arm implementation of the method to do
> what we want without causing wrong behaviour or a crash.
> 
> The ordering restrictions here are:
>   * we must call gdb_init_cpu before:
>     - any call to gdb_register_coprocessor()
>     - any use of the gdb_num_regs field (this is only used
>       in code that's about to call gdb_register_coprocessor()
>       and wants to know the first register number of the
>       set of registers it's about to add)
>   * we must call gdb_init_cpu after CPU properties have been
>     set, which is to say somewhere in realize
> 
> The function cpu_exec_realizefn() meets both of these requirements,
> as it is called by the architecture-specific CPU realize function
> early in realize, before any calls ot gdb_register_coprocessor().
> Move the gdb_init_cpu() call to there.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/core/cpu-common.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


