Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 646B5C5AD49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 08:41:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJTOP-0008Gs-Gy; Mon, 26 May 2025 04:41:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uJTOM-0008GO-CD
 for qemu-devel@nongnu.org; Mon, 26 May 2025 04:41:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uJTOF-0006Po-QJ
 for qemu-devel@nongnu.org; Mon, 26 May 2025 04:41:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748248857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=2gk8J4qdN+7/WzVTYDJmsbzuW+AyW4oYejYE3RoeY7U=;
 b=isxOQ+OGpMtDRzalHCSY60JIHA9YQ/+LtA0pF5151PRDW0xOFXKxIbpqkkJQhxgoFOv0L4
 ZVdN13wignw7n2unvYUzNhuzKZB3tE09sWLGEGTDuFR/h4hBHudXMRYrB3RqAQ4Duqg56v
 dF8A3sh+uKr0MzO9Vgb8fbqqv3N+GpY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-wzDNOZWaNqeFZRDwymy0mg-1; Mon, 26 May 2025 04:40:55 -0400
X-MC-Unique: wzDNOZWaNqeFZRDwymy0mg-1
X-Mimecast-MFC-AGG-ID: wzDNOZWaNqeFZRDwymy0mg_1748248855
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-441c122fa56so9385395e9.2
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 01:40:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748248854; x=1748853654;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2gk8J4qdN+7/WzVTYDJmsbzuW+AyW4oYejYE3RoeY7U=;
 b=BL/pmwgBtBeZDsafAMCitiHJM4fUl1PpUmWENsHEP4PjDxpkj5QfgHJLJBiVrBiJmy
 zAO8g2hAOebyghHZGEkGmt8sBV3NAs4d71ttrGaVezim6VEYr9TrQkd6xVvT5BmEmEzq
 SsaQKvLK7sA+IbOPB/YIAvvSgnHBZjTmuuOTUxJx3bVc9aEO8mAJzmbBShCHWAI7pFc4
 rbkQu23T0iUeT5VkZ8Ty/zMqx/VXrLx+5nGsc43cKuTBjkyvQkS74WNc/ILJZldkN5he
 vY+WjEKT4LcLYBzQl4+MdBkU/1CqvYTy8pC4B3WLMW9fZuhG6ZLV+omOuAsl7BHW3myD
 NhRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuQLfEElL58N17Xm6QfE3zvua9n6sJ0zk6WaEuFe3KyHCPV7Z+DGOQU3HWO/ojXDulE9CcCvLZ6jDR@nongnu.org
X-Gm-Message-State: AOJu0YwjqAERXd7xm7vRj9EVIkDlDEMXDpiQh3p27XiydP7agJNFlq52
 SFamRgtBvSl+gFnW1DS38z+UUikWHCJlBAO3OVKAIbTBF/aZnHL9b/l/iS/IoAJ4yLkDHxroBsi
 jx8RVsN4AeF/T+K9cIHNxJRl0savGWJYnWqs8MRcQ8iqLZXUqNdo0SkF5
X-Gm-Gg: ASbGncvXi8pKW2lA/CoTG6+D87o2dwfoywMbFxnxxcR3JozItD4crztkwmkSinMxFw4
 4xHxGu4cfza12sg9llEtxneEZP2matD+HqBRTu81xcn4MjIB6DxJIv+zogvDzNSBaCiQfwzx57r
 BCNQ0B+9uSNYX5i3mRRJMJdhUCQSMfAscX5BETxUg085N22pi9Y4c5Tv2GjXfYUoJJ4oOdI0UK8
 a/y7cCNbrLIDMenhyB5Rebq/9DbHYR/6wBR511aI6pHRJiyEnodsAZdp3JSRUXYzmFFsljhiqNo
 q/mbeKYN2W9XZdzNtxZ+w84Ru6vU60UKylluhC5oPF274Q0PTA==
X-Received: by 2002:a05:600c:1c8b:b0:44a:ac77:26d5 with SMTP id
 5b1f17b1804b1-44c919e1873mr72295655e9.14.1748248854611; 
 Mon, 26 May 2025 01:40:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElZTB/8NdBCXa+noVoBZEvRB3aPhx5ktQrwbM31b9TCTQt73Ii0tDgsygGfyu/Z8K7g/Y4Iw==
X-Received: by 2002:a05:600c:1c8b:b0:44a:ac77:26d5 with SMTP id
 5b1f17b1804b1-44c919e1873mr72295395e9.14.1748248854225; 
 Mon, 26 May 2025 01:40:54 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f78b2f19sm224943065e9.32.2025.05.26.01.40.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 May 2025 01:40:53 -0700 (PDT)
Message-ID: <66ad7451-b7a6-4112-8f20-1af06d5b482a@redhat.com>
Date: Mon, 26 May 2025 10:40:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v11 3/4] hw/vfio/ap: Storing event information for an
 AP configuration change event
To: Rorie Reyes <rreyes@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, thuth@redhat.com, akrowiak@linux.ibm.com
References: <20250523160338.41896-1-rreyes@linux.ibm.com>
 <20250523160338.41896-4-rreyes@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250523160338.41896-4-rreyes@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -59
