Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33415C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 15:35:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugPsF-0006md-Rj; Mon, 28 Jul 2025 11:34:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1ugPrp-0005jD-84
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 11:34:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1ugPrm-0001RK-FK
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 11:34:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753716856;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sdt/9Ejlns4XKo+Lq+bhSxUAc8h7hmaymcXwIZo2vIg=;
 b=RQLY7HLFhe7wncFZYOwNhIa97G2IZ1lEFLzzlifxjRijewUXbloAdZdLz+0lDxxFyTciu9
 gZoMK5s35ijdbCWac9CaOHaSOc5YCqjI5kUlMZ0r9vjdSeCLt8Msfj4zGLo3SViYY+BHs/
 yQ30UQg7j3TVKBIWPLHQGwDdrgaYDnY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-z1mz7helNjW-eAOAUS2m4A-1; Mon, 28 Jul 2025 11:34:14 -0400
X-MC-Unique: z1mz7helNjW-eAOAUS2m4A-1
X-Mimecast-MFC-AGG-ID: z1mz7helNjW-eAOAUS2m4A_1753716853
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-456013b59c1so24423805e9.3
 for <qemu-devel@nongnu.org>; Mon, 28 Jul 2025 08:34:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753716853; x=1754321653;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Sdt/9Ejlns4XKo+Lq+bhSxUAc8h7hmaymcXwIZo2vIg=;
 b=GrQhNClB+ei/GuNyxtHLx3QFxmw9K3lG2bLh6rMMdJhwjzo/AXJ1zA7HwVCdVFK0Ez
 AulUCPIqeWo6YcvKUPHkrYx8h/48CTxk75Mmda9CtQ8myd/1+SoGZGx1jF+05j1jELtG
 jCyRi3/yBv6TK2ggdHthaXiijoP0AQzuDOPNSstDi3Onb1ETvrG92H1YMK38qe1rj1Mc
 XW0wOQznNRgQqxbLCZdQGFk9u4QawmqyRlLIzXCbhvwWzgW4pGUa+I4FaRwYsemm4c7g
 fHOr0pYSGHhlAQmuYcxRy4afYzartqy1j4y3fHsv2sAIDebj1obsk2DGvlenLuWBgaoA
 Kepw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhGwXrXE2XFDH8y4fEDrO82k+Mca/MSr7Pw4I64Bw7ViWvdNkLl+t5yo6Ya2CzJ7XIk+PFC0vTzqZ0@nongnu.org
X-Gm-Message-State: AOJu0YwGFyF4tinTKOmJcg2p9AltJokSPdz4YNU+hvWJREa46kCUpSmZ
 oCPnb8sZ/1womryXoUvo5GQTht+69XLW09trAXgXyovnsemCInn44Y3mUuYQPj3nIi8ogP0qKAq
 X5kJssq2BBFxVpD2LbJRqwbA2/KgXC/ohCO7bkL1Md1/deWquz/Hp9JX7
X-Gm-Gg: ASbGncvHrfB87mNWS2djR6fIRygectbpNQpMQKGbQkeHgxzH5V+Ld2v0Xg79eKbGWW3
 5RAezc8uHESLy91cvqG1QUwN+Out2LdpnryJAQXJ/xe5OmeZ8tK5B8t1LZRzlpdud+59kyIu4Gh
 U+mjYRBjyxSxi2f/8ckcwjOYubGW/cEa71gGz6aid3eVMwfI6YsZhxHdmDzwsHAJ/KVxxGxpvxQ
 /Yrf1YPLIcooXPMRJi3XVDR9xIMjvd3lhOrXpzGbNhWd4pqIkz0SkgQxcg93ZjxAlANMVi2cJHx
 IMainZPTdSN0gBqEfTFKX+edpKtB7xFXINgcmPdpT4yCRxeISYh3FzI4oG9ZcYHmjuBXSfdBgA=
 =
