Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 044E0E77188
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 02:06:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVhvc-0007y8-9g; Wed, 08 Jan 2025 21:05:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tVhva-0007xy-4Q
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 21:05:42 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tVhvU-0001xh-9P
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 21:05:40 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id DE2A14E6004;
 Thu, 09 Jan 2025 03:05:32 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id VyD1wgEJoTw6; Thu,  9 Jan 2025 03:05:30 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 9F0584E601D; Thu, 09 Jan 2025 03:05:30 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 9C6AC757B27;
 Thu, 09 Jan 2025 03:05:30 +0100 (CET)
Date: Thu, 9 Jan 2025 03:05:30 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Rob Landley <rob@landley.net>
cc: =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, 
 Stafford Horne <shorne@gmail.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 "Jason A. Donenfeld" <Jason@zx2c4.com>, 
 QEMU Developers <qemu-devel@nongnu.org>, 
 Linux OpenRISC <linux-openrisc@vger.kernel.org>
Subject: Re: or1k -M virt -hda and net.
In-Reply-To: <c5efb6af-5fef-4938-aac9-c9c8b75a9a69@landley.net>
Message-ID: <ef302909-d94d-4bec-2a2d-3c26898c089b@eik.bme.hu>
References: <9b2761aa-8ee0-4399-b237-31e70e3ed165@landley.net>
 <Z0Cyx3i3z7Zl7XPm@antec> <31fa6255-8e0c-4d05-bad9-dd843c676244@landley.net>
 <Z0GSETLeT5w8B2DX@antec> <87a6b910-5af6-47ad-ad8d-b79f11a7cbf2@landley.net>
 <Z0LMqEqcdjkAxnN-@antec>
 <57c5207c-3aca-47cd-bfd3-3d7eb7be3c0f@landley.net> <Z2lgL31ZeSkO59MZ@antec>
 <8807078a-0673-4b27-8d58-4a2a3ce4987d@landley.net>
 <39511711-b86a-4ac6-8bd6-8dab824b693e@landley.net> <Z31k3zNN3pOdGWWK@antec>
 <87y0zmbita.fsf@draig.linaro.org>
 <e2f1c14c-f5d2-48f3-bb6e-d1db0ce6d1fa@landley.net>
 <6e5f24cf-02bf-1cf0-2d0d-e683866cc3d3@eik.bme.hu>
 <c5efb6af-5fef-4938-aac9-c9c8b75a9a69@landley.net>
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

On Wed, 8 Jan 2025, Rob Landley wrote:
> On 1/8/25 07:01, BALATON Zoltan wrote:
>> On Tue, 7 Jan 2025, Rob Landley wrote:
>>> What's the alternative to -hda you suggest for that?
>>> 
>>> Can I do "./run-qemu.sh -drive file=blah.img" without the rest? Perhaps 
>>> specify all the details in the script and then optionally add an extra 
>>> argument at the end? I couldn't get that to work:
>>> 
>>> $ root/or1k/run-qemu.sh -netdev user,id=net0 -device virtio-net- 
>>> device,netdev=net0 -drive format=raw,id=hd0 -device virtio-blk- 
>>> device,drive=hd0 -drive file=README
>> 
>> You need '-drive if=none,id=hd0,format=raw,file=README' as a single option 
>> not split into two.
>
> I'm not always specifying an -hda. Sometimes it does, and sometimes it runs 
> without it. I would like to have everything EXCEPT the media specified, so it 
> can be inserted into a ready drive or run without it.
>
> That's what -hda traditionally does.

I think you can't do that with -drive. You either do

-drive if=none,id=d,format=raw,file=raw.img -device whatever,drive=d

or try to have -drive create the device by specifying the type in if 
and hope it works such as

-drive if=virtio,format=raw,file=raw.img

and then you don't need corresponding device but this may not work for 
every machine. The -hda option should expand to such -drive option but it 
cannot if the machine does not define a default interface for block 
devices. So maybe just setting block_default_type in the MachineClass to 
IF_VIRTIO might be enough, otherwise you may need to implement handling 
for it in the machine. In the sam460ex I had to implement it because it 
uses SATA with only two ports which only takes one device per IDE bus 
while the default in QEMU expects PATA IDE that can have two devices per 
bus and two buses but for virtio maybe it works without additional 
handling of drives and only the default is missing which -hda would use.

>> With if=none -drive won't auto-create a  device
>
> $ root/or1k/run-qemu.sh -netdev user,id=net0 -device 
> virtio-net-device,netdev=net0 -drive if=none,id=hd0,format=raw
> qemu-system-or1k: -drive if=none,id=hd0,format=raw: A block device must be 
> specified for "file"
>
>> so you then also need a corresponding -device option for the drive that you 
>> seem to have already above.
>
> $ root/or1k/run-qemu.sh -netdev user,id=net0 -device 
> virtio-net-device,netdev=net0 -device virtio-blk-device
> qemu-system-or1k: -device virtio-blk-device: drive property not set
> $ root/or1k/run-qemu.sh -netdev user,id=net0 -device 
> virtio-net-device,netdev=net0 -device virtio-blk-device,drive=hd0
> qemu-system-or1k: -device virtio-blk-device,drive=hd0: Property 
> 'virtio-blk-device.drive' can't find value 'hd0'
> $ root/or1k/run-qemu.sh -netdev user,id=net0 -device 
> virtio-net-device,netdev=net0 -device virtio-blk-device,drive=hd0 -drive 
> id=hd0,if=none
> qemu-system-or1k: -device virtio-blk-device,drive=hd0: Device needs media, 
> but drive is empty
>
> That's as close as I can get. As far as I can tell, it's complaining that I 
> got it into the state I wanted, and it doesn't want to be in that state. The 
> "if=none" does not appear to help.

I think you can only have empty cdrom devices which can be created without 
a drive option but not devices that don't have removable media. You also 
can't define a drive without a file or some other backing store.

> I also don't know what drive=/id= pair "-hda" would be trying to populate, so 
> dunno what name to use there.

Maybe you can try 'info block' in QEMU monitor to see what drives are 
defined and 'info qtree' to see what devices are attached to them. But if 
-hda option does not work this won't help, you can only check on other 
machines what -hda defines.

Regards,
BALATON Zoltan

> Also, it requires -drive and its argument to be seperate:
>
>  qemu-system-or1k: -device=virtio-blk-device,drive=hda: invalid option
>
> Refusing to let them to be glued together with = (like most --longopt parsers 
> do, including the https://github.com/landley/toybox/blob/master/lib/args.c I 
> wrote) means I can't use bash's brace expansion to set up multiple at once 
> (to preload support for -hda, -hdb, -hdc, and -hdd), ala:
>
>  -drive=id=hd{0,1,2,3},if=none
>
> Not that the current script has a bash dependency... :P
>
>> If you want -hda to work you may need something like commit d36b2f4e78 
>> (hw/ppc/sam460ex: Support short options for adding drives) for the machine 
>> you use. In particular the MachineClass block_default_type field says 
>> what's the default interface that -drive and other short options should use 
>> (at least I think so, I'm no expert on this either but searching for it 
>> should at least point to where it's handled).
>
> Thanks for the pointer, I'll take a look.
>
> Rob
>
>

