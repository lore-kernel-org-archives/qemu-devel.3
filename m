Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6367C36010
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 10:16:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3BQ7-0007EY-VA; Fri, 11 Apr 2025 06:15:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u3BPx-0007Dj-Cs
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 06:15:25 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u3BPv-0004V7-2U
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 06:15:25 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4394a823036so18078685e9.0
 for <qemu-devel@nongnu.org>; Fri, 11 Apr 2025 03:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744366519; x=1744971319; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=X81x+fX7ctUUUErMmUxwg1vgYhVwKbczeIUuxvWcibA=;
 b=s4uBi3vzwjIDuzS5/BhM4/saP5VYEvlDvB+IlPOvqEmBz2ivQej4Me5ZlguTEvH01I
 k5n9SKx/DAEaaQvtlYPAl6IjS35JQQJ8uAmSYWnIUvUVjY8njjAEbXFYZ01cW7JGMMG0
 87RzkQZUBJQHa1CFAPK27e/b0rGTYCvNel/58yYwYczFDYo6pJeWNFqijGJb3lzg/Bvl
 yPnKOcxvB5BHZnGrzmIe9CsX5saeriQ7MJO+S5raRfuLXB8D/YWk/O8axaWas9ULW90U
 83oQKrzpHnYNiPmPQ5lqlGbI3T81xQul81dO3aHEpqu42dk1KzBMqheWYcZB6Tk5/8B1
 IBGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744366519; x=1744971319;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X81x+fX7ctUUUErMmUxwg1vgYhVwKbczeIUuxvWcibA=;
 b=dCCYI5NAjLETm5KZkZzasXZKIKygYifJfgdrdnF2oAjQ6NyjbUSoYyt1pE4ZGOCuhy
 LDRhQOAz7KZTCj3WPeC9akYDzgp1msRSbqywwsmI0Ufd6A+c2IchLzM/Mt/KNqicwmzQ
 wndvX7NMWwBOs/BAtxFuNcec0BqBt6bR/iMuh/iWNXQ8Przk9UwbpiU+Xrc8Za3kiBP2
 Vhz3rAKjJ//UVRnOg3QaUaj9bxsBTjzH2BubdPk4ZtK1lZcRE7xXdiQNdZ0lyTj9crvX
 BDb7LMr132PnoHAAg7k8CgZkMm7RV+TM2GaAvbOwRVwz7X2bCdePR+DRftXzMXY2Kcl5
 4Y2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXb/MZGv3KnJ3ABtw/npmVpLuNFoEpnqqMhEpADQRoHsRM9VAKfDWbZ0cb6HT9+w2ROrNKLCYSQbGQl@nongnu.org
X-Gm-Message-State: AOJu0Ywvvo5VapEZxAZCit/tLvS5jwmNfWBunDINtW+YIuw4S08ioHBG
 cRlzwtvolRC/eD5QqkS4nZEj0s+BhR8f1BHWCW/3Lcar2rA1gr216px5zbSuBaI=
X-Gm-Gg: ASbGncvusNMt1RGukS4ETL7n3BQ5dgv83wIGEVX+L66x3HaK/OPvR2xRAQ5fVQqQIMQ
 ziyRsF8MslNqoGptg6tIFyDSRHf1WHavFs/loE5SByN84Dkpo5NlWSLq4zifWR/To/I46Oo2UBo
 L4RtHLeRHRzt6yYsZQ8QT2CUWjzbGZaINZOS5t8RWUW8vd9+I+8yUkbcmlSUxzBaOGTYiPzJVHt
 KX2ztKzoEdPGG1KLelxTYU1AwHMp/UT1Z06epLuw+Ke0wss2cUb0qMyqEuiWB7Kzr/oaTk619Vd
 IZDsvodBYL0saubSGnxhmXyjR1Lma/ICHVt2Ce3TSw2v3NIuBH2eHauh9/fm2lQz0JKTRz9R3Tc
 6VXY/YvtZoUTxgDgW/KE=
