Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66E4DCD37AC
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 14:34:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMRiE-0008GM-2N; Mon, 11 May 2026 10:34:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMRi1-0008EU-JL
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:34:17 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMRhq-0006ba-74
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:34:13 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4891e5b9c1fso41995165e9.2
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 07:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778510040; x=1779114840; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Bm9PaCYsOeVpqahfI+G/ZWpXs1a5KP3GztgsSOHapMY=;
 b=VvXrJNUsH5o5Dg+o8Gi2vCYVzgUQRgk54LXFC9kxUXb/VhHqqyo0AZDFe9uXYcHn+u
 D+QtM4subb9CpsbUPKbXkHTMeqqdYEct+n5dypuhiFD78UC9xT4CH1nGgVRDKy3oEaZO
 vDjUqmmVTFbrGuwojI2fs+LeRS/VciuXlv8UYwxPiNTwb0yW+oKv1BomhZeqnm1yA0Gd
 p8XtWiBCXFlQgIILe9c3CnQdwcFpRvSTYqKFkngR4SOqwcr0pHWeOXgRlZZpt2aQjlg3
 WuXIa3exvKK6jfYF+iPyoOI5o7JqCJcouYM9WlLoLhF2ecfc7a2waMP5MGGhAUN970L+
 wdAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778510040; x=1779114840;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Bm9PaCYsOeVpqahfI+G/ZWpXs1a5KP3GztgsSOHapMY=;
 b=m87mNYrqOsxROM/Aw2tOGI3rRhhSryL/4yg+3lU0YJfuGyIE29RnaZFBtdc50/Hjc9
 vZowm7Ppgw5u9zUt5tQCAnrCdKFocnAwndy/hDYTD9+jgiLIwMKuVUPbHYwrKMgE37NN
 3Ak78Szdn83g9/UVa/xNDBF05uvUKJ83vayOjwpxCxVHLqFl3Fur8t6L18Q/S7R0eB8L
 DdRRAAmmoO2std5sJqTq+pZ7Biqno4Cfg14QOzhZAIcXOOdc2ht8KHxpSp0xik/bFahH
 kzFij3hJ6FZ7qk3T2ObSKW3hdXeQXOJXLYkP0pkB97bz+ZWIDi/cb+CZkS2aUjabxN3j
 tFFw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/GKWjgJJxT+igILbHX/zUpWogZ3e2MW/9X2FmTpurRDZvyW4KS6a5LdiGSLbXDbTRLmJZDXtNZZ2qr@nongnu.org
X-Gm-Message-State: AOJu0Yy4JxFr3SQ0AMmBbIFQcYrOir9gMgn6VdpkpU0lRy/NmatjDjiq
 9Nvu0cQLk6GGgeoPzfmUXsxOXO/KSj4zpgDZ+Ouy7fklNJpUqDDARiwol/apV/WxwD8=
X-Gm-Gg: Acq92OEAm//lxWw/bP4byx8unMmzXumYxprm9KfErIN2eXjqeAh2nhdZnHH4dNGgWvr
 eLHGWyzKWGbqKUdeMvd8U4RmzayTfxjqvdwhZ9oOuUSoAnMPEQryLE3EswvVhH/tCRQxlhriNRn
 XkLG84pSbRjhu78f+O45g/DC+9RBvCbW0uAaJ5JMhl9wZVirNBrCnRGMPtbhqR6NThMeI68B14s
 WLONMmHJIXry0wuntABL6gbUood+25rH379kb/5BIUlJELpJy1yMi72/b+mQRXtiNb4FqpaRTcT
 ZTilnAtyWDN7YsKyb63Jns83qZJ6jw2McWOyq3oO/SED1wo9XwN43YYErf+ZJ//J7fAikkGfE7s
 JYzcgz/57ywZohjYYQ2YvyY+GznItlUlC6Ll4gH5Zt7P8ZFmR3koNodGF9UJUnb+Sw4aRaBSxOC
 Es9517xbl2WsPqtCP+t5mveEB9tH2mKfOURV+AdHBu0j3BTb5PzE9h8H1flpKdjl8aZA==
X-Received: by 2002:a05:600c:c094:b0:48a:599a:3716 with SMTP id
 5b1f17b1804b1-48e51f40a29mr282691745e9.23.1778510040440; 
 Mon, 11 May 2026 07:34:00 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4549120ec0asm25690009f8f.17.2026.05.11.07.33.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2026 07:33:59 -0700 (PDT)
Message-ID: <fb8c2431-fffe-424d-b03b-37c85f5a4fee@linaro.org>
Date: Mon, 11 May 2026 16:33:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] buildsys: Remove MIPS TCG backend
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, devel@lists.libvirt.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aleksandar Rikalo
 <arikalo@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Aurelien Jarno <aurelien@aurel32.net>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260511135312.38705-1-philmd@linaro.org>
 <20260511135312.38705-6-philmd@linaro.org>
 <222fe848-a46b-43db-9494-8a7d773c3716@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <222fe848-a46b-43db-9494-8a7d773c3716@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 11/5/26 16:03, Richard Henderson wrote:
> On 5/11/26 08:53, Philippe Mathieu-Daudé wrote:
>> We removed support for MIPS host. Remove the now unreachable
>> TCG host code.
>>
>> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
>> ---
>>   MAINTAINERS                                  |    9 -
>>   include/user/thunk.h                         |    2 +-
>>   linux-user/include/host/mips64/host-signal.h |   75 -
>>   tcg/mips64/tcg-target-con-set.h              |   30 -
>>   tcg/mips64/tcg-target-con-str.h              |   20 -
>>   tcg/mips64/tcg-target-has.h                  |   69 -
>>   tcg/mips64/tcg-target-mo.h                   |   13 -
>>   tcg/mips64/tcg-target.h                      |   75 -
>>   tcg/mips64/tcg-target-opc.h.inc              |    1 -
>>   linux-user/mmap.c                            |    2 +-
>>   tcg/mips64/tcg-target.c.inc                  | 2605 ------------------
>>   11 files changed, 2 insertions(+), 2899 deletions(-)
>>   delete mode 100644 linux-user/include/host/mips64/host-signal.h
>>   delete mode 100644 tcg/mips64/tcg-target-con-set.h
>>   delete mode 100644 tcg/mips64/tcg-target-con-str.h
>>   delete mode 100644 tcg/mips64/tcg-target-has.h
>>   delete mode 100644 tcg/mips64/tcg-target-mo.h
>>   delete mode 100644 tcg/mips64/tcg-target.h
>>   delete mode 100644 tcg/mips64/tcg-target-opc.h.inc
>>   delete mode 100644 tcg/mips64/tcg-target.c.inc
> 
> Missed ./common-user/host/mips64.

Oh, thanks!

> Otherwise,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> r~


