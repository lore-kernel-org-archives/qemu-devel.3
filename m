Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A459CD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 08:00:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOstd-0006Xq-7S; Mon, 18 May 2026 04:00:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wOstE-0006S3-ON
 for qemu-devel@nongnu.org; Mon, 18 May 2026 03:59:54 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wOst9-0002zh-Am
 for qemu-devel@nongnu.org; Mon, 18 May 2026 03:59:49 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-44dd5cb0f81so1857361f8f.0
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 00:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779091173; x=1779695973; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jVKXn+xmQ3PD/fftV5yjdQG2Us2BnYj/dqEcZ7NQhVQ=;
 b=F86AAno/xdu2xEk+SgvWQOOKHMuG0S2PjrFCU0mFF5DJbPH0//HI1DqG1p/peryxb6
 5r7TKJCMAnAq1loisH7Kj0W2C8b40KAKaMelp2nPZ6Q3oWKSGlNP0eZmsbMhZOIhFY+s
 o53IylHjarazYVsdrlPvF0GElbYBUFPqi0J1537EfPV3noMJRENeGzGroG9oqdx5Ymbv
 EuyJV+2OzeNJ32XhfF1bgWmbp/v9PTRJJgRgSsKVbpzJOgtHQjvJq3e05/ngKuhLnflw
 GxysDo/xfjp8gi/Vj27k/l9P0Zu5IuL3T5wm9c/P+/oaO5MnKMSaZ2PKD10CELlevi7l
 uZ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779091173; x=1779695973;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jVKXn+xmQ3PD/fftV5yjdQG2Us2BnYj/dqEcZ7NQhVQ=;
 b=mR4kn5W2WMvtRzdsFgAjW522DYENDm71qtAvQVU6PXj0rzxFiaGdoydqNmHYV7Ib2d
 bIYXTYP8BCVezqGuHHlTa7hT0esOVc55eDvrI59wPqTcdr6+dlUmf8cNcfzmbRDi9IvL
 1A3WTQRsAYVZXXKr12wt7fi+9dFzaarbYTeRTbB4wDVD8Mo9KpXEpYN/Z+T3bJZh7oNl
 ogKg8P58w5MESJ5amf1nYWdInN6nxgWEJW0J400SLaLj2v5GUYrWO2usiwGRWnvdqxP2
 ywAT2i0Br4yqlqhUXU3blqMfUO+z4RRVXC1sI1vHKz+OB+mmKTQ7RvP0DWSq5Ek8qxXI
 ngtg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/2CU4ORAjv95d+/AVlKT09OV6Alm0nu8T1wC0dTp9Ke90QlEsUrtmlhOwe1aS45Ib/sFv1ewALn29Y@nongnu.org
X-Gm-Message-State: AOJu0YzUDc1YMyencoMxn3vSULMo3uQzupDGrX5GG8AMfu5AYg3nxwbJ
 WZnP2SCysA1lKlRHJ4oFFny/ui7zYri/t7Qz6B3plqNsJBJ90Bl3mXC9yRJlxSkWp5A=
X-Gm-Gg: Acq92OGUw0P2bbMDZvzxEkXxDcooaPNtA1UCrdBUJ95sjs30dzcIE2c3G80V28Tu8Ma
 B0l/9BHz8L2hjg82QabDvm9hP7QfQlW89qeowZ0B7vmJn1ydQJdOmMH+G31TYNs+G7tCgP06bTN
 i0mqqCtdDBJFA0RMRiP414zexmNhCLan8sq+59hGD5aUnYLW3cf/vHaUfs09o7Q1ID6oxN51kXV
 6tUDabssEd43tY6oKAHflKawnpfBpDWIkZoDZBFzCTix15IlaHOJx9aiQG/3O56IHGWVi3r9mas
 RzUgCyV0gegUQxfPKTxATtVfZ0QYZqKVRxhdFAIDqTShvSVtqbHaPP1nCYRPT2E3Tq48eGQ84tD
 pD26oPCbetTLnl+SyslN7i/S9fdXzssVRK8rnjnbnOWuYvCynhSBVclZ/5evTx8F0ezDqk3zX5l
 CN3CRSmE7QyVRdl9Hl97gWv0L8kX5elJu7zjI/BBjN0uVO/UVZ307ennVH5GitxNvmWQ==
X-Received: by 2002:a5d:4577:0:b0:450:b883:dd3c with SMTP id
 ffacd0b85a97d-45d9352412cmr20769275f8f.20.1779091173378; 
 Mon, 18 May 2026 00:59:33 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9ed2ffdfsm32612586f8f.15.2026.05.18.00.59.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 00:59:31 -0700 (PDT)
Message-ID: <2a560940-d834-4184-9369-301ca9dfc5fd@linaro.org>
Date: Mon, 18 May 2026 09:59:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 11/21] target/arm: Restrict IDAU interface to TCG
 namespace
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Steven Lee <steven_lee@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Laurent Vivier <lvivier@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Troy Lee <leetroy@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Fabiano Rosas <farosas@suse.de>
References: <20260516171524.19184-1-philmd@linaro.org>
 <20260516171524.19184-12-philmd@linaro.org>
 <5053ba4c-01eb-443d-b364-50a32be41e26@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <5053ba4c-01eb-443d-b364-50a32be41e26@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 18/5/26 09:48, Pierrick Bouvier wrote:
> On 5/16/2026 12:15 PM, Philippe Mathieu-Daudé wrote:
>> Emphasize the IDAU interface is restricted to TCG by moving the
>> header under target/arm/tcg/. Move the definition to cpu-v7m.c
>> which also contains v7/v8 hardware (NVIC), keeping only CPU types
>> in cpu32.c.
>>
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   include/hw/arm/armv7m.h     |  2 +-
>>   include/hw/misc/tz-msc.h    |  2 +-
>>   target/arm/{ => tcg}/idau.h |  4 ++--
>>   hw/arm/armv7m.c             |  2 +-
>>   target/arm/cpu.c            |  2 +-
>>   target/arm/ptw.c            |  2 +-
>>   target/arm/tcg/cpu-v7m.c    | 11 +++++++++++
>>   target/arm/tcg/cpu32.c      |  8 --------
>>   8 files changed, 18 insertions(+), 15 deletions(-)
>>   rename target/arm/{ => tcg}/idau.h (97%)
>>
> 
> This patch creates a problem with the (now merged) commit:
> 8d3e31c0d575b3265ae5cacfba10680718ba5a22
> "target/arm: Extract IDAU interface to its own unit"
> 
> Indeed, it results with TYPE_IDAU_INTERFACE being register twice which
> fails at startup.
> 
> Maybe simply drop current commit?

Yes. I'll repost, but the series still won't apply cleanly when
the "discarded const qualifier warning" fix gets merged (just
letting know, I don't mind respinning).

> 
> Regards,
> Pierrick


