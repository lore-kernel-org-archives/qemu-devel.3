Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E71951091910
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 18:43:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3IKR-0000A1-Rv; Thu, 19 Mar 2026 14:42:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w3IKQ-00008v-3J
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 14:42:42 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w3IKN-0006fi-Fb
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 14:42:41 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2ab46931cf1so19679295ad.0
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 11:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773945757; x=1774550557; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=2zEY3sRdBxwMoT/ejUW4SUFuI7keG9LgfeRpl/SD92I=;
 b=Ej4lsWBLQbKfSG5y441tcuSo6vvCDQCPayPdyVR1EP1Lk9kFRPU/AK/dwL/LtF359B
 RMtQ0/y+XwXlk9YNorXrazctoYMPHPj0tx2Gp6x3ATthRuoGthpKb/tE3qHC3buS6P+9
 LtJ/PO/lnV6HCTnf6zsEuTaVI4RCJMoHQyGeB6eBjRmieLTdrX6DC8e2FvL/lYHUhxNG
 56gMIDo4/L07S+UxW1EJH+ta0B+r/PSdWRqv5j3yJe53rnZ59R6O3EtTNE/31bcL9ULY
 exPBXJEAG7onZ6xdT6K9azgU6Eg5EB7WwZcsTztSXl9bAttiIJvnJoskTExckaBy8M3V
 jBhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773945757; x=1774550557;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2zEY3sRdBxwMoT/ejUW4SUFuI7keG9LgfeRpl/SD92I=;
 b=abPRJaO1PQJF89M2C43SLSV8fqo+v7QPF34QzP1dZJTWEYYDkcAOhkbtkao9dp/Nay
 DObb1/EbZIDfRspSlW4ra2MJU90Mxc80/+PEaI9GqUT9uXsBTtizZmGBcZBmtTbwc8h6
 8oMb32A26IpdDOeBDldauiXWHPtB7/ov9mRrfgdQApPIKWnrMyA/0fpmbbgtz6Bjp2uQ
 Qod/AQHu+SVycZlK6khaaHEWjYOaopMENd/ADpEqXxekkAc7xYPfTEGJRSPKd35Ph58O
 0U7/lYewKzuqUqY7mKdsRSKGC7EcTPXImONK8cwljuH2ldMJfW/TXyED37/ohkUdWMD9
 zSJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzFIrmnyvfa1PYp1tF2uM78+pxY3IlXwg8ToKg4iM0sEvXe9n2G/58SDQHSiKqGlNUcTAupCvRgR+g@nongnu.org
X-Gm-Message-State: AOJu0Yy8Xug/qTY77GdTKY6ee4RuGZe7VyRV9ynkNa4pDPw/NXd24KZa
 vkWy2dvE3neYQAQxa2N4IM6WYY30g/5i5R/+oY8NUP6MwgE4p9UMM6BJ2Sg6Yy2HBTE=
X-Gm-Gg: ATEYQzxKhCQCE2JMR66hw160Squ6yMn9OhUFBrHhpaatwzpOY/0JM6zhyGihx/gC7z3
 lDkxv4Rv3VIQUqRvDc6KUTpaPBh4awFUFlhiIRHwIAQBmgdhW8L+vtDcHBSqplioh13BSGnq3FB
 bI2mzdI2kgCXbH4sL/nHA7ff3wKk3T8bNmc0P1Sb7VNMxmttPSoTM55+e+n9Vbq3avhYJad67b2
 ZeXY75Ao+l/Ozq+s6yBW7Vu98rTQb/EEPJKZ/k+jLovQrhZ7IbISsyMT1DyF2Kj0+Mi9ZQWHuIN
 B7DfJ2ks0+kvlhRX8yog50pLoeD/hV381d0sz66GRpM/PUtkAiFAg8PS+vjM2ayWE4vaOzMm1Pw
 MfuWYDN4SbR0he/TCzFOZgAX4mnzZP365w5Fmt+6+uTxkY0QA8FlJA5XlssCmnFUyzW/E7QpPsk
 xsSIcoPKfpRr//kPwwecwK7lPznhgcamWSexRPucCnuBrOuRerw/OlRBP3jfMF24uOj4CY2mLc3
 mqmVqY=
X-Received: by 2002:a17:902:c94b:b0:2ae:7edd:c86f with SMTP id
 d9443c01a7336-2b077127329mr39785615ad.4.1773945757314; 
 Thu, 19 Mar 2026 11:42:37 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b06e5ef42asm80972245ad.40.2026.03.19.11.42.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Mar 2026 11:42:36 -0700 (PDT)
Message-ID: <0301759f-803e-474a-979a-10a4d3ad2913@linaro.org>
Date: Thu, 19 Mar 2026 11:42:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.0] Fix several typos in documentation (found by
 codespell)
To: Stefan Weil <sw@weilnetz.de>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, John Snow <jsnow@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
References: <20260319183453.100545-1-sw@weilnetz.de>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260319183453.100545-1-sw@weilnetz.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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

On 3/19/26 11:34 AM, Stefan Weil wrote:
> Signed-off-by: Stefan Weil <sw@weilnetz.de>
> 
> These typos are part of the generated documentation.
> Therefore they should be fixed in the new release.
> 
> More typos can be found in the remaining code, mostly in comments.
> 
> Regards,
> Stefan
> 
> ---
>   contrib/plugins/traps.c        | 2 +-
>   docs/about/emulation.rst       | 2 +-
>   docs/devel/code-provenance.rst | 4 ++--
>   docs/system/tls.rst            | 8 ++++----
>   hw/arm/virt.c                  | 2 +-
>   include/hw/arm/virt.h          | 2 +-
>   include/plugins/qemu-plugin.h  | 2 +-
>   qapi/block-core.json           | 6 +++---
>   qapi/job.json                  | 2 +-
>   qapi/uefi.json                 | 2 +-
>   qemu-options.hx                | 4 ++--
>   11 files changed, 18 insertions(+), 18 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

