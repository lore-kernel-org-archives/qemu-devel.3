Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3884CFC9EF4
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 11:41:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyq1a-0001G4-P7; Sat, 07 Mar 2026 06:40:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vyq1Y-0001Fh-Ue
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 06:40:49 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vyq1X-0007tM-9u
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 06:40:48 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4837f27cf2dso94344505e9.2
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2026 03:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772883645; x=1773488445; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ABJ9TM9lH4/bEhXWEJHA0MOznuyon1sbQHNqxCYeIo4=;
 b=Ca7veobXvSOSQRpkKI7dtZOBfUaDXHuhKmJggQqEAw1kXCDkTPhbtr0je/qIxjc/m5
 qkx02ExUNAPyY9F5fNF34cj8fnxLyudsdRiOGLUq2OR+IH86iSmrOSHa5mPp7CPWN1sL
 FB9jRB5poe3CELRua8/JA11Cl0gMtUEIg6QC6bDH3X4slZuDiN87yCcSwkeOta+FMTsD
 oJaRP61HjdQgsQ58/P1T+xkhh4ry8LOFlwU36bQ46XfqwKVRBcyqTr8137lXvYP712bN
 lj7V8BNSjBcSiCT1PrL3TEjB5Iu7FiyDE2gVP6P9BYcaDqqTCZL9olJF782oEbiGKR+S
 7iRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772883645; x=1773488445;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ABJ9TM9lH4/bEhXWEJHA0MOznuyon1sbQHNqxCYeIo4=;
 b=Lk7CBuRXyWK4h1+u3gQ2ulFJWhiVYtySDXc/EIQCm2YAYtOfEdSqELn82U3p0Jm3CZ
 UXIZOXK4m9Kg9pBoKIQpErB151t5o2P1f0bATc/bSkuJqW82JhJTm+Ysrsfdy5cO6vVm
 O2ax4xyGdMyBDj/s75IAk197azx7h8gKvqGrBcSlv9VZetzhgv4wOuP2AbxU8uGfB8Pw
 1d1rJ8Ti5GGlkhd5A9wTRxF5uHP7TCZFANHoxVPoP8ygNOLzUXvkBHOF66wVR2TrE+OT
 sYSnmw8M+aLIgNbyPCOzN6jooiZLfN8eVMJFYw8+Qny8ELEna+SH1NPPbwQD6KM3kZue
 TT0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUiLaqwbck0884YUkwfNowMZM3rEOsRTxUQtpdWGvD+fW4HKUooJveC0Szi1IgmdxdLsyms0OwD/NY@nongnu.org
X-Gm-Message-State: AOJu0YwSYIaVgRG0/HF2sGRcgV9+o7SICMtG/bpIzU4du1H26E2Ds7EF
 tXwmdbGrQNsAsyJxE1KpKmgKRRBW23Ab8JKuy1X/m/5b7ZI53jFKfyvU/E7B2uYJMvXzDt7XSl2
 5SgLdYow=
X-Gm-Gg: ATEYQzxb0U0oLPzQQZvm1Mo2JvTaqBafdtBewMiQQdEpU74lMkG6Df+DoSKyZh48hD/
 cduS+6LjNPuvpw5tYJesOuCAwg18nFz96KS0M3Cm/zc0KwVfL/ERJBkGZHzN3/m76r2Yh+FXbBr
 XLlI8jsiWTtKiO8RWh60EL9UNQoRuTal1YFO9L1T477AAYyCW6SBQGrtoYs02aFSrEyGebg3jl1
 mHqoN/8PdkyeVhL1gMkHpx9l18iIv/LmRNAeBXFoR+dviMiWwfR/IrbKDFEUjDJy38JrrTg8TFU
 Frwc25fZx/9it5UeeGzjeieBTXq0dhR8saBv/TeC88H4in6dHemOaflE7ZQ3s9j7LIhmZdt4UFu
 ymaWwqiLDktqoqNAXnrLgLvy0wXWlKW7BpWE8TGljfxb6Q8ToCLfKGhS13aD3Jdu7BV33UEoHxi
 FykYANWg5nJe1uSFg0wb+q63fA3F8rI9N8JHZExXM7q+BlQtjqKvqPxjhmV9QpxMEy9g==
