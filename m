Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAFC4D29C32
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 17:40:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhtDg-0004wH-MU; Mon, 19 Jan 2026 12:39:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vhtDV-0004sL-Bp
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 12:39:07 -0500
Received: from 3.mo548.mail-out.ovh.net ([188.165.32.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vhtDO-00045Q-Un
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 12:39:05 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.109.249.176])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4dvyP92dQGz5vyY;
 Mon, 19 Jan 2026 17:38:53 +0000 (UTC)
Received: from kaod.org (37.59.142.102) by DAG3EX1.mxp5.local (172.16.2.21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Mon, 19 Jan
 2026 18:38:52 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-102R0041a679a68-8c25-497e-9bb2-4e96bb90a04a,
 CBA6FA7C12C66A1134E3410DCAD37710A17CDEF2) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <ba5b61db-64ad-495d-90f4-03e5553bf38e@kaod.org>
Date: Mon, 19 Jan 2026 18:38:50 +0100
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
 <troy_lee@aspeedtech.com>
References: <20260112083054.4151945-1-kane_chen@aspeedtech.com>
 <5e72f6d4-6914-4797-85f6-6131af0d1349@linaro.org>
 <7b67c00a-2bf3-4a25-aae4-9d4dd932486a@kaod.org> <877btdn0gv.fsf@pond.sub.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <877btdn0gv.fsf@pond.sub.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.102]
X-ClientProxiedBy: DAG3EX2.mxp5.local (172.16.2.22) To DAG3EX1.mxp5.local
 (172.16.2.21)
X-Ovh-Tracer-GUID: 93e78bff-dd81-4242-85ce-b6f57a3e7e6f
X-Ovh-Tracer-Id: 7794886533619551224
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEacfAo7MVi7GrNeEMj85d81vhqYF1hO8tUYeFPOPcIXJ9tleptHKo72T9H4JvjmDss9RsIOtzcycuBxLOMwoyDyb3jEi9n3JxUQZhCEmnsM2P0x/I/ZGakEly37LjKrS+JogIL4Jl1OPtocj+Xk8/HAPiQ0wunZcOphD+vdrk0DUgKSIz51eaBoIBU1b8a/xTYGNCV48acANYuj/APwj32QU4PS4lwkmGBapHwCO2CcUnmhRCx3C1H1KEzmT9+rHD4Q2HLTrsAG3DNhSgnDYAuu+8YRehvGD6h32FOzporiwfR4RJL8bMwMMaVKY1vkax9aG2bJ9BtzuAgEEYkT0aysAVUnvSQhF5K4OiAa+FuMx4DSlFjzEMLyiKdr3DFQv/4G1uSgYNFd9J/PlKDtqNTMMHuC0PP56BA/NI2eOrYoQaMjgLxSpRU9Q1mC4o5fvQvt3zolImkozCSWAmt67aNyn1vABJHcuobQuNP6CBOk24tr+kcyx2ytlujuQ/WKX4+m961RXhfLYgHlQMKco48HkiFVYfa6TRg0cqI6Zis0/FBWXCCZbEHzvsTG2NjEH3l2dK+mQuI7EM2ytmcM8oj3M8tKO6/7lsVPL67gEU8ojVpMVSIa7h9LJpfmdNuUMyGbg+HuidCOgwEU8nVJ9StVkjltSB9V2zkSe3WqKFEIQ
DKIM-Signature: a=rsa-sha256; bh=tOJxwb7U6u/CxQ3tjd8V0h/OUnCy9uBKThXfSFYfzd0=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1768844335; v=1;
 b=pcNN4KndbI30eQ+BdtL+NzMcLFozaSJSg7U2VRuBCHpzmY5Q8dvMYeXciMDlP7nW4aR1/ZC7
 r9lTrw5bZJt3GavjsuAJIOcVQR5HKSycrOXrA+iB+Htbias11ehki60R3tV0QJMmCRs2Xjum9dd
 zyeqe5LSPSSl9318OX7TCJAx6Zq+W6yTQMi9u/LEJnI0eIKfiqNfhYut2/p5+ZrDmtsyISke2Zz
 7OE7orr6HhfT9CYkNBDC8FUEfTvKkJbS4pcGGShKXudLWSuYNGXrFihrQtwaNvsvZBWl1btxuLC
 3UFV+nhlZhz8E05Mxc0qIg/cZdxPfGa2LCiJjZjp1cEuA==
Received-SPF: pass client-ip=188.165.32.156; envelope-from=clg@kaod.org;
 helo=3.mo548.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello,

On 1/19/26 15:25, Markus Armbruster wrote:
> Cédric Le Goater <clg@kaod.org> writes:
> 
>> On 1/15/26 20:47, Philippe Mathieu-Daudé wrote:
>>> Hi,
>>> Cc'ing Markus.
>>> On 12/1/26 09:30, Kane Chen via qemu development wrote:
>>>> From: Kane-Chen-AS <kane_chen@aspeedtech.com>
>>>>
>>>> Currently, the Aspeed I2C controller uses a static naming convention
>>>> for its buses (e.g., "aspeed.i2c.bus.0"). This approach leads to
>>>> object name conflicts in machine models that incorporate multiple I2C
>>>> controllers, such as an Aspeed SoC paired with an external IO expander
>>>> or a co-processor like the AST1700.
>>>>
>>> Is this a side-effect of Problem 4: 'The /machine/unattached/ orphanage'
>>> described here?
>>> https://lore.kernel.org/qemu-devel/87o7d1i7ky.fsf@pond.sub.org/
>>> This problem isn't specific to I2C nor Aspeed.
>>
>>
>> See the discussion here :
>>
>>    https://lore.kernel.org/qemu-devel/006fa26f-6b84-4e82-b6e1-7d1353579441@kaod.org/
>>
>> The Aspeed SoC has 3*16 I2C buses attached on 3 different I2C
>> controllers plus the I2C/I3C buses. We need to find a way to
>> distinguish these groups at the QEMU machine level to be able
>> to add devices on the right bus when using the command line.
>>
>> Suggestions welcome !
> 
> Please show me how to start a QEMU with the 48 I2C mentioned above,
> complete with output of "info qtree".

Clone

   https://github.com/legoater/qemu/commits/aspeed-11.0

Download

   https://github.com/AspeedTech-BMC/openbmc/releases/download/v09.08/ast2700-default-obmc.tar.gz

And run :

   qemu-system-aarch64 -M ast2700a1-evb -m 8G -smp 4 -net nic,macaddr=,netdev=net0 -netdev user,id=net0,hostfwd=::2207-:22 -drive file=path/to/ast2700-default/image-bmc,format=raw,if=mtd -nographic -serial mon:stdio -snapshot

Today, to attach an I2C device on one of the Aspeed SoC I2C buses :

   -device tmp105,bus=aspeed.i2c.bus.1,address=0x4d,id=tmp-test

The Aspeed SoC I2C bus names follow the "aspeed.i2c.bus.X" format.
This is the model typename. The 2 new IO expander models attached
to the Aspeed SoC have an extra 16 I2C buses each. These buses use
an "ioexpX.Y" name, as proposed in the aspeed-next branch.

Attaching a device to one of the IO expanders I2C buses would be :

   -device tmp105,bus=ioexp0.1,address=0x4d,id=tmp-test

See the qtree below.


Thanks,

C.

