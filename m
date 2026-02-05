Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9970BECD9A6
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 20:58:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo6Qc-0003PV-TR; Thu, 05 Feb 2026 15:58:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vo6QV-0003Lx-Rw
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 15:58:12 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vo6QU-0005UA-Ft
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 15:58:11 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-482f2599980so16211675e9.0
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 12:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770325089; x=1770929889; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=n4D2CnS9K7tcTjMbgFAUMfeZtEpxK9wYWNpQnQlf9D0=;
 b=cE4sC0sDuz5CpuHzaIS2TWUBpctsLcyTdwCc/ABOTduog4JDjAS6MtDA9hqB4+G0ev
 hO9I3/uNnpHBN/IX8Gil3en1SCA8YSaX3GPW8BuCJn12sLCFZFL7MYHtGu+dtpFteRvx
 2MAY8bUFcpsUcOcwox7IxJ4Ocne524RCGkQFF0bi1He00uq+4LkwsEG4KLafDdTtAthZ
 I+JBwVTswsR6Trac8hpqkJmcsU/YOLEL6hBIb8xFGE/+Kb3+s3zlyvoN3/BZkVt7hsOE
 Xc6795JR4SO5qedYrEs+nkWB0ETGnvtZDVY0vIkB2Y6zOkprM7It0SVWKcPt49rPwaDh
 Kzgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770325089; x=1770929889;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n4D2CnS9K7tcTjMbgFAUMfeZtEpxK9wYWNpQnQlf9D0=;
 b=sOHhmfiOW05jjsYHDe/TOqI0EqabBB69M+Qx7PuHKFF3cSwR/p99CvRYmB3mMZNwz8
 cuCLI9l8niRvfQsboE5WeRTFjrJaSjIvvD1/0ZfevFCcUX/+2VxIM7D8yVKHLv7MJ6UN
 43xQzEqRL4aJrUI6qBdZ9QHm3pHGmx5C7Pna5snP/G0zyn3Mx0R7+hn7JCvqK/Zx/v2A
 nYK6jsk915dOdtk8u4A8xz1VrzsIHg4nDbspA/mKd+W4y8NEC8xZ5fmgA5jBr/fIC9QH
 8G2qC/O/0XItikjCpW3olwc2sMh6e/RFZ+DZlo/jVdhfGEeSQUaw6RkJ8kx3unmWNjrY
 Tceg==
X-Gm-Message-State: AOJu0YwuWjZV8/DG9usb3soT28liy9czaC4abr3w+XMwyHW3RCfFKser
 eRvbR0Ai+sCmfHqlWJOVfnbLmjcgm4buK8BsTatTMTwEJ3CtksUEALe8PGv3Fhe6S7+yWKKv9hW
 bD0uNxnQ=
X-Gm-Gg: AZuq6aKzpsUgpt00cLKCvn2qYUbaCYNSUIcvB+qXXPNb1SrN2yzHsWocdPq6UnYLy+f
 4LLBA52kauBVZuJirkuQ1NuM0MEdY2A99hqKt/kXj4sW+gbSXoF3B5XmrFdhgOO8pOT/ondWVlv
 S6aE4luA9yDODeBQdlX8ISDY+iOl3L+pk0j8xwdi6VQDKZAyNJ+o+FLl2nNAaEbasonFFyA+zkz
 HQewqfDVyRkV3iX2Mmf3jSphlfMeSQj56ht+0VchNfJ+XMUsaYaPvp/Qejx0WRTKTKz4uUIbiid
 SFnljJaXxXCs5ljie/v9tv8YCqmqjI4btFYn9RHFOaxQNVtByifesYxwqcRJS2rjvIhkNOP3Sjq
 bM3Er8oyBbRqGHk1hVBPFP590hia4O5VapjKDn0yaDBsHA53nNyvyzXXrcOb3XypPgDYZdddTWC
 p86KOtQMUEPaYTAGQ8sLE56Ojn0ONQeK3fZm0sV3XitHV3MrOZ+ffnsQ==
X-Received: by 2002:a05:600c:8719:b0:482:eec4:76d with SMTP id
 5b1f17b1804b1-4832021b461mr10523835e9.17.1770325088989; 
 Thu, 05 Feb 2026 12:58:08 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-436297460a5sm872692f8f.32.2026.02.05.12.58.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Feb 2026 12:58:07 -0800 (PST)
Message-ID: <d637d1de-200c-45d7-9738-043493207f3f@linaro.org>
Date: Thu, 5 Feb 2026 21:58:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] qapi: Add hexagon to SysEmuTarget
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Brian Cain <brian.cain@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20260205030617.266625-1-richard.henderson@linaro.org>
 <20260205030617.266625-2-richard.henderson@linaro.org>
 <CAEqNhNbw3EKT1Cra4-UjMxvNCa+4Acjg_OFwdLvBdW3rcLudLg@mail.gmail.com>
 <2473c90e-7171-421d-99ab-a2448210ba2c@linaro.org>
In-Reply-To: <2473c90e-7171-421d-99ab-a2448210ba2c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 5/2/26 17:01, Philippe Mathieu-Daudé wrote:
> On 5/2/26 04:49, Brian Cain wrote:
>> On Wed, Feb 4, 2026 at 9:06 PM Richard Henderson
>> <richard.henderson@linaro.org> wrote:
>>>
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>

I suppose you meant 'Reviewed-by' ;)

>>
>>>   qapi/machine.json | 4 +++-
>>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/qapi/machine.json b/qapi/machine.json
>>> index 907cb25f75..ef8575b6eb 100644
>>> --- a/qapi/machine.json
>>> +++ b/qapi/machine.json
>>> @@ -28,6 +28,8 @@
>>>   #
>>>   # @loongarch64: since 7.1
>>>   #
>>> +# @hexagon: since 11.0
>>
>> I-owe-you one hexagon sysemu :)
> 
> Please!
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 


