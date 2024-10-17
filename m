Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48501D3C526
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 16:57:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1ToG-0007T3-0L; Thu, 17 Oct 2024 12:57:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1t1ToF-0007Sv-2d
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 12:57:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1t1ToD-0004bD-CC
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 12:57:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729184225;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=lg7XsMEhuWLNtgjlRCyQaoVUReKNoqecctKxe2PlgNM=;
 b=WSxlrbFaEaMcV8Uw42UihqIMOm/QUJ1fM0AtkLRhNVzfoDRFfkNtWvRGBsD1j06bEKqUUV
 o/ZCXSWvCHkrpl0ehDkec3Np0+FaRl3fsn3cnKDvWPNgqlXuE1M7ChHuGJaUkjM7OI0v8d
 y+PcL3aB4mgQvwhgewlUgsdHnTHr66Y=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556--0c2XyXiMbq225mjyqL1DA-1; Thu, 17 Oct 2024 12:57:03 -0400
X-MC-Unique: -0c2XyXiMbq225mjyqL1DA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43151a9ea95so10740635e9.1
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 09:57:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729184222; x=1729789022;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lg7XsMEhuWLNtgjlRCyQaoVUReKNoqecctKxe2PlgNM=;
 b=YUmyCd7yWwIrymv4KpQAu88umdTDY+U4kAgt9j7aY1sYvkQTgZTGQTFryaizlSsHuL
 c64inJOTThrqH+dvtRVZk8THVhbjIEnWNApivqsjvOXjXbRfjlu8Q16NpyfHyvfoXSCH
 440OcNU7i4qEyCY8caA1n4D9nH+XjxisAT5Rb/FsoMNGekjdezIfxpv7Ud0Cvsh7PEGC
 903QSCknOJ4w1DonOrBM9XpWo97QOguGvGg7wRZPX39PV2Sl7pjCDPfKCOuuEdUANyqC
 5IgOamG1B+p0pnrh1qExB6cTsKHrWb22JLB4Ej6GHiuhXXzaSVc4m6+I/F1lk0cAXFDn
 hrVg==
X-Gm-Message-State: AOJu0YwBFn/qV3UOVn/MV3sx111Tq5BbdSy+jL5uFDG2TdywhNQqnG2V
 omaOv8qWCp0M1srmos6WX8Bn9pPqFyZ2ZBlJ7yOw3W3uB7NnGOktHxvLhV9ITZQ2YE3A8geynNc
 PfRwshzkoOiFNQGBSRgqEHu+amPXKInYcBkqU0JKdogANgWvK2ePk
X-Received: by 2002:a05:600c:6012:b0:431:46fe:4cac with SMTP id
 5b1f17b1804b1-43158759b80mr26805455e9.14.1729184222140; 
 Thu, 17 Oct 2024 09:57:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7nhSjWLW2YwXq+3jzHjDvHGRg++AFqh6UyGuBgHAuMziVTb1jKQ7j+twfSfHI/ghMayJISw==
X-Received: by 2002:a05:600c:6012:b0:431:46fe:4cac with SMTP id
 5b1f17b1804b1-43158759b80mr26805295e9.14.1729184221688; 
 Thu, 17 Oct 2024 09:57:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4316068c694sm1096255e9.13.2024.10.17.09.57.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Oct 2024 09:57:01 -0700 (PDT)
Message-ID: <5827f6e5-6de9-4ec1-83eb-b2e552092498@redhat.com>
Date: Thu, 17 Oct 2024 18:57:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/5] hw/cxl: Type 2 Device RFC
To: Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
 Dave Jiang <dave.jiang@intel.com>, Dan Williams <dan.j.williams@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>, Zhi Wang <zhiw@nvidia.com>
References: <20230517-rfc-type2-dev-v1-0-6eb2e470981b@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20230517-rfc-type2-dev-v1-0-6eb2e470981b@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.068,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hello,

On 5/18/23 04:45, Ira Weiny wrote:
> Type 2 devices are not yet a reality.  Developing core kernel support
> is difficult without some test device to model against.
> 
> Define a type 2 device 'cxl-accel'.  This device is derived from the
> type 3 device and retains all that functionality for now.
> 
> Mock up a couple of accelerator features (Back Invalidate [BI] and
> Unordered IO [UIO]) as examples for the RFC.  These have no
> functionality other than to report the features as present for software
> to key off of.
> 
> Defining these devices in qemu can be done with the following example:
> 
> ...
>    -device cxl-accel,bus=sw0p0,volatile-memdev=cxl-ac-mem5,id=cxl-dev5,sn=0xCAFE0005
> ...
> 
> NOTE: I'm leaving off Michael Tsirkin for now because this is really
> rough and I'm mainly sending it out because it was talked about in the
> CXL community call on 5/16.
> 
> Not-Yet-Signed-off-by: Ira Weiny <ira.weiny@intel.com>


A recent proposal to add support in VFIO for CXL passthrough uses
this emulated device and a sample driver for a proof of concept.
For this effort, it would be very useful to have a QEMU model for
a CXL type2 device, even partially implemented.

I haven't found any updates of this series. What are the plans for
upstream today ?

For vfio-cxl, see :
   
* [RFC] vfio: introduce vfio-cxl to support CXL type-2 accelerator passthrough
   https://lore.kernel.org/kvm/20240920223446.1908673-1-zhiw@nvidia.com
* [RFC] Introduce vfio-cxl to support CXL type-2 device passthrough
   https://lore.kernel.org/all/20240921071440.1915876-1-zhiw@nvidia.com/


Thanks,

C.

   

> ---
> Ira Weiny (5):
>        hw/cxl: Use define for build bug detection
>        hw/cxl: Refactor component register initialization
>        hw/cxl: Derive a CXL accelerator device from Type-3
>        hw/cxl/accel: Add Back-Invalidate decoder capbility structure
>        hw/cxl: Add UIO HDM decoder register fields
> 
>   docs/system/devices/cxl.rst    | 11 ++++++
>   hw/cxl/cxl-component-utils.c   | 80 +++++++++++++++++++-----------------------
>   hw/mem/cxl_type3.c             | 39 ++++++++++++++++++++
>   include/hw/cxl/cxl_component.h | 51 +++++++++++++++++++--------
>   include/hw/cxl/cxl_device.h    | 16 +++++++++
>   include/hw/pci/pci_ids.h       |  1 +
>   6 files changed, 141 insertions(+), 57 deletions(-)
> ---
> base-commit: 8eb2a03258313f404ca0c8609a8f9009b9b4318c
> change-id: 20230517-rfc-type2-dev-c2d661a29d96
> 
> Best regards,


