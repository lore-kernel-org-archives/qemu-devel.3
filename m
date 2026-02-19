Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68703E9A052
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 17:03:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt7PU-0008By-Sl; Thu, 19 Feb 2026 12:01:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vt7O3-0007Wm-B5
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 12:00:24 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vt7O0-0005h9-1g
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 12:00:22 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-8230f8f27cfso606735b3a.0
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 09:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771520417; x=1772125217; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cRkr8n2EcL/przfhNkTTEW/9fgQb6mrOD1Vqtgwcq80=;
 b=p493ukZMgg4AV5M9wGWTbWoVphzs6bYOeCAt/3sskM3+KsvbCmwwNnc7lSsbm0M+4l
 HSC4QmMkVOgFJTodCgEwH4aDVx/3xPSviGiolhwPtSh4ofhpEZYI+WQfNl+YvhfKKCrx
 8v+I0KsiqNXFVuiHnYL9B2GJDjyM6o0eGVgATVmLGxaRyO7V/fFvgfsgGvLLX9vkROgK
 gy7ix81VqTQUlYcB7UqohUKzazi9mEKsNs8Y5T9BMdPf+D57VLC37yr2pgB1ikHEt8qV
 pTi83bA/gcx5EQ0X8DQsfb6JzPCi9xpL9E9wFriZekjp7C6AD0vph81owUnSaxHeKUn2
 uxaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771520417; x=1772125217;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cRkr8n2EcL/przfhNkTTEW/9fgQb6mrOD1Vqtgwcq80=;
 b=PCZ9v2Pe4thg8/ZxDdJt5KeAwbQcVsb2Z/vOePkG5VwZ6ChZrWLIQfMgQXGIQhr6MS
 ojbMStZNg/51xSxK8YTs1AcyXq8CFzwIQr/XQNTbfp+yOPGukBJT9sJGu51QtY2/kJUN
 mIGFdtenRK+gmPA+iRtgkEf9shRN0v9aUxXT48XmM+uO3/9emQiW6y5mwW+kJApWA9Ku
 Uc6FDjva1c2NvqrUiWOwx3f/0WXQmtLhy8u8+rkRDS6iF+cbYFOm6OYg9Lo2ZU04KbT3
 k6/dzH8SiWxbGX5041dRLOwVNxkMN/2Uir01UEe9cK1gPy7oWwwrs5bLlFo12vUFpiny
 k/Gw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqHiVxO1GQ9WQ3ZUfilfl7t5V8aHA1V/amh82dTk2hG0G3Mbln0+pEdrRMwSScLo1Ewvd9/unoOLPJ@nongnu.org
X-Gm-Message-State: AOJu0Ywfv3RKnafp/KOxLFwAsIOGuUfKZtX0a0h4ryhOo3AoGbClr5Uz
 bZ625oE854eXaz6/xxZbiAkFZkf9Y5aSq7fmlqD2f4scwd47BL6uQxF99uq8v+D7xXk=
X-Gm-Gg: AZuq6aKiKJBOV4/G9hN/LWE175sopnmAJ+jNMQjbGu40zHJVQVS1A4GFONT8x0XfZbW
 VAh0BV09Rzjh9yONkP+pmeZjxqcLdS9KxgYVpPWWfeNojA4Q+TGHYFbGb6HCiuHO07B46boC4KI
 3ugOJ6TusWNG221b9TaGN74XhQvovc7HJLsTpRc/C8viLz+W1ZW9Ol+//II9qFp04u49YS5rzBA
 9dZhQsP2pp4YyhCqHoKxj0VjtaVutPPzXFSlxtavcgO9g7LfvNJ0mIo1vKOX8/1rDzAVRa4/6tY
 lVHywGIg7b7iSo5bPF4PsAvqEqcrjG1BIvwwuQPjM+EpSNWwKmrQLS/o8K1j+T+OayVf5MKUu46
 H0ZBo6nj6W71AKkYn8DdTSBsucWFKepxBmwKKFpnfTj6O5TnJHI5c3Zt2cjtw3qsXQB40wF40Pn
 6nmVndMHf2QEaAm4zKaOmY6b7puCIZm0ngjr7AK/EGZrQ+RXqXeUlcrTTT1YJFuZoOODAV
X-Received: by 2002:a05:6a00:849:b0:81f:4dc7:d31 with SMTP id
 d2e1a72fcca58-824c95a6236mr20012589b3a.33.1771520416479; 
 Thu, 19 Feb 2026 09:00:16 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-824c6a2e40bsm26452396b3a.11.2026.02.19.09.00.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Feb 2026 09:00:16 -0800 (PST)
Message-ID: <b4ace858-6769-4a02-8114-1b0716ae86c2@linaro.org>
Date: Thu, 19 Feb 2026 09:00:15 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 18/24] bsd-user: Add do_bsd___semctl implementation
Content-Language: en-US
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Stacey Son <sson@FreeBSD.org>
References: <20260218-bsd-user-claude-v3-0-0137b37b221e@bsdimp.com>
 <20260218-bsd-user-claude-v3-18-0137b37b221e@bsdimp.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260218-bsd-user-claude-v3-18-0137b37b221e@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42a.google.com
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

