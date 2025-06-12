Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99F90C71136
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 13:26:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPhwG-0006jI-IS; Thu, 12 Jun 2025 09:25:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uPhw8-0006g8-TZ
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 09:25:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uPhw5-0006ra-T9
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 09:25:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749734739;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zDyhqaDEF4FCd/hQmc+D77zq2ZaFHqRDVzl9hrHfjLY=;
 b=NJDIJ+YRimLd+6HmFbfyxcafe+UskQA4ue5BO9GIrewZI1Cc32MK/8i6ULhnnRwL+TACW4
 pAOtWfaS47lhYEsSY2LxCQg4W8yjarFVoG8NGXa7xJWvWeXX7clqxd4kuL9V0r2VppkCth
 pCo1GsGOyOaeAX57qj9vhclFr8xe9lw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-wLNB1jTMMHO_ZcxDtNYsvw-1; Thu, 12 Jun 2025 09:25:36 -0400
X-MC-Unique: wLNB1jTMMHO_ZcxDtNYsvw-1
X-Mimecast-MFC-AGG-ID: wLNB1jTMMHO_ZcxDtNYsvw_1749734735
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4532514dee8so8896605e9.0
 for <qemu-devel@nongnu.org>; Thu, 12 Jun 2025 06:25:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749734735; x=1750339535;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zDyhqaDEF4FCd/hQmc+D77zq2ZaFHqRDVzl9hrHfjLY=;
 b=LSMi6EGHdCHxHWGyv1kZs70qaftXvNoUreUjTMpQ2aa8+n8okPr+MsNsUpNuM87R4E
 s+Xy9AedirJiLjkqpm/AiulMmxe+dnF5S17yEDlEjtPO71CBtV6ljDpN+C81cdRNgGR/
 OSFeMsrLUANNjJ6XnRPz74xZmQIZ0K7Ad2XBQDA5PFCamAXWek9klu3YAzMuoOxYJ1ks
 B6XQ7SKY2fBFw9XQP7lAeQxcbQIGkAYbOi6ZIsr67yt195lMqu9h2LeW8MF6v2wQbDPt
 J7KuiEnLkyNUSB/xl39cmh1ZAQD6UbM0ygyfng+w9tqVA4WaW1yTtLCTxifnFb5lZQP7
 fUjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUg+cuIwF44KAonbAcXFCCmay5pCidGkrhEMkh+a5E55R36xMRs2HFkZflPcT7K06BARTo3v8PLnLCy@nongnu.org
X-Gm-Message-State: AOJu0YyH5r7Es8fqwEripaomPhlc9aQpevN3uKixyiVX795gMrMBLX2E
 xjre/+oP9fGr7wj2hHjW4JdDBvPDJRVpeWa8wnnsUhBn1ibiwbp3UA9CLzMqxBYoH+ps+CWLxol
 vXzDFCH27M/cNtgSG/U8bUPn20lUGt5ws52dEY22nNvA7GpXGWiBi/4VS
X-Gm-Gg: ASbGncviyBRsl2vl33ekc1T819ES+9Wk4msKY42fh3fHVz8cqiopDN5yc7BNTIQEaNT
 95ZF7JNQJ1vo18IsA6M+PfZiAnwTY/1ETCU5Y20hQ0bQmAWoIFNdxXxgNsxRV9J2ShfBSwsqzrr
 OHvVCG6t66sy4HBZm6Fd/tgGULuUpJ8ZI1n7GlyIp/gION7k1VAzsdFq3/lBuIHVulhjxai7zCh
 s95b0porAX9Y2bVW+l4oyT63N9nEkVuBQHh8eQMbn4Y6XXyIUXDPjKGIsMQ0fGHTmNaTYnufWh9
 W6Wpzmc3cjUYrcIu9ihakkLlhKbl0hgnJtSdlwddwvw=
