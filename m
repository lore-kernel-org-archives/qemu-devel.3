Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74280CAC582
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 21:07:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uw5XK-0007Ww-E1; Tue, 09 Sep 2025 17:05:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tpearson@raptorengineering.com>)
 id 1uw5XC-0007W3-M2; Tue, 09 Sep 2025 17:05:50 -0400
Received: from mail.raptorengineering.com ([23.155.224.40]
 helo=raptorengineering.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tpearson@raptorengineering.com>)
 id 1uw5X7-0003UK-57; Tue, 09 Sep 2025 17:05:50 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rptsys.com (Postfix) with ESMTP id 1FC2F828820F;
 Tue,  9 Sep 2025 16:05:31 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
 by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id C53sclFQTJ_4; Tue,  9 Sep 2025 16:05:28 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.rptsys.com (Postfix) with ESMTP id E52518288261;
 Tue,  9 Sep 2025 16:05:27 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com E52518288261
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
 t=1757451927; bh=pcb2EotGYn9Yw6u0qBIDErjWZ9LHsFuT0G031z+FEoU=;
 h=Date:From:To:Message-ID:MIME-Version;
 b=uoY0e9xsovbN7xUukC/Moj7Gl5ulDC+pC0/lHyj4Hn4xvXtKqHANZfzO/TTIOyERN
 hz+2Q6kRmAKQMX5ecu4b604an7A+6pVTt0EHeJGqJNyyzzvRwLoUszuJWaOhZiBgvu
 P9B07tNoavXhB16uC1K10mk0BBw/wHxLj/U+3jOo=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
 by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 28JjgZCZjtrQ; Tue,  9 Sep 2025 16:05:27 -0500 (CDT)
Received: from vali.starlink.edu (localhost [127.0.0.1])
 by mail.rptsys.com (Postfix) with ESMTP id AE94C828820F;
 Tue,  9 Sep 2025 16:05:27 -0500 (CDT)
Date: Tue, 9 Sep 2025 16:05:25 -0500 (CDT)
From: Timothy Pearson <tpearson@raptorengineering.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 "list@suse.de" <qemu-ppc@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, 
 Frederic Barrat <fbarrat@linux.ibm.com>, npiggin <npiggin@gmail.com>, 
 David Gibson <david@gibson.dropbear.id.au>
Message-ID: <1601363295.1707586.1757451924995.JavaMail.zimbra@raptorengineeringinc.com>
In-Reply-To: <2125253552.30561871.1713198808922.JavaMail.zimbra@raptorengineeringinc.com>
References: <1891893257.448156.1647023745384.JavaMail.zimbra@raptorengineeringinc.com>
 <6f0a92ca-9f53-b8b8-e85d-43f4da36200d@kaod.org>
 <edfa8ca4-8e8a-335a-2e7e-c69661ec73da@ozlabs.ru>
 <560c8c1a-a87e-71f9-cfea-0a034933070b@ozlabs.ru>
 <e25296b3-b1ec-a90a-ee72-ed15fe5130f6@kaod.org>
 <5308af13-a943-efeb-d819-e39cfc2f2907@ozlabs.ru>
 <3e188eb4-40dd-952c-9764-4cc8cb255f01@kaod.org>
 <2125253552.30561871.1713198808922.JavaMail.zimbra@raptorengineeringinc.com>
Subject: Re: XIVE VFIO kernel resample failure in INTx mode under heavy load
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.5.0_GA_3042 (ZimbraWebClient - GC139 (Linux)/8.5.0_GA_3042)
Thread-Topic: XIVE VFIO kernel resample failure in INTx mode under heavy load
Thread-Index: deIr1MHtwC5ZXfgisgYC7lwKFkKupHii3cau
Received-SPF: pass client-ip=23.155.224.40;
 envelope-from=tpearson@raptorengineering.com; helo=raptorengineering.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



----- Original Message -----
> From: "Timothy Pearson" <tpearson@raptorengineering.com>
> To: "C=C3=A9dric Le Goater" <clg@kaod.org>
> Cc: "Alexey Kardashevskiy" <aik@ozlabs.ru>, "Alex Williamson" <alex.willi=
amson@redhat.com>, "Timothy Pearson"
> <tpearson@raptorengineering.com>, "list@suse.de" <qemu-ppc@nongnu.org>, "=
qemu-devel" <qemu-devel@nongnu.org>, "Frederic
> Barrat" <fbarrat@linux.ibm.com>, "npiggin" <npiggin@gmail.com>, "David Gi=
bson" <david@gibson.dropbear.id.au>
> Sent: Monday, April 15, 2024 11:33:28 AM
> Subject: Re: XIVE VFIO kernel resample failure in INTx mode under heavy l=
oad

