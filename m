Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8F6DE8306E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 09:19:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnCYW-0001w9-2W; Tue, 03 Feb 2026 04:18:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vnCYU-0001vy-5B
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 04:18:42 -0500
Received: from mout.web.de ([212.227.15.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vnCYP-0005I6-SY
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 04:18:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1770110314; x=1770715114; i=lukasstraub2@web.de;
 bh=IUCQJ+PdNBG41cXc7D1iPwF+KZlQTICXOVEEobx1p3I=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=SLdNew+EmQSFEccGxRP6/ZRYfuXdXyyjUL7GsDF+4duFttXnbHvniMaKuQMEjc7J
 yVMpoCdz9hbGGHOjoSTTDgBfkE3Q5fh2qXYW31vdkE7B0Z3E5ufocOQSuofedt083
 VpEYuEn1xO3nkYZ6OGS8qu6AwzGuN2WXvJ+TB7KYJSwuKt/oEixED13Mk7zmfFXhD
 55XuNk55A09CcASxBjLeq0rYDI++G/lbNSBhbTTMbv+NstCM2/7WEO/YHg/n0Df7W
 SFoatMTwYlkuYOHSNpFxXXgdtCfmWDnRFPFRNN10lqaoXt/hoTt7bK4bJpodRQX3H
 3zOBMLMvqi2U7aIlzg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from penguin ([217.247.97.172]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MiuSe-1vJLSA2jOW-00iDVI; Tue, 03
 Feb 2026 10:18:34 +0100
Date: Tue, 3 Feb 2026 10:18:22 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Zhang Chen
 <zhangckid@gmail.com>, Hailiang Zhang <zhanghailiang@xfusion.com>, Markus
 Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, "Dr.
 David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH v3 06/10] migration-test: Add COLO migration unit test
Message-ID: <20260203101822.00eeeb0f@penguin>
In-Reply-To: <aYCz_se6Ji2g5d_L@x1.local>
References: <20260125-colo_unit_test_multifd-v3-0-ae926ccd8eae@web.de>
 <20260125-colo_unit_test_multifd-v3-6-ae926ccd8eae@web.de>
 <aXkk22x1M0k4qZoo@x1.local> <20260130112402.2c008707@penguin>
 <aYCz_se6Ji2g5d_L@x1.local>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/vKhbzVNrZIXPJ+AO9g+Q+6q";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:blanWx4CwGdM5VS8GrctZz10XDlXSxWID03AIAmrd+DW8FYvv8z
 g9IQfG5UK2sOvEzEqFVjgU4oYWdbbjXJ7jf7BjfQbYIqpsvilW16ftJhIi5UNNLrdQ/4KbP
 VQ+6QXOLsvltfTtTvzc+uzqqnXeigM60RIp4+asTEq5PVvGUHG6HWY0anVvWvRIqDzJKoOU
 F+tEFOD+7mJDDAsRSQ29w==
UI-OutboundReport: notjunk:1;M01:P0:p3rMT1gNUxw=;7MlUUtnUPTBugXcEnrBRtPP7GMN
 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
Received-SPF: pass client-ip=212.227.15.4; envelope-from=lukasstraub2@web.de;
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

--Sig_/vKhbzVNrZIXPJ+AO9g+Q+6q
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 2 Feb 2026 09:26:06 -0500
Peter Xu <peterx@redhat.com> wrote:

> On Fri, Jan 30, 2026 at 11:24:02AM +0100, Lukas Straub wrote:
> > On Tue, 27 Jan 2026 15:49:31 -0500
> > Peter Xu <peterx@redhat.com> wrote:
> >  =20
> > > On Sun, Jan 25, 2026 at 09:40:11PM +0100, Lukas Straub wrote: =20
> > > > +void migration_test_add_colo(MigrationTestEnv *env)
> > > > +{
> > > > +    if (!env->has_kvm) {
> > > > +        g_test_skip("COLO requires KVM accelerator");
> > > > +        return;
> > > > +    }   =20
> > >=20
> > > I'm OK if you want to explicitly bypass others, but could you explana=
tion
> > > why?
> > >=20
> > > Thanks,
> > >  =20
> >=20
> > It used to hang with TCG. Now it crashes, since
> > migration_bitmap_sync_precopy assumes bql is held. Something for later.=
 =20
>=20
> If we want to keep COLO around and be serious, let's try to make COLO the
> same standard we target for migration in general whenever possible.  We
> shouldn't randomly workaround bugs.  We should fix it.
>=20
> It looks to me there's some locking issue instead.
>=20
> Iterator's complete() requires BQL.  Would a patch like below makes sense
> to you?
>=20
> diff --git a/migration/colo.c b/migration/colo.c
> index db783f6fa7..b3ea137120 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -458,8 +458,8 @@ static int colo_do_checkpoint_transaction(MigrationSt=
ate *s,
>      /* Note: device state is saved into buffer */
>      ret =3D qemu_save_device_state(fb);
> =20
> -    bql_unlock();
>      if (ret < 0) {
> +        bql_unlock();
>          goto out;
>      }
> =20
> @@ -473,6 +473,9 @@ static int colo_do_checkpoint_transaction(MigrationSt=
ate *s,
>       */
>      qemu_savevm_live_state(s->to_dst_file);
> =20
> +    /* Save live state requires BQL */
> +    bql_unlock();
> +
>      qemu_fflush(fb);
> =20
>      /*

I already tested that and it works. However, we have to be very careful
around the locking here and I don't think it is safe to take the bql on
the primary here:

The secondary has the bql held at this point:

    colo_receive_check_message(mis->from_src_file,
                       COLO_MESSAGE_VMSTATE_SEND, &local_err);
    ...
    bql_lock();
    cpu_synchronize_all_states();
    ret =3D qemu_loadvm_state_main(mis->from_src_file, mis, errp);
    bql_unlock();

On the primary there is a filter-mirror mirroring incoming packets to
the secondary filter-redirector. However since the secondary migration
holds bql the receiving filter is blocked and will not receive anything
from the socket. Thus filter-mirror on the primary also may get blocked
during send and block the mainloop (It uses blocking IO).

Now if the primary migration thread wants to take the bql it will
deadlock.

So I think this is something to fix in a separate series since it is
more involved.

Regards,
Lukas Straub

>=20
> >=20
> > #6  0x00007ffff7471517 in __assert_fail
> >     (assertion=3Dassertion@entry=3D0x555555f17aee "bql_locked() !=3D lo=
cked", file=3Dfile@entry=3D0x555555f17ab0 "../system/cpus.c", line=3Dline@e=
ntry=3D535, function=3Dfunction@entry=3D0x55555609bfd0 <__PRETTY_FUNCTION__=
.9> "bql_update_status") at ./assert/assert.c:105
> > #7  0x0000555555b09f1e in bql_update_status (locked=3Dlocked@entry=3Dfa=
lse) at ../system/cpus.c:535
> > #8  0x0000555555ec60e7 in qemu_mutex_pre_unlock (mutex=3D0x555557166700=
 <bql>, file=3D0x555555efe1dc "../cpu-common.c", line=3D164) at ../util/qem=
u-thread-common.h:57
> > #9  qemu_mutex_pre_unlock (line=3D164, file=3D0x555555efe1dc "../cpu-co=
mmon.c", mutex=3D0x555557166700 <bql>) at ../util/qemu-thread-common.h:48
> > #10 qemu_cond_wait_impl (cond=3D0x5555571442c0 <qemu_work_cond>, mutex=
=3D0x555557166700 <bql>, file=3D0x555555efe1dc "../cpu-common.c", line=3D16=
4) at ../util/qemu-thread-posix.c:224
> > #11 0x000055555589e6c8 in do_run_on_cpu (cpu=3D<optimized out>, func=3D=
<optimized out>, data=3D..., mutex=3D0x555557166700 <bql>) at ../cpu-common=
.c:164
> > #12 0x0000555555b17a06 in memory_global_after_dirty_log_sync () at ../s=
ystem/memory.c:2938
> > #13 0x0000555555b55b47 in migration_bitmap_sync (rs=3D0x7fffe8001340, l=
ast_stage=3Dlast_stage@entry=3Dtrue) at ../migration/ram.c:1157
> > #14 0x0000555555b56721 in migration_bitmap_sync_precopy (last_stage=3Dl=
ast_stage@entry=3Dtrue) at ../migration/ram.c:1195
> > #15 0x0000555555b59f8a in ram_save_complete (f=3D0x5555575db620, opaque=
=3D<optimized out>) at ../migration/ram.c:3381
> > #16 0x0000555555b5e4f5 in qemu_savevm_complete (se=3Dse@entry=3D0x55555=
74c0d80, f=3Df@entry=3D0x5555575db620) at ../migration/savevm.c:1521
> > #17 0x0000555555b60437 in qemu_savevm_state_complete_precopy_iterable (=
f=3Df@entry=3D0x5555575db620, in_postcopy=3Din_postcopy@entry=3Dfalse) at .=
./migration/savevm.c:1627
> > #18 0x0000555555b60a4f in qemu_savevm_state_complete_precopy (iterable_=
only=3Dtrue, f=3D0x5555575db620) at ../migration/savevm.c:1719
> > #19 qemu_savevm_live_state (f=3D0x5555575db620) at ../migration/savevm.=
c:1855
> > #20 0x0000555555b65ed9 in colo_do_checkpoint_transaction (fb=3D<optimiz=
ed out>, bioc=3D<optimized out>, s=3D0x5555574c0070) at ../migration/colo.c=
:474
> > #21 colo_process_checkpoint (s=3D0x5555574c0070) at ../migration/colo.c=
:592
> > #22 migrate_start_colo_process (s=3D0x5555574c0070) at ../migration/col=
o.c:655
> > #23 0x0000555555b4971e in migration_iteration_finish (s=3D0x5555574c007=
0) at ../migration/migration.c:3297
> > #24 migration_thread (opaque=3Dopaque@entry=3D0x5555574c0070) at ../mig=
ration/migration.c:3584
> > #25 0x0000555555ec58c0 in qemu_thread_start (args=3D0x5555576583e0) at =
../util/qemu-thread-posix.c:393
> > #26 0x00007ffff74d2aa4 in start_thread (arg=3D<optimized out>) at ./npt=
l/pthread_create.c:447
> > #27 0x00007ffff755fc6c in clone3 () at ../sysdeps/unix/sysv/linux/x86_6=
4/clone3.S:78 =20
>=20
>=20
>=20


--Sig_/vKhbzVNrZIXPJ+AO9g+Q+6q
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmmBvV4ACgkQNasLKJxd
slh3Og//fj7Rybncw0+cQmuh5UqYnehRlz0/QhhpgLseXSgcTgpQDCdp3tbDFL8w
R7jK8qj81X2ojEHyd+veDy6rnT/fSrgYmhp84KSueUTQokcZAEy7V4tk0dBRqh9T
dCTdVyrOG4LMiaN2y6KHkTDndMJsKwqId9auejcZrzCaJzeA/46giI/aBDa1tfUX
WwA8euLoW5eGlbtdLoqJYYTyhHKa+5aeqCDM9kBgWLU7fgSfywJiliwmH5GUlCVs
9NKIpEJRRirZXc4xfqywkHYCbMDHAHZ9vGahPiIVF0kVvm6RXHVXWqhNLInwZpnX
yk83r7BYsF2DXwMTnVgrJs0ajj2m420I7D3ve1mxMaR6lcFZ0zn3AHD//ZXsbtQC
2UdzF8102x9N855yxuffmtOdcuDeblIcf25YCLdKTDqA3iIxO/oXxDaTzTf+jwAk
uhCTFdU/cnC009bTq3C5VksUQHh1comKIU7IkXUMB9QWZpCQlfvrR2nEiciXIE7W
PQKR/K7D9j56sEsZzs6mqf71gndi72+iIpckoiwEg9T8tg4vMlKyOMiuhnqcZdBf
i/lZN4vq1bSBUgSOsmSnXmnGPvTgqLFKCm3UK/JBlOvoEFXpjGDwbxbV/r4PSK3Q
ekFwGBpkb/59gNTyZvc5gnIx9D2sfVo/kLbo1iDWuLMH/eZ97x4=
=Gh4D
-----END PGP SIGNATURE-----

--Sig_/vKhbzVNrZIXPJ+AO9g+Q+6q--

