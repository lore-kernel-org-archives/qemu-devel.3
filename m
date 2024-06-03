Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81146C25B76
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 11:59:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE6Ko-000470-5X; Mon, 03 Jun 2024 07:58:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sE6Km-00042C-86
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 07:58:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sE6Kj-0007CD-Mb
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 07:58:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717415915;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Ws0Gp+r1CocCkjv8N95yPsdk59/lBeD0uDtTpAnaXT8=;
 b=JZ4RM21mYOxz8mLjxqFIVqOhE8yQfdggCIXmiiGquJ7LZMxJyYB42bpdXHxmHRmauJ+65a
 uCgHCTJl1ERF26eicMuvDWpBS9WeDwGnx/FyYk0pEelMdpvVks3Lz8MlaySzNqMQ9GjLF1
 lifoP2FZfHsgaCwc3RrCZYnI3Mk+EOw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-qzgeMMlCN5aJtL8YY7nbiA-1; Mon, 03 Jun 2024 07:58:34 -0400
X-MC-Unique: qzgeMMlCN5aJtL8YY7nbiA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4212aeac0e2so18855125e9.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 04:58:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717415913; x=1718020713;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ws0Gp+r1CocCkjv8N95yPsdk59/lBeD0uDtTpAnaXT8=;
 b=M5noO6bQfMyi2ktruJprf0nx677uJRM/+AKIsiWc+1al28yCKJd586wUVLKT7qgqML
 58ktLMRovlcgG1kvTcsW/0R2bucdHl+4XV6a/nl8lojVuTaeWj8Ud5BKWHGOSZXU4SQS
 J+p8TRUBhnrVIojMag4B3xNrRxfgStED63Dh01j68c2sKhFB2bIhbWbvoTgWQjHxot8j
 G+cMeaVELRJ4FHmVmvpZYbCjVNkTHqtOltuN68Qb4C9+TVhef+Evrztn0yP4i7ie6W+V
 103OiUIMbqVq7SU41iq8zgphMmsJsqfN6225CXIGSpSda041N+6ie9pQUtclJb9yrpdz
 X3dA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2MzWv+Wi0NhQ6QEb7GfxZ/FvaEQxVX4R9gSoIPbx+5/l8xGuGpGeXDiD3c8qEqJ9bQqwL+5VpVP9pwrgOR421o8hCVqs=
X-Gm-Message-State: AOJu0YwP/FSoqVAYzwzyKs2elZy8Va3LOv+khZfv/LIONrQKP/VrtqVg
 SV0xfV7gU0d1uyATRWnG3ycLZJ2kQKIU1yThHfxK7ioSmj/0Z1o31ZERlS6Y9Bmxm0eqlicLsnE
 3XXbVQX6VV2rgVJzxLHr7h/ljDXVp2D4RecWIalssJNvSBvx53VLT
X-Received: by 2002:a05:600c:46cb:b0:418:d3f4:677b with SMTP id
 5b1f17b1804b1-4212ddbc867mr89738925e9.17.1717415913374; 
 Mon, 03 Jun 2024 04:58:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDTtEK84Aj/NOJX9R+tiizPmLOrwMSJGdaY2WHy+nygradOmZ9rnOEm81/BI/GF4f///0JHw==
X-Received: by 2002:a05:600c:46cb:b0:418:d3f4:677b with SMTP id
 5b1f17b1804b1-4212ddbc867mr89738785e9.17.1717415912985; 
 Mon, 03 Jun 2024 04:58:32 -0700 (PDT)
Received: from [192.168.0.4] (ip-109-43-176-229.web.vodafone.de.
 [109.43.176.229]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4212b84be78sm115544745e9.17.2024.06.03.04.58.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 04:58:32 -0700 (PDT)
Message-ID: <d97f465d-a75f-492d-8d96-ecee574cbfa1@redhat.com>
Date: Mon, 3 Jun 2024 13:58:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: fix xsave.flat from kvm-unit-tests
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20240603100405.619418-1-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240603100405.619418-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 03/06/2024 12.04, Paolo Bonzini wrote:
> xsave.flat checks that "executing the XSETBV instruction causes a general-
> protection fault (#GP) if ECX = 0 and EAX[2:1] has the value 10b".  QEMU allows
> that option, so the test fails.  Add the condition.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 892544317fe ("target/i386: implement XSAVE and XRSTOR of AVX registers", 2022-10-18)
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/tcg/fpu_helper.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
> index e322293371c..e1b850f3fc2 100644
> --- a/target/i386/tcg/fpu_helper.c
> +++ b/target/i386/tcg/fpu_helper.c
> @@ -3142,6 +3142,11 @@ void helper_xsetbv(CPUX86State *env, uint32_t ecx, uint64_t mask)
>           goto do_gpf;
>       }
>   
> +    /* SSE can be disabled, but only if AVX is disabled too.  */
> +    if ((mask & (XSTATE_SSE_MASK | XSTATE_YMM_MASK)) == XSTATE_YMM_MASK) {
> +        goto do_gpf;
> +    }

That fixes the kvm-unit-test, indeed! Thanks!

Tested-by: Thomas Huth <thuth@redhat.com>


