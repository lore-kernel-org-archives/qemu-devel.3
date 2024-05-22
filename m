Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C627CC25B78
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 07:16:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9gBh-0000vt-V2; Wed, 22 May 2024 03:15:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9gBg-0000uv-F9
 for qemu-devel@nongnu.org; Wed, 22 May 2024 03:15:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9gBe-0006RI-9U
 for qemu-devel@nongnu.org; Wed, 22 May 2024 03:15:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716362097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XAPAritrtAjqEq3R/V4XAwxhHdEgBOhk+USMhzdpY8Y=;
 b=DzLENgQaQeg9irUBPZjAM6Z+80DP+K72h8/dxkm3bjLTDxvui9uqUYkmqG0Ld0JwU9bIF9
 PfB88HFIcWpfjIoLl+ofdC6txO5Un+jm4B4puJAzNk9eCC2pwsUnqA0XipW4qh4gVc+YQ1
 cZ6iuPoB4Q6JTVRPwatxc1IrEsu0BI4=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-a_MJr1HrN569Gll0jUhDJw-1; Wed, 22 May 2024 03:14:55 -0400
X-MC-Unique: a_MJr1HrN569Gll0jUhDJw-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-792c3d2b6beso1788597085a.2
 for <qemu-devel@nongnu.org>; Wed, 22 May 2024 00:14:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716362095; x=1716966895;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XAPAritrtAjqEq3R/V4XAwxhHdEgBOhk+USMhzdpY8Y=;
 b=qs88l6YMdiyH43BYk/Nz0+SWOAw/7cJrMWV7GGePLI4n6yE2c396sivQjOgAHNaqm2
 lWLAm5kxRZ3a/A3m2jcR11VpZPxTLp8w1f676psJbE9qkMwsu9FhFTa0yKbTtg/mVBEB
 8r7T3PwCnqikHyMA+eWfBeWXQ5xw3yD1RQvdAc3DYOwId24Ka4StGbcjtNifVEIZyuLy
 WI3hTdrUhXSYGQZ2IaH1bwxiuUYmnMFddvmjJNXAooG0mLYOJ5o33rJ72i7JvXgk4KIR
 v6Q/LyFCI+LPvAZ2h05DvAWFPYYN2bXgVw+fJ7E3rCp6luCktPwNo+F8d2XXu+ZeWoJ9
 C3QA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXipiRDTpIeFG0YaTQOk/byDs019ycAxVqNl8ifCD1pKkYbpCveFrq/cg69LZjHXv7W+3PexLEMMP+bHIVHUb5xajcpKno=
X-Gm-Message-State: AOJu0YyuTZzkJhbeObbG6DocDWrNbZ/kLYqmANNdNzMizTHL3E6fJtfs
 SDoUstCZKRo66YIVmbXS7Mm7azHorFAXzbfSCvb6mfpaILBZs+GWO6eB2Htlz03ByaCtfmudYLL
 iwpr3MmMCLg+89B/SP00/eRx4Sog5JhDlHI8LeLvXLIEvyelaIdvC
X-Received: by 2002:a05:620a:1920:b0:792:bcc4:23de with SMTP id
 af79cd13be357-7949944f927mr134103385a.36.1716362094170; 
 Wed, 22 May 2024 00:14:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESZ7W7xh/uWQ495OMaSyq4vZSfqf5Xlj0BSeFJ5XvKK3MO+i5iFNRCznPBfDDEptHqEn1Djw==
X-Received: by 2002:a05:620a:1920:b0:792:bcc4:23de with SMTP id
 af79cd13be357-7949944f927mr134101585a.36.1716362093774; 
 Wed, 22 May 2024 00:14:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-792bf2a11f6sm1357013085a.55.2024.05.22.00.14.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 May 2024 00:14:52 -0700 (PDT)
Message-ID: <ca4d50da-8569-47bf-966d-5278d8e2f7a9@redhat.com>
Date: Wed, 22 May 2024 09:14:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 18/20] vfio/igd: Use g_autofree in
 vfio_probe_igd_bar4_quirk()
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, chao.p.peng@intel.com
References: <20240522044015.412951-1-zhenzhong.duan@intel.com>
 <20240522044015.412951-19-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240522044015.412951-19-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
