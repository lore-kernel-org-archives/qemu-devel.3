Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6417CC25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 12:48:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9Ov3-0005Sh-6G; Tue, 21 May 2024 08:48:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9Ouu-0005Lb-C4
 for qemu-devel@nongnu.org; Tue, 21 May 2024 08:48:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9Ous-00051W-Ni
 for qemu-devel@nongnu.org; Tue, 21 May 2024 08:48:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716295710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=brQYdc1WHLIYbLy/ggZiRYjXi0y32qZl2Z4Ay0ITnbI=;
 b=Qm9gMHAU87GVDvCLo2wYSIuUnwHwzPADiEdKZaeUdGctxRXnt86eqzQLY6IhhxwlL+CewH
 zXmOuMDDVQcdNvpnXM38oKuzPahXDMOh66b1ixo4QshJaFCTrEk5BJ1YaHRwW0kNDmiMs3
 bVUrswr4ZPLmM87yp5geri0du7oqTEo=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-l-gIUgLNPAGsjSoXWxz5DQ-1; Tue, 21 May 2024 08:48:20 -0400
X-MC-Unique: l-gIUgLNPAGsjSoXWxz5DQ-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5206ef0d6fdso11438853e87.3
 for <qemu-devel@nongnu.org>; Tue, 21 May 2024 05:48:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716295699; x=1716900499;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=brQYdc1WHLIYbLy/ggZiRYjXi0y32qZl2Z4Ay0ITnbI=;
 b=ArYF1hQUt9qGnouEY9oQ5Wl4VOT0G8hB+hnrLppCD+dUTLe3+PqRAMb5jxPJhMCjXR
 hOIzi5YPcV5HmcpL6rvH1rIx4VcRbhI5qONdFhlEufJGqc2wFtVNkmS85nIyt4O0tJdW
 2d1dtGi3xGUSofVNIoWP5eI7kJMcThLa/qsp0taiQ8MWW1Yh+4g3iHGhuGHwjkXaV1b6
 4/8C+Aouur5aMJ7xcCSKGhf8G9JXT+ea5HL78NI9bGFi5uTjs/No7l+WgHLtMaYgBcKO
 VSw7g4XbQgPuOrozo4LVI9yUKYIBFWVKvuV7asfYQg5QVzdMfL/SKQBFzXi6/ZkfZNnJ
 IGXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuYZM57/0hgYGWlS3PQYzr4AFnvs6s9OIwipV7TXr140QhkfJnlZ9h6bnKRAfCi8L4+WfT36sSdx9+SXhnHgKpD/mfAEI=
X-Gm-Message-State: AOJu0YydRryyV7osoYtvGRDBTS0zSTVRdfD4H1IBDgor+N/Tw3Jy6xWQ
 9ko7lD3yQmfuQP+wENUoFG6yw7faN1bjEIwz23FLjwL9ecyIfZvbFQe8pl/PCpVHMfndI4WYKFL
 dlTvpGkZTTfFxQAxtToyYk4pu80OOPJoWXuSd+ZWw1yJ3WdsOxIEqlGma9VoB
X-Received: by 2002:a19:8c58:0:b0:521:7543:4534 with SMTP id
 2adb3069b0e04-5220ff74bb3mr19118634e87.62.1716295698976; 
 Tue, 21 May 2024 05:48:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEItCCVKLwMi1RJcIAvRwii0/q8vQ8ji1ZFEy26ArMrZOsHP1Kk5AeNTmTeHVeQ7clpjpmqQ==
X-Received: by 2002:a19:8c58:0:b0:521:7543:4534 with SMTP id
 2adb3069b0e04-5220ff74bb3mr19118619e87.62.1716295698547; 
 Tue, 21 May 2024 05:48:18 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a179c7faasm1604675766b.136.2024.05.21.05.48.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 May 2024 05:48:17 -0700 (PDT)
