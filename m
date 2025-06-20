Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3547C7115D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 12:17:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSafp-0003fd-4o; Fri, 20 Jun 2025 08:16:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uSafN-0003dc-3u
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 08:16:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uSafJ-0006Sy-6g
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 08:16:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750421771;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YttMP97XA0YGzCwUTM9cPhn/4IsllK+DArVX8YtuLig=;
 b=X60e3hM131uaxFGtezW7IlWoPiDuxNKSwPEMAGGKwQZ9vfssWrbTXilZeje7PyCNN685R/
 IUZ+a/AchrMbKUp34N8A1ISk7HPvoD7lW3YW4duNBeW22bT9sW0SuCpJ9UmsYaDVJy36Bm
 VprQLnhqAxljm+V5uyipQy04Wjv38mE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-l3Ptvf65M0Kn_GpMuHCI0A-1; Fri, 20 Jun 2025 08:16:10 -0400
X-MC-Unique: l3Ptvf65M0Kn_GpMuHCI0A-1
X-Mimecast-MFC-AGG-ID: l3Ptvf65M0Kn_GpMuHCI0A_1750421769
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-450d50eacafso10846965e9.3
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 05:16:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750421768; x=1751026568;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YttMP97XA0YGzCwUTM9cPhn/4IsllK+DArVX8YtuLig=;
 b=vWTdtrizjFNKEOGiNeLpPmwXmHqMghb3Sf3WE96BqyZchgIzkfWR7IHYKL6QdSIES5
 6GOpldfxFd+yKglKEXRnKbVd4pikRibVSSiP55JSqWcA8REOSFT1BGl0T6vd6PNLLTAz
 zB9ibT0ovlaACAgmDqmBWFkOwVqck4z6kRLU4c5Ij46AnacD6HEkt6sZWsLzElJJAfNi
 NMRErxWd5N/mTjX194kDlDdUN4KPQr1u5YvV757gAKJPZVOuwNsutcQYlp4CDasJW/dL
 ct/LegeXcHUCdEnxFanQiGNziKs2J3tCaEDs96Neqf+SPdMCCj8cte3otLcLkUO8/S9D
 M9Og==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBx1W2aFCDWhP7JuD2mUf6goFQMNSNHCH9Js4IXjB0uaJZwmI6AQM1Ro7zc3hfU+mpDaWG4Z3T57xh@nongnu.org
X-Gm-Message-State: AOJu0Yxy5azcQ8G2UvQ+VlRIrfum+j1a182tyQu+b5pl/YmMvypkYPiM
 fDBvARmmXXPwR4RImwGqzvs5//lEJ++Pyo66Il/qcYAfPduyhLyucl4s1lnE65LrO+bX4C/hT1/
 WtChHsT1+S/ec+rk7/KBKIQyHTKV4/zRxr8v1+ra7zzPx/+frDbQ5pwuIFji+dJuE
X-Gm-Gg: ASbGnct5qtWExmrmHqxj3zt+pUFD0MYley14nNKsG1LIfTF9o5frXDc+0VrYxKVXNu/
 m0xQbwH0kPxvLfaB5zLP07TaiaZk9Xh3dBf3Dj7W7aCsIVyxPGZ8GR12gw7UbZ1GbJCQztVtJZq
 euplTo8edIX4JA8Of1cwqtrSnHaXguZXwBAcCpydzMltx9qda1SDQJbvBhOUHCV0Td+2GNjnatr
 OhpOexEj4xrvxDrCpnv+tSXjmzy28xsO/A9C4ff3uKX0xwW12wQ9CsEAVCAsWBcUWFDaCK5yN/k
 FFqsb/MUKwHe
X-Received: by 2002:a05:600c:4684:b0:453:d3d:d9fd with SMTP id
 5b1f17b1804b1-453654cb7cdmr25695265e9.12.1750421768533; 
 Fri, 20 Jun 2025 05:16:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0XyIpLNg/BiaqBRQmGbzKGQTA2F5sDJz+fHh5GnN7rhRzIGqSzBp5bY9QYaURjs55EkD0MA==
X-Received: by 2002:a05:600c:4684:b0:453:d3d:d9fd with SMTP id
 5b1f17b1804b1-453654cb7cdmr25694855e9.12.1750421768092; 
 Fri, 20 Jun 2025 05:16:08 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d1190cc3sm1892106f8f.89.2025.06.20.05.16.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Jun 2025 05:16:07 -0700 (PDT)
