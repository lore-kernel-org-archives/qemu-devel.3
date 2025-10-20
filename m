Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0C2CCCD1A5
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 22:10:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAy4a-0006OJ-V4; Mon, 20 Oct 2025 18:09:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vAy4X-0006O2-Jd
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 18:09:46 -0400
Received: from mout.web.de ([212.227.15.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vAy4U-0005xJ-VT
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 18:09:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1760998146; x=1761602946; i=lukasstraub2@web.de;
 bh=VShnix6M8A6XEvBuQ2H+7cYpoDhf4fXdCSt3DQJB4XA=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=OryzaIC2bPgxkfinTkAezsd0HvVN2/yO5FsvfMhZiSqjPrd4JNsUDswFgJwpbE4r
 41LyInw1AMK4j+PM+6LbvnqNG+dFxhLDS9kKTMQZIqXtZZs0c6L6EdGgvxD/UFsRm
 lmOgUuwKpsxUQfMOJZpddKW+pUiIDbZq8WI1R9UAo7mnXjpK30i9yIeCgoSkoBSrE
 IR6SFdEG3dCb5vIiNFEXXi02ZxQ91fQQFxyeuOqIMb6v8G5j6HTygGP7F10pzA8Y/
 OnCMgCAD8ey7MTm7AFTyTKcsRFq3VE6sPIalvrW38LmtmNCkmmsG1XCMVN159//xJ
 JbPuY1+07GWwiKcvRw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from penguin ([84.133.46.123]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N5ljL-1u8mbZ0TZD-00uJcm; Tue, 21
 Oct 2025 00:09:06 +0200
Date: Tue, 21 Oct 2025 00:08:54 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: Peter Xu <peterx@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>, Hailiang Zhang
 <zhanghailiang@xfusion.com>, qemu-devel@nongnu.org, "Dr . David Alan
 Gilbert" <dave@treblig.org>, Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "Daniel P . =?UTF-8?B?QmVycmFuZ8Op?="
 <berrange@redhat.com>, Fabiano Rosas <farosas@suse.de>, Yury Kotov
 <yury-kotov@yandex-team.ru>, Vladimir Sementsov-Ogievskiy
 <vsementsov@yandex-team.ru>, Prasad Pandit <ppandit@redhat.com>, Li Zhijian
 <lizhijian@fujitsu.com>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH RFC 0/9] migration: Threadify loadvm process
Message-ID: <20251021000854.5cd97864@penguin>
In-Reply-To: <aPasigsOmIKvoqqm@x1.local>
References: <20250827205949.364606-1-peterx@redhat.com>
 <CAK3tnvKa=C-9qkOuyB+sZB8+o6YU0V+qaYheK-h9KBEumpyfBw@mail.gmail.com>
 <aObW9WrmWzTWs4N0@x1.local> <aPasigsOmIKvoqqm@x1.local>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/IBniQZz/+g5/LVMmCb=YoWt";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:pGkMm/ZVnS/3kdWI5q6Nxm9IV1M3E0unUhZFqfo9T6ABvhtgvaZ
 H6qPxmOlT7he+2DGvmEZNikb9t4NLaXMWJq7n1M7IA3oDMMjkYBDqDBooiJDq6w+BaCtdrR
 yII+gXs72b+9lyxsS/duhBNp3wmF0CTWSqk9HnTkxTO91vhUv1pD7JUNl2JRV1aBz0T/E0h
 MYUdzcG8cX8LgL5Wo2x8w==
UI-OutboundReport: notjunk:1;M01:P0:aan/15qxnoo=;6HlT5LkFCo8Rqbzb1iI7v9Bvrec
 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
 5anYQ==
Received-SPF: pass client-ip=212.227.15.4; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--Sig_/IBniQZz/+g5/LVMmCb=YoWt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 20 Oct 2025 17:41:30 -0400
Peter Xu <peterx@redhat.com> wrote:

> On Wed, Oct 08, 2025 at 05:26:13PM -0400, Peter Xu wrote:
> > On Thu, Sep 04, 2025 at 04:27:39PM +0800, Zhang Chen wrote: =20
> > > > I confess I didn't test anything on COLO but only from code observa=
tions
> > > > and analysis.  COLO maintainers: could you add some unit tests to Q=
EMU's
> > > > qtests? =20
> > >=20
> > > For the COLO part, I think remove the coroutines related code is OK f=
or me.
> > > Because the original coroutine still need to call the
> > > "colo_process_incoming_thread". =20
> >=20
> > Chen, thanks for the comment.  It's still reassuring.
> >  =20
> > >=20
> > > Hi Hailiang, any comments for this part? =20
> >=20
> > Any further comment on this series would always be helpful.
> >=20
> > It'll be also great if anyone can come up with a selftest for COLO.  Now
> > any new migration features needs both unit test and doc to get merged.
> > COLO was merged earlier so it doesn't need to, however these will be
> > helpful for sure to make sure COLO won't be easily broken. =20
>=20
> Chen/Hailiang:
>=20
> I may use some help from COLO side.
>=20
> Just now, I did give it a shot with the current docs/COLO-FT.txt and it
> didn't really work for me.
>=20
> The cmdlines I used almost followed the doc, however I changed a few
> things.  For example, on secondary VM I added "file.locking=3Doff" for dr=
ive
> "parent0" because otherwise the "nbd-server-add" command will fail taking
> the lock and it won't ever boot.  Meanwhile I switched to socket netdev
> from tap, in my case I only plan to run the COLO main routine, I hope
> that's harmless too but let me know if it is a problem.
>=20
> So below are the final cmdlines I used..
>=20
> For primary:
>=20
> bin=3D~/git/qemu/bin/qemu-system-x86_64
> $bin -enable-kvm -cpu qemu64,kvmclock=3Don \
>      -m 512 -smp 1 -qmp stdio \
>      -device piix3-usb-uhci -device usb-tablet -name primary \
>      -netdev socket,id=3Dhn0,listen=3D127.0.0.1:10000 \
>      -device rtl8139,id=3De0,netdev=3Dhn0 \
>      -chardev socket,id=3Dmirror0,host=3D0.0.0.0,port=3D9003,server=3Don,=
wait=3Doff \
>      -chardev socket,id=3Dcompare1,host=3D0.0.0.0,port=3D9004,server=3Don=
,wait=3Don \
>      -chardev socket,id=3Dcompare0,host=3D127.0.0.1,port=3D9001,server=3D=
on,wait=3Doff \
>      -chardev socket,id=3Dcompare0-0,host=3D127.0.0.1,port=3D9001 \
>      -chardev socket,id=3Dcompare_out,host=3D127.0.0.1,port=3D9005,server=
=3Don,wait=3Doff \
>      -chardev socket,id=3Dcompare_out0,host=3D127.0.0.1,port=3D9005 \
>      -object filter-mirror,id=3Dm0,netdev=3Dhn0,queue=3Dtx,outdev=3Dmirro=
r0 \
>      -object filter-redirector,netdev=3Dhn0,id=3Dredire0,queue=3Drx,indev=
=3Dcompare_out \
>      -object filter-redirector,netdev=3Dhn0,id=3Dredire1,queue=3Drx,outde=
v=3Dcompare0 \
>      -object iothread,id=3Diothread1 \
>      -object colo-compare,id=3Dcomp0,primary_in=3Dcompare0-0,secondary_in=
=3Dcompare1,outdev=3Dcompare_out0,iothread=3Diothread1 \
>      -drive if=3Dide,id=3Dcolo-disk0,driver=3Dquorum,read-pattern=3Dfifo,=
vote-threshold=3D1,children.0.file.filename=3D./primary.qcow2,children.0.dr=
iver=3Dqcow2
>=20
> For secondary (testing locally, hence using 127.0.0.1 as primary_ip):
>=20
> bin=3D~/git/qemu/bin/qemu-system-x86_64=20
> primary_ip=3D127.0.0.1
> $bin -enable-kvm -cpu qemu64,kvmclock=3Don -m 512 -smp 1 -qmp stdio \
>      -device piix3-usb-uhci -device usb-tablet -name secondary \
>      -netdev socket,id=3Dhn0,connect=3D127.0.0.1:10000 \
>      -device rtl8139,id=3De0,netdev=3Dhn0 \
>      -chardev socket,id=3Dred0,host=3D$primary_ip,port=3D9003,reconnect-m=
s=3D1000 \
>      -chardev socket,id=3Dred1,host=3D$primary_ip,port=3D9004,reconnect-m=
s=3D1000 \
>      -object filter-redirector,id=3Df1,netdev=3Dhn0,queue=3Dtx,indev=3Dre=
d0 \
>      -object filter-redirector,id=3Df2,netdev=3Dhn0,queue=3Drx,outdev=3Dr=
ed1 \
>      -object filter-rewriter,id=3Drew0,netdev=3Dhn0,queue=3Dall \
>      -drive if=3Dnone,id=3Dparent0,file.filename=3Dprimary.qcow2,driver=
=3Dqcow2,file.locking=3Doff \
>      -drive if=3Dnone,id=3Dchilds0,driver=3Dreplication,mode=3Dsecondary,=
file.driver=3Dqcow2,top-id=3Dcolo-disk0,file.file.filename=3Dsecondary-acti=
ve.qcow2,file.backing.driver=3Dqcow2,file.backing.file.filename=3Dsecondary=
-hidden.qcow2,file.backing.backing=3Dparent0 \
>      -drive if=3Dide,id=3Dcolo-disk0,driver=3Dquorum,read-pattern=3Dfifo,=
vote-threshold=3D1,children.0=3Dchilds0 \
>      -incoming tcp:0.0.0.0:9998
>=20

Hi Peter,
You have to use -incoming defer and enable x-colo on the
secondary side before starting migration.

And primary.qcow2 should be a separate image (with same content) for
each qemu instance.

Regards,
Lukas


> I started secondary, then primary, run the suggested QMP commands on
> secondary first, then the bunch of QMP commands on primary.  I got below
> error:
>=20
> x1:colo $ ./primary.sh=20
> qemu-system-x86_64: -chardev socket,id=3Dcompare1,host=3D0.0.0.0,port=3D9=
004,server=3Don,wait=3Don: info: QEMU waiting for connection on: disconnect=
ed:tcp:0.0.0.0:9004,server=3Don
> {"QMP": {"version": {"qemu": {"micro": 50, "minor": 1, "major": 10}, "pac=
kage": "v10.1.0-1513-g94586867df"}, "capabilities": ["oob"]}}
> VNC server running on ::1:5900
> {"execute":"qmp_capabilities"}
> {"return": {}}
> {"execute": "human-monitor-command", "arguments": {"command-line": "drive=
_add -n buddy driver=3Dreplication,mode=3Dprimary,file.driver=3Dnbd,file.ho=
st=3D127.0.0.2,file.port=3D9999,file.export=3Dparent0,node-name=3Dreplicati=
on0"}}
> {"return": ""}
> {"execute": "x-blockdev-change", "arguments":{"parent": "colo-disk0", "no=
de": "replication0" } }
> {"return": {}}
> {"execute": "migrate-set-capabilities", "arguments": {"capabilities": [ {=
"capability": "x-colo", "state": true } ] } }
> {"return": {}}
> {"execute": "migrate", "arguments": {"uri": "tcp:127.0.0.2:9998" } }
> {"return": {}}
> {"timestamp": {"seconds": 1760996025, "microseconds": 483349}, "event": "=
STOP"}
>=20
> x1:colo $ ./secondary.sh=20
> {"QMP": {"version": {"qemu": {"micro": 50, "minor": 1, "major": 10}, "pac=
kage": "v10.1.0-1513-g94586867df"}, "capabilities": ["oob"]}}
> VNC server running on ::1:5901
> {"execute":"qmp_capabilities"}
> {"return": {}}
> {"execute": "migrate-set-capabilities", "arguments": {"capabilities": [ {=
"capability": "x-colo", "state": true } ] } }
> {"return": {}}
> {"execute": "nbd-server-start", "arguments": {"addr": {"type": "inet", "d=
ata": {"host": "0.0.0.0", "port": "9999"} } } }
> {"return": {}}
> {"execute": "nbd-server-add", "arguments": {"device": "parent0", "writabl=
e": true } }
> {"return": {}}
> {"timestamp": {"seconds": 1760996025, "microseconds": 695059}, "event": "=
RESUME"}
> qemu-system-x86_64: Can't receive COLO message: Input/output error
> {"timestamp": {"seconds": 1760996025, "microseconds": 695369}, "event": "=
COLO_EXIT", "data": {"mode": "secondary", "reason": "error"}}
>=20
> Do you know what I missed?  Or does it mean that COLO is broken?
>=20
> Meanwhile, do you know if COLO still being used by anyone?  I'm pretty su=
re
> both Fabiano and myself are not looking after it..  I remember Dave used =
to
> try it, but it might be a long time ago too.
>=20
> Thanks,
>=20


--Sig_/IBniQZz/+g5/LVMmCb=YoWt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmj2svYACgkQNasLKJxd
sljIrxAApW+tNMII8sbcZ5XUm5Dob6maER+4CwU3BTNTaVgwrqvTWznCvIZaVZgG
mGuVJARm6+SPbJQ4Ym0LOeTBSk6CaxWPwIFLfHiv273fRlPLxJn2fVDhpZS9FpIy
Ij9gulXKrQ7eul6dwZLhe0rFSB0Rfr+FFSI2mB8YAPo4dwtj52WJDvYPeQoUdkbt
dDhN1rDU9cXfcXHDqe5cBvZCyvhpLkulronsNkCeHTM8KYy4R4Que0T82k7hIlRw
FSkVXVlnwLakLC+J80Um7lulq9KPBkI8R8OYt0U3SVj6mPA8/q51QIrPOLSSZVIO
fm0kp+tZ+C+NJHnhp0uu7zBZuvShtfk5Tjy5ZEdIhu2LQyzUrGE1vCvaX2gJ0C8K
Ohnjx98uWocBqoqudI9ElIb4GxYxNENLlxTTD3Vwge1427uFU3kHLn8xlWVJgTS5
Tm97cacbH+PNK/M/oyfThoN16I10xg3smB0gn1HQFkl9fY0W2Cs1GMb4O0Ei8YaJ
GCfD7NaYLDQIaRREdfnI0TaFUde7brpNrW4eWEe/rctvNHnHhMtSbb0dHRlAuG28
z4Vgr63NHeSw7w1D4ShlL2XN4EmyrGTigkhDkO7pqCLofXhuUtPCN1CxV+PHtBf+
2JzYKIABUSfl/pbo0XRMi1gyEz8pog7nqRe7PhQIQoC53hl232g=
=iAys
-----END PGP SIGNATURE-----

--Sig_/IBniQZz/+g5/LVMmCb=YoWt--

