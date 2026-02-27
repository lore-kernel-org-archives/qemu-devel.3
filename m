Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEBB6FEFB72
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 18:00:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw28M-0004gy-Qx; Fri, 27 Feb 2026 13:00:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vw28D-0004ew-9L
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 13:00:08 -0500
Received: from mout.web.de ([212.227.17.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vw288-0001xX-QB
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 13:00:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772215181; x=1772819981; i=lukasstraub2@web.de;
 bh=hMXcQ6aba4DoG4a428WyZJsz4uml/mutwv8Q5sSNZnc=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=oxlgemN3EfymkWIiEFQoMPBUqFbjDYn9+7mIAx+U/RZBkQV3RCgwMaT39f/8kJ6U
 wyg2bJMJhQ/w7Ac7Sehy3qwsuk9vpD1LR96579gBRWQFKw8qbzk4xuFSFm3mZ9Ho7
 JIZCkXZiPy/8R59JrxCfTJ3vEKYfBRwLJLbMv1RGa42wD0NxY3h2/WaJTzInyyrfv
 dofqMjNJkqzUjYuQFfSFtDSAWfr4t1J/1MzdLN1XKmBlxNSOX8zxC9WYNw0uf4W66
 sT/xrwOfyIY03sWCmvas1YWy95tTXqr0XcXYWyntp7KUfLhP4ragq5fPFs+DAOoHB
 F+P9z28gCd4Qk31E2Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MzTLO-1vibue3b5U-00rA7v; Fri, 27
 Feb 2026 18:59:41 +0100
Date: Fri, 27 Feb 2026 18:59:14 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Zhang Chen
 <zhangckid@gmail.com>, Hailiang Zhang <zhanghailiang@xfusion.com>, Markus
 Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, "Dr.
 David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH v10 19/19] migration: Always open
 s->rp_state.from_dst_file on the source
Message-ID: <20260227185914.4fd05c0b@penguin>
In-Reply-To: <aaHSypDPWTn8WXNv@x1.local>
References: <20260220-colo_unit_test_multifd-v10-0-bfe67d422ef1@web.de>
 <20260220-colo_unit_test_multifd-v10-19-bfe67d422ef1@web.de>
 <aaBrc4bMxUHhgpH8@x1.local> <20260227124903.241af498@penguin>
 <aaHSypDPWTn8WXNv@x1.local>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/4pzGy/EtRTm=osdrAUp1T2K";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:YfOhA/mOsvJ8LbUhRPpXg/On74mXUitZvBenMcc5GNTwsrDurZ/
 jBzHw/pqRVugWPN211sOCnRUBHPkro+I3I87DqA9vXGGZbVn8agt0YMhBwyuWqhYiK/0v77
 NUeGuLLjM+/jn5+Ykn42/Pwdi033Gv5zT3l34LOtDst5BMOGSIfW5+KuGHsvzFNmj81IVgQ
 uHqX6DnKiCoftOCp7E88g==
UI-OutboundReport: notjunk:1;M01:P0:R4GMSCCddbo=;LEiAf2AOSgUcvcv8qJDDuk3KpV6
 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
 RjX2feIaa0c95CeyV1GL6Evqv7iB+Ma6A==
Received-SPF: pass client-ip=212.227.17.12; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.706, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.401,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--Sig_/4pzGy/EtRTm=osdrAUp1T2K
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 27 Feb 2026 12:22:18 -0500
Peter Xu <peterx@redhat.com> wrote:

> On Fri, Feb 27, 2026 at 12:49:03PM +0100, Lukas Straub wrote:
> > On Thu, 26 Feb 2026 10:49:07 -0500
> > Peter Xu <peterx@redhat.com> wrote:
> >  =20
> > > On Fri, Feb 20, 2026 at 08:51:41PM +0100, Lukas Straub wrote: =20
> > > > qemu_file_get_return_path() can not fail (See also commit 3f9d6e77b)
> > > > so always open the return path socket on the source. This allows
> > > > us to reuse the return path in other parts like colo. Also take
> > > > the proper locks in colo while we're at it.
> > > >=20
> > > > This fixes a crash due to a race between migrate_cancel() and
> > > > the colo thread shutting down.
> > > >=20
> > > > Before, the rp socket is opened just before the rp thread is started
> > > > and closed after it terminates and postcopy fast path is closed.
> > > > Now it's the same, only the rp socket stays open until migration_cl=
eanup().
> > > >=20
> > > > If there is a rp thread, the rp socket is shut down at the end of m=
igration,
> > > > but the file is still open. COLO is not compatible with postcopy, s=
o this is
> > > > safe as no one else uses the rp socket after this point.
> > > >=20
> > > > Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> > > > ---
> > > >  migration/colo.c      | 29 ++++++-------------
> > > >  migration/migration.c | 77 ++++++++++++++++++++++++---------------=
------------
> > > >  2 files changed, 44 insertions(+), 62 deletions(-)
> > > >=20
> > > > diff --git a/migration/colo.c b/migration/colo.c
> > > > index ce02c71d8857d470be434bdf3a9cacad3baab0d5..0dee33f1145b81af276=
cf318e2984deae9ae0527 100644
> > > > --- a/migration/colo.c
> > > > +++ b/migration/colo.c
> > > > @@ -173,11 +173,13 @@ static void primary_vm_do_failover(void)
> > > >       * The s->rp_state.from_dst_file and s->to_dst_file may use the
> > > >       * same fd, but we still shutdown the fd for twice, it is harm=
less.
> > > >       */
> > > > -    if (s->to_dst_file) {
> > > > -        qemu_file_shutdown(s->to_dst_file);
> > > > -    }
> > > > -    if (s->rp_state.from_dst_file) {
> > > > -        qemu_file_shutdown(s->rp_state.from_dst_file);
> > > > +    WITH_QEMU_LOCK_GUARD(&s->qemu_file_lock) {
> > > > +        if (s->to_dst_file) {
> > > > +            qemu_file_shutdown(s->to_dst_file);
> > > > +        }
> > > > +        if (s->rp_state.from_dst_file) {
> > > > +            qemu_file_shutdown(s->rp_state.from_dst_file);
> > > > +        }   =20
> > >=20
> > > Nit: these "start to take mutex for..." changes should belong to a se=
parate
> > > patch.
> > >  =20
> >=20
> > Will do.
> >  =20
> > > >      }
> > > > =20
> > > >      old_state =3D failover_set_state(FAILOVER_STATUS_ACTIVE,
> > > > @@ -537,6 +539,7 @@ static void colo_process_checkpoint(MigrationSt=
ate *s)
> > > >      Error *local_err =3D NULL;
> > > >      int ret;
> > > > =20
> > > > +    assert(s->rp_state.from_dst_file);
> > > >      if (get_colo_mode() !=3D COLO_MODE_PRIMARY) {
> > > >          error_report("COLO mode must be COLO_MODE_PRIMARY");
> > > >          return;
> > > > @@ -544,12 +547,6 @@ static void colo_process_checkpoint(MigrationS=
tate *s)
> > > > =20
> > > >      failover_init_state();
> > > > =20
> > > > -    s->rp_state.from_dst_file =3D qemu_file_get_return_path(s->to_=
dst_file);
> > > > -    if (!s->rp_state.from_dst_file) {
> > > > -        error_report("Open QEMUFile from_dst_file failed");
> > > > -        goto out;
> > > > -    }
> > > > -
> > > >      packets_compare_notifier.notify =3D colo_compare_notify_checkp=
oint;
> > > >      colo_compare_register_notifier(&packets_compare_notifier);
> > > > =20
> > > > @@ -634,16 +631,6 @@ out:
> > > >      colo_compare_unregister_notifier(&packets_compare_notifier);
> > > >      timer_free(s->colo_delay_timer);
> > > >      qemu_event_destroy(&s->colo_checkpoint_event);
> > > > -
> > > > -    /*
> > > > -     * Must be called after failover BH is completed,
> > > > -     * Or the failover BH may shutdown the wrong fd that
> > > > -     * re-used by other threads after we release here.
> > > > -     */
> > > > -    if (s->rp_state.from_dst_file) {
> > > > -        qemu_fclose(s->rp_state.from_dst_file);
> > > > -        s->rp_state.from_dst_file =3D NULL;
> > > > -    }
> > > >  }
> > > > =20
> > > >  void migrate_start_colo_process(MigrationState *s)
> > > > diff --git a/migration/migration.c b/migration/migration.c
> > > > index f36d42ef657bdf26d78ca642d77a9b76e1c0c174..8caa56940beef12de33=
a799695cf486c8fbd471c 100644
> > > > --- a/migration/migration.c
> > > > +++ b/migration/migration.c
> > > > @@ -97,7 +97,7 @@ static GSList *migration_blockers[MIG_MODE__MAX];
> > > > =20
> > > >  static bool migration_object_check(MigrationState *ms, Error **err=
p);
> > > >  static bool migration_switchover_start(MigrationState *s, Error **=
errp);
> > > > -static bool close_return_path_on_source(MigrationState *s);
> > > > +static bool stop_return_path_thread_on_source(MigrationState *s);
> > > >  static void migration_completion_end(MigrationState *s);
> > > > =20
> > > >  static void migration_downtime_start(MigrationState *s)
> > > > @@ -1278,7 +1278,7 @@ static void migration_cleanup(MigrationState =
*s)
> > > >      cpr_state_close();
> > > >      cpr_transfer_source_destroy(s);
> > > > =20
> > > > -    close_return_path_on_source(s);
> > > > +    stop_return_path_thread_on_source(s);
> > > > =20
> > > >      if (s->migration_thread_running) {
> > > >          bql_unlock();
> > > > @@ -1307,6 +1307,14 @@ static void migration_cleanup(MigrationState=
 *s)
> > > >          qemu_fclose(tmp);
> > > >      }
> > > > =20
> > > > +    WITH_QEMU_LOCK_GUARD(&s->qemu_file_lock) {
> > > > +        tmp =3D s->rp_state.from_dst_file;
> > > > +        s->rp_state.from_dst_file =3D NULL;
> > > > +    }
> > > > +    if (tmp) {
> > > > +        qemu_fclose(tmp);
> > > > +    }
> > > > +
> > > >      assert(!migration_is_active());
> > > > =20
> > > >      if (s->state =3D=3D MIGRATION_STATUS_CANCELLING) {
> > > > @@ -2187,38 +2195,6 @@ static bool migrate_handle_rp_resume_ack(Mig=
rationState *s,
> > > >      return true;
> > > >  }
> > > > =20
> > > > -/*
> > > > - * Release ms->rp_state.from_dst_file (and postcopy_qemufile_src if
> > > > - * existed) in a safe way.
> > > > - */
> > > > -static void migration_release_dst_files(MigrationState *ms)
> > > > -{
> > > > -    QEMUFile *file =3D NULL;
> > > > -
> > > > -    WITH_QEMU_LOCK_GUARD(&ms->qemu_file_lock) {
> > > > -        /*
> > > > -         * Reset the from_dst_file pointer first before releasing =
it, as we
> > > > -         * can't block within lock section
> > > > -         */
> > > > -        file =3D ms->rp_state.from_dst_file;
> > > > -        ms->rp_state.from_dst_file =3D NULL;
> > > > -    }
> > > > -
> > > > -    /*
> > > > -     * Do the same to postcopy fast path socket too if there is.  =
No
> > > > -     * locking needed because this qemufile should only be managed=
 by
> > > > -     * return path thread.
> > > > -     */
> > > > -    if (ms->postcopy_qemufile_src) {
> > > > -        migration_ioc_unregister_yank_from_file(ms->postcopy_qemuf=
ile_src);
> > > > -        qemu_file_shutdown(ms->postcopy_qemufile_src);
> > > > -        qemu_fclose(ms->postcopy_qemufile_src);
> > > > -        ms->postcopy_qemufile_src =3D NULL;
> > > > -    }
> > > > -
> > > > -    qemu_fclose(file);
> > > > -}
> > > > -
> > > >  /*
> > > >   * Handles messages sent on the return path towards the source VM
> > > >   *
> > > > @@ -2388,9 +2364,9 @@ out:
> > > >      return NULL;
> > > >  }
> > > > =20
> > > > -static void open_return_path_on_source(MigrationState *ms)
> > > > +static void start_return_path_thread_on_source(MigrationState *ms)=
   =20
> > >=20
> > > Changing this seems OK, but I'm totally confused why you deleted
> > > migration_release_dst_files().  That's the helper to properly close t=
he two
> > > possible qemufiles that rp thread uses. =20
> >=20
> > Okay, so my reasoning here is:
> > I think that closing ms->postcopy_qemufile_src is very closely
> > related to cleaning up the rp thread so I moved that to
> > stop_return_path_thread_on_source(). =20
>=20
> Hmm OK, I had that feeling you wanted to move all qemufile cleanups into
> the cleanup function.
>=20
> Actually I think that may still be easier for you, e.g. you can at least
> reuse the migration_release_dst_files().  I don't see much benefit yet on
> open code the preempt qemufiles..
>=20
> >=20
> > Meanwhile I think s->rp_state.from_dst_file is more closely related to
> > s->to_dst_file and in fact I think we can remove s->rp_state.from_dst_f=
ile
> > entirely in the future and use s->to_dst_file for send *and* receive
> > just like you would with a normal socket.
> >=20
> > So I close s->rp_state.from_dst_file right besides s->to_dst_file in
> > this patch. And I do the same open-coded file lock dance like
> > s->to_dst_file already does. =20
>=20
> Let's not do open coded things.  That makes things worse.
>=20
> If you also agree we can cleanup qemufile alawys only until migration
> cleanup then we can stick with it for now.
>=20
> >  =20
> > > IIUC you can keep it then use it
> > > in either postcopy_pause() or migration_cleanup() directly. =20
> >=20
> > I can do that if you wish.
> > Should I keep closing ms->postcopy_qemufile_src inside
> > migration_release_dst_files() or stop_return_path_thread_on_source() ? =
=20
>=20
> If you use migration_release_dst_files() in both (1) postcopy pause and (=
2)
> migration cleanup, IIUC we should covered all cases.  But please double
> check.

Even better idea: Add a helper that closes s->to_dst_file and s->rp_state.f=
rom_dst_file
and use that in postcopy pause and migration cleanup.

What do you think?

> >  =20
> > >=20
> > > Then you need to remove the chunk [1] below, making the function only=
 do
> > > "stop" but not close.
> > >  =20
> > > >  {
> > > > -    ms->rp_state.from_dst_file =3D qemu_file_get_return_path(ms->t=
o_dst_file);
> > > > +    assert(ms->rp_state.from_dst_file);   =20
> > >=20
> > > I don't see why this change is a must, to open from_dst_file earlier.=
  Can
> > > we keep it as before, or would you justify it in a separate patch? =20
> >=20
> > Well, the issue is that opening the return path file is behind this if:
> >=20
> >  if (migrate_postcopy_ram() || migrate_return_path()) {
> > -        open_return_path_on_source(s);
> > +        start_return_path_thread_on_source(s);
> >  }
> >=20
> > And I want to always open the return path file, without also starting
> > the return path thread. =20
>=20
> I never notice this small difference.. then logically COLO should just
> depend on return-path capability.
>=20
> IIUC the simplest for your series to move on is:
>=20
>   - If COLO always require return-path (I hope you know the best... e.g. =
do
>     you enable return-path cap for your colo deployment?), we can add that
>     enforcement in migrate_caps_check().  It's an ABI break only to COLO,
>     but if you're OK, I don't see it an issue.
>=20
>   - Just add one more condition above into:
>=20
>   if (migrate_postcopy_ram() || migrate_return_path() || migrate_colo()) {
>           open_return_path_on_source(s);
>   }
>=20
>   Instead of making rp complicated; after all many places assume rp thread
>   is there when rp qemufile is there, vice versa.  Changing that needs mo=
re
>   monitoring of code base, IMHO.  Better stick with it to be simple.

That doesn't work either, because now you have the rp thread running
and to stop the thread we
qemu_file_shutdown(ms->rp_state.from_dst_file).
And we're back to square one because we can't reuse the shut
s->rp_state.from_dst_file in colo.

In fact looking at the code, qemu_file_shutdown() shuts both
ms->rp_state.from_dst_file *and* s->to_dst_file because
it calls qio_channel_shutdown(f->ioc, QIO_CHANNEL_SHUTDOWN_BOTH) and
f->ioc is the same io channel for both files.

So after stop_return_path_thread_on_source() our connection the the
secondary is severed. That's now workable.

>=20
> >  =20
> > >  =20
> > > > =20
> > > >      trace_open_return_path_on_source();
> > > > =20
> > > > @@ -2402,7 +2378,7 @@ static void open_return_path_on_source(Migrat=
ionState *ms)
> > > >  }
> > > > =20
> > > >  /* Return true if error detected, or false otherwise */
> > > > -static bool close_return_path_on_source(MigrationState *ms)
> > > > +static bool stop_return_path_thread_on_source(MigrationState *ms)
> > > >  {
> > > >      if (!ms->rp_state.rp_thread_created) {
> > > >          return false;
> > > > @@ -2424,7 +2400,17 @@ static bool close_return_path_on_source(Migr=
ationState *ms)
> > > > =20
> > > >      qemu_thread_join(&ms->rp_state.rp_thread);
> > > >      ms->rp_state.rp_thread_created =3D false;
> > > > -    migration_release_dst_files(ms);
> > > > +    /*
> > > > +     * Close the postcopy fast path socket if there is one.
> > > > +     * No locking needed because this qemufile should only be mana=
ged by
> > > > +     * return path thread which we just stopped.
> > > > +     */
> > > > +    if (ms->postcopy_qemufile_src) {
> > > > +        migration_ioc_unregister_yank_from_file(ms->postcopy_qemuf=
ile_src);
> > > > +        qemu_file_shutdown(ms->postcopy_qemufile_src);
> > > > +        qemu_fclose(ms->postcopy_qemufile_src);
> > > > +        ms->postcopy_qemufile_src =3D NULL;
> > > > +    }   =20
> > >=20
> > > [1]
> > >  =20
> > > >      trace_migration_return_path_end_after();
> > > > =20
> > > >      /* Return path will persist the error in MigrationState when q=
uit */
> > > > @@ -2787,7 +2773,7 @@ static void migration_completion(MigrationSta=
te *s)
> > > >          goto fail;
> > > >      }
> > > > =20
> > > > -    if (close_return_path_on_source(s)) {
> > > > +    if (stop_return_path_thread_on_source(s)) {
> > > >          goto fail;
> > > >      }
> > > > =20
> > > > @@ -2941,7 +2927,15 @@ static MigThrError postcopy_pause(MigrationS=
tate *s)
> > > >           * path and just wait for the thread to finish. It will be
> > > >           * re-created when we resume.
> > > >           */
> > > > -        close_return_path_on_source(s);
> > > > +        stop_return_path_thread_on_source(s);
> > > > +        QEMUFile *rp_file;
> > > > +        WITH_QEMU_LOCK_GUARD(&s->qemu_file_lock) {
> > > > +            rp_file =3D s->rp_state.from_dst_file;
> > > > +            s->rp_state.from_dst_file =3D NULL;
> > > > +        }
> > > > +        if (rp_file) {
> > > > +            qemu_fclose(rp_file);
> > > > +        }   =20
> > >=20
> > > Open-code this is going backwards.  Please see if we can reuse
> > > migration_release_dst_files() at least.
> > >=20
> > > Thanks,
> > >  =20
> > > > =20
> > > >          /*
> > > >           * Current channel is possibly broken. Release it.  Note t=
hat this is
> > > > @@ -3758,6 +3752,7 @@ void migration_start_outgoing(MigrationState =
*s)
> > > >      if (!qemu_file_set_blocking(s->to_dst_file, true, &local_err))=
 {
> > > >          goto fail;
> > > >      }
> > > > +    s->rp_state.from_dst_file =3D qemu_file_get_return_path(s->to_=
dst_file);
> > > > =20
> > > >      /*
> > > >       * Open the return path. For postcopy, it is used exclusively.=
 For
> > > > @@ -3765,7 +3760,7 @@ void migration_start_outgoing(MigrationState =
*s)
> > > >       * QEMU uses the return path.
> > > >       */
> > > >      if (migrate_postcopy_ram() || migrate_return_path()) {
> > > > -        open_return_path_on_source(s);
> > > > +        start_return_path_thread_on_source(s);
> > > >      }
> > > >
> > > >
> > > > =20
> > > >      /*
> > > >=20
> > > > --=20
> > > > 2.39.5
> > > >    =20
> > >  =20
> >  =20
>=20
>=20
>=20


--Sig_/4pzGy/EtRTm=osdrAUp1T2K
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmmh23IACgkQNasLKJxd
sljLLBAAhW1xgFyL+dd21D9MED7sKk1l+n0YD3bBPtnjgEk8E0GC6HdZCYJIFa8B
gAKG2ESlCVXqEqYwQL3iWgX/bVGjnD9Ac0zF/K8bAjlQ7cmmgSYx/WewcA2zExO4
b399VYwxA7y897RGMdp1y9h5t9Pgi5Qb9d8sYm/rO6jhWVjqbV/5rALu4PUX81VJ
UWtItdxYnmABS4bws3kUx5urNWKMwjyrsZVd41poKRHvOZnCHvXVW/kNW8FrBdTs
uOGI7VRq4HiPlhNB660yEewRUPpajLoHwRgdLR43OfN4T80UFZr5dji18wqHp3fx
Wk6j0l8SvtRqzpvBQxIt2496vO7v9KhsrFdGK7bAzNxQNlImEgo9N5s1hI0178X8
j75dFDE8umQgQLGgI7meeZUDpdsqWRaD1gQ+G/KFDbCPl0fZT2XPiL8qur1xWJec
R4nTDFpJ3AbDfcrtpjZAfjF7030d8Dbz+aXer/mzGGhPYthwAEmCU+rkLtGkeniU
h5MdxJ4rRxMFRnjwXPX8N4IHEzhpFtaPk1LUp1vXBjO4961G6EcUGD0SAbyxm1do
aPzjDpsleUmw8CmZzPbpB69M90bkoIo0nmw2Jipadsk2fcSrpuoi2T8BbZa+3qse
OWNGw8jx5WTZxvD0Pii69IWbY2dKTCvBKG7ichfYse2LwK4b3aA=
=BLpn
-----END PGP SIGNATURE-----

--Sig_/4pzGy/EtRTm=osdrAUp1T2K--