On 2/18/26 9:22 PM, Warner Losh wrote:
> From: Stacey Son <sson@FreeBSD.org>
> 
> Add implementation of __semctl(2) syscall for System V semaphore control
> operations. Handles command translation, endianness conversion for GETVAL/
> SETVAL, and array/structure conversions for GETALL/SETALL/IPC_STAT/IPC_SET.
> 
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
>   bsd-user/bsd-misc.h | 116 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 116 insertions(+)
> 
> diff --git a/bsd-user/bsd-misc.h b/bsd-user/bsd-misc.h
> index e1e552b58f..cb7fe1d6d0 100644
> --- a/bsd-user/bsd-misc.h
> +++ b/bsd-user/bsd-misc.h
> @@ -99,6 +99,122 @@ static inline abi_long do_bsd_semop(int semid, abi_long ptr, unsigned nsops)
>       return semop(semid, sops, nsops);
>   }
>   
> +/* __semctl(2) */
> +static inline abi_long do_bsd___semctl(int semid, int semnum, int target_cmd,
> +                                       abi_ptr un_ptr)
> +{
> +    void *target_un;
> +    union semun arg;
> +    struct semid_ds dsarg;
> +    unsigned short *array = NULL;
> +    int host_cmd;
> +    abi_long ret = 0;
> +    abi_long err;
> +    abi_ulong target_array, target_buffer;
> +
> +    switch (target_cmd) {
> +    case TARGET_GETVAL:
> +        host_cmd = GETVAL;
> +        break;
> +
> +    case TARGET_SETVAL:
> +        host_cmd = SETVAL;
> +        break;
> +
> +    case TARGET_GETALL:
> +        host_cmd = GETALL;
> +        break;
> +
> +    case TARGET_SETALL:
> +        host_cmd = SETALL;
> +        break;
> +
> +    case TARGET_IPC_STAT:
> +        host_cmd = IPC_STAT;
> +        break;
> +
> +    case TARGET_IPC_SET:
> +        host_cmd = IPC_SET;
> +        break;
> +
> +    case TARGET_IPC_RMID:
> +        host_cmd = IPC_RMID;
> +        break;
> +
> +    case TARGET_GETPID:
> +        host_cmd = GETPID;
> +        break;
> +
> +    case TARGET_GETNCNT:
> +        host_cmd = GETNCNT;
> +        break;
> +
> +    case TARGET_GETZCNT:
> +        host_cmd = GETZCNT;
> +        break;
> +
> +    default:
> +        return -TARGET_EINVAL;
> +    }
> +
> +    /*
> +     * Unlike Linux and the semctl system call, we take a pointer
> +     * to the union arg here.
> +     */
> +    target_un = lock_user(VERIFY_READ, un_ptr, sizeof(union target_semun), 1);
> +
> +    switch (host_cmd) {
> +    case GETVAL:
> +    case SETVAL:
> +        __get_user(arg.val, (abi_int *)target_un);
> +        ret = get_errno(semctl(semid, semnum, host_cmd, arg));
> +        break;
> +
> +    case GETALL:
> +    case SETALL:
> +        __get_user(target_array, (abi_ulong *)target_un);
> +        err = target_to_host_semarray(semid, &array, target_array);
> +        if (is_error(err)) {
> +            return err;
> +        }
> +        arg.array = array;
> +        ret = get_errno(semctl(semid, semnum, host_cmd, arg));
> +        err = host_to_target_semarray(semid, target_array, &array);
> +        if (is_error(err)) {
> +            return err;
> +        }
> +        break;
> +
> +    case IPC_STAT:
> +    case IPC_SET:
> +        __get_user(target_buffer, (abi_ulong *)target_un);
> +        err = target_to_host_semid_ds(&dsarg, target_buffer);
> +        if (is_error(err)) {
> +            return err;
> +        }
> +        arg.buf = &dsarg;
> +        ret = get_errno(semctl(semid, semnum, host_cmd, arg));
> +        err = host_to_target_semid_ds(target_buffer, &dsarg);
> +        if (is_error(err)) {
> +            return err;
> +        }


> +        break;
> +
> +    case IPC_RMID:
> +    case GETPID:
> +    case GETNCNT:
> +    case GETZCNT:
> +        ret = get_errno(semctl(semid, semnum, host_cmd, NULL));
> +        break;
> +
> +    default:
> +        ret = -TARGET_EINVAL;
> +        break;
> +    }
> +    unlock_user(target_un, un_ptr, 1);
> +    return ret;
> +}
> +
>   /* getdtablesize(2) */
>   static inline abi_long do_bsd_getdtablesize(void)
>   {
> 

Shouldn't we have a goto cleanup instead, to make sure with

