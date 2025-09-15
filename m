Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D768CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 17:43:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyDDW-0006rb-Sb; Mon, 15 Sep 2025 13:42:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uyDDV-0006rN-I5
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 13:42:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uyDDM-0002ON-9q
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 13:42:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757958122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=niFy11xGloJaS/zmofChTQOJf1BvPZosDYe93bNZP/U=;
 b=b0KPkO7LrPbVkAA3U1xMXmSGR0k366sgnRumhQivKiOa6i4YqtEja+ROz6v09iY4DXoFgh
 kT4GH4hJVW5nhDlJOq8yOo3CYOuRp1zFlHDVd31Xb5yqEG/iBwvDXhZa2PjKf1g1+IhqH+
 tdbGrMnjaMfhBI8DW82iOrB2WVYZB/g=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-681-TnM3I7s3NrqR16VSNOJ1kg-1; Mon,
 15 Sep 2025 13:41:58 -0400
X-MC-Unique: TnM3I7s3NrqR16VSNOJ1kg-1
X-Mimecast-MFC-AGG-ID: TnM3I7s3NrqR16VSNOJ1kg_1757958117
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1E5D31956053; Mon, 15 Sep 2025 17:41:57 +0000 (UTC)
Received: from localhost (unknown [10.2.16.235])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4E97419560A2; Mon, 15 Sep 2025 17:41:56 +0000 (UTC)
Date: Mon, 15 Sep 2025 13:41:54 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Brian Song <hibriansong@gmail.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com,
 bernd@bsbernd.com, fam@euphon.net, hreitz@redhat.com, kwolf@redhat.com
Subject: Re: [PATCH 4/4] iotests: add tests for FUSE-over-io_uring
Message-ID: <20250915174154.GE69944@fedora>
References: <20250830025025.3610-1-hibriansong@gmail.com>
 <20250830025025.3610-5-hibriansong@gmail.com>
 <20250909193830.GF218449@fedora>
 <c280787c-0db5-4a63-8e22-ce50726e7ebe@gmail.com>
 <20250910131418.GA246746@fedora>
 <f97b89e6-1faa-4f66-9630-99b7d387e90c@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZJ+a1B8kCyYDecFu"
Content-Disposition: inline
In-Reply-To: <f97b89e6-1faa-4f66-9630-99b7d387e90c@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--ZJ+a1B8kCyYDecFu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 10:22:24PM -0400, Brian Song wrote:
>=20
>=20
> On 9/10/25 9:14 AM, Stefan Hajnoczi wrote:
> > On Tue, Sep 09, 2025 at 04:51:12PM -0400, Brian Song wrote:
> > >=20
> > >=20
> > > On 9/9/25 3:38 PM, Stefan Hajnoczi wrote:
> > > > On Fri, Aug 29, 2025 at 10:50:25PM -0400, Brian Song wrote:
> > > > > To test FUSE-over-io_uring, set the environment variable
> > > > > FUSE_OVER_IO_URING=3D1. This applies only when using the
> > > > > 'fuse' protocol.
> > > > >=20
> > > > > $ FUSE_OVER_IO_URING=3D1 ./check -fuse
> > > > >=20
> > > > > Suggested-by: Kevin Wolf <kwolf@redhat.com>
> > > > > Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > > > Signed-off-by: Brian Song <hibriansong@gmail.com>
> > > > > ---
> > > > >    tests/qemu-iotests/check     |  2 ++
> > > > >    tests/qemu-iotests/common.rc | 45 +++++++++++++++++++++++++++-=
--------
> > > > >    2 files changed, 36 insertions(+), 11 deletions(-)
> > > > >=20
> > > > > diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
> > > > > index 545f9ec7bd..c6fa0f9e3d 100755
> > > > > --- a/tests/qemu-iotests/check
> > > > > +++ b/tests/qemu-iotests/check
> > > > > @@ -94,6 +94,8 @@ def make_argparser() -> argparse.ArgumentParser:
> > > > >            mg.add_argument('-' + fmt, dest=3D'imgfmt', action=3D'=
store_const',
> > > > >                            const=3Dfmt, help=3Df'test {fmt}')
> > > > > +    # To test FUSE-over-io_uring, set the environment variable
> > > > > +    # FUSE_OVER_IO_URING=3D1. This applies only when using the '=
fuse' protocol
> > > > >        protocol_list =3D ['file', 'rbd', 'nbd', 'ssh', 'nfs', 'fu=
se']
> > > > >        g_prt =3D p.add_argument_group(
> > > > >            '  image protocol options',
> > > > > diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/co=
mmon.rc
> > > > > index e977cb4eb6..f8b79c3810 100644
> > > > > --- a/tests/qemu-iotests/common.rc
> > > > > +++ b/tests/qemu-iotests/common.rc
> > > > > @@ -539,17 +539,38 @@ _make_test_img()
> > > > >            touch "$export_mp"
> > > > >            rm -f "$SOCK_DIR/fuse-output"
> > > > > -        # Usually, users would export formatted nodes.  But we p=
resent fuse as a
> > > > > -        # protocol-level driver here, so we have to leave the fo=
rmat to the
> > > > > -        # client.
> > > > > -        # Switch off allow-other, because in general we do not n=
eed it for
> > > > > -        # iotests.  The default allow-other=3Dauto has the downs=
ide of printing a
> > > > > -        # fusermount error on its first attempt if allow_other i=
s not
> > > > > -        # permissible, which we would need to filter.
> > > >=20
> > > > This comment applies to both branches of the if statement. I think
> > > > keeping it here is slightly better.
> > > >=20
> > > > > -        QSD_NEED_PID=3Dy $QSD \
> > > > > -              --blockdev file,node-name=3Dexport-node,filename=
=3D$img_name,discard=3Dunmap \
> > > > > -              --export fuse,id=3Dfuse-export,node-name=3Dexport-=
node,mountpoint=3D"$export_mp",writable=3Don,growable=3Don,allow-other=3Dof=
f \
> > > > > -              &
> > > > > +        if [ -n "$FUSE_OVER_IO_URING" ]; then
> > > > > +            nr_cpu=3D$(nproc 2>/dev/null || echo 1)
> > > > > +            nr_iothreads=3D$((nr_cpu / 2))
> > > > > +            if [ $nr_iothreads -lt 1 ]; then
> > > > > +                nr_iothreads=3D1
> > > > > +            fi
> > > >=20
> > > > Please add a comment explaining that the purpose of this configurat=
ion
> > > > based on the number of CPUs is to test multiple IOThreads when the =
host
> > > > allows it, since that is a more interesting case then just 1 IOThre=
ad.
> > > > Many other configurations are possible as well, but not all of them=
 can
> > > > be tested because the test matrix would be large.
> > > >=20
> > > > > +
> > > > > +            iothread_args=3D""
> > > > > +            iothread_export_args=3D""
> > > > > +            for ((i=3D0; i<$nr_iothreads; i++)); do
> > > > > +                iothread_args=3D"$iothread_args --object iothrea=
d,id=3Diothread$i"
> > > > > +                iothread_export_args=3D"$iothread_export_args,io=
thread.$i=3Diothread$i"
> > > > > +            done
> > > > > +
> > > > > +            QSD_NEED_PID=3Dy $QSD \
> > > > > +                    $iothread_args \
> > > > > +                    --blockdev file,node-name=3Dexport-node,file=
name=3D$img_name,discard=3Dunmap \
> > > > > +                    --export fuse,id=3Dfuse-export,node-name=3De=
xport-node,mountpoint=3D"$export_mp",writable=3Don,growable=3Don,allow-othe=
r=3Doff,io-uring=3Don$iothread_export_args \
> > > > > +                &
> > > > > +        else
> > > > > +            # Usually, users would export formatted nodes.  But =
we present fuse as a
> > > > > +            # protocol-level driver here, so we have to leave th=
e format to the
> > > > > +            # client.
> > > > > +            # Switch off allow-other, because in general we do n=
ot need it for
> > > > > +            # iotests.  The default allow-other=3Dauto has the d=
ownside of printing a
> > > > > +            # fusermount error on its first attempt if allow_oth=
er is not
> > > > > +            # permissible, which we would need to filter.
> > > > > +            QSD_NEED_PID=3Dy $QSD \
> > > > > +                --blockdev file,node-name=3Dexport-node,filename=
=3D$img_name,discard=3Dunmap \
> > > > > +                --export fuse,id=3Dfuse-export,node-name=3Dexpor=
t-node,mountpoint=3D"$export_mp",writable=3Don,growable=3Don,allow-other=3D=
off \
> > > > > +                &
> > > > > +        fi
> > > > >            pidfile=3D"$QEMU_TEST_DIR/qemu-storage-daemon.pid"
> > > > > @@ -592,6 +613,8 @@ _rm_test_img()
> > > > >            kill "${FUSE_PIDS[index]}"
> > > > > +        sleep 1
> > > > > +
> > > >=20
> > > > What is the purpose of this sleep command?
> > > >=20
> > >=20
> > > I don=E2=80=99t exactly remember why. It might get stuck if there=E2=
=80=99s no sleep here. I
> > > remember we discussed this problem in earlier emails.
> >=20
> > The purpose needs to be understood. Otherwise there is a good chance
> > that the test will fail randomly in a continuous integration environment
> > where things sometimes take a long time due to CPU contention.
> >=20
> > Stefan
>=20
> I think the issue lies in our current approach of using df to check wheth=
er
> the FUSE mount has been unmounted.
>=20
> When we traced df with strace, we found that its logic for checking the
> mount point is:
> =3D> Call mount to read the system's mount information
> =3D> Use statfs() to get the filesystem statistics
>=20
> But our current test code exits with the following sequence:
> =3D> Kill the FUSE process
> =3D> The kernel starts cleaning up the FUSE mount point
> =3D> df calls statfs(), which requires communication with the FUSE proces=
s But
> the FUSE process might still be cleaning up, causing the communication to
> fail
> =3D> df then returns an error or stale information
> =3D> Our detection logic misinterprets this and immediately deletes the
> mounted image
>=20
> Since we only need to check the system's mount information, we can just c=
all
> mount and grep "$img" to verify whether the image has been successfully
> unmounted.
>=20
> Does it make sense?

It's worth trying. Hanna wrote the existing code that uses df(1), so
maybe she has thoughts on this too.

I looked at waiting for FUSE_PIDS[] or using the QMP monitor to shut
down cleanly. Those approaches have their own issues. Sending a
`block-export-del` QMP command and waiting for it to return, followed by
a `quit` QMP command should work well. But it's more complex than
adjusting the existing loop and still needs a timeout. So I think the
mount(8) approach is worth a shot.

Stefan

--ZJ+a1B8kCyYDecFu
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmjIT+IACgkQnKSrs4Gr
c8iplwgAvYOLTEDiw9FRMeyjADSvdQL2LX/DgGFxSTDVM6so4+LKgPj7O4O3LFW5
jQT8b16CHQa0xSymxxq6BM32qvpyaKXFPQd8RGMmZb/LBKBAN9rmIBDeqB80ZskF
V59mjMivSAwz0s6s4W6C3VtXZuon8D5UECUy1x93Ag1CIyZTGEXmjuHTw3u0Kv3C
aa7t0l7LWg+hIk5XHbjD/1YNJDZ9j8thkebpZ4jMcqK4nQMkK0W7kAbSSqOk/W1I
tPnc99jFJ6LVBE0PXAM1HTvp7CbohFyzN0DHsbfpQuvG3/DjmSRpkGj9rr3ibOuw
bynhz8eSOS4wthrPDcBi+WVI4N8feA==
=UaQX
-----END PGP SIGNATURE-----

--ZJ+a1B8kCyYDecFu--


