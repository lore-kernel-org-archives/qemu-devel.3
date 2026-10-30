Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3096D606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 11:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=xrw55xgX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMkgI-0001Vv-Q4; Fri, 30 Oct 2026 07:21:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMkgH-0001VL-Fb
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 07:21:57 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMkgF-0002oR-Kl
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 07:21:57 -0400
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-85d363fb73cso361183a34.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 04:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793359314; x=1793964114; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7InvAxPaqKli4FmAnHy8UfyygTa9T2epB99mWPSea1c=;
 b=xrw55xgXlH94dVtUXVzPOfOtkDKo9Z/MSKCXpFKpkSj/Y6yHkd8QspPZ26LYtCtMmL
 eECCss/YF2clS2KoiY9M7IJRE4fcJwYbo479PvK+8rLG4fG1nhO65X8cIdKLz4nNLJX9
 yNhNAfXc32gmR8ALQh1fhTCoW0dPvEMMmFFGQTdr3/8aySt7uLNhhr58JsNpDqExD1Vw
 BQpxOMSjK+amqQvYWqi3JprqpNoiQYTExq2AS9ORgqtx20Chxa35+USjMJbJMzZtaE76
 fzJ8sjlhP3TnZPqa1R81RMcc+rbsxwgq2vg1SNE3DP8YYCgIstja5duB8lMwtlIi/60Z
 4zmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793359314; x=1793964114;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=7InvAxPaqKli4FmAnHy8UfyygTa9T2epB99mWPSea1c=;
 b=ElvdYnxdf+Iyv5g53s1Q/uFdSqyahjryVgqj+Uvb7m74/7NoTGbOrg9xxgI18XLnK2
 hGTsZYyzForu7P4KezwKdYU8KeM8WSZp/wf4JfbkwtZbcvPx+UBZQ2kKm/XQAd93GWUG
 3T0PEmWSqaNK3TdXtPx7zEtBbkVSere3Jy8GDCq3Wk/ott/ufUu+cz6WFckjK+b+JKo2
 ZJl8gmjKBztNoEzoUTd9dKE2BYt55uAFpYZPAPA0kF3nK0j27S80dizopR8R+D/4WitZ
 ViJ7TVLIhjaJwJWmaiqXJJJqhOB1DXIQwVpYyxLkfc709ZvLPOY3Gxaw7gVH92OEh4xm
 sU4A==
X-Gm-Message-State: AFq9FYJ1zIPo9j+fwnU013JdarC5lV4aVkdj47hszII0lOGHRTxB+o/G
 EP8eKxpQs1UpzTjU5uDMZZgMl2bH67YgyZfNH7E2gwnn2uwxpdHxVWGoISvht89GtSeT2w2CRXR
 FFzJk
X-Gm-Gg: AYBFou3sJ+BsR0c17bTD6U0J82rDrXp1II/GNXD8kNBbKvw1tfNpujGR+mh0MbNn7z/
 iJNHMM03+YnsNCtbA8UseCOOlEJdZgLVqjqALnFQLakX12af9LiIPft/X+UKWuBpDQxsfjVH6Zq
 E4iWM5N3e2kQtTOC98X+bWvIr3SnfV0q48OG1zb9f1PY8JoITPgN2Pz/mo0CpD9a7o+yl39Nsfw
 DOPCwZmz2JT41RD5Qb9KfDOsoMurfppOKx1jJtIGDcGuAe8taMAmi9uVQl6dhFQZ8VzSKFedB3z
 qS5FTNoKRHLgv/VJ/lL76QsIEtnXE8qCudH0oScAsgniHCEI34zhC61VIz1g3Px/tGbW/tnQjec
 RWiHD5F8OzupPtOEI4eAWfE6w3GkgrW0pflxvhZi+ihtA8nBWLr4PDbwNnuZGMb90dDTFFuuhEb
 po1JzTrtLimuFPfBSVGpa+REzNzKBOTKKmbOduLitBpkHc8ka6oq2o+6gfduPFnY/3SDrzqOCo8
 DnUGSrBixYIIPq1MG6hAlAtDAEKeoWPWlloli9cBMLyOOLsOfx6ZZF1pwSwfdS1/9CuHgR3n2EQ
 qyzAKFuB8ykU+Z+gmZafyUEVPulXJ/OU5Gzh/WV3f6uG
X-Received: by 2002:a05:6820:168a:b0:6f3:6cf9:f182 with SMTP id
 006d021491bc7-714f2480119mr1309798eaf.50.1793359314162; 
 Fri, 30 Oct 2026 04:21:54 -0700 (PDT)
Received: from [192.168.129.53] ([50.233.235.3])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85d355295fbsm1780767a34.25.2026.10.30.04.21.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2026 04:21:53 -0700 (PDT)
Message-ID: <6eae5b75-5f7b-4ce2-bb51-df3156ce968b@linaro.org>
Date: Fri, 30 Oct 2026 06:21:52 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/arm: Deprecate Nuvoton quanta-gsj board model
To: qemu-devel@nongnu.org
References: <20261030095731.581512-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261030095731.581512-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x331.google.com
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
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/30/26 04:57, Peter Maydell wrote:
> The latest OpenBMC release as of June 2026 no longer supports the
> quanta-gsj board model (as noted in docs/system/arm/nuvoton.rst);
> support was removed by OpenBMC back in 2023:
> https://github.com/openbmc/openbmc/commit/ 
> ab5062cf6f562ad0c844570ba1ea0089961848ca
> 
> If OpenBMC don't care about this model any more, it's unlikely to
> have many users.  Deprecate it, with the intention of deletion after
> the usual two-release period.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
> I don't insist on deprecating this if the Nuvoton maintainers
> think it's still useful. But this is a "hello, are you paying
> attention" call, since you didn't respond when I asked in
> code review on a different patchset 🙂
> ---
>   docs/about/deprecated.rst | 10 ++++++++++
>   hw/arm/npcm7xx_boards.c   |  1 +
>   2 files changed, 11 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

