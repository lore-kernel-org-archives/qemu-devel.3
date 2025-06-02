Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F055AC54FB3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 08:13:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uM0Hp-0001O7-K9; Mon, 02 Jun 2025 04:12:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uM0Hk-0001NO-SP
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 04:12:44 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uM0Hi-00009T-UO
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 04:12:44 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-442f9043f56so23721935e9.0
 for <qemu-devel@nongnu.org>; Mon, 02 Jun 2025 01:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748851961; x=1749456761; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+4KhK5uoNca2eG5pQBsIKnhN6ngCRkA6a4bxOtiHBpw=;
 b=Lmh0CpxpKkAt8qEsJ6hZuy5M4Y2LTEFY10rhdDh/VoEjyMrhuflkXmxxAYwjuHtQHu
 vxqHuXY4rvQgwc2fW9aTn8ZlQTehKwKS3qTF/Cj/JMbwc8r15tKNcREJDsqi/eToauZT
 yO6i0JTkxrEE+gZ3FL9II2be/w8MsG46cnW/ecN3xRTzxiYsdrTkWW6EyTe2BHcEg3eN
 hh1/hNvxwSV+Uvk+vFTwBdmDAfwoyV5rAwv2R769frpHw/Vm0y/cTRZ4WtSoPvFMG6FD
 diRRsg88J3xN2Z267F/wuGCkqVsjIxz+EuacAtk9Xyn1KT9QsKfuNoJC91d2eiov9OY2
 kDhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748851961; x=1749456761;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+4KhK5uoNca2eG5pQBsIKnhN6ngCRkA6a4bxOtiHBpw=;
 b=XlvHQV+/gTZvo4Kxfkaxpol4j5vm5FScXcx29Kx6nzhcuNdRYrcfAz6tY8jkJI1pqG
 TC2sUEHGRQFdSs8ywJ/zbm6R/7JBv0Aovcf/YqeK6mFpn8ztgAe4TVYSd49Xze3hzsKz
 CVH46EZsbLawQ7p/CqeID6k85POoT0GGObtgU4DodQzLZkBduUu7/8CYO7Az8V8AyJaw
 F2VXGXRYYYltbS1F0FQvkIkbYlBi0DqZefZjg81d95x+Rk/CyLY6vMZpm8OI2izoRq+d
 lREii1RsbbqzYMb4RemW9+SdZog/bmoI0bocsjjsaOVqGD5QRZuQhaPboC0DUEpKl7OD
 3tcw==
X-Gm-Message-State: AOJu0YxqxTwT7tmYsBM746ZHFJ7g1Xo4/+EV+KflhfGmGUeL1kwjnUcX
 TNoUcAUH/llBzmDtA4fHmv4GCdcSKMIxkqeZckHVwR4LUtWBD8KTagrjFHJngfG+UOM=
X-Gm-Gg: ASbGncvXhOr0VdFYUZhim1t9pRMCC38s4KDWWGdI7i/672euzy2Hs4QVuQnIXbSdivP
 8IdFFB6ft5yQiRl2LyMzLXMcO3B1sekv+3UZIAq8Lq66vbs0DgOfy1oVBNUwn6aYcuP8T4EoOoV
 zy2d0jG9y3TP6MbGycvP0AZSqqilhZJJlNkNk/w/6xJR0+qY98p7wP4KeL3nt4Rp1ib3y7NeV09
 Q+vDD8f/lmM+V/TogFhThve8hEPWcendW5+TSoG4EmDs4+tmiBCmId+e9yJhl+Gfu26l4uS1LCO
 6WQvvj+eGve2DxHh6Qc/JX4vuwpdWgrCH/5HuJxMwQMGtu8TQfNKXwmvDZI8lAAaQGabKmDHmap
 deptN2G65G/7j90HLbwc=
X-Google-Smtp-Source: AGHT+IEwFrKQjrZhWpTGoAjljQMeaUJ6j12krLgQciqJsdCcEB4HEmA5524gmQ8g0W9j5oAIpw5qQg==
X-Received: by 2002:a05:600c:4e4d:b0:445:1984:247d with SMTP id
 5b1f17b1804b1-451191fd126mr56661045e9.7.1748851961063; 
 Mon, 02 Jun 2025 01:12:41 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-451df07ac73sm10722925e9.9.2025.06.02.01.12.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Jun 2025 01:12:40 -0700 (PDT)
Message-ID: <0648af18-2e50-4eaa-96fb-b0e64eb706d9@linaro.org>
Date: Mon, 2 Jun 2025 10:12:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 36/58] pc-bios: Move device tree files in their own subdir
To: BALATON Zoltan <balaton@eik.bme.hu>, Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org
References: <20250425152843.69638-1-philmd@linaro.org>
 <20250425152843.69638-37-philmd@linaro.org>
 <621F23F2-05FC-4C8C-8AA8-F61DED04B306@gmail.com>
 <83dcb220-dd06-fb7f-1960-432fb2696b60@eik.bme.hu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <83dcb220-dd06-fb7f-1960-432fb2696b60@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 30/5/25 02:54, BALATON Zoltan wrote:
