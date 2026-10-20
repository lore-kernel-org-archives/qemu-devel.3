Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99986606A319
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 16:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=sSfj8zrp
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJCP5-0003c3-2v; Tue, 20 Oct 2026 12:09:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJCOv-0003Zm-Jz
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 12:09:21 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJCOt-00028u-T8
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 12:09:21 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-48e00eee27dso2038375f8f.0
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 09:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792512558; x=1793117358; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=kTvpOI9vTteqA2xL36OSKTTix7qkvkAzXpVlPm/dvkU=;
 b=sSfj8zrpO0+qtqeI+gCxDmF+DLPVWEWwIRAX3EP5oaFhT0sJO2g4lUtR0h4ysrbE0u
 aJauFwXqpNhK6ilrGK6LK9SqZvm7C4KY8Z3UaQGNm0qO7stocgf38sqXTRzXrygXdAn8
 s8YAKQkpuQx8vB2TSk5zO554HQeBxdT+Vp8dpdnbbaCcGXfS3UkHfZR5pzA+vdS9taPo
 lvzVveo7cTuU7NDUGQYfn+95a9psPj8FPQGFnma+ocL+gM23hDgCKCWHJ3tRf2HiGFYz
 KYm2q1QuEVJFazMALwC1YImsgLiDoG47tFYdZ6lkHHghXEbgIRJWZZSC6HPOI10NCbA+
 FzLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792512558; x=1793117358;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kTvpOI9vTteqA2xL36OSKTTix7qkvkAzXpVlPm/dvkU=;
 b=vSLVGevArIXCgqrRVdFpHGXrQ8ObfhHtgVEVBCa2843zsfn2i4B6ltMoJn8/C3T7qZ
 ofG2quDeUEv/i0zQ9d0xwH2k5+6KaoKyk0MDOwc+Y/r1Q+A7Q7YxuKcvsi4oA8LQjxXu
 AYJVx+KJKY5InExWqjttiLWrZCI3FnEMeYNRvtEpbDoLcNnwSFj7/kQMp4rb65phwlwJ
 QKVYRdjSl9v4ModUWFWjOEZovvDoxG6zzEeAbpcv4SlwefA0DyQnRGpLtmm8+XbRbifa
 bQh9XnPkETeOMHdnbSuCJiUpQEfDYS51R0YTJeYUqy/TDXL5yPNhwF/2Ek9rS7hZOtyP
 qy7g==
X-Forwarded-Encrypted: i=1;
 AKwUvBxdlUJb3Igj0lJzNVOefaUiBZfQq4g9Lr8893mhiu6xu28+KqXdrquPD9TNtk7ZsDKXnbsiCzuQk10m@nongnu.org
X-Gm-Message-State: AFq9FYKSG91za2omUSB3KxWTDOaNGtWkxpPYcT9okHa/Fawpzgy/C7Vq
 7of+uBJc6KfJaI3opFPUiePh+DO4RBVz8OEJcvrJ5Q1QMLxDBo48Lp+xtVGViDZwoZI=
X-Gm-Gg: AYBFou397qqEuXYM4aFrxmViRJ2MvbiEfiubcxS2QQt1Q9sFoNM55LZc6smOzB4gkbv
 bsdiPezcjFbv/YstGQu0nlUZWwFIe9IfAzgE5oBoZQ3Xo//fuDydNxTOiMSXinLtIBnNiCbBZQr
 WSDmkugKPawWPk7jZgA+qsNpRkanEfKmUIuF1FJuJ+fzid73wEtzR9bLEvVmOEUaMNtA6TgIE0W
 RVOKJu6kMAbkBMoF5onCnUAG4iKUv9QVgSZU8S/dsyPLxfiGRNPtTpN11bdmK8F7lrw/tUU9GXR
 YGPY4XbOFryOO+9dmNFCZMFOljhAAgVKJ/15ycxH+PGB73KNjDVYbT38Qeg/hC2usjgPnzfFpX6
 NNP4OIxFIUYf3JC8fi4kRAEPjePtVr8cFd1ljYfVDSc/LoEF9m2CJPDb4hHmNgJLmGR4vGRmKx+
 vNkrdCvcs9J8jR7FWRcfXfYd1qeBpoUhwOh5bXjVw21tv62VDS8Hk/cBmmsIsHa6TQAB2nbfSBT
 Y3/6gkkbpOt6wQPWDRP1dVG5EzdNhzbs9UlF254Ck6ni3q5W1jFMw==
X-Received: by 2002:a5d:5f85:0:b0:48a:fb3e:d93c with SMTP id
 ffacd0b85a97d-48e079800admr23485116f8f.5.1792512557912; 
 Tue, 20 Oct 2026 09:09:17 -0700 (PDT)
Received: from [192.168.2.121] (p5b3b6184.dip0.t-ipconnect.de. [91.59.97.132])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e1d8178dbsm7528181f8f.21.2026.10.20.09.09.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 09:09:17 -0700 (PDT)
Message-ID: <abafc102-06ee-444d-936a-30ff1855ff91@linaro.org>
Date: Tue, 20 Oct 2026 18:09:15 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] target/rx: Convert to translate_for_debug
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Michael Rolnik <mrolnik@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>
References: <20261020122752.3651914-1-peter.maydell@linaro.org>
 <20261020122752.3651914-5-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261020122752.3651914-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x432.google.com
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/20/26 14:27, Peter Maydell wrote:
> Convert rx to providing the translate_for_debug method rather than
> the deprecated get_phys_addr_debug method.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/rx/cpu.h    |  3 ++-
>   target/rx/cpu.c    |  2 +-
>   target/rx/helper.c | 10 ++++++++--
>   3 files changed, 11 insertions(+), 4 deletions(-)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

