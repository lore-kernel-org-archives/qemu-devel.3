Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22DABC54ED1
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 12:32:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJtTQ-0007bf-1S; Tue, 27 May 2025 08:32:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uJtTH-0007WP-1s
 for qemu-devel@nongnu.org; Tue, 27 May 2025 08:31:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uJtT6-00012x-M2
 for qemu-devel@nongnu.org; Tue, 27 May 2025 08:31:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748349101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=khf7rH0HmEe5VYlwa8emnKScvg82xox3EazQfBd2MOk=;
 b=Y8vcaCfCNJUH6iOjILH/rMOsRnZUYpJp0nbyCVtcKzstBvQtXq0XiirxaDCkPlItY/npiN
 n6AGeOkWAHd9mol2d4Y9YHK64byyu8vYFF7ahbLKTNO3d8HbQt7oTpzFS75zPhewYqhrvJ
 K6ujCI1zal2wlb/OewfAuShJfrjCOBE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-ulkrn52fMUmmBTooT1uPsQ-1; Tue, 27 May 2025 08:31:39 -0400
X-MC-Unique: ulkrn52fMUmmBTooT1uPsQ-1
X-Mimecast-MFC-AGG-ID: ulkrn52fMUmmBTooT1uPsQ_1748349098
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43ea256f039so26146305e9.0
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 05:31:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748349098; x=1748953898;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=khf7rH0HmEe5VYlwa8emnKScvg82xox3EazQfBd2MOk=;
 b=It9VPhagCoBTlFwh4svXLA4iGILtBEFh2Ty4OAAz372S4VtgteRIK2/DMHFXS4qjXh
 sfv/K/8AW98Vk9AtZxnH8MDxceRE+GlLPXUlBjyJkKMvWr8EgNBnYbQ8LwDiUVx0NHLz
 fddYzqBolCkjtXUR7Q5HhOvnVIVn+1Z2rr1V5NxV62ehf5CE419EF6pSKWW/1UxBXLMM
 mAlxmyheUKAIKZZfpv0fRXGgS9DtpMUtc48kOnXanEhOx2uUeIFASVpY8C8Y8PYVDSIw
 Pn3Xmw2fM+njR5Bk/GHGEFCtQWu0ruJRGZTqu6WZZmH/0n4Y2hpH/zKGqqvQzUwO9HmS
 aRWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGCVtNy1DAQyYNR40EqDzxMpDtTZ9+xRjENp0HQtqjihKG5lbHhtsrafXVt1EeFFBBgP3piDGURIKz@nongnu.org
X-Gm-Message-State: AOJu0Yy3sX/LTTxqMeF1/IjqiuG+WOXeyO5+DjyrN7xaCP+2e9Qt2xy+
 JJvvRk1fXnRrXwdDWqw8D05iROOgFgOhVwP4e6xVDVxNL2U7sx7t8QXkbVK6zDnP+N//YfcXe1d
 cqHp6tb11VdXmNlI9Gc6W6k1UN6i8a+eLaIoDy489J+zhJrJAAEU5lOz5
X-Gm-Gg: ASbGncshu5BggWrOxVsethtGAMDrdokfoCGrMY0wFIbFcQld5bGtTpodf1rM2J2PRsy
 YqBm5eLTfEX22EUqSCEJOQ2LWjAAUINyTdbfJz4aRieJ1Zx1SeObggCfqWLU2Kz7onnZrt1afNI
 WyNLGbpwc4kXPG2MJqJL0ai/jlBg8uffuixndxct/VB+2QK+FPmXG54Cy9yNScNwDUqjHMrhCs3
 /Tr4vdqEH9gvTgCwAZEF9e4KFbrWINY3qi8n1ET7SbrI2ev7opAoT2RZDAqLyC5+fsmwnYO+Wyj
 LxpmVZOD1D5uwdXRRqmz6+xfkZlDJgD4
X-Received: by 2002:a05:600c:34d3:b0:441:b19c:96fe with SMTP id
 5b1f17b1804b1-44c91ad6cc6mr147728355e9.10.1748349098336; 
 Tue, 27 May 2025 05:31:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyyRVcCTsS68sRFvZDDfpE0OjxyO4FIfvawJhxuCbuLUOlHjkvsIN9f7lKZ8u1A3YMRFXrXg==
X-Received: by 2002:a05:600c:34d3:b0:441:b19c:96fe with SMTP id
 5b1f17b1804b1-44c91ad6cc6mr147727975e9.10.1748349097931; 
 Tue, 27 May 2025 05:31:37 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f1ef032esm273576215e9.9.2025.05.27.05.31.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 05:31:37 -0700 (PDT)
Date: Tue, 27 May 2025 14:31:35 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, gustavo.romero@linaro.org, anisinha@redhat.com,
 mst@redhat.com, shannon.zhaosl@gmail.com, pbonzini@redhat.com,
 Jonathan.Cameron@huawei.com, philmd@linaro.org, alex.bennee@linaro.org
