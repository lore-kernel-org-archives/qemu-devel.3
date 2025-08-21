Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93F74CA0EEB
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 03:38:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uow6h-0003kH-LH; Wed, 20 Aug 2025 23:36:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1uow6e-0003jY-CO; Wed, 20 Aug 2025 23:36:52 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1uow6a-0006hr-QC; Wed, 20 Aug 2025 23:36:51 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-b471738daabso440133a12.1; 
 Wed, 20 Aug 2025 20:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755747406; x=1756352206; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=Mt2eSjZ4YMd5F1e8HHW7O/OQMcsZveB6rS0vhYKZcW4=;
 b=L837JBIh2Po7ZxQ2dfuJjQH5cCLVPseVl0wI/NLKLGjdJZIcpj7f98LauiM6M5m9tD
 vWC/wb8b0ou7v/+0RYrhdENeLf820a7tPP/dYP52T3uygmRI8CpejDK+42yoML8jlY4f
 2A8OquiLUVG+1CfnrBPUf57CAEc4f0Jbkf+G5BIiCdaqU4yPVf1/y+1novoKZykFsGb1
 85wUq4ekNr4YRPh1lgj1wdpzr/8/Dpl1hnDgEj/Og6/NkvKJfdRdgMoVCE2weUM44X31
 qCB+Ovpa/y47DNyiB0sB+eW7j/aYT5vgRXc2dWbt6Tfj4JjT0Jn8a3vlIENp/daXBk1J
 ilnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755747406; x=1756352206;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mt2eSjZ4YMd5F1e8HHW7O/OQMcsZveB6rS0vhYKZcW4=;
 b=RpF1cQuYWPb8gbw7+GEfTohkiYLV2TQs9dYoB14eU/0DIUugzmqLCa8JsrwDDYWWQk
 7iKKbhylgax0B19K22SWC8S7IgyZKgGu2FRa5YeTT3W++Qtejbm1Ai2HQ5VNnlnbDYsQ
 m4UaerS8XGOJ5lyCgofROvaakekicnMTiXVAhjkE+lQs+RUgXwdOtK6sjCYUfbhjQMuA
 xBYz+A/tD/ayiwM4yeNMIia9T0/rWPp//KjzXbA0XHb0Bn8oc14TPcXRXZ+PsOblEtOp
 V1Di9l5rpWWVke9rEbTcr9DWnUvGCJZ5q53F6kQcYSNld/TZyik1nPwNU9cH5CqJ4mSW
 ADBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8y7izqVr842UJgd78kiqb2yOhCZoqHHK0IhpHweJTuDFoo4jRh9xqkjEa8OG5Nvcgsq9KhRcqmg==@nongnu.org,
 AJvYcCXIvF84LI1WrMhUCp1XC17sTlE0Zi0aeTYBdZnp/npr8BuP6sR/mqSjV/82gP7vrI3m2tV3yx27HIipcQ==@nongnu.org
X-Gm-Message-State: AOJu0Ywh1RX1MxrZD7hV9eFhtoZVgd9PuKA/lZD4gAcph8eQIUJaBUDw
 2psg1hkzS17Kx4Syi2QLbMArlViV7SBdw/zBmDGjAXwhG5jVR3ID1NnA
X-Gm-Gg: ASbGnctr/w2/QUz0Op+Febd/ODgNc+CiNxl3FlkhuX4EiVWm20NTPSgW0AwrkCVFDl2
 vLNS5wvuPqDfgEFfEEfmQqsyUZ6kDe/7fx65h6z2As2YFEbRsuLPAcrG+v/W3SoSC7QQsF8mbvU
 fsS70OmRRm1D/zU0GGVQXTX0jYOepf0DfhJdmoaOSGFc/rVe11oIyeGTd8moDkEjFVZ2PUdNseK
 B5uz/hL/ydBi6cyCa/kWEqT/xt6augOlsfYfVCj+SBv18SgrzqnRH96iPChcIX3nGJfZMlWrgNu
 471w25MariuIBfCHWNDrDVy+dn1Kw7egTOwf8zzsR6YF1KbwpaQAIB0YTJ9SQ1GPP1BabloT4Bz
 s1IXuhAByUTiGbmtFW4xh4nW27sx2+r9ghVREq2cydTorfGgDmGGebC1uDYLYr2k3xROj9Ck=
X-Google-Smtp-Source: AGHT+IHqYcu7oL9UT9iautL4krPKmixAj5PmT9bePQeQhH76HOPplxa1ZRGz25yscPP7YxBidFZTxQ==
X-Received: by 2002:a05:6a20:7487:b0:240:2421:b912 with SMTP id
 adf61e73a8af0-24330a4c0ebmr1308135637.37.1755747405951; 
 Wed, 20 Aug 2025 20:36:45 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5?
 ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76e7d0d22b8sm6942121b3a.4.2025.08.20.20.36.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Aug 2025 20:36:45 -0700 (PDT)
