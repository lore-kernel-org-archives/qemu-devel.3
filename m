Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AC74CC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 06:39:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHbaG-0000Xj-HI; Fri, 16 Oct 2026 02:38:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1xHbaC-0000XR-Hf
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 02:38:24 -0400
Received: from smtpout4.mo539.mail-out.ovh.net ([51.210.91.43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1xHba9-0006c5-H3
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 02:38:24 -0400
Received: from director3.derp.mail-out.ovh.net
 (director3.derp.mail-out.ovh.net [79.137.60.223])
 by mo539.mail-out.ovh.net (Postfix) with ESMTPS id 4j5ZyB1yxHz42BR;
 Fri, 16 Oct 2026 06:38:09 +0000 (UTC)
Received: from director3.derp.mail-out.ovh.net
 (director3.derp.mail-out.ovh.net. [127.0.0.1])
 by director3.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Fri, 16 Oct 2026 06:38:09 +0000 (UTC)
Received: from mta11.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.0.187])
 by director3.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4j5Zy94NcWz1xp9; Fri, 16 Oct 2026 06:38:09 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.1])
 (Authenticated sender: clg@kaod.org)
 by mta11.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id
 C4B342402CC4; Fri, 16 Oct 2026 06:38:07 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-95G001ec1da373-2883-4b99-aa6a-696e3d4a43e3,
 0C85999E399CE1B7F5342D8E40E21A4D75FD0E11) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <32d54002-dd14-4e3e-8838-4097a6f9cb03@kaod.org>
Date: Fri, 16 Oct 2026 08:38:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/8] hw/usb: Add a usbredir server transport
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20261015093417.573063-1-jamin_lin@aspeedtech.com>
 <SEZPR06MB736219AC450D3B79101424E7FC9B2@SEZPR06MB7362.apcprd06.prod.outlook.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <SEZPR06MB736219AC450D3B79101424E7FC9B2@SEZPR06MB7362.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 14290203095211944987
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEEM965OfELArTrNFY2cQZvN34fUFOPOUsUJSZr7HVJnD1G1YkbOrh1h+vbTPDB5NEt4nqrPAPBtu8XkvCMm1aXCG4Q66/2izgAQZmSTwdATEl4evScjK8z43YWj6jVZqzBWkFpbAJYOKnhHbQo1rHWmE/Rhq/p51411N2m2exFMmevInKOwKnMDfojMhltrn+6GjWElbBfrotlYdtC+6Ov9nwQWmmpGyy4BzjGDKDDP44ng5z9HMsQBR9NRkge9H2QAUz4FWdYvEoLUecGjioUfv5W9mcnLJJ83Y3IfgUrKFMDNgV6siiH6/j/M6yYJPU3FhOu0qKzxAb6sCVz8QWMgie/J0FEMAN96bAfL637fA6XEipEvJwp8JgudzKe2KLDGnFoP6zij0W+umJfZ+cX+RVESAs0+8vfwEu7+DAodBk6zvw4S+aYajIddFTbIydOUlf5bWEi34X2lSUnqNV5qs8e/q7cgY0Zd5EckP3rkXpmmpbeVV6x0APTRUnHyAw6kqfBQIVxhNHfL+EqM9pQxjxrrMGD639BhGNQEHNYn/ybhqIt3w0AuoWdmXS122Cr5CoICp1m9UT8RGrGNyFs1Ha8TbLW4OxGQwNcjmHPTk6qKuOY/1HJKQQJd932unu8hhUCNyvEKC2vJ4ZwKkh6PGup2op09CSHkdUWiEH0wA
DKIM-Signature: a=rsa-sha256; bh=0siq1Js3wdnLQgDXqGB9IaGfBnOYPkQ/rCk4d0daUos=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1792132691; v=1;
 b=fLtOBUmzYQirkV8jYJiHRyC9/WSN9faDzLhDqEjjXumztxDPguRXah6WFd+ol/3dpRI0a3yI
 +nv152SMVaSu6/cOm55f0Rxzgmxyk1vsHjm6VrGUnn4exeSV+t7sPqvGbkAJ6GOj8pNZjO0ZoHJ
 gd5Sv6wVjdgDbzuoJP4aMRgRA3TqK5kuXUhIw0LN0waU6msJCudn/emgnMiqa5WJpVzP1y9g3Uw
 kcmN+c5fo+1vmttvmK23cnkx2vvOCe9ZsvNQfuJH8UphFu8lxdcsw3JA99uMdvqh77pNwtK0X6R
 qs+hFBZgAEY3Kp4hPGlNpu5sOCW0c+xBt7beChU7q99Pw==
Received-SPF: pass client-ip=51.210.91.43; envelope-from=clg@kaod.org;
 helo=smtpout4.mo539.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 10/16/26 08:31, Jamin Lin wrote:
> 
> 
>> Subject: [PATCH v5 0/8] hw/usb: Add a usbredir server transport
>>
>> This series adds a usbredir server transport to redirect a USB device emulated
>> in one QEMU instance to a USB host controller emulated in another one over
>> the usbredir protocol.
>>
>> The v1 series included both the usbredir server transport and the ASPEED
>> AST1030 USB Device Controller (UDC) support. Following review feedback, this
>> series contains only the usbredir server transport. The ASPEED
>> AST1030 UDC support will be sent separately.
>>
>> This work is part of a larger plan to model USB device-side support on ASPEED
>> BMC/BIC SoCs, which has three goals:
>>
>> 1. Model the ASPEED UDC (AST2600 / AST1030). The AST2600 also has USB
>> host
>>     (EHCI) controllers, so that work targets the AST2600 UDC: its gadget can
>>     be attached to the SoC's own EHCI bus, letting the guest enumerate its
>>     own gadget and exercise the UDC end-to-end.  [Done]
>>
>> https://lore.kernel.org/qemu-devel/20260902021542.3194812-1-jamin_lin@as
>> peedtech.com/
>>
>> 2. AST1030 UDC. The AST1030 has no USB host controller, so testing its UDC
>>     needs a second QEMU instance. The UDC gadget is redirected out of the
>>     guest with libusbredir and attached to another QEMU that runs a USB host
>>     (a VMM, or an AST2600 / AST2700 guest).  [this series]
>>
>> 3. ASPEED vHub, as a longer-term goal towards BMC KVM / Virtual Media
>>     support in QEMU.  [future]
>>
>> This series implements goal 2.
>>
>> The transport
>> =============
>>
>> x-usb-redir-server exports a locally emulated USB device to a remote USB host
>> over the usbredir protocol, so a device emulated in one QEMU instance can be
>> enumerated by a host controller emulated in another one.
>>
>> The left column is a request going to the device. The right column is the
>> answer coming back. The middle hop carries usbredir messages over a socket.
>> The top and bottom hops carry USBPackets inside QEMU.
>>
>>      remote QEMU: guest driver -> EHCI/XHCI
>>               |                     ^
>>     USBPacket |                     | USBPacket
>>               v                     |
>>      "usb-redir" (the client)
>>               |                     ^
>>      usbredir |   chardev socket    | usbredir
>>               v                     |
>>      x-usb-redir-server (the server, this series)
>>               |                     ^
>>     USBPacket |                     | USBPacket
>>               v                     |
>>      any USBDevice, "-device <dev>,bus=<id>.0"
>>
>> "usb-redir" (hw/usb/redirect.c) is the client:
>>    - it takes a USBPacket from the remote guest and writes it to the socket
>>      as a usbredir message
>>    - it reads the answer from the socket and completes the USBPacket
>>
>> x-usb-redir-server is the server. It does the same thing, but backwards:
>>    - it reads a usbredir message from the socket and runs it as a USBPacket
>>      on the bus below
>>    - it takes the result of that USBPacket and writes it back to the same
>>      socket as a usbredir message, for the client to read
>>
>> A USB device has to sit on a USB bus, and in QEMU a USB bus is always made
>> by a host controller. So x-usb-redir-server makes one and acts as the host
>> controller on this side. It models no real chip: its cable is the chardev socket.
>> The real host is in the other QEMU.
>>
>> The type name has an "x-" prefix because the device is experimental. It has to
>> sit on the sysbus so that "-device <dev>,bus=<id>.0" can find the USB bus it
>> provides, and that may change later.
>>
>> usbredir carries one device, not a bus. A hub cannot be exported: the protocol
>> has no device address field. To export several devices, run one
>> x-usb-redir-server per device, each with its own chardev.
>>
>> Testing
>> =======
>>
>> A plain usb-storage device was used to test the transport. The storage device is
>> attached to x-usb-redir-server and exported over a Unix socket:
>>
>> $ qemu-system-aarch64 ...
>> -chardev socket,id=usbredir0,path=/tmp/usbredir0.sock,server=on,wait=off
>> -device x-usb-redir-server,id=usbredir0,chardev=usbredir0
>> -drive id=usbdisk,if=none,file=image0.ext4,format=raw
>> -device usb-storage,bus=usbredir0.0,id=mystorage,drive=usbdisk
>>
>> The exported device can then be attached to EHCI bus 3 of an AST2700 guest
>> using the existing usb-redir client:
>>
>>      -chardev socket,id=storage,path=/tmp/usbredir0.sock,reconnect-ms=1000
>> \
>>      -device usb-redir,chardev=storage,bus=usb-bus.3
>>
>> The AST2700 Linux guest enumerates the redirected USB storage device:
>>
>> root@ast2700-default:~# lsusb
>> unable to initialize usb spec
>> Bus 001 Device 001: ID 1d6b:0001 Linux 6.18.36-v00.08.03-gaf2f426c5786
>> uhci_hcd Generic UHCI Host Controller Bus 002 Device 001: ID 1d6b:0002
>> Linux 6.18.36-v00.08.03-gaf2f426c5786 ehci_hcd EHCI Host Controller Bus 002
>> Device 002: ID 46f4:0001 QEMU QEMU USB HARDDRIVE
>>
>> This also demonstrates that x-usb-redir-server is not specific to the ASPEED
>> UDC. Any USBDevice can be attached to its USB bus and exported to a host
>> controller in another QEMU instance.
>>
>> v1:
>>    1. Add a usbredir server device
>>    2. Announce the exported device
>>    3. Implement control transfers
>>    4. Implement bulk and interrupt transfers
>>    5. Stream interrupt IN endpoints
>>
>> v2:
>>    1. Split the original series into USB and ASPEED parts as suggested
>>       during review.
>>    2. Keep this series focused on the usbredir server transport.
>>    3. Move the ASPEED UDC changes, AST1030 UDC support and its functional
>>       test to a separate series.
>>
>> v3:
>>     1. Move include/hw/usb/redirect-server.h into redirect-server.c.
>>     2. Drop the announce timer. The firmware does not toggle the pull-up,
>>        and the delay would be machine specific anyway.
>>     3. Rename the type to "x-usb-redir-server" to mark it experimental.
>>
>> v4:
>>    1. ep_info now says what the host chose, both the configuration and the
>>       alternate setting. Keep every configuration descriptor, not just the last
>> one.
>>    2. look at the request type too, not only the number
>>    3. wait for the endpoint's bInterval before asking the device
>>       again.
>>
>> Patch 7 lost its Reviewed-by because it changed. It used to ask the device again
>> from a bottom half, which runs as soon as the main loop comes back. So there
>> was no wait at all.
>>
>> A keyboard answers NAK while no key is down, and the retry timer paces that,
>> so it looked fine. usb-net's status endpoint answers every time.
>> The loop never stopped: ask, answer, ask again, about 17000 times a second.
>> The same main loop runs the guest's timers, and it had no room left. The guest
>> stopped feeding its watchdog, and the watchdog reset the machine.
>>
>> bInterval is the rate the endpoint asks to be polled at, and the rate a real host
>> controller uses. The stream now waits for it.
>>
>> v5:
>>    1. Use a separate timer and bottom half for each endpoint.
>>
>> Jamin Lin (8):
>>    hw/usb/bus: Let a bus opt out of automatic hub insertion
>>    hw/usb/redirect-server: Add a usbredir server device
>>    hw/usb/redirect-server: Connect usbredirparser to a chardev
>>    hw/usb/redirect-server: Announce the exported device
>>    hw/usb/redirect-server: Implement control transfers
>>    hw/usb/redirect-server: Implement bulk and interrupt transfers
>>    hw/usb/redirect-server: Stream interrupt IN endpoints
>>    hw/arm/aspeed: Enable the usbredir server transport
>>
>>   include/hw/usb/usb.h     |    1 +
>>   hw/arm/aspeed.c          |    7 +
>>   hw/usb/bus.c             |    3 +-
>>   hw/usb/redirect-server.c | 1812
>> ++++++++++++++++++++++++++++++++++++++
>>   hw/usb/meson.build       |    3 +-
>>   hw/usb/trace-events      |   31 +
>>   6 files changed, 1855 insertions(+), 2 deletions(-)  create mode 100644
>> hw/usb/redirect-server.c
>>
>> --
>> 2.43.0
> 
> 
> Patch 3 does not build on current master since
> 
>    13d2f5e4b0 ("chardev: add CHR_EVENT_RESIZE")
> 
> QEMUChrEvent gained a value and the switch does not handle it. I will
> fix it and send v5.

yes. That's an easy fix. Please let people take a look first before
sending a v6.

C.


