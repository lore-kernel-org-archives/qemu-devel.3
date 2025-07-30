Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9B67C87FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 12:59:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uh6Nw-0002Em-HN; Wed, 30 Jul 2025 08:58:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uh5Lr-0000OA-QP
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 07:52:07 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uh5Lp-0008Os-4V
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 07:52:07 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4561ed868b5so43506005e9.0
 for <qemu-devel@nongnu.org>; Wed, 30 Jul 2025 04:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753876322; x=1754481122; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mJRaYo+CstUt1ued8nrCI6seZFOkY1o7cNcrElj1JRU=;
 b=l4kPXwEpDoS5FoNUR/5rD9clIvWlcKNjXducKCFs1Rr6KkGlMHDl/7SSrpnYpcEnz0
 zgl9Ys+Q1R/lEMMnk+kVKH70ArYSvo2ypqaeLU2sKsIaqnitlqGnCGl7HPx1ExCg9Qbl
 RxJIq3I1af5U5N3UFQEo7uQy8kwxc5/KN2W16O3rHxsn2YFrGGDSwB5xe4j9cm/MuFxO
 jESoOMvhOrsdcav11ENAzq/eT5uqn4HCepCMmab8MSAYLiAW3Dlmxy1irZ6K0XovEg+g
 tfvy+SHakkUyOBU9b4xKQqXBHZ0kCQHPvddHmWH9cDYZbBiIgT06N5epmDWjb8L/ikdI
 jf9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753876322; x=1754481122;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mJRaYo+CstUt1ued8nrCI6seZFOkY1o7cNcrElj1JRU=;
 b=pAcruAzVG5thtKyuOnemmU8nxxfYjoHiact34pq/oTFwswT8YcCDnvGv8CIggmI/nC
 gFdrB2G5C49fo410WDvnZjUgvJYl/oXCyZLMj6SRtddfO2XJMN9Fz3IvXtKbVVoH+AHk
 u4gE292M6eJBwIroL/l0SZPQILzW6VwiwW5epIc3bZlDaV0evGIpm4NjsBsxQ7YWJqW3
 1PVUVZCQGnDrZneqP3WSJSvxQvjZv0Ia8dn1+Nn2B7f82Nui/f3CA4vBSVQvZs/nrCDl
 P44627y9sTlNyeQlBPJQckzKBVpiXLu7pV2nf7mxVxuv0G/2nMj80IkG57Xb3VzhPpHn
 3lTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxSOhX2ke8IYR8lCTJ2suxFPI0JO8ta2k4sYBsD0sHY7Fsij9ngsGO2PTffVMIpVLyjFG6qwfUdLMJ@nongnu.org
X-Gm-Message-State: AOJu0YzsjQ+elRnIRQYz+2yfJ1ywBTVWCbbCqQNW43RCRV+V58RnzUOm
 j1MkwDiV51Z/arEUjMe04VLj1N3CQ1zJvkYGP3NwdbCC5IrHioHi+G2h+SpGbyKJm8Y=
X-Gm-Gg: ASbGncsYkU8Yux7DJg+no0sL2B6vE6El8aBsRuGeN3SZ0p+Ohoc/8+uvc31PAsFHjI/
 TUqK/9Da6/f7eL3zPdQu2nTpG+tQrGWKfl8Yvc3eyMIKqpWVusG9tHynwDbEQyekBddmehJO0EX
 IulL1yTf6DfYRp9fNNbhWS37JqiEPc70ZawZfHao3drRC985iATNYTSXgjyNnqI3cHviRioBtJp
 YCBYRcc2FhtVB688pjfjACeA2mFooInKhmvH2pGAz1mcaPh2xv0bDWCapus5R1+FNCmcS78+wBH
 ZYENpDJEOxVKb+MpfYS3/D2/tm5BJCUKxix+kCdChmb5OwQv8YY27ricbGFa9JVSg7g/uHf0Ovv
 MZURLOYKUYiY3AT7u1J41IY2ohXWobefchBWMWujuZ2r7AK4tszFFoPQtqjcni3vsjg==
X-Google-Smtp-Source: AGHT+IENcnAx7s5rYFj39bQJJ0Jg7ZtRYKdIrqUI/vxghbiarTKgjMzd0Mb23FeekCPW+fGwAGhdig==
X-Received: by 2002:adf:f54f:0:b0:3b7:98bc:b856 with SMTP id
 ffacd0b85a97d-3b798bcba71mr630607f8f.41.1753876321868; 
 Wed, 30 Jul 2025 04:52:01 -0700 (PDT)
Received: from [192.168.69.209] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b783454d65sm12614041f8f.1.2025.07.30.04.52.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Jul 2025 04:52:01 -0700 (PDT)
Message-ID: <5fb23498-7ecc-4f8a-856b-33a39709de35@linaro.org>
Date: Wed, 30 Jul 2025 13:52:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] pc-bios: Update vbootrom images
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, Peter Maydell
 <peter.maydell@linaro.org>, Hao Wu <wuhaotsh@google.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>
References: <20250730045813.822132-1-clg@redhat.com>
 <676fc03e-df95-4287-b954-af1cc1f5737d@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <676fc03e-df95-4287-b954-af1cc1f5737d@redhat.com>
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

Hi Cédric,

On 30/7/25 08:39, Cédric Le Goater wrote:
> Philippe,
> 
> On 7/30/25 06:58, Cédric Le Goater wrote:
>> Hello !
>>
>> Michael provided changes to fix the build of the vbootrom image of the
>> AST2700 SoC machine in [1]. However, a workaound in roms/Makefile was
>> still necessary to build ast27x0_bootrom.bin correctly. This was later
>> fixed in [2].
>>
>> This series is an update of [1] including a vbootrom image matching
>> the new commits.
>>
>> Thanks,
>> C.
>>
>> [1] https://lore.kernel.org/qemu- 
>> devel/2a89ad4c8f5665d07952a4f1749caa6ec0cd3d9c.1753654515.git.mjt@tls.msk.ru/
>> [2] https://github.com/google/vbootrom/ 
>> commit/7b1eb5f7fe6a85a03a1e40aa703a6ebbdb644e31
>>
>>
>> Changes in v3:
>>
>>   - Updated commit log in patch 3/3
>>
>> Changes in v2:
>>
>>   - Updated all vbootrom images
>>
>> Cédric Le Goater (1):
>>    pc-bios: Update vbootrom image to commit 183c9ff8056b
>>
>> Michael Tokarev (2):
>>    roms/vbootrom: update to 7b1eb5f7fe6a
>>    roms/Makefile: build ast27x0_bootrom
>>
>>   pc-bios/ast27x0_bootrom.bin | Bin 15552 -> 16408 bytes
>>   pc-bios/npcm7xx_bootrom.bin | Bin 768 -> 672 bytes
>>   pc-bios/npcm8xx_bootrom.bin | Bin 608 -> 672 bytes
>>   roms/Makefile               |   5 +++++
>>   roms/vbootrom               |   2 +-
>>   5 files changed, 6 insertions(+), 1 deletion(-)
>>
> 
> is pc-bios your juridiction ?

AFAICT pc-bios/ is nobody's juridiction =) I'm OK to merge generic
buildsys patches to help, but in that case I think that belongs to
Peter (ARM) or you (Aspeed), because I don't have an as
thoughtful test suite as you both do.

That said, if you don't have other PR pending and provide your
Ack-by tag, I can include them in my next PR (I likely will to
post one to fix a pair of SD card issues) -- but I expect Peter
to also have one...

> 
> I think we should pull these changes in for QEMU 10.1.

No objection!

Regards,

Phil.

