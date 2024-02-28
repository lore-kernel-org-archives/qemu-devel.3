Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23A30C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 15:08:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfLWV-0001g6-GZ; Wed, 28 Feb 2024 10:07:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rfLWS-0001fh-Hr
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 10:07:05 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rfLWK-0007e3-NH
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 10:06:59 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-412b814da6bso1352275e9.2
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 07:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709132815; x=1709737615; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GrVntBP7Wgxz+sgxT81lRUo4hTod651emDn56DM2xWI=;
 b=BddSaDDFBsmjrGhmYTRuGisGiERjd4uFyj2LDkPdmcF+yimfdSzeyk+EUyf0ISTldG
 +2kIa1zzI6vIppcsBsWgo5sNP7MQaJkX0MMoHfZUUnSPRk1GVd8cA7tSMmhXE+5ZmiAJ
 FDMMIslCF/2lTuIerxGtQl+D62H2orusm6rxNi8RMDuB2OYufaUn2tNSZMB+YVZgIW+8
 WDXholkoE/E5uEylpPYk9jbXnIBB7ywzt75aC/xIHp9WlCqi1RdG4HCYTzzZkk0Mt90w
 HiBH/VX2ldfbswsS1f14/FwGRBr19xBmzCwm/qVG+YRevpFP1Zq0y/YYrsJGJn5xgcb6
 6UGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709132815; x=1709737615;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GrVntBP7Wgxz+sgxT81lRUo4hTod651emDn56DM2xWI=;
 b=p4qVeSka0NAHE8qZ+OX+H5Xl3BF48EkgvBrmSfbOovjN6mqNCX20TtQLiAyv2DRNXj
 6q7DT5LeiJ8hh1vAOVjUxTL3dKou4RfjYOb4gFVsrqctp3sEu32s88XSJGAqCEje4Be0
 o0j653nn/Z/WK/y6wDZkvvdn6hC0/bvmLwZMFtrJwaBQhzxr+h+SWlgLDQIHXTmTUvkB
 wQ14p0KFsLTg0N3+UmpNIOdM5rDy6n8LPbcJL6yfhhKpEmbxJbENQ52UxioxC86GrVpf
 sxxLsQ+G24MYUBG/ZAFAS1AHoEdxZcZnUV0TkLdoo2yEqNfIWUZchL2iOXL8+1nuuYLj
 Og7w==
X-Gm-Message-State: AOJu0YzXBJGQVmKCi3vJ6EQYiDFoENUfNW/hFM7jiMvo2nClFtO9zgsY
 yHyhMKiOYEcx7a+kJ3WwPGzaJ2e4Et69JToWgSUtNaAmBsWXHlFKORW0RznI7vk=
X-Google-Smtp-Source: AGHT+IHCcyIOXCx9N4UwHXXO4rmYb4eTKURGNphGHwCSGGcHTcZSAUeAm9Drk2tBWL9losYLnLh1lA==
X-Received: by 2002:a05:600c:198b:b0:412:a45f:4386 with SMTP id
 t11-20020a05600c198b00b00412a45f4386mr6702245wmq.16.1709132814884; 
 Wed, 28 Feb 2024 07:06:54 -0800 (PST)
Received: from [192.168.61.175] (122.red-88-29-183.dynamicip.rima-tde.net.
 [88.29.183.122]) by smtp.gmail.com with ESMTPSA id
 az14-20020adfe18e000000b0033d2541b3e1sm15612729wrb.72.2024.02.28.07.06.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Feb 2024 07:06:51 -0800 (PST)
Message-ID: <fb6ef90d-4a3e-4bdd-8516-8b15c1f2329f@linaro.org>
Date: Wed, 28 Feb 2024 16:06:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH, v2] physmem: avoid bounce buffer too small
Content-Language: en-US
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
References: <20240228125939.56925-1-heinrich.schuchardt@canonical.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240228125939.56925-1-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Hi Heinrich,

On 28/2/24 13:59, Heinrich Schuchardt wrote:
> virtqueue_map_desc() is called with values of sz exceeding that may exceed
> TARGET_PAGE_SIZE. sz = 0x2800 has been observed.
> 
> We only support a single bounce buffer. We have to avoid
> virtqueue_map_desc() calling address_space_map() multiple times. Otherwise
> we see an error
> 
>      qemu: virtio: bogus descriptor or out of resources
> 
> Increase the minimum size of the bounce buffer to 0x10000 which matches
> the largest value of TARGET_PAGE_SIZE for all architectures.
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
> 	remove unrelated change
> ---
>   system/physmem.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/system/physmem.c b/system/physmem.c
> index e3ebc19eef..3c82da1c86 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -3151,8 +3151,12 @@ void *address_space_map(AddressSpace *as,
>               *plen = 0;
>               return NULL;
>           }
> -        /* Avoid unbounded allocations */
> -        l = MIN(l, TARGET_PAGE_SIZE);
> +        /*
> +         * There is only one bounce buffer. The largest occuring value of
> +         * parameter sz of virtqueue_map_desc() must fit into the bounce
> +         * buffer.
> +         */
> +        l = MIN(l, 0x10000);

Please define this magic value. Maybe ANY_TARGET_PAGE_SIZE or
TARGETS_BIGGEST_PAGE_SIZE?

Then along:
   QEMU_BUILD_BUG_ON(TARGET_PAGE_SIZE <= TARGETS_BIGGEST_PAGE_SIZE);

>           bounce.buffer = qemu_memalign(TARGET_PAGE_SIZE, l);
>           bounce.addr = addr;
>           bounce.len = l;