X-Google-Smtp-Source: AGHT+IF9VQVJZxgHP5AZITiRj7zSzGzyYKmkRuoTavC56NbKQqG4yfTq/kUznmxEtrQp9ELJcjriKA==
X-Received: by 2002:a05:600c:4e13:b0:43d:4686:5cfb with SMTP id
 5b1f17b1804b1-43f3a9add63mr19675875e9.27.1744366519571; 
 Fri, 11 Apr 2025 03:15:19 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f233a2f71sm78563125e9.15.2025.04.11.03.15.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Apr 2025 03:15:19 -0700 (PDT)
Message-ID: <316898c8-20a6-499d-b0f4-437cf8e05d0b@linaro.org>
Date: Fri, 11 Apr 2025 12:15:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-8.0 09/10] hw/virtio: Extract
 vhost_user_ram_slots_max() to vhost-user-target.c
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org,
 Thomas Huth <thuth@redhat.com>
Cc: Greg Kurz <groug@kaod.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Hanna Reitz <hreitz@redhat.com>, Akihiko Odaki <akihiko.odaki@daynix.com>
References: <20221212230517.28872-1-philmd@linaro.org>
 <20221212230517.28872-10-philmd@linaro.org>
 <84b2bcf7-9df7-43e2-83d8-cae9d34ca541@linaro.org>
 <d4ecd6c2-73db-4c28-828c-bfa84ca90084@linaro.org>
 <0edf086b-18f1-4c75-a794-1c957b20bf19@linaro.org>
 <2336ff13-f329-46f5-95b6-e847b012328e@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <2336ff13-f329-46f5-95b6-e847b012328e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 10/4/25 19:29, Pierrick Bouvier wrote:
