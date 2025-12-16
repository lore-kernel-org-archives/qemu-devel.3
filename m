Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54989D637DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 23:00:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVe1c-0007mI-Pl; Tue, 16 Dec 2025 18:00:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vVe1b-0007kx-4L
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 18:00:11 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vVe1Z-0002WA-EJ
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 18:00:10 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7f651586be1so6448b3a.1
 for <qemu-devel@nongnu.org>; Tue, 16 Dec 2025 15:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765926008; x=1766530808; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ziPfD9NHMhYz3zapDtOKNcrP0FDQLQeZsiHf4ThB3ws=;
 b=a2CTqqTU5V6Wtl5MWz71xVj7tATx+7oJayLgjOjzVTIyVVEAHwPdkYcUtUY3DecN8E
 M5vCqWKQMlWpZFnoU/laZOcPKenNTYMUDSr5PZmB0w8viNySzL3AzDmXtwQCHk6QjB1Q
 pTK45A3kWfLO5pnm1JRmMHiYWWg6YXDiNbNLITNX2aE1kabkVHVyK6aQEYFQFpOeueri
 2Sn3lPzRNM+8gW7Z1j8jA0eW+CHSEtfWz83awyFTTDOC/KmyvE4JozzS35FmnAWfoarm
 HytGPjMpZc2bdB2YOypGvzr417U84B2vNShLFSsDUSRlLdxQlWGMTQGScP+rRbDweR+5
 O7YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765926008; x=1766530808;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ziPfD9NHMhYz3zapDtOKNcrP0FDQLQeZsiHf4ThB3ws=;
 b=Z5rFACVmhFgSBdkDWT4jdZH0rR7hHhPC5upzGVjCg7n7g0LYpmEIMzCXvfliusdn6m
 bULkNJ8XuqyhSFNST9dNnYlLbPEnP+oK1UkWI2AEJaVxto+dQ2vd8bdnMeAfT6heyJTI
 kO4u+SwEq9cKhGdtDbDxOC5Ftdj/s+9oajl7rLHeEK23q3f3XRdT8nMDy8wdkfj+ihK/
 pyrpisIvZmOsln+24bbz0pKGUhGF+JKA+wUKImPEpbXcADRWUNC2KSBS2SukQo8VnJ+Z
 ZFe+yvTx/9c6Xduh3c0vPj3Fu7yn7Heymic7VFisQHw39ygTtJbjjayBtqHwcmNXCtQD
 1LFw==
X-Gm-Message-State: AOJu0Yz3qMgjjO3WGxOi438szT2wNx3dP2rB6x4vYh/6ZJcZtlGEoJpp
 tuKYRHJK5AC+L69lkeJh5TTETpu+tnWqb4lFsKNftaE8JKYbpGYm8EOWptl0Fy3OptM=
X-Gm-Gg: AY/fxX55rfo071UMydotrY9vY9HAFxeqNnoZmcTEFFLuFRv396QOdT1XvOHUP/lBkGN
 T13br/3Yn5mYvHU9VptUVc5Q1AU5Ff0czYnYniIUfQbt5frIMHWzkgB8Q8+TR438apZ2GUWyEZq
 qczCxFfVlIlYOrQ5y6GeAnjNIhSVtw8A068XqoS1GDEUPjDrXfokoNcrM5i44HOunOFeQaN9Myo
 N981NmaU1G3fgFW2yPO34T/cVzqyGr4PaIJmAQ7fBsCbGJ3tsolmGFNIHJn3OPUDN6NaMMDmLqI
 2wJ1GthZGnIz57gr1giS9IF5Ev4o0fjaL2UNX99IjJNKX6mDED9rQIRYUz5xSY9xTS/tzE+Ft1u
 ZuTOMWtwDiDJ1UBzoPH/qzc8JnWp7vETvg0PvU1ONvMiQXVeEtAH+yDJX7Hp5x5H4EuujiqGbES
 lppONFPWLlVWgoXkSQyn6v05uIQSHnA8wkzZp4f8nHr85BJ0dwGo77ogo=
X-Google-Smtp-Source: AGHT+IHk/AAE3nkpcF3tAGdN7DPkDfONt1nmeZxSfNZa+7sfPwMxKfXZXszal7Dfu6QfnkOPu/KUOg==
X-Received: by 2002:a62:e515:0:b0:7ae:b13f:37c2 with SMTP id
 d2e1a72fcca58-7f51c48ad86mr11768197b3a.10.1765926007544; 
 Tue, 16 Dec 2025 15:00:07 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7fcbb6fa57bsm592232b3a.46.2025.12.16.15.00.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Dec 2025 15:00:06 -0800 (PST)
Message-ID: <c4c35b43-7868-45e6-9ea3-a0f859cb2bee@linaro.org>
Date: Tue, 16 Dec 2025 15:00:05 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] qga/vss-win32: Fix ConvertStringToBSTR redefinition
 with newer MinGW
To: phind.uet@gmail.com, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>, Michael Roth <michael.roth@amd.com>
Cc: qemu-devel@nongnu.org
References: <20251215164512.322786-1-phind.uet@gmail.com>
 <20251215164512.322786-2-phind.uet@gmail.com>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251215164512.322786-2-phind.uet@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42e.google.com
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

On 12/15/25 8:45 AM, phind.uet@gmail.com wrote:
> From: Nguyen Dinh Phi <phind.uet@gmail.com>
> 
> Newer versions of MinGW-w64 provide ConvertStringToBSTR() in the
> _com_util namespace via <comutil.h>. This causes a redefinition
> error when building qemu-ga on Windows with these toolchains.
> 
> Add a meson check to detect whether ConvertStringToBSTR is already
> available, and conditionally compile our fallback implementation
> only when the system does not provide one.
> 
> Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
> ---
>   meson.build               | 12 ++++++++++++
>   qga/vss-win32/install.cpp |  2 ++
>   2 files changed, 14 insertions(+)

Thanks for the fix, I was looking at this error.
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


