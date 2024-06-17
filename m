Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEBB6C2BA15
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 14:27:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJDJm-0005vA-UU; Mon, 17 Jun 2024 10:26:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sJDJg-0005tn-H9
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 10:26:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sJDJe-0004YU-5Z
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 10:26:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718634397;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1bjLJ7IqXAcp+cu+Zlh3yGiR5IH+46UdjIbFS5sh4j8=;
 b=gpnR4xAnsJCh+FovpmpmcSx6LmJque6xE74kBzgzh564m6ps30VFiIqVOfGySzDwfBmiAF
 UtXrQk9Rvd2jFZ7bel0sTP9kUDWlJPvtbvK+qeuu+iGBiYahR/lplk/2ZAZPkb+B1ZOr7H
 mGxlXXFX2gMBFNjYWeCI6ew4uTXHJMo=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-gT1itEQeMQSSovdA_VoSKA-1; Mon, 17 Jun 2024 10:26:35 -0400
X-MC-Unique: gT1itEQeMQSSovdA_VoSKA-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-62f4a831dd8so79223937b3.3
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 07:26:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718634395; x=1719239195;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1bjLJ7IqXAcp+cu+Zlh3yGiR5IH+46UdjIbFS5sh4j8=;
 b=fnMQ8LfYBv+iiumCVFTqi0xnB792rr4ltZIq6+lyNnDRLvDSItOX3lyA3Exm3bMoIw
 XmCY0H1htkHiURbSEB/ZbsJcDYjm3dCStfDpuU0493iOJnPEQJqsR2PKE4f+Rz2aqjmq
 ZuE+bf9HzOaVjyyUiJ86nVNi1o8BaWgXnT7kGa/qJvdFSq22bQziMafY8PxnkYAnnCp7
 ufY2xPRMaCiDwIdxS9PthmIm/aKHWRTBurCSMja9l6ps3lwZKYqTN57ruX+2HBQ83CfG
 Q5IfCM6RkHsSprYG+ESB+u34AFMrOJ2E+DeC85egnMD1/twGOv6LVaHYUQXwpw+/hVGt
 //vw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9Y1To/oAYU74ZUVwqG/gU+Y9KAbbKQfN79OvlIol55oriPpgS8fVIomBkb5hV0BXL1AebfEOtebgdf/BNa5cLOEyrOss=
X-Gm-Message-State: AOJu0YyW3WJ1MqgpuN9kmKBRLootfUTVs7MeIo4Xdl83epeiobbRCcV+
 fiI80UGt2HUI0NJgI7k89ykdjHiaShD0PeBG0RhitA6MuParqy4bGy8ZPhz48114gibJwwCsJGX
 7UIwKRFJYdwyJ+m7Fwl+IFBin17nIIgf3QBcVSf2BqVTMW664hSt7
X-Received: by 2002:a25:db44:0:b0:de6:dcd:20ae with SMTP id
 3f1490d57ef6-dff153a653dmr9023624276.27.1718634395359; 
 Mon, 17 Jun 2024 07:26:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGS0vyD2g7553C9x90hm9AJNagDSM+ZlgiCkO5QkJIbF7NqqkA6SkBKfUwxCJUF1KNgHTdhEQ==
X-Received: by 2002:a25:db44:0:b0:de6:dcd:20ae with SMTP id
 3f1490d57ef6-dff153a653dmr9023608276.27.1718634394994; 
 Mon, 17 Jun 2024 07:26:34 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b2a5ec6754sm56009216d6.78.2024.06.17.07.26.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jun 2024 07:26:34 -0700 (PDT)
Message-ID: <a271f52c-62ed-4412-9885-fa9f2feed66c@redhat.com>
Date: Mon, 17 Jun 2024 16:26:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/17] vfio/container: Modify vfio_get_iommu_type() to
 use a container fd
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20240617063409.34393-1-clg@redhat.com>
 <20240617063409.34393-8-clg@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240617063409.34393-8-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 6/17/24 08:33, Cédric Le Goater wrote:
> The 'container' pointer has no other use than its 'fd' attribute.
> Simplify the prototype to ease future changes.
>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  hw/vfio/container.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index dc85a79cb9e62b72312f79da994c53608b6cef48..589f37bc6d68dae18f9e46371f14d6952b2240c0 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -354,7 +354,7 @@ static void vfio_kvm_device_del_group(VFIOGroup *group)
>  /*
>   * vfio_get_iommu_type - selects the richest iommu_type (v2 first)
>   */
> -static int vfio_get_iommu_type(VFIOContainer *container,
> +static int vfio_get_iommu_type(int container_fd,
>                                 Error **errp)
>  {
>      int iommu_types[] = { VFIO_TYPE1v2_IOMMU, VFIO_TYPE1_IOMMU,
> @@ -362,7 +362,7 @@ static int vfio_get_iommu_type(VFIOContainer *container,
>      int i;
>  
>      for (i = 0; i < ARRAY_SIZE(iommu_types); i++) {
> -        if (ioctl(container->fd, VFIO_CHECK_EXTENSION, iommu_types[i])) {
> +        if (ioctl(container_fd, VFIO_CHECK_EXTENSION, iommu_types[i])) {
>              return iommu_types[i];
>          }
>      }
> @@ -399,7 +399,7 @@ static bool vfio_set_iommu(VFIOContainer *container, int group_fd,
>      int iommu_type;
>      const VFIOIOMMUClass *vioc;
>  
> -    iommu_type = vfio_get_iommu_type(container, errp);
> +    iommu_type = vfio_get_iommu_type(container->fd, errp);
>      if (iommu_type < 0) {
>          return false;
>      }


