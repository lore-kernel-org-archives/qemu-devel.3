Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 031F9C25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 12:20:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9OT9-00080G-Gj; Tue, 21 May 2024 08:19:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9OT7-0007zZ-S1
 for qemu-devel@nongnu.org; Tue, 21 May 2024 08:19:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9OT6-0007nd-7l
 for qemu-devel@nongnu.org; Tue, 21 May 2024 08:19:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716293987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PJPIczjkY8bxxbJbkXFg65hUKYa9Enu365H0LCbZElE=;
 b=UzG2MTIuNJE8FgUSQOwio4LLtaAud/xX4vboEvq7WARmVzDyZMpauyUKSHvBUi/Mp8CpKB
 FhmBmbIVKlBD3hOvE7K/P2tJZD6y7X43YAiTxLO0YMDto1A0+RQEzTX0UsOWfxuFkwhs+9
 hzha6PT5qe/+wBcr4Dp5oikFMSbWfAY=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-Y3dLXSWhPByUTKhAKLKIzQ-1; Tue, 21 May 2024 08:19:45 -0400
X-MC-Unique: Y3dLXSWhPByUTKhAKLKIzQ-1
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-6f0e6fb64bcso12754623a34.0
 for <qemu-devel@nongnu.org>; Tue, 21 May 2024 05:19:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716293984; x=1716898784;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PJPIczjkY8bxxbJbkXFg65hUKYa9Enu365H0LCbZElE=;
 b=vMDgftF9FXVBcbf79rAuG5EPSwR1NAqBJttiyNpbguwWnIbS82uwiqdlztZufA3OIm
 ADY+jI1ay06G2J4DVTKok52/vvtmQiPIuw5QwoiA3Ehr20Wr0ddjrVtZGYlr32nBsTOQ
 eyPwGJGjNa0flr2MoTH9EadAqRivjl7QzsnolED8Av7msC8nQ2Aq3i4/oEugOUEsoNol
 TpOaTiV0jF/v3BjDCMcXchspyJSg8F4AR/gv9DnwhMvgxlUE5y+TWIBCXQrRCF45Cqdi
 mjUijps/nrdTVoPk78HvJucwP3wj0zTEtdjhCijTHC9vwxQabqHA295FtVLaA8gSaP8F
 bbWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVR96rhMTSUKw+C+ZVcNghYScAgL9wSp4TCkxyeca5KuFqtKh4w34WEGoXHI8uXXPe9uc2oCxNr+JeQNhSZxgNSAnXeZxk=
X-Gm-Message-State: AOJu0YzSt9illa0pbltIeLc1D5KsnweizO01N/JbPSdMEzYUwCDc/jqv
 clQ1zZhtJ7J1+IjDDPgrrA656dFgubLOmWs1LPyLoEfeYWhpf5JwH2H8mD7wlt716iCzufzPfir
 MdXefymQjRzek6j/Qvrut+cPmVQpTY2qaA+10anSCIW1I+4Fox8qz7mtWsX7W
X-Received: by 2002:a05:6870:9624:b0:23d:a4ce:b82e with SMTP id
 586e51a60fabf-24172bcd4demr34577666fac.30.1716293984041; 
 Tue, 21 May 2024 05:19:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHughFGbtjaHryfjY0kSQvA0uz67RkPQ8wCPMqxfygUkkjxgmfjMA5NblWuq5OSJjDvS29zMw==
X-Received: by 2002:a05:6870:9624:b0:23d:a4ce:b82e with SMTP id
 586e51a60fabf-24172bcd4demr34577653fac.30.1716293983671; 
 Tue, 21 May 2024 05:19:43 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43df553ff3fsm160241721cf.54.2024.05.21.05.19.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 May 2024 05:19:43 -0700 (PDT)
Message-ID: <f6ebb051-1a42-4776-989d-97542ecea0b3@redhat.com>
Date: Tue, 21 May 2024 14:19:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/16] vfio/helpers: Use g_autofree in hw/vfio/helpers.c
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, chao.p.peng@intel.com
References: <20240515082041.556571-1-zhenzhong.duan@intel.com>
 <20240515082041.556571-4-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240515082041.556571-4-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
> Changed functions include vfio_set_irq_signaling() 

this change looks fine

> and vfio_region_setup().

I would prefer all users of vfio_get_region_info() to be changed.

Thanks,

C.



> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/vfio/helpers.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
> index 47b4096c05..0bb7b40a6a 100644
> --- a/hw/vfio/helpers.c
> +++ b/hw/vfio/helpers.c
> @@ -111,7 +111,7 @@ int vfio_set_irq_signaling(VFIODevice *vbasedev, int index, int subindex,
>                              int action, int fd, Error **errp)
>   {
>       ERRP_GUARD();
> -    struct vfio_irq_set *irq_set;
> +    g_autofree struct vfio_irq_set *irq_set = NULL;
>       int argsz, ret = 0;
>       const char *name;
>       int32_t *pfd;
> @@ -130,7 +130,6 @@ int vfio_set_irq_signaling(VFIODevice *vbasedev, int index, int subindex,
>       if (ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, irq_set)) {
>           ret = -errno;
>       }
> -    g_free(irq_set);
>   
>       if (!ret) {
>           return 0;
> @@ -348,7 +347,7 @@ static int vfio_setup_region_sparse_mmaps(VFIORegion *region,
>   int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
>                         int index, const char *name)
>   {
> -    struct vfio_region_info *info;
> +    g_autofree struct vfio_region_info *info = NULL;
>       int ret;
>   
>       ret = vfio_get_region_info(vbasedev, index, &info);
> @@ -381,8 +380,6 @@ int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
>           }
>       }
>   
> -    g_free(info);
> -
>       trace_vfio_region_setup(vbasedev->name, index, name,
>                               region->flags, region->fd_offset, region->size);
>       return 0;


