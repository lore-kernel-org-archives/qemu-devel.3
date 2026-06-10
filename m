Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43EDACD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 17:12:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXMTW-0005rq-1u; Wed, 10 Jun 2026 13:12:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wXMTU-0005rd-CS
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 13:12:20 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wXMTS-0004an-Qy
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 13:12:20 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-84236f9b638so3371593b3a.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 10:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781111537; x=1781716337; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gsD4xx5787ciVUey6AHYJvcKtxawArOofQB+aUx/aGQ=;
 b=vatxd18kkMcOJBbmlKSJw0prRnnHQ1NHxS4yiyBeR0eh6eO0MKzS8+JT9o/ahE9D9M
 a6slIlzMk7CooQ4x+vqICPqfmDZVxVBWt+UukB3tlW7mNDyR/Az/MJeqnINtV0bnRwaE
 5/Z2KfuQKuA3gPHeYHa7r22F2CUYEYQ9ero2KeiM/dO+rOLRn4uUz+E7wNesxq0rYhEq
 UA5R3MLxok260ZAU8xiuOdtYwhoy9KbZ4LCanNDNKB3vIXf1ibLPOfdhdeWMDu2+PH4o
 MsPm/lB42t5XhI1yXLt4LV3DAQRFJuoY0nAyfx6joIiUhk5HqkpULOuy1v8WW/i6EDWG
 OeUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781111537; x=1781716337;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gsD4xx5787ciVUey6AHYJvcKtxawArOofQB+aUx/aGQ=;
 b=GgSeEMccin6v3TZvvn3usFsMr24t2wpteDIFZ71PUI0n9u88qqjmFObh6r2DTP4Iu9
 9qMfhviBbQ7Z3OyXBLdkWDfgJ8Hzz7QsxBEC1spsvrOZgmogh+PKn9fG8LXtqJTCn0dq
 UvDh43yWBVMbwsAvL1+5a6GOuiwtHEjujUmG0KTr6ppJchQjx1CV0WgeuJFwOB9zLAtw
 WZ/3hQHAz3t6yoawxz4mYVJyrVXwrMEpZpGhlvaaBdNz1cyeBwdrbryEF5s1rcLTTjNQ
 VIFwZEdkD6NzjcMU+2LQKsapObCTimp+PzyUQxw3ir/LrzutJH/yAqGOkpSBJaTmIYPp
 IGbA==
X-Gm-Message-State: AOJu0Yw4HXBFKFSWShxkWIcAbSd6UsJ0DmUcJWrdpq3j185j9mzg2obA
 GaLhUNKfwlj/Zc3JRoGRgw97+GZ9pmzLnVBvmCFziHSap5THTpO873ph987g/QrAQtjglVTcvs2
 hp81sTHE=
X-Gm-Gg: Acq92OHXWa4NjpDTSiRpd8hZobYSfA/VK99sjn0fATgpnPow+SSZWw/ac7KKoYpH0jR
 aIImKnMNSuPmlqG+VcduoR4yCChN4tI9YtFzlSojqqZ1fCRTaTaGSQXsZIwh5T6G1zLaTaqfLnk
 Xr57/3NIvOmk0CIEqnOmAE0M2jBnpsqv0m/9MTZvWKmhsQVZR5Mu6eKRAXtVlSzO8L5+X/AbwOP
 7UIH5Y9hRVaei8zxP7ROVa1WsyfHsVg+Bm2/YWkFDfxkZGLHoiLmS3b9A0e5neFVtO2fM96qwDc
 NabvIzstYVAbuJq6kdQ397MJ9z2AYMCyHpIAetN28bsaH+NpMOfT8o0gDvzKC+n75EIvRq9Ts7c
 q6wx5OZ0QYjI22RsV91owBkNRLKfxyjNiO9kC0RHWww/8Hs6Cm5IAIIl3pET4qyzW2Xt3Mz0BL1
 aOJ2Uifkn0PzzcY8wSk1yhN7gAu/+/TzS06fl56lH95Chsv3o=
X-Received: by 2002:a05:6a00:32c7:b0:842:422b:259f with SMTP id
 d2e1a72fcca58-842b0e30c6dmr24759872b3a.10.1781111536759; 
 Wed, 10 Jun 2026 10:12:16 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-842828cb2bdsm25692032b3a.41.2026.06.10.10.12.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jun 2026 10:12:16 -0700 (PDT)
Message-ID: <412b9efe-fe48-4e30-bbc0-762aae4a19f4@linaro.org>
Date: Wed, 10 Jun 2026 10:12:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] tests/tcg/aarch64/system: Alternative boot object
 for exception logging
To: qemu-devel@nongnu.org
References: <20260603-jmac-gpc3b-v2-0-115c51936962@linaro.org>
 <20260603-jmac-gpc3b-v2-5-115c51936962@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260603-jmac-gpc3b-v2-5-115c51936962@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 6/3/26 11:26, Jim MacArthur wrote:
> --- a/tests/tcg/aarch64/system/boot.S
> +++ b/tests/tcg/aarch64/system/boot.S
> @@ -60,6 +60,40 @@ curr_sp0_irq:
>   curr_sp0_fiq:
>   curr_sp0_serror:
>   curr_spx_sync:
> +#ifdef ALT_VECTOR_TABLE

This is pretty gpc specific, so "alt" feels too generic.  We could probably come up with 
something generic, but let's wait until we have a second test with which to do so. 
Perhaps rename to "GPC" for now?

Some asm improvements:

> +	sub     sp, sp, #16
> +	stp     x0, x1, [sp, #0]

	stp	x0, x1, [sp, -16]!

> +	lsr 	x0, x0, #26
> +	and 	x0, x0, #0x3f

	bfxil	x0, x0, #26, #6

> +	ldr     x0, =0x1001

	mov	x0, #0x1001

> +	ldp     x0, x1, [sp, #0]
> +	add     sp, sp, #16

	ldp	x0, x1, [sp], 16

> +#ifdef ALT_VECTOR_TABLE
> +	.align 12
> +	.global exception_log
> +	.global exception_fault_address
> +	.global exception_type_code
> +exception_log:

You don't need to export exception_log.

Slightly better with

	.type exception_fault_address, @object
	.size exception_fault_address, 8

etc, for the 4 symbols being exported.


r~

