Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8895FC19F2E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 07:06:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnXxs-0006Uy-3O; Thu, 27 Feb 2025 02:05:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tnXxp-0006J8-7c
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 02:05:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tnXxn-0006nb-GX
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 02:05:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740639941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vbK1WhZmOcf3gcVh2+VrhIk2EyIIOIP/wZG8mYOXTE4=;
 b=EKdzZOWnWlQpVmxKXvT10KqwGvWAqAETIdr+JfA8JsNbQDkYeuoBwoVUvw6hn0daYk5083
 3DOrZ+nTii8SQ+miFwPjCZnEcE+TtYFb/eirrJfndOgFKz4Q0Y+O6JFxCWY4vBVynb/Bcl
 P0pVutiUmAWC66M/XiNg44tPNtwXdzk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-206-NZhNlWmGPFWoDMPpnSlUAw-1; Thu,
 27 Feb 2025 02:05:35 -0500
X-MC-Unique: NZhNlWmGPFWoDMPpnSlUAw-1
X-Mimecast-MFC-AGG-ID: NZhNlWmGPFWoDMPpnSlUAw_1740639932
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F13CE1801A13; Thu, 27 Feb 2025 07:05:30 +0000 (UTC)
Received: from localhost (unknown [10.2.16.46])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A5CAA1800945; Thu, 27 Feb 2025 07:05:26 +0000 (UTC)
Date: Thu, 27 Feb 2025 15:05:23 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, danielhb413@gmail.com
Subject: Re: [PATCH] trace/simple: Fix hang when using simpletrace with fork()
Message-ID: <20250227070523.GC85709@fedora>
References: <20250226085015.1143991-1-thuth@redhat.com>
 <Z77bqqKiV7etJNCf@redhat.com>
 <2a7c4f21-ee27-4407-8191-dd1f0547990c@redhat.com>
 <Z77ksR0vcySWC0CS@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Z5Rz4Crf7PowmNb2"
Content-Disposition: inline
In-Reply-To: <Z77ksR0vcySWC0CS@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--Z5Rz4Crf7PowmNb2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 09:53:53AM +0000, Daniel P. Berrang=E9 wrote:
> On Wed, Feb 26, 2025 at 10:38:56AM +0100, Thomas Huth wrote:
> > On 26/02/2025 10.15, Daniel P. Berrang=E9 wrote:
> > > On Wed, Feb 26, 2025 at 09:50:15AM +0100, Thomas Huth wrote:
> > > > When compiling QEMU with --enable-trace-backends=3Dsimple , the
> > > > iotest 233 is currently hanging. This happens because qemu-nbd
> > > > calls trace_init_backends() first - which causes simpletrace to
> > > > install its writer thread and the atexit() handler - before
> > > > calling fork(). But the simpletrace writer thread is then only
> > > > available in the parent process, not in the child process anymore.
> > > > Thus when the child process exits, its atexit handler waits forever
> > > > on the trace_empty_cond condition to be set by the non-existing
> > > > writer thread, so the process never finishes.
> > > >=20
> > > > Fix it by installing a pthread_atfork() handler, too, which
> > > > makes sure that the trace_writeout_enabled variable gets set
> > > > to false again in the child process, so we can use it in the
> > > > atexit() handler to check whether we still need to wait on the
> > > > writer thread or not.
> > > >=20
> > > > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > > > ---
> > > >   trace/simple.c | 17 ++++++++++++++++-
> > > >   1 file changed, 16 insertions(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/trace/simple.c b/trace/simple.c
> > > > index c0aba00cb7f..269bbda69f1 100644
> > > > --- a/trace/simple.c
> > > > +++ b/trace/simple.c
> > > > @@ -380,8 +380,22 @@ void st_print_trace_file_status(void)
> > > >   void st_flush_trace_buffer(void)
> > > >   {
> > > > -    flush_trace_file(true);
> > > > +    flush_trace_file(trace_writeout_enabled);
> > > > +}
> > > > +
> > > > +#ifndef _WIN32
> > > > +static void trace_thread_atfork(void)
> > > > +{
> > > > +    /*
> > > > +     * If we fork, the writer thread does not exist in the child, =
so
> > > > +     * make sure to allow st_flush_trace_buffer() to clean up corr=
ectly.
> > > > +     */
> > > > +    g_mutex_lock(&trace_lock);
> > > > +    trace_writeout_enabled =3D false;
> > > > +    g_cond_signal(&trace_empty_cond);
> > > > +    g_mutex_unlock(&trace_lock);
> > > >   }
> > > > +#endif
> > >=20
> > > This doesn't seem right to me. This is being run in the child and whi=
le
> > > it may avoid the hang when the child exits, surely it still leaves tr=
acing
> > > non-functional in the child as we're lacking the thread to write out =
the
> > > trace data.
> >=20
> > Well, you cannot write to the same file from the parent and child at the
> > same time, so one of both needs to be shut up AFAIU. And the simpletrace
> > code cannot now which one of the two processes should be allowed to con=
tinue
> > with the logging, so we either have to disable tracing in one of the two
> > processes, or think of something completely different, e.g. using
> > pthread_atfork(abort, NULL, NULL) to make people aware that they are not
> > allowed to start tracing before calling fork()...? But in that case we =
still
> > need a qemu-nbd expert to fix qemu-nbd, so that it does not initialize =
the
> > trace backend before calling fork().
>=20
> As precedent, in system/vl.c we delay trace_init() until after daemonizing
> which is the simple way to avoid the worst of the danger.

That sounds good to me.

Adding Daniel Henrique Barboza because he fixed a similar issue in
commit 10b6ee1616f9 ("vl.c: do not execute trace_init_backends() before
daemonizing").

Stefan

--Z5Rz4Crf7PowmNb2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfADrMACgkQnKSrs4Gr
c8ggAAgAww5j9KlaOt6ulTSjVzJUgETqogbybtmFOGE9ryiOlNohRGEsxsETKwvB
4HmTWkvfgBU/vYvVrCB/K9UM/Lz1QAaU8W3U/+vEhcfc3/J/kNfHeVjlvVL0JT6+
jYH80v4JL3ETXwS3r1cPPsniOapeTHHF0hBPrHn+qbgJS2/rbfEhae2n6u6bhCIb
tFNL/OZZ7m60nMQ1b79q8hw0hH+ytdubJxK04Ckn2uwSClpZDBH0ied65x0dbdu9
pl7kyzOLLmn+yWXL1hWw4ZTYt2w5MLi9meEwvrE4vAq6uUGCmKH2Evej39yo1fgy
PnUIo+PwXPZfDonNkfqxatwSVEsonA==
=wbeE
-----END PGP SIGNATURE-----

--Z5Rz4Crf7PowmNb2--


