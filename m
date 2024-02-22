Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8639BC48BF8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 06:41:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd2kt-0001Mo-5f; Thu, 22 Feb 2024 01:40:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rd2km-0001Li-0o
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 01:40:20 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rd2kj-0007ny-L2
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 01:40:19 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1d731314e67so54580105ad.1
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 22:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1708584015; x=1709188815;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rpS8SRUIrmf/JFN/QsLpCZHunyC6UCaGxo+uMQsLt10=;
 b=SJud/saH+gJLASY+/e3oVAlGr9lmB3cSL1qvojHfg2wLeaog/azW8esBDeNvuuogNZ
 AKQzZYz7JlQYEyswbJs4lC9Jt+zGlWmXwI4dfs9XyHWSWy2KMzZMG4cmfF0Lus20VMAa
 TE2jJIP9HVHSHAv2Dq30j8TSUqrZ5hV6LgEenhL+xZRdajnQrmLwXTXKrCT3aPuVzQkQ
 +vERgvVisRULTcMoeFq6D9U9HvwJ3GvkZuQEeJ0jhXvuboVLHaKIJvGiRA6/MWtC819f
 MydH494jHsWDJV8yl3929wwb4yFh5VZrtPiW8pYPZpcldhMJs78ECCuibc+0HSPUh64i
 Hc7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708584015; x=1709188815;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rpS8SRUIrmf/JFN/QsLpCZHunyC6UCaGxo+uMQsLt10=;
 b=g0NjmC+omLcvdkwvWHt2CwYuvP/vHAPthOZoz9PtbGPuIEMTZ9omRf2Mn1Nk3b4PyU
 7akhwLec23wX6wNjrpDUdfJwdhHgGdfxrn4Ehb+ppmdAlR4+bTYwYRjIuE9j2C7uvHgr
 7WRucnC17dy3kfBXj85tanrYQhbGzV2JuexrSJUumpJLWvXZysPZk0VZFS+6sJf+0wuS
 Pxiir5ddUg4iBMNHxYYxNir4GPBSzatpjhEgocNn1KdQl0BCPdHy+KA5OnCxhuzNSSSO
 y/OKP78l3nvzcJD1TF7fXkzyaZCbKvk0/VbNoACtSFgL7uCbkmUDDsaClxA/Htd2KMcP
 yIdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSzpqvgbz2w33fytYkoH8Ao8JNjKpOU3prQXYowzPK3m+cjMAH+MaKUHwiBXvwFUATtQERPp8dOmRuwbqSS4o+s0JTnS8=
X-Gm-Message-State: AOJu0YxviEZrHj74hq45aEv5RkYYK30i/SP4FtVb4X/0F8VPlXryl7K/
 1rQ/g4KZGQKaNrzcuXuZeneHL3nciXD1n/yISmsqsVT9LxUVMKFc0BSIA10pvQeN0LRydOk5vNO
 P
X-Google-Smtp-Source: AGHT+IHYak/+MUHQuvbncYyWRT9z3VwSTQvpiRk9FtYjXczY/oW7AINH29I3tCyn6dPnQOei2nylaw==
X-Received: by 2002:a17:902:b697:b0:1db:9f88:4ce6 with SMTP id
 c23-20020a170902b69700b001db9f884ce6mr15219114pls.1.1708584015507; 
 Wed, 21 Feb 2024 22:40:15 -0800 (PST)
Received: from [157.82.203.206] ([157.82.203.206])
 by smtp.gmail.com with ESMTPSA id
 r17-20020a170903411100b001d92a58330csm9215313pld.145.2024.02.21.22.40.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Feb 2024 22:40:15 -0800 (PST)
Message-ID: <4672de28-25b1-47bd-9ab7-cb27ed36afe4@daynix.com>
Date: Thu, 22 Feb 2024 15:40:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 12/15] hw/pci: Use -1 as a default value for rombar
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
References: <20240220-reuse-v6-0-2e42a28b0cf2@daynix.com>
 <20240220-reuse-v6-12-2e42a28b0cf2@daynix.com> <87a5nu1c47.fsf@pond.sub.org>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <87a5nu1c47.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::633;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001,
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

On 2024/02/21 16:59, Markus Armbruster wrote:
> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
> 
>> Currently there is no way to distinguish the case that rombar is
>> explicitly specified as 1 and the case that rombar is not specified.
>>
>> Set rombar -1 by default to distinguish these cases just as it is done
>> for addr and romsize. It was confirmed that changing the default value
>> to -1 will not change the behavior by looking at occurences of rom_bar.
>>
>> $ git grep -w rom_bar
>> hw/display/qxl.c:328:    QXLRom *rom = memory_region_get_ram_ptr(&d->rom_bar);
>> hw/display/qxl.c:431:    qxl_set_dirty(&qxl->rom_bar, 0, qxl->rom_size);
>> hw/display/qxl.c:1048:    QXLRom *rom = memory_region_get_ram_ptr(&qxl->rom_bar);
>> hw/display/qxl.c:2131:    memory_region_init_rom(&qxl->rom_bar, OBJECT(qxl), "qxl.vrom",
>> hw/display/qxl.c:2154: PCI_BASE_ADDRESS_SPACE_MEMORY, &qxl->rom_bar);
>> hw/display/qxl.h:101:    MemoryRegion       rom_bar;
>> hw/pci/pci.c:74:    DEFINE_PROP_UINT32("rombar",  PCIDevice, rom_bar, 1),
>> hw/pci/pci.c:2329:    if (!pdev->rom_bar) {
>> hw/vfio/pci.c:1019:    if (vdev->pdev.romfile || !vdev->pdev.rom_bar) {
>> hw/xen/xen_pt_load_rom.c:29:    if (dev->romfile || !dev->rom_bar) {
>> include/hw/pci/pci_device.h:150:    uint32_t rom_bar;
>>
>> rom_bar refers to a different variable in qxl. It is only tested if
>> the value is 0 or not in the other places.
> 
> Makes me wonder why it's uint32_t.  Not this patch's problem.

Indeed. It should have been OnOffAuto. I'm not changing it now though 
because I'm too worried if it is too disruptive.

> 
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   hw/pci/pci.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>> index 54b375da2d26..909c5b3ee4ee 100644
>> --- a/hw/pci/pci.c
>> +++ b/hw/pci/pci.c
>> @@ -71,7 +71,7 @@ static Property pci_props[] = {
>>       DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),
>>       DEFINE_PROP_STRING("romfile", PCIDevice, romfile),
>>       DEFINE_PROP_UINT32("romsize", PCIDevice, romsize, -1),
>> -    DEFINE_PROP_UINT32("rombar",  PCIDevice, rom_bar, 1),
>> +    DEFINE_PROP_UINT32("rombar",  PCIDevice, rom_bar, -1),
>>       DEFINE_PROP_BIT("multifunction", PCIDevice, cap_present,
>>                       QEMU_PCI_CAP_MULTIFUNCTION_BITNR, false),
>>       DEFINE_PROP_BIT("x-pcie-lnksta-dllla", PCIDevice, cap_present,
> 

