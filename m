Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D37BC54754
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 07:46:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFTIP-0005PC-VV; Thu, 15 May 2025 03:46:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uFTIO-0005Ow-7K
 for qemu-devel@nongnu.org; Thu, 15 May 2025 03:46:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uFTIL-0006XC-4y
 for qemu-devel@nongnu.org; Thu, 15 May 2025 03:46:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747295179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=M2SM/GQsQBObezjKplxXPIPDP079LKFzkIR9o5VAiSw=;
 b=iyTXH+zTcaj8LkzHzBjdZtPBr66v6ztTX7AGtm/c36aiZ0aGiGIc3MoyOFuqyldTpfBFtn
 XCbcW9DiNOlROHtXpokyaR4tOT1IHMtHdx56hy/opa1cQBmGxFYl++2hpYb8X3nPr21I1k
 tUN6A94deICDVaBJgeTP+QHLFrx5t6g=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-pXzbmJZzMaiICCRljkLhjg-1; Thu, 15 May 2025 03:46:17 -0400
X-MC-Unique: pXzbmJZzMaiICCRljkLhjg-1
X-Mimecast-MFC-AGG-ID: pXzbmJZzMaiICCRljkLhjg_1747295176
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43d5ca7c86aso3341495e9.0
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 00:46:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747295176; x=1747899976;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M2SM/GQsQBObezjKplxXPIPDP079LKFzkIR9o5VAiSw=;
 b=djdaz8lOCQPmjI6YAFXt749ZQbCvMPCRpeugvdAtvCII3j8NnzT8TMEvOYpgpNOAO+
 tkSncc/dcBtegfMVE85d2JBXd5UWOeTarvfc/gPAXyZr/NGsLFIV1ZRqlXPvgI2qvCDe
 bCD+l6E4J4cOr+gALw8dc4QtNBskh7+7qQjv2pBvvRhLWRDtR5J4f52UKE9JWDti1t52
 QASurIRCe21fJc8Qan5ozBIcVhP0ZrIKjk1UamSWgU+8NRFfsSrAAZdmjgctaXNXA+WV
 PYnqa9oT9cQ2U/Rv4DvcknYTyxewIKmWChqQ+SnswC1WItLIVoVAPJ17BZGmpCxnrOIS
 e8zg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPTXz0N/Whf9a7gi4sqF0SKX9eHyewT1NlArXstKxaT0mVIEtQjlw8U+DAhjAMz1jUnDAcAIlsJo7o@nongnu.org
X-Gm-Message-State: AOJu0YyFrwsMSPTVjnwgxeL/QwszAQDifvomPxj/9zUuewt2NgdIynnK
 DB3majQmOb5grxvXQZDcQcxLSCZCdSJ3Weh9QKDHpdL6SUHWDFvZ9lH/1kqhUUelWUushuLxnF4
 35qp0YX8Xfd94rJrXVtO9UKlnOt3lWRmEHEyGDfSU455915lnZNEz
X-Gm-Gg: ASbGncsb8KYmHigsArC8dPRD2jGNiN/zxsDYFNEosoShLOXrvxTiGDndQOdY6PmbJVz
 pkFNZSGJXU6RKWy+KB7Rj3fNhMAbxeIEQkkKg3sPu78gV0llN/0oz0LlWyhtAuvrI1d0UD15NnV
 7HmjNKj0Vwm8F+1FoagQt8KrKuqcvbL8zAGzZQlFuGjxcloN+ozMjFicNqA35gTs1lZMh1Oo4He
 HzQOo/5OLYYU4ahG5i44DfLSWh5ovuDPtD/YS7HEu3XaeJfkeli00HcHmTRr/L7HeyYDfJkNXuh
 kIDuI8x3VBvA1gk4V8Wy1Z5t/eEt2t83rpNANpI8iUhKw5wPGQ==
X-Received: by 2002:a05:600c:609b:b0:43c:fbba:41ba with SMTP id
 5b1f17b1804b1-442f21798ddmr48477335e9.28.1747295176276; 
 Thu, 15 May 2025 00:46:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMsyjBxWNZ8+IZXn2hRoTwS1dQa20u4i3nFllLBstdc3FTLRtQjkZsBQZ6WBcVlmwiZGnKNQ==
X-Received: by 2002:a05:600c:609b:b0:43c:fbba:41ba with SMTP id
 5b1f17b1804b1-442f21798ddmr48477105e9.28.1747295175846; 
 Thu, 15 May 2025 00:46:15 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f33691f2sm58059385e9.3.2025.05.15.00.46.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 May 2025 00:46:15 -0700 (PDT)
