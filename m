Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC6FDC25B75
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 16:05:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6uai-0002v2-2a; Tue, 14 May 2024 12:01:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s6uaX-0002rS-8n
 for qemu-devel@nongnu.org; Tue, 14 May 2024 12:01:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s6uaT-0006xO-69
 for qemu-devel@nongnu.org; Tue, 14 May 2024 12:01:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715702467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J+j3RxdaLn8CxjKGp5XmUOlpwTxZX/qluY03kLQ53LY=;
 b=AXpj4mdlkX5nU3lShxiTIE9Zodrsvt4qfg3MHdUrAvNd/eaNebHbpu/HhMYNJFgCIiL9St
 QyNxcdqu9EFeqZOER3OwACmaxNZ7ebLJ5wsLHfBNRBoaAKLV9RRmB9v11PdsUEHzrwzLc0
 hLbbuQqFNOd3gVxMstpL5NaghXLjJLo=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-o04qQxPEO36t_N45_Ufzuw-1; Tue, 14 May 2024 12:01:06 -0400
X-MC-Unique: o04qQxPEO36t_N45_Ufzuw-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-43de3681b58so63876251cf.2
 for <qemu-devel@nongnu.org>; Tue, 14 May 2024 09:01:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715702465; x=1716307265;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J+j3RxdaLn8CxjKGp5XmUOlpwTxZX/qluY03kLQ53LY=;
 b=PvOi5AkOWnil0/DhzfuIE925NjSxtgEQDqn2N8bjvpr94rfbv46l1MeQveCpO05dLn
 cTOHX8lGmI+3hL4KvtGA+nuvKewOawp/Ss+uph1q4TwkCeJfXFD5/XlIz9At4BXMNShC
 0eN6t0u4wCua1MGny0q5suV6r9lLNlrLKwGZjWEKrnx6LSuAj2BrR9igRSJ+caExdQ8n
 FSI09m3PegmjNdVPK9/uSH5gFwbxFtCc1PBMuC5E60oBj/2YwuY3LBCHo2pqLgjCCLmo
 48j67q51qmpJlZ8FBnpP21/yul+ZEXLI3+CerrlgN0OPW23K22AvH+MmPjmjHYjLePtJ
 TB2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsSrHu3gwbVd736BzXeCzDNdsPzTd3jiV8L+jcee25Eskucinwj+RGObk6P3PCuuDNMnnN+dvJqkw+hb5+By/MQLI14pE=
X-Gm-Message-State: AOJu0YzYrgfWtl2E7/+TyAldInoL9Hyal4XLTbaMMl0/XkFghZs5kju+
 AV+BGkx8pmBY7F4BNjTdqtUxFzErAgkxYgYYXc7xjPAsV6rE2u2Rb+ixys8bcNDTrxWaE1B0AZH
 lszgVOMnHwCOJDPo8Bsegp/JRJv5U6c229g9R139ZofWMm+LWvBY9r2FL1gAu
X-Received: by 2002:a05:622a:3c9:b0:43e:2010:89b3 with SMTP id
 d75a77b69052e-43e20108a12mr49118191cf.63.1715702465187; 
 Tue, 14 May 2024 09:01:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvHLrs2X5MPfz3B97wq7JPjiSVTHNIs5HSzuMwys7TpvxpLiYDxpJO75COtbskN+0bR7qySw==
X-Received: by 2002:a05:622a:3c9:b0:43e:2010:89b3 with SMTP id
 d75a77b69052e-43e20108a12mr49117851cf.63.1715702464714; 
 Tue, 14 May 2024 09:01:04 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43df54da2d3sm70009121cf.27.2024.05.14.09.01.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 May 2024 09:01:04 -0700 (PDT)
Message-ID: <cd7229e4-5650-4048-9d88-45785cda4dd6@redhat.com>
Date: Tue, 14 May 2024 18:01:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/11] vfio/container: Make vfio_get_device() return
 bool
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, chao.p.peng@intel.com
References: <20240507064252.457884-1-zhenzhong.duan@intel.com>
 <20240507064252.457884-9-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240507064252.457884-9-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 5/7/24 08:42, Zhenzhong Duan wrote:
> This is to follow the coding standand to return bool if 'Error **'
> is used to pass error.
> 
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.

	
> ---
>   hw/vfio/container.c | 16 +++++++---------
>   1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 5fb4bee082..b02583ea16 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -800,8 +800,8 @@ static void vfio_put_group(VFIOGroup *group)
>       g_free(group);
>   }
>   
> -static int vfio_get_device(VFIOGroup *group, const char *name,
> -                           VFIODevice *vbasedev, Error **errp)
> +static bool vfio_get_device(VFIOGroup *group, const char *name,
> +                            VFIODevice *vbasedev, Error **errp)
>   {
>       g_autofree struct vfio_device_info *info = NULL;
>       int fd;
> @@ -813,14 +813,14 @@ static int vfio_get_device(VFIOGroup *group, const char *name,
>           error_append_hint(errp,
>                         "Verify all devices in group %d are bound to vfio-<bus> "
>                         "or pci-stub and not already in use\n", group->groupid);
> -        return fd;
> +        return false;
>       }
>   
>       info = vfio_get_device_info(fd);
>       if (!info) {
>           error_setg_errno(errp, errno, "error getting device info");
>           close(fd);
> -        return -1;
> +        return false;
>       }
>   
>       /*
> @@ -835,7 +835,7 @@ static int vfio_get_device(VFIOGroup *group, const char *name,
>               error_setg(errp, "Inconsistent setting of support for discarding "
>                          "RAM (e.g., balloon) within group");
>               close(fd);
> -            return -1;
> +            return false;
>           }
>   
>           if (!group->ram_block_discard_allowed) {
> @@ -856,7 +856,7 @@ static int vfio_get_device(VFIOGroup *group, const char *name,
>   
>       vbasedev->reset_works = !!(info->flags & VFIO_DEVICE_FLAGS_RESET);
>   
> -    return 0;
> +    return true;
>   }
>   
>   static void vfio_put_base_device(VFIODevice *vbasedev)
> @@ -909,7 +909,6 @@ static bool vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
>       VFIODevice *vbasedev_iter;
>       VFIOGroup *group;
>       VFIOContainerBase *bcontainer;
> -    int ret;
>   
>       if (groupid < 0) {
>           return false;
> @@ -929,8 +928,7 @@ static bool vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
>               return false;
>           }
>       }
> -    ret = vfio_get_device(group, name, vbasedev, errp);
> -    if (ret) {
> +    if (!vfio_get_device(group, name, vbasedev, errp)) {
>           vfio_put_group(group);
>           return false;
>       }


