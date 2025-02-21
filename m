Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88ACBC021B3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 14:26:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlTyJ-0006IS-2G; Fri, 21 Feb 2025 09:25:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tlTy7-0006Hu-Lo
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 09:25:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tlTy6-0000I1-3W
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 09:25:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740147928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=vcaHqrRRq6tcYLUiQcJufhAfxjn15bqIY3uspjlXzIc=;
 b=c5xWJkoslM8Cz3/6e1EjLf1NTP7sKVeauuBZQ7hwjLbeQSeSi289ZSVuFGFb0DRu6Bgo6A
 uaPBPV2HcvRKrcJGkqh95XPBuLe0vbvIJBGvpgwqzwaYC1yHOKuD0n5BwFsG2HopYkimH0
 1AM9JxE6IzpiQ3fN9laaNxbpdh8Yxzs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-exmCFxotOgmWhsIoyPJAMw-1; Fri, 21 Feb 2025 09:25:25 -0500
X-MC-Unique: exmCFxotOgmWhsIoyPJAMw-1
X-Mimecast-MFC-AGG-ID: exmCFxotOgmWhsIoyPJAMw_1740147925
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-439a0e28cfaso11678485e9.2
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 06:25:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740147925; x=1740752725;
 h=content-transfer-encoding:in-reply-to:autocrypt:cc:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vcaHqrRRq6tcYLUiQcJufhAfxjn15bqIY3uspjlXzIc=;
 b=HYbr3qWC3ymq8JbN/rVqmPF2+8gtpDMn1gxJK/cKqAfYVKRVSIauKraMCTKYf+KXjh
 FeEh+cidwJCPbDYVgeXVQeTkUTxBmabi0K3nDqZzjeZ94qM20khzQ6oYuvB7xeizBc63
 6kPug6Dh1WGZh/2edJPZEr2WryV8vqZ9KAX3Os6uWxn+hkyyPSZQsR8TagsEYfmTQwGQ
 pNbJReGEWGs70i8MbwN3M5HypmmLaxPxmBGpA2DM3OuWaQd9adg9y4wpsg/8cJujciSW
 7fvnF3nOQSc98vr6QOkDrDkY0VAdR1zhGKIelmttPlK/sMWrBtV26f5KfEzgHApFrVhj
 yWIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWek8WoV2d5on2AyEUXYyMPaclJ8WCfzV3QgdnzT581cYA0glCIgSzuQFZBzdSkaypwf3tXkYYjTfKS@nongnu.org
X-Gm-Message-State: AOJu0YwKrs2jCacJI5Z3DrUC4IpjI5HekYVYXepnvDZIV63YwAYP6Ob4
 lyBUD0ECDglT4/VN6A7dcaztguc8pkSi+i5ZNLZVJC2Im75FqLwSO5SD7K+5q0SnBBmv8ryK9Zx
 /27+z4a37ze8lsAf/HC6s8bG/+6SBgSmv7fMPbZ3hXuhpyXNUKO5M
X-Gm-Gg: ASbGncsyBkrSvTHdB1E7t3pqOaxKx1DKX7DBcE4COIdjVbuUaF5YU5XfF56plA3bYcm
 NGl8otykC/GLx++mincdjPMQP52Y1iFijM17e4up8rEQNYKnXBR2lFhEEnvcb1IBe8znlnVxQWZ
 egTQbmCRqYGHr7DqjJ3ffju8+Sw7rdGFVTqItYQ6gKKaR3aXudN7XDvueLO1ifT0Z0p7nXXxw7X
 tWU9ny/icYLSUnHhFuV8hAUJUcBsNuElFWBV3cNAiPWOJH572147M8SHEZsTOo4kpnFEHpjl5Mr
 D4Z+0M6ToU966PohpAVJMVLHtWGL9TbsVai0ljqgZzIvkDE=
X-Received: by 2002:a05:600c:1c1b:b0:439:942c:c1cd with SMTP id
 5b1f17b1804b1-439ae1f1991mr29895675e9.15.1740147924747; 
 Fri, 21 Feb 2025 06:25:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGaKV9ADd7KA8gM4vs7ZHkhvAMEsnIexdQoOXC1Jl8v0MWv3X9P+k1tZsDPc4ciH+oTtKdXIA==
X-Received: by 2002:a05:600c:1c1b:b0:439:942c:c1cd with SMTP id
 5b1f17b1804b1-439ae1f1991mr29895455e9.15.1740147924344; 
 Fri, 21 Feb 2025 06:25:24 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-51-157.web.vodafone.de.
 [109.42.51.157]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b030bd9csm18788735e9.28.2025.02.21.06.25.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Feb 2025 06:25:23 -0800 (PST)
Message-ID: <12ff6477-7cd5-4ada-b7a8-97a3add814c3@redhat.com>
Date: Fri, 21 Feb 2025 15:25:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional: Bump some arm test timeouts
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20250221140640.786341-1-peter.maydell@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Cc: Radoslaw Biernacki <rad@semihalf.com>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250221140640.786341-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.424,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 21/02/2025 15.06, Peter Maydell wrote:
> On my local machine, for a debug build, sbsaref_alpine takes
> nearly 900s:
> 
> $ (cd build/x86 && ./pyvenv/bin/meson test --setup thorough --suite func-thorough func-aarch64-aarch64_sbsaref_alpine
> )
> 
> 1/1 qemu:func-thorough+func-aarch64-thorough+thorough / func-aarch64-aarch64_sbsaref_alpine
>                        OK 896.90s
> 
> arm_aspeed_rainier can also run close to its current timeout:
>   6/44 qemu:func-thorough+func-arm-thorough+thorough / func-arm-arm_aspeed_rainier
>                        OK 215.75s
> 
> and arm_aspeed_ast2500 and arm_aspeed_ast2600 can go over:
> 13/44 qemu:func-thorough+func-arm-thorough+thorough / func-arm-arm_aspeed_ast2600
>                        OK 792.94s
> 
> 27/44 qemu:func-thorough+func-arm-thorough+thorough / func-arm-arm_aspeed_ast2500
>                   TIMEOUT 480.01s
> 
> The sx1 test fails not on the overall meson timeout but on the
> 60 second timeout in some of the subtests.
> 
> Bump all these timeouts up a bit.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> This at least gets 'make -j4 check-functional' to passing for me
> for an arm/aarch64 debug build, apart from the gpu test hang which
> we're discussing in a different thread. Whole thing takes 25 mins...
> ---
>   tests/functional/meson.build     | 8 ++++----
>   tests/functional/test_arm_sx1.py | 6 +++---
>   2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
> index b516d21cba1..effa31701cf 100644
> --- a/tests/functional/meson.build
> +++ b/tests/functional/meson.build
> @@ -15,16 +15,16 @@ test_timeouts = {
>     'aarch64_raspi4' : 480,
>     'aarch64_rme_virt' : 1200,
>     'aarch64_rme_sbsaref' : 1200,
> -  'aarch64_sbsaref_alpine' : 720,
> +  'aarch64_sbsaref_alpine' : 1200,

I wonder whether we should disable that test with @skipSlowTest() by 
default, since it's really very slow...?

Anyway, for this patch here:
Reviewed-by: Thomas Huth <thuth@redhat.com>


