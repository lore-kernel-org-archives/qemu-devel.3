Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37F3FC87FDB
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 12:47:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulRvU-0003ZT-GT; Mon, 11 Aug 2025 08:46:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ulRvP-0003Sj-Ki
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 08:46:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ulRvE-0002UG-38
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 08:46:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754916388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=FWmsmyBbB4OORdNpJAqGqALBu6MzpmMZM5UqqxdlkIo=;
 b=AOQcpbvpGmmgSZDP4y9ODvoOPtl114AdGXtg5fU+SBFdVkGLGPBDTlw/JqxjrepuTo7nGb
 NKBXDlceOsaSF1yFTfjAHV1YBa++B0jBvoxs/xy0OpfXyboxjaNfyF5b05edMCIDDbMEIV
 iFJW7OC2wViEUV8rQ+Y0MKyTcyaF3lQ=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-fLGodAHLMJCwbx5SxFqUvQ-1; Mon, 11 Aug 2025 08:46:27 -0400
X-MC-Unique: fLGodAHLMJCwbx5SxFqUvQ-1
X-Mimecast-MFC-AGG-ID: fLGodAHLMJCwbx5SxFqUvQ_1754916386
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7e82a101470so802890185a.0
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 05:46:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754916386; x=1755521186;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FWmsmyBbB4OORdNpJAqGqALBu6MzpmMZM5UqqxdlkIo=;
 b=tK4rffCtn8IsNuCXN+P6SLFixeGFGgkaD0KWBi8J8O5xmqeW45liSdAI0Y9jWXL+OH
 SR9sZ8A3Z8YuVwSJQxS/HghtyOiuLdSqjZk+SgD7d7oQto879R6x4QFfSzkYEH9738OC
 nOsQT5vCO2f/KFXOiBFVt+h8Jyumj61M6pPP8cWj6rTjIQGvljB5f6PV/Y9tegZVReQn
 daJ38bB+KpEhWIG5xwcqf6V+wcd5itlNJLjyfVZgeU4YE8BMMxXfmmu/NHHORJ+YkMVy
 G1zR66Rl8562KqBD8HkhH9EuV6eUuqTUuFFXHdN/kRuMnn/4eaLsop8ZfmUwdolQBwh1
 PHzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXe6VEyOGXRK9OLi05rE8XFtShARQXSgerb2TzQx6eztse1VsxMHWNc7/2aFXZvv/Jb400pamUsSI9b@nongnu.org
X-Gm-Message-State: AOJu0Yy7qPvvAw5xCiT2qEUN+UYlKz89ZXbpv3KF2yG1gleXqzgP7Qq3
 KyeqqPWdGZCI1vOhf4mxO4/v+bm/Y7feocdoHMSIdjYLR55GmpDbSRvFbRCx7zTI59y72nAdtFt
 xjpq4e3JIxXXV4sZHBYOuEu+hIDKYTR+bavZlT6LMWolKXZog7+p3mJOR
X-Gm-Gg: ASbGncsFpdA5QjiX3HyQT8cFe/bxXwkVKz3dm1YxhYSiotYygKJUCpAixEz3nxAdUAD
 fFE6M396BBcB+TJbKmZLP0FocnZ64uIpiyLssKtdhT/v9E+s7uZpTioJ0hzaQTVI9ed40aEg54U
 +6V4a65CaZQPZxw8QOjQtaSkBk6Ff2cz+E1CcCEnQJKllQNnqxxbKdhNxGMjFcnfxnHqQ4TZR5I
 /UIblc09FM9oWWI0yc3UwBv3oC0XN2YdsHNT0OgzHeLvD7C9YOEWDKZxuT+jpvM5hU10PCjwqsK
 jVGe6JWZ3omxrzqTrVjI3QrOKwOnYKiNewIdI1G6QxoAqasZFnBQpEAqGlzizXxGtbHryU+n7ta
 SKw==
