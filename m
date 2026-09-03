Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35F83C624A4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 14:23:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x28KT-0003ok-UA; Thu, 03 Sep 2026 10:22:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1x28KS-0003oN-1t
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 10:22:12 -0400
Received: from smtpout4.mo538.mail-out.ovh.net ([51.210.91.33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1x28KL-0006ER-C6
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 10:22:11 -0400
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net [79.137.60.36])
 by mo538.mail-out.ovh.net (Postfix) with ESMTPS id 4hbMHD3Fw0z6DZf;
 Thu,  3 Sep 2026 14:21:59 +0000 (UTC)
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net. [127.0.0.1])
 by director2.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Thu,  3 Sep 2026 14:21:59 +0000 (UTC)
Received: from mta7.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.0.227])
 by director2.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4hbMHC5b5gz1xt3;
 Thu,  3 Sep 2026 14:21:59 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.4])
 (Authenticated sender: clg@kaod.org)
 by mta7.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id D4D07203FDB; 
 Thu,  3 Sep 2026 14:21:57 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-97G0027f079425-9784-4436-836a-22b3b6615bf0,
 D9A964E3C5AFBF6BD84231720E0C998EB3D97DAC) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <cb1b5ec3-d7ba-42fe-a8ab-da7c236b1660@kaod.org>
Date: Thu, 3 Sep 2026 16:21:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Adding /machines/labels (was Re: [PATCH v2 18/25] tests/functional:
 add a pure-Python device-locator resolver)
To: Emmanuel Blot <emmanuel.blot@free.fr>, qemu-devel@nongnu.org
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
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260731-sanmiguel-bmc-locator-v2-18-1266926ba769@free.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 9405486348910439469
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFQrZsomf6LbNSIIqVPisNl3lk9/5IuM+SAuHvf65FqznmUqzcrBdm4jUnTLXVF7sNBwjzXXfqRpkXfnhbzQiI/14fbE58CmMTWVj2zbIUtD6Zgdx29iP6lz+v/JQf4e1I8nrGkpR0IhbbNMFYDmlbZyelY0r3rd94/Nv0SbBW2rNBiH2pUQxrPRFQAJQY93OnzyKkwGqBBd08lwVHZ8S/zLqpYYB7d5lVAhpRQ5cGo8p5kFg2o5GIFAypHI3nCIyeJMUw7BYoHKpCJ8QT4EFoEAOl4Geh25EPUnA6txeuqR+jl1V3TIcz8dAaDaAJQy+Q6jy7RpTETN4jfxv6gl3KyktfLjawzp5pT4pxM/1gVJnd3AXU7gNPthGceOHiqUH6+9mZpGVu1pU/H1K8cIoW25y5nBYL8ccmMiDV/nSFtucabBJJXHSoyDNuP6SyqlUggw16b4Srdb4ib3NMmmm+bu7IGrygwNGXJB8dNnY8KwzJILO0Jvb8QQNR0J0EE8EujbF82CQf8VWTQ2swUN100oHR62w6xZV3L7UFgCsqLuqx/hlsZyHBPlp6VznXp2lKYwxqaJtM8NvfyIE93lNJFryOB/i7q9GI/tTnqqOaLhmijVFPaLcQRaDzrEjm3zxBtQaMbx6X9J9u+BqOalvVpAActM3PJcGIJKLIRC+i+MA
DKIM-Signature: a=rsa-sha256; bh=pPGg/M0AdNeXK4HXQK4blyc77s+k656feKUCFAAkeLY=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1788445321; v=1;
 b=bYy6XL5jSCe4uC4H5y2atTjOA35lP1xfUVOMv1qB13feU1uqzrOC3xoqMALmdQewWZkVcblg
 rd4OpPj9yEdWu/lejOr9d03TPZLVaOUx2KZoKCIoRe3TIFBz1I2za8x7Pkos280fA1mff8+pq/0
 XDWcQXn0wGmGifWZOYXcKmYxMlsTzwlLcCiU5Uwo56YU05oya5fabfl7WYN4fFqwxZ5LF6ktRPi
 /ocsVqfPFgNxoTGXtOrItaWecZ3Ih0s4dpzy4rpP03FAxVotHI9kV9cQ+zeCp15/KjS63KVHzhu
 OdBmJxgNTZ8rWoUwZczMAf9SLemtj9VajadACDRJuOVdg==
