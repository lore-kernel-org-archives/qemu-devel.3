Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC8FFCF34B0
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 15:56:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swO9b-0006S0-5x; Thu, 03 Oct 2024 11:54:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swO9Y-0006Q7-Lq
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 11:54:08 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swO9X-0003SE-87
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 11:54:08 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-42cb806623eso9372905e9.2
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 08:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727970846; x=1728575646; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=haaGdNT5KqDsiLnAxulpThAYXAfTnS2IcHRulTDj2cM=;
 b=u/QFcRW33CzgGNCFgeB8YyllPpIgKIJkcZhNBUvhpeGekykR88TaTK2CI07hcQ8ohC
 UvU3SwMV7vHwjeoV9wLjnfHd6kpGUj2KVaiJfpXel67cz/BnL4XvyupiELfO0lyzttKa
 Px3u5YyUaBryjQuK4uSpkM9hrYPOANAeJ9pt3eQpTlyalSld3gnojKRNcVCjUWYrCJQN
 7dULRO6Qd1EtoDADncar41aKsz6Cyn+R45F4Ka0j0Dfdrrd2av6xTgLLYC50AklBfsLu
 iwSR8t4OLd/FsEt5ZhiwoC/o2zX5r5rP2hg8y95E1M8IgQ+eByWSh1SdyDd+3MsPsDR4
 SQxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727970846; x=1728575646;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=haaGdNT5KqDsiLnAxulpThAYXAfTnS2IcHRulTDj2cM=;
 b=o35xXbdSzrj/ZzJNe5HUJ9yWBhEs0C56HetyavI+Epdaw1mC0xviIZbkL9coh+t8dQ
 8FEXWi3bQQyOGUnX8IIkOS7gyZR7bfOZAKbKmo+dTorzJGeuzS2e0SEjuhngr/G8S9Xm
 qmnw+2sf+Inp5QxpdyP0LSbsaNW8MvEJ0uJMO36RbnvsCwACdaTBKr6azxiwSRUaTZGy
 htuVVWlEyvyLZvG1q/+nIBIBDQslCreQSE6pwuF6ApXYq7lSJDGPMReS5WS15zowan4T
 MXfqQD88yE0TE+hw43QS7yHtW/c/cKuCHMyyDQ1pgCkWwatnzN2rMt/zx9VJ1TXcpbqB
 5kRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVNmuEF6fhMohc7k4ENVuxoGDg51wUgQN28zzpOfE+LrCcIV+cTMUD6zVgSs+i94/IYikhs9EWRu+x@nongnu.org
X-Gm-Message-State: AOJu0Ywl6KQ+bXSXpIjdEd4YaGfqtt2b8XRtMetHs9QDSHTIEiXXJgL7
 vzv9uUpiXqi20aEL3TcjwGUFNbklR6RGJlXMT3plqyHWRJzQmY+EYhhkLzE/e7HEfl37iq6j0Xp
 Mi9w=
X-Google-Smtp-Source: AGHT+IGthV2rVEQqS4bBZ2yFNKQCf0msiOUf9ZEEIKhinNfmJ+bjlHYRnUEG+J6AcSPzrM2Ev69xGw==
X-Received: by 2002:a05:600c:3ca5:b0:42c:bd27:4c12 with SMTP id
 5b1f17b1804b1-42f777b7888mr50916875e9.10.1727970845717; 
 Thu, 03 Oct 2024 08:54:05 -0700 (PDT)
Received: from [192.168.13.175] (49.red-88-29-183.dynamicip.rima-tde.net.
 [88.29.183.49]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d082425f5sm1544489f8f.50.2024.10.03.08.54.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Oct 2024 08:54:05 -0700 (PDT)
Message-ID: <efc4c807-c6e4-4462-847a-e7ea8b54f711@linaro.org>
Date: Thu, 3 Oct 2024 17:37:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/intc/omap_intc: Remove now-unnecessary abstract base
 class
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20241003135323.1653230-1-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241003135323.1653230-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 3/10/24 15:53, Peter Maydell wrote:
> The OMAP interrupt controller code used to have an omap-intc
> class and an omap2-intc class, which shared common code via
> the abstract class common-omap-intc. Now we have deleted
> omap2-intc, we don't need the separate abstract base class;
> fold int into omap-intc.
> 
> Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/hw/arm/omap.h |  2 +-
>   hw/intc/omap_intc.c   | 13 +++----------
>   2 files changed, 4 insertions(+), 11 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


