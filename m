Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17696C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 18:24:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfl4l-0005yn-Be; Thu, 29 Feb 2024 13:24:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rfl4f-0005sf-FF
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 13:24:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rfl4d-00046k-4p
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 13:24:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709231042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F3pIRz+zVLrKRYcSc+itWPqUw50CxhlRnpCLFrGPO6A=;
 b=HgQiDObTN1gk7MHea24IPmLIHKpikr9xZc52V0nAEk4OOwod73RED7FzfpzTUU6cGtCT0M
 cduWCYjFy2HThNXj2WkM2Fw4Pp+3rPAKXD5/h5VxQ3l1GsD9eztZ3lmAW3YvdRyhpR+K4E
 ISadPfl7vL3U3FEC18P9VeOb4sQAB1Q=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-86Zg6f8xOUanssxplteaRA-1; Thu, 29 Feb 2024 13:24:01 -0500
X-MC-Unique: 86Zg6f8xOUanssxplteaRA-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-68fd31a5cafso9989386d6.0
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 10:24:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709231040; x=1709835840;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F3pIRz+zVLrKRYcSc+itWPqUw50CxhlRnpCLFrGPO6A=;
 b=UsgHtPOaiRL8dZoKgtM4x6SFlsSpcbQBZSSK4XKsG9fDXdZEaqIX/lYeMe+uaHTn6H
 ybP9LxuHu4aHGuTmH0aIGkopLYuIAf1anl0sFXZQWgFO5rx9rxjsE85E0uQfeneBcTbF
 tWanvFhcSrsjQmQC0GQOXSIO/ztLIulgZsqLIwzIgn041X7txbKCHNNEbnU0kkHYnc6Y
 Sjbun/5DOKBwY1e/+lBuVDh4RNkrEBNpL+T0zvrgRHd21MdQvcGv81g3fDKbs7x8FEO7
 KFOjGrGQChYxZZSGlrr/PzTrH9ak4XNBDNJqd5AJfaR+HarKVy1OlMWac/PN4bjd6QBJ
 NxSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXU0BhSPLBZhR11iX1ncHxNaXv9Sj+FfoWLq0ZXH0r+1YJOm3XPFmHi7TH6ZS41CTnv4tg7sapOcVZTlUGbUHwnO395mTM=
X-Gm-Message-State: AOJu0YzTHybzd8P0Y7hzjYS9Ui7Q9fOxPVlQ/5baaeL3cR7/BIGMdt09
 Qd1ipJFACLieCkQsV8eMzlUfl+CkmFZfdeZ+42iFdJx0pDrcFZK+wJj1yNCv61J4Fn0utnNAwNk
 LnQeB/3X9JzeJWrd7r6NyYanNNZRriBX7+CxkNCRPC34W8FhScV4p
X-Received: by 2002:a05:6214:1083:b0:690:4de5:8483 with SMTP id
 o3-20020a056214108300b006904de58483mr1506488qvr.37.1709231040683; 
 Thu, 29 Feb 2024 10:24:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH/ODcYrlub94A9B4Gl6SZs3Mz2ZNeh+hvr0h2H5MfHFgl1D6PyYOWt9onu0KzKHwI4bfOaJA==
X-Received: by 2002:a05:6214:1083:b0:690:4de5:8483 with SMTP id
 o3-20020a056214108300b006904de58483mr1506474qvr.37.1709231040409; 
 Thu, 29 Feb 2024 10:24:00 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 qp11-20020a056214598b00b0068fef74fdb3sm994819qvb.59.2024.02.29.10.23.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Feb 2024 10:23:59 -0800 (PST)
Message-ID: <389190e1-cf8c-4cc5-bae0-3ce93c00f495@redhat.com>
Date: Thu, 29 Feb 2024 19:23:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/17] hw/vfio/pci-quirks: Fix missing ERRP_GUARD() for
 error_prepend()
Content-Language: en-US, fr
To: Zhao Liu <zhao1.liu@linux.intel.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Michael Tokarev <mjt@tls.msk.ru>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20240229143914.1977550-1-zhao1.liu@linux.intel.com>
 <20240229143914.1977550-10-zhao1.liu@linux.intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240229143914.1977550-10-zhao1.liu@linux.intel.com>
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
> In hw/vfio/pci-quirks.c, there're 2 functions passing @errp to
> error_prepend() without ERRP_GUARD():
> - vfio_add_nv_gpudirect_cap()
> - vfio_add_vmd_shadow_cap()
> 
> Their @errp parameters are so widely sourced that it is necessary to
> protect them with ERRP_GUARD().
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
>   hw/vfio/pci-quirks.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
> index 84b1a7b9485c..496fd1ee86bd 100644
> --- a/hw/vfio/pci-quirks.c
> +++ b/hw/vfio/pci-quirks.c
> @@ -1538,6 +1538,7 @@ static bool is_valid_std_cap_offset(uint8_t pos)
>   
>   static int vfio_add_nv_gpudirect_cap(VFIOPCIDevice *vdev, Error **errp)
>   {
> +    ERRP_GUARD();
>       PCIDevice *pdev = &vdev->pdev;
>       int ret, pos;
>       bool c8_conflict = false, d4_conflict = false;
> @@ -1630,6 +1631,7 @@ static int vfio_add_nv_gpudirect_cap(VFIOPCIDevice *vdev, Error **errp)
>   #define VMD_SHADOW_CAP_LEN 24
>   static int vfio_add_vmd_shadow_cap(VFIOPCIDevice *vdev, Error **errp)
>   {
> +    ERRP_GUARD();
>       uint8_t membar_phys[16];
>       int ret, pos = 0xE8;
>   