Message-ID: <5c951708-70c9-415d-85ba-c3bdfa7229df@redhat.com>
Date: Tue, 21 May 2024 14:48:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/16] vfio/pci-quirks: Make vfio_pci_igd_opregion_init()
 return bool
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, chao.p.peng@intel.com
References: <20240515082041.556571-1-zhenzhong.duan@intel.com>
 <20240515082041.556571-16-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240515082041.556571-16-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
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

On 5/15/24 10:20, Zhenzhong Duan wrote:
> This is to follow the coding standand in qapi/error.h to return bool
> for bool-valued functions.
> 
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/pci.h        | 6 +++---
>   hw/vfio/igd.c        | 3 +--
>   hw/vfio/pci-quirks.c | 8 ++++----
>   hw/vfio/pci.c        | 3 +--
>   4 files changed, 9 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index 7914f019d5..f158681072 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -227,9 +227,9 @@ int vfio_pci_get_pci_hot_reset_info(VFIOPCIDevice *vdev,
>   
>   bool vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp);
>   
> -int vfio_pci_igd_opregion_init(VFIOPCIDevice *vdev,
> -                               struct vfio_region_info *info,
> -                               Error **errp);
> +bool vfio_pci_igd_opregion_init(VFIOPCIDevice *vdev,
> +                                struct vfio_region_info *info,
> +                                Error **errp);
>   
>   void vfio_display_reset(VFIOPCIDevice *vdev);
>   bool vfio_display_probe(VFIOPCIDevice *vdev, Error **errp);
> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
> index ffe57c5954..402fc5ce1d 100644
> --- a/hw/vfio/igd.c
> +++ b/hw/vfio/igd.c
> @@ -502,8 +502,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
>       }
>   
>       /* Setup OpRegion access */
> -    ret = vfio_pci_igd_opregion_init(vdev, opregion, &err);
> -    if (ret) {
> +    if (!vfio_pci_igd_opregion_init(vdev, opregion, &err)) {
>           error_append_hint(&err, "IGD legacy mode disabled\n");
>           error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
>           goto out;
> diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
> index 496fd1ee86..ca27917159 100644
> --- a/hw/vfio/pci-quirks.c
> +++ b/hw/vfio/pci-quirks.c
> @@ -1169,8 +1169,8 @@ static void vfio_probe_rtl8168_bar2_quirk(VFIOPCIDevice *vdev, int nr)
>    * the table and to write the base address of that memory to the ASLS register
>    * of the IGD device.
>    */
> -int vfio_pci_igd_opregion_init(VFIOPCIDevice *vdev,
> -                               struct vfio_region_info *info, Error **errp)
> +bool vfio_pci_igd_opregion_init(VFIOPCIDevice *vdev,
> +                                struct vfio_region_info *info, Error **errp)
>   {
>       int ret;
>   
> @@ -1181,7 +1181,7 @@ int vfio_pci_igd_opregion_init(VFIOPCIDevice *vdev,
>           error_setg(errp, "failed to read IGD OpRegion");
>           g_free(vdev->igd_opregion);
>           vdev->igd_opregion = NULL;
> -        return -EINVAL;
> +        return false;
>       }
>   
>       /*
> @@ -1206,7 +1206,7 @@ int vfio_pci_igd_opregion_init(VFIOPCIDevice *vdev,
>       pci_set_long(vdev->pdev.wmask + IGD_ASLS, ~0);
>       pci_set_long(vdev->emulated_config_bits + IGD_ASLS, ~0);
>   
> -    return 0;
> +    return true;
>   }
>   
>   /*
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index be87478716..15823c359a 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3164,8 +3164,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>               goto out_teardown;
>           }
>   
> -        ret = vfio_pci_igd_opregion_init(vdev, opregion, errp);
> -        if (ret) {
> +        if (!vfio_pci_igd_opregion_init(vdev, opregion, errp)) {
>               goto out_teardown;
>           }
>       }


