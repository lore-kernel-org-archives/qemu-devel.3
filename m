Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D10FDC54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 16:50:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk5KE-0006UM-MF; Tue, 12 Mar 2024 12:50:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rk5K8-0006RN-PG
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 12:49:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rk5K7-00060O-97
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 12:49:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710262194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OBrUc9CSjuXZlhAeYSidqucYNOwWcfcqUYSZYyb2E94=;
 b=XlefbBfjaB3C7RiK5NtTcjneGV8kCDNoPnErf+hKjiGOfl/AeI6rrbSSXy5yg2djxiQ07/
 vXGYKIadQSHFM47LhuanKWgi0uISW2fKx0mLUg0vKDdMnorEYAl062euKqIupoxc1U8hp3
 wKRqOdWgWlrDb7wOiQW1OV4na8bogFU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-1rR_YwdHNseAg8rkja_xfg-1; Tue, 12 Mar 2024 12:49:53 -0400
X-MC-Unique: 1rR_YwdHNseAg8rkja_xfg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-413185181f6so22335725e9.3
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 09:49:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710262173; x=1710866973;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OBrUc9CSjuXZlhAeYSidqucYNOwWcfcqUYSZYyb2E94=;
 b=W4MCil4DS0FX1pFyiP1AUd622PETrQ9IR/Ve2onUeRMN/NwVq6EXsSjn0b1iA5ihGT
 i/Wlv68cLswmw4+3/yKaUqw8W8IHS9YZV/B6yaOmEV+hC8OLbw2PB2TlUVb9wY7rJWpT
 W8yAq8ffcj9krfMnoIBm1FSDHITgg7NqqTL4NKnSKKTR+h/rZ/sD8W+AbeQ24npMMq8O
 0rk+D1bK3E2mjAoc//GVvgar5wP1BLAZaDyl9+shpBhtBjT3UwSfVIuPTQ1ZbltvoUO/
 pwLVNDYjJ0LXt03vRaCNwtu0mngcxCLYXvtJt4z8AW/mEL0W0/y2I1mmxbpgLToOu5Y5
 xs5w==
X-Gm-Message-State: AOJu0YxD7QDVzThKOKWpA5IiHZCatUNEJAoqF25I2tVIYmYl9GcSQhXi
 iWTO2CIcmkm2YI2Lp258uZ7zMc5WJDP2yjNQJroXyaa6SgW9ozRU5HH5IuV0DmlJtcGgTRLX67J
 ZwYlJHN7Sh0w0F3A2zQp9btrwVcQ50xxKvBvfHNg2xJ94w2gYOlCc
X-Received: by 2002:a05:600c:4709:b0:412:8fef:7f with SMTP id
 v9-20020a05600c470900b004128fef007fmr8458898wmo.1.1710262172632; 
 Tue, 12 Mar 2024 09:49:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQenJKObtjUcq65acCzRYcz1IkbD8b24K9+4XiPEtqPMr1rMXE/JbnGZOBAxIpeDBb4HmFcA==
X-Received: by 2002:a05:600c:4709:b0:412:8fef:7f with SMTP id
 v9-20020a05600c470900b004128fef007fmr8458875wmo.1.1710262172042; 
 Tue, 12 Mar 2024 09:49:32 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f0:532c:5ae4:fce6:76e1:fa1a])
 by smtp.gmail.com with ESMTPSA id
 r13-20020adff10d000000b0033b278cf5fesm9380752wro.102.2024.03.12.09.49.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 09:49:31 -0700 (PDT)
Date: Tue, 12 Mar 2024 12:49:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Bernhard Beschow <shentey@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Ani Sinha <anisinha@redhat.com>, qemu-block@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, John Snow <jsnow@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH v2 00/15] hw/southbridge: Extract ICH9 QOM container model
Message-ID: <20240312124845-mutt-send-email-mst@kernel.org>
References: <20240226111416.39217-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240226111416.39217-1-philmd@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, Feb 26, 2024 at 12:13:59PM +0100, Philippe Mathieu-Daudé wrote:
> Since v1 [1]:
> - Rebased on top of Bernhard patches
> - Rename files with 'ich9_' prefix (Bernhard)
> 
> Hi,
> 
> I have a long standing southbridge QOM rework branches. Since
> Bernhard is actively working on the PIIX, I'll try to refresh
> and post. This is also motivated by the Dynamic Machine work
> where we are trying to figure the ideal DSL for QEMU, so having
> complex models well designed help.
> 
> Here we introduce the ICH9 'southbridge' as a QOM container.
> Since the chipset comes as a whole, we shouldn't instantiate
> its components separately. However in order to maintain old
> code we expose some properties to configure the container and
> not introduce any change for the Q35 machine. There is no
> migration change, only QOM objects moved around.
> 
> More work remain in the LPC function (more code to remove from
> Q35). Maybe worth doing in parallel with the PIIX to clean both
> PC machines.

