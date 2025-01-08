Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BA7CE77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 07:34:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVQaO-0003Tg-6t; Wed, 08 Jan 2025 02:34:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tVQaJ-0003TI-LL
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 02:34:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tVQaI-0006Db-65
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 02:34:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736321673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=OOTcPfvKuhInYM/UdlZzhtAlF++1Ra6scWdCntz5AaI=;
 b=gYK2fnfw8Ho0hbAp3R+5FG8PQkDSCc5Z9oKrzhXWUl51QOvlll9nfP1mNvAymG3gjLFqFP
 EnWQbUiVt6broabUmsF7VygDOPz3zx/bcerr4lT0P3euqDnLheKC19ZpBR/g8uC4fuZm62
 B8HA1MPzvCxWMvzRGpzRFa+pDPCfqTw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-4xGseoj7P2iZ3_d_0TCWVw-1; Wed, 08 Jan 2025 02:34:31 -0500
X-MC-Unique: 4xGseoj7P2iZ3_d_0TCWVw-1
X-Mimecast-MFC-AGG-ID: 4xGseoj7P2iZ3_d_0TCWVw
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-386333ea577so3049627f8f.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 23:34:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736321670; x=1736926470;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OOTcPfvKuhInYM/UdlZzhtAlF++1Ra6scWdCntz5AaI=;
 b=wEf3Y2ERxOO5tK2vm9o7mE0e+CtlV44EwdacochzyLHchNjmenJN51iE+L+ZEIMD5i
 wQWB3HM6ZBiCvXdE1pitbQXjljr9OERAxlnT/If1TPVp3DbWvN9nLWUCUlmOnufZF4BY
 WF5zr2ogvhFpUcx5C3INygQo9GmK01xYuZ/LKOZ9QUOmMkmJ37bodPo/3/zNuJ6Y1b5b
 M6SlOC9Ql1U5zCRdyd03Wty54mQvsKSYj0v5s+dGeieImbcSWyYE+NczcSDTPHUtD4HG
 KwGxjwW33ilxM+IEmbYuZzu2d7J8p3TOzN74oCgR39WbNYpnsoWC8Zl2qGhoPwVYLuhY
 fZNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWPtOd0HfOhZhEvjhoTKTUTefVPN83FNRaJHNYgWQ7yOT7dvN1qdn2vnXsKrfirk+RyJgZ/7qfdS9q@nongnu.org
X-Gm-Message-State: AOJu0YzHgQ9cualPJDbtlG8iLVnyNoWmFSPLJ+d2I0JBuKyBW0Fs0IDh
 V1SJxiudf1oMCTeR85qX8u5MdHiE0EfOEIBvotjBpeaKLySuFUj8pGy4Mo49o1NHpwvsGIY2YXM
 ow/YV869sj455TJYrlFmmyGPpPqPvgUxTCS8RL8+W5yaEpf9/67/8
X-Gm-Gg: ASbGncv58qFBSaNzF4VdYdqwRhq+j/vHzwHVYc3nUcL2urXAlOs0NtbBOwZV5nrb+7D
 /2d7+wK7NydT8098nS3EnKrysQGWoHMqyBWoZrKCu4PIM5RDK0VbonRt7lGZB5RT9QqDBcmyprc
 EAH2GG92mvQTPKL+yjBbKy41WJKn4DVW++GVZWVhXgmvc5+kT06T0/KjRTlQD9m9CDuMlwufLdG
 yHRsQPvPNpawKn0ltKwyCeU5zIiwEbMUhkwpyoVglNJGVC88ICH+08W7rkn0TWz8VOCFFOyUMs6
 fScCT6To+MyW+OkmQJs=
X-Received: by 2002:a5d:6d07:0:b0:38a:69a9:afb1 with SMTP id
 ffacd0b85a97d-38a8708849emr1196904f8f.0.1736321670461; 
 Tue, 07 Jan 2025 23:34:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHimI0f7OJrvre4jQuTy+yJ7oBJfj8+6QYzmYmObOUWDwmsIPt/fHHzoiLItHKWAuCG01eHuw==
