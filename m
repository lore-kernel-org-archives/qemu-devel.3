Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02BA4FCA192
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 21:25:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzi5u-0004DG-QL; Mon, 09 Mar 2026 17:24:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzi5s-0004CG-Ie
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 17:24:52 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzi5m-0006j5-Tt
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 17:24:49 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-48534237460so21241325e9.3
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 14:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773091483; x=1773696283; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iEb3Gmw+DV8qcnYdyNHFPna1pmpKVc9WdtNxf9T+YHA=;
 b=rieLvP4FQhEhoTc8ftunnGf6MO1L4wa42m7O2ZZUAMn87G0f7Z2feqE0u0QrhRWwzO
 neJ4NqH0VOmSb93hP8JafI8lJgbOE4GHp29yL3fMmTAHY551cjMQqdpR7seretTSiNPX
 yffdUWr7/c8BtCZmkpAyfB9Jeg11wn6nU8vkxwSCHADc5Yas9BmODhpWumnq/m7zit9t
 uCeAwTFEp505BuRy/5DIFvbxscU7X2L/VV+XxJRzw/C9CCoXopCX3g21tD8PTI4T5qlK
 tMnzg1Y9yAy2Lml7wg+P34pd8OZo9Z+fQhPoBG3gMaFFc0+svTGL7sJ6D9W+kxvbbcTt
 WrqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773091483; x=1773696283;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iEb3Gmw+DV8qcnYdyNHFPna1pmpKVc9WdtNxf9T+YHA=;
 b=FGVa13F/l+wjs5K1On5IPP5mhVQwnqHN5kRLdyCRS40dP2g19lFL2vv4QSorNHwf/V
 ZCN/5YSfEMyJ6o0jNtwvwjMesPGqrXQKwcq0ERLu8P5v8CaV4lo5YUCxVEWbXPN4LG+1
 LzP6y0Jwezcq22k5R0h5Cnidf102jG8HjEy0R0Ddsm7wu2pq6824DmSoxi6SA2m5kM4T
 X9rZP5ahSGnrQJ2UpCOjdSjjju2cBRHRP97RejCmovNJNi292NqkaXg6CdMEFbmULMte
 TRhCnMOeF8qrjJbVUFOvSKQny0k8f1tNtsvfn2fv5pT66G9pPIUsYWIELFcU87BS3wyx
 fQzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCGgj09rVGx8xgWNTOLpPRo/u5JpvoRRN/CoE9RcAQsN7kXx0cBtllDN0Kt2BwG9CkSlg91IdILMTL@nongnu.org
X-Gm-Message-State: AOJu0Yxapk8Id55AOlh0FUa6hhPmlKiK6kRw3n/VQkWCfLyPKOx2pgmA
 O+4aiKRP0l4/GifjXeVz5IdCd9pMvymrn1/pMOwAJgmcs9jMPZcmR9/0E8CksihX+Q8=
X-Gm-Gg: ATEYQzyUDFlvM75/+u5e3YD8dPx2aX6yOAYl4geDoPnZ+6G1xo0s7O3IoOwenfqJPxs
 fThcVo38nGTxfnKy9qtACPEpzBk97L/x7P1AlbBrjSbi1ijw3Abewlx7ZxHbpqZWpaRaq/jWKOl
 mRbmgH0a1nJy4zggFVIZa7K4lK5Pcr24GnDTj/r9NBVRS0XI9TXCN3XmOQE5auoL2DsjicXsJO8
 xsl3L70DiE0xEuLQzUrGROXlXmBtLdmQ+pRnMVf3cg3WRqcF4AWaRaG4iPhYfvUTKnA7QJRalsT
 1Xd3Qv32c//RmPrIsCCMOBigeNA8bJe8MeopoSTrQfhH45CBxt3ZTDKCnxYPnTTrwL+ViEpoHhY
 vMTgXhvMEjqrc0stp41DbJTZ//NPUVxkHhqxMisQGyN8+eSL4YXr2i39S2SnNsfiPZvoTmCdyBQ
 lgThnp9lhqaFoYGwY75HqwF8J4omPuzlYLEzCHf/DzngbnaFQLZJ4iPl0T1S07MAmSDg==
X-Received: by 2002:a05:600c:c16d:b0:485:3f58:d99 with SMTP id
 5b1f17b1804b1-4853f580e8fmr50948345e9.34.1773091483496; 
 Mon, 09 Mar 2026 14:24:43 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541a7f20csm19877365e9.6.2026.03.09.14.24.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2026 14:24:42 -0700 (PDT)
Message-ID: <c6203e80-f81b-4fad-bb6e-47b67beb25ca@linaro.org>
Date: Mon, 9 Mar 2026 22:24:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/7] tcg: Add tcg_op_imm_match
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, jim.macarthur@linaro.org
References: <20260303010833.1115741-1-richard.henderson@linaro.org>
 <20260303010833.1115741-6-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260303010833.1115741-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 3/3/26 02:08, Richard Henderson wrote:
> From: Paolo Bonzini <pbonzini@redhat.com>
> 
> Create a function to test whether the second operand of a
> binary operation allows a given immediate.
> 
> Reviewed-by: Jim MacArthur <jim.macarthur@linaro.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> [rth: Split out from a larger patch; keep the declaration internal.]
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tcg-internal.h |  5 +++++
>   tcg/tcg.c          | 21 +++++++++++++++++----
>   2 files changed, 22 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

