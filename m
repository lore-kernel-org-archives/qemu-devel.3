Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0749ACA0EF8
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 10:25:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up2T3-0004dV-Bq; Thu, 21 Aug 2025 06:24:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1up2T1-0004dI-Dm; Thu, 21 Aug 2025 06:24:23 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1up2Sw-0007Q6-Pf; Thu, 21 Aug 2025 06:24:23 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-afcb78d5dcbso121505666b.1; 
 Thu, 21 Aug 2025 03:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755771854; x=1756376654; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=phAvCa2oZ51Xeh+b+QhZckCzQl0Fh/yMSjJEcXhCCnk=;
 b=aveUDwC8qmGgdeJbc/9CfFkwuPK5Cy6W5b/qhg2BXS9RD9Cv4Y55uxb+TcHw83T3Be
 TrD/wOSlrHaWpDsqFJzkOr+/357dwlmRB+Q0+5aEte3gEkmdPPDtpv8YFAG2CcUoaxJC
 IBNegYmrNkun2BdXrTVzt8z7zGFSJjqiSlOREhlk8VLoySaqsw7AoSSJ5jVEbDElPMBg
 793yoFMpWS7+57JMSknJ4orAcPAYC3yBl2SAFEMGmLRw/4DNj9TrbYbx6wC9ZaZ48h/0
 prej5/zs0z8EiqN9umNyPjNA45fxmraE+q0yrq7p6QkAxevBW6TrUf1afKPpYwgiw8Ir
 tNhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755771854; x=1756376654;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=phAvCa2oZ51Xeh+b+QhZckCzQl0Fh/yMSjJEcXhCCnk=;
 b=MNstXnTYx+JlWHatr/aty3NBvQrRpz/dyBncFRQaUqRTY5MXIyQoVddu33SkyTXasn
 wPNZADXmnapGSkUXl01rpOjUrSHT6EgSxSMqw3dA6Zjt56FhgiXKsiH8jiB6WN8ebCQg
 hmA+inI/QQNqRhIpE2Fd6/VusUl+dukOfGL18ton8mMr27IUQTNJRXsi7BvzUQpNkUqY
 SdPbwMM64T6Zh+hQYUTFH3YSzZ5wXk7WEqROrpcMMajM9JeHuy9p13O/9LPqL/c+XLmd
 LBULVFcHo+hCjLEeytJtB9rlmcB6FKft/n91ckJr/L2FrEOATDtSRs+GXK6DQzuJIsdn
 RNDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMzjRvOTUMn0lNdhaSnwBY5NGRdW03fiXGyUQC+WSIyi8oCT+qblbaEdRzpPZorisW8JpV9XsTEZonJQ==@nongnu.org,
 AJvYcCXn/SgjDqA5kFaIEtaCWzj6sk8FHUPIBahlG1Ple3fu5DoqNM7JwME/MNNlz7IIGbtKs1xbPXq5mQ==@nongnu.org
X-Gm-Message-State: AOJu0YzmSuvucDE9qBMnOIljwxHIGA0c77M8iU+bK28YcSehJXsoLASz
 AhbWN/yMH3e0TQvwIF/M8EEJDsmg6xCbYWsT4QOE8VQPeOFbe/Xjr0B36K9TgA==
X-Gm-Gg: ASbGncunjMtJ3bA3+cMjmW3Vh+umuhBCegKuo9S6a8mcrnP2ZCF0yCO3+sBrDQd7kg6
 c/4t/1LUt7GWxoCC4q5l6YWIGeOL9Svu8QcZu6x5GsY5MfCXcKZ8ZZpoKK+TDM8cLD4AJ2R2wdd
 mnAPshCPMcE6FNN7hTOXwmNdqlhfkGfZVFtI8X4hJjyWw67xTEXez/IQnhjJ1kgtCuDmWBraL3S
 AonlvmMuPGsKTGsyitSUj8w11sbp6k0UwSXfGt2GiQliJobUeFtexeOJDzAqPrSbE7rCbiZ1uou
 LSW6LlpbG/eX4mF2NTi9yO6bkj2t99JgfBtjQccpzU9xAQxEHoucGQUuCpfUjv3nHK3rX9H69M+
 +HuxO7bzaN/t91QKwr6t/Gty2WNHTzxk5HFs65lQ=
X-Google-Smtp-Source: AGHT+IE8z6cUjxhXQXNNYzjsgf7hzZRlDizQZBfMhgN0sopmLuChjzbWPqhHcKG7fPQNqh1aWklOYw==
X-Received: by 2002:a17:907:3f12:b0:af5:3172:ca80 with SMTP id
 a640c23a62f3a-afe07b82fa6mr179802466b.38.1755771853530; 
 Thu, 21 Aug 2025 03:24:13 -0700 (PDT)
Received: from ehlo.thunderbird.net ([62.214.191.67])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-afded4796ddsm361481066b.55.2025.08.21.03.24.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Aug 2025 03:24:13 -0700 (PDT)
Date: Thu, 21 Aug 2025 10:24:02 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>, qemu-devel@nongnu.org
CC: Peter Maydell <peter.maydell@linaro.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm@nongnu.org
Subject: Re: [PATCH 00/10] Designware PCIe host fixes
In-Reply-To: <7804e625-2421-473f-9320-89fa0cc0d085@roeck-us.net>
References: <20250820211932.27302-1-shentey@gmail.com>
 <7804e625-2421-473f-9320-89fa0cc0d085@roeck-us.net>
Message-ID: <D1762D97-2253-4503-9BD9-E4BF6BED1EAE@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x632.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



