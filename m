Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11A1BCD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 13:58:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKclw-0000lD-DB; Wed, 06 May 2026 09:58:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKclu-0000jb-Mu
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:58:42 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcls-0008Ss-Rv
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:58:42 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4891f625344so10769275e9.0
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 06:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778075919; x=1778680719; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/2HoprDKMbpDe/o5gT30bN+QsSCkFnyUVTyl+FtPgps=;
 b=nvxwTq7XVsearzf0RqdU7nI/57nIi+BLRL0Lv0QaxB2REIdsEJuTtuKU4LfQf0olJb
 GmBNaAPDYTZN8X7ZgDujaShrwwxeckLPok4S3ETV4ML0RUP2/d5uMFTekUMLnKkGd7z8
 EN8tdtJ9+f7pmcXBqdesrkelEgFIi6OyCBE9Fp7ruwUoU9UbUt9wkjuRvPASRr91GtLS
 Ouj92E7cYv3s/5Swjd9neoJ7T4YXvY7Qa1JunbVzMuraGhks+gZ6cZDwBLOgFNfV2ipm
 JITcNQWV4D7FD9bDG2ZJi8P65NGlk+sfn8xysJ7H9OYcXu0KnY+fl+GqJbw9KdGDSNmd
 4oYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778075919; x=1778680719;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/2HoprDKMbpDe/o5gT30bN+QsSCkFnyUVTyl+FtPgps=;
 b=NlDJnat9RCo5eSHs4Hk1TEPA2mfe56qCW9MYCtfJi9S6V413mZ7rNLKCVdZ4WYhKaF
 OhQ0pnLF7tq7rinXHkvKZso6oFHFbfGVtrPPT6OtpeL/wgvwU1+4agXTfHM7HZ6ojVv6
 i23395WQ9r6MNzstGUMIQYyqK5HBZ9bl1plVgJT/oJe44/7tPAqi6iVzEPU/5e8fMCcn
 BWghblKugVO/SxRCIPRgPVQaz8RL4R35htvqjOTO6qdRJ8fQH8C7ASHjJLGZcj63neer
 XdGPKYW+w+JQtlVmWOgBSuahPi3Ok1F1DkzQPxDt0+y4NXWDIoLPc6ZwquJ1dhb09TXE
 5tww==
X-Forwarded-Encrypted: i=1;
 AFNElJ94/KlCtPg3W/Hf9mzfPIcRiepqTLcw/s0XcT9y6jrDVTiQnZOL8asxcX68dOwBthD7KOqWKhmfIOCw@nongnu.org
X-Gm-Message-State: AOJu0YwZuznRC5+Wlbwc/IL5AGaj+VB5CuY5MCVUVG2GKP1CmRb45EeT
 Dr51QwWkmlfh3GuJylEwmSvreSDRI66L4l+qKsJB4efvnBSw+gWspmrMtdEWXpai2zs=
X-Gm-Gg: AeBDieuNXVTyWsGUgM0H2JcZvBOR+mkdPMHMG9GJOyga29axqLZfX7EoLbms3baRREY
 4fWoSmcuM9v1YQ+RN1tIWzjaQRaW3Mod55cgwFNUMagguz3knle8eF0NjCohUKLGeeopsFu04Uf
 nZ1mSIGYxVKC58sV/1gprIpLzoteNOrgCz3wTZis0MZXpdlruwC5lB0YJoiXMqY0qcPixaTIFuh
 OiZl4vwkxoQXX1FoA+o8rHf5/7PGro5O2IWgu+H2nnXOPXxWBppRBTBrB9M2fkyVYbq4VJQEcnK
 hGItWnM5OTW2zdvUUtt6Jid0oDHB4HaLByHWN8HO2qkqD3wUKzxFGWVk7TSxxrWiO1mhKKK7c6T
 FK/MqrUvdsZKD9m1lpxKD/ru4I4ZYqY3lOx64wKi+4G8wPh5cdZtemFG9na9VBLoaTkXM+1mKLr
 iw5yue/lRTb5DyM1pT9fgRk4aPgfoQPgKD+f8dBIr+B6lpEXW1S9X9RfLq2SKrsgSk6Bd1vw3xs
 CbM
