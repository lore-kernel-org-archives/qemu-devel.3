Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A33EBC67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 07:53:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru6HP-00005p-PD; Tue, 09 Apr 2024 03:52:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ru6HO-00004x-J8
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 03:52:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ru6HK-0005A7-4p
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 03:52:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712649145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=2+y3X8thPJB4HpzoLRJ/sur02/gFphdU7r5ldKyBVNE=;
 b=DyDv9okclL6hoMwsdJwYdIK93fvy38s6eB8urx5TNQ7HAx+3L9515wL/xgXYHiA8W7F/fB
 TPUGQlFWK8a4HBXnB85DpfWgzDILF3IhTWe63knUJLSrX8CXHZRcpefLKb7fJBQ/IeIgYN
 ODAF2yICw2A94M2egPTZhvUN/tH0Piw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-W5uzJypcOG2aVJz0PF1KLw-1; Tue, 09 Apr 2024 03:52:24 -0400
X-MC-Unique: W5uzJypcOG2aVJz0PF1KLw-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-345cc6c2367so886183f8f.0
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 00:52:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712649142; x=1713253942;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2+y3X8thPJB4HpzoLRJ/sur02/gFphdU7r5ldKyBVNE=;
 b=Zgp/j6DWkFgAztxWiW9AXkX3eFvLKYWez6wv0l+R/ccxOipj++VDDF4goaqQuHpHpg
 vCHPFNNiNZmUMEL8MW1FiFDkhyHhvtpWEmr5hL4cuy7rtfmODAPVn8NsOojYMmQd7MlI
 mynZ/IIykdFzfCdT0VgxiOBteCHbRP+vwZT4koR3PTSlFMWYw1LCEYBrR1U1xymYKSYO
 79cFrGrZ/nzfFCX/l9o52gzYvPH/1JrmHdaSm48BM7SRIwy/cKhmahf7V0pfEeyIh+uX
 4alEAYGA4RvUP+wsAAl9Zl69J6Bf3HD8TrmxWd9Lk5bC+aN7e9tn8DvqEB9eIYb/QPEz
 u1Pg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIlEXINonwnUaF3GMkq48ps6wfsldQGTf1YWSUWXxP4R0neztfrwqHm0GLSNcJxIl3N/4CCLwWQ0CgbOtcc5fwxOKdySk=
X-Gm-Message-State: AOJu0Yxe+wT7VmlXS/5DfndX291OStzZFyuFeNyLGRsVf0RCMOWJhf56
 Z/8vSxmhEZRHq9BNCU+aMyyNgfe/ZGZC0JAVO2qADdbErijpnioc5Q7PW2hetI2ivTJOrMXeSCz
 aad9Qby3yvnLpcnmpSIuaCj2oH+Ngoh2krv8EAA3wZp/5ptOVMIdTilGZAIQQ
X-Received: by 2002:a5d:6486:0:b0:343:7573:84d3 with SMTP id
 o6-20020a5d6486000000b00343757384d3mr1985736wri.5.1712649141932; 
 Tue, 09 Apr 2024 00:52:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwlxk3hMngunQ/YwsH5Jhe+/pRu4WXW70/FuFj8OtPukIe000KsJm55B2odTqSsXWZ1X1PcA==
X-Received: by 2002:a5d:6486:0:b0:343:7573:84d3 with SMTP id
 o6-20020a5d6486000000b00343757384d3mr1985722wri.5.1712649141582; 
 Tue, 09 Apr 2024 00:52:21 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.152.232])
 by smtp.googlemail.com with ESMTPSA id
 p13-20020a5d638d000000b00343ad4bca7dsm10773370wru.85.2024.04.09.00.52.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Apr 2024 00:52:21 -0700 (PDT)
Message-ID: <3884a15f-b00e-4805-b0df-0d30cbc48e48@redhat.com>
Date: Tue, 9 Apr 2024 09:52:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/28] target/i386: Convert do_fldt, do_fstt to
 X86Access
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240409050302.1523277-1-richard.henderson@linaro.org>
 <20240409050302.1523277-3-richard.henderson@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20240409050302.1523277-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.494,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 4/9/24 07:02, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/i386/tcg/fpu_helper.c | 44 +++++++++++++++++++++++++-----------
>   1 file changed, 31 insertions(+), 13 deletions(-)

Three incorrect GETPC()s that get fixed later in the series:

do_fsave:

> @@ -2459,15 +2465,18 @@ void helper_fldenv(CPUX86State *env, target_ulong ptr, int data32)
>   static void do_fsave(CPUX86State *env, target_ulong ptr, int data32,
>                        uintptr_t retaddr)
>   {
> +    X86Access ac;
>       floatx80 tmp;
>       int i;
>   
>       do_fstenv(env, ptr, data32, retaddr);
>   
>       ptr += (target_ulong)14 << data32;
> +    access_prepare(&ac, env, ptr, 80, MMU_DATA_STORE, GETPC());
> +

do_xsave_fpu:

> @@ -2506,6 +2518,7 @@ static void do_xsave_fpu(CPUX86State *env, target_ulong ptr, uintptr_t ra)
>   {
>       int fpus, fptag, i;
>       target_ulong addr;
> +    X86Access ac;
>   
>       fpus = (env->fpus & ~0x3800) | (env->fpstt & 0x7) << 11;
>       fptag = 0;
> @@ -2524,9 +2537,11 @@ static void do_xsave_fpu(CPUX86State *env, target_ulong ptr, uintptr_t ra)
>       cpu_stq_data_ra(env, ptr + XO(legacy.fpdp), 0, ra); /* edp+sel; rdp */
>   
>       addr = ptr + XO(legacy.fpregs);
> +    access_prepare(&ac, env, addr, 8 * 16, MMU_DATA_STORE, GETPC());
> +
>       for (i = 0; i < 8; i++) {
>           floatx80 tmp = ST(i);
> -        do_fstt(env, tmp, addr, ra);
> +        do_fstt(&ac, addr, tmp);
>           addr += 16;
>       }
>   }

do_xrstor_fpu:

> @@ -2699,6 +2714,7 @@ static void do_xrstor_fpu(CPUX86State *env, target_ulong ptr, uintptr_t ra)
>   {
>       int i, fpuc, fpus, fptag;
>       target_ulong addr;
> +    X86Access ac;
>   
>       fpuc = cpu_lduw_data_ra(env, ptr + XO(legacy.fcw), ra);
>       fpus = cpu_lduw_data_ra(env, ptr + XO(legacy.fsw), ra);
> @@ -2711,8 +2727,10 @@ static void do_xrstor_fpu(CPUX86State *env, target_ulong ptr, uintptr_t ra)
>       }
>   
>       addr = ptr + XO(legacy.fpregs);
> +    access_prepare(&ac, env, addr, 8 * 16, MMU_DATA_LOAD, GETPC());
> +
>       for (i = 0; i < 8; i++) {
> -        floatx80 tmp = do_fldt(env, addr, ra);
> +        floatx80 tmp = do_fldt(&ac, addr);
>           ST(i) = tmp;
>           addr += 16;
>       }



