Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22840C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 13:54:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uETbw-0006nq-PU; Mon, 12 May 2025 09:54:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uETbm-0006hf-Ao
 for qemu-devel@nongnu.org; Mon, 12 May 2025 09:54:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uETbk-00038N-6v
 for qemu-devel@nongnu.org; Mon, 12 May 2025 09:54:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747058055;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=RioFIeog8UWwgpNpMyCCra5D3Nc/7fV3vgaGMiqgpTw=;
 b=WgCrFDd0kJzhI1yxtkx0hDUjg+DMzJHCskJSDTmQQVAcFST/VMpnhH2m4yFV/VKa8Gfdw0
 B6ViIv6RBRc7YzLSQQ7bkboRK9tmjJNRpdirteG3cvTyLwpuYIECJh1BVYKaSjAe3hlzNA
 OzXyjRmIo35gYH4Q6ZI+xsr8vcT0Imw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385--F9R6rv_MfetsL0DJ-_E_w-1; Mon, 12 May 2025 09:54:11 -0400
X-MC-Unique: -F9R6rv_MfetsL0DJ-_E_w-1
X-Mimecast-MFC-AGG-ID: -F9R6rv_MfetsL0DJ-_E_w_1747058050
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a205227595so506367f8f.3
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 06:54:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747058050; x=1747662850;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RioFIeog8UWwgpNpMyCCra5D3Nc/7fV3vgaGMiqgpTw=;
 b=U0qot2aLO4ylZ7oNUf3GMitsX1Z5ftvIXuNGMLvN1MvvfomCxd8PPV1BadwDOtlPrK
 Hc9wDJXyUviB5TnF/e/1Tu+9R09a9JPMifaHuGecLfe7m3M4SXGlsMVVivECpAD1JGJD
 K222AQPZnkPPTVl8+JkkXWLnAgWPpAQoTv/rQjDa8Yt9tCQGLX5RvaMDJS5bDPuOh3t6
 riXMMaO2KQZ6cqVY10dwHuaEpAPC5MWXwyGnHHZkSnzN4+brcqqKRlk264dOqkn/R00A
 O7t3xk6A8wpOTGGz4ar9NESiGnwoVXFXqaIMhmKFHWWkLkXeOHr0PNmHE22UzD2PkcMF
 o5tA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiIl5TpzRvqKdLUegaJWbFvvNOpn+g+ypQSH5BF3gKkzKYbH9Zu9My3UDfTMqD2DTJQnnyaRuaBNzS@nongnu.org
X-Gm-Message-State: AOJu0YwbyHe0N2qJJD5nwKqCVRjuYtfXuezKGP6Ka5wbjr36eTjb/y6Q
 2BKWeNDrFNb2Us6dgeo++2ogjuaRlSk0R9X94LhKPRSibDb2KoApl74k+oJhTkEAOj9uMYSysyL
 eqxwGztd6zcw95iVUj1De7uanwrAOvIWavQal865yy6nkNMvdjKrU
X-Gm-Gg: ASbGncs5MEmp121ITAhvN3W+K2rcvNBYi2omeYsI286NVSMQLwT20mIQZ5NAV2htd0S
 gQmruvJZid7NLR5ZRQ6jbNeNB6NiqTYhTpdVNU1twEwW7wYleaqqmcwdX+79SSUR8c/dTmmzc4Q
 2XylupujD2FSplPrhwXGXj+nRSojWR617x1e4OQ2yYCD17M/KvP2mjVZ8e63H/xoL7GlJyXTXim
 w1LZ3lfaZgns5wh4DcvhT4716Xnh4m7c+plMtjOJ2Qd5dL0OV3mzTpSn9su5UwlvUlAOxHpqcur
 FGIEkkRNuwA/7kQuM1zVPfnj0Cnxknm09vnFtMDLAl++o2RMVA==
X-Received: by 2002:a5d:5984:0:b0:3a1:f537:45ea with SMTP id
 ffacd0b85a97d-3a1f643cb61mr11327179f8f.25.1747058050231; 
 Mon, 12 May 2025 06:54:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHK++ywRGHXD/aSAOXs1ewphGZ0a9dA6JhwcQOzaeyQAaREjRcocxKC6MjndkhpY99hF8sAyA==
X-Received: by 2002:a5d:5984:0:b0:3a1:f537:45ea with SMTP id
 ffacd0b85a97d-3a1f643cb61mr11327161f8f.25.1747058049910; 
 Mon, 12 May 2025 06:54:09 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f5a4c78fsm12643030f8f.97.2025.05.12.06.54.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 May 2025 06:54:09 -0700 (PDT)
