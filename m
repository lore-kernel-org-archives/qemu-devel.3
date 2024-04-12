Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C560AC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 17:19:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvKY0-0003BL-8R; Fri, 12 Apr 2024 13:18:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rvKXz-0003B2-83
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 13:18:43 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rvKXw-0001AD-Ul
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 13:18:42 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-41802e8db9aso4491945e9.1
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 10:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712942319; x=1713547119; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=S3c9Y25udULLg/ch1hsrheK8fX4OeuYjhJOJmnrkbR0=;
 b=Cr3ll2hYcMmb64uJpGg5so1Nz/wxu0vMqeT/jp9GJqmcI71aUjc0U8MSh7pXWmzIMn
 ElqEfera/zjzr5EuKQHNOr/vCaUIM4Dkq612+lDvMiJ+dWS7Sw7k95nE12hZ/j7M+Rv3
 ypHawFWk44SMcjjECD+Tac7NoZbX0EHHgczF6Gt/tVuisLe7eWn/RCVRBdhOWJ/kOCuO
 JW8DmVQsSSLCPE+g1Uk+8jqEHw6H1jxf4Zvv/R5bXSZX9tylnbPlxy4ghZf9isfKZd4C
 CvFqRUTJPqkGtsS/C6v0HCV4slUyK7hI2eKbWSjBgBAou17Tr1aoa0TBN2Ua4Qig1EX7
 fp6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712942319; x=1713547119;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=S3c9Y25udULLg/ch1hsrheK8fX4OeuYjhJOJmnrkbR0=;
 b=FcZo4g15/D4rMNJye+B058974fn17UKrHIX1NIRkpSkmGPDiJ25shwo6ZAJu5qxJ0i
 kBC8oxXpTO4kkGvdOvrivo+mRW8FNjQuO68lAuT+IkXgmxsAKBMRL/hNq4Mcfh1cLmXr
 99yeg3fPqMkPT+1CkEcm0PxX/s07IhjExCiBwsf9UASUKWN/CdUxOmWJ8fQ8Yty12qNc
 PW9yAi1MN1HXDxb6TAae/VQd0+JWf9q2dXE/4DF/lzFjScMG7vPnVsSiudBGi3UNGeOt
 8Z+52rz52UjV9iwsG6XuuLz4FAMZyltdZTrr6cwzfTBjbiP2EuHbQskXQViYtIhNqu0V
 +xlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6KX8E14Jhxl2EMl84WSsG5gLV1hZDKc1pKHJHMmG9S2P8zmLj0Ngw4w0Alise3Og+CmJL9UYHPJfiiulw5QEFlUYTx+I=
X-Gm-Message-State: AOJu0Yy2rhz1g4ZUebn9pRL/83RXXj2zcfLXQVxPKQH4Qa5PAQxSeKFm
 nYuFoWGEvrmrjmXaJarOeJt/gHzpjw5xT6nJll2ARUJ8/99Nr35TH2iBOItJB78=
X-Google-Smtp-Source: AGHT+IHVAHG/P81agPt7c4tmPSpMnjV5RGR6luTk4vIT6jANPIPRsf9sCgUkk2JncUSDN7PjMRpPEA==
X-Received: by 2002:a05:600c:4f45:b0:418:af0:3b4e with SMTP id
 m5-20020a05600c4f4500b004180af03b4emr1765073wmq.0.1712942318752; 
 Fri, 12 Apr 2024 10:18:38 -0700 (PDT)
Received: from [192.168.1.28] (lfbn-bay-1-170-196.w83-193.abo.wanadoo.fr.
 [83.193.250.196]) by smtp.gmail.com with ESMTPSA id
 u14-20020a05600c19ce00b0041772ec5d18sm8723904wmq.0.2024.04.12.10.18.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Apr 2024 10:18:38 -0700 (PDT)
Message-ID: <dacc8233-40e9-4c30-81b4-80edd0fa3bd2@linaro.org>
Date: Fri, 12 Apr 2024 19:18:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/13] tests: Remove Ubuntu 20.04 container
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Lieven <pl@kamp.de>, "Richard W.M. Jones" <rjones@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, qemu-block@nongnu.org
References: <20240412132415.282354-1-thuth@redhat.com>
 <20240412132415.282354-2-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240412132415.282354-2-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 12/4/24 15:24, Thomas Huth wrote:
> Since Ubuntu 22.04 is now available since two years, we can stop
> actively supporting the previous LTS version of Ubuntu now.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/docker/dockerfiles/ubuntu2004.docker | 157 ---------------------
>   tests/lcitool/refresh                      |   1 -
>   2 files changed, 158 deletions(-)
>   delete mode 100644 tests/docker/dockerfiles/ubuntu2004.docker

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


