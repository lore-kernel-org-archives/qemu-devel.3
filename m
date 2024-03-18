Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55801C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 15:12:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmEeT-0000Do-Vj; Mon, 18 Mar 2024 11:11:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rmEeQ-0000Ct-1K
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 11:11:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rmEeO-0001KD-Bk
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 11:11:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710774703;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BwikDXIvm/ZqtKkCfWdyfQnuEvVpIzZ/88HEG2B5Qok=;
 b=dRC36V2ixA1IcSaPdDRJmZooqfiDrX1JBdBrut0GmhiZVGErPbkCfQB2ET3bFAsi/rBMPs
 iO7jVAxSsJhzda2G/ENc1sjbdnjkHcOb1+4fw1UeC3xXxkYSmZLfg+yDQGS2q2jIDO7v7x
 4D66p8PDeAajln/nAhPL8ImWKCglrX0=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-S_YGheMrPrC22Na9pQjrdg-1; Mon, 18 Mar 2024 11:11:35 -0400
X-MC-Unique: S_YGheMrPrC22Na9pQjrdg-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-430a6fe58bfso52463411cf.1
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 08:11:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710774695; x=1711379495;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BwikDXIvm/ZqtKkCfWdyfQnuEvVpIzZ/88HEG2B5Qok=;
 b=FlljW4gPaJOAimDbmk79lM+1B3zpJhUqXJmtfrN+A7RFCWlZFcOecrEW537kGVs3nS
 IMc4RJ24xchwNlQ4QvQZCd7nq7WiphnUgS22j/r+XgViTniYyXpxZDzTduK2DRxucTdW
 N0nM1Qv4gxZ4Fih3t2Q936kjbgHH4Gyb7nZW5GYZUxcJpk2QtXq61+CYtqSpbUnsU8U1
 p7P+PcbUMs+9O5xZFCfwKY6DCFgUbkEAV/ycc6VyTuy2qbkaOXNZstWE+FcBcIxfeo7y
 WjkuTZGjcPUdZJkbkHXbaf15lV3MGjOYYlvUu8tUM3hdXvXPXi6d/L8zrAadpxQaz8F1
 fhuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/92Sl3N+vm9CzmagC2X0bMf3mE9UjnsGSGKD4+0BwoRLYFmQsn9QRjN8ADq1aAufRchVgregj3p+lPnrwS5EsfFb4j64=
X-Gm-Message-State: AOJu0YzMNCRcEs2TQpjEkWFbcsSiPEbctO9TEKbPAy8Kr4Q04GKl6swX
 T/vdmLeFJFckVOYsxKyFKRDNsaV7QfmsWVLcswtSPQzhzndRWh0ZynpZNo2wx8Fhy7pISPpQ8ZW
 FlMPmbPWh1mbYzZkPGNiEuo6df086yqo/W8n3xsZl6mqfc0VcMMTT
X-Received: by 2002:ac8:5d07:0:b0:42d:ff64:edf with SMTP id
 f7-20020ac85d07000000b0042dff640edfmr15154646qtx.7.1710774695089; 
 Mon, 18 Mar 2024 08:11:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5h70vrojt7DG/RlO+tBzRCjYNpw/UDeS9qqwPBW7+Irhc/HllvYBADWgDoSL77CMtjtaXSA==
X-Received: by 2002:ac8:5d07:0:b0:42d:ff64:edf with SMTP id
 f7-20020ac85d07000000b0042dff640edfmr15154622qtx.7.1710774694779; 
 Mon, 18 Mar 2024 08:11:34 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 l16-20020ac84a90000000b0042ee243ca95sm5051538qtq.50.2024.03.18.08.11.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Mar 2024 08:11:34 -0700 (PDT)
Message-ID: <ca9b6f89-db51-4fce-93f1-b0bd8fb4cf1c@redhat.com>
Date: Mon, 18 Mar 2024 16:11:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 11/11] backends/iommufd: Introduce helper function
 iommufd_device_get_info()
Content-Language: en-US
To: Joao Martins <joao.m.martins@oracle.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: alex.williamson@redhat.com, clg@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, yi.y.sun@intel.com,
 qemu-devel@nongnu.org, chao.p.peng@intel.com,
 Yi Sun <yi.y.sun@linux.intel.com>
