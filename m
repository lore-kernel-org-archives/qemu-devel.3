Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAD1D10F284B
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 16:18:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w69t8-0002Y4-HB; Fri, 27 Mar 2026 12:18:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathias.krause@opensrcsec.com>)
 id 1w69t5-0002Xq-BL
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 12:18:19 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathias.krause@opensrcsec.com>)
 id 1w69t2-0003p0-K5
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 12:18:19 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-486fb112c09so23413835e9.1
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 09:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=grsecurity.net; s=grsec; t=1774628293; x=1775233093; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=8nXzkjARMSTYgR3ndSSTESuLQ7u4Y6zZ+VFA69AhiBA=;
 b=VT4VDg0AeQCMlni23AzvakaN+38JQGhwtPd0/keTqlyKAuuaK0u32DRNRuasjAeoOu
 QSCZA9zV+ZUGdSN7fD0PNqUFgpnQwQIeiTX4iEMKm7gfUmRZwYsICLwhMxhQUI1njcTV
 +hFOTQfmVOyIC4f/7I5/LbGvMnkT5hZleC8+luzPBUcSSAJtjxFOQbrCbGesD5IZf4Qd
 oP+8C9OngnxN+/Khpn3mTG5VjWEk4BfS3JBr7G/v3HjD59Cx8C3GxKqczfx5GbTbMrEp
 5CACuQ51dv8+46tm9azB6gYB/wlloz/VcJ/lSt4EWF04qFZXYJMlZuBBSLpzzANNYxWC
 M61w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774628293; x=1775233093;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8nXzkjARMSTYgR3ndSSTESuLQ7u4Y6zZ+VFA69AhiBA=;
 b=TDK8qGGYk7aoOciMEX6kLBKbO38N7lu7ukcpsHkkbZqDNvezWo1KnZcC6wJJT6EFMU
 mPxx4F8dlqazrZLkV5mgMnkgSSVRrp7YH+1vcn0US7QYAQyMA/XodPP/Yy6LKb2mP90H
 xDErlsEpYiIQkYNz8kHIqVjW8nH7Sj1+b0UOj0gBQVpFYc5JZ2p0T6IhUKU4SDsWBrbC
 W5jwxeU1c8hE5a1AX8m75Lel5BuSFqVYQqqmjT9oVbjJHGuQom7yKOBlLmk6/ctHpnBM
 zD6DWSSMruQJvIoltRizKwQn9mRb8p3LnqVbg9KbcGXPPf4rg/sualjrktRZyvuHdIpp
 bV2w==
X-Gm-Message-State: AOJu0Yy9r95+0b+VaS72LLEVvLhCU/pMfFPL14guwpTTv9f4N6a2/kxM
 RQo9rAUuNX4ZVmILwKDwgB7Uu9NQnNwBlaKDdFFolJcldjsSbD5X0jwWANa4NvSxKldLD4oqDX5
 LsrJq
X-Gm-Gg: ATEYQzxUribN7C1GvbwjReNlijdYmKT+zUT7dpM8MwaiBPhkn/w15psJHlTkNT/smCv
 uiqXuDjk6nUckcDVUbKsqQ5Z7HOVur4mDMoA8YbVmtV0WFnWomPQwNBtgMyYd5IiC7wga+gzp6x
 p36DuGxmTAGl+3HJvB1QkAu43mo0U9KHopZilL9ANu6AGAW8g9flwRd3feHfF6wlNBA8XugKmxv
 50I9jfvnHhVznADi60Ti6uQX9dQKftF3otIBBiVJe0zBXC3jeOJWUv9O37ZMiuX7k11nXgM+kvC
 b8ev3/CCzjS1yavEkwtNM/CpSlg5fLQ7n/FFNnkH9ZzUDd1MkWGy3n0YXgttBWByEJ7fUTgN+f0
 zR1sKD1tpQ7zbCrZy9jRMXJLGnlFnOoDAc5OER0LWoab90lzkJcf1ahAmtX//V+lj4/tZ+0ye0f
 Q7/QKWB6hBN7boJ+Y6hOkrdtA+7OeSgAxE8qRwYoigdqvXtH6ldN2YIfaV4KJxb1yWrBQ4uGC3D
 oN2jxJbUVGorPNymQ3oCAmEaTQMAjQtZzIoC6j/8zBYtmCTUFRI/iwn
X-Received: by 2002:a05:600c:8715:b0:485:3bc7:a231 with SMTP id
 5b1f17b1804b1-48728091c2cmr54671985e9.29.1774628292985; 
 Fri, 27 Mar 2026 09:18:12 -0700 (PDT)
Received: from ?IPV6:2003:fa:af26:200:51a:ef03:a698:a1fc?
 (p200300faaf260200051aef03a698a1fc.dip0.t-ipconnect.de.
 [2003:fa:af26:200:51a:ef03:a698:a1fc])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4872712acb7sm18513075e9.18.2026.03.27.09.18.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Mar 2026 09:18:12 -0700 (PDT)
Message-ID: <585df7ce-65cd-4ab0-a1b7-cc90f36e01cd@grsecurity.net>
Date: Fri, 27 Mar 2026 17:18:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gdbstub: Update x86 control register bits
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <20260327143413.254227-1-minipli@grsecurity.net>
 <87v7eh1ckm.fsf@draig.linaro.org>
Content-Language: en-US, de-DE
From: Mathias Krause <minipli@grsecurity.net>
Autocrypt: addr=minipli@grsecurity.net; keydata=
 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
 RzDVkdgPJkL/NFTKZHo5foFXNi89kA==
In-Reply-To: <87v7eh1ckm.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=mathias.krause@opensrcsec.com; helo=mail-wm1-x334.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 27.03.26 17:06, Alex Bennée wrote:
> Mathias Krause <minipli@grsecurity.net> writes:
> 
>> The control register bits haven't been updated in a few years, making
>> them lack behind features QEMU ganied in these years.
>>
>> Update them to the current version of the SDM and sort the 32bit version
>> to be in line with all the other definitions (descending order).
> 
> Do these changes come from the gdb upstream (which is where all the XML
> originally comes from).

The upstream version has no control register coverage, that's QEMU
specific and came with 7b0f97bade8a ("gdbstub: Fix i386/x86_64 machine
description and add control registers").

Thanks,
Mathias

