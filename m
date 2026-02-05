Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9063EA7960
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 03:50:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnqMu-0007IP-E1; Wed, 04 Feb 2026 22:49:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>) id 1vnqMr-0007Hx-Nn
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 22:49:22 -0500
Received: from fhigh-b4-smtp.messagingengine.com ([202.12.124.155])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>) id 1vnqMg-0006ZL-LG
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 22:49:13 -0500
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 2B42F7A011F;
 Wed,  4 Feb 2026 22:49:09 -0500 (EST)
Received: from phl-imap-18 ([10.202.2.89])
 by phl-compute-02.internal (MEProxy); Wed, 04 Feb 2026 22:49:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1770263348;
 x=1770349748; bh=E5t3hV4qKnQhJNKykfQdk3Rnf+ulr6vW5yWgrGJKtL8=; b=
 VFfeBR0+J8if1BLg6Ex4hJnuILOXBJ4847umNsqf2PbTOyK2wIh9h7ut/yGvDmx/
 k9zlg3sT28Ca5PtR1oL0rOodr17lvsF7h5aCvgl6gvypVhFT79T14qy/AjgIpJ96
 P8wTpLo25fzqri4AcW5wibco7/7cGPAhvmStx5iTwSHu2g0GiO5oW4gSo2LSF/3L
 pw4UTvPlxyWbF7i6wKjeBLtbsF8p/1pm9KWqsK/OIak5JeHpNPWuqoO4DSvACREz
 3UQ11iViSQoEzMub9dOmGcCRnP81q5h7QP9xvz0dRouBUrj6CAhJzyY1b9Q4xPdi
 fQWqGuOuGOnqjcaPUcO/2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770263348; x=
 1770349748; bh=E5t3hV4qKnQhJNKykfQdk3Rnf+ulr6vW5yWgrGJKtL8=; b=I
 Z40CJwBqtHo5LA/6AGeu8WwZC9r/zG6jp6zJG5yrO6h0L7lx5aUZ0SRcMZk7DUXW
 T4JfkMiBrNDZZ+3AibMU5AP81n0Dx54LbEYVuNHwI+YUhS760ffiMJ/FcZtxCEiE
 iCAFy3UPUES9oz3UxYoI1f8wTJK3amJMr9fhuFvjSwzbqyp81IAYYGtX5tI+0cYH
 Z8wYWXfGczDVnc+jGLa3cXn4/DCDVh0sDGwUwdYGwQsTykzCh2/6Hd5sV99bkowP
 YZRqhZCjOh6IBvSsmdwuhI/8cS4Op8XLFCWGPzRJOJ+netqyZpcwTBetXCpGgUJO
 lO8tWY0wnpYggD3D1FqnA==
X-ME-Sender: <xms:NBOEaYxMIatNEhoeOQFT65VzlpFoTkjiRQ6xQ0_x_Y-WsZ-2PhVrbQ>
 <xme:NBOEaXEzkpw4cA2XyNFen1cw9hVS5QlWtm8wPMosnk8opnr3yUic1d4B_quwYoPhc
 -MogChjJJ6vPFCJ44_mycLATBgzJv0USPeQFC4lb_wTr1NXxAHDRA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeegvdekucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedftehlvgig
 ucghihhllhhirghmshhonhdfuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtf
 frrghtthgvrhhnpeeugfdtfeehieehtefhgefghfetudeihfffhfeileejieejgeeiffel
 veejieeugfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpegrlhgvgiesshhhrgiisghothdrohhrghdpnhgspghrtghpthhtohephedpmhhouggv
 pehsmhhtphhouhhtpdhrtghpthhtohepuggvjhgrnhdrrghnughjvghlkhhovhhitgesrg
 hmugdrtghomhdprhgtphhtthhopehmrghnohhjlhhordhpvghkohhvihgtsegrmhgurdgt
 ohhmpdhrtghpthhtohepnhhikhholhgrrdhprhhitggrsegrmhgurdgtohhmpdhrtghpth
 htohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopegtlhhg
 sehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:NBOEaSedpiq2julwIdGITHzfO3xfwF3YQ7IoZrK6QMibH-61fjRUPw>
 <xmx:NBOEaTHaQqfs1eWADNQdJpp8XVNbv9uTNgSczbkaAfr9gZS05fepxw>
 <xmx:NBOEab1_vY3vMS-Zf3VgF3TbQHq4i1_bkgIyh9BWjeNWXLgHNgUL7Q>
 <xmx:NBOEablbUMjZuwc29xYeha6Hg5X7MarK9c6Lj0dHldQ2LwR4_0XlvA>
 <xmx:NBOEaWfknCHMt92WHbCzrfpeEfHU5kKvMHGL8u-2-6nlXC-RPUYPAjvs>
