Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62BC0CAC5AE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 13:57:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Pz7-00035x-VH; Wed, 24 Sep 2025 09:56:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v1Pz5-000307-4R
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 09:56:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v1Pyx-0007WC-40
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 09:56:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758722185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=zxTOzqjBPq/eTvRWN4x9z9mpBrw9YGiPBVp5haAR8oc=;
 b=hoMAyhypjG7bMTyf3GzwzEFYAia+6fUxvjjNScAQDvpCAb87p+YCf4VHhnlo4HxF3jFR2j
 +oeyamx3/+MzRJXzlTL0z8pIUZmK2LJ+niXHbM17P69MoR0b+dCaFrZ57XHPVhsKtd6bzi
 AMjHonx1reY705Ls2DpfQDtTE+0v7sU=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-ZHXMUuWOPY6Tqc7DOHXETg-1; Wed, 24 Sep 2025 09:56:21 -0400
X-MC-Unique: ZHXMUuWOPY6Tqc7DOHXETg-1
X-Mimecast-MFC-AGG-ID: ZHXMUuWOPY6Tqc7DOHXETg_1758722180
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-35225b4ddaaso37439801fa.0
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 06:56:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758722179; x=1759326979;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zxTOzqjBPq/eTvRWN4x9z9mpBrw9YGiPBVp5haAR8oc=;
 b=sdPD5YTawi+q3Y9sVdRKihD1Kgc1So9BrnFz9L429yE9ytBGl9vnJQqBQ3bdvOShYF
 D8F7+kkOerB5LFz6O0p4ktMz3O+kriEAGErQMLiFn+PK7Oo/WbtIrgPTKKXWeWt7KHJR
 791HkF/ldkgXfOljpAUZTlW1bNGaJgwzfRE7B3qm9eyC6hDzsxh80TW/W87Gbc+zl9DC
 lUN6wb9n7XlJ+DGUaBINA4CyyZeLhYtVEUWbaEnqrP9rm0mgSKUhjZXFT+bcfflTnniy
 PZvZLXr1XjgisynFUxKaxrPnMcVCaNiT4DDEY9DS5JPskBVrLF9GUTn+s3tmmLvEDPgG
 r8Qg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9HSYFAU0Z+zpe6Vyo6oiDtsA4cIrpXWNyVkyKEpbLBVCF86K+L3TjOkboIzlHrN3eNLETytCQXEsH@nongnu.org
X-Gm-Message-State: AOJu0YzzW0uGqwfKCa7zoC50pOgFFtnh4p4Th+uPPFEQbZ+Cy/DKw7DU
 sUtr+1jb93G2SbiMpsmUJPiDf+eN8ta+TTDex6s/Wc55U8IqzFblBos6USqiO6Cb8KwXYlXbdcl
 nFO6YOL4c2V5cJuR4pJkXL4PhMDhFGc0l7nrhSUivBfJuwg9EeL3gplKD
X-Gm-Gg: ASbGncuTO1uNZdKH1FOrTZ1vMya8aR4U+OGilC+LzejhuR0ZiUYMindGnv2ToDY/NkY
 H0BADMy9mbCK+z2zBXq9ZFSvC0SVvXJWDUiSt7Vov+miBVRK1/c7UCVC50fWDTKKD8+K42v060U
 hgxM70hL4JqybaJZ0mzDNmSopAd/w8+v55sF0mX7RvGFMsYzTYKMLqRHJt+WYT6zT1gz0gkE8xM
 wUWLGrVgtCdSVWU2nbJGS8pAnG9cwlfQ3+J978ztMkUH9ciJSU0gsNQ9BWZuhf3eCwK0qZpyDOo
 Upbtj9qVkSHz1KbyEh5GqGzc/x2A/kF5F9m4/3cMslBf2K+gx+94KLIdrWSF+fBNBj99sxHyWxb
 WknI=
X-Received: by 2002:a05:651c:31cb:b0:353:a8f5:3ebc with SMTP id
 38308e7fff4ca-36d177d8838mr19961051fa.42.1758722179579; 
 Wed, 24 Sep 2025 06:56:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFt1xycnYZpXilnFLClNwdagYiEyNNGw+z4U4r/+ytFgv6KM2fgL68QIe1EEQDq9aqqy+6yyw==
X-Received: by 2002:a05:651c:31cb:b0:353:a8f5:3ebc with SMTP id
 38308e7fff4ca-36d177d8838mr19960841fa.42.1758722179134; 
 Wed, 24 Sep 2025 06:56:19 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-366e29e4378sm29434731fa.53.2025.09.24.06.56.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Sep 2025 06:56:18 -0700 (PDT)
Message-ID: <10228495-de9d-429a-a522-93b4b57fa9c6@redhat.com>
Date: Wed, 24 Sep 2025 15:56:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/27] vfio/cpr-iommufd.c: use QOM casts where appropriate
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, npiggin@gmail.com,
 harshpb@linux.ibm.com, mjrosato@linux.ibm.com, farman@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, thuth@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 john.levon@nutanix.com, thanos.makatos@nutanix.com,
 alex.williamson@redhat.com, steven.sistare@oracle.com, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20250923135352.1157250-1-mark.caveayland@nutanix.com>
 <20250923135352.1157250-9-mark.caveayland@nutanix.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250923135352.1157250-9-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 9/23/25 15:53, Mark Cave-Ayland wrote:
> Use QOM casts to convert between VFIOIOMMUFDContainer and VFIOContainer instead
> of accessing bcontainer directly.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>   hw/vfio/cpr-iommufd.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/vfio/cpr-iommufd.c b/hw/vfio/cpr-iommufd.c
> index 6aaf6f77a2..1d70c87996 100644
> --- a/hw/vfio/cpr-iommufd.c
> +++ b/hw/vfio/cpr-iommufd.c
> @@ -176,7 +176,7 @@ void vfio_iommufd_cpr_unregister_iommufd(IOMMUFDBackend *be)
>   bool vfio_iommufd_cpr_register_container(VFIOIOMMUFDContainer *container,
>                                            Error **errp)
>   {
> -    VFIOContainer *bcontainer = &container->bcontainer;
> +    VFIOContainer *bcontainer = VFIO_IOMMU(container);
>   
>       migration_add_notifier_mode(&bcontainer->cpr_reboot_notifier,
>                                   vfio_cpr_reboot_notifier,
> @@ -189,7 +189,7 @@ bool vfio_iommufd_cpr_register_container(VFIOIOMMUFDContainer *container,
>   
>   void vfio_iommufd_cpr_unregister_container(VFIOIOMMUFDContainer *container)
>   {
> -    VFIOContainer *bcontainer = &container->bcontainer;
> +    VFIOContainer *bcontainer = VFIO_IOMMU(container);
>   
>       migration_remove_notifier(&bcontainer->cpr_reboot_notifier);
>   }



Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



