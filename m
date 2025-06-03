Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04CF3C5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 11:40:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMPzW-0007b8-00; Tue, 03 Jun 2025 07:39:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uMPz4-0007On-8Y
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 07:39:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uMPz0-0006zr-P1
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 07:39:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748950744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=kIkMkcsG8n+LSEEYseeJIhsQPrNGdps52ghDL5Mt5dc=;
 b=UzkHKsWQEFXhGgfBjBxASjFOjWzlwf7CTRH0RnIgSLkNyFrTySkdh71r0mUSNkC0wviJYI
 swJZFzHbVGGVmfQMZK8DE/ZH/OsiugMeQm/RFdZHOCD4QwtAqqvu1yQxEOcXbgHKR8DGnO
 Xubp6KESJqvcPE7iiMh/chzgI5Tshr4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-FfcxXKifMve9xxH6n0uvcQ-1; Tue, 03 Jun 2025 07:39:03 -0400
X-MC-Unique: FfcxXKifMve9xxH6n0uvcQ-1
X-Mimecast-MFC-AGG-ID: FfcxXKifMve9xxH6n0uvcQ_1748950742
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-450de98b28eso13189455e9.0
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 04:39:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748950742; x=1749555542;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kIkMkcsG8n+LSEEYseeJIhsQPrNGdps52ghDL5Mt5dc=;
 b=russNGQVATe7VcB+MFduaBYTCPU1Avr9V5lKYlh1eyJVuJJeHpT2NiKNPnc2xGMxG/
 VvgKP8NSJh25DgLsQkQwkI61Gpf3K43yUWRVAjb6ZITh5Yyxmn2q7ZgDnGC7iuZ2aRTP
 RZj5AsM8TEwlR62bsoVOfYLQ68MXX0YNJrNc/5nK5OsMxvy/BxGXwEl4yhPs3FjYN91P
 wckon9ofNtmkfXRUr/ruaQq1YtjQ9JpJLqwHAsrHH6y+fEJcaToOoNUraGob2Wj4gkF1
 TyHRm1Dngr2pSf8YxBYz1NDgOL9WuHDzJzmEFIoU0kZV58+G7H3G99UdzUg2ci6e8g0m
 QS4w==
X-Gm-Message-State: AOJu0Yw+8SqqmwI2ya5NQ6Pi7cApueT6NuYaXzjqjqODrV3ZPsArn5zx
 XthoyYw5zXsvmZfr2bjcxWveHpxYfJDLVDBw7w85wPh1hFeORyM589lw9nGhGh/LK6/pw7pwPgA
 M9y+iEypE2FZ/J/nElwigaV6hpCqTF6LsznDhOPTedmlbVHSbeKWTk3ZH
X-Gm-Gg: ASbGncsV+dx3nzuT7yz9ZP0sfcm/PZOITeuqQktzjg6l0T6KJPpk05xjlz079MU8I6D
 evMKial9PU/8p3KelzljaUPbP8iJP6HhPySbOcsGW70WjpXAAcsXRM7VL9LsRwsRc0Z+O+viTjd
 gO3ss6pAcexWQWHrl8xZixx8qTuDgyNGlk7m/4v4YaoMGN0k9XJNBJ+Xo8lfJCQDBXbuZrMcWtm
 piBc44rYXREL1sOfMo9jA9KoWqar0HBopJ47mrJ+CAyXMu7CuxpZTwNK2xM7XQevihrPHumr3KZ
 aS2VaMTZKmq2bjuXxigVIm9qt5fMcwxWp2ig4uJ3sWY=
X-Received: by 2002:a05:6000:18a8:b0:3a3:7117:1bba with SMTP id
 ffacd0b85a97d-3a514501ecemr2015875f8f.24.1748950742109; 
 Tue, 03 Jun 2025 04:39:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMCfRwB6wyFm5YBZJC1TGqjQOTkR+kngOiWsRE2QE9xwOMbXMJqGhWiuXiD0k9YfbutUoEYw==
