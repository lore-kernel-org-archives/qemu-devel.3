Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B77A4C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 10:03:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVpsg-00071b-RZ; Mon, 22 Jul 2024 06:02:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sVpsf-00070h-LT
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 06:02:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sVpsd-0007Od-OW
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 06:02:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721642573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5hJQ20vythFUPSae0Wxi9xbi9th8wwjBMXsSPdHQNTM=;
 b=gHg5pR7LqXlFDvm/k8WbI4Th9w+V+q47P7lAiIMfVGWzLCQJSP2ylplYpGIYIZ/gy9N42I
 PgEXQYQkfu4IVtpfdtIiXKYrV124G1w1OhQK+qU35hhx+sZbyXzoh84O0cq8HvO+Mclwdq
 R/yMORv76kqkVMltPnAPjerKEnfJKN8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-2s4s0dwOPBycl_Fn-09FjQ-1; Mon, 22 Jul 2024 06:02:51 -0400
X-MC-Unique: 2s4s0dwOPBycl_Fn-09FjQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3687529b63fso2360372f8f.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 03:02:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721642570; x=1722247370;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5hJQ20vythFUPSae0Wxi9xbi9th8wwjBMXsSPdHQNTM=;
 b=hCg4Rh7SbpXVPSszYwWUo1Y1g/HzKA7kXSsEVWJGFLnSScIeUsMWm1rIMk6cFO2oZi
 /vxpAGYJH2GAXoMZiGNecK+wtkLZfhUF0fvD29GsTcp3sBOoHHcGqNNJGVq1mwilLWrl
 zypTaOVZQqJfzXvUVvKKfq5KuoemFc0VWXwkaTfRGXI/e6v80nr42dftmZc9KZog7r0q
 s7ASBF0DDvlDTKqcXMehpwgu4cInlLeyMQ94fytbMIOVvWImxTQVKyzv2feAWdpbfBz7
 5aRkFzy8wq4mSYhtcbcFcyfhdZuRP7eN04Y7W9N/ZVKbWSq0VJKxr5ti4ycP3hw38Asf
 jC7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXFzh0/3W188nyNFOQ//dO2AO8M/nIpBaZO5/SXzdMnlVU5JuLRehvXnYnMLiie5Qz7hG6SjCGzLcCm85Bp5KhByj85a4=
X-Gm-Message-State: AOJu0YxHg3UBziTbSyxSauYKd/WzIIn+jTcJHCavaPZMzI9UhLzzGhUL
 jqp0gVn8YtCmoBkIf/5rf4mZAUUIOwCTe0uSUr/V2g1UjKUg/DW9j+9sIhKzkbVdCwMCyJevaY+
 YaevNwIrBgzdPoBqYCMhdjo/9nWiY/B5I94L1v0b/nY6Uw5mTKgNW
X-Received: by 2002:a05:600c:1f87:b0:426:64a2:5362 with SMTP id
 5b1f17b1804b1-427dc51a0e6mr44009685e9.8.1721642570456; 
 Mon, 22 Jul 2024 03:02:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXWho6cIom+GZsUZWu6720V75KNcPEQQMQ4ESb7urc0jE1zbYFq3FvoerMUEaGkKtEFcuEfQ==
X-Received: by 2002:a05:600c:1f87:b0:426:64a2:5362 with SMTP id
 5b1f17b1804b1-427dc51a0e6mr44009465e9.8.1721642570067; 
 Mon, 22 Jul 2024 03:02:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:bed7:42c6:fb19:d12e?
 ([2a01:e0a:9e2:9000:bed7:42c6:fb19:d12e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d68fa09bsm123112575e9.7.2024.07.22.03.02.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 03:02:49 -0700 (PDT)
Message-ID: <4c9a184b-514c-4276-95ca-9ed86623b9a4@redhat.com>
Date: Mon, 22 Jul 2024 12:02:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Don't initialize HOST_IOMMU_DEVICE with mdev
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com,
 joao.m.martins@oracle.com, chao.p.peng@intel.com
References: <20240722070713.1342711-1-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240722070713.1342711-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On 7/22/24 09:07, Zhenzhong Duan wrote:
> This fixes a potential issue with mdev that fails to initialize HOST_IOMMU_DEVICE.
> Reason is mdev isn't physical device and doesn't support IOMMU_GET_HW_INFO.
> 
> I thought ap/ccw are all mdev type and need a fix.
> 
> This series depends on a patch from Joao which fixes the same for vfio-pci.
> See https://lists.gnu.org/archive/html/qemu-devel/2024-07/msg04612.html
> 
> Not tested due to no ap/ccw environment. But build test pass.
> 
> Thanks
> Zhenzhong
> 
> Zhenzhong Duan (2):
>    vfio/ap: Don't initialize HOST_IOMMU_DEVICE with mdev
>    vfio/ccw: Don't initialize HOST_IOMMU_DEVICE with mdev
> 
>   hw/vfio/ap.c  | 3 +++
>   hw/vfio/ccw.c | 3 +++
>   2 files changed, 6 insertions(+)
> 

I have queued this series and the first 2 patches of "[v5] hw/vfio: IOMMUFD
Dirty Tracking" :

   https://lore.kernel.org/all/20240719120501.81279-1-joao.m.martins@oracle.com/

I am trying to estimate now if the above could be fully merge for 9.1.

Thanks,

C.


