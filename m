Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E1C7C25B76
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 12:49:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE77e-0000gR-PE; Mon, 03 Jun 2024 08:49:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sE77c-0000g0-TR
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 08:49:08 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sE77b-0000Zg-DN
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 08:49:08 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2e6f2534e41so35569621fa.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 05:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717418945; x=1718023745; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=a4Os/ZqoxLh2BqrzkEgiHApc1jXAK0Sv+PciRlZtTGI=;
 b=AOnXDCRzm08XzH0KcjuDCgKBMaxZ70FRI9Tb28/kKS2TgDbZtreMTr3zaDwLeUZak1
 jn14jC11JayXKjG3zp4IkaGELoOGTg0Byz17bwV2b73zvPv3Yas5002dcSWGRX6MJKx9
 ZYO8vWoPSoJIk73P9Fg/oE/40x5ndRYa+IY5EuES7HW6/7BVm+nqqzNPzogSqiNoHNrs
 7t/AtnPvDieQ5I/wRKMymdA2GPzqo7VouuT6ZIUX03gteIEuvHQIDIux9LvRWr15d2om
 uwpTkmwdce1CfWLJvltwZYxArHNNvgNk/Srzp52+V3SYrdeCXS8yEsHYhvHixt8/kJmw
 4ZvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717418945; x=1718023745;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a4Os/ZqoxLh2BqrzkEgiHApc1jXAK0Sv+PciRlZtTGI=;
 b=QajS51B1ot4bkrGJZWLpL8EbzjOW0L6rLM31iEX7XzKcbQI83VTMD0fThCNJsP7tcW
 9+RquEF/kvYJlhofpQ/40qpPLHQ0NjKp99QqCRbJs68mNmkXyAFWeGFiqjrzjTE5DJPl
 C5Re29epHmyWjiyRO+OZ77yVQG/64gl9YvgBvsLTcKbiA8aJfPWgDE6/bwY/yUGp1Snl
 SK7Y+5MBLE2TY7ntdXr8cj8tW34eeOZQiZuoOiokZ63eNQCCQXqCfO51DIhDW+1nW0qJ
 r+9sVZiQxn9LRFYwl86zLzu2N3IevxiWq5+wUgZzmzm22bNfeLweqo645gQqPi9BCJXD
 F+Iw==
X-Gm-Message-State: AOJu0Yws9DTTedFB0F6Yx3ShbesmKRE5G521Fgnb4k0dfnZzTQfPsoH3
 i1JOSC0zL/Eqi7LwuDE/ih6lZZHiLIvopZ0EbdTkcg3RJ6Aob3iI8qf0xHzSVl/cMdZPZXDiNi2
 6
X-Google-Smtp-Source: AGHT+IHNBrvpDBztP6jK8W+YjHZnMBPcyGmunE68Mly6tVq6phiPvYkrINdFbXFht4C1Cs6WC10i5w==
X-Received: by 2002:a05:651c:21a:b0:2da:a3ff:524e with SMTP id
 38308e7fff4ca-2ea950ae89emr55149891fa.9.1717418944940; 
 Mon, 03 Jun 2024 05:49:04 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.177.241])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd062ea66sm8715917f8f.78.2024.06.03.05.49.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 05:49:04 -0700 (PDT)
Message-ID: <f63d06ea-d5fe-474f-bd67-d4279eb4fa54@linaro.org>
Date: Mon, 3 Jun 2024 14:49:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/mips: Remove unused 'hw/misc/mips_itu.h' header
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>
References: <20240529155216.5574-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240529155216.5574-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x235.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 29/5/24 17:52, Philippe Mathieu-Daudé wrote:
> Since commit e1152f8166 ("target/mips: Remove helpers accessing
> SAAR registers") this header is not needed.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/mips/tcg/sysemu/cp0_helper.c | 1 -
>   1 file changed, 1 deletion(-)

Patch queued, thanks.