X-Received: by 2002:a05:600c:a49:b0:450:d614:cb with SMTP id
 5b1f17b1804b1-453248e2952mr66081645e9.33.1749734735470; 
 Thu, 12 Jun 2025 06:25:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZDy+X0MhgYxWXE6yADHYuWZ4xeORRRmzsowt1Pwkvg8s0SRlueIVeHA87M6rj0q7SvOiFDQ==
X-Received: by 2002:a05:600c:a49:b0:450:d614:cb with SMTP id
 5b1f17b1804b1-453248e2952mr66081375e9.33.1749734734976; 
 Thu, 12 Jun 2025 06:25:34 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a561b4bb0bsm1953501f8f.77.2025.06.12.06.25.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Jun 2025 06:25:34 -0700 (PDT)
Date: Thu, 12 Jun 2025 15:25:33 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, gustavo.romero@linaro.org, anisinha@redhat.com,
 mst@redhat.com, shannon.zhaosl@gmail.com, pbonzini@redhat.com,
 Jonathan.Cameron@huawei.com, philmd@linaro.org, alex.bennee@linaro.org
Subject: Re: [PATCH v2 06/25] hw/pci-host/gpex-acpi: Propagate hotplug type
 info from virt machine downto gpex
Message-ID: <20250612152533.49fa5ab5@imammedo.users.ipa.redhat.com>
In-Reply-To: <72c84565-3879-4c08-a73c-15bc5543ee2b@redhat.com>
References: <20250527074224.1197793-1-eric.auger@redhat.com>
 <20250527074224.1197793-7-eric.auger@redhat.com>
 <20250527143301.77f5bfd1@imammedo.users.ipa.redhat.com>
 <72c84565-3879-4c08-a73c-15bc5543ee2b@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, 11 Jun 2025 11:00:02 +0200
Eric Auger <eric.auger@redhat.com> wrote:

> Hi Igor,
> 
> On 5/27/25 2:33 PM, Igor Mammedov wrote:
> > On Tue, 27 May 2025 09:40:08 +0200
> > Eric Auger <eric.auger@redhat.com> wrote:
> >  
> >> Propagate the type of pci hotplug mode downto the gpex
> >> acpi code. In case machine acpi_pcihp is unset we configure
> >> pci native hotplug on pci0. For expander bridges we keep
> >> legacy pci native hotplug, as done on x86 q35.  
> > this is not needed if done as suggested in 2/25  
> So since the property would be applied to the GED device we will still
> need a patch that retrieves the GED setting and propagate it to the GPEX
> device.

I don't see a need for propagating it to GPEX device itself for ACPI sake.

For ACPI code, what we do in q35 case is fetching
pm->pcihp_bridge_en from acpi_dev(whatever it is) and then
passing it down trough call-chain

  build_dsdt->build_q35_osc_method

the only hack that touches GPEX device model, is the need to
wire up root bus to GED, when GED is being created.
So that GED would be able to swap hotplug handler on
an acpi specific one when configured to do so.


> Thanks
> 
> Eric
> >  
> >> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> >> Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
[...]
> >> @@ -279,7 +280,7 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
> >>      }
> >>      aml_append(dev, aml_name_decl("_CRS", rbuf));
> >>  
> >> -    acpi_dsdt_add_host_bridge_methods(dev, true);
> >> +    acpi_dsdt_add_host_bridge_methods(dev, cfg->pci_native_hotplug);

also, having sufficiently forgotten this series context.
It might be better to abandon idea of consolidating osc and dsm methods
in acpi_dsdt_add_host_bridge_methods().

Just looking at above is confusing and forces one to re-rear previous
commits to figure out what acpi_dsdt_add_host_bridge_methods() is doing.

having here separate sequence of
  add_osc()
  add_dsm()
would be much more readable.
Lets drop acpi_dsdt_add_host_bridge_methods() helper.

> >>  
> >>      Aml *dev_res0 = aml_device("%s", "RES0");
> >>      aml_append(dev_res0, aml_name_decl("_HID", aml_string("PNP0C02")));  
> >  
> 