X-Received: by 2002:a05:6000:18a8:b0:3a3:7117:1bba with SMTP id
 ffacd0b85a97d-3a514501ecemr2015850f8f.24.1748950741626; 
 Tue, 03 Jun 2025 04:39:01 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-50-214.web.vodafone.de.
 [109.42.50.214]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe6c94dsm18192178f8f.37.2025.06.03.04.39.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Jun 2025 04:39:01 -0700 (PDT)
Message-ID: <6b0cddfb-4ebe-4775-becc-c4301235849d@redhat.com>
Date: Tue, 3 Jun 2025 13:38:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 36/58] pc-bios: Move device tree files in their own subdir
To: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org
References: <20250425152843.69638-1-philmd@linaro.org>
 <20250425152843.69638-37-philmd@linaro.org>
 <621F23F2-05FC-4C8C-8AA8-F61DED04B306@gmail.com>
 <83dcb220-dd06-fb7f-1960-432fb2696b60@eik.bme.hu>
 <0648af18-2e50-4eaa-96fb-b0e64eb706d9@linaro.org>
 <05174912-B148-4ECB-9F8C-4C0641FFC2BB@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <05174912-B148-4ECB-9F8C-4C0641FFC2BB@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 03/06/2025 08.39, Bernhard Beschow wrote:
