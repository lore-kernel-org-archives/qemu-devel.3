Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CD7AF3ED5C
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2026 22:28:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBgoe-0004UL-S6; Sat, 11 Apr 2026 18:28:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBgod-0004U6-3Y
 for qemu-devel@nongnu.org; Sat, 11 Apr 2026 18:28:35 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBgob-0004W8-28
 for qemu-devel@nongnu.org; Sat, 11 Apr 2026 18:28:34 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-48897fd88ebso34241665e9.2
 for <qemu-devel@nongnu.org>; Sat, 11 Apr 2026 15:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775946510; x=1776551310; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Vjo9ZyxVJxwBOyoyFIkbpmEqlc6JY7vUPPULw0FWIY0=;
 b=S+BHg1Zyb6H51e5pV4Ym+Kg0iFovWMrSmCfLZ/CfOy3XxmfBBxYVuHbm0+N9eYo7MT
 OreTE7uZE8S5LKi/5CPgkejewnvDb38nCrPFuzP4pB8+dIBNcdMX2W6Jm3UZAS3bCk8H
 cbGjibHw4s1ZGYMpMj7cQCs3exaQI3LPuLFlJpOh3lAmOjJi4ekgJ6Bfu2jVxa3eiuLW
 RRz0cZqvY7Yv0Jn4CtuzyzrjcapLHYf2oHuEsjFlEcL3Nuh4o4CyC8+yI1+qEZRMVJ5Y
 PfeNxZ3oHNln7oCQdPhGjU1PjPZVlTuw8SAkP2GeAesjcj7VkmShGudLWgIZZMi5VXXc
 qKFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775946510; x=1776551310;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Vjo9ZyxVJxwBOyoyFIkbpmEqlc6JY7vUPPULw0FWIY0=;
 b=SKFcTaWlB0fPL21nFSYs3vQe5nIJwbEzR2fOFRJ2MBmlWf1pppL/P3VUK9HQtU/vXJ
 RsEHRkWKC2q1sei+heQyv02L8CzeP5Wazn4JPKphYA9u7jtCS8t7qPCr7KWsiIazSE+i
 vUIROvCg+u+gtbg+aUWaBu+cuU4QcVpl4KcHKFOtFkzVvkmMK1fgVfv//WzZbqMa7EgX
 4xeRIZ0mXrlC/cb7JyrUhbQJo4bLWIYz67wq1yUK6RKaUCwtKhfocLhnjZvKwKAsrOYY
 Zo6+V4PD/57Cp/GZqq1x7h/NoaOJVWXXa26MaK89/FEc6dGFg2aRhgSZ9P/8TvjbhZXY
 4Tdg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVb5b8UPL93P1bFSvv1WzI7S0F/779YYUokuqEygc4/txrOhtafQ1KPbGxQAWpzxySrsNSU0fU2sqhH@nongnu.org
X-Gm-Message-State: AOJu0YzB9wrUZaTWS1QVbn0Rko6Esgqt8JEg6CsBjNPpFcsUMThnuv2d
 8YPTHfEyOfT9wr0oi2lOWW8hEjyv+3lvqLBdaHnGXOjlLw16RRoJ9BkB8TK++BzTnynL3jV6g15
 sGpTKRWw=
X-Gm-Gg: AeBDiesQqV30tLnz8MJoyrtm7CTg860GFGTSTAqAeL6f3BUhGfU0TRLvg5Rgzn4F7bX
 K937wB/1RZ/HGsn5vaQd/khNuTdafJHDUUVukLYY3+rRHfXnWb54RVZnPMzQ8g+WqfL207VpIYC
 zaW1c6Ztfxewg/sjWkeuzPpSO9XRpejRAj9CKD43XdkMEYIHW5lAzIz3cPHTdohhGxwioI7CGwG
 ypBxhPL+TPC2o99rq9j69H1ZR5rzhjFRkvp23fr8GXViTeEzLMYxekA654i8LMkmmAi6QDV21FR
 Rr/4LJ2ETcmRxk+ThfQXxi8WLAfaziaiKV+JE7IWfYEzwsUMWaHTYu89nhr1F2lRBq1cMZ1pW5x
 O7ZQJtwMIHpGC+qPkc+OA97ibEnpo8g8KGh1IVqvu1JS0xw3aZhJwXkjK6vuuy6gLTjD2fcn+we
 6CENP6gMRZ1N72NPXxTWF2vqzytzArz4392QDTXKrm/gsmEwgxeP4iHueioKVfpcbk/Q==
X-Received: by 2002:a05:600c:4e4d:b0:485:3193:6ddb with SMTP id
 5b1f17b1804b1-488d6808507mr108412055e9.3.1775946510061; 
 Sat, 11 Apr 2026 15:28:30 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d68603f4sm54178195e9.27.2026.04.11.15.28.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 11 Apr 2026 15:28:29 -0700 (PDT)
Message-ID: <827423a1-da0a-4734-a8fd-57124262d1bd@linaro.org>
Date: Sun, 12 Apr 2026 00:28:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 47/67] ui/vnc: vnc_display_init() and
 vnc_display_open() return bool
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
 <20260410-qemu-vnc-v2-47-231416f76dc3@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260410-qemu-vnc-v2-47-231416f76dc3@redhat.com>
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

On 10/4/26 21:19, Marc-André Lureau wrote:
> Use the QEMU-style error pattern returning "true" on success.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   include/ui/console.h |  4 ++--
>   ui/vnc.c             | 20 ++++++++++----------
>   2 files changed, 12 insertions(+), 12 deletions(-)


> @@ -4354,12 +4356,10 @@ int vnc_init_func(void *opaque, QemuOpts *opts, Error **errp)

vnc_init_func() could also return a boolean.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>           id = vnc_auto_assign_id(opts);
>       }
>   
> -    vnc_display_init(id, errp);
> -    if (*errp) {
> +    if (!vnc_display_init(id, errp)) {
>           return -1;
>       }
> -    vnc_display_open(id, errp);
> -    if (*errp) {
> +    if (!vnc_display_open(id, errp)) {
>           return -1;
>       }
>       return 0;
> 


