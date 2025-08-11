Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9CFAC87FDB
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 11:46:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulQy1-0002fZ-Tp; Mon, 11 Aug 2025 07:45:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ulQxp-0002eV-Ib
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 07:45:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ulQxj-0008Pm-1V
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 07:45:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754912708;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=yDldk+9f5+uVSECZijfj/FYE8aEdiR+THigFff5P6d0=;
 b=gMwLi7nJItNUaHz6ylejmBvv806bpBxyhnVJZAG7F55U5h/NA/aj5jx44aoFfvlqsHgMYq
 Mw93+LbVgejM90fO7yFQpHeUi5Ma9KGiueMa42r17Q0s+Oz6gC0facizOXaMufA9uzGAFQ
 HZQIChadi7Y8mHOmLsThKHeFHL72q7E=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-RJSRGYEFOdmO3H3OnU2lfw-1; Mon, 11 Aug 2025 07:45:07 -0400
X-MC-Unique: RJSRGYEFOdmO3H3OnU2lfw-1
X-Mimecast-MFC-AGG-ID: RJSRGYEFOdmO3H3OnU2lfw_1754912706
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-70771983a52so91350076d6.2
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 04:45:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754912706; x=1755517506;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yDldk+9f5+uVSECZijfj/FYE8aEdiR+THigFff5P6d0=;
 b=KGhjxVNUXXdae5TakHHgy9IJlOM2w5lwyIg+ivuaok8J8m5u6jLp5xwJuG929oeUmJ
 g9qbHg4/p+n+fVVIEcWjeMPpYujFhk4jE2yHiSVC1x9fMoOsjzHyUDq5vkBSybI79bPT
 tbJ/GBYSa1BvkcLq4+0HHgziSLLEmn/jy6medc97N815LSF+6D9DQTysxToLV8bQ+2Ad
 hF+nLrdf7FdCnMKVowgtlx2GKXTS5WDYQpM9SdD+7saviQpyuC+9i9Pzb+Qvy5GHNS5U
 JRX9wLp2nMB9i+sEZGa0KCmFfm8oFzNFSe6g3C/z8FOY+Y87qVxXRMx+N6oCDMPgMIqV
 Md1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWC6AYqGv81beVXjD2pZfFU4JGWs54NNAdmZ4T7uoNqvO0b/WNDpomo/2eMIbau0ryDXlUn+R+DmOPM@nongnu.org
X-Gm-Message-State: AOJu0Yy6xYfqHygUoza8XvW0WkXz/+cGD6Izet2WeHcu+q2g/wbFqHYN
 fUvFI1mhOYrgLlZNIde7HdrXK2tenD+rbeU81FjY4FiCSCXqXzJVI9Tbn0rP9PVDaBbaVT6Siix
 h04grDGPD9NxuCMId5rN9bYVVdd6hr9xpJIkVk7WlpUFLo3jYzTZBIXd9
X-Gm-Gg: ASbGncuee/Fgilw3Eybq2NmRSCYoCNKKBqYovcUi2dtc5S7quRI5jBQ5ifLRJJrxiEa
 Er7exTKZEQEcmpBSHlCONNWdnm07Ru/gypAoQU4Z1I/JmpUM+sGHIOQ1pTWhGStf8eiFczdTHbK
 mlsSMMn/zQ3bP4o7f8WqwUtXrhRS4ffeoPfymrSDREXApw8SF3ZWBuywBp8u4MYGGjQFD63JxvD
 PsJZ+w9LR7CWPCwpwt8E28u4R5NTh3LyPfKO1xe5OshXm+STu4Li31COdQPUcJLx9ff4tGLIWZI
 qfhXYsmd+PY/8pwBgTal/c1B1+VnC7/rBLMkr0/EuKo6hWUrIil0YkW3uJLv4PaM8Wbes5wlPA/
 yKg==
