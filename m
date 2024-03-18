Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58C71C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 21:38:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmKgK-0003i1-BM; Mon, 18 Mar 2024 17:38:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rmKgJ-0003ht-9o
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 17:38:07 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rmKgH-0004wr-UT
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 17:38:07 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1e00d1e13a2so10745105ad.0
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 14:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710797884; x=1711402684; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VjoIwh4G514qhbyvsgeFKgtKp89kE484/dRbVa2wKKY=;
 b=EzkKvDqSapCZD2tRt8jq9OhgfbQ6xBaO843NZtCsynyEAXUiSVXzwKyhFSqL8BWoTD
 HTek2BeSBfNv5AdpNN3RK6ouHlNSawIl3wWOSSyiU6DtXf3Sm5jgSwMoSII5BJv4TyVV
 A7kG56unQh48HOVKioT6yj9Ju4QZ7dHyemVhWA5e1UHiStpX6iH2h0c0I7+V+/0gvm/H
 ZMgQvq28q0VgPeXTPCax0uZXJoQfJwy1I1DCxA32sb8N74mwvwyzmPpqdkIXHeo+lU0D
 dSkUcvxglSoGeHREIKLp9DHm7pZA1SD8jIaklKdJhItu18yhz89GEa1aZr1fA1/csGVm
 QnXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710797884; x=1711402684;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VjoIwh4G514qhbyvsgeFKgtKp89kE484/dRbVa2wKKY=;
 b=wXNW9+iVFKvbLQvxr/8tmFJMSKL2LMHDCSDJne7jk9dDzTTHBam5EzHU7KgsB/EWw3
 DWYTVn+KEiEyYJuLWIri8+lc/cXT2ffSuW3MKvHy8jcR+/QCxVLHjP3tsKlzkWqMxuWq
 6QEVMQlUd4Zcq93a0QIxuJ2ooqBxOhJdAldTBlliG2+MLpS1ZWMBF15ueJJSiVbL8BLy
 gUQVJReg0ltlLMK5BGILlPYIZJ3kj0f05SKmtcK7ZP1pLe3eNpt5tP4AH2qijFmoReE6
 Lskswr8ha3GFnnAV5xip6pNPWxfvpRrFXJVOMib2bBM9XOiWU/a0Mltpg5Em1XssO6iS
 5c+g==
X-Gm-Message-State: AOJu0YyyNZejPElw28HFuBRgVNWtt67m2WK9Jrn7E8hb+5QfgotnHUD7
 wZKXFHFGw63Shtuu1Kg8pAW9+0YSL5dYohYVeTYcFmviMLA4ruprT8GLUeU/Rm0=
X-Google-Smtp-Source: AGHT+IGgtgBrStI+248RaRs77cPTy59yopuGxaO0+tMB5/Xz+XBxWsbpkYhCpbIEt0qSuTvGNKhfIQ==
X-Received: by 2002:a17:903:11c8:b0:1dd:8ee9:62c0 with SMTP id
 q8-20020a17090311c800b001dd8ee962c0mr13174361plh.34.1710797884139; 
 Mon, 18 Mar 2024 14:38:04 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 a9-20020a170902ecc900b001def18c0cedsm7371012plh.179.2024.03.18.14.38.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Mar 2024 14:38:03 -0700 (PDT)
Message-ID: <592f9fee-654b-4fda-9142-2a815c1e5a91@linaro.org>
Date: Mon, 18 Mar 2024 11:38:00 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] target/hppa: fix do_stdby_e()
Content-Language: en-US
To: Sven Schnelle <svens@stackframe.org>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>
References: <20240317221431.251515-1-svens@stackframe.org>
 <20240317221431.251515-8-svens@stackframe.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240317221431.251515-8-svens@stackframe.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 3/17/24 12:14, Sven Schnelle wrote:
> stdby,e,m was writing data from the wrong half of the register
> into memory for cases 0-3.
> 
> Signed-off-by: Sven Schnelle<svens@stackframe.org>
> ---
>   target/hppa/op_helper.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)

Fixes: 25460fc5a71 ("target/hppa: Implement STDBY")
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

