Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6491AC8302F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 06:38:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWUcn-0004DZ-8X; Tue, 01 Jul 2025 02:37:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uWUcl-0004DE-RX
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 02:37:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uWUcj-0002z6-RR
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 02:37:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751351864;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O51oDbqfS2jqoQ5u4E+MxQBihcdy7V3KWEU8aewRTWU=;
 b=DpMtYN3FJsH7r6YUT0+/9Fpu8i1PlGk3vXEu3eUZDscTW2P3I5q/my+8xlM0DoOsA2U4aI
 Bu7L2q7qzn6x6m9kXWXYw1wb9M+bk0Q00wR7L01Du2wzEMVvdLBdYhBhfL/UEqvqU5THI8
 4oYGKzOJeo3uUwg8fvGFEYioqskLOYo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-Z_RErHUAPgSWbNOoaY0cSQ-1; Tue, 01 Jul 2025 02:37:43 -0400
X-MC-Unique: Z_RErHUAPgSWbNOoaY0cSQ-1
X-Mimecast-MFC-AGG-ID: Z_RErHUAPgSWbNOoaY0cSQ_1751351862
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a58939191eso978851f8f.0
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 23:37:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751351862; x=1751956662;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O51oDbqfS2jqoQ5u4E+MxQBihcdy7V3KWEU8aewRTWU=;
 b=e06Nce38AXrAO6s49sEc4d0d3KJFzepJNkgf4JZaT4Z4TR+YM3ucoP5UvYTCzhNA00
 DdWKhx201zbDQPL2tKjQ1sYe9I/28ha6Rch+YvQrt+5XQzH6BaHIiCTHiwxrfYtGF9sc
 +8n7vfLmo5OiWgQY/HgfB2cTSC3OAD/jvmOKU6JaDr+0TjwmCpmnlCf/bGg4cGKtIiWW
 kPfynHQf/Wps602P2e6s5QZ3L/S0VaJrNnDH7W69mJqDZkRBBOgRhTq+M9fcTjxBZ9pW
 TFVU6MKVCu30Z9xr4Ql1FHtNa8MATKORJJAOv3ESpOwpXnMwPw842BbPQICk/VGtNTGq
 2u5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU++psC4IuZkcgqnC15m//7AfFYlqGcgO5yDdy3In1W5PSzlncYyIqaGX9LyNWAZVMRMrXqZQNTcFve@nongnu.org
X-Gm-Message-State: AOJu0YyOfXQUeLMx9dhO65UFLCQsxeE0DOv2ZbJINZhB/bbq9NLRWCNb
 dapCQw6J6ptHBoL3clxWyk9PNLTJ0o/pBjcY7CFPhI9jy0EKLLjiLSLEWavlIn5YgjnCEqQzWC6
 3NkfZ5eDdUCVVrC0y0GwNMPVCHDQzzh38KV3qm+H/kqlnnCYGzXhwhdCk
X-Gm-Gg: ASbGnctWYTcFkfzLa8/uWerIqVcx/ueVIG/JjHqooOKQ3zvdoUXkRvpqNn4ISEym1Vp
 LCMkp85zEe3SI+ozOdkRDdRlLXj4yovoU76pP1o0CfruR6v8CAPJtZLT9mgnIwd8DVhbcYZsWkE
 fN9ITpf79gjwq+xi+sqNorOO5VYxbkLJ+BNtSDDGBnvuZlwbeOBM6jnUMvzDxYRAJU5+X20v7Bg
 lUj6OxXWNjAdCVTL+/vPTeI4GsY06WYWIV2YyFYG2ZZLrF1BjbA62Hp25HfhhtpaAMmkapzDARQ
 ClSlY0lSez4e7J9WtI+WQokEl0fK9J+36Q+lWBdtnrapdzO2E+BgR8yYONC/3sjjNarwBQ==
X-Received: by 2002:a05:6000:5c4:b0:3a5:3b93:be4b with SMTP id
 ffacd0b85a97d-3a8f54a0395mr14783506f8f.25.1751351862113; 
 Mon, 30 Jun 2025 23:37:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUiXBewsxlIK18Cs+vcz7E+YolU8WqEU6E3Dil2tudCVXB4Mzk8p6zVYi2Pg0UymM5ZrLg0g==
X-Received: by 2002:a05:6000:5c4:b0:3a5:3b93:be4b with SMTP id
 ffacd0b85a97d-3a8f54a0395mr14783476f8f.25.1751351861658; 
 Mon, 30 Jun 2025 23:37:41 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453823ad01csm186755725e9.22.2025.06.30.23.37.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Jun 2025 23:37:40 -0700 (PDT)
Message-ID: <ca81f749-8eda-4f33-87be-61c74f44d861@redhat.com>
Date: Tue, 1 Jul 2025 08:37:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/11] hw/arm/virt: Add support for user creatable
 SMMUv3 device
Content-Language: en-US
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "nathanc@nvidia.com" <nathanc@nvidia.com>,
 "mochs@nvidia.com" <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>,
 "gustavo.romero@linaro.org" <gustavo.romero@linaro.org>,
 Linuxarm <linuxarm@huawei.com>, "Wangzhou (B)" <wangzhou1@hisilicon.com>,
 jiangkunkun <jiangkunkun@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
References: <20250623094230.76084-1-shameerali.kolothum.thodi@huawei.com>
 <7a878419-d709-4da7-8b06-2c36a2b05287@redhat.com>
 <942853c1cd54409480fa4136e45e7db8@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <942853c1cd54409480fa4136e45e7db8@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 6/30/25 9:12 AM, Shameerali Kolothum Thodi wrote:
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Sent: Friday, June 27, 2025 1:37 PM
>> To: Shameerali Kolothum Thodi
>> <shameerali.kolothum.thodi@huawei.com>; qemu-arm@nongnu.org;
>> qemu-devel@nongnu.org
>> Cc: peter.maydell@linaro.org; jgg@nvidia.com; nicolinc@nvidia.com;
>> ddutile@redhat.com; berrange@redhat.com; imammedo@redhat.com;
>> nathanc@nvidia.com; mochs@nvidia.com; smostafa@google.com;
>> gustavo.romero@linaro.org; Linuxarm <linuxarm@huawei.com>; Wangzhou
>> (B) <wangzhou1@hisilicon.com>; jiangkunkun <jiangkunkun@huawei.com>;
>> Jonathan Cameron <jonathan.cameron@huawei.com>;
>> zhangfei.gao@linaro.org
>> Subject: Re: [PATCH v5 00/11] hw/arm/virt: Add support for user creatable
>> SMMUv3 device
>>
>> Hi Shameer,
>>
>> On 6/23/25 11:42 AM, Shameer Kolothum wrote:
>>> Hi All,
>>>
>>> Changes from v4:
>>> https://lore.kernel.org/qemu-devel/20250613144449.60156-1-
>> shameerali.kolothum.thodi@huawei.com/
>>> Major changes from v4:
>> this will need a respin after merge of
>> f5ec751ee70d  hw/arm/virt: Check bypass iommu is not set for iommu-map
>> DT property
you may have seen Gustavo's series
[PATCH-for-10.1 v6 0/9] hw/arm: GIC 'its=off' ACPI table fixes
has been applied to target-arm.next. You shall rebase on top of it and
unfortunately it should conflict with some part of your series

Eric
> Yes. Missed that. Will do.
>
> Thanks,
> Shameer
>