References: <20240228035900.1085727-1-zhenzhong.duan@intel.com>
 <20240228035900.1085727-12-zhenzhong.duan@intel.com>
 <db2f0780-7817-423b-a286-c3c67b95367c@redhat.com>
 <71a09333-8fe8-4313-951e-b76417b45c13@oracle.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <71a09333-8fe8-4313-951e-b76417b45c13@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Joao,

On 3/18/24 16:09, Joao Martins wrote:
> On 18/03/2024 07:54, Eric Auger wrote:
>> Hi Zhenzhong,
>>
>> On 2/28/24 04:59, Zhenzhong Duan wrote:
>>> Introduce a helper function iommufd_device_get_info() to get
>>> host IOMMU related information through iommufd uAPI.
>> Looks strange to have this patch in this series. I Would rather put it
>> in your second series alongs with its user.
>>
> The reason it was here was to use this helper for this patch:
>
> https://lore.kernel.org/qemu-devel/20240212135643.5858-2-joao.m.martins@oracle.com/
>
> Instead of me having my own alternate helper.
>
> Though at the same time, Zhenzhong will also make use of it in his second series.
OK I understand now. Maybe with extra comment in the coverletter then

Thanks

Eric
>
>> Eric
>>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>>> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> ---
>>>  include/sysemu/iommufd.h |  4 ++++
>>>  backends/iommufd.c       | 23 ++++++++++++++++++++++-
>>>  2 files changed, 26 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
>>> index d509ff88ef..518b97bfed 100644
>>> --- a/include/sysemu/iommufd.h
>>> +++ b/include/sysemu/iommufd.h
>>> @@ -4,6 +4,7 @@
>>>  #include "qom/object.h"
>>>  #include "exec/hwaddr.h"
>>>  #include "exec/cpu-common.h"
>>> +#include <linux/iommufd.h>
>>>  #include "sysemu/host_iommu_device.h"
>>>  
>>>  #define TYPE_IOMMUFD_BACKEND "iommufd"
>>> @@ -48,4 +49,7 @@ typedef struct IOMMUFDDevice {
>>>  
>>>  void iommufd_device_init(IOMMUFDDevice *idev,
>>>                           IOMMUFDBackend *iommufd, int devid);
>>> +int iommufd_device_get_info(IOMMUFDDevice *idev,
>>> +                            enum iommu_hw_info_type *type,
>>> +                            uint32_t len, void *data, Error **errp);
>>>  #endif
>>> diff --git a/backends/iommufd.c b/backends/iommufd.c
>>> index 6d280e4aea..69f3f75ea5 100644
>>> --- a/backends/iommufd.c
>>> +++ b/backends/iommufd.c
>>> @@ -20,7 +20,6 @@
>>>  #include "monitor/monitor.h"
>>>  #include "trace.h"
>>>  #include <sys/ioctl.h>
>>> -#include <linux/iommufd.h>
>>>  
>>>  static void iommufd_backend_init(Object *obj)
>>>  {
>>> @@ -240,3 +239,25 @@ void iommufd_device_init(IOMMUFDDevice *idev,
>>>      idev->iommufd = iommufd;
>>>      idev->devid = devid;
>>>  }
>>> +
>>> +int iommufd_device_get_info(IOMMUFDDevice *idev,
>>> +                            enum iommu_hw_info_type *type,
>>> +                            uint32_t len, void *data, Error **errp)
>>> +{
>>> +    struct iommu_hw_info info = {
>>> +        .size = sizeof(info),
>>> +        .dev_id = idev->devid,
>>> +        .data_len = len,
>>> +        .data_uptr = (uintptr_t)data,
>>> +    };
>>> +    int ret;
>>> +
>>> +    ret = ioctl(idev->iommufd->fd, IOMMU_GET_HW_INFO, &info);
>>> +    if (ret) {
>>> +        error_setg_errno(errp, errno, "Failed to get hardware info");
>>> +    } else {
>>> +        *type = info.out_data_type;
>>> +    }
>>> +
>>> +    return ret;
>>> +}


