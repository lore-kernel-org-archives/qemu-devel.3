Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C560C021AA
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 00:38:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkuZP-0007kk-Nc; Wed, 19 Feb 2025 19:37:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tkuZI-0007kQ-EZ
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 19:37:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tkuZF-0007CC-7t
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 19:37:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740011842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S8vmM1mO63WOLrBkG3zgcYwdA/0aO/3p9VWmWdsUPU0=;
 b=M0PGpWlv81DRUi9TqLRwYaWm9qIC8nIx4xacRNfzrSN+PqkwNKMhGCKd2/hTp0yKwPBR4X
 xs42kMIiE44bE6NyrtdLWW6ztsQryuguYefLHy5uD+iLE8zvlhGhdgThrwOY5CM/2BXEev
 btGRGQxUvn9YltnAfGRjZ1gDtpzX1N0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-19-pDt_fS2jN6WbAJk3c2Vqtg-1; Wed,
 19 Feb 2025 19:37:20 -0500
X-MC-Unique: pDt_fS2jN6WbAJk3c2Vqtg-1
X-Mimecast-MFC-AGG-ID: pDt_fS2jN6WbAJk3c2Vqtg_1740011838
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 74AE619783B2; Thu, 20 Feb 2025 00:37:15 +0000 (UTC)
Received: from localhost (unknown [10.2.16.36])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7250F300019F; Thu, 20 Feb 2025 00:37:12 +0000 (UTC)
Date: Thu, 20 Feb 2025 08:37:09 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Vitalii Mordan <mordan@ispras.ru>
Cc: Thomas Huth <thuth@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 sdl.qemu@linuxtesting.org, Vadim Mutilin <mutilin@ispras.ru>,
 Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: Re: [PATCH] Fix data race with the state Field of ThreadPoolElement
Message-ID: <20250220003709.GA105402@fedora>
References: <20250219161223.3340431-1-mordan@ispras.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Ca+mx8UAPY3Tie+L"
Content-Disposition: inline
In-Reply-To: <20250219161223.3340431-1-mordan@ispras.ru>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.191,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


--Ca+mx8UAPY3Tie+L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 07:12:23PM +0300, Vitalii Mordan wrote:
> TSAN reports a potential data race on the state field of
> ThreadPoolElement. This is fixed by using atomic access to the field.

The tsan output from the bug report:

WARNING: ThreadSanitizer: data race (pid=3D787043)
  Write of size 4 at 0x7b1c00000660 by thread T5 (mutexes: write M0):
    #0 worker_thread /home/mordan/qemu/build/../util/thread-pool.c:108:20 (=
test-thread-pool-smc+0xa65a56)
    #1 qemu_thread_start /home/mordan/qemu/build/../util/qemu-thread-posix.=
c:543:9 (test-thread-pool-smc+0xa49040)

  Previous read of size 4 at 0x7b1c00000660 by main thread:
    #0 thread_pool_completion_bh /home/mordan/qemu/build/../util/thread-poo=
l.c:183:19 (test-thread-pool-smc+0xa6549d)
    #1 aio_bh_call /home/mordan/qemu/build/../util/async.c:171:5 (test-thre=
ad-pool-smc+0xa5e03e)
    #2 aio_bh_poll /home/mordan/qemu/build/../util/async.c:218:13 (test-thr=
ead-pool-smc+0xa5e03e)
    #3 aio_poll /home/mordan/qemu/build/../util/aio-posix.c:722:17 (test-th=
read-pool-smc+0xa4343a)
    #4 test_submit_many /home/mordan/qemu/build/../tests/unit/test-thread-p=
ool-smc.c:133:9 (test-thread-pool-smc+0x50e638)
    #5 do_test_cancel /home/mordan/qemu/build/../tests/unit/test-thread-poo=
l-smc.c:150:5 (test-thread-pool-smc+0x50e638)
    #6 test_cancel_async /home/mordan/qemu/build/../tests/unit/test-thread-=
pool-smc.c:234:5 (test-thread-pool-smc+0x50e638)
    #7 main /home/mordan/qemu/build/../tests/unit/test-thread-pool-smc.c:24=
9:3 (test-thread-pool-smc+0x50e638)

  Location is heap block of size 104 at 0x7b1c00000620 allocated by main th=
read:
    #0 malloc out/lib/clangrt-x86_64-unknown-linux-gnu/./out/lib/clangrt-x8=
