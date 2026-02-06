Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3718EE6B46
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 19:12:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voRFF-0008Ku-Qg; Fri, 06 Feb 2026 14:11:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1voRFD-0008KS-Q9
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 14:11:55 -0500
Received: from mout.web.de ([212.227.15.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1voRFB-0006Dv-HW
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 14:11:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1770405094; x=1771009894; i=lukasstraub2@web.de;
 bh=rrH4QZ9RWxkgqyN8X8QG02m4sR9ExyKSA3HvxBPkN2g=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=UVdzzBoAuKe8+eRC/AriDjz0gsEAR4jL8ZxBudfCTH+gKSy/mX/5tg8aW5wFEy5w
 vPI2LYGBgKfnoN8j4Sja30OK/wGP8E/vRvZ9kH6HlZze5D97oubE72/AQtuU4bsco
 jmcTpAHYuqoF237mfU1jkep7R4llnGVkDgRLalj/yog5HgqN+RZo7kkRWHOmxue7I
 dvoKIdgEOMvV6pZXw2AjYnvt8W32GTrw0av3ev0515Shg0nlzeLOGmP5VU4DgQmwV
 fcZ/CkSPTDiOSYm2Zu9GCkzEws8vX5s5eJU3hHScwpA/4Bo5pwfZ+aK1O8X/2vfzw
 XFtGv5mSVy006HOmNg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from penguin ([217.247.97.172]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MiuSe-1vIejC1miq-00l8kU; Fri, 06
 Feb 2026 20:11:34 +0100
Date: Fri, 6 Feb 2026 20:11:22 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Zhang Chen
 <zhangckid@gmail.com>, Hailiang Zhang <zhanghailiang@xfusion.com>, Markus
 Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, "Dr.
 David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH v3 06/10] migration-test: Add COLO migration unit test
Message-ID: <20260206201050.6a692a34@penguin>
In-Reply-To: <aYJmwfQgw0dD7CjD@x1.local>
References: <20260125-colo_unit_test_multifd-v3-0-ae926ccd8eae@web.de>
 <20260125-colo_unit_test_multifd-v3-6-ae926ccd8eae@web.de>
 <aXkk22x1M0k4qZoo@x1.local> <20260130112402.2c008707@penguin>
 <aYCz_se6Ji2g5d_L@x1.local> <20260203101822.00eeeb0f@penguin>
 <aYJmwfQgw0dD7CjD@x1.local>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/pRKHPt6bwII8dqQItSJ3kB7";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:wEC12vuYgJZuqSpDCq5N1C+wc9zm65NeonSK41AOanePBpLiaFk
 Lga8tRa4iy3toyKaf46CXWOGQX3pLLPBF1lwr9qYIQBWXe6yYHql5KWwoR9Gr3N2UmjG5Xj
 ivSlL3aHU16g+hEemoGDqvLbMwdtA01cqHviITqjd0ve1G6DAWG6dNwdA2c7XqPOZQBtKII
 8SvurdBI06DM5oGgp1vwg==
UI-OutboundReport: notjunk:1;M01:P0:ShJA9ahPq0A=;65tAvyO2YY5xOkeF2FtCNj0NVN2
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

--Sig_/pRKHPt6bwII8dqQItSJ3kB7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 3 Feb 2026 16:21:05 -0500
Peter Xu <peterx@redhat.com> wrote:

> On Tue, Feb 03, 2026 at 10:18:22AM +0100, Lukas Straub wrote:
> > On Mon, 2 Feb 2026 09:26:06 -0500
> > Peter Xu <peterx@redhat.com> wrote:
> >  =20
> > > On Fri, Jan 30, 2026 at 11:24:02AM +0100, Lukas Straub wrote: =20
> > > > On Tue, 27 Jan 2026 15:49:31 -0500
> > > > Peter Xu <peterx@redhat.com> wrote:
> > > >    =20
> > > > > On Sun, Jan 25, 2026 at 09:40:11PM +0100, Lukas Straub wrote:   =
=20
> > > > > > +void migration_test_add_colo(MigrationTestEnv *env)
> > > > > > +{
> > > > > > +    if (!env->has_kvm) {
> > > > > > +        g_test_skip("COLO requires KVM accelerator");
> > > > > > +        return;
> > > > > > +    }     =20
> > > > >=20
> > > > > I'm OK if you want to explicitly bypass others, but could you exp=
lanation
> > > > > why?
> > > > >=20
> > > > > Thanks,
> > > > >    =20
> > > >=20
> > > > It used to hang with TCG. Now it crashes, since
> > > > migration_bitmap_sync_precopy assumes bql is held. Something for la=
ter.   =20
> > >=20
> > > If we want to keep COLO around and be serious, let's try to make COLO=
 the
> > > same standard we target for migration in general whenever possible.  =
We
> > > shouldn't randomly workaround bugs.  We should fix it.
> > >=20
> > > It looks to me there's some locking issue instead.
> > >=20
> > > Iterator's complete() requires BQL.  Would a patch like below makes s=
ense
> > > to you?
> > >=20
> > > diff --git a/migration/colo.c b/migration/colo.c
> > > index db783f6fa7..b3ea137120 100644
> > > --- a/migration/colo.c
> > > +++ b/migration/colo.c
> > > @@ -458,8 +458,8 @@ static int colo_do_checkpoint_transaction(Migrati=
onState *s,
> > >      /* Note: device state is saved into buffer */
> > >      ret =3D qemu_save_device_state(fb);
> > > =20
> > > -    bql_unlock();
> > >      if (ret < 0) {
> > > +        bql_unlock();
> > >          goto out;
> > >      }
> > > =20
> > > @@ -473,6 +473,9 @@ static int colo_do_checkpoint_transaction(Migrati=
onState *s,
> > >       */
> > >      qemu_savevm_live_state(s->to_dst_file);
> > > =20
> > > +    /* Save live state requires BQL */
> > > +    bql_unlock();
> > > +
> > >      qemu_fflush(fb);
> > > =20
> > >      /* =20
> >=20
> > I already tested that and it works. However, we have to be very careful
> > around the locking here and I don't think it is safe to take the bql on
> > the primary here:
> >=20
> > The secondary has the bql held at this point: =20
>=20
> This is definitely an interesting piece of code... one question:
>=20
> >=20
> >     colo_receive_check_message(mis->from_src_file,
> >                        COLO_MESSAGE_VMSTATE_SEND, &local_err);
> >     ...
> >     bql_lock();
> >     cpu_synchronize_all_states(); =20
>=20
> Why this is needed at all? ^^^^^^^^^^^^^^^
>=20
> The qemu_loadvm_state_main() line right below should only load RAM.  I
> don't see how it has anything to do with CPU register states..

You are right we don't need this and the lock is needed here. Then I'm
fine with removing the lock here and adding one on the primary side.

>=20
> >     ret =3D qemu_loadvm_state_main(mis->from_src_file, mis, errp);
> >     bql_unlock();
> >=20
> > On the primary there is a filter-mirror mirroring incoming packets to
> > the secondary filter-redirector. However since the secondary migration
> > holds bql the receiving filter is blocked and will not receive anything
> > from the socket. Thus filter-mirror on the primary also may get blocked
> > during send and block the mainloop (It uses blocking IO). =20
>=20
> Hmm... could you explain why a blocking IO operation to mirror some packe=
ts
> require holding BQL?  This sounds wrong on its own.

Yes there is no need for the BQL, it just is wrong. The tap fd gets a
POLLIN event, main loop takes BQL and calls the tap fd callback. Tap
reads a packet from the fd and calls qemu_send_packet_async() which
puts it through the net-filters and filter-mirror does a blocking send,
blocking the main loop while BQL is held.

>=20
> >=20
> > Now if the primary migration thread wants to take the bql it will
> > deadlock.
> >=20
> > So I think this is something to fix in a separate series since it is
> > more involved. =20
>=20
> Yes it might be involved, but this is really not something like "let's ma=
ke
> it simple for now and improve it later".  This is "OK this function
> _requires_ this lock, but let's not take this lock and leave it for
> later".  It's not something we can put aside, afaiu.  We should really fix
> it..
>=20
> How far do you think we can fix it?  Could you explain the problem better?
>=20
> It might be helpful if you can reproduce the hang, then attach the logs
> from both QEMU on a full thread backtrace dump.  I'll see what I can help.
>=20
> Thanks,
>=20


--Sig_/pRKHPt6bwII8dqQItSJ3kB7
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmmGPNoACgkQNasLKJxd
slgOShAAuVC34HFevlr+aAJlveUXk1woTNn1B3dvF2gd/Rl67yxyDuYxiEIad7Dh
GQGUMMLY6gpkvnOeE2L7/Jb1NMB4LG/M47WlhZFgDryLNbFEQTPZR5UUoYRXx/s9
3f8xLUwAAR/dx3ixyxGGEPyH67GJb1p5tWz46F1c1n8r8E54ZyNUgGHtF3giGnZe
K4Ya4QW5z+lTsUT3FDyceejbbuqCeNoP03k4HD4JWIijJXraAKQbjpkVP/SUKlkA
C63r8n8inlAkEFrEoatT9JVkv6a0w6yWsJ9NPa/ltvac9EM3xpbf6aex27V4R5G0
V3pgel35hgFH9ADbbiRDbvKHD7dX+dBB87VebBDzs7UBJW/NTQjgKJyFpqTkjlQ8
IsPMtjdvjfEd4DYtEFQ3ltG3n8fn6tZIrbzpIr49OSzfsob1dGnvgKgs2HtEuynv
CPoSWpPj/wdiQA8Xsjm1b3wlv/QNNZiD16HazB0NXmB2/H6qemFeOhisFZlG8KUJ
kEX9jEtfWEmEiD41sQAxy4X+5QcZjZWOriL78Jbx+phGzqlhNfW56Hk40U88igyb
kDOvHE3bIODbWNI19fPfbi+u1ULrNmj4MgUkaY4l1MV4XfuASwfhV6h5VvxgHQCy
8kcQg2kLetAQpnOR9eePvgI7YrIk10OTFoPqYbWh+31ummmBvwo=
=jt9r
-----END PGP SIGNATURE-----

--Sig_/pRKHPt6bwII8dqQItSJ3kB7--

