Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8D02C54E66
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 08:16:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjxJX-0000IW-DO; Tue, 12 Mar 2024 04:16:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rjxJ4-0000CT-VF
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 04:16:22 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rjxJ2-00088T-KA
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 04:16:18 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-512bde3d197so4453070e87.0
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 01:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710231372; x=1710836172; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5pThmiKwZCaXpGU6F6BckEm7jMsXMqdQau4EnbipAL4=;
 b=SVSMZazKZ6MVSAbNMUnXX5z7gTE1by+t+YKyROMQ+TkRBcx8zuxwVDyrn5Sl/DovUd
 TwxyPAJaI77bZWrDPw40rqJOG/VzkpKnZeoMeF0SVGiVpY25KLfPjCKNHf1Mb0YIT2WS
 XQKdl4PDeCVKtv1X91a0XlnPwAYVWkQ8HdVgI7Nce/+NI5lm3SUCOn27kXhRENncp0tt
 QZvPJldWkeKekPz2MQoL5HPR6cG1Ql2zKjJPE+rf5nh2k97QaIbtPXqNwQbqnId+NrkP
 2WCxNFR91XCT8tQMNsQVXCW1BSyX6DwlQvkMNZvnx9wpJCOEO6O+SDfCDjBa8UD+cntf
 i4bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710231372; x=1710836172;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5pThmiKwZCaXpGU6F6BckEm7jMsXMqdQau4EnbipAL4=;
 b=Uy9ZwLSWNvFKf0cUaMWbh/MeAQu21iuxDyN9sCaDWEgGNFwApXksM7tcsRyGepfT7p
 dwOPz/o45ILcNZhmRJe3G682U19yINH9ipp6gnVJMyplcKHcgHvGW2BHPmoK4/LL0Mu7
 FB4vxFfK6Ai0/vwOtMjZXPT2X4atVa7nu3zAjuAd+H7HcEqUKv6g0p4Aoc+jlYxquthV
 0kHSY/hqHUw6QODJFVUSGLLeM1NKuFKhwYIMCYhL4iwtEoYpiIK6wZJjmOSesZLbFBeK
 hnLTalh+6AAHXqHIpO5oXKbHeiDapXWCHeGzkg8+KWi0gkSLSHv+0KuELcEY5Zht2TMl
 NYSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFW8hBGzaHy8fbthc2zko1z+pdNtGN7uYJDUy4pnoXADrLl+vwPG7od5o26Pf6dL1cNL4a1lSMJWxRoqKgN0U8CpwGqkw=
X-Gm-Message-State: AOJu0YyoDXUzDcPoxwxJzpUjKwDigGW4hAGOHMC9AmnvhH/HEWM0WGW8
 qrHQJwsqEZo47KYT2OOGiijNIMpl/obF4Pd0oUkQjkXjj4b26I48yXqwQvU5Xo6q7LaHvkTEXsj
 e
X-Google-Smtp-Source: AGHT+IE0uBEJm/37R91tHlX/ycBvYK5Puwf7RA0Z/RdBwYnQ/hdNzriDpE+/sTXTa1kLG6likaqllg==
X-Received: by 2002:ac2:42d9:0:b0:513:80cd:e807 with SMTP id
 n25-20020ac242d9000000b0051380cde807mr6269906lfl.20.1710231372389; 
 Tue, 12 Mar 2024 01:16:12 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.206.139])
 by smtp.gmail.com with ESMTPSA id
 q14-20020a05600c46ce00b00412b4dca795sm11617377wmo.7.2024.03.12.01.16.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 01:16:11 -0700 (PDT)
Message-ID: <e3c7610b-8834-426b-bf54-73e850b3586f@linaro.org>
Date: Tue, 12 Mar 2024 09:16:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] hw: gpio: introduce pcf8574 driver
Content-Language: en-US
To: Dmitriy Sharikhin <d.sharikhin@yadro.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Igor Kononenko <i.kononenko@yadro.com>,
 "Alexander A. Filippov" <a.filippov@yadro.com>,
 Alexander Amelkin <a.amelkin@yadro.com>
References: <f1552d822276e878d84c01eba2cf2c7c9ebdde00.camel@yadro.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <f1552d822276e878d84c01eba2cf2c7c9ebdde00.camel@yadro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12f.google.com
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

On 11/3/24 10:58, Dmitriy Sharikhin wrote:
> NXP PCF8574 and compatible ICs are simple I2C GPIO expanders.
> PCF8574 incorporates quasi-bidirectional IO, and simple
> communication protocol, when IO read is I2C byte read, and
> IO write is I2C byte write. User can think of it as
> open-drain port, when line high state is input and line low
> state is output.
> 
> Signed-off-by: Dmitrii Sharikhin <d.sharikhin@yadro.com>
> ---
>   MAINTAINERS               |   6 ++
>   hw/gpio/Kconfig           |   4 +
>   hw/gpio/meson.build       |   1 +
>   hw/gpio/pcf8574.c         | 162 ++++++++++++++++++++++++++++++++++++++
>   include/hw/gpio/pcf8574.h |  15 ++++
>   5 files changed, 188 insertions(+)
>   create mode 100644 hw/gpio/pcf8574.c
>   create mode 100644 include/hw/gpio/pcf8574.h

Patch queued, thanks!

