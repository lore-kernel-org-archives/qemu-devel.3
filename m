Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 500A6CA0FE1
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 14:27:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up6Fc-0004IY-Sd; Thu, 21 Aug 2025 10:26:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1up6FW-0004GS-Sb
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 10:26:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1up6FT-0006Yx-6n
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 10:26:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755786393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4O/3j6GfC81y7+lFf2UY1mKCp5mkGQwhBKKa6IDo7d8=;
 b=CRZebNz/yKiOwp8vqKugjKnXWR7TyticsZ2HgJFWHN7mhGNoSS0IUxdySNJOqAKhSMRtqa
 Hrkjxe8D6jiWifCCvjnlCibu6BL+F/2nROTJtM/JA1BRP2Elo2t4HUXWBj3unWweoSlZ5f
 CObIbB39wBIVMNarkiIPDvyzSO/CBso=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-321-KKdSe4I_M32xhqzUGUh5bg-1; Thu,
 21 Aug 2025 10:26:30 -0400
X-MC-Unique: KKdSe4I_M32xhqzUGUh5bg-1
X-Mimecast-MFC-AGG-ID: KKdSe4I_M32xhqzUGUh5bg_1755786388
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D6E6F195D650; Thu, 21 Aug 2025 14:24:47 +0000 (UTC)
Received: from localhost (unknown [10.2.16.124])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 67AFB1800447; Thu, 21 Aug 2025 14:24:46 +0000 (UTC)
Date: Thu, 21 Aug 2025 10:24:45 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Juraj Marcin <jmarcin@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH RFC] bql: Fix bql_locked status with condvar APIs
Message-ID: <20250821142445.GB7010@fedora>
References: <20250820205051.24424-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="WW5ctqpvvABwBlx0"
Content-Disposition: inline
In-Reply-To: <20250820205051.24424-1-peterx@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


