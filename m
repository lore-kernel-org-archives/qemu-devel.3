Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D82FC54E65
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 13:36:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI65O-0007o0-Qf; Thu, 22 May 2025 09:35:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uI65L-0007nK-4p
 for qemu-devel@nongnu.org; Thu, 22 May 2025 09:35:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uI65I-0001Hn-CS
 for qemu-devel@nongnu.org; Thu, 22 May 2025 09:35:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747920941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=YTDH19IWN+kKj4OHFjs1ZK3wsT7lv36lVkF84MH3yWg=;
 b=Zv3sy9e2o7FcgpzXfLiahvth4Tlnsi9hwIbrCHlPcWJe6A9MeGwbE1qO8UbSjDbGzn7pir
 L8ryZyBbXDYAyB3UToOCTb07a6Y1SZ4HqYx2UdJGbc3o7n9P9bk84fXJ666l8qXe3hZSu9
 IeAHkaA/57SgZf7Dsodup4lYtuXQc/c=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-4rQo1qk2NAma6spH5PK8Vw-1; Thu, 22 May 2025 09:35:40 -0400
X-MC-Unique: 4rQo1qk2NAma6spH5PK8Vw-1
X-Mimecast-MFC-AGG-ID: 4rQo1qk2NAma6spH5PK8Vw_1747920939
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a362939f61so3196326f8f.3
 for <qemu-devel@nongnu.org>; Thu, 22 May 2025 06:35:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747920939; x=1748525739;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YTDH19IWN+kKj4OHFjs1ZK3wsT7lv36lVkF84MH3yWg=;
 b=FJiUs9Qmj3W3IDbq0eOAsgHvvzAksPSXH/o8MB1yp/rL0rySWN0QWgTzC9C9BZEwvp
 F3DP8FExCIPTp1yzkbwLQoBvFoiRvb5ccn/WC66uLvLM/Wl7Gq/5qXMhQJiJLBIE9ovE
 R4h8WJqNFQe9Zz5h90l0QW2VYp4ke3g+WViUwzGkKEXfAxrHLc9Mi9UUQ235XDlOQtNE
 ug2dAkV/H+6tYEs9GC6KORu+/ckvoxnLtAWLhZEFhX6WcQ0uU0v2mlQsTVqH8Xp4+M2S
 GOKEb6EvN0C9KCZS5fAO5vh4765gdoZ7jN0dnfYHGFACMYGEnlAVl2WVr8ZHQ6fHI2qv
 O8VQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWq+fgIUgvprjJN/KQ7WgBT1p98HF3H/IOs8NvkuJ3va6qPTbOAHJkHoZxmhswGcosbqJvtfeq6y6uv@nongnu.org
X-Gm-Message-State: AOJu0YwI1xU4ZKmQg0TXSssDDbXwUrFLBxgMQJFWxsu29mCMbX/jLg7I
 D7+V+T/tPmjY02Eh0wE6XELzDvxuqvfI9isrzeX3Y62Pv7y6WdzNyPq5Qeoyw7pvu3omT72bzSV
 6pnQgjUj3Ysgz1ucBQMFlN45/Rjs+dX2VeAu8VCPJz0LS3t6hT3CUecAe
X-Gm-Gg: ASbGncsIY+/cdEviUgQ9ZYy0MXWAa7R9bd/+pLSQIhyjh5jBvElb44DbhxcCD3dKveQ
 /oFLzb1cq9cDnggq8rinG8sxXOrTMZkseULyqinGUNC5lnnkATb4ixXSTzWdQ/xlxJkqiQwAUqy
 hhYIfoZIFp7vpK+oc7j27SJjwp+rX/qjUwIj396DekIt4Nw6W9zFDssq/lQfrUdPo6tqWYfhsDp
 /JHCZBTbMrqmVKSE+IoSn+Ob2WTVYK9dyBRHUHsGP3hsU6l7YVQVvJ/Cupi5pWPplJfBAgoej01
 uT/onWKHFuwCzVigeT65SZ77XdqXLMDwwuMNZf/jQ7TjllFGAw==
