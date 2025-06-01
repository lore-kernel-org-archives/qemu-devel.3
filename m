Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15D18C5B549
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Jun 2025 18:05:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLn2s-0008DM-6n; Sun, 01 Jun 2025 14:04:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uLn2n-0008D3-CP
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 14:04:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uLn2l-0001f7-80
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 14:04:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748801060;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=785yGvz3/BvkNu/AfLF5HYFGz33h39swUmwpH88ebCc=;
 b=NN1mgzbtteDXYFYMxym5nmfS/AK72begV9hIKuAL56a8MV811TS188KU0jvF5VoGbo0DIs
 APxclXRmAq3AFOOyr1ZQ5RZvsV/jfPDjlMip+MkcL+MFLNwT7ZXpBCYKTq9dYVCIp5wuO+
 synw0vWKIjWkw1TuBhIkp5KctnLcPzk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-yrxX4NumPwmo8JQxiNcUBQ-1; Sun, 01 Jun 2025 14:04:19 -0400
X-MC-Unique: yrxX4NumPwmo8JQxiNcUBQ-1
X-Mimecast-MFC-AGG-ID: yrxX4NumPwmo8JQxiNcUBQ_1748801058
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-450787c8626so20190775e9.1
 for <qemu-devel@nongnu.org>; Sun, 01 Jun 2025 11:04:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748801057; x=1749405857;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=785yGvz3/BvkNu/AfLF5HYFGz33h39swUmwpH88ebCc=;
 b=DDHXPhNk9BCFofyFCPPNhCoIFc95YGPYu7FOmdeJh31qo9WZ/Wqxn0LNqp1VME/GC9
 dX4sWjf3brXhPorZKf62rSUEmHMiUBWeupwQECyPJ85jwfUD1LQCV68rMnfOcn1heKGp
 0RILB6zN4um7bG4FN1pFKq9ILBx/A2U1FWXnP42cEiA9B9fbAyukJ6O8dEOvocXGCGOf
 OzFqsx9Xsj2wRSwIEVchAGMUlJfYhbDFGvZvZA1xERY5YFHnL4rxLeCXqe/cuBjIxE/A
 VUBTPR6E0wBf83v/g22bFl0Qpui+urnTX5R02+KKK+xUSZZj6mqVboLbSBikjlQR+E2p
 Epag==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHvAcSInNZKRTbJBYx8ndxZ9XOUVAiRBKcChtxazMc1uYJQR6vlZ7CNpVPiE4V4ZFrDru9bsBHvHbF@nongnu.org
X-Gm-Message-State: AOJu0YzXP1MfJU7WQRsUr/mzDqBLSBRm723Dw9i23qS1/4/UyCzOfyBl
 zGdrTJafU2OQ1pc4+nF2OnJVXXKk5npZxwri+ajy2OuAh4bKarogpnqrUsg7k5FERillP5/tx7M
 6PWio9+oDidXq65gcl960a2ILXHbaS+TFkqOABhQQjdHtbXiIO+QKTXPB
X-Gm-Gg: ASbGncsNhtR8OBb14kxLeED91vlmINjU4Wc+TI7DxGTFc5qQ+RkoHKsEGpGpN2Yh5ha
 4ezMhNzWp0c+2rTsScca20J9wFKbWKxtjHYOdR9f8G4X7xreX3tYPXXeSdMzewYd3AO4WyNLM3p
 XMaB8O71ahEhM/1tIg60lZ7pT40NxB/v2I77iEx1lVbbi1ihpRw3CB0gYv+YLMnegr8Um8v3saZ
 fwn2/srR6yJUgP64UY40yi9q9GExE6HyDilzplzpLnDmKLStUbj15SpSuQA1X815ru4gSrmnrj0
 sFM01PJ0bCO8LdvaZEDxIq0ATDS6f4yXZrm3Qd0WBLW2tzCHbXI+cFozF8Gv
X-Received: by 2002:a05:600c:1c8f:b0:43c:f70a:2af0 with SMTP id
 5b1f17b1804b1-4511edd5bfamr55960155e9.16.1748801057571; 
 Sun, 01 Jun 2025 11:04:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGy7/ka70rSF0N0711C0Lm+G8O/TOa1VEMLm0u155dEFzr2mcJMKvMnNRgk1yHbjqWOdKWq1A==
X-Received: by 2002:a05:600c:1c8f:b0:43c:f70a:2af0 with SMTP id
 5b1f17b1804b1-4511edd5bfamr55959925e9.16.1748801057197; 
 Sun, 01 Jun 2025 11:04:17 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d7fa25besm91306775e9.14.2025.06.01.11.04.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Jun 2025 11:04:16 -0700 (PDT)
Message-ID: <8bfb07b2-2e9e-43d5-81a1-030554a64b5a@redhat.com>
Date: Sun, 1 Jun 2025 20:04:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] VFIO and IOMMU prerequisite stuff for IOMMU
 nesting support
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com
References: <20250530093512.3959484-1-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250530093512.3959484-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.071,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On 5/30/25 11:35, Zhenzhong Duan wrote:
> Hi,
> 
> The first 6 patches of [1] are all VFIO or IOMMUFD related additions.
> Split them out per Cédric and seek for quick acceptance.
> 
> I didn't copy changelog from [1] as it's a mix of the whole nesting series.
> 
> For who want a quick view of the whole nesting series [2].
> 
> Test done:
> - VFIO devices hotplug/unplug
> - build test on Windows
> 
> [1] https://lists.gnu.org/archive/html/qemu-devel/2025-05/msg05002.html
> [2] https://github.com/yiliu1765/qemu/tree/zhenzhong/iommufd_nesting.v1.wip
> 
> Thanks
> Zhenzhong
> 
> Changelog:
> v2:
> - report kernel BUG as error instead of assert (Cédric)
> - merge patch2 and patch3 (Cédric)
> - handle vendor cap check directly from vtd_check_hiod, so patch6 removed (Cédric)
> - s/data_ptr/data (Cédric)
> - s/totally/total (Donald)


Applied to vfio-next.

Thanks,

C.



> 
> v1:
> - changed to save raw data in VendorCaps, so we can keep all vendor structure
>    decoding inside the backend and VFIO wouldn't need to care about types nor
>    what's inside the data.
> 
> 
> Zhenzhong Duan (4):
>    backends/iommufd: Add a helper to invalidate user-managed HWPT
>    vfio/iommufd: Add properties and handlers to
>      TYPE_HOST_IOMMU_DEVICE_IOMMUFD
>    vfio/iommufd: Implement [at|de]tach_hwpt handlers
>    vfio/iommufd: Save vendor specific device info
> 
>   include/system/host_iommu_device.h | 11 ++++++
>   include/system/iommufd.h           | 54 ++++++++++++++++++++++++++++
>   backends/iommufd.c                 | 58 ++++++++++++++++++++++++++++++
>   hw/vfio/iommufd.c                  | 36 ++++++++++++++++---
>   backends/trace-events              |  1 +
>   5 files changed, 155 insertions(+), 5 deletions(-)
> 