X-Received: by 2002:a05:620a:408a:b0:7e8:2805:889d with SMTP id
 af79cd13be357-7e82c6a7b23mr1788879485a.25.1754916386269; 
 Mon, 11 Aug 2025 05:46:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEl2977eQRPCJlc3PHgZYw3JrLyhImHDO1PkPDGKWWfBbb8Dnd/HuLeBn9f16mkMrduU03J/w==
X-Received: by 2002:a05:620a:408a:b0:7e8:2805:889d with SMTP id
 af79cd13be357-7e82c6a7b23mr1788871685a.25.1754916385618; 
 Mon, 11 Aug 2025 05:46:25 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e81237b2e2sm905512685a.72.2025.08.11.05.46.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Aug 2025 05:46:24 -0700 (PDT)
Message-ID: <16dd15fe-a30d-4078-bec7-b4069570dbbc@redhat.com>
Date: Mon, 11 Aug 2025 14:46:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/22] vfio/pci.h: rename VFIOPCIDevice pdev field to
 parent_obj
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, npiggin@gmail.com,
 danielhb413@gmail.com, harshpb@linux.ibm.com, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 alex.williamson@redhat.com, steven.sistare@oracle.com,
 tomitamoeko@gmail.com, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20250715093110.107317-1-mark.caveayland@nutanix.com>
 <20250715093110.107317-23-mark.caveayland@nutanix.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250715093110.107317-23-mark.caveayland@nutanix.com>
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

On 7/15/25 11:26, Mark Cave-Ayland wrote:
> Now that nothing accesses the pdev field directly, rename pdev to
> parent_obj as per our current coding guidelines.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/cpr.c | 4 ++--
>   hw/vfio/pci.c | 4 ++--
>   hw/vfio/pci.h | 2 +-
>   3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
> index 3e3f4035ab..366490c908 100644
> --- a/hw/vfio/cpr.c
> +++ b/hw/vfio/cpr.c
> @@ -171,8 +171,8 @@ const VMStateDescription vfio_cpr_pci_vmstate = {
>       .post_load = vfio_cpr_pci_post_load,
>       .needed = cpr_incoming_needed,
>       .fields = (VMStateField[]) {
> -        VMSTATE_PCI_DEVICE(pdev, VFIOPCIDevice),
> -        VMSTATE_MSIX_TEST(pdev, VFIOPCIDevice, pci_msix_present),
> +        VMSTATE_PCI_DEVICE(parent_obj, VFIOPCIDevice),
> +        VMSTATE_MSIX_TEST(parent_obj, VFIOPCIDevice, pci_msix_present),
>           VMSTATE_VFIO_INTX(intx, VFIOPCIDevice),
>           VMSTATE_END_OF_LIST()
>       }
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index fb9eb58da5..1db6be8f21 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2804,8 +2804,8 @@ static const VMStateDescription vmstate_vfio_pci_config = {
>       .version_id = 1,
>       .minimum_version_id = 1,
>       .fields = (const VMStateField[]) {
> -        VMSTATE_PCI_DEVICE(pdev, VFIOPCIDevice),
> -        VMSTATE_MSIX_TEST(pdev, VFIOPCIDevice, vfio_msix_present),
> +        VMSTATE_PCI_DEVICE(parent_obj, VFIOPCIDevice),
> +        VMSTATE_MSIX_TEST(parent_obj, VFIOPCIDevice, vfio_msix_present),
>           VMSTATE_END_OF_LIST()
>       },
>       .subsections = (const VMStateDescription * const []) {
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index c0c3d68742..37d8b996f5 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -131,7 +131,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(VFIOPCIDevice, VFIO_PCI_BASE)
>   /* TYPE_VFIO_PCI shares struct VFIOPCIDevice. */
>   
>   struct VFIOPCIDevice {
> -    PCIDevice pdev;
> +    PCIDevice parent_obj;
>   
>       VFIODevice vbasedev;
>       VFIOINTx intx;


