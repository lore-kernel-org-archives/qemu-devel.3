Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B434EC25B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 13:35:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBwyK-0005cd-CR; Tue, 28 May 2024 09:34:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1sBwyH-0005cJ-Mi; Tue, 28 May 2024 09:34:33 -0400
Received: from mout.gmx.net ([212.227.15.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1sBwyF-0000yJ-Pv; Tue, 28 May 2024 09:34:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1716903257; x=1717508057; i=deller@gmx.de;
 bh=aHeQAaqrHt5WPj+oz7KinDv/0qQ7dmCEeBIc2t/XnHA=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=OYCFZb/IKtS18y4UZPuSuYPvW6ZjqKFAjj6S3ceZCe9AqDDyaGOEiFcyusgHpjBW
 864o4PU5iG3o5YYoy5a/PkT4UFrKjYSdXQHbp/WI/WkzRKgFak68cvX1qALHEvJY/
 CPNHb7nwTvafIlDW8sS7n2tjliaZTnaIzalwoCKhJk/GOCuRI2T1roWQGz6NeOJ7b
 o4GNrlq00tjUxW1KvylIlqpKkldFACR9Djwyp4eO8BWQDpWRfO4YyotO4VswFF6EW
 J+Cym0YYr+oo/gPySZ0DXwYI2X7Jo51fRYj1FjB3/DWdS93TPok/LIWIytgl3DetV
 IpsvhZdgAJnNs5quXA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([83.135.217.92]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MJmGZ-1rwCIa0tMP-00KA4u; Tue, 28
 May 2024 15:34:17 +0200
Message-ID: <c0eef58e-06b7-4e82-82bb-0117da9b9bd8@gmx.de>
Date: Tue, 28 May 2024 15:34:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] usb/ohci-pci: deprecate, don't build by default
To: Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20240528095459.896594-1-kraxel@redhat.com>
 <20240528095459.896594-4-kraxel@redhat.com>
 <8fa84896-f534-4d2e-8b00-057514a7de03@redhat.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <8fa84896-f534-4d2e-8b00-057514a7de03@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JjwnrMaoHb551ivpzu5FxrA+DMyeoxFWkMv4ob4+kA7kf8aNiW9
 zewE3wvUAQlOwZ3obE2HgwbweV0UaexZdSHeUtySfBWQmOGUGKEl3ECwGW5+oya0dadfDi+
 zODWY2Io0KF7gplqvDUE2561w2LtWeLhBTnmeFKobuTDXNCYd1dVInHqpODITJApAoldjiH
 g4pJkaYM/1mJew92WMfGg==
UI-OutboundReport: notjunk:1;M01:P0:cLJ2UCQVBtI=;+LMSDk9DZmkk8IVs/jTACtKyzn7
 rZi0H1EDll7mkrpaAsC4EkKeEm7Xq0q1BLkNooy2ZAcpi6rT0TtLPjh6acmKWsbT2FDGn8xZx
 gb1ZCWirTlrnBGLvaehEzuTY7P6J4VHTzVkNC3t35/Wg6EfKpcz0z1dbh/4Qlbouvwrk9OT4P
 VXoYx8APq25Q8hl1w7CNzl99/DrbNHylS6Mbd3ZX4TqVZhMPr9dlQ5eH3lllGhAdOAfNzCBuZ
 PCZhSejEaVc7LryLvmBelVLlIeW6no+4llhV/jBY/0DOxZNZ6okSHefmZ3C8tj0qM5iY9VBuq
 ovLcfMc6i1w6lHEdpTrZUqt7K1rPOaCP9l8U6BZLBhyk3BACRkxItgpWOwkiD2nETf7H2cRu2
 RLWXzSD24dId0M0cnBaCYkkUT8P0KckmPyEjUG6UQpd7twiNNKTOggVP2qgoMhlJqdsDLtJJp
 W1QUeFb7gPRyXbUoq0FOw56XqwFfM9bnWI0S6xeBfRxHym1wusCMtNpqZUGVwpdQ35jnFpomL
 smi7usJDZdZBe98AXawGBhJ5avtu5H9cefOID3CeWI5B4x2pr+Cd9IZ3woxGoKjXvqxXKn+Lv
 GqsU70q8o6Trel1f3S3wDvC7zzJnufjR2SKrCB/ZEuNwELBVjTtEjBzVqR1OFWKgEguG2zZib
 HdL+IX9JzU22uI5LnoaRW8DbH+C/U+cpqm+yjr1rXzanXwOvOekZzmzZaXQCyoKlIAjvQ9+ck
 QOzc2cINeyy3BUvwkcjrWYAKUQjCB5YcCLM8W67Opyvqh7DMDYW4wvXuNaWSMtMcGgloBt7DW
 E+Q0Rib2ofYa0ibKRt1OFEajUUUoMUpGtvatii5bxXmag=
Received-SPF: pass client-ip=212.227.15.18; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 5/28/24 12:35, Thomas Huth wrote:
> On 28/05/2024 11.54, Gerd Hoffmann wrote:
>> The xhci host adapter is the much better choice.
>>
>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>> ---
>> =C2=A0 hw/usb/hcd-ohci-pci.c | 1 +
>> =C2=A0 hw/usb/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1 -
>> =C2=A0 2 files changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/usb/hcd-ohci-pci.c b/hw/usb/hcd-ohci-pci.c
>> index 33ed9b6f5a52..88de657def71 100644
>> --- a/hw/usb/hcd-ohci-pci.c
>> +++ b/hw/usb/hcd-ohci-pci.c
>> @@ -143,6 +143,7 @@ static void ohci_pci_class_init(ObjectClass *klass,=
 void *data)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dc->hotpluggable =3D false;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dc->vmsd =3D &vmstate_ohci;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dc->reset =3D usb_ohci_reset_pci;
>> +=C2=A0=C2=A0=C2=A0 klass->deprecation_note =3D "use qemu-xhci instead"=
;
>> =C2=A0 }
>> =C2=A0 static const TypeInfo ohci_pci_info =3D {
>> diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig
>> index 84bc7fbe36cd..c4a6ea5a687f 100644
>> --- a/hw/usb/Kconfig
>> +++ b/hw/usb/Kconfig
>> @@ -17,7 +17,6 @@ config USB_OHCI_SYSBUS
>> =C2=A0 config USB_OHCI_PCI
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool
>> -=C2=A0=C2=A0=C2=A0 default y if PCI_DEVICES
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 depends on PCI
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select USB_OHCI
>
> Not sure whether we should disable it by default just because it is depr=
ecated. We don't do that for any other devices as far as I know.
>
> Anyway, you should add the device to docs/about/deprecated.rst to really=
 mark it as deprecated, since that's our official list (AFAIK).
>
> Also, there are still some machines that use this device:
>
> $ grep -r USB_OHCI_PCI *
> hw/hppa/Kconfig:=C2=A0=C2=A0=C2=A0 imply USB_OHCI_PCI
> hw/mips/Kconfig:=C2=A0=C2=A0=C2=A0 imply USB_OHCI_PCI
> hw/ppc/Kconfig:=C2=A0=C2=A0=C2=A0 imply USB_OHCI_PCI
> hw/ppc/Kconfig:=C2=A0=C2=A0=C2=A0 imply USB_OHCI_PCI
>
> pseries could certainly continue without OHCI AFAICT, but the others? Ma=
ybe this needs some discussion first... (thus putting some more people on =
CC:)

There was never a XHCI host on any of the hppa machines, but
the latest generation of HP machines do have built-in OHCI controllers.
So, deprecating OHCI in favor of XHCI will prevent emulation of HP-UX
on the hppa target.
So, for hppa the "xhci host adapter is NOT the much better choice.".

Helge

