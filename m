Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12248CA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Sep 2025 13:15:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwKf0-0005ls-Pc; Wed, 10 Sep 2025 09:14:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uwKek-0005j2-B0
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 09:14:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uwKef-0003ER-AL
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 09:14:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757510068;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Egq3wQjZu8TiBu3MFRskDk7SlSh7r4i4dgdYdDNUPR4=;
 b=K5XaQFJdgJW3Zj1jMsarFHsYKeduiSZ2i0I0ddpECuUN34+3kRjnTx3z6K/HYNgsd4mztX
 KIdLoCCmguM+pOTQpsw7NhrfHaXq852Hw6unuNkOLSgwHy1nbAH5/CpbZ657PfV2Ylv7/i
 BYHv+KwaZ501ak4hzzbdMa4YgnGYwj8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-494-PyvSbtcuNWGCHn9dkvm0xA-1; Wed,
 10 Sep 2025 09:14:23 -0400
X-MC-Unique: PyvSbtcuNWGCHn9dkvm0xA-1
X-Mimecast-MFC-AGG-ID: PyvSbtcuNWGCHn9dkvm0xA_1757510062
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 00B58195419F; Wed, 10 Sep 2025 13:14:21 +0000 (UTC)
Received: from localhost (unknown [10.2.16.131])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E6E0419560AB; Wed, 10 Sep 2025 13:14:19 +0000 (UTC)
Date: Wed, 10 Sep 2025 09:14:18 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Brian Song <hibriansong@gmail.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com,
 bernd@bsbernd.com, fam@euphon.net, hreitz@redhat.com, kwolf@redhat.com
Subject: Re: [PATCH 4/4] iotests: add tests for FUSE-over-io_uring
Message-ID: <20250910131418.GA246746@fedora>
References: <20250830025025.3610-1-hibriansong@gmail.com>
 <20250830025025.3610-5-hibriansong@gmail.com>
 <20250909193830.GF218449@fedora>
 <c280787c-0db5-4a63-8e22-ce50726e7ebe@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="l0pJIzbzghogMWIW"
