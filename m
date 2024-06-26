Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C006C27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 10:40:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMQ3X-0002oD-UY; Wed, 26 Jun 2024 06:39:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sMQ3V-0002nU-R0
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 06:39:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sMQ3U-000894-D8
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 06:39:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719398348;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MFBijKNCUp0T7Qta2WUTwJTAhudpMqd/9GjSe79/mj4=;
 b=ANV9b+UDLpzLZU6ZDr1ZGbI8nMsrQIrDCCwuAr8uuQDTlIGyb5n2+vKI3d+/HZ2UaBFK1W
 p00lBZPRNcuu3glNuqW5vr/Jw2efOAS/xYvC1Cmgth3mNN2gKnnsCLgnz1XHrni6Y+3J6a
 4dOHB1Sx/9us1YyDO7mcvOfHOxL1EV0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-OJedAu8WOcOvW4B6-_gZsw-1; Wed, 26 Jun 2024 06:39:03 -0400
X-MC-Unique: OJedAu8WOcOvW4B6-_gZsw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4227e29cd39so34972175e9.1
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 03:39:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719398342; x=1720003142;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MFBijKNCUp0T7Qta2WUTwJTAhudpMqd/9GjSe79/mj4=;
 b=Msvjr6ukW14JMlQ3aEYdJZKz6PzwW7nU1QC60Keu8ObT0tcE1WroVQ7Yghsgo7X029
 /4lvHASnsLFrPr39lkeraNzHiHFxDhDYTyZYJNvQB3xeKc+KZB+q6vBIYzQjXgrJ8+yI
 exnqXopSAEz73uz0J69Wk+AGqo8f56MGZoUN5zyJ9UrTK8CBxbAlkKDrCY5dnKsxGhWV
 prV66RNlEzlA9rGs9ea4oMsL33YnxNXeondfBfMNC4rQp3hjG3Bjm+jsrygVwDowp33f
 8594L4/2X9WFT5vIAwus+3sAlsrsHXNiuFdErRw3yrDyatMojjtJ/7pFrZU8WsjbhA1g
 y3aA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVU99dgpsDDzG/0ZxzZz0zhNeq0pX8l0simLDbQGI5G8qOeD1M1xzDlS5cLsY0UkMlesw/D4HuKf2W57T5V4o8lE3vzCWM=
X-Gm-Message-State: AOJu0YxmacRE+SEFyXaADnnwYSTT2AhJwrjKBsjoCt32ril085XDwvdV
 IS8QV8kID1lYTzA8DzdCoeoMH6BhJZ9kCLgFra7QZgtyHMdmdwE9tfTKVVWtPkyx+XktdaSl8tM
 cYCKJclInD7YhWGcDL2jZrdoFub7DSq7YC8flRQto8rqbduABDT8K
X-Received: by 2002:a05:600c:4209:b0:425:5e8b:679f with SMTP id
 5b1f17b1804b1-4255e8b69f7mr7812355e9.6.1719398342671; 
 Wed, 26 Jun 2024 03:39:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtDpRRHPAbU9ffJdUlFqu0JiPhOq0JNTw64oW3EK02RPjfmV4hXBto7np6DkVxbBnDQbNLig==
X-Received: by 2002:a05:600c:4209:b0:425:5e8b:679f with SMTP id
 5b1f17b1804b1-4255e8b69f7mr7812245e9.6.1719398342362; 
 Wed, 26 Jun 2024 03:39:02 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-424c826a2e7sm20439615e9.21.2024.06.26.03.39.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jun 2024 03:39:01 -0700 (PDT)
Message-ID: <6a01db71-fbca-4ff6-be8c-628b43c937f6@redhat.com>
Date: Wed, 26 Jun 2024 12:39:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] virtio-iommu: Fix error handling in
 virtio_iommu_set_host_iova_ranges()
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, mst@redhat.com,
 jean-philippe@linaro.org, peter.maydell@linaro.org, yanghliu@redhat.com,
 zhenzhong.duan@intel.com, alex.williamson@redhat.com
References: <20240626082727.1278530-1-eric.auger@redhat.com>
 <20240626082727.1278530-2-eric.auger@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240626082727.1278530-2-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 6/26/24 10:26 AM, Eric Auger wrote:
> In case no IOMMUPciBus/IOMMUDevice are found we need to properly
> set the error handle and return.
> 
> Fixes : Coverity CID 1549006
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Fixes: cf2647a76e ("virtio-iommu: Compute host reserved regions")


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/virtio/virtio-iommu.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
> index b9a7ddcd14..b708fb96fd 100644
> --- a/hw/virtio/virtio-iommu.c
> +++ b/hw/virtio/virtio-iommu.c
> @@ -543,10 +543,15 @@ static int virtio_iommu_set_host_iova_ranges(VirtIOIOMMU *s, PCIBus *bus,
>       int ret = -EINVAL;
>   
>       if (!sbus) {
> -        error_report("%s no sbus", __func__);
> +        error_setg(errp, "%s: no IOMMUPciBus found!", __func__);
> +        return ret;
>       }
>   
>       sdev = sbus->pbdev[devfn];
> +    if (!sdev) {
> +        error_setg(errp, "%s: no IOMMUDevice found!", __func__);
> +        return ret;
> +    }
>   
>       current_ranges = sdev->host_resv_ranges;
>   