> 
> 
> Am 2. Juni 2025 08:12:39 UTC schrieb "Philippe Mathieu-Daudé" <philmd@linaro.org>:
>> On 30/5/25 02:54, BALATON Zoltan wrote:
>>> On Thu, 29 May 2025, Bernhard Beschow wrote:
>>>> Am 25. April 2025 15:28:20 UTC schrieb "Philippe Mathieu-Daudé" <philmd@linaro.org>:
>>>>> From: BALATON Zoltan <balaton@eik.bme.hu>
>>>>>
>>>>> We have several device tree files already and may have more in the
>>>>> future so add a new dtb subdirectory and move device tree files there
>>>>> so they are not mixed with ROM binaries.
>>>>>
>>>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>> Message-ID: <57f179bd3904c1f2ca062ca4d4ff9592bb4f4daa.1745402140.git.balaton@eik.bme.hu>
>>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>> ---
>>>>> MAINTAINERS                                |   2 +-
>>>>> system/datadir.c                           |   4 +++-
>>>>> pc-bios/{ => dtb}/bamboo.dtb               | Bin
>>>>> pc-bios/{ => dtb}/bamboo.dts               |   0
>>>>> pc-bios/{ => dtb}/canyonlands.dtb          | Bin
>>>>> pc-bios/{ => dtb}/canyonlands.dts          |   0
>>>>> pc-bios/dtb/meson.build                    |  23 +++++++++++++++++++++
>>>>> pc-bios/{ => dtb}/petalogix-ml605.dtb      | Bin
>>>>> pc-bios/{ => dtb}/petalogix-ml605.dts      |   0
>>>>> pc-bios/{ => dtb}/petalogix-s3adsp1800.dtb | Bin
>>>>> pc-bios/{ => dtb}/petalogix-s3adsp1800.dts |   0
>>>>> pc-bios/meson.build                        |  23 +--------------------
>>>>> qemu.nsi                                   |   2 +-
>>>>> 13 files changed, 29 insertions(+), 25 deletions(-)
>>>>> rename pc-bios/{ => dtb}/bamboo.dtb (100%)
>>>>> rename pc-bios/{ => dtb}/bamboo.dts (100%)
>>>>> rename pc-bios/{ => dtb}/canyonlands.dtb (100%)
>>>>> rename pc-bios/{ => dtb}/canyonlands.dts (100%)
>>>>> create mode 100644 pc-bios/dtb/meson.build
>>>>> rename pc-bios/{ => dtb}/petalogix-ml605.dtb (100%)
>>>>> rename pc-bios/{ => dtb}/petalogix-ml605.dts (100%)
>>>>> rename pc-bios/{ => dtb}/petalogix-s3adsp1800.dtb (100%)
>>>>> rename pc-bios/{ => dtb}/petalogix-s3adsp1800.dts (100%)
>>>>>
>>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>>> index 661a47db5ac..d82d962f1a4 100644
>>>>> --- a/MAINTAINERS
>>>>> +++ b/MAINTAINERS
>>>>> @@ -1581,7 +1581,7 @@ F: hw/pci-host/ppc440_pcix.c
>>>>> F: hw/display/sm501*
>>>>> F: hw/ide/sii3112.c
>>>>> F: hw/rtc/m41t80.c
>>>>> -F: pc-bios/canyonlands.dt[sb]
>>>>> +F: pc-bios/dtb/canyonlands.dt[sb]
>>>>> F: pc-bios/u-boot-sam460ex-20100605.bin
>>>>> F: roms/u-boot-sam460ex
>>>>> F: docs/system/ppc/amigang.rst
>>>>> diff --git a/system/datadir.c b/system/datadir.c
>>>>> index e450b84ce91..f96f8fc2646 100644
>>>>> --- a/system/datadir.c
>>>>> +++ b/system/datadir.c
>>>>> @@ -44,9 +44,11 @@ char *qemu_find_file(QemuFileType type, const char *name)
>>>>>
>>>>>      switch (type) {
>>>>>      case QEMU_FILE_TYPE_BIOS:
>>>>> -    case QEMU_FILE_TYPE_DTB:
>>>>>          subdir = "";
>>>>>          break;
>>>>> +    case QEMU_FILE_TYPE_DTB:
>>>>> +        subdir = "dtb/";
>>>>> +        break;
>>>>>      case QEMU_FILE_TYPE_KEYMAP:
>>>>>          subdir = "keymaps/";
>>>>>          break;
>>>>> diff --git a/pc-bios/bamboo.dtb b/pc-bios/dtb/bamboo.dtb
>>>>> similarity index 100%
>>>>> rename from pc-bios/bamboo.dtb
>>>>> rename to pc-bios/dtb/bamboo.dtb
>>>>> diff --git a/pc-bios/bamboo.dts b/pc-bios/dtb/bamboo.dts
>>>>> similarity index 100%
>>>>> rename from pc-bios/bamboo.dts
>>>>> rename to pc-bios/dtb/bamboo.dts
>>>>> diff --git a/pc-bios/canyonlands.dtb b/pc-bios/dtb/canyonlands.dtb
>>>>> similarity index 100%
>>>>> rename from pc-bios/canyonlands.dtb
>>>>> rename to pc-bios/dtb/canyonlands.dtb
>>>>> diff --git a/pc-bios/canyonlands.dts b/pc-bios/dtb/canyonlands.dts
>>>>> similarity index 100%
>>>>> rename from pc-bios/canyonlands.dts
>>>>> rename to pc-bios/dtb/canyonlands.dts
>>>>> diff --git a/pc-bios/dtb/meson.build b/pc-bios/dtb/meson.build
>>>>> new file mode 100644
>>>>> index 00000000000..7a71835bca7
>>>>> --- /dev/null
>>>>> +++ b/pc-bios/dtb/meson.build
>>>>> @@ -0,0 +1,23 @@
>>>>> +dtbs = [
>>>>> +  'bamboo.dtb',
>>>>> +  'canyonlands.dtb',
>>>>> +  'petalogix-ml605.dtb',
>>>>> +  'petalogix-s3adsp1800.dtb',
>>>>
>>>> Was it intended that the suffix changed from .dts to .dtb? This change isn't motivated in the commit message and usually source files rather than generated artifacts are listed in build files.
>>>
>>> I think I either found similar python code somewhere and followed that because meson and python is not something I understand well. Or changed it because we always need the list of dtbs to install but only need the dts when compiling so this way we don't need another list or replacing suffix twice.
>>
>> Should we revert?
> 
> What's the idea behind having dtbs in the repository instead of making dtc mandatory? If there is any perspective that we could remove the dtbs in the future I vote for restoring the original logic. I could send a patch since I have further dtb fixes for the e500 and arm.

IMHO since we require libfdt for many boards already anyway, we could also 
require dtc for these boards that need a dtb (and disable them if dtc is not 
available) ... we just might need some additional Kconfig symbol for that 
case since dtc and libfdt are sometimes shipped in different packages on the 
various distros and thus could be installed independently from each other.

  Thomas


