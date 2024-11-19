Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 335AED62060
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 09:57:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDKyS-0003UO-Oq; Tue, 19 Nov 2024 04:56:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1tDKyS-0003UC-3O
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 04:56:44 -0500
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1tDKyQ-0006FO-9P
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 04:56:43 -0500
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a9ed7d8c86cso823521866b.2
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 01:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732010200; x=1732615000; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=5LTFzYQmPxYDonB5fe7UjSYJHb2KlfJAa4k+kdB4/R4=;
 b=QEDBGCR3VvRTNGcnIHxbvADgx3gNXXanEQKRvqRkuWhxF+4v7jt+bEifGlKYD8op96
 PkRTnix7HyBzPHJcjXMI3QNGYUjRdJZP273DjHiyYN2Mk85o5BXNXDOuqIUJ73d3yCzH
 BiFvwyCwlet8/vtzX6EcLKebS6qjnVTyXCfP2CDRZHEdMrxUgWnL0NG4DimHjmQ7cT1D
 rGTW2o46R6byQEcfPnYI563d95Spvh/pRS6zdYU886B3KtGD7hGYXWfXDTBjsVPSkKNn
 fW4N2yrWysfKjFLWZH1i9Wivnc9PPKIhlCx6jNZ2UH20SEfFvUd+LPPMwoMx6LZdjZeY
 PHmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732010200; x=1732615000;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5LTFzYQmPxYDonB5fe7UjSYJHb2KlfJAa4k+kdB4/R4=;
 b=Qb2cfJtv1qosXG4NIDXx7FeMWMU+2KCWoY6m7JJQZSi9UzST4Nn6FL5uJWrH24WAYJ
 MnL2/tyyt+e+H9sk//T54nxpJjI2ZVc4dFS/GQIovbe9wVVDfIvwDCTo5KwIFBgRJJ9k
 al4tANFU4O4I+e345FiyXfdBd/EAfVeopfP9tOL+Q1Ts1oONOC83ZtqRQbgPii0I9fXn
 mmJ/IM/NJcsVsEC+cluWmKnDInKhuZlDaPIymh4qIR8ENQ28uHoCnXr1f3hyKHKNYPQk
 A8oSezl6VtwPEqcIaURyiPbe3B4CKwk/WLAOs6oVgl345rpXJS89wYNayhmhnLFiXxzM
 4UbA==
X-Gm-Message-State: AOJu0YxK9wDmE2uk7AEz6+rprDrEwy0j+jNpsraVps4E/1BZ2rbzAAKZ
 RUcdta0o6chvdDnmaJ7ITKnYit8Agxal59il6tLhM3KXfL5xKYCmCvDwcna45/w=
X-Google-Smtp-Source: AGHT+IF3+jmxr4QshurKhK8jdb65Rbq+5wSWdMSzKgS84eR4qPPebPVvPe114OMoDeZ/vyZZdUVCGQ==
X-Received: by 2002:a17:907:7f23:b0:a9e:f28c:374a with SMTP id
 a640c23a62f3a-aa4834544a3mr1313757366b.32.1732010200503; 
 Tue, 19 Nov 2024 01:56:40 -0800 (PST)
Received: from [192.168.210.26] (83.11.2.232.ipv4.supernova.orange.pl.
 [83.11.2.232]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa20e086098sm635405066b.190.2024.11.19.01.56.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Nov 2024 01:56:39 -0800 (PST)
Message-ID: <47831adc-26f7-4633-a371-975c97e8dae7@linaro.org>
Date: Tue, 19 Nov 2024 10:56:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] docs/devel: add b4 for patch retrieval
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>,
 Andrew Melnychenko <andrew@daynix.com>, Jason Wang <jasowang@redhat.com>,
 Thomas Huth <thuth@redhat.com>, alex.bennee@linaro.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 qemu-arm@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 manos.pitsidianakis@linaro.org, qemu-block@nongnu.org,
 Michael Roth <michael.roth@amd.com>, Konstantin Kostiuk
 <kkostiuk@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, gustavo.romero@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20241118172357.475281-1-pierrick.bouvier@linaro.org>
 <20241118172357.475281-4-pierrick.bouvier@linaro.org>
 <ZzxXAtuRowg8hp9u@redhat.com>
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Language: pl-PL, en-GB
Organization: Linaro
In-Reply-To: <ZzxXAtuRowg8hp9u@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-ej1-x634.google.com
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

W dniu 19.11.2024 o 10:14, Daniel P. Berrangé pisze:

>> +    b4 shazam $msg-id
> 
> I'm wondering how b4 knows where to find the mails for $msg-id  for QEMU ?

It goes for https://lore.kernel.org/qemu-devel/$msg-id by default or 
checks b4.midmask in git config.

