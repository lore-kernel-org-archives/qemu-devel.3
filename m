Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A18A0D6E2BF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 17:47:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWI5f-0006qv-Eo; Thu, 18 Dec 2025 12:47:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vWI5X-0006pL-Hb
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 12:46:56 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vWI5V-000408-TI
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 12:46:55 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2a07f8dd9cdso10770795ad.1
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 09:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766080012; x=1766684812; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GKZHgOzpsefmYW4ac4EC/2Xybeu7VFTsebSF05MCUIw=;
 b=hfnOpAJN7DXQ9ahnHVGwFpS8eMd6IU6Pq/4IAxHG95UcnarIlNSi1yEkVoGn348zlX
 /h+E7fgWlunNS25ZTwD0wKAQXruSt0zf0OW5V5I+oGWxzvBcnKQkHSaLikLuY2x077S5
 wmRw6pNW2cJnYEd14iQnqWwa/xkHWd6zt/PQ2L2Im7zdgcA66RRxUd0pso0DwPT97hzp
 VVQxR9eBIPjEffV5FE+ToVH3PAmlRt+FHYXOL3sgjW4lh7RaO9zK964oFqP0KGtlQpEk
 KQ7gKUGB8EWjmxtN8upWJhgeh3U/IavHadwBBLndH41kODk090U9XzBy9XgMDfAuGhiQ
 FbXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766080012; x=1766684812;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GKZHgOzpsefmYW4ac4EC/2Xybeu7VFTsebSF05MCUIw=;
 b=IYMpn5pYyEw+x/Y9z7I4gFizODeQO02mJpfr29UEAucLdYnIgO8pyk92dJWyxxz9sx
 b0hGin29/vQDUGENaJlDe70msR1YO+Dc3Kbks+v35vGsWNSYNf+7t+ppVHc5dPwXL2zH
 UlqmTuDSrrGBXba0N1lOv0scJK0QvDaMrJXnQ5hgzsQh6kNhejltsKVdOVOVgYSBD56H
 mDvoYIPZTksZXPArrXKZ3rM89Bns3lnUgle0fojZrghS/0MyTOqoRnaaq1Kl8ryiLvK8
 NVCTEj7Ab2tRwzeU3/uf7grO4dCvt2ZxFjnrGb9LqYTggSpXZTtSfOvv9Y8+3gEp6EIn
 Ot7w==
X-Gm-Message-State: AOJu0YxhSe65NZdWJyt6+b092aul8cybr8yWuqHxAGubbRhyMdFbELzu
 Ydso86sMJ7lAdmsMqOm42FtCF4niiVowKYoYAzfiWdIClFhVljPvcYZWGDspgzxGBEU=
X-Gm-Gg: AY/fxX43ToFZBpHWSJOeTGu5s3tsTnVaGEhVdPYdQFQSk954dlV5bIL0AvLYIF1EcR7
 0LwaqfV8QJv/Wt/QTh0KXDAMtS+YZRCV86L2/cuQksoxLLU4g1r8FIOPYT0Qm2KrZbDvqn8g5G2
 8SCZTTkuJKOd1R0C66s6DofGBSNxyqgI4ScuG74of4xNi/ie1i3IBHwbJ7jyP6+iMqk5poO27Xb
 t7h/pgk/zn21LHc7gY05IntNM97aYGm6FcdrKXwf6hIqyv+ccHDRKufHGgWAFIPdQx+cTDULK9O
 LsjhisSSaRCBbPzQFI+j8ZB0qQUlm9h4jS44Wl5hGz17Vf+8mWX+R0KVWdSk3Ytszg/6WZGELHq
 kmgb0gWffjR9/es9cT75HL23MGRytHPJv2oHaWNBi3AFOL9CgQI1vIez95N/31wjYSNdAgpFB5n
 FnwKu1QR073Cn1QxHZaz1E1pHfS6BRjTqMFVnPauiaouQ8AJdUurgiNgAhUF6IggKkGw==
X-Google-Smtp-Source: AGHT+IFZE6ilYeytLvSJ9NRX9+wbx+/pohknYl6ts1+GXCf8L4Fxvn+qI5p7hESduS/Szrj8DkAQfg==
X-Received: by 2002:a17:903:2f85:b0:2a0:d364:983b with SMTP id
 d9443c01a7336-2a2f2c53f15mr506535ad.60.1766080011938; 
 Thu, 18 Dec 2025 09:46:51 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2d1927273sm31066545ad.86.2025.12.18.09.46.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Dec 2025 09:46:51 -0800 (PST)
Message-ID: <29feb7ae-e077-4c75-a861-0c53fe2fd7a6@linaro.org>
Date: Thu, 18 Dec 2025 09:46:50 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] qga/vss-win32: Fix ConvertStringToBSTR
 redefinition with newer MinGW
Content-Language: en-US
To: phind.uet@gmail.com, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>, Michael Roth <michael.roth@amd.com>
Cc: qemu-devel@nongnu.org
References: <20251218085446.462827-1-phind.uet@gmail.com>
 <20251218085446.462827-2-phind.uet@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251218085446.462827-2-phind.uet@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
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

On 12/18/25 12:54 AM, phind.uet@gmail.com wrote:
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
> Suggested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   meson.build               | 12 ++++++++++++
>   qga/vss-win32/install.cpp |  2 ++
>   2 files changed, 14 insertions(+)
Thanks for the update,
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


