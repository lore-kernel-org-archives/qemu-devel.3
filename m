Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71351C4345F
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2024 01:18:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s342H-0001pC-41; Fri, 03 May 2024 21:17:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s342F-0001oo-Qh
 for qemu-devel@nongnu.org; Fri, 03 May 2024 21:17:55 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s342E-0006IE-6m
 for qemu-devel@nongnu.org; Fri, 03 May 2024 21:17:55 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6f44dd41a5cso292464b3a.0
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 18:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714785472; x=1715390272; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Znv/A1peFrZeg+01cCtMglkTKs7jCgeyrCtMnIuzLxg=;
 b=poB/N8reRTYTZDffvS32YRCiNKHxV1/NjNcsEP6G5nomK6RCF7wLWKtoEB2MmfJpP2
 nABnRzvMafwN68+z7AhN7cl+ONMLhGCfTaMCjejqjjMgi0ItU3XWp8Ug0RX7y1uP9x7d
 VKMPTqDPXuUaUCFAknuuB/ie6yLZdDoXV9awCshbyHxANi/hUViKUbAt7e+nJSETipAO
 +5jLKiLNlGuulJzg5aWRwUz35z5V4QEKW/lCnYob5yGAorN+nzBbxDn8P2RC9i1wnaDo
 oOO4ADhi/TW5Bnz5NzoslSWxwp1Akbkqs8y9gopQ4ShlT4V9gtxwpBPRUJ3+bHoa+3ca
 1ERg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714785472; x=1715390272;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Znv/A1peFrZeg+01cCtMglkTKs7jCgeyrCtMnIuzLxg=;
 b=TuT+FYSeYLWVPg0TZe2l+NDHUsJQUJDFtA3eaOC/lnvCEL5sWswqLeU678eh8/EOaL
 rLCuWlb22PrdBhVnVKoOWTlBRNmhjcXZjqOPih1geeGfZVNAMmb5wSNdf6IlLeRUPYY+
 q7YmQdylDUnJFD7zPCDMw8OQIOGTva1h9J9r93IF0/i79omG/Y64d8hDYqEoNJ3o/x8u
 H0d1X10BDaFIQpoj70eSC6YItH59zs74EfVYjKzzgHfAcZfRIS0/d5iHQftSfPbCn+xx
 SIX9bW5zP1gEIOoUQWlSDjjXnLIHaCaCUg4oVdzmTlOwS/3nhK62+DKPnX74HBZhTKT2
 lUww==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCfPWhzb6cxBvCzc5HO9Y+0hovPbXdD9RFtFYqLV/WoJ9DG8KhZaj/xnW1RbMSwHfLe4TsStfZaam/qtxhw2kYoVfZmx4=
X-Gm-Message-State: AOJu0YxTovHk0gEjHm8QQKOJQdDvS3aFO7xUVRWzNoK02gCJw69BWyHp
 JWh4iYIFgqTyoqKaVJTdD2JOBpfTTP9Q8fCdNF6WOA2F+L0xFlWLoUc4xzbB5vs=
X-Google-Smtp-Source: AGHT+IG07XmUhsjR2lRiHS/Kk+S9SbRu5dJoYHFb5+WW3ZlBTXh/k8fAX6mAqveBngdSuvLzp8pmcQ==
X-Received: by 2002:a05:6a20:7782:b0:1ad:7bfd:549f with SMTP id
 c2-20020a056a20778200b001ad7bfd549fmr4118720pzg.48.1714785472243; 
 Fri, 03 May 2024 18:17:52 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 fi7-20020a056a00398700b006ed007b3596sm3690222pfb.69.2024.05.03.18.17.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 May 2024 18:17:51 -0700 (PDT)
Message-ID: <50c27a9f-fd75-4f8e-9a2d-488d8df4f9b9@linaro.org>
Date: Fri, 3 May 2024 18:17:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] testing/next: s390x gitlab updates
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org
References: <20240426153938.1707723-1-alex.bennee@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240426153938.1707723-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

On 4/26/24 08:39, Alex Bennée wrote:
> I was asked to update the custom gitlab runner from the aging 20.04 to
> 22.04 which has been done. However I needed to update the provisioning
> scripts and clean-up some of the cruft. Sadly this doesn't seem to be
> passing cleanly as we have:
> 
>    - qtest-s390x/migration-test ERROR           98.94s   killed by signal 6 SIGABRT
>    - failing TCG tests (on s390x HW)
>       - float_convd fails against a generated reference
>       - clc returns 1

I've had a look at the clc failure.

It fails because of bad address space layout, where the NULL page isn't unmapped, so the 
expected SIGSEGV does *not* happen.

This is unfortunate and we could do better.

However, with the upgrade, --static --enable-pie no longer works.
 From config.log,

cc -m64 -Werror -fPIE -DPIE -o config-temp/qemu-conf.exe config-temp/qemu-conf.c -static-pie
/usr/bin/ld: cannot find rcrt1.o: No such file or directory

which suggests a missing package.

Alternately, we could drop --static, as it's not really relevant to this testing.  With 
that, we get PIE dynamically linked executables, which do not trigger the bad layout.

But at some point we should make sure that the NULL page(s) are reserved PROT_NONE for the 
guest, which ensure this stays fixed.


r~