> On Thu, 29 May 2025, Bernhard Beschow wrote:
>> Am 25. April 2025 15:28:20 UTC schrieb "Philippe Mathieu-Daudé" 
>> <philmd@linaro.org>:
>>> From: BALATON Zoltan <balaton@eik.bme.hu>
>>>
>>> We have several device tree files already and may have more in the
>>> future so add a new dtb subdirectory and move device tree files there
>>> so they are not mixed with ROM binaries.
>>>
>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> Message-ID: 
>>> <57f179bd3904c1f2ca062ca4d4ff9592bb4f4daa.1745402140.git.balaton@eik.bme.hu>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>> MAINTAINERS                                |   2 +-
>>> system/datadir.c                           |   4 +++-
>>> pc-bios/{ => dtb}/bamboo.dtb               | Bin
>>> pc-bios/{ => dtb}/bamboo.dts               |   0
>>> pc-bios/{ => dtb}/canyonlands.dtb          | Bin
>>> pc-bios/{ => dtb}/canyonlands.dts          |   0
>>> pc-bios/dtb/meson.build                    |  23 +++++++++++++++++++++
>>> pc-bios/{ => dtb}/petalogix-ml605.dtb      | Bin
>>> pc-bios/{ => dtb}/petalogix-ml605.dts      |   0
>>> pc-bios/{ => dtb}/petalogix-s3adsp1800.dtb | Bin
>>> pc-bios/{ => dtb}/petalogix-s3adsp1800.dts |   0
>>> pc-bios/meson.build                        |  23 +--------------------
>>> qemu.nsi                                   |   2 +-
>>> 13 files changed, 29 insertions(+), 25 deletions(-)
>>> rename pc-bios/{ => dtb}/bamboo.dtb (100%)
>>> rename pc-bios/{ => dtb}/bamboo.dts (100%)
>>> rename pc-bios/{ => dtb}/canyonlands.dtb (100%)
>>> rename pc-bios/{ => dtb}/canyonlands.dts (100%)
>>> create mode 100644 pc-bios/dtb/meson.build
>>> rename pc-bios/{ => dtb}/petalogix-ml605.dtb (100%)
>>> rename pc-bios/{ => dtb}/petalogix-ml605.dts (100%)
>>> rename pc-bios/{ => dtb}/petalogix-s3adsp1800.dtb (100%)
>>> rename pc-bios/{ => dtb}/petalogix-s3adsp1800.dts (100%)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 661a47db5ac..d82d962f1a4 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -1581,7 +1581,7 @@ F: hw/pci-host/ppc440_pcix.c
>>> F: hw/display/sm501*
>>> F: hw/ide/sii3112.c
>>> F: hw/rtc/m41t80.c
>>> -F: pc-bios/canyonlands.dt[sb]
>>> +F: pc-bios/dtb/canyonlands.dt[sb]
>>> F: pc-bios/u-boot-sam460ex-20100605.bin
>>> F: roms/u-boot-sam460ex
>>> F: docs/system/ppc/amigang.rst
>>> diff --git a/system/datadir.c b/system/datadir.c
>>> index e450b84ce91..f96f8fc2646 100644
>>> --- a/system/datadir.c
>>> +++ b/system/datadir.c
>>> @@ -44,9 +44,11 @@ char *qemu_find_file(QemuFileType type, const char 
>>> *name)
>>>
>>>     switch (type) {
>>>     case QEMU_FILE_TYPE_BIOS:
>>> -    case QEMU_FILE_TYPE_DTB:
>>>         subdir = "";
>>>         break;
>>> +    case QEMU_FILE_TYPE_DTB:
>>> +        subdir = "dtb/";
>>> +        break;
>>>     case QEMU_FILE_TYPE_KEYMAP:
>>>         subdir = "keymaps/";
>>>         break;
>>> diff --git a/pc-bios/bamboo.dtb b/pc-bios/dtb/bamboo.dtb
>>> similarity index 100%
>>> rename from pc-bios/bamboo.dtb
>>> rename to pc-bios/dtb/bamboo.dtb
>>> diff --git a/pc-bios/bamboo.dts b/pc-bios/dtb/bamboo.dts
>>> similarity index 100%
>>> rename from pc-bios/bamboo.dts
>>> rename to pc-bios/dtb/bamboo.dts
>>> diff --git a/pc-bios/canyonlands.dtb b/pc-bios/dtb/canyonlands.dtb
>>> similarity index 100%
>>> rename from pc-bios/canyonlands.dtb
>>> rename to pc-bios/dtb/canyonlands.dtb
>>> diff --git a/pc-bios/canyonlands.dts b/pc-bios/dtb/canyonlands.dts
>>> similarity index 100%
>>> rename from pc-bios/canyonlands.dts
>>> rename to pc-bios/dtb/canyonlands.dts
>>> diff --git a/pc-bios/dtb/meson.build b/pc-bios/dtb/meson.build
>>> new file mode 100644
>>> index 00000000000..7a71835bca7
>>> --- /dev/null
>>> +++ b/pc-bios/dtb/meson.build
>>> @@ -0,0 +1,23 @@
>>> +dtbs = [
>>> +  'bamboo.dtb',
>>> +  'canyonlands.dtb',
>>> +  'petalogix-ml605.dtb',
>>> +  'petalogix-s3adsp1800.dtb',
>>
>> Was it intended that the suffix changed from .dts to .dtb? This change 
>> isn't motivated in the commit message and usually source files rather 
>> than generated artifacts are listed in build files.
> 
> I think I either found similar python code somewhere and followed that 
> because meson and python is not something I understand well. Or changed 
> it because we always need the list of dtbs to install but only need the 
> dts when compiling so this way we don't need another list or replacing 
> suffix twice.

Should we revert?

