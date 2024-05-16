Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 466A4C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 16:30:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7dzm-0005VO-F0; Thu, 16 May 2024 12:30:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s7dzk-0005Rs-5L
 for qemu-devel@nongnu.org; Thu, 16 May 2024 12:30:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s7dzi-0004eq-BR
 for qemu-devel@nongnu.org; Thu, 16 May 2024 12:30:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715877007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CGyg2pF+B6usVtk10FcInupRX8kxPOYAzTAI2Gn1v7w=;
 b=CcVCuWqe7En5ObR+o65CI4RVtbyv1qQIlt95VO2DEiMWN/WFIr6KIP6abdqrV4Uhc1L7JN
 PnVz02mQKVvd5Fm/GgzIm01Db4n+U8KYKjvsUwzpJoByTgStbiafKRXSSldN95VbyTGQ9M
 6LJI99jY5m/o0m2nUxa9l43HdT/6Iq4=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-GtpRvvxUOMOQ3A9-y84yXA-1; Thu, 16 May 2024 12:30:05 -0400
X-MC-Unique: GtpRvvxUOMOQ3A9-y84yXA-1
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-6f10c1a7952so5452414a34.0
 for <qemu-devel@nongnu.org>; Thu, 16 May 2024 09:30:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715877005; x=1716481805;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CGyg2pF+B6usVtk10FcInupRX8kxPOYAzTAI2Gn1v7w=;
 b=fpaYIrNVPHutr/I1gS+4cSd1v2DnBcWGpDZuFZOFn8YJnstst6RHpZ4F4GsrLzSZ5F
 9WK6RAqxHvXqnijUCrQn4Fpga5ZZxkYCjxsdOzr6gNxYpjTGQmflf7IOGcBU0NuBDMjF
 LCCn+7B+x2aLPfw/Y6o3Q/oYTXsdD6jn5YwjsJlwQQFXkDKIA0zpy0jpsA6aHj7Ts5cO
 eZ9swwsR2H7moq9lAb/I4x7e06Q4IT0N3c6u7+g0YTyQdnP3W88J1FlhtKRBPKdNR4zM
 rWJ1Tt1SeY/OioPhhK+pGNFNrW6idgdjdUSNI8V0sjDYVHZdW+FUAy2YUqJF97XzHrYB
 SwSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfqN4xLsz+jD8VGgRCeB45eIvR0IfC/kzQel15xDGEE4FVZUy6ySmxHkQTWsk89upwpJ47YMchPmbZOZEk6VV8GE2QanQ=
X-Gm-Message-State: AOJu0YxKEIL67RnvzhVR2nn2Ef7yegZ5OnQ8m8EwcvuKJ6w1zVB7yMfT
 EDFAr3pNLTSBYNOMR/YpR60drEaO5jsAtVUWxTveB+YWDF4G6XB2YSVYEWH3qhiRdUKkThDJLuC
 +F2KbfBpJdbDj7rNmpV4PoG7SalZ/r21HWrL9JBj4WgJxvjbej7jf
X-Received: by 2002:a05:6870:f146:b0:23d:2ca3:aca with SMTP id
 586e51a60fabf-24172a88a84mr21448490fac.16.1715877003516; 
 Thu, 16 May 2024 09:30:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJri+VkAiJnH8V4VpDnwNFCeF+hQ2f9Y6cerbxAtG47Y4ukk+eZHdiSWMgc4p5jjUvjCifaA==
X-Received: by 2002:a05:6870:f146:b0:23d:2ca3:aca with SMTP id
 586e51a60fabf-24172a88a84mr21448463fac.16.1715877003161; 
 Thu, 16 May 2024 09:30:03 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6a16187f2d0sm75378896d6.130.2024.05.16.09.30.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 May 2024 09:30:02 -0700 (PDT)
Message-ID: <ce87b81e-a2c7-4786-b97c-fc14c38b8317@redhat.com>
Date: Thu, 16 May 2024 18:30:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/11] VFIO: misc cleanups
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, chao.p.peng@intel.com
References: <20240507064252.457884-1-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240507064252.457884-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.022,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 5/7/24 08:42, Zhenzhong Duan wrote:
> Hi
> 
> This is a cleanup series to change functions in hw/vfio/ to return bool
> when the error is passed through errp parameter, also some cleanup
> with g_autofree.
> 
> See discussion at https://lists.gnu.org/archive/html/qemu-devel/2024-04/msg04782.html
> 
> This series processed below files:
> hw/vfio/container.c
> hw/vfio/iommufd.c
> hw/vfio/cpr.c
> backends/iommufd.c
> 
> So above files are clean now, there are still other files need processing
> in hw/vfio.
> 
> Test done on x86 platform:
> vfio device hotplug/unplug with different backend
> reboot
> 
> Thanks
> Zhenzhong
> 
> Changelog:
> v2:
> - split out g_autofree code as a patch (Cédric)
> - add processing for more files
> 
> Zhenzhong Duan (11):
>    vfio/pci: Use g_autofree in vfio_realize
>    vfio/pci: Use g_autofree in iommufd_cdev_get_info_iova_range()
>    vfio: Make VFIOIOMMUClass::attach_device() and its wrapper return bool
>    vfio: Make VFIOIOMMUClass::setup() return bool
>    vfio: Make VFIOIOMMUClass::add_window() and its wrapper return bool
>    vfio/container: Make vfio_connect_container() return bool
>    vfio/container: Make vfio_set_iommu() return bool
>    vfio/container: Make vfio_get_device() return bool
>    vfio/iommufd: Make iommufd_cdev_*() return bool
>    vfio/cpr: Make vfio_cpr_register_container() return bool
>    backends/iommufd: Make iommufd_backend_*() return bool


Applied to vfio-next.

Thanks,

C.


