Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DADEC71155
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 12:13:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSabG-0002Cy-Aq; Fri, 20 Jun 2025 08:12:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uSab7-00028d-2Y
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 08:11:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uSab3-0005l2-Bi
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 08:11:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750421511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/Ir0px5WCIDm9aNSHCxvhKa6T9zzjSsHqMnbniD/uT8=;
 b=HWaamu9TBJPagmSJpEaxyrBwrEw/aqB7Wt6kSMFoGhaP2iMyR3jqMNWkihI9usZvpECH8L
 zd65hrja++NFlRIidNGm8It3uTVUfqgmYJKfDgmGa4GDu0aMHB62X4zDY1oAowfzp7CN3o
 JmcTygrQUyOsTR3MnNVJCKDsN+utyi4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-ks_nX5gsMhi1CPgNl9Zc3Q-1; Fri, 20 Jun 2025 08:11:50 -0400
X-MC-Unique: ks_nX5gsMhi1CPgNl9Zc3Q-1
X-Mimecast-MFC-AGG-ID: ks_nX5gsMhi1CPgNl9Zc3Q_1750421509
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a4fac7fa27so852147f8f.0
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 05:11:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750421509; x=1751026309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/Ir0px5WCIDm9aNSHCxvhKa6T9zzjSsHqMnbniD/uT8=;
 b=seZhcAYLoKFrKPU4L9fcVPV8PWM9fgDbCwUMjhFXx/3NsW8nBbmKzEhtIYL++wwNUs
 Rfz1pyFyX0kgVm+KAM/CTvUHUrX6dgTbAhcAmY19cDDs7Qqcx7zonNGIR1WSFnI/v/bm
 w/YPEuRvOScDuEJKxA/kGtZ8JiMCwGHa0bwpxt7YUUQZvCKmRoL68XMzGyRnl7plipVl
 2dzn7RCMGqSGVOuI+e0joQCax1Cy7wj5Vo22aFORlwzsudMTMpSCFIk7xz96vNaaQgqm
 rGaGGYF22nxkbf4e8ETHs8AVw7QGCenyP62rzcQJ04SOPWntNLjhWnXUWasCY5A6zBzP
 CA+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWb/A1ot29Um6zVZoyGndc2SyVKIEKrlamni7PwQEdHnicCZS7SsUaCmZKfT5Tx8YmUa/uRol2bMuCR@nongnu.org
X-Gm-Message-State: AOJu0YybPCvQses/2z31tFBlj5+7ii+c15AkXVdFXJY6zR+SoMiptn4B
 qGqmmW4an6tsSMT154Tvgfkx3YjYUVYAFWhzFjrR//ETcQPH1apSzEnjHfkkpO0nIfKbVIJGyQZ
 oSgvKrD325lVT5jRQaJps3ognW5gRazIM7GO7yFH980+L88OCUCfrjpkw
X-Gm-Gg: ASbGncvNUp1v0bh/0Ze53fgXBdUTCuV5ic9X0ygcqeQ9cwN3eGunfojX3XX0j7+/Cdu
 XQw/YTrgR6MRp+S2BAwFR84A64ycOkdqJrcYdwoSvOAjXQigldWMa6NPt8FIBnH32GyQj4VlV7y
 9btjpcqn88jmbmm6wUEwmAE1zqab6fR99J6owPOExAMXXco6vl3V/3CHYYOM86MrpYvr7qBHXTQ
 eLdYo8QaVKcpMvxeF2PPEO4PE3RqTiF+EXqvP7aKVTMscZ1Qy1lRGacF2l76WKBr0lnh+P+9pa4
 n5lw/pclJOFH
X-Received: by 2002:a05:6000:1a8e:b0:3a4:f6ba:51da with SMTP id
 ffacd0b85a97d-3a6d12db6d0mr2171314f8f.15.1750421509063; 
 Fri, 20 Jun 2025 05:11:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHM6VWXWmJ3/dbhFUZML8OZQJtxuLz322+G8Vdm4MRRvjiZRY3CEJn4BHU81aRH+vGkCZ5hWw==
X-Received: by 2002:a05:6000:1a8e:b0:3a4:f6ba:51da with SMTP id
 ffacd0b85a97d-3a6d12db6d0mr2171283f8f.15.1750421508652; 
 Fri, 20 Jun 2025 05:11:48 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d0f19f9esm1925745f8f.39.2025.06.20.05.11.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Jun 2025 05:11:48 -0700 (PDT)
