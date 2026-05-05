Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40ACCCD3427
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 14:43:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKGz0-0004Ku-6H; Tue, 05 May 2026 10:42:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKGxK-0003D7-4o
 for qemu-devel@nongnu.org; Tue, 05 May 2026 10:41:02 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKGxI-00059n-5d
 for qemu-devel@nongnu.org; Tue, 05 May 2026 10:41:01 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-449e96a8a80so3181933f8f.3
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 07:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777992058; x=1778596858; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8SrFOaAKR6hLIqu/DoVL/IXcznWpmD+qAwuisaGMLyY=;
 b=WOltRS4gDrdsaHtL/gNQFVhN3jpCGgHbNLuPC//ClvoNHwGr0IU2QWA6rCxPM9XfDL
 wIstKVFfL7Xtw3uTC2OHdGlrz8v8FlIflMeIX095djf9YhIctr8Czjlw12fitF1PIhtb
 W44WO/iTK8UkQRGHzowqgsvqJ8aI0hD2gZoKl8IX/FpUpOI5t+G9iY1tZYuUtCyB5RTr
 jUjKNasx3j4T7lrVsSP/hkaCLzAKEv8Tz4cns4WSa8ufvVFfdCxzjuI/F0hHZxLirowM
 EpBBChAkiKKXu/7Glk5TtpgYpiN4y1Sztl7HMEnsNbnV/ZIm/4SEyv0Aefaxx/KDQquP
 8+rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777992058; x=1778596858;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8SrFOaAKR6hLIqu/DoVL/IXcznWpmD+qAwuisaGMLyY=;
 b=giylePSxiCujghR3FvvKhmjqKhO3aHSXV0CLoSWmQ5oPZhxQaQG8UcRp8Va1mk3pFP
 Cs3wOv5yEPNxEU1a/FxKKgdfkW8RTHYMBiMIPg+M6RBnr1Hu4E3VkJFAgcWJqs54tdBW
 uGe3gsbI1rMHG7ZEufYU6m7aN8oJyVTyfvG6VhGkcNcjl1mKafxIQz4OBBXCmHxx+pzZ
 j4OhP29yfx3pe21WxqeEmmcEJXuascuL7Xg1kSSCc0/MZF0c8hY2gtN2l5A0KBGjv+Wh
 5JjL5u8UdwXNuVA+WuE5vVxev8/2ONiNqtJVE4nFDlcC/VpW5jazHyLcNrTX5L56DwIf
 oNTQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9QKELZo8e3sesMEm9hQJB77I1a/GPKRkZEDhu28OM9GfBEjjTGwHrZfXpqHhCEX6S/6eXSpeCYNBTU@nongnu.org
X-Gm-Message-State: AOJu0Yx0ViA+x/EmJlxT7/eLVceIkZI0qmctnnYhn124NK7WbU9U1279
 r75p4iMOukqaom/Gs8sv8qgWIqmv1fuVsHxI4qMYVJCH7tPVchdW2HAykZFGlAubXkE=
X-Gm-Gg: AeBDiesOMA51d2oxAJBbCAif1E3OQWUaiB4C9ipz2WNnQpTaa7l8DAJGJBKtIUvovT4
 0wsiNjhRrzPe5BkWFvPbEtILhI6OpamrE2lvIKJ8jFFBPKJU/TymfJTuZQ3SQRoo0Bf5mbsu4NE
 5H0nLmLHv0A7DtJMOssUGsl1vbIW0Z6+I7lkCNU4AB6cvGdkN+cvCCwQln4/TpUmTTLfDa/ljjS
 H/4NoOdQ2Af5++OEHew6G+Xiv7mtuBLgvlUOxfWtK89vLILP/NleP+vvDDZBVkihHfBW/ceer4Y
 OlADn/o5w7Jmra0+sp/rS0SKS38u65HghbDEMVcfzDZ9rYWSrSaiHJHA+lrnvn3rPaFgEWzXb42
 ayqXnqXQzwGFlNjZg2IJ+VmOIxPQoeuCrzms+BnaugSjqTWNonp7H/l5A27Uk/6W/yA5AM91+mL
 dIH6XL6+6c6O5pNZMLXLS88WJlz1HIZapDYFfP+A4ksGWgIoLaoqgWYB7yPP+erNWNpYQK/5wxJ
 5Et
