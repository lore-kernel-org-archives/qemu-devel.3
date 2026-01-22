Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9C4EC44536
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 10:43:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vis9s-0002n7-90; Thu, 22 Jan 2026 05:43:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vis9k-0002jT-Eh
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 05:43:19 -0500
Received: from 6.mo552.mail-out.ovh.net ([188.165.49.222])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vis9c-0007th-Ej
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 05:43:14 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.110.58.165])
 by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 4dxd1p6mwhz5vLW;
 Thu, 22 Jan 2026 10:42:54 +0000 (UTC)
Received: from kaod.org (37.59.142.113) by DAG3EX1.mxp5.local (172.16.2.21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Thu, 22 Jan
 2026 11:42:47 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-113S007f8abb573-3313-4346-ba5f-4b9d8d07c2d2,
 9C2E3E0988B38FCDD726FE3DC76C694F3DF0A25D) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <62cc752e-fd06-48c9-9aa8-badbea8562dd@kaod.org>
Date: Thu, 22 Jan 2026 11:42:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/1] hw/i2c/aspeed: Introduce 'bus-label' to customize
 bus naming
To: Markus Armbruster <armbru@redhat.com>
CC: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Kane Chen
 <kane_chen@aspeedtech.com>, Peter Maydell <peter.maydell@linaro.org>, Steven
 Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 <troy_lee@aspeedtech.com>, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P.
 Berrange" <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
References: <20260112083054.4151945-1-kane_chen@aspeedtech.com>
 <5e72f6d4-6914-4797-85f6-6131af0d1349@linaro.org>
 <7b67c00a-2bf3-4a25-aae4-9d4dd932486a@kaod.org> <877btdn0gv.fsf@pond.sub.org>
 <ba5b61db-64ad-495d-90f4-03e5553bf38e@kaod.org> <875x8win97.fsf@pond.sub.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <875x8win97.fsf@pond.sub.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.113]
X-ClientProxiedBy: DAG7EX1.mxp5.local (172.16.2.61) To DAG3EX1.mxp5.local
 (172.16.2.21)
X-Ovh-Tracer-GUID: 5f0b064e-c178-4db1-bf3d-e23130f2c2c7
X-Ovh-Tracer-Id: 18387634332776369025
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTF17LRtR8i0ZOxfHFC2pwVM4iB7B63zE3lLBse8ppFmw42xEump3jHejKQ/HD8wA8M+XCpRF9dO0z0fXzEhMQaOkfd0eV04NHU0uZCzZ0P8qsampYL/nUdKH8oom1di7y8lyyJL7tcMzFJhij/oJADDUFUamcIG3vaINTymVkLaYHucrAldyWLyQDn4ANY9ckQUfmOiqMlE6dBGgJ/j1hdVoln9FYcTtNfJM5589WZ27NKLLx6xUkJadSLJH461Yas4/JSChS0fYvkm954ahCrJfK8fwD3M/eWle0VyBknbh/dKugcHA6GmMWgzZbug1VAXq3xditjELD/cwcfpg5IYkn1OnKTWyzbNhbTijYRmrjgrDH9Twpqz4AF8SSb6+Pu/jn9xizlaSpHQhmYLlx6uNWJkPyzCiIauSMYltOZcMoPPoXdtSUjO3WGn9qKDmB6a8A2vu48BJXoN5Fm6hcSw9s9fbw930HmN2wADdK18cecEwiaJJoQwDDggDuAKt9KZrTooJHcFBJVLSPdy3MX/pc72AZs120fSEwX/pPb/9JPRa91HGkWtyca35FRoStCsV907dbWWTw8htsVwIub5Ufxw+uQ2iJQegtoHDABpvlj9fBX4iq6wOMNc/uGVlVXvIpxFLk49MemQ6KrnWFBOqidAumYsn+O9eh/6UcUyFw
DKIM-Signature: a=rsa-sha256; bh=8fmNiE+AKHWsOniqVN7786Cee9q0xRkj2DnKFmpIWew=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1769078577; v=1;
 b=OttiMrzRoZD3OrjrP6RSkjYw9HdI6XyzOu84/gv0ICHDTm6fsZJIS3x5s7N0mxRDg4JtErKY
 tdZ10BYjnlkF35B6dODWnVJqjCezi/XXwAi75U/cdj7C+W/gn+iJCrO0avmfY57myadwNctaKPS
 DSFDkVJtahbZQWpyp11eInsdga3pCVBCxwp8C5eUetc4UWa5OifF0vOtoGahU8cEDdEiGQBhJSu
 kKlx0/T6TOy0AyCdWBeCDm19eBtNLRHt0LlGkAW4scdj1zOFJPRm325g3BtEFZOHDpMNEmXb/mR
 Xh2j01krgCn9JihkAWATHpk8yrzo/JQRb0oco+28tUWQA==
