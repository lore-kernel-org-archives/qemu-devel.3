Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9152E7718A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 20:08:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tO0LF-0004XQ-T0; Wed, 18 Dec 2024 15:08:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+6cdea2fcdec3a6535aff+7787+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1tO0LB-0004Wr-F8
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 15:08:17 -0500
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+6cdea2fcdec3a6535aff+7787+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1tO0L9-0006q0-1x
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 15:08:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
 :MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=u+bRP8+tZGWoefo8rX/G+qPMh7HbJvKkGR1u4cxtjNM=; b=NIUAm1rjLQOGoEF/7ouL1ZdQnn
 PjISBk4uqykkpHGxy/n8e+EGS3npGAWi1hy4nU38fCtpUZAfU7epXdYQwXJ2JR5x+RfOdylxx4/Vr
 jm6QHarZWlLtu7dw9AfCpu+xKygEaO3Rk137/NDAduSDc3K0S+y9QzC87bPmMk5SUqzIGN/PqqvI8
 IJu6ySglNjk71rOXKfQ26c1vBswiD9sK4hIX2pLZNpnqNbDtafNDDjYGTVJp0ByGEh7nxJMn1QqSl
 UTSnOyS7v1+zmAKqk+sK+VYnzZi2ANx1bDZEiWEFpHvBfMZHJmkjS/QqGT4YqCU+seah4IF2z3LPJ
 T/pk0gsQ==;
Received: from [82.144.38.251] (helo=[127.0.0.1])
 by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
 id 1tO0L4-00000005KQ7-0UOh; Wed, 18 Dec 2024 20:08:10 +0000
Date: Wed, 18 Dec 2024 20:11:31 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
CC: Paul Durrant <paul@xen.org>
Subject: Re: [PATCH] tests/functional: Convert the kvm_xen_guest avocado test
User-Agent: K-9 Mail for Android
In-Reply-To: <eba79212-95c2-4747-babd-cbd67605fce9@redhat.com>
References: <20241218113255.232356-1-thuth@redhat.com>
 <9B5DDDDB-769B-4654-BEF1-D3F853EA05E5@infradead.org>
 <31e85f4d-66f2-4790-8597-f43e291bcbea@redhat.com>
 <61cadf31-8656-4216-a345-e364bb85e45b@redhat.com>
 <44c87114343dc57b248ff0f86e5f4e0683533efb.camel@infradead.org>
 <f987b60d-9e73-4f6a-ae48-857f7af6cddc@redhat.com>
 <eba79212-95c2-4747-babd-cbd67605fce9@redhat.com>
Message-ID: <B2AC746C-4911-456E-A47B-5069959152BB@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 desiato.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05;
 envelope-from=BATV+6cdea2fcdec3a6535aff+7787+infradead.org+dwmw2@desiato.srs.infradead.org;
 helo=desiato.infradead.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 18 December 2024 18:16:13 CET, Thomas Huth <thuth@redhat=2Ecom> wrote:
>On 18/12/2024 17=2E19, Thomas Huth wrote:
>> On 18/12/2024 15=2E11, David Woodhouse wrote:
>>> On Wed, 2024-12-18 at 14:38 +0100, Thomas Huth wrote:
>> =2E=2E=2E
>>>> But FWIW, there seems to be another issue with this test=2E While run=
ning it
>>>> multiple times, I sometimes see test_kvm_xen_guest_novector_noapic ha=
nging=2E
>>>> According to the console output, the guest waits in vain for a device=
:
>>>>=20
>>>> 2024-12-18 14:32:58,606: Initializing XFRM netlink socket
>>>> 2024-12-18 14:32:58,607: NET: Registered PF_INET6 protocol family
>>>> 2024-12-18 14:32:58,609: Segment Routing with IPv6
>>>> 2024-12-18 14:32:58,609: In-situ OAM (IOAM) with IPv6
>>>> 2024-12-18 14:32:58,610: NET: Registered PF_PACKET protocol family
>>>> 2024-12-18 14:32:58,610: 8021q: 802=2E1Q VLAN Support v1=2E8
>>>> 2024-12-18 14:32:58,611: 9pnet: Installing 9P2000 support
>>>> 2024-12-18 14:32:58,613: NET: Registered PF_VSOCK protocol family
>>>> 2024-12-18 14:32:58,614: IPI shorthand broadcast: enabled
>>>> 2024-12-18 14:32:58,619: sched_clock: Marking stable (551147059, -677=
8955)->(590359530, -45991426)
>>>> 2024-12-18 14:32:59,507: tsc: Refined TSC clocksource calibration: 24=
95=2E952 MHz
>>>> 2024-12-18 14:32:59,508: clocksource: tsc: mask: 0xffffffffffffffff m=
ax_cycles: 0x23fa49fc138, max_idle_ns: 440795295059 ns
>>>> 2024-12-18 14:32:59,509: clocksource: Switched to clocksource tsc
>>>> 2024-12-18 14:33:28,667: xenbus_probe_frontend: Waiting for devices t=
o initialise: 25s=2E=2E=2E20s=2E=2E=2E15s=2E=2E=2E10s=2E=2E=2E5s=2E=2E=2E0s=
=2E=2E=2E
>>>>=20
>>>> Have you seen this problem before?
>>>=20
>>> That seems like event channel interrupts aren't being routed to the
>>> legacy i8259 PIC=2E I've certainly seen that kind of thing before,
>>> especially when asserted level-triggered interrupts weren't correctly
>>> being asserted=2E But I don't expect that of QEMU=2E I'll see if I can
>>> reproduce; thanks=2E
>>>=20
>>> How often does it happen?
>>=20
>> With the new functional test, it happens maybe 2 times out of 100 test =
runs=2E
>>=20
>> I wasn't able to reproduce it with the avocado version yet, but that al=
so runs 10x slower, so it takes a longer time to get to that many runs=2E=
=2E=2E
>
>Ok, FWIW, I've now also seen the problem with the old avocado version of =
the test, so it's nothing that has been introduced by my patch=2E I just ha=
d to downgrade to Avocado v88 again since the current version v103 does not=
 seem to correctly output the console anymore :-/ (which is another good in=
dicator that we really need to get the stuff moved over to the functional f=
ramework now)=2E
>
> Thomas
>

I have reproduced it, will look into it=2E I'm fairly sure this was all wo=
rking reliably at the time the Xen support was merged; that's why I wrote t=
hese test cases after all=2E

