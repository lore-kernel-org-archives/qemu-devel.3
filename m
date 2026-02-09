Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B9A2EF06FC
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 02:04:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpGdc-0000KH-04; Sun, 08 Feb 2026 21:04:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vpGda-0000J3-AU
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 21:04:30 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vpGdX-0004WB-DC
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 21:04:29 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2aad1dc8856so6435275ad.1
 for <qemu-devel@nongnu.org>; Sun, 08 Feb 2026 18:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770602666; x=1771207466; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KnoKZEXCtb1opzNeYc78+JZdYCpGLKZd1O7FqOlAScI=;
 b=lNeLexCan338Edq2Sz+PQxzXUDQDVJPvh9mWEhsQrguACncjN6S6rx+GUgaxXkHp/a
 PeX3onGU6sjsQVkoRiyqaJcUl4M40y5Py7PZzqV1PQHoRxHl28uyo3IlBlPHfHxd5Jzd
 KVIbhT1AAkqygMuHp6IdWeWwxPqCICDD24wnsh3jaergT6GFpTMmrZ8wKme/LeHHoc/X
 70Tu6GLesUtMPTTN/CCn1Bc2NV3jsprGoZGmW45BnzwB9+iKF6cgSqJJGMg0uPoUfPgX
 i4Ppx2OZdx+ta5UfJb1QHKXseW+/Kswdf8KxDef2lXGh9pMjEXmRaU24ZtUmtrIs+8IH
 sAFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770602666; x=1771207466;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KnoKZEXCtb1opzNeYc78+JZdYCpGLKZd1O7FqOlAScI=;
 b=PepY0u8jy9hYkegYqztm6RUiDK9D5NowmDYybrJyQ2J9Q6uC3n8KE3T8xLr28cOLMi
 idbiNd7iF51J+F9E2rtMwdMEfbbvbSS2t9tWNal8iLycf1QmXEUnJ7wh8L6Y92T57aat
 /VDOnbupP47AJp45a3+ay5RTRWGCuuyunYNMupuJR2AaZiU5rnHJvNZOww9OEpY8XKAq
 NYHS7F3X//n6Dy8dGxcaq5UxvT/nQpIMY4Xxiq0unLYFf0p2n97SW3DnU814n/ie9otS
 lNa/an703zvMcm5vHHhP2CLl9n0bVxahf/0WLoKDmhp07gm/n9pPGHGK3QinoGX0MzPZ
 qpNw==
X-Gm-Message-State: AOJu0YweSQp9WDbQh74cn+nS+N4rT29NY5zN07aP9+vJxx5n45sYPt2b
 SfFlYIZWnBrOxdSzyXPnsE77xGwqjYczZXDuYd7poAEJ1x417JOFBc7XQSZbsUH76ic8VhJ78rr
 G3UWKJgU=
X-Gm-Gg: AZuq6aJxBbIbQPhnP60E7Rw420uVFhBSTXFLNu9UKnaanEALaiHg+K2ccgUoUGjOV3w
 Q42PMmJhDQyYlV1esqtc/K/RYCV5kp6BuFdNVc1WmPf54MqZ3nWL2nh9TPWFaN/k8XNVbcM8n/k
 paqOKO+7MEJTW1QiRHi4P/nKV/uReCZNKzNeHFTyHz7ooloJjdzLzZQqlWTtN9oBtySvpgt5CkU
 RalXdkBwI9Qukxqom3i5QUyfidF1mzr6Thcin34WLFkgbb3rbcwHjfrSDRhvYjV0LsqYSQicWNP
 y7dq7BPFG+bd/fWa5/0KtX+PgHpOOzhtKhqqFhjWXQeODE3l0w5NkYjljbJTfyR8I88W3vQlnE2
 YxjhnWoeuvbUuXr93TmnKaPUpoJxH6p4WVUjgGWNxjJ0DcdkMYhMcwp0OJX9RFfVf5o1CsGhS6d
 kFH+56U6rZAmzzpXm62YqiVI3lUV/MNwKKrnfEmw7ky8PLaPjBV5mBjfEKeFUAUsg=
X-Received: by 2002:a17:902:da89:b0:2aa:d2a7:ad2e with SMTP id
 d9443c01a7336-2aad2a7afc7mr56663295ad.36.1770602665721; 
 Sun, 08 Feb 2026 18:04:25 -0800 (PST)
Received: from ?IPV6:2001:8003:e109:dd00:9c4:a3d:914:f9b?
 ([2001:8003:e109:dd00:9c4:a3d:914:f9b])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a9522287d1sm83677335ad.91.2026.02.08.18.04.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Feb 2026 18:04:25 -0800 (PST)
Message-ID: <60f644bf-db93-4f8d-bc39-d1cf2af50c1a@linaro.org>
Date: Mon, 9 Feb 2026 12:04:21 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/24] bsd-user: Add do_bsd_uuidgen implementation
To: qemu-devel@nongnu.org
References: <20260208-bsd-user-claude-v2-0-58e5fcfdb84f@bsdimp.com>
 <20260208-bsd-user-claude-v2-15-58e5fcfdb84f@bsdimp.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260208-bsd-user-claude-v2-15-58e5fcfdb84f@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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
> Add implementation of uuidgen(2) syscall that generates UUIDs and
> converts them to target ABI format.
> 
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
>   bsd-user/bsd-misc.h | 29 +++++++++++++++++++++++++++++
>   1 file changed, 29 insertions(+)
> 
> diff --git a/bsd-user/bsd-misc.h b/bsd-user/bsd-misc.h
> index d81b4fbaef..ad248c3b79 100644
> --- a/bsd-user/bsd-misc.h
> +++ b/bsd-user/bsd-misc.h
> @@ -43,6 +43,35 @@ static inline abi_long do_bsd_reboot(abi_long how)
>       return -TARGET_ENOSYS;
>   }
>   
> +/* uuidgen(2) */
> +static inline abi_long do_bsd_uuidgen(abi_ulong target_addr, int count)
> +{
> +    int i;
> +    abi_long ret;
> +    g_autofree struct uuid *host_uuid;

autofree variables *must* be initialized.
NULL is sufficient.

> +
> +    if (count < 1 || count > 2048) {
> +        return -TARGET_EINVAL;
> +    }
> +
> +    host_uuid = g_malloc(count * sizeof(struct uuid));
> +
> +    ret = get_errno(uuidgen(host_uuid, count));
> +    if (is_error(ret)) {
> +        goto out;
> +    }
> +    for (i = 0; i < count; i++) {
> +        ret = host_to_target_uuid(target_addr +
> +            (abi_ulong)(sizeof(struct target_uuid) * i), &host_uuid[i]);
> +        if (is_error(ret)) {
> +            goto out;

break is sufficient.


r~

> +        }
> +    }
> +
> +out:
> +    return ret;
> +}
> +
>   /* getdtablesize(2) */
>   static inline abi_long do_bsd_getdtablesize(void)
>   {
> 


