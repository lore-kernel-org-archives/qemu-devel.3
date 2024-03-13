Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71552C54E66
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 15:08:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkQBq-0000QU-Lf; Wed, 13 Mar 2024 11:06:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkQBp-0000Q0-DG
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 11:06:45 -0400
Received: from mail-qv1-xf2c.google.com ([2607:f8b0:4864:20::f2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkQBn-0005Fk-R3
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 11:06:45 -0400
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-690c73735b5so34659596d6.3
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 08:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710342402; x=1710947202; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Tu0xD7ZBnedeOj/EZ3f7V7ofbAbfcxgSsqyDiiEt/h8=;
 b=a6R5OSjlu56cuwxfIXK/9dsVcNuS1u7Mx9djk+pCZgANlulK/WyrBWApgaUldf67sr
 KXC3VFhu6qefnJOM9uuIxrE/CiwUL0y3JaXbuDmim8f728rxH+gdjjcXy8Z1fwiyQ9Na
 zbtkkTYAZr9bE83hle3ZH0iCK31ecZeaiCfMTRetPUtNY0MWhToP7r8Bdp8+REJoVdCP
 HnIDRx/AqzBrlvzWwTQNms3BrBNk3ir91LZ/tgyHkKM/eBUT11Q5yNkjM2CuCPbLtL21
 S3FJ6KHdq6Y1gRvT3je+AoUnFu2R/7Pk6iOSo6cDl2o57+4anwVwJHNtb4346hKFLC0d
 JCrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710342402; x=1710947202;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Tu0xD7ZBnedeOj/EZ3f7V7ofbAbfcxgSsqyDiiEt/h8=;
 b=anEbIxyop5sQGw0LXu87MP6B0H+iYJbuTDpKGqqCRuIqNtwbRNgaucX82BjQUqdMlB
 y9U1GWdM/qNObLlqFfJPw1zSDDXGg+gLXz7WvfAeEj1IvxaEx9hX8k62140u2EfWz0Q0
 5cKownHylUhMvOR28miAZT/uya3yRKDwpOD6qJ6Z+fOccYlQZxgkNUd3CT/6ykTnFw43
 C2vfXrEGCTP6DjtZK/e/3ru3XuiZP3V0H+8KEbs29WRaC7UB4EgKBcfhRJVTi4fWHxPN
 UK4jI3VUJAkQU0+YBJEhzgc7UTPTC3pYxuRvYbbfZa58VP1MO4KCAPnmuEjD0hP7p0vC
 5VgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUSVUyBQHFY6efadoKwjFQIjCU+wCyrdR1U3IPurfOGucA61gUTqobJcoMa5p9R8tqHyCv4v11aTAVDNFAr7EhxzQqGk0=
X-Gm-Message-State: AOJu0Yw4RNsejHiCUJEWbkHX8wIlrQhtd31bLOGMtNdxPyZUM/ruLtQI
 6dgRw9SUJkK+jk2tuJ/RWDHNrEVVNAqv4rB3n1OfpODjvTteY9iHu7Ag3Wazk/M=
X-Google-Smtp-Source: AGHT+IGELHa+icgA2AYl88Li3eS89ZR/eJW/Va0Qm6+wycOZhr5BEvNk+qxYJ2hSyV6Q2J79Ao3EDg==
X-Received: by 2002:a0c:eb08:0:b0:690:74bf:9e7e with SMTP id
 j8-20020a0ceb08000000b0069074bf9e7emr57607qvp.64.1710342402481; 
 Wed, 13 Mar 2024 08:06:42 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.182.179])
 by smtp.gmail.com with ESMTPSA id
 e16-20020a056214163000b0069111c5cdd4sm894321qvw.100.2024.03.13.08.06.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Mar 2024 08:06:42 -0700 (PDT)
Message-ID: <06fb4fce-fd61-4813-9bbe-aeffdd5fd429@linaro.org>
Date: Wed, 13 Mar 2024 16:06:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] tests/avocado: use OpenBSD 7.4 for sbsa-ref
Content-Language: en-US
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-devel@nongnu.org
Cc: Radoslaw Biernacki <rad@semihalf.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Brad Smith <brad@comstyle.com>,
 qemu-arm@nongnu.org
References: <20240313-sbsa-ref-firmware-update-v1-0-e166703c5424@linaro.org>
 <20240313-sbsa-ref-firmware-update-v1-3-e166703c5424@linaro.org>
 <8c197bfe-0cab-47dd-beec-c9752d434a47@linaro.org>
 <fe2abd47-be73-496d-94a4-0b6d95f31bd1@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <fe2abd47-be73-496d-94a4-0b6d95f31bd1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2c;
 envelope-from=philmd@linaro.org; helo=mail-qv1-xf2c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 13/3/24 14:39, Marcin Juszkiewicz wrote:
> W dniu 13.03.2024 o 12:44, Philippe Mathieu-Daudé pisze:
>>> -        :avocado: tags=cpu:cortex-a57
>>> +        :avocado: tags=cpu:cortex-a57,os:openbsd
>>
>> IIRC for some reason we must use one tag per line... Even if
>> named 'tags', this is handled as a single tag, so we couldn't
>> filter on "os:openbsd". We need:
>>
>>    :avocado: tags=cpu:cortex-a57
>>    :avocado: tags=os:openbsd
> 
> OK. It worked when I tested this way:
> 
> $ make check-avocado AVOCADO_TAGS='machine:sbsa-ref,os:openbsd'
> [..]
>   (1/3) 
> tests/avocado/machine_aarch64_sbsaref.py:Aarch64SbsarefMachine.test_sbsaref_openbsd_cortex_a57: PASS (16.18 s)
>   (2/3) 
> tests/avocado/machine_aarch64_sbsaref.py:Aarch64SbsarefMachine.test_sbsaref_openbsd_neoverse_n1: PASS (16.06 s)
> 
> $ make check-avocado AVOCADO_TAGS='os:openbsd'

Oh great news, TIL!

> [..]
>   (1/3) 
> tests/avocado/machine_aarch64_sbsaref.py:Aarch64SbsarefMachine.test_sbsaref_openbsd_cortex_a57: PASS (16.18 s)
>   (2/3) 
> tests/avocado/machine_aarch64_sbsaref.py:Aarch64SbsarefMachine.test_sbsaref_openbsd_neoverse_n1: PASS (16.06 s)
> 


