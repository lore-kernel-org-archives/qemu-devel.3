Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DDAC10F287C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 23:48:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6Gu5-0004Z3-63; Fri, 27 Mar 2026 19:47:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w6Gty-0004Yf-4s
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 19:47:42 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w6Gtw-0002Hn-6P
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 19:47:41 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-486507134e4so29829795e9.0
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 16:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774655258; x=1775260058; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8U0NFvxINT5B0OqgCTNmJYQAGf5nVzmIxrMl9fgV8RU=;
 b=AU0FWZpSPnMGV+kLzwm8FBO9Z706xz71S/6oWMz2euiUFFAnpXRoAU4fZE6J3EYNKM
 efg7Ob4i1CJnfS7+oTq93/mGKk2iBa98r64QXSgyP63sxbV3bvcc5QGKw+cf+nRBopTd
 qKx/RnIvXPT+xVnpr6Ynt4dxLEXjbgGuj1O1hHhfZ1zgbMDl6GE37oRS17oGJk5BseaA
 Dt1fgXLJ+EUoyJ8i0uzzUp3ERUyUb8Go52rV4MJs1wGMS+TyWMLBw2dZ7jzUoLUXr5uQ
 vvQ6vTiog02IsFvpyz1hkjlJ1PQ5X7RXNAErtmliEojOoPIt7Z7UAiGUAEnIpaumPwka
 +Vjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774655258; x=1775260058;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8U0NFvxINT5B0OqgCTNmJYQAGf5nVzmIxrMl9fgV8RU=;
 b=P8aIcGS8U20L8JUmLQVPNakFhe/YTO8EahXCnTy6GOw6BRaA4n5Nl+OXTjA8XUnQ5+
 Zv7ad6HGPMK5xSdNZgCRRfWZsyTOrQttDRmjGLl08/rahLmD0sDY+DvjgIsymwB/TDQe
 oeNW6+HO8l8tTZoL41DYVWzbgMxmoUtyyx3eGuv4hwd/hp8ZEKrxri80K/16/jN8VepS
 FFMlrf6n8DTx8NemaJsW8t1FufYEndul/TWP6hkc0XPJZIL4Z/VIcpanDcy0/ZlJBjiT
 gQEZURNWjIsuqT5RcEWRfkXzfi4Eii/Q25wW1foRSdc72hW3N+rsUvUJlRzzVttvvqSj
 mN+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxY4QfR2V1NxlHnZiZQ8czEX4nM3HzwYDIiNYX4ftuvCSU2mbXWyo+4kQEYOE3MoVp1TSxfL5vvtse@nongnu.org
X-Gm-Message-State: AOJu0YySVDcQzMeFwnfCr/+k8i0SKr9pCHYTUX+I4UI3g0FPkaUyikp6
 t68qN/3jincnHapC5U3bLcLtgtBNeAYQSzM3DXCizVUigJe0/McA9wbBYztYO/OU7YfLQlNPAE0
 Zyg9XGAg=
X-Gm-Gg: ATEYQzyYScvo0+pmrRcvmX5o7sAgDlFs5YoH6urBaGb7hyQ/mTjTzdHCch6rvLZrVys
 J4nOaUvIYGaM88nvoarXPAoS2AbH7npgkxdRLdsLRIXeJ7L5qVg9H4v2smmbSCWakQ1OJnb+3Bc
 PtpXwss/6XdsBOZDfVOw0SO4YJDbuhASmfwGCVJ6bMVhM0NT6hr00/9HTdFunLN8H4oWWBVw73i
 pKeAvQcVKeZSe6sBYJeiW5x7pggAuPoNw+BfdCZS0+Pxxn5+VKDcw1g9V4SiiFFa/nKvdX0sszm
 TV6tSgAt7553bpSF45npfyMf/DHeOJW5tWhGas1kbCKVLYh8nf4ytSwKF/MX9E51AL6WBI8ItNe
 EyQ19v44dDNq6CMkaGEt+EpwTadPB3WGXxSjE/+2qkQ4T6YBclT755wvcf/rtruqtdNf3H6LzhR
 jLi7qidyUeH5hHlHqLT9Yqu2kzPi4K2exRXfOCH3Gwd34WzOZ24J/xx/92BBhj8g==
