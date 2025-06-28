Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBF7BC7EE32
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Jun 2025 08:45:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uVRBJ-0006yo-DB; Sat, 28 Jun 2025 04:45:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uVRBE-0006xe-U8
 for qemu-devel@nongnu.org; Sat, 28 Jun 2025 04:45:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uVRBD-0008E5-Bt
 for qemu-devel@nongnu.org; Sat, 28 Jun 2025 04:45:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751100297;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=zGaOA3EoKe56V6PTNIDNCgS+XJLqau081bRvVeq8J/s=;
 b=QXxWu19A5cQM6UWc3uofUFUH053RxbDgmVGHUj94DNfOz0fUGIu7tHrQ9YqzHtL2anyDB4
 CGzzhgshBq19bDOqv8DZgP1SFAXPXy75SRmIiW75cRi+2qgyW9gIDepPMPMSCw3lF23Qr3
 ESe9zSMtYr7NKBsdopVkwXvnsSsIN2c=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-WeQewIe7MVuC-HW3_5bluQ-1; Sat, 28 Jun 2025 04:44:55 -0400
X-MC-Unique: WeQewIe7MVuC-HW3_5bluQ-1
X-Mimecast-MFC-AGG-ID: WeQewIe7MVuC-HW3_5bluQ_1751100295
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a503f28b09so1475699f8f.0
 for <qemu-devel@nongnu.org>; Sat, 28 Jun 2025 01:44:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751100295; x=1751705095;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zGaOA3EoKe56V6PTNIDNCgS+XJLqau081bRvVeq8J/s=;
 b=Xk1yYp30qBtGH04ZkkG3s3YaP9oXjHxGEecB/M2v2WYCovUf07YQNENe+5juwzf8BD
 v8qBFbxd8AYebB6YGHFM5J6DGR3NlykVxtA+tHaflSl+9fFyQFa7IgKY2MGmKMBJ/OBD
 nOTFo0uCYMoGZAbMJM3sRs2px571xEPSbkwl2Z5Jn3QMF4TaD9ZXZYQg5gDF4UOT6OLz
 W10AssewrKrxFCizBwZCkIu0Fnth08R+tFu05Jk7hq945O3xCSHWe/wXyMYzZRbeg24z
 AEkUiM2uXPVrgIVOKVEuGszZyBCQhNklhJrps5qEQ+Zkmno6f6wD4iVxfPV9IoBDwnR0
 XvNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/ozF4pjQ1sH3ZUM4ZtQz1xTSmd1gge1V6RFE4EXoOtGVNyjE2TME1k7qf7S8nuodVjBArQR2PQvHE@nongnu.org
X-Gm-Message-State: AOJu0YzRCj5UMXtdDc4H23eOaOCwLPlp4jsGlQ69MI/Tmi8/BbYWC3K8
 /U7R8Y0svj8nl+njMG/waveTGEkJIHBwOhT+wTH2an2b9ckvkWF5Hvc/iH3t4HsdfIf8hyjL0Xc
 JNmOxcpQeTgQTc/SoCfcOdgyvvBE3F7h20ZQGTwGzykeUm+Oo70cKtwEY
X-Gm-Gg: ASbGncs0fFwFUOEhQ8d0qlHwACkBbddSDYRqdYoHwVVw1B4+Hdx2pEGAOge/ubY2XI7
 BCHj2Swtchv30jgnNmEKzb/CKE20qbRbQUTTK6V/FcmhAYaG/muVww0l1PbG4wm+2LOIu9KraRL
 0zbDqhdi2Z5vLvrasXuz+fHsSrLx5yqMrIB4xhb9BRh6KiDfKgCiXyLmBh1xcTt0/+NqjL9zQAr
 nLFQalQVe3Fc8hRScvewS4d6FExv6Ds3ddmujDqzlr8qYnfGvhHQYx/rGKqMdkh5radDtql2h6Q
 SFf3+qWLIADg5/U/Hjwo7FJGw+oVC4L+WA3tc0YZz3FlRZ7uU3Mpf1Bvj8hv
X-Received: by 2002:a05:6000:40c8:b0:3a4:dfbe:2b14 with SMTP id
 ffacd0b85a97d-3a98b53f408mr5488929f8f.16.1751100294587; 
 Sat, 28 Jun 2025 01:44:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFan0mKCezRjfR/gYiH4DG4DWHrt/1TldIn5rk5snSPzZvuqX8Vh+4H37mntMO5jQ1nSHZ3NA==
X-Received: by 2002:a05:6000:40c8:b0:3a4:dfbe:2b14 with SMTP id
 ffacd0b85a97d-3a98b53f408mr5488909f8f.16.1751100294165; 
 Sat, 28 Jun 2025 01:44:54 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c7fab15sm4855776f8f.33.2025.06.28.01.44.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 28 Jun 2025 01:44:53 -0700 (PDT)
Message-ID: <093bb0b9-46ea-459c-ab00-fce228da0854@redhat.com>
Date: Sat, 28 Jun 2025 10:44:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Some trivial live update fixes
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com,
 steven.sistare@oracle.com, chao.p.peng@intel.com,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 "open list:Trivial patches" <qemu-trivial@nongnu.org>
References: <20250627063332.5173-1-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250627063332.5173-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 6/27/25 08:33, Zhenzhong Duan wrote:
> Hi
> 
> These are trivial VFIO live update fixes in corner cases.
> 
> 1) potential SIGSEGV when unmap-all-vaddr failed
> 2) potential vfio_container_post_load failure
> 
> Thanks
> Zhenzhong
> 
> Changelog:
> v2:
> - drop patch1,2 in v1 as they are merged
> - squashed "local save" parts of patch3 into patch4 (Steve)
> - s/DMA_MAP_FUNC/dma_map_fn (Steve)
> 
> Zhenzhong Duan (2):
>    vfio/container: Fix potential SIGSEGV when recover from
>      unmap-all-vaddr failure
>    vfio/container: Fix vfio_container_post_load()
> 
>   include/hw/vfio/vfio-cpr.h |  7 ++++---
>   hw/vfio/cpr-legacy.c       | 23 +++++++++--------------
>   2 files changed, 13 insertions(+), 17 deletions(-)
> 


Applied to vfio-next.

Thanks,

C.



