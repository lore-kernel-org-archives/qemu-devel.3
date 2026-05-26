Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C177FCD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 14:45:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRt1i-0006Lx-0F; Tue, 26 May 2026 10:45:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRt1g-0006L8-99
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:45:00 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRt1e-0008IZ-Jd
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:45:00 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-4585a116a4aso8880169f8f.3
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 07:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779806696; x=1780411496; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FYt44AXt1huXGaUgzuyPeDkbkp1q5HBIxM88DCm3miM=;
 b=W8SVJ9k+jmqCrMcL3/4OEgW00iqDFyNftBPL+kl8O3PFytcTOSU2GhObgbUjYCFPBV
 Tv9oCOa0QDHWJgkrypnAmyzy8gqNgsnnssEaWW2gBtZfgqt6FVl9CNAsGLfQmNYtCTUU
 Ow4XavWhXd6sFWysx7OmOmnwplyzJwYg1QPSkONwx9PS/1ONHaUFRn7AtcoH6MyPx4Yj
 n9B/x3itNEvYIJXuALeLy/bPCfADNfG14l8ZVEUIJ0trls8b7WQpUbdy9HuUIlNFeYHE
 RYrFmatVG0xvJUDMpyVUk0du8QdTixFjuKTY9Ti35qUYscRuvUNUGKElM7bC0dCvSi/R
 mgCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779806696; x=1780411496;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FYt44AXt1huXGaUgzuyPeDkbkp1q5HBIxM88DCm3miM=;
 b=iZkcMTMnnrpzzVGhxlDoyrCm+mvbkyayqvf1De/lGQ7NjJP9WY8ElBAfGvpZJtqMkJ
 QfguYmnl5Od62HKh1At+ruZE2AUuM2KSHre7Sh8i1RASvhXQdFXeC4a5ZfV5cdI3A1jm
 lDO8BO9wRUIv02+xzaZYA9vghNSiCXzscLOKvaahPAdL24tYP/f8imWzFEOhO9j6NY3K
 4GKK30cRWBlOkllCGm+cZDP987v3e+AzfLsBjMb9gV5BqkKcOBXDpv6LbVAtfP34Fvuc
 NShyCCD4eZ8E+KzpfbrU51yCFvsKUv8ycpmVr98ZPhykYOCyiO/Nx2i0kDaineKTDl7i
 VMeQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9x6OvzKq817kQF/x3BsSCFyczXF8eIjlpPnk8LTUjfldSrNmxW2K+8CYxJGVy6pKy+GS+7cfg2OsiI@nongnu.org
X-Gm-Message-State: AOJu0Yz0B2CHHc2SsB3y7aODfaAyUTcFpCT/QsQR5xft84C1cmBvgF/z
 i6Q36Cv/kEi4UqTI0yzHD4R1A0uSRybSJgcJqw5Zu4ko5uzPYJrS8QkAZ0yF1A7RJrA=
X-Gm-Gg: Acq92OHnpX4qdemWQYIzVu721+UvxENoUav9mh/LS9VjPFf4F+U3NDBF/jEEB4Pd0ka
 HIxOaz+0DWMAlnL8gN0aetpD36JmS1+0vd3VjRUmlFPNAZZgP6Yfsl6keX7vyFXhtyW6OlcyeiN
 KyRB9ovQCIWx19TCGMOv5Y3xeLIjzA9C1faAgjpJu4G2FnOnmYYnCvTiLu80btvoy/wHrHPBq+z
 t6P71nhKeQhsiBDae5nN/hYyAJvUaHke5D8IZJxZbb6FN/1Sej9vCpHveDHd3gqbQJG/8LcpI8x
 zpQeuj6HpybDGZ3WdLuVAANU2CMOZd/TzDWw7lJK9MVymH91MRKIVtBNDVPC9iQszR6WEfrLU88
 CCo4dpoUGW08X6HtWHLxdQneuHt0UmrX59z7CdzfopYFD7UXtP8TGIwhw5TWD40sJw7ean7WVlJ
 cI6tN7EdSJocq7NbOi8ifmkg3KjBxla7ICJTRtMnI/kguM6B2eKeISU3geN+nOOkyk+tqOysm3t
 Lfx