X-Received: by 2002:a05:6214:5c82:b0:709:9e64:93f5 with SMTP id
 6a1803df08f44-7099e64973amr131802036d6.41.1754912706354; 
 Mon, 11 Aug 2025 04:45:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9nMrfxjl0g2jaLnSZCPFv16Fv1jte/6tA9A/Fz2gK1+4o4oPmkC/4kOcMTI9BNbiCwEXEjA==
X-Received: by 2002:a05:6214:5c82:b0:709:9e64:93f5 with SMTP id
 6a1803df08f44-7099e64973amr131801456d6.41.1754912705798; 
 Mon, 11 Aug 2025 04:45:05 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-7077c9da46esm154810336d6.3.2025.08.11.04.45.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Aug 2025 04:45:05 -0700 (PDT)
Message-ID: <b80832ef-636c-4f6d-b58e-bdee977fe4e2@redhat.com>
Date: Mon, 11 Aug 2025 13:45:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/22] vfio/vfio-container-base.h: update
 VFIOContainerBase declaration
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, npiggin@gmail.com,
 danielhb413@gmail.com, harshpb@linux.ibm.com, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 alex.williamson@redhat.com, steven.sistare@oracle.com,
 tomitamoeko@gmail.com, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20250715093110.107317-1-mark.caveayland@nutanix.com>
 <20250715093110.107317-2-mark.caveayland@nutanix.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250715093110.107317-2-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 7/15/25 11:25, Mark Cave-Ayland wrote:
> Update the VFIOContainerBase declaration to match our current coding
> guidelines: remove the explicit typedef (this is already handled by the
> OBJECT_DECLARE_TYPE() macro), add a blank line after the parent object,
> rename parent to parent_obj, and move the macro declaration next to the
> VFIOContainerBase struct declaration.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   include/hw/vfio/vfio-container-base.h | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
> index bded6e993f..acbd48a18a 100644
> --- a/include/hw/vfio/vfio-container-base.h
> +++ b/include/hw/vfio/vfio-container-base.h
> @@ -33,8 +33,9 @@ typedef struct VFIOAddressSpace {
>   /*
>    * This is the base object for vfio container backends
>    */
> -typedef struct VFIOContainerBase {
> -    Object parent;
> +struct VFIOContainerBase {
> +    Object parent_obj;
> +
>       VFIOAddressSpace *space;
>       MemoryListener listener;
>       Error *error;
> @@ -51,7 +52,10 @@ typedef struct VFIOContainerBase {
>       QLIST_HEAD(, VFIODevice) device_list;
>       GList *iova_ranges;
>       NotifierWithReturn cpr_reboot_notifier;
> -} VFIOContainerBase;
> +};
> +
> +#define TYPE_VFIO_IOMMU "vfio-iommu"
> +OBJECT_DECLARE_TYPE(VFIOContainerBase, VFIOIOMMUClass, VFIO_IOMMU)
>   
>   typedef struct VFIOGuestIOMMU {
>       VFIOContainerBase *bcontainer;
> @@ -105,14 +109,11 @@ vfio_container_get_page_size_mask(const VFIOContainerBase *bcontainer)
>       return bcontainer->pgsizes;
>   }
>   
> -#define TYPE_VFIO_IOMMU "vfio-iommu"
>   #define TYPE_VFIO_IOMMU_LEGACY TYPE_VFIO_IOMMU "-legacy"
>   #define TYPE_VFIO_IOMMU_SPAPR TYPE_VFIO_IOMMU "-spapr"
>   #define TYPE_VFIO_IOMMU_IOMMUFD TYPE_VFIO_IOMMU "-iommufd"
>   #define TYPE_VFIO_IOMMU_USER TYPE_VFIO_IOMMU "-user"
>   
> -OBJECT_DECLARE_TYPE(VFIOContainerBase, VFIOIOMMUClass, VFIO_IOMMU)
> -
>   struct VFIOIOMMUClass {
>       ObjectClass parent_class;
>   