Message-ID: <08e23456-33cd-467f-8425-ee19fae28e5f@redhat.com>
Date: Thu, 15 May 2025 09:46:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 05/42] vfio: move vfio-cpr.h
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu
 <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-6-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <1747063973-124548-6-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 5/12/25 17:32, Steve Sistare wrote:
> Move vfio-cpr.h to include/hw/vfio, because it will need to be included by
> other files there.


So patch 1 is fine. Forget my comment.


> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>   MAINTAINERS                |  1 +
>   hw/vfio/container.c        |  2 +-
>   hw/vfio/cpr.c              |  2 +-
>   hw/vfio/iommufd.c          |  2 +-
>   hw/vfio/vfio-cpr.h         | 15 ---------------
>   include/hw/vfio/vfio-cpr.h | 18 ++++++++++++++++++
>   6 files changed, 22 insertions(+), 18 deletions(-)
>   delete mode 100644 hw/vfio/vfio-cpr.h
>   create mode 100644 include/hw/vfio/vfio-cpr.h


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> diff --git a/MAINTAINERS b/MAINTAINERS
> index d54a532..9bee3cf 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3023,6 +3023,7 @@ CheckPoint and Restart (CPR)
>   R: Steve Sistare <steven.sistare@oracle.com>
>   S: Supported
>   F: hw/vfio/cpr*
> +F: include/hw/vfio/vfio-cpr.h
>   F: include/migration/cpr.h
>   F: migration/cpr*
>   F: tests/qtest/migration/cpr*
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index a9f0dba..eb56f00 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -33,8 +33,8 @@
>   #include "qapi/error.h"
>   #include "pci.h"
>   #include "hw/vfio/vfio-container.h"
> +#include "hw/vfio/vfio-cpr.h"
>   #include "vfio-helpers.h"
> -#include "vfio-cpr.h"
>   #include "vfio-listener.h"
>   
>   #define TYPE_HOST_IOMMU_DEVICE_LEGACY_VFIO TYPE_HOST_IOMMU_DEVICE "-legacy-vfio"
> diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
> index 3214184..0210e76 100644
> --- a/hw/vfio/cpr.c
> +++ b/hw/vfio/cpr.c
> @@ -8,9 +8,9 @@
>   #include "qemu/osdep.h"
>   #include "hw/vfio/vfio-device.h"
>   #include "migration/misc.h"
> +#include "hw/vfio/vfio-cpr.h"
>   #include "qapi/error.h"
>   #include "system/runstate.h"
> -#include "vfio-cpr.h"
>   
>   static int vfio_cpr_reboot_notifier(NotifierWithReturn *notifier,
>                                       MigrationEvent *e, Error **errp)
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index af1c7ab..167bda4 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -21,13 +21,13 @@
>   #include "qapi/error.h"
>   #include "system/iommufd.h"
>   #include "hw/qdev-core.h"
> +#include "hw/vfio/vfio-cpr.h"
>   #include "system/reset.h"
>   #include "qemu/cutils.h"
>   #include "qemu/chardev_open.h"
>   #include "pci.h"
>   #include "vfio-iommufd.h"
>   #include "vfio-helpers.h"
> -#include "vfio-cpr.h"
>   #include "vfio-listener.h"
>   
>   #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO             \
> diff --git a/hw/vfio/vfio-cpr.h b/hw/vfio/vfio-cpr.h
> deleted file mode 100644
> index 134b83a..0000000
> --- a/hw/vfio/vfio-cpr.h
> +++ /dev/null
> @@ -1,15 +0,0 @@
> -/*
> - * VFIO CPR
> - *
> - * Copyright (c) 2025 Oracle and/or its affiliates.
> - *
> - * SPDX-License-Identifier: GPL-2.0-or-later
> - */
> -
> -#ifndef HW_VFIO_CPR_H
> -#define HW_VFIO_CPR_H
> -
> -bool vfio_cpr_register_container(VFIOContainerBase *bcontainer, Error **errp);
> -void vfio_cpr_unregister_container(VFIOContainerBase *bcontainer);
> -
> -#endif /* HW_VFIO_CPR_H */
> diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
> new file mode 100644
> index 0000000..750ea5b
> --- /dev/null
> +++ b/include/hw/vfio/vfio-cpr.h
> @@ -0,0 +1,18 @@
> +/*
> + * VFIO CPR
> + *
> + * Copyright (c) 2025 Oracle and/or its affiliates.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_VFIO_VFIO_CPR_H
> +#define HW_VFIO_VFIO_CPR_H
> +
> +struct VFIOContainerBase;
> +
> +bool vfio_cpr_register_container(struct VFIOContainerBase *bcontainer,
> +                                 Error **errp);
> +void vfio_cpr_unregister_container(struct VFIOContainerBase *bcontainer);
> +
> +#endif /* HW_VFIO_VFIO_CPR_H */