X-Received: by 2002:a5d:6d07:0:b0:38a:69a9:afb1 with SMTP id
 ffacd0b85a97d-38a8708849emr1196881f8f.0.1736321670118; 
 Tue, 07 Jan 2025 23:34:30 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8332absm51562415f8f.38.2025.01.07.23.34.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2025 23:34:29 -0800 (PST)
Message-ID: <af2e1f98-f313-4a84-baa8-4435da40c326@redhat.com>
Date: Wed, 8 Jan 2025 08:34:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/5] hw/vfio/ap: notification handler for AP config
 changed event
To: Rorie Reyes <rreyes@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, thuth@redhat.com, akrowiak@linux.ibm.com
References: <20250107184354.91079-1-rreyes@linux.ibm.com>
 <20250107184354.91079-3-rreyes@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250107184354.91079-3-rreyes@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.437,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 1/7/25 19:43, Rorie Reyes wrote:
> Register an event notifier handler to process AP configuration
> change events by queuing the event and generating a CRW to let
> the guest know its AP configuration has changed
> 
> Signed-off-by: Rorie Reyes <rreyes@linux.ibm.com>
> Reviewed-by: Anthony Krowiak <akrowiak@linux.ibm.com>
> Tested-by: Anthony Krowiak <akrowiak@linux.ibm.com>

I don't recall a previous version of these changes where these
trailers were added. Was this part of an internal review ?
It is best to restart the process when the patches become public.

Thanks,

C.



> ---
>   hw/vfio/ap.c | 27 +++++++++++++++++++++++++++
>   1 file changed, 27 insertions(+)
> 
> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> index 30b08ad375..533cadb2dd 100644
> --- a/hw/vfio/ap.c
> +++ b/hw/vfio/ap.c
> @@ -18,6 +18,7 @@
>   #include "hw/vfio/vfio-common.h"
>   #include "system/iommufd.h"
>   #include "hw/s390x/ap-device.h"
> +#include "hw/s390x/css.h"
>   #include "qemu/error-report.h"
>   #include "qemu/event_notifier.h"
>   #include "qemu/main-loop.h"
> @@ -37,6 +38,7 @@ struct VFIOAPDevice {
>       APDevice apdev;
>       VFIODevice vdev;
>       EventNotifier req_notifier;
> +    EventNotifier cfg_notifier;
>   };
>   
>   OBJECT_DECLARE_SIMPLE_TYPE(VFIOAPDevice, VFIO_AP_DEVICE)
> @@ -70,6 +72,18 @@ static void vfio_ap_req_notifier_handler(void *opaque)
>       }
>   }
>   
> +static void vfio_ap_cfg_chg_notifier_handler(void *opaque)
> +{
> +    VFIOAPDevice *vapdev = opaque;
> +
> +    if (!event_notifier_test_and_clear(&vapdev->cfg_notifier)) {
> +        warn_report("Event notifier not initialized");
> +        return;
> +    }
> +
> +    css_generate_css_crws(0);
> +}
> +
>   static bool vfio_ap_register_irq_notifier(VFIOAPDevice *vapdev,
>                                             unsigned int irq, Error **errp)
>   {
> @@ -85,6 +99,10 @@ static bool vfio_ap_register_irq_notifier(VFIOAPDevice *vapdev,
>           notifier = &vapdev->req_notifier;
>           fd_read = vfio_ap_req_notifier_handler;
>           break;
> +    case VFIO_AP_CFG_CHG_IRQ_INDEX:
> +        notifier = &vapdev->cfg_notifier;
> +        fd_read = vfio_ap_cfg_chg_notifier_handler;
> +        break;
>       default:
>           error_setg(errp, "vfio: Unsupported device irq(%d)", irq);
>           return false;
> @@ -175,6 +193,15 @@ static void vfio_ap_realize(DeviceState *dev, Error **errp)
>           warn_report_err(err);
>       }
>   
> +    if (!vfio_ap_register_irq_notifier(vapdev, VFIO_AP_CFG_CHG_IRQ_INDEX, &err))
> +    {
> +        /*
> +         * Report this error, but do not make it a failing condition.
> +         * Lack of this IRQ in the host does not prevent normal operation.
> +         */
> +        warn_report_err(err);
> +    }
> +
>       return;
>   
>   error:


