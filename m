Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FE7AD15D96
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 14:03:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2szh-0004eS-3J; Mon, 21 Oct 2024 10:02:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1t2sze-0004dc-Gx; Mon, 21 Oct 2024 10:02:46 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1t2szc-00051T-K4; Mon, 21 Oct 2024 10:02:46 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-7eae96e6624so903105a12.2; 
 Mon, 21 Oct 2024 07:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729519363; x=1730124163; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=RG4IemUhwjFijUUM58Rm3MXy4OzzjPVniYRcFoJOMTo=;
 b=KHO1BVL9JuN8YqdjNFBchFGiuoLfQBvEQ4I9LtrgCM81uMJ8O4nmMCn9Yn7Pf9fhVA
 4oVuqwlxj6dyEDwL+Wy6FDL77Zim7c59huIQf/3t82igXqSDWIdcyL/AIx8FHFloDPbP
 mQGhNufy4a8NBAaemqWgX14b0wbOMJ1ZicxTNpOQDQ1SigdQDp0le2nVCjHm9FNSJVT5
 naXmvbqEbKp130NwBTjkqrMCvbQhEgYHofY3QKhI/9ofGO82LaODKV9jW8bvCKFodiab
 rdc2mblFYhjX82GtxS3ovfo/1327LYYsvz1ftLNnHoFmn/eGANGSGov6uBm9dmL/g4mD
 ivxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729519363; x=1730124163;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RG4IemUhwjFijUUM58Rm3MXy4OzzjPVniYRcFoJOMTo=;
 b=migGA9o2o8xkMsjtnfegrn0s3FHUTZTGgkjor/8jtd/GwmY2Iti4StngNJSf5+nFoB
 3AwNMBlHprU4rND0t7QFFeqwFDGhZl3kc5rw3yEvbDavOU9I9NIQky0q72JKzNlJtXES
 7bO67jeQ9M179UwboQf2ncC5I90p6Rv+KqrBjdkY5suixvYC7FVE6LZ4h+YZaHzeezLg
 hCmW111Vrj87uES4AZ8yIoDCj2zJ62TLEr99ysPI+CTDFPAje9qS1IiDEl19dD41ULCh
 0fn1jHPEZk6fY+JmhYN3vxGpSSqheyvY0j1100JkEuDgYFJTjgz9Wvzc8/4SzWqzmss1
 Beig==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnA5zEdk7QYhn/EFB6k4D+/FK1A8wdqLrYDNqRhXQTo7FshAAW5fJd9FnkecgLP783AbcI3hbfjtRj@nongnu.org
X-Gm-Message-State: AOJu0YzmrmpNZ5ql/MkGSZOs1zZ+XR69YGubuVH7wDNVwmChxADb0ZhE
 Xbf3veptaKoI/R+Iz6U075TMRvG+OL82uR0mkJKd04nbh5zrSwh5ZxrSUg==
X-Google-Smtp-Source: AGHT+IFkpZBGEDd/MV4pyCEPVQ800A4oz+I9ThaXJQOFjid6tgFk/3FyjfCWBaV1nXvayJawTYhEAA==
X-Received: by 2002:a05:6a21:164a:b0:1d6:e6b1:120f with SMTP id
 adf61e73a8af0-1d92c4dffb5mr16764986637.11.1729519362309; 
 Mon, 21 Oct 2024 07:02:42 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c?
 ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71ec13334f7sm2890494b3a.77.2024.10.21.07.02.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2024 07:02:41 -0700 (PDT)
Message-ID: <a65a224e-4f54-436d-b555-734a8926d941@roeck-us.net>
Date: Mon, 21 Oct 2024 07:02:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] arm: Add collie and sx functional tests
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20241017163247.711244-1-peter.maydell@linaro.org>
 <dcf06645-dac0-4099-8946-38ca9deaeccf@redhat.com>
 <ec2cb5e8-77be-435e-8aa7-4314cf412c4d@redhat.com>
 <CAFEAcA8MY8DWABNuYuzH57k-nv3J4s0eMR=FuRt1TVd8P2GU2g@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <CAFEAcA8MY8DWABNuYuzH57k-nv3J4s0eMR=FuRt1TVd8P2GU2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=groeck7@gmail.com; helo=mail-pg1-x536.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.171, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 10/21/24 02:17, Peter Maydell wrote:
> On Mon, 21 Oct 2024 at 09:01, Thomas Huth <thuth@redhat.com> wrote:
>>
>> On 21/10/2024 09.15, Thomas Huth wrote:
>>> On 17/10/2024 18.32, Peter Maydell wrote:
>>>> This patchset adds new functional tests for the collie and sx1
>>>> boards, which are the only remaining ones that survived the
>>>> culling of the OMAP/PXA2xx/strongarm machines.
>>>>
>>>> For these tests I'm indebted to Guenter Roeck, who has kindly
>>>> built and made available the kernel images, rootfs, etc and
>>>> documented the commands needed to boot them. All I've done
>>>> here is wrap those up into test cases in our testcase
>>>> framework by cribbing from some of our existing test code.
>>>>
>>>> Based-on: 20241017162755.710698-1-peter.maydell@linaro.org
>>>> ("hw/sd/omap_mmc: Don't use sd_cmd_type_t")
>>>>    -- the sd card test for the sx1 board will not pass without
>>>>       that bugfix
>>>>
>>>> thanks
>>>> -- PMM
>>>>
>>>> Peter Maydell (2):
>>>>     tests/functional: Add a functional test for the collie board
>>>>     tests/functional: Add a functional test for the sx1 board
>>>>
>>>>    MAINTAINERS                         |  1 +
>>>>    tests/functional/meson.build        |  3 ++
>>>>    tests/functional/test_arm_collie.py | 31 +++++++++++++
>>>>    tests/functional/test_arm_sx1.py    | 72 +++++++++++++++++++++++++++++
>>>>    4 files changed, 107 insertions(+)
>>>>    create mode 100755 tests/functional/test_arm_collie.py
>>>>    create mode 100755 tests/functional/test_arm_sx1.py
>>>
>>> Thanks, I'll queue the patches [...]
>>
>> Unfortunately, the test_arm_sx1.SX1Test.test_arm_sx1_sd test is not working
>> for me, it seems to fail the shutdown of the QEMU binary:
> 
> The interesting information will be in the guest console
> log, which seems to not be in this log. But the first
> question is "did you include the omap_mmc fix that the
> cover letter and patch description says is a prerequisite"? :-)
> 

Unrelated to this, but I found that the sd emulation in 9.1 is also broken
for loongarch and sifive_u, and partially for ast2600-evb (it has two
controllers, with one of them no longer working). That is too much for me
to track down quickly, so this is just a heads-up.

Guenter


