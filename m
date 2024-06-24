Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E58F9C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 13:18:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLjaU-00079o-Pa; Mon, 24 Jun 2024 09:18:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sLjaN-0006wm-1I
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 09:18:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sLjaJ-0005ri-SZ
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 09:18:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719235094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QNadneWrO33F1H3PKCnhpcnx7rnW9OzzOfuqmtKqd4s=;
 b=dujkF3JtkVBRTmtv0h0FPHa/n1J/MYosP+AbKMXaqFYLOcGd+yhUBZFEwTSjs8+ZMID/Sc
 YUo9CnRhi12VSEOTxN2rTdG5ZvJN1LA3g/mIuqF8MlHtGjJ2nLfQ8hCroBISYq+OdRHGcN
 Xi/mVBgvw7C+QULIiQr0uS20dl9YgFU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-51J9UgOKNgelty9v5p3RLg-1; Mon, 24 Jun 2024 09:18:12 -0400
X-MC-Unique: 51J9UgOKNgelty9v5p3RLg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4217a6a00d8so28677955e9.0
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 06:18:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719235091; x=1719839891;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QNadneWrO33F1H3PKCnhpcnx7rnW9OzzOfuqmtKqd4s=;
 b=TcRxWk/MNZ2THXL5emRcF7zFqb/86QQ2s769paRQWkNvF3q0Yf3RxNQvV0o2OM6g5j
 TUr6I62s++BN6u1RH4qE47mFYe1cDB+fgV3Cd07m6pwwi9bXQ3lUoTAKr7UsF168NjFL
 TulbYou1CrGy6k62mrK1frz9RT8uJza4cHUmnKx4dTkwNCWvY/n73XVQY2y0D3lfum+K
 b8X5lSv17h9/Gw+wtGWUjKqm9MO0HU8pMqN25B+7zJ71PFxYwgs8vbEPO92LPnVyNYjm
 AaEQkuAWhXlDETxne5BXotZINpvizcXgWZQ/GxQN3XqXvPkZSkdaxyPo67XyGBy3oLT5
 LXXQ==
X-Gm-Message-State: AOJu0YylwZt/Ic8npeVinPZ4GZlEwNTi5eaxvq/86eXjSUHHuz4CPyMo
 TsVPFuxNUaIE7NiBTB4F9xBP4KX8vxRVh6hrMxd/lRoqxVUEZbfJ44+mgveonOO1nrOhly8zFsk
 P9NPAFx6RN5le642WQCPM3tTfJPdZZmBdXIwzXd01ndRj+nQfYHAt
X-Received: by 2002:a05:600c:3b11:b0:422:fa63:33ff with SMTP id
 5b1f17b1804b1-42489e37068mr36948465e9.1.1719235091091; 
 Mon, 24 Jun 2024 06:18:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFO0RYk6XCP1fRwpx2jYYEAKSptTty1fk+pezEm1V4Wp+ShhfmFQ+WDoJ8I+NQqfvdTh98CUA==
X-Received: by 2002:a05:600c:3b11:b0:422:fa63:33ff with SMTP id
 5b1f17b1804b1-42489e37068mr36948145e9.1.1719235090332; 
 Mon, 24 Jun 2024 06:18:10 -0700 (PDT)
Received: from redhat.com ([2.52.146.100]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42481910f64sm137914555e9.34.2024.06.24.06.18.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 06:18:09 -0700 (PDT)
Date: Mon, 24 Jun 2024 09:18:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Shiyuan Gao <gaoshiyuan@baidu.com>
Cc: qemu-devel@nongnu.org, imammedo@redhat.com
Subject: Re: [PATCH 1/1] hw/i386/acpi-build: add OSHP method support for SHPC
 driver load
Message-ID: <20240624091745-mutt-send-email-mst@kernel.org>
References: <20240624131426.77231-1-gaoshiyuan@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624131426.77231-1-gaoshiyuan@baidu.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
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

On Mon, Jun 24, 2024 at 09:14:26PM +0800, Shiyuan Gao wrote:
> SHPC driver will be loaded fail in i440fx platform, the dmesg shows
> that OS cannot get control of SHPC hotplug and hotplug device to
> the PCI bridge will fail when we use SHPC Native type:
> 
>   [3.336059] shpchp 0000:00:03.0: Requesting control of SHPC hotplug via OSHP (\_SB_.PCI0.S28_)
>   [3.337408] shpchp 0000:00:03.0: Requesting control of SHPC hotplug via OSHP (\_SB_.PCI0)
>   [3.338710] shpchp 0000:00:03.0: Cannot get control of SHPC hotplug
> 
> Add OSHP method support for SHPC driver load, the hotplug device to the PCI bridge will
> success when we use SHPC Native type.
> 
>   [1.703975] shpchp 0000:00:03.0: Requesting control of SHPC hotplug via OSHP (\_SB_.PCI0.S18_)
>   [1.704934] shpchp 0000:00:03.0: Requesting control of SHPC hotplug via OSHP (\_SB_.PCI0)
>   [1.705855] shpchp 0000:00:03.0: Gained control of SHPC hotplug (\_SB_.PCI0)
>   [1.707054] shpchp 0000:00:03.0: HPC vendor_id 1b36 device_id 1 ss_vid 0 ss_did 0
> 
> According to the acpi_pcihp, the OSHP method don't need parameter and return value now.
> 
>   shpc_probe
>     --> acpi_get_hp_hw_control_from_firmware
>       --> acpi_run_oshp
>         --> status = acpi_evaluate_object(handle, METHOD_NAME_OSHP, NULL, NULL);
> 
> Signed-off-by: Shiyuan Gao <gaoshiyuan@baidu.com>
> ---
>  hw/i386/acpi-build.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index f4e366f64f..79622e6939 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1412,6 +1412,18 @@ static void build_acpi0017(Aml *table)
>      aml_append(table, scope);
>  }
>  
> +static Aml *build_oshp_method(void)
> +{
> +    Aml *method;
> +
> +    /*
> +     * Request control of SHPC hotplug via OSHP method,
> +     * no need parameter and return value in acpi_pcihp.
> +     */

Quote spec and earliest version documenting this, please.


> +    method = aml_method("OSHP", 0, AML_NOTSERIALIZED);
> +    return method;
> +}
> +
>  static void
>  build_dsdt(GArray *table_data, BIOSLinker *linker,
>             AcpiPmInfo *pm, AcpiMiscInfo *misc,
> @@ -1452,6 +1464,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>          aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A03")));
>          aml_append(dev, aml_name_decl("_UID", aml_int(pcmc->pci_root_uid)));
>          aml_append(dev, aml_pci_edsm());
> +        aml_append(dev, build_oshp_method());
>          aml_append(sb_scope, dev);
>          aml_append(dsdt, sb_scope);
>  
> @@ -1586,6 +1599,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>                  aml_append(dev, build_q35_osc_method(true));
>              } else {
>                  aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A03")));
> +                aml_append(dev, build_oshp_method());
>              }
>  
>              if (numa_node != NUMA_NODE_UNASSIGNED) {
> -- 
> 2.27.0


