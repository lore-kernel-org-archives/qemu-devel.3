Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E51D4C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 12:51:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhpD4-00053C-Hg; Fri, 01 Aug 2025 08:50:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uhotC-000456-GW
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 08:29:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uhot7-00054I-5t
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 08:29:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754051364;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lM9lZxHQzSjVXT78nF2/noSWJ8oz+r63yamxSZ9A9qA=;
 b=Re8q1wlapG1O+usN4Ubin0xo3Z+6vw+eBo+HDfYcn/fNTpjEQnbOjtFKSr/L68WiYr6Q/Y
 W35NxNr4JZRIn86XnoehF7f9GAl8q1HuAo16fs7bJClF0Xn/VX/wqRog4CEYvu37iCqGYx
 Qy+lLOi1ddwmO5uBKrc4Cc/Ub+/te8w=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-ehOaIWBCPUq65NAMfSZW7A-1; Fri, 01 Aug 2025 08:29:23 -0400
X-MC-Unique: ehOaIWBCPUq65NAMfSZW7A-1
X-Mimecast-MFC-AGG-ID: ehOaIWBCPUq65NAMfSZW7A_1754051362
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-45624f0be48so10181295e9.3
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 05:29:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754051362; x=1754656162;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lM9lZxHQzSjVXT78nF2/noSWJ8oz+r63yamxSZ9A9qA=;
 b=GXnhmrtxS6lcFYfCZ8CQFQBUWyotG6MF8cyTMd+rDvNn+vJOAbZ6WEGfJl6iDhKkJk
 8pilujKZLqfIw2nM4MSI+9U97H1kENmusEIlN0taUbNhpFSE8JLm0NBL6O3Vh7M+A3gS
 DYSmuraMUI0zs4UUkVIuxtc6p5YvE/y86K99CZP+XVW6/d4UkqzuIUIhV9SGRXf1VR01
 hrQG4uLrc3Gs8F30Z2/3VscIL3U0npgtXWB9ZHpFgK5l/Poj+LCyWwAmZHo6LEXrAu5t
 Cr1732qRLY0O5ns7XLhe5DhQgrFA6A01eGgIaiutt38Zbnp1+rJ4HyOGwA0uWsLjA7su
 TX+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCURgmgnE6/4TvSLo7zDqf1jgBzzLtEW2w03m9rY0ZmYGu9drQ1wy8FEAQv6JMXgHx3VhjO0/oSCD1mO@nongnu.org
X-Gm-Message-State: AOJu0YzZydxc/png3uqclBUovoqgF7WCLfQbG47ZO5n/6RSz24MUeiwh
 c+nRJqUuo+3ioehozGJxbMso6ZtGgxF+tHsiKEFgEmtj4Oyrz9YjOv8LzwHVoF7iRvydC6lKSNX
 xCTn9fSq8u0da/zuvq8g54vyHRZRqFg7cXV2O7Vm7cNjnGTiA8tHlwuQaRpwB60RL
X-Gm-Gg: ASbGncv+z8IxPKTiWp8WPGKaIfcwZDE1zQLU6JI/sasryNqzVwM0vUccHZMTJZLshGs
 Vu0MssezeJxGxJ3Rmc4JiTjTnGMp6yDkL2ex2qtdILmoLOQic1AXT1/dSKeSSxqiJjWMVvZVOtr
 Q/bhA4Ro82kJU7zrif29Z3OImyigSm1+q6M++AKMrUdOcgrmVdlfWNkx2Mlw81kDzknRvY5LjTN
 kmS2Yy78Ku6FfhTPko2rKzsWNi5/yNNTBBpo9Zi6kAOfiBKkSi1M6OABaYecIgeBpctTIi+ejdC
 OOK9CH4Hc01snLMPqRP1j30B/6rb465P
X-Received: by 2002:a05:600c:138e:b0:456:1d61:b0f2 with SMTP id
 5b1f17b1804b1-45892bdf7ebmr111755465e9.30.1754051361862; 
 Fri, 01 Aug 2025 05:29:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEd+gjhjuuhRv9KIRn2pJpIwQ7ylXM8ojJJJ5JCdsEkH7C4PDNXGrPEJ3+kNdY4g3u7RKfMbA==
X-Received: by 2002:a05:600c:138e:b0:456:1d61:b0f2 with SMTP id
 5b1f17b1804b1-45892bdf7ebmr111755215e9.30.1754051361430; 
 Fri, 01 Aug 2025 05:29:21 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458953cfeaesm111587495e9.16.2025.08.01.05.29.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Aug 2025 05:29:20 -0700 (PDT)
Date: Fri, 1 Aug 2025 08:29:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, imammedo@redhat.com,
 Jonathan.Cameron@huawei.com, gustavo.romero@linaro.org,
 anisinha@redhat.com, shannon.zhaosl@gmail.com,
 Gerd Hoffmann <kraxel@redhat.com>, pbonzini@redhat.com,
 philmd@linaro.org, alex.bennee@linaro.org
