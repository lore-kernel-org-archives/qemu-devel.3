Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14D4CC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 13:36:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTiLr-0006uT-UC; Tue, 16 Jul 2024 09:36:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sTiLp-0006mY-Ta
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 09:36:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sTiLo-0005YW-4D
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 09:36:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721136975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t6s9nurSA9UT22PBrzVzsDL7QhWhr278JOn25aPMF0U=;
 b=ScqXHzrIzyXdbtAaYY7pJjJTCm+SOdogv+A/eLSviF5fKG7zx7IKMiTKZuNlHMOK7DEIlN
 GhuMQjz5ZoqtLnMSMziWS0WXs1VTuWFW0krBTfIvU+Y+9k2Q+Dhl6Jg0/07XhwB5Cly6SD
 Lba0nXrNSK8ueVUz2LoKbXzCx1sS//I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-MLg-dlb8MAS02C0NTsmlJw-1; Tue, 16 Jul 2024 09:36:13 -0400
X-MC-Unique: MLg-dlb8MAS02C0NTsmlJw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-426724679f0so34099975e9.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 06:36:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721136972; x=1721741772;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t6s9nurSA9UT22PBrzVzsDL7QhWhr278JOn25aPMF0U=;
 b=HW/Ef+9JbNbYmyU7SJeGuEWKC7HnxzYM0u2sd38qolNCQ03R0PAneaJXaSOABJrNL/
 ZQKPE202FoFoF+67/A6kQ9p6t5SJ83o7ZC7WI1m8CGDBVHtRk0SvH1frDvFOIa1TRWyh
 xEFRUYI0SETXDq/125/39ttve07q0+oK6zcVinsh661UAHexdFac9/T846wP3+KWt50k
 FMOJKs25El2R5QgUVYl53pZbTl8CLiBcJuf3Ej4IkZ9ueF9cDQss78eMxXwVMX/5x394
 RzB6b4hFNfGHIG6fH9ANW29I6FAxYy44uQ5eks8fVDj1ngmOYLAvyRBvfLXWEfI8xNRD
 eIgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQfRcwNT9x/3laURmwPGi5mqHBwGiKM56jDT9FjtKLFHjjNvOV8QqVUB4Cg44+m0fpm1N8WQQlG2wWSOYv3eI4/KSaZS0=
X-Gm-Message-State: AOJu0Yx08OQbvMP0BI3XMpl+idGfVAhn3hs5Qf059NELCcg/IvM72id7
 GFgUg2weHIRqYGkE0+wt5Nrv+HsVe7lZeD4JXxqsggupxM92OeN+ku1pNdtGaqlDXj8tW7nq4XW
 E4+8pbUlTqdA8iYGwkJQy3Oro5IYHJvs4I6kXork6UIVnn8de+Hw5
X-Received: by 2002:a05:600c:458a:b0:426:526f:4a1f with SMTP id
 5b1f17b1804b1-427bb8cc8a6mr15432635e9.16.1721136972373; 
 Tue, 16 Jul 2024 06:36:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfOSFsWCm8zeXd2aj8+C4uhBkd5ydHPisfXGWowCQd55EkgqoWs0/z4ahUCB9T4tHeCa0H1w==
X-Received: by 2002:a05:600c:458a:b0:426:526f:4a1f with SMTP id
 5b1f17b1804b1-427bb8cc8a6mr15432485e9.16.1721136972154; 
 Tue, 16 Jul 2024 06:36:12 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:26c5:842:8baa:576b?
 ([2a01:e0a:9e2:9000:26c5:842:8baa:576b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427a5ef4793sm127167285e9.43.2024.07.16.06.36.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jul 2024 06:36:11 -0700 (PDT)
Message-ID: <841b1e2a-310b-49c7-a176-8a4ea670dad5@redhat.com>
Date: Tue, 16 Jul 2024 15:36:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] virtio-iommu: Remove the end point on detach
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, mst@redhat.com,
 jean-philippe@linaro.org, peter.maydell@linaro.org,
 zhenzhong.duan@intel.com, alex.williamson@redhat.com, jasowang@redhat.com
Cc: yanghliu@redhat.com
References: <20240716094619.1713905-1-eric.auger@redhat.com>
 <20240716094619.1713905-5-eric.auger@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240716094619.1713905-5-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 7/16/24 11:45, Eric Auger wrote:
> We currently miss the removal of the endpoint in case of detach.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/virtio/virtio-iommu.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
> index 2de41ab412..440dfa6e92 100644
> --- a/hw/virtio/virtio-iommu.c
> +++ b/hw/virtio/virtio-iommu.c
> @@ -786,6 +786,7 @@ static int virtio_iommu_detach(VirtIOIOMMU *s,
>       if (QLIST_EMPTY(&domain->endpoint_list)) {
>           g_tree_remove(s->domains, GUINT_TO_POINTER(domain->id));
>       }
> +    g_tree_remove(s->endpoints, GUINT_TO_POINTER(ep_id));
>       return VIRTIO_IOMMU_S_OK;
>   }
>   