Content-Disposition: inline
In-Reply-To: <c280787c-0db5-4a63-8e22-ce50726e7ebe@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--l0pJIzbzghogMWIW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 09, 2025 at 04:51:12PM -0400, Brian Song wrote:
>=20
>=20
> On 9/9/25 3:38 PM, Stefan Hajnoczi wrote:
> > On Fri, Aug 29, 2025 at 10:50:25PM -0400, Brian Song wrote:
> > > To test FUSE-over-io_uring, set the environment variable
> > > FUSE_OVER_IO_URING=3D1. This applies only when using the
> > > 'fuse' protocol.
> > >=20
> > > $ FUSE_OVER_IO_URING=3D1 ./check -fuse
> > >=20
> > > Suggested-by: Kevin Wolf <kwolf@redhat.com>
> > > Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > Signed-off-by: Brian Song <hibriansong@gmail.com>
> > > ---
> > >   tests/qemu-iotests/check     |  2 ++
> > >   tests/qemu-iotests/common.rc | 45 +++++++++++++++++++++++++++------=
---
> > >   2 files changed, 36 insertions(+), 11 deletions(-)
> > >=20
> > > diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
> > > index 545f9ec7bd..c6fa0f9e3d 100755
> > > --- a/tests/qemu-iotests/check
> > > +++ b/tests/qemu-iotests/check
> > > @@ -94,6 +94,8 @@ def make_argparser() -> argparse.ArgumentParser:
> > >           mg.add_argument('-' + fmt, dest=3D'imgfmt', action=3D'store=
_const',
> > >                           const=3Dfmt, help=3Df'test {fmt}')
> > > +    # To test FUSE-over-io_uring, set the environment variable
> > > +    # FUSE_OVER_IO_URING=3D1. This applies only when using the 'fuse=
' protocol
> > >       protocol_list =3D ['file', 'rbd', 'nbd', 'ssh', 'nfs', 'fuse']
> > >       g_prt =3D p.add_argument_group(
> > >           '  image protocol options',
> > > diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common=
=2Erc
> > > index e977cb4eb6..f8b79c3810 100644
> > > --- a/tests/qemu-iotests/common.rc
> > > +++ b/tests/qemu-iotests/common.rc
> > > @@ -539,17 +539,38 @@ _make_test_img()
> > >           touch "$export_mp"
> > >           rm -f "$SOCK_DIR/fuse-output"
> > > -        # Usually, users would export formatted nodes.  But we prese=
nt fuse as a
> > > -        # protocol-level driver here, so we have to leave the format=
 to the
> > > -        # client.
> > > -        # Switch off allow-other, because in general we do not need =
it for
> > > -        # iotests.  The default allow-other=3Dauto has the downside =
of printing a
> > > -        # fusermount error on its first attempt if allow_other is not
> > > -        # permissible, which we would need to filter.
> >=20
> > This comment applies to both branches of the if statement. I think
> > keeping it here is slightly better.
> >=20
> > > -        QSD_NEED_PID=3Dy $QSD \
> > > -              --blockdev file,node-name=3Dexport-node,filename=3D$im=
g_name,discard=3Dunmap \
> > > -              --export fuse,id=3Dfuse-export,node-name=3Dexport-node=
,mountpoint=3D"$export_mp",writable=3Don,growable=3Don,allow-other=3Doff \
> > > -              &
> > > +        if [ -n "$FUSE_OVER_IO_URING" ]; then
> > > +            nr_cpu=3D$(nproc 2>/dev/null || echo 1)
> > > +            nr_iothreads=3D$((nr_cpu / 2))
> > > +            if [ $nr_iothreads -lt 1 ]; then
> > > +                nr_iothreads=3D1
> > > +            fi
> >=20
> > Please add a comment explaining that the purpose of this configuration
> > based on the number of CPUs is to test multiple IOThreads when the host
> > allows it, since that is a more interesting case then just 1 IOThread.
> > Many other configurations are possible as well, but not all of them can
> > be tested because the test matrix would be large.
> >=20
> > > +
> > > +            iothread_args=3D""
> > > +            iothread_export_args=3D""
> > > +            for ((i=3D0; i<$nr_iothreads; i++)); do
> > > +                iothread_args=3D"$iothread_args --object iothread,id=
=3Diothread$i"
> > > +                iothread_export_args=3D"$iothread_export_args,iothre=
ad.$i=3Diothread$i"
> > > +            done
> > > +
> > > +            QSD_NEED_PID=3Dy $QSD \
> > > +                    $iothread_args \
> > > +                    --blockdev file,node-name=3Dexport-node,filename=
=3D$img_name,discard=3Dunmap \
> > > +                    --export fuse,id=3Dfuse-export,node-name=3Dexpor=
t-node,mountpoint=3D"$export_mp",writable=3Don,growable=3Don,allow-other=3D=
off,io-uring=3Don$iothread_export_args \
> > > +                &
> > > +        else
> > > +            # Usually, users would export formatted nodes.  But we p=
resent fuse as a
> > > +            # protocol-level driver here, so we have to leave the fo=
rmat to the
> > > +            # client.
> > > +            # Switch off allow-other, because in general we do not n=
eed it for
> > > +            # iotests.  The default allow-other=3Dauto has the downs=
ide of printing a
> > > +            # fusermount error on its first attempt if allow_other i=
s not
> > > +            # permissible, which we would need to filter.
> > > +            QSD_NEED_PID=3Dy $QSD \
> > > +                --blockdev file,node-name=3Dexport-node,filename=3D$=
img_name,discard=3Dunmap \
> > > +                --export fuse,id=3Dfuse-export,node-name=3Dexport-no=
de,mountpoint=3D"$export_mp",writable=3Don,growable=3Don,allow-other=3Doff \
> > > +                &
> > > +        fi
> > >           pidfile=3D"$QEMU_TEST_DIR/qemu-storage-daemon.pid"
> > > @@ -592,6 +613,8 @@ _rm_test_img()
> > >           kill "${FUSE_PIDS[index]}"
> > > +        sleep 1
> > > +
> >=20
> > What is the purpose of this sleep command?
> >=20
>=20
> I don=E2=80=99t exactly remember why. It might get stuck if there=E2=80=
=99s no sleep here. I
> remember we discussed this problem in earlier emails.

The purpose needs to be understood. Otherwise there is a good chance
that the test will fail randomly in a continuous integration environment
where things sometimes take a long time due to CPU contention.

Stefan

--l0pJIzbzghogMWIW
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmjBeaoACgkQnKSrs4Gr
c8jArQf/Z7h7LxV+gslN2AvccgIz/8LxBFbwNIy4Pn2SPvKRTRZQxZJ58kljE5e0
oELzxsSUPSfGGUHef38lMI8+ZPGEfg+UYEI5/0A12rtOW2wz4U8fxfe3ItmCUxhb
c1+LFVb59fnJEflPCvzKJergcVg3p6eV7zB0pAyMMV8e+8So6Xwj+gA16ql77WBP
oBnrFP9BKNrdfgELrm9KZcot/cF0yoGXRTnBsYKKsptoqYtoap7Eh95hCKG0SHez
3c6c9jv+EnO51Mgw1Hri1vj55BMDe4hCNUWebZhWBpXrlk4vhTwAt82ncDdMrAH/
6wNJGjwXq/T9UYuMDHFpY6X4kLHpvQ==
=n+ib
-----END PGP SIGNATURE-----

--l0pJIzbzghogMWIW--


