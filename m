Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CFB9CDE025
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2024 16:53:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1strjf-0002lE-DO; Thu, 26 Sep 2024 12:52:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1strje-0002kh-9s
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 12:52:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1strjb-00025S-VL
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 12:52:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727369574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=zj9vLyVeTUrkXFtErPVwTTDYQdcUkLzh1lKD/qYC/0s=;
 b=hQzBWxDAM+ijApamYX6ry0V8Xb0ip8Oo5+29JS8KNxOBvaqXmW9uCXlljuw3DZLYZ0Gp+L
 yGsSG5O5r3JmYYCLG9S9iVoFnAjs/h6SqA2rTQHkztnxPr1bLCGsI6luemuGS+SuA8OCO7
 b/ElfYEks8RMsp9q4aq4JB4aCs5/WZk=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-m_xddXU1N5SfW4EpFUiE_g-1; Thu, 26 Sep 2024 12:52:52 -0400
X-MC-Unique: m_xddXU1N5SfW4EpFUiE_g-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7a7fa073718so222396885a.3
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2024 09:52:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727369572; x=1727974372;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zj9vLyVeTUrkXFtErPVwTTDYQdcUkLzh1lKD/qYC/0s=;
 b=eleYtmYtdVPNTLIiM+DRR86id+bYo+Djug9r4WbEP3ZZl4lN3GTa4qZzMQnEW9JxrV
 JtsEOpF7jADSP+/H+QrtpP2MIfVru1IyQ5FrQdK47e8hl98faUbdFXsVfRYkCDwplvYZ
 6f7XzdRiX1N0ufFFapKxBhs+k841PcjpAwaJHhxmIvBZ/ImDl1ZjN5gNBnSP8N+XM+aV
 6g0j9LG24KemIA9HUlBWb5o4AvsyHyfeuNJyaoYuEyG4PQItHKP+mZ7mYUV5P40wPZqr
 wC9hjJ7Nx0V/aftB4km3bvXY0+FWrHh8p0cmPCBQD2woIbVk3T+X3wyyxTnVATU4T1Ob
 zEqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPKpq8wGlDoyvsFRy+54OHQLTepEI8IYPF2faBXEFna+jSMAmk+fW2Rl9QWUsxBeKC2dV+DP/8w/A0@nongnu.org
X-Gm-Message-State: AOJu0YyZedvarRENwXU3QECSpztZeim2K6C4mQgVbPIGuCrEQecY8Ghw
 DC57wIECDDJO/09TaH5CQzQwV1+j0frUfyt3YUjrjVeAkwDCsEaGOUIm3lUPkM6ZiyGjxl7Vr2k
 CA5TiVzBQU+ks3yEV0LuCdCQh4DPILgpQEsEddsJsASVdARbL12Rt
X-Received: by 2002:a05:620a:4305:b0:7ab:3511:4eda with SMTP id
 af79cd13be357-7ae37859606mr28692585a.34.1727369572045; 
 Thu, 26 Sep 2024 09:52:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEc18+Y15wl3KbfQPxhfJugWm0iv4GLJ2pqlzsLF1lv3cavBK20N0dqbclFhcsiP8FYcVCfA==
X-Received: by 2002:a05:620a:4305:b0:7ab:3511:4eda with SMTP id
 af79cd13be357-7ae37859606mr28688285a.34.1727369571647; 
 Thu, 26 Sep 2024 09:52:51 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7ae3782c5f1sm6537285a.74.2024.09.26.09.52.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Sep 2024 09:52:51 -0700 (PDT)
Message-ID: <104676c7-9732-4972-b00e-8f65ce9eb259@redhat.com>
Date: Thu, 26 Sep 2024 18:52:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/1] Introduce vfio-cxl to support CXL type-2 device
 passthrough
To: Zhi Wang <zhiw@nvidia.com>, kvm@vger.kernel.org, linux-cxl@vger.kernel.org
Cc: alex.williamson@redhat.com, kevin.tian@intel.com, jgg@nvidia.com,
 alison.schofield@intel.com, dan.j.williams@intel.com, dave.jiang@intel.com,
 dave@stgolabs.net, jonathan.cameron@huawei.com, ira.weiny@intel.com,
 vishal.l.verma@intel.com, alucerop@amd.com, qemu-devel@nongnu.org,
 acurrid@nvidia.com, cjia@nvidia.com, smitra@nvidia.com, ankita@nvidia.com,
 aniketa@nvidia.com, kwankhede@nvidia.com, targupta@nvidia.com,
 zhiwang@kernel.org
References: <20240921071440.1915876-1-zhiw@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20240921071440.1915876-1-zhiw@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hello Zhi,

On 9/21/24 09:14, Zhi Wang wrote:
> Compute Express Link (CXL) is an open standard interconnect built upon
> industrial PCI layers to enhance the performance and efficiency of data
> centers by enabling high-speed, low-latency communication between CPUs
> and various types of devices such as accelerators, memory.
> 
> Although CXL is built upon the PCI layers, passing a CXL type-2 device can
> be different than PCI devices according to CXL specification. Thus,
> addtional changes on are required.
> 
> vfio-cxl is introduced to support the CXL type-2 device passthrough.
> This is the QEMU VFIOStub draft changes to support it.
> 
> More details (patches, repos, kernel config) all what you need to test
> and hack around, plus a demo video shows the kernel/QEMU command line
> can be found at:
> https://lore.kernel.org/kvm/20240920223446.1908673-7-zhiw@nvidia.com/T/


I have started looking at the software stack and the QEMU trees
are quite old. Could you please rebase the branches on the latest ?

Also, I think having a single branch per project would be easier.

For linux :
   [v2] cxl: add Type2 device support
   [RFC] vfio: introduce vfio-cxl to support CXL type-2
   [RFC] samples: introduce QEMU CXL accel driver

Same for QEMU.

Thanks,

C.



> 
> Zhi Wang (1):
>    vfio: support CXL device in VFIO stub
> 
>   hw/vfio/common.c              |   3 +
>   hw/vfio/pci.c                 | 134 ++++++++++++++++++++++++++++++++++
>   hw/vfio/pci.h                 |  10 +++
>   include/hw/pci/pci.h          |   2 +
>   include/hw/vfio/vfio-common.h |   1 +
>   linux-headers/linux/vfio.h    |  14 ++++
>   6 files changed, 164 insertions(+)
> 


