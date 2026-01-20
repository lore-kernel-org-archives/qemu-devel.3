Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23CFFD2ED0F
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 11:50:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viAEm-0000gn-Aq; Tue, 20 Jan 2026 06:49:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1viAEk-0000cg-L5
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 06:49:30 -0500
Received: from mout.web.de ([212.227.17.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1viAEi-0001gK-8w
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 06:49:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1768909759; x=1769514559; i=lukasstraub2@web.de;
 bh=Ndih9CNuO5r7FvpLCKDt2lyyedTc5GHSbWKDBYRb7lo=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=HSUG/F7G1gAT0hwBXXUXkNxvZ+bucZHPzDnzu3v9vJ9rGNu6gipoNsi7uB7wL1Hw
 WmKvU7FXpG6UUZaayfhdU4YkD0ATENaCR50Tg1fSpr/7G2IRG3ct+PHVwdbEndxO3
 y4jqo3X+gjWQIku+SkxeEqPTD1m2QZtnlKf/U2uND7hxy7t78Vy+1ZflvGv9r01/b
 UrxS5Cp90tAhyYIpJuHe1wCPq3pXuTkznK1UCd8htK8i7MykzMk2rS0BOTUqzTAUS
 6mRuyhXXihRb6dZIGHzkHHc0A9JyKtNuWgeLEbNv0+Q2InPLHUdRJ4aW+p+1rxxEO
 a+4ZLAXfSlCI6Ko1Gg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from penguin ([217.247.100.70]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N947J-1vtUTJ3SAp-00wszB; Tue, 20
 Jan 2026 12:49:18 +0100
Date: Tue, 20 Jan 2026 12:48:47 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: Peter Xu <peterx@redhat.com>
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>, qemu-devel@nongnu.org,
 Juraj Marcin <jmarcin@redhat.com>, Fabiano Rosas <farosas@suse.de>, Markus
 Armbruster <armbru@redhat.com>, "Daniel P . =?UTF-8?B?QmVycmFuZ8Op?="
 <berrange@redhat.com>, =?UTF-8?B?THVrw6HFoQ==?= Doktor
 <ldoktor@redhat.com>, Juan Quintela <quintela@trasno.org>, Zhang Chen
 <zhangckid@gmail.com>, zhanghailiang@xfusion.com, Li Zhijian
 <lizhijian@fujitsu.com>, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 1/3] migration/colo: Deprecate COLO migration framework
Message-ID: <20260120110811.7df19a6c@penguin>
In-Reply-To: <aW6xNcsz3RIqHeE5@x1.local>
References: <20260114195659.2543649-1-peterx@redhat.com>
 <20260114195659.2543649-2-peterx@redhat.com>
 <aWf4i7EOXtpAljGX@x1.local> <20260115224929.616aab85@penguin>
 <aWlso1w39cQnEh2t@x1.local> <aWlxY9TWGT1aaMJz@gallifrey>
 <aWl6ixQpHaMJhV_E@x1.local> <20260117204913.584e1829@penguin>
 <aW6xNcsz3RIqHeE5@x1.local>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/B_/DfUBmJDY1QxNSmW1.OOB";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:IHfPheg6TstUJUUxpAyQkkQu7hgf062Zm6AL5cKpd8DlK54BOgW
 z7Ptoa299uEzUE7u564RjIkjUIQHd/OXePU+2bCfac8ZemOQFLQ3YndRE/vNDq0h5rEwY2r
 fizbMACYF5F4IFyR8uT372SAdpiylbcNHwANitaEdl1hoWbfZ2RQ0j96QZoY7y3Uaxtjvo9
 BWEQU09Si99meGoMhoV/w==
UI-OutboundReport: notjunk:1;M01:P0:ZStIZwy+CPk=;6sXHwcKJMqe9RZH5D9PZGIKA+tI
 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
 dOp1uTjxHjvaEeuc6QVM
Received-SPF: pass client-ip=212.227.17.11; envelope-from=lukasstraub2@web.de;
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

--Sig_/B_/DfUBmJDY1QxNSmW1.OOB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 19 Jan 2026 17:33:25 -0500
Peter Xu <peterx@redhat.com> wrote:

> On Sat, Jan 17, 2026 at 08:49:13PM +0100, Lukas Straub wrote:
> > On Thu, 15 Jan 2026 18:38:51 -0500
> > Peter Xu <peterx@redhat.com> wrote:
> >  =20
> > > On Thu, Jan 15, 2026 at 10:59:47PM +0000, Dr. David Alan Gilbert wrot=
e: =20
> > > > * Peter Xu (peterx@redhat.com) wrote:   =20
> > > > > On Thu, Jan 15, 2026 at 10:49:29PM +0100, Lukas Straub wrote:   =
=20
> > > > > > Nack.
> > > > > >=20
> > > > > > This code has users, as explained in my other email:
> > > > > > https://lore.kernel.org/qemu-devel/20260115224516.7f0309ba@peng=
uin/T/#mc99839451d6841366619c4ec0d5af5264e2f6464   =20
> > > > >=20
> > > > > Please then rework that series and consider include the following=
 (I
> > > > > believe I pointed out a long time ago somewhere..):
> > > > >    =20
> > > >    =20
> > > > > - Some form of justification of why multifd needs to be enabled f=
or COLO.
> > > > >   For example, in your cluster deployment, using multifd can impr=
ove XXX
> > > > >   by YYY.  Please describe the use case and improvements.   =20
> > > >=20
> > > > That one is pretty easy; since COLO is regularly taking snapshots, =
the faster
> > > > the snapshoting the less overhead there is.   =20
> > >=20
> > > Thanks for chiming in, Dave.  I can explain why I want to request for=
 some
> > > numbers.
> > >=20
> > > Firstly, numbers normally proves it's used in a real system.  It's at=
 least
> > > being used and seriously tested.
> > >=20
> > > Secondly, per my very limited understanding to COLO... the two VMs in=
 most
> > > cases should be in-sync state already when both sides generate the sa=
me
> > > network packets.
> > >=20
> > > Another sync (where multifd can start to take effect) is only needed =
when
> > > there're packets misalignments, but IIUC it should be rare.  I don't =
know
> > > how rare it is, it would be good if Lukas could introduce some of tho=
se
> > > numbers in his deployment to help us understand COLO better if we'll =
need
> > > to keep it. =20
> >=20
> > It really depends on the workload and if you want to tune for
> > throughput or latency. =20
>=20
> Thanks for all the answers from all of you.
>=20
> If we decide to keep COLO, looks like I'll have no choice but understand =
it
> better, as long as it still has anything to do with migration..  I'll lea=
ve
> some more questions / comments at the end.
>=20
> >=20
> > You need to do a checkpoint eventually and the more time passes between
> > checkpoints the more dirty memory you have to transfer during the
> > checkpoint.
> >=20
> > Also keep in mind that the guest is stopped during checkpoints. Because
> > even if we continue running the guest, we can not release the mismatched
> > packets since that would expose a state of the guest to the outside
> > world that is not yet replicated to the secondary. =20
>=20
> Yes this makes sense.  However it is also the very confusing part of COLO.
>=20
> When I said "I was expecting migration to not be the hot path", one reason
> is I believe COLO checkpoint (or say, when migration happens) will
> introduce a larger downtime than normal migration, because this process
> transfers RAM with both VMs stopped.
>=20
> You helped explain why that large downtime is needed, thanks.  However th=
en
> it means either (1) packet misalignment, or (2) periodical timer kickoff,
> either of them will kickoff checkpoint..

Yes, it could be optimized so we don't stop the guest for the periodical
checkpoints.

>=20
> I don't know if COLO services care about such relatively large downtime,
> especially it is not happening once, but periodically for every tens of
> seconds at least (assuming when periodically then packet misalignment is
> rare).
>=20

If you want to tune for latency you go for like 500ms checkpoint
interval.


The alternative way to do fault tolerance is micro checkpointing where
only the primary guest runs while you buffer all sent packets. Then
every checkpoint you transfer all ram and device state to the secondary
and only then release all network packets.
So in this approach every packet is delayed by checkpoint interval +
checkpoint downtime and you use a checkpoint interval of like 30-100ms.

Obviously, COLO is a much better approach because only few packets
observe a delay.

> >=20
> > So the migration performance is actually the most important part in
> > COLO to keep the checkpoints as short as possible. =20
>=20
> IIUC when a heartbeat will be lost on PVM _during_ sync checkpoints, then
> SVM can only rollback to the last time checkpoint.  Would this be good
> enough in reality?  It means if there's a TCP transaction then it may bro=
ke
> anyway.  x-checkpoint-delay / periodic checkpoints definitely make this
> more possible to happen.

We only release the mismatched packets after the ram and device state
is fully sent to the secondary. Because then the secondary is in the
state that generated these mismatched packets and can take over.

>=20
> >=20
> > I have quite a few more performance and cleanup patches on my hands,
> > for example to transfer dirty memory between checkpoints.
> >  =20
> > >=20
> > > IIUC, the critical path of COLO shouldn't be migration on its own?  It
> > > should be when heartbeat gets lost; that normally should happen when =
two
> > > VMs are in sync.  In this path, I don't see how multifd helps..  beca=
use
> > > there's no migration happening, only the src recording what has chang=
ed.
> > > Hence I think some number with description of the measurements may he=
lp us
> > > understand how important multifd is to COLO.
> > >=20
> > > Supporting multifd will cause new COLO functions to inject into core
> > > migration code paths (even if not much..). I want to make sure such (=
new)
> > > complexity is justified. I also want to avoid introducing a feature o=
nly
> > > because "we have XXX, then let's support XXX in COLO too, maybe some =
day
> > > it'll be useful". =20
> >=20
> > What COLO needs from migration at the low level:
> >=20
> > Primary/Outgoing side:
> >=20
> > Not much actually, we just need a way to incrementally send the
> > dirtied memory and the full device state.
> > Also, we ensure that migration never actually finishes since we will
> > never do a switchover. For example we never set
> > RAMState::last_stage with COLO.
> >=20
> > Secondary/Incoming side:
> >=20
> > colo cache:
> > Since the secondary always needs to be ready to take over (even during
> > checkpointing), we can not write the received ram pages directly to
> > the guest ram to prevent having half of the old and half of the new
> > contents.
> > So we redirect the received ram pages to the colo cache. This is
> > basically a mirror of the primary side ram.
> > It also simplifies the primary side since from it's point of view it's
> > just a normal migration target. So primary side doesn't have to care
> > about dirtied pages on the secondary for example.
> >=20
> > Dirty Bitmap:
> > With COLO we also need a dirty bitmap on the incoming side to track
> > 1. pages dirtied by the secondary guest
> > 2. pages dirtied by the primary guest (incoming ram pages)
> > In the last step during the checkpointing, this bitmap is then used
> > to overwrite the guest ram with the colo cache so the secondary guest
> > is in sync with the primary guest.
> >=20
> > All this individually is very little code as you can see from my
> > multifd patch. Just something to keep in mind I guess.
> >=20
> >=20
> > At the high level we have the COLO framework outgoing and incoming
> > threads which just tell the migration code to:
> > Send all ram pages (qemu_savevm_live_state()) on the outgoing side
> > paired with a qemu_loadvm_state_main on the incoming side.
> > Send the device state (qemu_save_device_state()) paired with writing
> > that stream to a buffer on the incoming side.
> > And finally flusing the colo cache and loading the device state on the
> > incoming side.
> >=20
> > And of course we coordinate with the colo block replication and
> > colo-compare. =20
>=20
> Thank you.  Maybe you should generalize some of the explanations and put =
it
> into docs/devel/migration/ somewhere.  I think many of them are not
> mentioned in the doc on how COLO works internally.
>=20
> Let me ask some more questions while I'm reading COLO today:
>=20
> - For each of the checkpoint (colo_do_checkpoint_transaction()), COLO will
>   do the following:
>=20
>     bql_lock()
>     vm_stop_force_state(RUN_STATE_COLO)     # stop vm
>     bql_unlock()
>=20
>     ...
>  =20
>     bql_lock()
>     qemu_save_device_state()                # into a temp buffer fb
>     bql_unlock()
>=20
>     ...
>=20
>     qemu_savevm_state_complete_precopy()    # send RAM, directly to the w=
ire
>     qemu_put_buffer(fb)                     # push temp buffer fb to wire
>=20
>     ...
>=20
>     bql_lock()
>     vm_start()                              # start vm
>     bql_unlock()
>=20
>   A few questions that I didn't ask previously:
>=20
>   - If VM is stopped anyway, why putting the device states into a temp
>     buffer, instead of using what we already have for precopy phase, or
>     just push everything directly to the wire?

Actually we only do that to get the size of the device state and send
the size out-of-band, since we can not use qemu_load_device_state()
directly on the secondary side and look for the in-band EOF.

>=20
>   - Above operation frequently releases BQL, why is it needed?  What
>     happens if (within the window where BQL released) someone invoked QMP
>     command "cont" and causing VM to start? Would COLO be broken with it?
>     Should we take BQL for the whole process to avoid it?

We need to release the BQL because block replication on the secondary side =
and
colo-compare and netfilters on the primary side need the main loop to
make progress.

Issuing a cont during a checkpoint will probably break it yes.

>=20
> - Does colo_cache has an limitation, or should we expect SVM to double
>   consume the guest RAM size?  As I didn't see where colo_cache will be
>   released during each sync (e.g. after colo_flush_ram_cache).  I am
>   expecting over time SVM will have most of the pages touched, then the
>   colo_cache can consume the same as guest mem on SVM.

Yes, the secondary side consumes twice the guest ram size. That is one
disadvantage of this approach.

I guess we could do some kind of copy on write mapping for the
secondary guest ram. But even then it's hard to make the ram overhead
bounded in size.

Best regards,
Lukas Straub

>=20
> Thanks,
>=20


--Sig_/B_/DfUBmJDY1QxNSmW1.OOB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmlva58ACgkQNasLKJxd
slgPAA//dZACRnz8Hg+XYnB9k68vTqH3zekY3DiBxIh4v7u9+iAjV2yrlgsz7hxR
JWQH0zZhRQ+cmGKRutkPvaCu2kyA4d2VC+Wn9LURjytMkheJq6duwHkwUwFM2uOi
/la10nYLVFVT27F96ox933sos/EFQqKFOPmaO8DmOOro6R6xaoaid4ney31VvVwO
08OLj6oLI7K2N4saScRTyb+SwOZwxu9vBcV554l//IK9dp3fgRGJmAVZ9GZ30+K5
977/KgvdjHO7czkFNwGEj3C8xZz/2KEzpD5B7H5gTGnPrhpKKVgdR/k5DAwgIn3F
NmIL2DNroxabm/8NbFWdWjtgNsfXtVD454GtETN7WhBRhyC6SsjIXE5HcAk/zXLl
1CDqIXAOf0Pl1Nr9CFqxLTfYmTC1ymLFNoU12Ho+DunqQnG57to92hwPcBEuIZdM
9g4tQknEa9CZsPWIGZoP3DoaLjfSG2b79Fozq4pHqqLYHoXHfVFBRoP0EEDhzI3e
Mf13ftg92QHiKsz49FgUdhl0xsDHiRfEwP8H0ZjRdiJWkVlZHUaGYeNQrQ0NVXtz
pOMNVwVNvH9l/WzkOCdVn6K42Wxl+KFhNuijnj6GWFhcV0ofNsSC7I+i7FIjGVQN
0QVypOLREQ8AjE4UWl5dqQDp6MXmM2s8c7+yEMfNqioQZ38/q7M=
=PPQ6
-----END PGP SIGNATURE-----

--Sig_/B_/DfUBmJDY1QxNSmW1.OOB--

