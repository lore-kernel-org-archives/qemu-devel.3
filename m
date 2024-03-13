Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29F41C54791
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 21:12:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkVtD-0002ik-Fv; Wed, 13 Mar 2024 17:11:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rkVtC-0002iV-Dk
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 17:11:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rkVtB-0003pU-04
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 17:11:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710364311;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AleTZl1PUVX908GJT/LUOxERo/O5kQrPyepGmWEy0Mk=;
 b=UMJ2+KNqTsbLzudsoUe6G/bPuTBvUxtx0pI6DFM+jUuTOxSxhCXxfaNjo+Z5oWgsOR25Tt
 v0QNfIppqo2m1gnID9nTnrn1mT2iZfYyX9BWkfbrZ6zMhcYY1cJaVqhxj9lrNf0H6K7KY7
 C+GKAYeYvMt46Z/ubGwPbGPbMak6n7k=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-SYA5GkDLMeamLZlIooxylw-1; Wed, 13 Mar 2024 17:11:49 -0400
X-MC-Unique: SYA5GkDLMeamLZlIooxylw-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-42ef6c2e84cso1981171cf.1
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 14:11:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710364309; x=1710969109;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AleTZl1PUVX908GJT/LUOxERo/O5kQrPyepGmWEy0Mk=;
 b=lPfX/88ivrEja9e6o7aHOe64tQGHjd/AuV35xEYEHYswYaJgxcnpHmOJpgU+BJjL1U
 JIgnxoYL9or6pAQDg6rLmmLv2DeY0V31tNLSwe4MCvrjgnQr1VptU/VEy3paojI3E23K
 LvQIFBG6P38gFL3PgYqfqw2rC9aOnAYSamPUNB8ie/nSlc2t7O5yaDeoupJ/UTqQYnO0
 Wd4lGvrrEltwgZweTYoPAswW51hCnvddYBRZSffuXMGazqeNx58ZIApw2Diu8Ahpl473
 VftNr6LtWR/GXeuI9GvFoYYsVMWgNhu8lJPH8RcKcqRJVP4LUZDUeBpf0rQbTBmKjyiM
 gTeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyVJYBECJXUsVcefIKVMY9bPqNSe2AupcvwuIgqsYBSETjMM6O4Etqsp54sqkC4iasNGysZnXwGJogxxykChlADJrXxms=
X-Gm-Message-State: AOJu0YxgAXo3MRFWONx3LfP4R1jelJaBH1XAD3fca/NaYPvR7dfci7Za
 yKv9pMFdljSIYi30KSQINYQMKPAFPTRx7fL8V9GvlE9E2XPzTXO5sCzAyxyGfQ+DDU9fIjwkuEb
 Fj06r0VTi7Kib+sEBeZ9q6R/DLXSAOPuYBlSrzx9oBhlqv/cDuw32
X-Received: by 2002:a05:622a:411:b0:42e:5a10:27f0 with SMTP id
 n17-20020a05622a041100b0042e5a1027f0mr16351178qtx.8.1710364309121; 
 Wed, 13 Mar 2024 14:11:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGastwUDFGNcZAVxWzFxhwe+79etmDKmqvi6C0Sv3oUr/36Ra4U/p1l6j6TS3KeTcCMaAMB7A==
X-Received: by 2002:a05:622a:411:b0:42e:5a10:27f0 with SMTP id
 n17-20020a05622a041100b0042e5a1027f0mr16351162qtx.8.1710364308847; 
 Wed, 13 Mar 2024 14:11:48 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 q11-20020ac8450b000000b004308e46e815sm1189908qtn.67.2024.03.13.14.11.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Mar 2024 14:11:47 -0700 (PDT)
Message-ID: <33a8303b-1123-4f10-89b3-ee952cbcf838@redhat.com>
Date: Wed, 13 Mar 2024 22:11:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/iommufd: Fix memory leak
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu
 <yi.l.liu@intel.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>
References: <20240313210628.786224-1-clg@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240313210628.786224-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.971,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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



On 3/13/24 22:06, Cédric Le Goater wrote:
> Make sure variable contents is freed if scanf fails.
>
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Yi Liu <yi.l.liu@intel.com>
> Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Fixes: CID 1540007
> Fixes: 5ee3dc7af785 ("vfio/iommufd: Implement the iommufd backend")
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks!

Eric
> ---
>  hw/vfio/iommufd.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index a75a785e90c64cdcc4d10c88d217801b3f536cdb..cd549e0ee8573e75772c51cc96153762a6bc8550 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -152,9 +152,8 @@ static int iommufd_cdev_getfd(const char *sysfs_path, Error **errp)
>  
>      if (sscanf(contents, "%d:%d", &major, &minor) != 2) {
>          error_setg(errp, "failed to get major:minor for \"%s\"", vfio_dev_path);
> -        goto out_free_dev_path;
> +        goto out_free_contents;
>      }
> -    g_free(contents);
>      vfio_devt = makedev(major, minor);
>  
>      vfio_path = g_strdup_printf("/dev/vfio/devices/%s", dent->d_name);
> @@ -166,6 +165,8 @@ static int iommufd_cdev_getfd(const char *sysfs_path, Error **errp)
>      trace_iommufd_cdev_getfd(vfio_path, ret);
>      g_free(vfio_path);
>  
> +out_free_contents:
> +    g_free(contents);
>  out_free_dev_path:
>      g_free(vfio_dev_path);
>  out_close_dir:


