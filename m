Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FCD606A323
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 09:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=xiUBM9mY
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xStB7-00078i-Cz; Mon, 16 Nov 2026 04:39:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xStAk-00070g-EG
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 04:38:51 -0500
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xStAi-0007f5-Jl
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 04:38:46 -0500
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-67db8985419so812828d50.1
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 01:38:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794821923; cv=none;
 d=google.com; s=arc-20260327;
 b=PYMc5pvD5mOEjinwUZp1wuOKvcYzqE0iCffsukVU48Znw5+T6D2uv69zgbmhqAlb/q
 ZdUp99r5FQrrw/GkBvqXrFpukhzk4lpYI2fbtIEff5rIoO7foO8U7hNUYpYSJ0lwhVo9
 hhop21EeBg8ZmMA8JjWvQ29/2xMRlML2MNTcBrBaFv2CglF1SH03aCsR1ve1tY/iuNec
 U/MnQ4f3YbfU8gbYfnZYVtY1yZ0LOde4BL3dypus0bSFj8TP8mIdyBG52p9OEB6js20Z
 mQ7LPocR/sUuu+EdlSGo0km2azgFjYPiGs3axKsIxyoSNFEI3YpwOx5gq3k+WiFHPigM
 BayA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=fH5GMPft6TcG95a0Ylec4P9fiZvDE/4gh++pKKNRaR4=;
 fh=KWaBfB8XFaYNsSiXdMsYH8wjQkGcQWcX3gAgSI0xg/k=;
 b=ip6VyDyU5zxUfk42/eqYZsepT1n8ZJBfj8Fvw5QboYTquWRg66J5AxP51TrwXpzN6O
 ux4USpDXxgUoCN9TA7a9VD7TN70FWSVmGvDYbV927LOq33PpxmfrYD8Pm+KU0zpsBh8U
 imNhMPnzaWBsAAsCQkG4wd2qDFFJZGeqRX59sGhNiipkr8l/XHQzVMslPtkY0uwpjJjs
 Z5DCK+kigDTNcl+K+HZRg6RiojNJiV6BUfpleNwQpzMKcVBgEAXt88In6pFF8wT0O1eR
 ChiaBZ/O0LcyxODD9exLn1iTW1Tat8qoVYILuy75aaLvTLWIyywjuS4mVnXiiZW3Pu1U
 B2ug==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794821923; x=1795426723; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=fH5GMPft6TcG95a0Ylec4P9fiZvDE/4gh++pKKNRaR4=;
 b=xiUBM9mY/99YfWQMIxWpxDJwHMgHcsgLTkL7o9ink0NQl8deXPT/dVb/E99yU5+d81
 ir92XU1EFP5t+48uWcsZm7SPVMWBiBg74I7gZtJh8Cj4KLAuW1c7f+Mcouo2i9kZzn1A
 dZlw+05Bd9yAeRK9Qchq8mcDpputF6uMFklRWZmmhPW732dtoMeML4GuB0akoqS6oODB
 30SaDSl7Mglva+Xhgq+cJuSkhv54rKD7UOQ1fkPMxNJyKWzOFpw5E8lBtQK7fmP+jXn0
 zWWGlR97G6AX6jFq8t3pfgkKByxzIUAdUW55j0V2OjzLPw+vlTXba3TIX1ftOrbyQwfQ
 Cf0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794821923; x=1795426723;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=fH5GMPft6TcG95a0Ylec4P9fiZvDE/4gh++pKKNRaR4=;
 b=htU+QW1BA3mUqCfubAOsy8vFguTso79ui2zeMZm2mxoHckpp8iRNZYOPsv4R+6btGk
 td09QogPDmC0c23NvO8FUAqCf/bomZ4AK9wtXuKhwL9W/bnB3bfysfoUlfyBirjvGARg
 c7L5lvpRjuSJRfBABZrB0BlVOA/twYB6hOtOm3Esc+NmXwgUTkc0v2F759rD7uiW+8+f
 ucFGwSGJ9gPvrhr/xuca75JI8JhFTnhuuKkRqEeKLsn2QFFlN+DEJ1E08eJZc5lK1tCH
 fbIBHdAV5l1kiq1Dos9lGZkQ04Oe0JEd/m/J865qIfkegEBI4JyqZQvzfskynHG3Xd2t
 yk2w==
