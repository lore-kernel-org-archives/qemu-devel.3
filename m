Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F919C624D3
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2026 12:46:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2pmC-0003iZ-TN; Sat, 05 Sep 2026 08:45:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1x2pmA-0003hm-0q; Sat, 05 Sep 2026 08:45:42 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1x2pm6-0007c3-33; Sat, 05 Sep 2026 08:45:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=YkjcjKmiHVI2Nkv/26u3ssl/h0M5IaTbKeJMyDsJT/0=; b=A+xoInWv7cW5y+NumXglBKtskP
 SqV7pc+BMyEWdKkhj19wnidDTAjE9bSKOIZ8G9ei8zuNQl8sjhN3W2ifq6AbhbA8wmB9N0AwSG3pH
 t07jSPmCFjSAP41T6Rt1Za0q1qXFk7eRGCJ1E04bHHM/GLgjwBDQkqmRrHeStHfG6bsQ31AVG01Wg
 X7LoO3ajqXHUi8C1LOsYBB6ns5P86zcZNu5l+gonMT4ptJE8NE6r8+KjIRYGrG4mXbRXJ4fyjhyCE
 eXOPaG1lT2qax+Bwyk7cv5UUWAUL1GwzDrG2k7Rz8wJOAsWR18uz7gEsu7coyfIiJSH7a4AbimNT1
 1gTxmc/gm5QXw76W6m1bjt1vt6m4RKJOs+DdQKsLdpofbJBOZN38Y24oPsBaLDl7Fdeww7pMTbXSf
 7M7VyVvAxHcwNh9xDbrIis39NlBY7NeyrlenLLvWfFhGj4UckfBi59H1M+efCGPfxy1bnD5+v43Sw
 hwVn5MAE16Vu03qq/E8PEmP1/h+V+sLFVo80Vfc8InAH72+8zEMsFcokCpwLyr4x3jO9oaHCwt4Li
 6ltVFW5q3AJbtxqaE/bbSCP9pRKNjR+tfjrpm9zjU0PNG7daS2v878xbkwSwWPaNZ0LbX73rJer9U
 UNC53w+KmvRP7/qZGLL7Lz+sZ5xZOGqk2CVLhxNX8=;
Received: from [2a02:8012:2f01:0:fe49:60b9:9856:b8ef]
 by mail.ilande.co.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1x2plL-00CMJ3-VK; Sat, 05 Sep 2026 13:44:52 +0100
Message-ID: <bdbdec6f-91a6-4c70-a818-ef2b1fbe4ad5@ilande.co.uk>
Date: Sat, 5 Sep 2026 13:45:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Emmanuel Blot <emmanuel.blot@free.fr>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 qemu-arm@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Emmanuel Blot <eblot@meta.com>, Markus Armbruster <armbru@redhat.com>
References: <20260731-sanmiguel-bmc-locator-v2-0-1266926ba769@free.fr>
 <20260731-sanmiguel-bmc-locator-v2-18-1266926ba769@free.fr>
 <cb1b5ec3-d7ba-42fe-a8ab-da7c236b1660@kaod.org>
Content-Language: en-US
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 xsBNBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAHNME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPsLA
 eAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63M7ATQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABwsBfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
In-Reply-To: <cb1b5ec3-d7ba-42fe-a8ab-da7c236b1660@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:fe49:60b9:9856:b8ef
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: Adding /machines/labels (was Re: [PATCH v2 18/25]
 tests/functional: add a pure-Python device-locator resolver)
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 03/09/2026 15:21, Cédric Le Goater wrote:

