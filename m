Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71970606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 16:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XG3OxE2K;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=NUg3yL8V
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLjiy-00046Z-Ck; Tue, 27 Oct 2026 12:08:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xLjig-0003vA-4a
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 12:08:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xLjid-0007Bw-SJ
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 12:08:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793117287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=4jLLpkxhi3RdJB79MsM7OZCHEoq+mhpUraOJvTX/I1Y=;
 b=XG3OxE2K12MHXA1/8lBH0Nd2gCe7rlNoeeNscHe2aDoxKqoKZ0r0QQDk5FZ6DJNoP33JuY
 TNuSdlYksnbny7xPltMjRdZFVU31LhWcADD07eqf2FLgkQFLdBRQQLLEgFQM43itw8rsP7
 QXH/s98gxiufPBC9br7z/tYUDCH6F6k=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-ZGc4k8UXM2qKJsZWSEcPew-1; Tue, 27 Oct 2026 12:08:05 -0400
X-MC-Unique: ZGc4k8UXM2qKJsZWSEcPew-1
X-Mimecast-MFC-AGG-ID: ZGc4k8UXM2qKJsZWSEcPew_1793117285
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4a80bd45e1cso4900645e9.3
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 09:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793117284; x=1793722084; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=4jLLpkxhi3RdJB79MsM7OZCHEoq+mhpUraOJvTX/I1Y=;
 b=NUg3yL8V2mgYkl0Qj3NsKqHpbzGIJjpWrib69emCGnPIo8L8+CHJFR217MFN8lC3Xh
 y3xf9sLrGqBn8EHvoN8WRBM59/mr+3JaaqSYI8v9VVB/TXc6ssoKg1s461Cjd26CgM/v
 3K4xlaT+KHHBzjl8YtbFQZY331YJUq9P537tO4Wt3bHeyerc8Z5DL58TnReJGrtF0da/
 DoMS4cmIsLlc3d3elTkzOuIoN4QyJsFX9Z5Q+i1VUIMU9cmP3WmBXFveIrmxNstxK2re
 EwnmgjC/aMYY9Uav2XseN/LyOP/WQ4EC8hce4n9cAOUm9uvteNrp/pWaTe6R1s7SE74e
 nIwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793117284; x=1793722084;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=4jLLpkxhi3RdJB79MsM7OZCHEoq+mhpUraOJvTX/I1Y=;
 b=cSCemESMeoDVYwF/o2VyPctppbDZ1i94EcRAMODYSVbqVGlAmiUl2ud4TPTDzkORNr
 IE3qvT3k3Bxy8iQgdurDafr2X8soRd+e3Kar59diDEs0TUbdzwvd+QWUJewBAEeRzBeS
 sgALOJNpnGtvfVtQbbp6DvhBGZ77W+XC/wP4dxBtwLtzDBBWezZu+YMGfHC7al3iA7Vo
 i/wQwCxhkTM73pDIUSDsTufeYk378xC93h7aDQ3jL9ujp29Kh/GkvPPnMCPEf1kgMBgX
 E4PLvQ+sMEJ+JnOLxpT3ld5w5swPcY6x7gOG4LaogDL+2fVbvOIg3e7mFQOKRv3Y9eY0
 icVA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzSAlPktDy7i6Y7WDJs8QHnVx+GrUKujOMgQxH9/qLEf/jXkffF8dPoH13MWhOgE6PaKFoWy3dY/cZh@nongnu.org
X-Gm-Message-State: AFq9FYIF8Kl1GFeY6hwq7mwKFgMy0iLyRsZTe+tGQhjgfbKthbA3duiF
 iN4w+sc996VBqYVqUMhpTKSOpioO5QNojzEW3J079fvS9s3eyvG81bOHQHLLjVSFKda7BB/qkgC
 e/6J96dBifQpoEM3kOpItPchfQ1gFXbkz1M0vClAR7yO/8O0Z2BJi74NX
X-Gm-Gg: AYBFou1f6TjKWh5pGCHNPj/DktrWqK6lqgxeaTFJ0Di4uHxyLgPQmmdlfLo+JS9wZrG
 msNcidWgt/tuk/rnMHTNBOwKQol88i9RYM9vT+jv3675Do2BRxRfb6MXhZPdby5DNiPHIp656gc
 R6ma1I8noLuAVfrCdRPH3xU1aOGuWlztqVgUaxtRfIJqTTXcwkr1azkK7NijkC9pvpC6DFWDGyU
 itkybe04W3fPix8cw02iqRqJn28OiYA0tyI2zUa0RUHwoLMCFoQAQYqEHsN1pa0MZuYSuTeo/8l
 UKmOdtTIxzqFwIFiPaTOtbmFd4MgU1BwWc2egG0bRYqqzVeqo2cZG2CgPRun6uGju5E2ed5bDPz
 gGQXW0eax1VUsM26uaXP5L2h+mRlwx7UbY+w3sYxK
