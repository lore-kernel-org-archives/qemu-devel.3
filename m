Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7390C107526F
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 07:40:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w37yu-0000B7-HI; Thu, 19 Mar 2026 03:39:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w37ys-0000Ad-OQ
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 03:39:46 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w37yr-0001xY-27
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 03:39:46 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-482f454be5bso16732385e9.0
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 00:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773905983; x=1774510783; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SUOX20E+nqx1tLMRpr8hqxX/8+GzMIpuH3/Xt06d+88=;
 b=bD+LJl43jqjPqvgBYckPyA1mCekYIN+Df2QGnSER1l1QPKkEPum6pwRvZ8v7hrLnPx
 xXMO/3CEkWuW7lA4+5q5LVD3SMQm938UaLvDIY/K/8I1p+GNEZsxt2Roy70DXKF5ImC4
 3Fzn+nOda0dEy00O77VH22ZaEq1FS8rbt69qG0EOdbGLc3Z+VSBPh8pL+wyacKM2dlZl
 kQtlyE7qomTb3sP8cpIXF8JBtS9rd7q+FZgm9Lyn7PNqQjixPS3j1AMKm4rURADqZ6TE
 4s03Y/gss2yC+biBFhB4U/y32fyESR5wUniUsfICE2/bR+Tds4EUEXiLv3J7U8ruo4an
 igkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773905983; x=1774510783;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SUOX20E+nqx1tLMRpr8hqxX/8+GzMIpuH3/Xt06d+88=;
 b=TehrUvK7maKxxnJS2HMY54oSN4ViktMYJqKaaiEG41jhzSrWjcxfFRcEHJqqeyTafN
 l08z/nxpkwJTWi+xZS3LeAJ3oyBa1+w0bF/Lv+RrnUqYcTAdYhYuGuQnj4VfERtUksUt
 G2NP1pbndhoqshVBMySZuqq8Qth6rA6NSkAjaCn5UV4f6j+pliPRSIZemNN/b/xGp5iu
 jcuH4wCeSyoOnFKpDCQeayC7tAHuYYnxD6ZeLsetuJwME7Pqc9MFlXE6nycqjiDHeLto
 x+Uc4Rg6zvD01zTzMRpRAK/xu5BmMPSZ+k7UPm4eeWSEC+C7PRcPfD0d8ha/rizScVsP
 r0Hg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0s8zSsDrCtUisQi/vqNoKOXsCKJn5yNI2oCcaE+74pK0qqSC1MIZFztzunIltjYfdXUrixiGyyRuz@nongnu.org
X-Gm-Message-State: AOJu0Ywjl9t5r4oXhOCT14obv2+vm7D7YHKOdvV8MADJ0CF8QGYSHnDt
 CtHLwdsHHAhKiEFJlXqpoINPCP6tvTMF/MlecWS7Bn7hkzAx3DyR9WLRNC37KqNtILI=
X-Gm-Gg: ATEYQzzGpEyaA1dry1R4wJ66pwTWlZGeP1SuPnRt3x9NbT8LVGF/k18Hxl3T07uSgQ+
 LI4HV/yA4Nzeuf46mUhaB2YJhceMceilewheKHsQVQa1gHx7A6avDrims6/AoaT69iQ+A/uWT0n
 /vYknsbMxKeaXH8WagjBcBpV3D9eIxVlfL4m1AmMxOk/SYsmUIBNFPBTBUC4R57oXNhvDjqZOh5
 LzmCp+OQESHZ/ApB5brtIQ93WGlncTmRt9stTttlVRZXo0BGQkf/kDEdWGhfyN7MIML6r4efBXt
 0O2cO8ajD0FeKyECilbKJWGT4ngB9Adq8M/GwoBFc2FEBuBicvQTHftna6k7nUc/lfd3eB5r80o
 oF2QMfUHA2x2V7Lc51gu+o629qOB1U/gYpQBD+F/mlUiHgs2xs2xcc8+8vQoUAE8uZxr1naFJpg
 dTgIDguCm1sqTBf/3QkN2WH5XjxBTlvLjZEz/r+IY5s1Du9g==
X-Received: by 2002:a05:600c:4fd6:b0:485:3f58:da2 with SMTP id
 5b1f17b1804b1-486f8b6ce01mr37019765e9.16.1773905982646; 
 Thu, 19 Mar 2026 00:39:42 -0700 (PDT)
Received: from [192.168.69.206] ([88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486f4623a26sm39315275e9.7.2026.03.19.00.39.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Mar 2026 00:39:39 -0700 (PDT)
Message-ID: <f09a4fba-96c2-43f1-92de-412a1db18ac3@linaro.org>
Date: Thu, 19 Mar 2026 08:39:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/8] hw/vfio: single-binary
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, eric.auger@redhat.com,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20260317194241.869568-1-pierrick.bouvier@linaro.org>
 <517be5bb-d6c8-4220-b585-3adbe4826056@linaro.org>
 <5718eb21-ab32-49e1-82ce-beabb33983ea@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <5718eb21-ab32-49e1-82ce-beabb33983ea@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 18/3/26 18:48, Pierrick Bouvier wrote:
> On 3/17/26 10:57 PM, Philippe Mathieu-Daudé wrote:
>> On 17/3/26 20:42, Pierrick Bouvier wrote:
>>
>>> Pierrick Bouvier (8):
>>>     hw/vfio/listener.c: remove CONFIG_KVM
>>>     hw/vfio/helpers.c: extract kvm helpers in kvm-helpers.c
>>>     hw/vfio/pci-quirks.c: remove CONFIG_VFIO_IGD
>>>     hw/vfio: eradicate CONFIG_IOMMU from sources
>>>     hw/vfio/pci.c: eradicate CONFIG_KVM
>>>     hw/vfio/ap.c: use full path for target specific header
>>>     hw/vfio/spapr.c: extract vfio_spapr_kvm_attach_tce to
>>>       hw/vfio/kvm-spapr.c
>>>     hw/vfio: all vfio files can now be common files
>>
>> Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>
> 
> For some reason, b4 trailers does not apply this. I added it manually on 
> latest patch of series.

Sorry for the inconvenience.

Maybe I should have prefixed with "Series:"?

Also there is the '-t' option:

   -t, --apply-cover-trailers
      Apply trailers sent to the cover letter to all patches

> Regards,
> Pierrick


