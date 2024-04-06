Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D6ACC67861
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Apr 2024 22:58:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtEyh-00055N-KK; Sat, 06 Apr 2024 18:57:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtEyg-00055A-F5
 for qemu-devel@nongnu.org; Sat, 06 Apr 2024 18:57:38 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtEye-0003un-QY
 for qemu-devel@nongnu.org; Sat, 06 Apr 2024 18:57:38 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6ecee5c08e6so3073942b3a.3
 for <qemu-devel@nongnu.org>; Sat, 06 Apr 2024 15:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712444254; x=1713049054; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PONsyQg7nXGHqPk5RVamR5SrwrOTin702EjsRFeyi1A=;
 b=InXxNwp5rrt5TkQi1mX87LcaFUJERXhVcWYajTji+ZEtEvUf+nIZmrQ2J2Lpsl7B2k
 XjByfMXPDAWtGDb1AG7vOzFBQ2Bso1rlkUALFbcsIy//zUVtKEEYwznXYGkvWxpGulla
 jzEQO+NZUX0ZW06oKWX93QWs0tu+7J3fCnsbJaDtecSfKdOMcmSyhJe+eif08/RFLTbl
 STNDyU4PWFoDEal66ClHUoyUExo9qNRc6+aMlgQp3oFVxlVTK4d/HJ3ecIWBQf4nmQma
 lZTf8bhkrYYFJLwPo7gR4KgonFhJweU21TOOfMf/8euAhc+MLYDjSej2zVWlo7K3jiCv
 hLug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712444254; x=1713049054;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PONsyQg7nXGHqPk5RVamR5SrwrOTin702EjsRFeyi1A=;
 b=TAcydNkrYd8nSeSGx8ee56NnTdny9uIF9M30NZTxm59WVvkA5LobeVQHKxWz3a80s1
 GBZm/6s6ZNsnJk6vR9PgqLRk3eziI6QPrva0EnSLsMUXfVP9uyTdOXKRuePp6j9n5Zdg
 i1XLeXqHwXOswWQvysOrF3YH7ROccmxj+gaa9wgZ3Y2LATOG03+TpF2SWG0VxDBrbNxn
 kMnTLtBbyy31oezVLoCUmkp+S0PTbsVugCENds4FSqEgFo+VUq2oaOhyr0qpb3Y639cj
 2ZXhm3D5X/ZWZE+uctKE4XPttKsywyWZTg2LbvWmrhU+Fos7ST8oYz2Rv1mBGkWc+W62
 jUdg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkt/fxq6kKYnDnYTiRnCoRyyksAlsfAYD7NyRuv0PJwToiXAd1FylDZrdcvC9u8+rPGMhZx1u4pqLbfSZ5jfzh/HesySs=
X-Gm-Message-State: AOJu0YyO8elD3nAHSxFKW7UwHNTEmFtA1hgD7xm/H4MeVaPU+WMPhQGc
 CNZ++gsaKbeiehQIqb3GWuFAX4MXGC1vVUVCVK/HnTkI6fX0G00EaYvK1pIHbvA=
X-Google-Smtp-Source: AGHT+IEhMOogr1L/K7Lf3Bze8NZvsz0mBJ/C28wN8alXE0RxiRVUPBCnGxXtWUbdLQ+jzmaHIs9/Tg==
X-Received: by 2002:a05:6a21:3a84:b0:1a7:5402:8a92 with SMTP id
 zv4-20020a056a213a8400b001a754028a92mr2189542pzb.31.1712444254114; 
 Sat, 06 Apr 2024 15:57:34 -0700 (PDT)
Received: from [172.20.1.19] (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 u7-20020a17090341c700b001e2b57a6e22sm3897800ple.305.2024.04.06.15.57.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 06 Apr 2024 15:57:33 -0700 (PDT)
Message-ID: <24d6c722-90ee-4e86-ac4f-5178671e96e6@linaro.org>
Date: Sat, 6 Apr 2024 12:57:29 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] meson: Make DEBUG_REMAP a meson option
To: Ilya Leoshkevich <iii@linux.ibm.com>, Warner Losh <imp@bsdimp.com>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, qemu-devel@nongnu.org
References: <20240312002402.14344-1-iii@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240312002402.14344-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

On 3/11/24 14:23, Ilya Leoshkevich wrote:
> Currently DEBUG_REMAP is a macro that needs to be manually #defined to
> be activated, which makes it hard to have separate build directories
> dedicated to testing the code with it. Promote it to a meson option.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   bsd-user/qemu.h               | 6 ++----
>   linux-user/qemu.h             | 4 +---
>   linux-user/uaccess.c          | 4 ++--
>   meson.build                   | 4 ++++
>   meson_options.txt             | 2 ++
>   scripts/meson-buildoptions.sh | 3 +++
>   6 files changed, 14 insertions(+), 9 deletions(-)

Sorry for the delay.  Queued for 9.1.


r~

