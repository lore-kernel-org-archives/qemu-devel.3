Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57190EFB7EF
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 04:25:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vujyQ-0002v3-S8; Mon, 23 Feb 2026 23:24:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vujyO-0002uj-Ly
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 23:24:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vujyL-0006Ju-88
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 23:24:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771907071;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/ddbWTMKVbD43VgAqMVpdyVheLSSkIncF4HgxqE9WjQ=;
 b=bvWr+0b0yuasi+1whiLRbE0fJVF5I+f38TU89QB8ejiW2xFLYwX0ut5NSiSwGOk0NIx3CR
 rHbElTgEExT2Rwz0JwyiSwxASeWJDsyYXPDlUdHJTDHf4leGYCJrXH+SAbQnTkLs3bFNNO
 So3bfFp/lpoGGdbxa9x1jURcjq/0zCk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-387-AXY4UpbPPyuB54EEm_KnNw-1; Mon,
 23 Feb 2026 23:24:27 -0500
X-MC-Unique: AXY4UpbPPyuB54EEm_KnNw-1
X-Mimecast-MFC-AGG-ID: AXY4UpbPPyuB54EEm_KnNw_1771907066
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BC0D218004A9; Tue, 24 Feb 2026 04:24:25 +0000 (UTC)
Received: from localhost (unknown [10.2.16.27])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E75333003D91; Tue, 24 Feb 2026 04:24:23 +0000 (UTC)
Date: Tue, 24 Feb 2026 12:24:21 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: JAEHOON KIM <jhkim@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, pbonzini@redhat.com,
 fam@euphon.net, armbru@redhat.com, eblake@redhat.com,
 berrange@redhat.com, eduardo@habkost.net, dave@treblig.org, sw@weilnetz.de
Subject: Re: [PATCH RFC v1 0/3] aio-poll: improve aio-polling efficiency
Message-ID: <20260224042421.GA1446053@fedora>
References: <20260113174824.464720-1-jhkim@linux.ibm.com>
 <20260219222717.GA1011077@fedora>
 <79c89de8-68f4-46ff-bcce-dcb817d04ad5@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Fzyg9qdQRgEcAh0C"
Content-Disposition: inline
In-Reply-To: <79c89de8-68f4-46ff-bcce-dcb817d04ad5@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1.179, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.717,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--Fzyg9qdQRgEcAh0C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 20, 2026 at 01:00:16PM -0600, JAEHOON KIM wrote:
> On 2/19/2026 4:27 PM, Stefan Hajnoczi wrote:
> > Hi Jaehoon,
> > Following the call earlier this week I ran a single fio job to get a
> > clearer picture of:
> > 1. The QEMU 10.0.0 regression that prompted you to optimize AioContext
> >     polling.
> > 2. How the poll-weight parameter affects IOPS.
> >=20
> > run      rw        bs   numjobs iothreads iops   diff
> > v9.2.0   randread  8k   1       1         174944 3.6%
> > v10.0.0  randread  8k   1       1         174285 3.2%
> > baseline randread  8k   1       1         168908 0.0%
> > w2       randread  8k   1       1         163718 -3.1%
> > w3       randread  8k   1       1         165805 -1.8%
> > w4       randread  8k   1       1         167388 -0.9%
> >=20
> > This time I only ran randread bs=3D8k iodepth=3D8 numjobs=3D1 with a si=
ngle
> > IOThread.
> >=20
> > Observations:
> >=20
> > - There might be an IOPS regression between v10.0.0 and the baseline
> >    (9ad7f544c696) that your patches apply on top of. This is different
> >    from the CPU utilization regression that you found in v9.2.0 ->
> >    v10.0.0. I will bisect it.

I reran v10.0.0, v10.1.0, and the baseline to check for a regression.
The fio results came back not showing a regression. It's weird that the
results I previously posted showed a change, but there doesn't seem to
be a reproducible issue after all.

Stefan

--Fzyg9qdQRgEcAh0C
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmmdJ/QACgkQnKSrs4Gr
c8h0UAgAwL4xuXyhjE8t0jwm6nil9sBfqpTwhkI6MQz/skHZrYHkk5+Eoh9//nLJ
iSdD80U1eW/w24MWgZGrsdIG01rhS6RWKvIxOB/7xeA9xfIws/4V3oBzCDIoLqnu
8sfKlgrS1/EOF884Hlr/MEIrNMNfhP+VQLyMX/Yi60TDtKm6NeqZ32FpIEYjGeyq
05l3Bt+trD7Qz2+ULVY/rizgn8Hbnq3ROqWJX0L90IeYAsoevTQGriBQ1u/peJ1+
JDzV/QwLfhanF6FXUQIi/lpJvPh5Kwkbew3YMhMTRM9ruuwWwKac4v5PBtDSi0Px
3rQkVr7dRxxOc0HqDB8yc2RoDdzNXw==
=uPqw
-----END PGP SIGNATURE-----

--Fzyg9qdQRgEcAh0C--


