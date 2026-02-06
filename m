Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF635ECD9BF
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 03:11:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voCFm-0007Vw-Tb; Thu, 05 Feb 2026 22:11:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1voCFk-0007VR-LB
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 22:11:28 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1voCFi-0004zQ-Tz
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 22:11:28 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2a871daa98fso1551395ad.1
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 19:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770347485; x=1770952285; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0EYA2MUwZXakEzmDE//Jy6qICS6u25g/CcYHQ5uhtRo=;
 b=KYx+Wc6k38DqGKciOu+P4eqieYwSmqf3PTQPk4g8B2ymVsfAHQnMST6hnW32w8DuZ5
 HwywYIPghmBP1Wsk+pwffKAv8upRe4H4MviRjn+2AL6gMdE4ALnnBjpa7tT4BeXWVy6A
 1kKE+u786MwyMroJeYyszKNPOJAhbk8wUS3CQk7zCjoiIVQYzxqQKfb9h8clq8FQK6i/
 U2S02IJHadgeIcXA51DRHnGdGoguPeK9yomtHQy5pATQewhtwk12DTjs+F6ZrO5hcU2Q
 1hm0Tlu/3zoLFWAEUYKgzOGxole5BCts0BDWSPfWoburCskCzbAsD/bniTOjoOW3oZXQ
 LI9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770347485; x=1770952285;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0EYA2MUwZXakEzmDE//Jy6qICS6u25g/CcYHQ5uhtRo=;
 b=OXW+//UNtV4s6sF7ovvA0MB495APYmeFyYE9UoL685D8d4cPj5TaFvLTwsInKeh2gy
 WXKj2IZ3pVtNmq26wFz1I1j9XxyVZVbTCnEk/h8MFNkEl7Swg27MKd0YdMAFoJYzLKFo
 WMArkTECr4VB3FV+cYQELNU1UnxAoc+ROAF24pC24sgC1YmQPfocQzOEuoxdd8zDSD71
 mJomi+tBv3DQzcwQwzc16CQbhANIdsBKt/z7LxmpM5AsTqKm4R88H95gwk/aiQDfkj0B
 sgOJ3FnCoOgKOqj44Ylll9B0TElcxDiTq8StKZtwrEseIYfTf0IYvY01+by59gCusxVS
 bzRw==
X-Gm-Message-State: AOJu0Yx74Yqj7lxEQPHC/u/vy3P1xkfyQWu1s3n0V6Vb28+TwOWpBMJf
 V8OhYOnzONMw9kXTgbfadPFbeKv4Cm3EzHTJqTceF/G4SxXfxNP2fekiKOxqwlui+eimwHvAwJ9
 v/6GVRHdSOQ==
X-Gm-Gg: AZuq6aKRQew3BOjjmD+qARsITkFfHK2BCZCwhd0KRll3lDkXjtzT5WccUgWaITzJeuF
 vz+cOU3v3JRjax92/xjPwkS4s0qf90v/8qkFeLD39Du5IDg239zMUzUX2IsUgLP+iYCMnY1ny1r
 KCdq7LRMG4Q1demk+kUkRk9qs9mfqliaqglzIUuJVXb1tI7rOgn8rB5mfwapGqrPf/zaek6//kH
 cQ3OCDl0Jfq8QPtJixeKuQlcvIuhSDcV4CV3p/WnuM/+oJQWrCGbG2wNtemuI1MzHBxinPEsrSs
 BKD/Lzlsj+r6Nujs+GnJgOGqsYpq+5EFv2dJqpsn2KDwOrqchu1LD6IMllxNug7Cvd0O4j4V+Ft
 1XUHAhnxJXQb2wHD36F1i5QhDCSuJNeqldPsHND8gpIp8Wk4FOo4QQwI3+he/yS62S4jkohVAwq
 +Gg97gav+jvh0RsbiDI39XEHlbfMfwyAO5b9x01m/O9AqKcmdB1rGFfQq21js3LrV0u8SnK5TWQ
 yV4OC2uRIJ7yTLZG3rMqFmEWmKhRBcBb3skfWjOxCo=
X-Received: by 2002:a17:903:298e:b0:2a8:ed0e:3fba with SMTP id
 d9443c01a7336-2a951926e07mr11791435ad.32.1770347485171; 
 Thu, 05 Feb 2026 19:11:25 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:1ced:e57b:71bf:567a?
 (bg30dhzpdc341w7g29yn.ip6.superloop.au.
 [2401:d002:dc0f:2100:1ced:e57b:71bf:567a])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c6dcb520bddsm791972a12.8.2026.02.05.19.11.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Feb 2026 19:11:24 -0800 (PST)
Message-ID: <4050ab09-5dde-4ed0-9283-ee306d55e639@linaro.org>
Date: Fri, 6 Feb 2026 13:11:20 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/24] bsd-user: Add do_bsd_semget implementation
To: qemu-devel@nongnu.org
References: <20260205-bsd-user-claude-v1-0-8d8ff0035372@bsdimp.com>
 <20260205-bsd-user-claude-v1-16-8d8ff0035372@bsdimp.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260205-bsd-user-claude-v1-16-8d8ff0035372@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 2/6/26 03:26, Warner Losh wrote:
> From: Stacey Son <sson@FreeBSD.org>
> 
> Add implementation of semget(2) syscall to get System V semaphore set
> identifier. Converts target IPC flags to host format.
> 
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
>   bsd-user/bsd-misc.h | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/bsd-user/bsd-misc.h b/bsd-user/bsd-misc.h
> index b722c63437..18520548fb 100644
> --- a/bsd-user/bsd-misc.h
> +++ b/bsd-user/bsd-misc.h
> @@ -77,6 +77,18 @@ out:
>       return ret;
>   }
>   
> +/*
> + * System V Semaphores
> + */
> +
> +/* semget(2) */
> +static inline abi_long do_bsd_semget(abi_long key, int nsems,
> +        int target_flags)
> +{
> +    return get_errno(semget(key, nsems,
> +                target_to_host_bitmask(target_flags, ipc_flags_tbl)));
> +}
> +
>   /* getdtablesize(2) */
>   static inline abi_long do_bsd_getdtablesize(void)
>   {
> 

Doesn't FreeBSD have consistent ipc flags across targets?
I'm surprised the conversion is necessary.

Anyway,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