Received-SPF: pass client-ip=188.165.49.222; envelope-from=clg@kaod.org;
 helo=6.mo552.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 1/20/26 11:36, Markus Armbruster wrote:
> Cc: QOM/qdev maintainers
> 
> Cédric Le Goater <clg@kaod.org> writes:
> 
>> Hello,
>>
>> On 1/19/26 15:25, Markus Armbruster wrote:
>>> Cédric Le Goater <clg@kaod.org> writes:
>>>
>>>> On 1/15/26 20:47, Philippe Mathieu-Daudé wrote:
>>>>> Hi,
>>>>> Cc'ing Markus.
>>>>> On 12/1/26 09:30, Kane Chen via qemu development wrote:
>>>>>> From: Kane-Chen-AS <kane_chen@aspeedtech.com>
>>>>>>
>>>>>> Currently, the Aspeed I2C controller uses a static naming convention
>>>>>> for its buses (e.g., "aspeed.i2c.bus.0"). This approach leads to
>>>>>> object name conflicts in machine models that incorporate multiple I2C
>>>>>> controllers, such as an Aspeed SoC paired with an external IO expander
>>>>>> or a co-processor like the AST1700.
>>>>>>
>>>>> Is this a side-effect of Problem 4: 'The /machine/unattached/ orphanage'
>>>>> described here?
>>>>> https://lore.kernel.org/qemu-devel/87o7d1i7ky.fsf@pond.sub.org/
> 
> No, but ...
> 
>>>>> This problem isn't specific to I2C nor Aspeed.
> 
> ... yes, indeed.  Details below.
> 
>>>> See the discussion here :
>>>>
>>>>     https://lore.kernel.org/qemu-devel/006fa26f-6b84-4e82-b6e1-7d1353579441@kaod.org/
>>>>
>>>> The Aspeed SoC has 3*16 I2C buses attached on 3 different I2C
>>>> controllers plus the I2C/I3C buses. We need to find a way to
>>>> distinguish these groups at the QEMU machine level to be able
>>>> to add devices on the right bus when using the command line.
>>>>
>>>> Suggestions welcome !
>>>
>>> Please show me how to start a QEMU with the 48 I2C mentioned above,
>>> complete with output of "info qtree".
>>
>> Clone
>>
>>    https://github.com/legoater/qemu/commits/aspeed-11.0
>>
>> Download
>>
>>    https://github.com/AspeedTech-BMC/openbmc/releases/download/v09.08/ast2700-default-obmc.tar.gz
>>
>> And run :
>>
>>    qemu-system-aarch64 -M ast2700a1-evb -m 8G -smp 4 -net nic,macaddr=,netdev=net0 -netdev user,id=net0,hostfwd=::2207-:22 -drive file=path/to/ast2700-default/image-bmc,format=raw,if=mtd -nographic -serial mon:stdio -snapshot
>>
>> Today, to attach an I2C device on one of the Aspeed SoC I2C buses :
>>
>>    -device tmp105,bus=aspeed.i2c.bus.1,address=0x4d,id=tmp-test
>>
>> The Aspeed SoC I2C bus names follow the "aspeed.i2c.bus.X" format.
>> This is the model typename. The 2 new IO expander models attached
>> to the Aspeed SoC have an extra 16 I2C buses each. These buses use
>> an "ioexpX.Y" name, as proposed in the aspeed-next branch.
>>
>> Attaching a device to one of the IO expanders I2C buses would be :
>>
>>    -device tmp105,bus=ioexp0.1,address=0x4d,id=tmp-test
>>
>> See the qtree below.
> 
> Thank you!

