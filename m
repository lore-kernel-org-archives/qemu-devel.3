Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34214C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 21:28:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4opG-0003k9-NV; Wed, 08 May 2024 17:27:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4opE-0003jo-JT
 for qemu-devel@nongnu.org; Wed, 08 May 2024 17:27:44 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4opC-0002w2-QA
 for qemu-devel@nongnu.org; Wed, 08 May 2024 17:27:44 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-573137ba8d7so2477859a12.0
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 14:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715203660; x=1715808460; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Mdjosks7r/KJkxwZhUwAHkrACfDKzq7Mygq7lPfzFcY=;
 b=TZ53IbJDfVqCTd5KPnvefKTajWQhZ7tA8mXEArLx7uyqbOJkmBibWiSO0s3zgbDcp9
 Y8/NlpEN3vbvoatPwtEd6Xmg5ptHJ2jLPCC/ti/7MdAvYle1bPlXvhbTblN5bpiTnYzq
 cfZ+zyg/ymiT1l3WINqTmOeTt7Ys/ogB+fG/0oBIRlTxcbvwPIyyA/bfUE0i3wk+z4PI
 2RRpsbqePQZDLJ6p9DJLvd4muKWs8q/28XxGgt0CAwR2pzsoXp2ZUYwPGyQ2w3yJCRPy
 zj2WjeP2UsTeYBQF2YYOtDX3HA3Rsmsm/eP0Xnp8dTZ8lsQsZrUP+wI8PyEv/Ru/qWoe
 RtPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715203660; x=1715808460;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Mdjosks7r/KJkxwZhUwAHkrACfDKzq7Mygq7lPfzFcY=;
 b=EnWhUYV+OYOwl1POLSlz+P+PqUFAbp/EMKaiPnUz7weR9UcEwoZpMpyxrdwPF1fdXq
 FyBnTT9wOEHC+qY0JKzsWoquZ8RSDmvzwU2fpmSY7YC+rtZybVFU5SOgpaUeibMcQ0np
 uUTgAK51Zkp72rIZpKrKFDjebq56dJ4BYQufFv57yzsj9BC9CQ+D2vFQgzNlVvNX57F6
 lBzrqNO7SGkE03Lp55JMzJkTTwWR9Z+uIAspIpSkCG+u4w5KDJOCCCsz+9Ms3kozB73Q
 gtvRqmW8pnfg/Sin/FRaYr8/SZJFceEWLxpTw6xcU11PUnueIdwqZ7fiWuA0iR4bdE8d
 SyCg==
X-Gm-Message-State: AOJu0YxwfE8BjT/jkNkoToWZ3kjBtThMpqPol6Px5qOMcF1Gm69/bqCI
 7RRDnxjlHNNybjofkl6z7ZcborSUVFryJMjHDcZOQe2Sw9FpXaz5DmQRXQ/7Pfk=
X-Google-Smtp-Source: AGHT+IHImM+TXbGXYmvYBNO1dxdgkij7yUod+2avs5MpDESTaXpqDNGlNeGDnjl45//IFvFfm5G83g==
X-Received: by 2002:a17:907:76f4:b0:a59:c3a1:23f9 with SMTP id
 a640c23a62f3a-a5a1155b44cmr68595766b.7.1715203660449; 
 Wed, 08 May 2024 14:27:40 -0700 (PDT)
Received: from [192.168.69.100] (sar95-h02-176-184-10-250.dsl.sta.abo.bbox.fr.
 [176.184.10.250]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a17b01d3dsm2914466b.186.2024.05.08.14.27.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 14:27:39 -0700 (PDT)
Message-ID: <ba6c3173-12c2-45d8-ade4-b21598800f5b@linaro.org>
Date: Wed, 8 May 2024 23:27:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/clock: Expose 'freq-hz' QOM property
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Luc Michel <luc@lmichel.fr>,
 Damien Hedde <damien.hedde@dahe.fr>,
 =?UTF-8?Q?In=C3=A8s_Varhol?= <ines.varhol@telecom-paris.fr>
References: <20240508141333.44610-1-philmd@linaro.org>
 <CAFEAcA84CfdNZSjZ1R96=5P-VhxGXyaaujF1Y8AxKa+Wvpdp3Q@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA84CfdNZSjZ1R96=5P-VhxGXyaaujF1Y8AxKa+Wvpdp3Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52f.google.com
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

On 8/5/24 19:46, Peter Maydell wrote:
> On Wed, 8 May 2024 at 15:13, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> Expose the clock frequency via the QOM 'freq-hz' property,
>> as it might be useful for QTests.
>>
>> HMP example:
>>
>>    $ qemu-system-mips -S -monitor stdio -M mipssim
>>    (qemu) qom-get /machine/cpu-refclk freq-hz
>>    12000000
>>
>> Inspired-by: Inès Varhol <ines.varhol@telecom-paris.fr>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> So I have a couple of thoughts here:
> 
> (1) if this is intended for qtests, would exposing the period (i.e.
> QOM equivalent of clock_get() rather than clock_get_hz()) be better?
> A Hz figure has rounding so it's not as accurate.

Indeed, simpler to compare from QTest perspective.

> (2) We should document this in clocks.rst; I guess we want to say
> "only intended for use in qtests" (i.e. if you're part of QEMU
> use the existing function interface, not this).

OK, and we can also only expose this for QTest using:

   if (qtest_enabled()) {
       object_property_add(obj, "[qtest-]clock-period", ...);
   }

