Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5342CE63FFF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2026 23:33:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9ATw-0005ke-BA; Sat, 04 Apr 2026 19:32:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1w9ATv-0005kW-0C
 for qemu-devel@nongnu.org; Sat, 04 Apr 2026 19:32:47 -0400
Received: from v512.v5f06b487.use4.send.mailgun.net ([143.55.232.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1w9ATt-0006Es-5M
 for qemu-devel@nongnu.org; Sat, 04 Apr 2026 19:32:46 -0400
X-Mailgun-Sid: WyI4ZDFlNiIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjk3NjA3ZSJd
Received: from mail.yodel.dev (mail.yodel.dev [35.209.39.246]) by
 3e36628bed354508f55fe2c38d478cff2044cf0a55f8acc5e152bbfd8f8dafea with SMTP id
 69d19f93f2f7fa4308868d1b; Sat, 04 Apr 2026 23:32:35 GMT
X-Mailgun-Sending-Ip: 143.55.232.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yodel.dev;
 s=rsa2048; t=1775345554;
 bh=Uwg9PvySCOemqSHr19GMagVaGrk0TQyaiUytsw6K7CI=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 X-Mailgun-Dkim:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:From:Reply-to:Subject:Date:Message-id:To:
 Cc:Mime-version:Content-type:Content-transfer-encoding:In-reply-to:
 References;
 b=i1RFT8qdsGceJXZvSCBe+dckM/i8pZm9JOU5MU8wwU6EDDFi7Jcuhofk6OYOm8rWg
 zgvaxR5B6UcRW7xSxt8sylM6B23UoylaX0jtiHPf93suhBlJQFdZqws3UvtM1LQNa8
 TsjZ80Fh5mWMMcXGVRyW0F3CkBk42MO8hLljCE/k+LMmx/WG5DwhNs1exi+8b/03d2
 InJTPz1yiYkuEFF3F230h1tNt2aPxQjwg+I2/ozwAhTpnL1GDSalO73BD/py/TQyOO
 bvmMmbfNzgU6anY8+H5xJZyLD5Evnr8oEpq5UI72GmTL6lqqkF30cu7aQuQhpysgTR
 nk/cvCylDUz8Q==
Message-ID: <0f822f37-de4a-44d3-81dc-61f9caee0403@yodel.dev>
Date: Sat, 4 Apr 2026 18:32:34 -0500
MIME-Version: 1.0
Subject: Re: [RFC PATCH 3/4] alpha: Replace helper_set_alarm with Typhoon
 Cchip MMIO register
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20260401170454.32045-1-yodel.eldar@yodel.dev>
 <20260401170454.32045-4-yodel.eldar@yodel.dev>
 <1c6d7e6f-eb16-4820-a4c2-35767c8db919@linaro.org>
Content-Language: en-US
X-Mailgun-Dkim: no
X-Mailgun-Dkim: no
From: Yodel Eldar <yodel.eldar@yodel.dev>
Autocrypt: addr=yodel.eldar@yodel.dev; keydata=
 xjMEZxqXdhYJKwYBBAHaRw8BAQdAkletQdG3CLyANZyuf2t7Z9PK4b6HiT+DdSPUB2mHzmPN
 I1lvZGVsIEVsZGFyIDx5b2RlbC5lbGRhckB5b2RlbC5kZXY+wpkEExYKAEECGwMFCQOcG00F
 CwkIBwIGFQoJCAsCBBYCAwECHgECF4AWIQTTzRjNQG27imap+N+V7k+3NmVNrAUCaNWASwIZ
 AQAKCRCV7k+3NmVNrNnSAPoDjQXa6v7ZzdQSaLdRfAQy/5SsUucv+zp3WAP4pXdgJQEAzMMC
 Ctx4l6b13Fs2hZdRXEnF/4BZ9t1K68nwzZOV3QnOOARnGpd2EgorBgEEAZdVAQUBAQdAKPIy
 3W/DKFsm1e+31zoqmOY0pqz8vjIM846wM6lEY2QDAQgHwn4EGBYIACYCGwwWIQTTzRjNQG27
 imap+N+V7k+3NmVNrAUCaNWG7QUJA5wi9wAKCRCV7k+3NmVNrPusAQCQDQwETy7VT6UhHPho
 TkrQnsNqQfFU3tXqCTiViToktQD7B/U2/to97hQIJCWbK6yd3T+KPZJPMcHMg2XRyedUvgA=
In-Reply-To: <1c6d7e6f-eb16-4820-a4c2-35767c8db919@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=143.55.232.12;
 envelope-from=bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev;
 helo=v512.v5f06b487.use4.send.mailgun.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HELO_STATIC_HOST=-0.001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 03/04/2026 20:01, Richard Henderson wrote:
> On 4/2/26 03:04, Yodel Eldar wrote:
>> From: Yodel Eldar <yodel.eldar@yodel.dev>
>>
>> This commit creates a QEMU-specific (non-standard) MMIO register
>> in Typhoon's Cchip to replace helper_set_alarm() and to move
>> the QEMUTimer pointer, alarm_timer, out of the Alpha CPU and into
>> the chipset code.
>>
>> Currently, PALcode writes to the QEMU-specific, synthetic
>> Processor Register (index 251) and triggers the invocation of
>> helper_set_alarm() as a side effect in QEMU, thereby setting
>> the timer alarm expiration value.
>>
>> This works, because the AlphaCPU contains the QEMUTimer and
>> CPUAlphaState stores the alarm expiration value; however, the timer
>> alarm callback resides in and is specific to the Typhoon chipset,
>> thus the CPU and the chipset are entangled.
>>
>> By designating the currently unused offset (0x7c0) of Cchip as the
>> location of the timer alarm expiration, we can disentangle and
>> better encapsulate both.
>>
>> Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Signed-off-by: Yodel Eldar <yodel.eldar@yodel.dev>
>> ---
>>
>> Notes:
>>      The patch to the palcode-clipper binary that follows this
>>      one is necessary for this patch to work; I've left the
>>      diff to the source in the notes of it for reproduction.
>>      Philippe:
>>      Thanks, again, for the suggestion of decoupling the CPU from
>>      the Typhoon using IRQ lines. In my response, I guessed that
>>      getting the CPU index would be trickier than moving the timer
>>      into TyphoonState; perhaps you'll find it amusing (as I do)
>>      that it appears I had that backwards (due to the PALcode
>>      peculiarity)!
>>      The remaining CPU interrupts will be refactored in v2 of that
>>      series.
> 
> I'm not keen on this.  I would much rather keep the synthetic processor 
> register than add a synthetic CChip mmio.
> 

No problem... Are we okay with exposing a typhoon timer helper
and TyphoonState to target/alpha/sys_helper.c via the inclusion
of hw/alpha/alpha_sys.h?

If so, we can add an opaque pointer parameter to helper_set_alarm
carrying the TyphoonState and invoke the typhoon timer helper;
e.g.:

/* Inside target/alpha/sys_helper.c */
#include "hw/alpha/alpha_sys.h"

void helper_set_alarm(CPUAlphaState *env, uint64_t expire, void *opaque)
{
     CPUState *cs = env_cpu(env);
     TyphoonState *s = TYPHOON_PCI_HOST_BRIDGE(opaque);
     int cpu_index = cs->cpu_index & 3;

     if (expire) {
         env->alarm_expire = expire;
         typhoon_timer_mod(s, cpu_index, expire);
     } else {
         typhoon_timer_del(s, cpu_index);
     }

}

We'd have to keep alarm_expire in CPUAlphaState, because
palcode-clipper would still expect it, but alarm timers would
be moved into the typhoon as an array indexed by cpu_index.

WDYT?

> In any case, this is also doing more than one thing at a time. For 
> instance, Connecting the irq on typhoon to the irq on the cpu does not 
> depend on anything else.
> 

Thanks for the example; I'll split it next time.

Thanks again,
Yodel

> 
> r~
> 


