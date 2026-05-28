Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75F64CD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 08:42:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSWJ0-00056f-1y; Thu, 28 May 2026 04:41:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wSWIy-00056K-MY
 for qemu-devel@nongnu.org; Thu, 28 May 2026 04:41:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wSWIw-0006R9-OH
 for qemu-devel@nongnu.org; Thu, 28 May 2026 04:41:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779957685;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G/23fwhqV8WXgPI1wN0ormXP3YWePW2QiVTBvod5lQY=;
 b=Xd0ZCpBWFa+nCsgfjloRvpaguyx4cySY6rPiHHW/nYVqPclRsLI0ShKisUojyoPPEW/rPO
 DTq37B3Jgj0gEFk7jmp7L+macBNmv1uAhN1JHzVGJ6es/QOI6P1SQtcEo2pDDaKr8RAgQl
 Psnen1XdNrPHI7ISuMmuAWNlSngzh8A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-jCi4Y3uRPHewNO19ofD61w-1; Thu, 28 May 2026 04:41:23 -0400
X-MC-Unique: jCi4Y3uRPHewNO19ofD61w-1
X-Mimecast-MFC-AGG-ID: jCi4Y3uRPHewNO19ofD61w_1779957682
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4904ee02e72so46357295e9.1
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 01:41:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779957682; x=1780562482;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G/23fwhqV8WXgPI1wN0ormXP3YWePW2QiVTBvod5lQY=;
 b=a+cU9BYHL/DU2Gd8Pm1i6FRdl5vUA1bxYAGYCiDe/DP6imEakHOzbY/esAu02xQeiF
 zS+D2uL4bZ8PEXW+9JvpPUM1VvvgT9+X1lLGMa6soZhNogJb3iwYCCfYIrY4SvvjdhxK
 2LuQsqoTmcamnVqm9Zc0Nm3raux3eploT+1wasFu6E/YPkcSJa58zxVqTrTgM0V9mNEG
 JlpbrysAT+n32NirJWTmaB9vaF+9SglASFoZTtSQJvgee1hh7i2J6Ihs8tiWAsFeiXG0
 0l7Cfb5nu5JGkJrIGEs/cw2VE0G/kSL9OanJqBTaEfe2Ih/e0npK15ZiQ77Qwk+XEMX4
 7cqA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+smHsSISGv6yP0/8YD/iY877RC73oSD2S3pNvGhh7+VOhDcusBODigygAMYyLdCVJkutJriozuqE8c@nongnu.org
X-Gm-Message-State: AOJu0YzwTPa36kp4nHkr6sDy3Eml4QXCB1HfXsXE4jnFZ6qniQUCHD4C
 00vRjdW05FnGmWwmsbsG5gZSodHp8O1qdBKVmDUBtzZA9vx9aJQq+vINA/mZN7kEyOXDVPAO/aB
 XdHIjr4UquH6gbAJ39kX9bd4TmdezIktXGcTi70O41gW6N85oCrfHERX7
X-Gm-Gg: Acq92OFHUDbRuAqtJBZH8iXxI1xYZ8zP5UzwCWi0DOAgt8/uIQyH5fHniJ/mU5DFfz5
 rtOB+F8Eg22+qOngLHN0RHWE4GZJP8kktwnC2XLYwSRNLXQ5fQb1IwtPX5iYxAfFPD6mJro6ew0
 IVjM0NoVh5McNQ3F05t0baho7upp36c6qO+wAKIMSFzcvzDoL+jOazjnSp9fN8rtOormhTYp4J+
 4z6GG7kqnEzh2Bo6ZWnurw90Z0aNFgIdnHOwOHjMnaRZhfPtHpKs31Pcn6SfPHe93QKDeMyna6f
 Fy6ywCTBRCprAFnGNXVOzJuKPmfH3BNbXqkG72sTZ+rjO6bYoHWr1NoBKT1pJw8ifVkLY6piXWj
 saG/9Au+UCEsuEv9X126gP02sCC6BJ76XT1A/L5x4gN623D3YKgwKDk8ryvirQWeOLn9kI6UbIO
 mjo/lJ
X-Received: by 2002:a05:600c:4ecc:b0:48e:5fb8:f80f with SMTP id
 5b1f17b1804b1-490426d1ea7mr420821825e9.24.1779957682336; 
 Thu, 28 May 2026 01:41:22 -0700 (PDT)
X-Received: by 2002:a05:600c:4ecc:b0:48e:5fb8:f80f with SMTP id
 5b1f17b1804b1-490426d1ea7mr420821415e9.24.1779957681908; 
 Thu, 28 May 2026 01:41:21 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4908dcf850fsm15796915e9.4.2026.05.28.01.41.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 01:41:21 -0700 (PDT)
Message-ID: <5a0afcaa-3fa2-498c-86a9-32480619e973@redhat.com>
Date: Thu, 28 May 2026 10:41:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/9] hw/arm/smmuv3: Improve accel SMMUv3 usage
 documentation
Content-Language: en-US
To: Nathan Chen <nathanc@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>
References: <20260527221631.612026-1-nathanc@nvidia.com>
 <20260527221631.612026-3-nathanc@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260527221631.612026-3-nathanc@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 5/28/26 12:16 AM, Nathan Chen wrote:
> From: Nathan Chen <nathanc@nvidia.com>
>
> Add a statement to clarify that the host SMMUv3 must support HW-accelerated
> vfio-pci device assignment when setting accel=on.
>
> Suggested-by: Eric Auger <eric.auger@redhat.com>
Hum did I suggest that ;-)
> Signed-off-by: Nathan Chen <nathanc@nvidia.com>
> ---
>  hw/arm/smmuv3.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 0c65dc8c91..a8c49a48ac 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -2165,7 +2165,9 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
>  
>      object_class_property_set_description(klass, "accel",
>          "Enable SMMUv3 accelerator support. Allows host SMMUv3 to be "
> -        "configured in nested mode for vfio-pci dev assignment");
> +        "configured in nested mode for vfio-pci dev assignment. Please "
> +        "ensure the host SMMUv3 supports hardware-accelerated VFIO-PCI "
> +        "device assignment before enabling.");
this is a rather abstract statement. What is the actual host
requirement, dual translation stage support?

Thanks

Eric
>      object_class_property_set_description(klass, "ril",
>          "Disable range invalidation support (for accel=on). ril=auto "
>          "is not supported.");


