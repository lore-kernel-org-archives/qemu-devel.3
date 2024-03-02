Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C9ACC5478C
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Mar 2024 15:35:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgRNM-0005kg-Ih; Sat, 02 Mar 2024 10:34:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rgRNH-0005j1-HI
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 10:34:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rgRN9-0006XT-CX
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 10:34:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709393637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=54pAYSo8hZvMTDgBLslAFWG2BSBhNyIksapSarakzGo=;
 b=SnPYqAhKtfPXFEEpQJBGbdqDU/F7jI/y983uHPZ8UrfqKpAOqbKy1lduuiSm+8aN0sxEEw
 wlssLIQq9asqhhLqb2n/27+dtmZQQp96y5g8uWPZCV4AJ5AbvGPfsdWHcFyl7hrTK8PFNu
 xxjPQmazv071DB1U68xt2uoH9dB7O+E=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-py4iv8aoPPuVlfgI02yX4g-1; Sat, 02 Mar 2024 10:33:56 -0500
X-MC-Unique: py4iv8aoPPuVlfgI02yX4g-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a450265c7b6so5702666b.0
 for <qemu-devel@nongnu.org>; Sat, 02 Mar 2024 07:33:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709393635; x=1709998435;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=54pAYSo8hZvMTDgBLslAFWG2BSBhNyIksapSarakzGo=;
 b=Z6SyTlSE1uLxM3U1/KxqLAbl5jlz/2tbQb0vnCLVpzEQO6CUOPWQ3yVj82k7V4oCB7
 q8ezcHL+vig37d3K+Nt1wp7X3bR6yFsdOxSJ7kX6owhs7hze5YID/KRkUx5SBFPKHGU7
 mWyyuq/R4z9Ff71LLHHDnfR2FxMYMxK1ia2t2FnxQPnVrur0f42hCZkvIcvkXGu2cj69
 93GuKasn80DnduM3WhsLPjmHD4AboBfW+Q0M5UvMyvzNtA2h+u19PAG1hq6rnYMpw+QJ
 QNFT3WJ/Y271KdfTIW4poEKyTmaCZI4yWB9ihkKwdquZVHPMBM5HkvvX5Rnm9S7kLzUA
 +vpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4d96e4rE10F63uwR22DiHdnNoTOzJLUDODZ98b6yQZ0WO34Fbibo9gzxXoSwXdYc+qaVE53V0t/5zm2iNuhs44Xm0+jE=
X-Gm-Message-State: AOJu0YwMjeCQDxkhYSH429CBHrzy2nhwrKfcK3vDTIsJRlHQVE3GMJSo
 zF7eTSZ6QiFoECSrGUTwyTe/JmWBE8Mq2lLxjhvCooNy7/K6sgsXviHM0EgJW553bi3HmfiiNha
 FgsGVh+BCnM3JX/2tUaNvmjZuTROmujsO6bZulc8jV4KYcHPkoDvh
X-Received: by 2002:a17:906:dfc1:b0:a44:e5fc:d4e4 with SMTP id
 jt1-20020a170906dfc100b00a44e5fcd4e4mr976698ejc.33.1709393635204; 
 Sat, 02 Mar 2024 07:33:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmkLG0ADS//phIihupprRmTdKDr7lei2HdGBD9Ojq2gCroQrWFywMWB7BibZ5JMDDxDS/mJQ==
X-Received: by 2002:a17:906:dfc1:b0:a44:e5fc:d4e4 with SMTP id
 jt1-20020a170906dfc100b00a44e5fcd4e4mr976671ejc.33.1709393634840; 
 Sat, 02 Mar 2024 07:33:54 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-178-133.web.vodafone.de.
 [109.43.178.133]) by smtp.gmail.com with ESMTPSA id
 ag3-20020a1709069a8300b00a44790d06d3sm1918149ejc.71.2024.03.02.07.33.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 02 Mar 2024 07:33:54 -0800 (PST)
Message-ID: <65fee13a-f927-4791-a3a9-132f53ad5ae0@redhat.com>
Date: Sat, 2 Mar 2024 16:33:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 5/8] virtio-ccw: Handle extra notification data
To: Jonah Palmer <jonah.palmer@oracle.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, jasowang@redhat.com, eperezma@redhat.com,
 si-wei.liu@oracle.com, boris.ostrovsky@oracle.com, raphael@enfabrica.net,
 kwolf@redhat.com, hreitz@redhat.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 cohuck@redhat.com, pbonzini@redhat.com, fam@euphon.net, stefanha@redhat.com,
 qemu-block@nongnu.org, qemu-s390x@nongnu.org, virtio-fs@lists.linux.dev
References: <20240301134330.4191007-1-jonah.palmer@oracle.com>
 <20240301134330.4191007-6-jonah.palmer@oracle.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240301134330.4191007-6-jonah.palmer@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.094,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 01/03/2024 14.43, Jonah Palmer wrote:
> Add support to virtio-ccw devices for handling the extra data sent from
> the driver to the device when the VIRTIO_F_NOTIFICATION_DATA transport
> feature has been negotiated.
> 
> The extra data that's passed to the virtio-ccw device when this feature
> is enabled varies depending on the device's virtqueue layout.
> 
> That data passed to the virtio-ccw device is in the same format as the
> data passed to virtio-pci devices.
> 
> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
> ---
>   hw/s390x/s390-virtio-ccw.c | 18 ++++++++++++++----
>   1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 62804cc228..b8e193956c 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -140,9 +140,11 @@ static void subsystem_reset(void)
>   static int virtio_ccw_hcall_notify(const uint64_t *args)
>   {
>       uint64_t subch_id = args[0];
> -    uint64_t queue = args[1];
> +    uint64_t data = args[1];
>       SubchDev *sch;
> +    VirtIODevice *vdev;
>       int cssid, ssid, schid, m;
> +    uint16_t vq_idx;
>   
>       if (ioinst_disassemble_sch_ident(subch_id, &m, &cssid, &ssid, &schid)) {
>           return -EINVAL;
> @@ -151,12 +153,20 @@ static int virtio_ccw_hcall_notify(const uint64_t *args)
>       if (!sch || !css_subch_visible(sch)) {
>           return -EINVAL;
>       }
> -    if (queue >= VIRTIO_QUEUE_MAX) {
> +
> +    vdev = virtio_ccw_get_vdev(sch);
> +    if (virtio_vdev_has_feature(vdev, VIRTIO_F_NOTIFICATION_DATA)) {
> +        vq_idx = data & 0xFFFF;
> +        virtio_set_notification_data(vdev, vq_idx, data);
> +    } else {
> +        vq_idx = data;
> +    }
> +
> +    if (vq_idx >= VIRTIO_QUEUE_MAX) {
>           return -EINVAL;
>       }
> -    virtio_queue_notify(virtio_ccw_get_vdev(sch), queue);
> +    virtio_queue_notify(vdev, vq_idx);
>       return 0;
> -
>   }

Acked-by: Thomas Huth <thuth@redhat.com>



