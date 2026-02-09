Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 142FBEF06FF
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 02:17:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpGq4-0002rY-1r; Sun, 08 Feb 2026 21:17:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vpGq2-0002jP-4R
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 21:17:22 -0500
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vpGpz-000692-Vw
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 21:17:21 -0500
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-c2af7d09533so2829181a12.1
 for <qemu-devel@nongnu.org>; Sun, 08 Feb 2026 18:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770603438; x=1771208238; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dChIBSXHou4DSR3OrQeO8xJ9h6yJ69pgRaAh2a8XlEY=;
 b=NVCLmt8byXDv2bjc/WlG5ljEztP6EjtPBpkXIrX9hgUdyogdP70pri/7XiJa7zCoMA
 dfUTQh6t7uAu7sOBGZ1e57z+aVFB4R9xJ8cOM35JZiuAnhYNUshEAOWfe4aypYfaCiJU
 xDtvTIIlg05NJBmEq2GrK8HO2fD/RY/RRNTFD4WBEZP4+2M62tYFO12KfwvOcNVqDv+Q
 6TQv1RKr+0NvdPowJOOLKqVEBdIeP8JlYRPQv82cWZiXnutw8EKBIaO88lBGu74tuKyw
 jOGNUfjnKTdzinczZLIWnLlRIv6RO7EbzE0WRkfHlgdJ2Gou8tGTFnm2usRYd5IXnm9g
 hJJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770603438; x=1771208238;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dChIBSXHou4DSR3OrQeO8xJ9h6yJ69pgRaAh2a8XlEY=;
 b=AYWlVWHxg61X4lmH1vhs8GUYTh8mA3gpIEJ7sJM854kTGivzReNU1EzxvCO807Hxhe
 f28lzeftt6J2OA4sLctIB7ADqa9RWadEV0iYpdKCN1/pkFnbMbl4JruX96lKAnCvGOer
 Ro3e0B4NcCETubqV6Amt8H7UPY8xLyhPQa+Y486peoQLw2rHWR4WiC6arlQCE/yZfgMj
 /qJhXc1t05jpfhFvC3rLgnHH8VsqVpcRkhN+fUnlrMmmt0zZkB1aNZaPp54J+QLUMYYO
 /pTQWSKJtd1gZZKVrMvl2wShIlkmvqHRdIruWSkOlYSJCfCzkUyzSs/wwc5OB+6Q9Txu
 s5eQ==
X-Gm-Message-State: AOJu0YyEAnoYsFgnvtmO+nJuZJdvQkU2kxHY8WgE9O8QcuDvVGqx83f+
 agh7awAHkj0byRn2Vt2b5dMgbFC1ZEqpDYe2jUnKTAH8xzHeYcvkyBj9lZKhIh8yW2skeM9GnsZ
 2CpJsY3M=
X-Gm-Gg: AZuq6aL4mKA/CVbuV7kHWOoY7xBucUSsbbdj1+sXyfHI4n+5NtWU3SVjciDY62S2ijS
 8fDv7qBeuRtHsjzK7418HryO0FbgwUW6YwJN64xa0EGfMvORQ/lhtQkD4SGTUPIiKWaWMNPt/nw
 6LJ5ld6aMhGmC6WyauyyPydgnJdckCHhYcUdLHbvX+RsNVV2BVxJho9z1WfiMyoJs1Cef+gyAa+
 ncm4eouABptH6vlhh2dDw8SImPYeLqaT/zFpyoaq2+FMNHU5rd+oPvqX9TW0905vYLzjrd1RPe2
 N4ngji//qQ+KQJSfCpWu2nkITtNp0ia8Q/iV6tehPGvm3/Sg63Su4rEUcwyCkAyJsI00XAHIeBa
 c6y9GJVrcPKirspK4GAw+4OGv0EEZI3P1hYRvqtr37PKwpKV3kRDe6oBbfdVsvA8r/LMG+laDZP
 8NMnq4+ei4Nx0BjqVlwsgD2ZA6XCLFVbTAOTbucUJGtiQZUB8UwDEVBLso1sqI8NI=
X-Received: by 2002:a05:6a20:7353:b0:366:14ac:e1f1 with SMTP id
 adf61e73a8af0-393ad3adfe9mr9914982637.67.1770603438230; 
 Sun, 08 Feb 2026 18:17:18 -0800 (PST)
Received: from ?IPV6:2001:8003:e109:dd00:9c4:a3d:914:f9b?
 ([2001:8003:e109:dd00:9c4:a3d:914:f9b])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c6dcb4fb713sm8300167a12.3.2026.02.08.18.17.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Feb 2026 18:17:17 -0800 (PST)
Message-ID: <4ac81830-4a5a-4a24-bc96-bbc091b817ef@linaro.org>
Date: Mon, 9 Feb 2026 12:17:13 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 18/24] bsd-user: Add do_bsd___semctl implementation
To: qemu-devel@nongnu.org
References: <20260208-bsd-user-claude-v2-0-58e5fcfdb84f@bsdimp.com>
 <20260208-bsd-user-claude-v2-18-58e5fcfdb84f@bsdimp.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260208-bsd-user-claude-v2-18-58e5fcfdb84f@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
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

On 2/9/26 05:26, Warner Losh wrote:
> From: Stacey Son <sson@FreeBSD.org>
> 
> Add implementation of __semctl(2) syscall for System V semaphore control
> operations. Handles command translation, endianness conversion for GETVAL/
> SETVAL, and array/structure conversions for GETALL/SETALL/IPC_STAT/IPC_SET.
> 
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
>   bsd-user/bsd-misc.h | 115 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 115 insertions(+)
> 
> diff --git a/bsd-user/bsd-misc.h b/bsd-user/bsd-misc.h
> index cba0b2ec92..d3ce01a2a3 100644
> --- a/bsd-user/bsd-misc.h
> +++ b/bsd-user/bsd-misc.h
> @@ -106,6 +106,121 @@ static inline abi_long do_bsd_semop(int semid, abi_long ptr, unsigned nsops)
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
> +    target_un = lock_user(VERIFY_READ, un_ptr, sizeof(union target_semun), 0);

Missing an unlock.

r~

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
> +    return ret;
> +}
> +
>   /* getdtablesize(2) */
>   static inline abi_long do_bsd_getdtablesize(void)
>   {
> 


