Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEB85C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 08:53:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA4C6-0001H2-5e; Thu, 23 May 2024 04:53:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sA4C3-0001Fu-Cw
 for qemu-devel@nongnu.org; Thu, 23 May 2024 04:52:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sA4C1-0007qY-P3
 for qemu-devel@nongnu.org; Thu, 23 May 2024 04:52:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716454376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YDMq8dUlxSyWg7491Qcv2Je80kiZMnT9MByHGzyXBA4=;
 b=iTht0CsfKNZUYXgcN+4t3UoGaPXrFVoFfxtzghMoAsDfLKIv71J+mVn3MuFHkRNwivj0Jj
 TAR9NAOah+nA42RrQ3vf9nFBJBjbSA06RBdsZqi8nlixaMt6TChQ0BK62q6prO+4zXaSrU
 O98KZwk5JNYjJVMQ9RlKnm+Uy8F3ZQw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-uI0EzDJfNOe1Six26gCBTw-1; Thu, 23 May 2024 04:52:13 -0400
X-MC-Unique: uI0EzDJfNOe1Six26gCBTw-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-792fadf7b61so981491885a.2
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 01:52:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716454333; x=1717059133;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YDMq8dUlxSyWg7491Qcv2Je80kiZMnT9MByHGzyXBA4=;
 b=WnYMZZINxDZPAMBv/yPNBzoiABo81+tuE87qy0aLlevSV49BXnWX00yTgvtQ+7kjHF
 8SsmicKCZeTY8u70dfBGneKz34562aozaiETaDUXgOk+qygjmiWLJXBcx3QitoZaRhal
 lzu2uS6kJ1jGSWqVWK1xHspigsAgqPV15Qp9s3dM0dYM1KV71rKYwN90cnBXYeooQMz7
 qbgyqfyNNp8Thaqx2JIfsogppupG3LDNr/s7FCAFeAP8SuG8l6pt0ppuaZALLKqEWsjf
 qV6trBEsgm0nbktIOKHTpJb6BN1bxY0AP6oQQhJuo1PJ3P2z3W4YThhsAjhjZifaSMvV
 eyzQ==
X-Gm-Message-State: AOJu0YzYCkE3fEkRpSMOjyIL51CT9UXDzCS7q3LmuNISKvhdi6UV6ROS
 Dc/a5QecLuvOWF2iSVkZJtZpqINKrAIn2eF+cnxnOulOdxjQPd8ozI1wQijqYnPX31BGPG0S6xc
 I7Zv7HrTF8akNyfIjdknPgHOj2a93kG3c5d3V+EBXt6//lKz1znOVmcQF8Cx61Pk9lq/YpZMbQT
 xVl7mvTSZK7bypUZGbgP/5pPr671rS/g==
X-Received: by 2002:a05:620a:1da3:b0:792:9295:6828 with SMTP id
 af79cd13be357-79499454ecdmr422895685a.38.1716454332789; 
 Thu, 23 May 2024 01:52:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFq4nABd6yw8DdTOarslIn+Zkc8Bz23+HQaeXCS1byEHM4o00LG+8a8K/TPtoLIMRaUUudNIw==
X-Received: by 2002:a05:620a:1da3:b0:792:9295:6828 with SMTP id
 af79cd13be357-79499454ecdmr422893185a.38.1716454332260; 
 Thu, 23 May 2024 01:52:12 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-792bf2fc5a7sm1470868085a.84.2024.05.23.01.52.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 May 2024 01:52:11 -0700 (PDT)
Message-ID: <5b724d71-9f15-42f5-98f4-a592c0223cfd@redhat.com>
Date: Thu, 23 May 2024 10:52:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] vfio/ccw: Fix the missed unrealize() call in error
 path
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>
References: <20240522170107.289532-1-clg@redhat.com>
 <20240522170107.289532-7-clg@redhat.com>
Content-Language: en-US, fr
In-Reply-To: <20240522170107.289532-7-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 5/22/24 19:01, Cédric Le Goater wrote:
> From: Zhenzhong Duan <zhenzhong.duan@intel.com>
> 
> When get name failed, we should call unrealize() so that
> vfio_ccw_realize() is self contained.
> 
> Fixes: 909a6254eda ("vfio/ccw: Make vfio cdev pre-openable by passing a file handle")
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/ccw.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index a468fa2342b97e0ee36bd5fb8443025cc90a0453..36f2677a448c5e31523dcc3de7d973ec70e4a13c 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -588,7 +588,7 @@ static void vfio_ccw_realize(DeviceState *dev, Error **errp)
>       }
>   
>       if (!vfio_device_get_name(vbasedev, errp)) {
> -        return;
> +        goto out_unrealize;
>       }
>   
>       if (!vfio_attach_device(cdev->mdevid, vbasedev,
> @@ -631,6 +631,7 @@ out_region_err:
>       vfio_detach_device(vbasedev);
>   out_attach_dev_err:
>       g_free(vbasedev->name);
> +out_unrealize:
>       if (cdc->unrealize) {
>           cdc->unrealize(cdev);
>       }