(qemu) info qtree
bus: main-system-bus
   type System
   dev: unimplemented-device, id ""
     size = 16777216 (0x1000000)
     name = "aspeed.iomem1"
     mmio ffffffffffffffff/0000000001000000
   dev: unimplemented-device, id ""
     size = 16777216 (0x1000000)
     name = "aspeed.iomem0"
     mmio ffffffffffffffff/0000000001000000
   dev: unimplemented-device, id ""
     size = 16646144 (0xfe0000)
     name = "aspeed.io"
     mmio ffffffffffffffff/0000000000fe0000
   dev: unimplemented-device, id ""
     size = 262144 (0x40000)
     name = "aspeed.dpmcu"
     mmio ffffffffffffffff/0000000000040000
   dev: unimplemented-device, id ""
     size = 65536 (0x10000)
     name = "ioexp-i3c"
     mmio ffffffffffffffff/0000000000010000
   dev: aspeed.wdt-ast2700, id ""
     scu = "/machine/soc/ioexp[1]/ioexp-scu[0]"
     mmio ffffffffffffffff/0000000000000080
   dev: aspeed.wdt-ast2700, id ""
     scu = "/machine/soc/ioexp[1]/ioexp-scu[0]"
     mmio ffffffffffffffff/0000000000000080
   dev: aspeed.wdt-ast2700, id ""
     scu = "/machine/soc/ioexp[1]/ioexp-scu[0]"
     mmio ffffffffffffffff/0000000000000080
   dev: aspeed.wdt-ast2700, id ""
     scu = "/machine/soc/ioexp[1]/ioexp-scu[0]"
     mmio ffffffffffffffff/0000000000000080
   dev: aspeed.wdt-ast2700, id ""
     scu = "/machine/soc/ioexp[1]/ioexp-scu[0]"
     mmio ffffffffffffffff/0000000000000080
   dev: aspeed.wdt-ast2700, id ""
     scu = "/machine/soc/ioexp[1]/ioexp-scu[0]"
     mmio ffffffffffffffff/0000000000000080
   dev: aspeed.wdt-ast2700, id ""
     scu = "/machine/soc/ioexp[1]/ioexp-scu[0]"
     mmio ffffffffffffffff/0000000000000080
   dev: aspeed.wdt-ast2700, id ""
     scu = "/machine/soc/ioexp[1]/ioexp-scu[0]"
     mmio ffffffffffffffff/0000000000000080
   dev: aspeed.wdt-ast2700, id ""
     scu = "/machine/soc/ioexp[1]/ioexp-scu[0]"
     mmio ffffffffffffffff/0000000000000080
   dev: aspeed.sgpio-ast2700, id ""
     gpio-out "sysbus-irq" 1
     mmio ffffffffffffffff/0000000000001000
   dev: aspeed.sgpio-ast2700, id ""
     gpio-out "sysbus-irq" 1
     mmio ffffffffffffffff/0000000000001000
   dev: aspeed.ltpi-ctrl, id ""
     mmio ffffffffffffffff/0000000000000900
   dev: aspeed.pwm, id ""
     gpio-out "sysbus-irq" 1
     mmio ffffffffffffffff/0000000000001000
   dev: aspeed.i2c.bus, id ""
     gpio-out "sysbus-irq" 1
     bus-id = 15 (0xf)
     controller = "/machine/soc/ioexp[1]/ioexp-i2c[0]"
     bus-name = "ioexp1.15"
     mmio ffffffffffffffff/0000000000000080
     mmio ffffffffffffffff/0000000000000020
     bus: ioexp1.15
       type i2c-bus
       dev: aspeed.i2c.slave, id ""
         address = 255 (0xff)
   dev: aspeed.i2c.bus, id ""
     gpio-out "sysbus-irq" 1
     bus-id = 14 (0xe)
     controller = "/machine/soc/ioexp[1]/ioexp-i2c[0]"
     bus-name = "ioexp1.14"
     mmio ffffffffffffffff/0000000000000080
     mmio ffffffffffffffff/0000000000000020
     bus: ioexp1.14
       type i2c-bus
       dev: aspeed.i2c.slave, id ""
         address = 255 (0xff)
   dev: aspeed.i2c.bus, id ""
     gpio-out "sysbus-irq" 1
     bus-id = 13 (0xd)
     controller = "/machine/soc/ioexp[1]/ioexp-i2c[0]"
     bus-name = "ioexp1.13"
     mmio ffffffffffffffff/0000000000000080
     mmio ffffffffffffffff/0000000000000020
     bus: ioexp1.13
       type i2c-bus
       dev: aspeed.i2c.slave, id ""
         address = 255 (0xff)
   dev: aspeed.i2c.bus, id ""
     gpio-out "sysbus-irq" 1
     bus-id = 12 (0xc)
     controller = "/machine/soc/ioexp[1]/ioexp-i2c[0]"
     bus-name = "ioexp1.12"
     mmio ffffffffffffffff/0000000000000080
     mmio ffffffffffffffff/0000000000000020
     bus: ioexp1.12
       type i2c-bus
       dev: aspeed.i2c.slave, id ""
         address = 255 (0xff)
   dev: aspeed.i2c.bus, id ""
     gpio-out "sysbus-irq" 1
     bus-id = 11 (0xb)
     controller = "/machine/soc/ioexp[1]/ioexp-i2c[0]"
     bus-name = "ioexp1.11"
     mmio ffffffffffffffff/0000000000000080
     mmio ffffffffffffffff/0000000000000020
     bus: ioexp1.11
       type i2c-bus
       dev: aspeed.i2c.slave, id ""
         address = 255 (0xff)
   dev: aspeed.i2c.bus, id ""
     gpio-out "sysbus-irq" 1
     bus-id = 10 (0xa)
     controller = "/machine/soc/ioexp[1]/ioexp-i2c[0]"
     bus-name = "ioexp1.10"
     mmio ffffffffffffffff/0000000000000080
     mmio ffffffffffffffff/0000000000000020
     bus: ioexp1.10
       type i2c-bus
       dev: aspeed.i2c.slave, id ""
         address = 255 (0xff)
   dev: aspeed.i2c.bus, id ""
     gpio-out "sysbus-irq" 1
     bus-id = 9 (0x9)
     controller = "/machine/soc/ioexp[1]/ioexp-i2c[0]"
     bus-name = "ioexp1.9"
     mmio ffffffffffffffff/0000000000000080
     mmio ffffffffffffffff/0000000000000020
     bus: ioexp1.9
       type i2c-bus
       dev: aspeed.i2c.slave, id ""
         address = 255 (0xff)
   dev: aspeed.i2c.bus, id ""
     gpio-out "sysbus-irq" 1
     bus-id = 8 (0x8)
     controller = "/machine/soc/ioexp[1]/ioexp-i2c[0]"
     bus-name = "ioexp1.8"
     mmio ffffffffffffffff/0000000000000080
     mmio ffffffffffffffff/0000000000000020
     bus: ioexp1.8
       type i2c-bus
       dev: aspeed.i2c.slave, id ""
         address = 255 (0xff)
   dev: aspeed.i2c.bus, id ""
     gpio-out "sysbus-irq" 1
     bus-id = 7 (0x7)
     controller = "/machine/soc/ioexp[1]/ioexp-i2c[0]"
     bus-name = "ioexp1.7"
     mmio ffffffffffffffff/0000000000000080
     mmio ffffffffffffffff/0000000000000020
     bus: ioexp1.7
       type i2c-bus
       dev: aspeed.i2c.slave, id ""
         address = 255 (0xff)
   dev: aspeed.i2c.bus, id ""
     gpio-out "sysbus-irq" 1
     bus-id = 6 (0x6)
     controller = "/machine/soc/ioexp[1]/ioexp-i2c[0]"
     bus-name = "ioexp1.6"
     mmio ffffffffffffffff/0000000000000080
     mmio ffffffffffffffff/0000000000000020
     bus: ioexp1.6
       type i2c-bus
       dev: aspeed.i2c.slave, id ""
         address = 255 (0xff)
   dev: aspeed.i2c.bus, id ""
     gpio-out "sysbus-irq" 1
     bus-id = 5 (0x5)
     controller = "/machine/soc/ioexp[1]/ioexp-i2c[0]"
     bus-name = "ioexp1.5"
     mmio ffffffffffffffff/0000000000000080
     mmio ffffffffffffffff/0000000000000020
     bus: ioexp1.5
       type i2c-bus
       dev: aspeed.i2c.slave, id ""
         address = 255 (0xff)
   dev: aspeed.i2c.bus, id ""
     gpio-out "sysbus-irq" 1
     bus-id = 4 (0x4)
     controller = "/machine/soc/ioexp[1]/ioexp-i2c[0]"
     bus-name = "ioexp1.4"
     mmio ffffffffffffffff/0000000000000080
     mmio ffffffffffffffff/0000000000000020
     bus: ioexp1.4
       type i2c-bus
       dev: aspeed.i2c.slave, id ""
         address = 255 (0xff)
   dev: aspeed.i2c.bus, id ""
     gpio-out "sysbus-irq" 1
     bus-id = 3 (0x3)
     controller = "/machine/soc/ioexp[1]/ioexp-i2c[0]"
     bus-name = "ioexp1.3"
     mmio ffffffffffffffff/0000000000000080
     mmio ffffffffffffffff/0000000000000020
     bus: ioexp1.3
       type i2c-bus
       dev: aspeed.i2c.slave, id ""
         address = 255 (0xff)
   dev: aspeed.i2c.bus, id ""
     gpio-out "sysbus-irq" 1
     bus-id = 2 (0x2)
     controller = "/machine/soc/ioexp[1]/ioexp-i2c[0]"
     bus-name = "ioexp1.2"
     mmio ffffffffffffffff/0000000000000080
     mmio ffffffffffffffff/0000000000000020
     bus: ioexp1.2
       type i2c-bus
       dev: aspeed.i2c.slave, id ""
         address = 255 (0xff)
   dev: aspeed.i2c.bus, id ""
     gpio-out "sysbus-irq" 1
     bus-id = 1 (0x1)
     controller = "/machine/soc/ioexp[1]/ioexp-i2c[0]"
     bus-name = "ioexp1.1"
     mmio ffffffffffffffff/0000000000000080
     mmio ffffffffffffffff/0000000000000020
     bus: ioexp1.1
       type i2c-bus
       dev: aspeed.i2c.slave, id ""
         address = 255 (0xff)
   dev: aspeed.i2c.bus, id ""
     gpio-out "sysbus-irq" 1
     bus-id = 0 (0x0)
     controller = "/machine/soc/ioexp[1]/ioexp-i2c[0]"
     bus-name = "ioexp1.0"
     mmio ffffffffffffffff/0000000000000080
     mmio ffffffffffffffff/0000000000000020
     bus: ioexp1.0
       type i2c-bus
       dev: aspeed.i2c.slave, id ""
         address = 255 (0xff)
   dev: aspeed.i2c-ast2700, id ""
     gpio-out "sysbus-irq" 1
     dram = "/machine/soc/ioexp[1]/aspeed.ast1700[0]"
     bus-label = "ioexp1"
     mmio ffffffffffffffff/0000000000002000
   dev: aspeed.gpio-ast2700, id ""
     gpio-out "sysbus-irq" 213
     mmio ffffffffffffffff/0000000000001000
   dev: aspeed.scu-ast2700, id ""
     silicon-rev = 100729091 (0x6010103)
     hw-strap1 = 0 (0x0)
     hw-strap2 = 0 (0x0)
     hw-prot-key = 0 (0x0)
     mmio ffffffffffffffff/0000000000001000
   dev: aspeed.adc.engine, id ""
     gpio-out "sysbus-irq" 1
     engine-id = 1 (0x1)
     nr-channels = 8 (0x8)
     mmio ffffffffffffffff/0000000000000100
   dev: aspeed.adc.engine, id ""
     gpio-out "sysbus-irq" 1
     engine-id = 0 (0x0)
     nr-channels = 8 (0x8)
     mmio ffffffffffffffff/0000000000000100
   dev: aspeed.adc-ast2700, id ""
     gpio-out "sysbus-irq" 1
     gpio-in "" 2
     mmio ffffffffffffffff/0000000000001000
   dev: aspeed.smc.flash, id ""
     cs = 1 (0x1)
     controller = "/machine/soc/ioexp[1]/ioexp-spi[0]"
     mmio ffffffffffffffff/0000000008000000
   dev: aspeed.smc.flash, id ""
     cs = 0 (0x0)
     controller = "/machine/soc/ioexp[1]/ioexp-spi[0]"
     mmio ffffffffffffffff/0000000008000000
   dev: aspeed.spi0-ast2700, id ""
     gpio-out "cs" 2
     gpio-out "sysbus-irq" 1
     inject-failure = false
     dram-base = 0 (0x0)
     dram = "/machine/soc/ioexp[1]/aspeed.ast1700[0]"
     mmio ffffffffffffffff/0000000000000100
     mmio ffffffffffffffff/0000000040000000
     bus: ssi.5
       type SSI
   dev: serial-mm, id ""
     gpio-out "sysbus-irq" 1
     regshift = 2 (0x2)
     endianness = 2 (0x2)
     mmio ffffffffffffffff/0000000000000020
   dev: aspeed.ast1700, id ""
     board-idx = 1 (0x1)
     silicon-rev = 100729091 (0x6010103)
     mmio 0000000050000000/0000000001000000
   dev: unimplemented-device, id ""
     size = 65536 (0x10000)
     name = "ioexp-i3c"
     mmio ffffffffffffffff/0000000000010000
   dev: aspeed.wdt-ast2700, id ""
     scu = "/machine/soc/ioexp[0]/ioexp-scu[0]"
     mmio ffffffffffffffff/0000000000000080
   dev: aspeed.wdt-ast2700, id ""
     scu = "/machine/soc/ioexp[0]/ioexp-scu[0]"
     mmio ffffffffffffffff/0000000000000080
   dev: aspeed.wdt-ast2700, id ""
     scu = "/machine/soc/ioexp[0]/ioexp-scu[0]"
     mmio ffffffffffffffff/0000000000000080
   dev: aspeed.wdt-ast2700, id ""
     scu = "/machine/soc/ioexp[0]/ioexp-scu[0]"
     mmio ffffffffffffffff/0000000000000080
   dev: aspeed.wdt-ast2700, id ""
     scu = "/machine/soc/ioexp[0]/ioexp-scu[0]"
     mmio ffffffffffffffff/0000000000000080
   dev: aspeed.wdt-ast2700, id ""
     scu = "/machine/soc/ioexp[0]/ioexp-scu[0]"
     mmio ffffffffffffffff/0000000000000080
   dev: aspeed.wdt-ast2700, id ""
     scu = "/machine/soc/ioexp[0]/ioexp-scu[0]"
     mmio ffffffffffffffff/0000000000000080
   dev: aspeed.wdt-ast2700, id ""
     scu = "/machine/soc/ioexp[0]/ioexp-scu[0]"
     mmio ffffffffffffffff/0000000000000080
   dev: aspeed.wdt-ast2700, id ""
     scu = "/machine/soc/ioexp[0]/ioexp-scu[0]"
     mmio ffffffffffffffff/0000000000000080
   dev: aspeed.sgpio-ast2700, id ""
     gpio-out "sysbus-irq" 1
     mmio ffffffffffffffff/0000000000001000
   dev: aspeed.sgpio-ast2700, id ""
     gpio-out "sysbus-irq" 1
     mmio ffffffffffffffff/0000000000001000
   dev: aspeed.ltpi-ctrl, id ""
     mmio ffffffffffffffff/0000000000000900
   dev: aspeed.pwm, id ""
     gpio-out "sysbus-irq" 1
     mmio ffffffffffffffff/0000000000001000
   dev: aspeed.i2c.bus, id ""
     gpio-out "sysbus-irq" 1
     bus-id = 15 (0xf)
     controller = "/machine/soc/ioexp[0]/ioexp-i2c[0]"
     bus-name = "ioexp0.15"
     mmio ffffffffffffffff/0000000000000080
     mmio ffffffffffffffff/0000000000000020
     bus: ioexp0.15
       type i2c-bus
       dev: aspeed.i2c.slave, id ""
         address = 255 (0xff)
   dev: aspeed.i2c.bus, id ""
     gpio-out "sysbus-irq" 1
     bus-id = 14 (0xe)
     controller = "/machine/soc/ioexp[0]/ioexp-i2c[0]"
     bus-name = "ioexp0.14"
     mmio ffffffffffffffff/0000000000000080
     mmio ffffffffffffffff/0000000000000020
     bus: ioexp0.14
       type i2c-bus
       dev: aspeed.i2c.slave, id ""
         address = 255 (0xff)
   dev: aspeed.i2c.bus, id ""
     gpio-out "sysbus-irq" 1
     bus-id = 13 (0xd)
     controller = "/machine/soc/ioexp[0]/ioexp-i2c[0]"
     bus-name = "ioexp0.13"
     mmio ffffffffffffffff/0000000000000080
     mmio ffffffffffffffff/0000000000000020
     bus: ioexp0.13
       type i2c-bus
       dev: aspeed.i2c.slave, id ""
         address = 255 (0xff)
   dev: aspeed.i2c.bus, id ""
     gpio-out "sysbus-irq" 1
     bus-id = 12 (0xc)
     controller = "/machine/soc/ioexp[0]/ioexp-i2c[0]"
     bus-name = "ioexp0.12"
     mmio ffffffffffffffff/0000000000000080
     mmio ffffffffffffffff/0000000000000020
     bus: ioexp0.12
       type i2c-bus
       dev: aspeed.i2c.slave, id ""
         address = 255 (0xff)
   dev: aspeed.i2c.bus, id ""
     gpio-out "sysbus-irq" 1
     bus-id = 11 (0xb)
     controller = "/machine/soc/ioexp[0]/ioexp-i2c[0]"
     bus-name = "ioexp0.11"
     mmio ffffffffffffffff/0000000000000080
     mmio ffffffffffffffff/0000000000000020
     bus: ioexp0.11
       type i2c-bus
       dev: aspeed.i2c.slave, id ""
         address = 255 (0xff)
   dev: aspeed.i2c.bus, id ""
     gpio-out "sysbus-irq" 1
     bus-id = 10 (0xa)
     controller = "/machine/soc/ioexp[0]/ioexp-i2c[0]"
     bus-name = "ioexp0.10"
     mmio ffffffffffffffff/0000000000000080
     mmio ffffffffffffffff/0000000000000020
     bus: ioexp0.10
       type i2c-bus
       dev: aspeed.i2c.slave, id ""
         address = 255 (0xff)
   dev: aspeed.i2c.bus, id ""
     gpio-out "sysbus-irq" 1
     bus-id = 9 (0x9)
     controller = "/machine/soc/ioexp[0]/ioexp-i2c[0]"
     bus-name = "ioexp0.9"
     mmio ffffffffffffffff/0000000000000080
     mmio ffffffffffffffff/0000000000000020
     bus: ioexp0.9
       type i2c-bus
       dev: aspeed.i2c.slave, id ""
         address = 255 (0xff)
   dev: aspeed.i2c.bus, id ""
     gpio-out "sysbus-irq" 1
     bus-id = 8 (0x8)
     controller = "/machine/soc/ioexp[0]/ioexp-i2c[0]"
     bus-name = "ioexp0.8"
     mmio ffffffffffffffff/0000000000000080
     mmio ffffffffffffffff/0000000000000020
     bus: ioexp0.8
       type i2c-bus
       dev: aspeed.i2c.slave, id ""
         address = 255 (0xff)
   dev: aspeed.i2c.bus, id ""
     gpio-out "sysbus-irq" 1
     bus-id = 7 (0x7)
     controller = "/machine/soc/ioexp[0]/ioexp-i2c[0]"
     bus-name = "ioexp0.7"
     mmio ffffffffffffffff/0000000000000080
     mmio ffffffffffffffff/0000000000000020
     bus: ioexp0.7
       type i2c-bus
       dev: aspeed.i2c.slave, id ""
         address = 255 (0xff)
   dev: aspeed.i2c.bus, id ""
     gpio-out "sysbus-irq" 1
     bus-id = 6 (0x6)
     controller = "/machine/soc/ioexp[0]/ioexp-i2c[0]"
     bus-name = "ioexp0.6"
     mmio ffffffffffffffff/0000000000000080
     mmio ffffffffffffffff/0000000000000020
     bus: ioexp0.6
       type i2c-bus
       dev: aspeed.i2c.slave, id ""
         address = 255 (0xff)
   dev: aspeed.i2c.bus, id ""
     gpio-out "sysbus-irq" 1
     bus-id = 5 (0x5)
     controller = "/machine/soc/ioexp[0]/ioexp-i2c[0]"
     bus-name = "ioexp0.5"
     mmio ffffffffffffffff/0000000000000080
     mmio ffffffffffffffff/0000000000000020
     bus: ioexp0.5
       type i2c-bus
       dev: aspeed.i2c.slave, id ""
         address = 255 (0xff)
   dev: aspeed.i2c.bus, id ""
     gpio-out "sysbus-irq" 1
     bus-id = 4 (0x4)
     controller = "/machine/soc/ioexp[0]/ioexp-i2c[0]"
     bus-name = "ioexp0.4"
     mmio ffffffffffffffff/0000000000000080
     mmio ffffffffffffffff/0000000000000020
     bus: ioexp0.4
       type i2c-bus
       dev: aspeed.i2c.slave, id ""
         address = 255 (0xff)
   dev: aspeed.i2c.bus, id ""
     gpio-out "sysbus-irq" 1
     bus-id = 3 (0x3)
     controller = "/machine/soc/ioexp[0]/ioexp-i2c[0]"
     bus-name = "ioexp0.3"
     mmio ffffffffffffffff/0000000000000080
     mmio ffffffffffffffff/0000000000000020
     bus: ioexp0.3
       type i2c-bus
       dev: aspeed.i2c.slave, id ""
         address = 255 (0xff)
   dev: aspeed.i2c.bus, id ""
     gpio-out "sysbus-irq" 1
     bus-id = 2 (0x2)
     controller = "/machine/soc/ioexp[0]/ioexp-i2c[0]"
     bus-name = "ioexp0.2"
     mmio ffffffffffffffff/0000000000000080
     mmio ffffffffffffffff/0000000000000020
     bus: ioexp0.2
       type i2c-bus
       dev: aspeed.i2c.slave, id ""
         address = 255 (0xff)
   dev: aspeed.i2c.bus, id ""
     gpio-out "sysbus-irq" 1
     bus-id = 1 (0x1)
     controller = "/machine/soc/ioexp[0]/ioexp-i2c[0]"
     bus-name = "ioexp0.1"
     mmio ffffffffffffffff/0000000000000080
     mmio ffffffffffffffff/0000000000000020
     bus: ioexp0.1
       type i2c-bus
       dev: aspeed.i2c.slave, id ""
         address = 255 (0xff)
   dev: aspeed.i2c.bus, id ""
     gpio-out "sysbus-irq" 1
     bus-id = 0 (0x0)
     controller = "/machine/soc/ioexp[0]/ioexp-i2c[0]"
     bus-name = "ioexp0.0"
     mmio ffffffffffffffff/0000000000000080
     mmio ffffffffffffffff/0000000000000020
     bus: ioexp0.0
       type i2c-bus
       dev: aspeed.i2c.slave, id ""
         address = 255 (0xff)
   dev: aspeed.i2c-ast2700, id ""
     gpio-out "sysbus-irq" 1
     dram = "/machine/soc/ioexp[0]/aspeed.ast1700[0]"
     bus-label = "ioexp0"
     mmio ffffffffffffffff/0000000000002000
   dev: aspeed.gpio-ast2700, id ""
     gpio-out "sysbus-irq" 213
     mmio ffffffffffffffff/0000000000001000
   dev: aspeed.scu-ast2700, id ""
     silicon-rev = 100729091 (0x6010103)
     hw-strap1 = 0 (0x0)
     hw-strap2 = 0 (0x0)
     hw-prot-key = 0 (0x0)
     mmio ffffffffffffffff/0000000000001000
   dev: aspeed.adc.engine, id ""
     gpio-out "sysbus-irq" 1
     engine-id = 1 (0x1)
     nr-channels = 8 (0x8)
     mmio ffffffffffffffff/0000000000000100
   dev: aspeed.adc.engine, id ""
     gpio-out "sysbus-irq" 1
     engine-id = 0 (0x0)
     nr-channels = 8 (0x8)
     mmio ffffffffffffffff/0000000000000100
   dev: aspeed.adc-ast2700, id ""
     gpio-out "sysbus-irq" 1
     gpio-in "" 2
     mmio ffffffffffffffff/0000000000001000
   dev: aspeed.smc.flash, id ""
     cs = 1 (0x1)
     controller = "/machine/soc/ioexp[0]/ioexp-spi[0]"
     mmio ffffffffffffffff/0000000008000000
   dev: aspeed.smc.flash, id ""
     cs = 0 (0x0)
     controller = "/machine/soc/ioexp[0]/ioexp-spi[0]"
     mmio ffffffffffffffff/0000000008000000
   dev: aspeed.spi0-ast2700, id ""
     gpio-out "cs" 2
     gpio-out "sysbus-irq" 1
     inject-failure = false
     dram-base = 0 (0x0)
     dram = "/machine/soc/ioexp[0]/aspeed.ast1700[0]"
     mmio ffffffffffffffff/0000000000000100
     mmio ffffffffffffffff/0000000040000000
     bus: ssi.4
       type SSI
   dev: serial-mm, id ""
     gpio-out "sysbus-irq" 1
     regshift = 2 (0x2)
     endianness = 2 (0x2)
     mmio ffffffffffffffff/0000000000000020
   dev: aspeed.ast1700, id ""
     board-idx = 0 (0x0)
     silicon-rev = 100729091 (0x6010103)
     mmio 0000000030000000/0000000001000000
   dev: aspeed.ltpi-ctrl, id ""
     mmio ffffffffffffffff/0000000000000900
   dev: aspeed.ltpi-ctrl, id ""
     mmio ffffffffffffffff/0000000000000900
   dev: aspeed.pcie-rc, id ""
     gpio-out "sysbus-irq" 1
     bus-nr = 0 (0x0)
     has-rd = false
     rp-addr = 0 (0x0)
     msi-addr = 240 (0xf0)
     dram-base = 17179869184 (0x400000000)
     dram = "/objects/ram/ram[0]"
     x-config-reg-migration-enabled = true
     bypass-iommu = false
     mmio ffffffffffffffff/0000000010000000
     mmio ffffffffffffffff/ffffffffffffffff
     mmio ffffffffffffffff/0000000000010000
     bus: pcie.rc2
       type PCIE
       dev: aspeed.pcie-root-port, id ""
         power_controller_present = true
         disable-acs = false
         chassis = 2 (0x2)
         slot = 0 (0x0)
         hotplug = true
         x-do-not-expose-native-hotplug-cap = false
         port = 0 (0x0)
         aer_log_max = 8 (0x8)
         x-pci-express-writeable-slt-bug = false
         addr = 00.0
         romfile = ""
         romsize = 4294967295 (0xffffffff)
         rombar = -1 (0xffffffffffffffff)
         multifunction = false
         x-pcie-lnksta-dllla = true
         x-pcie-extcap-init = true
         failover_pair_id = ""
         acpi-index = 0 (0x0)
         x-pcie-err-unc-mask = true
         x-pcie-ari-nextfn-1 = false
         x-max-bounce-buffer-size = 4096 (4 KiB)
         sriov-pf = ""
         x-pcie-ext-tag = true
         busnr = 0 (0x0)
         class PCI bridge, addr 00:00.0, pci id 1a03:1150 (sub 0000:0000)
         bus: pcie.2
           type PCIE
   dev: aspeed.pcie-cfg-ast2700, id ""
     id = 2 (0x2)
     mmio ffffffffffffffff/0000000000000100
   dev: aspeed.pcie-phy-ast2700, id ""
     id = 2 (0x2)
     mmio ffffffffffffffff/0000000000000800
   dev: aspeed.pcie-rc, id ""
     gpio-out "sysbus-irq" 1
     bus-nr = 0 (0x0)
     has-rd = false
     rp-addr = 0 (0x0)
     msi-addr = 240 (0xf0)
     dram-base = 17179869184 (0x400000000)
     dram = "/objects/ram/ram[0]"
     x-config-reg-migration-enabled = true
     bypass-iommu = false
     mmio ffffffffffffffff/0000000010000000
     mmio ffffffffffffffff/ffffffffffffffff
     mmio ffffffffffffffff/0000000000010000
     bus: pcie.rc1
       type PCIE
       dev: aspeed.pcie-root-port, id ""
         power_controller_present = true
         disable-acs = false
         chassis = 1 (0x1)
         slot = 0 (0x0)
         hotplug = true
         x-do-not-expose-native-hotplug-cap = false
         port = 0 (0x0)
         aer_log_max = 8 (0x8)
         x-pci-express-writeable-slt-bug = false
         addr = 00.0
         romfile = ""
         romsize = 4294967295 (0xffffffff)
         rombar = -1 (0xffffffffffffffff)
         multifunction = false
         x-pcie-lnksta-dllla = true
         x-pcie-extcap-init = true
         failover_pair_id = ""
         acpi-index = 0 (0x0)
         x-pcie-err-unc-mask = true
         x-pcie-ari-nextfn-1 = false
         x-max-bounce-buffer-size = 4096 (4 KiB)
         sriov-pf = ""
         x-pcie-ext-tag = true
         busnr = 0 (0x0)
         class PCI bridge, addr 00:00.0, pci id 1a03:1150 (sub 0000:0000)
         bus: pcie.1
           type PCIE
   dev: aspeed.pcie-cfg-ast2700, id ""
     id = 1 (0x1)
     mmio ffffffffffffffff/0000000000000100
   dev: aspeed.pcie-phy-ast2700, id ""
     id = 1 (0x1)
     mmio ffffffffffffffff/0000000000000800
   dev: aspeed.pcie-rc, id ""
     gpio-out "sysbus-irq" 1
     bus-nr = 0 (0x0)
     has-rd = false
     rp-addr = 0 (0x0)
     msi-addr = 240 (0xf0)
     dram-base = 17179869184 (0x400000000)
     dram = "/objects/ram/ram[0]"
     x-config-reg-migration-enabled = true
     bypass-iommu = false
     mmio ffffffffffffffff/0000000010000000
     mmio ffffffffffffffff/ffffffffffffffff
     mmio ffffffffffffffff/0000000000010000
     bus: pcie.rc0
       type PCIE
       dev: aspeed.pcie-root-port, id ""
         power_controller_present = true
         disable-acs = false
         chassis = 0 (0x0)
         slot = 0 (0x0)
         hotplug = true
         x-do-not-expose-native-hotplug-cap = false
         port = 0 (0x0)
         aer_log_max = 8 (0x8)
         x-pci-express-writeable-slt-bug = false
         addr = 00.0
         romfile = ""
         romsize = 4294967295 (0xffffffff)
         rombar = -1 (0xffffffffffffffff)
         multifunction = false
         x-pcie-lnksta-dllla = true
         x-pcie-extcap-init = true
         failover_pair_id = ""
         acpi-index = 0 (0x0)
         x-pcie-err-unc-mask = true
         x-pcie-ari-nextfn-1 = false
         x-max-bounce-buffer-size = 4096 (4 KiB)
         sriov-pf = ""
         x-pcie-ext-tag = true
         busnr = 0 (0x0)
         class PCI bridge, addr 00:00.0, pci id 1a03:1150 (sub 0000:0000)
         bus: pcie.0
           type PCIE
   dev: aspeed.pcie-cfg-ast2700, id ""
     id = 0 (0x0)
     mmio ffffffffffffffff/0000000000000100
   dev: aspeed.pcie-phy-ast2700, id ""
     id = 0 (0x0)
     mmio ffffffffffffffff/0000000000000800
   dev: aspeed.hace-ast2700, id ""
     gpio-out "sysbus-irq" 1
     dram = "/objects/ram/ram[0]"
     mmio ffffffffffffffff/000000000000009c
   dev: aspeed.timer-ast2700, id ""
     gpio-out "sysbus-irq" 8
     scu = "/machine/soc/scu"
     mmio ffffffffffffffff/0000000000001000
   dev: generic-sdhci, id ""
     gpio-out "sysbus-irq" 1
     endianness = 2 (0x2)
     sd-spec-version = 2 (0x2)
     uhs = 0 (0x0)
     vendor = 0 (0x0)
     capareg = 30567563392 (0x71df80080)
     maxcurr = 0 (0x0)
     pending-insert-quirk = false
     dma = ""
     wp-inverted = false
     mmio ffffffffffffffff/0000000000000100
     bus: sd-bus
       type sdhci-bus
   dev: aspeed.sdhci-ast2700, id ""
     gpio-out "sysbus-irq" 1
     gpio-in "" 1
     num-slots = 1 (0x1)
     mmio ffffffffffffffff/0000000000001000
   dev: generic-sdhci, id ""
     gpio-out "sysbus-irq" 1
     endianness = 2 (0x2)
     sd-spec-version = 2 (0x2)
     uhs = 0 (0x0)
     vendor = 0 (0x0)
     capareg = 30567563392 (0x71df80080)
     maxcurr = 0 (0x0)
     pending-insert-quirk = false
     dma = ""
     wp-inverted = false
     mmio ffffffffffffffff/0000000000000100
     bus: sd-bus
       type sdhci-bus
   dev: aspeed.sdhci-ast2700, id ""
     gpio-out "sysbus-irq" 1
     gpio-in "" 1
     num-slots = 1 (0x1)
     mmio ffffffffffffffff/0000000000001000
   dev: aspeed.rtc, id ""
     gpio-out "sysbus-irq" 1
     mmio ffffffffffffffff/0000000000000018
   dev: aspeed.sgpio-ast2700, id ""
     gpio-out "sysbus-irq" 1
     mmio ffffffffffffffff/0000000000001000
   dev: aspeed.sgpio-ast2700, id ""
     gpio-out "sysbus-irq" 1
     mmio ffffffffffffffff/0000000000001000
   dev: aspeed.gpio-ast2700, id ""
     gpio-out "sysbus-irq" 213
     mmio ffffffffffffffff/0000000000001000
   dev: aspeed.i2c.bus, id ""
     gpio-out "sysbus-irq" 1
     bus-id = 15 (0xf)
     controller = "/machine/soc/i2c"
     bus-name = "aspeed.i2c.bus.15"
     mmio ffffffffffffffff/0000000000000080
     mmio ffffffffffffffff/0000000000000020
     bus: aspeed.i2c.bus.15
       type i2c-bus
       dev: aspeed.i2c.slave, id ""
         address = 255 (0xff)
   dev: aspeed.i2c.bus, id ""
     gpio-out "sysbus-irq" 1
     bus-id = 14 (0xe)
     controller = "/machine/soc/i2c"
     bus-name = "aspeed.i2c.bus.14"
     mmio ffffffffffffffff/0000000000000080
     mmio ffffffffffffffff/0000000000000020
     bus: aspeed.i2c.bus.14
       type i2c-bus
       dev: aspeed.i2c.slave, id ""
         address = 255 (0xff)
   dev: aspeed.i2c.bus, id ""
     gpio-out "sysbus-irq" 1
     bus-id = 13 (0xd)
     controller = "/machine/soc/i2c"
     bus-name = "aspeed.i2c.bus.13"
     mmio ffffffffffffffff/0000000000000080
     mmio ffffffffffffffff/0000000000000020
     bus: aspeed.i2c.bus.13
       type i2c-bus
       dev: aspeed.i2c.slave, id ""
         address = 255 (0xff)
   dev: aspeed.i2c.bus, id ""
     gpio-out "sysbus-irq" 1
     bus-id = 12 (0xc)
     controller = "/machine/soc/i2c"
     bus-name = "aspeed.i2c.bus.12"
     mmio ffffffffffffffff/0000000000000080
     mmio ffffffffffffffff/0000000000000020
     bus: aspeed.i2c.bus.12
       type i2c-bus
       dev: aspeed.i2c.slave, id ""
         address = 255 (0xff)
   dev: aspeed.i2c.bus, id ""
     gpio-out "sysbus-irq" 1
     bus-id = 11 (0xb)
     controller = "/machine/soc/i2c"
     bus-name = "aspeed.i2c.bus.11"
     mmio ffffffffffffffff/0000000000000080
     mmio ffffffffffffffff/0000000000000020
     bus: aspeed.i2c.bus.11
       type i2c-bus
       dev: aspeed.i2c.slave, id ""
         address = 255 (0xff)
   dev: aspeed.i2c.bus, id ""
     gpio-out "sysbus-irq" 1
     bus-id = 10 (0xa)
     controller = "/machine/soc/i2c"
     bus-name = "aspeed.i2c.bus.10"
     mmio ffffffffffffffff/0000000000000080
     mmio ffffffffffffffff/0000000000000020
     bus: aspeed.i2c.bus.10
       type i2c-bus
       dev: aspeed.i2c.slave, id ""
         address = 255 (0xff)
   dev: aspeed.i2c.bus, id ""
     gpio-out "sysbus-irq" 1
     bus-id = 9 (0x9)
     controller = "/machine/soc/i2c"
     bus-name = "aspeed.i2c.bus.9"
     mmio ffffffffffffffff/0000000000000080
     mmio ffffffffffffffff/0000000000000020
     bus: aspeed.i2c.bus.9
       type i2c-bus
       dev: aspeed.i2c.slave, id ""
         address = 255 (0xff)
   dev: aspeed.i2c.bus, id ""
     gpio-out "sysbus-irq" 1
     bus-id = 8 (0x8)
     controller = "/machine/soc/i2c"
     bus-name = "aspeed.i2c.bus.8"
     mmio ffffffffffffffff/0000000000000080
     mmio ffffffffffffffff/0000000000000020
     bus: aspeed.i2c.bus.8
       type i2c-bus
       dev: aspeed.i2c.slave, id ""
         address = 255 (0xff)
   dev: aspeed.i2c.bus, id ""
     gpio-out "sysbus-irq" 1
     bus-id = 7 (0x7)
     controller = "/machine/soc/i2c"
     bus-name = "aspeed.i2c.bus.7"
     mmio ffffffffffffffff/0000000000000080
     mmio ffffffffffffffff/0000000000000020
     bus: aspeed.i2c.bus.7
       type i2c-bus
       dev: aspeed.i2c.slave, id ""
         address = 255 (0xff)
   dev: aspeed.i2c.bus, id ""
     gpio-out "sysbus-irq" 1
     bus-id = 6 (0x6)
     controller = "/machine/soc/i2c"
     bus-name = "aspeed.i2c.bus.6"
     mmio ffffffffffffffff/0000000000000080
     mmio ffffffffffffffff/0000000000000020
     bus: aspeed.i2c.bus.6
       type i2c-bus
       dev: aspeed.i2c.slave, id ""
         address = 255 (0xff)
   dev: aspeed.i2c.bus, id ""
     gpio-out "sysbus-irq" 1
     bus-id = 5 (0x5)
     controller = "/machine/soc/i2c"
     bus-name = "aspeed.i2c.bus.5"
     mmio ffffffffffffffff/0000000000000080
     mmio ffffffffffffffff/0000000000000020
     bus: aspeed.i2c.bus.5
       type i2c-bus
       dev: aspeed.i2c.slave, id ""
         address = 255 (0xff)
   dev: aspeed.i2c.bus, id ""
     gpio-out "sysbus-irq" 1
     bus-id = 4 (0x4)
     controller = "/machine/soc/i2c"
     bus-name = "aspeed.i2c.bus.4"
     mmio ffffffffffffffff/0000000000000080
     mmio ffffffffffffffff/0000000000000020
     bus: aspeed.i2c.bus.4
       type i2c-bus
       dev: aspeed.i2c.slave, id ""
         address = 255 (0xff)
   dev: aspeed.i2c.bus, id ""
     gpio-out "sysbus-irq" 1
     bus-id = 3 (0x3)
     controller = "/machine/soc/i2c"
     bus-name = "aspeed.i2c.bus.3"
     mmio ffffffffffffffff/0000000000000080
     mmio ffffffffffffffff/0000000000000020
     bus: aspeed.i2c.bus.3
       type i2c-bus
       dev: aspeed.i2c.slave, id ""
         address = 255 (0xff)
   dev: aspeed.i2c.bus, id ""
     gpio-out "sysbus-irq" 1
     bus-id = 2 (0x2)
     controller = "/machine/soc/i2c"
     bus-name = "aspeed.i2c.bus.2"
     mmio ffffffffffffffff/0000000000000080
     mmio ffffffffffffffff/0000000000000020
     bus: aspeed.i2c.bus.2
       type i2c-bus
       dev: aspeed.i2c.slave, id ""
         address = 255 (0xff)
   dev: aspeed.i2c.bus, id ""
     gpio-out "sysbus-irq" 1
     bus-id = 1 (0x1)
     controller = "/machine/soc/i2c"
     bus-name = "aspeed.i2c.bus.1"
     mmio ffffffffffffffff/0000000000000080
     mmio ffffffffffffffff/0000000000000020
     bus: aspeed.i2c.bus.1
       type i2c-bus
       dev: aspeed.i2c.slave, id ""
         address = 255 (0xff)
   dev: aspeed.i2c.bus, id ""
     gpio-out "sysbus-irq" 1
     bus-id = 0 (0x0)
     controller = "/machine/soc/i2c"
     bus-name = "aspeed.i2c.bus.0"
     mmio ffffffffffffffff/0000000000000080
     mmio ffffffffffffffff/0000000000000020
     bus: aspeed.i2c.bus.0
       type i2c-bus
       dev: tmp105, id ""
         gpio-out "" 1
         address = 77 (0x4d)
       dev: aspeed.i2c.slave, id ""
         address = 255 (0xff)
   dev: aspeed.i2c-ast2700, id ""
     gpio-out "sysbus-irq" 1
     dram = "/objects/ram/ram[0]"
     bus-label = "aspeed.i2c.bus"
     mmio ffffffffffffffff/0000000000002000
   dev: aspeed.adc.engine, id ""
     gpio-out "sysbus-irq" 1
     engine-id = 1 (0x1)
     nr-channels = 8 (0x8)
     mmio ffffffffffffffff/0000000000000100
   dev: aspeed.adc.engine, id ""
     gpio-out "sysbus-irq" 1
     engine-id = 0 (0x0)
     nr-channels = 8 (0x8)
     mmio ffffffffffffffff/0000000000000100
   dev: aspeed.adc-ast2700, id ""
     gpio-out "sysbus-irq" 1
     gpio-in "" 2
     mmio ffffffffffffffff/0000000000001000
   dev: aspeed.sliio-ast2700, id ""
     mmio ffffffffffffffff/0000000000000500
   dev: aspeed.sli-ast2700, id ""
     mmio ffffffffffffffff/0000000000000500
   dev: aspeed.wdt-ast2700, id ""
     scu = "/machine/soc/scu"
     mmio ffffffffffffffff/0000000000000080
   dev: aspeed.wdt-ast2700, id ""
     scu = "/machine/soc/scu"
     mmio ffffffffffffffff/0000000000000080
   dev: aspeed.wdt-ast2700, id ""
     scu = "/machine/soc/scu"
     mmio ffffffffffffffff/0000000000000080
   dev: aspeed.wdt-ast2700, id ""
     scu = "/machine/soc/scu"
     mmio ffffffffffffffff/0000000000000080
   dev: aspeed.wdt-ast2700, id ""
     scu = "/machine/soc/scu"
     mmio ffffffffffffffff/0000000000000080
   dev: aspeed.wdt-ast2700, id ""
     scu = "/machine/soc/scu"
     mmio ffffffffffffffff/0000000000000080
   dev: aspeed.wdt-ast2700, id ""
     scu = "/machine/soc/scu"
     mmio ffffffffffffffff/0000000000000080
   dev: aspeed.wdt-ast2700, id ""
     scu = "/machine/soc/scu"
     mmio ffffffffffffffff/0000000000000080
   dev: aspeed-mmi, id ""
     nic = "/machine/soc/ftgmac100[2]"
     mmio ffffffffffffffff/0000000000000008
   dev: ftgmac100, id ""
     gpio-out "sysbus-irq" 1
     aspeed = true
     mac = "52:54:00:12:34:58"
     netdev = ""
     dma64 = true
     mmio ffffffffffffffff/0000000000001000
   dev: aspeed-mmi, id ""
     nic = "/machine/soc/ftgmac100[1]"
     mmio ffffffffffffffff/0000000000000008
   dev: ftgmac100, id ""
     gpio-out "sysbus-irq" 1
     aspeed = true
     mac = "52:54:00:12:34:57"
     netdev = ""
     dma64 = true
     mmio ffffffffffffffff/0000000000001000
   dev: aspeed-mmi, id ""
     nic = "/machine/soc/ftgmac100[0]"
     mmio ffffffffffffffff/0000000000000008
   dev: ftgmac100, id ""
     gpio-out "sysbus-irq" 1
     aspeed = true
     mac = "52:54:00:12:34:56"
     netdev = "net0"
     dma64 = true
     mmio ffffffffffffffff/0000000000001000
   dev: aspeed.sdmc-ast2700, id ""
     max-ram-size = 8589934592 (0x200000000)
     unlocked = true
     mmio ffffffffffffffff/0000000000001000
   dev: platform-ehci-usb, id ""
     gpio-out "sysbus-irq" 1
     maxframes = 128 (0x80)
     companion-enable = false
     mmio ffffffffffffffff/0000000000001000
     bus: usb-bus.3
       type usb-bus
   dev: platform-ehci-usb, id ""
     gpio-out "sysbus-irq" 1
     maxframes = 128 (0x80)
     companion-enable = false
     mmio ffffffffffffffff/0000000000001000
     bus: usb-bus.2
       type usb-bus
   dev: platform-ehci-usb, id ""
     gpio-out "sysbus-irq" 1
     maxframes = 128 (0x80)
     companion-enable = false
     mmio ffffffffffffffff/0000000000001000
     bus: usb-bus.1
       type usb-bus
   dev: platform-ehci-usb, id ""
     gpio-out "sysbus-irq" 1
     maxframes = 128 (0x80)
     companion-enable = false
     mmio ffffffffffffffff/0000000000001000
     bus: usb-bus.0
       type usb-bus
   dev: aspeed.smc.flash, id ""
     cs = 1 (0x1)
     controller = "/machine/soc/spi[2]"
     mmio ffffffffffffffff/0000000000000000
   dev: aspeed.smc.flash, id ""
     cs = 0 (0x0)
     controller = "/machine/soc/spi[2]"
     mmio ffffffffffffffff/0000000008000000
   dev: aspeed.spi2-ast2700, id ""
     gpio-out "cs" 2
     gpio-out "sysbus-irq" 1
     inject-failure = false
     dram-base = 0 (0x0)
     dram = "/objects/ram/ram[0]"
     mmio ffffffffffffffff/0000000000000100
     mmio ffffffffffffffff/0000000040000000
     bus: ssi.3
       type SSI
   dev: aspeed.smc.flash, id ""
     cs = 1 (0x1)
     controller = "/machine/soc/spi[1]"
     mmio ffffffffffffffff/0000000000000000
   dev: aspeed.smc.flash, id ""
     cs = 0 (0x0)
     controller = "/machine/soc/spi[1]"
     mmio ffffffffffffffff/0000000008000000
   dev: aspeed.spi1-ast2700, id ""
     gpio-out "cs" 2
     gpio-out "sysbus-irq" 1
     inject-failure = false
     dram-base = 0 (0x0)
     dram = "/objects/ram/ram[0]"
     mmio ffffffffffffffff/0000000000000100
     mmio ffffffffffffffff/0000000040000000
     bus: ssi.2
       type SSI
   dev: aspeed.smc.flash, id ""
     cs = 1 (0x1)
     controller = "/machine/soc/spi[0]"
     mmio ffffffffffffffff/0000000008000000
   dev: aspeed.smc.flash, id ""
     cs = 0 (0x0)
     controller = "/machine/soc/spi[0]"
     mmio ffffffffffffffff/0000000008000000
   dev: aspeed.spi0-ast2700, id ""
     gpio-out "cs" 2
     gpio-out "sysbus-irq" 1
     inject-failure = false
     dram-base = 0 (0x0)
     dram = "/objects/ram/ram[0]"
     mmio ffffffffffffffff/0000000000000100
     mmio ffffffffffffffff/0000000040000000
     bus: ssi.1
       type SSI
       dev: w25q512jv, id ""
         gpio-in "WP#" 1
         gpio-in "ssi-gpio-cs" 1
         write-enable = false
         nonvolatile-cfg = 36863 (0x8fff)
         spansion-cr1nv = 0 (0x0)
         spansion-cr2nv = 8 (0x8)
         spansion-cr3nv = 2 (0x2)
         spansion-cr4nv = 16 (0x10)
         drive = ""
         cs = 0 (0x0)
   dev: aspeed.smc.flash, id ""
     cs = 2 (0x2)
     controller = "/machine/soc/fmc"
     mmio ffffffffffffffff/0000000008000000
   dev: aspeed.smc.flash, id ""
     cs = 1 (0x1)
     controller = "/machine/soc/fmc"
     mmio ffffffffffffffff/0000000008000000
   dev: aspeed.smc.flash, id ""
     cs = 0 (0x0)
     controller = "/machine/soc/fmc"
     mmio ffffffffffffffff/0000000008010000
   dev: aspeed.fmc-ast2700, id ""
     gpio-out "cs" 3
     gpio-out "sysbus-irq" 1
     inject-failure = false
     dram-base = 17179869184 (0x400000000)
     dram = "/objects/ram/ram[0]"
     mmio ffffffffffffffff/0000000000000100
     mmio ffffffffffffffff/0000000040000000
     bus: ssi.0
       type SSI
       dev: w25q01jvq, id ""
         gpio-in "WP#" 1
         gpio-in "ssi-gpio-cs" 1
         write-enable = false
         nonvolatile-cfg = 36863 (0x8fff)
         spansion-cr1nv = 0 (0x0)
         spansion-cr2nv = 8 (0x8)
         spansion-cr3nv = 2 (0x2)
         spansion-cr4nv = 16 (0x10)
         drive = ""
         cs = 1 (0x1)
       dev: w25q01jvq, id ""
         gpio-in "WP#" 1
         gpio-in "ssi-gpio-cs" 1
         write-enable = false
         nonvolatile-cfg = 36863 (0x8fff)
         spansion-cr1nv = 0 (0x0)
         spansion-cr2nv = 8 (0x8)
         spansion-cr3nv = 2 (0x2)
         spansion-cr4nv = 16 (0x10)
         drive = "mtd0"
         cs = 0 (0x0)
   dev: serial-mm, id ""
     gpio-out "sysbus-irq" 1
     regshift = 2 (0x2)
     endianness = 2 (0x2)
     mmio ffffffffffffffff/0000000000000020
   dev: serial-mm, id ""
     gpio-out "sysbus-irq" 1
     regshift = 2 (0x2)
     endianness = 2 (0x2)
     mmio ffffffffffffffff/0000000000000020
   dev: serial-mm, id ""
     gpio-out "sysbus-irq" 1
     regshift = 2 (0x2)
     endianness = 2 (0x2)
     mmio ffffffffffffffff/0000000000000020
   dev: serial-mm, id ""
     gpio-out "sysbus-irq" 1
     regshift = 2 (0x2)
     endianness = 2 (0x2)
     mmio ffffffffffffffff/0000000000000020
   dev: serial-mm, id ""
     gpio-out "sysbus-irq" 1
     regshift = 2 (0x2)
     endianness = 2 (0x2)
     mmio ffffffffffffffff/0000000000000020
   dev: serial-mm, id ""
     gpio-out "sysbus-irq" 1
     regshift = 2 (0x2)
     endianness = 2 (0x2)
     mmio ffffffffffffffff/0000000000000020
   dev: serial-mm, id ""
     gpio-out "sysbus-irq" 1
     regshift = 2 (0x2)
     endianness = 2 (0x2)
     mmio ffffffffffffffff/0000000000000020
   dev: serial-mm, id ""
     gpio-out "sysbus-irq" 1
     regshift = 2 (0x2)
     endianness = 2 (0x2)
     mmio ffffffffffffffff/0000000000000020
   dev: serial-mm, id ""
     gpio-out "sysbus-irq" 1
     regshift = 2 (0x2)
     endianness = 2 (0x2)
     mmio ffffffffffffffff/0000000000000020
   dev: serial-mm, id ""
     gpio-out "sysbus-irq" 1
     regshift = 2 (0x2)
     endianness = 2 (0x2)
     mmio ffffffffffffffff/0000000000000020
   dev: serial-mm, id ""
     gpio-out "sysbus-irq" 1
     regshift = 2 (0x2)
     endianness = 2 (0x2)
     mmio ffffffffffffffff/0000000000000020
   dev: serial-mm, id ""
     gpio-out "sysbus-irq" 1
     regshift = 2 (0x2)
     endianness = 2 (0x2)
     mmio ffffffffffffffff/0000000000000020
   dev: serial-mm, id ""
     gpio-out "sysbus-irq" 1
     regshift = 2 (0x2)
     endianness = 2 (0x2)
     mmio ffffffffffffffff/0000000000000020
   dev: aspeed.scuio-ast2700, id ""
     silicon-rev = 100729091 (0x6010103)
     hw-strap1 = 1792 (0x700)
     hw-strap2 = 0 (0x0)
     hw-prot-key = 0 (0x0)
     mmio ffffffffffffffff/0000000000001000
   dev: aspeed.scu-ast2700, id ""
     silicon-rev = 100729091 (0x6010103)
     hw-strap1 = 2048 (0x800)
     hw-strap2 = 0 (0x0)
     hw-prot-key = 0 (0x0)
     mmio ffffffffffffffff/0000000000001000
   dev: aspeed.intcast2700-ioexp2, id ""
     gpio-out "sysbus-irq" 10
     gpio-in "" 2
     mmio ffffffffffffffff/0000000000000400
   dev: aspeed.intcast2700-ioexp1, id ""
     gpio-out "sysbus-irq" 10
     gpio-in "" 2
     mmio ffffffffffffffff/0000000000000400
   dev: aspeed.intcio-ast2700, id ""
     gpio-out "sysbus-irq" 6
     gpio-in "" 6
     mmio ffffffffffffffff/0000000000000400
   dev: aspeed.intc-ast2700, id ""
     gpio-out "sysbus-irq" 10
     gpio-in "" 1
     mmio ffffffffffffffff/0000000000004000
   dev: arm-gicv3, id ""
     gpio-out "sysbus-irq" 24
     gpio-in "" 384
     num-cpu = 4 (0x4)
     num-irq = 288 (0x120)
     revision = 3 (0x3)
     has-lpi = false
     has-nmi = false
     has-security-extensions = false
     maintenance-interrupt-id = 0 (0x0)
     force-8-bit-prio = false
     redist-region-count = 4 (0x4)
     sysmem = ""
     first-cpu-index = 0 (0x0)
     mmio ffffffffffffffff/0000000000010000
     mmio ffffffffffffffff/0000000000080000