Am 21=2E August 2025 03:36:44 UTC schrieb Guenter Roeck <linux@roeck-us=2E=
net>:
>On 8/20/25 14:19, Bernhard Beschow wrote:
>> This series fixes the Designware PCIe host to work with cards other tha=
n
>> virio-net-pci, e=2Eg=2E e1000=2E It was tested on the imx8mp-evk machin=
e=2E
>>=20
>> The series is structured as follows: The first part refactors the devic=
e
>> model to create memory regions for inbound/outbound PCI mappings on dem=
and
>> rather than upfront since this approach doesn't scale for adding I/O sp=
ace
>> support=2E The second part consists of fixing the memory mapping by add=
ing I/O
>> space support and fixing default inbound viewport mapping=2E The third =
part
>> concludes the series by implementing device reset and cleaning up the i=
mx8mp SoC
>> implementation=2E
>>=20
>> Testing done:
>> * Boot imx8mp-evk machine with Buildroot while having an e1000 card att=
ached=2E
>> Observe that it gets an IP address via DHCP and allows for downloading =
an HTML
>> file via HTTP=2E
>>=20
>Crashing for me even if no PCIe card is attached=2E This is with the seri=
es applied
>on top of 10=2E1=2E0-rc4 or 10=2E0=2E3=2E I have not tried to track down =
the problem=2E
>
>Guenter

Hi Guenther,

Thanks for testing this series! I can reproduce the issue with Buildroot w=
hile the functional test passes=2E=2E=2E

I guess that I was too optimistic in having resolved the issue mentioned i=
n the last patch=2E Does it work for you if you omit it?

Thanks,
Bernhard

>
>---
>Build reference: v6=2E17-rc1-287-g685de850cabf
>Compiler version: aarch64-linux-gcc (GCC) 13=2E4=2E0
>Qemu version: 10=2E0=2E94 (v10=2E1=2E0-rc4-55-g320ed12bd9)
>
>[    7=2E748393] Internal error: synchronous external abort: 000000009600=
0010 [#1]  SMP
>[    7=2E748917] Modules linked in:
>[    7=2E749533] CPU: 3 UID: 0 PID: 12 Comm: kworker/u16:0 Tainted: G   M=
             N  6=2E17=2E0-rc2-g685de850cabf #1 PREEMPT
>[    7=2E749689] Tainted: [M]=3DMACHINE_CHECK, [N]=3DTEST
>[    7=2E749745] Hardware name: NXP i=2EMX8MPlus EVK board (DT)
>[    7=2E750118]         ok 1 block_bits=3D10 cluster_bits=3D3 blocks_per=
_group=3D8192 group_count=3D4 desc_size=3D64
>[    7=2E749922] Workqueue: async async_run_entry_fn
>[    7=2E751174] pstate: 200000c5 (nzCv daIF -PAN -UAO -TCO -DIT -SSBS BT=
YPE=3D--)
>[    7=2E751267] pc : pci_generic_config_read+0x38/0xb8
>[    7=2E751370] lr : pci_generic_config_read+0x24/0xb8
>[    7=2E751474] sp : ffff8000845fb730
>[    7=2E751532] x29: ffff8000845fb730 x28: 00000000000000ff x27: 0000000=
000000000
>[    7=2E751686] x26: 0000000000000001 x25: ffff80008290c008 x24: ffff800=
0832cbe80
>[    7=2E751770] x23: 0000000000000000 x22: ffff8000845fb844 x21: ffff000=
008a73800
>[    7=2E751859] x20: ffff8000845fb7a4 x19: 0000000000000004 x18: 0000000=
0ffffffff
>[    7=2E751942] x17: ffff800080e2f918 x16: ffff800080e2f7ac x15: ffff800=
080e2e6d8
>[    7=2E752027] x14: 0000000000000000 x13: 0000000000000000 x12: ffff800=
08427cab8
>[    7=2E752120] x11: 0000000000000326 x10: 0000000000000326 x9 : 0000000=
0000c0326
>[    7=2E752225] x8 : 000000006973b6c5 x7 : ffff800085c00000 x6 : 0000000=
000000000
>[    7=2E752320] x5 : ffff000007cc5080 x4 : 0000000000000000 x3 : 0000000=
000000000
>[    7=2E752403] x2 : 0000000000000000 x1 : ffff000004bf5680 x0 : ffff800=
085900000
>[    7=2E752577] Call trace:
>[    7=2E752694]  pci_generic_config_read+0x38/0xb8 (P)
>[    7=2E752794]  dw_pcie_rd_other_conf+0x38/0xb0
>[    7=2E752851]  pci_bus_read_config_dword+0x80/0xe4
>[    7=2E752903]  pci_bus_generic_read_dev_vendor_id+0x30/0x190
>[    7=2E752964]  pci_scan_device+0xdc/0x184
>[    7=2E753010]  pci_scan_slot+0xe0/0x23c
>[    7=2E753056]  pci_scan_child_bus_extend+0x44/0x2cc
>[    7=2E753110]  pci_scan_bridge_extend+0x514/0x598
>[    7=2E753166]  pci_scan_child_bus_extend+0x104/0x2cc
>[    7=2E753220]  pci_scan_root_bus_bridge+0x64/0xd8
>[    7=2E753273]  pci_host_probe+0x34/0x10c
>[    7=2E753328]  dw_pcie_host_init+0x2f0/0x4b0
>[    7=2E753376]  imx_pcie_probe+0x33c/0x70c
>[    7=2E753439]  platform_probe+0x5c/0x9c
>[    7=2E753485]  really_probe+0xc0/0x390
>[    7=2E753530]  __driver_probe_device+0x7c/0x15c
>[    7=2E753581]  driver_probe_device+0x3c/0x110
>[    7=2E753633]  __device_attach_driver+0xbc/0x158
>

