Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A3EAC25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 12:10:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9OIu-0002hp-KE; Tue, 21 May 2024 08:09:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9OIp-0002gW-MZ
 for qemu-devel@nongnu.org; Tue, 21 May 2024 08:09:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9OIn-0006Dw-Mh
 for qemu-devel@nongnu.org; Tue, 21 May 2024 08:09:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716293347;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jLQaY7nkWjy9lEUWEIE3YVgbTbFwC3zxDaWwzmE9vRQ=;
 b=AyQSdd7O5Gb5ppXPdUxu4edQ4MMM3gFaQV0fkLvK5rw6SdjZ74HE9eYNIspCb4ELcmzqtU
 eeIFXyzsym7TX4qb9hsQh2ebsFVA8PxKLIjVqUKfaUeJjmjHjgSQGcPBQz9YYky5HOi6Rs
 z91+6aA2vLsL56SGJUCzl0rfOmNrSUs=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-sVbK1NDGOdyVqZ2XTMLRjQ-1; Tue, 21 May 2024 08:09:05 -0400
X-MC-Unique: sVbK1NDGOdyVqZ2XTMLRjQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a5a1b50d45cso744171966b.2
 for <qemu-devel@nongnu.org>; Tue, 21 May 2024 05:09:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716293344; x=1716898144;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jLQaY7nkWjy9lEUWEIE3YVgbTbFwC3zxDaWwzmE9vRQ=;
 b=v/2tPKrlnplwOhy5BnF14f+f6YuKZJNncsriWCBNLO8y2P/p2QiF8dphF3BdoBZpNs
 IoWGR8X5ACtGQDch4heXNHZh4Y1TFe+UGVT4SuBoOtxuMgDAc+V2i03xbfE+tZYxxCCT
 Zqb2lX8FAu3Ly23KfJmJnZGVISbuKIYpuo5+dgOY4peVgxGAIJthx6fGxzU2D1kW7L/c
 W7I+jd9j+H0Myt/MOPeh/lW5/59iWMeuFLoWyKI1U2Vm62ZDRogWaC7XZ7ARlXJdsVZz
 uZYM4n5MAIbXdMSwXUjGRLtgDlXce4BuY9PgYu3kaOns1g9eMWBFciZ0SoVkbNakgv1p
 EfQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8PYTNqd+lTeqw2n+lNmWNPWIjKJhWF+Q4TDjULMb2LNxwJ/n5iqyeOxENl42YYEGWGkMnIPQQ1r5FuKPNsUXRJKtzjOI=
X-Gm-Message-State: AOJu0YxqDO5f1vUK2svdZT4NfyZuYskTNj1aw9w5ON0CGe67tftHbsSV
 eiGWuhKdIG5d3mOgoJ78fqwh3SLLqprmWUo5FF0zI+zaq84pN3V6nfOjSu3qR6Es1Uyag4zhsMF
 zvBhsPISKyMhcxdAstmV62cnYRwHLGM9KKOrVygPmnF9yjr3srt9d
X-Received: by 2002:a17:906:b79a:b0:a59:aa69:9790 with SMTP id
 a640c23a62f3a-a5a2d54c87fmr2001993066b.8.1716293344599; 
 Tue, 21 May 2024 05:09:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZkJ2Y03ETcUgFNp2hJ5Vb+BJboYiT9NmbXKrfEgRq/SL0M6y+G+3jRUKHOs1jZ8sznJAa6w==
X-Received: by 2002:a17:906:b79a:b0:a59:aa69:9790 with SMTP id
 a640c23a62f3a-a5a2d54c87fmr2001990966b.8.1716293344177; 
 Tue, 21 May 2024 05:09:04 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a60eabd3csm1210870466b.108.2024.05.21.05.09.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 May 2024 05:09:03 -0700 (PDT)
Message-ID: <b844ce2f-1363-46b1-877c-ab65d325e172@redhat.com>
Date: Tue, 21 May 2024 14:09:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/16] vfio/display: Fix error path in call site of
 ramfb_setup()
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, chao.p.peng@intel.com, 
 Gerd Hoffmann <kraxel@redhat.com>
References: <20240515082041.556571-1-zhenzhong.duan@intel.com>
 <20240515082041.556571-2-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240515082041.556571-2-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 5/15/24 10:20, Zhenzhong Duan wrote:
> vfio_display_dmabuf_init() and vfio_display_region_init() calls
> ramfb_setup() without checking its return value.
> 
> So we may run into a situation that vfio_display_probe() succeed
> but errp is set. This is risky and may lead to assert failure in
> error_setv().
> 
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Fixes: b290659fc3d ("hw/vfio/display: add ramfb support")
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/display.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/hw/vfio/display.c b/hw/vfio/display.c
> index 1aa440c663..57c5ae0b2a 100644
> --- a/hw/vfio/display.c
> +++ b/hw/vfio/display.c
> @@ -359,6 +359,9 @@ static int vfio_display_dmabuf_init(VFIOPCIDevice *vdev, Error **errp)
>                                             vdev);
>       if (vdev->enable_ramfb) {
>           vdev->dpy->ramfb = ramfb_setup(errp);
> +        if (!vdev->dpy->ramfb) {
> +            return -EINVAL;
> +        }
>       }
>       vfio_display_edid_init(vdev);
>       return 0;
> @@ -486,6 +489,9 @@ static int vfio_display_region_init(VFIOPCIDevice *vdev, Error **errp)
>                                             vdev);
>       if (vdev->enable_ramfb) {
>           vdev->dpy->ramfb = ramfb_setup(errp);
> +        if (!vdev->dpy->ramfb) {
> +            return -EINVAL;
> +        }
>       }
>       return 0;
>   }


