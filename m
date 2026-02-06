Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11698ECD9B5
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 00:17:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo9XS-00079E-KD; Thu, 05 Feb 2026 19:17:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vo9XR-00078r-6M
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 19:17:33 -0500
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vo9XP-0003qE-FQ
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 19:17:32 -0500
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-34c93e0269cso1627242a91.1
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 16:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770337050; x=1770941850; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BHEiuLCGMeo1fGsVtgN5seNfOYDGki8nlRigwwL25F0=;
 b=pyhGKywndTlJmyOcYYAhYQYzmeUPJmgtBnPtUUl/Sw9MgDe0jc0XScpebsW5ZTply7
 cpyOrtGsYeerHGlAQ78WC4Ov0JorOVcVaLlpj4FcnD/YKz3xV4GM76okNEripk4WhoJY
 YmhBQ3k32oRv10NBKnhiAqhzAlwRs7YTe+LPS2tYYRJ4t3Pm7qUBN/nWIUg8GFpK5cdN
 h+5NBS2+RcoQhKbvGObhTrrgUQvmOGD7eHjhA1uhlOTDO4/O72uxOxLBvtbRJbTpKzk2
 712k3Fulk5mSDNAXhdip0Gd7KnaffIVEO9h2waBaS4QJ0eMgrzDUGfQ7ofg0cqJbyESM
 PC5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770337050; x=1770941850;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BHEiuLCGMeo1fGsVtgN5seNfOYDGki8nlRigwwL25F0=;
 b=e8KKPoRq2bIWMcvr+i3W5Lqpv2WavaOpPHzl/LBzB7gfeK17qxdKgu8Y/V+DIH2hK7
 CMHxDrQ6sePXD24XHqCCVFhIymf5ECj1WUz7i26U/YyiA1IIaE7k+gotft+AjP0Nh8Qe
 VvVTc0aU1CNXTIcamJxVEUsDzC7C+meV4a+xk95K++0XOxadbWqsOlostRT4Hb+ph7Gd
 GXQiHf8Y38C2kohhC5T9PP9+mVVp2SV0dZd9ZiM0QaEy0eO8sFO+veeVPE4PzeVqdVfA
 RamN3VO+gLR49g+dPAv1M4XCr38MV12EIchEK92uCs/ZTN9rOM8qRwCmqedOopDtjq9z
 eMXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/Ds1X3kd56AkZw36otCfUIeG/aNrlhwTKqIIY7j3jzYJFLk7VWwZbcDk2Wg/2Itclpu1KiPE+Ckbe@nongnu.org
X-Gm-Message-State: AOJu0Yyj8h6kqql2GBkFkNvjcsmM1iaHMmG4YxksaSdvjuMHseE5eJfm
 BbzjXqT93Gd3eOy6wTU1EpjxFOt9xjvlVR45V3gBC+ZaXanNiI7EKvUizylwBhlL7JU=
X-Gm-Gg: AZuq6aLKb2LSBkn6mOsaqlCaA6qSqq+bJ4WT7sn0uJ8IDU0GtTebpuHl3/zNKrrs9v8
 gdlyDhJlVMdd/CgVFUEATW2Byu/UCj/381e2rUxuX212rTWSO0QCgqnLg104orNoT3ZdNnBuZyc
 H2NjbDsGhIVWIcZIcu+33Cy7JubRb/ckD06Rvz3Or4fa+SvWr/ueNgl3c3dFnsWepdg1sMzFy9o
 jsgORFbxlKWnpDCbL9h03OZb3m1cfg+dEYX9E+nZT0AObh2kmltBVtpzN6Hzgtv0BDPNP8kRlBi
 cTaMzj+U/cfc58oTYDdoznOhCQbi190kBkosQKrwlWpvzVdYwT+t4vIcJcfc1Bm8AFlXqjntr84
 T3JE5fiFM0kxz+P3bDCi9u4OhJkdfV8OaAfzB4QjplJAMjk2Ip1VcL09hii+sp87V66Jq4bLxln
 PH0tXReDJg6vtn0zRJI4M2aaisjdqmsBTDhiF/vDeEBy9v7F32T8FAmjw8vPD3IK5jJ7lR6SNdR
 +qsnnSIcguPMQcXHdSb0Cr5LsAFtqbsTjGEik6DsFZnHqsyzRm6
X-Received: by 2002:a17:90b:2b43:b0:352:d0cf:9d18 with SMTP id
 98e67ed59e1d1-3549bafc8d5mr3569674a91.5.1770337049894; 
 Thu, 05 Feb 2026 16:17:29 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:3c5e:852f:abc3:6539?
 (bg30dhzs8j4dh00m37sw.ip6.superloop.au.
 [2401:d002:dc0f:2100:3c5e:852f:abc3:6539])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a951c78824sm5174695ad.24.2026.02.05.16.17.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Feb 2026 16:17:29 -0800 (PST)
Message-ID: <a688dd34-a37e-46f1-8739-e01105ee4dc8@linaro.org>
Date: Fri, 6 Feb 2026 10:17:22 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/24] bsd-user: Add function declarations for bsd-misc.c
 conversions
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Stacey Son <sson@FreeBSD.org>
References: <20260205-bsd-user-claude-v1-0-8d8ff0035372@bsdimp.com>
 <20260205-bsd-user-claude-v1-5-8d8ff0035372@bsdimp.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260205-bsd-user-claude-v1-5-8d8ff0035372@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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
> Add function declarations for BSD System V IPC and UUID conversion
> routines that will be implemented in bsd-misc.c.
> 
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
>   bsd-user/qemu-bsd.h | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/bsd-user/qemu-bsd.h b/bsd-user/qemu-bsd.h
> index 56affcd31d..b98d1d76b2 100644
> --- a/bsd-user/qemu-bsd.h
> +++ b/bsd-user/qemu-bsd.h
> @@ -54,4 +54,19 @@ abi_long target_to_host_shmid_ds(struct shmid_ds *host_sd,
>   abi_long host_to_target_shmid_ds(abi_ulong target_addr,
>           struct shmid_ds *host_sd);
>   
> +/* bsd-misc.c */
> +abi_long host_to_target_uuid(abi_ulong target_addr, struct uuid *host_uuid);
> +abi_long target_to_host_semarray(int semid, unsigned short **host_array,
> +        abi_ulong target_addr);
> +abi_long host_to_target_semarray(int semid, abi_ulong target_addr,
> +        unsigned short **host_array);
> +abi_long target_to_host_semid_ds(struct semid_ds *host_sd,
> +        abi_ulong target_addr);
> +abi_long host_to_target_semid_ds(abi_ulong target_addr,
> +        struct semid_ds *host_sd);
> +abi_long target_to_host_msqid_ds(struct msqid_ds *host_md,
> +        abi_ulong target_addr);
> +abi_long host_to_target_msqid_ds(abi_ulong target_addr,
> +        struct msqid_ds *host_md);
> +
>   #endif /* QEMU_BSD_H */
> 

Normally, the declarations should be added with the definition. But I won't insist that 
you split this into the 6 following patches that add the definitions.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