Message-ID: <1648e6dd-6983-46e6-8bc2-d079e63673cb@redhat.com>
Date: Mon, 12 May 2025 15:54:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v8 6/6] s390: implementing CHSC SEI for AP config
 change
To: Rorie Reyes <rreyes@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, thuth@redhat.com, akrowiak@linux.ibm.com
References: <20250509163645.33050-1-rreyes@linux.ibm.com>
 <20250509163645.33050-7-rreyes@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250509163645.33050-7-rreyes@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.551,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 5/9/25 18:36, Rorie Reyes wrote:
> Handle interception of the CHSC SEI instruction for requests
> indicating the guest's AP configuration has changed.
> 
> If configuring --without-default-devices, hw/s390x/ap-stub.c
> was created to handle such circumstance. Also added the
> following to hw/s390x/meson.build if CONFIG_VFIO_AP is
> false, it will use the stub file.
> 
> Signed-off-by: Rorie Reyes <rreyes@linux.ibm.com>
> ---
>   MAINTAINERS           |  1 +
>   hw/s390x/ap-stub.c    | 23 +++++++++++++++++++++++
>   hw/s390x/meson.build  |  1 +
>   target/s390x/ioinst.c | 11 +++++++++--
>   4 files changed, 34 insertions(+), 2 deletions(-)
>   create mode 100644 hw/s390x/ap-stub.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 23174b4ca7..070c746c69 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -112,6 +112,7 @@ F: hw/intc/s390_flic.c
>   F: hw/intc/s390_flic_kvm.c
>   F: hw/s390x/
>   F: hw/vfio/ap.c
> +F: hw/s390x/ap-stub.c
>   F: hw/vfio/ccw.c
>   F: hw/watchdog/wdt_diag288.c
>   F: include/hw/s390x/
> diff --git a/hw/s390x/ap-stub.c b/hw/s390x/ap-stub.c
> new file mode 100644
> index 0000000000..9d2c4c2e67
> --- /dev/null
> +++ b/hw/s390x/ap-stub.c
> @@ -0,0 +1,23 @@
> +/*
> + * VFIO based AP matrix device assignment
> + *
> + * Copyright 2025 IBM Corp.
> + * Author(s): Rorie Reyes <rreyes@linux.ibm.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or (at
> + * your option) any later version. See the COPYING file in the top-level
> + * directory.

SPDX-License-Identifier is missing.


Thanks,

C.



> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/s390x/ap-bridge.h"
> +
> +int ap_chsc_sei_nt0_get_event(void *res)
> +{
> +    return 0;
> +}
> +
> +int ap_chsc_sei_nt0_have_event(void)
> +{
> +    return 0;
> +}
> diff --git a/hw/s390x/meson.build b/hw/s390x/meson.build
> index 3bbebfd817..99cbcbd7d6 100644
> --- a/hw/s390x/meson.build
> +++ b/hw/s390x/meson.build
> @@ -33,6 +33,7 @@ s390x_ss.add(when: 'CONFIG_S390_CCW_VIRTIO', if_true: files(
>   ))
>   s390x_ss.add(when: 'CONFIG_TERMINAL3270', if_true: files('3270-ccw.c'))
>   s390x_ss.add(when: 'CONFIG_VFIO', if_true: files('s390-pci-vfio.c'))
> +s390x_ss.add(when: 'CONFIG_VFIO_AP', if_false: files('ap-stub.c'))
>   
>   virtio_ss = ss.source_set()
>   virtio_ss.add(files('virtio-ccw.c'))
> diff --git a/target/s390x/ioinst.c b/target/s390x/ioinst.c
> index fe62ba5b06..2320dd4c12 100644
> --- a/target/s390x/ioinst.c
> +++ b/target/s390x/ioinst.c
> @@ -18,6 +18,7 @@
>   #include "trace.h"
>   #include "hw/s390x/s390-pci-bus.h"
>   #include "target/s390x/kvm/pv.h"
> +#include "hw/s390x/ap-bridge.h"
>   
>   /* All I/O instructions but chsc use the s format */
>   static uint64_t get_address_from_regs(CPUS390XState *env, uint32_t ipb,
> @@ -574,13 +575,19 @@ out:
>   
>   static int chsc_sei_nt0_get_event(void *res)
>   {
> -    /* no events yet */
> +    if (s390_has_feat(S390_FEAT_AP)) {
> +        return ap_chsc_sei_nt0_get_event(res);
> +    }
> +
>       return 1;
>   }
>   
>   static int chsc_sei_nt0_have_event(void)
>   {
> -    /* no events yet */
> +    if (s390_has_feat(S390_FEAT_AP)) {
> +        return ap_chsc_sei_nt0_have_event();
> +    }
> +
>       return 0;
>   }
>   