X-Received: by 2002:a05:6000:1848:b0:45e:73eb:2a75 with SMTP id
 ffacd0b85a97d-45eb367fb1amr32661483f8f.16.1779806696413; 
 Tue, 26 May 2026 07:44:56 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d4903bsm33453119f8f.21.2026.05.26.07.44.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2026 07:44:55 -0700 (PDT)
Message-ID: <b2cfb0cf-bec5-49ca-add2-20fed4c36250@linaro.org>
Date: Tue, 26 May 2026 16:44:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Question about tb_flush()
Content-Language: en-US
To: Warner Losh <imp@bsdimp.com>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
References: <CANCZdfr6xs9n8sF8AXVWVu9i2_rViKErrMHAVbopnaor4uCN6A@mail.gmail.com>
 <875x8g1pmi.fsf@draig.linaro.org>
 <CANCZdfqT7r9jcTuiwe3=CcjRExL-FP1msx-Q8ftQM5amJ_t0YQ@mail.gmail.com>
 <1795fc9c-f82e-40f1-aab6-ec24ad02a918@linaro.org>
 <CANCZdfp=mCp89NdwVzy-tEo=FNiEu6_H79r5vFRD0-Nk=Cx54Q@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CANCZdfp=mCp89NdwVzy-tEo=FNiEu6_H79r5vFRD0-Nk=Cx54Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 26/5/26 16:39, Warner Losh wrote:
> On Tue, May 26, 2026 at 1:53 AM Philippe Mathieu-Daudé <philmd@linaro.org>
> wrote:
> 
>> On 24/5/26 18:57, Warner Losh wrote:
>>> On Sun, Feb 1, 2026 at 7:54 AM Alex Bennée <alex.bennee@linaro.org>
>> wrote:
>>>
>>>> Warner Losh <imp@bsdimp.com> writes:
>>>>
>>>>> OK. I've updated bsd-user fork from last year to yesterday. I had one
>>>> question.
>>>>>
>>>>> I see that we've gone from tb_flush() to queue_tb_flush(). Why was
>> that?
>>>> And is it a drop in?
>>>>> FreeBSD's fork has this in the thread creation:
>>>>>
>>>>>       /*
>>>>>        * If this is our first additional thread, we need to ensure we
>>>>>        * generate code for parallel execution and flush old
>> translations.
>>>>>        * Do this now so that the copy gets CF_PARALLEL too.
>>>>>        */
>>>>>       if (!(cpu->tcg_cflags & CF_PARALLEL)) {
>>>>>           cpu->tcg_cflags |= CF_PARALLEL;
>>>>>           tb_flush(cpu);
>>>>>       }
>>>>>
>>>>> I think the right thing to do is to just change this to
>>>> queue_tb_flush(cpu), and that compiles. I'd like to get some
>> confirmation,
>>>> though.
>>>>> Did I parse the changes right?
>>>>
>>>> Yes, because ultimately we use safe work which:
>>>>
>>>>    * Schedules the function @func for execution on the vCPU @cpu
>>>> asynchronously,
>>>>    * while all other vCPUs are sleeping.
>>>>
>>>
>>> So I've done this in the latest blitz branch. I encountered one gotcha. I
>>> replaced it in the one place, but that didn't work too well. I finally
>>> tracked down the issue: I had implemented the change in only one place
>>> instead of the three required locations. I also had to bring the
>>> begin_parallel_context() function over from linux-user. I like
>>> user-internal.h that's in linux user. What is your touchstone for
>> deciding
>>> where that code belongs in it? I'd like to do the same in bsd-user once
>> my
>>> upstream focus shift to refinement of blitz and maybe my next cool thing
>>> there.
>>
>> All common code should go under common-user/ and include/user/.
>>
> 
> Great! I look forward to growing this directory.. But I was trying to ask a
> slightly
> different question: What belongs in user-internal.h? What's the current
> rubric
> for linux-user in that regard?

We try to have cross-subsystem APIs exposed in include/. When we need to
share some structure / method only within a single subsystem, we do not
expose the prototype via include/ and add a local header.

So linux-user/linux-user-internal.h should only contains things to share
within linux-user/, and not related to bsd-user.

