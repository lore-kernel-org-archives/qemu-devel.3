Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F039AC25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 13:42:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6Vvx-0008GQ-Eg; Mon, 13 May 2024 09:41:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s6Vvv-0008GH-WC
 for qemu-devel@nongnu.org; Mon, 13 May 2024 09:41:40 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s6Vvl-0000Hf-0A
 for qemu-devel@nongnu.org; Mon, 13 May 2024 09:41:39 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4201986d60aso4265145e9.3
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 06:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715607687; x=1716212487; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LTcvkcGoJa9SjRoiZfIOFpHNX+KWpDkP1lMhvhEzBno=;
 b=EwyQ/Xdef1OPyyLZ+cLMbP8ihD+G9GO0QDppWrnIOi5S7FI+ZcBK2OoysyewBSIAK9
 l0bRekT02wleY8v1WehHQwBcO1EkZjDmAU8JbSq1fUBh8Tp9JR5g+4qBS3HIrYNxkiHC
 YkyZEXcgEzLrIOZK6cPeJ/+eG1oVtJrnNFU2DxQrAEljwCkGxhDQKqyUW80ugKtuw3Ic
 lP0gvLECoeeGzx/RRscRDVj3gTLjeXsnzaSZ9RyXdYUvLcTPiM1B3zoT9yznmQrv3lir
 mjkfKzQU2T9jMUCDo9xlNx5wa309Ju1uyCKwuzHvDXr7TIkih4bnh2iqbfEYwlsuRIVR
 i5XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715607687; x=1716212487;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LTcvkcGoJa9SjRoiZfIOFpHNX+KWpDkP1lMhvhEzBno=;
 b=BqalfekKvTpDLMPBEWn2kWwQv/KC676+sDvXjix8qrIJdjFm64CDTfM/1CAKJFBrxF
 MDxH5dj+pYIGfD1olG+TTyUhRR0D1DX+qOe7yM5HF5jr6wCSoxDMVDsax2o720ASKyTK
 0XD9ZD9YgttCLpUtIlPxbmduNhcAhzWRbFQZ6lSZBlsG2OW4FiEFotiNiotA/UlS3MaS
 c7oYiQOWqPAsa/rBrSy9tmWwH7X07gnxyMgNKErQ0BYv4NKPS8aDIfRx3hpLnnZGO3YC
 d2ZDYQnCD/eL+zHAycHdNMUKQzzGXRbwbIgFlsNo/qfHq+cDarWGodAI4HqL5yTbNqfB
 iyUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5v/6bFzvPJ+aAMogDBPE6c0paeNZRMAFkSbRDM4Kb2vq1Zygqq8O0cTA7jwGv+DAlDWymIjuOv+HMzk7pGMdac6o0V7g=
X-Gm-Message-State: AOJu0Yy/Vdbf8K5z6eCakXQ5cfQJoai3a+UZfyfRPVm8mG/0scc/2xqK
 cdfl/cDP6dR4FhTYwWsdRacVh5H8BoFWm3Rb4nv8s27ISESoNAy4kjx/yff7RP0=
X-Google-Smtp-Source: AGHT+IEk0gT2dflxktTrBR5c5A1CItAo4MUSAmD0PEDdyIY+0YNEnBCVGdCyVlVTpsQ0OugDZCuoHA==
X-Received: by 2002:a05:600c:4f04:b0:420:139e:9eda with SMTP id
 5b1f17b1804b1-420139ea0c7mr31495905e9.12.1715607686728; 
 Mon, 13 May 2024 06:41:26 -0700 (PDT)
Received: from [10.1.2.72] ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccbe9080sm159947225e9.5.2024.05.13.06.41.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 May 2024 06:41:26 -0700 (PDT)
Message-ID: <dfd1df94-0d6b-4e44-a392-e1e5fc382955@linaro.org>
Date: Mon, 13 May 2024 15:41:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] hw/arm: Connect OTP device to BCM2835
To: Rayhan Faizel <rayhan.faizel@gmail.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
References: <20240510141010.656561-1-rayhan.faizel@gmail.com>
 <20240510141010.656561-3-rayhan.faizel@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240510141010.656561-3-rayhan.faizel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Hi Rayhan,

On 10/5/24 16:10, Rayhan Faizel wrote:
> Signed-off-by: Rayhan Faizel <rayhan.faizel@gmail.com>
> ---
>   hw/arm/bcm2835_peripherals.c         | 13 ++++++++++++-
>   include/hw/arm/bcm2835_peripherals.h |  3 ++-
>   2 files changed, 14 insertions(+), 2 deletions(-)


> @@ -500,7 +512,6 @@ void bcm_soc_peripherals_common_realize(DeviceState *dev, Error **errp)
>       create_unimp(s, &s->i2s, "bcm2835-i2s", I2S_OFFSET, 0x100);
>       create_unimp(s, &s->smi, "bcm2835-smi", SMI_OFFSET, 0x100);
>       create_unimp(s, &s->bscsl, "bcm2835-spis", BSC_SL_OFFSET, 0x100);
> -    create_unimp(s, &s->otp, "bcm2835-otp", OTP_OFFSET, 0x80);

Maybe worth noting in the description, before we were covering a range
of 0x80 and now 0x28, so a range of 0x58 I/O ends in RAM. Maybe better
keep a region of 0x80 in the previous patch?

Flatview diff:

(qemu) info mtree -f
FlatView #0
  AS "memory", root: system
  Root memory region: system
   0000000000000000-000000003f002fff (prio 0, ram): ram
   ...
- 000000003f20f000-000000003f20f07f (prio -1000, i/o): bcm2835-otp
- 000000003f20f080-000000003f211fff (prio 0, ram): ram @000000003f20f080
+ 000000003f20f000-000000003f20f027 (prio 0, i/o): bcm2835-otp
+ 000000003f20f028-000000003f211fff (prio 0, ram): ram @000000003f20f028

FlatView #3
  Root memory region: bcm2835-gpu
   0000000000000000-000000003fffffff (prio 0, ram): ram
   0000000040000000-000000007e002fff (prio 0, ram): ram
   ...
- 000000007e20f000-000000007e20f07f (prio -1000, i/o): bcm2835-otp
- 000000007e20f080-000000007e211fff (prio 0, ram): ram @000000003e20f080
+ 000000007e20f000-000000007e20f027 (prio 0, i/o): bcm2835-otp
+ 000000007e20f028-000000007e211fff (prio 0, ram): ram @000000003e20f028

>       create_unimp(s, &s->dbus, "bcm2835-dbus", DBUS_OFFSET, 0x8000);
>       create_unimp(s, &s->ave0, "bcm2835-ave0", AVE0_OFFSET, 0x8000);
>       create_unimp(s, &s->v3d, "bcm2835-v3d", V3D_OFFSET, 0x1000);