X-Received: by 2002:a05:600c:5291:b0:489:32b:ac0b with SMTP id
 5b1f17b1804b1-48e52285af1mr47494825e9.6.1778075919289; 
 Wed, 06 May 2026 06:58:39 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e53152acasm18447125e9.31.2026.05.06.06.58.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 May 2026 06:58:37 -0700 (PDT)
Message-ID: <bef66345-522d-43d6-8225-ef5609ca5abc@linaro.org>
Date: Wed, 6 May 2026 15:58:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/4] Monitor patches for 2026-05-05
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org,
 stefanha@redhat.com
References: <20260505123502.1316554-1-armbru@redhat.com>
 <0f68fa39-f190-420c-a55a-f31a7b95663c@linaro.org>
 <CAJSP0QWVdSHvK2g8jncEL40nR=yp65LGZJ6z5NnsKM8ey2Oh_w@mail.gmail.com>
 <5d1f592d-21cb-4fb8-a8a4-0234af4bc3ed@linaro.org>
 <87y0hxdpzm.fsf@pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87y0hxdpzm.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 6/5/26 08:14, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
>> Hi Stefan,
>>
>> On 5/5/26 16:00, Stefan Hajnoczi wrote:
>>> On Tue, May 5, 2026 at 8:59 AM Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>>>
>>>> On 5/5/26 14:34, Markus Armbruster wrote:
>>>>> The following changes since commit ac0cc20ad2fe0b8df2e5d9458e90a095ac711ab1:
>>>>>
>>>>>      Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2026-05-01 14:41:49 -0400)
>>>>>
>>>>> are available in the Git repository at:
>>>>>
>>>>>      https://repo.or.cz/qemu/armbru.git tags/pull-monitor-2026-05-05
>>>>>
>>>>> for you to fetch changes up to ea017f67ce1ca34c7503b6f23f48b433585d37ac:
>>>>>
>>>>>      monitor: Add `clear` command (2026-05-05 13:53:03 +0200)
>>>>>
>>>>> ----------------------------------------------------------------
>>>>> Monitor patches for 2026-05-05
>>>>>
>>>>> ----------------------------------------------------------------
>>>>> AlanoSong@163.com (1):
>>>>>          monitor: Add `clear` command
>>>>>
>>>>> Dr. David Alan Gilbert (3):
>>>>>          hmp*hx: Move info docs
>>>>>          hxtool: Split srst/erst add checks
>>>>>          hxtool: Error on missing docs
>>>>>
>>>>>     include/monitor/hmp.h |  1 +
>>>>>     monitor/hmp-cmds.c    | 11 +++++++++++
>>>>>     hmp-commands-info.hx  |  9 +--------
>>>>>     hmp-commands.hx       | 41 +++++++++++++++++++++++++++++++----------
>>>>>     scripts/hxtool        | 39 ++++++++++++++++++++++++++++++++++++---
>>>>>     5 files changed, 80 insertions(+), 21 deletions(-)
>>>>>
>>>>
>>>> Obviously this conflicts with the PR I'm waiting since 10 days to post:
>>>>
>>>> $ git merge pull-monitor-2026-05-05
>>>> Auto-merging hmp-commands-info.hx
>>>> Auto-merging hmp-commands.hx
>>>> CONFLICT (content): Merge conflict in hmp-commands.hx
>>>> Auto-merging include/monitor/hmp.h
>>>> Auto-merging monitor/hmp-cmds.c
>>>> Automatic merge failed; fix conflicts and then commit the result.
>>>>
>>>> Sigh.
> 
> I'm sorry.
> 
>>> Hi,
>>> What is blocking you from sending your PR and who can do something about it?
>>
>> Sorry, this comment was for Markus. I understood he wanted to have a
>> look on patches related to monitor I was going to pull:
>> https://lore.kernel.org/qemu-devel/d434b8b1-e79c-40c7-984d-1164543c7069@linaro.org/
> 
> Yes, I'd like to have a look.  But I'm under water, so what I like
> doesn't matter.  I'll have to rely on the review of others here.

All patches have at least 1 Reviewed-by tag. We also rely on CI. If you
noticed something that shouldn't have been merged, please point me to it
and consider adding a CI tests.

>> More than 1 week passed so I think we are good. Do not hold on Markus
>> pull-monitor-2026-05-05 tag, I'll wait it gets merged then fix the
>> conflicts and post mine.
> 
> Go right ahead.

Thank you!