> On 4/10/25 10:21, Philippe Mathieu-Daudé wrote:
>> On 10/4/25 16:36, Pierrick Bouvier wrote:
>>> On 4/10/25 05:14, Philippe Mathieu-Daudé wrote:
>>>> Hi Pierrick,
>>>>
>>>> On 13/12/22 00:05, Philippe Mathieu-Daudé wrote:
>>>>> The current definition of VHOST_USER_MAX_RAM_SLOTS is
>>>>> target specific. By converting this definition to a runtime
>>>>> vhost_user_ram_slots_max() helper declared in a target
>>>>> specific unit, we can have the rest of vhost-user.c target
>>>>> independent.
>>>>>
>>>>> To avoid variable length array or using the heap to store
>>>>> arrays of vhost_user_ram_slots_max() elements, we simply
>>>>> declare an array of the biggest VHOST_USER_MAX_RAM_SLOTS,
>>>>> and each target uses up to vhost_user_ram_slots_max()
>>>>> elements of it. Ensure arrays are big enough by adding an
>>>>> assertion in vhost_user_init().
>>>>>
>>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>> ---
>>>>> RFC: Should I add VHOST_USER_MAX_RAM_SLOTS to vhost-user.h
>>>>>         or create an internal header for it?
>>>>> ---
>>>>>     hw/virtio/meson.build          |  1 +
>>>>>     hw/virtio/vhost-user-target.c  | 29 +++++++++++++++++++++++++++++
>>>>>     hw/virtio/vhost-user.c         | 26 +++++---------------------
>>>>>     include/hw/virtio/vhost-user.h |  7 +++++++
>>>>>     4 files changed, 42 insertions(+), 21 deletions(-)
>>>>>     create mode 100644 hw/virtio/vhost-user-target.c
>>>>>
>>>>> diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
>>>>> index eb7ee8ea92..bf7e35fa8a 100644
>>>>> --- a/hw/virtio/meson.build
>>>>> +++ b/hw/virtio/meson.build
>>>>> @@ -11,6 +11,7 @@ if have_vhost
>>>>>       specific_virtio_ss.add(files('vhost.c', 'vhost-backend.c',
>>>>> 'vhost-iova-tree.c'))
>>>>>       if have_vhost_user
>>>>>         specific_virtio_ss.add(files('vhost-user.c'))
>>>>> +    specific_virtio_ss.add(files('vhost-user-target.c'))
>>>>>       endif
>>>>>       if have_vhost_vdpa
>>>>>         specific_virtio_ss.add(files('vhost-vdpa.c', 'vhost-shadow-
>>>>> virtqueue.c'))
>>>>> diff --git a/hw/virtio/vhost-user-target.c b/hw/virtio/vhost-user-
>>>>> target.c
>>>>> new file mode 100644
>>>>> index 0000000000..6a0d0f53d0
>>>>> --- /dev/null
>>>>> +++ b/hw/virtio/vhost-user-target.c
>>>>> @@ -0,0 +1,29 @@
>>>>> +/*
>>>>> + * vhost-user target-specific helpers
>>>>> + *
>>>>> + * Copyright (c) 2013 Virtual Open Systems Sarl.
>>>>> + *
>>>>> + * SPDX-License-Identifier: GPL-2.0-or-later
>>>>> + */
>>>>> +
>>>>> +#include "qemu/osdep.h"
>>>>> +#include "hw/virtio/vhost-user.h"
>>>>> +
>>>>> +#if defined(TARGET_X86) || defined(TARGET_X86_64) || \
>>>>> +    defined(TARGET_ARM) || defined(TARGET_ARM_64)
>>>>> +#include "hw/acpi/acpi.h"
>>>>> +#elif defined(TARGET_PPC) || defined(TARGET_PPC64)
>>>>> +#include "hw/ppc/spapr.h"
>>>>> +#endif
>>>>> +
>>>>> +unsigned int vhost_user_ram_slots_max(void)
>>>>> +{
>>>>> +#if defined(TARGET_X86) || defined(TARGET_X86_64) || \
>>>>> +    defined(TARGET_ARM) || defined(TARGET_ARM_64)
>>>>> +    return ACPI_MAX_RAM_SLOTS;
>>>>> +#elif defined(TARGET_PPC) || defined(TARGET_PPC64)
>>>>> +    return SPAPR_MAX_RAM_SLOTS;
>>>>> +#else
>>>>> +    return 512;
>>>>
>>>> Should vhost_user_ram_slots_max be another TargetInfo field?
>>>>
>>>
>>> I don't think so, it would be better to transform the existing function
>>> in something like:
>>>
>>> switch (target_current()) {
>>> case TARGET_X86:
>>> case TARGET_ARM:
>>> case TARGET_X86_64:
>>> case TARGET_ARM_64:
>>>       return ACPI_MAX_RAM_SLOTS;
>>> case TARGET PPC:
>>> case TARGET PPC64:
>>>       return SPAPR_MAX_RAM_SLOTS;
>>> default:
>>>       return 512;
>>> }
>>
>> Clever, I like it, thanks!
> 
> It's a pattern we can reuse in all places where it'll be needed.
> It's better if we keep in TargetInfo only global information, that is 
> used through all the codebase, and not specifics about a given 
> subsystem/device/file.
> 
> By the way, TARGET_ARM_64 is probably TARGET_AARCH64.

Correct, it has been fixed by Akihiko:

commit 744734ccc9eff28394a453de462b2a155f364118
Author: Akihiko Odaki <akihiko.odaki@daynix.com>
Date:   Mon Jan 9 15:31:30 2023 +0900

     vhost-user: Correct a reference of TARGET_AARCH64

     Presumably TARGET_ARM_64 should be a mistake of TARGET_AARCH64.

     Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
     Message-Id: <20230109063130.81296-1-akihiko.odaki@daynix.com>
     Fixes: 27598393a2 ("Lift max memory slots limit imposed by vhost-user")
     Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
     Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
     Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
     Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index d9ce0501b2c..6c79da953b3 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -48,7 +48,7 @@
   * hardware plaform.
   */
  #if defined(TARGET_X86) || defined(TARGET_X86_64) || \
-    defined(TARGET_ARM) || defined(TARGET_ARM_64)
+    defined(TARGET_ARM) || defined(TARGET_AARCH64)
  #include "hw/acpi/acpi.h"
  #define VHOST_USER_MAX_RAM_SLOTS ACPI_MAX_RAM_SLOTS