X-Received: by 2002:a05:600c:1c22:b0:4a7:9044:a87 with SMTP id
 5b1f17b1804b1-4a790440cfdmr96293325e9.27.1793117284441; 
 Tue, 27 Oct 2026 09:08:04 -0700 (PDT)
X-Received: by 2002:a05:600c:1c22:b0:4a7:9044:a87 with SMTP id
 5b1f17b1804b1-4a790440cfdmr96292585e9.27.1793117284027; 
 Tue, 27 Oct 2026 09:08:04 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:11c3:86f0:970c:89f0:ad32:f84d?
 ([2a01:e0a:11c3:86f0:970c:89f0:ad32:f84d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a92a642494sm674025e9.0.2026.10.27.09.08.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2026 09:08:03 -0700 (PDT)
Message-ID: <3cbe37ab-96aa-4489-828a-60ead423791b@redhat.com>
Date: Tue, 27 Oct 2026 17:08:02 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] ppc/spapr: Disable VFIO BAR mmap during EEH PE
 reset
To: Narayana Murty N <nnmlinux@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, sbhat@linux.ibm.com, mahesh@linux.ibm.com,
 sourabhjain@linux.ibm.com, adityag@linux.ibm.com, npiggin@gmail.com,
 harshpb@linux.ibm.com, alex@shazbot.org
Cc: amachhiw@linux.ibm.com, hbathini@linux.ibm.com, shivangu@linux.ibm.com,
 anushree.mathur@linux.ibm.com
References: <20261027160258.48207-1-nnmlinux@linux.ibm.com>
 <20261027160258.48207-3-nnmlinux@linux.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20261027160258.48207-3-nnmlinux@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> index 428ab2f069..931df22add 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -1949,6 +1949,38 @@ static void vfio_mmap_set_enabled(VFIOPCIDevice *vdev, bool enabled)
>       }
>   }
>   
> +/*
> + * Prevent a pending INTx mmap timer from restoring BAR mmap while
> + * the PE is undergoing EEH reset.  Keep BAR accesses on the VFIO
> + * region read/write path until PE configuration completes.
> + */
> +void vfio_pci_eeh_pre_reset(PCIDevice *pdev)
> +{
> +    VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(pdev);
> +
> +    if (vdev->intx.mmap_timer) {
> +        timer_del(vdev->intx.mmap_timer);
> +    }
> +
> +    vfio_mmap_set_enabled(vdev, false);
> +}
> +
> +void vfio_pci_eeh_post_configure(PCIDevice *pdev)
> +{
> +    VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(pdev);
> +
> +    if (vdev->interrupt == VFIO_INT_INTx && vdev->intx.pending) {
> +        if (vdev->intx.mmap_timer && vdev->intx.mmap_timeout) {
> +            timer_mod(vdev->intx.mmap_timer,
> +                      qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) +
> +                      vdev->intx.mmap_timeout);
> +        }
> +        return;
> +    }
> +
> +    vfio_mmap_set_enabled(vdev, true);
> +}
> +
>   static void vfio_bar_prepare(VFIOPCIDevice *vdev, int nr)
>   {
>       VFIOBAR *bar = &vdev->bars[nr];
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index c9ab949870..63fa378fbc 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -266,6 +266,8 @@ struct vfio_pci_hot_reset_info;
>   
>   void vfio_pci_pre_reset(VFIOPCIDevice *vdev);
>   void vfio_pci_post_reset(VFIOPCIDevice *vdev);
> +void vfio_pci_eeh_pre_reset(PCIDevice *pdev);
> +void vfio_pci_eeh_post_configure(PCIDevice *pdev);
>   bool vfio_pci_host_match(PCIHostDeviceAddress *addr, const char *name);
>   int vfio_pci_get_pci_hot_reset_info(VFIOPCIDevice *vdev,
>                                       struct vfio_pci_hot_reset_info **info_p);

These are POWER-only routines. Why put them under hw/vfio/pci.c ?

C.


