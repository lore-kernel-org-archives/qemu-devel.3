Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49CB4C46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 13:14:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSd4q-0005XA-FN; Wed, 24 Jan 2024 08:14:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSd4p-0005Sh-CD
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 08:13:59 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSd4n-0004yg-Ly
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 08:13:59 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a271a28aeb4so586190166b.2
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 05:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706102036; x=1706706836; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8Hmp/0Lh5G3NF5KBegbEBNwtPow7TLs7E2D1lxSL4/4=;
 b=ZlNdvrAl+9NoyOy4LrXFTGPLPAfFzoNLT8wq4D5xpjGUfXtM3dTgBnq+KqCBTW8c8w
 pXXAaLaScb3VacJwU3TJXf145jZWB18hCGaTCtvltfSIxrGkKvmvbXZ6T0wDTso+WUo2
 xJj9r9MXjNfEUCVt9ItZEwniB09jtZABZUTag62OgQ4koL+9TQoh8sYDeh3QichZBUGZ
 s01gSDxgkwj04ZMAPpxj9cyEq6ogjtn1rSnZepETSaCi36NBChU+yvwPVgm8hwvbum0F
 Avnuh7LtafUsUm/n5WRx+SYHWYCwwkdtKJrSAoKJ63s2TGZmZAFCOjKaNKIk+aG3NrfO
 Ofnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706102036; x=1706706836;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8Hmp/0Lh5G3NF5KBegbEBNwtPow7TLs7E2D1lxSL4/4=;
 b=kvgo0myP78HnuBFew9OQICh+i2gOhIRKL5y+7wGjKS3918yFru9UZ1+CQP0a2sGM/K
 aGh8NFNO1bCd+bkGN/JQwcqtSEdDLhc44IJT1OTovayt2JcpMR2RNUPIW5E1rn6wE/2O
 kb+yy2uMRJFffOcbK6YiINJQTA5Hk6/Ux0hAX3QVPmQpOVaJfGin6VV4WEKIO4YfbgEt
 Jhpo+jCPca9kdPXWFIY36HkP9x+/yxO3ax5GEBM6WA1qaXK3liWE0LqGoJJGIVl3oVXt
 gCOMVpRItPImLDhaaR80hyruCMX2+kysRDTr8p9nCrBxE5IJAD903guyw4M2FIDF4gvl
 9v1A==
X-Gm-Message-State: AOJu0Yw+7idbysfXIZEkePqtqCiymT372zkKGACHIIvGuW08mf98xnUv
 FDDv5B2N/FsNLBxAo6LFA+zPVM+BVqEu5HkwjXEhfP5NHiNg6wVLa1jiNjGjnvo=
X-Google-Smtp-Source: AGHT+IHpsTfYuc3QPmptlCyfU7hd/z6vkOu1IGfQjO1THpdHiJashW5I3gohHySzLe0XV/zu2LDG/w==
X-Received: by 2002:a17:907:cb85:b0:a30:6015:5557 with SMTP id
 un5-20020a170907cb8500b00a3060155557mr1100618ejc.84.1706102036213; 
 Wed, 24 Jan 2024 05:13:56 -0800 (PST)
Received: from [192.168.69.100] (lgp44-h02-176-184-8-67.dsl.sta.abo.bbox.fr.
 [176.184.8.67]) by smtp.gmail.com with ESMTPSA id
 st7-20020a170907c08700b00a2fde3a8097sm4485277ejc.74.2024.01.24.05.13.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jan 2024 05:13:55 -0800 (PST)
Message-ID: <fbb44101-27a9-48a4-a9fe-e78bb124a213@linaro.org>
Date: Wed, 24 Jan 2024 14:13:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/avocado/mem-addr-space-check: Replace
 assertEquals() for Python 3.12
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
References: <20231116061956.14676-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231116061956.14676-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
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

On 16/11/23 07:19, Thomas Huth wrote:
> assertEquals() has been removed in Python 3.12 and should be replaced by
> assertEqual(). See: https://docs.python.org/3.12/whatsnew/3.12.html#id3
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   Note: The test has just been merged, that's why I missed this file in
>   my earlier patch that replaces the assertEquals()
> 
>   tests/avocado/mem-addr-space-check.py | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)

Merged as commit 572960cb23.

