Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CCEEEA8549
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 23:10:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzNGf-0000OU-LD; Sun, 08 Mar 2026 19:10:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1vzNGZ-0000Mv-GR
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 19:10:31 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1vzNGV-0008O5-Gn
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 19:10:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=sXbhxsVI3zWGvGfTHn/bIPgdJnkCYT30kW/kZ8+nk6Q=; b=aJr/M7szoYobcNqM48eCHQ51Sd
 bw6Ti0KhwpjAJ4KdEbtbgeZUSqo89CJeGnFHElgEZwU+Bbim0iijvQ0C0yPzif8P3LMHezOx5zw9T
 vwlcFHuCS/6yOWwmCv3Ibn1E4j8nnD0JmawSy/Gb2vAeQ9owBWSW5XgoGJDkrfh/obNxdPre8ZVPw
 YHGaGKdlaqKBCvzU5E5HAICoDcKQmdxjId6cvCat66s1dghfb3iyJBGmlm7GGPgp//WxBzNxSD51p
 Xp7L6yJNwHCyV+ORznIY41lZSCX6Efz2on0kQvsr3JyQVD/qsPnRD8ny/MzU2GL2ZkgmjFIQ9dJuO
 qxs7tz/kscZZ+PX8XptOoeQyLzSMr+iRnFdQ/eYhL8EWajOT/bokuZ9sAZ9xJN9lPRuqC/09kYxzP
 sSRMqxt5mAgTsUhvtSRRqSomhKeh6N/oEWDZ+jqEA1TRFzDxG176tkREb1owTg8chE6K/14136C9Y
 vZsjnHqBsAePAInM+WA4DP8fN+d4nszyyZ8Q6HqtmNQJdzwxoDS9nuaI83YrVEXcoCbNhBDmx8ohV
 9w4AqJPnCrSJcQNAfWc3dHOTo9sLRG6O8KkFn4APUZ35/1Kb7prB5EY0yvRVehW0YHqE+CubWGLVp
 sDu8GDUQSJWYDxf4O6+O/yyTvmFscBhTWFMLcnbOc=;
Received: from [2a02:8012:2f01:0:853d:6c6b:2689:bc0e]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1vzNDc-0004n5-6L; Sun, 08 Mar 2026 23:07:28 +0000
Message-ID: <3df9a747-2c55-4442-ad84-9c3a03bb061a@ilande.co.uk>
Date: Sun, 8 Mar 2026 23:10:25 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>
References: <20260307112931.3322532-1-peter.maydell@linaro.org>
 <20260307112931.3322532-4-peter.maydell@linaro.org>
Content-Language: en-US
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 xsBNBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAHNME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPsLA
 eAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63M7ATQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABwsBfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
In-Reply-To: <20260307112931.3322532-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:853d:6c6b:2689:bc0e
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 3/3] hw/timer/slavio_timer: Free resources allocated in
 instance_init
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 07/03/2026 11:29, Peter Maydell wrote:

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
> 
> diff --git a/hw/timer/slavio_timer.c b/hw/timer/slavio_timer.c
> index 4a3e227fba..eccdc532fb 100644
> --- a/hw/timer/slavio_timer.c
> +++ b/hw/timer/slavio_timer.c
> @@ -62,20 +62,21 @@ typedef struct CPUTimerState {
>   #define TYPE_SLAVIO_TIMER "slavio_timer"
>   OBJECT_DECLARE_SIMPLE_TYPE(SLAVIO_TIMERState, SLAVIO_TIMER)
>   
> +typedef struct TimerContext {
> +    MemoryRegion iomem;
> +    SLAVIO_TIMERState *s;
> +    unsigned int timer_index; /* 0 for system, 1 ... MAX_CPUS for CPU timers */
> +} TimerContext;
> +
>   struct SLAVIO_TIMERState {
>       SysBusDevice parent_obj;
>   
>       uint32_t num_cpus;
>       uint32_t cputimer_mode;
>       CPUTimerState cputimer[MAX_CPUS + 1];
> +    TimerContext timer_context[MAX_CPUS + 1];
>   };
>   
> -typedef struct TimerContext {
> -    MemoryRegion iomem;
> -    SLAVIO_TIMERState *s;
> -    unsigned int timer_index; /* 0 for system, 1 ... MAX_CPUS for CPU timers */
> -} TimerContext;
> -
>   #define SYS_TIMER_SIZE 0x14
>   #define CPU_TIMER_SIZE 0x10
>   
> @@ -400,7 +401,7 @@ static void slavio_timer_init(Object *obj)
>           uint64_t size;
>           char timer_name[20];
>   
> -        tc = g_new0(TimerContext, 1);
> +        tc = &s->timer_context[i];
>           tc->s = s;
>           tc->timer_index = i;
>   
> @@ -420,6 +421,15 @@ static void slavio_timer_init(Object *obj)
>       }
>   }
>   
> +static void slavio_timer_finalize(Object *obj)
> +{
> +    SLAVIO_TIMERState *s = SLAVIO_TIMER(obj);
> +
> +    for (int i = 0; i <= MAX_CPUS; i++) {
> +        ptimer_free(s->cputimer[i].timer);
> +    }
> +}
> +
>   static const Property slavio_timer_properties[] = {
>       DEFINE_PROP_UINT32("num_cpus",  SLAVIO_TIMERState, num_cpus,  0),
>   };
> @@ -438,6 +448,7 @@ static const TypeInfo slavio_timer_info = {
>       .parent        = TYPE_SYS_BUS_DEVICE,
>       .instance_size = sizeof(SLAVIO_TIMERState),
>       .instance_init = slavio_timer_init,
> +    .instance_finalize = slavio_timer_finalize,
>       .class_init    = slavio_timer_class_init,
>   };

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.


