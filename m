Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3973CA0FED
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Sep 2025 10:37:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuToP-0000yF-Uj; Fri, 05 Sep 2025 06:36:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uuToO-0000xr-An
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 06:36:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uuToG-0003fT-Fj
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 06:36:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757068604;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jgzRI4M8YzzXymautfHy1slGXby83FcFw/MBRmwhcvk=;
 b=b+c4CG/nSk3wunypAyxwvYi6wwVCJ5x2pE7PC8Q21dacK3nBEF53PFleefYHIRsYapOuHC
 H9/n2fPLdpkX5UwI0E1bR5uB2ehIMbCkJnwuaaDi1qIvZ6P5r0GS4ystKoBqokaAbRFa0H
 J2MyKZcGKc5CiRbIqgJMLjCNlKIFUew=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-SGBQi7fNP4GumNXkFigCEw-1; Fri, 05 Sep 2025 06:36:43 -0400
X-MC-Unique: SGBQi7fNP4GumNXkFigCEw-1
X-Mimecast-MFC-AGG-ID: SGBQi7fNP4GumNXkFigCEw_1757068602
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-45dcf5f1239so8084935e9.2
 for <qemu-devel@nongnu.org>; Fri, 05 Sep 2025 03:36:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757068602; x=1757673402;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jgzRI4M8YzzXymautfHy1slGXby83FcFw/MBRmwhcvk=;
 b=Yf8wRHv4NZ4/FafOtV0aH0z8jKThrZZLTkCWWuDq42rwhMiiovig8kQCCgK4eN+0Il
 nJvea9uC4bE7HRIRiK+KDbzXaKZ2KELtpJnVOd1ANpS1O8p1M/PyxLYOjptoiCWak1u0
 p77gSW+xxHPvBO5R5VMBtKNbctby+36r19qSoPiS0muxnPRfOPIz54O/6SnmmPBZgy3T
 1DdWZjMThzT7kSMKt40yywDkWKJHHkGUNeRCL2rqa2s0bn3wtLkjvcxFXVmqREhPk/9o
 EJqGfS3lYaikHddvR1yyBhB5DLY9ZxXX03j8xuc0ht1P6cMSGqvcDUhCkYJwWjmqt0od
 o9WQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiiUHFMmpkf4uW5cZjsop1GgQwI+HL9mzlemIoVue0nEBzfU9VwlXYM0kw/zP/PmIC5bO8a3mx48p3@nongnu.org
X-Gm-Message-State: AOJu0YyOUht+AHyzRwosZySWm8T3Gx2PGHvzjNwn/Wq/RRqa82iinG9/
 udSgRDLEhTDeJHIJtB1CJ8M+76a3aFr/A/MxESRuOxb2RqB1m7IK4llmSrftZmGUEZKmxbEX6q2
 banEVOxzFrmkapM/2BuaO4pJGITS4lNTfmGnW4DClSye+OkXI7k4cuhu1
X-Gm-Gg: ASbGncs/THZR5arZWZdzPlb9v4q1S0fDtRyJEHEsGW5m8yH4/k1qMNW9Y03JckCgArq
 1ZoqSwfoN4/9kf2VHbULcDe1b9CMFNpIbSpLjWP9eecJ0kHrdf+8KEylAPwUDpsbt67AJOZ5vEs
 kNiVhqvhUnlL79Cj2gcfowPXxQmz+XCrBvqPORpb4nvOTBB0nY+cBS5NR5sA7R/TDyps86A/naU
 rApn9vJ68/SlQCae6cv6tpRU3njCJkG5NHct+ovtiyZbKOuxl3hSXa/DupvSl9TPSlugP1Py1P6
 9f0EwmgKBE02K5BZNRL128FjWa83sKoQUsv5KAEAQ7BW0+IP3OYKXzM6HUmKt6LGhwb5BRjVEX7
 DRXr/WZT6m8I=
X-Received: by 2002:a05:600c:524f:b0:45b:8453:d7e with SMTP id
 5b1f17b1804b1-45b85526a68mr203942585e9.6.1757068602270; 
 Fri, 05 Sep 2025 03:36:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYacQgGtLUHklmXAMKA9NtrY78SLmncEs54gilRcHMhxwZ+BDRjutRJXGFHlG/bIz/lRw3xQ==
X-Received: by 2002:a05:600c:524f:b0:45b:8453:d7e with SMTP id
 5b1f17b1804b1-45b85526a68mr203942385e9.6.1757068601883; 
 Fri, 05 Sep 2025 03:36:41 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3dc1cd4a7d2sm11196918f8f.33.2025.09.05.03.36.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Sep 2025 03:36:40 -0700 (PDT)
Message-ID: <28332ba8-976b-4bae-8ea7-7843b410a450@redhat.com>
Date: Fri, 5 Sep 2025 12:36:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 15/15] hw/arm/smmu-common: Add accel property for
 SMMU dev
Content-Language: en-US
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Shameer Kolothum <skolothumtho@nvidia.com>
Cc: peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, linuxarm@huawei.com,
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org,
 zhenzhong.duan@intel.com, shameerkolothum@gmail.com
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
 <20250714155941.22176-16-shameerali.kolothum.thodi@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250714155941.22176-16-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Shameer,

On 7/14/25 5:59 PM, Shameer Kolothum wrote:
> Now user can set "accel=on". Have fun!
>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  hw/arm/smmu-common.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> index 6a58f574d3..3e8783670a 100644
> --- a/hw/arm/smmu-common.c
> +++ b/hw/arm/smmu-common.c
> @@ -1022,6 +1022,7 @@ static const Property smmu_dev_properties[] = {
>      DEFINE_PROP_BOOL("smmu_per_bus", SMMUState, smmu_per_bus, false),
>      DEFINE_PROP_LINK("primary-bus", SMMUState, primary_bus,
>                       TYPE_PCI_BUS, PCIBus *),
> +    DEFINE_PROP_BOOL("accel", SMMUState, accel, false),
would be nice to add some documentation as done in
4526687bf126 ("vfio: Add property documentation")

Eric
>  };
>  
>  static void smmu_base_class_init(ObjectClass *klass, const void *data)