Bernhard had some comments so I hope you'll address them so
I can merge - after the release presumably.


> Also we'd need to decouple the cpu_interrupt() calls between hw/
> and target/.
> 
> Note that GSI is currently broken [2]. Once the LPC/ISA part is
> done, it might be easier to fix it.
> 
> [1] https://lore.kernel.org/qemu-devel/20240219163855.87326-1-philmd@linaro.org/
> [2] https://lore.kernel.org/qemu-devel/cd0e13c6-c03d-411f-83a5-1d4d28ea4345@linaro.org/
> 
> Philippe Mathieu-Daudé (15):
>   MAINTAINERS: Add 'ICH9 South Bridge' section
>   hw/i386/q35: Add local 'lpc_obj' variable
>   hw/acpi/ich9: Restrict definitions from 'hw/southbridge/ich9.h'
>   hw/acpi/ich9_tco: Include 'ich9' in names
>   hw/acpi/ich9_tco: Restrict ich9_generate_smi() declaration
>   hw/ide: Rename ich.c -> ich9_ahci.c
>   hw/i2c/smbus: Extract QOM ICH9 definitions to 'ich9_smbus.h'
>   hw/pci-bridge: Extract QOM ICH definitions to 'ich9_dmi.h'
>   hw/southbridge/ich9: Introduce TYPE_ICH9_SOUTHBRIDGE stub
>   hw/southbridge/ich9: Add the DMI-to-PCI bridge
>   hw/southbridge/ich9: Add a AHCI function
>   hw/southbridge/ich9: Add the SMBus function
>   hw/southbridge/ich9: Add the USB EHCI/UHCI functions
>   hw/southbridge/ich9: Extract LPC definitions to 'hw/isa/ich9_lpc.h'
>   hw/southbridge/ich9: Add the LPC / ISA bridge function
> 
>  MAINTAINERS                               |  21 +-
>  include/hw/acpi/ich9.h                    |  15 ++
>  include/hw/acpi/ich9_tco.h                |   6 +-
>  include/hw/i2c/ich9_smbus.h               |  25 +++
>  include/hw/isa/ich9_lpc.h                 | 166 +++++++++++++++
>  include/hw/pci-bridge/ich9_dmi.h          |  20 ++
>  include/hw/southbridge/ich9.h             | 235 +---------------------
>  hw/acpi/ich9.c                            |   9 +-
>  hw/acpi/ich9_tco.c                        |   5 +-
>  hw/i2c/{smbus_ich9.c => ich9_smbus.c}     |  36 +++-
>  hw/i386/acpi-build.c                      |   1 +
>  hw/i386/pc_q35.c                          | 126 +++---------
>  hw/ide/{ich.c => ich9_ahci.c}             |   0
>  hw/isa/{lpc_ich9.c => ich9_lpc.c}         |  37 +++-
>  hw/pci-bridge/{i82801b11.c => ich9_dmi.c} |  11 +-
>  hw/southbridge/ich9.c                     | 213 ++++++++++++++++++++
>  tests/qtest/tco-test.c                    |   2 +-
>  hw/Kconfig                                |   1 +
>  hw/i2c/meson.build                        |   2 +-
>  hw/i386/Kconfig                           |   3 +-
>  hw/ide/meson.build                        |   2 +-
>  hw/isa/meson.build                        |   2 +-
>  hw/meson.build                            |   1 +
>  hw/pci-bridge/meson.build                 |   2 +-
>  hw/southbridge/Kconfig                    |  11 +
>  hw/southbridge/meson.build                |   3 +
>  26 files changed, 587 insertions(+), 368 deletions(-)
>  create mode 100644 include/hw/i2c/ich9_smbus.h
>  create mode 100644 include/hw/isa/ich9_lpc.h
>  create mode 100644 include/hw/pci-bridge/ich9_dmi.h
>  rename hw/i2c/{smbus_ich9.c => ich9_smbus.c} (77%)
>  rename hw/ide/{ich.c => ich9_ahci.c} (100%)
>  rename hw/isa/{lpc_ich9.c => ich9_lpc.c} (95%)
>  rename hw/pci-bridge/{i82801b11.c => ich9_dmi.c} (95%)
>  create mode 100644 hw/southbridge/ich9.c
>  create mode 100644 hw/southbridge/Kconfig
>  create mode 100644 hw/southbridge/meson.build
> 
> -- 
> 2.41.0


