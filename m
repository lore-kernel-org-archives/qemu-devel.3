Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43804CF2579
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2024 17:31:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t02Q0-00075h-SI; Sun, 13 Oct 2024 13:30:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t02Pz-00074e-7F
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 13:30:11 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t02Px-0003OZ-G9
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 13:30:10 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-207115e3056so28669415ad.2
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2024 10:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728840607; x=1729445407; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D83f+KcDMnwyLbifqJUEWjwJAIEKpC5jUUm4zFbphN8=;
 b=Z0GpGmAJ5zHEDjQilxt8Ojxc5RtzxrJJiTTGNGXNxKU5od0ke21lJD08tEgFKOKtm7
 OzKM5QMVIlrCz0YAdyG8+dW8NAinanVdBsNdjuJWVCNGQGqNC76mOQqdMYIBRdJALdWF
 l0I7gyWhAbGHxgTWXIcUAMtK0ZEVIxNL+TtweW8OJRo7v3ZZ9AvlaeEkZE7IqLs+UiHQ
 6ume8Wd0joYVvlAolXxxWs+VeE7q10u2t9QW0RILb7RdIxz4URalClOXl7bmTPR0pNrR
 aDpjn4vk2XnH7hs26HiXRsbWxGLqNssk0Ssi1xDThVlmHkbeB/FmigkcZqZD9acDLNQK
 1sbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728840607; x=1729445407;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D83f+KcDMnwyLbifqJUEWjwJAIEKpC5jUUm4zFbphN8=;
 b=kt6s7yZmg2uyH6OKgidizAJvV2eJvJqjTZerILxF0A1lFgCEOo/3PcCk7cZhAH1aR9
 VqB4SFnf1EYsL7A1IWgiMbIZRtZbkthPOfDjRsEcykBvWjGw8Z/UzIjKZBJkE5QfspCm
 QKvddya9tdYh5bk8pbggwZsClNG3JO3YBa2an2OLihGjEdUytl7PbfOqIgKOk8j+Zrde
 NPPmubY/LSioCOSRY/Yvv+TLu5wURARD70uzf+twNQDy7Lzx6qYUY3fc6XwOukqcELBx
 eMxkggNe7V782JlZuVwzXF0XkWocqaVDuHLlnMFyuQOGe1S7cNJ2+nlM8qRgXgvv9AuL
 qILQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2J7d2Ex0gAnQ2Keu/RHVtLEqBTxCKdfZqN/rbJdGfEadwRfu4CyI/YJlR6GKglT41n7qZXNmdZkwR@nongnu.org
X-Gm-Message-State: AOJu0YyCIF1zaHdZKfx6uZIPBxBdxxe8E5cBj2YjT76Yb5tY4v0EKrcw
 SgBzhTaJoXcl+yCBonbcU7cYvFP+t40MBsEuaLhX0vtPbNieLL3eVmdVmZWeQOM=
X-Google-Smtp-Source: AGHT+IGrPfoTMUDK3lDrcjzWYjo4g56J97q5vrKmHF0FsqXrzbBDO+Mc+3b/FMGfWtqYt85ZF0wr6A==
X-Received: by 2002:a17:902:d481:b0:20c:a387:7dc9 with SMTP id
 d9443c01a7336-20ca3877fd7mr118200965ad.29.1728840607421; 
 Sun, 13 Oct 2024 10:30:07 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c8c0e7513sm52020925ad.137.2024.10.13.10.30.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Oct 2024 10:30:06 -0700 (PDT)
Message-ID: <e504719e-aa6a-41c5-b2f2-31e3400807b5@linaro.org>
Date: Sun, 13 Oct 2024 10:30:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: Store FPSR cumulative exception bits in
 env->vfp.fpsr
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20241011162401.3672735-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241011162401.3672735-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 10/11/24 09:24, Peter Maydell wrote:
> Currently we store the FPSR cumulative exception bits in the
> float_status fields, and use env->vfp.fpsr only for the NZCV bits.
> (The QC bit is stored in env->vfp.qc[].)
> 
> This works for TCG, but if QEMU was built without CONFIG_TCG (i.e.
> with KVM support only) then we use the stub versions of
> vfp_get_fpsr_from_host() and vfp_set_fpsr_to_host() which do nothing,
> throwing away the cumulative exception bit state.  The effect is that
> if the FPSR state is round-tripped from KVM to QEMU then we lose the
> cumulative exception bits.  In particular, this will happen if the VM
> is migrated.  There is no user-visible bug when using KVM with a QEMU
> binary that was built with CONFIG_TCG.

Ok, noted.

> -    int i = vfp_exceptbits_to_host(val);
> -    set_float_exception_flags(i, &env->vfp.fp_status);
> +    set_float_exception_flags(0, &env->vfp.fp_status);
>       set_float_exception_flags(0, &env->vfp.fp_status_f16);
>       set_float_exception_flags(0, &env->vfp.standard_fp_status);
>       set_float_exception_flags(0, &env->vfp.standard_fp_status_f16);

I will note that this affects can_use_fpu() in softfpu.c, at least for the first operation 
after setting FPSR: without float_flag_inexact set, we will always use the slow path.

In glibc, when manipulating FPSR, it tends to come in pairs: feholdsetround + 
feresetround.  With this, half of the time we'll be setting the exception flags to 0, and 
half of the time we'll be restoring old values.  The latter set is reasonably like to have 
inexact set.

It might be worthwhile to set float_flag_inexact in all of these when IXC is set.  We will 
still sum to the same result when reading later.

That said, this fixes a bug and is not wrong so
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

