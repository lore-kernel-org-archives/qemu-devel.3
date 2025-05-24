Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F15C54ED1
	for <qemu-devel@archiver.kernel.org>; Sat, 24 May 2025 15:34:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIqtY-0006rI-1q; Sat, 24 May 2025 11:34:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1uIqtW-0006rA-Ei
 for qemu-devel@nongnu.org; Sat, 24 May 2025 11:34:42 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1uIqtU-0004po-KW
 for qemu-devel@nongnu.org; Sat, 24 May 2025 11:34:42 -0400
Received: by mail-pl1-x643.google.com with SMTP id
 d9443c01a7336-22c33677183so5188085ad.2
 for <qemu-devel@nongnu.org>; Sat, 24 May 2025 08:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748100879; x=1748705679; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=7yE1qCsDMyek8vOG1YvC3zJC6TgSTGGOJrcZwmANjm4=;
 b=mQSsyvtNSqaE8w+Y59Tt0LdcfYzqALT2ll3ruAspPJydVsGDyziwjKlwGgrviui4YL
 56bKGzeBcIkmn96p3IN6CgYgEpQcSact5bUuZ3tdtimLD0nqZBtcDLw3MeL3ggKBfU3w
 dxFUmsPCik6LO+7OEy1rjUJrCHTng8+EoryYl9yXAjfbXhA6ck+ZNKfW4H0idz5O1gCq
 g8akVM0Jz6sUozC4wrcV3CZjqtTUyfx1Qj/3zBJ7DyiHayqMn50Ahc8BgUQZKzED6iFm
 qCzykGLhD2xwebksaCm7p/HeCOww1H+0wtacn64RWRsphUNYJzgE+7HbAkcd1JW3fELT
 VQ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748100879; x=1748705679;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7yE1qCsDMyek8vOG1YvC3zJC6TgSTGGOJrcZwmANjm4=;
 b=C5vnZVc5eCSD2B5ZJk9bAcnkgPx3tc1D4sDskLQfrm0Mrh0bN5vHqLfcjXcHTxatDt
 bOYA7nJcBlQk7Ict/jEGSkNCsRijryXNwkM8+18XfSmg+s68BZSvDIdvpJbp+eIQ2iY/
 LCGC7w4TPOSseLbSqaQPSUMNoi/r3eGoO26qGcH58TCORHwbOBSurEvtpfii64w70UyC
 uzYpyO9KB2GiDu+7EZv3fB/17UvhUcVyQYBz+OGRkFObVgkc0nbzlqOUKi4MPralCDqc
 r44GUfmSJIUV2qTMWP4DDMB4kcBK4iehzHpiGyKrnvte261pMeCLoLv8p+Hho8Nb7f1J
 /8wA==
X-Gm-Message-State: AOJu0YxyOuXffF0O+qFkQOQPqenanKgrDP4zolYYkAqJ9QY9ks4Kjtu4
 2ziAyUiObo1/3X7JwEJBBWJcSMpEZuRkHy91dXS/d74haOWuHx3mg9A=
X-Gm-Gg: ASbGnctzQC1ZaJw6xrbZj9JyFmMkVs4uSBtSDAYgSDEBxFgY5Oh4OmkFYcrVBgkElDS
 cupRROxShDXUE5OuNisPiu+0WecD+6Zpm6zPKocqja4eM/0k/wnDGMRtGxp3pBhuZotDFVQlVNP
 j9XSJbfTWKEB0naCGGJhHrTycVRZRlQllHPyWBgc1R6HWB/6/pljnYELAq2Wl4skJeM+Wkmf4Zg
 URwt+VvI7i8uVD2euscD8K2JwFJiY/hp0Qf465TukSdrfiKu8K5noWRrqadjDckiPQWj7Lb0cYg
 1+NCHAxXlXesR9zMGJFGOz29jpAlIvTwKuso+ewqO+cXHuZ2/nnr0b5fSl8=
X-Google-Smtp-Source: AGHT+IFE7ljrJeF4LzwW+CnqnS+9qoi3n+My+OBRcF3AnlwhP6sQyaBJGrcg3SdNFs2peoP4USWb3w==
X-Received: by 2002:a17:903:1946:b0:231:b7f5:cab5 with SMTP id
 d9443c01a7336-23414fbb6c9mr58670365ad.33.1748100879014; 
 Sat, 24 May 2025 08:34:39 -0700 (PDT)
