Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65737606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=WrG2V+4Y
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJXfs-0007Uw-RT; Wed, 21 Oct 2026 10:52:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXfo-0007Q1-3U
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:52:12 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXfm-0004uY-Cz
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:52:11 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4a1d293b293so4795115e9.2
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792594329; x=1793199129; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZQ/gvW9E7zS89ibjEbHB8l6zBjuQ5Vo1QKVfx9fO4Us=;
 b=WrG2V+4YlgVpgw/o6gyqLNNeS64+u2omLWEj/fu1Nl8Sa83SBZ5fMy6J6wz/mVd68l
 FakUxjxKQ1+jOUwVT1wf1Fmt3cQ9hXshBm3WyxJrdYx3p9f512fhOLFetSPGNXKyzrhw
 3gmeLPWHT3TzwQpWuJTWy2ab7DURYul4GGmlAqABHy+SzCWxAwCOdPyAi8e/WnxjHW/G
 mcA/LVscnemrCJ3gliRha6qAu1R9JsEF8UQg2DwiwmP8NDWEpNX/j3eZfwmhfFf77CtP
 usvlWAhuq48+qODh33kR2UveWEdkC2oAwDqEOOBrLgbEVQ88sHbPOnWjZwPGkC9ZSdbO
 H3kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792594329; x=1793199129;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ZQ/gvW9E7zS89ibjEbHB8l6zBjuQ5Vo1QKVfx9fO4Us=;
 b=Nu5sBT5OhwSlWwDifKSoxS1xeAxgwV3Qci9FdHKkvefPiUjw5HFH1KFfZ6ujDyEVIJ
 uE/aVELPVtOrbXeA68H2n4yD++8ou+wgzYqBC/3WF7zpTDBCYkfZENL/4GltgaIMS38M
 HPT84RgaFZPNIVmVVnI8E1H4XtQ7kPQY8Q8U0+PCj/X5X0pMmCy+nkJSLalGJu7i1KGF
 8McAMf8225IQWbGs8qaXrRRCH9QnB1vNRSWzwJOx2pCAejFTrHvZksQ9Us1B9dV9H0Jm
 36p286uTjE0VHH58CEAq4G4GSxFfs49ePdZ2yvWs3tv+9kdET4avbJmYHyma1x3PVuBe
 sSpQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwnLJGHh07fupJ2fc4eORFcHQFpQ/Y+d63u9gEM58pYXqmAgRPWfbvnOfbnd4mhP6KgWHLxEIiTxGbN@nongnu.org
X-Gm-Message-State: AFq9FYIOtynn/M5nqE+8SAcaXDNdf3Zr0XI8ZJYl/iq4mqKLs1xw2mxM
 nmLgZD+aNW5+Ksm8k/pjBVAnf6ZCIJaAH1TEzzv6qspAl932jpO4I/wBjalPlJVZHS4=
X-Gm-Gg: AYBFou2JcJsr+ykaIqKP83s+Gl8Z2yzZbdz58eI5Ltf1P7LcuOzhZ70sKjaMEqtN+NM
 ZbjotapdwpY8Esqct5/5Li4SXZwmpU3exPKe/5cNPqlEQJ7xNVkfn9fg8YEJshQ95rCWsujYd5H
 VnNs+zuNKjEGFLrxSezsMrn5ST640kVW6A4EJOJQxKmyS2a4vzI5zLSq/RMNfqEQfl6IKq8BzGP
 fmRxbetDjeIP+tin3NHQE0T4E2f09pUjUaRYqv7W8x+w8Xxr+aoHBPs59O4toHd9/++BBFHKE/y
 Hhm18AOn2oThSEbmaC5lBlS+NiWUrbLRrbLvdHVwQ/73b8/xO33lbetyNq89TvscU8kdzoFnLbw
 jg60Cqc6YL9F6oQjag9UoWedPV1XhHnZgpyXE/6Oq7m8xFxjB9yltiyELo2kGUx7O43ATRhyNuh
 oVX0uejeby2xCj23FJd4oqNRlNkpwJYugx5IlV8LdH4UZg0vqksCnn6B4nM7cw8axoz8M+R0CEB
 2z3dVjKTkvHSnSNBY6wBjtbGFDwySUpk8fnBsYit0kIvPvN/bkMDQ9ZMZ5AnnttWNUoDZL/Q/O6
 KWGTN1FBB3YctvrZFQ4fIuIRGTEQSquwtHJzkoiExpNwhSr3
X-Received: by 2002:a05:600c:3512:b0:4a1:e00b:a0ea with SMTP id
 5b1f17b1804b1-4a1fd8a3fd3mr46266925e9.1.1792594328553; 
 Wed, 21 Oct 2026 07:52:08 -0700 (PDT)
Received: from [192.168.2.121] (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e2581eedesm5466317f8f.14.2026.10.21.07.52.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2026 07:52:08 -0700 (PDT)
Message-ID: <8f7b0bf7-c239-46fc-a20c-a5cd43b27f90@linaro.org>
Date: Wed, 21 Oct 2026 16:52:06 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/9] hw/intc/arm_gicv5: Ignore low bits in
 L1_ISTE.L2_ADDR
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20260914160020.327787-1-peter.maydell@linaro.org>
 <20260914160020.327787-3-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260914160020.327787-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x330.google.com
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

On 9/14/26 18:00, Peter Maydell wrote:
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

