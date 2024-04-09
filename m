Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53A6FCD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 07:32:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru5wt-0006GZ-Ra; Tue, 09 Apr 2024 03:31:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ru5wr-0006Eg-SG
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 03:31:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ru5wq-0001RC-3y
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 03:31:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712647874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=IEaDj5X43MVzKybRvb4u4tVIj1/KhYa/ZJo5OIjsHag=;
 b=ikv41SXdj7lfznhx11OOYjbq3li/+tUeTYQ14x2SYwIv/vvZqDd4zZocd66mztET+4Sx3M
 /h8vPTe7RJLY8+I3F2esq3jhi+uvmGb6XXgm4T7vtEbi/DbgtWs1B4o1jI+VD+J4HNAB+h
 L6gU7pjHys16OsBygB+CC4fnL1nQVpA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-PmK8J1BYOd2PIjj_0OHUyw-1; Tue, 09 Apr 2024 03:31:13 -0400
X-MC-Unique: PmK8J1BYOd2PIjj_0OHUyw-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-343da0a889dso3361634f8f.0
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 00:31:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712647872; x=1713252672;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IEaDj5X43MVzKybRvb4u4tVIj1/KhYa/ZJo5OIjsHag=;
 b=HVJ6rjwW57zz9HZfsoiE8dNfueAaWP+A7I9NW1xHJza0GR61Kz88rZpRirmYvlRAsS
 fU865Hw89dXp/8ua74HMQWD/SdMmQWAlWTjn5+26/8GGpdpmU6BYGRwWUu8jbI+e1Oze
 JRjezJ6jFvFTJnpt8z1wjpME8q/EyTBAH88g1ppNsO9vHAw+6L5/5myTvSxb8FgEL6T/
 s7LyHtCTKuJ9vl7cAmPWYmLWy8ie1qW0yVo8kMKbxsB/GpN0tRK/ILeaXhyG4abZU3g9
 g6QPg6+CCyPZPEqUkdJ/KI0jkhKarTtvAc4Rk2nQ1rTeKtBmcukEPnvrqSPnPH51PpCr
 Ugdg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUySUZI7SCPs0gOZ8Mtiu2Ef612DeQRI4/4MVfMhwVg+BWSgEu/GbemFDlXYtKbCL/UfvXEEq/b9QLxqIJFdNHY9T+sodk=
X-Gm-Message-State: AOJu0YxUE2qa6SECLttxi59pRt6sJWv/x6oEOsDsTm7a7wD2UOW/407Q
 QncEreGhqip5QGRsGwNzN/yoGBt1ROgeU0D/1uVMeUZiTNiKQp1oER9G9lMDaZMmQ3ScyQYaEyh
 Z6X9mom4YEgbnEVrCVJYL1u6ZFDLkOtnyPg70VPFGq0Sq9Aj/p0Pp
X-Received: by 2002:adf:e3c9:0:b0:343:78da:9817 with SMTP id
 k9-20020adfe3c9000000b0034378da9817mr8675158wrm.68.1712647871764; 
 Tue, 09 Apr 2024 00:31:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlYUAspIDkDwYpVAukDPM3sePtlDcueGaVPvwrONiaof1PgIjx2pzbT+meFUHqwtzcM2/o9g==
X-Received: by 2002:adf:e3c9:0:b0:343:78da:9817 with SMTP id
 k9-20020adfe3c9000000b0034378da9817mr8675140wrm.68.1712647871225; 
 Tue, 09 Apr 2024 00:31:11 -0700 (PDT)
Received: from [192.168.10.4] ([151.95.152.232])
 by smtp.googlemail.com with ESMTPSA id
 b17-20020a5d40d1000000b00343cad2a4d3sm10710892wrq.18.2024.04.09.00.31.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Apr 2024 00:31:10 -0700 (PDT)
Message-ID: <0a86e001-30a7-433d-9bac-053c182ee949@redhat.com>
Date: Tue, 9 Apr 2024 09:31:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 19/28] linux-user/i386: Fix -mregparm=3 for signal
 delivery
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240409050302.1523277-1-richard.henderson@linaro.org>
 <20240409050302.1523277-20-richard.henderson@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20240409050302.1523277-20-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.494,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 4/9/24 07:02, Richard Henderson wrote:
> Since v2.6.19, the kernel has supported -mregparm=3.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/i386/signal.c | 20 +++++++++-----------
>   1 file changed, 9 insertions(+), 11 deletions(-)
> 
> diff --git a/linux-user/i386/signal.c b/linux-user/i386/signal.c
> index 559b63c25b..f8cc0cff07 100644
> --- a/linux-user/i386/signal.c
> +++ b/linux-user/i386/signal.c
> @@ -427,6 +427,11 @@ void setup_frame(int sig, struct target_sigaction *ka,
>       env->regs[R_ESP] = frame_addr;
>       env->eip = ka->_sa_handler;
>   
> +    /* Make -mregparm=3 work */
> +    env->regs[R_EAX] = sig;
> +    env->regs[R_EDX] = 0;
> +    env->regs[R_ECX] = 0;

Perhaps also move here the

     __put_user(sig, &frame->sig);

from above, for consistency with setup_rt_frame?

Paolo

>       cpu_x86_load_seg(env, R_DS, __USER_DS);
>       cpu_x86_load_seg(env, R_ES, __USER_DS);
>       cpu_x86_load_seg(env, R_SS, __USER_DS);
> @@ -448,9 +453,6 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
>                       target_sigset_t *set, CPUX86State *env)
>   {
>       abi_ulong frame_addr;
> -#ifndef TARGET_X86_64
> -    abi_ulong addr;
> -#endif
>       struct rt_sigframe *frame;
>       int i;
>   
> @@ -460,14 +462,6 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
>       if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 0))
>           goto give_sigsegv;
>   
> -    /* These fields are only in rt_sigframe on 32 bit */
> -#ifndef TARGET_X86_64
> -    __put_user(sig, &frame->sig);
> -    addr = frame_addr + offsetof(struct rt_sigframe, info);
> -    __put_user(addr, &frame->pinfo);
> -    addr = frame_addr + offsetof(struct rt_sigframe, uc);
> -    __put_user(addr, &frame->puc);
> -#endif
>       if (ka->sa_flags & TARGET_SA_SIGINFO) {
>           frame->info = *info;
>       }
> @@ -507,9 +501,13 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
>       env->eip = ka->_sa_handler;
>   
>   #ifndef TARGET_X86_64
> +    /* Store arguments for both -mregparm=3 and standard. */
>       env->regs[R_EAX] = sig;
> +    __put_user(sig, &frame->sig);
>       env->regs[R_EDX] = frame_addr + offsetof(struct rt_sigframe, info);
> +    __put_user(env->regs[R_EDX], &frame->pinfo);
>       env->regs[R_ECX] = frame_addr + offsetof(struct rt_sigframe, uc);
> +    __put_user(env->regs[R_ECX], &frame->puc);
>   #else
>       env->regs[R_EAX] = 0;
>       env->regs[R_EDI] = sig;


