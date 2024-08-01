Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E34EC3DA64
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 05:38:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZOVp-0006u4-5n; Thu, 01 Aug 2024 01:38:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sZOVn-0006t8-Fk
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 01:38:03 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sZOVl-0007b8-H0
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 01:38:03 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-70b703eda27so4191639b3a.3
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 22:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1722490680; x=1723095480;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lIdz4H2124aQyqA3C6kYgFVMZviQ0s3kHmoq8FeGpK4=;
 b=kE3pD8bb6XWMDaUvVdduMErT0tJAhIHurTfrmzScsXGxZqQgA87r532Oazw9dTzJPd
 G0SVnicpdvEhoEE8UWbjQBugjvfZUR7kNL+naAPv3gQcdjDILM9htMmJOkDexDKJk5ce
 FhWcYkn166oH23eS6/AG62IeW5WkQc7ojEGoRCUHX42w4VT2fTNX5r464nBDQ2goCLbP
 +mjdxr0OEBPFgFf75P/ekmrOXh51r/EIwU3Xh1ZqA1USN7D+yP9wh1OdxQZz3ccVfM+l
 TuzwW4bfpaG7FEOrN37w38V2qrGfh15ETXWKKTmYxGpoFQW8+K4OEhosdNLDiOA+GC2L
 QmMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722490680; x=1723095480;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lIdz4H2124aQyqA3C6kYgFVMZviQ0s3kHmoq8FeGpK4=;
 b=Zy47HfU4IkNRa4twNj8fXt4yv5boQgAjzOSH6+X6jFiJER5imZbm6nYCpw4xgkOeLO
 aHGA0qxeJ8N6wmz4Jhx0stetUFaSudWtrvctO1kGKTSdlEcZo8utowhBiBbwGBFR5qdD
 kfuH97X+74siMWwyyKhtFf00s/aquXvwiukfCnsf/5NDFse2F6IRxaf+02tMLklc8s2c
 38wsx5uCDxopdKm2qZNDbyOqxqWz4AeywmqqKVCtF4KYjZ4vS105BkfEEHr42gV2g93Z
 46aSa6DTlszkmvE4NZOgdWcpibSuwwbyFH+r2230TdVYmDRFgsmrVfN8kPnqb75e1mCu
 y/og==
X-Gm-Message-State: AOJu0YzUHdoMW+hC2UCht9K5IAEQJ/dB7eG9r0RUy91PQcoWsvsRpWZ7
 mSgZ8qzKLAtryjZy5XrITXtwS4TS/2LCqld5OAF6p4z8XEx0oduTA2xjvwcAD+laarMXM2kJ0SL
 K
X-Google-Smtp-Source: AGHT+IE29vN/QGEbEC+P9B1Kd9LBSKH59/2MaJjPzIPSGhyA6lVj0gqB1JJzgl5iH/uk9l74GEOTQA==
X-Received: by 2002:a05:6a00:22cb:b0:705:c0a1:61c9 with SMTP id
 d2e1a72fcca58-7105d6e3c35mr1719087b3a.9.1722490679945; 
 Wed, 31 Jul 2024 22:37:59 -0700 (PDT)
Received: from [157.82.201.15] ([157.82.201.15])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70ead89e564sm10783550b3a.189.2024.07.31.22.37.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Jul 2024 22:37:59 -0700 (PDT)
Message-ID: <36c4c10b-0b5c-44ad-978f-29ba5162ef2b@daynix.com>
Date: Thu, 1 Aug 2024 14:37:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v4 0/7] virtio-net: add support for SR-IOV emulation
To: Yui Washizu <yui.washidu@gmail.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20240428-sriov-v4-0-ac8ac6212982@daynix.com>
 <966b756c-f4b9-40da-ad35-ddb7c6e7da50@gmail.com>
 <88ffcfa0-f3c4-406c-ac79-456b0f8b38bd@daynix.com>
 <90cef42c-dbb5-44fd-9b20-fe0996c9974b@gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <90cef42c-dbb5-44fd-9b20-fe0996c9974b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::429;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/07/31 18:34, Yui Washizu wrote:
