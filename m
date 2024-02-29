Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DFC4C54E49
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 18:23:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfl49-0005IW-Sd; Thu, 29 Feb 2024 13:23:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rfl48-0005BV-MY
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 13:23:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rfl45-0003wM-OH
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 13:23:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709231009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qastcp8CQGXthHZuPdOFfJywS2j1TI3CPTiTjAPpUq0=;
 b=McPfRkg0yaX3fNaxaSjfc/43Yt2zf8P27lhTOftSMKzNC1n46AvWC1xmZqsFk+lanUuNLu
 rgFHmq203i6I9AnM+ZcVnTqekssaMN7YCFgzTOGFdmUmCn8ftpguuSX0Ky+VNsdHcUvgih
 2vbQ9xc78MZYKFbab9YIEh9QlJNAQg4=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-xZ47ssOuNeCG2C982yEJpQ-1; Thu, 29 Feb 2024 13:23:27 -0500
X-MC-Unique: xZ47ssOuNeCG2C982yEJpQ-1
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-5a0b99d6f2bso1123908eaf.0
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 10:23:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709231006; x=1709835806;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qastcp8CQGXthHZuPdOFfJywS2j1TI3CPTiTjAPpUq0=;
 b=iLaIvgV7Y/tdu4n8CKqCwu88FcN6O8ky4hej5NrtLtR90DVHYsNprsIqZKQ8IXpPCt
 EbYF8TDRO2EXB4rLuMjlBbZFH6dXALvKqwAYuY0gEiW7HzsjSkuBdToAuA/nVvqq0glH
 ot4G5qsF5nKECeZjsMMszlIz6Ft/cbYWsikZXjjiWoAHl22tdvy0rrQHgXNlHoR5yd1E
 yhXoHApuXDDHhpssQDVlLs2P+M4B6cFGt4sMu3XfQWLCDuMXjzk7A77gA2fq74mxztk/
 5vOSSwKCMogCd9wCwcik7mSjBIhdkrUaRrBY24mxkEoymLt1qOWVsG+16hMUwe8OZY7g
 tR7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWU2vJMVJmJT1mbkXiP8PReaoEZejmZHNk42IvHXGcTUKULQBNZ09vs0l2tKMj1Lg8fRYizuhdx7KlUqcAyJYsTHuhOO0=
X-Gm-Message-State: AOJu0YxeT5HtjQkuOARHS2dwKUk9VMMFiElt1y0RD+oIrTV3xnZMJPyb
 9urSm92xUNSCx+DW2nax+YJtjgqXK0wqfyCALtqvVxFIK4VJxg+Nng1OlDHgVupeq5LyWw8oOr2
 wqfmWkLnZ78cXukpMLWLgCN5GCiHZUVRjYBk3OwNVE/XA+rQw3Nsq
X-Received: by 2002:a05:6358:7e85:b0:17b:b830:2809 with SMTP id
 o5-20020a0563587e8500b0017bb8302809mr3618422rwn.19.1709231006274; 
 Thu, 29 Feb 2024 10:23:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEBmcvqtDdbJG2GiWKBOMOx9PjmZCYsFOJbH35xdHtSvRX5Q/EAL6eZObabWPj6FVjgY8PgCw==
X-Received: by 2002:a05:6358:7e85:b0:17b:b830:2809 with SMTP id
 o5-20020a0563587e8500b0017bb8302809mr3618410rwn.19.1709231006007; 
 Thu, 29 Feb 2024 10:23:26 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 qp11-20020a056214598b00b0068fef74fdb3sm994819qvb.59.2024.02.29.10.23.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Feb 2024 10:23:25 -0800 (PST)
Message-ID: <dd68947e-5edd-41d7-893e-6e75df2086b8@redhat.com>
Date: Thu, 29 Feb 2024 19:23:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/17] hw/vfio/iommufd: Fix missing ERRP_GUARD() for
 error_prepend()
Content-Language: en-US, fr
To: Zhao Liu <zhao1.liu@linux.intel.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Michael Tokarev <mjt@tls.msk.ru>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20240229143914.1977550-1-zhao1.liu@linux.intel.com>
 <20240229143914.1977550-9-zhao1.liu@linux.intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240229143914.1977550-9-zhao1.liu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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

On 2/29/24 15:39, Zhao Liu wrote:
> From: Zhao Liu <zhao1.liu@intel.com>
> 
> As the comment in qapi/error, passing @errp to error_prepend() requires
> ERRP_GUARD():
> 
> * = Why, when and how to use ERRP_GUARD() =
> *
> * Without ERRP_GUARD(), use of the @errp parameter is restricted:
> ...
> * - It should not be passed to error_prepend(), error_vprepend() or
> *   error_append_hint(), because that doesn't work with &error_fatal.
> * ERRP_GUARD() lifts these restrictions.
> *
> * To use ERRP_GUARD(), add it right at the beginning of the function.
> * @errp can then be used without worrying about the argument being
> * NULL or &error_fatal.
> 
> ERRP_GUARD() could avoid the case when @errp is the pointer of
> error_fatal, the user can't see this additional information, because
> exit() happens in error_setg earlier than information is added [1].
> 
> The iommufd_cdev_getfd() passes @errp to error_prepend(). Its @errp is
> from vfio_attach_device(), which @errp parameter is so widely sourced
> that it is necessary to protect it with ERRP_GUARD().
> 
> To avoid the issue like [1] said, add missing ERRP_GUARD() at the
> beginning of this function.
> 
> [1]: Issue description in the commit message of commit ae7c80a7bd73
>       ("error: New macro ERRP_GUARD()").
> 
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: "Cédric Le Goater" <clg@redhat.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/iommufd.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 9bfddc136089..7baf49e6ee9e 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -116,6 +116,7 @@ static void iommufd_cdev_unbind_and_disconnect(VFIODevice *vbasedev)
>   
>   static int iommufd_cdev_getfd(const char *sysfs_path, Error **errp)
>   {
> +    ERRP_GUARD();
>       long int ret = -ENOTTY;
>       char *path, *vfio_dev_path = NULL, *vfio_path = NULL;
>       DIR *dir = NULL;


