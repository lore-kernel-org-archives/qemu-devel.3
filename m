Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65E08CD342F
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 07:32:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKAGA-0001Z3-MN; Tue, 05 May 2026 03:32:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKAG7-0001YV-QC
 for qemu-devel@nongnu.org; Tue, 05 May 2026 03:31:59 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKAG5-0002lh-O9
 for qemu-devel@nongnu.org; Tue, 05 May 2026 03:31:59 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4891f625344so52288525e9.0
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 00:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777966316; x=1778571116; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AyGvDiK8C3VN4oQOh+QeSnI4chszrUjjtLY5pVFdIIE=;
 b=JpdyFkkdanzJpu6toGJEGzYULhePDXm7EQdc2XNfQ90Ct4gvkuZc9yr8jg0Kcat1Mq
 bxqAUzebadPODLp8QF2uVSSLGlIi8mKwUhjxcbEcJHuJsvB6qBbPcHoWe1mHFHD1xXq+
 mtU/K65E5pJssRlGQvS7u/KvjPDe9m9ghuHD9OJHsEIgbN1NAJ5z9d99NYIy9gHyYXgy
 Kg2x3D10prWSANv+7lI2DCjeNHQRjwVbAli5R8cVvsHU/lofNpjy9mwev+pspayGgUeg
 0x3MHZiZxmvNHzoFEMZD1D9mLZCcpu9q4QpkW0mRFrs3QbJHD+eka5I+1maX3YNOTEAv
 xBww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777966316; x=1778571116;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AyGvDiK8C3VN4oQOh+QeSnI4chszrUjjtLY5pVFdIIE=;
 b=Mjj2+kwZmwSGHqHQtmlBbqWNl0WpS7V5DWlImTsdFg6847ioXLotCkynWoTgLjOO54
 2u3vpRQ70+TrpD35frQpD1hEBj3hI4w9oKlnu/+omsZnAYJl1cIENtf0WYz1joTmj2Ze
 wM7NNGiFe1hHNNZHwMV3n6TSd8sOCezo3wntvtWyUb+i4WhjK2HS6RIJYnga+0diiyFL
 Vk7LXSjL9fx/Y13n/5pTvuAemXK/viKR3APVbuCtGJaG9jbn7B+ZxiY6uTioeujBo11r
 SUVf+ccpPxno0cA42nlnoA9bxefTOoTgAAPtTHmbmKss/JKsGW6z0q+6Tw2pnsa1XvZf
 ewyA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+vIn94oZ5dRdyhjM+25qVWAJLKqo+Jdj1/5s6inWijxWVOFBIFyNZs8eeQcNA0saZnNUJFS9aXJuq+@nongnu.org
X-Gm-Message-State: AOJu0YyI7UE/MGetOVhWx7VVUuNrZvlxCJF7ehSm+XgtHQ8CiH9NjL7j
 4s1oWegFxi4+Goq8kzfTHTriYTzURmIIFQfVecwiTu3NXjGKOeLxBGxON5ve5UB0DfM=
X-Gm-Gg: AeBDietUZmmRrxEkAg/k6iI+Oe7Fw47QIfVoQ8vZIXjBWaVz/rFBoFbs+JpCqExrFi1
 AbHFjDehzyXQOHsQSj6/XT6XXYuCc7K5CfHKFA/iF4KU3KgTi3FFNKNlbppui8xxkEYCSIy7c/K
 qgKz3s8rOn8Uz7YgmtS1pfBsdfsvtVxm8/tyCRSrdrR9Os9nYmgJ3a5zq8wNIbndNj5ENIS+1DC
 TqXce1lRPz5k1+l3uylRXJEuSaKBuToBfbqwPjo0SxPyFApbmQ7i3Yu5QGbt/lX5fQFp/nXTyP+
 75rSVwnMkLpg4x8I2NhM4uqyIvmJgnsFtm1K2cOowGcTATS6V0gkAnfuYEnwSNeBL10G/UQQfsN
 DmCMlLDZ5wTmgJhzmnx56fhzuwd1yQiWUkq4BDNPFt9l9vvEXwCZ32ImoTMp1qVJ0LMkMiF08JH
 SlnaRK/wz6tqxKz6dKlde4YpGAnRxBSBn4ZLjtgSmytmJU9DRS8pOzQpeGYPERX4cuJChNuMph4
 8bo
X-Received: by 2002:a05:600c:2d07:b0:489:1927:5c0 with SMTP id
 5b1f17b1804b1-48d155750ffmr18388335e9.0.1777966315576; 
 Tue, 05 May 2026 00:31:55 -0700 (PDT)
Received: from [10.115.35.66] (95.170.88.92.rev.sfr.net. [92.88.170.95])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45054b02f76sm2307813f8f.23.2026.05.05.00.31.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 May 2026 00:31:54 -0700 (PDT)
Message-ID: <8a145950-399d-4c74-81e6-3b889d430fd4@linaro.org>
Date: Tue, 5 May 2026 09:31:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/13] hw/riscv: Add Tenstorrent Atlantis machine
To: Nicholas Piggin <npiggin@gmail.com>,
 Alistair Francis <alistair23@gmail.com>
Cc: Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Michael Ellerman <mpe@kernel.org>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
References: <20260425131721.932250-1-joel@jms.id.au>
 <20260425131721.932250-10-joel@jms.id.au>
 <CAKmqyKMLwO2uRnzrke+RkCZmdOJPs3Ouyoe=UeuAWnRgitAD8A@mail.gmail.com>
 <afk0kVtQGz7OZ65_@lima-default>
 <CAKmqyKMbWXFBSuiKyp1uQ5TBhFAEex961Jzp4To5uyBzuUGMBQ@mail.gmail.com>
 <afl6x1CTIx2jvMH0@lima-default>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <afl6x1CTIx2jvMH0@lima-default>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 5/5/26 08:00, Nicholas Piggin wrote:
> On Tue, May 05, 2026 at 02:34:50PM +1000, Alistair Francis wrote:
>> On Tue, May 5, 2026 at 11:04 AM Nicholas Piggin <npiggin@gmail.com> wrote:
>>>
>>> On Thu, Apr 30, 2026 at 09:57:34AM +1000, Alistair Francis wrote:
>>>> On Sat, Apr 25, 2026 at 11:20 PM Joel Stanley <joel@jms.id.au> wrote:
>>>>>
>>>>> The Tenstorrent Atlantis platform is a collaboration between Tenstorrent
>>>>> and CoreLab Technology. It is based on the Atlantis SoC, which includes
>>>>> the Ascalon-X CPU and other IP from Tenstorrent and CoreLab Technology.
>>>>
>>>> Can you provide a link to documentation
>>>
>>> Also not presently.
>>
>> Hmmm... That's a bit annoying. Can we get some?

That would be nice of course. I didn't mind while reviewing because both
documentation and functional test are provided.

> That's the plan but I don't have a date I can give you for it, sorry.
> 
> [...]

