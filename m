Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC312C3DA64
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 09:35:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ5j7-0006H9-Rg; Wed, 31 Jul 2024 05:34:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yui.washidu@gmail.com>)
 id 1sZ5j6-0006FD-Ge; Wed, 31 Jul 2024 05:34:32 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yui.washidu@gmail.com>)
 id 1sZ5j4-0004Sf-R5; Wed, 31 Jul 2024 05:34:32 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-70ea2f25bfaso3927844b3a.1; 
 Wed, 31 Jul 2024 02:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722418469; x=1723023269; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=F7xTZJISBA2Q8qpu5RjFa1EqPQsdwXhNu3qjXfGS5eM=;
 b=aR2RdHsnOioQLSSRVR4gfvXp5y31nQAlPz1d1oE2vVh6b/gzNpaLGK956Kz9BOhMf6
 dBKEou7DrLwRIoJISJAaP5z7I+qtssT3iUPbqbLWrohdiuWd24TcJ54QCETI4PQtVC+j
 XOxbYlhw+tc7f+7zJCXHdYxF5g4hVOlPABDYbOUZQJl0XsWIfr+8ipuDsYWaVDk3bLYx
 W7kgC4m5ebDqvBV0DLFHcgXIhX/1bV39W3Qu/gSUfrKJODbcSkRjhP0nvDMW3Hc1tLWk
 9mLtDZQPx4sAfiZORirHuuFNiu0jolTlc73dx0KXXlGQbAqKVJhvM00J7fpjRoCcczC/
 i6Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722418469; x=1723023269;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F7xTZJISBA2Q8qpu5RjFa1EqPQsdwXhNu3qjXfGS5eM=;
 b=b3By+LUmxOgK1e37HifU1xU9QHBi9iFqhHbpvRZr0+H4CcH0Eww2CmV0pA3Of+sa+I
 062c2ChhnCqyA+4w8NTqC8A8EHPq12zpBjrx/23V/B/cDQlSI0j2mgA8ZqSNxYxPeIfx
 2SDnNwst2E+J/CungGe8hcAt2QRFDQUGJnvLmSTQ4byJECmNJxdN0g73vFwDOPfooDg2
 FN9vGn3wA6aIPVNkIDeRnzmr5bbRJ1Prf3AYiNt9JAPZhSnmHYSw0fo66AgOqlvhexU/
 DNXea4+zF9vc54cF2wwzEA1nmGsMc7lhLp+r2XiKQFRJnxpnEoAUvq4rORb+MQGIyJk8
 jpcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW50fsYtPuXA0VCtaju0GRFjngbTPLqrfW4G6DW9VmCkBJXQK7IbwVAWNZMPYirQ4sjW+3dXIdNsTyrOrn4cSsh9e9D3TM=
X-Gm-Message-State: AOJu0YxZnF66y0jDyqJtfILyB00scJS8iWARcusRMtALZOMsO82IS8WU
 WO9pvkMsYZniPJvyi7QzKKbE5hhPlcg/QwJY4kbNm0DJySVoqaI9
X-Google-Smtp-Source: AGHT+IHcpJKPt4AnnObBIGNgvsminA8Qz2tyDUXdn/TsrOZm7+OZgbTFJx/bzmA/Y6eQLokyI+2lcA==
X-Received: by 2002:a05:6a00:91d6:b0:70e:8f89:7e2e with SMTP id
 d2e1a72fcca58-70ecea32783mr11514289b3a.18.1722418468553; 
 Wed, 31 Jul 2024 02:34:28 -0700 (PDT)
Received: from [172.20.149.24] ([222.151.198.97])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70ead8a3a91sm9642919b3a.195.2024.07.31.02.34.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Jul 2024 02:34:28 -0700 (PDT)
Message-ID: <90cef42c-dbb5-44fd-9b20-fe0996c9974b@gmail.com>
Date: Wed, 31 Jul 2024 18:34:21 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v4 0/7] virtio-net: add support for SR-IOV emulation
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
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
Content-Language: en-US
From: Yui Washizu <yui.washidu@gmail.com>
In-Reply-To: <88ffcfa0-f3c4-406c-ac79-456b0f8b38bd@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=yui.washidu@gmail.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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


On 2024/07/15 14:15, Akihiko Odaki wrote:
> On 2024/05/16 11:00, Yui Washizu wrote:
>>
>> On 2024/04/28 18:05, Akihiko Odaki wrote:
>>> Based-on: <20240315-reuse-v9-0-67aa69af4d53@daynix.com>
>>> ("[PATCH for 9.1 v9 00/11] hw/pci: SR-IOV related fixes and 
>>> improvements")
>>>
>>> Introduction
>>> ------------
>>>
>>> This series is based on the RFC series submitted by Yui Washizu[1].
>>> See also [2] for the context.
>>>
>>> This series enables SR-IOV emulation for virtio-net. It is useful
>>> to test SR-IOV support on the guest, or to expose several vDPA devices
>>> in a VM. vDPA devices can also provide L2 switching feature for
>>> offloading though it is out of scope to allow the guest to configure
>>> such a feature.
>>>
>>> The PF side code resides in virtio-pci. The VF side code resides in
>>> the PCI common infrastructure, but it is restricted to work only for
>>> virtio-net-pci because of lack of validation.
>>>
>>> User Interface
>>> --------------
>>>
>>> A user can configure a SR-IOV capable virtio-net device by adding
>>> virtio-net-pci functions to a bus. Below is a command line example:
>>>    -netdev user,id=n -netdev user,id=o
>>>    -netdev user,id=p -netdev user,id=q
>>>    -device pcie-root-port,id=b
>>>    -device virtio-net-pci,bus=b,addr=0x0.0x3,netdev=q,sriov-pf=f
>>>    -device virtio-net-pci,bus=b,addr=0x0.0x2,netdev=p,sriov-pf=f
>>>    -device virtio-net-pci,bus=b,addr=0x0.0x1,netdev=o,sriov-pf=f
>>>    -device virtio-net-pci,bus=b,addr=0x0.0x0,netdev=n,id=f
>>>
>>> The VFs specify the paired PF with "sriov-pf" property. The PF must be
>>> added after all VFs. It is user's responsibility to ensure that VFs 
>>> have
>>> function numbers larger than one of the PF, and the function numbers
>>> have a consistent stride.
>>
>>
>> I tried to start a VM with more than 8 VFs allocated using your patch,
>> but the following error occured and qemu didn't work:
>> VF function number overflows.
>>
>> I think the cause of this error is that virtio-net-pci PFs don't have 
>> ARI.
>> (pcie_ari_init is not added to virtio-net-pci when PFs are initialized.)
>> I think it is possible to add it later,
>> but how about adding pcie_ari_init ?
>>
>> As a trial,
>> adding pcie_ari_init to virtio_pci_realize enabled the creation of 
>> more than 8 VFs.
>
> I have just looked into that possibility, but adding pcie_ari_init to 
> virtio_pci_realize has some implications. Unconditionally calling 
> pcie_ari_init will break the existing configuration of virtio-pci 
> devices so we need to implement some logic to detect when ARI is 
> needed. Preferably such logic should be implemented in the common PCI 
> infrastructure instead of implementing it in virtio-pci so that other 
> PCI multifunction devices can benefit from it.
>
> While I don't think implementing this will be too complicated, I need 
> to ensure that such a feature is really needed before doing so.


OK.
I want to use this emulation for offloading virtual network
in a environment where there are many containers in VMs.
So, I consider that the feature is need.
I think that 7 VFs are too few.
I'll keep thinking about the feature's necessity.


I'll add other comments to RFC v5 patch.


Regards,

Yui Washizu


