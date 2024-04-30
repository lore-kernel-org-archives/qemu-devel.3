Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 532A1C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 12:01:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1mAL-0005KB-Pn; Tue, 30 Apr 2024 08:00:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s1mA4-0005CT-Q7
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 08:00:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s1mA2-0005A3-Am
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 08:00:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714478437;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xxn5vd70PoDihUywOAfN2UG3vJf75Kt+J44ZVfm6OMY=;
 b=HuY8Z9bXGJhcEK/c0Hr5bk3aC81YGzl/aLAfEwr9+M796Qm4CiOjAE8W1dxggJXr/dYmcy
 eILPxQrEoRTOdIqreqc6OZhdATLPzC7nzDKoR+TItrdmLEhevjTiszw9LvTMn32E/5iSAq
 Al35brsYI6NTqKA19kHXnr5Ik2nyp6k=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-Mnjha6KpM96WzTUAAH5iWw-1; Tue, 30 Apr 2024 08:00:35 -0400
X-MC-Unique: Mnjha6KpM96WzTUAAH5iWw-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6a0dedea1d0so7760656d6.3
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 05:00:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714478435; x=1715083235;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xxn5vd70PoDihUywOAfN2UG3vJf75Kt+J44ZVfm6OMY=;
 b=i9NysoItf8X7ej5brIepLtEyc+0oZC4fYSFA+lGpGKYu5yz71uZAkbiwx4OliOiprB
 KAPf9JATFDlRs84rJL30PzA3hS06A8BC55WV1XYb6Vjkze24KA0googrT4DWdU7MdipN
 85vwZKmXMVrXLVaBVTbBipcCunbT15SvGdFkxoK8YOtVX6lbkPywVXYnJH825yJG7s9z
 6Iy/UP1eDiegTDaOEscVaDjmlF5L+Znf8/cX/705YDijMV2uiSuE7I8yvuAmL7izpN4y
 gfNObfvJxYhRVRl7VZgBG2uhNTPWxnr38wiDnv5CRTn7jVm851d8W95fIgZ3XnSCXO5o
 xPuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVitG+udu1df5LgwvhKrwHL3bcZ35rcwhUz1K7VNfZhq2FqwwDYmjnE44iuhYsoGP6vzhLlDGKoC0iWe9mL6kHoILoZSEc=
X-Gm-Message-State: AOJu0Yz8QNyLCzKmxoaAuTratKg9izdjKQZnqJ2Vb/2rderl/UXPrIaP
 0150qiMH98jLUKNyN6kRZKlR5OKfx09hTKth+HVyA00EwxM9igDAe0yPLlEyPMPYfmuPqSEBfLb
 +tL314JijcHC1ljGj2nQ2rO9uu4hnOG/EgeJXvKGSeywxqkqtxfjv
X-Received: by 2002:a05:620a:24c6:b0:790:f573:3fce with SMTP id
 m6-20020a05620a24c600b00790f5733fcemr3030167qkn.4.1714478434905; 
 Tue, 30 Apr 2024 05:00:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPDl+2WIlBL7BLgvLV1mz8MvuEX3ZWDwGV/+TOmups/zbggNCquFf+CldiFkZws6N16SEGoA==
X-Received: by 2002:a05:620a:24c6:b0:790:f573:3fce with SMTP id
 m6-20020a05620a24c600b00790f5733fcemr3030129qkn.4.1714478434487; 
 Tue, 30 Apr 2024 05:00:34 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 vr2-20020a05620a55a200b00790a2e12dc8sm4543966qkn.116.2024.04.30.05.00.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Apr 2024 05:00:33 -0700 (PDT)
Message-ID: <c0620278-f8b9-478d-bd24-b23fba42e0bf@redhat.com>
Date: Tue, 30 Apr 2024 14:00:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/19] vfio/container: Introduce
 HostIOMMUDeviceLegacyVFIO device
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>
References: <20240429065046.3688701-1-zhenzhong.duan@intel.com>
 <20240429065046.3688701-3-zhenzhong.duan@intel.com>
 <5160adfc-9630-49f0-a2a4-f6987c819bc5@redhat.com>
 <SJ0PR11MB6744D20165F8D9F8383CA115921A2@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <SJ0PR11MB6744D20165F8D9F8383CA115921A2@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
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

On 4/30/24 11:13, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Cédric Le Goater <clg@redhat.com>
>> Subject: Re: [PATCH v3 02/19] vfio/container: Introduce
>> HostIOMMUDeviceLegacyVFIO device
>>
>> On 4/29/24 08:50, Zhenzhong Duan wrote:
>>> HostIOMMUDeviceLegacyVFIO represents a host IOMMU device under
>> VFIO
>>> legacy container backend.
>>>
>>> It includes a link to VFIODevice.
>>
>> I don't see any use of this attribute. May be introduce later when needed.
> 
> Indeed, will remove.
> 
> Then 'struct HostIOMMUDeviceLegacyVFIO' is same as
> struct HostIOMMUDevice.
> 
> Not clear if it's preferred to remove 'struct HostIOMMUDeviceLegacyVFIO'
> and use HostIOMMUDevice instead. Something like:
> 
> OBJECT_DECLARE_SIMPLE_TYPE(HostIOMMUDevice,
>                                              HOST_IOMMU_DEVICE_LEGACY_VFIO)

I would. The simpler the better.

Thanks,

C.


