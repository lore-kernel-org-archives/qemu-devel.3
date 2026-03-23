Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC062F483D7
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 17:39:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4jEn-0008LW-3X; Mon, 23 Mar 2026 13:38:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w4jEc-0008Kn-Ob
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 13:38:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w4jEa-0006c8-DW
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 13:38:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774287512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=85wBMeLYiCvQF/MYN0NYQTfVX1Iog/1OPDWE96H829o=;
 b=Ie7hvOaFoq5xEzVW0bEzZnCwww9f4O6y+1LeGh0GadSavbEm0UqeO4tDRUfDg3e0Us51br
 8vAt6K/O1sGzXRzVXBq/slxHgPxijjSHO3CFtEH44RbOLZgr3PXHafIvJVcfsp39qTzsWn
 xmlOndoWiIPYnxNnzk+CQF8CWscvcfI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-9x55FIA9MgugukXBPH9aHQ-1; Mon, 23 Mar 2026 13:38:30 -0400
X-MC-Unique: 9x55FIA9MgugukXBPH9aHQ-1
X-Mimecast-MFC-AGG-ID: 9x55FIA9MgugukXBPH9aHQ_1774287509
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-43b4dcdb372so2369971f8f.0
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 10:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774287509; x=1774892309; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=85wBMeLYiCvQF/MYN0NYQTfVX1Iog/1OPDWE96H829o=;
 b=K5Ua74Z1pGiQYicvkVxT81IkHZMHWsug5Sdqu/S8wtV6rpslF/qy9cdO1MbJf78bdT
 V9GeOU71dL39E7813JLlsf1DR00bvjxIhiW44GEBhpGyhjykNIcZq6M6BaWmeDQpaRg8
 xF+OqA+UazTJ+Iq2gA7G6hRiL748zYkV+hS2c8huxpp6hgnPfsWpftBa2DYnuF5CKxEr
 FzSoT7IkQ4uulB2XAvyKNLVg0ejjevMhzklo0sxvdhV5usVQTISgepkhb1j1t+ubCNHT
 QPT28Rrmwt7bYser/HQeoikvYkYUvNcBQuUVLcedaAe4Mwkp1z31Cokl4oSBXfLTigTn
 lxew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774287509; x=1774892309;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=85wBMeLYiCvQF/MYN0NYQTfVX1Iog/1OPDWE96H829o=;
 b=Rv8gGr1uw0Dxd4EX4yYbN7kCRSIflP5+bK2wG2I4yhes/mZAVluY8MeL5EUyq/bxLe
 gIVQDsMgWa7P9eishHYjNLhiqUvbSs5aLEaNv/MM/qd+l2wtwB0vk1JNbmg50+nKqD8F
 YberVAsJdHHb7d+in24mf4wCetnCZFblG4WzGZzXdov+T883/L+KlPWjFlG1q85n9n/8
 HNv8gFDOTd5we+x5FJ0emb1G5bQwNw1CQKzf4wVVuShJCFKs2l0hITrlMr3TCXltqDvV
 WEkZHpH8XFa3bxUjXlXH93kwUybz77YdTdnGCJCgW2svVJUiTbGCdf1dDrOsQRf/jDZ8
 UbCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCylB2sMMmuZyb63dZI7IjRfeK5/96kuqvL1gsXC5YerGEjwrQHfCjxmUEqjcflOiqmYBF2Ibx3EjK@nongnu.org
X-Gm-Message-State: AOJu0YzqqwKirU5lawb29giHQPDyVbbtNka1PAGx3c8E625mrqWzLWyA
 vMcIhAKBQNXZYF8iUYlE03IoOknxwEctV8Ddl/nat1MlcDcT4wy60rGckog6WTcJkWWN5E8h2wq
 5TnV7VAkqM++qDsJFYCY8U1tWBIpbUsx/8c93ILv5db9B4FUD7zxhNUfT