X-Received: by 2002:a05:600c:870b:b0:47e:e8de:7420 with SMTP id
 5b1f17b1804b1-48526957c7bmr86691745e9.22.1772883645201; 
 Sat, 07 Mar 2026 03:40:45 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4851fae0202sm260053295e9.6.2026.03.07.03.40.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 07 Mar 2026 03:40:44 -0800 (PST)
Message-ID: <9e74c889-5363-4312-a939-3e9c16579fc0@linaro.org>
Date: Sat, 7 Mar 2026 12:40:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] hw/timer/slavio_timer: Free resources allocated in
 instance_init
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
References: <20260307112931.3322532-1-peter.maydell@linaro.org>
 <20260307112931.3322532-4-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260307112931.3322532-4-peter.maydell@linaro.org>
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

On 7/3/26 12:29, Peter Maydell wrote:
> The slavio_timer device's instance_init function allocates memory for
> TimerContext structs and a ptimer, but it never frees this memory, so
> we will leak it if the QMP interface does introspection of this
> device type, as reported by the clang address sanitizer:
> 
> Indirect leak of 4896 byte(s) in 17 object(s) allocated from:
>      #0 0x5f2948d9b14d in calloc (/home/pm215/qemu/build/san/qemu-system-sparc+0xe0c14d) (BuildId: 7210711bdf6f7fbd0b863bd2dfcc7c42c7175db1)
>      #1 0x758584b11771 in g_malloc0 (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x63771) (BuildId: 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
>      #2 0x5f2949097b8a in slavio_timer_init /home/pm215/qemu/build/san/../../hw/timer/slavio_timer.c:403:14
>      #3 0x5f29495d790f in object_initialize_with_type /home/pm215/qemu/build/san/../../qom/object.c:570:5
>      #4 0x5f29495d96ef in object_new_with_type /home/pm215/qemu/build/san/../../qom/object.c:774:5
>      #5 0x5f2949a30a26 in qmp_device_list_properties /home/pm215/qemu/build/san/../../qom/qom-qmp-cmds.c:206:11
> 
> Indirect leak of 1632 byte(s) in 17 object(s) allocated from:
>      #0 0x5f2948d9b14d in calloc (/home/pm215/qemu/build/san/qemu-system-sparc+0xe0c14d) (BuildId: 7210711bdf6f7fbd0b863bd2dfcc7c42c7175db1)
>      #1 0x758584b11771 in g_malloc0 (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x63771) (BuildId: 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
>      #2 0x5f2948f7c65a in ptimer_init /home/pm215/qemu/build/san/../../hw/core/ptimer.c:464:9
>      #3 0x5f2949097c1f in slavio_timer_init /home/pm215/qemu/build/san/../../hw/timer/slavio_timer.c:407:32
>      #4 0x5f29495d790f in object_initialize_with_type /home/pm215/qemu/build/san/../../qom/object.c:570:5
>      #5 0x5f29495d96ef in object_new_with_type /home/pm215/qemu/build/san/../../qom/object.c:774:5
>      #6 0x5f2949a30a26 in qmp_device_list_properties /home/pm215/qemu/build/san/../../qom/qom-qmp-cmds.c:206:11
> 
> Avoid the TimerContext leaks by making them an array inside the
> SLAVIO_TimerState struct instead of allocating a compile-time-fixed
> number of them each individually with g_new0() and then throwing away
> the pointer.
> 
> Avoid the ptimer() leak by calling ptimer_free in
> instance_finalize().
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/timer/slavio_timer.c | 25 ++++++++++++++++++-------
>   1 file changed, 18 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

