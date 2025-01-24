Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57328C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 08:44:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbFI1-0000rD-BJ; Fri, 24 Jan 2025 03:43:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tbFHx-0000qO-6Z
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 03:43:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tbFHv-0004sD-8I
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 03:43:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737708217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=4XLPKfjV6KfFtmJERY5VFZ8W/kvpm6/D7BF1FPv2DS0=;
 b=Q/99LtacGejvXcKBstrexxDLdivc56W6gmieJQtN2ba6wawZFxcJLK9UscwG3gojSCaFJs
 qRadUbtCqIbjzB/YMiFfRr3XLn4f4I3zm5P13Ke9vdw4XBRjdHWfwJHWpQ2+8DWttmgDYh
 EtC1Msv5rmm8zwQqmMFsFJo4taW/Cfk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-3VD2o-eNNJmgNpmAxwQWSw-1; Fri, 24 Jan 2025 03:43:35 -0500
X-MC-Unique: 3VD2o-eNNJmgNpmAxwQWSw-1
X-Mimecast-MFC-AGG-ID: 3VD2o-eNNJmgNpmAxwQWSw
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4362153dcd6so8768115e9.2
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 00:43:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737708214; x=1738313014;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4XLPKfjV6KfFtmJERY5VFZ8W/kvpm6/D7BF1FPv2DS0=;
 b=NXnnyCeS/iEG0GJdPsw/Ay6+2ww4nHjciMBpv/heCy/LEaSAgSipD+n65pvTUjwxUi
 Z2kHCloA2gkuWUQvGjLf+i1pvcVMx+jdC1Re821qt+jo60/w72T47+r3UGoNVfKfe7/R
 RF2/h3tMJKh9kfACAUQT9noINbst4Oyq4scoFJqjGzE4OFKem9UBPb60Ra52qdJpYATg
 4Nc6FwOjHtj335M/jeKNhTkDOQ5pnIf2RQv9bN6yvEjusoduuuSn+owFSHSqQQoL0PIV
 sVbD2lk5JgAADvP7Y3xMOMLvVKcCDzN3qGyfdnaye4yNnRg6VdsW9UWRrGW/FM1gsyt5
 wgxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAQ76WZlbcFucKl0VuB2lt01KLK4+ehOh7EBXmN6mRgI3VPMUbEuWsg46ivAlfO5oayI0kqnvKVt+9@nongnu.org
X-Gm-Message-State: AOJu0YyAduLGWa4KrXg+xdbUgFqcBy81LPuysqKJ82PEgge5Ma9OkrUD
 EtwB3Y9KlGXm1wLAiDCijG+IFl9B6bQLTmFEuu7zDedMJmJt8qrQwF6uWALb/EVoOgt2EDhlUGJ
 xL4M4OTLZKCUpKHGItMUv3M19E5Wyvx56R+P23Va1s3oT0DWu8KGrsQ3rrDk1
X-Gm-Gg: ASbGncve8GBP6eSwprF9LYit8Gf4JSbrdNxYAXxsxsuLfiTkg4mxaGVJHrPxrrNQXUp
 RtUGoVoJqHm++997NC/GFhFhoruA0IOgy14aObd4u26e8mUzgGGC0PYpqUkfRB4fsmNyWItPJlZ
 Ca+vB+QQVofaf2PSyz9NyGDwNrFmap/A9h4Yj8385WirBwRDR/zN3P6X7f0jCN8cmrDfXDfA9zY
 asW/WxhaaRwVSwZJVC2bIJ0/0sVs05PGUXJAypwvJln8lAWz651LRIMi3+6fi2mlRFIaec/VoDd
 tISwZyL/8yZWiQcaCzqznm4fazD3hSrZ
X-Received: by 2002:a05:600c:1c93:b0:42a:a6d2:3270 with SMTP id
 5b1f17b1804b1-43891426ebcmr224343375e9.21.1737708213870; 
 Fri, 24 Jan 2025 00:43:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHTzZjJXBtGLwz2g7ukKSGPu2fnZGJJlQcI2QaC2zlbx1xhbETGrA/ERbsJG+/1RF2paDfBrg==
