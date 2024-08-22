Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 453E8C5320E
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 20:38:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shEZ8-0002OD-0m; Thu, 22 Aug 2024 16:37:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1shEZ5-0002ND-Ne
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 16:37:51 -0400
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1shEZ4-0002aC-6h
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 16:37:51 -0400
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-2689e7a941fso947170fac.3
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 13:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724359069; x=1724963869; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CrGu+Vx2RHAougBtwGJyAIOB3l9SX+Lc7D0MDbURQY0=;
 b=FtN+UviKYLlTV+o4YNtCrUTVWKwFy9jFcFYHbMpXrCpAIPFtvQ3qAHyjq/gLolra3M
 qJXO65JkQUUjLttItuPC/gk4Fz9vkiwZQtp/pttUaE+DoWlGyY/CXHbWcc+g8GjqO5QW
 xQlwZNH2O9hOth5FCWcNqUY05Zv+0ZJY7Gug7ogUCqg7islnV8FPKLU85whyGD6XNdwQ
 jJaFc5pWBOmfYgL/u4QQOJRbpHwiUG7gtOY5XnyM4lzGeP1M8vCYOQL1kHXhAUvweqch
 FrDxFpja8m/IJQuhHf8JFMjM2Izxo2n/yTxY+u9YCKBG55Sga9OrPoAG7sCIHXsyIlSY
 cvhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724359069; x=1724963869;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CrGu+Vx2RHAougBtwGJyAIOB3l9SX+Lc7D0MDbURQY0=;
 b=pUVQgbJOJwkiOF0tbxoTNs23GizzPHpGTl4RCKp8lEPDn2IHmvTUDbeceHooQApTOl
 AfZhX7p2m5aFAC4QFIGTE1HKJsUtq5N9tbzsQVPxz86ngoFc+aPSL5qJXSWS+n+WDivY
 fJMYJsaH/U2uD+4KvE9ArgtHZAnrL3MQhrlX8va3QNXQZ2Te0+MS7fwQ7wnsnLR/HDCV
 nUki1kiywjlT8qZAUGj6PijXh0M/c+5GYEfQK1Sw3pqP14bf6XM7aG63P4xTLxqA3HGW
 O2FC+e/z/aco0cwRn5u8wL4Vyh8gbVu6zGKaRVeONUxvBncurq2s+lqOnvghfmscwUPN
 KzEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0cTZpxRV8oApA6Fb/zI1ifoD9J9dZnmMlFif5kdWtcyZHqKR3MSXnMpxFHBpPMKcgCci88OPTS3Lo@nongnu.org
X-Gm-Message-State: AOJu0YyY3/PUpg1FLLUQQV8ovYKdNW8mDAGO0W3RxHW90I6AmEVnD0W/
 L21eYYA2gsfZ1rtUyf9kEO7vLbtqIkfmRLRWAgp9m2BElzahtVOPnCgTwW4evhk=
X-Google-Smtp-Source: AGHT+IFirUK3Rr1naHu29C9hAxH028fKfeL3jU3UZNRa1Rmx5sy5mg8ITa07OHtaqDLhQvFw/UXgAQ==
X-Received: by 2002:a05:6870:649e:b0:261:1b66:5ab1 with SMTP id
 586e51a60fabf-2737ef4b825mr7464045fac.21.1724359068749; 
 Thu, 22 Aug 2024 13:37:48 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::27bd? ([2604:3d08:9384:1d00::27bd])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7cd9ad7db5fsm1532932a12.92.2024.08.22.13.37.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Aug 2024 13:37:48 -0700 (PDT)
Message-ID: <bd4a4d18-1e4e-4f90-b9dc-7d0c4c2c3459@linaro.org>
Date: Thu, 22 Aug 2024 13:37:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] plugins: add plugin API to read guest memory
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: Rowan Hart <rowanbhart@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20240821235607.208622-1-rowanbhart@gmail.com>
 <d134a954-0380-41dc-9e3b-75e1dc2e2bbf@linaro.org>
In-Reply-To: <d134a954-0380-41dc-9e3b-75e1dc2e2bbf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-oa1-x2a.google.com
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



On 8/22/24 13:33, Pierrick Bouvier wrote:
>> + *
>> + * version 3:
>> + * - modified arguments and return value of qemu_plugin_insn_data to copy
>> + *   the data into a user-provided buffer instead of returning a pointer
>> + *   to the data.
>> + *
> 
> Is it a change left on your side, or a bad diff?
> 

Just saw it's a comment we forgot to add when bumping version. Thanks 
for changing it.