X-Spam_score: -6.0
X-Spam_bar: ------
X-Spam_report: (-6.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 5/23/25 18:03, Rorie Reyes wrote:
> These functions can be invoked by the function that handles interception
> of the CHSC SEI instruction for requests indicating the accessibility of
> one or more adjunct processors has changed.
> 
> Signed-off-by: Rorie Reyes <rreyes@linux.ibm.com>
> ---
>   hw/vfio/ap.c                 | 53 ++++++++++++++++++++++++++++++++++++
>   include/hw/s390x/ap-bridge.h | 39 ++++++++++++++++++++++++++
>   2 files changed, 92 insertions(+)
> 
> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> index fc435f5c5b..97a42a575a 100644
> --- a/hw/vfio/ap.c
> +++ b/hw/vfio/ap.c
> @@ -10,6 +10,7 @@
>    * directory.
>    */
>   
> +#include <stdbool.h>
>   #include "qemu/osdep.h"
>   #include CONFIG_DEVICES /* CONFIG_IOMMUFD */
>   #include <linux/vfio.h>
> @@ -48,6 +49,8 @@ typedef struct APConfigChgEvent {
>   static QTAILQ_HEAD(, APConfigChgEvent) cfg_chg_events =
>       QTAILQ_HEAD_INITIALIZER(cfg_chg_events);
>   
> +static QemuMutex cfg_chg_events_lock;
> +
>   OBJECT_DECLARE_SIMPLE_TYPE(VFIOAPDevice, VFIO_AP_DEVICE)
>   
>   static void vfio_ap_compute_needs_reset(VFIODevice *vdev)
> @@ -96,6 +99,49 @@ static void vfio_ap_cfg_chg_notifier_handler(void *opaque)
>   
>   }
>   
> +int ap_chsc_sei_nt0_get_event(void *res)
> +{
> +    ChscSeiNt0Res *nt0_res  = (ChscSeiNt0Res *)res;
> +    APConfigChgEvent *cfg_chg_event;
> +
> +    qemu_mutex_lock(&cfg_chg_events_lock);

please consider using WITH_QEMU_LOCK_GUARD()

> +    if (!ap_chsc_sei_nt0_have_event()) {
> +        qemu_mutex_unlock(&cfg_chg_events_lock);
> +        return EVENT_INFORMATION_NOT_STORED;
> +    }
> +
> +    cfg_chg_event = QTAILQ_FIRST(&cfg_chg_events);
> +    QTAILQ_REMOVE(&cfg_chg_events, cfg_chg_event, next);
> +
> +    qemu_mutex_unlock(&cfg_chg_events_lock);
> +
> +    memset(nt0_res, 0, sizeof(*nt0_res));
> +    g_free(cfg_chg_event);
> +
> +    /*
> +     * If there are any AP configuration change events in the queue,
> +     * indicate to the caller that there is pending event info in
> +     * the response block
> +     */
> +    if (ap_chsc_sei_nt0_have_event()) {
> +        nt0_res->flags |= PENDING_EVENT_INFO_BITMASK;
> +    }
> +
> +    nt0_res->length = sizeof(ChscSeiNt0Res);
> +    nt0_res->code = NT0_RES_RESPONSE_CODE;
> +    nt0_res->nt = NT0_RES_NT_DEFAULT;
> +    nt0_res->rs = NT0_RES_RS_AP_CHANGE;
> +    nt0_res->cc = NT0_RES_CC_AP_CHANGE;
> +
> +    return EVENT_INFORMATION_STORED;
> +}
> +
> +bool ap_chsc_sei_nt0_have_event(void)

hmm, no locking ?

> +{
> +    return !QTAILQ_EMPTY(&cfg_chg_events);
> +}
> +
>   static bool vfio_ap_register_irq_notifier(VFIOAPDevice *vapdev,
>                                             unsigned int irq, Error **errp)
>   {
> @@ -192,6 +238,13 @@ static void vfio_ap_realize(DeviceState *dev, Error **errp)
>       VFIOAPDevice *vapdev = VFIO_AP_DEVICE(dev);
>       VFIODevice *vbasedev = &vapdev->vdev;
>   
> +    static bool lock_initialized;
> +
> +    if (!lock_initialized) {
> +        qemu_mutex_init(&cfg_chg_events_lock);
> +        lock_initialized = true;
> +    }

this could be replaced with a constructor routine. See hyperv.


Thanks,

C.



>       if (!vfio_device_get_name(vbasedev, errp)) {
>           return;
>       }
> diff --git a/include/hw/s390x/ap-bridge.h b/include/hw/s390x/ap-bridge.h
> index 470e439a98..7efc52928d 100644
> --- a/include/hw/s390x/ap-bridge.h
> +++ b/include/hw/s390x/ap-bridge.h
> @@ -16,4 +16,43 @@
>   
>   void s390_init_ap(void);
>   
> +typedef struct ChscSeiNt0Res {
> +    uint16_t length;
> +    uint16_t code;
> +    uint8_t reserved1;
> +    uint16_t reserved2;
> +    uint8_t nt;
> +#define PENDING_EVENT_INFO_BITMASK 0x80;
> +    uint8_t flags;
> +    uint8_t reserved3;
> +    uint8_t rs;
> +    uint8_t cc;
> +} QEMU_PACKED ChscSeiNt0Res;
> +
> +#define NT0_RES_RESPONSE_CODE 1
> +#define NT0_RES_NT_DEFAULT    0
> +#define NT0_RES_RS_AP_CHANGE  5
> +#define NT0_RES_CC_AP_CHANGE  3
> +
> +#define EVENT_INFORMATION_NOT_STORED 1
> +#define EVENT_INFORMATION_STORED     0
> +
> +/**
> + * ap_chsc_sei_nt0_get_event - Retrieve the next pending AP config
> + * change event
> + * @res: Pointer to a ChscSeiNt0Res struct to be filled with event
> + * data
> + *
> + * This function checks for any pending AP config change events and,
> + * if present, populates the provided response structure with the
> + * appropriate SEI NT0 fields.
> + *
> + * Return:
> + *   EVENT_INFORMATION_STORED - An event was available and written to @res
> + *   EVENT_INFORMATION_NOT_STORED - No event was available
> + */
> +int ap_chsc_sei_nt0_get_event(void *res);
> +
> +bool ap_chsc_sei_nt0_have_event(void);
> +>   #endif


