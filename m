Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 189C0EF06FA
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 01:11:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpFoG-0007HY-VD; Sun, 08 Feb 2026 20:11:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vpFoB-0007C1-Tp
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 20:11:23 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vpFo8-0004Mm-PR
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 20:11:23 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2a7a23f5915so25070945ad.2
 for <qemu-devel@nongnu.org>; Sun, 08 Feb 2026 17:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770599467; x=1771204267; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=B6mvDL6H5lQxNnAzBlAPPlo/c+M+wnA7j6kmHgiaye4=;
 b=R5VxpdmWbaRsP4fNWA/tgnWdMX8OuA+a55fDZODUTfPaYfTYGW3NqHoeWeYeHLM/GD
 puwNAr3uE8jmhSdR/CxVjO65yuYWSWYRQ+sbuu4dqfeCgATEmQi4wL44zvDPaIZX7aCn
 +3bNHLABxZjIUjFX8U8TPAxcp9fHQleKwwwlTHSYwI2+S30cFNzr9DaJ4EdjvBFb10r4
 AxhaU9N2lNxWfvyESUX0XcgR7fvZog4efe9qCnBX7/o7oG0OG9ZJRZQNIPgingyzavsr
 mJpVF3BYYm4jazaD952DkxbDse5RBzNhIlsS3cVnA5EuFiv8LbCjvWBjuBq93hnAY0j4
 djAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770599467; x=1771204267;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B6mvDL6H5lQxNnAzBlAPPlo/c+M+wnA7j6kmHgiaye4=;
 b=s5SLrcegkmMiGRnaiHxk7nnH5VVbIDrhF2HcMQXPZ6sT5rh7I8Zl+aLRqBe2riF/kV
 kphQREyf9GIgK/1oPl/Sb2l5GCttO/uWQ40aPNQXhQ8RnRit9uRxrZm2fX9xGfFej2fY
 RQ4g5VOP/hdHBGgunRKb+1YAJ+xM8WOK9JldnFkuFFKVCzK2TpkEZIOgMZkZbqdkB4px
 FkcZuTSrkq3tFrRIISCQld44EsxdeCHIN3o8CUlS6InGFbf6QSseCc/paihv80Ht2gPz
 04jcA3O7KtpB2qal9wtcU9mQP6bM4G+6lSpvQy/lYhCRnVFMUNQu7YeQRPXWfRsue1FU
 wHJg==
X-Gm-Message-State: AOJu0YwYIjkgypZwRqB+A8s9eahGD1pb+6c2CqvF3h27PND6pwzVRvBq
 Oubi1jksjWnwKr7Ul4XaYe13xrCDiUxw84fUd0gcWiA1MhzPauKkq5nibfT31ivS5L7OHfOo65o
 YhqPGDzk=
X-Gm-Gg: AZuq6aLg2MMUDUvyHxA3JOd31DGmqWgkLjzZhrS1Ln6/ICggjIAvp7E/stUoJxZgfUH
 Po/vXsThzs98IOK6kcK+5rJTw/ACfjCPkWW/Yjc64OyzhINXobQL2v8/pTAtbGPvRpdktG1BLFy
 4YDRz0IAff6wVLJxLK3QkbHPGkQhObvB/OxTVMgZTWBzu6iusgvaKigEHbiEB0B7Soe6QgugXLL
 AW27zoKR6InimbiKwk+9q+X+N471t3ziKzARSC6YoHBndVhxzrEff1/YJzjHekvcSZLEPAGvnPj
 gsi2+M9ECASRNiT7leGNfHeJZ6YErp3OJxR7JchcIUaDi5u+shjpgymR6dGI2Xa5T5AxFDX4RMs
 IU5TMZ241r4vABm1nG2ZUK6OlNEUlUvAz9/1RcJWjvgeiuzpl4vpu/5Tx8H70oROi6ujWuy3LRp
 PtXkff24mhM0BmfccYuzVBanxv29rL0kl4wsEZ+mlv2LdJ0uGxV3M+tgNGaYe0xM4=
X-Received: by 2002:a17:903:46c4:b0:2a9:62f1:3fba with SMTP id
 d9443c01a7336-2a963008612mr54186045ad.33.1770599466970; 
 Sun, 08 Feb 2026 17:11:06 -0800 (PST)
Received: from ?IPV6:2001:8003:e109:dd00:9c4:a3d:914:f9b?
 ([2001:8003:e109:dd00:9c4:a3d:914:f9b])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a95e2fad78sm65442455ad.45.2026.02.08.17.11.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Feb 2026 17:11:06 -0800 (PST)
Message-ID: <1ab8eb64-c546-4faa-a0b7-09a30c40b2f2@linaro.org>
Date: Mon, 9 Feb 2026 11:11:02 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/24] bsd-user: Add host_to_target_semarray for
 semaphore operations
To: qemu-devel@nongnu.org
References: <20260208-bsd-user-claude-v2-0-58e5fcfdb84f@bsdimp.com>
 <20260208-bsd-user-claude-v2-8-58e5fcfdb84f@bsdimp.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260208-bsd-user-claude-v2-8-58e5fcfdb84f@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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
> Add host_to_target_semarray() to convert host semaphore array to target
> format for semctl(2) GETALL operations.
> 
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
>   bsd-user/bsd-misc.c | 33 +++++++++++++++++++++++++++++++++
>   1 file changed, 33 insertions(+)
> 
> diff --git a/bsd-user/bsd-misc.c b/bsd-user/bsd-misc.c
> index d9eb87db80..677cb49d27 100644
> --- a/bsd-user/bsd-misc.c
> +++ b/bsd-user/bsd-misc.c
> @@ -79,3 +79,36 @@ abi_long target_to_host_semarray(int semid, unsigned short **host_array,
>   
>       return 0;
>   }
> +
> +abi_long host_to_target_semarray(int semid, abi_ulong target_addr,
> +        unsigned short **host_arrayp)
> +{
> +    g_autofree unsigned short *host_array = *host_arrayp;

Good, but...

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
> +        free(host_array);
> +        return get_errno(ret);
> +    }
> +
> +    nsems = semid_ds.sem_nsems;
> +    array = (unsigned short *)lock_user(VERIFY_WRITE, target_addr,
> +        nsems * sizeof(unsigned short), 0);
> +    if (array == NULL) {
> +        free(host_array);

forgot to remove the explict free.

> +        return -TARGET_EFAULT;
> +    }
> +    for (i = 0; i < nsems; i++) {
> +        __put_user(array[i], host_array + i);
> +    }
> +    free(host_array);

again.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
> +    unlock_user(array, target_addr, 1);
> +    return 0;
> +}
> 


