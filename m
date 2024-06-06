Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8932C25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 12:43:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFCSS-00051H-86; Thu, 06 Jun 2024 08:43:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sFCSR-00050C-5R
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 08:43:07 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sFCSP-0002uX-GE
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 08:43:06 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2eacd7e7b38so10165541fa.2
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 05:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717677783; x=1718282583; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wmWSFdenUilBejz9cmBeGqpcFxGB6yhYLz7CzbG1ozs=;
 b=W0GNHh745gvkcECNfNY2wBRYW0IHE/eSRa/WNPJ9ybdspQZysJUoCzZc+ELSCB/fQx
 BUHbiBdmMCQpTf0lKiX578we9airKvR0JAtRW8Cbe/HE9x0ij05zlzkj94y5F08YXFyb
 EcT98ZJsGRVkLz44rEhe5wfBYcu2iDCwBKOcx81HLka33sU+uStAmmQmunxE6OK0tcBm
 WPoSdOtRb14ENihQm8mHFrPdBf3gx4iHwpn6+Kfoz3cTdAEQKycykrzeqFoQeJTt3dq1
 x+ZNFiC1rlwy62BjvJMN2j9sKKD875ICBE5l1n/hMm31pRtN3NhRdioOLMibqnpTftxs
 eDug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717677783; x=1718282583;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wmWSFdenUilBejz9cmBeGqpcFxGB6yhYLz7CzbG1ozs=;
 b=H/xKrP6e/eF/ejchxxBEvvitwXEPpKDZYjm0F+lYiotT6xLH2H5LG3lWvhAKsW+yBs
 CGfB+DMHUGEtGASzwMLR+kwISZPBEa4eUuU6bIStpqunhNOD4R1tMw65sdLv4ppe9Xzf
 3dwUWy+XkKC8l+/ueG9LudcV3+MXA4JtLtPjGP1RbCica7MwxpbJ7eou15KOmfMUF16M
 bk30yK+k2WBt/gDTG5C4bhkcnjf3EONYMQZqVmu7dfEbU7cFVZQf1dj1Z/UAikIq1Qqn
 gIh5z2FJwNgrYUqpWqbBsUxihx7ENQpzjlNH+cIQestr6xU4ya/bTU9MjKdzh3Ab7mX+
 UEiQ==
X-Gm-Message-State: AOJu0YxLsOdAqVxebZzDHuJSIoWKRd5C/YdWZHk7DiwKw0I+Y2W/RMxL
 M581ncQMuPyHm7Qnr8PK3er3uEG3/agghtf43ZKiJNX/RUq4g/29PYtc6CDtY7U/MDb5rYmWE7t
 pTPE=
X-Google-Smtp-Source: AGHT+IHUhco/STdOGNOxa91hG63dDQ0DUedIKXnsNZ/2Gkjw2KayegBFid/nJKsmjjXj3oLl9FC77A==
X-Received: by 2002:a05:651c:551:b0:2ea:89f6:258f with SMTP id
 38308e7fff4ca-2eac77a26a9mr46588661fa.0.1717677782972; 
 Thu, 06 Jun 2024 05:43:02 -0700 (PDT)
Received: from [192.168.183.175] (94.red-88-29-105.staticip.rima-tde.net.
 [88.29.105.94]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4215c2a5f47sm20864055e9.24.2024.06.06.05.43.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jun 2024 05:43:02 -0700 (PDT)
Message-ID: <f932b4f2-25ed-405f-b9c4-cffaab903e3d@linaro.org>
Date: Thu, 6 Jun 2024 14:43:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] semihosting: Restrict to TCG
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>
References: <20240530145349.41309-1-philmd@linaro.org>
 <1abce060-99cd-4881-835c-1cedc02e61e2@linaro.org>
Content-Language: en-US
In-Reply-To: <1abce060-99cd-4881-835c-1cedc02e61e2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22a.google.com
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

Kind ping :)

On 3/6/24 10:27, Philippe Mathieu-Daudé wrote:
> On 30/5/24 16:53, Philippe Mathieu-Daudé wrote:
>> v2: Address Paolo's comment
> 
> Missing review: 1 & 2
> 
>> Semihosting currently uses the TCG probe_access API,
>> so it is pointless to have it in the binary when TCG
>> isn't.
>>
>> It could be implemented for other accelerators, but
>> work need to be done. Meanwhile, do not enable it
>> unless TCG is available.
>>
>> Philippe Mathieu-Daudé (3):
>>    target/mips: Restrict semihosting to TCG
>>    target/riscv: Restrict semihosting to TCG
>>    semihosting: Restrict to TCG
>>
>>   semihosting/Kconfig  | 1 +
>>   target/mips/Kconfig  | 2 +-
>>   target/riscv/Kconfig | 4 ++--
>>   3 files changed, 4 insertions(+), 3 deletions(-)
>>
> 


