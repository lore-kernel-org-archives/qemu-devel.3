Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C82C9C44501
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 16:03:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whrDV-0006cO-K3; Thu, 09 Jul 2026 12:03:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1whrDP-0006Yc-GY; Thu, 09 Jul 2026 12:03:08 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1whrDN-0004TS-6N; Thu, 09 Jul 2026 12:03:07 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7AB6B59673B;
 Thu, 09 Jul 2026 18:03:00 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id YM5uTRnouatE; Thu,  9 Jul 2026 18:02:58 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 0ED50596742; Thu, 09 Jul 2026 18:02:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 0B492596741;
 Thu, 09 Jul 2026 18:02:58 +0200 (CEST)
Date: Thu, 9 Jul 2026 18:02:58 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Markus Armbruster <armbru@redhat.com>
cc: qemu-devel@nongnu.org, Aditya Gupta <adityag@linux.ibm.com>, 
 Alexander Graf <graf@amazon.com>, Alexandre Iooss <erdnaxe@crans.org>, 
 Alexey Kardashevskiy <aik@ozlabs.ru>, 
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Alistair Francis <alistair@alistair23.me>, 
 Antony Pavlov <antonynpavlov@gmail.com>, 
 Artyom Tarasenko <atar4qemu@gmail.com>, 
 Bernhard Beschow <shentey@gmail.com>, Bibo Mao <maobibo@loongson.cn>, 
 Brian Cain <brian.cain@oss.qualcomm.com>, 
 Chao Liu <chao.liu@processmission.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 =?ISO-8859-15?Q?Cl=E9ment_Chigot?= <chigot@adacore.com>, 
 =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, 
 Dorjoy Chowdhury <dorjoychy111@gmail.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Eric Farman <farman@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, 
 Felipe Balbi <balbi@kernel.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, 
 Frederic Konrad <konrad.frederic@yahoo.fr>, 
 Gaurav Sharma <gaurav.sharma_7@nxp.com>, Gautam Gala <ggala@linux.ibm.com>, 
 Glenn Miles <milesg@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Hao Wu <wuhaotsh@google.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Helge Deller <deller@gmx.de>, Hendrik Brueckner <brueckner@linux.ibm.com>, 
 =?ISO-8859-15?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>, 
 Huacai Chen <chenhuacai@kernel.org>, Jan Kiszka <jan.kiszka@web.de>, 
 Jared Rossi <jrossi@linux.ibm.com>, Joel Stanley <joel@jms.id.au>, 
 Laurent Vivier <laurent@vivier.eu>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Max Filippov <jcmvbkbc@gmail.com>, 
 Michael Rolnik <mrolnik@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Niek Linnenbank <nieklinnenbank@gmail.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@mailo.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Ran Wang <wangran@bosc.ac.cn>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, 
 Samuel Tardieu <sam@rfc1149.net>, Sergio Lopez <slp@redhat.com>, 
 Song Gao <17746591750@163.com>, Stafford Horne <shorne@gmail.com>, 
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, 
 Thomas Huth <th.huth+qemu@posteo.eu>, Tyrone Ting <kfting@nuvoton.com>, 
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, 
 qemu-s390x@nongnu.org
Subject: Re: Call to clean up QOM onboard devices lacking a parent
In-Reply-To: <87se5scipx.fsf@pond.sub.org>
Message-ID: <17c7f91b-8935-8ebf-a982-f91df755af81@eik.bme.hu>
References: <87se5scipx.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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



On Thu, 9 Jul 2026, Markus Armbruster wrote:
> A QOM object must be the child of exactly one parent.  This defines the
> QOM composition tree.  The link from parent to child is a property of
> the parent, and therefore has a name that is unique within its parent.
> An object's canonical QOM path is these names on the path from root to
> object in the QOM composition tree separated by '/'.
>
> For devices:
>
> * If a device is plugged in with -device / device_add, and it has an ID,
>  we make it a child of /machine/peripheral/ with name ID.  If it
>  doesn't have an ID, we make it a child of /machine/peripheral-anon/
>  with name device[N], where N counts up from zero.  The canonical QOM
>  path /machine/peripheral/ID is stable.  The canonical QOM path
>  /machine/peripheral-anon/device[N] isn't: it depends on the number of
>  devices already there.
>
> * If a device is part of another device, it should be its child.  The
>  child's canonical QOM path is the parent's plus '/CHILD-NAME'.  Stable
>  as long as the parent's path and the child name are.
>
> * "Should" because we have a lot of code that fails to pick the parent.
>  When such a device gets realized, we make it a child of
>  /machine/unattached/ orphanage with name device[N], where N counts up
>  from zero.  The canonical QOM path /machine/unattached/device[N]
>  depends on the number of children already in the orphanage, which
>  makes it unstable.
>
>  Letting code get away with not picking a parent was a mistake.  I
>  guess it "saved" us some thinking about what's part of what when
>  converting existing devices to QOM.  In other words, it enabled sloppy
>  hardware modeling.  We've been "saving" thinking ever since.
>
>  I want /machine/unattached/ to be empty.  If an onboard device isn't
>  part of another device, put it into /machine/ with a sensible name.

The last time this came up I've asked a few questions but did not get an 
answer:

1. What's the use of the QOM composition tree? I never needed it and apart 
from being able to admire it in info qom-tree I don't know if it's used 
for anything. For a long time I did not even know about info qom-tree 
because I only needed info qtree and info mtree and rarely if ever need to 
look at the qom-tree. If it has no real use I'm happy to not think about 
it.

2. What is a QOM parent? There were proposals to parent devices to their 
bus if they have any, that's what qtree shows anyway. If it's something 
else it should be better defined somewhere.

Without getting answers for these questions I don't think I'm able to fix 
the machines I maintain.

Regards,
BALATON Zoltan

