Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9335C4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 13:43:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZt3W-0006Fe-3S; Tue, 13 Feb 2024 08:42:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1rZt3V-0006FQ-8F
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 08:42:37 -0500
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1rZt3R-0005jB-DC
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 08:42:37 -0500
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2d107ae5288so8382511fa.3
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 05:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707831751; x=1708436551; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=xffuTwsj9hhicMrnU9gj0YroPO7MfvKEOdjjRwyDP/w=;
 b=lwWHiohD+wGMawrv2Tt9YCh3v/ru7aLUMzCkbHuT2us/7pSp7pBYBPUyEWvCNp4nDz
 Lt3f6mJAvSsFF0G+6avpW2DMqMLC3M7SRzrm64eFmMmex592AEs6iVLvHuwVOEpSY4m/
 JlqUp6kjcjz6aiVIFJvv1t7V3cdPNmqjIUykjkj12bGncnAPL6pNKFhSp7FbVJVSxeSh
 smizV/Oy5wROcJ7EuEvWFQIPditxTdXHr53cAz5VWx7phmT5qkO1wEoptwlLQPXcvNJ9
 Y1kZq2ZhV8o0vWOp9t5KO1IKP8FYKJpQdEY3Nxw9FdETaZInIAz3IYOboIC4W7I9Brno
 1p6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707831751; x=1708436551;
 h=content-transfer-encoding:in-reply-to:organization:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xffuTwsj9hhicMrnU9gj0YroPO7MfvKEOdjjRwyDP/w=;
 b=O8gvWHfP60rXZ2/8GdEwIm+uZn7IOLprAWV79itimTMpqUg0tSgTjOQTg/DuNghNGu
 0DIjipK6cMorC/+6bbIDstSpVfNt/WNV8HKgGwwoV3qWQaa11HHBCcce2mP5//jpMCZv
 ykxB0iTv4mYX9P+z1Sh5luvZkVILonafSLyJT2KrC8jj29HVNXdv2+XBYXefXSohrMxS
 Nc8YeA2ERLYxdRj3LMwq9CaatNPKhMLvby3fD0hpBpYXfJlj7fflwnH3wIiC1X/suAZA
 OhsvfnJpWI1eKiy4mkc9mHQePDtd8L2Ib7NQNVHTNLq2+z0kJIArpsmXTvCmyghKnwhj
 fmsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuR9XWE3E+j+OvNXh07jbluYFlwY15A40RHp4ZKg+PYwkB4+PxrwZng3Ol3zbasQKfSUBWCYzrqcSZWEe+dA8jHUb6cmI=
X-Gm-Message-State: AOJu0YyvPefnq6QXp6OwZDT7rlDp4jFqvWrUILS2XYaAmu2sdR/jXhF6
 Ruj2tBMgGDNNt06rjQse4e1S/Pg8c5tr1dxmOs7ofpctyJSq5K+bj209dTM7p/Q=
X-Google-Smtp-Source: AGHT+IFdrSL2A3MjkgnOmizRNpNSusFcwyGGZmr43BwMJIHQdAtuSsiC2+H7R/+22cZJHrwuVOMr6w==
X-Received: by 2002:a2e:a0cb:0:b0:2d0:9210:fd57 with SMTP id
 f11-20020a2ea0cb000000b002d09210fd57mr6193990ljm.18.1707831751027; 
 Tue, 13 Feb 2024 05:42:31 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUOf7FSTcsr+w1UYF4rBo2gZdNch0CX2b2xGJP7zKUE3VO6vJHGZTFmOSURFA0lQDOEcRk39sZFQWhntjvwIzusr325HYvI6zMph/M2k5b0nCU+BvDwmiSJrbeS72vUPw==
Received: from [192.168.1.19] (83.8.197.133.ipv4.supernova.orange.pl.
 [83.8.197.133]) by smtp.gmail.com with ESMTPSA id
 n1-20020a2eb781000000b002d0fba14be8sm506581ljo.83.2024.02.13.05.42.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Feb 2024 05:42:30 -0800 (PST)
Message-ID: <ede43fd1-9005-4f02-9494-73cfd898e3a0@linaro.org>
Date: Tue, 13 Feb 2024 14:42:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: possible deprecation and removal of some old QEMU Arm machine
 types (pxa2xx, omap, sa1110)
To: Guenter Roeck <linux@roeck-us.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Cc: qemu-arm <qemu-arm@nongnu.org>
References: <CAFEAcA88UGhjh8-iBvhxx6GdWg74dinYouiguTcz=qEe51L7Ag@mail.gmail.com>
 <fe5476c7-82e0-4353-a943-7f39b14e1b5b@roeck-us.net>
Content-Language: pl-PL, en-GB, en-HK
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Organization: Linaro
In-Reply-To: <fe5476c7-82e0-4353-a943-7f39b14e1b5b@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-lj1-x232.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

W dniu 12.02.2024 o 15:36, Guenter Roeck pisze:

>> The machines I have in mind are:
>>
>> PXA2xx machines:
>>
>> akita                Sharp SL-C1000 (Akita) PDA (PXA270)
>> borzoi               Sharp SL-C3100 (Borzoi) PDA (PXA270)
>> connex               Gumstix Connex (PXA255)
>> mainstone            Mainstone II (PXA27x)
>> spitz                Sharp SL-C3000 (Spitz) PDA (PXA270)
>> terrier              Sharp SL-C3200 (Terrier) PDA (PXA270)
>> tosa                 Sharp SL-6000 (Tosa) PDA (PXA255)
>> verdex               Gumstix Verdex Pro XL6P COMs (PXA270)
>> z2                   Zipit Z2 (PXA27x)
>>
> I test akita, borzoi, spitz, and terrier. Upstream Linux removed support
> for mainstone, tosa, and z2 from the Linux kernel as of version 6.0, so
> I am no longer testing those.

I do wonder are those Zaurus models also boot kernels which QEMU boots. 
Would love to see someone still using those old palmtops. I put my 
Zauruses (collie, poodle, c7x0) into drawer long time ago.

>> OMAP2 machines:
>>
>> n800                 Nokia N800 tablet aka. RX-34 (OMAP2420)
>> n810                 Nokia N810 tablet aka. RX-44 (OMAP2420)
>>
> I never managed to get those to boot the Linux kernel.

They were working in 2008. I was running Maemo and Poky Linux then. 
Never tried later.

>> The one SA1110 machine:
>>
>> collie               Sharp SL-5500 (Collie) PDA (SA-1110)
>>
> I do test collie.

Can you share kernel/initrd/config? I wanted to boot something at 20th 
anniversary of buying one but was unable to build anything bootable on 
either QEMU/collie or physical one.


