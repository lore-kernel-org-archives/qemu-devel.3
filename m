Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C17C2C3064D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 13:47:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMpS3-0005TU-K9; Thu, 27 Jun 2024 09:46:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sMpRp-0005R7-LN
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 09:46:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sMpRk-0000HA-SS
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 09:46:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719495955;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oDoTEGLBYOeYliJMueazKuemGf4R1qHdni1KwR4A890=;
 b=Amc5UKaerDfmYOsCQh+CqZXUY+wYB2a73bE/e7e39d8JhOzgFz1Cn1kii4MsQZfjDsQ7K7
 HAkPd7Nmf5PhoJdzQSi37wLEaD6uLVwUh/IVuW53iDr5AdNQj+zbJuSzKxBdfhDbLUSGY2
 pz3W0I5I0LaxOWsNHOWJk5jyYPf7ZbQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-l_DKuTQ4MNmX4YwsB4GjWg-1; Thu, 27 Jun 2024 09:45:51 -0400
X-MC-Unique: l_DKuTQ4MNmX4YwsB4GjWg-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3643d0e3831so5285168f8f.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 06:45:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719495950; x=1720100750;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oDoTEGLBYOeYliJMueazKuemGf4R1qHdni1KwR4A890=;
 b=jOqbSCLCVddBTG216zdggi0V4gAdZiRK10h4vFrSSXvfS3CdF00UqM0U9jqOHpdUIr
 I45JfKTWjgg8oxXPjwvwwNiaT04bpQIwgm0IoE+j3UBbijaOiCeB5uRhgXWYZBFF1g9R
 tUJ6VRQlsQOnBOaeY+VivETtUiAkFzsY38FBgybO3XpKNZ0cg03u0df2F7Dmz6OYItFb
 fRrlhRDWkdm5Acs2TqXaVtbZA/cN0CHYdskfPgUsffq2kPTWYAti29H3XQnsVqMIRA07
 yCUu8PiAlVjqPNpd+5uMzQBiLq2jrpb/Yc4jrgRgRO5fCdaal1vSmvCj2caNdbhutscB
 7Ogw==
X-Gm-Message-State: AOJu0Yx+4c1kLr2OAd2DhmYSqQgKAbpNuMerFsZWgU67Je4TPcfxDmT4
 r5aScTO5dsPbWLKND28G65W4yChhaKXjFN1NWviJts6VvKkuSaF8aAn7K23RQsWi4RXm8cZzMtX
 ot633lYvqqMbWgB6M2icX+q3jBYECTPdN9IZURMXbFqdkO6jjb2HtW0UjKnMt
X-Received: by 2002:a5d:640a:0:b0:360:791c:aff2 with SMTP id
 ffacd0b85a97d-366e95dc73emr8569578f8f.47.1719495950160; 
 Thu, 27 Jun 2024 06:45:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKYZWklZztbRMWLZSFQ+hiVpyB0tieSxMnaMy9YkJY76qCCmpplwf1/6nr7t/ZZsy3UYVyEQ==
X-Received: by 2002:a5d:640a:0:b0:360:791c:aff2 with SMTP id
 ffacd0b85a97d-366e95dc73emr8569568f8f.47.1719495949802; 
 Thu, 27 Jun 2024 06:45:49 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3674357fed2sm1931180f8f.48.2024.06.27.06.45.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 06:45:49 -0700 (PDT)
Date: Thu, 27 Jun 2024 15:45:48 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Shiyuan Gao <gaoshiyuan@baidu.com>
Cc: <qemu-devel@nongnu.org>, <mst@redhat.com>
Subject: Re: [v2 1/1] hw/i386/acpi-build: add OSHP method support for SHPC
 driver load
Message-ID: <20240627154548.74a969c2@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240625035224.13019-1-gaoshiyuan@baidu.com>
References: <20240625035224.13019-1-gaoshiyuan@baidu.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.212,
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

On Tue, 25 Jun 2024 11:52:24 +0800
Shiyuan Gao <gaoshiyuan@baidu.com> wrote:

> SHPC driver will be loaded fail in i440fx machine, the dmesg shows
> that OS cannot get control of SHPC hotplug and hotplug device to
> the PCI bridge will fail when we use SHPC Native type:
> 
>   [3.336059] shpchp 0000:00:03.0: Requesting control of SHPC hotplug via OSHP (\_SB_.PCI0.S28_)
>   [3.337408] shpchp 0000:00:03.0: Requesting control of SHPC hotplug via OSHP (\_SB_.PCI0)
>   [3.338710] shpchp 0000:00:03.0: Cannot get control of SHPC hotplug
> 
> Add OSHP method support for transfer control to the operating system,
> after this SHPC driver will be loaded success and the hotplug device to
> the PCI bridge will success when we use SHPC Native type.
> 
>   [1.703975] shpchp 0000:00:03.0: Requesting control of SHPC hotplug via OSHP (\_SB_.PCI0.S18_)
>   [1.704934] shpchp 0000:00:03.0: Requesting control of SHPC hotplug via OSHP (\_SB_.PCI0)
>   [1.705855] shpchp 0000:00:03.0: Gained control of SHPC hotplug (\_SB_.PCI0)
>   [1.707054] shpchp 0000:00:03.0: HPC vendor_id 1b36 device_id 1 ss_vid 0 ss_did 0

please describe in commit message reproducer
(aka QEMU CLI and guest OS and if necessary other details)


> Signed-off-by: Shiyuan Gao <gaoshiyuan@baidu.com>
> ---
> v1 -> v2:
> * add quote PCI firmware spec 3.0
> * explain why an empty method is enough
> ---
> 
>  hw/i386/acpi-build.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index f4e366f64f..00f8abedf6 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1412,6 +1412,23 @@ static void build_acpi0017(Aml *table)
>      aml_append(table, scope);
>  }
>  
> +/*
> + * PCI Firmware Specification 3.0
> + * 4.8. The OSHP Control Method
> + */
> +static Aml *build_oshp_method(void)
> +{
> +    Aml *method;
> +
> +    /*
> +     * We don't use ACPI to control the SHPC, so just return
> +     * success is enough.
> +     */
> +    method = aml_method("OSHP", 0, AML_NOTSERIALIZED);
> +    aml_append(method, aml_return(aml_int(0x0)));
> +    return method;
> +}
> +
>  static void
>  build_dsdt(GArray *table_data, BIOSLinker *linker,
>             AcpiPmInfo *pm, AcpiMiscInfo *misc,
> @@ -1452,6 +1469,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>          aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A03")));
>          aml_append(dev, aml_name_decl("_UID", aml_int(pcmc->pci_root_uid)));
>          aml_append(dev, aml_pci_edsm());
> +        aml_append(dev, build_oshp_method());

it's global and what will happen if we have ACPI PCI hotplug enabled
and guest calls this NOP method?

>          aml_append(sb_scope, dev);
>          aml_append(dsdt, sb_scope);
>  
> @@ -1586,6 +1604,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>                  aml_append(dev, build_q35_osc_method(true));
>              } else {
>                  aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A03")));
> +                aml_append(dev, build_oshp_method());
>              }
>  
>              if (numa_node != NUMA_NODE_UNASSIGNED) {


