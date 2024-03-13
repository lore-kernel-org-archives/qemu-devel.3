Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 947DDC54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 13:40:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkOpW-0003ni-W4; Wed, 13 Mar 2024 09:39:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1rkOpU-0003n4-JI
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 09:39:36 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1rkOpS-0006zG-5u
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 09:39:36 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2d204e102a9so14690861fa.0
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 06:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710337171; x=1710941971; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=opoUGSlDJP2Z++ZuVyrOcqqRBByg9hLmua8U/wls1aA=;
 b=er3oDW5Cdo3NhLNZYJHm7Xa4cd6YE5PRkeRpwpUlclku9mxlNnli8fSzvowD2y65G5
 0lJ8PyGu/O/RCwZafq6r6C/X29u7u3602DS1GjPnczusFqEmwtTsGtQkT7HUaU//seMV
 AbMdjYbmI3csLow3QQ9LSaqfwmQIlvis/a6+rcyYikNiggD7u3eqF0IhBMmObc3cTeXV
 0hOZq48O+vLv4kJMmc4X33MySd4QQgPEFNfSjLp9isP+ncxt9iioCKLACiNZxKUQ3C56
 sCG+up4/BVxYZrXGWJHTixIVtC0yWweiHbvScQ+yU9W2B+Kf/K25FHVDifivpCdn/Jek
 /QuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710337171; x=1710941971;
 h=content-transfer-encoding:in-reply-to:organization:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=opoUGSlDJP2Z++ZuVyrOcqqRBByg9hLmua8U/wls1aA=;
 b=O8VKhFUABDAJw1tjybQI1QlT1pHQ9LWlh48naR7n0JLc5hkPiNmexpwUYMRknekqwC
 ToRSEp4M6hCUd99bgUfCqORtgMGySjEqYBtkYxHwfkr/+f0erSOKEhZiByIXgBQZ3Ws+
 lEFLQLc2SzlEKq/R123cLyeNXpSYPcjG4II++AJMeIPDRZyL+cfbeeMpKczGdpGp8uOt
 NMNXexkg9EghlWxFZt3G6NKxrDs/hxmZaJiGSIjqIEBkmY59+OtPWjhgJhuAXI7MWBT/
 dw7Qzb/fbsoalKx4r97PpB5aqgod4+tciraaEieJCLS8bDwgKp5nZkE9qe6YCZLgxlmr
 7hZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgaMp3P3HPtIQoWImjyvbJ8QzBj6h+pFqdBCWQ0ZKvj/Y2Oi3uXebvwQmqbF0dLxDVlGIqgYNhVOpDX9PWTSW7GPGLbVw=
X-Gm-Message-State: AOJu0YznDqDOj0zIWIC8qlyHshp3pxmJ6XUu/AD3a0pdP4mQLRCgohvI
 9R3xat38+tMKmvjZRm2yvcgeOgRsS55d2+oVdBL3i8oA9CSix1s1GkpCX5tpb78=
X-Google-Smtp-Source: AGHT+IEETbRwWSXVWdQr27iBPyaUe1Ru6o9FKSZOF5CtLK/Xf46en3exipY90xRfn9IggXNQsS9wDw==
X-Received: by 2002:a05:651c:204:b0:2d2:a201:3e81 with SMTP id
 y4-20020a05651c020400b002d2a2013e81mr2221693ljn.52.1710337171445; 
 Wed, 13 Mar 2024 06:39:31 -0700 (PDT)
Received: from [192.168.200.106] (83.11.22.169.ipv4.supernova.orange.pl.
 [83.11.22.169]) by smtp.gmail.com with ESMTPSA id
 i1-20020a0564020f0100b005687bb9816csm1293755eda.69.2024.03.13.06.39.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Mar 2024 06:39:31 -0700 (PDT)
Message-ID: <fe2abd47-be73-496d-94a4-0b6d95f31bd1@linaro.org>
Date: Wed, 13 Mar 2024 14:39:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] tests/avocado: use OpenBSD 7.4 for sbsa-ref
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Radoslaw Biernacki <rad@semihalf.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Brad Smith <brad@comstyle.com>,
 qemu-arm@nongnu.org
References: <20240313-sbsa-ref-firmware-update-v1-0-e166703c5424@linaro.org>
 <20240313-sbsa-ref-firmware-update-v1-3-e166703c5424@linaro.org>
 <8c197bfe-0cab-47dd-beec-c9752d434a47@linaro.org>
Content-Language: pl-PL, en-GB, en-HK
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Organization: Linaro
In-Reply-To: <8c197bfe-0cab-47dd-beec-c9752d434a47@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-lj1-x233.google.com
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

W dniu 13.03.2024 o 12:44, Philippe Mathieu-Daudé pisze:
>> -        :avocado: tags=cpu:cortex-a57
>> +        :avocado: tags=cpu:cortex-a57,os:openbsd
> 
> IIRC for some reason we must use one tag per line... Even if
> named 'tags', this is handled as a single tag, so we couldn't
> filter on "os:openbsd". We need:
> 
>    :avocado: tags=cpu:cortex-a57
>    :avocado: tags=os:openbsd

OK. It worked when I tested this way:

$ make check-avocado AVOCADO_TAGS='machine:sbsa-ref,os:openbsd'
[..]
  (1/3) tests/avocado/machine_aarch64_sbsaref.py:Aarch64SbsarefMachine.test_sbsaref_openbsd_cortex_a57: PASS (16.18 s)
  (2/3) tests/avocado/machine_aarch64_sbsaref.py:Aarch64SbsarefMachine.test_sbsaref_openbsd_neoverse_n1: PASS (16.06 s)

$ make check-avocado AVOCADO_TAGS='os:openbsd'
[..]
  (1/3) tests/avocado/machine_aarch64_sbsaref.py:Aarch64SbsarefMachine.test_sbsaref_openbsd_cortex_a57: PASS (16.18 s)
  (2/3) tests/avocado/machine_aarch64_sbsaref.py:Aarch64SbsarefMachine.test_sbsaref_openbsd_neoverse_n1: PASS (16.06 s)


