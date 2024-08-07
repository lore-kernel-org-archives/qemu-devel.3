Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEA59C52D6F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 03:47:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbXe2-0000Sr-5H; Tue, 06 Aug 2024 23:47:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sbXe0-0000Mf-PJ
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 23:47:24 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sbXdz-0003Ps-0M
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 23:47:24 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1fc5296e214so13118555ad.0
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 20:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723002441; x=1723607241; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rMePUQ3LpHJEeKd6TGojMj79dN1NpaAlqdu9z4L6pMg=;
 b=rawmSzKxD8heNbO5l2Tg++Y/Ll+gBB8wrFolyD4fvmAsWobTzD2pIi85WfVKFQbTMj
 uXcwwBlamgMRIQNG9bprF2qOxpW5scaqbgVRmTAGuFhvTeiq4QaNKJeQtErG9D68AC7k
 fDnJFiryvsXdatzCmJKCwi8qIlhrwnKBdgb7MRzgJiLH8jjHmSccB+gUpTYFJ/GVmzIq
 DAhPdIH/ZJZULOB95/CkvJJIDbWs3tJUODqrvJ3J9vpkgvyatW19XFY6u/lHGBWwWk+G
 f862P66eEkHB9IN8UduPy2z2j1C6RsWPvADZErd7ASN2LoahTAo7DZiFxwMi08B9MTMw
 qChA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723002441; x=1723607241;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rMePUQ3LpHJEeKd6TGojMj79dN1NpaAlqdu9z4L6pMg=;
 b=Ty4SiLimqygeb+78LOvBxgilQaJqEmd9O8yWJpHSWjtQmWyq2xcW+9Gst/lRUDc+tk
 Jl6Uya94VtsbPW+2cJxUQb5yxDpfsHag+ZPAKbkNG8JKg1cXEYyaCyubaO5oJjicnNhp
 RR4FHYQsWk0BNOPdMS+ZHBe+t4HeDSOGnqaOKyeN0pjOYZf6wiSpF3LOqU8RshuS6f9E
 kS05oR1UqyqVTYnY+8dmH8XOWWWOOKzmR69LkMPMTpkyOccjbs2voATBYmcfE3bHkWru
 KowtCYnzdb26bTywojsVsQ/PgznNHhg0BMGIxUcRz0MKdZGv86PdTP65+I0dni9F2SdA
 t8IA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8l4jMqdmhMxnTbIDVbqYQ8P+QK9Ovbrzleb+xbS5SNeBSoBn3uCT5MVj5Da/PeFcEC0Lg9eOzGgvHybq99aIU4LWIcRM=
X-Gm-Message-State: AOJu0YyS2N0k9M5mt0b8sfOv1l8PgZ06FCY53AqcXxi8BJHu1piIDhXY
 DL0jNbB8409ZRnBPhbsu/WRRZcKAsPSqT9ghHffLjF2nNLLZgLW45bYAzkWniac=
X-Google-Smtp-Source: AGHT+IHGpNXqVFx4xpHW21RXKVtrWUPnHaUK8gb5ss4zbSVw+AG8gIVZE0qeUJIlchuuJzkq7cH5hQ==
X-Received: by 2002:a17:902:db02:b0:1fb:779e:4fd0 with SMTP id
 d9443c01a7336-1ff57294d1bmr199322375ad.24.1723002441253; 
 Tue, 06 Aug 2024 20:47:21 -0700 (PDT)
Received: from ?IPV6:2403:580a:f89b:0:e01b:92e5:d779:1bc0?
 (2403-580a-f89b-0-e01b-92e5-d779-1bc0.ip6.aussiebb.net.
 [2403:580a:f89b:0:e01b:92e5:d779:1bc0])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff58f19bd5sm95288145ad.50.2024.08.06.20.47.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Aug 2024 20:47:20 -0700 (PDT)
Message-ID: <4e45c886-cb93-4906-8559-65205703f52c@linaro.org>
Date: Wed, 7 Aug 2024 13:47:15 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-9.1? 2/2] hw/intc/arm_gic: Only provide
 query-gic-capabilities when GIC built-in
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>
References: <20240806141940.22095-1-philmd@linaro.org>
 <20240806141940.22095-3-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240806141940.22095-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 8/7/24 00:19, Philippe Mathieu-Daudé wrote:
> When configuring QEMU with --without-default-devices and
> not including machines using a GIC, the GIC model is not
> built in but the 'query-gic-capabilities' command still
> returns false hopes about GIC:
> 
>    {"execute": "query-gic-capabilities"}
>    {"return": [{"emulated": true, "version": 3, "kernel": false}, {"emulated": true, "version": 2, "kernel": false}]}
> 
> Restrict the command to when the GIC is available. If it
> isn't we'll get:
> 
>    { "execute": "query-gic-capabilities" }
>    {"error": {"class": "CommandNotFound", "desc": "The command query-gic-capabilities has not been found"}}
> 
> Resolves:https://gitlab.com/qemu-project/qemu/-/issues/2484
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   qapi/misc-target.json | 4 ++--
>   hw/intc/arm_gic_qmp.c | 2 ++
>   hw/intc/meson.build   | 2 +-
>   3 files changed, 5 insertions(+), 3 deletions(-)

Ah, nevermind my final question for patch 1.

Entire series:
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