> On 7/31/26 12:45, Emmanuel Blot wrote:
>> Add DeviceLocator, a helper that addresses a device by its position on
>> the bus -- bus, address, type or index -- rather than by a QOM path. A
>> QOM path locates a device under the object that owns it, by enumeration
>> order, and so says nothing about where the device actually sits in the
>> bus topology. From a QOM anchor DeviceLocator instead walks the bus and
>> device hierarchy, alternating bus and device hops, to reach the target.
>>
>> It relies only on standard QOM queries over QMP, needing no custom
>> commands or changes to QEMU.
> 
> Let's recap first :
> 
> Several recent threads have touched the same topic: QOM
> composition-tree paths encode ownership, but developers and tests
> regularly need to identify devices by their position in the bus
> topology. The threads in question:
> 
>    - "[PATCH v5 0/8] hw/sensor: Add new device emulation for TI ADC128D818" [1]
>    - "Call to clean up QOM onboard devices lacking a parent" [2]
>    - "[PATCH RFC 001/134] qom: Introduce object_new_child()" [3]
>    - "[PATCH RFC v2 0/137] qom: Make composition-tree parenting mandatory" [4]
>    - "[PATCH v2 0/25] hw/arm: Facebook SanMiguel BMC and TMP75-family sensors" [5]
> 
> 
> * The problem
> 
> QEMU has two device hierarchies serving different purposes:
> 
>    - The QOM composition tree describes parent/child ownership.  Every
>      object has exactly one parent. Paths look like:
>      /machine/soc/i2c-controller/child-device.
>    - The bus topology describes electrical connectivity (visible
>      through "info qtree"). A device sits on a bus at an address.
> 
> Devices created without an explicit QOM parent fall into
> /machine/unattached/device[N], the "orphanage", with names that depend
> on enumeration order and are therefore unstable. Markus identified
> 380+ such devices across all QEMU machines [2]. Even with a stable QOM
> path, the path says nothing about where the device sits in the bus
> topology or what purpose it serves.
> 
> 
> * Three approaches on the table
> 
>    1. Mandatory QOM parenting (Graf [3][4] / Armbruster [2])
>       object_new_child() and per-bus creators enforce parenting at
>       creation time. Deletes the orphanage. Scope: 440 files, 137
>       patches.
> 
>    2. Bus-child parenting (Blot [1], rejected)
>       i2c_slave_create_simple() would parent slaves to their bus,
>       named by hex address (e.g. /machine/i2c[0]/i2c-bus/0x6f).
> 
>    3. DeviceLocator (Blot [5])
>       Pure-Python helper that resolves devices by bus-position
>       descriptors like:
> 
>         /machine/soc::aspeed.i2c-ast2600[0]~i2c[9]~tmp75@0x4b
> 
>       It walks the bus/device hierarchy using only qom-list/qom-get
>       over QMP, no QEMU code changes needed. 600 lines of python.
> 
> 
> * /machine/labels: DT-style alias container for QOM
> 
> The idea: add a flat container /machine/labels under the machine, where
> board code registers link<> properties pointing to devices by
> purpose name. Like device tree /aliases (serial0  > /soc/uart@9000000).
> 
> Container creation is one line in qemu_create_machine_containers().
> QMP introspection works today: qom-get /machine/labels/rtc returns the
> target's canonical path.
> 
> A small helper is all that is needed:
> 
>    void machine_add_label(const char *label, Object *target)
>    {
>        object_property_add_const_link(
>            machine_get_container("labels"), label, target);
>    }
> 
> Board code registers one label per well-known device:
> 
>    machine_add_label("rtc", OBJECT(dev));
>    machine_add_label("tmp75-bus9-0x4b", OBJECT(sensor));
> 
> Tests resolve devices with a single QMP call instead of walking
> the bus hierarchy.  For the common case, functional tests targeting
> specific board devices (SanMiguel TMP75s, Catalina PCA9555s, Anacapa
> ADC128D818s), the board author already knows which devices matter.
> 
> Thoughts?
> 
> Thanks,
> 
> C.
> 
> [1] https://lore.kernel.org/qemu-devel/20260701-i2c-adc128d818-anacapa-v5-6- 
> fe8292d86b38@free.fr
> [2] https://lore.kernel.org/qemu-devel/87se5scipx.fsf@pond.sub.org
> [3] https://lore.kernel.org/qemu-devel/20260711223707.42139-1-graf@amazon.com
> [4] https://lore.kernel.org/qemu-devel/20260718213652.37673-1-graf@amazon.com
> [5] https://lore.kernel.org/qemu-devel/20260731-sanmiguel-bmc-locator- 
> v2-0-1266926ba769@free.fr

I remember expressing a similar idea a while back in a private thread but as 
/machine/aliases, possibly with Pierrick and Phil?

The problem I was trying to solve was how to access in-built PCI buses and NIC 
devices from the command line consistently without resorting to various hacks such as 
having to use -nic to connect an in-built NIC to a backend: instead expose the 
frontend as an alias that can be referenced by the backend, so the exact QOM path is 
fixed and doesn't matter.

I'd certainly be interested to see the design fleshed out in more detail to explore 
more potential use cases.


ATB,

Mark.


