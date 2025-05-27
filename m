Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 903DBC54ED1
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 12:25:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJtLm-0004za-Bq; Tue, 27 May 2025 08:24:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uJtLi-0004yi-0V
 for qemu-devel@nongnu.org; Tue, 27 May 2025 08:24:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uJtLb-0008O2-08
 for qemu-devel@nongnu.org; Tue, 27 May 2025 08:24:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748348633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kPIl6huUN4xa4yyD+AofLyI8OZhnZGlbGJO+t6Xo75o=;
 b=aKHhX1HeznQwBHbRA3CVKKHqlE3CS9CTDO/CfMsNm4FGok1b+b52Mud9GeSunWky15/6RC
 KpVnFHPVely9ndZA41IIoljJNQCStKSLE8Hz5Hb0Zsk8IEF8464Em+lHoy/tBHeiKs6E47
 cbO5xErxgbehrGEfAUliyhp5zTsl1EY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-LaGeu3bPPEu8g4YKy_9JAA-1; Tue, 27 May 2025 08:23:52 -0400
X-MC-Unique: LaGeu3bPPEu8g4YKy_9JAA-1
X-Mimecast-MFC-AGG-ID: LaGeu3bPPEu8g4YKy_9JAA_1748348631
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a3684a5655so1640216f8f.0
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 05:23:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748348631; x=1748953431;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kPIl6huUN4xa4yyD+AofLyI8OZhnZGlbGJO+t6Xo75o=;
 b=ri7EyXcG4qXWsHyxfxFKyTItqsTHk0cnnN0eRxfXiEjiprskx2uO8mZgCiufj3spM5
 7ksF5fNwUOK1am2puOk+z65twyR9fM2vZ76Wz/zBgNDxWx7riYmVpKZpbTxbrP61JNAr
 JNQBIlkWHX8neibKF6hxGJoyqg+sp+Y+QGhRXaZBMGiMCHCyaY1Wj1MGHiMbYffkagON
 rM+8RS7RdVlbzG018alqP9m2GK3igPOMqLxoKMNoqRa+53Q6pg3axee8FtQkwCEbobLs
 WcZsGYpnN+e11Acl+OrjtBUx7WxeGQPrF08QocSjLfLYWmb8JMyHsQLstR+f+rRx2h0e
 npdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmEJAuVj3/h2SK2SZq1P2IeqUA//fWw2m8hF/GNsnUbPVkiBvH0mHSxIWxum4b6Tn/wgvyQJGnwd98@nongnu.org
X-Gm-Message-State: AOJu0YwG4yhxlu5E+MiJY6KBJn8XTd9GMwYtwBJF/U6ltTNr2h8HNkrX
 RV3X0bcEr8KX3FWiBjT5J/cFa2SSglY5yg+uxTuoVLUHPafLuC/b7yJuANPYhINPTX9V6iMNBoi
 CFpJHks/375FoCBa5Kq375zadymCPt9+fIil62aPHF8cGeQ0VsvITeBrY
X-Gm-Gg: ASbGncuvTcSO9kfepXhNg18nk3QoUUlpQPLXzrfqS2KYR97Y57gusxOYeuzc+wBvvQc
 gzsM+jKwcckZ3S8/QE3ao5w0M0cikDjo4Km0jQU2RyJ5BJ8YVH5St5FF9xbcPNxsyPO9QwRif4F
 vX2uK2TVU0hI6D7gVKI5UBT41llE1hGgNMig+6bTb21GLZESyegF7EgxGYGTtSJrNAjpSzhPZrr
 uiSCVYd3w4OqrWtXqgdqCx52RkFE2YDXi2laxcmuyWuLBMNISUATgulTwo4n9nNHpC0jl17xOLZ
 qkS33vZEAWNAteOIYxVZGZyX5WT9nqKF
X-Received: by 2002:a05:6000:2584:b0:3a4:d0dc:184d with SMTP id
 ffacd0b85a97d-3a4d0dc1c68mr7377876f8f.27.1748348630743; 
 Tue, 27 May 2025 05:23:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGB7BxE9W5W/DDYoVEQFnLP61/83ezqiT8cqHPUAwq9ZigmJrFr31tvgeos4gerHzQu6VfTNg==
X-Received: by 2002:a05:6000:2584:b0:3a4:d0dc:184d with SMTP id
 ffacd0b85a97d-3a4d0dc1c68mr7377862f8f.27.1748348630376; 
 Tue, 27 May 2025 05:23:50 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4d90912d4sm5808116f8f.47.2025.05.27.05.23.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 05:23:50 -0700 (PDT)
Date: Tue, 27 May 2025 14:23:48 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, gustavo.romero@linaro.org, anisinha@redhat.com,
 mst@redhat.com, shannon.zhaosl@gmail.com, pbonzini@redhat.com,
 Jonathan.Cameron@huawei.com, philmd@linaro.org, alex.bennee@linaro.org
Subject: Re: [PATCH v2 01/25] hw/i386/acpi-build: Make aml_pci_device_dsm()
 static
Message-ID: <20250527142348.1b4b721d@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250527074224.1197793-2-eric.auger@redhat.com>
References: <20250527074224.1197793-1-eric.auger@redhat.com>
 <20250527074224.1197793-2-eric.auger@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, 27 May 2025 09:40:03 +0200
Eric Auger <eric.auger@redhat.com> wrote:

> No need to export aml_pci_device_dsm() as it is only used
> in hw/i386/acpi-build.c.
>=20
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  include/hw/acpi/pci.h | 1 -
>  hw/i386/acpi-build.c  | 2 +-
>  2 files changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/include/hw/acpi/pci.h b/include/hw/acpi/pci.h
> index 6359d574fd..ab0187a894 100644
> --- a/include/hw/acpi/pci.h
> +++ b/include/hw/acpi/pci.h
> @@ -36,7 +36,6 @@ typedef struct AcpiMcfgInfo {
> =20
>  void build_mcfg(GArray *table_data, BIOSLinker *linker, AcpiMcfgInfo *in=
fo,
>                  const char *oem_id, const char *oem_table_id);
> -Aml *aml_pci_device_dsm(void);
> =20
>  void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus);
>  void build_pci_bridge_aml(AcpiDevAmlIf *adev, Aml *scope);
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 61851cc840..f59026524f 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -338,7 +338,7 @@ build_facs(GArray *table_data)
>      g_array_append_vals(table_data, reserved, 40); /* Reserved */
>  }
> =20
> -Aml *aml_pci_device_dsm(void)
> +static Aml *aml_pci_device_dsm(void)
>  {
>      Aml *method;
> =20


