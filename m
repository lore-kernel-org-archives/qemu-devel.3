Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58B26C9830C
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 01:21:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhdww-0004UN-QF; Sun, 18 Jan 2026 20:20:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhdwv-0004SM-8b
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 20:20:57 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhdwt-0003iQ-NM
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 20:20:56 -0500
Received: by mail-pf1-x444.google.com with SMTP id
 d2e1a72fcca58-81ed3e6b8e3so1736792b3a.2
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 17:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768785654; x=1769390454; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BBrzs2RRFJeF55PljLLAsbzFfwlKmB5YZ8RH7zVTXhY=;
 b=YEiS5Z+A+K3LWhydmmifDf4Q9nG6IMXC+q2AOeP9zXP9bokZmeJ+8uPfD4aZv82Kbo
 wMJrEmKD4Oe1NNsogxpRR3erbqWTwClXpICS1xuRLbwU1Aj3mXH0rWuhBgsnJoo6L9pA
 Jf8LqhEZgzwJBetKzahcYnxgI5mFKZIpONqO6l0+CJnHU4tD1zb1ZaqyNp45+H82F2AH
 k37NjcvX3/xfQQLw3TZS25BFyc1M+HHPKAUI8NbDCp8B5MlVED4kSrTi+rMr64LMXxrC
 Dfy/xmB93c9bU4GAATt2qmrF6UALOykmh/PpFx/uqf6VO+PwXz4hz1zGKVuRV/jywlHO
 zlCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768785654; x=1769390454;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BBrzs2RRFJeF55PljLLAsbzFfwlKmB5YZ8RH7zVTXhY=;
 b=d5zD6H15XEhgNkuEOvzNQyWmaP7O0lE2jQ3a7NRfmXNT0sq2ug/FptNX/lWBI+boof
 TQ64o7waZ6cAxKpftZf6elSXpr8eK92JXp181iYHWaTZB54y7FTP+GNVwMYhMdVl8mwE
 2r+/dvL0MVlw9PKQKF0KQ1T7Qvgxo8PSHC4CZ9hkG5OcCYoEBdCp8OtLqMwKpgEB+Oit
 HCERAu2VbM4t8UidbUc9fGxO0LPtWMUCH4DlwDlisNbkkL5QcClFYnegUwvJLelPRoLu
 NORIzVj4+LZwXZNKFQTJDAo71x0tv29+9sOoqUQVecB9Lv+MMR9db61bMIznE7vIpV+Z
 wnNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqcRFZvjZ9TjXrSAbnLdtGNvbeQImoR+sI3PsnQed0ykvYIssrzNouxhkguqV9/UfwHCulLJ27FnVq@nongnu.org
X-Gm-Message-State: AOJu0Yx/tNXtY+qGJmeLNl2ku84xiFYkJ1SM+GFG3UxX1tV7F4QbvlBp
 Rx3pGtMwTC6fnevBzL89lwDyFxh4P0kyR6Vuzh5abDm4va5SKA5UZ8T9QERjJUP53y4=
X-Gm-Gg: AY/fxX6+xsOb/ixPxwGSUyllo7DWmLB3FukJdXAUH29b8VISzj1uyQ7O8lHs8XaaVGE
 fDzSQ6y4ROOp/nn3Ft/d1IMHAwXxUnpwdeXzoSkggmF34bX9C58mwwe49GrBltjk9cA3hRSwrf9
 wmUYYN48xWgr3VBx/1L00Hrf3o/lyRlVuOjMe60q0t8QExItbyJEejkFhudgLzG/q3YlDJfDXAv
 suxnWmcxpoNSwoQe8Y1mUhUcEeI1vfJBHJ/+AidmktX1mtWbUspxwL+8xnfjsfRH1p48H8GXfHO
 WqsVoEqAeMZjlI1YucSeXo5E6apxtpfIzYo+NXlxaNX1cy5hr2aggIMD5AV5W0themfIW7VwxSo
 AEzarS+u/gd7CgeKHu/jq89kNtq7mNt7Emb5glj/Gnk5t8YIkF5gkZ4IfRqlbIRsb1dRC0FXkeT
 3cs90TaUQzd1h7wzuF0GuTZ8ricmQpjw==
X-Received: by 2002:a05:6a00:1882:b0:81f:5198:ba2f with SMTP id
 d2e1a72fcca58-81fa17bb232mr7657440b3a.30.1768785654000; 
 Sun, 18 Jan 2026 17:20:54 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81fa1291135sm7418514b3a.47.2026.01.18.17.20.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 18 Jan 2026 17:20:53 -0800 (PST)
Message-ID: <3adf7c0b-bf58-4195-bda9-8aa67ba20a73@linaro.org>
Date: Mon, 19 Jan 2026 12:20:49 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH trivial 1/7] linux-user/syscall.c: assume splice is always
 present
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
References: <20260113130008.910240-1-mjt@tls.msk.ru>
 <20260113130008.910240-2-mjt@tls.msk.ru>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260113130008.910240-2-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 1/13/26 23:59, Michael Tokarev wrote:
> splice() &Co are defined since linux 2.6.17.
> Assume it is always present.
> 
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>   linux-user/syscall.c | 15 +++------------
>   1 file changed, 3 insertions(+), 12 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Separately, I wonder if these require safe_* versions to properly handle restart from 
signal delivery during a blocking operation.


r~

> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 67ad681098..9cc9ed2fbc 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -13450,15 +13450,9 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
>           return ret;
>   #endif
>   
> -#ifdef CONFIG_SPLICE
> -#ifdef TARGET_NR_tee
>       case TARGET_NR_tee:
> -        {
> -            ret = get_errno(tee(arg1,arg2,arg3,arg4));
> -        }
> +        ret = get_errno(tee(arg1, arg2, arg3, arg4));
>           return ret;
> -#endif
> -#ifdef TARGET_NR_splice
>       case TARGET_NR_splice:
>           {
>               loff_t loff_in, loff_out;
> @@ -13488,9 +13482,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
>               }
>           }
>           return ret;
> -#endif
> -#ifdef TARGET_NR_vmsplice
> -	case TARGET_NR_vmsplice:
> +    case TARGET_NR_vmsplice:
>           {
>               struct iovec *vec = lock_iovec(VERIFY_READ, arg2, arg3, 1);
>               if (vec != NULL) {
> @@ -13501,8 +13493,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
>               }
>           }
>           return ret;
> -#endif
> -#endif /* CONFIG_SPLICE */
> +
>   #ifdef CONFIG_EVENTFD
>   #if defined(TARGET_NR_eventfd)
>       case TARGET_NR_eventfd:


