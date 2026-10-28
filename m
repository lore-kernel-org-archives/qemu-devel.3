Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF13606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 14:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=JSsRctXH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM583-0001lV-CL; Wed, 28 Oct 2026 10:59:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xM57n-0001jL-7L
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 10:59:40 -0400
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xM57l-0007CI-MU
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 10:59:34 -0400
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-536c8f958d7so10314541cf.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 07:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793199572; x=1793804372; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=aUOLgEJM7cj66D8Igvil+wxm8t3y6EkTmrc0hcQpktY=;
 b=JSsRctXHImKjqEUd8CbagsAk1KNA0HTK3raL9ONfXcMPiNJtscKwdvK9g68ZQMOW+y
 72LYN+TdE5I6pLwbyLqCg9jCn6l61Rh2Z3itQR+XortQIGAt7heHQwloh7Ou/NbHl+Gn
 kdDXjk5Ej6XrOY5ucOi32U0lWoTZ6ZViIs+hhN5boDljbhcAtJLCO3cvCpwmt3cS8a39
 8ZqyK8ZoEiyrpkWIZI1Yl1GdQc6bnXWvlAkV0THX70q8A8IAHKTAaq9BdWslcNn/wr5N
 +amjupVT+PdjNG4QcqEm4quhJEUFI21ogKuENtRnQmOPBv+6Ub036D3pdm80LZU+Ex1u
 Bx4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793199572; x=1793804372;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=aUOLgEJM7cj66D8Igvil+wxm8t3y6EkTmrc0hcQpktY=;
 b=wSjXMrYOpzfHzjm1xCC83tjLUbMs7q70F2rqhMmwx0DuGy951LRGsHnDbK2Qi+gAqi
 9ApeaIPzDpA9/WYYxByg+gpfshJ7nmQzIp6o0/kXRGc9xZA54MZ7X2pXaDT2Jbx6ONq6
 8RQzbiGhRYyTXEcZ3FbFgMKq+T8sNAXB28WVkFS3nAh+1uTfhuCh6n7t03OgoA7KQZTG
 FAkGr2tGi2lTiG4hbB1nrCGNtJASAtTZx67sVvpcH2K7vOtYHdJY/NY/K/5SB7hSBBBI
 yQYfaZJ8TAKVQS0g7xaIYffww1VwbDwtpSA/IWQmXaXGzJB3QtJscIfU2mn9wx2UUFEP
 WR2w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzMlnbPcGF4NtiNUJMQKbMwE108P7lp0qALsRPg74YI/xKSWIL+YgtUU51vueB+YR8EKvwH2r9NraU0@nongnu.org
X-Gm-Message-State: AFq9FYIzm5+ggskJyE2k+oA6QGWTOl9HhUv9oBKqerfpPxT44rmEZnX6
 Vnml6+pTiKOggsM/VffHFzN0eTAzIC1H8Vy0FTUsZtfVeZ1NkkBlt40W4ypIcQXb8J2UO0eCI43
 Iekxq
X-Gm-Gg: AYBFou1dL/FrpBvZtCVFJQb//BvlSS6DBauropQ33Rwa3Eo2xf93A+GWdWz70JHyrvT
 NLO6zIi3Kf+BCsRdr+i/oCN6m+N9TH/jsjP4SQM5bpY/Vol/gmKZFGsM9cscqLLh5O7VLO4lvsd
 MKGLpWM0KBj2cugn7UjSc7Vbbz4gZk14dotUk7Nm7GDPyjgl19hfuruMNhkuMPU6WrgkG3eCHPo
 7bsKU7VpVuJ15IPBBUW/g/JEDe/5vLYyJMJQiHBXDMr/Xw9iMoFqEr8TwtDPmU5UFewmktWxAap
 ZdPrG4iFtCh1IGD/NPtA3/i/DDMb3A7uDqb1YhTp35+Mf+C25PvMQ53/rIlsjCo2eX0XRbujiyI
 T4l4gjVhfW8XR5TMoYocbXJqAPeebgKOQhhVr1juGa2tXWl2lR/uirULONvtqyrh6bbb2TKgV8W
 qxdRUX+H7AO4V6LYSew4tCiVSKolt7IzydPe4Wt73P0evLV++H86z0b25RAKQoTe5g27kA89pXV
 hlqKi7ZpVyRMi6rqWhvucLY9AmXAkwAR9qjg2ZQaD/u6Z/LgOQWUpsTmYBdfEoPUFFCIQk9038A
 dsFz/J6MfsGILB378yQPZaPGXVgFs/Xq5YxbQ7mGFXET1mcXlGt/UwcsZTTn7df67YCYmIJ2yr3
 5FYnjg4oZeQs=
X-Received: by 2002:a05:622a:38e:b0:535:a5fa:ee07 with SMTP id
 d75a77b69052e-53fccbb61b9mr42702881cf.71.1793199572135; 
 Wed, 28 Oct 2026 07:59:32 -0700 (PDT)
Received: from ?IPV6:2607:fb91:2c2e:8a8c:60fa:827:925e:3bb6?
 ([2607:fb91:2c2e:8a8c:60fa:827:925e:3bb6])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91c88040f5asm8485166d6.45.2026.10.28.07.59.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2026 07:59:31 -0700 (PDT)
Message-ID: <f57cfd27-4d34-411d-b6e0-58f9a90f9d9c@linaro.org>
Date: Wed, 28 Oct 2026 09:59:29 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/6] Misc fixes for QEMU Guest Agent (2026-10-28)
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20261028094152.14934-1-kkostiuk@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261028094152.14934-1-kkostiuk@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82b;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x82b.google.com
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

On 10/28/26 04:41, Kostiantyn Kostiuk wrote:
> The following changes since commit 29b1dc631d6ac6bfc39464e0be8bf4cad556a591:
> 
>    Merge tag 'block-pull-request' ofhttps://gitlab.com/stefanha/qemu into staging (2026-10-27 20:02:57 -0500)
> 
> are available in the Git repository at:
> 
>    https://github.com/kostyanf14/qemu.git tags/qga-pull-2026-10-28
> 
> for you to fetch changes up to 0ae3840f612ba00330940f26758ae03754f6c6b6:
> 
>    qga: implement 'guest-network-get-route' for FreeBSD (2026-10-28 11:21:01 +0200)

Applied, thanks.

r~

