Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C9A2C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 13:24:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reaxA-0007aB-4r; Mon, 26 Feb 2024 08:23:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1reax6-0007Xp-26; Mon, 26 Feb 2024 08:23:28 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1reax3-0001LV-Ou; Mon, 26 Feb 2024 08:23:27 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 9D5B04E601E;
 Mon, 26 Feb 2024 14:23:21 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id Zo-oWZwN0tO2; Mon, 26 Feb 2024 14:23:19 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id A17BF4E6005; Mon, 26 Feb 2024 14:23:19 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 9F97B7456B4;
 Mon, 26 Feb 2024 14:23:19 +0100 (CET)
Date: Mon, 26 Feb 2024 14:23:19 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, Bernhard Beschow <shentey@gmail.com>, 
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>, qemu-block@nongnu.org, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Eduardo Habkost <eduardo@habkost.net>, John Snow <jsnow@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH v2 08/15] hw/pci-bridge: Extract QOM ICH definitions to
 'ich9_dmi.h'
In-Reply-To: <e8389171-1ae7-4955-9b5b-ac0ad261654b@linaro.org>
Message-ID: <d65ee3cc-70f1-b0f4-0fd2-8c50b369556d@eik.bme.hu>
References: <20240226111416.39217-1-philmd@linaro.org>
 <20240226111416.39217-9-philmd@linaro.org>
 <5bab87f9-aeee-3aa5-d695-4fa2128130a1@eik.bme.hu>
 <e8389171-1ae7-4955-9b5b-ac0ad261654b@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1177737100-1708953799=:37179"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--3866299591-1177737100-1708953799=:37179
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 26 Feb 2024, Philippe Mathieu-Daudé wrote:
> On 26/2/24 14:01, BALATON Zoltan wrote:
>> On Mon, 26 Feb 2024, Philippe Mathieu-Daudé wrote:
>>> Expose TYPE_ICH_DMI_PCI_BRIDGE to the new
>>> "hw/pci-bridge/ich9_dmi.h" header.
>> 
>> Since this is effectively an empty object (that's not even instantiated by 
>> default) I still think that instead of adding even more files for it all 
>> this could just be moved to hw/isa/lpc_ich9.c and define there as an 
>> internal object and drop the OBJECT_DECLARE_SIMPLE_TYPE(I82801b11Bridge, 
>> ICH_DMI_PCI_BRIDGE) and just use the size of the superclass as it's 
>> instance size. That just adds the realize function and a type definition 
>> and gets rid of boilerplate scattered around the source tree which just 
>> adds complexity for no reason. But I don't care too much about it, just 
>> wanted to say again that if something can be kept simple I'd prefer that 
>> over making it more complex and for this device it looks already too 
>> complex for what it does or used for.
>
> My understanding was project coherency and style is preferred over
> simplifications / optimizations, so we prefer explicit TYPE_FOO
> and corresponding OBJECT_DECLARE_XXX() in a public include/hw/foo
> header -- because it will end up copy/pasted --, but I might be
> wrong.

For classes that are actually used that may be true but this class isn't 
used anywhere just defined for the user to be instantiated from command 
line or config. So you won't even need a type name in code currently. It's 
also an internal part of ICH southbridge so no need to be exposed outside 
of that as it's only useful within that chip. Finally it has no 
functionality, just an empty boilerplate so that the device appears in 
lspci output but it does nothing. Therefore, I think it's simpler to just 
move all of it within the same file where the southbridge is implemented 
and define as empty object there like the via-mc97 device in 
hw/audio/via-ac97.c which serves the same purpose to show the part to the 
guest but its empty device without function. That would save half of all 
this boilerplate that just adds complexity now. If sometimes in the future 
this device gains some functionality then it can be split off and add all 
the defines and stuff around it but that's not needed yet so why not keep 
it simple?

Regards,
BALATON Zoltan
--3866299591-1177737100-1708953799=:37179--

