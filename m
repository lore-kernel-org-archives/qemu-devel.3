Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2DC6D49C92
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 10:25:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vllg7-00069g-Vd; Fri, 30 Jan 2026 05:24:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vllg7-00069V-5A
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 05:24:39 -0500
Received: from mout.web.de ([212.227.15.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vllg5-0004Gt-Bg
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 05:24:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1769768668; x=1770373468; i=lukasstraub2@web.de;
 bh=n0r4ZR5UZs/SqWpE2j3Uk2nBR2bIS4mnFVmERR85t44=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=SnJbP/FfSZ73RO/ADiw40L0wcCDFAR0HygUX+n02yhA2oHIAuU+IVSszfhac/kLa
 oicfxNwMg+Tq2SnGSOq82lFqq73KiQY+bDpylvh34NLfNGw5R8hZlOSheeyK2/ZYK
 icBJdzP9g+ql7tqiqcbu6aytsD42R9tZ47p5eptxZufLps7+nZwhX6aB2D92lwRMA
 mTKJah++ui1naZ0XC6K2QivGI6yRPXpCwvKhSxFdWfExCIYwV0ssDZtn3O71mElJw
 32mtpRLe5RiV3A33IrdohHDpA29k6AQNSMIcy7hyRRWExfmu1GhYgsPRz5mjwOTEp
 VSvY+H4v4J5FD8sGTw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from penguin ([217.247.97.172]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N45xt-1vuoBR2b1V-00wlhZ; Fri, 30
 Jan 2026 11:24:28 +0100
Date: Fri, 30 Jan 2026 11:24:02 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Zhang Chen
 <zhangckid@gmail.com>, Hailiang Zhang <zhanghailiang@xfusion.com>, Markus
 Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, "Dr.
 David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH v3 06/10] migration-test: Add COLO migration unit test
Message-ID: <20260130112402.2c008707@penguin>
In-Reply-To: <aXkk22x1M0k4qZoo@x1.local>
References: <20260125-colo_unit_test_multifd-v3-0-ae926ccd8eae@web.de>
 <20260125-colo_unit_test_multifd-v3-6-ae926ccd8eae@web.de>
 <aXkk22x1M0k4qZoo@x1.local>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/s9UH4v4u_POl2IeqDdUQzFp";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:nM0aIa2KA+DmfT9dxMymEqa7mmTvx8IhZaZJ2vHWqcgLqX6f5FF
 lTPiCmrfwNdtg92q/Uo/AFNBATuqjgGFTzf8emuSZIzNGlflW7GCnf+rSwC0NRZaZ6x5XdS
 UF8wdgLJHFHCUtP6Pkes4vAoTN96O+TYg/FjqXOFTfqzP6fQkalwHEo3Yl4h9ZAS2Qp8mwY
 I6AtBjBWQD/hNwAMrqtgA==
UI-OutboundReport: notjunk:1;M01:P0:vJrUnSFdh+w=;C0Ui7NmNtDXfMFWkGEQttDRcTWk
 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
 9X7po9pKPVD
Received-SPF: pass client-ip=212.227.15.3; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

--Sig_/s9UH4v4u_POl2IeqDdUQzFp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 27 Jan 2026 15:49:31 -0500
Peter Xu <peterx@redhat.com> wrote:

> On Sun, Jan 25, 2026 at 09:40:11PM +0100, Lukas Straub wrote:
> > +void migration_test_add_colo(MigrationTestEnv *env)
> > +{
> > +    if (!env->has_kvm) {
> > +        g_test_skip("COLO requires KVM accelerator");
> > +        return;
> > +    } =20
>=20
> I'm OK if you want to explicitly bypass others, but could you explanation
> why?
>=20
> Thanks,
>=20

It used to hang with TCG. Now it crashes, since
migration_bitmap_sync_precopy assumes bql is held. Something for later.

#6  0x00007ffff7471517 in __assert_fail
    (assertion=3Dassertion@entry=3D0x555555f17aee "bql_locked() !=3D locked=
", file=3Dfile@entry=3D0x555555f17ab0 "../system/cpus.c", line=3Dline@entry=
=3D535, function=3Dfunction@entry=3D0x55555609bfd0 <__PRETTY_FUNCTION__.9> =
"bql_update_status") at ./assert/assert.c:105
#7  0x0000555555b09f1e in bql_update_status (locked=3Dlocked@entry=3Dfalse)=
 at ../system/cpus.c:535
#8  0x0000555555ec60e7 in qemu_mutex_pre_unlock (mutex=3D0x555557166700 <bq=
l>, file=3D0x555555efe1dc "../cpu-common.c", line=3D164) at ../util/qemu-th=
read-common.h:57
#9  qemu_mutex_pre_unlock (line=3D164, file=3D0x555555efe1dc "../cpu-common=
.c", mutex=3D0x555557166700 <bql>) at ../util/qemu-thread-common.h:48
#10 qemu_cond_wait_impl (cond=3D0x5555571442c0 <qemu_work_cond>, mutex=3D0x=
555557166700 <bql>, file=3D0x555555efe1dc "../cpu-common.c", line=3D164) at=
 ../util/qemu-thread-posix.c:224
#11 0x000055555589e6c8 in do_run_on_cpu (cpu=3D<optimized out>, func=3D<opt=
imized out>, data=3D..., mutex=3D0x555557166700 <bql>) at ../cpu-common.c:1=
64
#12 0x0000555555b17a06 in memory_global_after_dirty_log_sync () at ../syste=
m/memory.c:2938
#13 0x0000555555b55b47 in migration_bitmap_sync (rs=3D0x7fffe8001340, last_=
stage=3Dlast_stage@entry=3Dtrue) at ../migration/ram.c:1157
#14 0x0000555555b56721 in migration_bitmap_sync_precopy (last_stage=3Dlast_=
stage@entry=3Dtrue) at ../migration/ram.c:1195
#15 0x0000555555b59f8a in ram_save_complete (f=3D0x5555575db620, opaque=3D<=
optimized out>) at ../migration/ram.c:3381
#16 0x0000555555b5e4f5 in qemu_savevm_complete (se=3Dse@entry=3D0x5555574c0=
d80, f=3Df@entry=3D0x5555575db620) at ../migration/savevm.c:1521
#17 0x0000555555b60437 in qemu_savevm_state_complete_precopy_iterable (f=3D=
f@entry=3D0x5555575db620, in_postcopy=3Din_postcopy@entry=3Dfalse) at ../mi=
gration/savevm.c:1627
#18 0x0000555555b60a4f in qemu_savevm_state_complete_precopy (iterable_only=
=3Dtrue, f=3D0x5555575db620) at ../migration/savevm.c:1719
#19 qemu_savevm_live_state (f=3D0x5555575db620) at ../migration/savevm.c:18=
55
#20 0x0000555555b65ed9 in colo_do_checkpoint_transaction (fb=3D<optimized o=
ut>, bioc=3D<optimized out>, s=3D0x5555574c0070) at ../migration/colo.c:474
#21 colo_process_checkpoint (s=3D0x5555574c0070) at ../migration/colo.c:592
#22 migrate_start_colo_process (s=3D0x5555574c0070) at ../migration/colo.c:=
655
#23 0x0000555555b4971e in migration_iteration_finish (s=3D0x5555574c0070) a=
t ../migration/migration.c:3297
#24 migration_thread (opaque=3Dopaque@entry=3D0x5555574c0070) at ../migrati=
on/migration.c:3584
#25 0x0000555555ec58c0 in qemu_thread_start (args=3D0x5555576583e0) at ../u=
til/qemu-thread-posix.c:393
#26 0x00007ffff74d2aa4 in start_thread (arg=3D<optimized out>) at ./nptl/pt=
hread_create.c:447
#27 0x00007ffff755fc6c in clone3 () at ../sysdeps/unix/sysv/linux/x86_64/cl=
one3.S:78

