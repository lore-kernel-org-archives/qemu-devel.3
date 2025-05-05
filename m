Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9E36C3ABB6
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 09:19:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBryN-0005GN-74; Mon, 05 May 2025 05:18:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uBryL-0005Fu-D7
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:18:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uBryJ-0008T7-NU
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:18:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746436726;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=dHUB9oOnalUFt71ueYXCrffVdFeIBJ4ftI4AQX6DLTs=;
 b=MzXyGmyS9Vs1vZTD5VgI6SkB11j3XS98B6uRoolQ6g+yn2CSreqUNTFm3t6wBzrNueCLdo
 wVWP66yYPJSlNPlgK8BGmjvFXVQLoAP/WMItSm8rlLHYCAW6V9+kWbHHWJe0lQUp/QmutW
 PYp9sC+6LfR/2zy4+5Puaw7kOaVQ/30=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-GW11B9mANP20vhLa8YtJfQ-1; Mon, 05 May 2025 05:18:43 -0400
X-MC-Unique: GW11B9mANP20vhLa8YtJfQ-1
X-Mimecast-MFC-AGG-ID: GW11B9mANP20vhLa8YtJfQ_1746436723
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43d00017e9dso21900275e9.0
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 02:18:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746436722; x=1747041522;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dHUB9oOnalUFt71ueYXCrffVdFeIBJ4ftI4AQX6DLTs=;
 b=LDsHlKmjRQM9e5D1LNdKdhPK/ZhbGA3I6r5g5Iwb5H072leJ6Yy3YIfZNQE3+Gy8ax
 WfO3Th9/zmeDiofaGHeUfo4GAk+VtYD+n8QO36zBfybG8rxk0F7o0P9cGSxBaEpDpo3F
 VRrewMVxuTVWvKN3iJc4oe2zt19X9ZCg2XsxifnXJxii5NDK4X4Hp5nBc86IRDezbCgo
 9zoHbFHRutHcHVojBwR5/RUHCv8kjBgOB8kgmKIL0Guagz4RN5UTtWmbwSpOpabUK8fC
 TDllKh9qdpWkbxU95XM+t4DmGJQyNSa0+yMNisOp1VZvh/BKQWRtlHUC9Y1XJhR5+1an
 fAWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBH8Rrvzn/idq/XV8QGc+XmdYDzLL7jI858D5S6xu9ojxXwsU76yfCVaW8pI9PiR8eLBFgLDJ6uoub@nongnu.org
X-Gm-Message-State: AOJu0YxyICBS6QXw0bHP3WUdxmG7MS3NVqDkWTDWn4Ix1k/vtWF716Sh
 ujIPx2Qg1Bt/xQvN4BjiC9dCi+OsUXA5hBB4Ynurj5ChtpcShuXO2ELdt2FVeg2xD41Y4sQGXZ1
 6p3uVDrukaqryb14CSIYtaLZ20zpjMfkQ2jvIYa9dTMib4Hc3QsxGHZqGQ8Yq
X-Gm-Gg: ASbGncvVfMHNljZlB5wAfoZ6dHNHitouIXG0TUMrpFbCugNVOoz0cHpp7uL4rhH8+Ew
 WY7WaMmfHSTROGFh+MlWdXHIwR+W9TPL0NUUTcZ37skGLyKVAlGEDHDaN7piwWli4xcoMiaeaBs
 /xw6jhcTAgWK72ExRx4InYvMLTh0xwj7anz4nkupyj2cFARmNs6SZxQCZonO/7kicHaZq4ugbCc
 zvM3lOVIFH36ruS2fKU22uEEgKOP628Z/i78Q7X4tzVr/hsu4kNDb1wp2D2H0QqhCDOVI6eO5g6
 YGaM1bvin2ERtB/jSnvhafp5nZC3p87c+GgmKA99heXWQrYe+g==
X-Received: by 2002:a05:600c:a412:b0:43c:e467:d6ce with SMTP id
 5b1f17b1804b1-441c7a2f001mr38550575e9.4.1746436722468; 
 Mon, 05 May 2025 02:18:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZ2HwouqfgpLWojea4MU/eapCHlCP3Ml+Zl7X086oBRfNrRgShJKptzVEUN1UF4OMF5FRauA==
X-Received: by 2002:a05:600c:a412:b0:43c:e467:d6ce with SMTP id
 5b1f17b1804b1-441c7a2f001mr38550175e9.4.1746436722102; 
 Mon, 05 May 2025 02:18:42 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099ae3403sm9720460f8f.28.2025.05.05.02.18.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 02:18:41 -0700 (PDT)
Message-ID: <f1af5260-a55a-424c-9d7b-60166fa55596@redhat.com>
Date: Mon, 5 May 2025 11:18:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/15] vfio: add vfio_unprepare_device()
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, qemu-s390x@nongnu.org,
 Jason Herne <jjherne@linux.ibm.com>, Tomita Moeko <tomitamoeko@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Tony Krowiak
 <akrowiak@linux.ibm.com>, Alex Williamson <alex.williamson@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
References: <20250430194003.2793823-1-john.levon@nutanix.com>
 <20250430194003.2793823-3-john.levon@nutanix.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250430194003.2793823-3-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 4/30/25 21:39, John Levon wrote:
> Add a helper that's the inverse of vfio_prepare_device().
> 
> Signed-off-by: John Levon <john.levon@nutanix.com>
> ---
>   hw/vfio/container.c           | 6 +++---
>   hw/vfio/device.c              | 7 +++++++
>   hw/vfio/iommufd.c             | 4 +---
>   include/hw/vfio/vfio-device.h | 1 +
>   4 files changed, 12 insertions(+), 6 deletions(-)
> 

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



