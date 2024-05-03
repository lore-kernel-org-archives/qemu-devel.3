Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B71CBC4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 14:04:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2tWg-00082B-IY; Fri, 03 May 2024 10:04:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s2tWe-00080f-JK
 for qemu-devel@nongnu.org; Fri, 03 May 2024 10:04:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s2tWc-0002rn-Ms
 for qemu-devel@nongnu.org; Fri, 03 May 2024 10:04:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714745073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tePEu0PuIEhNFx8obtsXhlF6CfDfIErPKrS8LLaqoz8=;
 b=Q9M5LAeENwvEs7FgjcsAWwpST5VlRxNUeuZgz6rTaSCkAgW6Dzq0yYKokij+JHzU61scCx
 xHohwp8ZeUmt18xREJxfYV+gfqf0tedpJYt5DWHpizYmlYiGUE7DpVmim1fjS7tDri7Jjm
 b9L/XGPTPqcaCYGAlRbdqldYJCMa+Mo=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-a5ucR5F8N9yAJaWcYivP9A-1; Fri, 03 May 2024 10:04:31 -0400
X-MC-Unique: a5ucR5F8N9yAJaWcYivP9A-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6a0ddfee0aaso54314126d6.2
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 07:04:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714745070; x=1715349870;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tePEu0PuIEhNFx8obtsXhlF6CfDfIErPKrS8LLaqoz8=;
 b=M38m016CE0Hm1xDKPcGC5GyynrnX1CHIBHADHOg3/hicLlSKVUgifNEXMqJ0q6H3+9
 FQ3iUj/rhU/M1yB7UvLwsXZW/wKVuz6iVxee9BmRr36/P9IJrpfgT6ZhIZw/U/Lw2kZR
 Lqt7kcWXgdcIku8SIqi42TdgF2zBtefFfbA2qtuxCF5NLFWhh3brbnk+yac7tGrA9W9x
 Pf0a7SHOrVqUlROBtXLWEtL/9364eVl+p9SJAIK0JxDNfxbmGuLg/JddVBz/6j1Ns0/M
 /SKeE3zVxkHLdi59jo99CZyF48/awk6/XS72AaVy4kikQIaPudt5B6Pq6s09nEsdzJB1
 U++Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW89rMKtLY+JSoVcP8y9a9ZVLtcpOoGjdY8FnmnA1RTm3cVCaA6DLvr28oDZZfnjAPIQ1KP8a2B89LMtHd+cLKzCVFuXFw=
X-Gm-Message-State: AOJu0Yy8/Et0Aw2iUMN4flGO3tE+X2UAGm80XTjHIZkFxGE8yQykq55w
 RF0/7NV6JFcjHavGnvpbE7EdPf3E+O737CC06GgeGKxtj47ZSdhKIK7NgPx1zdfNKxAtg9qe95C
 EeUTcHDoWxMVIqOSUdrH3lHcnxXB6ogwh/M1NTkTzkRQc57Qb1pDGP7CrFN+1
X-Received: by 2002:ad4:4ee3:0:b0:6a0:76fa:a323 with SMTP id
 dv3-20020ad44ee3000000b006a076faa323mr3191466qvb.4.1714745070009; 
 Fri, 03 May 2024 07:04:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2FoyIlbKFy0+x++gkMMpdd3+mjBWZq6iRxWygECzmT/IVPTFN913BxErEoq1WmkIT4qG43A==
X-Received: by 2002:ad4:4ee3:0:b0:6a0:76fa:a323 with SMTP id
 dv3-20020ad44ee3000000b006a076faa323mr3191433qvb.4.1714745069642; 
 Fri, 03 May 2024 07:04:29 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 y1-20020ad445a1000000b006a0f1d8f718sm1238087qvu.92.2024.05.03.07.04.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 May 2024 07:04:28 -0700 (PDT)
Message-ID: <c245b234-60d5-4ee6-a947-c7526d58698e@redhat.com>
Date: Fri, 3 May 2024 16:04:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/19] Add a host IOMMU device abstraction to check
 with vIOMMU
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com
References: <20240429065046.3688701-1-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240429065046.3688701-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.483,
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

On 4/29/24 08:50, Zhenzhong Duan wrote:
> Hi,
> 
> The most important change in this version is instroducing a common
> HostIOMMUDeviceCaps structure in HostIOMMUDevice and a new interface
> between vIOMMU and HostIOMMUDevice.
> 
> HostIOMMUDeviceClass::realize() is introduced to initialize
> HostIOMMUDeviceCaps and other fields of HostIOMMUDevice variants.
> 
> HostIOMMUDeviceClass::check_cap() is introduced to query host IOMMU
> device capabilities.
> 
> After the change, part2 is only 3 patches, so merge it with part1 to be
> a single prerequisite series, same for changelog. If anyone doesn't like
> that, I can split again.
> 
> The class tree is as below:
> 
>                                HostIOMMUDevice
>                                       | .caps
>                                       | .realize()
>                                       | .check_cap()
>                                       |
>              .-----------------------------------------------.
>              |                        |                      |
> HostIOMMUDeviceLegacyVFIO  {HostIOMMUDeviceLegacyVDPA}  HostIOMMUDeviceIOMMUFD
>              | .vdev                  | {.vdev}              | .iommufd
>                                                              | .devid
>                                                              | [.ioas_id]
>                                                              | [.attach_hwpt()]
>                                                              | [.detach_hwpt()]
>                                                              |
>                                            .----------------------.
>                                            |                      |
>                         HostIOMMUDeviceIOMMUFDVFIO  {HostIOMMUDeviceIOMMUFDVDPA}
>                                            | .vdev                | {.vdev}
> 
> * The attributes in [] will be implemented in nesting series.
> * The classes in {} will be implemented in future.
> * .vdev in different class points to different agent device,
> * i.e., for VFIO it points to VFIODevice.
> 
> PATCH1-4: Introduce HostIOMMUDevice and its sub classes
> PATCH5-11: Introduce HostIOMMUDeviceCaps, implement .realize() and .check_cap() handler
> PATCH12-16: Create HostIOMMUDevice instance and pass to vIOMMU
> PATCH17-19: Implement compatibility check between host IOMMU and vIOMMU(intel_iommu)
> 
> Qemu code can be found at:
> https://github.com/yiliu1765/qemu/tree/zhenzhong/iommufd_nesting_preq_v3
> 
> Besides the compatibility check in this series, in nesting series, this
> host IOMMU device is extended for much wider usage. For anyone interested
> on the nesting series, here is the link:
> https://github.com/yiliu1765/qemu/tree/zhenzhong/iommufd_nesting_rfcv2


v4 should be a good candidate, we will need feedback from the vIOMMU
maintainers though.

However, have you considered another/complementary approach which
would be to create an host IOMMU (iommufd) backend object and a vIOMMU
device object together for each vfio-pci device being plugged in the
machine ?

Something like,
     
     -device pcie-root-port,port=23,chassis=8,id=pci.8,bus=pcie.0 \
     -object iommufd,id=iommufd1 \
     -device intel-iommu,intremap=on,device-iotlb=on,caching-mode=on,iommufd=iommufd1 \
     -device vfio-pci,host=0000:08:10.0,bus=pci.1,iommufd=iommufd0

The vIOMMU device would be linked to the host IOMMU (iommufd) backend
object at realize time and it would simplify the discovery of the host
IOMMU properties. The implementation would be more straight forward.

That said, I didn't study deeply what needs to be done. The vIOMMU
implementation is not ready yet to support multiple instances and some
massaging is needed to change that first.

Thanks,

C.

       


