Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53D8FC43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 08:39:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfZQt-0004ZV-TN; Fri, 03 Jul 2026 04:39:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1wfZQs-0004ZM-JS
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 04:39:34 -0400
Received: from mout.web.de ([212.227.15.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1wfZQq-0003bf-2L
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 04:39:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1783067962; x=1783672762; i=lukasstraub2@web.de;
 bh=QfY1X8ArqfmiTiyat8fHwGcQBA5Wb3ilglAm2ySRiEo=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=wdr2HePCIEMwuZ4lNyT9d2YhXPyKwscy2XALWp/KjUbtHHuRPxv54uENwgyzcgfu
 IAhrOkpM+Vn8qQwnJedn+apw4P45bdcZUAAnM4Ya48PMytIspkGGJoWJ0sj4QT0Hm
 1bjRc3L+oZVHrOWyu4hjbZbi7pW792rJxuWfhaSeY/zumqH4V4MlbjKD1jNhWGXEk
 5HPlkHc12HJ8Ulen8OzKtfbAmCy/3AoPV2cOo0rKFFCz57S1Laf4RGMCynjWbMUqL
 y/8m6Onauzm00Npkl/BQ3m3DpDS4tBgv3XQpu1sj1kAafUaYh3ruqPVuOHe7Q4TtW
 t7bMJAh1nPLDmzeNcQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mx0N5-1x30QT0sfL-017K4K; Fri, 03
 Jul 2026 10:39:22 +0200
Date: Fri, 3 Jul 2026 10:38:40 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: Avihai Horon <avihaih@nvidia.com>
Cc: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>, Peter Xu
 <peterx@redhat.com>, "Jason J. Herne" <jjhern@linux.ibm.com>
Subject: Re: [PULL 08/23] migration: Run final save_query_pending at switchover
Message-ID: <20260703103840.7306b4fa@penguin>
In-Reply-To: <a82ece02-d9fd-4ea4-b934-a9bc5abde663@nvidia.com>
References: <20260630043107.1511076-1-clg@redhat.com>
 <20260630043107.1511076-9-clg@redhat.com>
 <a82ece02-d9fd-4ea4-b934-a9bc5abde663@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2SSnbEtE/0E0kDBV1qDM1tx";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:zZEbe+aJGR6FDeumBMSLHc6hVRHdlqEr0+rxKmLYJDFTHt+ucSz
 1qsfv+1ihutrg6x386Vo0EYwDfTCYkCrw0tdT1paeBhU+s/QQad4VDXQQqR4d7oNtDXypOd
 othIgtjrTDfnugNH/Rfe9YhoaGLzP1TQlak6r3MTmE9IQPclJQggJjDAXB8kJh0Xk2dNntZ
 EMFeiPsPPnpiJnh9KL8Yw==
UI-OutboundReport: notjunk:1;M01:P0:31DJOHu4vl8=;Zdc8PrS5ynJnSlMHi2Rs4JGjmh3
 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
 wOMyss7Oer6n4bybXjHcp
Received-SPF: pass client-ip=212.227.15.14; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

--Sig_/2SSnbEtE/0E0kDBV1qDM1tx
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 3 Jul 2026 11:05:39 +0300
Avihai Horon <avihaih@nvidia.com> wrote:

> On 6/30/2026 7:30 AM, C=C3=A9dric Le Goater wrote:
> > External email: Use caution opening links or attachments
> >
> >
> > From: Avihai Horon <avihaih@nvidia.com>
> >
> > Before switchover, the source needs one last exact pending query so
> > modules can flush dirty state. This is currently done ad hoc in modules
> > handlers. For example, RAM syncs its dirty bitmap in its save_complete
> > handler.
> >
> > This should be a general concept relevant for any module, so extract it
> > to migration core instead by running a final save_query_pending before
> > switchover.
> >
> > The final query requires special handling by modules (e.g., it's called
> > with BQL locked, during VM stop), so extend save_query_pending
> > SaveVMHandlers callback and qemu_savevm_query_pending() with a "final"
> > flag so migration modules can tell the last pending query during
> > switchover from periodic iteration queries.
> >
> > Reviewed-by: Peter Xu <peterx@redhat.com>
> > Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> > Reviewed-by: Jason J. Herne <jjhern@linux.ibm.com>
> > Link: https://lore.kernel.org/qemu-devel/20260622101214.25770-4-avihaih=
@nvidia.com
> > Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
> > ---
> >   include/migration/register.h   | 41 ++++++++++++++++++----------------
> >   migration/savevm.h             |  3 ++-
> >   hw/s390x/s390-stattrib.c       |  2 +-
> >   hw/vfio/migration.c            | 11 ++++++---
> >   migration/block-dirty-bitmap.c | 11 ++++++---
> >   migration/migration.c          | 14 ++++++++++--
> >   migration/ram.c                | 40 +++++++++++++++++++--------------
> >   migration/savevm.c             | 20 +++++++++++++----
> >   hw/vfio/trace-events           |  2 +-
> >   migration/trace-events         |  2 +-
> >   10 files changed, 94 insertions(+), 52 deletions(-)
> >
> > [...]
> >
> > diff --git a/migration/migration.c b/migration/migration.c
> > index 0f9e891cf85c8e5074f7f9800515e244fa413fa2..ea0b236597087cc005541e1=
916ceabb229afab4b 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -2787,12 +2787,22 @@ static bool migration_switchover_prepare(Migrat=
ionState *s)
> >   static bool migration_switchover_start(MigrationState *s, Error **err=
p)
> >   {
> >       ERRP_GUARD();
> > +    MigPendingData pending =3D {};
> >
> >       if (!migration_switchover_prepare(s)) {
> >           error_setg(errp, "Switchover is interrupted");
> >           return false;
> >       }
> >
> > +    /*
> > +     * The final query to the whole system on dirty data to make sure =
we
> > +     * collect the latest status of the VM.  For precopy, source QEMU =
will
> > +     * dump all the dirty data during switchover.  For postcopy, this =
will
> > +     * properly update all the dirty bitmaps to finally generate the
> > +     * correct discard bitmaps; see ram_postcopy_send_discard_bitmap().
> > +     */
> > +    qemu_savevm_query_pending_final(&pending);
> > +
> >       /* Inactivate disks except in COLO */
> >       if (!migrate_colo()) {
> >           /*
> > @@ -3285,7 +3295,7 @@ static void migration_iteration_go_next(MigPendin=
gData *pending)
> >       /*
> >        * Do a slow sync first before boosting the iteration count.
> >        */
> > -    qemu_savevm_query_pending(pending, true);
> > +    qemu_savevm_query_pending_iter(pending, true);
> >
> >       /*
> >        * Update the dirty information for the whole system for this
> > @@ -3336,7 +3346,7 @@ static MigIterateState migration_iteration_run(Mi=
grationState *s)
> >       bool complete_ready;
> >
> >       /* Fast path - get the estimated amount of pending data */
> > -    qemu_savevm_query_pending(&pending, false);
> > +    qemu_savevm_query_pending_iter(&pending, false);
> >
> >       if (in_postcopy) {
> >           /*
> > diff --git a/migration/ram.c b/migration/ram.c
> > index 55aa9b47dc8ab8463fd1aeba19726a493b81b070..8918b2f03b6fbcc98532bb4=
5ab905f9bac59384c 100644
> > --- a/migration/ram.c
> > +++ b/migration/ram.c
> > @@ -2686,9 +2686,6 @@ void ram_postcopy_send_discard_bitmap(MigrationSt=
ate *ms)
> >
> >       RCU_READ_LOCK_GUARD();
> >
> > -    /* This should be our last sync, the src is now paused */
> > -    migration_bitmap_sync_precopy(true);
> > -
> >       /* Easiest way to make sure we don't resume in the middle of a ho=
st-page */
> >       rs->pss[RAM_CHANNEL_PRECOPY].last_sent_block =3D NULL;
> >       rs->last_seen_block =3D NULL;
> > @@ -3376,10 +3373,6 @@ static int ram_save_complete(QEMUFile *f, void *=
opaque)
> >       rs->last_stage =3D !migration_in_colo_state();
> >
> >       WITH_RCU_READ_LOCK_GUARD() {
> > -        if (!migration_in_postcopy()) {
> > -            migration_bitmap_sync_precopy(true);
> > -        }
> > - =20
>=20
> (Got some technical issues receiving QEMU ML mails that I'm not CCed to,=
=20
> so replying here for Stefan's mail [1])
>=20
> Seems like this patch overlooked the COLO case which calls=20
> ram_save_complete() on each checkpoint and expects the RAM complete=20
> handler to sync RAM dirty bitmap.
> This patch moved this dirty sync from ram_save_complete() (the removed=20
> lines above) into a qemu_savevm_query_pending_final() called only once=20
> at migration_switchover_start().
>=20
> I believe this is the root cause for the CI failure reported by Stefan,=20
> since I was able to repro this locally [2] and the diff below [3] fixed=20
> the issue [4].
>=20
> I have zero knowledge in COLO so would really appreciate some feedback=20
> from Peter/COLO folks if that's a valid fix.
>=20
> Thanks.
>=20
> [1]=20
> https://lore.kernel.org/qemu-devel/CAJSP0QX-8L2CSX5q95Md5V6NTE_4p+K8Kr-QG=
bqKm2BBMtdh5Q@mail.gmail.com/
>=20
> [2]
>=20
> QTEST_QEMU_BINARY=3D./qemu-system-x86_64 =C2=A0./tests/qtest/migration-te=
st -k=20
> --full -r /x86_64/migration/colo
> [...]
> # Running /x86_64/migration/colo/plain/secondary_failover
> # Using machine type: pc-q35-11.1
> # starting QEMU: exec ./qemu-system-x86_64 -qtest=20
> unix:/tmp/qtest-1415533.sock -qtest-log /dev/null -chardev=20
> socket,path=3D/tmp/qtest-1415533.qmp,id=3Dchar0 -mon=20
> chardev=3Dchar0,mode=3Dcontrol -display none -audio
> none -run-with exit-with-parent=3Don -accel kvm -accel tcg -machine=20
> pc-q35-11.1, -name source,debug-threads=3Don -machine=20
> memory-backend=3Dmig.mem -object=20
> memory-backend-ram,id=3Dmig.mem,size=3D150M,share=3Doff -serial
>  =C2=A0file:/tmp/migration-test-GF36R3/src_serial -drive=20
> if=3Dnone,id=3Dd0,file=3D/tmp/migration-test-GF36R3/bootsect,format=3Draw=
=20
> -device ide-hd,drive=3Dd0,secs=3D1,cyls=3D1,heads=3D1 -snapshot 2>/dev/nu=
ll=C2=A0=20
> -accel qtest
> # starting QEMU: exec ./qemu-system-x86_64 -qtest=20
> unix:/tmp/qtest-1415533.sock -qtest-log /dev/null -chardev=20
> socket,path=3D/tmp/qtest-1415533.qmp,id=3Dchar0 -mon=20
> chardev=3Dchar0,mode=3Dcontrol -display none -audio
> none -run-with exit-with-parent=3Don -accel kvm -accel tcg -machine=20
> pc-q35-11.1, -name target,debug-threads=3Don -machine=20
> memory-backend=3Dmig.mem -object=20
> memory-backend-ram,id=3Dmig.mem,size=3D150M,share=3Doff -serial
>  =C2=A0file:/tmp/migration-test-GF36R3/dest_serial -incoming defer -drive=
=20
> if=3Dnone,id=3Dd0,file=3D/tmp/migration-test-GF36R3/bootsect,format=3Draw=
=20
> -device ide-hd,drive=3Dd0,secs=3D1,cyls=3D1,heads=3D1 -snapshot 2>/dev/nu=
ll=C2=A0 -a
> ccel qtest
> Memory content inconsistency at ea2000 first_byte =3D 53 last_byte =3D 53=
=20
> current =3D 54 hit_edge =3D 0
> Memory content inconsistency at ea3000 first_byte =3D 53 last_byte =3D 53=
=20
> current =3D 54 hit_edge =3D 0
> Memory content inconsistency at ea4000 first_byte =3D 53 last_byte =3D 53=
=20
> current =3D 54 hit_edge =3D 0
> Memory content inconsistency at ea5000 first_byte =3D 53 last_byte =3D 53=
=20
> current =3D 54 hit_edge =3D 0
> Memory content inconsistency at ea6000 first_byte =3D 53 last_byte =3D 53=
=20
> current =3D 54 hit_edge =3D 0
> Memory content inconsistency at ea7000 first_byte =3D 53 last_byte =3D 53=
=20
> current =3D 54 hit_edge =3D 0
> Memory content inconsistency at ea8000 first_byte =3D 53 last_byte =3D 53=
=20
> current =3D 54 hit_edge =3D 0
> Memory content inconsistency at ea9000 first_byte =3D 53 last_byte =3D 53=
=20
> current =3D 54 hit_edge =3D 0
> Memory content inconsistency at eaa000 first_byte =3D 53 last_byte =3D 53=
=20
> current =3D 54 hit_edge =3D 0
> Memory content inconsistency at eab000 first_byte =3D 53 last_byte =3D 53=
=20
> current =3D 54 hit_edge =3D 0
> and in another 13488 pages**
> ERROR:../tests/qtest/migration/framework.c:190:check_guests_ram:=20
> assertion failed: (bad =3D=3D 0)
> not ok /x86_64/migration/colo/plain/secondary_failover -=20
> ERROR:../tests/qtest/migration/framework.c:190:check_guests_ram:=20
> assertion failed: (bad =3D=3D 0)
> Bail out!
>=20
> [3]
>=20
> diff --git a/migration/colo.c b/migration/colo.c
> index 2d36f933cf..5c486c09ef 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -409,6 +409,7 @@ static int=20
> colo_do_checkpoint_transaction(MigrationState *s,
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0QEMUFile *fb)
>  =C2=A0{
>  =C2=A0 =C2=A0 =C2=A0Error *local_err =3D NULL;
> +=C2=A0 =C2=A0 MigPendingData pending =3D {};
>  =C2=A0 =C2=A0 =C2=A0int ret =3D -1;
>=20
>  =C2=A0 =C2=A0 =C2=A0colo_send_message(s->to_dst_file, COLO_MESSAGE_CHECK=
POINT_REQUEST,
> @@ -465,6 +466,18 @@ static int=20
> colo_do_checkpoint_transaction(MigrationState *s,
>  =C2=A0 =C2=A0 =C2=A0if (migrate_auto_converge()) {
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mig_throttle_counter_reset();
>  =C2=A0 =C2=A0 =C2=A0}
> +
> +=C2=A0 =C2=A0 /*
> +=C2=A0 =C2=A0 =C2=A0* Run the final pending query so migration modules c=
an flush their=20
> dirty
> +=C2=A0 =C2=A0 =C2=A0* state (e.g., RAM syncs its dirty bitmap) before th=
is=20
> checkpoint's live
> +=C2=A0 =C2=A0 =C2=A0* state is saved. Unlike a regular switchover, COLO =
reaches completion
> +=C2=A0 =C2=A0 =C2=A0* repeatedly for every checkpoint, so this must be d=
one on each one.
> +=C2=A0 =C2=A0 =C2=A0*/
> +=C2=A0 =C2=A0 if (!qemu_savevm_query_pending_final(s, &pending, &local_e=
rr)) {
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 bql_unlock();
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;
> +=C2=A0 =C2=A0 }
> +
>  =C2=A0 =C2=A0 =C2=A0/*
>  =C2=A0 =C2=A0 =C2=A0 * Only save VM's live state, which not including de=
vice state.
>  =C2=A0 =C2=A0 =C2=A0 * TODO: We may need a timeout mechanism to prevent =
COLO process

Hello,
This patch looks good to me.

Regards,
Lukas Straub

>=20
> [4]
>=20
> QTEST_QEMU_BINARY=3D./qemu-system-x86_64 =C2=A0./tests/qtest/migration-te=
st -k=20
> --full -r /x86_64/migration/colo
> [...]
> # Running /x86_64/migration/colo/plain/secondary_failover
> # Using machine type: pc-q35-11.1
> # starting QEMU: exec ./qemu-system-x86_64 -qtest=20
> unix:/tmp/qtest-1417324.sock -qtest-log /dev/null -chardev=20
> socket,path=3D/tmp/qtest-1417324.qmp,id=3Dchar0 -mon=20
> chardev=3Dchar0,mode=3Dcontrol -display none -audio
> none -run-with exit-with-parent=3Don -accel kvm -accel tcg -machine=20
> pc-q35-11.1, -name source,debug-threads=3Don -machine=20
> memory-backend=3Dmig.mem -object=20
> memory-backend-ram,id=3Dmig.mem,size=3D150M,share=3Doff -serial
>  =C2=A0file:/tmp/migration-test-0TMNR3/src_serial -drive=20
> if=3Dnone,id=3Dd0,file=3D/tmp/migration-test-0TMNR3/bootsect,format=3Draw=
=20
> -device ide-hd,drive=3Dd0,secs=3D1,cyls=3D1,heads=3D1 -snapshot 2>/dev/nu=
ll=C2=A0=20
> -accel qtest
> # starting QEMU: exec ./qemu-system-x86_64 -qtest=20
> unix:/tmp/qtest-1417324.sock -qtest-log /dev/null -chardev=20
> socket,path=3D/tmp/qtest-1417324.qmp,id=3Dchar0 -mon=20
> chardev=3Dchar0,mode=3Dcontrol -display none -audio
> none -run-with exit-with-parent=3Don -accel kvm -accel tcg -machine=20
> pc-q35-11.1, -name target,debug-threads=3Don -machine=20
> memory-backend=3Dmig.mem -object=20
> memory-backend-ram,id=3Dmig.mem,size=3D150M,share=3Doff -serial
>  =C2=A0file:/tmp/migration-test-0TMNR3/dest_serial -incoming defer -drive=
=20
> if=3Dnone,id=3Dd0,file=3D/tmp/migration-test-0TMNR3/bootsect,format=3Draw=
=20
> -device ide-hd,drive=3Dd0,secs=3D1,cyls=3D1,heads=3D1 -snapshot 2>/dev/nu=
ll=C2=A0 -a
> ccel qtest
> ok 2 /x86_64/migration/colo/plain/secondary_failover
>=20
> > [...]

--Sig_/2SSnbEtE/0E0kDBV1qDM1tx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmpHdRAACgkQNasLKJxd
sliDBw/+ItsCijQJ0/kuOzxRggalbuayzHbSH+VSi5OGvURbI5HF7ROWDW4XlbY1
LvJ2kUqVCb3gxb6lwHR/MyYl69aFyKfKGZuhsqdWndEbaGvesS1TvMGfygEg7p8I
FirBSP7Ph9agIs8jn1TSDxarkWYtcTKq2D79dGc226Xza1bqSPV1ywfscekZGUAm
X4TnwH6nc38vXmHZRQSUktFawJyrUyWfcPk8JTIu50dy3LfE+YLIEp+PcXJaga+l
wz74bkb2wt7bQIwsAVIGvCoxFU8b2GkWp7gdz66zB+EqbSQkkiT+mB6EntOZPRlJ
warOfVBmoV+UuzYIn0TtQGOhZU2vbmkVPxh1KwcZXW7iTKjMZoFDM103ySMMEbpl
XsTYBLTb/XE1NNs7EqKg+7moywns+XhQIxjGmluXFupDLxYOtTQ4bGNvZqqY8GYP
seKU5mSwk3GpEguvunxWhZ2fpk2vw3BUVnuv4FyP1XQzsLh20LzoV5NTV0XUidsv
TZa5RmoXEHcyAbLcA8UiVTTIKJ0HmsSCK6PLfCrMaTsnbFeoiClQmHhVdLwFif4U
4jZbVcu9mXfJMFvQo6Kwr2+A3Cs2H2au2GXl+CkNOHnNQo1rqqcyAQVhM4KI7uMJ
rABEwBTnIH1zVnxutGiCboM8R9NLoOGZmv4kemZkmDNGaCQ61LM=
=F2TJ
-----END PGP SIGNATURE-----

--Sig_/2SSnbEtE/0E0kDBV1qDM1tx--

