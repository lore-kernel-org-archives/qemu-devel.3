Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01AEEC02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 08:38:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbFBn-0007nv-Le; Fri, 24 Jan 2025 03:37:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tbFBm-0007nC-6O
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 03:37:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tbFBk-00044W-31
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 03:37:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737707834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=DYKSjl956xdlwTAokpbefqJ/LiVAddWW87QGsX7x6QI=;
 b=M/BZbuGujXK7VL89sNU9CKUr7EZUqM2yF6h02Dg3Thnljb6E95MJXjzeffQ+EfHaDLYWDM
 jMfSj5C822I3n4AHIw9rmRi9DArHdW2/s8S7D1dIlLr6+RelCWUfFWOZAOaz4PjkCCCHPl
 /Sv7H/KM+EqqePTht/H7iKIMthogzu8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-UfF1zHJxPWK1d7PpWVcVvw-1; Fri, 24 Jan 2025 03:37:12 -0500
X-MC-Unique: UfF1zHJxPWK1d7PpWVcVvw-1
X-Mimecast-MFC-AGG-ID: UfF1zHJxPWK1d7PpWVcVvw
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4362552ce62so8513185e9.0
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 00:37:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737707831; x=1738312631;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DYKSjl956xdlwTAokpbefqJ/LiVAddWW87QGsX7x6QI=;
 b=bABQSa1bCqQ/QfObIE7xip5WY7EqafXtOYghrzixSrXSB6TvVgppkeJX1uRsvY/KCk
 TmALdQsCyDGTm0F0E9A1fHi1eTK9NkV8TNYA/YuSqmOAiWPugmfiP/BRzPjFKaH34q5P
 zdV+Yn3d8TfYR4Xzrz7lI9CF6tTKeW83pnKX3ss+GvKcT/Nmd7U1NpYIa9cw49t7CO4P
 ZVck9rIUWo2cLMpYq5ZTfcK7lGkyj8IqrWG8LewkiygidGsjxHH8LXpb91EoHV24t2UW
 gDB3IUQrwnEVBns6+mUQ+hwtMF+X4QKGUUrb7JovmvDjqe0KnJmfCbfabU2zCoiJwRhs
 zMDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnsD0Qua/weORtMAHeWxVzWz6oNJx8n2bUBL19wHmS5K3108Xaty9hHUYF1Z0EgRDmDZ7jJI/VmsJf@nongnu.org
X-Gm-Message-State: AOJu0Yyu17ZFm+c75GSDau+lz8UJwAoFdfsx6AyG/XAmoeepS7f5P23i
 pMZ1AXnx7fg1effemOPwTF0gwqvIed/VFT8bEwY8j0ul9mr+dFeLgXghSs/X9EBTj5Hm3ui1Ifv
 fL+i/ubZqykreO+Q+M6zal3Pfg79xaR5e47eyeOVttrrzdgyhtZfK
X-Gm-Gg: ASbGncs7dUVEd+BcN2ZiWi6dRZAAEPA4Lz6rNHJCupbV9z/xUUz6WaVtFABysmXrEjk
 9nipWDWn9FcY98c6Fa2AfBWed1SkVPkfRsjLatUtBez/DBRMAgOVfdo6WaSMatQBlDEREcwDbCb
 l0a1JxMSrhFgpHUtL5t90lGow7MmBivhDXOG9DsYAD/GXFDMaZUpLiQfzCKbc/Td4ArlX6W1oJl
 ZYrBl3DtLT5B1oNDOJDMHzxCvuF28DS23e5aeMYgs4Fgo5R3+r088RjDFj0SLUpZEO268jm6aKr
 5MuOkOQzMcoiA4ihnD5gf1sWOB1bmOAT
X-Received: by 2002:a05:600c:4e08:b0:435:136:75f6 with SMTP id
 5b1f17b1804b1-438912d5426mr317545345e9.0.1737707831617; 
 Fri, 24 Jan 2025 00:37:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGnvSNNmkrQg9mktXUpOQYjfvL0t7E4RxW1pgSH4ekJFaDZtqX3NWfKHXACbPLG0wKRU3yIyQ==
X-Received: by 2002:a05:600c:4e08:b0:435:136:75f6 with SMTP id
 5b1f17b1804b1-438912d5426mr317545085e9.0.1737707831246; 
 Fri, 24 Jan 2025 00:37:11 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd48a145sm19029625e9.16.2025.01.24.00.37.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jan 2025 00:37:10 -0800 (PST)
Message-ID: <25ef744b-16f4-4a07-a8a0-cba3fc537cea@redhat.com>
Date: Fri, 24 Jan 2025 09:37:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/5] hw/vfio/ap: store object indicating AP config
 changed in a queue
To: Rorie Reyes <rreyes@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, thuth@redhat.com, akrowiak@linux.ibm.com
References: <20250107184354.91079-1-rreyes@linux.ibm.com>
 <20250107184354.91079-4-rreyes@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250107184354.91079-4-rreyes@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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

On 1/7/25 19:43, Rorie Reyes wrote:
> Creates an object indicating that an AP configuration change event
> has been received and stores it in a queue. These objects will later
> be used to store event information for an AP configuration change
> when the CHSC instruction is intercepted.
> 
> Signed-off-by: Rorie Reyes <rreyes@linux.ibm.com>
> Reviewed-by: Anthony Krowiak <akrowiak@linux.ibm.com>
> Tested-by: Anthony Krowiak <akrowiak@linux.ibm.com>
> ---
>   hw/vfio/ap.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> index 533cadb2dd..508c6eed7a 100644
> --- a/hw/vfio/ap.c
> +++ b/hw/vfio/ap.c
> @@ -41,6 +41,13 @@ struct VFIOAPDevice {
>       EventNotifier cfg_notifier;
>   };
>   
> +typedef struct APConfigChgEvent {
> +    QTAILQ_ENTRY(APConfigChgEvent) next;
> +} APConfigChgEvent;
> +
> +QTAILQ_HEAD(, APConfigChgEvent) cfg_chg_events =
> +    QTAILQ_HEAD_INITIALIZER(cfg_chg_events);
> +
>   OBJECT_DECLARE_SIMPLE_TYPE(VFIOAPDevice, VFIO_AP_DEVICE)
>   
>   static void vfio_ap_compute_needs_reset(VFIODevice *vdev)
> @@ -76,6 +83,9 @@ static void vfio_ap_cfg_chg_notifier_handler(void *opaque)
>   {
>       VFIOAPDevice *vapdev = opaque;
> 

Extra white line ^

> +    APConfigChgEvent *new_event = g_new0(APConfigChgEvent, 1);

minor comment :

I would use the same variable name for APConfigChgEvent in this patch
and following. Easier to read. So, rename 'new_event' to 'cfg_chg_event'
or 'event'.

Thanks,

C.


> +
> +    QTAILQ_INSERT_TAIL(&cfg_chg_events, new_event, next);
>       if (!event_notifier_test_and_clear(&vapdev->cfg_notifier)) {
>           warn_report("Event notifier not initialized");
>           return;


