Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33895606A323
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 16:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=dP28XG2b
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJCOj-0003WK-Nf; Tue, 20 Oct 2026 12:09:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJCOg-0003W9-4t
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 12:09:06 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJCOa-00027k-HG
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 12:09:01 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4a1fa22006cso4360055e9.1
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 09:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792512538; x=1793117338; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=DCQ7iR5Q4BMy5YLT30D6L12FzlLSLnIgcnNDZHgSPjk=;
 b=dP28XG2birFlH4OmEAJjiVIFZFzz3siZ7g6/ORFk3ieuFfI1BQXJsGNN4njuvkhSz7
 4N8Qou0Ik0KIhnvA0eKNY9CGtJH2/izlgi4TzziRCHmuvnM+45XSQ0q6TGTLsM0vR0x5
 flUgsDqBZPjl0H/lRYaq0xAeJDKmdD0Cz/YnmGXG/v3GZp8rv6EaUWhjHJHkjhcQkqE8
 bYdRDNr/sMRDyFpgXxyEvWMAhWBpikWhb21M4F6BAyY5D9C/sHjFRUO0p+IcZCgupfKg
 9KxPxjBjBHOfzlVpQXdujcyJYfuRrafeDCzaIrAZdRnNKI10edig4ap5mqkQWDfXR+01
 BBXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792512538; x=1793117338;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DCQ7iR5Q4BMy5YLT30D6L12FzlLSLnIgcnNDZHgSPjk=;
 b=I6E0O3x2WaspkeSjAlvp8GOHH5VTUeS9GLxobNTHaj5yjV7hTxErUA2CcAbMKAZlNb
 bZyPeETbMCb3QYFEkOqO35ScTzOz0PULonrehm3yjkximIyWkSAeIP6jC6GNbBaVKHry
 3JmBcEisW9ypu5psPEQtGjkRR/40Kjxpd9HEylYZ8O4FI8f3+kb+X/GYBnO1M8cDWX01
 FlcwQCatd6f4GYVwt2dq58cr5alNp9lra20l0wAaZGvHg8QgioYTEYVbkF3/9y7ObNkA
 fjpxacoU+FLGEniBMCnksiu9Rnzs/YK4UiKcmN+9DuA54PbwzHhymtYyG4xN+7tQ7vin
 FcvA==
X-Forwarded-Encrypted: i=1;
 AKwUvByYMQrbg6g3D5xdIn39F51obqed586i0itOiyfrzN2Nt+jBPgUV6uUcZWz81xDuyWuBysrsmCPlj5Qz@nongnu.org
X-Gm-Message-State: AFq9FYJFuf6QDmfJObS7pLcHjynTqzM/yCudGVabzHg0uqIBy3X9n54j
 NgiHitT76rIRsxPkurcamS74oGdcAtxJiqgEMJDmA7CSuGzcGgWVoZkFZHivpKeqF+c=
X-Gm-Gg: AYBFou2awtnMD+vGRqDZeQIHv6/jJA1ZAxVZr6EH3OOi4UAGiJbesoFZSIE7qv4Wf9P
 3oW89kVBxR5g5wa8u1msUR/Tocrx1jJJ72QaXyXLfKDshlS2rbR40txyxuyMPEMIaS+v6sYNrs5
 QhxL5zAAWNeE4a+5AAzdgIak7o45RQYDINNd8CbXx3V35eGDUdQiiiNYH2MPfA6LeD+17zcLLjm
 HfnOzpv2hgkiMKthr0LFV+38ZREjJB7kkyCwiEr6ty047rUo+vQT/iPerL+0nt4ptEKKO7X6AEe
 TnM6GU5nnNNv1ZG+wuHjGoyYNHxCb3T7BgRe0BkAlyhEEFyTfO1jFojaA6cWaSSmp9Lu2b2nTeM
 qR7IOjInGQ52jfKjtG30busyF4Aupoxr/uzCKlPyO6PO8ghCOlj95IGcLVi6tEmlmk6ptrwLju0
 tSfOTGpdhnkofzvN0T0URYFPW7MiVYW31PNHpM7SK9aKz4vnSZfw7c/7A2L3TAHSGEBLR+QUPAs
 IATCfUnbsK8dlzbQrV8CUJvtu/YY9M/mSBwc1IPAbA=
X-Received: by 2002:a05:600c:b86:b0:4a1:d459:db4b with SMTP id
 5b1f17b1804b1-4a1d7610722mr233843435e9.24.1792512538331; 
 Tue, 20 Oct 2026 09:08:58 -0700 (PDT)
Received: from [192.168.2.121] (p5b3b6184.dip0.t-ipconnect.de. [91.59.97.132])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e1e0632fcsm6378905f8f.0.2026.10.20.09.08.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 09:08:57 -0700 (PDT)
Message-ID: <a7e19244-a124-4260-a741-623c0c286899@linaro.org>
Date: Tue, 20 Oct 2026 18:08:56 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] target/or1k: Convert to translate_for_debug
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Michael Rolnik <mrolnik@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>
References: <20261020122752.3651914-1-peter.maydell@linaro.org>
 <20261020122752.3651914-4-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261020122752.3651914-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32a.google.com
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
> Convert or1k to providing the translate_for_debug method rather than
> the deprecated get_phys_addr_debug method.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/or1k/cpu.h |  3 ++-
>   target/or1k/cpu.c |  2 +-
>   target/or1k/mmu.c | 21 ++++++++++++++++-----
>   3 files changed, 19 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

