Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FA08C04FF0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 17:23:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruy8l-0000Ci-9c; Thu, 11 Apr 2024 13:23:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruy8k-0000CF-8g
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 13:23:10 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruy8i-0005U3-2e
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 13:23:09 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2d8b194341eso9001fa.3
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 10:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712856186; x=1713460986; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=i3w15Wk+ZL5iWgEvuBBjIBj+Q+8fe3DE8zgycHv7d8Q=;
 b=XdiNdz7KmtGHfv8mjbTmrWZ/VoBVk6G97R1OTVLQzsEg4BUB9HvDWZgIC4EWMHL/Do
 MdPxNxj6q0lI4oi46RztO0omPWMeuEibjZlwtDp0NxMafr/xH6HBH/0KqhB9n2qN5RGq
 SbSQjMtmMb84/QJMPW6amxiglTiYdZdaBsY72cJ87yh1p4zT/waTCcXuamm79Rihkru5
 z/1RcNRfSom9UWGJIu9/r9i1e0fBo8rcihJLZyUmCpvcms74wtBYq+VJOrJEeG4P88OA
 xAk2584UjVvAnsS/b70ItfXJ16aF9WuSpmkY60TyB30LRTrfv5kBDdO9ffY0hi3oTga1
 j36Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712856186; x=1713460986;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i3w15Wk+ZL5iWgEvuBBjIBj+Q+8fe3DE8zgycHv7d8Q=;
 b=FCeUJiEIYm82NFyMPQwvbFjBVkmSWzroSkwrFE6ZzV/WMCqJ31MqVVgZbBrz8OOK1V
 HG/6rpQnqIebHtTaQ6NFBwG4VRqa+h+006FPwmBg8G1xUcdyXJsd8n1p/M1ajzmO9+C8
 Kh/4rzWEHovO95md9DBOXzfS/NyMDXgVf8HHy6X3l4NoxBTNi8IFR6M8ht4iinbjAefy
 m7ozt15JClbRZJSTjYAvmu7qAUD4nGxpP59JSwWZm/8X0NAKwShk5/PyWWWStr+5LyVa
 drPBagznJBOZ5C9KLV1Fo8Pf4he70V76bEomvNi1k/DUffsAQZlis1yBqXgQ9yYd02b6
 Wn/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4EPr28beyZgCGF+Tuf71AQMovBlyeIT3zGUtkIiwz+NL5ArNYq4MwVcMvxe6sT24M9uL5e4CTIjKWGmDQDp8wgGMkLg0=
X-Gm-Message-State: AOJu0YzaBj20lL+c2z0FraHEKw88SLvKKeUyJ2k4/+mFCBAOfqUMuvuM
 QvzW+8H/8Zlro8gBotQwH87wJDhtljgmzOcAlXzv9OUz6fzEI7T0LgJVVPxSZDI=
X-Google-Smtp-Source: AGHT+IE2Jdl10gm8YigUNIfSfk5H3NR6A36wyLSOMXKimFUz/pny4UQzU2IhDYl5phC8GWqttSv24g==
X-Received: by 2002:a05:651c:33c:b0:2d9:fe84:a485 with SMTP id
 b28-20020a05651c033c00b002d9fe84a485mr140317ljp.29.1712856186312; 
 Thu, 11 Apr 2024 10:23:06 -0700 (PDT)
Received: from [192.168.120.175] (31.red-95-127-88.dynamicip.rima-tde.net.
 [95.127.88.31]) by smtp.gmail.com with ESMTPSA id
 fk7-20020a05600c0cc700b00417c434a340sm2937981wmb.21.2024.04.11.10.23.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Apr 2024 10:23:05 -0700 (PDT)
Message-ID: <6b384586-c7ad-4b6c-a1f1-8a8d8b0ad526@linaro.org>
Date: Thu, 11 Apr 2024 19:23:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/10] hw/core: create Resettable QOM interface
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, berrange@redhat.com, david@gibson.dropbear.id.au,
 Damien Hedde <damien.hedde@dahe.fr>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20190821163341.16309-1-damien.hedde@greensocs.com>
 <20190821163341.16309-3-damien.hedde@greensocs.com>
 <CAFEAcA8FUgmnq0-QfutpbN=xkeKxRe75b56Fu2zoXknXczwnvA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA8FUgmnq0-QfutpbN=xkeKxRe75b56Fu2zoXknXczwnvA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x235.google.com
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

On 11/4/24 15:43, Peter Maydell wrote:
> On Wed, 21 Aug 2019 at 17:34, Damien Hedde <damien.hedde@greensocs.com> wrote:
>>
>> This commit defines an interface allowing multi-phase reset. This aims
>> to solve a problem of the actual single-phase reset (built in
>> DeviceClass and BusClass): reset behavior is dependent on the order
>> in which reset handlers are called. In particular doing external
>> side-effect (like setting an qemu_irq) is problematic because receiving
>> object may not be reset yet.
> 
> So, I wanted to drag up this ancient patch to ask a couple
> of Resettable questions, because I'm working on adding a
> new ResetType (the equivalent of SHUTDOWN_CAUSE_SNAPSHOT_LOAD).
> 
>> +/**
>> + * ResetType:
>> + * Types of reset.
>> + *
>> + * + Cold: reset resulting from a power cycle of the object.
>> + *
>> + * TODO: Support has to be added to handle more types. In particular,
>> + * ResetState structure needs to be expanded.
>> + */
> 
> Does anybody remember what this TODO comment is about? What
> in particular would need to be in the ResetState struct
> to allow another type to be added?

IIRC this comes from this discussion:
https://lore.kernel.org/qemu-devel/7c193b33-8188-2cda-cbf2-fb545254458b@greensocs.com/
Updated in this patch (see after '---' description):
https://lore.kernel.org/qemu-devel/20191018150630.31099-9-damien.hedde@greensocs.com/

> 
>> +typedef enum ResetType {
>> +    RESET_TYPE_COLD,
>> +} ResetType;
> 
>> +typedef void (*ResettableInitPhase)(Object *obj, ResetType type);
>> +typedef void (*ResettableHoldPhase)(Object *obj);
>> +typedef void (*ResettableExitPhase)(Object *obj);
> 
> Was there a reason why we only pass the ResetType to the init
> phase method, and not also to the hold and exit phases ?
> Given that many devices don't need to implement init, it
> seems awkward to require them to do so just to stash the
> ResetType somewhere so they can look at it in the hold
> or exit phase, so I was thinking about adding the argument
> to the other two phase methods.

You are right, the type should be propagated to to all phase
handlers.

> 
> thanks
> -- PMM