Feedback-ID: i03f14258:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 855D115C008C; Wed,  4 Feb 2026 22:49:08 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: A_quthzHMDYc
Date: Wed, 04 Feb 2026 20:48:48 -0700
From: "Alex Williamson" <alex@shazbot.org>
To: "Pekovic, Manojlo" <Manojlo.Pekovic@amd.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 "Prica, Nikola" <Nikola.Prica@amd.com>,
 "Andjelkovic, Dejan" <Dejan.Andjelkovic@amd.com>
Message-Id: <8b3e30e6-3c3e-49ab-b9db-8296aaf819d1@app.fastmail.com>
In-Reply-To: <CH0PR12MB52833619AF8D222A463E9209FA98A@CH0PR12MB5283.namprd12.prod.outlook.com>
References: <20260203154112.1668-1-manojlo.pekovic@amd.com>
 <20260203154112.1668-3-manojlo.pekovic@amd.com>
 <20260203212330.56e07330@shazbot.org>
 <CH0PR12MB52833619AF8D222A463E9209FA98A@CH0PR12MB5283.namprd12.prod.outlook.com>
Subject: Re: [PATCH 2/2] vfio/pci: Support multifunction atomic ops capability
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=202.12.124.155; envelope-from=alex@shazbot.org;
 helo=fhigh-b4-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

On Wed, Feb 4, 2026, at 11:18 AM, Pekovic, Manojlo wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Hi Alex,
> before I submit a new patch according to Cedric's email, I want to mak=
e=20
> some clarifications
>
> On Tue, 3 Feb 2026 16:41:12 +0100
> Manojlo Pekovic <manojlo.pekovic@amd.com> wrote:
>
>> From: Manojlo Pekovic <mpekovic@amd.com>
>>
>> Extend PCIe Atomic Ops completer support to multifunction vfio-pci
>> devices by calculating the common subset of atomic capabilities across
>> all functions.
>>
>> For multifunction devices, we now:
>> 1. Calculate the intersection of atomic capabilities across all
>> functions 2. Only enable capabilities that ALL functions with atomic
>> support share 3. Functions without atomic support are skipped (not
>> penalized)
>>
>> During vfio_realize(), other functions in a multifunction device may
>> not be realized yet, making it impossible to enumerate all functions.
>> We defer atomic ops configuration to machine_done time for
>> multifunction devices, ensuring all functions are realized before
>> calculating common capabilities.
>
> Exactly what are we trying to enable with this support?  Why do we nee=
d=20
> multifunction AtomicOps support versus multiple single function=20
> assignments under separate root ports?
>
> ++ While systems do allow separate assignments, we have come up on mor=
e=20
> than one occasion where the topology of the bare metal was mimicked by=20
> VM's configuration.
> ++ Current solutions were hacking and forcing atomics ops on the root=20
> port, or changing the topology of the VM (which no longer represents=20
> the same as bare metal)
> ++ Right now, I cannot confirm that doing either has created any=20
> faults, however, from UX standpoint, the correct way is that user=20
> shouldn't think about it
> ++ I understand your concerns, and I can either
> ++ - Defer this patch and investigate further
> ++ - Proceed with it for completeness, given its low risk
> ++ What's your preference?

Atomic ops routing is complicated though.  The current automatic setup f=
ocuses on a specific use case.  The vfio interface *only* report atomic =
ops support relative to the root bus, therefore we can effectively only =
enable host->device or device->host atomic ops, thus automatic configura=
tion is limited to the single function downstream of a root port, withou=
t atomic ops routing enabled.

It's been a while since I implemented this and I should have left better=
 breadcrumbs as to the single function restriction, but I think it was n=
ot simply determining the common set of capabilities between the devices=
, but actually the implications relative to device->device atomic ops.

For example, imagine that we want to create a virtual topology that enab=
les atomic ops between two single function devices, each downstream of a=
 separate root port.  Before we can set the atomic ops routing flag on t=
he root ports we need to evaluate whether the host system has atomic ops=
 routing on every physical interconnect between the devices.  The curren=
t vfio interface doesn't tell us this.

Now, instead of a virtual topology placing those devices under separate =
root ports with explicit routing flags, what if we lump them together in=
to a multifunction device.  Do these functions implicitly support device=
->device atomic ops?  Such paths are typically implementation details be=
yond the scope of the spec.

Therefore, it's not really clear what gremlins we're unleashing in this =
"low risk" extension.

Back to the point, atomic ops routing is complicated, QEMU currently kic=
ks anything beyond the trivial case back to the VM administrator.  If th=
e VM administrator doesn't want to think about it, analyze the host topo=
logy, create a compatible VM topology, and manually set appropriate atom=
ic ops bits, then the burden probably needs to go in the direction of VM=
 builders and management tools rather than pushed down into QEMU.  QEMU =
