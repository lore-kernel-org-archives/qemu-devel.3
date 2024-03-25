Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB2F3C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 07:14:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1roeXc-00006B-BF; Mon, 25 Mar 2024 03:14:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1roeXa-00004x-14
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 03:14:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1roeXY-0007VH-Lz
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 03:14:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711350879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=y/WyKL/DD3rMxC3z0jZCyl/OPNw4765QdMokhQgyIbw=;
 b=QUz+Cl2eiNnQsMeAq67MopdXlppDL7vbwuOpd52OVhdtOtwjXAW4fE4jj1BB6gTasRQAo4
 FLLCev4ZLr2F3ZFTXP355V40B9MxBMAlU8FFgl8NqBsWBOSPInEZWQ+J7mKq9Y1SjJUIVH
 4BtW8RlT5i7gccYpZPqjG8mf0ozm8zk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-gsipoKD1MbWMzdLxJJe8ZQ-1; Mon, 25 Mar 2024 03:14:35 -0400
X-MC-Unique: gsipoKD1MbWMzdLxJJe8ZQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-40e4478a3afso20224285e9.1
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 00:14:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711350874; x=1711955674;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y/WyKL/DD3rMxC3z0jZCyl/OPNw4765QdMokhQgyIbw=;
 b=SVUp/yRTjtngua+LO3mYM0S7sY5jtvAVUpPg7cJK7ZS4jSjFdb4N0NnozYkqDklBuH
 bJrmfOzUDYvZCOLMVbrkVIxtMIc/AoC8FDteqZWOCsGW0iidGBHQzekQHhF/NxpJVrYk
 6A47I9TEzS4d7UaKByViMhWrE3LECylqNOsNiiFIWT46NFNtNDF1faRko+hUEKXWVCIj
 ZlTW61XZ7kNxOYzot2sw/i5U7XrkhbngMndgM1qc99mHhY5FCbJ44IbowIzPtgs6GezZ
 938sIzX+S8jzs5oSrGNvxxG0ifB1hxNTJ47K9VQRP6JYS2v/XAn/COPoF8stPA7mqHzN
 IzaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfm918X3sIcPkpe3meCSrkjrB6e5w1zZkzYdPt5uLrAz5InlgQ6iGSmfbUDYqN06Bp8UKdYVBBwngzbCkJuYxdfOnftsE=
X-Gm-Message-State: AOJu0YxJzv9yoMfQDdVL2Lda+n4jz+u0OjB+gRGk5Va/l1xPxV5SWmy3
 0tPW996nRTnoAIzpHlznBwqNUhF6qu0TapiP2mUid2uVHimF1P0z4W7L6v3al5rAqFjdRl3qn+s
 1wadWXtJSn6wnKgDlWV/Hwh8YjOcmGMX1spE3t9qHvGVG/cvpOqzN
X-Received: by 2002:a05:600c:3c8c:b0:414:61d9:d1f5 with SMTP id
 bg12-20020a05600c3c8c00b0041461d9d1f5mr4440755wmb.10.1711350874176; 
 Mon, 25 Mar 2024 00:14:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE15eTLCtUUHjNItQoppZTTpzJF9rc/KMJjpGogxucwN6XyNx8FIZlj60/lVrOD6JYWSlpFxA==
X-Received: by 2002:a05:600c:3c8c:b0:414:61d9:d1f5 with SMTP id
 bg12-20020a05600c3c8c00b0041461d9d1f5mr4440742wmb.10.1711350873877; 
 Mon, 25 Mar 2024 00:14:33 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-43-176-158.web.vodafone.de.
 [109.43.176.158]) by smtp.gmail.com with ESMTPSA id
 ck19-20020a5d5e93000000b00341c6440c36sm4461410wrb.74.2024.03.25.00.14.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Mar 2024 00:14:33 -0700 (PDT)
Message-ID: <d44cb28a-dce1-437d-8b5d-0966140211c4@redhat.com>
Date: Mon, 25 Mar 2024 08:14:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1] target/ppc: Unify TYPE_POWERPC_CPU definition for
 32/64-bit
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Nicholas Piggin
 <npiggin@gmail.com>, Anton Johansson <anjo@rev.ng>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>
References: <20240322183450.25284-1-philmd@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240322183450.25284-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On 22/03/2024 19.34, Philippe Mathieu-Daudé wrote:
> Apparently there is no wordsize special use with the QOM
> TYPE_POWERPC_CPU typename. Unify 32 and 64-bit with a single
> common definition.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/ppc/cpu-qom.h | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
> index 8247fa2336..ed75f1b690 100644
> --- a/target/ppc/cpu-qom.h
> +++ b/target/ppc/cpu-qom.h
> @@ -23,11 +23,7 @@
>   #include "exec/gdbstub.h"
>   #include "hw/core/cpu.h"
>   
> -#ifdef TARGET_PPC64
> -#define TYPE_POWERPC_CPU "powerpc64-cpu"
> -#else
>   #define TYPE_POWERPC_CPU "powerpc-cpu"
> -#endif

Have you tried a bunch of migrations with ppc machines from an older QEMU to 
a QEMU with this change and back, to make sure that there are no regressions?

  Thomas



