Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36747C982ED
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 13:37:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8eCh-0002ou-Eb; Mon, 21 Sep 2026 09:37:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x8eCg-0002og-6g
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 09:37:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x8eCe-0002ih-Hu
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 09:37:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789997823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QggBVJ1/yFxW8gxfIuB3NJBxWqWGICpjFpzxz0bS+FI=;
 b=O0Jk9iQv8Oa36hAdF/GPzCj36401pm754kZuBYW35Gee3nDprLhdcmJYLADdoBTIoGXSMM
 THDHSOWRgkQmJ26XAoS0BOvW6T1/gVyPqcEN/DUMkkAcTvNvx+y35fNJERdgOIw1sq8iMr
 nlfimGwrASdcHEpX4Zu8VIwmopwwVQ8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-5-cT7x20RJPhi7vXBzoaw4aw-1; Mon,
 21 Sep 2026 09:37:01 -0400
X-MC-Unique: cT7x20RJPhi7vXBzoaw4aw-1
X-Mimecast-MFC-AGG-ID: cT7x20RJPhi7vXBzoaw4aw_1789997820
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1C981195D038; Mon, 21 Sep 2026 13:37:00 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 68CDC41B; Mon, 21 Sep 2026 13:36:59 +0000 (UTC)
Date: Wed, 16 Sep 2026 15:33:12 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 'Daniel P =?iso-8859-1?Q?=2E_Berrang=E9'?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Subject: Re: [PATCH V17 04/13] monitor: track IOThread users with QOM paths
Message-ID: <20260916193311.GA162769@fedora>
References: <20260915101655.3216101-1-zhangckid@gmail.com>
 <20260915101655.3216101-5-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kYIIJfOO5NVEHNYn"
Content-Disposition: inline
In-Reply-To: <20260915101655.3216101-5-zhangckid@gmail.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 46
X-Spam_score: 4.6
X-Spam_bar: ++++
X-Spam_report: (4.6 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--kYIIJfOO5NVEHNYn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 06:16:46PM +0800, Zhang Chen wrote:
> Monitors that require an IOThread share the internal mon_iothread.
> Account for each monitor explicitly in IOThread holder tracking, using
> the monitor's canonical QOM path to distinguish holders.
>=20
> Acquire the shared monitor IOThread AioContext once and store the
> IOThread and canonical QOM path so the holder can be released after the
> monitor has been removed from the QOM tree. Use the stored IOThread for
> per-monitor checks and accesses after initialization, and reuse the
> stored context for later operations.
>=20
> Release the holder from monitor_finalize(), after resources associated
> with the AioContext have been destroyed. This pairs the reference taken
> in complete() with instance finalization and keeps the IOThread alive
> throughout monitor teardown.
>=20
> The internal mon_iothread remains hidden from query-iothreads, as before.
> Management applications therefore cannot use it to determine which
> monitors are using the IOThread. Nevertheless, track the monitor
> holders so that they follow the same explicit holder and
> IOThread reference lifecycle as other AioContext users.
>=20
> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> ---
>  monitor/monitor-internal.h |  7 +++++--
>  monitor/monitor.c          | 36 ++++++++++++++++++++++++++----------
>  monitor/qmp.c              | 14 +++++++-------
>  3 files changed, 38 insertions(+), 19 deletions(-)

Aside from Markus' comment:
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--kYIIJfOO5NVEHNYn
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmqq7vgACgkQnKSrs4Gr
c8j1DAf/fOZbKbooBJZ0/OUWRZsKIUPGqMSYmh2qYBUpIqzMGgN7AEMHPTuWnnNn
E6ixtboEzstH1+l5O2oWXJl7LvY9V7YEgSbiL/cavD7Yn0zpIeu6RNe9ySjXnah7
Iks6KW6C4/UuZY3HtCGr/MRGUSMXqBjEa4BqQK8BhiUapDYZplYdqgYjgtiFY5cw
06eGbMVBIBBMSgDRRwOilMWe9v9YRzh3QwfokHnYb98izvwrKYXQhqaWB6XoFEPg
Eji8lC8YS4AljZGgf1181IQkuYMHftOU7shwwMPN3JB65Gtc4VmbPgn2UmYLv+RY
JLFxBmKh5cDPuhptTgsSfQbxF2Z01A==
=9B36
-----END PGP SIGNATURE-----

--kYIIJfOO5NVEHNYn--


