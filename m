Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B3A1FD2D71
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 12:57:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzwda-0003eA-Od; Tue, 10 Mar 2026 08:56:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzwdZ-0003cl-Bx
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 08:56:37 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzwdX-0004iy-Pu
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 08:56:37 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4852b81c73aso28554645e9.3
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 05:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773147394; x=1773752194; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2cKCaHuYXGMUWUMnWt5SlLSkZKnm5lkgN7CkXStw8eo=;
 b=IWzNCt6rn5hn59yLkXceaX6249ht2uInNHanKel0obbNrWCs+l5Al67p94Mj76Slxm
 PDusAzK4cQJTkHvYuPNGNt9MrtmWFBa0GnWEaeI2+dKTi4Az3FIpcQOTNPOHt6zHXvXd
 Pc2L3KQl04Qja7P2T2QR6Rr60TtPfgJ1uhZbEmTzP9ZrvQm+w5JyxhfJpeyEbcKgGLWu
 VSyxDaebdhgqSbcVfXPHPsUkZxxjJwV3SfJj7VgXtk8zEsWhcVtsXJpmf0Im8Ah02mbl
 oPcO3EVeyoTH0YeG/C1ZgveIrhiZWMS3A2EHJ7dt/47yQbJcfdzW4H60hfCfunLIDXRd
 Q/Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773147394; x=1773752194;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2cKCaHuYXGMUWUMnWt5SlLSkZKnm5lkgN7CkXStw8eo=;
 b=uv1+cxkIjDCPqzgJAmxNrO9CSxSHg+w40aLzcmv42E8yXzZdo5MK9FBMOfutvD5Qg5
 pPAsLfPoUwXUMC+I+5SP5hlUUxD8ExpHKtPzBnc0zUoN5RYRB2zrT1UB2c897Wg28SIx
 8IJgBfk7D6ZVC0EGLqBdFNTkD/vy4nAvYFGxAqJ63GjJlvx7mb/M9G39FxLTe9RhBOJz
 yLtRUv7eyGtBfIqe0OXX1Rnlyt8Xs7qSla32ZVp1CQ5Btk09TtY3ZnYjlRYgexzICPAM
 TUvTC/UG/b96MNyfxchY6d5WpA7HRCKBD+rAFU7I24mrNduqrumNKqWppXbYQmTL+WKh
 kKyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUn1kQWtN96XnleSLAQRTxh3mjVAcmRqhrTkjP83Zt86Dv7EY5y0nLCkXe3yqzYuuSzyArXXH5pST8O@nongnu.org
X-Gm-Message-State: AOJu0YxGybmlU2QBRcYXwPsP/27683nuLhhbaF7fo1YlqOEtVztd2fz0
 WpOm+gmjFMHqCeyDarviIAtDtyCCnu1kKstNL9bqJHHs8/G+7AWXtUxiJVV+A9PSJNA=
X-Gm-Gg: ATEYQzwbKsBCG3cPw77jhR/KAwZjTieXFeYW8+TXb6buSuQPmdVDwgUa15MLdSSGnSm
 ZxTIaO6Reehy22DxI1bn/Wdb1I0tP8zAJrO3Tso3hdfnvA/sAwrqS/cf2VLpEfP6IAc5dezwrnb
 xAerD1t3vxx45g4xeYgB0Rt/dXdNF6HQdjEzFYJ5v122v8HAbBo/PzEYcZiIoUftwCAhGIpjcn+
 DewJ7jylstQ9z5rddrPpXVskqPidMV+M6v8CiO+Ro+tdM049FDphXKSetblPAFKylUKTMSNvGYt
 ZqbeKG+wVwWpUEEXBIkJyc5eKaKSBGt9714qXAzjrwcXr5SLJ4Jh+SsOsMM2Ww1KwOZl9aAlko6
 je9nP40K9K4jXyAbk/DKTzoOvGGGwmgiSt5cQ0cPF/isZD4uFLknReQH40GzVo6j31w1lAmxPlU
 R+nwWM68ZTcCMK7+PYJ6f6COt6MlMEwGOeOoA3+fazdhw6wINn6eX7kR+hAQQPWPUy6A==