6_64-unknown-linux-gnu/./toolchain/llvm-project/compiler-rt/lib/tsan/rtl/ts=
an_interceptors_posix.cpp:667:5 (test-thread-pool-smc+0x346131)
    #1 g_malloc <null> (libglib-2.0.so.0+0x5e738) (BuildId: e845b8fd2f39687=
2c036976626389ffc4f50c9c5)
    #2 thread_pool_submit_aio /home/mordan/qemu/build/../util/thread-pool.c=
:251:11 (test-thread-pool-smc+0xa648bd)
    #3 test_submit_many /home/mordan/qemu/build/../tests/unit/test-thread-p=
ool-smc.c:128:9 (test-thread-pool-smc+0x50e600)
    #4 do_test_cancel /home/mordan/qemu/build/../tests/unit/test-thread-poo=
l-smc.c:150:5 (test-thread-pool-smc+0x50e600)
    #5 test_cancel_async /home/mordan/qemu/build/../tests/unit/test-thread-=
pool-smc.c:234:5 (test-thread-pool-smc+0x50e600)
    #6 main /home/mordan/qemu/build/../tests/unit/test-thread-pool-smc.c:24=
9:3 (test-thread-pool-smc+0x50e600)

  Mutex M0 (0x7b3c00000100) created at:
    #0 pthread_mutex_init out/lib/clangrt-x86_64-unknown-linux-gnu/./out/li=
b/clangrt-x86_64-unknown-linux-gnu/./toolchain/llvm-project/compiler-rt/lib=
/tsan/rtl/tsan_interceptors_posix.cpp:1316:3 (test-thread-pool-smc+0x34914f)
    #1 qemu_mutex_init /home/mordan/qemu/build/../util/qemu-thread-posix.c:=
71:11 (test-thread-pool-smc+0xa47189)
    #2 thread_pool_init_one /home/mordan/qemu/build/../util/thread-pool.c:3=
34:5 (test-thread-pool-smc+0xa64f60)
    #3 thread_pool_new /home/mordan/qemu/build/../util/thread-pool.c:348:5 =
(test-thread-pool-smc+0xa64f60)
    #4 aio_get_thread_pool /home/mordan/qemu/build/../util/async.c:441:28 (=
test-thread-pool-smc+0xa5e6d4)
    #5 thread_pool_submit_aio /home/mordan/qemu/build/../util/thread-pool.c=
:246:24 (test-thread-pool-smc+0xa6488d)
    #6 test_submit_many /home/mordan/qemu/build/../tests/unit/test-thread-p=
ool-smc.c:128:9 (test-thread-pool-smc+0x50e600)
    #7 do_test_cancel /home/mordan/qemu/build/../tests/unit/test-thread-poo=
l-smc.c:150:5 (test-thread-pool-smc+0x50e600)
    #8 test_cancel_async /home/mordan/qemu/build/../tests/unit/test-thread-=
pool-smc.c:234:5 (test-thread-pool-smc+0x50e600)
    #9 main /home/mordan/qemu/build/../tests/unit/test-thread-pool-smc.c:24=
9:3 (test-thread-pool-smc+0x50e600)

  Thread T5 'worker' (tid=3D787049, running) created by thread T4 at:
    #0 pthread_create out/lib/clangrt-x86_64-unknown-linux-gnu/./out/lib/cl=
angrt-x86_64-unknown-linux-gnu/./toolchain/llvm-project/compiler-rt/lib/tsa=
n/rtl/tsan_interceptors_posix.cpp:1022:3 (test-thread-pool-smc+0x34791d)
    #1 qemu_thread_create /home/mordan/qemu/build/../util/qemu-thread-posix=
=2Ec:583:11 (test-thread-pool-smc+0xa48ed0)
    #2 do_spawn_thread /home/mordan/qemu/build/../util/thread-pool.c:146:5 =
(test-thread-pool-smc+0xa658de)
    #3 worker_thread /home/mordan/qemu/build/../util/thread-pool.c:83:5 (te=
st-thread-pool-smc+0xa658de)
    #4 qemu_thread_start /home/mordan/qemu/build/../util/qemu-thread-posix.=
c:543:9 (test-thread-pool-smc+0xa49040)

SUMMARY: ThreadSanitizer: data race /home/mordan/qemu/build/../util/thread-=
pool.c:108:20 in worker_thread