Received: from [192.168.0.113] ([139.227.182.131])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23401ab6c3asm21844315ad.72.2025.05.24.08.34.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 May 2025 08:34:38 -0700 (PDT)
Message-ID: <ef86389b-ce08-4530-8150-55fac6ec6f66@gmail.com>
Date: Sat, 24 May 2025 23:34:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/pci: Introduce x-pci-class-code option
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20250524153102.19747-1-tomitamoeko@gmail.com>
Content-Language: en-US
From: Tomita Moeko <tomitamoeko@gmail.com>
Autocrypt: addr=tomitamoeko@gmail.com; keydata=
 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
In-Reply-To: <20250524153102.19747-1-tomitamoeko@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pl1-x643.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 5/24/25 23:31, Tomita Moeko wrote:
> Introduce x-pci-class-code option to allow users to override PCI class
> code of a device, similar to the existing x-pci-vendor-id option. Only
> the lower 24 bits of this option are used, though a uint32 is used here
> for determining whether the value is valid and set by user.
> 
> This is mainly intended for IGD devices that expose themselves either
> as VGA controller (primary display) or Display controller (non-primary
> display). The UEFI GOP driver depends on the device reporting a VGA
> controller class code (0x030000).
> 
> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
> ---
>  hw/vfio/pci.c        | 17 +++++++++++++++++
>  hw/vfio/pci.h        |  1 +
>  hw/vfio/trace-events |  1 +
>  3 files changed, 19 insertions(+)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index a1bfdfe375..879347a54e 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3062,6 +3062,21 @@ static bool vfio_pci_config_setup(VFIOPCIDevice *vdev, Error **errp)
>                                                vdev->sub_device_id);
>      }
>  
> +    /*
> +     * Class code is a 24-bit value at config space 0x09. Allow overriding it
> +     * with any 24-bit value.
> +     */
> +    if (vdev->class_code != PCI_ANY_ID) {
> +        if (vdev->class_code > 0xffffff) {
> +            error_setg(errp, "invalid PCI class code provided");
> +            return false;
> +        }
> +        /* Higher 24 bits of PCI_CLASS_REVISION are class code */
> +        vfio_add_emulated_long(vdev, PCI_CLASS_REVISION,
> +                               vdev->class_code << 8, ~0xff);
> +        trace_vfio_pci_emulated_class_code(vbasedev->name, vdev->class_code);
> +    }
> +
>      /* QEMU can change multi-function devices to single function, or reverse */
>      vdev->emulated_config_bits[PCI_HEADER_TYPE] =
>                                                PCI_HEADER_TYPE_MULTI_FUNCTION;
> @@ -3482,6 +3497,8 @@ static const Property vfio_pci_dev_properties[] = {
>                         sub_vendor_id, PCI_ANY_ID),
>      DEFINE_PROP_UINT32("x-pci-sub-device-id", VFIOPCIDevice,
>                         sub_device_id, PCI_ANY_ID),
> +    DEFINE_PROP_UINT32("x-pci-class-code", VFIOPCIDevice,
> +                       class_code, PCI_ANY_ID),
>      DEFINE_PROP_UINT32("x-igd-gms", VFIOPCIDevice, igd_gms, 0),
>      DEFINE_PROP_UNSIGNED_NODEFAULT("x-nv-gpudirect-clique", VFIOPCIDevice,
>                                     nv_gpudirect_clique,
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index 5ce0fb916f..587eb8cc9a 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -156,6 +156,7 @@ struct VFIOPCIDevice {
>      uint32_t device_id;
>      uint32_t sub_vendor_id;
>      uint32_t sub_device_id;
> +    uint32_t class_code;
>      uint32_t features;
>  #define VFIO_FEATURE_ENABLE_VGA_BIT 0
>  #define VFIO_FEATURE_ENABLE_VGA (1 << VFIO_FEATURE_ENABLE_VGA_BIT)
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index e90ec9bff8..d0b006aa29 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -46,6 +46,7 @@ vfio_pci_emulated_vendor_id(const char *name, uint16_t val) "%s 0x%04x"
>  vfio_pci_emulated_device_id(const char *name, uint16_t val) "%s 0x%04x"
>  vfio_pci_emulated_sub_vendor_id(const char *name, uint16_t val) "%s 0x%04x"
>  vfio_pci_emulated_sub_device_id(const char *name, uint16_t val) "%s 0x%04x"
> +vfio_pci_emulated_class_code(const char *name, uint16_t val) "%s 0x%06x"
                                                  ^^^^^^^^
Sorry there is a mistake, it should be `uint32_t` here...

>  # pci-quirks.c
>  vfio_quirk_rom_in_denylist(const char *name, uint16_t vid, uint16_t did) "%s %04x:%04x"


