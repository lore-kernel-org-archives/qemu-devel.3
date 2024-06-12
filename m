Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED0E1C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 13:46:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHOIV-0006bu-SK; Wed, 12 Jun 2024 09:45:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sHOIM-0006ax-RL
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 09:45:50 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sHOIK-0000bd-9t
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 09:45:46 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-52bc3130ae6so5387606e87.3
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 06:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718199942; x=1718804742; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3iMuEOSqVyKNMU1vKgc/9cJtilerGT1O4PEnMf0TI5k=;
 b=bvUjVJE+4WyJgmjGmWhnPdGwjXXEyMTLV7X4q/Ma71PavNx+CnfDcpSeUcl1vHR9n2
 1kGDOyO9/RYsIrVAl+7WvSfDploeLQnKwavksH3LIxR3ZzoY04JQsXbM7/yRjhv9EYNi
 O39F5gYJg8M7HtBwDOG9sjQLMDPQHwvivC7WQnesk/tPviP4GY5vNkhw7jcSeAG5FDcc
 F5acTjZpHHlcD4JrYsKOzYju/zUETK1GQ02NJyOZKF07jl8sqyt9mtEfJSXq+imFFQX3
 RP+RRnTHYo0JoylQnLHzvCqhOdv9MzDSN8XZtTJtfAHbwRw8qKJKN2r4kz2hSGYc6ycz
 no/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718199942; x=1718804742;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3iMuEOSqVyKNMU1vKgc/9cJtilerGT1O4PEnMf0TI5k=;
 b=JziezMU+LTSWA7tyXKiTSb5GEqmicAuo3HIuAJoXYxNh2kUaBM8zNJBVCmYWOoStZi
 d8wf5vZBthaorVwMeGSC+y4UB2MBeOiPV0hFGXhr4YRrKoSrbrPoG2kFOY0hec2GOP65
 fo5m4Koyc/LZPisfFEdHJM3JSlull6MBbX/nIszTIVEgTN+31hpPZR1j5JBfMvY0KpFh
 QPADzbOjqMmk7tRWFIg5LCnpSv/Ak9auIBKwLm2nQ3mvfGYyMZZB8Q0135ZRVAXMyZfq
 wM23XT7Ob2ctvHXNIy0B7NiJpqle+12dSzYBumobUoshC9qILkudGF5crZb8pLq1J3lR
 c3eg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdHcXpee/8j3gogC27cLW5vo/KtZf4N9NQq9dX663RbBRiWeOc0WnIH1gYxi1MKdv2F4u7F4La6PaPvNIbliJeqpKvFT8=
X-Gm-Message-State: AOJu0YwETr3GWlg7yKz+DYwxtVGSVWRTzTmAK1r7xvobIjWHhiBoNHux
 +zWZIMDI+9Z5k7lpHmBO5oidU1TwpA01gEdH7xnibBgpTbZA733J452gOS012NY=
X-Google-Smtp-Source: AGHT+IEaM/obTlsMPLH3flzu1jdIdpnAlOXOFxUqGXRegM1Y4Pgjr7yGxxhaTndHkNZhj336kaRJag==
X-Received: by 2002:a05:6512:3055:b0:52c:89b5:27b3 with SMTP id
 2adb3069b0e04-52c9a3fdf47mr1549604e87.42.1718199942422; 
 Wed, 12 Jun 2024 06:45:42 -0700 (PDT)
Received: from [192.168.69.100] (ram94-h02-176-184-0-172.dsl.sta.abo.bbox.fr.
 [176.184.0.172]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-52c97db2356sm401521e87.200.2024.06.12.06.45.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Jun 2024 06:45:41 -0700 (PDT)
Message-ID: <ffd4dcb3-3777-4335-9a33-9818dd413b8d@linaro.org>
Date: Wed, 12 Jun 2024 15:45:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 21/22] qapi: Inline and remove QERR_UNSUPPORTED
 definition
To: Markus Armbruster <armbru@redhat.com>
Cc: Konstantin Kostiuk <kkostiuk@redhat.com>,
 Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-block@nongnu.org,
 qemu-s390x@nongnu.org
References: <20231005045041.52649-1-philmd@linaro.org>
 <20231005045041.52649-22-philmd@linaro.org> <87mswx5n63.fsf@pond.sub.org>
 <18739a67-84bb-4fd3-adb6-0db0f0eb7af1@linaro.org>
 <87plsmfgxq.fsf@pond.sub.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87plsmfgxq.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x133.google.com
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

On 12/6/24 15:07, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
>> Michael, Konstantin, QERR_UNSUPPORTED is only used by QGA.
>>
>> Do you mind giving our maintainer's position on Markus
>> analysis so we can know how to proceed with this definition?
> 
> Daniel Berrangé recently posted patches that get rid of most instances
> of QERR_UNSUPPORTED:
> 
>      [PATCH 00/20] qga: clean up command source locations and conditionals
>      https://lore.kernel.org/qemu-devel/20240604134933.220112-1-berrange@redhat.com/
> 
> I pointed out a possible opportunity to remove even more.
> 
> I think we should let the dust settle there, then figure out how to
> eliminate remaining QERR_UNSUPPORTED, if any.

Ah great, thanks for the update :)