X-Gm-Message-State: APuU4Z8LUizgg8oFqZNvUgCpEuNxxsMyWR9iU8ReBg0eSQSr9aMjbVdC
 tmgTM0RJuxcsxJ3NwLuZn6NZaITTDdKsjoxYFfGtvMjxQb2NsGOADTFdiXZL5a0XswAh8RjVXxn
 /5U2fqYSZBNOBLH7nVDYoi6V2I4Dt22wiSWdFzgUe1w==
X-Gm-Gg: AZFdTZf5OO/eJb0yzfDfbr/NaBntBK0CfOC80aoddzcv6udZ5Va+czBdDwLG6R4xT5a
 DyPEqK8TXBTYakgsbajI/eWYeU1CktoXwnJbYthkbr4Cn144BDV3tpVvk0mkMGGAbWI6Ts/9bDL
 p+WMRthdeW5UvrIE9PTlzxIDuQ8hlbzuXvn59kiffFNwn9sfUe4DybRzUdyng3cAB9/n+MikiBU
 KbZd8jcXsWEvmrx1hj8/IkiY6cfAHPXc0NS1QbYlWO0pCBo5HgMs8T4ajxQagFHSesGW1aERc9l
 YsNS62/ctR7xSOJMMWcMClYULeMMfCpn7xwHozpgCwCSNerYNOrpWCBa1kMa1lGVlcU2AKHx1FR
 /jztBguQ1S3chjjSxxZ0lAPau7CkaVYiClwkRICoXUXxIGOT9UODb1xxEec58azCYdP0oT4SSfm
 r9bvF/1zpeV6bl+mPMZVzF
X-Received: by 2002:a05:690e:1388:b0:67d:b27f:bec9 with SMTP id
 956f58d0204a3-67db27fbfb0mr1691399d50.64.1794821922953; Mon, 16 Nov 2026
 01:38:42 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261115-4836-cpu-host-error-v1-1-fdf0eb56ba8a@gmail.com>
In-Reply-To: <20261115-4836-cpu-host-error-v1-1-fdf0eb56ba8a@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Nov 2026 09:38:30 +0000
X-Gm-Features: AclHuK_C3RdX6CP7oACaMR8BmGBFMQ5YGM58rprxg-C2Zkf91BmXhJO86YOH8is
Message-ID: <CAFEAcA_dyd8Y5mJc_J7dtDwLL3eDaEo1P8fx01Rjkgah+q4Dvw@mail.gmail.com>
Subject: Re: [PATCH] target/i386: make error message for -cpu host more
 informative
To: Andrew Nguyen <xmphyr@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 16 Nov 2026 at 03:38, Andrew Nguyen <xmphyr@gmail.com> wrote:
>
> Included the mention of WHPX when the option -cpu host doesn't have
> an accelerator option.
>
> Signed-off-by: Andrew Nguyen <xmphyr@gmail.com>
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4836
> ---
> This is a resolution for issue #4836: https://gitlab.com/qemu-project/qemu/-/work_items/4836.
> "-cpu host" by itself is not permitted; an accelerator must be specified as well. For Linux,
> it is KVM. macOS is HVF and Windows is WHPX.
>
> Previously, QEMU would only tell the user to use either KVM or HVF, essentially excluding
> Windows users. This patch adds WHPX to the error message. A similar patch was made seven
> months ago in target/arm/cpu.c:1861.
>
> Signed-off-by: Andrew Nguyen <xmphyr@gmail.com>
> ---
> Changes:
> - cpu.c:10229: added WHPX to the error message when "-cpu host" doesn't include an accelerator
> ---
>  target/i386/cpu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index eab0d5a4d4..7dd5535f80 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -10229,7 +10229,8 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
>
>      if (xcc->host_cpuid_required && !accel_uses_host_cpuid()) {
>          g_autofree char *name = x86_cpu_class_get_model_name(xcc);
> -        error_setg(&local_err, "CPU model '%s' requires KVM or HVF", name);
> +        error_setg(&local_err, "The '%s' CPU type can only be used with KVM,
> +            HVF or WHPX", name);
>          goto out;
>      }

The code isn't checking "is this KVM, HVF or WHPX", though.
accel_uses_host_cpuid() is checking "not TCG" (also "not qtest" but as
that's a test facility we don't need to mention it here). Listing
an explicit set of accelerators means it gets out of date whenever
a new one is added (as has already happened here once when the
WHPX accelerator was added and the message not updated).

thanks
-- PMM