Date: Fri, 20 Jun 2025 14:11:46 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, gustavo.romero@linaro.org, anisinha@redhat.com,
 mst@redhat.com, shannon.zhaosl@gmail.com, pbonzini@redhat.com,
 Jonathan.Cameron@huawei.com, philmd@linaro.org, alex.bennee@linaro.org
Subject: Re: [PATCH v3 08/29] hw/i386/acpi-build: Turn build_q35_osc_method
 into a generic method
Message-ID: <20250620141146.503c89e8@fedora>
In-Reply-To: <20250616094903.885753-9-eric.auger@redhat.com>
References: <20250616094903.885753-1-eric.auger@redhat.com>
 <20250616094903.885753-9-eric.auger@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, 16 Jun 2025 11:46:37 +0200
Eric Auger <eric.auger@redhat.com> wrote:

> GPEX acpi_dsdt_add_pci_osc() does basically the same as
> build_q35_osc_method().
> 
> Rename build_q35_osc_method() into build_pci_host_bridge_osc_method()
> and move it into hw/acpi/pci.c. In a subsequent patch we will
> use this later in place of acpi_dsdt_add_pci_osc().
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> 
> ---
> 
> v2 -> v3:
> - move to hw/acpi/pci.c instead of aml-build.c (Igor)
> ---
>  include/hw/acpi/pci.h |  2 ++
>  hw/acpi/pci.c         | 50 +++++++++++++++++++++++++++++++++++++++
>  hw/i386/acpi-build.c  | 54 ++-----------------------------------------
>  3 files changed, 54 insertions(+), 52 deletions(-)
> 
> diff --git a/include/hw/acpi/pci.h b/include/hw/acpi/pci.h
> index ab0187a894..8a328b580c 100644
> --- a/include/hw/acpi/pci.h
> +++ b/include/hw/acpi/pci.h
> @@ -42,4 +42,6 @@ void build_pci_bridge_aml(AcpiDevAmlIf *adev, Aml *scope);
>  
>  void build_srat_generic_affinity_structures(GArray *table_data);
>  
> +Aml *build_pci_host_bridge_osc_method(bool enable_native_pcie_hotplug);
> +
>  #endif
> diff --git a/hw/acpi/pci.c b/hw/acpi/pci.c
> index d511a85029..2228f1245e 100644
> --- a/hw/acpi/pci.c
> +++ b/hw/acpi/pci.c
> @@ -301,3 +301,53 @@ void build_srat_generic_affinity_structures(GArray *table_data)
>      object_child_foreach_recursive(object_get_root(), build_acpi_generic_port,
>                                     table_data);
>  }
> +
> +Aml *build_pci_host_bridge_osc_method(bool enable_native_pcie_hotplug)
> +{
> +    Aml *if_ctx;
> +    Aml *if_ctx2;
> +    Aml *else_ctx;
> +    Aml *method;
> +    Aml *a_cwd1 = aml_name("CDW1");
> +    Aml *a_ctrl = aml_local(0);
> +
> +    method = aml_method("_OSC", 4, AML_NOTSERIALIZED);
> +    aml_append(method, aml_create_dword_field(aml_arg(3), aml_int(0), "CDW1"));
> +
> +    if_ctx = aml_if(aml_equal(
> +        aml_arg(0), aml_touuid("33DB4D5B-1FF7-401C-9657-7441C03DD766")));
> +    aml_append(if_ctx, aml_create_dword_field(aml_arg(3), aml_int(4), "CDW2"));
> +    aml_append(if_ctx, aml_create_dword_field(aml_arg(3), aml_int(8), "CDW3"));
> +
> +    aml_append(if_ctx, aml_store(aml_name("CDW3"), a_ctrl));
> +
> +    /*
> +     * Always allow native PME, AER (no dependencies)
> +     * Allow SHPC (PCI bridges can have SHPC controller)
> +     * Disable PCIe Native Hot-plug if ACPI PCI Hot-plug is enabled.
> +     */
> +    aml_append(if_ctx, aml_and(a_ctrl,
> +        aml_int(0x1E | (enable_native_pcie_hotplug ? 0x1 : 0x0)), a_ctrl));
> +
> +    if_ctx2 = aml_if(aml_lnot(aml_equal(aml_arg(1), aml_int(1))));
> +    /* Unknown revision */
> +    aml_append(if_ctx2, aml_or(a_cwd1, aml_int(0x08), a_cwd1));
> +    aml_append(if_ctx, if_ctx2);
> +
> +    if_ctx2 = aml_if(aml_lnot(aml_equal(aml_name("CDW3"), a_ctrl)));
> +    /* Capabilities bits were masked */
> +    aml_append(if_ctx2, aml_or(a_cwd1, aml_int(0x10), a_cwd1));
> +    aml_append(if_ctx, if_ctx2);
> +
> +    /* Update DWORD3 in the buffer */
> +    aml_append(if_ctx, aml_store(a_ctrl, aml_name("CDW3")));
> +    aml_append(method, if_ctx);
> +
> +    else_ctx = aml_else();
> +    /* Unrecognized UUID */
> +    aml_append(else_ctx, aml_or(a_cwd1, aml_int(4), a_cwd1));
> +    aml_append(method, else_ctx);
> +
> +    aml_append(method, aml_return(aml_arg(3)));
> +    return method;
> +}
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 4f8572eebe..91945f716c 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1111,56 +1111,6 @@ static Aml *build_q35_dram_controller(const AcpiMcfgInfo *mcfg)
>      return dev;
>  }
>  
> -static Aml *build_q35_osc_method(bool enable_native_pcie_hotplug)
> -{
> -    Aml *if_ctx;
> -    Aml *if_ctx2;
> -    Aml *else_ctx;
> -    Aml *method;
> -    Aml *a_cwd1 = aml_name("CDW1");
> -    Aml *a_ctrl = aml_local(0);
> -
> -    method = aml_method("_OSC", 4, AML_NOTSERIALIZED);
> -    aml_append(method, aml_create_dword_field(aml_arg(3), aml_int(0), "CDW1"));
> -
> -    if_ctx = aml_if(aml_equal(
> -        aml_arg(0), aml_touuid("33DB4D5B-1FF7-401C-9657-7441C03DD766")));
> -    aml_append(if_ctx, aml_create_dword_field(aml_arg(3), aml_int(4), "CDW2"));
> -    aml_append(if_ctx, aml_create_dword_field(aml_arg(3), aml_int(8), "CDW3"));
> -
> -    aml_append(if_ctx, aml_store(aml_name("CDW3"), a_ctrl));
> -
> -    /*
> -     * Always allow native PME, AER (no dependencies)
> -     * Allow SHPC (PCI bridges can have SHPC controller)
> -     * Disable PCIe Native Hot-plug if ACPI PCI Hot-plug is enabled.
> -     */
> -    aml_append(if_ctx, aml_and(a_ctrl,
> -        aml_int(0x1E | (enable_native_pcie_hotplug ? 0x1 : 0x0)), a_ctrl));
> -
> -    if_ctx2 = aml_if(aml_lnot(aml_equal(aml_arg(1), aml_int(1))));
> -    /* Unknown revision */
> -    aml_append(if_ctx2, aml_or(a_cwd1, aml_int(0x08), a_cwd1));
> -    aml_append(if_ctx, if_ctx2);
> -
> -    if_ctx2 = aml_if(aml_lnot(aml_equal(aml_name("CDW3"), a_ctrl)));
> -    /* Capabilities bits were masked */
> -    aml_append(if_ctx2, aml_or(a_cwd1, aml_int(0x10), a_cwd1));
> -    aml_append(if_ctx, if_ctx2);
> -
> -    /* Update DWORD3 in the buffer */
> -    aml_append(if_ctx, aml_store(a_ctrl, aml_name("CDW3")));
> -    aml_append(method, if_ctx);
> -
> -    else_ctx = aml_else();
> -    /* Unrecognized UUID */
> -    aml_append(else_ctx, aml_or(a_cwd1, aml_int(4), a_cwd1));
> -    aml_append(method, else_ctx);
> -
> -    aml_append(method, aml_return(aml_arg(3)));
> -    return method;
> -}
> -
>  static void build_acpi0017(Aml *table)
>  {
>      Aml *dev, *scope, *method;
> @@ -1231,7 +1181,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>          aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A08")));
>          aml_append(dev, aml_name_decl("_CID", aml_eisaid("PNP0A03")));
>          aml_append(dev, aml_name_decl("_UID", aml_int(pcmc->pci_root_uid)));
> -        aml_append(dev, build_q35_osc_method(!pm->pcihp_bridge_en));
> +        aml_append(dev, build_pci_host_bridge_osc_method(!pm->pcihp_bridge_en));
>          aml_append(dev, aml_pci_edsm());
>          aml_append(sb_scope, dev);
>          if (mcfg_valid) {
> @@ -1353,7 +1303,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>                  aml_append(dev, aml_name_decl("_CID", aml_eisaid("PNP0A03")));
>  
>                  /* Expander bridges do not have ACPI PCI Hot-plug enabled */
> -                aml_append(dev, build_q35_osc_method(true));
> +                aml_append(dev, build_pci_host_bridge_osc_method(true));
>              } else {
>                  aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A03")));
>              }


