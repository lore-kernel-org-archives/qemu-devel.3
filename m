Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 051BBC02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 16:28:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbMXV-0002vh-3o; Fri, 24 Jan 2025 11:28:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbMXS-0002vS-9E
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:28:11 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbMXN-0005HF-Go
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:28:10 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4361815b96cso15911545e9.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 08:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737736084; x=1738340884; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eQuYG7upoxbpOPXjG+3hYlhADqAHOSeKyfZmWngrDto=;
 b=gBXVsLjtsn6mKYE8zqK24jYI3dZbG2PB3vuhrxstsc0y1qtcHv0Ff3dsWXdscnidZz
 2Npz6iMi/e+3FX8JO7F7fUVV39LOo0rmnLILiBolwQZm+eqp3Sotwxs73vAP9QFXSIub
 IaNXs2RvlJnQBZhejwMoDK6zx9BnCMWndpHJ5cdwklgEC/OQAsQin+vXEdH4sfGlFpSS
 +/mgaJjKbt3kjYBMUGFtMJTE8gmpEmjD5KNQcCc1PE9G++2z7hMOVVpYCoooy44XmVoP
 dVhwxT9DeVohR1XbGQn/PDHr1Tviwi7Xg0lbpbLk1aGBMivZflmpjcIxXURVijQeGe5D
 bICw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737736084; x=1738340884;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eQuYG7upoxbpOPXjG+3hYlhADqAHOSeKyfZmWngrDto=;
 b=i0K7C22XTfvckGP+cmqK07oxzU/bkyZejs3PpmNS+lS+YdesFqjwQ2Eyww+27wIJqG
 l4e73BOa2UsjJoqVc0LsUI5sN/JdEOdM80HBVrt+30GNj0jZUv2tweuzgEMlC2h1myPN
 zVlPR2lCuR1Ry0jtJRFAnlw0PKpUvSP4dc4X8UsdilR8GPwixl2GoEV1ZCZkc44ozXdP
 azkQ3YwQo6lfdk3ke3PSalasEYDeB/J5zMZc0lqGOZuYxibU8DKnbk+mJXO3vOY0HER2
 kG4HmwsOz5LgMfc+YgHWff/dgd6pAx0GMLCF8Uq39x1G4uEmECoY6HmiqJKBcCKcb4/u
 2ekw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWK8lvZKwadDKpVaUkbbaEGBWNUXBJqyyuuf/Esh9muEX1SxeHLFGq0kxBmIbGzUeyF3OUVsL1P5LJU@nongnu.org
X-Gm-Message-State: AOJu0Ywq7dM868kFfW0mX1WY4wyKoE/qWbzi6D+WVrR8k7jHxxFe8S/S
 6X8Jg4b65Ch8lHIa5HIYZMPt6tlcHtI1Z/7S6Ez5jSg+MyqTEBSp1gnHQZ1VVtE=
X-Gm-Gg: ASbGnctZHOH5iNpV5v3RtqUoYTSxDQ+XsLPjH3vzTEg6Vh5g/U6Endyz/KbOu89NLBw
 EBdondGkEq9GHLHPDiBtB0vuRPJEfp3C9tLWzfMOg4oGHXO14mdaomYD1RWafzbpHL5DlaRo2F0
 jhPmYYxY3AYkMq+obs1VGoh2x0d7xJs9j6l5UHuEPcBeMd192/psUCJTTAEOC//zoHjkYRYVVSZ
 CtvZxHbQS71q/8R/pOeWCDPvQizq4BPL1yEaVtQIqNIuLCgGELmqZcsLn1eoKKe7fjC+lOP0mmp
 sHsKKzYX1BBL0ntza+/Z8PqnEaDE+zRXLXL4qAf5G0tOM79A
X-Google-Smtp-Source: AGHT+IG3fmCKw+a3pBlf1FnYOYJRCJUC5s8+rT9MvnA/uEYAXeBwBEQNZ4XYHFtjFYFtk9LZLsHE0A==
X-Received: by 2002:a05:600c:450e:b0:436:1ac2:1ad2 with SMTP id
 5b1f17b1804b1-43891427485mr255507925e9.19.1737736083712; 
 Fri, 24 Jan 2025 08:28:03 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438b1d904cbsm54934015e9.1.2025.01.24.08.28.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jan 2025 08:28:03 -0800 (PST)
Message-ID: <d5749a49-a12f-4485-b2f1-189b3d9cc89e@linaro.org>
Date: Fri, 24 Jan 2025 17:28:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hw/cxl: Allow tracing component I/O accesses
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Jonathan Cameron via <qemu-devel@nongnu.org>
Cc: Fan Ni <fan.ni@samsung.com>, Paolo Bonzini <pbonzini@redhat.com>,
 mst@redhat.com
References: <20250122065624.34203-1-philmd@linaro.org>
 <20250122065624.34203-3-philmd@linaro.org>
 <20250123095151.000041a0@huawei.com> <20250124162028.0000464b@huawei.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250124162028.0000464b@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 24/1/25 17:20, Jonathan Cameron wrote:
> On Thu, 23 Jan 2025 09:51:51 +0000
> Jonathan Cameron via <qemu-devel@nongnu.org> wrote:
> 
>> On Wed, 22 Jan 2025 07:56:24 +0100
>> Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>>> Map the component I/O region as UnimplementedDevice
>>> to be able to trace guest I/O accesses with '-d unimp'.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> I'm not that familiar with this infrastructure but seems
>> fine to me.
>>
>> I'd definitely be curious if anything is touching this space so
>> tracing may be helpful for that!
> Hi Philippe
> 
>>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Retract that.
> 
> Can't instantiate a CXL device with this patch because:
> 
> Device unimplemented-device can not be dynamically instantiated.

Hmm the qtests using CXL devices pass, how do you trigger that?

> 
> Reverting this patch on my tree fixes that.
> 
>>> ---
>>>   include/hw/cxl/cxl_component.h |  3 ++-
>>>   hw/cxl/cxl-component-utils.c   | 14 +++++++++++---
>>>   hw/cxl/Kconfig                 |  1 +
>>>   3 files changed, 14 insertions(+), 4 deletions(-)


