Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1D5606AB24
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 15:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=PxulUTtC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM5VK-0008TE-DT; Wed, 28 Oct 2026 11:23:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xM5VB-0008Qh-Ho
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 11:23:45 -0400
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xM5VA-00010V-4D
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 11:23:45 -0400
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-705cb6ceebaso739965eaf.3
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 08:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793201022; x=1793805822; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3i6bxbRZova5Zt4s8yFQ50r5ZezgAwsOEKYhJpXWDuQ=;
 b=PxulUTtCYec3GQnME0WafPHkZD+ZI5292whjLruS+dCi2ppbuYW7XZfCIJHtcDmDju
 F/4+nuV5pYBYzO6xHxsymmw5rJ95Qka+98wjefIFMcBIvD9tImzqjbDisOBQ4/i5kQKG
 hLWrIX1n8khvVI8f2C/AodcxJpYXEYAgZq/eFxfG4T8u0MT7ypmFA53sGIAxGMAf9NNB
 CoyFUDSWogdZl0AdM7w2+Pl84NtBMVTFmgR4CUHS8OlifnGOE8+nIPeoI2PSynsikHVg
 J222asAK6HTKq9m+9sWG9fHCTWWHv0OproQL9DVrG8u7s79SLR4YcIvo70jiS2imvYSP
 g9QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793201022; x=1793805822;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=3i6bxbRZova5Zt4s8yFQ50r5ZezgAwsOEKYhJpXWDuQ=;
 b=LZDoaB3o1IqmM/IRt02GrPIz7NJAOb8A/UuSmXC96sy56Ul2i4/vHftF2h8S/XwvTH
 XLmnRZntwsLKKdh5nYtQZsCSgUQyBkA7Qx1Y54KwRUUVji/8+PzrY4bDkc61OIL1hTsT
 CXx4gN8fdQKEYSymhhtzBaWa3BWlAX8xpXNWjsQeE9rKMbe4UgIfhcxApn+tur03qWJ9
 NW4Y4snnKOyFBVWUcIAB7hiFgcUd5A+97sq63YEx35aYqrhP5UCbTvH2OE0+H72DNoX7
 mIaCu/WkvvYKClauiw1ryHjm+BOUx21mqvzr3pIKCdAz7+8mZpNlgb+Z64+1J++dCXrs
 g9gQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxX5PbWmT+XUeEpO2QEuszBfuecAGrkBCaqJ6A9vVSQh5RJSCJd3TYQhle6kkp4jZfWjaBybE8mfrcO@nongnu.org
X-Gm-Message-State: AFq9FYJcK3dvR37EowwYM9b0YNADJGIfNH/BapHicH9wdpBgNe27+9ZI
 S1oesN3VpbMFnepDRVbaWLpJ3WVEVDuWctgv7JJv7rpcEW9WhT2BlR3G+IinNEJnxRU=
X-Gm-Gg: AYBFou34Zo5iyMUyhs9oQWGKzL5LZPOSK975ByNiAXMCCiwc+OFDab43lq7iuFFwg0t
 N9LFGWC3kCs4Fwg+0EqjeMZnhl5uuKRa3CKtvUJQoc7Zbf1MzksaBYj7v3P3puf1araW7MlfqX9
 RqMDnBvdVB4QUPU+8z7STATuKwph66HfZakgeqgKL0Hrk7981biHCbuZ2yhTzOtH+tPwLLMmZW7
 ve7mjYKNBO8k4+w/Am6NLUYhUQ6IY1LWqehTEFaV6b2q7kzNEDZZ93iV4nfbpYVbt6bKTY4Y5vf
 mItz9doYi/lLMCdUhoS4zhZ+CVI/7pej7nweWJcdHyiCf9B0o3b41X8kUYgg6oF1wEJzp7DMuEr
 46Jf7Hz0fziPnEw3wN5EoQjoQOFoA21EaP0o2A6V5IZj7EHSWYcYx4IQuHnJaLiIdf3D5BDpjqE
 G7EGMZgnuZfnyJnDRaYbSRi/agvaJzgYxrQv/nrO+mOhfgS25m6AUzMClXPNKUO/BzQgkyMC+bJ
 2xpqdbcNywnfuzTHfkKrFOslnxIoF5WtrSwo4z7NDT3h4cGdk5PgzwCVaU/UIYjCokykQZzXNNy
 9CqLelnfs0Qx1Lgg8cxxImL8FnH1ZUE2qAfEtuH/TDvgeP4pMnvoCFhFUrdvVBXKyodIjgGejtY
 mdHVOwdW9lQQ=
X-Received: by 2002:a05:6820:82a:b0:713:e433:81e1 with SMTP id
 006d021491bc7-713ef924474mr1576186eaf.53.1793201022337; 
 Wed, 28 Oct 2026 08:23:42 -0700 (PDT)
Received: from ?IPV6:2607:fb91:2c2e:8a8c:60fa:827:925e:3bb6?
 ([2607:fb91:2c2e:8a8c:60fa:827:925e:3bb6])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85b2021857csm2007499a34.23.2026.10.28.08.23.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2026 08:23:42 -0700 (PDT)
Message-ID: <586c8c7a-9251-4d6e-aab0-c5e2accaa387@linaro.org>
Date: Wed, 28 Oct 2026 10:23:40 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/86] hw/intc/arm_gicv5: Ignore low bits in
 L1_ISTE.L2_ADDR
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20261013083933.1024405-1-peter.maydell@linaro.org>
 <20261013083933.1024405-4-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261013083933.1024405-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc31.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/13/26 03:38, Peter Maydell wrote:
> The GICv5 spec defines that an L2 IST is always aligned to its size,
> by stating that bits [N:0] of the address are 0 where
>      N = 11 + (2 * L2SZ)
> 
> We were missing this check, and only aligning by applying
> R_L1_ISTE_L2_ADDR_MASK, so we would only enforce 4K alignment even if
> the L2 IST was 16K or 64K.
> 
> Add the missing masking of low bits.  We already needed to calculate
> the number of bits needed to index each byte in the L2 table, so add
> it to the GICv5ISTConfig to save having to re-calculate it later.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   hw/intc/arm_gicv5.c         | 6 ++++++
>   include/hw/intc/arm_gicv5.h | 1 +
>   2 files changed, 7 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

