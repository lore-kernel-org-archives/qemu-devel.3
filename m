Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57F8DD31A3C
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 10:17:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfxwV-0002H0-7m; Wed, 14 Jan 2026 05:17:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Marco.Cavenati@eurecom.fr>)
 id 1vfxvu-0002EE-PP
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 05:16:58 -0500
Received: from smtp.eurecom.fr ([193.55.113.210])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Marco.Cavenati@eurecom.fr>)
 id 1vfxvs-0001qD-6O
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 05:16:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=eurecom.fr; i=@eurecom.fr; q=dns/txt; s=default;
 t=1768385817; x=1799921817;
 h=from:in-reply-to:references:date:cc:to:mime-version:
 message-id:subject:content-transfer-encoding;
 bh=B2F12y4WnovnyaTZS2zX8dli3hLrVex7sUvNaxqpsuY=;
 b=C2142/UcY8cpJXxSABW0U/izcNajFWLnLKmvuDZC4+9oH8RYbeHWypvi
 1JwVuPYg5d8F/0cqhomb3dl2giKw8ozJlyxs7MnM3JN8/+LMLhEcwGpRb
 dxQ230HTrFUw42fYFv+5OR0uQtgJv3HNlT1sEe1lKkcpdqy1LtjHdl2CF U=;
X-CSE-ConnectionGUID: Jh81eu2qThyAYzl88/I72A==
X-CSE-MsgGUID: Msk7Keo7QrKB/9nxvEROdA==
X-IronPort-AV: E=Sophos;i="6.21,225,1763420400"; 
   d="scan'208";a="4215494"
Received: from quovadis.eurecom.fr ([10.3.2.233])
 by drago1i.eurecom.fr with ESMTP; 14 Jan 2026 11:16:52 +0100
From: "Marco Cavenati" <Marco.Cavenati@eurecom.fr>
In-Reply-To: <aWZk7udMufaXPw-E@x1.local>
Content-Type: text/plain; charset="utf-8"
X-Forward: 193.55.114.5
References: <CAJSP0QVXXX7GV5W4nj7kP35x_4gbF2nG1G1jdh9Q=XgSx=nX3A@mail.gmail.com>
 <aWZk7udMufaXPw-E@x1.local>
Date: Wed, 14 Jan 2026 11:16:52 +0100
Cc: "qemu-devel" <qemu-devel@nongnu.org>
To: "Peter Xu" <peterx@redhat.com>
MIME-Version: 1.0
Message-ID: <3e46b0-69676d00-4d-1a5e27c0@252361837>
Subject: =?utf-8?q?Re=3A?= Call for GSoC internship project ideas
User-Agent: SOGoMail 5.12.1
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=193.55.113.210;
 envelope-from=Marco.Cavenati@eurecom.fr; helo=smtp.eurecom.fr
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Hi Peter,

This is great to hear! I=E2=80=99m happy you=E2=80=99re taking the time=
 to propose and
mentor this. I=E2=80=99m definitely interested in seeing what comes out=
 of it,
thanks for putting me in the loop.

Regarding your proposed Fast Snapshot Load, it=E2=80=99s certainly more=
 widely
applicable and doesn=E2=80=99t require new QMP commands or extensive co=
nfigurations
(beyond mapped-ram), compared to what I had in mind. I think it will be
beneficial for our use case regardless.

I=E2=80=99d still be interested in trying to improve it further using d=
irty
tracking at some point, to ignore pages that haven=E2=80=99t been writt=
en between
two loadvm of the same snapshot. This would probably apply only to lega=
cy
snapshot though, as file migration expects a clean QEMU process.

I=E2=80=99m not sure if I=E2=80=99m still eligible for GSoC; otherwise,=
 I would have
applied myself :)

Best,
Marco

(removing people from CC to reduce noise)

On Tuesday, January 13, 2026 16:29 CET, Peter Xu <peterx@redhat.com> wr=
ote:

> On Mon, Jan 05, 2026 at 04:47:22PM -0500, Stefan Hajnoczi wrote:
> > Dear QEMU and KVM communities,
> > QEMU will apply for the Google Summer of Code internship
> > program again this year. Regular contributors can submit project
> > ideas that they'd like to mentor by replying to this email by
> > January 30th.
>=20
> There's one idea from migration side that should be self-contained, p=
lease
> evaluate if this suites for the application.
>=20
> I copied Marco who might be interested on such project too at least f=
rom an
> user perspective on fuzzing [1].
>=20
> [1] https://lore.kernel.org/all/193e5a-681dfa80-3af-701c0f80@22719288=
7/
>=20
> Thanks,
>=20
> =3D=3D=3D Fast Snapshot Load =3D=3D=3D
>=20
> '''Summary:''' Fast loadvm process based on postcopy approach
>=20
> We have two common ways to load snapshots: (1) QMP "snapshot-load", o=
r QMP
> "migrate=5Fincoming" with a "file:" URI. The idea to be discussed her=
e should
> apply to either form of loadvm, however here we will focus on "file:"
> migration only, because it should be the modern and suggested way of =
using
> snapshots nowadays.
>=20
> Load snapshot currently requires all VM data (RAM states and the rest
> device states) to be loaded into the QEMU instance before VM starts.
>=20
> It is not required, though, to load guest memory to start the VM. For
> example, in a postcopy live migration process, QEMU uses userfaultfd =
to
> allow VM run without all of the guest memory migrated. A similar tech=
nique
> can also be used in a loadvm process to make loadvm very fast, starti=
ng the
> VM almost immediately right after the loadvm command.
>=20
> The idea is simple: we can start the VM right after loading device st=
ates
> (but without loading the guest memory), then QEMU can start the VM. I=
n the
> background, the loadvm process should keep loading all the VM data in=
 an
> atomically way. Meanwhile, the vCPUs may from time to time access a m=
issing
> guest page. QEMU needs to trap these accesses with userfaultfd, and r=
esolve
> the page faults.
>=20
> After loading all the RAM state, the whole loadvm procedure is comple=
ted.
>=20
> This feature needs to depend on mapped-ram feature, which allows offs=
etting
> into the snapshots to find whatever page being asked by the guest vCP=
Us at
> any point in time.
>=20
> This feature may not be very help in VM suspend / resume use cases, b=
ecause
> in those cases the VM was down previously, normally it's fine waiting=
 for
> the VM to be fully loaded. However, it might be useful in some other =
cases
> (like, frequently loading snapshots).
>=20
> '''Links:'''
> * https://wiki.qemu.org/ToDo/LiveMigration#Fast=5Fload=5Fsnapshot
>=20
> '''Details:'''
> * Skill level: advanced
> * Language: C
> * Mentor: Peter Xu <peterx@redhat.com>, peterx (on #qemu IRC)
>=20
> --=20
> Peter Xu
>


