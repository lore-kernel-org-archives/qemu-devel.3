Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E47A2D35163
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 09:33:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7rx9-0002uL-QM; Wed, 01 Apr 2026 05:33:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7rx8-0002u8-EL
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 05:33:34 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7rx6-0006du-S3
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 05:33:34 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-486fb14227cso88130975e9.3
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 02:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775036011; x=1775640811; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1Jlb9cd0CWMGABn2x9gXbLYIptmaim5a9hxjOI8GvsY=;
 b=NVwVaFT9uFpVpEnUsDq4gEgRDyNOMkvFyVuW2QMylUmoclvQzQFCAWC1UG3jBE/fHJ
 xtn+LOhwigantPQUCmGX7AYeTc2okawOSP3ENo5Wyy5dZxluUgMI7hQf0Ae9Xido+xBO
 XTz2SFn83+SjnIKcZLiv4NW/BNMo8AtY+HKi2OXB0OS8U6iR3z9lV0vTY4z5vIXg1UxZ
 VTxwY0kYiA28hASuWSoEZomk60JtwIHOjsUCKmS6QJ+W5hepWRJFERfMb73PPbyFh8ll
 5wbEURHlq6aWlPIWoWKGfO3qzfzkbK5I9JG9kSbI761eAz1LeAjLRQ8xgArtEohn5CyC
 iEOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775036011; x=1775640811;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1Jlb9cd0CWMGABn2x9gXbLYIptmaim5a9hxjOI8GvsY=;
 b=AvuywHEDgfSdjYIFOjT4yf1c/efHfbuykWp/xh0PbUIJfgn158phwMse43nLa53HoN
 JzJ4d0KNtXiD4QIbax9HtH6JleT3MMGs9V1rW3XI4dvPAqqz8iIDS0A7D8Lh9xc1fldV
 /PFlDU+ownIfFzYsd9b7zL+w9ZeXDrlFVD8CuC/ECosPlcrWP3K+Qqqdp2a+JhIhmVEi
 Z3x43qXHNSYe79CRTl699JYmo/p/u9UH146K9SkXX/a+4e6AbIr0J6PPzSU1Txv+BS1z
 s+EskAKFYaw06NytY+JGSu1FFvSBQtc0y0d1tqvd2/BJC6wRaI7vFCnl5x6kRefJYlWB
 7N3w==
X-Gm-Message-State: AOJu0YxITkSW3Mm2IfiaftJ1zj5j82MO8SrV1QWCPFsgRnJqxZ5Q4in8
 enoCvRSc/P9y4ZdKxdsEiU2DF+90kFETXok86gFiUq408SKKhFoVAXniYvwJF8qA2QpwSIsVm8E
 X8qRfpKc=
X-Gm-Gg: ATEYQzyn8izI9X9o/Pch2OY40P+7gseY13xf8m0D5zZ1UB6n/J8f1+AZ5YnAm0ZOp11
 oysUzYtbAPBRlN5vvOQWFVIYZN4TglYs9tAv8Y4AskWLFy/zRrvd8u8a7nDpTqsDAF9ZOrZq2bu
 sYjvkwv58OiL11FACC3CfAwTIBoW8EItsCy8tmAGcdIgZ5gqWwjvHHkGOWwn+NxR5sY2oa3R3Xy
 FO9aEl8w8FAvuQ6nfLzhu1Lw39ecysfeBPhKcy1yjJkBNMdwkMj4mOw3Bp55KFxIlks1XOMr4NM
 qihhOjMgCN9NQ69qwkGGrx+JmOy12cbRjOXSW8BO68evuMB4c/oCXfDnzR8xlqXYhLXxgLabiIo
 Z+VNbfN7D7dI4o5ErLwTtJqKTrljSD9KEBkAbKK2MpcX1pBdzflUvuW98Tw/sAr0tMw+3LGenCs
 214wTcQDEnW3z/WhpXw87mLtNxe0Qw+Mts+AuMNT/oGjJKqpdTirh6SGtlW7CB9T4DQQ==
X-Received: by 2002:a05:600c:c056:b0:485:3a03:ceca with SMTP id
 5b1f17b1804b1-488835b30a7mr30916745e9.23.1775036010914; 
 Wed, 01 Apr 2026 02:33:30 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887a633f23sm39261535e9.0.2026.04.01.02.33.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Apr 2026 02:33:30 -0700 (PDT)
Message-ID: <0b02f1be-dad6-4845-b505-5d9037c88584@linaro.org>
Date: Wed, 1 Apr 2026 11:33:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 40/60] ui: minor code simplification
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
 <20260317-qemu-vnc-v1-40-48eb1dcf7b76@redhat.com>
 <acKgEm0F_Ghh4fRB@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <acKgEm0F_Ghh4fRB@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 24/3/26 15:30, Daniel P. Berrangé wrote:
> On Tue, Mar 17, 2026 at 12:50:54PM +0400, Marc-André Lureau wrote:
>> Remove the extra "info" variable and its initialization.
>>
>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>> ---
>>   ui/sdl2.c | 10 +++++-----
>>   ui/vnc.c  |  7 ++-----
>>   2 files changed, 7 insertions(+), 10 deletions(-)
>>
>> diff --git a/ui/sdl2.c b/ui/sdl2.c
>> index aaaede56e0e..3ffb8acaff8 100644
>> --- a/ui/sdl2.c
>> +++ b/ui/sdl2.c
>> @@ -600,11 +600,11 @@ static void handle_windowevent(SDL_Event *ev)
>>       switch (ev->window.event) {
>>       case SDL_WINDOWEVENT_RESIZED:
>>           {
>> -            QemuUIInfo info;
>> -            memset(&info, 0, sizeof(info));
>> -            info.width = ev->window.data1;
>> -            info.height = ev->window.data2;
>> -            dpy_set_ui_info(scon->dcl.con, &info, true);
>> +            dpy_set_ui_info(scon->dcl.con,
>> +                &(QemuUIInfo) {
>> +                    .width = ev->window.data1,
>> +                    .height = ev->window.data2,
>> +                }, true);
> 
> I find this new code less readable than the original. The compiler
> optimizer can remove uneccessary variables in this way.
> 
> I would, however, suggest removing the memset and doing
> 
>               QemuUIInfo info = { .width = ev->window.data1,
>                                   .height = ev->window.data2 };
>               dpy_set_ui_info(scon->dcl.con, &info, true);

Using suggestion:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


