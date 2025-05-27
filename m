Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAF20C54F30
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 13:10:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJu4K-0000VH-HX; Tue, 27 May 2025 09:10:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uJu4J-0000UN-70
 for qemu-devel@nongnu.org; Tue, 27 May 2025 09:10:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uJu4C-0005vE-LK
 for qemu-devel@nongnu.org; Tue, 27 May 2025 09:10:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748351399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6SORohSuXJ/bg9jDlHgEDEDaVO+N78BynoBi5RubMzc=;
 b=K6KMRxtJOw7K0HZ0OmJ7vaBwghPqTBbg+ig7GmGdlGHrQIFuy3T8e7kStVNEPARWcjVEiB
 HUdBoU+KKaHzFw1F/Ew9vAvYtBYi4yeWyjfAt7prQwLn+AjF+A+G6GOx4+U8o4QnlWJjHC
 5PwQePvCf67FmIdrFGtjqtUXquH9AsM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-If-VlaO_NAKF7OtPkY4R-w-1; Tue, 27 May 2025 09:09:57 -0400
X-MC-Unique: If-VlaO_NAKF7OtPkY4R-w-1
X-Mimecast-MFC-AGG-ID: If-VlaO_NAKF7OtPkY4R-w_1748351396
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a4d5e1af1fso1027777f8f.1
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 06:09:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748351396; x=1748956196;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6SORohSuXJ/bg9jDlHgEDEDaVO+N78BynoBi5RubMzc=;
 b=SnYyUJH6UAdJUSIcw5dIJtcFPRfERejPmbWBnlCCwJs+OLgNEKTFXUYlISXFBx5LtS
 AvdlU6BaagUDvtj0scxfB4Xfcpo5/oVJdUb/Ion20nH8oJ/DaBDY23EF8wyR4G6ahKZg
 CCOri9YUCOUs4D1xITZ0g58fkpHxCLNPSMfOtH9gW6u+hnxONoIMPBOYMkUdZ1lQCpwK
 +MGsqkTJaoXeNWNgeqLCrzZ/LcdIZQGMnKQMoiNi+ibVqy9XTs4fbGeL4twh7HnxZxMh
 KBe80YnGit11lZNNv9/uigePyZmQYtMCnCAqoh5S07qz6xabT6hA/HCjgSAkdr4y2nPh
 fJug==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnljWLrJBkFJHuYUiraDS8P5JUxQwRmJxNCxbUEyvjqG8rhqQkSoPveZZSupTBCfedmozPknJItgkf@nongnu.org
X-Gm-Message-State: AOJu0Yw56I7FOPZE+CBE4XHwDEaP13QeVmHJvWPxme6O7o3qMytp1L9x
 gduVFplZWeCoPYkSDtcJ8IbnbaUwOX7RJsBmY+PtxR8KKUzwEBwU6vaXMHdBIS6pYt6Iz8kL5OF
 xuWCpHvEtEDS7a/IDhje6ui0SIojMI/AY+Gxr1bXmsKmb2j9kIyf9DEPJ
X-Gm-Gg: ASbGncufqAPMPG5N/O+GXNSTHJmS4t3fNdgagtQfXk3nYRRfOmHcvOuqCX2ZsbfZvzy
 MxtONLUyS/aq15fkiYrq0pzOC9TgOMeyQFhMWxMygznqVUA4QQ3Ot7tDzrN/J0D7Z63F4wJlsfK
 DdriQSKBbSYfQ+KV8woGqUCq1E1f4mK1ySCB0zIyAyWOWBw7bthSuQLYNRsbwXzeQGMg+S+0frL
 xg6W6mCoT8ET34R7iYWtk2DCwVS7MvvyhPY9qXFA5mpNW4Qvw8dsVaj24sQ8tw+6eIisTH33Jjk
 S5UDeHD1YRW9+O+KbWzgndnr6vb8dn/l
X-Received: by 2002:a05:6000:1789:b0:3a4:d719:5be0 with SMTP id
 ffacd0b85a97d-3a4e5e37ff3mr551664f8f.2.1748351396041; 
 Tue, 27 May 2025 06:09:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWq7rVI2cFlbo/+bR32Abg8J3i2GKmSm2ctEVCLIaLs18RYDn3DV6maRATQqr4jGibyjLUZA==
X-Received: by 2002:a05:6000:1789:b0:3a4:d719:5be0 with SMTP id
 ffacd0b85a97d-3a4e5e37ff3mr551621f8f.2.1748351395614; 
 Tue, 27 May 2025 06:09:55 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4d2a7a317sm8217352f8f.24.2025.05.27.06.09.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 06:09:55 -0700 (PDT)