Subject: Re: [PATCH v7 09/36] hw/pci-host/gpex-acpi: Use
 build_pci_host_bridge_osc_method
Message-ID: <20250801082904-mutt-send-email-mst@kernel.org>
References: <20250714080639.2525563-1-eric.auger@redhat.com>
 <20250714080639.2525563-10-eric.auger@redhat.com>
 <ddf6f9e3-daaa-4ea1-a5e6-d402a75524c8@tls.msk.ru>
 <914677f4-07ba-45fe-9dc2-dea40940e789@tls.msk.ru>
 <53971ad6-9f50-45b0-80c4-eeedb24e53db@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <53971ad6-9f50-45b0-80c4-eeedb24e53db@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Jul 28, 2025 at 04:56:37PM +0200, Eric Auger wrote:
> Hi Michael,
> 
> On 7/28/25 11:07 AM, Michael Tokarev wrote:
> > On 27.07.2025 14:48, Michael Tokarev wrote:
> >> On 14.07.2025 11:04, Eric Auger wrote:
> >>> gpex build_host_bridge_osc() and x86 originated
> >>> build_pci_host_bridge_osc_method() are mostly identical.
> >>>
> >>> In GPEX, SUPP is set to CDW2 but is not further used. CTRL is
> >>> same as Local0.
> >>>
> >>> So let gpex code reuse build_pci_host_bridge_osc_method() and remove
> >>> build_host_bridge_osc().
> >>>
> >>> Also add an imply ACPI_PCI clause along with
> >>> PCI_EXPRESS_GENERIC_BRIDGE to compile hw/acpi/pci.c when its
> >>> dependency is resolved (ie. CONFIG_ACPI_PCI). This is requested
> >>> to link qemu-system-mips64el.
> >>
> >> This patch somehow broke microvm-only build which is used by debian.
> >>
> >> configure options used (trimmed a bit):
> >>
> >> ../configure \ --without-default-features \ --target-list=x86_64-
> >> softmmu \ --enable-kvm --disable-tcg \ --enable-pixman \ --enable-
> >> vnc \ --audio-drv-list="" \ --without-default-devices \ --with-
> >> devices-x86_64=microvm \ --enable-vhost-user
> >>
> >> configs/devices/x86_64-softmmu/microvm.mak: ---- cut ---- # see
> >> configs/devices/i386-softmmu/default.mak # for additional devices
> >> which can be disabled # CONFIG_PCI_DEVICES=n
> >>
> >> CONFIG_MICROVM=y
> >>
> >> CONFIG_VIRTIO_BLK=y CONFIG_VIRTIO_SERIAL=y CONFIG_VIRTIO_INPUT=y
> >> CONFIG_VIRTIO_INPUT_HOST=y CONFIG_VHOST_USER_INPUT=y
> >> CONFIG_VIRTIO_NET=y CONFIG_VIRTIO_SCSI=y CONFIG_VIRTIO_RNG=y
> >> CONFIG_VIRTIO_CRYPTO=y CONFIG_VIRTIO_BALLOON=y CONFIG_VIRTIO_GPU=y
> >> CONFIG_VHOST_USER_GPU=y ---- cut ----
> >>
> >> The result: FAILED: qemu-system-x86_64 cc -m64 @qemu-system-
> >> x86_64.rsp /usr/bin/ld: libsystem.a.p/hw_pci-host_gpex-acpi.c.o: in
> >> function `acpi_dsdt_add_host_bridge_methods': hw/pci-host/gpex-
> >> acpi.c:83:(.text+0x274): undefined reference to
> >> `build_pci_host_bridge_osc_method' collect2: error: ld returned 1
> >> exit status
> >
> > In hw/i386/Kconfig, MICROVM selects ACPI_HW_REDUCED (not ACPI or
> > ACPI_PCI), *and* PCI_EXPRESS_GENERIC_BRIDGE.  But in hw/pci/meson.build,
> > pci.c (where the function in question is defined) is built when
> > ACPI_PCI is enabled.  Something's not right here.
> This commit added an imply ACPI_PCI to the PCI_EXPRESS_GENERIC_BRIDGE
> config in hw/pci-host/Kconfig:
> 
> config PCI_EXPRESS_GENERIC_BRIDGE
>     bool
>     select PCI_EXPRESS  -> selects PCI
>     imply ACPI_PCI
> 
> In hw/acpi/Kconfig we have:
> 
> config ACPI_PCI
>     bool
>     depends on ACPI && PCI
> 
> ACPI is selected by ACPI_HW_REDUCED
> 
> config ACPI_HW_REDUCED
>     bool
>     select ACPI
>     select ACPI_MEMORY_HOTPLUG
>     select ACPI_NVDIMM
> 
> so logically the ACPI && PCI dependencies for ACPI_PCI should be
> resolved. What do I miss?
> regards
> 
> Eric
> 


Not sure I get what are you proposing?

> 
> 
> 
> 
> 
> 
> 
> >
> > Addig kraxel for 24db877ab6e6 "microvm: add pcie support".
> >
> > Thanks
> >
> > /mjt
> >


