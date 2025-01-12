Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3487CE77188
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 18:06:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX2Ll-0007Fu-KY; Sun, 12 Jan 2025 13:06:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX2Lj-0007Er-Lx
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 13:06:11 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX2Lh-00049G-2z
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 13:06:11 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-436345cc17bso25682045e9.0
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 10:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736705167; x=1737309967; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=otYinShyAewOwnmISiuz+1tAv1Ix0O1Ac884qz7ORwU=;
 b=IWB1YY3PTTE2tCyDXGMjzkR5LA4lySThCghUqAttRIPvqJi29+tj53z11EyYjHXE6r
 Pi41/8ZFAdj3Ffae/1pWqEQ8PkpU8BDQDkqNtvRBOtYqHF3rpeGBw5apoItv7TEKc3j6
 xezBS5Yn97VtG8RFHGu1szB0nILSC1LkCUxS+YDnW/QRaqwqXT6YWpvtr/jsXIKhurbK
 uiE+eNrfuUUE3K67poCyDtJLcRtmctrk1l5vaq4C9PCDChwWODiHq0YrtpUpZFlRg6mj
 tx4AVanHpcQ4+OCgeGt9E5Hq74esnb/xlfzxGyohdFAuDIE/azbbX90/4leprvFT6kkK
 wpVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736705167; x=1737309967;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=otYinShyAewOwnmISiuz+1tAv1Ix0O1Ac884qz7ORwU=;
 b=G/rl2ylhQdaYB/0/A4ruU+60gGutnQc3mwNOYTFsi+31dbEk51vjI1WgzfMEeo+0h8
 uxxUrOgEZVnMKt3B8CJPzW6DLCfHWLq1zF2xJ1Uo0twYj4a7f/Ui+Y1AzwtHtEbLPnkc
 CppBLGf0OXgI0lS0csLSuqjBZu3PdqIZwIe0DVLkKLXu8XjwvREgHCWE9VNZ6lU1LNjB
 +z25XfVibUxv44LKpENHBJ7T+mWxKavaFJW4EMHYuCHDoxJv3SY6xyhnhNhwlgDRiHZ6
 Kvxa1PeIQ+Ju0ncuwJiTIc/MluhH1/Yv+BrqHyFRdz2Wt4yCXY5tXZwutZGLR+cI/ULz
 paWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPAI3+cr7CnQBRYk5hHGkq1Fx2IUg19QVJ9jK8QxOcNgQKHGco1gT2YMoCyoC+JNXe8Hx6W2vilTlN@nongnu.org
X-Gm-Message-State: AOJu0Yx/ypWTayeYLI3iJt/DTYjLuBL4fDqkomaIjvChlOb8PE6SvH8A
 E5np2lBWaFTCfgPFp691/Y5O3wLMRBf+WxGVlbmIpE2vryeFfqq1bCrRghfUCjM=
X-Gm-Gg: ASbGncv56ijZh/2wgEzN10OGWPj/XP0/lD2dthILBPJN7Df51iis3VY73JHzQ7h72x5
 ABp5XPxVBgxZ3F9RRyVU4NQRcmGfuTA18djOA88Q669IRvvmMDiWgXPo9DYvGLjNC7CTUycYBy2
 OvLiqbSSnCGgS3XEc8g+ZOddnAlAVqEAI3n7iT3rkDleK3vZrgGokD4uTR35OYNSi/wrfdK/zz8
 3PiToB5ATi94BlT/MJJI3UU8ZP4XP7q5ura+xOYQr+nsVPh/m25YU45QtAOmrSO0zryGavrLYqc
 nAVBE5TANqxWxGqUNg3EdHjk
X-Google-Smtp-Source: AGHT+IEyBEq4dw7oNAHmGUeq1TocyHUNP2E1yqroqxkONOddxsMpLD9sJCCBj/1z7dlhpVWuAdu87A==
X-Received: by 2002:a05:600c:4511:b0:434:fe3c:c67c with SMTP id
 5b1f17b1804b1-436e26e51eemr144060375e9.26.1736705167436; 
 Sun, 12 Jan 2025 10:06:07 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2e89ca5sm152540255e9.29.2025.01.12.10.06.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Jan 2025 10:06:06 -0800 (PST)
Message-ID: <e202623e-eac7-4ed3-87fb-002491ddf745@linaro.org>
Date: Sun, 12 Jan 2025 19:06:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/14] hw/sd/sd: Allow for inverting polarities of
 presence and write-protect GPIOs
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Bin Meng <bmeng.cn@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Guenter Roeck <linux@roeck-us.net>, Andrey Smirnov
 <andrew.smirnov@gmail.com>, Jean-Christophe Dubois <jcd@tribudubois.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250108092538.11474-1-shentey@gmail.com>
 <20250108092538.11474-9-shentey@gmail.com>
 <342ca371-3e14-4108-9c45-e15cda51b9ca@linaro.org>
 <FBA535B4-8191-4CEB-905F-FA4C3416048C@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <FBA535B4-8191-4CEB-905F-FA4C3416048C@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 9/1/25 17:20, Bernhard Beschow wrote:
> 
> 
> Am 9. Januar 2025 11:40:10 UTC schrieb "Philippe Mathieu-Daudé" <philmd@linaro.org>:
>> Hi Bernhard,
>>
>> On 8/1/25 10:25, Bernhard Beschow wrote:
>>> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
>>> ---
>>>    hw/sd/sd.c | 12 ++++++++----
>>>    1 file changed, 8 insertions(+), 4 deletions(-)
>>
>>
>>> @@ -876,8 +878,8 @@ static void sd_reset(DeviceState *dev)
>>>        sd->cmd_line = true;
>>>        sd->multi_blk_cnt = 0;
>>>    -    qemu_set_irq(sd->readonly_cb, sd_get_readonly(sd));
>>> -    qemu_set_irq(sd->inserted_cb, sd_get_inserted(sd));
>>> +    qemu_set_irq(sd->readonly_cb, sd_get_readonly(sd) ^ sd->readonly_active_low);
>>
>> Please embed in sd_get_readonly(),
>>
>>> +    qemu_set_irq(sd->inserted_cb, sd_get_inserted(sd) ^ sd->inserted_active_low);
>>
>> and sd_get_inserted().
> 
> Are you sure? I deliberately implemented it as is because embedding would change the internal logic of the device as well as SDCardClass::{get_inserted, get_readonly}.

Yes, this is why I requested that change. Why don't you think it is correct?

> 
> Best regards,
> Bernhard

>> With the requested changes:
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>


