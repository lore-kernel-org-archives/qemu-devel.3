Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45174606A31A
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 01:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=pW9Hyaqa
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNKHI-0000SR-8N; Sat, 31 Oct 2026 21:22:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xNKGu-0000Ph-1T
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 21:22:09 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xNKGs-0008AW-B0
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 21:22:07 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-8a07078200fso725542b3a.2
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2026 18:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793496124; x=1794100924; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cHqm3+TeWj+8hzvxCLGPdnSK1V8BMMlAVyJoZ3/5zAc=;
 b=pW9HyaqaDJye/D/CH6kdM7/JMvA6+qa7JuUu4RBg6WK5dsC6zFRK1KpG55aP0E0zqq
 nNYxpDP1dusvpavMMwdgI6CMq10la5qE8xgmGoSol+ciJAgNH3Bws2TLNTOvtvni3haD
 d2+BKsLbn10/RFO23bDcUZ6KD2Zt9hBhhBA5IKb0adTjYLFFqCkoobJGwED9WNzW6T5f
 YIs0iupd1HRocguEaogD+5ByS7GXE16Wu54fEji5YWyBf0r67PumpHUe7qoZaeoDC1YJ
 0ecIUMYwACBNcWwogc/QjAvVZEN6ZxBQ/NUaAr3A29VZGRxza4bdrIl6o0gb04toz621
 DZNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793496124; x=1794100924;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=cHqm3+TeWj+8hzvxCLGPdnSK1V8BMMlAVyJoZ3/5zAc=;
 b=u6ARsy7VMPx7OX6InOa8UCRru30Zmeoy4q4tNz4dnKpsLBnLaum0b4phb344PyemUr
 Wz9FZRqtcZtkewzXG5iv8moOPOcI9O1snAa/0jLOnJQuzdZ+dEqwE1Rjsa5jhuC2ANHj
 Ibl8d+1j6prSkZwO8iFBK7HTTkxmy8RaFOdBIod7W4KwMA1BIsPFNlKLSuL1N3ZvnGju
 eloBJF3st0NKi5vWTJDClntuGSJTAXUQJ56Gd11PRSdGb82eXZ8d3sqX5rT/PTsjtDfe
 sC1Fi7yRkvdYys6LY6ljledsnbAHuTfTODS6aCW7bDPJC1PCJX2Lz6eWaJGkuLvVhOvk
 V5Tw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxKV+jj9rjrcLE+YywAm8zIgAx2RFk1Y/NzeHGsmRzcOfu7AAZsO4epN4TNMoErTnncGLJzGgUoQDZw@nongnu.org
X-Gm-Message-State: AFq9FYKf/msXIQWq8jaGzSabw5yfFG5rkOKN1wjVq1rCy97gYJZ6GaBb
 yrb5K9lHFn9MQG+xi1xJygmm+T+jvTm9jVL6EqZqNZLIkbWt+3NQX0R/noX2230uTZ8=
X-Gm-Gg: AYBFou1x8jKYjwC115M72rLT+AG2BuZJ+aB8vfTno59AhKho/8MazrVMXH9C6rhSSHy
 ODyrNNfwsdkseKkks1wdmlB/xE1dOrEcX1jEkt9Rjfu8RaUg5hn9cfkXq1UrsnZmaMoc9/sLe8/
 Go5qrsC9VHw9hS7lGmCa/1SOuZzNNiy+aJ4wSu00s50iL1ufgTb/FvqwSsItJ2hyAgX+4iGZXH9
 AI0AH8CWJ7Rz7Ph6Yxt3ywU9nFXJUwJGjivO3+XH2G76WNlvRTOSw8HxUgwK3n4HSnRmRacyrGj
 NNRTxJhIfqT+HKHklRNRU/nq+mWzD7QXcBkVDM14b3Powolo6sXeadEaFOWzg3iXy4KCP1+ThxZ
 QzOm5HLGgZtkhojeR00LyBxhvfOMSn07GwQCyeJUi3L0iROsQQ43LKz+7O5DUwvjj1fHHwVG5ph
 09qhMy4vbuIHJNAh3v9wa22yOamaowYohpwPN08EjR5x4y5wyECpnrtow3IrNcO5cnU4w5UIaft
 rAxpV2o1qGsJ62Cosj2SQl7gVWSIIGU41onKX0IkWj2i2AzrDwGym19Isnvwn7awRLyc/tdbQ85
 IcUflZCF3B8GpEkXfOeuwmjuqUteGnLUFImNo8Lunpj7ZMVPuDQkHhBb+QZY2YwESqJulJo=
X-Received: by 2002:a05:6a00:3987:b0:886:a737:e0fe with SMTP id
 d2e1a72fcca58-8a9bea67183mr5122999b3a.23.1793496124392; 
 Sat, 31 Oct 2026 18:22:04 -0700 (PDT)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8aada2dec47sm922146b3a.36.2026.10.31.18.22.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 31 Oct 2026 18:22:03 -0700 (PDT)
Message-ID: <bdd52452-f683-4677-b5f6-5b8101a4585f@linaro.org>
Date: Sat, 31 Oct 2026 18:22:01 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/34] aspeed queue
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20261031065823.191966-1-clg@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261031065823.191966-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/30/26 23:57, Cédric Le Goater wrote:
> The following changes since commit 4075aa42daecf701cd3869da8b3271dc3c04a4b1:
> 
>    Merge tag 'block-pull-request' ofhttps://gitlab.com/stefanha/qemu into staging (2026-10-30 15:26:36 -0500)
> 
> are available in the Git repository at:
> 
>    https://github.com/legoater/qemu/ tags/pull-aspeed-20261031
> 
> for you to fetch changes up to d83158a1e9f6fa74cc7ae3bdac9e4fd5077909a2:
> 
>    hw/rtc: ds1338: parameterise the register map via a device class (2026-10-31 06:52:19 +0100)
> 
> ----------------------------------------------------------------
> aspeed queue:
> 
> * Fix AST2700 SMC segment end address decoding and DMA flash address mask
> * Add Winbond W25Q33PW flash SFDP data
> * Correct AST1040 A0 revision ID
> * Add AST1040 FMC and SPI controllers with SMC qtests, and stub
>    unimplemented devices
> * Bump AST1040 functional test image version to v01.00
> * Add the AST1080 Platform Root of Trust SoC and EVB machine,
>    with functional test
> * Adjust Aspeed documentation with catalina-bmc and sanmiguel-bmc
> * Remove unused SPI flash controller from the SanMiguel board
> * Add PCA9545 4-channel I2C mux with qtest coverage
> * Rework the DS1338 RTC

Applied, thanks.

r~

