Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22AE3C54798
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Mar 2024 15:35:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgROU-0006SA-T9; Sat, 02 Mar 2024 10:35:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rgROT-0006N6-2I
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 10:35:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rgROP-00083H-FO
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 10:35:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709393712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+Ysx85g/W0kQzYguGb7KsJTcMOviltiNzvv6o9/n7kQ=;
 b=fzg6phpU3Q7OR+zLA6T5tgUywQR5a0Tca4aWDcr8c8+w+9B7Lq4E0J6AUvsGBVGMl61sG7
 G1SAR368cIuxbkXRKYOjNNuHq9bz40aV95oxSmaauFs0VlRe7J/y0e59uom/neLr0aUfiT
 RF9G8L1oD1Xr/GMB5kPECmUtxak4t7k=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-3EnshH-XN6mbjEqMwocO9Q-1; Sat, 02 Mar 2024 10:35:11 -0500
X-MC-Unique: 3EnshH-XN6mbjEqMwocO9Q-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a44e57bbc30so24542866b.0
 for <qemu-devel@nongnu.org>; Sat, 02 Mar 2024 07:35:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709393710; x=1709998510;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+Ysx85g/W0kQzYguGb7KsJTcMOviltiNzvv6o9/n7kQ=;
 b=viZrSylFuD4Ys3Z3ymdHZEQUyrgEvZr1pcReaxPh6Kzyw2QDqxmbONGxR+LNP1yJnQ
 DxjR2WEO+V3zn6L7sPF7OKSDL2V8n8BrhW13dz7EKBH0BvBtavci3R+J40yGXGVMsta+
 RRtNeaqRnBKx5ROPgWXRdgN3V4QIN9AUEOrJZgjizSX0DSkfOPOxVJuPXzxQjlLUr0uQ
 skw5wm29DNcTR0aAMw9ldX+KjFOupu0KZFJ0NmMiz0RBxjVSXOeRq6/C96/Y1aFU+7qu
 1/4eRtUJJUMBdvIeDFk4cG1W6/gm323Dr4BDyO9x997KEMD7FFh/w9z3bXTBZAHXbSmA
 6b4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEMUjpKGMGKMx7Ia9KPjccHkVo3ShWB+sBQZXRETSSvuERZLxpVQoc+HB+uoepvLcgUQNFdt5l75YDZOQCGdtoptkDj0c=
X-Gm-Message-State: AOJu0YwoQg1wU1w7vo/ABQTDR4pwuDfD6dmEXP4reDwVIfsfajBoRv3y
 EBiiN8OxUEZZLF+b1aseYLiDcEuVz3lkZ3weaJDqH49XAlQurAQvkenIexgvIs5rWJDZ9Afwppm
 ahgQ8e1cgbUECyco7R/yP0KTt1R4J21NKCRpnv08S/V7LD41uAnGK
X-Received: by 2002:a17:906:1cc2:b0:a44:4578:c79d with SMTP id
 i2-20020a1709061cc200b00a444578c79dmr2627059ejh.4.1709393710247; 
 Sat, 02 Mar 2024 07:35:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFY9MUodEcq5pRtp8+1j9t8Xxh2XdPUcbjFbDne1Iba7u3u+yTyQRsz3fYX6MPN5o+XBJvruw==
X-Received: by 2002:a17:906:1cc2:b0:a44:4578:c79d with SMTP id
 i2-20020a1709061cc200b00a444578c79dmr2627035ejh.4.1709393709867; 
 Sat, 02 Mar 2024 07:35:09 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-178-133.web.vodafone.de.
 [109.43.178.133]) by smtp.gmail.com with ESMTPSA id
 ag3-20020a1709069a8300b00a44790d06d3sm1918149ejc.71.2024.03.02.07.35.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 02 Mar 2024 07:35:09 -0800 (PST)
Message-ID: <356dff14-af44-403b-9a9c-b4ea9e156f19@redhat.com>
Date: Sat, 2 Mar 2024 16:35:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 6/8] virtio-ccw: Lock ioeventfd state with
 VIRTIO_F_NOTIFICATION_DATA
Content-Language: en-US
To: Jonah Palmer <jonah.palmer@oracle.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, jasowang@redhat.com, eperezma@redhat.com,
 si-wei.liu@oracle.com, boris.ostrovsky@oracle.com, raphael@enfabrica.net,
 kwolf@redhat.com, hreitz@redhat.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 cohuck@redhat.com, pbonzini@redhat.com, fam@euphon.net, stefanha@redhat.com,
 qemu-block@nongnu.org, qemu-s390x@nongnu.org, virtio-fs@lists.linux.dev
References: <20240301134330.4191007-1-jonah.palmer@oracle.com>
 <20240301134330.4191007-7-jonah.palmer@oracle.com>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240301134330.4191007-7-jonah.palmer@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.094,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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
> Prevent ioeventfd from being enabled/disabled when a virtio-ccw device
> has negotiated the VIRTIO_F_NOTIFICATION_DATA transport feature.
> 
> Due to the ioeventfd not being able to carry the extra data associated
> with this feature, the ioeventfd should be left in a disabled state for
> emulated virtio-ccw devices using this feature.
> 
> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
> ---
>   hw/s390x/virtio-ccw.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
> index b4676909dd..936ba78fda 100644
> --- a/hw/s390x/virtio-ccw.c
> +++ b/hw/s390x/virtio-ccw.c
> @@ -530,14 +530,16 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
>               if (ret) {
>                   break;
>               }
> -            if (!(status & VIRTIO_CONFIG_S_DRIVER_OK)) {
> +            if (!(status & VIRTIO_CONFIG_S_DRIVER_OK) &&
> +                !virtio_vdev_has_feature(vdev, VIRTIO_F_NOTIFICATION_DATA)) {
>                   virtio_ccw_stop_ioeventfd(dev);
>               }
>               if (virtio_set_status(vdev, status) == 0) {
>                   if (vdev->status == 0) {
>                       virtio_ccw_reset_virtio(dev);
>                   }
> -                if (status & VIRTIO_CONFIG_S_DRIVER_OK) {
> +                if ((status & VIRTIO_CONFIG_S_DRIVER_OK) &&
> +                    !virtio_vdev_has_feature(vdev, VIRTIO_F_NOTIFICATION_DATA)) {
>                       virtio_ccw_start_ioeventfd(dev);
>                   }
>                   sch->curr_status.scsw.count = ccw.count - sizeof(status);

Acked-by: Thomas Huth <thuth@redhat.com>