X-Received: by 2002:a05:600c:1c93:b0:42a:a6d2:3270 with SMTP id
 5b1f17b1804b1-43891426ebcmr224343195e9.21.1737708213553; 
 Fri, 24 Jan 2025 00:43:33 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd48574csm19189725e9.9.2025.01.24.00.43.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jan 2025 00:43:33 -0800 (PST)
Message-ID: <83e92dbd-0ff2-41cd-995d-af55c72c711b@redhat.com>
Date: Fri, 24 Jan 2025 09:43:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/5] hw/vfio/ap: Storing event information for an AP
 configuration change event
To: Rorie Reyes <rreyes@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, thuth@redhat.com, akrowiak@linux.ibm.com
References: <20250107184354.91079-1-rreyes@linux.ibm.com>
 <20250107184354.91079-5-rreyes@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250107184354.91079-5-rreyes@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.043,
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
> These functions can be invoked by the function that handles interception
> of the CHSC SEI instruction for requests indicating the accessibility of
> one or more adjunct processors has changed.
> 
> Signed-off-by: Rorie Reyes <rreyes@linux.ibm.com>
> ---
>   hw/vfio/ap.c                 | 37 ++++++++++++++++++++++++++++++++++++
>   include/hw/s390x/ap-bridge.h | 17 +++++++++++++++++
>   2 files changed, 54 insertions(+)
> 
> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> index 508c6eed7a..9d1e18f100 100644
> --- a/hw/vfio/ap.c
> +++ b/hw/vfio/ap.c
> @@ -94,6 +94,43 @@ static void vfio_ap_cfg_chg_notifier_handler(void *opaque)
>       css_generate_css_crws(0);
>   }
>   
> +int ap_chsc_sei_nt0_get_event(void *res)
> +{
> +    APConfigChgEvent *cfg_chg_event = QTAILQ_FIRST(&cfg_chg_events);
> +    ChscSeiNt0Res *nt0_res  = (ChscSeiNt0Res *)res;
> +    memset(nt0_res, 0, sizeof(*nt0_res));

please put the memset after the variables.

> +    int rc = 1;

'rc' is not very useful. Why not simply return 0 or 1 ?

> +
> +    if (cfg_chg_event) {

I would reverse the logic and return early.

      if (! cfg_chg_event) {
          return 1;
      }


> +        QTAILQ_REMOVE(&cfg_chg_events, cfg_chg_event, next);
> +        free(cfg_chg_event);

g_free()

> +
> +        /*
> +         * If there are any AP configuration change events in the queue,
> +         * indicate to the caller that there is pending event info in
> +         * the response block
> +         */
> +        if (!QTAILQ_EMPTY(&cfg_chg_events)) {
> +            nt0_res->flags |= PENDING_EVENT_INFO_BITMASK;
> +        }
> +
> +        nt0_res->length = sizeof(ChscSeiNt0Res);
> +        nt0_res->code = 1;
> +        nt0_res->nt = 0;
> +        nt0_res->rs = 5;
> +        nt0_res->cc = 3;

The above values are cryptic. Can we have some define possibly ?

> +        rc = 0;
> +    }
> +
> +    return rc;
> +}
> +
> +int ap_chsc_sei_nt0_have_event(void)
> +{
> +    return !QTAILQ_EMPTY(&cfg_chg_events);
> +}

Why not use this routine in ap_chsc_sei_nt0_get_event() too ?



Thanks,

C.


>   static bool vfio_ap_register_irq_notifier(VFIOAPDevice *vapdev,
>                                             unsigned int irq, Error **errp)
>   {
> diff --git a/include/hw/s390x/ap-bridge.h b/include/hw/s390x/ap-bridge.h
> index 470e439a98..c9beec3db4 100644
> --- a/include/hw/s390x/ap-bridge.h
> +++ b/include/hw/s390x/ap-bridge.h
> @@ -16,4 +16,21 @@
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
> +int ap_chsc_sei_nt0_get_event(void *res);
> +
> +int ap_chsc_sei_nt0_have_event(void);
> +
>   #endif