> 
> On 2024/07/15 14:15, Akihiko Odaki wrote:
>> On 2024/05/16 11:00, Yui Washizu wrote:
>>>
>>> On 2024/04/28 18:05, Akihiko Odaki wrote:
>>>> Based-on: <20240315-reuse-v9-0-67aa69af4d53@daynix.com>
>>>> ("[PATCH for 9.1 v9 00/11] hw/pci: SR-IOV related fixes and 
>>>> improvements")
>>>>
>>>> Introduction
>>>> ------------
>>>>
>>>> This series is based on the RFC series submitted by Yui Washizu[1].
>>>> See also [2] for the context.
>>>>
>>>> This series enables SR-IOV emulation for virtio-net. It is useful
>>>> to test SR-IOV support on the guest, or to expose several vDPA devices
>>>> in a VM. vDPA devices can also provide L2 switching feature for
>>>> offloading though it is out of scope to allow the guest to configure
>>>> such a feature.
>>>>
>>>> The PF side code resides in virtio-pci. The VF side code resides in
>>>> the PCI common infrastructure, but it is restricted to work only for
>>>> virtio-net-pci because of lack of validation.
>>>>
>>>> User Interface
>>>> --------------
>>>>
>>>> A user can configure a SR-IOV capable virtio-net device by adding
>>>> virtio-net-pci functions to a bus. Below is a command line example:
>>>>    -netdev user,id=n -netdev user,id=o
>>>>    -netdev user,id=p -netdev user,id=q
>>>>    -device pcie-root-port,id=b
>>>>    -device virtio-net-pci,bus=b,addr=0x0.0x3,netdev=q,sriov-pf=f
>>>>    -device virtio-net-pci,bus=b,addr=0x0.0x2,netdev=p,sriov-pf=f
>>>>    -device virtio-net-pci,bus=b,addr=0x0.0x1,netdev=o,sriov-pf=f
>>>>    -device virtio-net-pci,bus=b,addr=0x0.0x0,netdev=n,id=f
>>>>
>>>> The VFs specify the paired PF with "sriov-pf" property. The PF must be
>>>> added after all VFs. It is user's responsibility to ensure that VFs 
>>>> have
>>>> function numbers larger than one of the PF, and the function numbers
>>>> have a consistent stride.
>>>
>>>
>>> I tried to start a VM with more than 8 VFs allocated using your patch,
>>> but the following error occured and qemu didn't work:
>>> VF function number overflows.
>>>
>>> I think the cause of this error is that virtio-net-pci PFs don't have 
>>> ARI.
>>> (pcie_ari_init is not added to virtio-net-pci when PFs are initialized.)
>>> I think it is possible to add it later,
>>> but how about adding pcie_ari_init ?
>>>
>>> As a trial,
>>> adding pcie_ari_init to virtio_pci_realize enabled the creation of 
>>> more than 8 VFs.
>>
>> I have just looked into that possibility, but adding pcie_ari_init to 
>> virtio_pci_realize has some implications. Unconditionally calling 
>> pcie_ari_init will break the existing configuration of virtio-pci 
>> devices so we need to implement some logic to detect when ARI is 
>> needed. Preferably such logic should be implemented in the common PCI 
>> infrastructure instead of implementing it in virtio-pci so that other 
>> PCI multifunction devices can benefit from it.
>>
>> While I don't think implementing this will be too complicated, I need 
>> to ensure that such a feature is really needed before doing so.
> 
> 
> OK.
> I want to use this emulation for offloading virtual network
> in a environment where there are many containers in VMs.
> So, I consider that the feature is need.
> I think that 7 VFs are too few.
> I'll keep thinking about the feature's necessity.

I understand there could be many containers in VMs, but will a single 
device deal with them? If the virtio-net VFs are backed by the vDPA 
capability of one physical device, it will not have VFs more than that. 
The VMs must have several PFs individually paired with VFs to 
accommodate more containers on one VM.

I don't know much about vDPA-capable device, but as a reference, igb 
only has 8 VFs.

> 
> 
> I'll add other comments to RFC v5 patch.

The RFC tag is already dropped.

Regards,
Akihiko Odaki