Message-ID: <7804e625-2421-473f-9320-89fa0cc0d085@roeck-us.net>
Date: Wed, 20 Aug 2025 20:36:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] Designware PCIe host fixes
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm@nongnu.org
References: <20250820211932.27302-1-shentey@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20250820211932.27302-1-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=groeck7@gmail.com; helo=mail-pg1-x529.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.029, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 8/20/25 14:19, Bernhard Beschow wrote:
> This series fixes the Designware PCIe host to work with cards other than
> virio-net-pci, e.g. e1000. It was tested on the imx8mp-evk machine.
> 
> The series is structured as follows: The first part refactors the device
> model to create memory regions for inbound/outbound PCI mappings on demand
> rather than upfront since this approach doesn't scale for adding I/O space
> support. The second part consists of fixing the memory mapping by adding I/O
> space support and fixing default inbound viewport mapping. The third part
> concludes the series by implementing device reset and cleaning up the imx8mp SoC
> implementation.
> 
> Testing done:
> * Boot imx8mp-evk machine with Buildroot while having an e1000 card attached.
> Observe that it gets an IP address via DHCP and allows for downloading an HTML
> file via HTTP.
> 
Crashing for me even if no PCIe card is attached. This is with the series applied
on top of 10.1.0-rc4 or 10.0.3. I have not tried to track down the problem.

Guenter

---
Build reference: v6.17-rc1-287-g685de850cabf
Compiler version: aarch64-linux-gcc (GCC) 13.4.0
Qemu version: 10.0.94 (v10.1.0-rc4-55-g320ed12bd9)

[    7.748393] Internal error: synchronous external abort: 0000000096000010 [#1]  SMP
[    7.748917] Modules linked in:
[    7.749533] CPU: 3 UID: 0 PID: 12 Comm: kworker/u16:0 Tainted: G   M             N  6.17.0-rc2-g685de850cabf #1 PREEMPT
[    7.749689] Tainted: [M]=MACHINE_CHECK, [N]=TEST
[    7.749745] Hardware name: NXP i.MX8MPlus EVK board (DT)
[    7.750118]         ok 1 block_bits=10 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
[    7.749922] Workqueue: async async_run_entry_fn
[    7.751174] pstate: 200000c5 (nzCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    7.751267] pc : pci_generic_config_read+0x38/0xb8
[    7.751370] lr : pci_generic_config_read+0x24/0xb8
[    7.751474] sp : ffff8000845fb730
[    7.751532] x29: ffff8000845fb730 x28: 00000000000000ff x27: 0000000000000000
[    7.751686] x26: 0000000000000001 x25: ffff80008290c008 x24: ffff8000832cbe80
[    7.751770] x23: 0000000000000000 x22: ffff8000845fb844 x21: ffff000008a73800
[    7.751859] x20: ffff8000845fb7a4 x19: 0000000000000004 x18: 00000000ffffffff
[    7.751942] x17: ffff800080e2f918 x16: ffff800080e2f7ac x15: ffff800080e2e6d8
[    7.752027] x14: 0000000000000000 x13: 0000000000000000 x12: ffff80008427cab8
[    7.752120] x11: 0000000000000326 x10: 0000000000000326 x9 : 00000000000c0326
[    7.752225] x8 : 000000006973b6c5 x7 : ffff800085c00000 x6 : 0000000000000000
[    7.752320] x5 : ffff000007cc5080 x4 : 0000000000000000 x3 : 0000000000000000
[    7.752403] x2 : 0000000000000000 x1 : ffff000004bf5680 x0 : ffff800085900000
[    7.752577] Call trace:
[    7.752694]  pci_generic_config_read+0x38/0xb8 (P)
[    7.752794]  dw_pcie_rd_other_conf+0x38/0xb0
[    7.752851]  pci_bus_read_config_dword+0x80/0xe4
[    7.752903]  pci_bus_generic_read_dev_vendor_id+0x30/0x190
[    7.752964]  pci_scan_device+0xdc/0x184
[    7.753010]  pci_scan_slot+0xe0/0x23c
[    7.753056]  pci_scan_child_bus_extend+0x44/0x2cc
[    7.753110]  pci_scan_bridge_extend+0x514/0x598
[    7.753166]  pci_scan_child_bus_extend+0x104/0x2cc
[    7.753220]  pci_scan_root_bus_bridge+0x64/0xd8
[    7.753273]  pci_host_probe+0x34/0x10c
[    7.753328]  dw_pcie_host_init+0x2f0/0x4b0
[    7.753376]  imx_pcie_probe+0x33c/0x70c
[    7.753439]  platform_probe+0x5c/0x9c
[    7.753485]  really_probe+0xc0/0x390
[    7.753530]  __driver_probe_device+0x7c/0x15c
[    7.753581]  driver_probe_device+0x3c/0x110
[    7.753633]  __device_attach_driver+0xbc/0x158


