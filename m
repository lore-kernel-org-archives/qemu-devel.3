Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12182C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 09:25:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmVj2-0001Om-Qo; Tue, 19 Mar 2024 05:25:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rmVj1-0001ON-1T
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 05:25:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rmViz-0005Mt-Kj
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 05:25:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710840337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=I9qupZUBKSESwdPmUrykmiCwbYxNnSgb6TP821+LROk=;
 b=FMumFfNC8uKjJ/FzgjaHtNRmWmug441jUfbfYjoOjNxpmWsaK1CVt92a6TbOMqDe8tcdKf
 psmmOTs3MgupOY02HCvVrrpu+Tb4Hs9E9+5IL+NZ1je63a+7HDtLzSDiSTzm7gGlOyZrrJ
 OR6hZrpiHfoaAuRjYrcj5qYe2rYZxM8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-wH3qteuZOBOuyXSpX433-g-1; Tue, 19 Mar 2024 05:25:35 -0400
X-MC-Unique: wH3qteuZOBOuyXSpX433-g-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-41463be093aso3100785e9.3
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 02:25:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710840334; x=1711445134;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
 :references:cc:to:content-language:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I9qupZUBKSESwdPmUrykmiCwbYxNnSgb6TP821+LROk=;
 b=DLqT/JrSAkcmSf6QOlDjtxMf7MMO58Id9vUh+kjwq39UUIlmQRWMe/Eqe0wRJwk9xX
 dSzxdLH7T9CuKAj8RRr5Qg6A3/VMXdmB2VIg9UMmTGUgnSUz+eNq/o4pLtn5IOrfsFYU
 MuA2hbAY06ic/ZOf2lYNemw4W1JbDGUGmK7T/rCciSfifZ3qZcYfsx6jT3M3avdcUGog
 rAanHVlAh2bUcXw7cLJp49xRp1wTlk+lBJKYrxD9mNJN1poDlSdNxMh376RRzmivTdrh
 KFFxkxj1+n5bTmrl0yymyPnsha92PoPE/hNZvXJbBXSgUHVrd7KSrDBQk/zqVnIeWIKt
 L6YA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNF5LdnnHQvfcAh5DqexLLY7GK8OX39GWDW2H+Kg2ogELuh53g0deYwaUgiSbbvZp/2N0BGNpzO+6gKkP7LhZE6yKApbQ=
X-Gm-Message-State: AOJu0YzzYDEfcBWq+8IT21mYZ9xNjySUpPfEuUpyyBF7u2ZMy6KMUDqT
 CEmkpo4xmlRcTtEPEXxBNBPLHvYTdrpAw2Nda9cyvW9gr2fCO749RDeoGURXDEl68XGwOoZ91XJ
 OmkBHfvb+4e47zsAA9UvIlYcIQXQnONC8Dsu3Z6wIcSs2EspELYfA
X-Received: by 2002:a05:600c:1c15:b0:414:c64:f3d0 with SMTP id
 j21-20020a05600c1c1500b004140c64f3d0mr4356403wms.27.1710840333994; 
 Tue, 19 Mar 2024 02:25:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG59GmfknbX+5BtUcsMDulCtGkU+zSgpFKALDtpbj6wiCKkPFr+XJkbcODfvTxAHPFbJW6mPw==
X-Received: by 2002:a05:600c:1c15:b0:414:c64:f3d0 with SMTP id
 j21-20020a05600c1c1500b004140c64f3d0mr4356384wms.27.1710840333592; 
 Tue, 19 Mar 2024 02:25:33 -0700 (PDT)
Received: from ?IPV6:2003:cb:c741:2200:2adc:9a8d:ae91:2e9f?
 (p200300cbc74122002adc9a8dae912e9f.dip0.t-ipconnect.de.
 [2003:cb:c741:2200:2adc:9a8d:ae91:2e9f])
 by smtp.gmail.com with ESMTPSA id
 t14-20020a05600c450e00b0041409db0349sm9396242wmo.48.2024.03.19.02.25.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Mar 2024 02:25:33 -0700 (PDT)
Message-ID: <5a997b02-207b-4d8d-b9e1-8c85ae468cfb@redhat.com>
Date: Tue, 19 Mar 2024 10:25:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOetlOWkjTogW1BBVENIIHYxIDIvMl0gc3lzdGVtL2NwdXM6IEZp?=
 =?UTF-8?Q?x_resume=5Fall=5Fvcpus=28=29_under_vCPU_hotplug_condition?=
Content-Language: en-US
To: zhukeqian <zhukeqian1@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, Igor Mammedov
 <imammedo@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: "Wanghaibin (D)" <wanghaibin.wang@huawei.com>,
 yuzenghui <yuzenghui@huawei.com>, jiangkunkun <jiangkunkun@huawei.com>,
 Salil Mehta <salil.mehta@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "Zengtao (B)" <prime.zeng@hisilicon.com>
References: <20240317083704.23244-1-zhukeqian1@huawei.com>
 <20240317083704.23244-3-zhukeqian1@huawei.com>
 <57c8506e-3f6a-4d1d-9720-c9b030781109@redhat.com>
 <60ed0bd01fc346088f48bcce1c92a6d3@huawei.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <60ed0bd01fc346088f48bcce1c92a6d3@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
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

On 19.03.24 06:11, zhukeqian wrote:
> Hi David,
> 
> On 17.03.24 09:37, Keqian Zhu via wrote:
>>> For vCPU being hotplugged, qemu_init_vcpu() is called. In this
>>> function, we set vcpu state as stopped, and then wait vcpu thread to
>>> be created.
>>>
>>> As the vcpu state is stopped, it will inform us it has been created
>>> and then wait on halt_cond. After we has realized vcpu object, we will
>>> resume the vcpu thread.
>>>
>>> However, during we wait vcpu thread to be created, the bql is
>>> unlocked, and other thread is allowed to call resume_all_vcpus(),
>>> which will resume the un-realized vcpu.
>>>
>>> This fixes the issue by filter out un-realized vcpu during
>>> resume_all_vcpus().
>>
>> Similar question: is there a reproducer?
>>
>> How could we currently hotplug a VCPU, and while it is being created, see pause_all_vcpus()/resume_all_vcpus() getting claled.
>>
> I described the reason for this at patch 1.
> 
>> If I am not getting this wrong, there seems to be some other mechanism missing that makes sure that this cannot happen. Dropping the BQL half-way through creating a VCPU might be the problem.
>>
> When we add retry mechanism in pause_all_vcpus(), we can solve this problem. With the sematic unchanged for user, which means:
> With bql, we can make sure all vcpus are paused after pause_all_vcpus() finish,  and all vcpus are resumed after resume_all_vcpus() finish.

Okay, got it. As just replied to #1, please see if you can avoid messing 
with pause_all_vcpus() by inhibiting KVM IOCTLs like KVM does. That 
would be preferable.

-- 
Cheers,

David / dhildenb


