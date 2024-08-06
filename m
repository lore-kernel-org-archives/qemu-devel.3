Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC00AC52D6D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 08:12:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbFIP-0003uy-E4; Tue, 06 Aug 2024 04:11:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbFIN-0003to-IX
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 04:11:51 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbFII-0000iT-Hl
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 04:11:50 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-58ef19aa69dso457546a12.3
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 01:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722931902; x=1723536702; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=C05xRAaMK4jTHrOi7Z3GY5FOT4W2UqaRGG+A2c9w3TY=;
 b=oE8G6SnWKcSYkA3wARTLgR3K/IrH0Iu1AZemtpRznvs0MzEDG9caeIlnGchg7F9ueP
 dDQBBkOjUw6CjTOtXiKMIAZz/itQoO3UXVwuUCyEjQ5C/v+KLdhwJ/yx7WDH9BzKPEKg
 cTZo39+/6Kt3idrAIQEzrJZm9V+UuNLg3Be+R9mN/6sNsL6C6RvAu3bhazd7S+uzFgQV
 8JzRz214DjmUffN/NTzQcaQBVQZr/Uu4gAojAJE4Oqm3uvc29ygUyw3pyKO0FjcCV5WX
 RWIdq8C94kpjA4S2moypfm2ve7EpPF3xZOYQ/1n3vbOoU2jnqqrEN7g5egpFM+xVtDxu
 jPOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722931902; x=1723536702;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=C05xRAaMK4jTHrOi7Z3GY5FOT4W2UqaRGG+A2c9w3TY=;
 b=FHqxmPeegkGOPr6C7WdvzdI89CUfuxrMWKUx38OTYgWdJgtrpnoFyJdYNnEcg293l1
 aZN65Bj7kfZQT2hR4QgiAO8ByqhDwbKGO3S97sX0NzWO2jD/K0LCSRI5wIIsQfiKCa2l
 5J/8knLFJzlK0edmmvZlpDAK8ggvsQHGubocll7J+BRpT29OZS8+TGBot0IauJttpz2W
 SodF7nqAVaOBvAdQebXr5yA240PB713IBXAb7sGp5Vc3nGRpOp7qo0YNEqTwSSpd/ATO
 ILNTFCQcUIoAjOKH7Tg+7QrTsg9hd4/ZEENxkAoPxy+T4USmmvEutVIK1L4EVMIA9r2Y
 GkoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCdvf2W19eQmIpNA88DnhqItQOjOGbb67rBdI7K7fJ06GV/J2xW9NZCXACNlLRMKqPMR5ZjzDqx09r6aFxbeg2HaXhQ2w=
X-Gm-Message-State: AOJu0YyUWom6AVhLz3Fp0hsnEQMTHzf6smmna+qOt83/gm1QE+i2Xlnd
 BZ9rCpz/ivvzQxfxM8K8DsGsQXSt6InRVSVmh+oom5LVLvC5T33Igsy6tiZFtSY=
X-Google-Smtp-Source: AGHT+IHTwfIPXNbpJVtj85bMVYiHjBpOSNq33Q58Usb5BOI7tuJkkAQfuX3Q8Ul/PM+23DtdRYRrWQ==
X-Received: by 2002:aa7:c3cc:0:b0:5af:e7d1:9532 with SMTP id
 4fb4d7f45d1cf-5b7f3502b76mr9138265a12.8.1722931902145; 
 Tue, 06 Aug 2024 01:11:42 -0700 (PDT)
Received: from [192.168.69.100] (cor91-h02-176-184-30-206.dsl.sta.abo.bbox.fr.
 [176.184.30.206]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5ba442ed7f1sm3965753a12.81.2024.08.06.01.11.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Aug 2024 01:11:41 -0700 (PDT)
Message-ID: <5b12ebc8-3d99-46a5-8fb2-0f3e5d28834e@linaro.org>
Date: Tue, 6 Aug 2024 10:11:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] block: Miscellaneous minor Coverity fixes
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 "Richard W.M. Jones" <rjones@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20240731143617.3391947-1-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240731143617.3391947-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52a.google.com
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

On 31/7/24 16:36, Peter Maydell wrote:

>    hw/block/pflash_cfi01: Don't decrement pfl->counter below 0
>    hw/ide/atapi: Be explicit that assigning to s->lcyl truncates
>    hw/block/fdc-isa: Assert that isa_fdc_get_drive_max_chs() found
>      something

Patches 3-5 queued, thanks.