Date: Fri, 20 Jun 2025 14:16:06 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, gustavo.romero@linaro.org, anisinha@redhat.com,
 mst@redhat.com, shannon.zhaosl@gmail.com, pbonzini@redhat.com,
 Jonathan.Cameron@huawei.com, philmd@linaro.org, alex.bennee@linaro.org
Subject: Re: [PATCH v3 09/29] hw/pci-host/gpex-acpi: Use
 build_pci_host_bridge_osc_method
Message-ID: <20250620141606.709c49a7@fedora>
In-Reply-To: <20250616094903.885753-10-eric.auger@redhat.com>
References: <20250616094903.885753-1-eric.auger@redhat.com>
 <20250616094903.885753-10-eric.auger@redhat.com>
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

On Mon, 16 Jun 2025 11:46:38 +0200
Eric Auger <eric.auger@redhat.com> wrote:

> gpex build_host_bridge_osc() and x86 originated
> build_pci_host_bridge_osc_method() are mostly identical.
> 
> In GPEX, SUPP is set to CDW2 but is not further used. CTRL
> is same as Local0.
> 
> So let gpex code reuse build_pci_host_bridge_osc_method()
> and remove build_host_bridge_osc().

qtest fails with

FAILED: qemu-system-mips64el 
cc -m64 @qemu-system-mips64el.rsp
/usr/bin/ld: libsystem.a.p/hw_pci-host_gpex-acpi.c.o: in function `acpi_dsdt_add_host_bridge_methods':
./hw/pci-host/gpex-acpi.c:83: undefined reference to `build_pci_host_bridge_osc_method'

