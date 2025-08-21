Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8356CCA0EEB
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 14:21:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up6AK-0002Jd-0c; Thu, 21 Aug 2025 10:21:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1up6AF-0002HN-GV
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 10:21:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1up6AC-0005hR-3w
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 10:21:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755786069;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yTyQh6RZZGl+ADbV2i/KSTGDZKJsYWZOiE7f/fIT0RM=;
 b=QtzhykzF2JD+Lg3xVg51LlBzWA9O+5goZVGYjbd4rJzhfzMYzPUYnL4E13IMC1ROS8MsAC
 f0oYTlMKtYdnwM5C03pIjpYU0lEX7OsmJZ4K8VOjoZV9mavE2py9zP9Zf4Bc5Fc0sGkuBI
 Fg49b8bccv9Miw1ILzJ5yPCgkzzEdrE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-279-WiWI3pNAOayGk0Dcw_OSlQ-1; Thu,
 21 Aug 2025 10:21:03 -0400
X-MC-Unique: WiWI3pNAOayGk0Dcw_OSlQ-1
X-Mimecast-MFC-AGG-ID: WiWI3pNAOayGk0Dcw_OSlQ_1755786062
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CF37418011DE; Thu, 21 Aug 2025 14:20:40 +0000 (UTC)
Received: from localhost (unknown [10.2.16.124])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D860530001A1; Thu, 21 Aug 2025 14:20:39 +0000 (UTC)
Date: Thu, 21 Aug 2025 10:20:38 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Brian Song <hibriansong@gmail.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com,
 bernd@bsbernd.com, fam@euphon.net, hreitz@redhat.com, kwolf@redhat.com
Subject: Re: [RFC PATCH 0/3] block/export: Add FUSE-over-io_uring for Storage
 Exports
Message-ID: <20250821142038.GA7010@fedora>
References: <20250815034619.51980-1-hizhisong@gmail.com>
 <20250817134527.GA321129@fedora>
 <CAKWCU7V4+Eu-6iVbjd+xR0yrqNShGf3y2VB_RNqXo-dP7ZMFUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="V6bANKp2DUy/dn9h"
Content-Disposition: inline
In-Reply-To: <CAKWCU7V4+Eu-6iVbjd+xR0yrqNShGf3y2VB_RNqXo-dP7ZMFUg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--V6bANKp2DUy/dn9h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 09:32:44PM -0400, Brian Song wrote:
> On 8/17/25 9:45 AM, Stefan Hajnoczi wrote:
> > On Thu, Aug 14, 2025 at 11:46:16PM -0400, Zhi Song wrote:
> >> Due to kernel limitations, when the FUSE-over-io_uring option is
> >> enabled,
> >> you must create and assign nr_cpu IOThreads. For example:
> >
> > While it would be nice for the kernel to support a more flexible queue
> > mapping policy, userspace can work around this.
> >
> > I think Kevin suggested creating the number of FUSE queues required by
> > the kernel and configuring them across the user's IOThreads. That way
> > the number of IOThreads can be smaller than the number of FUSE queues.
> >
> > Stefan
>=20
> If we are mapping user specified IOThreads to nr_cpu queues Q, when we
> register entries, we need to think about how many entries in each Q[i]
> go to different IOThreads, and bind the qid when submitting. Once a CQE
> comes back, the corresponding IOThread handles it. Looks like we don't
> really need a round robin for dispatching. The actual question is how

Round-robin is needed for qid -> IOThread mapping, not for dispatching
individual requests. The kernel currently dispatches requests based on a
1:1 CPU:Queue mapping.

> to split entries in each queue across IOThreads.
>=20
> For example, if we split entries evenly:
>=20
> USER: define 2 IOThreads to submit and recv ring entries
> NR_CPU: 4
>=20
> Q =3D malloc(sizeof(entry) * 32 * nr_cpu);
>=20
> IOThread-1:
> Q[0] Q[1] Q[2] Q[3]
>   16   16   16   16
>=20
> IOThread-2:
> Q[0] Q[1] Q[2] Q[3]
>   16   16   16   16

There is no need to have nr_cpus queues in each IOThread. The constraint
is that the total number of queues across all IOThreads must equal
nr_cpus.

The malloc in your example implies that each FuseQueue will have 32
entries (REGISTER uring_cmds). nr_cpu is 4 so the mapping should look
like this:

IOThread-1:
Q[0] Q[2]
  32   32

IOThread-2:
Q[1] Q[3]
  32   32

Stefan

--V6bANKp2DUy/dn9h
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAminKzYACgkQnKSrs4Gr
c8gXYAf9GXpKbL1+NlnhoJ6P6P4SZP2ocJdJujBDp/tRTklHSgIxZuB3F1dmz5FY
zBljtVCQiaF5X1gvI7t/PnhMZZJVfWU1lC1cPbhEF8KehVIUGeehEqCaUge10Ll0
2d3RgSQPZ1+d+grZaFLoVZ0UT4uBM7ujSOVvg4KB/NZp1a8K6srSEqSeCS9Zygx2
PJMVM3At1u5zq4dxIYGxQju3CYTpuNE5WfwHgxZ2fV8xmQAiAiAcA0ftRN5Z+3I1
2sh+ae8lubs1A6/8xGM22tuQ/MxRd2UiI4uJAvywbCe3+HV2vIE6tzqAtbYDIVA5
pWrN1dMhhc2ndHCB6pPZKki1ooVNTA==
=CRMn
-----END PGP SIGNATURE-----

--V6bANKp2DUy/dn9h--


