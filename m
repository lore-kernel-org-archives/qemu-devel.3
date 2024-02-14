Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA70FC4829F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 06:50:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ra95k-0005YM-OT; Wed, 14 Feb 2024 01:50:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ra95h-0005UG-9P
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 01:49:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ra95g-0003lT-1G
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 01:49:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707893395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=k6EBsbajUmDhBEE95oe4vK7VdLZzWXa9YWqUbOfjtsE=;
 b=QCBRRrD7KId7FiKuxDdEzZGx8piGsmvJZ1TosrpZihfZ+yQhzMueuWaj+Yc2osNxJc1rTj
 QK/oBIwYR1NrB4ZraZEtcySj98RO7jUnq36+pdaqG8hAwrDsCi71ZbCQ3/hmkmolZ6kr0N
 fHrPUB7hIiED5s/1x4yBd26AzQ2ghtw=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-aO7ZA1k0OfOM5V4qgT5VuQ-1; Wed, 14 Feb 2024 01:49:52 -0500
X-MC-Unique: aO7ZA1k0OfOM5V4qgT5VuQ-1
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-2196b4d291bso8020539fac.0
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 22:49:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707893392; x=1708498192;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k6EBsbajUmDhBEE95oe4vK7VdLZzWXa9YWqUbOfjtsE=;
 b=LStFq5eAEa3ca94cMjBZSeYwr96XpkoxbdTswNF14fjZ05L/25Rfdvq+K5ubfvfXRe
 qMsm2p/4Ft9i3PbcymI8KfDZ0M66pfN+SzJDeinAeyAT8hBwgrChH9eqpl3QFYTeq7+D
 clKp8hVwDG1htsvPVs3RAriIcv1XLo0zVW35k6ILWx0ol52yGXjSgWTTkm1WqOTOtol/
 YRG0q/WVrm2CCIK7kkbVA54QBNX7kXmeFSymNMPO2AwW9qtr5LM8mkjHalReoPIloyT/
 taJm5fcSsFZmbae2/jksochOPZ9CZ06N0aDrMVRevqz2jh0wcPBRV2B+fV0rSX2xcm9Q
 Z8Eg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSnakVv0OiaMEOfTFUKuE4rUWK1MEw2HMnWWZoC6WyTOJyJFl/bhZR3LeRsh8qfeS6LxKSDIk9hhKEItXUd2joVMHV0+Q=
X-Gm-Message-State: AOJu0YyLUvGslIOoTRpKfqtHJ5JziSdT7aRz0d8oYZ63atyAA6QuvXbd
 /ryaRxY4u6b/QWMgqabjZrs2vXXDCieao8nwo21U1SLIkNVdIAcgEwyN86O6+uRWhnUFKKRbMJt
 GrX3JqbxOdyeEycH9nJeIfcbFQdUVAN99MvukHZOD7OAjC1z8NiL7
X-Received: by 2002:a05:6871:7825:b0:219:f170:77f with SMTP id
 oy37-20020a056871782500b00219f170077fmr1963961oac.47.1707893392240; 
 Tue, 13 Feb 2024 22:49:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH+tQ6IlcF2X2IeRvcAIkT7FWvZKO9+M19GaoD6gXjWLA1s+2SMk6PZRHubepod4E2eaq/h2A==
X-Received: by 2002:a05:6871:7825:b0:219:f170:77f with SMTP id
 oy37-20020a056871782500b00219f170077fmr1963944oac.47.1707893391883; 
 Tue, 13 Feb 2024 22:49:51 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUqj1+EkppxCM0JE4cghJ3JzFovGO+8Z93YlNdiKnj0nQenT3umCXrB9tGBfLarSfwE4Taob/KVETc5ifXpbnK5bFX5UeqqCUChS2RBZoWYyOC/CJ7kE89lEQLMWS3/ebSM1rYH8vGHHGw1D5v53xQP20coNTpmG/aW4qxs2nCGnOkY/gM2jtr/6X1h0faKmSgrMu2e8dUkFSbVq+teY+h5dhEQ8RtuoF/UIRbxJ9gl6DTqLsm77Bfki4dtSjsciFowe3O4m7a1vMrsWdYDUlt+EAWVX9wo38QpRPfJETpIjMky6zkr7nCZbpw680PcKSpV6GDuZu+tvnUyw3Mvm71wCItzAVSEsbDWowsmanQ7jpK+OYjgBfvaIFvb/fRxC1eJ0bwMPPfJFxv3OHXtlb2GLdYTw6t9YXi7Yg==
Received: from redhat.com ([2.52.26.67]) by smtp.gmail.com with ESMTPSA id
 hz10-20020a05687153ca00b0021a714d556asm1035808oac.41.2024.02.13.22.49.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 22:49:50 -0800 (PST)
Date: Wed, 14 Feb 2024 01:49:43 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Subject: Re: [PATCH v4 2/9] hw/pci: Determine if rombar is explicitly enabled
Message-ID: <20240214014345-mutt-send-email-mst@kernel.org>
References: <20240214-reuse-v4-0-89ad093a07f4@daynix.com>
 <20240214-reuse-v4-2-89ad093a07f4@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214-reuse-v4-2-89ad093a07f4@daynix.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.504,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_SORBS_WEB=1.5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Wed, Feb 14, 2024 at 02:13:40PM +0900, Akihiko Odaki wrote:
> vfio determines if rombar is explicitly enabled by inspecting QDict.
> Inspecting QDict is not nice because QDict is untyped and depends on the
> details on the external interface. Add an infrastructure to determine if
> rombar is explicitly enabled to hw/pci.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

I frankly don't know what the issue with using qdict is.
Alex do you want to switch?

> ---
>  include/hw/pci/pci_device.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
> index d3dd0f64b273..54fa0676abf1 100644
> --- a/include/hw/pci/pci_device.h
> +++ b/include/hw/pci/pci_device.h
> @@ -205,6 +205,11 @@ static inline uint16_t pci_get_bdf(PCIDevice *dev)
>      return PCI_BUILD_BDF(pci_bus_num(pci_get_bus(dev)), dev->devfn);
>  }
>  
> +static inline bool pci_rom_bar_explicitly_enabled(PCIDevice *dev)
> +{
> +    return dev->rom_bar && dev->rom_bar != -1;
> +}
> +
>  uint16_t pci_requester_id(PCIDevice *dev);
>  
>  /* DMA access functions */
> 
> -- 
> 2.43.0