> ----- Original Message -----
>> From: "C=C3=A9dric Le Goater" <clg@kaod.org>
>> To: "Alexey Kardashevskiy" <aik@ozlabs.ru>, "Alex Williamson"
>> <alex.williamson@redhat.com>, "Timothy Pearson"
>> <tpearson@raptorengineering.com>
>> Cc: "list@suse.de:PowerPC" <qemu-ppc@nongnu.org>, "qemu-devel"
>> <qemu-devel@nongnu.org>, "Frederic Barrat"
>> <fbarrat@linux.ibm.com>, "npiggin" <npiggin@gmail.com>, "David Gibson"
>> <david@gibson.dropbear.id.au>
>> Sent: Thursday, April 21, 2022 1:35:50 AM
>> Subject: Re: XIVE VFIO kernel resample failure in INTx mode under heavy =
load
>=20
>> On 4/21/22 05:07, Alexey Kardashevskiy wrote:
>>>=20
>>>=20
>>> On 14/04/2022 22:41, C=C3=A9dric Le Goater wrote:
>>>>
>>>>>> After re-reading what I just wrote, I am leaning towards disabling u=
se of
>>>>>> KVM_CAP_IRQFD_RESAMPLE as it seems last worked on POWER8 and never s=
ince :)
>>>>>>
>>>>>> Did I miss something in the picture (hey Cedric)?
>>>>>
>>>>> How about disabling it like this?
>>>>>
>>>>> =3D=3D=3D=3D=3D
>>>>> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
>>>>> index 5bfd4aa9e5aa..c999f7b1ab1b 100644
>>>>> --- a/hw/ppc/spapr_pci.c
>>>>> +++ b/hw/ppc/spapr_pci.c
>>>>> @@ -732,7 +732,7 @@ static PCIINTxRoute spapr_route_intx_pin_to_irq(v=
oid
>>>>> *opaque, int pin)
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SpaprPhbState *sphb =3D SPAPR_PCI_HOST=
_BRIDGE(opaque);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PCIINTxRoute route;
>>>>>
>>>>> -=C2=A0=C2=A0=C2=A0 route.mode =3D PCI_INTX_ENABLED;
>>>>> +=C2=A0=C2=A0=C2=A0 route.mode =3D PCI_INTX_DISABLED;
>>>>>
>>>>> =3D=3D=3D=3D=3D
>>>>
>>>> I like it.
>>>=20
>>>=20
>>> The only thing is that this resampling works on POWER8/XICS and
>>> removing it there is not great. So far sPAPR PHB was unaware of
>>> underlying interrupt controller, or was not it?
>>=20
>> It is. The dynamic change of the underlying irqchip in QEMU and
>> in KVM required that for CAS. Of course, plenty is done in the
>> back of the devices when this happens, see spapr_irq.
>>=20
>> There are some quirks related to LPM with VIO devices in Linux.
>> This is the only case I know about.
>>=20
>> Thanks,
>>=20
>> C.
>=20
> Unfortunately this remains quite broken, and after a kernel upgrade (incl=
uding
> the purported fix [1]) and a qemu upgrade we have now completely lost the
> ability to get the card working in the guest with *any* combination of
> parameters.
>=20
> In guest XIVE mode with irqchip on it passes through a handful of interru=
pts,
> then dies.  In guest XICS mode we're dropping the majority of the interru=
pts.
> This is all on POWER9.

To close the loop on this, it looks like the issue was a corner case in a s=
eries of bridged legacy PCI 2.2 devices, and that the remaining issues were=
 the result of a specific interaction between the INTx hardware and INTx gu=
est mode devices. [1]  PCI 2.3+ and PCIe devices use a different interrupt =
signalling mechanism (INTx with DisINTx+, or MSI), and would not be affecte=
d.

With the linked patch, XIVE on XIVE works fairly well, even with the legacy=
 PCI 2.2 devices.

The one remaining issue is that we tend to generate a lot of spurious IRQs =
due to all of the INTx handshaking between the host and guest XIVEs; if the=
 H_INT_ESB hypercall is issued by the guest before the VFIO interrupt is ac=
knowledged by QEMU (i.e. while the emulated INTx line is still asserted and=
, thus, the host INTx line is still masked), we get an extra unwanted INTx =
IRQ generated in the guest.  This is mostly harmless aside from causing the=
 spurious interrupt counters to increase, but as it is apparently caused by=
 a race condition between guest IRQ completion and host QEMU VFIO acknowled=
ge it doesn't look particularly simple to fix.

[1] https://lore.kernel.org/linuxppc-dev/663798478.1707537.1757450926706.Ja=
vaMail.zimbra@raptorengineeringinc.com/T/#u

