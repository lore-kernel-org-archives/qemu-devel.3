Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3AF2C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 14:32:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiCGk-00069A-I8; Fri, 10 Jul 2026 10:31:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1wiCGj-000690-OA
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 10:31:57 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1wiCGi-0002bC-2n
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 10:31:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=pfbfQUIC7badV5OtiBVKNQ0Hbmyf6nV2Q5VDHLkrAjQ=; b=YcM6A0qpJbiLndBXu+aAPYp6ov
 UxqxVtiYRZQEzDuRibYJEQIaivPlIDvrXaBLzaih3cma2AyC3K//gR0IXSOjufkzehxoKrl9IsWLA
 5WN3Yj8mAmZRbEKAccmAxtImdYs7t1Gc9oEfCcbXRow57RSEqU60FO4vB6KQgDD89aT3z/k/n2fuj
 zAK2hYIQ8ki1lJfkvF6XegD4TUjFy3TAv7d9u3auskEPcj3lJxerO6y0LgPFIkC8jJYav/jlD/aPQ
 abvoGnSgp+CSswoAZNoMpFUg3Rpb8VdopmnYrmBuZ910Og7z3OJ26UK0SGCR21tp8rEjZngQtrYxS
 ScnPDZ3XUgxvonBm3z8S71zW0+Tt/xyQGSLTJrRZJMCw1zOkkr1Z6R2WZFLcZUZcUAtUZDSW2AoHx
 MMCrbNVBAME+6dQctKKWqOKnBH4A5o8gejy+QfpFpqdDpuUt1kqBrcvtGLdBic1dR/wuHiRvfAk1/
 GNLIrGRQcxmgimyq4DaLiW7u8SdWAkxXm7H8P1OJJvn1iTEUsiqu11GOhN6XG6UbxqD6TfnmBf82p
 m9l8ukxIlOy/pcQmj7j5Zm1+QPzDLSxPVfmFJsr+qkSwsYVvFWKGaNCzWUDTAK0u5pJiErtf1iD5O
 PMeoSRtn3TpKzagG8BU4U/CI3SFXz6MxcluT+HoLg=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>,
 Jia Jia <physicalmtea@gmail.com>
Subject: Re: [PATCH 2/3] hw/9pfs/virtio: disable hotpluggable property of
 virtio-9p device
Date: Fri, 10 Jul 2026 16:31:51 +0200
Message-ID: <2055091.yKVeVyVuyW@weasel>
In-Reply-To: <20260710145149.6e077fdd@imammedo>
References: <cover.1783604079.git.qemu_oss@crudebyte.com>
 <2355649.iZASKD2KPV@weasel> <20260710145149.6e077fdd@imammedo>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

On Friday, 10 July 2026 14:51:49 CEST Igor Mammedov wrote:
> On Fri, 10 Jul 2026 12:49:06 +0200
> 
> Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:
> > On Friday, 10 July 2026 12:23:45 CEST Igor Mammedov wrote:
[...]
> note: I'm looking from pov of hotpluggable PCI device and generic hotplug
> infra, only.

That's okay, but so far I don't see the relevance for this particular 9p 
device.
 
> it's not guest users directly, it's how hotplug flow works for various guest
> OSes:
> 
> 1. host plugs device in (-device or device_add)
> 2. guest OS get's notified one way or another and does what ever guest side
>    init needed (incl. mounting share in 9pfs case)

That's not affected by this patch, right?

> opposite flow:
> 1. host does device_del (basically notify guest to remove device)
> 2. guest OS frees resources and tells qemu to delete device
> 3. qemu process remove event (which incl. unrealize as part of destroying
> device)

And that's not affected by this patch either, right?

> Of cause guest if free to eject device without signal from host,

OK, here is the point where we deviate: you are apparently seeing this from a 
purely theoretical PoV.

I am facing reality: for several years I'm the only person taking care about 
this piece of code at all (on a side channel, for free, next to my actual 
work). And for several months I get AI generated security reports thrown at 
me, where I have to a) filter legit ones, and b) fix those legit security 
issues.

For that reason, I am tightening security wherever I can, to prevent further 
flood.

So the question here is: are you concerned about a real-life issue being 
introduced by disabling hotplugging for 9pfs specifically?

> (I could imagine: get some file from share once and then guest releases
> no longer need resource).

It's a pass-through file system. Ejecting the device does not really free a 
noteworthy amount of resources.

> > Looking at the fixed issue (patch 1), my impression was that original 9p
> > server developers were unaware that guest can actually trigger a device
> > unrealize via ACPI eject.
> 
> I'd say it's a bug, and you are trying to fix it in patch #1
> 
> > Most probably because hotplugging is enabled by
> > default for all devices in QEMU
> 
> it is on by default for PCI devices but also heavily depends on used
> configuration (where/what is plugged).

Exactly! And I was trying to explain, that for this particular use case 
(9pfs), I don't see any real-live use-case for allowing a guest to eject the 
9p device at runtime.

So why allowing it? Just for fun?

> > Independent of this patch here, I'm therefore currently investigating
> > whether enabling hotplugging by default in QEMU actually make sense. To
> > me, this should be an opt-in, not the other way around. Because device
> > developers should make sure that ejecting a device a) makes sense for the
> > device type in the first place and most importantly b) that ejecting the
> > device works (without data loss and without negative security impact, as
> > it was the case here).
> 
> well, hotplug is on by default for PCI devices. It is unlikely we would
> flip default now.

I am investigating to flip the default value for good reasons: I made a quick 
scan on the huge list of devices in QEMU and found quite a number that are 
affected by a similar UAF issue on guest ACPI eject. What do those devices 
have in common? Hotplug is enabled by default, not explicitly by the 
respective device.

> that said, if 9pfs maintainer deem that it shouldn't be hotpluggable and 
> it's safe to remove capability,

That's me, unfortunately. Singular.

> I'm fine with that too, just fix commit message
> section wrt QMP removal and perhaps move the flag into front-end impl of
> the device.

Yeah, I just noticed that as well, that this should rather go to the PCI 
bridge device. This patch applied it to the inner device, which is wrong.

> BTW: always describe a way to reproduce problem (cover letter and/or patch)
> so that reviewer could see whole flow. Otherwise one has to guess what/how
> it gets broken based on context.

The original report (private) is linked by patch 1:
https://gitlab.com/qemu-project/qemu/-/work_items/3937

Anyway, I'll think some more days about this, whether I should fix or drop the 
patch.

If you have more feedback, always appreciated of course.

Thanks!

/Christian