--Sig_/s9UH4v4u_POl2IeqDdUQzFp
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAml8hsIACgkQNasLKJxd
sliFKhAAtRGNJVq0N9Du4DFIBxuFtknrKUk+8nPY6BbasUnToOriGJPnFss7phde
zN3rBR/XyjSReHaGqF1AMkcisIl3qBWrHRP5Homd3qpHePltXaccb0jf5rc5L5HL
Gx1BrvbL+ZdkH5V5NQOfyq5t9F+XdKmzmRmQvDVovZ6yvpyT7pxerMlwB3d7poXo
1XviHfdDb3+SUCRfYTjkifzen+bzLPxLwvEwo96DNFp+n1n7aEzFeP/8UEDY42Hy
iTtk+F39316bb1W5cryhUwZKcVpGW0vbd7YceHL25sWWEMc2z5MASrtamPIc5CCE
bbolPkxV6OMo1MZCh/PEwauabfC8hROWrBMrBVSrQZRBRgB48O0TV8CDW3sM/gQX
SZyCMyiZhAbyCFCjkc5uzk0GezAyX8c+gMSWXOQQvISKfCTvW1KblMycrS4sThWg
z1SMWYtA9vrRtTJgJCznjCSInR+di0vXyI/hHNMWWQyggJcRuZtmBdtebY7lOiQ1
PrdWSxzyHfDnbTCJSMF/3U0jss5foWCMiganv/MtT6+tYRhcIDIxIdQ/ixeaM3nb
/jyxAjSmtHmTKeu5fKfI+sV0hjhO5njrTwv4kHRnvsZgVCHp2qtVE9aH4Nm06qBr
0Bs9fM492Ek47W5WlEEc6Zld+l93+Mfycue3EwCbtXXqP0jsF1Q=
=u9q8
-----END PGP SIGNATURE-----

--Sig_/s9UH4v4u_POl2IeqDdUQzFp--