X-Received: by 2002:a05:600c:46c4:b0:485:3a03:ceca with SMTP id
 5b1f17b1804b1-48727f0e53bmr76254025e9.23.1774655257674; 
 Fri, 27 Mar 2026 16:47:37 -0700 (PDT)
Received: from [10.202.147.66] (147.149.216.82.rev.sfr.net. [82.216.149.147])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4873068858bsm11296985e9.9.2026.03.27.16.47.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Mar 2026 16:47:36 -0700 (PDT)
Message-ID: <6cb600f2-5f0a-4b77-a972-967deee93698@linaro.org>
Date: Sat, 28 Mar 2026 00:47:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] hw/tpm: add PPI support to tpm-tis-device for
 ARM64 virt
Content-Language: en-US
To: Mohammadfaiz Bawa <mbawa@redhat.com>, qemu-devel@nongnu.org
Cc: stefanb@linux.vnet.ibm.com, pierrick.bouvier@linaro.org,
 "Michael S . Tsirkin" <mst@redhat.com>, imammedo@redhat.com,
 anisinha@redhat.com, peter.maydell@linaro.org, shannon.zhaosl@gmail.com,
 qemu-arm@nongnu.org, mohamed@unpredictable.fr,
 Stefan Berger <stefanb@linux.ibm.com>
References: <20260327173209.148180-1-mbawa@redhat.com>
 <20260327173209.148180-4-mbawa@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260327173209.148180-4-mbawa@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi,

On 27/3/26 18:32, Mohammadfaiz Bawa wrote:
> Add PPI memory region and ACPI _STA, _DSM to tpm-tis-sysbus so
> Windows 11 ARM64 guests no longer log Event ID 15 errors from
> tpm.sys on every boot.
> 
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> Signed-off-by: Mohammadfaiz Bawa <mbawa@redhat.com>
> ---
>   hw/arm/virt-acpi-build.c |  9 ++++++++-
>   hw/tpm/tpm_tis_sysbus.c  | 11 +++++++++++
>   2 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 591cfc993c..5b5ac551f8 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -240,7 +240,8 @@ static void acpi_dsdt_add_tpm(Aml *scope, VirtMachineState *vms)
>       Aml *dev = aml_device("TPM0");
>       aml_append(dev, aml_name_decl("_HID", aml_string("MSFT0101")));
>       aml_append(dev, aml_name_decl("_STR", aml_string("TPM 2.0 Device")));
> -    aml_append(dev, aml_name_decl("_UID", aml_int(0)));
> +    aml_append(dev, aml_name_decl("_UID", aml_int(1)));
> +    aml_append(dev, aml_name_decl("_STA", aml_int(0xF)));
>   
>       Aml *crs = aml_resource_template();
>       aml_append(crs,
> @@ -248,6 +249,12 @@ static void acpi_dsdt_add_tpm(Aml *scope, VirtMachineState *vms)
>                                     (uint32_t)memory_region_size(sbdev_mr),
>                                     AML_READ_WRITE));
>       aml_append(dev, aml_name_decl("_CRS", crs));
> +
> +    hwaddr ppi_base = platform_bus_get_mmio_addr(pbus, sbdev, 1);
> +    if (ppi_base != -1) {
> +        ppi_base += pbus_base;
> +        tpm_build_ppi_acpi(TPM_IF(sbdev), dev, ppi_base);

Matter of style, I'd rather:

            tpm_build_ppi_acpi(TPM_IF(sbdev), dev, pbus_base + ppi_base);

> +    }
>       aml_append(scope, dev);
>   }
>   #endif

Hmm I see in tests/qtest/bios-tables-test.c that test_acpi_tcg_tpm()
only tests X86 (Q35). Could you see how to add coverage for Aarch64
virt machine? (It could be a patch on top, no need to repost a v4).

Otherwise,

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


