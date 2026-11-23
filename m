Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6930360A2627
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 20:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=So8z2/pg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVaiL-00051A-Qh; Mon, 23 Nov 2026 15:32:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xVahw-0004ll-Ql
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 15:32:14 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xVaht-00060a-LM
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 15:32:11 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2f0918f9e6cso5891305ad.1
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 12:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795465926; x=1796070726; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=nwqZ00Tn7MIgJrEuLS5He6Z8VbJVBJbcqzjdYdeGOR4=;
 b=So8z2/pgiFQQLZ2t0Wfaje0C01HByVsQjvRPWqzzBOMaQRH6Yz0dyOgFhbuhcqftrp
 aYps7EGZMLlcHDlHQDy4tM4wOU/pyvceziJwUAdJ8mdC19gagRyoszsSvPwdFdQASAkQ
 rQ6s+E7gOfr1J1kgCtjR72XhkDfIHhf/wfufFr4pb3FgzFn6ASTnXPNPJOcAj2i2xhek
 WRagMxCzmVshox0kAyQwAUiQWV7bpwsEkMxuDG8fiV5X1gA4ikDYMmi5SyWuBMh5Obrd
 e9h+65rTWXRLAd777wcGF8OO9/eH7T8j9Pxd4UFLiLL7jaoSZqItq8HhvNI5Ba3ThyR1
 npmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795465926; x=1796070726;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=nwqZ00Tn7MIgJrEuLS5He6Z8VbJVBJbcqzjdYdeGOR4=;
 b=2jyUwVkPTbgmrDwXpdyorpt13nHFF9jWtLlErGMM7py4k6T96GjfgJ74tQay21R2ES
 u0V0+u+QnVQxRtZHaUHF0S12zwseMw+Ixbd3GLxCpHRoKv5zb/SmsuAn4e/++ha86/F7
 XW2FXR7Qx1zWiUSVILGP64mgDivN1EVDwXYIWazrkjiIkx+0uZLbABJ2xOlKeYNcpRvh
 zqLCaRk3V7xVkr2ff8bXRJHADd9Bqr7ZZ1oWm5NPTCXqV5P51mWVrUwSm0HtjIvXeRev
 sGTDcgc47XYjLZjmRFV56heFTDIR/BOm7JL29koNapGANcZksvfwlAvH5TFYHdRJXqKK
 +s1g==
X-Forwarded-Encrypted: i=1;
 AL+hErExRgtyVdiRtJjaa0UO2jH5zCuEn970ZDMYgrD1RCfYkIWgn6dqGyXjHxQQ6XzA1utuAGsv1PE8Ptsf@nongnu.org
X-Gm-Message-State: APuU4Z/pfaQLOcyePkzOhRpFkHYEYW7DtuDZs7bmTMpvBtvQ8KtgloBb
 zPyHXeudI3f9MBb0o1I8+baWF1Qt0aMPVxmSpxc6saGYzddDbKziSXyAl4HEobI/bQ6dJ5nU7ZZ
 w3w67
X-Gm-Gg: AZFdTZdv7Xgg3yfraG28ekwWDFM1Oh7kraBEqQx+mHd7gQJ8jS/UNHYSDK7CLKq6rqc
 M15ToBWv/fwl3/wD69oeHAPBWTxehjo+dW2O+vs1g+a6FjsjLsMDn3nkvlqcTjC6rxOSI2xJprA
 OTAg/A/cdbs7Oe4kNNNYpZ6W8D/FcZ/f1/CTCUtkvITQtkTnAAulPKuqpBjTofx+KliAK6YFwEg
 md29fR6yOhK4wbpcH2ASvfNY225x3NWa5kQf9bVw1SHBAqm9AYE+NeKVGT4OtKClQdvrQj2nDRd
 oNFzVfuastmD1i9gbN4B+cHh1crjC9XxrVB7yDXByfPWG05TLb5FzI1n6pAr2Cwk0oqSyQ5/i3K
 O1nNo7dIY8P7qoJg8/+YMqZVx60daUutRTSlJRmbg3i+E7yWrrTLSg3rT9vW7lSwTmZGgu3/FRv
 YA/b0pjXeUKZmOYQkV8M2eYc3dzu3w8LSBi6zBu88xAHcYewYUEnJ++BTeg9hvVP10xlmMWoQ9Y
 SK3E42+2hyuajCZnVH65k7NQ0t+Kji8tBPUGytY7zxY3E1mK8+9UJVqie1WHgxZJ7kkn59k1jCA
 2PcM5BgCBvTwnnK8+8h4bOz/J/f+r5kr7l2OcdtpGBo=
X-Received: by 2002:a17:903:22cf:b0:2f0:6055:33e8 with SMTP id
 d9443c01a7336-2f060553672mr73462455ad.64.1795465925846; 
 Mon, 23 Nov 2026 12:32:05 -0800 (PST)
Received: from [172.20.3.121] ([156.19.246.27])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2f03f14a432sm59101695ad.75.2026.11.23.12.32.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Nov 2026 12:32:05 -0800 (PST)
Message-ID: <d655be73-7deb-4408-b7d8-fae1d333290e@linaro.org>
Date: Mon, 23 Nov 2026 12:32:01 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/6] Misc fixes patches
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20261123170050.4166517-1-berrange@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261123170050.4166517-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/23/26 09:00, Daniel P. Berrangé wrote:
> The following changes since commit d2f99dc8ddbd8922ae2550f9197a79304c17e692:
> 
>    Merge tag 'linux-user-next-pull-request' ofhttps://github.com/hdeller/qemu-hppa into staging (2026-11-23 07:29:14 -0800)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/berrange/qemu tags/misc-fixes-pull-request
> 
> for you to fetch changes up to df235ec670000e277ed0490ea974494242c77a61:
> 
>    qapi: correctly mark 'ignore-unavailable' deprecated (2026-11-23 16:55:20 +0000)
> 
> ----------------------------------------------------------------
> * Fix error handling when erasing keyslots in LUKS driver
> * Fix URLs for sunxi kernels in functional tests
> * Satisfy Anubis challenges when downloading assets in
>    functional tests by setting Accept header
> * Correctly deprecate 'ignore-unavailable' tracing QAPI

Applied, thanks.

r~