X-Received: by 2002:a05:600c:1907:b0:456:1d93:4365 with SMTP id
 5b1f17b1804b1-458762fb73emr101470465e9.5.1753716853025; 
 Mon, 28 Jul 2025 08:34:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDBj7HeNJtjL1zliTzj//Vg8dtNx8e3sNk1h3JKiRJhk/Al8cyrFzpGHzh+ZiABP9GuhOR2w==
X-Received: by 2002:a05:600c:1907:b0:456:1d93:4365 with SMTP id
 5b1f17b1804b1-458762fb73emr101469925e9.5.1753716852407; 
 Mon, 28 Jul 2025 08:34:12 -0700 (PDT)
Received: from [192.168.3.191] (228.246.150.77.rev.sfr.net. [77.150.246.228])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b7816e3641sm7384490f8f.73.2025.07.28.08.34.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Jul 2025 08:34:11 -0700 (PDT)
Message-ID: <df529eec-8987-4b32-a421-3ba63a368619@redhat.com>
Date: Mon, 28 Jul 2025 17:34:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 09/36] hw/pci-host/gpex-acpi: Use
 build_pci_host_bridge_osc_method
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 imammedo@redhat.com, Jonathan.Cameron@huawei.com, gustavo.romero@linaro.org,
 anisinha@redhat.com, mst@redhat.com, shannon.zhaosl@gmail.com,
 Gerd Hoffmann <kraxel@redhat.com>
Cc: pbonzini@redhat.com, philmd@linaro.org, alex.bennee@linaro.org
References: <20250714080639.2525563-1-eric.auger@redhat.com>
 <20250714080639.2525563-10-eric.auger@redhat.com>
 <ddf6f9e3-daaa-4ea1-a5e6-d402a75524c8@tls.msk.ru>
 <914677f4-07ba-45fe-9dc2-dea40940e789@tls.msk.ru>
 <53971ad6-9f50-45b0-80c4-eeedb24e53db@redhat.com>
 <46f08bce-7176-4332-9764-6999fd655bdf@tls.msk.ru>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <46f08bce-7176-4332-9764-6999fd655bdf@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Michael,
On 7/28/25 5:17 PM, Michael Tokarev wrote:
> On 28.07.2025 17:56, Eric Auger wrote:
>> Hi Michael,
>
> Hi!
>
>> This commit added an imply ACPI_PCI to the PCI_EXPRESS_GENERIC_BRIDGE
>> config in hw/pci-host/Kconfig:
>>
>> config PCI_EXPRESS_GENERIC_BRIDGE
>>      bool
>>      select PCI_EXPRESS  -> selects PCI
>>      imply ACPI_PCI
>>
>> In hw/acpi/Kconfig we have:
>>
>> config ACPI_PCI
>>      bool
>>      depends on ACPI && PCI
>>
>> ACPI is selected by ACPI_HW_REDUCED
>>
>> config ACPI_HW_REDUCED
>>      bool
>>      select ACPI
>>      select ACPI_MEMORY_HOTPLUG
>>      select ACPI_NVDIMM
>>
>> so logically the ACPI && PCI dependencies for ACPI_PCI should be
>> resolved. What do I miss?
>
> I think it should be "select" not "imply", which seems to be stricter.
> With a devices file like I'm using - it looks like - only things which
> are selected gets enabled.  But this commit brings hard dependency
> between the bridge device and ACPI_PCI, as demonstrated by my example.
> So when the bridge selects ACPI_PCI instead of implying it, whole thing
> works (I just verified it)

build_pci_host_bridge_osc_method() is called from gpex-acpi.c

pci_ss.add(when: ['CONFIG_PCI_EXPRESS_GENERIC_BRIDGE', 'CONFIG_ACPI'],
if_true: files('gpex-acpi.c'))

so the hard dependency exists only if ACPI is selected.

If you use "select" you will force ACPI_PCI even if ACPI is not set
which does not sound what we want?

regards

Eric
>
> I wonder why we build microvm-only executable in debian...  Initially
> it was a small binary aimed at very fast startup and light runtime.
> But with time it grew quite a lot of things...
>
> Thanks,
>
> /mjt
>


