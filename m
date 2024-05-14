Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C4DFC04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 15:46:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6uLO-0003n6-Nx; Tue, 14 May 2024 11:45:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s6uL7-0003dW-0E
 for qemu-devel@nongnu.org; Tue, 14 May 2024 11:45:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s6uL1-0003tL-G5
 for qemu-devel@nongnu.org; Tue, 14 May 2024 11:45:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715701510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4KdmLP6u2anN+wCbPr6y6F3ZIpONfsEkyaRWyXyqmGE=;
 b=d5nSkxcDEnGkr6he6/fSWjXScjnL+Mgf7a4N7OcNaUN1WgCL1/V7vMqODsgAtGGJeNZOMC
 hclVpR8p9B1o0HxEiuqTw5v53Qf53/UpBe9ww6Vmz7r/Fh9TKP4LlKou7bAXtMkAvvxxbb
 mWdsQTTCMcEPgPY/s0a9agSpk/6yVq8=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-4ZP1h3SuPeuueCszIrrgNw-1; Tue, 14 May 2024 11:45:08 -0400
X-MC-Unique: 4ZP1h3SuPeuueCszIrrgNw-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-792c3250f87so775642985a.1
 for <qemu-devel@nongnu.org>; Tue, 14 May 2024 08:45:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715701508; x=1716306308;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4KdmLP6u2anN+wCbPr6y6F3ZIpONfsEkyaRWyXyqmGE=;
 b=I2+m/4/2ZS/gZLba0ifvRMrQtKmSyQbseVm8gElPFyaNcR7Ne1BxdrLnchc/bO9XPQ
 qxy0S3hqvlO7H43a8tD/AM1Uh6t33nUNanhKCZfeE/gg4HOpMwdKgDtRslrfic4jKaxC
 rUGrX23uc+gzS6glDPqhERZtp6gJyZ8YBqDT1NjosLfoo2OApLqeSqCiCIMoh9DBobDI
 PabSC44jD8XHFM/msmuhXyuecuacFi2+0nxjntQdlQ+rqKrV4afRxTAHcy0/RnfJJrh+
 rbDd/5uJrSkjgE466yQ7M2XbkveElv28TWdcvp+mA8OVPYyCvGvnIuG5yOUDjeWBO/Hc
 Cb9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAFlktNEFWE7+4Dwn723eETXS3I+LBaQeX1ARMBO5bDtfoBE1xPWt5zSWazdab/3O+rto2IH6UunkXGHeQaBx3miq0zo0=
X-Gm-Message-State: AOJu0YyrkfcGj7tYWjKaEbzRdb5Fn54m6rX2GEEwEd5UVusH4YOf8Wsg
 boVnCGFMV2ml/zyPCChvFbifFp79whEQZdZTGNCr6EleKA2fgiFmcVPYlJl/hhqNZi1MLJXYr9O
 GApLV/UlePAug58lamQwKRMWIfyr673t0+HNk8VxM3ew3/ypfcXHL
X-Received: by 2002:a05:620a:1727:b0:790:8656:8427 with SMTP id
 af79cd13be357-792bbdc4de6mr2827357985a.7.1715701507819; 
 Tue, 14 May 2024 08:45:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUaPtpcNNn1O49Ddaf2ZVEv3O6LAIeHOG6VDYWOEIZ1y8S9/LG2VwkpOWf/E/4d1HhhBbvvQ==
X-Received: by 2002:a05:620a:1727:b0:790:8656:8427 with SMTP id
 af79cd13be357-792bbdc4de6mr2827355085a.7.1715701507478; 
 Tue, 14 May 2024 08:45:07 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-792bf340533sm569749185a.133.2024.05.14.08.45.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 May 2024 08:45:07 -0700 (PDT)
Message-ID: <9d615831-a907-43dd-972c-2defa6645759@redhat.com>
Date: Tue, 14 May 2024 17:45:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/11] vfio/pci: Use g_autofree in vfio_realize
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, chao.p.peng@intel.com
References: <20240507064252.457884-1-zhenzhong.duan@intel.com>
 <20240507064252.457884-2-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240507064252.457884-2-zhenzhong.duan@intel.com>
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
> Local pointer name is allocated before vfio_attach_device() call
> and freed after the call.
> 
> Same for tmp when calling realpath().
> 
> Use 'g_autofree' to avoid the g_free() calls.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/pci.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 64780d1b79..576b21e2bb 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2946,12 +2946,13 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>       ERRP_GUARD();
>       VFIOPCIDevice *vdev = VFIO_PCI(pdev);
>       VFIODevice *vbasedev = &vdev->vbasedev;
> -    char *tmp, *subsys;
> +    char *subsys;
>       Error *err = NULL;
>       int i, ret;
>       bool is_mdev;
>       char uuid[UUID_STR_LEN];
> -    char *name;
> +    g_autofree char *name = NULL;
> +    g_autofree char *tmp = NULL;
>   
>       if (vbasedev->fd < 0 && !vbasedev->sysfsdev) {
>           if (!(~vdev->host.domain || ~vdev->host.bus ||
> @@ -2982,7 +2983,6 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>        */
>       tmp = g_strdup_printf("%s/subsystem", vbasedev->sysfsdev);
>       subsys = realpath(tmp, NULL);
> -    g_free(tmp);
>       is_mdev = subsys && (strcmp(subsys, "/sys/bus/mdev") == 0);
>       free(subsys);
>   
> @@ -3003,7 +3003,6 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>   
>       ret = vfio_attach_device(name, vbasedev,
>                                pci_device_iommu_address_space(pdev), errp);
> -    g_free(name);
>       if (ret) {
>           goto error;
>       }


