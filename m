Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90A60F3D334
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 17:05:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyC7w-00039R-Ki; Thu, 05 Mar 2026 12:04:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vyC7r-0002zU-TV
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:04:40 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vyC7q-00047i-CG
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:04:39 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-439c9eb5d36so1933233f8f.2
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 09:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772730276; x=1773335076; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eOt65cxkcxIk7XLPeX43CZs39Ta2WhxQpw3VsVulev4=;
 b=VdYBeA86l5eqwbGT3rVv+0zms1WkKGAiHBnBpnD/4O9JX45aPNO5OUpa50O9y4j/2A
 sMn7XBvRkx6OkOakii+9dfU4c9tqyV/DJMIwgxw83UfC2HmL19KFGzgqPaBT8hQdcCSg
 taHEBU1wppVyQQFYWHuoyJyBZsL/DCa+TOlTLcAt7H2PpJAB6Ih3ZsMjqzmqLL73WNnq
 lRoi7PEZUZDwlXt+39hit23te/K0c7Yp0hzopmPGOuwC21lXAwnzQ3ODdbg63G5PUVw8
 ubPUSXRaZj6OqZhU4WH60IBoAdt6jzzBGOGqyJQVaGhe0W9JthI+uBRl9Y9zXj41CX5i
 QIqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772730276; x=1773335076;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eOt65cxkcxIk7XLPeX43CZs39Ta2WhxQpw3VsVulev4=;
 b=Yl2PNvcBmIZ1hWjxz85Lm4sX1Cbf1TKX0J+jMlIzJwcHtEPmhFA/RkELh/AJYaQpXP
 ukdYM8eZknXUs8A+vNBfkbO3NczRUKq/dFzR39t+evbpxkj9VZChZkYeeGi/FmlzMbzz
 KrmKzHvaxKLKzimIfvsWeN7UFh9N4klkxGC8ZKnDY6vVVkkeVR64gMZZQxHWDV2w4cvU
 fSau8l61kxHyl5GcP024faUfTzx7rcTCYVZEvqJ/rNPKPJ5EuksDtQts2Vx5B9WEp2cj
 KMMPNrL6arEqZFM9Vd2KwZdT7tUB6rMKm1MteiKl+fcCtEY5Bsc08WiUgI+sRunsZO8g
 093Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW20+R/nyexF/bOPVEq6MgNZ+8uioKY+OhMpQpphvLxKf3m8Xu7w1mWRD4iTmc5a9xvi2ZQsVux6RbH@nongnu.org
X-Gm-Message-State: AOJu0Yy3qvnuoZ566dnpZPRs2/N7G0NskZgWQn7TjAjg7gQ9Nmp//BUB
 CBpSvFNMhGZDRNG5BvnAxIPdiyZufre+y8j1BIA8fiZOx/mqaPgLSqQknr8BBtOU2pg=
X-Gm-Gg: ATEYQzyD8dU9uUIIHdaBzlFo4c6eh3ftYpNx4rNiOlvsmX4KC9xy9CnwK+70n4/z/us
 MSxO4wtd87hN5/GeXrMi77S2HKf4Q3hVdbDAudbQbmHCPC/IbTY1xNXhpvSNky8dB75e9NnlHse
 4z25UU1Wu5xfS1E7Xl5O/tDYseNEZgMriz8JZy8ip0C8UbR4hTCiSWQUXfnEf3qmvK4TOcG97r1
 khMbUA/WgDA9U+QIOyVHZrlkvtMN7ptCsTZzkSZ+A02ekQzW7vqvnpyp+FqaNlyfe0htp5aWHQ7
 emWU4B5W192ibAvOkdCBFoSbkyGfjZCnGoTEEX7xYFiq0RF4sSKMIsPjosRl1J9V4ubPE9RexCc
 qbQqY6Y4gjwK3cfX5oOy9RmPvxomqSOpa6W/R28J042dSABdwLJwOaX+7+SRrtN2FGbrGGq1KuZ
 nG8QoUuO1OtkbtoxflrX+RXGYbe9VxpobuWiK0PFaxE+4jyrNuLO6G85q04v52O7K45w==
X-Received: by 2002:a05:6000:2011:b0:439:8eef:11f8 with SMTP id
 ffacd0b85a97d-439c7fd3e44mr10889157f8f.36.1772730276424; 
 Thu, 05 Mar 2026 09:04:36 -0800 (PST)
Received: from [192.168.69.208] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439c2f8c0e7sm19850263f8f.29.2026.03.05.09.04.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Mar 2026 09:04:35 -0800 (PST)
Message-ID: <f90be20c-c224-4c4f-9d1e-3360bde17c29@linaro.org>
Date: Thu, 5 Mar 2026 18:04:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 08/12] hvf: arm: allow exposing minimal PMU when
 running with nested virt on
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Paolo Bonzini
 <pbonzini@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 qemu-arm@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>
References: <20260228220837.35275-1-mohamed@unpredictable.fr>
 <20260228220837.35275-9-mohamed@unpredictable.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260228220837.35275-9-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 28/2/26 23:08, Mohamed Mediouni wrote:
> When running with nested virt on, a minimum PMU is exposed by Hypervisor.framework
> if a valid PMUVer register value is set. That PMU isn't exposed otherwise.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   target/arm/hvf/hvf.c | 4 ++++
>   1 file changed, 4 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

