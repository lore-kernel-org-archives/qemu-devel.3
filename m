Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72A2AF8D775
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 19:52:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDSkY-000414-Ha; Thu, 16 Apr 2026 15:51:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDSkW-00040f-R5
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 15:51:40 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDSkV-0004TN-BG
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 15:51:40 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-488a14c31eeso66592545e9.0
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 12:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776369098; x=1776973898; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kQGGhomqIL6L6Vmuy+gI2rr2SCBTHNJKM8cuxcyUo2g=;
 b=FoA5brEzB/y1dsraxQteMN6Fn6o/FnQ/xKjxE5AuWOHwtecuHCWCn2/E6b2sjyP9hi
 OPpeyKw0V+DvGJS0pw3A07OD65ytgDBBfl+l3o1B82oRVVOxe8PKgz0LY65glUIUvaZi
 6diIHqpUr1IO12uUsYwkT+2k7dNB6dpaL82Ng3vl9BDuo6R+2K2tKudUNPqsygJNX9Mh
 ZLl0Y0DHABWE4i/UYZqFE+lSMELUH99NDV5dt/ivLx1aYrqBWpRnHm8053WT+7uBgY0t
 MTlE3DINxKAWOorDjXCrkxcqdT5abRKs+y5Puj9gtjqgDO8ESxC+rPnW2OoGaK9wZyw+
 hdOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776369098; x=1776973898;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kQGGhomqIL6L6Vmuy+gI2rr2SCBTHNJKM8cuxcyUo2g=;
 b=MHK8truyVlhGSUvTT07OqzL28ve+Ygb29hK2TQ2sAQW34sq9eILJkRdoGMdthc3pCI
 8rgs8PzwTEwnjv17tAufCDlTiQ8wVxeio3mnvi+obexPveg6UFwU5G51Uq61+8sY4aqo
 QZq65lhpDxR+gEdEVWBs/JappTEbMnSCPJzBv2b35uoXT5BwdFQDenISCZm7IzydfNoH
 1b/oN6Vfh5vwRTa80COEDD7VhioRrTt5i3b0n+AoQWxaq6poByolAtt0rr32sjbbUXtn
 B9OTBVmRTp+9JarfF3Efbubxgo0TdJTcEq2dKXb5oxIPWv070eevzhK+OvK7+t13FRmm
 ZdIg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+yu7KNYMtdsRGwX4ueJC8Zc3Kj4/bqeDl8d88hZkZk8vofvOM9OBUBEzsodL7RbCRIl1T9DL+UIVFz@nongnu.org
X-Gm-Message-State: AOJu0YxgND5CZH80rcccdAnTfpJ+heK0DTvgXsB6O8BgTdGpPQfwu8Ed
 7siVC82apcU/sQ/cHaV7ZN38f9cJL32Ot2iN0YhRuLszZQeC0lJyMccatViDoFyyVfY=
X-Gm-Gg: AeBDievHL1e82bmr9kbjMJk8RiVYBkOTZ8JOqSSIMyZcankyM5xpw/NnHpy8kYHceCz
 yo2UkCoHUXSptpdZAFKoP4MoINY10h7nfaGSBgvheb25xVphvrH9YVljYWBLUS8akKkGH3UKMoc
 P9Cyq8V1p6YrSJows5cHwqmOYgDzL5YIaD7KoWPYZnxsWOdCTOgDeuRaoZzyp6RjVgB3Y+hAfI3
 Q7s/l88LMu7AIKTwJxA8jxG2eON4l8UAFIWnSRfpGJDcMEpuyQxWUbnJccX/XmTe6P2iUN2QsvQ
 vykQbGELAG16QV3s3dOVADv2SdiMogCdgBg3RhAWyoExN0mPgfh3ZDi1MZgPPwSsoy0bIWZnOdH
 Gxsa4Z+Vl9QknPs6cLia+MDSDwAGyKK106eDzv/cJkrSgI+In8TEM/v5SyaSrQ3LnDYKl/Iuxje
 y2lRc7h1V4gfKthb00hK4dH440Sph8u0hePTQB1wIT7C43V9o5vmBFgrd5gaJGKCtM0wDZwX2yi
 y01
X-Received: by 2002:adf:f08e:0:b0:43f:e211:1090 with SMTP id
 ffacd0b85a97d-43fe21110dcmr468632f8f.1.1776369097485; 
 Thu, 16 Apr 2026 12:51:37 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43ead2decafsm14813107f8f.0.2026.04.16.12.51.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Apr 2026 12:51:36 -0700 (PDT)
Message-ID: <73d6cb95-454d-49c3-b8eb-d8711941ec2d@linaro.org>
Date: Thu, 16 Apr 2026 21:51:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] tests/functional/aarch64: Add basic test of TCG
 aarch64=off
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
References: <20260416165353.589569-1-peter.maydell@linaro.org>
 <20260416165353.589569-4-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260416165353.589569-4-peter.maydell@linaro.org>
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 16/4/26 18:53, Peter Maydell wrote:
> Add a basic test of the TCG 'aarch64=off' functionality; this is the
> same as our existing arm/test_virt test, but it runs the AArch32
> guest kernel on qemu-system-aarch64 with -cpu max,aarch64=off.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   tests/functional/aarch64/meson.build          |  1 +
>   .../aarch64/test_virt_aarch64_off.py          | 37 +++++++++++++++++++
>   2 files changed, 38 insertions(+)
>   create mode 100755 tests/functional/aarch64/test_virt_aarch64_off.py

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

