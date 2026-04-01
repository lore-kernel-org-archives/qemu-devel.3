Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB8C610F6FB9
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 14:58:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7x11-0000eU-Bw; Wed, 01 Apr 2026 10:57:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w7x0u-0000dp-Nk
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 10:57:48 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w7x0s-00036k-7x
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 10:57:48 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-35c1a131946so655902a91.0
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 07:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775055465; x=1775660265; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7zY+WJBmQZnfgg+bU6mIxK5hOsuQA0UDPUojGKP5t2Q=;
 b=CATXyYb9uctyXkRG6iq3fcvrBVo/1q8sniTs/dzjNawFGKEWV0Tsu0FVO3qshXOfAn
 amOImnvOgGXZFpsUfai1i3SaM9wKndmnNo39DzTH3n157R+W3MiK2Ry2J594NcqmIxcY
 1m2b/crABgDA27L3d7QXdVfVKkRYV7IOtItJ25iTdR4ZkJIuAYVSZS9uEOw3NUcp6lxP
 ie+zEN6VKx3eyViPyD+TZk0kdEi/OOtJ9adRRxViTe1bdt4xXTlCcQSkGDombzZTotcB
 BN4aWWFMDpawNYeghXl+Eltq0032aS1Hj+XVO7Y0ucUvFlBlfjSo+cHac7UGW3Y/29AQ
 QGKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775055465; x=1775660265;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7zY+WJBmQZnfgg+bU6mIxK5hOsuQA0UDPUojGKP5t2Q=;
 b=CzDBgcCCQKLK0JdVeVUz+wioNvjM0MFHT3aIFYgOGwThoZQud92s6kpx6ix/eiyPie
 ltiIBfYC0+gpBJDLUYS+IVtYUFdwfTMTc8nFUiOYeEQhu/LhTyFzqnyOxiGZvh47eTrW
 bSd5u1EXIy9Qq9Vl0ot+0n3mZdPIGQMZcm6TPOv7oJf7Nel3TMNGcgLJltd9nywtY1ed
 z0QZiNr1SEia1ae3tVUbakhjsITxAfC6GRxZCqjoCqUAnrENMdsq8JqC7mHe/wSCsoHH
 rf1PiB/JlxMlW3ELlRnDE8PjtUVIYJLUjAbekMjRJqZ5M3kd3/vS9sA37zPe51tdQbQV
 415Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTvbRaxLSqvMRrYiTGgd1MExwJEIwQmt3q18AAI1px5KSy4YdLl4UsofB1c6V64WnS3ErHUCuG36Pb@nongnu.org
X-Gm-Message-State: AOJu0Yy2vlcKkrl+GpJAmlBn5Y6iSmY/1TsMFZ9XryiN+spGRNNnGnwF
 iHAvkU/yqEZRFIsCqbhSnZikRIkTIVDSSa4pQGe7MSq93x2vhurFonZoTfUxlGMOZ4w=
X-Gm-Gg: ATEYQzxkRljUSv5WgWj5Lp2XqvgLfTk/0SnfLQzBHkX9pA+pegM4d30njZdc1JmJYMe
 ZQe1MZno3fQW1N25NJNJ0fLrbfJ9F4oGxMgyHOM9yXU95a6mQ20jg2q8xqxic22jcrySIqEflGm
 rnPcKnV8tWld+GO/OSFgt2FYfnTQBi0uLfMHYUrv/Sl9MgX0yHsOsKlucbXi8D9Za91J0czmUij
 ECBdMCT+Xkcd81BxRhdAJo+k7uZ6qxaniFCdqOO468JzfsHEuJqz7CTCATOtm/tJBCWX/I1439b
 fNbJvd1SAR91RNWnPtwvmS3XcTIhFDW/OqaLnjFtgjk0ZoEeXd8nJGRuxM6jc8wabgmojhmtQ+Q
 fMSpmdjTzD8Af2gmQVvbBRZNSkjp8fo2hkCGciSFIcvSMjHppeofTrfUEtTIO/7otCsH+WiWPVe
 hCedtwdZ1iW6qWMhzzHFRvfkSpiZm4q46HI3p3iboDiCrVBDZmfpFIT0C5TPBsgZ5/VTPwElI1u
 A6kQI8=
X-Received: by 2002:a17:90b:2d8b:b0:35d:aa02:d776 with SMTP id
 98e67ed59e1d1-35dc6e7b196mr3470275a91.2.1775055464688; 
 Wed, 01 Apr 2026 07:57:44 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35dbe5e5127sm6974158a91.1.2026.04.01.07.57.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Apr 2026 07:57:44 -0700 (PDT)
Message-ID: <d9ebb776-59c7-4ee2-8aad-dd38d14baae6@linaro.org>
Date: Wed, 1 Apr 2026 07:57:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.1] target/arm: Replace target_ulong -> vaddr in
 guarded_page_br()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Anton Johansson <anjo@rev.ng>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20260401143456.79843-1-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260401143456.79843-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102e.google.com
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

On 4/1/26 7:34 AM, Philippe Mathieu-Daudé wrote:
> Following commit 15500df3b3b ("target/arm/tcg/translate.h: replace
> target_ulong with vaddr") change, adapt guarded_page_br().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> I know this expands to uint64_t on Aarch64, but vaddr for $pc
> seems clearer, since this is the type used by callees, i.e.
> probe_access_full().
> ---
>   target/arm/tcg/helper-a64-defs.h | 2 +-
>   target/arm/tcg/helper-a64.c      | 4 ++--
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

