Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6560FC87FD3
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 13:35:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukNF5-0004cO-9I; Fri, 08 Aug 2025 09:34:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ukNEs-0004UN-DI
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 09:34:33 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ukNEo-0007Mf-Dw
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 09:34:28 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-458bdde7dedso14957755e9.0
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 06:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754660061; x=1755264861; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=e170LGFXn1rlJaN78yP9eVnF2Ri6sfI7ENjDPoXcdww=;
 b=JBrzi+tPdUK+WVUe97h0gELy7BFXkvwimasT1NXURd4fbO3Ew/ONGipX1T9J8V+d6R
 uCsQwci90/bP8n3Uzz2lCPdr/962J7KoPtcLiriQssK7SM3NWoK4RH3SYRdj/gry9tn3
 v+ZXcyr+a8KyS/SB4gzoBDcFJfQ0nr5YsBxRC8k1lV7AWeI+hNLDCBEM+3qJunw6eyVD
 Aqfcl+zyypDP1pJ9x3KSSA2AxHq34uZDn8+o5xRnD7NOzmXP9xeIh6s0dtjIWbS0reAm
 SYy4OJyTbQbsql05RxcHgl4AuoyJO+phaMz6rrgHs+PC8MWFfRx8eFIZdh8y62XVE4AE
 iF+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754660061; x=1755264861;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e170LGFXn1rlJaN78yP9eVnF2Ri6sfI7ENjDPoXcdww=;
 b=LSlTARO4L6LSj+cBG4LqtXsB+JLd2UJGiyCJaP54csPXSdeEf+mNXev6DNt75pqUQI
 Fkw7/MsVBgqXcAcFgI6taG8wFYAOq/Yy9xZ+EdOwZO3bbcKOxl7Mc/stuQdphwY6HWSm
 KRhygvBRBHlKjg17T/sY2DqpzkNdjNvzgirURdsYDEsDmhmaZdmDuXiofSEktsy8ohLe
 WLvgyZH4eoA3f/tGgq5T8fI1QbleQjsr0PuwOdTFsDsIdaiF6UmyuGXMRomJas9LEozw
 XOFwHO75t6G4xwS04qZ0v6n1oIYIKFYok2Jt7KgV9M3gK/eeaKa7g/g9rmEt05AGcoQp
 sKCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBlKpR3f0TN6arADN/aOQkTkIaeSKLPIX+SGxXSq9q+p1VieWxOnu1JVY0W0V+SBHzF6eY0JTi+0jQ@nongnu.org
X-Gm-Message-State: AOJu0YxqNWRjO6AK8HSbdCAOb6vmGWbz+3K1ae6qgXeWWjbdoL3MS8tx
 BGYs2UpkvUwQIOr01z2d3WVNRkoAgpeC/mg06Mef2K/sqlVucTuMtvaPlRWvA/v/IZQ=
X-Gm-Gg: ASbGnct/xawqoXJnUGiu6T4AJS//7ri3rry0bho3TTdhPt+i3OTdqoEYZpntSAxfwxP
 NZs3X85qirU054G7ETx8NLYBM5XyqDIcOA/A1Xh0iLxgPCO6CAo4oYnmS28zh/j6vaYA+ETQurO
 EpiA2Zshxga8Cf4mTXpAvFP94uKBiru8SGArWcdGwxs/Ioou+UymylGqQ3N+wNe08AL3Gaow407
 4OWcKVBXeBIWlCv5krF/mlA/VWkzFMOE+k5CbPXAmDRt8wR53CIGM2vpDTs5nj+ZfEqPD5xVJgh
 6dEu7zWDAPuqqwOjMNc/Xb33Fe/vvnMS7wekBrmvLFiXYyY/0HRUEC6l9x8Q+6fWIk+iWvVCm/i
 PCTE+DxDWgiEXpbg6tFfC5Ptl1vMYTdNvxVArdovkWqtirF25Ab7EfUBXz8Rv79p1pg==
X-Google-Smtp-Source: AGHT+IFlgYVZCum5aT/6nO/o0heDInm5TgPBGHB6k/QDaa+VzganUxVLOKqrUB0h8/zdixkz4XpnRA==
X-Received: by 2002:a05:6000:144c:b0:3b8:ebfb:4592 with SMTP id
 ffacd0b85a97d-3b900b57347mr2961413f8f.55.1754660060792; 
 Fri, 08 Aug 2025 06:34:20 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e585430csm136220455e9.11.2025.08.08.06.34.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Aug 2025 06:34:19 -0700 (PDT)
Message-ID: <5dc6784f-bbe8-4354-ab8a-4d8e6b0d1f39@linaro.org>
Date: Fri, 8 Aug 2025 15:34:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v2 00/11] hw/sd: Fix SD cards in SPI mode
To: Guenter Roeck <linux@roeck-us.net>
Cc: Michael Tokarev <mjt@tls.msk.ru>, Peter Maydell
 <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Ben Dooks <ben.dooks@codethink.co.uk>, qemu-riscv@nongnu.org,
 qemu-block@nongnu.org, qemu-arm@nongnu.org, Bin Meng <bmeng.cn@gmail.com>
References: <20250804133406.17456-1-philmd@linaro.org>
 <39982478-b3fb-46b0-bef0-c0839c123300@tls.msk.ru>
 <9dc90489-9e74-4e00-8fc6-f97e3f425495@linaro.org>
 <5b2dc427-f0db-4332-a997-fe0c82415acd@roeck-us.net>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <5b2dc427-f0db-4332-a997-fe0c82415acd@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 7/8/25 18:06, Guenter Roeck wrote:
> On Wed, Aug 06, 2025 at 09:22:46AM +0200, Philippe Mathieu-Daudé wrote:
>> On 6/8/25 08:39, Michael Tokarev wrote:
>>
>>> Philippe, do you think this series is something which should
>>> go to stable-10.0 (LTS) branch?  I'm not sure for the impact if
>>> it is not applied, though, - what do we miss in this case?
>>
>> Only 2 machines use a SD card wired over SPI lines:
>>
>> $ git grep '"ssi-sd"'
>> hw/arm/stellaris.c:1302:            sddev = ssi_create_peripheral(bus,
>> "ssi-sd");
>> hw/riscv/sifive_u.c:671:    sd_dev = ssi_create_peripheral(s->soc.spi2.spi,
>> "ssi-sd");
>> hw/sd/ssi-sd.c:70:#define TYPE_SSI_SD "ssi-sd"
>>
>> I don't know them enough to tell if they are that important. This
>> isn't a security problem. The emulation of the transport (SPI) to the
>> SD card being broken, guests can not access the emulated card.
> 
> With 10.1.0-rc2, trying to boot v6.16-11744-g9c389564fa8e on sifive_u, I get:
> 
> [    2.503619] riscv-pmu-sbi: 16 firmware and 18 hardware counters
> [    2.503672] riscv-pmu-sbi: Perf sampling/filtering is not supported as sscof extension is not available
> qemu-system-riscv64: ../hw/sd/ssi-sd.c:160: ssi_sd_transfer: Assertion `s->arglen > 0' failed.
> 
> This is without trying to boot from it. Oddly enough, booting from SD card
> does work.

This was a latent bug, thank you for the report.

I'll post a fix & test ASAP.

Regards,

Phil.


