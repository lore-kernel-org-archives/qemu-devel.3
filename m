Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3328C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 13:39:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzGMO-0002X6-J9; Tue, 23 Apr 2024 09:39:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzGMD-0002Ow-8t
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 09:38:49 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzGMB-00067I-4t
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 09:38:48 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-41aa2f6ff00so12456815e9.3
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 06:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713879525; x=1714484325; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aAZaEd1Mi6JQgGm8e87cLRdoJ9Q5z9UiK24G0CPnZb4=;
 b=b+XLSzUDYElGbw1iRTmMGbKtXsqSXipKQHmBAhg4/1dvjI7e7cHGsJlGsID0Azu8Cn
 CQu5lzGkhowv29fWnu4mphSxinKhAQn7brJ7isNjcweqMMjiKZrMWsTxFe8izzzusRxa
 Vr1/sR9r+Pnt7wnaIO11kEqjCSZ2PtZghOMGrhHLJNNuSNctLd/w7HsDYBPQsYVYvS++
 cnL+PTbGJ4Y/7On4VM6ishH5KrtT0Fiu6MLTm836Yo28WEZw4AMWLLRKyc2KmNhFGsVI
 0HIfUT7USedLnK9+ud0qJy1vMGzCoR+tUbqYIToLDwM2Si3mGLSAmxq7K5dBH0u0hVz9
 U45w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713879525; x=1714484325;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aAZaEd1Mi6JQgGm8e87cLRdoJ9Q5z9UiK24G0CPnZb4=;
 b=eqNU5LFxcbG8pfpSUx49Tr+3Pvm8L63vPRME2n4sNJc9eV16UfNlHOLBQs009lrZZm
 IZPHDdCUo3zwabiPmz7kJxLoT5IdYno7KCaaAEWTAXNwXq9sfMmW9FN+QfBXwO9TTQBM
 hF1HXNPR1iR526+Rgn8ApjR2nfRRFMdxAWI/PCuotVTnJUbeDfQV3bGR67Cu59tcCkSx
 6cN8rSaH57YGw/ZRHnWzrSDCPxb/O2412tqp6PGsAB3qzg5gjLpjWvjO+IYsxthwXErX
 I69jbksitiOOiRqEu9ycv9418lEyPfx0cPXESFYZZOOQY67hH2DVLJJ5dWW15o9i2Cld
 US8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+FT5ix+ZGRmCBSz3/meQaFf3Hs4PgXoI+5/BLeIXUy/ldsDd3Rhh/rDkaWWfOpwaPlZHN24a4GVTomxRQZJH110yvuK4=
X-Gm-Message-State: AOJu0YweIHxh3T8WprmAH8Kza3DPsQqjCntnnVaz/CvrCPcGc2pnD9eL
 qmHonY6t3k3aN/Bm29hxJ3ekdHov3bgLqOL0Nj5640nAACWBStg8CuCNO50uy9bVGHmeS9xPLGQ
 UEpA=
X-Google-Smtp-Source: AGHT+IGtoJzefkz0715TSAdhE09zAd3g1CfiB+Vxn7q4pCtrG1HJhdzdzllftLGIXm3cA2g4ihgn2w==
X-Received: by 2002:a05:600c:348f:b0:41a:7c3c:680b with SMTP id
 a15-20020a05600c348f00b0041a7c3c680bmr4598833wmq.18.1713879524876; 
 Tue, 23 Apr 2024 06:38:44 -0700 (PDT)
Received: from [192.168.175.175] ([92.88.171.241])
 by smtp.gmail.com with ESMTPSA id
 l6-20020a05600c4f0600b0041a0f3d92c7sm10571759wmq.2.2024.04.23.06.38.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Apr 2024 06:38:44 -0700 (PDT)
Message-ID: <513ad62f-b5e4-4045-b2d3-c7b13d56702e@linaro.org>
Date: Tue, 23 Apr 2024 15:38:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/22] alpha: switch boards to "default y"
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: farosas@suse.de
References: <20240423131612.28362-1-pbonzini@redhat.com>
 <20240423131612.28362-3-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240423131612.28362-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 23/4/24 15:15, Paolo Bonzini wrote:
> Some targets use "default y" for boards to filter out those that require
> TCG.  For consistency we are switching all other targets to do the same.
> Start with Alpha.
> 
> No changes to generated config-devices.mak file.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   configs/devices/alpha-softmmu/default.mak | 5 ++---
>   hw/alpha/Kconfig                          | 2 ++
>   2 files changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


