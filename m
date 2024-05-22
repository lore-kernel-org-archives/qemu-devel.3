Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FA49C25B7D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 07:52:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9glV-0001jW-JB; Wed, 22 May 2024 03:52:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9glT-0001el-Hq
 for qemu-devel@nongnu.org; Wed, 22 May 2024 03:52:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9glJ-00059E-5f
 for qemu-devel@nongnu.org; Wed, 22 May 2024 03:51:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716364308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qPDbP1Qc2riajlUDWy5UoXGdAjb97eT61qZWuxyh+eU=;
 b=ZYA9/NouZgrQPoNJAoMVUEKJHIdsz8iPfKYrEZIVBSuu9yZ2oDMTTMO12PkI51RSW2/apV
 nSWAclEhgdcyEF0zC0Ftgiu7B23ec68jTZqTWBi737vKu6TsRqxYQinDSwQLgYfGf4BN4d
 o32eanUCHC7lQhZP0s3AhCaaGIKTL0U=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-OtV4SKrbNEGZtqTk00-2GA-1; Wed, 22 May 2024 03:51:47 -0400
X-MC-Unique: OtV4SKrbNEGZtqTk00-2GA-1
Received: by mail-yb1-f199.google.com with SMTP id
 3f1490d57ef6-df4da3446beso1761249276.1
 for <qemu-devel@nongnu.org>; Wed, 22 May 2024 00:51:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716364306; x=1716969106;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qPDbP1Qc2riajlUDWy5UoXGdAjb97eT61qZWuxyh+eU=;
 b=g+8uBC4ADo7xgijSDTC1SIZwA0//sJIqZ9AGhlgJ11xK4Cyd9jT+aE6TpynKbddpKO
 Dtw9U6dPKkx3OBVpu+OAlBeVd/QA0mZu7WVMWO90oKE6n1zZHiDlg2RqmJLG77sOMR8R
 kEf37zMRls4Ylf1Iy+PHV56U+KwM5pAxosFl9GWwmhDqFe1IOD8BwZKq9KBdpUl0qyiU
 G2bB/SGeGnt6k5dXyEwd0ahjvAdjAZ3O8YwTaVtWX6yXja5Z5S3ItpGVBLHOx3X/VVyZ
 X9oJVlC+21L99RognRLml9AzGBSEBQTGElSX8HD6F9oYi65gfpGGbH4aV5XehRhfwUHh
 i8Hw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBhuk8zihIfS6K1Js/wudJOY9Qs1ttD9iotm/Hz9ePiZ63DWIfTr5oGgkg7g89si1mAiYb1ApRWkVhQ6mvkoGHBhyMwzw=
X-Gm-Message-State: AOJu0YzgrFFmJkFJqL/RZhhn0sMG98q2zUTcwKwKVz5JEmk6ABB95II9
 tGQkRbqhDFfUlmLxr+bTWUjLFRppNWqOlY+DL8pLh4vawjtbrPOAVo4fAYvSr7iCVcgDIcDPbIQ
 lmCWKIJA3p8hNSaKhaYtHF2lQbAZoXaVa9mu6ypyecFljsWYZuHYe
X-Received: by 2002:a25:dc0e:0:b0:de5:9e4b:4c92 with SMTP id
 3f1490d57ef6-df4e0da4e5emr1295144276.49.1716364306290; 
 Wed, 22 May 2024 00:51:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErBGKalJ3l7DjIVdVyB/SIKCPjbZz3KOgd9q3TcJeVENlaV8g8gCVCOlut0Q2OQJBZIR64Og==
X-Received: by 2002:a25:dc0e:0:b0:de5:9e4b:4c92 with SMTP id
 3f1490d57ef6-df4e0da4e5emr1295137276.49.1716364305983; 
 Wed, 22 May 2024 00:51:45 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ab873f7108sm1504666d6.125.2024.05.22.00.51.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 May 2024 00:51:45 -0700 (PDT)
Message-ID: <8e3efc39-b8a1-4750-86d3-1d2451ad2b65@redhat.com>
Date: Wed, 22 May 2024 09:51:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 20/20] vfio/ccw: Fix the missed unrealize() call in
 error path
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, chao.p.peng@intel.com, 
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, "open list:vfio-ccw" <qemu-s390x@nongnu.org>
References: <20240522044015.412951-1-zhenzhong.duan@intel.com>
 <20240522044015.412951-21-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240522044015.412951-21-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 5/22/24 06:40, Zhenzhong Duan wrote:
> When get name failed, we should call unrealize() so that
> vfio_ccw_realize() is self contained.
> 
> Fixes: 909a6254eda ("vfio/ccw: Make vfio cdev pre-openable by passing a file handle")
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

If the realize handler fails, the unrealize handler should be called.
See device_set_realized(). We should be fine without IMO.


Thanks,

C.


  
> ---
>   hw/vfio/ccw.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index 168c9e5973..161704cd7b 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -589,7 +589,7 @@ static void vfio_ccw_realize(DeviceState *dev, Error **errp)
>       }
>   
>       if (!vfio_device_get_name(vbasedev, errp)) {
> -        return;
> +        goto out_unrealize;
>       }
>   
>       if (!vfio_attach_device(cdev->mdevid, vbasedev,
> @@ -633,6 +633,7 @@ out_region_err:
>       vfio_detach_device(vbasedev);
>   out_attach_dev_err:
>       g_free(vbasedev->name);
> +out_unrealize:
>       if (cdc->unrealize) {
>           cdc->unrealize(cdev);
>       }