Thank you for taking the time of analyzing the code and history.

> 
> Machine ast2700a1-evb has QOM objects
> 
>      /machine/soc/i2c/ (aspeed.i2c-ast2700)
>        /bus[N] (aspeed.i2c.bus)    for N in 0..15
>          /aspeed.i2c.bus.N (i2c-bus)
> 
> in both master and aspeed-11.0.

Yes, that doesn't change because I would prefer not to break the current
user interface. The "i2c.X" bus name would have been a better choice.
I didn't anticipated that 10y ago when I proposed this model.


> Object aspeed.i2c-ast2700 is a sysbus device that contains 16
> aspeed.i2c.bus objects as children bus[N] for N in 0..15.  Each object
> has a property "bus-id" with value N.
> 
> Object aspeed.i2c.bus is a sysbus device that contains an i2c-bus object
> as child aspeed.i2c.bus.N.
> 
> Aside: why parent TYPE_SYS_BUS_DEVICE, and not TYPE_DEVICE?  It doesn't
> actually plug into a sysbus...

The AspeedI2CBus model has a couple of MRs and an IRQ. I guess that's why.
  
> Object i2c-bus is a qbus.
> 
> In master, object aspeed.i2c.bus computes the child name by appending .N
> to its own type name TYPE_ASPEED_I2C_BUS.
> 
> In aspeed-11.0, it takes it from its property "bus-name".  The property
> is set by its QOM parent aspeed.i2c-ast2700, and computed by appending
> .N to the value of its property "bus-label".  It defaults the property
> to TYPE_ASPEED_I2C_BUS.
> 
> Since nothing sets this property in this case, we get the same child
> name.
> 
> aspeed-11.0 additionally has QOM objects
> 
>      /machine/soc/ioexp[M] (aspeed.ast1700)    for M in 0..1
>          /ioexp-i2c[0] (aspeed.i2c-ast2700)
>            /bus[N] (aspeed.i2c.bus)    for N in 0..15
>              /ioexpM.N (i2c-bus)
> 
> Object aspeed.ast1700 is a sysbus device that contains an
> aspeed.i2c-ast2700 as child "ioexp-i2c[0]".  It has a property
> "board-idx" with value M.
> 
> Aside: we only ever create one aspeed.i2c-ast2700 child.  Why [0]?

Right. We can drop [*] in aspeed_ast1700_instance_init() - PATCH 15.

  
> Aside^2: I tried to strangle the "[*]" feature in the crib, but failed.
> Has been a minor thorn in my side ever since.
> 
> aspeed.ast1700 set its child's (aspeed.i2c-ast2700) property "bus-label"
> to "ioexpM".  This makes the child set the grandchild's (aspeed.i2c.bus)
> property "bus-name" to "ioexpM.N", which makes the grandchild name the
> great-grandchild (i2c-bus) "ioexpM.N".
> 
> This naming business is complicated, and I had a hard time ferreting it
> out.  As far as I can tell, it's all in service of -device bus=...

yes.

That's why I regret not letting QEMU taking care of the naming with :

    s->bus = i2c_init_bus(dev, NULL);

This would break the user interface though. This is still an option.