X-Received: by 2002:a5d:64c5:0:b0:43d:69ff:6898 with SMTP id
 ffacd0b85a97d-45003afe3e4mr5959356f8f.9.1777992058288; 
 Tue, 05 May 2026 07:40:58 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4505238e7c0sm4527223f8f.3.2026.05.05.07.40.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 May 2026 07:40:57 -0700 (PDT)
Message-ID: <5d1f592d-21cb-4fb8-a8a4-0234af4bc3ed@linaro.org>
Date: Tue, 5 May 2026 16:40:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/4] Monitor patches for 2026-05-05
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 stefanha@redhat.com
References: <20260505123502.1316554-1-armbru@redhat.com>
 <0f68fa39-f190-420c-a55a-f31a7b95663c@linaro.org>
 <CAJSP0QWVdSHvK2g8jncEL40nR=yp65LGZJ6z5NnsKM8ey2Oh_w@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAJSP0QWVdSHvK2g8jncEL40nR=yp65LGZJ6z5NnsKM8ey2Oh_w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

Hi Stefan,

On 5/5/26 16:00, Stefan Hajnoczi wrote:
> On Tue, May 5, 2026 at 8:59 AM Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> On 5/5/26 14:34, Markus Armbruster wrote:
>>> The following changes since commit ac0cc20ad2fe0b8df2e5d9458e90a095ac711ab1:
>>>
>>>     Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2026-05-01 14:41:49 -0400)
>>>
>>> are available in the Git repository at:
>>>
>>>     https://repo.or.cz/qemu/armbru.git tags/pull-monitor-2026-05-05
>>>
>>> for you to fetch changes up to ea017f67ce1ca34c7503b6f23f48b433585d37ac:
>>>
>>>     monitor: Add `clear` command (2026-05-05 13:53:03 +0200)
>>>
>>> ----------------------------------------------------------------
>>> Monitor patches for 2026-05-05
>>>
>>> ----------------------------------------------------------------
>>> AlanoSong@163.com (1):
>>>         monitor: Add `clear` command
>>>
>>> Dr. David Alan Gilbert (3):
>>>         hmp*hx: Move info docs
>>>         hxtool: Split srst/erst add checks
>>>         hxtool: Error on missing docs
>>>
>>>    include/monitor/hmp.h |  1 +
>>>    monitor/hmp-cmds.c    | 11 +++++++++++
>>>    hmp-commands-info.hx  |  9 +--------
>>>    hmp-commands.hx       | 41 +++++++++++++++++++++++++++++++----------
>>>    scripts/hxtool        | 39 ++++++++++++++++++++++++++++++++++++---
>>>    5 files changed, 80 insertions(+), 21 deletions(-)
>>>
>>
>> Obviously this conflicts with the PR I'm waiting since 10 days to post:
>>
>> $ git merge pull-monitor-2026-05-05
>> Auto-merging hmp-commands-info.hx
>> Auto-merging hmp-commands.hx
>> CONFLICT (content): Merge conflict in hmp-commands.hx
>> Auto-merging include/monitor/hmp.h
>> Auto-merging monitor/hmp-cmds.c
>> Automatic merge failed; fix conflicts and then commit the result.
>>
>> Sigh.
> 
> Hi,
> What is blocking you from sending your PR and who can do something about it?

Sorry, this comment was for Markus. I understood he wanted to have a
look on patches related to monitor I was going to pull:
https://lore.kernel.org/qemu-devel/d434b8b1-e79c-40c7-984d-1164543c7069@linaro.org/

More than 1 week passed so I think we are good. Do not hold on Markus
pull-monitor-2026-05-05 tag, I'll wait it gets merged then fix the
conflicts and post mine.

Thanks,

Phil.

