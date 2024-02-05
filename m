Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19977C48292
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 09:15:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWv4Q-0002Xf-QV; Mon, 05 Feb 2024 04:15:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rWv4P-0002Qv-GN
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 04:15:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rWv4N-0007Vh-KH
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 04:15:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707124515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mx4BDIj8LfQcCcGsg3R1uyLzBUSGNHAfyaHSWXL6JBo=;
 b=YzmytEponPIaxZhM4vzvuuSPbTUDuUsnbUmkZTH5lKDYmxMjftFWRh44uYeT3HpUICGJOd
 JPtC6j4qJsMvE1OuNEcqmrTSw6XjDAWiprbNjiWrUKDvWKWu01QDNzmpHQRDfaw5YFehiO
 ybpzSgZ+g1GsNrb3C/sh/Duc8oRJVVY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-B5OS_lqaP5mpBxvo_GVlLw-1; Mon, 05 Feb 2024 04:15:12 -0500
X-MC-Unique: B5OS_lqaP5mpBxvo_GVlLw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-40fdd0e2110so2391435e9.1
 for <qemu-devel@nongnu.org>; Mon, 05 Feb 2024 01:15:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707124511; x=1707729311;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Mx4BDIj8LfQcCcGsg3R1uyLzBUSGNHAfyaHSWXL6JBo=;
 b=lZ1a+77AIDlRmhj6LngnvOTKhsU28PCRb6u8QVYz7VpFNy/TDzYlG3dY48JAipTeAQ
 CfuYirOCbv+QOVSInMSg02GqucmzA1e3uE3m7oshRDmDItPGhvDfRZ/Zygt4LjQFoP/o
 Ify8puVpcmaq0wv0Bcy3YKjTjDLogN9GcMkYrfR0CX3ly26DrGufRLI1hg3W0FNrn5I9
 7KWEXr84jTXlYaH4VEbJ61nudEy+8AbEAPdxLsdh0JUfgbJIpRZxtdseBMpIKBE9vsUe
 0kF4Nq1GDi4gfGlerF6NYtCWzlWTIG0owNkuvmORK+osDel4Nv0zYwExeCfA5bcAfTm0
 9K7A==
X-Gm-Message-State: AOJu0Yw22Yc7YYq+x1WJlbqW/tc3xWHN2X9j3BuvSI50Y8GWYKyOCFDm
 6DpqvXnE1mJ9vqdOvrmPWtvbTo7AcYMOYrBymrbZGmh9diORHUgL+CldlWWFTYFh8Wi70K1rnpG
 yI9xfKZ2nJ68jLOeUIPGq5aNAf8Zq6YQ1LHn4z0WXPD00HeihhIDa
X-Received: by 2002:a05:600c:3056:b0:40f:cbad:2436 with SMTP id
 n22-20020a05600c305600b0040fcbad2436mr4528295wmh.24.1707124511268; 
 Mon, 05 Feb 2024 01:15:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHhfkfUtEyUSHNeQKbeh04gMCwAsx4LfvCQ+69qY0vwP/F1CFzlYYoVy64V5/DtuE4d0lLvfw==
X-Received: by 2002:a05:600c:3056:b0:40f:cbad:2436 with SMTP id
 n22-20020a05600c305600b0040fcbad2436mr4528268wmh.24.1707124510781; 
 Mon, 05 Feb 2024 01:15:10 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCWpNZ0bz5Bfus5sGzqtUJpU7ZXvpQoQbPT73NNPyDqajZ2aGLxRYyH9XYMO35aZXXE3ACfUoMLYUrbBkLqlsRkGRTPpJx1NZNMkJlvFyQf2fH6V9zK2bKncgsQKGHMuEBOUEJ1B9lEQzwNec26OoHmxFV+zpceLs1gagOznNYlRzU+Gr+SXOYAfCxxPApxm2K5nxIvH7Hc8eaDstbJFyqYlZUzqE8mg/+drAL7FchHDb65viTVYCFQ74A4AYHpqWUD72UWruw01v8QAvHT1TMsdIJY9tJoFNmOPE71tcAgTQq8znCXyi2aluxRlgpP45tIXgHVwrEDW4wRUDefcBCVipRquuVT9Sy8=
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 k15-20020a05600c1c8f00b0040eea5dc778sm2060515wms.1.2024.02.05.01.15.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Feb 2024 01:15:10 -0800 (PST)
Message-ID: <d5b56245-8011-4f5d-a6ea-14976b9683d5@redhat.com>
Date: Mon, 5 Feb 2024 10:15:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] virtio-iommu: Trace domain range limits as
 unsigned int
Content-Language: en-US
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, jean-philippe@linaro.org,
 alex.williamson@redhat.com, peter.maydell@linaro.org,
 zhenzhong.duan@intel.com, yanghliu@redhat.com
Cc: mst@redhat.com, jasowang@redhat.com
References: <20240201163324.564525-1-eric.auger@redhat.com>
 <20240201163324.564525-3-eric.auger@redhat.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240201163324.564525-3-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.361,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 2/1/24 17:32, Eric Auger wrote:
> Use %u format to trace domain_range limits.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/virtio/trace-events | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
> index 77905d1994..2350849fbd 100644
> --- a/hw/virtio/trace-events
> +++ b/hw/virtio/trace-events
> @@ -111,7 +111,7 @@ virtio_iommu_device_reset(void) "reset!"
>   virtio_iommu_system_reset(void) "system reset!"
>   virtio_iommu_get_features(uint64_t features) "device supports features=0x%"PRIx64
>   virtio_iommu_device_status(uint8_t status) "driver status = %d"
> -virtio_iommu_get_config(uint64_t page_size_mask, uint64_t start, uint64_t end, uint32_t domain_start, uint32_t domain_end, uint32_t probe_size, uint8_t bypass) "page_size_mask=0x%"PRIx64" input range start=0x%"PRIx64" input range end=0x%"PRIx64" domain range start=%d domain range end=%d probe_size=0x%x bypass=0x%x"
> +virtio_iommu_get_config(uint64_t page_size_mask, uint64_t start, uint64_t end, uint32_t domain_start, uint32_t domain_end, uint32_t probe_size, uint8_t bypass) "page_size_mask=0x%"PRIx64" input range start=0x%"PRIx64" input range end=0x%"PRIx64" domain range start=%u domain range end=%u probe_size=0x%x bypass=0x%x"
>   virtio_iommu_set_config(uint8_t bypass) "bypass=0x%x"
>   virtio_iommu_attach(uint32_t domain_id, uint32_t ep_id) "domain=%d endpoint=%d"
>   virtio_iommu_detach(uint32_t domain_id, uint32_t ep_id) "domain=%d endpoint=%d"