doesn't have the visibility to determine host routing and is forced to w=
ork with the topology that's been specified.

>> +        /*
>> +         * A function with no atomic completer support simply cannot
>> +         * receive and execute atomic operations.
>> +         * This does NOT mean other functions in the same multifunct=
ion
>> +         * device should be prevented from supporting atomics.
>> +         */
>> +        func_cap =3D vfio_get_atomic_cap(func_vdev);
>> +        if (func_cap !=3D 0) {
>> +            common_mask &=3D func_cap;
>> +        }
>
> It's not clear to me that this is a valid interpretation:
>
> PCIe 7.0, 6.15.2:
>
>         If any Function in a Multi-Function Device supports AtomicOp
>         Completer or AtomicOp routing capability, all Functions with
>         Memory Space BARs in that device must decode properly formed
>         AtomicOp Requests and handle any they don=E2=80=99t support as=
 an
>         Unsupported Request (UR). Note that in such devices, Functions
>         lacking AtomicOp Completer capability are forbidden to handle
>         properly formed AtomicOp Requests as Malformed TLPs.
>
> If we're adding an arbitrary device that may not support AtomicOps int=
o=20
> a virtual multifunction package, how can we know that a device that=20
> doesn't have an AtomicOps cap wouldn't respond with a Malformed TLP=20
> error?
>
> ++ My mistake in wording the comment. It is not that completer cannot=20
> receive operations, but rather that the true state of the hardware=20
> should be passed through, having same functionality on both VM and Bar=
e=20
> Metal

But we cannot enforce that in QEMU.

> ++ If the devices that doesn't support AtomicOps is passed through, it=20
> will have same capabilities as actual hardware, having same properties=20
> as bare metal (and same faults if hardware cannot respond with UR)

Only if the function is part of the same multifunction device on bare me=
tal.  QEMU cannot enforce that.

> ++ Because of the check that we do for VFIOPCIDevice in lines before,=20
> if non-vfio device is passed we will simply return

We can compose multifunction devices in QEMU from separate multi- and si=
ngle- function devices on bare metal.  The fact that they are VFIOPCIDev=
ices tells us nothing about the physical association.

>> +    }
>> +
>> +    return common_mask;
>> +}
>> +
>>  static void vfio_pci_enable_rp_atomics(VFIOPCIDevice *vdev)  {
>>      PCIBus *bus =3D pci_get_bus(&vdev->pdev); @@ -1948,8 +2009,7 @@
>> static void vfio_pci_enable_rp_atomics(VFIOPCIDevice *vdev)
>>      if (pci_bus_is_root(bus) || !parent || !parent->exp.exp_cap ||
>>          pcie_cap_get_type(parent) !=3D PCI_EXP_TYPE_ROOT_PORT ||
>>          pcie_cap_get_version(parent) !=3D PCI_EXP_FLAGS_VER2 ||
>> -        vdev->pdev.devfn ||
>> -        vdev->pdev.cap_present & QEMU_PCI_CAP_MULTIFUNCTION) {
>> +        vdev->pdev.devfn) {
>>          return;
>>      }
>>
>> @@ -1962,6 +2022,25 @@ static void vfio_pci_enable_rp_atomics(VFIOPCI=
Device *vdev)
>>          return;
>>      }
>>
>> +    /*
>> +     * Single-function: All device info is available now, configure =
immediately
>> +     * Multifunction: Other functions may not be realized yet, defer=
 to
>> +     *                machine_done time when all devices guaranteed =
to exist
>> +     */
>
> This also means that multifunction devices can only support cold-plug=20
> whereas single function devices support AtomicOps with cold-plug and=20
> hot-plug.  The cold-plug device can be unplugged and re-added and it=20
> will have different behavior.
>
> Additionally, it seems we only enable AtomicOps if function 0 supports=20
> AtomicOps, what's the basis for that decision?  Based on the previous=20
> comment, the more conservative approach might be that all functions=20
> need to support AtomicOps, but...
>
> Maybe what we really want is for each function to attempt to initializ=
e=20
> the AtomicOps bits on the root port.  The last realized function shoul=
d=20
> get it correct regardless of the order the functions are realized,=20
> though we'll need to track our 'Abort if already configured' strategy=20
> differently.
>
> I tossed out this machine_done notifier as a possibility, but I'd=20
> rather avoid it.
>
> ++ Machine_done was something I hesitantly did, trying to not change a=
s=20
> much functionality as possible of the current code.
> ++ If its appropriate, I can try with changing 'Abort if already=20
> configured' logic, to support this approach
> ++ What is your suggestion on this?

I'm not convinced it's QEMU's job, or that QEMU is even capable of servi=
ng the intended goal here.  Thanks,

Alex

