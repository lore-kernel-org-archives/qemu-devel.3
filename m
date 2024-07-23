Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D650DC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 15:46:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWHi0-0003bx-SS; Tue, 23 Jul 2024 11:45:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWHhm-0003Kk-PG
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 11:45:34 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWHhi-0008Qg-IC
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 11:45:34 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2ef2d96164aso23279331fa.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 08:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721749528; x=1722354328; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PAAgUGy/Vrh+ePNzc0RuKO+1YP7H/hmuG02Mn3+OVWs=;
 b=OQI3T8kuJlLhxzO5D6mu4t1xCVkvXGt53gdxe0UeEjFvrIsjx+s/f1Czfy5dfdf+nh
 6PHFT013nC33aq3aj9ElgFfWzVGS49PCXqd9+ZdYputVsuietBClCtwSv3blBNs2sNir
 iBB6uhbEbfbz2npr1YhKXFtYu055YZ5dQvWLvyrpHrsUPq/Y0nvnGQmRaAdm7jf604oA
 Ebx7R1g0yJ7YjxTGlvV2YeXnmz8NDyf2MzjvLwiSBRQMO/MlmdY7RL1S8XccTzxX3MM7
 dYK58GhL5B6kFyhvQ59hN6PqTfrw2KOkF6jdP60tka2+Ay398hafawG7/xHL7m+CJqyV
 2v8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721749528; x=1722354328;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PAAgUGy/Vrh+ePNzc0RuKO+1YP7H/hmuG02Mn3+OVWs=;
 b=ueFKKP5TmNH4UJ88dX/8K5S0E7x9kvoSEMFjePmnh0924oZ+HzL2P9B4WyRkNw4cGG
 BuVJbcdxq87fjLiXP9APNQzgljg8pH9AzxaCt8RAg2pLgrVPMyfOhDRZ30fSRThh2A7x
 kZwUFhrvp0iaIbJscBh7uHSGYWEmg7j/16slZtlkrx5cJ0Z9aPpmTJzptJAgffAnatFG
 2VZlW5UaFRdfsINPTlPVN0VnwOUTAfzT/td981JR0c2s5oEuQTX7lU27rPTHxETVvYe9
 2HnbcRTxEZMhSSdPuVEo4WpZlqx5+6nVfEz6PDChIpCmTSfMrWmBaM0kSSOHj7Bn9Nax
 wgAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFYfeEE68fgp/tiR2e83fwnck947AMjp7ctDWUDqBwSoG7QCQBmcSjpjTHTd931bK5mlG2tR5WlP8OvqCwBLa3pyPNSl0=
X-Gm-Message-State: AOJu0Yys3viD453Q8e5Lct2nzHF4P+5Nrf6V5160duwR5y2p4kUJPQQ4
 h/0LuZxZROrqx531o4kMdgPZ0/zVIFfjQZCFjUu6aTuhThrPLHnyz/cZjDWN61s=
X-Google-Smtp-Source: AGHT+IHzORHc7YL5LtA9u/nSspTdNF5X433gi+U7FJhy1BDqmVU/wyfMdOTjo6XCutbXBcalp52saQ==
X-Received: by 2002:a2e:be93:0:b0:2ef:1bd5:bac3 with SMTP id
 38308e7fff4ca-2f02b99bcc7mr1949841fa.41.1721749528622; 
 Tue, 23 Jul 2024 08:45:28 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.208.14])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d692ad0fsm176475925e9.30.2024.07.23.08.45.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jul 2024 08:45:28 -0700 (PDT)
Message-ID: <e63defa6-cfd2-4611-889c-bac9a80889f3@linaro.org>
Date: Tue, 23 Jul 2024 17:45:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/m68k: avoid shift into sign bit in
 dump_address_map()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>
References: <20240723154207.1483665-1-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240723154207.1483665-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22e.google.com
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

On 23/7/24 17:42, Peter Maydell wrote:
> Coverity complains (CID 1547592) that in dump_address_map() we take a
> value stored in a signed integer variable 'i' and shift it by enough
> to shift into the sign bit when we construct the value 'logical'.
> This isn't a bug for QEMU because we use -fwrapv semantics, but
> we can make Coverity happy by using an unsigned type for the loop
> variables i, j, k in this function.
> 
> While we're changing the declaration of the variables, put them
> in the for() loops so their scope is the minimum required (a style
> now permitted by our coding style guide).
> 
> Resolves: Coverity CID 1547592
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I could have just marked this as a false-positive, but it
> just about seemed worth making the change overall.
> ---
>   target/m68k/helper.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


