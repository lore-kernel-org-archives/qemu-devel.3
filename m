Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09CAEC54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 13:46:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmZn5-0001Uu-Bt; Tue, 19 Mar 2024 09:46:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rmZml-0001RB-Vt
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 09:45:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rmZmi-0004OT-Ka
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 09:45:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710855941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y8llUQVMdEehtbmjSVLxOp/7eFiGwgt4+VCI9Z3h7LM=;
 b=dHHBAxtNjOyaz5p+UqyeuLQIiuguckkTCd2ZFVb9tKUUHP6+EjH3psHkMNvJYwX/oMv5fg
 N7ppWdg9bOhx27yZeu1dVVBbt2PH0YGmFfgOU+Kw2yZhCBGYOWq6eaMeRbCi7KTIv83rRZ
 fKgbPjGCN3SFP1qYkc82l2zuJGMYZNk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-FxtOrJfHMTyWCGjUEAOn6g-1; Tue, 19 Mar 2024 09:45:39 -0400
X-MC-Unique: FxtOrJfHMTyWCGjUEAOn6g-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B1A6C85A58C
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 13:45:38 +0000 (UTC)
Received: from localhost (unknown [10.39.195.82])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2F363492BD0;
 Tue, 19 Mar 2024 13:45:37 +0000 (UTC)
Date: Tue, 19 Mar 2024 09:45:32 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Sanjay Rao <srao@redhat.com>,
 Boaz Ben Shabat <bbenshab@redhat.com>, Joe Mario <jmario@redhat.com>
Subject: Re: [PATCH] coroutine: cap per-thread local pool size
Message-ID: <20240319134532.GA1099687@fedora>
References: <20240318183429.1039340-1-stefanha@redhat.com>
 <ZfmT1s8hcW48KIn1@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="dqkUv3Lhb0uJ95zD"
Content-Disposition: inline
In-Reply-To: <ZfmT1s8hcW48KIn1@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


--dqkUv3Lhb0uJ95zD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 02:32:06PM +0100, Kevin Wolf wrote:
> Am 18.03.2024 um 19:34 hat Stefan Hajnoczi geschrieben:
> > The coroutine pool implementation can hit the Linux vm.max_map_count
> > limit, causing QEMU to abort with "failed to allocate memory for stack"
> > or "failed to set up stack guard page" during coroutine creation.
> >=20
> > This happens because per-thread pools can grow to tens of thousands of
> > coroutines. Each coroutine causes 2 virtual memory areas to be created.
> > Eventually vm.max_map_count is reached and memory-related syscalls fail.
> > The per-thread pool sizes are non-uniform and depend on past coroutine
> > usage in each thread, so it's possible for one thread to have a large
> > pool while another thread's pool is empty.
> >=20
> > Switch to a new coroutine pool implementation with a global pool that
> > grows to a maximum number of coroutines and per-thread local pools that
> > are capped at hardcoded small number of coroutines.
> >=20
> > This approach does not leave large numbers of coroutines pooled in a
> > thread that may not use them again. In order to perform well it
> > amortizes the cost of global pool accesses by working in batches of
> > coroutines instead of individual coroutines.
> >=20
> > The global pool is a list. Threads donate batches of coroutines to when
> > they have too many and take batches from when they have too few:
> >=20
> > .-----------------------------------.
> > | Batch 1 | Batch 2 | Batch 3 | ... | global_pool
> > `-----------------------------------'
> >=20
> > Each thread has up to 2 batches of coroutines:
> >=20
> > .-------------------.
> > | Batch 1 | Batch 2 | per-thread local_pool (maximum 2 batches)
> > `-------------------'
> >=20
> > The goal of this change is to reduce the excessive number of pooled
> > coroutines that cause QEMU to abort when vm.max_map_count is reached
> > without losing the performance of an adequately sized coroutine pool.
> >=20
> > Here are virtio-blk disk I/O benchmark results:
> >=20
> >       RW BLKSIZE IODEPTH    OLD    NEW CHANGE
> > randread      4k       1 113725 117451 +3.3%
> > randread      4k       8 192968 198510 +2.9%
> > randread      4k      16 207138 209429 +1.1%
> > randread      4k      32 212399 215145 +1.3%
> > randread      4k      64 218319 221277 +1.4%
> > randread    128k       1  17587  17535 -0.3%
> > randread    128k       8  17614  17616 +0.0%
> > randread    128k      16  17608  17609 +0.0%
> > randread    128k      32  17552  17553 +0.0%
> > randread    128k      64  17484  17484 +0.0%
> >=20
> > See files/{fio.sh,test.xml.j2} for the benchmark configuration:
> > https://gitlab.com/stefanha/virt-playbooks/-/tree/coroutine-pool-fix-si=
zing
> >=20
> > Buglink: https://issues.redhat.com/browse/RHEL-28947
> > Reported-by: Sanjay Rao <srao@redhat.com>
> > Reported-by: Boaz Ben Shabat <bbenshab@redhat.com>
> > Reported-by: Joe Mario <jmario@redhat.com>
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>=20
> Reviewed-by: Kevin Wolf <kwolf@redhat.com>
>=20
> Though I do wonder if we can do something about the slight performance
> degradation that Sanjay reported. We seem to stay well under the hard
> limit, so the reduced global pool size shouldn't be the issue. Maybe
> it's the locking?

I'm not sure if it's the lock. When writing the code I tried to avoid
thresholds that cause batches to bounce between the global and local
thread pools, because that is another way to lose performance. So maybe
it's something related to the algorithm.

> Either way, even though it could be called a fix, I don't think this is
> for 9.0, right?

There is a bug report for the max_map_count issue (RHEL-28947), so I
think this fix should go into QEMU 9.0.

Stefan

--dqkUv3Lhb0uJ95zD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmX5lvwACgkQnKSrs4Gr
c8iQiQgAv8545zXw+HdmCntFlFz2Nv9lrsGSq2zE+e+6iaDsai97+q4DL4dyMqzz
AjOEnimIKs+N/3FbHVXJIYKxabhvXekHV7j5g1yYLXfkFu5d67WNMjbHYKUFZ3j3
YMhbOWfTA/OPW3CioyrIkgJktDMkQpGDeM/ZXqu5cPVlQfz2BkxolU2mtaCiuON2
3hyBKwk87C0Xy5YAzfLDd9qxw6cvKIKkCF+9h3RU30fWsPhxSM8VDCBn4JPJE1TJ
dRU9qVtr4sND6diWk7sHt4nqtVOBqaKKhQ7UXnNM2rWwSvvcizqIVsR1M1soJnBP
FkP691HHgCTld7z90foeZdMdWcfnPA==
=LTQW
-----END PGP SIGNATURE-----

--dqkUv3Lhb0uJ95zD--


