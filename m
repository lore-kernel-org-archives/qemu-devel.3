Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B752ECD9B5
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 01:47:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voAw7-0001TS-Bf; Thu, 05 Feb 2026 20:47:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1voAw5-0001T0-Nb
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 20:47:05 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1voAw4-0003XQ-2H
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 20:47:05 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-81dab89f286so765229b3a.2
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 17:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770342422; x=1770947222; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=e6neuCyiUxXHgn68pyuXGnP3MXdcFztdJHnRTGT7knk=;
 b=qVySPlJBWkqchyaE+fdAtFYmhtZAsSK4A6iqclkfztqAUju906qYeeQHvwlPas1P8Q
 gmY9sktVOfeLgdAnLp0jKxeJ4kVCnIB6hlMnwRQixMemHzSawoeOHGvqb33v3clHSdBf
 s6aWitSuod6fq0kXb03xEmJvXnpxRy3oA3t0nMHDLj4i7dLL4Kdr2wRPQ0WharglvJAV
 BmzT3wK7hRYre9Wd6biCUclPBVVoGbXP7TAwao0SYb8jXrFOVfpPF1jmv4QPGeJkqE8z
 2rIfWwT8fGY/1ZqgXWXJbGNTRYw9vvGTvlvfK8yzCzp++UF4g0J1uUIXjx7DmuZqKATu
 emFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770342422; x=1770947222;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e6neuCyiUxXHgn68pyuXGnP3MXdcFztdJHnRTGT7knk=;
 b=Wz4Kki+WFBx+P3n/94uNUBVZ7TK27+2tDezAd4NfvRqiRYUKs3Tk8IqpBqsbAbxQXf
 C65Hd7eOINr+mELUm5f4pPrDZeO0pFZqMcg9++YjCM4d41Ow93RW/H2DwdVZ+Dmmzfpp
 eG/jee0Iwx0JhOtuaQaJBPIitcThaadj6V8MG3II2k8rW4gpEl48Hhedh3DXdW5BcbwX
 5LGTW8scux/GE27nqmIoHeC3Jd2uaIHKBFp4Zlrnq4X95cA26DeHVHj9DhHx0715ZUj+
 XTiL1uouDpRsQl4rfkRPB1zGR21PisFF58DezIlnx10vMuobimGP7UZnxnPDrGkOhi7V
 DGNg==
X-Gm-Message-State: AOJu0YwyI+w/BklhA7CbDAt/dtPHDuRkdH8fmr/HyD/gCUQkCUKhGkcv
 KadYhS4tGIIVlbDcASFCQ5Vhj8/FSLGqJS29Y941aRysKYA76QMLCKiR6ulpKe6zZXQrviv6nMl
 vcD9zSnOv7A==
X-Gm-Gg: AZuq6aJCcz8LsViKzpOILPg3FrhjqM49yeuLkUi/l1c/PfaQMMJdTXsO5jrA+pkpGFc
 mCYsqF4jjjO0OvZ81HFzFr00dvY1XkdazAjDf7DIE9jTdU6Gd1ofdSGsCMlUMUYYmDbhZsjl271
 SC04C91BDmk2FfEdfzthKxj0Z9swycypS2GxUsmYqOxIy99rvgXwwGCxRQsIbiJJIwO0cZXbvxr
 Wf936+0vyZBcIcuaScDcjGug9LCg3yukMmq/bLLTE1A2tm1VDDFsz4Sv3jI0h1/91LA9qF2d4VY
 Jkz/FWK8z4VTWLvKGpAEQYzPvh1b2my3Ba48MqrtrEqmrzFQAk8sPIDPax8BrOrzm6i3Fh9hOVs
 zqa2kf4SfQtFfEvnferKYLu+0c1PZPDaNfPawqyADShOHy+PfkrRxWpRwqEa5KSXyRuFm1ChBqF
 1jAIFaFLhexOSeqhhi6AcqB8IavMUqq83Jls4COx0VOSUwyBTrP0mQGjMOTDT9OxFi0oKIkw020
 A==
X-Received: by 2002:a05:6a00:3386:b0:81f:7c29:6091 with SMTP id
 d2e1a72fcca58-8244165674bmr781785b3a.29.1770342421879; 
 Thu, 05 Feb 2026 17:47:01 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:1ced:e57b:71bf:567a?
 ([2401:d002:dc0f:2100:1ced:e57b:71bf:567a])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-824418e7d14sm544619b3a.68.2026.02.05.17.47.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Feb 2026 17:47:01 -0800 (PST)
Message-ID: <c4925c4c-0562-4033-8a6b-5311dd419c9b@linaro.org>
Date: Fri, 6 Feb 2026 11:46:56 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/24] bsd-user: Add host_to_target_semarray for semaphore
 operations
To: qemu-devel@nongnu.org
References: <20260205-bsd-user-claude-v1-0-8d8ff0035372@bsdimp.com>
 <20260205-bsd-user-claude-v1-8-8d8ff0035372@bsdimp.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260205-bsd-user-claude-v1-8-8d8ff0035372@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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
> Add host_to_target_semarray() to convert host semaphore array to target
> format for semctl(2) GETALL operations.
> 
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
>   bsd-user/bsd-misc.c | 32 ++++++++++++++++++++++++++++++++
>   1 file changed, 32 insertions(+)
> 
> diff --git a/bsd-user/bsd-misc.c b/bsd-user/bsd-misc.c
> index 07d8bf1304..7bdf65450a 100644
> --- a/bsd-user/bsd-misc.c
> +++ b/bsd-user/bsd-misc.c
> @@ -79,3 +79,35 @@ abi_long target_to_host_semarray(int semid, unsigned short **host_array,
>   
>       return 0;
>   }
> +
> +abi_long host_to_target_semarray(int semid, abi_ulong target_addr,
> +        unsigned short **host_array)
> +{
> +    abi_long ret;
> +    int nsems, i;
> +    unsigned short *array;
> +    union semun semun;
> +    struct semid_ds semid_ds;
> +
> +    semun.buf = &semid_ds;
> +
> +    ret = semctl(semid, 0, IPC_STAT, semun);
> +    if (ret == -1) {
> +        free(*host_array);
> +        return get_errno(ret);
> +    }
> +
> +    nsems = semid_ds.sem_nsems;
> +    array = (unsigned short *)lock_user(VERIFY_WRITE, target_addr,
> +        nsems * sizeof(unsigned short), 0);
> +    if (array == NULL) {
> +        free(*host_array);
> +        return -TARGET_EFAULT;
> +    }
> +    for (i = 0; i < nsems; i++) {
> +        array[i] = (*host_array)[i];
> +    }
> +    free(*host_array);
> +    unlock_user(array, target_addr, 1);
> +    return 0;
> +}
> 

You can simplify this a bit:

...	unsigned short **host_arrayp)
{
     g_autofree unsigned short *host_array = *host_arrayp;

which now takes care of releasing the memory across all return paths.
You also don't need double-indirection in the loop.

You do need __put_user (or tswap16) in the loop for endianness.


r~

