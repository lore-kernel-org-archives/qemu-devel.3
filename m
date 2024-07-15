Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF588C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 05:16:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTE3c-00037E-VK; Mon, 15 Jul 2024 01:15:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sTE3X-00035u-Ky
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 01:15:25 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sTE3V-0006d1-G4
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 01:15:23 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2caaae31799so2794305a91.0
 for <qemu-devel@nongnu.org>; Sun, 14 Jul 2024 22:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1721020519; x=1721625319;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EQ3tdCobcBnF3rwxSrCSaF3bdLjYlA3SwLoJDP/4cFQ=;
 b=oIQ9WFoSr/RGPHaeO+WF2ykkqobMcq8ErDKkYStvTSgq2roN0lF6XmwtsCeAHVrzeu
 a14k6633rzqqtmVBgGvWG9/IYLdZAVp5fujJxTG1z1XteJ8fijmN9zJDh4HY88C8EXmC
 IsRNOD8EOit7CaUTsgDgBxKyHR/6VsEjS8raGm3YfUQFRSYgKF20rehZVHM3bApoPGL4
 yWMawPqfLtAOydj0yqgqXg+NpOu4XRkPhOxyda/JyJ1uH5yRiS25+Z0Jkcshl0yMLZb+
 I6n570HBp7n/rQQPzqiotJk4T92EULdqnqDdzPqMk+hXMWO9MVes6H56Pasy2KC56MqD
 kFxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721020519; x=1721625319;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EQ3tdCobcBnF3rwxSrCSaF3bdLjYlA3SwLoJDP/4cFQ=;
 b=mtyzcQRUxeg0PpOLLx7yV4Du4owJdjXsaXVfbOY5uZoIJIBX+CN2y9OkD8FI1+TqUU
 Jqt06oNW84aNQov6j+LBSFqRDr9us4p2I7czl+NP59yyMZOHjDMyTmGAVAs1x2aQJmsZ
 FirxNLUnPyms9YWXbQT+5jTn2e+mikXwIzqpLu2y/bs31zqLStoBA0wfXgSdr2BBAMqK
 OUjmwcxZ2WgG5KaRNY4Co4F6ccCPyunHQvteCbRPRGJ/LemaRAqwUSmkqmDNsOut5FaL
 W754rt/n/11uI09cXUFmSRK8V3/y3/apXckg3cRTjzjvoGA+TfnxQtJB/wyMus4Y21GW
 0VHw==
X-Gm-Message-State: AOJu0Yx7bvIXIhod4y7thfBAikTJlI3dhm6B+sBvYpXCi10lEG2+W1fN
 Gm3bDnvNRwFBRinkFlK1L5ulllRhL3N6zEarTLPfMEybPr0RdjU8RJLzbrOJV80=
X-Google-Smtp-Source: AGHT+IEgl1UPxdkc55sz+aenx5+OOEg2+5RfisqLt/dpPGfLE3vRNJdi5Gia5EX8v7TSs0GeqqzPvw==
X-Received: by 2002:a17:90a:3882:b0:2c9:93a3:1db6 with SMTP id
 98e67ed59e1d1-2ca35c30e36mr15377292a91.11.1721020519230; 
 Sun, 14 Jul 2024 22:15:19 -0700 (PDT)
Received: from [157.82.204.135] ([157.82.204.135])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2caedbf71f1sm3400111a91.16.2024.07.14.22.15.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 14 Jul 2024 22:15:18 -0700 (PDT)
Message-ID: <88ffcfa0-f3c4-406c-ac79-456b0f8b38bd@daynix.com>
Date: Mon, 15 Jul 2024 14:15:15 +0900
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
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <966b756c-f4b9-40da-ad35-ddb7c6e7da50@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::102f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102f.google.com
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

On 2024/05/16 11:00, Yui Washizu wrote:
> 
> On 2024/04/28 18:05, Akihiko Odaki wrote:
>> Based-on: <20240315-reuse-v9-0-67aa69af4d53@daynix.com>
>> ("[PATCH for 9.1 v9 00/11] hw/pci: SR-IOV related fixes and 
>> improvements")
>>
>> Introduction
>> ------------
>>
>> This series is based on the RFC series submitted by Yui Washizu[1].
>> See also [2] for the context.
>>
>> This series enables SR-IOV emulation for virtio-net. It is useful
>> to test SR-IOV support on the guest, or to expose several vDPA devices
>> in a VM. vDPA devices can also provide L2 switching feature for
>> offloading though it is out of scope to allow the guest to configure
>> such a feature.
>>
>> The PF side code resides in virtio-pci. The VF side code resides in
>> the PCI common infrastructure, but it is restricted to work only for
>> virtio-net-pci because of lack of validation.
>>
>> User Interface
>> --------------
>>
>> A user can configure a SR-IOV capable virtio-net device by adding
>> virtio-net-pci functions to a bus. Below is a command line example:
>>    -netdev user,id=n -netdev user,id=o
>>    -netdev user,id=p -netdev user,id=q
>>    -device pcie-root-port,id=b
>>    -device virtio-net-pci,bus=b,addr=0x0.0x3,netdev=q,sriov-pf=f
>>    -device virtio-net-pci,bus=b,addr=0x0.0x2,netdev=p,sriov-pf=f
>>    -device virtio-net-pci,bus=b,addr=0x0.0x1,netdev=o,sriov-pf=f
>>    -device virtio-net-pci,bus=b,addr=0x0.0x0,netdev=n,id=f
>>
>> The VFs specify the paired PF with "sriov-pf" property. The PF must be
>> added after all VFs. It is user's responsibility to ensure that VFs have
>> function numbers larger than one of the PF, and the function numbers
>> have a consistent stride.
> 
> 
> I tried to start a VM with more than 8 VFs allocated using your patch,
> but the following error occured and qemu didn't work:
> VF function number overflows.
> 
> I think the cause of this error is that virtio-net-pci PFs don't have ARI.
> (pcie_ari_init is not added to virtio-net-pci when PFs are initialized.)
> I think it is possible to add it later,
> but how about adding pcie_ari_init ?
> 
> As a trial,
> adding pcie_ari_init to virtio_pci_realize enabled the creation of more 
> than 8 VFs.

I have just looked into that possibility, but adding pcie_ari_init to 
virtio_pci_realize has some implications. Unconditionally calling 
pcie_ari_init will break the existing configuration of virtio-pci 
devices so we need to implement some logic to detect when ARI is needed. 
Preferably such logic should be implemented in the common PCI 
infrastructure instead of implementing it in virtio-pci so that other 
PCI multifunction devices can benefit from it.

While I don't think implementing this will be too complicated, I need to 
ensure that such a feature is really needed before doing so.

