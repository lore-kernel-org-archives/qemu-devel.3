Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 028ABC982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 18:07:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x94tR-0008B0-8h; Tue, 22 Sep 2026 14:07:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x94tP-0008Al-Jm
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 14:06:59 -0400
Received: from mail-pz2-x0c.google.com ([2607:f8b0:4864:3b::c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x94tN-00020Q-M4
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 14:06:59 -0400
Received: by mail-pz2-x0c.google.com with SMTP id
 d2e1a72fcca58-87c90648f99so208634b3a.0
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 11:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790100416; x=1790705216; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7phQY1AVnxbwQGyEIf0s0KkUEMF1qyH+fHQWZkw0bv4=;
 b=Euyhrz3Z8CvGgByvPD+1EiYBst/GWsnmlCgLDO5BRG1QSxP5U7ATPtTa1X29FHzowE
 3EZrv1fd7CSUnu+GvI4QKSxFozdLxmYYI1SvdLQ4PHCvpjqk7ADrGkwDu5F+Od2J7Tn6
 OoSGaGG108qGNRl1AoM1bx0LobyciFqEdv47EFIpUWa2pYNpqLtD4FbVo+evy9OU1FDy
 QRoWQ1f7mjei6D/ydw4vOdKfYAijr/vWv61WAjPkqYBgUBIkA8FwTI0BJgEMmMBSjp+B
 5Hl2Ev8tlkrPPmB6PtDKUaPP7LmPzIQ40CECb4i9w23byJsAxMTupn02WzQBQv9BSz66
 eQig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790100416; x=1790705216;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7phQY1AVnxbwQGyEIf0s0KkUEMF1qyH+fHQWZkw0bv4=;
 b=E2z5Hw+/cfSpZjbIBfgj5lmwfpGzzBLpECqcdFgZzPoxxZtAaeUstMefxOO1Cwsx1p
 uFYJp52DIhrYmZVBhDqNGTdq1y/976q0A/y8bdQ7WPdRYs1oSDivChvmgLhvJKqKHYDU
 H0Y/06F/4WgQ5mqQEDn1l0b245kxI1l4cSX3v+3RXB2/SJlYpFEwR4tJRuIWz4msA/GN
 k9/ZuUohj2ltX/hC+Q66aayMk8lxcoIaWEMM8YQzkT60WWdIjMx85B0+S0gWMzk0xh+a
 +egNuRcolKUS+XH5/HC6lghyXHMN91UJBVc1A5PX3t1Q3S28RfZRXgwoAkBMEeYHpxC7
 WR8g==
X-Forwarded-Encrypted: i=1;
 AKwUvBx72mthxHBWdsBGAFmRo88XoCVGNGIhHOxqHXpLachcs9JNIpW+FqMFY/qiObUwBnjR8gzAbhNBhWQ5@nongnu.org
X-Gm-Message-State: AFuF++l1yIBTCesgFd2zz/rEJidNRTYK4cvmTICPmnt1LGsS7xXd9QSA
 LmC2e4RsETkLWJq5+bJ5y0gs4cyu4D8rIyGTm5nhb4K7oPHGKDTkJVeAvx76mkm8m20=
X-Gm-Gg: AYBFou1LJCyzrAPmG/nb0QQeF2YCPYBCqUo7AAFhEdUYVcl+nRZDv4MZjbhcctGoHWx
 XZZebeTgh8h+OhadABAhbedrK1TEv4IEH1rQBRB15wsYFrfyWtpx9VOaATOZ4eNxI0JoKlq9uaQ
 xe5JGwz/zt8c8WkyWPjVQlOGe3iGLU/g76hr/U6avDDjY6rwqF1jVcbIaEigQqsiUfVp2r/yv12
 UcYo5/VjYFie6VLsGF3hMXa64RZbCYv6U2eiF47gzh61V3/8ra8XqoY99HRLP+Cc7LFYsRr7roI
 USlkQSRnPcDFCiYqIbcsJW+vq/QAw7ZwoxwYg15HOyepaHAkNhdlKNM2E1n04NbCPSLzoVJt2wn
 W6fyX2ptGxYBndh4edQe3YweAIBcaoHmXfeScHdP+6M8xR6b4JCXD8QUdURWDUABhZwL4GviRyc
 dJQpIsFnfoYvRkOxgUFiM3NQ3FM9f1GjuGYIO77XiKHDKxfalnyRLkrM7kxMdQCN94NfKiXgOZP
 XhdKGSnEyngXoQ/vxuwampR84nwTBYgZ8lAlYJk
X-Received: by 2002:a05:6a21:39b:b0:3dd:a197:ede4 with SMTP id
 adf61e73a8af0-3ddf8304ad8mr265641637.51.1790100415752; 
 Tue, 22 Sep 2026 11:06:55 -0700 (PDT)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc75f3ba829sm3852a12.11.2026.09.22.11.06.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Sep 2026 11:06:55 -0700 (PDT)
Message-ID: <c621f948-add2-4e9a-9871-344906c7b662@linaro.org>
Date: Tue, 22 Sep 2026 11:06:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] linux-user/sh4: fix race in atomic variables
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, Helge Deller <deller@gmx.de>,
 qemu-devel@nongnu.org
References: <ae75af55-eb9a-5ac2-9288-aa116a3c4000@redhat.com>
 <dfa3b2ca-b87b-4581-9769-2f90aba86c56@linaro.org>
 <2845945d-4d46-3ae9-8182-7d2288ff06ac@redhat.com>
 <a435c784-849c-4a0b-95bb-182068d4abfa@linaro.org>
 <f5f389df-3865-b0de-4b91-da40a5a05256@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <f5f389df-3865-b0de-4b91-da40a5a05256@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x0c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 9/22/26 10:58, Mikulas Patocka wrote:
> 
> 
> On Tue, 22 Sep 2026, Richard Henderson wrote:
> 
>> On 9/22/26 10:04, Mikulas Patocka wrote:
>>> I looked at the sh4 translator and it seems that it already tries to make
>>> sure that the full gUSA region is translated into one TB - i.e. there is
>>> "ctx->base.max_insns = max_insns" in sh4_tr_init_disas_context - that will
>>> override the value "1" that is supplied by cpu_exec_step_atomic. The
>>> comments suggest that the author is aware of the fact that the gUSA region
>>> must be completed atomically.
>>>
>>> So, the code that single-steps through the gUSA region is not needed.
>>>
>>> It seems that the misbehavior is caused by the fact that if we exit from
>>> the gUSA TB early, we execute the rest of the region in non-exclusive
>>> context.
>>>
>>> I simplified the patch, so that it adds just one method -
>>> revert_uninterruptible. It tests whether we are in the unfinished gUSA
>>> region, and if we are, it reverts PC and SP back to the beginning.
>>
>> What good does that do?  You'll only restart the same block as before.
>>
>> Is this really the case where you're encountering
> 
> Without that patch, it deadlocks in 10-30 minutes. With the patch (either
> version 1 or version 2 that I sent), it stays running overnight.
> 
> Maybe the bug is somewhere else and the patch just papers over it.

Could well be.  Do you have a reliable reproducer?  Or is this a "run 
the container and things eventually fail" sort of thing?

Logging guest state at the point your revert hook fires could be 
informative...

> BTW. what happens with synchronous signals inside the TB? (i.e. SIGSEGV
> due to writing into a write-protected page)
Synchronous signals like that exit the translation block right away, 
leading to the signal being delivered.


r~

