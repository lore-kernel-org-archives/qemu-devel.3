Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBE91C87FCF
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 13:54:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uk14V-0004YD-Sy; Thu, 07 Aug 2025 09:54:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uk14S-0004Tn-3X
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 09:54:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uk14P-0000h1-BJ
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 09:54:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754574852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Hk1cAPfnwD8uL1N9Q2z/2ZZehf8PtNf0DH4ZOV1vykk=;
 b=R10a0nfPaQhg5VMnC/rMMEz//ctdB+XsGKqivr2Jyn4p/m0wUP1gZ3tMpRO/oa3C08HYOW
 hK0BddhHKSVP+up+GYfGZmt5riqe8L/97AuUKQxmUEUJRTnUrFXwKW0e8e5M+iOJL/Cekr
 tkmooLE+TyIfr71uOIAmuweXievXsVs=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-Kf4-M3m-NzGkCbJC0M9ccA-1; Thu, 07 Aug 2025 09:54:10 -0400
X-MC-Unique: Kf4-M3m-NzGkCbJC0M9ccA-1
X-Mimecast-MFC-AGG-ID: Kf4-M3m-NzGkCbJC0M9ccA_1754574849
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-af9685f2243so172337066b.1
 for <qemu-devel@nongnu.org>; Thu, 07 Aug 2025 06:54:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754574849; x=1755179649;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Hk1cAPfnwD8uL1N9Q2z/2ZZehf8PtNf0DH4ZOV1vykk=;
 b=bwoEJ+QbL2XLpLOwBSCulPCuxUvWarOimzQEvjF1NBC89fUtUhTzRorTKXVnmsOHEL
 3fTMS11al6oGk4xNImMdZ9aDzCAM8CkuJVkPq3OaZ+FZDVztvf83hZe3eA9bZbIwGvyb
 91Q8lxrsFTKpJtLq2PrTNMCyi9cxAzDMk7rPtQAMdNIVaLWWBehVtrP5iEkHoFWSBXNd
 DS93WFhNnLISRaC9IvwaypuqtEHZRtHHFDm7KKgCgI5H75ryJWD5Lbq8NOkNQYAtSPkg
 ttKO7TbUUrbWMh0O/Xd+T8WT5Vbdw5UUBtSgmZs/YEgTBYTgVHyPWqpW49dS2FunM19T
 5gpg==
X-Gm-Message-State: AOJu0YwGGluhWa6S7IvD5f59No8W9V8s6RF+g/QfupV67kn1X5Do0zaN
 DsGDHzmuXPvk52x0W6a5dmQZBaATa7aGErPwzdjgH0Bh0Yz09AZTdtAIbzzDFYSMro/jYvcVGNh
 MBDN6nbIZhnVeXgru0F72Cc/nslQD1aoV3Rv2S5q+bX8NbtM5Y34LnPBo
X-Gm-Gg: ASbGnctn8BDm5D9WZIVUypopxGgUfaORhx0alfh1+s7hpimTELwPEw+nDXKkFQT4efj
 CQtNN2v5x0pdUWb/wFb1nVKyS29yxgdjYNhBKkdXhhKXLg4UFwNGA1zIvMhKZMNPoFOTsJIpq9G
 H1+T5HvJGWQfmqQEF9F56PnJ/CE7WASSZdiLIqRD+MjQyc9ze+m8X7bDWuRJbOzwjhsjT3nvPBN
 Wtjbqm9Pe4BLhRs0ajP3KBVe7YdaPETMnhPtH6iYacUMhLVp/Tr/PZTyjX5qKazoyxFP9ZiLufw
 wYaVVJddB2ikDpEVlSjnfHjI6jGENQm9LJyM7sKAukHY
X-Received: by 2002:a17:907:7f2a:b0:ae3:c777:6e5e with SMTP id
 a640c23a62f3a-af9a3db26b4mr375559566b.19.1754574849237; 
 Thu, 07 Aug 2025 06:54:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoeE1SfllRBerNk5R6caCvjcV8DdF0qXDvYu5qphmp4GO2tqoabVXJCz9rOpqaVKNJQHsWCQ==
X-Received: by 2002:a17:907:7f2a:b0:ae3:c777:6e5e with SMTP id
 a640c23a62f3a-af9a3db26b4mr375557566b.19.1754574848800; 
 Thu, 07 Aug 2025 06:54:08 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.253.173])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-af91a1e82fbsm1304386666b.88.2025.08.07.06.54.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Aug 2025 06:54:08 -0700 (PDT)
Message-ID: <262b5b35-e8f4-4bd7-8e7c-0d2acc2c9742@redhat.com>
Date: Thu, 7 Aug 2025 15:54:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 12/26] rcu: Make rcu_read_lock & rcu_read_unlock not inline
To: Zhao Liu <zhao1.liu@intel.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Junjie Mao <junjie.mao@hotmail.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Chuanxiao Dong <chuanxiao.dong@intel.com>
References: <20250807123027.2910950-1-zhao1.liu@intel.com>
 <20250807123027.2910950-13-zhao1.liu@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250807123027.2910950-13-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/7/25 14:30, Zhao Liu wrote:
> Make rcu_read_lock & rcu_read_unlock not inline, then bindgen could
> generate the bindings.
> 
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>

Either this, or keep it inline and add wrappers rust_rcu_read_lock() and 
rust_rcu_read_unlock().

Paolo

> ---
>   include/qemu/rcu.h | 45 ++-------------------------------------------
>   util/rcu.c         | 43 +++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 45 insertions(+), 43 deletions(-)
> 
> diff --git a/include/qemu/rcu.h b/include/qemu/rcu.h
> index 020dbe4d8b77..34d955204b81 100644
> --- a/include/qemu/rcu.h
> +++ b/include/qemu/rcu.h
> @@ -75,49 +75,8 @@ struct rcu_reader_data {
>   
>   QEMU_DECLARE_CO_TLS(struct rcu_reader_data, rcu_reader)
>   
> -static inline void rcu_read_lock(void)
> -{
> -    struct rcu_reader_data *p_rcu_reader = get_ptr_rcu_reader();
> -    unsigned ctr;
> -
> -    if (p_rcu_reader->depth++ > 0) {
> -        return;
> -    }
> -
> -    ctr = qatomic_read(&rcu_gp_ctr);
> -    qatomic_set(&p_rcu_reader->ctr, ctr);
> -
> -    /*
> -     * Read rcu_gp_ptr and write p_rcu_reader->ctr before reading
> -     * RCU-protected pointers.
> -     */
> -    smp_mb_placeholder();
> -}
> -
> -static inline void rcu_read_unlock(void)
> -{
> -    struct rcu_reader_data *p_rcu_reader = get_ptr_rcu_reader();
> -
> -    assert(p_rcu_reader->depth != 0);
> -    if (--p_rcu_reader->depth > 0) {
> -        return;
> -    }
> -
> -    /* Ensure that the critical section is seen to precede the
> -     * store to p_rcu_reader->ctr.  Together with the following
> -     * smp_mb_placeholder(), this ensures writes to p_rcu_reader->ctr
> -     * are sequentially consistent.
> -     */
> -    qatomic_store_release(&p_rcu_reader->ctr, 0);
> -
> -    /* Write p_rcu_reader->ctr before reading p_rcu_reader->waiting.  */
> -    smp_mb_placeholder();
> -    if (unlikely(qatomic_read(&p_rcu_reader->waiting))) {
> -        qatomic_set(&p_rcu_reader->waiting, false);
> -        qemu_event_set(&rcu_gp_event);
> -    }
> -}
> -
> +void rcu_read_lock(void);
> +void rcu_read_unlock(void);
>   void synchronize_rcu(void);
>   
>   /*
> diff --git a/util/rcu.c b/util/rcu.c
> index b703c86f15a3..2dfd82796e1e 100644
> --- a/util/rcu.c
> +++ b/util/rcu.c
> @@ -141,6 +141,49 @@ static void wait_for_readers(void)
>       QLIST_SWAP(&registry, &qsreaders, node);
>   }
>   
> +void rcu_read_lock(void)
> +{
> +    struct rcu_reader_data *p_rcu_reader = get_ptr_rcu_reader();
> +    unsigned ctr;
> +
> +    if (p_rcu_reader->depth++ > 0) {
> +        return;
> +    }
> +
> +    ctr = qatomic_read(&rcu_gp_ctr);
> +    qatomic_set(&p_rcu_reader->ctr, ctr);
> +
> +    /*
> +     * Read rcu_gp_ptr and write p_rcu_reader->ctr before reading
> +     * RCU-protected pointers.
> +     */
> +    smp_mb_placeholder();
> +}
> +
> +void rcu_read_unlock(void)
> +{
> +    struct rcu_reader_data *p_rcu_reader = get_ptr_rcu_reader();
> +
> +    assert(p_rcu_reader->depth != 0);
> +    if (--p_rcu_reader->depth > 0) {
> +        return;
> +    }
> +
> +    /* Ensure that the critical section is seen to precede the
> +     * store to p_rcu_reader->ctr.  Together with the following
> +     * smp_mb_placeholder(), this ensures writes to p_rcu_reader->ctr
> +     * are sequentially consistent.
> +     */
> +    qatomic_store_release(&p_rcu_reader->ctr, 0);
> +
> +    /* Write p_rcu_reader->ctr before reading p_rcu_reader->waiting.  */
> +    smp_mb_placeholder();
> +    if (unlikely(qatomic_read(&p_rcu_reader->waiting))) {
> +        qatomic_set(&p_rcu_reader->waiting, false);
> +        qemu_event_set(&rcu_gp_event);
> +    }
> +}
> +
>   void synchronize_rcu(void)
>   {
>       QEMU_LOCK_GUARD(&rcu_sync_lock);


