Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089A4606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 07:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=V9jAC6II;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=bEjucvvO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMghj-0005mk-1T; Fri, 30 Oct 2026 03:07:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xMghg-0005jO-KL
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 03:07:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xMghe-0003Fj-Dz
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 03:07:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793344025;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=DT+dDjAXGej19Heq56714KdK/PzRGfsanEnj28VdI3A=;
 b=V9jAC6II0A3IrhmxoZhP/APBWnjWbgR9EKUQ+/gLC9DQOoCJkoGfw2wuc9cnTLhpPSShWq
 l7A4+LJyd22OHT+jT8b4voxnZPHAx4HVYNxaHTHv3b/s0pE68rV0LEl+yHCr6+si6WUnTE
 pDN9m+Fh/TMRa25sr9ErlbIyMtztEXk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-g1DgCTZwN66v5bVyQHEElw-1; Fri, 30 Oct 2026 03:07:03 -0400
X-MC-Unique: g1DgCTZwN66v5bVyQHEElw-1
X-Mimecast-MFC-AGG-ID: g1DgCTZwN66v5bVyQHEElw_1793344022
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4a2065a2ef9so3419065e9.3
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 00:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793344022; x=1793948822; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=DT+dDjAXGej19Heq56714KdK/PzRGfsanEnj28VdI3A=;
 b=bEjucvvOOMaDlbqrTfSnQKsRoqu2ls8ZHtI8KPeTc6C6BTwndtim5vaOI+XTBA3PX0
 OD/ggVETzTj2FAkdYNnpw3KQdqM0b0SrdlDAuVnAz8QbWdPxZLpnctw61jOclnJVajiR
 8mpwduMq1Y6ys9Ovgls3KQYxZGiRuDTxgG5WerdUsDELT0CpSIX84oM3wuXTcQ8kNtuy
 wkeWnAoWfTbDz+A65aY0xoA9he+ghhwz1Y/7dqTddI4joSu+9XVeKXqIBKs/zTAbOxrr
 o2UelCDxEZvqtPW4Nh0TakcWlofgz67JpCu+JQKqKoWLbezCllNX0qOz7eXz7dSJac7E
 u77w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793344022; x=1793948822;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=DT+dDjAXGej19Heq56714KdK/PzRGfsanEnj28VdI3A=;
 b=W9a40JY3HJPuwUUo2p+O/zRb/maLXcRBrxaixVGtbMLCuLho/kdRCtnn5nm4T/YqeB
 c+ONiJvCAhEwYlK9j9+4Jbwz+cl9PSXbpPf+b+LRNX6jOZ8VXTGx/PX5M+T4KldMK+MT
 FtvnsvtKdiewm1XZm4GQtaqer83/1QgAsS+2rp64w2zyWS9AN+4ksHgQDLKdIhbSzQGL
 ZIWHR0jr/nH3lnQAK82SSEMx86FfvyTlD0mKGy8YNjB6I//6zWyFipDeR+CGAdHeHthR
 O4yS5D71Yz+O/c08iQHAugJHQ+4Eekx+DjTlGpK9drtMoUDeilvXruzByq12coPA8XQ7
 EsIg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwT+FwGH7sA2GWuOaK6mSlJ1/LKsqHXdl33OrXc7HDYm4KoC1s9/rEUSuxNpvI8W3c6yffSDb1zj31j@nongnu.org
X-Gm-Message-State: AFq9FYIFoIhZUJGQxYhUnHi+/c9Mhok6v4AVxvgS8h6NZQ/4OvUqf6A/
 44s2GhdelnuqwLyhxmUsymXDvbZ+GpM5LaWIHLL9nKM6RszlEBsU0R2yQqf44N5BqV+pgjkxgW1
 M0RRGJ+mGgXmBkOW8v3NZRpiDDIsc50RhyHJX40SY4YDEyFzZr6MDIzwq
X-Gm-Gg: AYBFou38Uflt9u3SpHKMavvw2lNLz1y9kv+Gtr5la4NyD5cjrHRsNEfPlSB6BPgoaVs
 edk4euNcmc951Y/Tg/uffs05Jmj45GcRubDBkAvbzHxudapm45nYaO1jdT8YPK5B/bITEOFDyTx
 9Ah4LXQ7xfmm96m1kGWfWRKj+lbVx9X6GAiOolJ46hNoSe1QfS2ag4CfcSMUKqOa25YPAGonhTF
 kT2rOYwaea48WVJ1yMqv5HQBIu5EkjMVGHE0xHkDQh7SkW/OQ2AvbXsYjWSTD8cHQcgrOQbf0XC
 mvEaOn2yBW5fGpjlMdbcUddOXyTFFTJXjxGwQ444VigcqD/UlGaGOeA+vSAMX9jtgBQTuS6uoGp
 gjNAx8gEO/DQcfWFbwwk872eXal5dHgneEk5P3g2WaQFIUBX35Hkzcd83CNpNbuxakIk4CfXDrV
 k9we6VXfaMyuAB0A==
X-Received: by 2002:a05:600c:1d28:b0:4a2:1612:637a with SMTP id
 5b1f17b1804b1-4ac1793fb6bmr30413915e9.16.1793344022176; 
 Fri, 30 Oct 2026 00:07:02 -0700 (PDT)
