Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EDD9C282CD
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 15:27:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp7gX-0006hI-L4; Mon, 03 Mar 2025 10:26:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tp7gU-0006gd-T2
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 10:26:23 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tp7gS-00058I-65
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 10:26:22 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id BFDBE4E601D;
 Mon, 03 Mar 2025 16:26:14 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id VlpIhAGIx-sm; Mon,  3 Mar 2025 16:26:12 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id C4C5D4E6010; Mon, 03 Mar 2025 16:26:12 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C201C74577C;
 Mon, 03 Mar 2025 16:26:12 +0100 (CET)
Date: Mon, 3 Mar 2025 16:26:12 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
cc: Paolo Bonzini <pbonzini@redhat.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Tony Krowiak <akrowiak@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
 Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH 1/2] vfio: Make vfio-pci available on 64-bit host platforms
 only
In-Reply-To: <b2075e91-79ca-4d5f-b13b-151f2a59181d@redhat.com>
Message-ID: <8e3a5810-accf-1f77-8692-4e077c3ce327@eik.bme.hu>
References: <20250226084721.232703-1-clg@redhat.com>
 <20250226084721.232703-2-clg@redhat.com>
 <a39e97c2-c6fd-34e4-f91b-b3491185b789@eik.bme.hu>
 <c60b7780-5b3f-43a0-a7f1-30820d4e6fb8@redhat.com>
 <bb7c2adf-f146-50c7-7716-c1ee7b606b01@eik.bme.hu>
 <aa01f3dd-e3ac-4ee5-87b4-8133103bd000@linaro.org>
 <270cc189-e3b2-4bf4-b32b-8655be51bcb4@redhat.com>
 <b2075e91-79ca-4d5f-b13b-151f2a59181d@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1909933127-1741015572=:78201"
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1909933127-1741015572=:78201
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 3 Mar 2025, Cédric Le Goater wrote:
> On 3/3/25 15:46, Paolo Bonzini wrote:
>> On 3/3/25 15:30, Philippe Mathieu-Daudé wrote:
>>>>>> I see PPC is defined in target/ppc/Kconfig so I think these mark the 
>>>>>> target not the host. Vfio-pci works with qemu-system-ppc 
>>>> 
>>>> I've seen people do this on x86_64 host
>>> 
>>> Since this patch does:
>>> 
>>>    LINUX && PCI && (...  X86_64 ...)
>>> 
>>> these users won't see any change.
>> 
>> This is wrong---clearly this patch was never tested on the 32-bit platforms 
>> where it was supposed to have an effect.
>
> euh it was.
>
> With this patch, on 32-bit and 64-bit host systems :
>
>  # build/qemu-system-i386 -device vfio-pci,?
>  # qemu-system-i386: -device vfio-pci,?: Device 'vfio-pci' not found
>
> Same for qemu-system-ppc and qemu-system-arm
>
> What I am doing wrong ?

These QEMU targets aren't deprecated, compiling QEMU on 32 bit hosts is. 
But you can still use qemu-system-i386 and qemu-system-ppc on 64 bit 
hosts and vfio-pci works with these so it should not be disabled when 
building these QEMU targets. I think you meant to do something else not 
what this patch does.

Regards,
BALATON Zoltan
--3866299591-1909933127-1741015572=:78201--