X-Gm-Gg: ATEYQzwaV0VKnRECaslNB9Qm3D2fL1xTSMhaWTsxV50sHUhp+opu4i4ACoRKSemXdDu
 nXQMgyS5DEb0+bopvD68SFmO8+h1WnvMVnoRuyl2IykfFKT/NLJTNdNPzD3bXN4wKXIFpo4I5md
 v7hXyOXWcSG/hgbx7bKhpsnZM+fUPjLU6cYLubO+1EdYUEk5TX4S34E7d0R/K8AnmNzqO4iKMxY
 tfvmNd0J65w3wjRwcPjiar9tgPZeJrqjymW7pgjNjDSdH8xUaZ2pzHj4jXYDxhQrza0pc3JQhXM
 7ToTHmRUJtHK50nCEjsNvT6aGWBsDP3t5NzMkZgEVwOqFQMnLhOferNxz1qU6cuZEyA+uwhHCSS
 A+ymCE7Zqnf/FfMzt2iS6YeYSYbIUO3Otni4hHqT/P6Uvqq0s7jLhjw9+isPk
X-Received: by 2002:a05:6000:2003:b0:43b:5761:f232 with SMTP id
 ffacd0b85a97d-43b642819d6mr21131179f8f.43.1774287508864; 
 Mon, 23 Mar 2026 10:38:28 -0700 (PDT)
X-Received: by 2002:a05:6000:2003:b0:43b:5761:f232 with SMTP id
 ffacd0b85a97d-43b642819d6mr21131141f8f.43.1774287508433; 
 Mon, 23 Mar 2026 10:38:28 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b644ae619sm32447221f8f.5.2026.03.23.10.38.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Mar 2026 10:38:27 -0700 (PDT)
Message-ID: <ab984d46-3b70-4f6e-b035-3895187164e7@redhat.com>
Date: Mon, 23 Mar 2026 18:38:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 06/10] vfio/region: Add a helper to get VFIO region
 from memory region
To: Vivek Kasireddy <vivek.kasireddy@intel.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>
References: <20260319052023.2088685-1-vivek.kasireddy@intel.com>
 <20260319052023.2088685-7-vivek.kasireddy@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260319052023.2088685-7-vivek.kasireddy@intel.com>
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 3/19/26 06:15, Vivek Kasireddy wrote:
> Having a way to get the VFIO region associated with a memory region
> is helpful in various scenarios. For example, this capability can
> be useful in retrieving the region info such as index and offset
> needed for mapping a part of a VFIO region or creating a dmabuf.
> 
> Cc: Alex Williamson <alex@shazbot.org>
> Cc: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> ---
>   hw/vfio/vfio-region.h | 10 ++++++++++
>   hw/vfio/region.c      | 11 +++++++++++
>   2 files changed, 21 insertions(+)
> 
> diff --git a/hw/vfio/vfio-region.h b/hw/vfio/vfio-region.h
> index 9b21d4ee5b..3dd47f77f6 100644
> --- a/hw/vfio/vfio-region.h
> +++ b/hw/vfio/vfio-region.h
> @@ -45,4 +45,14 @@ void vfio_region_unmap(VFIORegion *region);
>   void vfio_region_exit(VFIORegion *region);
>   void vfio_region_finalize(VFIORegion *region);
>   
> +/**
> + * Return the VFIO region associated with a given MemoryRegion. This can
> + * be useful in retrieving region info such as index and offset.
> + *
> + * @mr: MemoryRegion to use
> + *
> + * Returns the region or NULL on error.
> + */
> +void *vfio_get_region_from_mr(MemoryRegion *mr);
> +
>   #endif /* HW_VFIO_REGION_H */
> diff --git a/hw/vfio/region.c b/hw/vfio/region.c
> index 47fdc2df34..9d7ac339c9 100644
> --- a/hw/vfio/region.c
> +++ b/hw/vfio/region.c
> @@ -539,3 +539,14 @@ void vfio_region_mmaps_set_enabled(VFIORegion *region, bool enabled)
>       trace_vfio_region_mmaps_set_enabled(memory_region_name(region->mem),
>                                           enabled);
>   }
> +
> +void *vfio_get_region_from_mr(MemoryRegion *mr)

can we return a "VFIORegion *" ?

Thanks,

C.

> +{
> +    while (mr->container) {
> +        if (mr->ops == &vfio_region_ops) {
> +            return mr->opaque;
> +        }
> +        mr = mr->container;
> +    }
> +    return NULL;
> +}


