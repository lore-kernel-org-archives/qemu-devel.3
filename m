Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59578E87839
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 15:27:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnIJb-0004P7-Tk; Tue, 03 Feb 2026 10:27:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vnIJZ-0004KD-HJ
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:27:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vnIJX-0003zN-SU
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:27:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770132458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fQAhcLqTzoGbogwYigo7nENGQbFQ3baEvHFMCzejPcY=;
 b=JNDJaLd0hYzFRTDw52DnW547Z1eOYqea5UfTYMi0c4Cpk9skzNb5d+D+5SAbzV5nCSmM/e
 GykYMZ2wx9PmP49sNZ0Ur7KDv+UFvZ4ZdsdKUK9EPlvsRE+kkk3sZ10OrqPgNY0do5EnS+
 dNefknzIjhpj49sbd0fvublknWos+vU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-106-DEAYmLUYOGy48hahMnvyNQ-1; Tue,
 03 Feb 2026 10:27:36 -0500
X-MC-Unique: DEAYmLUYOGy48hahMnvyNQ-1
X-Mimecast-MFC-AGG-ID: DEAYmLUYOGy48hahMnvyNQ_1770132455
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9976F18005AF; Tue,  3 Feb 2026 15:27:35 +0000 (UTC)
Received: from localhost (unknown [10.2.16.143])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EEFDE1800665; Tue,  3 Feb 2026 15:27:34 +0000 (UTC)
Date: Tue, 3 Feb 2026 10:27:33 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Cc: Noam Assouline <nassouli@redhat.com>,
 Yan Vugenfirer <yvugenfi@redhat.com>, qemu-devel@nongnu.org,
 michael.roth@amd.com, Qianqian Zhu <qizhu@redhat.com>,
 Stefan Hajnoczi <shajnocz@redhat.com>
Subject: Re: QGA fsfreeze blocks QMP: need async fsfreeze or alternative?
Message-ID: <20260203152733.GA449076@fedora>
References: <CANc8XmBVnkbrsJ+DMKXA7HhepStAPHRpXOH8fB16e=bghPOsqQ@mail.gmail.com>
 <CAPMcbCq2oOYXo=O0D0fdBSG-vB7+q1=VtEqQpHqSzFU6+5Sq9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YmIqKLi6X8F6IYQZ"
Content-Disposition: inline
In-Reply-To: <CAPMcbCq2oOYXo=O0D0fdBSG-vB7+q1=VtEqQpHqSzFU6+5Sq9g@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--YmIqKLi6X8F6IYQZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 03, 2026 at 02:58:29PM +0200, Kostiantyn Kostiuk wrote:
> Hi Noam
>=20
> QEMU agent was developed as a tool with a synchronous API, and adding any
> async commands requires a redesign of the API. QGA also does not support
> sending any event to the host.

Regarding the lack of QMP events, this is a bummer because it introduces
latency but polling for completion is a possibility. Enabling QMP events
might also be an option?

> First of all, if you send 2 asing command "file-open-async" and get 2
> responses with FD, how can you know which FD is for which file? Yes, asked
> about FS freeze API, but the idea is the same. FS-freeze allow to provide=
 a
> list of volumes to freeze, so you can have 2 requests to freeze 2 sets of
> volumes. And get the same question.

An async freeze command could take a unique identifier argument that is
passed back to the client when completion is reported. This way the
client can correlate the completion to a specific command.

There are existing async QAPI APIs that can be used as a reference. For
example, qapi/jobs.json. It's a 3-part API where jobs are launched, can
be queried, and can be managed (pause/cancel/dismiss). Querying is
read-only, so the dismiss command can be used to actually reap the job
and make it go away. Something similar could be done for fsfreeze. The
job API was supposed to be generic, but it's only used by the block
layer as far as I'm aware - maybe it could be reused here too?

>=20
> Regarding multiple agents, this is theoretically possible because QGA is =
an
> independent application. If you run each QGA instance with a proper
> different state folder and a different communication channel, it should
> work. The main problem is that QGA instances will be independant and when
> QGA1 blocks all API execution because the guest has frozen FS, QGA2 will
> allow any command, including FS freeze.
>=20
> Unfortunately, I have no good answer for you. Windows VSS has a lot of
> limitations, and we are trying to somehow work with it. Windows VSS doesn=
't
> even have an API to report a FS state, so QGA builds and uses internal
> knowledge that will be out of sync after snapshot restoring.
>=20
> CC: @Yan Vugenfirer <yvugenfi@redhat.com> @Qianqian Zhu <qizhu@redhat.com=
> Do
> you have any idea?
>=20
> Best Regards,
> Kostiantyn Kostiuk.
>=20
>=20
> On Tue, Feb 3, 2026 at 12:23=E2=80=AFPM Noam Assouline <nassouli@redhat.c=
om> wrote:
>=20
> > Hello qemu-devel!
> >
> > I=E2=80=99m working on a KubeVirt fix for Windows VSS fsfreeze timeouts=
 (PR #16653
> > <https://github.com/kubevirt/kubevirt/pull/16653>). Up to now we=E2=80=
=99ve
> > relied on libvirt=E2=80=99s default QEMU agent response timeout of 5 se=
conds, and
> > that often isn=E2=80=99t enough for VSS fsfreeze to complete. This PR p=
roposes
> > increasing the timeout to 60 seconds so the freeze can finish successfu=
lly.
> >
> > The challenge and the reason for this email is that qemu-ga processes
> > commands synchronously on a single connection. While guest-fsfreeze-fre=
eze
> > is running, the agent is effectively busy and other commands (e.g. ping,
> > status) will hang until it returns, which can impact pod readiness prob=
es.
> > I=E2=80=99m checking what we can do about this.
> >
> > I=E2=80=99m mainly looking to understand whether this can be addressed =
in qemu-ga,
> > and to get guidance on the right direction. Is there a supported way to=
 use
> > multiple agent connections/channels, or is an async guest-fsfreeze-free=
ze
> > with a completion event the more appropriate solution? More generally, =
any
> > best=E2=80=91practice guidance around Windows fsfreeze timeouts and res=
ponsiveness
> > would be very helpful!
> >
> > Thanks in advance, and cc=E2=80=99ing qemu-ga maintainers.
> >
> > Noam
> > KubeVirt Storage Ecosystem team
> >

--YmIqKLi6X8F6IYQZ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmmCE+UACgkQnKSrs4Gr
c8jXlAf/d9eE6+8Scq5Yi0jl2d7vkFFxWfMjAuf0LniLgRGbkmb+ICmvt/2ty+gK
yC3YjyWZacTm0Eb0y46V71GalMC0yhAeHq52PWJg+le3mSlPHBLBtblXoytKEuFL
um24DsXNH6qaQ26LLtfKO7O07vzhkuF4MLgZ6ySaSXH9VHAP4aLaEA1WrGHFiB4m
rDGWorNvS8T182CRwGo4jMfp59f6QxrNwa1VacoY6v4pBPzRbSvM34ZgPOHSaEx+
dwCFqbacRAL8Tc5yfBoBUzO6wi35VQpY1qVbK3I7lGMgLC42NUUy8hrJg71xkxjb
iLdxRCot4Zl7htqeP7Nc9qdM7TOTOQ==
=UFCP
-----END PGP SIGNATURE-----

--YmIqKLi6X8F6IYQZ--


