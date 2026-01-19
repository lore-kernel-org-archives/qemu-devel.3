Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7B6BD29C56
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 18:17:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhto4-0000n2-2M; Mon, 19 Jan 2026 13:16:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vhtnu-0000jG-Pv
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 13:16:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vhtnt-0006BW-4B
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 13:16:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768846598;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8PpcMtrNpaK+JdxA1c+gRL5Jz2pcpGS1AKnpotrEolY=;
 b=Fi5OqCak52xbZiofcfh5BSCeqKnT0ns5kFZVOJdBmoUPgF747UrFUbcL0HGbjC6TKD3/yh
 hTVT2q5QiaPK30xl3hz0JFDf/nJ5epRdRR0hy5xY79gcrLp1mwUHfXmUqMlmzoZOZitlTv
 RNbF8W1UZQxTw2fVe9jEQN3nNmpD+P0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-P2DfIHM6M9-5SK-jr-7cdw-1; Mon,
 19 Jan 2026 13:16:35 -0500
X-MC-Unique: P2DfIHM6M9-5SK-jr-7cdw-1
X-Mimecast-MFC-AGG-ID: P2DfIHM6M9-5SK-jr-7cdw_1768846594
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EC24119560A1; Mon, 19 Jan 2026 18:16:32 +0000 (UTC)
Received: from localhost (unknown [10.2.16.150])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AE5DC19560AB; Mon, 19 Jan 2026 18:16:31 +0000 (UTC)
Date: Mon, 19 Jan 2026 13:16:30 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jaehoon Kim <jhkim@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, pbonzini@redhat.com,
 fam@euphon.net, armbru@redhat.com, eblake@redhat.com,
 berrange@redhat.com, eduardo@habkost.net, dave@treblig.org, sw@weilnetz.de
Subject: Re: [PATCH RFC v1 0/3] aio-poll: improve aio-polling efficiency
Message-ID: <20260119181630.GA834718@fedora>
References: <20260113174824.464720-1-jhkim@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="e9hiSGwfhh+z78tS"
Content-Disposition: inline
In-Reply-To: <20260113174824.464720-1-jhkim@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
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


--e9hiSGwfhh+z78tS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 11:48:21AM -0600, Jaehoon Kim wrote:
> We evaluated the patches on an s390x host with a single guest using 16
> virtio block devices backed by FCP multipath devices in a separate-disk
> setup, with the I/O scheduler set to 'none' in both host and guest.
>=20
> The fio workload included sequential and random read/write with varying
> numbers of jobs (1,4,8,16) and io_depth of 8. The tests were conducted
> with single and dual iothreads, using the newly introduced poll-weight
> parameter to measure their impact on CPU cost and throughput.
>=20
> Compared to the baseline, across four FIO workload patterns (sequential
> R/W, random R/W), and averaged over FIO job counts of 1, 4, 8, and 16,
> throughput decreased slightly (-3% to -8% for one iothread, -2% to -5%
> for two iothreads), while CPU usage on the s390x host dropped
> significantly (-10% to -25% and -7% to -12%, respectively).

Hi Jaehoon,
I would like to run the same fio benchmarks on a local NVMe drive (<10us
request latency) to see how that type of hardware configuration is
affected. Are the scripts and fio job files available somewhere?

Thanks,
Stefan

--e9hiSGwfhh+z78tS
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmludP4ACgkQnKSrs4Gr
c8hnsAf/aJ1rH5U/dojgWuZ5aw0IHEHQ7OBgTDlsfUY4WAR4XrSK2ymvHf0VbKrV
V0nFQQ/4C2SAtuUcJ6+FMh0QAyEjK4aohL903W4kjLl6bRALPlfb972Z6QyZM1Bj
LtNPR7X2jHRzIim+lLLKHkXD6S2+agpRAmQAlUd7PoLU7RteoRThC0V1lNBozTpz
W/u458guuy4bql3beTftlfWV6Ndv9xQBgaW2gkinlXtoxX15plbZjK825tU5+MVl
Ejg30O9cYzE+siVQyPCsJ+4bPX4FC5BQ8wDqly/kw7ivpyXjvuMyl3EOC8Vrb4ew
NOvs/koFSuBhJnjfFBuBz7U82G4TJQ==
=aQ0Y
-----END PGP SIGNATURE-----

--e9hiSGwfhh+z78tS--


