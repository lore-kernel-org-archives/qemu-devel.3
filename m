Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B431C47DDB
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jan 2024 01:08:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTte2-0002Z0-Ci; Sat, 27 Jan 2024 20:07:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTte0-0002Yo-TR
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 20:07:33 -0500
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTtdz-0002sO-Aj
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 20:07:32 -0500
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-6e11faeb125so128584a34.2
 for <qemu-devel@nongnu.org>; Sat, 27 Jan 2024 17:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706404049; x=1707008849; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=54NGIk1YXdQRGXocshB5oi4l0/n0jW7wA/bbU57hnu0=;
 b=LrQqfnbQ4EqUuvh0eqlDouzMqfpHNtZ+xhyI3pk7sWqzeeNGBF4x7jqG1d173OYq+z
 1By1kETpUnlneNEHNGvK999NOL0FjCuoJsza+TG/tl2rAKcQ0eC0NliIyQ9BIAgtj1Vl
 D/CmEzSRR3XlQREupQW4n4vjZghSblEJa4kmctrozb8KsTlPo6f8+HubzY7rkFM06/yp
 NYXZcoDd1yNL3mKpNqJbnpM/00WxooJ+Uu61UJTtypjCgh4Jn5apqJpYYrPHzFoR4X4A
 9DC1gH22S0QkA6TdqPIY7DxwI/HU1ilF5X8OkF8RaHLkdB94z+MrJGGMvS5llEglsPjC
 H8Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706404049; x=1707008849;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=54NGIk1YXdQRGXocshB5oi4l0/n0jW7wA/bbU57hnu0=;
 b=tZdGhmGkLZHTtU0SeTT17xJDOFbEYXy7V/5Glr/AgP6cpEpDb/rutCc+JAHMWYOH3m
 +XBeipAAb9hYzM9g8cChLEGmy1LW5iwX9iB1JQHkpWK0RUpG+t39xpLhexiDjao74qvf
 5csd0HkoEK5crgc3CLP3WVqzAmBoKGMOTJF776VI3Vp23qweRg0al0X/rZhKlCYC/34k
 rqEvPtxYm19/uXvfQq7FDgGFZD0fPPdRkUfUy+uKTjstd6uQ7pdJDseiQvIEN1/hN/f+
 RGPF28X6Ag62XnBKgDYZr9YV41SryYcHnWycT9pqZwqRfI0sH7tMz3HrCw3R5kzoEhde
 90Dw==
X-Gm-Message-State: AOJu0YyFbe3fsFs6M27XaA/csENjFAwHGWdHSLMGr1nWGTy1Y8j+1Mk2
 gwqpz7O1oa/hLuEunVtOH8Q5kn7dcncMvel4yN0C6DD0cjr50pIZzgtCKFHzkhc=
X-Google-Smtp-Source: AGHT+IHd53TPRANTvq8+LJB5Gl9sB/GpEcRJoyTIlWeUxzdmj0q+zrpxtMlzwKvWa1rIEJrelkAMCg==
X-Received: by 2002:a05:6358:7f11:b0:175:f65c:45c8 with SMTP id
 p17-20020a0563587f1100b00175f65c45c8mr1285979rwn.61.1706404049355; 
 Sat, 27 Jan 2024 17:07:29 -0800 (PST)
Received: from ?IPV6:2001:44b8:2176:c800:5c13:51aa:e666:7387?
 (2001-44b8-2176-c800-5c13-51aa-e666-7387.static.ipv6.internode.on.net.
 [2001:44b8:2176:c800:5c13:51aa:e666:7387])
 by smtp.gmail.com with ESMTPSA id
 oh11-20020a17090b3a4b00b0029051dad730sm3497631pjb.26.2024.01.27.17.07.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 27 Jan 2024 17:07:28 -0800 (PST)
Message-ID: <53062790-a4b1-494d-b60a-8eae7c8ebc34@linaro.org>
Date: Sun, 28 Jan 2024 11:07:22 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] accel/tcg/cpu-exec: Use RCU_READ macro
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Fam Zheng <fam@euphon.net>,
 Greg Kurz <groug@kaod.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20240124074201.8239-1-philmd@linaro.org>
 <20240124074201.8239-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240124074201.8239-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/24/24 17:41, Philippe Mathieu-Daudé wrote:
> Replace the manual rcu_read_(un)lock calls by the
> WITH_RCU_READ_LOCK_GUARD macro (See commit ef46ae67ba
> "docs/style: call out the use of GUARD macros").
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/tcg/cpu-exec.c | 24 ++++++++++++------------
>   1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index 67eda9865e..6b3f66930e 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -1070,21 +1070,21 @@ int cpu_exec(CPUState *cpu)
>           return EXCP_HALTED;
>       }
>   
> -    rcu_read_lock();
> -    cpu_exec_enter(cpu);
> +    WITH_RCU_READ_LOCK_GUARD() {
> +        cpu_exec_enter(cpu);
>   
> -    /*
> -     * Calculate difference between guest clock and host clock.
> -     * This delay includes the delay of the last cycle, so
> -     * what we have to do is sleep until it is 0. As for the
> -     * advance/delay we gain here, we try to fix it next time.
> -     */
> -    init_delay_params(&sc, cpu);
> +        /*
> +         * Calculate difference between guest clock and host clock.
> +         * This delay includes the delay of the last cycle, so
> +         * what we have to do is sleep until it is 0. As for the
> +         * advance/delay we gain here, we try to fix it next time.
> +         */
> +        init_delay_params(&sc, cpu);
>   
> -    ret = cpu_exec_setjmp(cpu, &sc);
> +        ret = cpu_exec_setjmp(cpu, &sc);
>   
> -    cpu_exec_exit(cpu);
> -    rcu_read_unlock();
> +        cpu_exec_exit(cpu);
> +    };
>   
>       return ret;
>   }

I've tweaked this to use RCU_READ_LOCK_GUARD instead -- there's little point
in excluding the return from the block, and thus avoid the re-indent -- and queued this 
one patch to tcg-next.


r~