X-Received: by 2002:a05:6000:3112:b0:3a2:133:b17d with SMTP id
 ffacd0b85a97d-3a35fe796b6mr23801708f8f.14.1747920938831; 
 Thu, 22 May 2025 06:35:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0VriZhQBFtDBWwo2pEZXatnKA5nv4acVEjszPdpZvVosYq3Md8EgbCQCmE7QMA3TFdRdi+g==
X-Received: by 2002:a05:6000:3112:b0:3a2:133:b17d with SMTP id
 ffacd0b85a97d-3a35fe796b6mr23801662f8f.14.1747920938427; 
 Thu, 22 May 2025 06:35:38 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a366e08747sm20021853f8f.95.2025.05.22.06.35.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 May 2025 06:35:37 -0700 (PDT)
Message-ID: <f94d3555-2f09-4620-b0e7-19fbdae86323@redhat.com>
Date: Thu, 22 May 2025 15:35:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v9 3/4] hw/vfio/ap: Storing event information for an
 AP configuration change event
To: Rorie Reyes <rreyes@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, thuth@redhat.com, akrowiak@linux.ibm.com
References: <20250512180230.50129-1-rreyes@linux.ibm.com>
 <20250512180230.50129-4-rreyes@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250512180230.50129-4-rreyes@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.275,
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

On 5/12/25 20:02, Rorie Reyes wrote:
> These functions can be invoked by the function that handles interception
> of the CHSC SEI instruction for requests indicating the accessibility of
> one or more adjunct processors has changed.
> 
> Signed-off-by: Rorie Reyes <rreyes@linux.ibm.com>
> ---
>   hw/vfio/ap.c                 | 39 ++++++++++++++++++++++++++++++++++++
>   include/hw/s390x/ap-bridge.h | 22 ++++++++++++++++++++
>   2 files changed, 61 insertions(+)
> 
> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> index 5ea5dd9cca..4f88f80c54 100644
> --- a/hw/vfio/ap.c
> +++ b/hw/vfio/ap.c
> @@ -96,6 +96,45 @@ static void vfio_ap_cfg_chg_notifier_handler(void *opaque)
>   
>   }
>   
> +int ap_chsc_sei_nt0_get_event(void *res)
> +{
> +    ChscSeiNt0Res *nt0_res  = (ChscSeiNt0Res *)res;
> +    APConfigChgEvent *cfg_chg_event;
> +
> +    if (!ap_chsc_sei_nt0_have_event()) {
> +        return 1;
> +    }
> +
> +    cfg_chg_event = QTAILQ_FIRST(&cfg_chg_events);
> +    memset(nt0_res, 0, sizeof(*nt0_res));
> +
> +    QTAILQ_REMOVE(&cfg_chg_events, cfg_chg_event, next);
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
> +    return 0;
> +

extra white line ^

and returning a bool would make more sense.

> +}
> +
> +int ap_chsc_sei_nt0_have_event(void)
> +{
> +    return !QTAILQ_EMPTY(&cfg_chg_events);

same here for the bool.

> +}
> +
>   static bool vfio_ap_register_irq_notifier(VFIOAPDevice *vapdev,
>                                             unsigned int irq, Error **errp)
>   {
> diff --git a/include/hw/s390x/ap-bridge.h b/include/hw/s390x/ap-bridge.h
> index 470e439a98..f4d838bf99 100644
> --- a/include/hw/s390x/ap-bridge.h
> +++ b/include/hw/s390x/ap-bridge.h
> @@ -16,4 +16,26 @@
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
> +#define NT0_RES_RESPONSE_CODE 1;
> +#define NT0_RES_NT_DEFAULT    0;
> +#define NT0_RES_RS_AP_CHANGE  5;
> +#define NT0_RES_CC_AP_CHANGE  3;
> +
> +int ap_chsc_sei_nt0_get_event(void *res);

Documentation would be nice to have since a "return 1" means failure.

> +
> +int ap_chsc_sei_nt0_have_event(void);
> +>   #endif


Thanks,

C.



