Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7225AC25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 16:28:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7dxz-0003c8-J0; Thu, 16 May 2024 12:28:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s7dxw-0003bS-A7
 for qemu-devel@nongnu.org; Thu, 16 May 2024 12:28:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s7dxu-0004NT-T1
 for qemu-devel@nongnu.org; Thu, 16 May 2024 12:28:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715876901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0y61LM5HoJXOxwFhaIOTdmT0PTZGmCU261TrC8Qy2rk=;
 b=bSlQFg2/OEASHgWlgBN3H7VNqTXMNB8qebqNn6qnUBXYwhldzIMEi/6BRxJeJh4YZ2GyYf
 ouoonbNzosLaiONpmRB9paoBAq2yxLqdrTazFHEKH5grFG8oawYh3RXnIjZocPOE4E1u6V
 BS3pTw9rfqOwMWuB4e6+RhpDC219O9M=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-rTfO_lkrMgqeVtzW5H9Z-Q-1; Thu, 16 May 2024 12:28:19 -0400
X-MC-Unique: rTfO_lkrMgqeVtzW5H9Z-Q-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6a0dc98dc24so78361226d6.2
 for <qemu-devel@nongnu.org>; Thu, 16 May 2024 09:28:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715876899; x=1716481699;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0y61LM5HoJXOxwFhaIOTdmT0PTZGmCU261TrC8Qy2rk=;
 b=r8iWj2UnEvf3AoOaYb298GNB4KaF7agvaGK5770sK3+cIbLaT/gJZPQn4jnj+CQl59
 88+0FV7r32lGcGljNQCZEFlkyYL4pLPC5aDWtP9EXTdbxYN7EtRuSM51Rwu2r9Ondzis
 +jq7pfL6JySX9nc4o7au9k3GzcXYLnH9qV3KuQ/+bIl9JhYTuZW9JzFSqkZL6227Cvwi
 backzq7gwUdb+6Bw3CvUt8Rl/QmGc5CDKprRInvSSOxa20vq3VuEoCv8H7vR4IQW8MtM
 +jegUOQpOlgCXuu16kmmMoiBb6uyxNzLMPWJpxtssdeLuOVgklrBrXFga4ciWVe79iWu
 jetA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfbRSryBCksiNMHWCRTlPCJM+vhq4gO46gdNhWQX1fRdaEW4VQcI1B7yO0mPQ8CtRpHyO0Y/nuR/FO3TT0l1IuVTZsUQ8=
X-Gm-Message-State: AOJu0Yw7ycCkpcGql5vBT7qKd/pt9JbLmsW8zYT5M4ilPOFxnCHZJgkv
 D/S1T6O9k98v8+L3h5ShXenRzVxTcxbx25ULV+LJvhI6r+aeonLQgLi/aONiejbHiMEFJXEHNHy
 KbeySrQo7m7KFqUvLFEb894eHTVemziJiijA074k5e/FSZTh0Tt97
X-Received: by 2002:a05:6214:4a89:b0:6a0:c95d:909b with SMTP id
 6a1803df08f44-6a16821eb03mr270264346d6.44.1715876898913; 
 Thu, 16 May 2024 09:28:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5ZFJbOFIjj2oRrCevhqTd1FOS6OpmygGhRTnAyX3+E+pOSc6kk7kkAcfyuRU3ySa/HsEBtg==
X-Received: by 2002:a05:6214:4a89:b0:6a0:c95d:909b with SMTP id
 6a1803df08f44-6a16821eb03mr270264076d6.44.1715876898541; 
 Thu, 16 May 2024 09:28:18 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6a15f185141sm76924266d6.30.2024.05.16.09.28.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 May 2024 09:28:18 -0700 (PDT)
Message-ID: <3b6b5831-6357-4226-b2a0-e9ab97f1fc73@redhat.com>
Date: Thu, 16 May 2024 18:28:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] vfio/ap: Use g_autofree variable in
 vfio_ap_register_irq_notifier()
To: Thomas Huth <thuth@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20240425090214.400194-1-clg@redhat.com>
 <20240425090214.400194-2-clg@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240425090214.400194-2-clg@redhat.com>
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


Applied series to vfio-next.

Thanks,

C.

On 4/25/24 11:02, Cédric Le Goater wrote:
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/vfio/ap.c | 10 +++-------
>   1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> index 7c4caa5938636937680fec87e999249ac84a4498..03f8ffaa5e2bf13cf8daa2f44aa4cf17809abd94 100644
> --- a/hw/vfio/ap.c
> +++ b/hw/vfio/ap.c
> @@ -77,7 +77,7 @@ static void vfio_ap_register_irq_notifier(VFIOAPDevice *vapdev,
>       size_t argsz;
>       IOHandler *fd_read;
>       EventNotifier *notifier;
> -    struct vfio_irq_info *irq_info;
> +    g_autofree struct vfio_irq_info *irq_info = NULL;
>       VFIODevice *vdev = &vapdev->vdev;
>   
>       switch (irq) {
> @@ -104,14 +104,14 @@ static void vfio_ap_register_irq_notifier(VFIOAPDevice *vapdev,
>       if (ioctl(vdev->fd, VFIO_DEVICE_GET_IRQ_INFO,
>                 irq_info) < 0 || irq_info->count < 1) {
>           error_setg_errno(errp, errno, "vfio: Error getting irq info");
> -        goto out_free_info;
> +        return;
>       }
>   
>       if (event_notifier_init(notifier, 0)) {
>           error_setg_errno(errp, errno,
>                            "vfio: Unable to init event notifier for irq (%d)",
>                            irq);
> -        goto out_free_info;
> +        return;
>       }
>   
>       fd = event_notifier_get_fd(notifier);
> @@ -122,10 +122,6 @@ static void vfio_ap_register_irq_notifier(VFIOAPDevice *vapdev,
>           qemu_set_fd_handler(fd, NULL, NULL, vapdev);
>           event_notifier_cleanup(notifier);
>       }
> -
> -out_free_info:
> -    g_free(irq_info);
> -
>   }
>   
>   static void vfio_ap_unregister_irq_notifier(VFIOAPDevice *vapdev,


