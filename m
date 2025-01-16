Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EB99C02180
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 09:16:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYLyI-00051p-1Y; Thu, 16 Jan 2025 04:15:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tYLy8-000505-Dw
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 04:15:21 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tYLy6-0005eO-HF
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 04:15:16 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2165448243fso14599235ad.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 01:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737018912; x=1737623712;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4/lL4UidUy1I4CY8mtnumDmLoZlT8YIlEtOPTU6JD7g=;
 b=3OWE9w30ePhiDjpAU3wg3QlpOGDg08klkqHqskYeKa1a7lkOPC/6p4upmqHZJDwZMb
 /+ZXajUQo85t4MYv56SHmFbZvuzs1W86UfvNBqHE81VFlDBduLxZ7Uw+0EVMegA5uw5v
 PHqfJ3tOQnffMayBHygX75kzfTCukpRkZBUBFepd7JL66SmJefb9q92VWuK8hc9sUT0P
 BRa19paOobF6efq8orBacxikr5/EzE6rHuPli596FAJIen6IQT1u/MFtumeCflFwvxTe
 Zkv0YEVPLtce4KTejHuGC3RPKxOE1yB75BLnXdQ3bY0G52f3gZCd6iQn61qfzCbw/LuQ
 lP5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737018912; x=1737623712;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4/lL4UidUy1I4CY8mtnumDmLoZlT8YIlEtOPTU6JD7g=;
 b=bZXaCJey3wAByUcn4tU0qvXt4uanxb2PuQ8lVT/W5nK/0hfzGgD9/AGTvqddMtBUdZ
 K2kv0irZF8ZFliEA2vjug9/OTQFAFE1LkZlFZbWEmpLw7V2rLIp7MyE3kZTtMTVGFfes
 tMA3gvgYNNv3SnIkVwFXuE+PGbayi6Sl8QZV0SuHsjKxjSKVQtSVfg590mWs+0HYXgvJ
 hGZ+vUh3zjKLl9umaB89JA1Be/0XrD6soUkw2VXDYhv9SGpAwbzDkEg7uHnqbXbY7GLS
 T+C2I+dZR8mzCFRfZNz1zhVTUIceZRcjAZaA2BDBP0fnTyrjrqw3LKUfd2ipwkV/zbyb
 80Cw==
X-Gm-Message-State: AOJu0Yw7iDDGA6u5g+PNafrBj+jAGgNTPJwsg7ocwbjw/BMIZsiqt2Ph
 H+jXVhUONMVj2n4R46gkrw+fult1neubC2MCi1wRj50AUoUzh/7e3z3ZKwLrRL4=
X-Gm-Gg: ASbGnct6bwinplbeY/nOKxjAeKWhlwA7RfkVmycIbNvXW/tssaajYoXj+r+nDJHNVOP
 uFbwtfjAlMkgw8QPAM42+qEiA1Tk2lSDTxnriUbshc8dfz3tzeGDgF87I9VAGDJWVGY+BW3ZJNg
 ndt6RbMMwcpSlkP98G8gqJZ/7fAlIfloaUouGSfo0NDvt10xecwCdbrfmZDqcGjB4d0HJHmbXj/
 9xl0iccIeERW8ihJHZQ1ah0jnwXje6/PYxCL5NRroCElFpBjrhRkhhYlIGSS5wwOyk=
X-Google-Smtp-Source: AGHT+IE8xHHaZ8Xruqw8xP5MRTMNO2dH92dkkayqQJGpUMRsj8qQ/XyrkO1exHpMXPSFam+gExAycg==
X-Received: by 2002:a17:903:187:b0:20c:9936:f0ab with SMTP id
 d9443c01a7336-21a84009ab8mr496111205ad.47.1737018912405; 
 Thu, 16 Jan 2025 01:15:12 -0800 (PST)
Received: from [157.82.203.37] ([157.82.203.37])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21a9f1381a6sm95311265ad.93.2025.01.16.01.15.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2025 01:15:12 -0800 (PST)
Message-ID: <f706c171-f1ae-4baf-bb90-8dfb2678a164@daynix.com>
Date: Thu, 16 Jan 2025 18:15:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 09/14] pcie_sriov: Reuse SR-IOV VF device instances
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Shivaprasad G Bhat <sbhat@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, devel@daynix.com
References: <20250109-reuse-v19-0-f541e82ca5f7@daynix.com>
 <20250109-reuse-v19-9-f541e82ca5f7@daynix.com>
 <01eac6ff-e128-4b1c-a5de-66ffa28b43b1@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <01eac6ff-e128-4b1c-a5de-66ffa28b43b1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2025/01/09 19:51, Philippe Mathieu-Daudé wrote:
> Hi Akihiko,
> 
> On 9/1/25 07:29, Akihiko Odaki wrote:
>> Disable SR-IOV VF devices by reusing code to power down PCI devices
>> instead of removing them when the guest requests to disable VFs. This
>> allows to realize devices and report VF realization errors at PF
>> realization time.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   include/hw/pci/pcie_sriov.h |  1 -
>>   hw/pci/pci.c                | 14 ++++++-
>>   hw/pci/pcie_sriov.c         | 94 ++++++++++++++++++ 
>> +--------------------------
>>   3 files changed, 51 insertions(+), 58 deletions(-)
> 
> 
>>   void pci_set_enabled(PCIDevice *d, bool state)
>> @@ -2977,7 +2987,7 @@ void pci_set_enabled(PCIDevice *d, bool state)
>>       memory_region_set_enabled(&d->bus_master_enable_region,
>>                                 (pci_get_word(d->config + PCI_COMMAND)
>>                                  & PCI_COMMAND_MASTER) && d->enabled);
>> -    if (!d->enabled) {
>> +    if (d->qdev.realized) {
> 
> I'm not a big fan of accessing an internal field that way, without
> accessor. Besides, we use this field atomicly within qdev.c.

I changed it to use qdev_is_realized() with v20.

> 
>>           pci_device_reset(d);
> 
> Anyhow, resetting an unrealized device is a bug IMO.

Right. Calling pci_set_enabled() for an unrealized device to set the 
initial value is fine. This code ensures it will not trigger resetting 
the device.

> 
>>       }
>>   }
> 