--WW5ctqpvvABwBlx0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 04:50:51PM -0400, Peter Xu wrote:
> QEMU has a per-thread "bql_locked" variable stored in TLS section, showing
> whether the current thread is holding the BQL lock.
>=20
> It's a pretty handy variable.  Function-wise, QEMU have codes trying to
> conditionally take bql, relying on the var reflecting the locking status
> (e.g. BQL_LOCK_GUARD), or in a GDB debugging session, we could also look =
at
> the variable (in reality, co_tls_bql_locked), to see which thread is
> currently holding the bql.
>=20
> When using that as a debugging facility, sometimes we can observe multiple
> threads holding bql at the same time. It's because QEMU's condvar APIs
> bypassed the bql_*() API, hence they do not update bql_locked even if they
> have released the mutex while waiting.
>=20
> It can cause confusion if one does "thread apply all p co_tls_bql_locked"
> and see multiple threads reporting true.
>=20
> Fix this by moving the bql status updates into the mutex debug hooks.  Now
> the variable should always reflect the reality.
>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/qemu/main-loop.h  | 18 ++++++++++++++++++
>  util/qemu-thread-common.h |  7 +++++++
>  stubs/iothread-lock.c     |  9 +++++++++
>  system/cpus.c             | 14 ++++++++++++--
>  4 files changed, 46 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/qemu/main-loop.h b/include/qemu/main-loop.h
> index 4e2436b196..44fb430f5b 100644
> --- a/include/qemu/main-loop.h
> +++ b/include/qemu/main-loop.h
> @@ -270,6 +270,24 @@ void rust_bql_mock_lock(void);
>   */
>  bool bql_locked(void);
> =20
> +/**
> + * mutex_is_bql:
> + *
> + * @mutex: the mutex pointer
> + *
> + * Returns whether the mutex is the BQL.
> + */
> +bool mutex_is_bql(QemuMutex *mutex);
> +
> +/**
> + * set_bql_locked:

This does not match the actual function name (bql_update_status()).

> + *
> + * @locked: update status on whether the BQL is locked
> + *
> + * NOTE: this should normally only be invoked when the status changed.
> + */
> +void bql_update_status(bool locked);
> +
>  /**
>   * bql_block: Allow/deny releasing the BQL
>   *
> diff --git a/util/qemu-thread-common.h b/util/qemu-thread-common.h
> index 2af6b12085..09331843ba 100644
> --- a/util/qemu-thread-common.h
> +++ b/util/qemu-thread-common.h
> @@ -14,6 +14,7 @@
>  #define QEMU_THREAD_COMMON_H
> =20
>  #include "qemu/thread.h"
> +#include "qemu/main-loop.h"
>  #include "trace.h"
> =20
>  static inline void qemu_mutex_post_init(QemuMutex *mutex)
> @@ -39,6 +40,9 @@ static inline void qemu_mutex_post_lock(QemuMutex *mute=
x,
>      mutex->line =3D line;
>  #endif
>      trace_qemu_mutex_locked(mutex, file, line);
> +    if (mutex_is_bql(mutex)) {
> +        bql_update_status(true);
> +    }
>  }
> =20
>  static inline void qemu_mutex_pre_unlock(QemuMutex *mutex,
> @@ -49,6 +53,9 @@ static inline void qemu_mutex_pre_unlock(QemuMutex *mut=
ex,
>      mutex->line =3D 0;
>  #endif
>      trace_qemu_mutex_unlock(mutex, file, line);
> +    if (mutex_is_bql(mutex)) {
> +        bql_update_status(false);
> +    }
>  }
> =20
>  #endif
> diff --git a/stubs/iothread-lock.c b/stubs/iothread-lock.c
> index 6050c081f5..c89c9c7228 100644
> --- a/stubs/iothread-lock.c
> +++ b/stubs/iothread-lock.c
> @@ -34,3 +34,12 @@ void bql_block_unlock(bool increase)
>      assert((new_value > bql_unlock_blocked) =3D=3D increase);
>      bql_unlock_blocked =3D new_value;
>  }
> +
> +bool mutex_is_bql(QemuMutex *mutex)
> +{
> +    return false;
> +}
> +
> +void bql_update_status(bool locked)
> +{
> +}
> diff --git a/system/cpus.c b/system/cpus.c
> index 256723558d..0bf677c4a2 100644
> --- a/system/cpus.c
> +++ b/system/cpus.c
> @@ -517,6 +517,18 @@ bool qemu_in_vcpu_thread(void)
> =20
>  QEMU_DEFINE_STATIC_CO_TLS(bool, bql_locked)
> =20
> +bool mutex_is_bql(QemuMutex *mutex)
> +{
> +    return mutex =3D=3D &bql;
> +}
> +
> +void bql_update_status(bool locked)
> +{
> +    /* This function should only be used when an update happened.. */
> +    assert(bql_locked() !=3D locked);
> +    set_bql_locked(locked);
> +}
> +
>  static uint32_t bql_unlock_blocked;
> =20
>  void bql_block_unlock(bool increase)
> @@ -557,14 +569,12 @@ void bql_lock_impl(const char *file, int line)
> =20
>      g_assert(!bql_locked());
>      bql_lock_fn(&bql, file, line);
> -    set_bql_locked(true);
>  }
> =20
>  void bql_unlock(void)
>  {
>      g_assert(bql_locked());
>      g_assert(!bql_unlock_blocked);
> -    set_bql_locked(false);
>      qemu_mutex_unlock(&bql);
>  }
> =20
> --=20
> 2.50.1
>=20

--WW5ctqpvvABwBlx0
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAminLC0ACgkQnKSrs4Gr
c8jpmwf/dn/VZJiIOttti4R6v950nzZmGpumi9rP8YRWo663MlEKm6DacG7C5LGo
hOZ4nO795X1ptXNNVqpy7sGlnyyH5FAdNchcCeZQvMdsCtiyWwW6BO4A5nOc9Lv2
I/E/VIKtk5RQBhR0WV0vgOXdVSHl4N+yFUYfrwuezL7JtsDs4mpaY1N1Qi5uutnu
Mxf1THssaIf4r43f93hGf57UUsjKRZrLxjmcP1KKReljT85VJhZUGRYB+NOlqsFw
oeRw91qaYbUsbLw1Qpnqfh3kRb3sO9EodRfONUUGvGMHHnTZ0tpeJD0GXksM457f
jjhZ3UKXA96tRo3lh9mqLttFjd2iaA==
=YbXw
-----END PGP SIGNATURE-----

--WW5ctqpvvABwBlx0--