Received-SPF: pass client-ip=51.210.91.33; envelope-from=clg@kaod.org;
 helo=smtpout4.mo538.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 7/31/26 12:45, Emmanuel Blot wrote:
> Add DeviceLocator, a helper that addresses a device by its position on
> the bus -- bus, address, type or index -- rather than by a QOM path. A
> QOM path locates a device under the object that owns it, by enumeration
> order, and so says nothing about where the device actually sits in the
> bus topology. From a QOM anchor DeviceLocator instead walks the bus and
> device hierarchy, alternating bus and device hops, to reach the target.
> 
> It relies only on standard QOM queries over QMP, needing no custom
> commands or changes to QEMU.

Let's recap first :

Several recent threads have touched the same topic: QOM
composition-tree paths encode ownership, but developers and tests
regularly need to identify devices by their position in the bus
topology. The threads in question:

   - "[PATCH v5 0/8] hw/sensor: Add new device emulation for TI ADC128D818" [1]
   - "Call to clean up QOM onboard devices lacking a parent" [2]
   - "[PATCH RFC 001/134] qom: Introduce object_new_child()" [3]
   - "[PATCH RFC v2 0/137] qom: Make composition-tree parenting mandatory" [4]
   - "[PATCH v2 0/25] hw/arm: Facebook SanMiguel BMC and TMP75-family sensors" [5]


* The problem

QEMU has two device hierarchies serving different purposes:

   - The QOM composition tree describes parent/child ownership.  Every
     object has exactly one parent. Paths look like:
     /machine/soc/i2c-controller/child-device.
   - The bus topology describes electrical connectivity (visible
     through "info qtree"). A device sits on a bus at an address.

Devices created without an explicit QOM parent fall into
/machine/unattached/device[N], the "orphanage", with names that depend
on enumeration order and are therefore unstable. Markus identified
380+ such devices across all QEMU machines [2]. Even with a stable QOM
path, the path says nothing about where the device sits in the bus
topology or what purpose it serves.


* Three approaches on the table

   1. Mandatory QOM parenting (Graf [3][4] / Armbruster [2])
      object_new_child() and per-bus creators enforce parenting at
      creation time. Deletes the orphanage. Scope: 440 files, 137
      patches.

   2. Bus-child parenting (Blot [1], rejected)
      i2c_slave_create_simple() would parent slaves to their bus,
      named by hex address (e.g. /machine/i2c[0]/i2c-bus/0x6f).

   3. DeviceLocator (Blot [5])
      Pure-Python helper that resolves devices by bus-position
      descriptors like:

        /machine/soc::aspeed.i2c-ast2600[0]~i2c[9]~tmp75@0x4b

      It walks the bus/device hierarchy using only qom-list/qom-get
      over QMP, no QEMU code changes needed. 600 lines of python.


* /machine/labels: DT-style alias container for QOM

The idea: add a flat container /machine/labels under the machine, where
board code registers link<> properties pointing to devices by
purpose name. Like device tree /aliases (serial0  > /soc/uart@9000000).

Container creation is one line in qemu_create_machine_containers().
QMP introspection works today: qom-get /machine/labels/rtc returns the
target's canonical path.

A small helper is all that is needed:

   void machine_add_label(const char *label, Object *target)
   {
       object_property_add_const_link(
           machine_get_container("labels"), label, target);
   }

Board code registers one label per well-known device:

   machine_add_label("rtc", OBJECT(dev));
   machine_add_label("tmp75-bus9-0x4b", OBJECT(sensor));

Tests resolve devices with a single QMP call instead of walking
the bus hierarchy.  For the common case, functional tests targeting
specific board devices (SanMiguel TMP75s, Catalina PCA9555s, Anacapa
ADC128D818s), the board author already knows which devices matter.

Thoughts?

Thanks,

C.

[1] https://lore.kernel.org/qemu-devel/20260701-i2c-adc128d818-anacapa-v5-6-fe8292d86b38@free.fr
[2] https://lore.kernel.org/qemu-devel/87se5scipx.fsf@pond.sub.org
[3] https://lore.kernel.org/qemu-devel/20260711223707.42139-1-graf@amazon.com
[4] https://lore.kernel.org/qemu-devel/20260718213652.37673-1-graf@amazon.com
[5] https://lore.kernel.org/qemu-devel/20260731-sanmiguel-bmc-locator-v2-0-1266926ba769@free.fr


