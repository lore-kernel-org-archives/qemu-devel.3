Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6216107637B
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 13:46:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7vtM-0000Tx-4x; Wed, 01 Apr 2026 09:45:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7vtH-0000TA-IX
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 09:45:51 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7vtG-0000oW-18
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 09:45:51 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-486fe36cfabso6175935e9.1
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 06:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775051148; x=1775655948; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xTY1i8KyjqkYPU57LBCdszpxncZOEORaGdc2rA7xtm0=;
 b=EM1BWAzpKj+MRJ20+jNlrEKZziD3E+L6bryZQBUfp1FUhOJn8n6JX3/7k20V7uwaXz
 xdIk5uMzKDtb++vK5PjIi4kopihk/7U9Fa8DDckGg4RYaUlFxY8eSrGmk03rZSv+mCmA
 GAmn3klD761dmxmv2PR5H8/qkmNdy0u1Zx/haMctSQG5TJTEhqC5eZ+6k6pFJ54WTH4q
 IxO0H49nuSN7i0n4VIQV0ZyX/+sIqsH5cE0j6Uke6XxGCkKcSlQMXMGKh7ltUsjb6GaU
 ORidNaWpz+v0AtXGqMth/Qoz4YBwi8aukeQi32ytXVMygAnXqd1NH9IC0mmF+rUj5r3h
 hRPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775051148; x=1775655948;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xTY1i8KyjqkYPU57LBCdszpxncZOEORaGdc2rA7xtm0=;
 b=q080FaMyFtrVvCE7A4iVoW3lje30lCLmDKZxnVhHmSJ4BQ7gzcqIscqUI7A3wsgU80
 VR3uTXw/6F0PNnv8K/nwcVCSVyZD6AiYtIMhZT+oL5uGPUqEUxZf6BHuLZJ4+wo/8jNE
 ufnDbN2jkoMM9zf2DmKaIR8WJlg95iR4fMY/1L7NXFsb/HvQLNRXNkNsw3fONUa+8XjQ
 DK1w1Vctjfu6EwplVxlHI+XLEEOPqVV7nR0Ag8KyH/hauVoyiXrfx+3jdkhEx5gsj3Hl
 lDyvYIucbLqPVWOv8lvU+WTDHuYjsAKNvKeqLpSsLFPe3X8uGzMerI4mVXtzcicqdy8u
 zEmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUY1iOmgQ2guEddSJOJR0/CVs1CAPAfJc1lbHON+wDfgNAHi3MdRTDpQ6DmIGr9BzW86dgXTyK+bF0W@nongnu.org
X-Gm-Message-State: AOJu0Ywo75ckHF80Lb6bA+ABVScAhRqNQR35F+8QLniYvllYJXB4qvcC
 0mW9cf15nUnNsI0VdVrU/wdvJ9P3JicR/lb2AArUYhRslVZbN/FMOOniyG4764X6SzB3QvY6wPo
 S5dRlcgY=
X-Gm-Gg: ATEYQzw2KVsL2RiaicmQx7KT7zHpAagCOCgyyeMdZ4aa2PsYM74JHK5Lrho05o5X1oA
 QTUrznUreepivuzJh1E7Ier/b/E+n6iK34Bg2Pc11Jl8QitIILjgk1SKY1yD+fmz6MR+r3o5Fd3
 rTGua7eQuXN7sl8RSGBS4tQP+W3iAEpOfQnSkIggBvWnW8fYH0yf5E5tLQfdAhzKFWXF7/rySyq
 WnK17b5gfTDTj/JCYzEghYuLqpY318V8C384c9nmTgA03FrXvCJa3dxU9mVBMOSuoriSkPbqiI2
 33NEppelSKjwsy+DXdFKGJKu9mIgcu2xeLyVzAk6t2jAS3AlU7IDDw8sDaTDYB6kNTma8TkXmnK
 dsccleFyucgzv5seSwY7xKNIxziVN4QsvicdIueobKuGBRTUeR4MWxHlFhn60vslnBjp2G4zehf
 qXl2ztvlbMebxSYaMjghLeVRpak5Gchbv1KgK4XGJkG06iAA1Qu6sHiv97f1D5aGxW5FYKLE4jq
 qMC
X-Received: by 2002:a05:600c:1e85:b0:487:12c:e7ea with SMTP id
 5b1f17b1804b1-4888358935amr53913545e9.5.1775051148356; 
 Wed, 01 Apr 2026 06:45:48 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887ad1cd86sm44517815e9.5.2026.04.01.06.45.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Apr 2026 06:45:47 -0700 (PDT)
Message-ID: <cb44bbc5-9b71-42c8-a831-6b4495dc5f52@linaro.org>
Date: Wed, 1 Apr 2026 15:45:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/60] ui/console-vc: decouple VT100 display updates via
 function pointer
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
 <20260317-qemu-vnc-v1-20-48eb1dcf7b76@redhat.com>
 <90642606-419d-4217-8e8b-b6063d660a05@linaro.org>
In-Reply-To: <90642606-419d-4217-8e8b-b6063d660a05@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 1/4/26 11:17, Philippe Mathieu-Daudé wrote:
> On 17/3/26 09:50, Marc-André Lureau wrote:
>> Replace direct dpy_gfx_update() calls from the VT100 emulation code
>> with an indirect call through a new image_update function pointer in
>> QemuVT100. This decouples the VT100 terminal emulation from the
>> QEMU display layer, allowing different backends to provide their own
>> image update implementation.
>>
>> The QemuVT100 typedef is changed to a forward-declared struct so the
>> function pointer signature can reference QemuVT100 itself.
>>
>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>> ---
>>   ui/console-vc.c | 28 ++++++++++++++++++++++------
>>   1 file changed, 22 insertions(+), 6 deletions(-)
> 
> 
>>   static bool vc_chr_open(Chardev *chr, ChardevBackend *backend, Error 
>> **errp)
>>   {
>>       ChardevVC *vc = backend->u.vc.data;
>> @@ -1205,6 +1220,7 @@ static bool vc_chr_open(Chardev *chr, 
>> ChardevBackend *backend, Error **errp)
>>       }
>>       dpy_gfx_replace_surface(QEMU_CONSOLE(s), 
>> qemu_create_displaysurface(width, height));
>> +    s->vt.image_update = text_console_image_update;
> 
> Isn't it better in qemu_text_console_init()?

Nevermind, I now see this ends in vt100_init() in patch #30.


