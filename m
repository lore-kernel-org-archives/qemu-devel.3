Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AD8EE68952
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 04:02:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6MO9-0008R6-4H; Thu, 31 Oct 2024 00:02:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t6MNq-00085B-Ac
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 00:02:09 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t6MNo-0004iu-Ae
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 00:02:05 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2fb5be4381dso3818221fa.2
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 21:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730347322; x=1730952122; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=X7eYAc6TdS7hLtLGSAnN7NlD5+j5bytNo++zI/J2PzE=;
 b=nBBN1MHcnLeifddm20ttSKqmH892+gINGg21BdnEi4Y7s1f0tMAYTITvymw7JBhEIE
 MTNV3DAncjWhID5+E14W8jRFr/BDvfiTXpZx1F+maQhbFw50er+ZVTdh23ZicvcYWyat
 oKOIhk4jJZ1Ty77ijp0kbn94oQFsAx5iRr8XtrUMHG5EYc9zQitUedeH6DaMEnRcJLaA
 8e6M1gfb/VNxg3rvOGgaaPQ6GafbRNjrieUrceX9tPLADQIgL0+QPL2x/k396IgmM9ZV
 ItMWiSodPU0rkm47Eutf14NpxfKhtOowgO1DsNjxRhbyi3xjLpkYxWPLGTQ3PBeE7GnS
 tfYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730347322; x=1730952122;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X7eYAc6TdS7hLtLGSAnN7NlD5+j5bytNo++zI/J2PzE=;
 b=h3CZ0B1bXtsOQGI4cRTuUCfwD1aCQWBHCx0/kv6p+AHOrODYfkkOpfRr0bqMj5kBAk
 AkWQe1Dn4i0YYuwlVV5qtJJHvFvO64se3foAzddYI6EgPD0YZQfGLib/YN9To6INcztR
 JuOEX8/Y6gDmm2WGgR7s8LSioZBVIag46puvTTBhF2Va5Rp45+xsWsnIB/8CegAIolau
 cpUnHv0jaNG8xQqZbPx0kquZpcMh+DuKWGJ8at8bPGtvDovwRQHvK+7xTJb3NSrKoAWi
 vtEon0xdWbYOK1Fe1pDgx/T+zm2TUl2s+/4joukqlntVQh840MlbcIuo1o8avj+aUuUC
 YwJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5DuJ0tfO1LBZqjJ+s2V6y3wxawYC6eSTybqOEX0NaZLCoI9xa1Ui+3MrVa2naBcOD5J4kG0LMTeRR@nongnu.org
X-Gm-Message-State: AOJu0YxDMPEVj4rKPt8QY/J2tnCzHrhY8oL0eMk/HuL/l9u14RsGtUIC
 ocD9lrqAnq8E9tpDu4lHW1NSi6PH7gOVb0aLhuJP7rr6FixgpCJhYC8yszTc1H8eibDDzL1w7if
 C
X-Google-Smtp-Source: AGHT+IF5fSXPPPmU1w2gas2P7MoebE3Nkga2aFryq4ON0bhR90KFQNwbLFonxwkFM63f0oScchR9aw==
X-Received: by 2002:a2e:701:0:b0:2f7:7ef7:7434 with SMTP id
 38308e7fff4ca-2fcbe095e65mr73007481fa.37.1730347321956; 
 Wed, 30 Oct 2024 21:02:01 -0700 (PDT)
Received: from [192.168.21.226] ([91.223.100.208])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2fdef3beb5asm931541fa.6.2024.10.30.21.01.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Oct 2024 21:02:00 -0700 (PDT)
Message-ID: <25228ae2-eaaa-4693-9668-a42e91529446@linaro.org>
Date: Thu, 31 Oct 2024 01:01:52 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] crypto: perform runtime check for hash/hmac support
 in gcrypt
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20241030101150.3023300-1-berrange@redhat.com>
 <20241030101150.3023300-3-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241030101150.3023300-3-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22b.google.com
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

On 30/10/24 07:11, Daniel P. Berrangé wrote:
> gcrypto has the ability to dynamically disable hash/hmac algorithms
> at runtime, so QEMU must perform a runtime check.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   crypto/hash-gcrypt.c | 2 +-
>   crypto/hmac-gcrypt.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