> Let's examine how that works.
> 
> We want to be able to plug i2c devices into any of these 48 i2c buses
> with -device / device_add.  To do that, we need to select a bus with the
> "bus" argument.
> 
> In a world saner than the one we live in, the value of "bus" would be a
> QOM path or qdev ID, where qdev ID is shorthand for the QOM path
> /machine/peripheral/ID.
>
> For instance, the first i2c bus could then be selected with absolute QOM
> path "/machine/soc/i2c/bus[0]" or partial QOM paths "soc/i2c/bus[0]" or
> "i2c/bus[0]".  Partial QOM paths are a convenience feature that is
> virtually unknown (and possibly ill-advised): you can omit leading path
> components as long as there's no ambiguity.
> 
> However, in the world we live in, the value of bus is not a QOM path,
> it's a path in the qtree.  Why?  qdev and -device / device_add predate
> QOM.
> 
> If the path starts with "/", it's anchored at the main system bus.
> 
> Else, it's anchored at a bus whose name is the first path component.  If
> there's more than one such bus, we pick the first one we find.  This is
> a misfeature.
> 
> Remaining path components, if any, pick a path in the qtree from that
> anchor towards leaves.  Note that the child of a qbus is always a qdev,
> and the child of a qdev always a qbus.
> 
> This must ultimately resolve to a qbus of the appropriate type.
> 
> Picking a qdev child of a qbus works like this:
> 
> * If a child with a (user-specified) qdev ID equal to the path component
>    exists, pick it.  Since qdev IDs are unique, there can only be one.
> 
> * Else, if children whose QOM type name equals the path component
>    exists, pick the first one.
> 
> * Else, if children whose qdev alias equals the path component exists,
>    pick the first one.
> 
> Picking the first one is again a misfeature.
> 
> Picking a qbus child is simpler: we pick the first child whose bus name
> equals the path component.
> 
> Bus names are defined as follows:
> 
> * Whatever creates the bus may set its name.
> 
> * Else, if the qbus's parent qdev has an ID, the bus name is ID.N, where
>    N counts up from 0 within that qdev.
> 
> * Else, the bus name is TYPE.N, where TYPE is the parent qdev's QOM type
>    name, and N counts up from 0 within that bus class.
> 
> The only case where this is actually works is picking the N-th bus child
> provided by a qdev with an ID: use bus=ID.N (a partial tree path of just
> one component).  Anything else is unfit for purpose, except in special
> cases, e.g. when the machine can have just one device of a certain type.
> 
> This mess is harmless for user-created devices: just specify the ID.
> It's awful for onboard devices, which cannot have an ID.
> 
> This is a qdev design flaw.  It's not specific to I2C or Aspeed, as
> Philippe suspected.
> 
> To illustrate it further, let's have a look at the qtree of machine
> ast2700a1-evb.  Output of "info qtree" in master:
> 
>      bus: main-system-bus
>        type System
>        [...]
>        dev: aspeed.i2c.bus, id ""    for N in 0..15
>          [...]
>          bus: aspeed.i2c.bus.N
>            type i2c-bus
>            [...]
>        
> In aspeed-11.0, we additionally have
> 
>        dev: aspeed.i2c.bus, id ""    for M in 0..1, N in 0..15
>          [...]
>          bus: ioexpM.N
>            type i2c-bus
>            [...]
> 
> The i2c-buses all have unique names: aspeed.i2c-bus.N and ioexpM.N.  We
> can point to any of them with a partial qtree path of just one
> component: bus=NAME where NAME is one of these unique names works, and
> there is no ambiguity.
> 
> The buses have unique names only because device code takes pains to make
> them configurable by parent devices, and the parent devices cooperate to
> configure them so the resulting bus names are unique.
> 
> This is a lot of complexity to work around this qdev design flaw for
> just one special instance.
> 
> Can we instead remedy the design flaw once and for all?
> 
> Here't the obvious stupid idea: give -device / device_add the means to
> pick a bus by QOM path.
> 
> Thoughts?
> 

Could we support both methods ? I mean looking up the bus by the
qtree name and by the QOM path ?

Thanks,

C.

