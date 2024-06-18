Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3725C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 11:46:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJXHv-00053K-At; Tue, 18 Jun 2024 07:46:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sJXHr-00052u-FI
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 07:46:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sJXHn-0002zM-Mv
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 07:46:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718711162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rKtRmevcUcXccckp7YSABqnmhA5/+P4gAgYuj17MY40=;
 b=YgGHY4EQOmOtexx7rymsYp9J/aK3HBj/gieBaoonmHSgI+Qj09c0RmJN5RKIFBUKd0llyF
 CCjcSEtrifxKpFcx0m795EVsPI01ZmHEkY7+6sd6eqQBu7TjGsEdAWzjZfqF2AtFed/2SW
 TJdcUuLwu80/KpK0sXnjgoH4967ZQAU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-JOFSa_M2Mrytu0Q9BlY4ig-1; Tue, 18 Jun 2024 07:46:00 -0400
X-MC-Unique: JOFSa_M2Mrytu0Q9BlY4ig-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42120e123beso48127425e9.0
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 04:46:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718711160; x=1719315960;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rKtRmevcUcXccckp7YSABqnmhA5/+P4gAgYuj17MY40=;
 b=jXUQNlvhYzI1wKihf7WU/dq+gNtmlQiw799zneSaFWk0nkj7/bvE5AuYkEKgSmUgO7
 JgjIenZtHRJtKKg5x6REmlYMoV/299RIm0JRqHyFx7BP/ZbObb8bbc20Mv2041ydll51
 E026pWuApw6RXJIx03mjWPTn5hRup0fNSyHHf6cRJ8wezf2R9aB8KjtqmQpg8rab5R8O
 GW1GRmME0YNSF9gy+9DrzK+VrNf85rpYIcr6PZiW+OJtpAgOl0bKSQaSyiU1L7b04pl0
 bK2ffxGaDK9Br3HjLdmdUT4qFE7iPd772I+r4pr9xHDimoIr1d9zq3liUczkvA2XncbH
 fHNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZO9babivyKqweEkeYRI6vFtessUMQbizUYAjwu0e3wM5KlqZ2IsVFSIcwtZKKKU4t3m43mDh64qGBvPkl1B3nPv7Vqrs=
X-Gm-Message-State: AOJu0YwTivOXk9NFBCiVb6KggX9awAIBUX8TULIiFTqFnWiWqD5FNg0k
 QY8sWPuGqyOtMptpPhtTeVQ9RGTfHZGvJgJGpTxZnhAOurEYueTwKAZ/+MZVsppDuMy74uCLWmC
 d5B3ipQuPv45gCulB4aMiOrW6kKDh6bmlrcAj5mE8mRViJJsYDwAk
X-Received: by 2002:a05:600c:3b06:b0:422:1705:7549 with SMTP id
 5b1f17b1804b1-42304844acamr116103495e9.25.1718711159872; 
 Tue, 18 Jun 2024 04:45:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFndg0C6ud5RdS6VmKDuaUWCZJ92Pit3G40O9C4jBt2J9YF2lX4pVB3gSbxDWF2+wHf63j2ig==
X-Received: by 2002:a05:600c:3b06:b0:422:1705:7549 with SMTP id
 5b1f17b1804b1-42304844acamr116103365e9.25.1718711159509; 
 Tue, 18 Jun 2024 04:45:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422f602e7e3sm187023525e9.12.2024.06.18.04.45.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jun 2024 04:45:59 -0700 (PDT)
Message-ID: <caa5e52b-f9a9-4e7e-94aa-7d3207fb9273@redhat.com>
Date: Tue, 18 Jun 2024 13:45:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/17] vfio: QOMify VFIOContainer
To: eric.auger@redhat.com, qemu-devel@nongnu.org
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20240617063409.34393-1-clg@redhat.com>
 <f419417d-2346-4cfa-a7e4-068946d4bafc@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <f419417d-2346-4cfa-a7e4-068946d4bafc@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
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

On 6/17/24 6:22 PM, Eric Auger wrote:
> Hi Cédric,
> 
> On 6/17/24 08:33, Cédric Le Goater wrote:
>> Hello,
>>
>> The series starts with simple changes (patch 1-4). Two of which were
>> initially sent by Joao in a series adding VFIO migration support with
>> vIOMMU [1].
>>
>> The changes following prepare VFIOContainer for QOMification, switch
>> the container models to QOM when ready and add some final cleanups.
>>
>> Applies on top of :
>>
>>   * [v7] Add a host IOMMU device abstraction to check with vIOMMU
>>     https://lore.kernel.org/all/20240605083043.317831-1-zhenzhong.duan@intel.com
>>   * [v4] VIRTIO-IOMMU/VFIO: Fix host iommu geometry
>>     https://lore.kernel.org/all/20240614095402.904691-1-eric.auger@redhat.com
> 
> For the whole series, feel free to add my
> 
> Tested-by: Eric Auger <eric.auger@redhat.com>
> 
> I tested with legacy/iommufd BE and with/without virtio-iommu

Thanks !

Here is an updated version, with the new commit logs :

   https://github.com/legoater/qemu/commits/vfio-9.1

I hope to push on vfio-next soon, without the series "vfio: VFIO
migration support with vIOMMU".

C.


