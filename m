Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA4E2C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 18:26:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfl6R-0008Di-8u; Thu, 29 Feb 2024 13:25:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rfl6K-00084o-3E
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 13:25:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rfl6E-0004b8-Hy
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 13:25:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709231142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y9MfR6yFiL6Yf+nePk+1nulIFtYsNR4W/XvrcCNJtF0=;
 b=MnDSo3Tyk5VYauhMTuCitmFQzusTxGISS9wlt03KKmOcBUCPL2CIAPSLO8OuEjguY8uIRT
 1hP7X0UCZfPIE82tCLYczZ8sNX8YFRFHPpgJf+WssBmcSbiBc/YS2VLOXZKpSgnmnjbV16
 Lz02uX718h9MApWfeM2vANmSYYo8cOY=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-zsAaJBPLOM2I2iiS53qpfQ-1; Thu, 29 Feb 2024 13:25:40 -0500
X-MC-Unique: zsAaJBPLOM2I2iiS53qpfQ-1
Received: by mail-oo1-f72.google.com with SMTP id
 006d021491bc7-5a0b99d6f2bso1128150eaf.0
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 10:25:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709231140; x=1709835940;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Y9MfR6yFiL6Yf+nePk+1nulIFtYsNR4W/XvrcCNJtF0=;
 b=btwiCM2FD4dFPr2ZjYAY2PdeOJQ41pXxzL9ae5yQz7x6lp5sR1FKSPStqJejhtT6wV
 HifCnPh3t7wogPqj4rSc9RNB3FRpC4jWelvV1iZKATEMaQWS53vv3806QUQvezt2fcjU
 TDR6WI3euCiX3Bmy/W02I9Wzp3F79Hsqe3dDo27YztPPIKaUuGfGbI7US7XXEawjIzOb
 Xp+P6iF+RllTvpn5DW8pfLs5g20iqw6evgIBtlRiXHLLQYFFZTu7Pmimq0GZFMF/GXJX
 heCs+CkxuIjhxmAAeODu19WIQ9u6ejXZI5yI4/1n2g8SIQfAyqJI2HisD/UsO7QFLXBi
 Ippw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmWxYDnG8X+GxyiGO9uCWIxN3DpCb6MxOxbRNOCNyficSC2Ux4jxuvRLJ3yiZPd46YpVoQoeYm8hlMA/zOWKIs3GpJ120=
X-Gm-Message-State: AOJu0Yzl87+bBdurg8+ovs1GLwY+F9yfX35v/tHoUORn4FxqrI5/MdJR
 AZeWlodMRRqm3iaLCkHVy0d3TWp5dvI77Gg15cY3bXQt8qlI4RcJ5ctou9W2ToV0lInOzfsEoZh
 m7dIJl1FgNWfOxlkkx5O3PfHBHMUsnp1MQ47DRwSV7ipVcKautfk9
X-Received: by 2002:a05:6358:8a1:b0:17a:e17f:7f01 with SMTP id
 m33-20020a05635808a100b0017ae17f7f01mr3763032rwj.23.1709231139775; 
 Thu, 29 Feb 2024 10:25:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF3TaJoSzHBiKhuDTYUMStrjWnMdVie2ChbmfQKmt/zcxJyLzzl8AGeA7tmjiNWlCigQGLGig==
X-Received: by 2002:a05:6358:8a1:b0:17a:e17f:7f01 with SMTP id
 m33-20020a05635808a100b0017ae17f7f01mr3763013rwj.23.1709231139442; 
 Thu, 29 Feb 2024 10:25:39 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 qp11-20020a056214598b00b0068fef74fdb3sm994819qvb.59.2024.02.29.10.25.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Feb 2024 10:25:38 -0800 (PST)
Message-ID: <0a2b147e-0876-4ef4-85c0-9fa8eb7046e3@redhat.com>
Date: Thu, 29 Feb 2024 19:25:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/17] hw/vfio/platform: Fix missing ERRP_GUARD() for
 error_prepend()
Content-Language: en-US, fr
To: Zhao Liu <zhao1.liu@linux.intel.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Michael Tokarev <mjt@tls.msk.ru>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20240229143914.1977550-1-zhao1.liu@linux.intel.com>
 <20240229143914.1977550-12-zhao1.liu@linux.intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240229143914.1977550-12-zhao1.liu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
> The vfio_platform_realize() passes @errp to error_prepend(), and as a
> DeviceClass.realize method, its @errp is so widely sourced that it is
> necessary to protect it with ERRP_GUARD().
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
>   hw/vfio/platform.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
> index a8d9b7da633e..dcd2365fb353 100644
> --- a/hw/vfio/platform.c
> +++ b/hw/vfio/platform.c
> @@ -576,6 +576,7 @@ static int vfio_base_device_init(VFIODevice *vbasedev, Error **errp)
>    */
>   static void vfio_platform_realize(DeviceState *dev, Error **errp)
>   {
> +    ERRP_GUARD();
>       VFIOPlatformDevice *vdev = VFIO_PLATFORM_DEVICE(dev);
>       SysBusDevice *sbdev = SYS_BUS_DEVICE(dev);
>       VFIODevice *vbasedev = &vdev->vbasedev;