Subject: Re: [PATCH v2 05/25] hw/pci-host/gpex-acpi: Split host bridge OSC
 and DSM generation
Message-ID: <20250527143135.33a96728@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250527074224.1197793-6-eric.auger@redhat.com>
References: <20250527074224.1197793-1-eric.auger@redhat.com>
 <20250527074224.1197793-6-eric.auger@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Tue, 27 May 2025 09:40:07 +0200
Eric Auger <eric.auger@redhat.com> wrote:

> acpi_dsdt_add_pci_osc() name is confusing as it gives the impression
> it appends the _OSC method but in fact it also appends the _DSM method
> for the host bridge. Let's split the function into two separate ones
> and let them return the method Aml pointer instead. This matches the
> way it is done on x86 (build_q35_osc_method). In a subsequent patch
> we will replace the gpex method by the q35 implementation that will
> become shared between ARM and x86.
> 
> acpi_dsdt_add_host_bridge_methods is a new top helper that generates
> both the _OSC and _DSM methods.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/pci-host/gpex-acpi.c | 31 +++++++++++++++++++++----------
>  1 file changed, 21 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/pci-host/gpex-acpi.c b/hw/pci-host/gpex-acpi.c
> index f34b7cf25e..1aa2d12026 100644
> --- a/hw/pci-host/gpex-acpi.c
> +++ b/hw/pci-host/gpex-acpi.c
> @@ -50,13 +50,10 @@ static void acpi_dsdt_add_pci_route_table(Aml *dev, uint32_t irq,
>      }
>  }
>  
> -static void acpi_dsdt_add_pci_osc(Aml *dev, bool enable_native_pcie_hotplug)
> +static Aml *build_host_bridge_osc(bool enable_native_pcie_hotplug)
>  {
> -    Aml *method, *UUID, *ifctx, *ifctx1, *elsectx, *buf;
> +    Aml *method, *UUID, *ifctx, *ifctx1, *elsectx;
>  
> -    /* Declare an _OSC (OS Control Handoff) method */
> -    aml_append(dev, aml_name_decl("SUPP", aml_int(0)));
> -    aml_append(dev, aml_name_decl("CTRL", aml_int(0)));
>      method = aml_method("_OSC", 4, AML_NOTSERIALIZED);
>      aml_append(method,
>          aml_create_dword_field(aml_arg(3), aml_int(0), "CDW1"));
> @@ -103,9 +100,13 @@ static void acpi_dsdt_add_pci_osc(Aml *dev, bool enable_native_pcie_hotplug)
>                                 aml_name("CDW1")));
>      aml_append(elsectx, aml_return(aml_arg(3)));
>      aml_append(method, elsectx);
> -    aml_append(dev, method);
> +    return method;
> +}
>  
> -    method = aml_method("_DSM", 4, AML_NOTSERIALIZED);
> +static Aml *build_host_bridge_dsm(void)
> +{
> +    Aml *method = aml_method("_DSM", 4, AML_NOTSERIALIZED);
> +    Aml *UUID, *ifctx, *ifctx1, *buf;
>  
>      /* PCI Firmware Specification 3.0
>       * 4.6.1. _DSM for PCI Express Slot Information
> @@ -124,7 +125,17 @@ static void acpi_dsdt_add_pci_osc(Aml *dev, bool enable_native_pcie_hotplug)
>      byte_list[0] = 0;
>      buf = aml_buffer(1, byte_list);
>      aml_append(method, aml_return(buf));
> -    aml_append(dev, method);
> +    return method;
> +}
> +
> +static void acpi_dsdt_add_host_bridge_methods(Aml *dev,
> +                                              bool enable_native_pcie_hotplug)
> +{
> +    aml_append(dev, aml_name_decl("SUPP", aml_int(0)));
> +    aml_append(dev, aml_name_decl("CTRL", aml_int(0)));
> +    /* Declare an _OSC (OS Control Handoff) method */
> +    aml_append(dev, build_host_bridge_osc(enable_native_pcie_hotplug));
> +    aml_append(dev, build_host_bridge_dsm());
>  }
>  
>  void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
> @@ -193,7 +204,7 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
>              if (is_cxl) {
>                  build_cxl_osc_method(dev);
>              } else {
> -                acpi_dsdt_add_pci_osc(dev, true);
> +                acpi_dsdt_add_host_bridge_methods(dev, true);
>              }
>  
>              aml_append(scope, dev);
> @@ -268,7 +279,7 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
>      }
>      aml_append(dev, aml_name_decl("_CRS", rbuf));
>  
> -    acpi_dsdt_add_pci_osc(dev, true);
> +    acpi_dsdt_add_host_bridge_methods(dev, true);
>  
>      Aml *dev_res0 = aml_device("%s", "RES0");
>      aml_append(dev_res0, aml_name_decl("_HID", aml_string("PNP0C02")));


