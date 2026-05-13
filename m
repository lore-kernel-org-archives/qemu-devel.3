Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B55BCD37AC
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 21:31:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNHAe-0003SQ-Ix; Wed, 13 May 2026 17:31:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1wNHAb-0003S0-BK
 for qemu-devel@nongnu.org; Wed, 13 May 2026 17:31:09 -0400
Received: from mail-dy1-x132f.google.com ([2607:f8b0:4864:20::132f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1wNHAZ-0005KM-R3
 for qemu-devel@nongnu.org; Wed, 13 May 2026 17:31:09 -0400
Received: by mail-dy1-x132f.google.com with SMTP id
 5a478bee46e88-2ee1054627bso6002583eec.1
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 14:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778707865; x=1779312665; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=ULBW+dCxKnPEly70htYUJUdNovXU8DPnyG49uQN4O6A=;
 b=ZZukEk+bVfmTvEu9ruwUTSCPJcQsuBNdUJ68pRGk9qrwgEvDzBhYsElcDN4T3+uxrC
 227wwVkRuU/lgYaBGHU7ZRxTGO2e3UoZy7KldPYeuNd6nKyF0032efEoYt8yn+IJpOs9
 QvZ9vElCxdo4VVmnQqEsuirgkyr/vf4Iw4iWP/1EMCL9CjtfUbnZo6hwiYBmDhVJuatD
 5yspDBq7ZCGB+5EGmabP6kCdrwtqAPrTrcfogV3VeODJ8IKemX7aSe2QCszwoscbViBz
 m0BwLOlLBvarA97fSsHaalQLE2KotS+8IYdeeC+T7jSsvzZrrYQpA8kwwXn5ndmSOdNC
 SuYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778707865; x=1779312665;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ULBW+dCxKnPEly70htYUJUdNovXU8DPnyG49uQN4O6A=;
 b=g7VeEqyutLa+54Re2Jo1igITxyVSHsGbd9f7Bskqlyabm6FXn+HINHqPoRhXikJ4nG
 Bndz2zJ7TZX4uI2SfB5XKzVksZ60XbKJsjrxrTnYfNhzLglyL/eiaqBXzfC49PyF424T
 D9c3t2hPSIMEhFZ8YpGUuS2PWU5melo+Jn3DCXfpCDxT3xDR2jsk9oMf+4442hUoIqll
 cgGP4/JDREEAb8dZdGJC/0fDlxAV7MwKy5JhYDVoyWgubzHCYrv4MOV5u22c1JMm2OmO
 A7WyvX59xPpFinc+t8cG2zs9/kDwE2wF+hTGb73127GOJTbb9uQ7PP1AtrvoMkHJXj+U
 l6lg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/fxopDnQpuwkSly+sRGsDPSk/x9fFADrOnu809Zj2ZN3c3rkv1LieIv9dIX+jxxfVStvZDWS70oA2X@nongnu.org
X-Gm-Message-State: AOJu0YwAjVhLwfZP4QRLrho+yUgDHKKH0HAnWnxIZJqcrHe0vrZMcqIG
 ZTnotDcHemA6po7aP952WGqA4jiz75TMj8yMEda8tAFp2KF5Dr7Gyrbw
X-Gm-Gg: Acq92OG02G/jfscuNleQXUkUTNgag+pvSfHRc4Wq+povbbnLwkeysusiR9D8qOIB198
 tmEPb15mTm695gIUMEHdbkRUpCCGEWJ+bmFjbIamg88An2PYkytU3LBeeLQE4wz74Vh/4ZYTRgn
 vrnzU4lkWctbqKkobEVlgjfwgR6OWOJ7W8HcgXH1UzfHLB8zMhQwHvQdJMf1xfp3U0i0Kenzolm
 kpP+CpYjn7SoDT+JjVK+XESOIDf6+xvFrpyW5S3n473axaYgmFkRkEl3fFjBsMNqwj5Gn9XNgz/
 z0q37mMSIgS3asgjpYEYrbjAGdtEHrzJOw/uE/wD26loU5U9UR6J1Qxq0fV0xAb9vrEWm0wC6sx
 Dzj+X/a0/upWIrt5JzYd0i1LPEjpJYfeC/YC+3COV6T8yAv8G4qBbJ7nUyRPn7AsNW6AA+7eFIv
 028mFgwcqZA2mzhmFBW0XeLuuf0suCZntmnu90XJnMxEstjMTiOxouSphyaQI6SN3PncUfaVjM
X-Received: by 2002:a05:7301:1691:b0:2d9:db50:c6ce with SMTP id
 5a478bee46e88-3025eca19b2mr753386eec.3.1778707864958; 
 Wed, 13 May 2026 14:31:04 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5?
 ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-302978b3cb2sm754608eec.30.2026.05.13.14.31.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 May 2026 14:31:04 -0700 (PDT)
Message-ID: <688ddccd-d52d-46bf-b619-10f8fa41c80a@roeck-us.net>
Date: Wed, 13 May 2026 14:31:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Mark Microchip PolarFire SoC as Odd Fixes
To: Conor Dooley <conor@kernel.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: alistair23@gmail.com, palmer@dabbelt.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 sebastian.huber@embedded-brains.de,
 Alistair Francis <alistair.francis@wdc.com>
References: <20260513023859.518484-1-alistair.francis@wdc.com>
 <82b83672-24b9-40d1-9a19-89fd64c0606f@linaro.org>
 <20260513-pampers-threaten-2a71df36e314@spud>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260513-pampers-threaten-2a71df36e314@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132f;
 envelope-from=groeck7@gmail.com; helo=mail-dy1-x132f.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 5/13/26 14:26, Conor Dooley wrote:
> On Wed, May 13, 2026 at 08:10:06AM +0200, Philippe Mathieu-Daudé wrote:
>> On 13/5/26 04:38, alistair23@gmail.com wrote:
>>> From: Alistair Francis <alistair.francis@wdc.com>
>>>
>>> Mark the "Microchip PolarFire SoC Icicle Kit" as Odd Fixes and enlist
>>> Conor and Sebastian as people to help deal with the fixes.
>>>
>>> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>>> ---
>>> Conor let me know if it should be a different address
>>>
>>>    MAINTAINERS | 4 +++-
>>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 952ed683bb..9626eb1ea9 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -1751,8 +1751,10 @@ F: target/riscv/xlrbr.decode
>>>    F: tests/tcg/riscv64/test-crc32.S
>>>    Microchip PolarFire SoC Icicle Kit
>>> +M: Conor Dooley <conor@kernel.org>
>>> +M: Sebastian Huber <sebastian.huber@embedded-brains.de>
>>
>> Maybe worth having a look at Guenter's following patch for this
>> machine:
>> https://github.com/groeck/qemu/commit/1a66d5b4e5fe9
> 
> Ye, I can do that. It looks mostly pretty sane, but needs a bit of
> cleanup I think before it is really applicable.
> 
> Does it matter if the rates the PLLs report are accurate btw? Since
> everything here is emulated, it shouldn't matter if the PLLs run say all
> at 100 MHz instead of one at 100 and one at 40, right? They're just used
> to clock things like i2c or pwm controllers.


I for my part have no idea, sorry. My only goal was to get rid of the
stack backtraces. I did not explore further.

Guenter


