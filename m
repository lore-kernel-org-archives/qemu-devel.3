Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38A6FF3026D
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2026 16:48:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w1odH-0000kc-UI; Sun, 15 Mar 2026 12:48:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w1od1-0000iC-Tq
 for qemu-devel@nongnu.org; Sun, 15 Mar 2026 12:47:49 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w1ocz-0004ZZ-No
 for qemu-devel@nongnu.org; Sun, 15 Mar 2026 12:47:47 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-43b3d9d0695so546969f8f.0
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2026 09:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773593264; x=1774198064; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=APnRQpeQTBfInwWzJ7QvsK+ujKSIITJd1fXWkcuTBag=;
 b=dp4/gGk/eFrOS3gg5lc8a4RwleCITEta5hlK26qeKZOUxALTTtTQ3Xm9h8INQbeqgf
 cXsyq0Yrf8KkmRY7ovMU+nC3BhGYwkrJdbtX2g1YJXlGRIYtQE+c5x/kBmrjFeYBDU1l
 Ccz82j/1DF4WYx7mqGoWoKZllL1E1tf8ROGeQUngIcKPrsvspAeXDDW50O7cgGczdGAE
 yakNTvildgJSua1KbF1ewtUiKh4kjaVQVh2WncLa8VSDSDnl1OMkmsPULfXxP9dCEmYW
 wjthwC7Tx4BZxzIPv2mkFBxnau9Nt8D/jXPU9sk1Ox7TGLDM4gMZwljbB9gGpdTMEgtM
 dChQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773593264; x=1774198064;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=APnRQpeQTBfInwWzJ7QvsK+ujKSIITJd1fXWkcuTBag=;
 b=MCiG5lN60d0Dw+7Rvs2NERJjkc0ZS889VppfX71QehYoI+ys/04lRnzvyAqeBpSRzo
 FZu0fvfJDRzQprEyBK5m8f8ukN3/SpBwfbGPQxXm31X2JUvUpyG7F8Bxr8Sso0Y3Rxi/
 H+sSNozEE7YtGrXjMNCxyQ5YpjiKBJkP673I2WHdnqBma3s91zN6BYfOs1v9y1RbyZfA
 WQ0IiyNAwMwpJm0aRdZnpsWZ+oWIeJH426jk3c0DmBV3jRYaTDLFShEb87LT1RA4JmKH
 ocKoF2ouQZEsGUkvxQUZlfxXgn+q1NjDHZpQyUcLIE7Lukber+XHya3qosO9xvSvZtc6
 BW5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDuwfUtc1R1A0JWvDpHmBYnYP4+SMn1TZEdK1bY9h/xfoqmbTz8iLmpbeY6qPgyPMpVvDX/MX254Sa@nongnu.org
X-Gm-Message-State: AOJu0YwFaX1f2ZSI0RJZF8aJdaP7GjmuxmIPx6bPyMRh0Nx/lDBdg9mN
 Ns4NcuA3+9Hj6gWIaM2DXB65XODxCadLy9LEwO5nlunUk+6QJu2D7LVeHHYHHLSz3+c=
X-Gm-Gg: ATEYQzyvPMeDqLD64lYo0JGpZxmEqFasceg+srrKusb4KMAliBH7B0/G4Aa9Qb+HCOQ
 aie4H/k4D0Sl+BF/71InpwK0zKszhNOl/3moERDlXp6Z3NH7CSt9c40WRcBfqEJPa75/dWr8vij
 d1esddE0vFjTTRynadydOo9KD/m+2B1Tb+Cq4ixjzYo3DS1qj0uAA9X9jmGUQiiR/j/NU+6dbPI
 qKjhmwvDSL4YKf+AuXedjBF7BXRS+eACdCKQ1LQbygJ/QKN/tURMq4HYHKceUHyFLg29ZQMndww
 8pAPg9be8Ve7q31hMG1RDGkl0AZLybR+PZA6uLtZgV1YHMl4/bxtXTp4WmcIISUGIzgDOJw6+qI
 WD736FmP28cSAiRHIiIhGV2gQ3tD3iWG7NKzK2egNtE5GEdabgz9v8POMha4l9vDdYdn3EisUp5
 791fncvGdLllHLBY8XqmiqE94ZbaRqjfIFXvuczeaA+ezc15e1Fce1K/OEPlp+xGfTSIiRXAiDE
 TM6
X-Received: by 2002:a05:6000:2313:b0:439:b775:fca2 with SMTP id
 ffacd0b85a97d-43a04dbb74emr18092864f8f.24.1773593263693; 
 Sun, 15 Mar 2026 09:47:43 -0700 (PDT)
Received: from [192.168.69.206] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe20b899sm34521232f8f.23.2026.03.15.09.47.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Mar 2026 09:47:42 -0700 (PDT)
Message-ID: <c0856af2-b527-4bf0-bf4f-e0cd2065f23c@linaro.org>
Date: Sun, 15 Mar 2026 17:47:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] hw/vfio/pci-quirks.c: remove CONFIG_VFIO_IGD
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, eric.auger@redhat.com
References: <20260312224449.1605071-1-pierrick.bouvier@linaro.org>
 <20260312224449.1605071-4-pierrick.bouvier@linaro.org>
 <6492850c-12b6-4687-a07a-99530e2553ae@linaro.org>
 <b34a072b-6933-4fe5-bd75-5911979284f4@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <b34a072b-6933-4fe5-bd75-5911979284f4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 15/3/26 03:57, Pierrick Bouvier wrote:
> On 3/12/26 8:20 PM, Philippe Mathieu-Daudé wrote:
>> On 12/3/26 23:44, Pierrick Bouvier wrote:
>>> Add stubs for needed functions.
>>>
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>> ---
>>>    hw/vfio/igd-stubs.c  | 20 ++++++++++++++++++++
>>>    hw/vfio/pci-quirks.c |  5 -----
>>>    hw/vfio/meson.build  |  3 ++-
>>>    3 files changed, 22 insertions(+), 6 deletions(-)
>>>    create mode 100644 hw/vfio/igd-stubs.c
>>
>>
>>> diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
>>> index f32d8573600..562ba79d1c0 100644
>>> --- a/hw/vfio/meson.build
>>> +++ b/hw/vfio/meson.build
>>> @@ -16,7 +16,8 @@ vfio_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
>>>    ))
>>>    vfio_ss.add(when: 'CONFIG_VFIO_CCW', if_true: files('ccw.c'))
>>>    vfio_ss.add(when: 'CONFIG_VFIO_AP', if_true: files('ap.c'))
>>> -vfio_ss.add(when: 'CONFIG_VFIO_IGD', if_true: files('igd.c'))
>>> +vfio_ss.add(when: 'CONFIG_VFIO_IGD', if_true: files('igd.c'),
>>> +                                     if_false: files('igd-stubs.c'))
>>
>> Directly add to global stubs source set, otherwise:
>>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> To share some information, using the global stub mechanism instead of 
> subsystem ones makes one difference: some dependencies are not included. 
> In the case of this stub file, pixman.h and epoxy/gl.h are transitively 
> included, which is solved by adding those dependencies to qemuutil library.

Yep, this explains and fixes the failure I had with this patch:

https://lore.kernel.org/qemu-devel/20260225035739.42848-8-philmd@linaro.org/

Thanks!

> 
> Nothing too complex, but just worth mentioning in case you ran into an 
> issue similar for other stubs.
> 
> Regards,
> Pierrick