> Pointer opregion, host and lpc are allocated and freed in
> vfio_probe_igd_bar4_quirk(). Use g_autofree to automatically
> free them.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/igd.c | 27 ++++++++++++---------------
>   1 file changed, 12 insertions(+), 15 deletions(-)
> 
> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
> index 1e79202f2b..d320d032a7 100644
> --- a/hw/vfio/igd.c
> +++ b/hw/vfio/igd.c
> @@ -368,7 +368,9 @@ static const MemoryRegionOps vfio_igd_index_quirk = {
>   void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
>   {
>       g_autofree struct vfio_region_info *rom = NULL;
> -    struct vfio_region_info *opregion = NULL, *host = NULL, *lpc = NULL;
> +    g_autofree struct vfio_region_info *opregion = NULL;
> +    g_autofree struct vfio_region_info *host = NULL;
> +    g_autofree struct vfio_region_info *lpc = NULL;
>       VFIOQuirk *quirk;
>       VFIOIGDQuirk *igd;
>       PCIDevice *lpc_bridge;
> @@ -426,7 +428,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
>       if ((ret || !rom->size) && !vdev->pdev.romfile) {
>           error_report("IGD device %s has no ROM, legacy mode disabled",
>                        vdev->vbasedev.name);
> -        goto out;
> +        return;
>       }
>   
>       /*
> @@ -437,7 +439,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
>           error_report("IGD device %s hotplugged, ROM disabled, "
>                        "legacy mode disabled", vdev->vbasedev.name);
>           vdev->rom_read_failed = true;
> -        goto out;
> +        return;
>       }
>   
>       /*
> @@ -450,7 +452,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
>       if (ret) {
>           error_report("IGD device %s does not support OpRegion access,"
>                        "legacy mode disabled", vdev->vbasedev.name);
> -        goto out;
> +        return;
>       }
>   
>       ret = vfio_get_dev_region_info(&vdev->vbasedev,
> @@ -459,7 +461,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
>       if (ret) {
>           error_report("IGD device %s does not support host bridge access,"
>                        "legacy mode disabled", vdev->vbasedev.name);
> -        goto out;
> +        return;
>       }
>   
>       ret = vfio_get_dev_region_info(&vdev->vbasedev,
> @@ -468,7 +470,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
>       if (ret) {
>           error_report("IGD device %s does not support LPC bridge access,"
>                        "legacy mode disabled", vdev->vbasedev.name);
> -        goto out;
> +        return;
>       }
>   
>       gmch = vfio_pci_read_config(&vdev->pdev, IGD_GMCH, 4);
> @@ -482,7 +484,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
>           error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
>           error_report("IGD device %s failed to enable VGA access, "
>                        "legacy mode disabled", vdev->vbasedev.name);
> -        goto out;
> +        return;
>       }
>   
>       /* Create our LPC/ISA bridge */
> @@ -490,7 +492,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
>       if (ret) {
>           error_report("IGD device %s failed to create LPC bridge, "
>                        "legacy mode disabled", vdev->vbasedev.name);
> -        goto out;
> +        return;
>       }
>   
>       /* Stuff some host values into the VM PCI host bridge */
> @@ -498,14 +500,14 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
>       if (ret) {
>           error_report("IGD device %s failed to modify host bridge, "
>                        "legacy mode disabled", vdev->vbasedev.name);
> -        goto out;
> +        return;
>       }
>   
>       /* Setup OpRegion access */
>       if (!vfio_pci_igd_opregion_init(vdev, opregion, &err)) {
>           error_append_hint(&err, "IGD legacy mode disabled\n");
>           error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
> -        goto out;
> +        return;
>       }
>   
>       /* Setup our quirk to munge GTT addresses to the VM allocated buffer */
> @@ -607,9 +609,4 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
>       }
>   
>       trace_vfio_pci_igd_bdsm_enabled(vdev->vbasedev.name, ggms_mb + gms_mb);
> -
> -out:
> -    g_free(opregion);
> -    g_free(host);
> -    g_free(lpc);
>   }


