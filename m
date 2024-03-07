Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DDEDC54798
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 13:40:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riDxG-0001YT-I9; Thu, 07 Mar 2024 08:38:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1riDvC-00019i-NF
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 08:36:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1riDvB-0001U0-BM
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 08:36:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709818588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=08IHYlGM1NCRDHLFDLs4wFdYbMZ+ma6wnNgKkJJFpVg=;
 b=Ka49HUmJOoFEJizDsRyn2Yv6DiEloS8TFeq/CGBKNoss3LGWrDc/+UDn+vI5b8budaNwvh
 AJWbPvGgJ/4tJV8w7NwqwQutQ6Kd69ueY7SN7/euXJOdPXCeT4BVpuz3gmh9Lj5G3xT4n5
 N8s68NFnyvEXW1suRLSSR1yFDQjBtsw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-Cv-qf98ROZW581KI1SaUlA-1; Thu, 07 Mar 2024 08:36:27 -0500
X-MC-Unique: Cv-qf98ROZW581KI1SaUlA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-412dd54cc17so5370655e9.1
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 05:36:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709818586; x=1710423386;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=08IHYlGM1NCRDHLFDLs4wFdYbMZ+ma6wnNgKkJJFpVg=;
 b=RGxeheRl+JT2cgvgThNisQnAi22vFFTyumSGbOWS+bKpEq27SFr2tf6ZtZmGTKr2/l
 7NvnesnQbmhyhID+loAZEGpJiXZODQwSdTLByJUgq7vYhV2rWKuEjwYmfTPh3YPdoaio
 uwrUDIjz4/U+Cl4kntCR/hleriC6shmhnXTD+5A5DKmzATGEJSb45vsFUqFklqS3KhBy
 uvdF/oqlX0pwCVzgaCuCOuqTQFaolyFexSAR7sgabU+w11CUkdQ9vV2skfloiNzvCeLg
 X4wKM8iwOGfcS2ObtjeB94INDud3/CPJVg7pxWa/MS7/HiXA8hVk1GVbwoAjVX02Ja0J
 xYoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLf0aPIEwP61R/pfk3AHM4Br0/qJ5wR+V8R/cibBpVRKf8y7U4iT8VLaobj9wnuj6w5e7JCXKAXKmld6y/03JeWvnD32g=
X-Gm-Message-State: AOJu0Yzdnzxxr91Sr6O1JsFuCD1otj6dt9IiVx1SYW43FtgiOjdreLT3
 srMJwksYhdQje1pPKrHuPi1uqyclM4nDW9t8FJYDFg/CpO5he2zy/ab7PTZpIbYUmb5aQG8Oxe0
 Kjo4DB9vhbIKYa0K4zdYCiPC+85ZsqhB6qK+Zgcu+mzapZe2PKP6X
X-Received: by 2002:a05:600c:5488:b0:412:d493:19a3 with SMTP id
 iv8-20020a05600c548800b00412d49319a3mr11380543wmb.12.1709818586262; 
 Thu, 07 Mar 2024 05:36:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE1XpeZqYiZT5yll5aqeeX7LeKBXM7S5RULvpCM7WSEC1OjbaKn5y++3hHHTrNuHGJZcfmEZw==
X-Received: by 2002:a05:600c:5488:b0:412:d493:19a3 with SMTP id
 iv8-20020a05600c548800b00412d49319a3mr11380535wmb.12.1709818586078; 
 Thu, 07 Mar 2024 05:36:26 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 fj5-20020a05600c0c8500b00412b56aa46bsm2727229wmb.13.2024.03.07.05.36.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Mar 2024 05:36:25 -0800 (PST)
Message-ID: <0a4ecd0f-721b-4c58-8300-911eaa888332@redhat.com>
Date: Thu, 7 Mar 2024 14:36:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 24/25] vfio: Also trace event failures in
 vfio_save_complete_precopy()
Content-Language: en-US, fr
To: Eric Auger <eauger@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>
References: <20240306133441.2351700-1-clg@redhat.com>
 <20240306133441.2351700-25-clg@redhat.com>
 <c7fec11d-284c-4134-95aa-d10cf7658f6d@redhat.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <c7fec11d-284c-4134-95aa-d10cf7658f6d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.583,
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

On 3/7/24 10:28, Eric Auger wrote:
> 
> 
> On 3/6/24 14:34, Cédric Le Goater wrote:
>> vfio_save_complete_precopy() currently returns before doing the trace
>> event. Change that.
>>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>   hw/vfio/migration.c | 3 ---
>>   1 file changed, 3 deletions(-)
>>
>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>> index bd48f2ee472a5230c2c84bff829dae1e217db33f..c8aeb43b4249ec76ded2542d62792e8c469d5f97 100644
>> --- a/hw/vfio/migration.c
>> +++ b/hw/vfio/migration.c
>> @@ -580,9 +580,6 @@ static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
>>   
>>       qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
>>       ret = qemu_file_get_error(f);
>> -    if (ret) {
>> -        return ret;
>> -    }
>>   
>>       trace_vfio_save_complete_precopy(vbasedev->name, ret);
> it is arguable if you want to trace if an error occured. If you want to
> unconditionally trace the function entry, want don't we put the trace at
> the beginning of the function?

But, then, the 'ret' value is not set and the trace event is less useful.
I'd rather keep it that way.

Thanks,

C.