Date: Tue, 27 May 2025 15:09:54 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, gustavo.romero@linaro.org, anisinha@redhat.com,
 mst@redhat.com, shannon.zhaosl@gmail.com, pbonzini@redhat.com,
 Jonathan.Cameron@huawei.com, philmd@linaro.org, alex.bennee@linaro.org
Subject: Re: [PATCH v2 11/25] hw/i386/acpi-build: Introduce
 build_append_pcihp_resources() helper
Message-ID: <20250527150954.13d08fa9@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250527074224.1197793-12-eric.auger@redhat.com>
References: <20250527074224.1197793-1-eric.auger@redhat.com>
 <20250527074224.1197793-12-eric.auger@redhat.com>
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

On Tue, 27 May 2025 09:40:13 +0200
Eric Auger <eric.auger@redhat.com> wrote:

> Extract the code that reserves resources for ACPI PCI hotplug
> into a new helper named build_append_pcihp_resources() and
> move it to pcihp.c. We will reuse it on ARM.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>


> ---
>  include/hw/acpi/pcihp.h |  2 ++
>  hw/acpi/pcihp.c         | 20 ++++++++++++++++++++
>  hw/i386/acpi-build.c    | 15 ++-------------
>  3 files changed, 24 insertions(+), 13 deletions(-)
> 
> diff --git a/include/hw/acpi/pcihp.h b/include/hw/acpi/pcihp.h
> index 971451e8ea..8a46a414cc 100644
> --- a/include/hw/acpi/pcihp.h
> +++ b/include/hw/acpi/pcihp.h
> @@ -75,6 +75,8 @@ void acpi_pcihp_device_unplug_request_cb(HotplugHandler *hotplug_dev,
>  
>  void build_acpi_pci_hotplug(Aml *table, uint64_t pcihp_addr);
>  void build_append_pci_dsm_func0_common(Aml *ctx, Aml *retvar);
> +void build_append_pcihp_resources(Aml *table,
> +                                  uint64_t io_addr, uint64_t io_len);
>  
>  /* Called on reset */
>  void acpi_pcihp_reset(AcpiPciHpState *s);
> diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
> index e0260f67e6..fb54c31f77 100644
> --- a/hw/acpi/pcihp.c
> +++ b/hw/acpi/pcihp.c
> @@ -685,6 +685,26 @@ void build_acpi_pci_hotplug(Aml *table, uint64_t pcihp_addr)
>      aml_append(table, scope);
>  }
>  
> +/* Reserve PCIHP resources */
> +void build_append_pcihp_resources(Aml *scope /* \\_SB.PCI0 */,
> +                                  uint64_t io_addr, uint64_t io_len)
> +{
> +    Aml *dev, *crs;
> +
> +    dev = aml_device("PHPR");
> +    aml_append(dev, aml_name_decl("_HID", aml_string("PNP0A06")));
> +    aml_append(dev,
> +               aml_name_decl("_UID", aml_string("PCI Hotplug resources")));
> +    /* device present, functioning, decoding, not shown in UI */
> +    aml_append(dev, aml_name_decl("_STA", aml_int(0xB)));
> +    crs = aml_resource_template();
> +    aml_append(crs,
> +        aml_io(AML_DECODE16, io_addr, io_addr, 1, io_len)
> +    );
> +    aml_append(dev, aml_name_decl("_CRS", crs));
> +    aml_append(scope, dev);
> +}
> +
>  const VMStateDescription vmstate_acpi_pcihp_pci_status = {
>      .name = "acpi_pcihp_pci_status",
>      .version_id = 1,
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 91945f716c..52cef834ed 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1432,19 +1432,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>  
>      /* reserve PCIHP resources */
>      if (pm->pcihp_io_len && (pm->pcihp_bridge_en || pm->pcihp_root_en)) {
> -        dev = aml_device("PHPR");
> -        aml_append(dev, aml_name_decl("_HID", aml_string("PNP0A06")));
> -        aml_append(dev,
> -            aml_name_decl("_UID", aml_string("PCI Hotplug resources")));
> -        /* device present, functioning, decoding, not shown in UI */
> -        aml_append(dev, aml_name_decl("_STA", aml_int(0xB)));
> -        crs = aml_resource_template();
> -        aml_append(crs,
> -            aml_io(AML_DECODE16, pm->pcihp_io_base, pm->pcihp_io_base, 1,
> -                   pm->pcihp_io_len)
> -        );
> -        aml_append(dev, aml_name_decl("_CRS", crs));
> -        aml_append(scope, dev);
> +        build_append_pcihp_resources(scope,
> +                                      pm->pcihp_io_base, pm->pcihp_io_len);
>      }
>      aml_append(dsdt, scope);
>  


