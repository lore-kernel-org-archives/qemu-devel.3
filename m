Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E071AC0218F
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 17:56:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdCHD-0004lL-RN; Wed, 29 Jan 2025 12:54:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tdCH8-0004ke-Pz; Wed, 29 Jan 2025 12:54:55 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tdCH5-0005ys-Tv; Wed, 29 Jan 2025 12:54:54 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7A3114E6027;
 Wed, 29 Jan 2025 18:54:48 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id T1c9ff6ZTSRK; Wed, 29 Jan 2025 18:54:46 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 6C4F14E6014; Wed, 29 Jan 2025 18:54:46 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 6A41A74577C;
 Wed, 29 Jan 2025 18:54:46 +0100 (CET)
Date: Wed, 29 Jan 2025 18:54:46 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Bernhard Beschow <shentey@gmail.com>
cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>, 
 Alistair Francis <alistair@alistair23.me>, 
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: Re: [PATCH 09/21] hw/arm/fsl-imx8mp: Add PCIe support
In-Reply-To: <137C0579-19AB-4D92-82DC-6CBE2422AD6A@gmail.com>
Message-ID: <f2172469-5935-414e-b4a9-bf61055b6fff@eik.bme.hu>
References: <20250120203748.4687-1-shentey@gmail.com>
 <20250120203748.4687-10-shentey@gmail.com>
 <CAFEAcA9efWMDxaTCfa6t8MiCgFUEU+nsyurNOqVDxAa9=KS=-Q@mail.gmail.com>
 <137C0579-19AB-4D92-82DC-6CBE2422AD6A@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 28 Jan 2025, Bernhard Beschow wrote:
> Am 28. Januar 2025 14:33:14 UTC schrieb Peter Maydell <peter.maydell@linaro.org>:
>> On Mon, 20 Jan 2025 at 20:38, Bernhard Beschow <shentey@gmail.com> wrote:
>>>
>>> Linux checks for the PLLs in the PHY to be locked, so implement a model
>>> emulating that.
>>>
>>> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
>>
>>> diff --git a/docs/system/arm/imx8mp-evk.rst b/docs/system/arm/imx8mp-evk.rst
>>> index 1514bc5864..8d48580cb4 100644
>>> --- a/docs/system/arm/imx8mp-evk.rst
>>> +++ b/docs/system/arm/imx8mp-evk.rst
>>> @@ -14,6 +14,7 @@ The ``imx8mp-evk`` machine implements the following devices:
>>>   * Generic Interrupt Controller (GICv3)
>>>   * 4 UARTs
>>>   * 3 USDHC Storage Controllers
>>> + * 1 Designware PCI Express Controller
>>>   * Secure Non-Volatile Storage (SNVS) including an RTC
>>>   * Clock Tree
>>>
>>> @@ -62,3 +63,15 @@ Now that everything is prepared the newly built image can be run in the QEMU
>>>        -dtb imx8mp-evk-patched.dtb \
>>>        -append "root=/dev/mmcblk2p2" \
>>>        -drive file=sdcard.img,if=sd,bus=2,format=raw,id=mmcblk2
>>> +
>>> +Using PCI Devices
>>> +-----------------
>>> +
>>> +The PCI Express controller spawns two PCI buses, of which only one can be used.
>>> +By default QEMU assigns the wrong bus, so the correct one has to be specified
>>> +manually by adding ``bus=dw-pcie``. For example, when adding an Intel e1000
>>> +network card, the command line looks like:
>>> +
>>> +.. code-block:: bash
>>> +
>>> +  $ qemu-system-aarch64 -M imximp-evk ... -device virtio-net-pci,bus=dw-pcie
>>
>> Why does this happen? Isn't there some way to make QEMU default to
>> using the right bus? Otherwise there's likely to be a lot of
>> user confusion because PCI "doesn't work"...
>
> Yeah, this is really confusing and I forget about it myself. I'd appreciate any hints here.

I'm not sure but I think the PCI bus created last will be used by default 
so maybe swapping the order these are created may help.

Regards,
BALATON Zoltan

> Best regards,
> Bernhard
>
>>
>> thanks
>> -- PMM
>
>