X-Received: by 2002:a05:600d:41c9:b0:485:3911:b8c7 with SMTP id
 5b1f17b1804b1-4853911bb1amr118500715e9.35.1773147393576; 
 Tue, 10 Mar 2026 05:56:33 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485246fd127sm178098105e9.6.2026.03.10.05.56.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Mar 2026 05:56:31 -0700 (PDT)
Message-ID: <4425f6c4-7003-4d6d-9842-3b9c320be0f6@linaro.org>
Date: Tue, 10 Mar 2026 13:56:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ati-vga: Fix sign extension in DEFAULT_SC_BOTTOM_RIGHT
 read
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Chad Jablonski <chad@jablonski.xyz>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20260309212206.2457691-1-chad@jablonski.xyz>
 <1931a6d0-d351-cc43-1b3d-fa3b3b0809a9@eik.bme.hu>
 <e2824e5c-4d1d-4d08-ba24-a8c3056c2edc@linaro.org>
 <de83d589-99c0-9d40-b29e-61f8deb3d249@eik.bme.hu>
 <18a50a29-1deb-41c5-91f1-ae5f76129a05@linaro.org>
 <9233d54a-1a95-0cc9-c118-9c557b8bae4b@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <9233d54a-1a95-0cc9-c118-9c557b8bae4b@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 10/3/26 13:47, BALATON Zoltan wrote:
> On Tue, 10 Mar 2026, Philippe Mathieu-Daudé wrote:
>> On 9/3/26 23:59, BALATON Zoltan wrote:
>>> On Mon, 9 Mar 2026, Philippe Mathieu-Daudé wrote:
>>>> On 9/3/26 22:41, BALATON Zoltan wrote:
>>>>> On Mon, 9 Mar 2026, Chad Jablonski wrote:
>>>>>> Cast default_sc_bottom to uint32_t before shifting left to prevent
>>>>>> sign extension when assigning to uint64_t.
>>>>>>
>>>>>> Fixes: CID 1645615
>>>>>> Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
>>>>>> ---
>>>>>> hw/display/ati.c | 2 +-
>>>>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/hw/display/ati.c b/hw/display/ati.c
>>>>>> index 6cf243bcf9..f9773e1154 100644
>>>>>> --- a/hw/display/ati.c
>>>>>> +++ b/hw/display/ati.c
>>>>>> @@ -514,7 +514,7 @@ static uint64_t ati_mm_read(void *opaque, 
>>>>>> hwaddr addr, unsigned int size)
>>>>>>         val |= s->regs.default_tile << 16;
>>>>>>         break;
>>>>>>     case DEFAULT_SC_BOTTOM_RIGHT:
>>>>>> -        val = (s->regs.default_sc_bottom << 16) |
>>>>>> +        val = ((uint32_t)s->regs.default_sc_bottom << 16) |
>>>>>>               s->regs.default_sc_right;
>>>>
>>>> What about using deposit64() which is uncontroversial?
>>>>
>>>>            val = deposit64(s->regs.default_sc_right, 16,
>>>>                            13, s->regs.default_sc_bottom);
>>
>> (alternatively deposit32)
>>
>>> I can't make sense of that without going and looking what the 
>>> arguments of this function are so I'd rather keep it simple. As I 
>>> said, the values here can't be large enough to sign extend and there 
>>> may be other similar cases that are already marked in Coverity. But 
>>> if we still want to fix all of them then maybe we could try to make 
>>> val uint32_t then do something about it once at the return for all 
>>> cases. That seems better than trying to handle in each case 
>>> inconsistently. The simplest would still be to tell Converity it's 
>>> wrong here.
>>
>> Until the next register is implemented and Coverity complains again,
>> and another round-up on the mailing list until Peter manually marks it.
>> I was hoping for a way to avoid all that hassle.
> 
> Changing local val to uint32_t and cast it at the last return line 
> should also solve this if the issue is assigning to uint64_t without a 
> cast. To me that seems better than making changes to every case 
> separately and would allow me to avoid additional complexity. If you 
> think it would help I can make a patch but I can't test it.

No more time / energy for this topic, so do what you think is best for
the project, I don't mind much anymore. I shouldn't have intervened at
all first, but since I merged this patch, I felt a bit concerned.
Actually the simplest is you mark that issue yourself on Coverity;
anybody can request an account for free. I'm done with this thread.

Thanks,

Phil.

