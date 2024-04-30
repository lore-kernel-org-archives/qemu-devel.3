Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC9EC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 14:13:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1oEQ-00009K-Ce; Tue, 30 Apr 2024 10:13:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s1oEO-00007e-H3
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 10:13:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s1oEM-0005Iy-Gr
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 10:13:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714486392;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YPywCFL7SwgckxTCrjAwx1deaVMHtzsOHtqvJs4c064=;
 b=Pab6c4xfIVhg7bVIaeOtiaF2sqlCV5Y/SSwbSZ943kc1edVN1rnKkLddqwyIio1a2s1MEb
 wBYjdvRctuc6+yqUhl/M5eSXQ4N27pTxPXe5rH5NdtiWl4e3CMawhRTMkZOQudlS7ZlC++
 OFz0TddsUtbfb552VV2QJ9qxRGw851c=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-9gUYp5l-Nzal2A3nmGh4kw-1; Tue, 30 Apr 2024 10:13:09 -0400
X-MC-Unique: 9gUYp5l-Nzal2A3nmGh4kw-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2d87dad1640so52402061fa.3
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 07:13:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714486388; x=1715091188;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YPywCFL7SwgckxTCrjAwx1deaVMHtzsOHtqvJs4c064=;
 b=OORzfgf/8XAovOkodrLQQ6aS/FQxFBVsLj90CfNbK3mGKjU3I2AWwS0rUmo1gHPJQX
 k7gxXLUKRwiMYc+ZOcV9XPbmFJak+pUZwzTDgo5Ki+vQUMPQ0Scdl5tc277IWupVH35z
 aW86xUBwC9sfR6R8tbzT5iw3FFzDXHWSl1/+Gf1aCys5RfCRToM4ZbJTaSR+YPRlgCxJ
 D1Bb3lsXZoPGz5ppfCicnSne3hnwfdn9ZBCna8w5vdZ8rtNzNdsdtAzpkfLUVhljmc50
 uhZNqOMbK+c05jR+JNblHlQvOmvaC9Y7jsw1p0YzVGMEiMYpUzpqtCjrZWWki4UGdEL7
 aF6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjiK435CHdF9fNL1eMOkzNhyof6OgB5xxv+TR27Vw/ZvCIq98PuYs+ytZ+1RqZdaGj+NFhHixJP8LNuuu+mDwrV/6sjF4=
X-Gm-Message-State: AOJu0YzxcZvqpDk5CkvJZwWzt+jIH1IcKgY4OJm+LbhwiAKDfe55E2o7
 MjXhnDU8zayEpifDkLkbrx8GwkgZ9aOUX1AcYaWXWbjmS3v8cDqQ+00TmQw3xdXRfbZ7/pvYnqr
 43WFuUavSJD0CuK5FHze+FB+eARFfM3AJO3DF6KL4f/xOYpdAk4a0
X-Received: by 2002:a05:6512:4882:b0:51d:3675:6a08 with SMTP id
 eq2-20020a056512488200b0051d36756a08mr1887752lfb.66.1714486388084; 
 Tue, 30 Apr 2024 07:13:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/kfcLrfl7CGZDcEWCtKEZJ9eBMpu+6CNlpWX7Lci4wJLS0rNnxqLYwxynA584dnLfXA8k8g==
X-Received: by 2002:a05:6512:4882:b0:51d:3675:6a08 with SMTP id
 eq2-20020a056512488200b0051d36756a08mr1887728lfb.66.1714486387618; 
 Tue, 30 Apr 2024 07:13:07 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 h9-20020a5d4309000000b0034c78001f6asm10301225wrq.109.2024.04.30.07.13.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Apr 2024 07:13:07 -0700 (PDT)
Message-ID: <9e15abd9-f824-4f11-9532-b0dcb7b521dd@redhat.com>
Date: Tue, 30 Apr 2024 16:13:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH intel_iommu 0/7] FLTS for VT-d
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "jasowang@redhat.com" <jasowang@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, Liu Yi L <yi.l.liu@intel.com>,
 Joao Martins <joao.m.martins@oracle.com>, Peter Xu <peterx@redhat.com>
References: <20240422155236.129179-1-clement.mathieu--drif@eviden.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240422155236.129179-1-clement.mathieu--drif@eviden.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
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

Hello,

Adding a few people in Cc: who are familiar with the Intel IOMMU.

Thanks,

C.




On 4/22/24 17:52, CLEMENT MATHIEU--DRIF wrote:
> This series is the first of a list that add support for SVM in the Intel IOMMU.
> 
> Here, we implement support for first-stage translation in VT-d.
> The PASID-based IOTLB invalidation is also added in this series as it is a
> requirement of FLTS.
> 
> The last patch introduces the 'flts' option to enable the feature from
> the command line.
> Once enabled, several drivers of the Linux kernel use this feature.
> 
> This work is based on the VT-d specification version 4.1 (March 2023)
> 
> Here is a link to a GitHub repository where you can find the following elements :
>      - Qemu with all the patches for SVM
>          - ATS
>          - PRI
>          - PASID based IOTLB invalidation
>          - Device IOTLB invalidations
>          - First-stage translations
>          - Requests with already translated addresses
>      - A demo device
>      - A simple driver for the demo device
>      - A userspace program (for testing and demonstration purposes)
> 
> https://github.com/BullSequana/Qemu-in-guest-SVM-demo
> 
> Clément Mathieu--Drif (7):
>    intel_iommu: fix FRCD construction macro.
>    intel_iommu: rename slpte to pte before adding FLTS
>    intel_iommu: make types match
>    intel_iommu: add support for first-stage translation
>    intel_iommu: extract device IOTLB invalidation logic
>    intel_iommu: add PASID-based IOTLB invalidation
>    intel_iommu: add a CLI option to enable FLTS
> 
>   hw/i386/intel_iommu.c          | 655 ++++++++++++++++++++++++++-------
>   hw/i386/intel_iommu_internal.h | 114 ++++--
>   include/hw/i386/intel_iommu.h  |   3 +-
>   3 files changed, 609 insertions(+), 163 deletions(-)
> 