My interpretation is that tsan is saying there is a data race between
the load in thread_pool_completion_bh():

  static void thread_pool_completion_bh(void *opaque)
  {
      ThreadPool *pool =3D opaque;
      ThreadPoolElement *elem, *next;

      defer_call_begin(); /* cb() may use defer_call() to coalesce work */

  restart:
      QLIST_FOREACH_SAFE(elem, &pool->head, all, next) {
          if (elem->state !=3D THREAD_DONE) {
	      ^^^^^^^^^^^

and the store in worker_thread():

    req =3D QTAILQ_FIRST(&pool->request_list);
    QTAILQ_REMOVE(&pool->request_list, req, reqs);
    req->state =3D THREAD_ACTIVE;
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^
    qemu_mutex_unlock(&pool->lock);

It doesn't matter whether thread_pool_completion_bh() sees THREAD_QUEUED
or THREAD_ACTIVE, so this looks like a false positive. There is no
practical effect either way.

THREAD_QUEUED vs THREAD_ACTIVE matters in thread_pool_cancel(), but that
is protected by pool->lock.

Paolo: Any thoughts?

Stefan

>=20
> Fixes: d354c7eccf ("aio: add generic thread-pool facility")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2822
> Signed-off-by: Vitalii Mordan <mordan@ispras.ru>
> ---
>  util/thread-pool.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>=20
> diff --git a/util/thread-pool.c b/util/thread-pool.c
> index 27eb777e85..6c5f4d085b 100644
> --- a/util/thread-pool.c
> +++ b/util/thread-pool.c
> @@ -111,9 +111,8 @@ static void *worker_thread(void *opaque)
>          ret =3D req->func(req->arg);
> =20
>          req->ret =3D ret;
> -        /* Write ret before state.  */
> -        smp_wmb();
> -        req->state =3D THREAD_DONE;
> +        /* Atomically update state after setting ret.  */
> +        qatomic_store_release(&req->state, THREAD_DONE);
> =20
>          qemu_bh_schedule(pool->completion_bh);
>          qemu_mutex_lock(&pool->lock);
> @@ -180,7 +179,7 @@ static void thread_pool_completion_bh(void *opaque)
> =20
>  restart:
>      QLIST_FOREACH_SAFE(elem, &pool->head, all, next) {
> -        if (elem->state !=3D THREAD_DONE) {
> +        if (qatomic_load_acquire(&elem->state) !=3D THREAD_DONE) {
>              continue;
>          }
> =20
> @@ -223,12 +222,12 @@ static void thread_pool_cancel(BlockAIOCB *acb)
>      trace_thread_pool_cancel(elem, elem->common.opaque);
> =20
>      QEMU_LOCK_GUARD(&pool->lock);
> -    if (elem->state =3D=3D THREAD_QUEUED) {
> +    if (qatomic_load_acquire(&elem->state) =3D=3D THREAD_QUEUED) {
>          QTAILQ_REMOVE(&pool->request_list, elem, reqs);
>          qemu_bh_schedule(pool->completion_bh);
> =20
> -        elem->state =3D THREAD_DONE;
>          elem->ret =3D -ECANCELED;
> +        qatomic_store_release(&elem->state, THREAD_DONE);
>      }
> =20
>  }
> @@ -251,8 +250,8 @@ BlockAIOCB *thread_pool_submit_aio(ThreadPoolFunc *fu=
nc, void *arg,
>      req =3D qemu_aio_get(&thread_pool_aiocb_info, NULL, cb, opaque);
>      req->func =3D func;
>      req->arg =3D arg;
> -    req->state =3D THREAD_QUEUED;
>      req->pool =3D pool;
> +    qatomic_store_release(&req->state, THREAD_QUEUED);
> =20
>      QLIST_INSERT_HEAD(&pool->head, req, all);
> =20
> --=20
> 2.34.1
>=20

--Ca+mx8UAPY3Tie+L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAme2eTUACgkQnKSrs4Gr
c8hcVwf+Pl86nNcx5NwBE8BPIa9MWjFYwMt5cKGNW9qP2c78+lqZFxePX+5vust9
B3yeNibJTgrdhqjvhIljkHbPNuHaXTC/qtBP2M44FQ+K8C2jCujB2mW6XCF+w9oD
uG9zkgW7n1RPQIQ0yfP52O5Khbz/Wgs6HHFpw95D158FLUSypFdVH+lmNUeRGmQZ
rBq6PZAyOH4JgWYC6ypBJDL4QEgZOCZoUfMyY/VYG7aibOrKXw5Vi+RtDJbRhLGN
JWK+JLjzQsUM8OgshysA9O5Pv7Urgl4j858bRSh6xTNQGCtMgDP3uf5zqK/FapQn
qgeE/Xmaen224Ee7pPh8/ljGLTaWxw==
=CedH
-----END PGP SIGNATURE-----

--Ca+mx8UAPY3Tie+L--


