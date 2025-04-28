Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16D46C369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 19:34:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9UEU-0006uw-Sg; Mon, 28 Apr 2025 15:33:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9UEI-0006tv-L0
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 15:33:28 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9UEE-0000bM-I4
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 15:33:24 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-af908bb32fdso4581469a12.1
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 12:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745868799; x=1746473599; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/okaK0HuJy3EMmVJ4+WEL2MyY5OMZbtGaBLcYriTlqA=;
 b=OtOzDS2aocnshzncE44FtYcUSCjdLd7WQO6rL6mm9IpvSPMpCqmHznJznC8nqu4gA1
 nNziA41nniacSjDMCyrAaQeDjTkEb1U+0yA9UdXU8TVqu00gb33m1iL6gdLVCrhcQMa3
 TyqWwNtFJ5wzlg9J5eGL5MqCoCh+JKadC0aKGmaHH0HHhrp5EgruPiWTP36Z8VcNTm2D
 fihZLyy6A59HmNUTGqD/z4ketq4g8qeut0WwTpIGE6V1O6ZvOBT62UcMjnm7bIavLlBv
 I0JlfYYyZ7njMe/YdU8UAq2H2vc4dYlDE89AOrIKIWaZYxtJB0+wEMC21HYTNrtGwCv9
 4Ntg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745868799; x=1746473599;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/okaK0HuJy3EMmVJ4+WEL2MyY5OMZbtGaBLcYriTlqA=;
 b=jsFSZxeSwAsz17GiPzY6KO2L8z63MQWa19DhhI1rO81EOmQmDnUFfIcuPBJrwxONE5
 WHkkUl2kGkG6kZtfUim/dtKM2WWR3ooXy5qX8OrjfgVcIoGFiYK3to5JdEWg8lHcF86p
 NwcyewjRuotydGyFlHO9/RxIltUMde1s6GapVkjODbyqydTcxcUNBZwpa9g/V/B98QcO
 Tlea3feRrXsSVANEOhJnSRzR1Sp+/2SKD+aO9rDngBHPSKgwhp0Opk4plHvjGvr3TB08
 V1SPHJHXFQGW2zOmgQOB2jAxOnes22XldRXoLhXLYzIeV6vkjjpVox4q8ZLF2akWinAn
 dDGw==
X-Gm-Message-State: AOJu0YwavPPyDIOJTYp6GlfQTuq/KCyVMIi1mu8aDUpvbU7L5fhjToxf
 62I0D8h6Ct65qGSiTV5QUjbzc1aSms50KnvfVqa+WpPjsQNJ1detQ1JMast2TTnfoHB+JhDD2bl
 e
X-Gm-Gg: ASbGncuvUnifP/upKnIA3FM2JzAEQwXb1NzuWXrsqp8WHv3Jhs65ljZl9Kt/xSKwhSM
 +hOPyl9lAZRuE1lm07Lwud5TFFXzc1HKzlfe73MCM7piQ+Xkua0Wxbbd3MGLW3vTeq24R149sjj
 71ypun6AKMJ51QI5uSydnbsCrtVwgN5WmWe3zmmtyyhlkqvYb/GAyQI52d7fHamiFVSHVrcq4LG
 fnUXrAoN9AT9tGX9GoVxdTCCr1/s7OHrcDen0nIu9RyF04ySXpKrwHDpK5gVejeYUyNIbCeOd+g
 iYIiLIx1tUPcNBIf1zUSkw24E3hWxE6s57RmrUYqB4VpnqjH7eGCtQ==
X-Google-Smtp-Source: AGHT+IE/yiyPuvuFtABx0v1Yp+ck+aX/MOMzm6Bm2yKpCE6VRWOtRv1OMOePZo7ifNHdgM0wzdhpjQ==
X-Received: by 2002:a05:6a20:c991:b0:1f3:20be:c18a with SMTP id
 adf61e73a8af0-2095024725emr548461637.10.1745868798893; 
 Mon, 28 Apr 2025 12:33:18 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6a655sm8652766b3a.101.2025.04.28.12.33.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Apr 2025 12:33:18 -0700 (PDT)
Message-ID: <9c50884a-90fd-479f-b666-e489d2859ff9@linaro.org>
Date: Mon, 28 Apr 2025 12:33:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] system/main: comment lock rationale
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, Phil Dennis-Jordan <phil@philjordan.eu>,
 Paolo Bonzini <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20250416185218.1654157-1-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250416185218.1654157-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52c.google.com
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

On 4/16/25 11:52 AM, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   system/main.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/system/main.c b/system/main.c
> index 1c022067349..b8f7157cc34 100644
> --- a/system/main.c
> +++ b/system/main.c
> @@ -69,8 +69,21 @@ int (*qemu_main)(void) = os_darwin_cfrunloop_main;
>   int main(int argc, char **argv)
>   {
>       qemu_init(argc, argv);
> +
> +    /*
> +     * qemu_init acquires the BQL and replay mutex lock. BQL is acquired when
> +     * initializing cpus, to block associated threads until initialization is
> +     * complete. Replay_mutex lock is acquired on initialization, because it
> +     * must be held when configuring icount_mode.
> +     *
> +     * On MacOS, qemu main event loop runs in a background thread, as main
> +     * thread must be reserved for UI. Thus, we need to transfer lock ownership,
> +     * and the simplest way to do that is to release them, and reacquire them
> +     * from qemu_default_main.
> +     */
>       bql_unlock();
>       replay_mutex_unlock();
> +
>       if (qemu_main) {
>           QemuThread main_loop_thread;
>           qemu_thread_create(&main_loop_thread, "qemu_main",

Gentle ping on this patch.
@Nicholas: as you asked for this patch, would that be possible for you 
to review it?

Regards,
Pierrick

