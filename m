Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61556C5478C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 15:25:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfLnr-00009B-M2; Wed, 28 Feb 2024 10:25:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rfLno-0008Er-ES
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 10:25:00 -0500
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rfLnk-0006Fd-BA
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 10:25:00 -0500
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2d228a132acso76524341fa.0
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 07:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709133894; x=1709738694; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Jp+7AFRf/5bdQKKYqATGX4V0b2scFyEtgy5iAi36glE=;
 b=rFslL10UoPA7hdZkhIaEY5r70JrZ0QHOEr+yGPGwK5N74ngIvDkdNq6PesHgFNLcZV
 FJlrTsULdsN23EvlHaeFGpzOJB1n6JtI1HbH53vLLYtG7ZZX/F0gvMWigOQkci9lZxBF
 K/ZXtrDLo6L10yiAPWJ4R1iH8w7N5+RuDcKGTyzCWjL7ep+y9wmDK8WY6F89Q4O0kTKB
 f9iTJfZpcTcUfK1vkjRts/xjyjcQNugvmyXQBZh0Rdv/CuzTwHKVEy+Lg3Zl/qXUCp9N
 z3Ea7er59cLK75BQ/VmFfhi3coiMf3ahCEFd4T7j82kRE18ZhzhIkUIofpN3nNYPktTX
 lx2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709133894; x=1709738694;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Jp+7AFRf/5bdQKKYqATGX4V0b2scFyEtgy5iAi36glE=;
 b=Gy3i79VzSm29qgsjS6/Z5NyKnt7dDhCImDNV8gkjwQzl1/Q38248wRD89b5lCbiKmT
 mnJCcplfcBQ0Mzj1NoOfifFj0IktvbaUmtpnhlN1ihJe2BALXg/EWGmEoKE+Hm7+SDBH
 6HChGpk5eFBfK4Ohea8wdJy9+2pmdROCJ+3qnjo18om+6MAPeFbWKR+5S+M/Cmk2Hq3b
 gAaQzi6QFY2dCvfK2R1TgBQkzIH/DuFlq0ENN1v8/JRc3/hngyjOyl9tY0K5huVDDGI3
 YGz0D8LnS2o1ZISEhqxflGSDN6wr+VvPALbRTPr/krFavC4moOTnFm1hvk+KuJ2D22i4
 B3sw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHfoHZWSUzxf9rWN2i1hZxjGz7YV9uqFiXFTgdJxfkLLzPZw+ues+L0AR2uD57V5Alm2U3N+Pb74jhiodUsCzsu0UYxPE=
X-Gm-Message-State: AOJu0YycOFeFfNN2iVutKhkeo0IvwxlswolBAd77/PDDUBtbMUiHqS2X
 211PKWJ9JGnxePySCQRNWPBlp3EVr5vsnnCgOqdRhDoh6g3lcbfUvuChXvFIL83xt7szrIBQJjZ
 klpc=
X-Google-Smtp-Source: AGHT+IGxlAJjnC29Qqi/PJZRbDZGihp0vIaZK8TgT6oXKDxbgDfFxcf7FQ7CMh/do9csxvYbCMRZKA==
X-Received: by 2002:a2e:9982:0:b0:2d2:a3ae:b339 with SMTP id
 w2-20020a2e9982000000b002d2a3aeb339mr3061015lji.48.1709133894200; 
 Wed, 28 Feb 2024 07:24:54 -0800 (PST)
Received: from [192.168.61.175] (122.red-88-29-183.dynamicip.rima-tde.net.
 [88.29.183.122]) by smtp.gmail.com with ESMTPSA id
 o30-20020a05600c511e00b0041294d015fbsm2487516wms.40.2024.02.28.07.24.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Feb 2024 07:24:52 -0800 (PST)
Message-ID: <3ac7d304-6bf4-49fa-b19e-74925409e736@linaro.org>
Date: Wed, 28 Feb 2024 16:24:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Update Sriram Yagnaraman mail address
Content-Language: en-US
To: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, qemu-devel@nongnu.org
References: <20240228080625.2412372-1-sriram.yagnaraman@ericsson.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240228080625.2412372-1-sriram.yagnaraman@ericsson.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x229.google.com
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

Hi Sriram,

On 28/2/24 09:06, Sriram Yagnaraman wrote:
> Due to company policies, I have changed my mail address. Updating
> MAINTAINERS and .mailmap to show my latest mail address.
> 
> Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
> ---
>   .mailmap    | 1 +
>   MAINTAINERS | 2 +-
>   2 files changed, 2 insertions(+), 1 deletion(-)


> diff --git a/MAINTAINERS b/MAINTAINERS
> index 65dfdc9677..0a3294f698 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2474,7 +2474,7 @@ F: tests/qtest/libqos/e1000e.*
>   
>   igb
>   M: Akihiko Odaki <akihiko.odaki@daynix.com>
> -R: Sriram Yagnaraman <sriram.yagnaraman@est.tech>

Could you confirm this from your <sriram.yagnaraman@est.tech>
address?

> +R: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
>   S: Maintained
>   F: docs/system/devices/igb.rst
>   F: hw/net/igb*


