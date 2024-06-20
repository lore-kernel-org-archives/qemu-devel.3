Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EECEDC41513
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 12:33:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKGxc-0007le-OQ; Thu, 20 Jun 2024 08:32:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sKGxa-0007lO-9C
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 08:32:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sKGxY-0000vZ-1W
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 08:32:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718886729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z4NxfBZzk8F84z87xpVj4yfGTNAeBnyjJsQZegEKfyM=;
 b=ea8uCernvc9np5WelhWIM3MuIswLEiBwM093+Bs/vejzzdHyiUOqcvtpbIq+6F4lYdSnKX
 yJL0cC+hC3aa9r6PIF3SZTAyM7mRpSPSsIbtFajYLHWehaZUsa/sGY21k0FFqdEAxYXVSZ
 pQIs0yoSBZDsC6v/jNBtfcp7HI7Xf2I=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-6UcixFPLMuCjqOMkkzBbyg-1; Thu, 20 Jun 2024 08:32:05 -0400
X-MC-Unique: 6UcixFPLMuCjqOMkkzBbyg-1
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-3d2296b144aso711934b6e.1
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 05:32:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718886725; x=1719491525;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z4NxfBZzk8F84z87xpVj4yfGTNAeBnyjJsQZegEKfyM=;
 b=TanjfAlKXbNWYAmM9TrdsxL6DwLzuQ5YoDa0LV7GwgoZzV/lmp9Ksfk5q2dd1q4qkb
 tQFCpHkgMtm2XYPzsxbPK4uS1rgJElKa5u5srCUyN086lpr9MRAI9HNPNhoArNP6oy19
 /e37SN350DTSgUI/WmMsqHVwc+Jpl3Al0Eipha+h/5WJHWw1CbkdKAJA2CEW8F6WUvPK
 BNciWDd6UEJg8Gb+hoCWZNni3t2TxI4O9OYA6/tZNdGfo9NBvw92lsTNHpiQt4Jw8ZOM
 Hsgq0YSf+1i1TiRsfYNXDFxTOx1QF/S3FKstSlYXTASvKA7ZonoE+QqJYfG6bDNc9qMk
 WfHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdr5YIPbKePabJa7gaztTr1wDQsFRr50VDZcWQhzV9lngYRZuH9uOYo2LOQMZ4gbOJPyRHo+fDXU2u9rurpDu4Vk7dUFQ=
X-Gm-Message-State: AOJu0YwVF1hvmccobjmk3DvdxOaRZ0N4xfPYlHLl+wAyeL950WqDwRZF
 A7DvU3T1XdfLOKQ2nQnPALkn7ESycIQ+IyZJcLnB8t9jiJMkGaVG+7QRZmy4NvblKdMS+I0TEhJ
 bkns/zFaaH40+TYCa9SevGdz4f8bQJx/aVCGfVEUX+6faPPFwEgC1
X-Received: by 2002:a05:6808:1923:b0:3d2:21a5:d3bd with SMTP id
 5614622812f47-3d51badd2abmr5902489b6e.52.1718886724680; 
 Thu, 20 Jun 2024 05:32:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdXfpD1OcDLfbWs4+ENDkf1ma4WOEz5l+7JRMYNONLeCPOEL52r4Wgno9reGRZYPSKAtn3Yg==
X-Received: by 2002:a05:6808:1923:b0:3d2:21a5:d3bd with SMTP id
 5614622812f47-3d51badd2abmr5902428b6e.52.1718886723971; 
 Thu, 20 Jun 2024 05:32:03 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-441f310dcd8sm74195121cf.93.2024.06.20.05.32.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Jun 2024 05:32:03 -0700 (PDT)
Message-ID: <157f2b6d-5899-41eb-9171-2deabae7108f@redhat.com>
Date: Thu, 20 Jun 2024 14:31:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/15] vfio: VFIO migration support with vIOMMU
To: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Avihai Horon <avihaih@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
 Maciej Szmigiero <maciej.szmigiero@oracle.com>
References: <20230622214845.3980-1-joao.m.martins@oracle.com>
 <088a0db6-ae69-4d85-a817-1685d4053d17@redhat.com>
 <8ca65f18-5a0d-4176-9bc1-f318d4ba4db5@oracle.com>
 <d6ef8a37-9337-433e-a0bf-ce50af20a734@redhat.com>
 <d97cd2cc-5cc4-46c1-bbe5-8ab6e97b1bca@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <d97cd2cc-5cc4-46c1-bbe5-8ab6e97b1bca@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
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

[ ... ]

>> * [v4] vfio: VFIO migration support with vIOMMU
>>   
>> https://lore.kernel.org/qemu-devel/20230622214845.3980-1-joao.m.martins@oracle.com/
>>      Refreshed the patchset on upstream and pushed on vfio-9.1 branch.
> 
> /me nods Probably deserves an item on the list too related to this subject of
> vIOMMU and migration after the vIOMMU series is done:
> 
> *
> https://lore.kernel.org/qemu-devel/20230908120521.50903-1-joao.m.martins@oracle.com/
> 
>>    * [RFCv2] vfio/iommufd: IOMMUFD Dirty Tracking
>>   
>> https://lore.kernel.org/qemu-devel/20240212135643.5858-1-joao.m.martins@oracle.com/
>>
> I plan on still submitting a follow-up targetting 9.1 likely next week with
> Avihai's comments on top of the vfio-9.1 branch after I sent some dirty tracking
> fixes in kernel side. Though it is mostly to progress review as I think I am
> still dependent on Zhenzhong prep series for merging because of this patch:
> https://lore.kernel.org/all/20240605083043.317831-8-zhenzhong.duan@intel.com/

This is ready to be pushed.

As soon as I get an ack, a nod, a smoke sign, from the PCI maintainers
regarding the new PCIIOMMUOps callbacks I will send a PR for:

   https://lore.kernel.org/all/20240522170107.289532-1-clg@redhat.com
   https://lore.kernel.org/all/20240605083043.317831-1-zhenzhong.duan@intel.com
   https://lore.kernel.org/all/20240614095402.904691-1-eric.auger@redhat.com
   https://lore.kernel.org/all/20240617063409.34393-1-clg@redhat.com

Thanks,

C.