X-Received: by 2002:a05:600c:1d28:b0:4a2:1612:637a with SMTP id
 5b1f17b1804b1-4ac1793fb6bmr30413375e9.16.1793344021766; 
 Fri, 30 Oct 2026 00:07:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:11c3:86f0:970c:89f0:ad32:f84d?
 ([2a01:e0a:11c3:86f0:970c:89f0:ad32:f84d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ac0a66caefsm27599385e9.5.2026.10.30.00.07.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2026 00:07:01 -0700 (PDT)
Message-ID: <93985284-06ab-4371-922f-86ae3e2e4d8e@redhat.com>
Date: Fri, 30 Oct 2026 08:07:00 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/igd: Use version mapping for MTL/ARL quirk selection
To: Tomita Moeko <tomitamoeko@gmail.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>, Yuan Wang <yuan1.wang@intel.com>,
 Bosheng Xue <bosheng.xue@intel.com>, Junjie Cao <junjie.cao@intel.com>
References: <20261029161702.117078-1-tomitamoeko@gmail.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20261029161702.117078-1-tomitamoeko@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/29/26 17:17, Tomita Moeko wrote:
> Meteor Lake and Arrow Lake use graphics IP version 12.70, but igd_gen()
> only returns the major version (generation). Encode the existing device
> ID mapping as (version * 100 + release) so that MTL/ARL can be selected
> in the BAR0 pcode stolen access quirk instead of a separate device ID
> check.
> 
> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
> Cc: Yuan Wang <yuan1.wang@intel.com>
> Cc: Bosheng Xue <bosheng.xue@intel.com>
> Cc: Junjie Cao <junjie.cao@intel.com>
> ---
>   hw/vfio/igd.c | 30 +++++++++++++++++-------------
>   1 file changed, 17 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
> index 4c7d654592..728b60d3d4 100644
> --- a/hw/vfio/igd.c
> +++ b/hw/vfio/igd.c
> @@ -58,8 +58,9 @@
>    * not be taken as an indication that all the devices are supported, or even
>    * supportable, some of them don't even support VT-d.
>    * See linux:include/drm/i915_pciids.h for IDs.

This file doesn't exist.

> + * Returns (version * 100 + release).
>    */
> -static int igd_gen(VFIOPCIDevice *vdev)
> +static int igd_graphics_ver(VFIOPCIDevice *vdev)
>   {
>       /*
>        * Device IDs for Broxton/Apollo Lake are 0x0a84, 0x1a84, 0x1a85, 0x5a84
> @@ -67,38 +68,39 @@ static int igd_gen(VFIOPCIDevice *vdev)
>        * Prefix 0x0a is taken by Haswell, this rule should be matched first.
>        */
>       if ((vdev->device_id & 0xffe) == 0xa84) {
> -        return 9;
> +        return 900;
>       }
>   
>       switch (vdev->device_id & 0xff00) {
>       case 0x0100:    /* SandyBridge, IvyBridge */
> -        return 6;
> +        return 600;
>       case 0x0400:    /* Haswell */
>       case 0x0a00:    /* Haswell */
>       case 0x0c00:    /* Haswell */
>       case 0x0d00:    /* Haswell */
>       case 0x0f00:    /* Valleyview/Bay Trail */
> -        return 7;
> +        return 700;
>       case 0x1600:    /* Broadwell */
>       case 0x2200:    /* Cherryview */
> -        return 8;
> +        return 800;
>       case 0x1900:    /* Skylake */
>       case 0x3100:    /* Gemini Lake */
>       case 0x5900:    /* Kaby Lake */
>       case 0x3e00:    /* Coffee Lake */
>       case 0x9B00:    /* Comet Lake */
> -        return 9;
> +        return 900;
>       case 0x8A00:    /* Ice Lake */
>       case 0x4500:    /* Elkhart Lake */
>       case 0x4E00:    /* Jasper Lake */
> -        return 11;
> +        return 1100;
>       case 0x9A00:    /* Tiger Lake */
>       case 0x4C00:    /* Rocket Lake */
>       case 0x4600:    /* Alder Lake */
>       case 0xA700:    /* Raptor Lake */
> +        return 1200;
>       case 0x7D00:    /* Meteor Lake / Arrow Lake */
>       case 0xB600:    /* Arrow Lake */
> -        return 12;
> +        return 1270;
>       }
>   
>       /*
> @@ -109,6 +111,12 @@ static int igd_gen(VFIOPCIDevice *vdev)
>       return -1;
>   }
>   
> +static int igd_gen(VFIOPCIDevice *vdev)
> +{
> +    int ver = igd_graphics_ver(vdev);
> +    return ver < 0 ? -1 : ver / 100;
> +}
> +
>   #define IGD_ASLS 0xfc /* ASL Storage Register */
>   #define IGD_GMCH 0x50 /* Graphics Control Register */
>   #define IGD_BDSM 0x5c /* Base Data of Stolen Memory */
> @@ -458,10 +466,6 @@ static bool vfio_pci_igd_override_gms(int gen, uint32_t gms, uint32_t *gmch)
>   #define IGD_BDSM_MMIO_OFFSET        0x1080C0
>   #define IGD_MTL_PCODE_STOLEN_ACCESS 0x138914
>   
> -#define IGD_IS_MTL_OR_ARL(vdev) \
> -    ((((vdev)->device_id & 0xff00) == 0x7d00) || \
> -     (((vdev)->device_id & 0xff00) == 0xb600))
> -
>   static uint64_t vfio_igd_pcode_stolen_access_read(void *opaque, hwaddr addr,
>                                                     unsigned size)
>   {
> @@ -591,7 +595,7 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
>        * Return 0 for PCODE stolen memory access detection (0x138914) so GOP
>        * stays on the standard access path in the VM.
>        */
> -    if (IGD_IS_MTL_OR_ARL(vdev)) {
> +    if (igd_graphics_ver(vdev) == 1270) {


I'd prefer to introduce a define for this value. Anyhow,

>           pcode_stolen_access_quirk = vfio_quirk_alloc(1);
>           memory_region_init_io(pcode_stolen_access_quirk->mem, OBJECT(vdev),
>                                 &vfio_igd_pcode_stolen_access_quirk, vdev,


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