> 
> The disassembled DSDT difference is given below:
> 
>   * Original Table Header:
>   *     Signature        "DSDT"
> - *     Length           0x00001A4F (6735)
> + *     Length           0x00001A35 (6709)
>   *     Revision         0x02
> - *     Checksum         0xBF
> + *     Checksum         0xDD
>   *     OEM ID           "BOCHS "
>   *     OEM Table ID     "BXPC    "
>   *     OEM Revision     0x00000001 (1)
> @@ -1849,27 +1849,26 @@ DefinitionBlock ("", "DSDT", 2, "BOCHS ", "BXPC    ", 0x00000001)
>                  {
>                      CreateDWordField (Arg3, 0x04, CDW2)
>                      CreateDWordField (Arg3, 0x08, CDW3)
> -                    SUPP = CDW2 /* \_SB_.PCI0._OSC.CDW2 */
> -                    CTRL = CDW3 /* \_SB_.PCI0._OSC.CDW3 */
> -                    CTRL &= 0x1F
> +                    Local0 = CDW3 /* \_SB_.PCI0._OSC.CDW3 */
> +                    Local0 &= 0x1F
>                      If ((Arg1 != One))
>                      {
>                          CDW1 |= 0x08
>                      }
> 
> -                    If ((CDW3 != CTRL))
> +                    If ((CDW3 != Local0))
>                      {
>                          CDW1 |= 0x10
>                      }
> 
> -                    CDW3 = CTRL /* \_SB_.PCI0.CTRL */
> -                    Return (Arg3)
> +                    CDW3 = Local0
>                  }
>                  Else
>                  {
>                      CDW1 |= 0x04
> -                    Return (Arg3)
>                  }
> +
> +                Return (Arg3)
>              }
> 
>              Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> 
> ---
> 
> v1 -> v2:
> - move in the dsdt.dsl diff in the commit message and remove useless
>   info (Gustavo, Michael)
> ---
>  hw/pci-host/gpex-acpi.c | 62 ++++-------------------------------------
>  1 file changed, 5 insertions(+), 57 deletions(-)
> 
> diff --git a/hw/pci-host/gpex-acpi.c b/hw/pci-host/gpex-acpi.c
> index 44737a8d81..952a0ace19 100644
> --- a/hw/pci-host/gpex-acpi.c
> +++ b/hw/pci-host/gpex-acpi.c
> @@ -1,5 +1,6 @@
>  #include "qemu/osdep.h"
>  #include "hw/acpi/aml-build.h"
> +#include "hw/acpi/pci.h"
>  #include "hw/pci-host/gpex.h"
>  #include "hw/arm/virt.h"
>  #include "hw/pci/pci_bus.h"
> @@ -50,61 +51,7 @@ static void acpi_dsdt_add_pci_route_table(Aml *dev, uint32_t irq,
>      }
>  }
>  
> -static Aml *build_host_bridge_osc(bool enable_native_pcie_hotplug)
> -{
> -    Aml *method, *UUID, *ifctx, *ifctx1, *elsectx;
> -    method = aml_method("_OSC", 4, AML_NOTSERIALIZED);
> -    aml_append(method, aml_name_decl("SUPP", aml_int(0)));
> -    aml_append(method, aml_name_decl("CTRL", aml_int(0)));
> -    aml_append(method,
> -        aml_create_dword_field(aml_arg(3), aml_int(0), "CDW1"));
> -
> -    /* PCI Firmware Specification 3.0
> -     * 4.5.1. _OSC Interface for PCI Host Bridge Devices
> -     * The _OSC interface for a PCI/PCI-X/PCI Express hierarchy is
> -     * identified by the Universal Unique IDentifier (UUID)
> -     * 33DB4D5B-1FF7-401C-9657-7441C03DD766
> -     */
> -    UUID = aml_touuid("33DB4D5B-1FF7-401C-9657-7441C03DD766");
> -    ifctx = aml_if(aml_equal(aml_arg(0), UUID));
> -    aml_append(ifctx,
> -        aml_create_dword_field(aml_arg(3), aml_int(4), "CDW2"));
> -    aml_append(ifctx,
> -        aml_create_dword_field(aml_arg(3), aml_int(8), "CDW3"));
> -    aml_append(ifctx, aml_store(aml_name("CDW2"), aml_name("SUPP")));
> -    aml_append(ifctx, aml_store(aml_name("CDW3"), aml_name("CTRL")));
> -
> -    /*
> -     * Allow OS control for SHPCHotplug, PME, AER, PCIeCapability,
> -     * and PCIeHotplug depending on enable_native_pcie_hotplug
> -     */
> -    aml_append(ifctx, aml_and(aml_name("CTRL"),
> -               aml_int(0x1E | (enable_native_pcie_hotplug ? 0x1 : 0x0)),
> -               aml_name("CTRL")));
> -
> -    ifctx1 = aml_if(aml_lnot(aml_equal(aml_arg(1), aml_int(0x1))));
> -    aml_append(ifctx1, aml_or(aml_name("CDW1"), aml_int(0x08),
> -                              aml_name("CDW1")));
> -    aml_append(ifctx, ifctx1);
> -
> -    ifctx1 = aml_if(aml_lnot(aml_equal(aml_name("CDW3"), aml_name("CTRL"))));
> -    aml_append(ifctx1, aml_or(aml_name("CDW1"), aml_int(0x10),
> -                              aml_name("CDW1")));
> -    aml_append(ifctx, ifctx1);
> -
> -    aml_append(ifctx, aml_store(aml_name("CTRL"), aml_name("CDW3")));
> -    aml_append(ifctx, aml_return(aml_arg(3)));
> -    aml_append(method, ifctx);
> -
> -    elsectx = aml_else();
> -    aml_append(elsectx, aml_or(aml_name("CDW1"), aml_int(4),
> -                               aml_name("CDW1")));
> -    aml_append(elsectx, aml_return(aml_arg(3)));
> -    aml_append(method, elsectx);
> -    return method;
> -}
> -
> -static Aml *build_host_bridge_dsm(void)
> +static Aml *build_pci_host_bridge_dsm_method(void)
>  {
>      Aml *method = aml_method("_DSM", 4, AML_NOTSERIALIZED);
>      Aml *UUID, *ifctx, *ifctx1, *buf;
> @@ -133,8 +80,9 @@ static void acpi_dsdt_add_host_bridge_methods(Aml *dev,
>                                                bool enable_native_pcie_hotplug)
>  {
>      /* Declare an _OSC (OS Control Handoff) method */
> -    aml_append(dev, build_host_bridge_osc(enable_native_pcie_hotplug));
> -    aml_append(dev, build_host_bridge_dsm());
> +    aml_append(dev,
> +               build_pci_host_bridge_osc_method(enable_native_pcie_hotplug));
> +    aml_append(dev, build_pci_host_bridge_dsm_method());
>  }
>  
>  void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)


