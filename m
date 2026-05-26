Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3744ECD5BB4
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 07:53:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRmbU-0001ZE-QQ; Tue, 26 May 2026 03:53:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRmbR-0001Yy-Vo
 for qemu-devel@nongnu.org; Tue, 26 May 2026 03:53:30 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRmbQ-0001Di-6N
 for qemu-devel@nongnu.org; Tue, 26 May 2026 03:53:29 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-44c350a5b87so6064513f8f.3
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 00:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779782006; x=1780386806; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qx+ECvWwuD3fVS2DwNgsdzXTplYhEnUT+SXfgvBEGMU=;
 b=F1SUDOVY0qfRASvEzxBnEZ5UnXQnNBOmPZBk/CR1yW2lD1gYN/7l6P3ryG7NmuinUE
 pkR3BBJTHyD8i7e/6KSSQ7q1GEVMfgm43a9Z5lGiZaUW1gLC26LN9hSMi30gPCYO0wsC
 oQ4dS1/ftMFCCEn/fSfvZYHKn9ysYgfig3GjzEUfoLg4flUUnesztROy53xDTxT0RCnc
 U7kyDPpaOIc6QCUoTD51bBHuFLWNRjJikNBQTtKCD/O2sQhHqycMxx+B8OF+C64kMyAD
 0aa/lT90MPeVfyx2myh9jFC+mCeqN4oyK6UorNTe0ezMRq9dM4FBLK0EyZWindHLICHG
 /ESg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779782006; x=1780386806;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qx+ECvWwuD3fVS2DwNgsdzXTplYhEnUT+SXfgvBEGMU=;
 b=q5j2DBGrlWa2rmV//dYFstcwJcjF6dR3CUwqdvJwu8JP9qwm3qGzjkFoNwDrHRx0ah
 Fjku/F7PFf6rM7LJnENdFAq70zqICTtllLz9ovjA5pozTF2mb4KHUzoIRhnzwlFZ6PA5
 BjazIJnpAd5Di8UTkF1bW7VTXDWj4FiZIdcySpoqtIs8SRAx+b39V1iN9UQPTwaJ6oGp
 1YmuNAmj2Q8JOkd0UFQH8obyjzLl1CR5RrH4Pbx17JvPgwfwaiVsOebE3UTq8dbbAetg
 f6SMmR13hbHLnOC9ShxVxxjKIPVpUYAI5bkNOnc5gXGL1MYaDX9fpEsega0a/hFmWhnd
 WdMg==
X-Gm-Message-State: AOJu0Yxl9J2n3Ov8tliTx2e5jmRul0P8W/JObLR4g8E2G1PjnTBKce/N
 CegNiZ34PxVSLDu5PdLFw55uSoh53kW7DYTtr0tOb1fxaF7OduA9TQIQQkUOcDeLrcoVta70fZK
 BQ18IamE/7g==
X-Gm-Gg: Acq92OETRte6uK2oVoQ+04lqu21hNv3sZGGwAfMlgY1NzDZib+T5QoGkOfzo//QzwUM
 +9lx2svnxyMtobBuJ+oBAI422mXy3+WTM7f5IVNSwRdF7akXR/zFIQ1ApmL75VR+Xd+M0rXg5sL
 0vRxu2uJ46+oEoJX6wQQZShvmiOCr3+BK41vn6GQV+h5ic5X+qCfKU5q+XFMqcgK0FUq51vCsP1
 hqJVpSJD9ITj1+HpvHJBmTHgyono9CC1SGZzg6+UatIrt/ruXjudxYtJUtQR7COv6ke09BpeKl7
 gbYsCdmV0FVmwKCt5n/96TnE+sfKNt4n8QW+IJdvCpGESRbb+SZucNfPg1T0SUR+fbWjvm33jfQ
 x4ZsLXMcEpofc+TSOnAcvjR1P+PhjokG5p2WY1lvtMU3vQL3mygym+WYUBLjZaTP5pLK3IPYyBx
 aumSwgSK2LAJHFyuxYwr+svmCCnSCaV6PgBglFjp0f0ceFyAzgPnslgK7DSDYCaGzJ8w==
X-Received: by 2002:a05:6000:2508:b0:43c:f5a0:4e56 with SMTP id
 ffacd0b85a97d-45eb38e0867mr29200041f8f.42.1779782006378; 
 Tue, 26 May 2026 00:53:26 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d49132sm33475032f8f.24.2026.05.26.00.53.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2026 00:53:25 -0700 (PDT)
Message-ID: <1795fc9c-f82e-40f1-aab6-ec24ad02a918@linaro.org>
Date: Tue, 26 May 2026 09:53:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Question about tb_flush()
Content-Language: en-US
To: Warner Losh <imp@bsdimp.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>
References: <CANCZdfr6xs9n8sF8AXVWVu9i2_rViKErrMHAVbopnaor4uCN6A@mail.gmail.com>
 <875x8g1pmi.fsf@draig.linaro.org>
 <CANCZdfqT7r9jcTuiwe3=CcjRExL-FP1msx-Q8ftQM5amJ_t0YQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CANCZdfqT7r9jcTuiwe3=CcjRExL-FP1msx-Q8ftQM5amJ_t0YQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 24/5/26 18:57, Warner Losh wrote:
> On Sun, Feb 1, 2026 at 7:54 AM Alex Bennée <alex.bennee@linaro.org> wrote:
> 
>> Warner Losh <imp@bsdimp.com> writes:
>>
>>> OK. I've updated bsd-user fork from last year to yesterday. I had one
>> question.
>>>
>>> I see that we've gone from tb_flush() to queue_tb_flush(). Why was that?
>> And is it a drop in?
>>> FreeBSD's fork has this in the thread creation:
>>>
>>>      /*
>>>       * If this is our first additional thread, we need to ensure we
>>>       * generate code for parallel execution and flush old translations.
>>>       * Do this now so that the copy gets CF_PARALLEL too.
>>>       */
>>>      if (!(cpu->tcg_cflags & CF_PARALLEL)) {
>>>          cpu->tcg_cflags |= CF_PARALLEL;
>>>          tb_flush(cpu);
>>>      }
>>>
>>> I think the right thing to do is to just change this to
>> queue_tb_flush(cpu), and that compiles. I'd like to get some confirmation,
>> though.
>>> Did I parse the changes right?
>>
>> Yes, because ultimately we use safe work which:
>>
>>   * Schedules the function @func for execution on the vCPU @cpu
>> asynchronously,
>>   * while all other vCPUs are sleeping.
>>
> 
> So I've done this in the latest blitz branch. I encountered one gotcha. I
> replaced it in the one place, but that didn't work too well. I finally
> tracked down the issue: I had implemented the change in only one place
> instead of the three required locations. I also had to bring the
> begin_parallel_context() function over from linux-user. I like
> user-internal.h that's in linux user. What is your touchstone for deciding
> where that code belongs in it? I'd like to do the same in bsd-user once my
> upstream focus shift to refinement of blitz and maybe my next cool thing
> there.

All common code should go under common-user/ and include/user/.

