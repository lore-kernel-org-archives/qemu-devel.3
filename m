Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0D99C3600B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 15:57:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txpaZ-00073F-Ox; Thu, 27 Mar 2025 11:56:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1txpaS-00072e-UV
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 11:56:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1txpaP-0000Fx-44
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 11:56:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743090963;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IilffKrHMHqZlb2HSPLrJUeya/4/pVas9u4Z7ttysJE=;
 b=XAfeyyMj7BjctvP7vVR604bQxHfHZxFqzvGtqmBOypc1lKtheF7qipDLTKoqe7GwCHX+b1
 MyP/g9lYPmAGb0k4zd2p+f9IshQZCwj5tI9eVtZZ3OEn+txaUl0eLaAaM5tbe7f/XPHRe3
 XoVdQh4hTRDIXIKqSEUS75dQgzRKX8U=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-ugDXUKVyPT-PJRJlhDIs9g-1; Thu,
 27 Mar 2025 11:56:00 -0400
X-MC-Unique: ugDXUKVyPT-PJRJlhDIs9g-1
X-Mimecast-MFC-AGG-ID: ugDXUKVyPT-PJRJlhDIs9g_1743090959
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B92D518EBE91; Thu, 27 Mar 2025 15:55:59 +0000 (UTC)
Received: from localhost (unknown [10.2.16.93])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1A9BD1956095; Thu, 27 Mar 2025 15:55:58 +0000 (UTC)
Date: Thu, 27 Mar 2025 11:55:57 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 14/15] fuse: Implement multi-threading
Message-ID: <20250327155557.GN37458@fedora>
References: <20250325160529.117543-1-hreitz@redhat.com>
 <20250325160655.119407-13-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="IeAEo9zzPRzuKp0E"
Content-Disposition: inline
In-Reply-To: <20250325160655.119407-13-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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


--IeAEo9zzPRzuKp0E
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 05:06:54PM +0100, Hanna Czenczek wrote:
> FUSE allows creating multiple request queues by "cloning" /dev/fuse FDs
> (via open("/dev/fuse") + ioctl(FUSE_DEV_IOC_CLONE)).
>=20
> We can use this to implement multi-threading.
>=20
> Note that the interface presented here differs from the multi-queue
> interface of virtio-blk: The latter maps virtqueues to iothreads, which
> allows processing multiple virtqueues in a single iothread.  The
> equivalent (processing multiple FDs in a single iothread) would not make
> sense for FUSE because those FDs are used in a round-robin fashion by
> the FUSE kernel driver.  Putting two of them into a single iothread will
> just create a bottleneck.

This text might be outdated. virtio-blk's new iothread-vq-mapping
parameter provides the "array of iothreads" mentioned below and a way to
assign virtqueues to those IOThreads.

>=20
> Therefore, all we need is an array of iothreads, and we will create one
> "queue" (FD) per thread.
>=20
> These are the benchmark results when using four threads (compared to a
> single thread); note that fio still only uses a single job, but
> performance can still be improved because of said round-robin usage for
> the queues.  (Not in the sync case, though, in which case I guess it
> just adds overhead.)

Interesting. FUSE-over-io_uring seems to be different from
FUSE_DEV_IOC_CLONE here. It doesn't do round-robin. It uses CPU affinity
instead, handing requests to the io_uring context associated with the
current CPU when possible.

>=20
> file:
>   read:
>     seq aio:   264.8k =B10.8k (+120 %)
>     rand aio:  143.8k =B10.4k (+ 27 %)
>     seq sync:   49.9k =B10.5k (-  5 %)
>     rand sync:  10.3k =B10.1k (-  1 %)
>   write:
>     seq aio:   226.6k =B12.1k (+184 %)
>     rand aio:  225.9k =B11.8k (+186 %)
>     seq sync:   36.9k =B10.6k (- 11 %)
>     rand sync:  36.9k =B10.2k (- 11 %)
> null:
>   read:
>     seq aio:   315.2k =B111.0k (+18 %)
>     rand aio:  300.5k =B110.8k (+14 %)
>     seq sync:  114.2k =B1 3.6k (-16 %)
>     rand sync: 112.5k =B1 2.8k (-16 %)
>   write:
>     seq aio:   222.6k =B16.8k (-21 %)
>     rand aio:  220.5k =B16.8k (-23 %)
>     seq sync:  117.2k =B13.7k (-18 %)
>     rand sync: 116.3k =B14.4k (-18 %)
>=20
> (I don't know what's going on in the null-write AIO case, sorry.)
>=20
> Here's results for numjobs=3D4:
>=20
> "Before", i.e. without multithreading in QSD/FUSE (results compared to
> numjobs=3D1):
>=20
> file:
>   read:
>     seq aio:   104.7k =B1 0.4k (- 13 %)
>     rand aio:  111.5k =B1 0.4k (-  2 %)
>     seq sync:   71.0k =B113.8k (+ 36 %)
>     rand sync:  41.4k =B1 0.1k (+297 %)
>   write:
>     seq aio:    79.4k =B10.1k (-  1 %)
>     rand aio:   78.6k =B10.1k (=B1  0 %)
>     seq sync:   83.3k =B10.1k (+101 %)
>     rand sync:  82.0k =B10.2k (+ 98 %)
> null:
>   read:
>     seq aio:   260.5k =B11.5k (-  2 %)
>     rand aio:  260.1k =B11.4k (-  2 %)
>     seq sync:  291.8k =B11.3k (+115 %)
>     rand sync: 280.1k =B11.7k (+115 %)
>   write:
>     seq aio:   280.1k =B11.7k (=B1  0 %)
>     rand aio:  279.5k =B11.4k (-  3 %)
>     seq sync:  306.7k =B12.2k (+116 %)
>     rand sync: 305.9k =B11.8k (+117 %)
>=20
> (As probably expected, little difference in the AIO case, but great
> improvements in the sync case because it kind of gives it an artificial
> iodepth of 4.)
>=20
> "After", i.e. with four threads in QSD/FUSE (now results compared to the
> above):
>=20
> file:
>   read:
>     seq aio:   193.3k =B1 1.8k (+ 85 %)
>     rand aio:  329.3k =B1 0.3k (+195 %)
>     seq sync:   66.2k =B113.0k (-  7 %)
>     rand sync:  40.1k =B1 0.0k (-  3 %)
>   write:
>     seq aio:   219.7k =B10.8k (+177 %)
>     rand aio:  217.2k =B11.5k (+176 %)
>     seq sync:   92.5k =B10.2k (+ 11 %)
>     rand sync:  91.9k =B10.2k (+ 12 %)
> null:
>   read:
>     seq aio:   706.7k =B12.1k (+171 %)
>     rand aio:  714.7k =B13.2k (+175 %)
>     seq sync:  431.7k =B13.0k (+ 48 %)
>     rand sync: 435.4k =B12.8k (+ 50 %)
>   write:
>     seq aio:   746.9k =B12.8k (+167 %)
>     rand aio:  749.0k =B14.9k (+168 %)
>     seq sync:  420.7k =B13.1k (+ 37 %)
>     rand sync: 419.1k =B12.5k (+ 37 %)
>=20
> So this helps mainly for the AIO cases, but also in the null sync cases,
> because null is always CPU-bound, so more threads help.
>=20
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  qapi/block-export.json |   8 +-
>  block/export/fuse.c    | 214 +++++++++++++++++++++++++++++++++--------
>  2 files changed, 179 insertions(+), 43 deletions(-)
>=20
> diff --git a/qapi/block-export.json b/qapi/block-export.json
> index c783e01a53..0bdd5992eb 100644
> --- a/qapi/block-export.json
> +++ b/qapi/block-export.json
> @@ -179,12 +179,18 @@
>  #     mount the export with allow_other, and if that fails, try again
>  #     without.  (since 6.1; default: auto)
>  #
> +# @iothreads: Enables multi-threading: Handle requests in each of the
> +#     given iothreads (instead of the block device's iothread, or the
> +#     export's "main" iothread).  For this, the FUSE FD is duplicated so
> +#     there is one FD per iothread.  (since 10.1)

This option isn't FUSE-specific but FUSE is the first export type to
support it. Please add it to BlockExportOptions instead and refuse
export creation when the export type only supports 1 IOThread.

Eric: Are you interested in implementing support for multiple IOThreads
in the NBD export? I remember some time ago we talked about NBD
multi-conn support, although maybe that was for the client rather than
the server.

> +#
>  # Since: 6.0
>  ##
>  { 'struct': 'BlockExportOptionsFuse',
>    'data': { 'mountpoint': 'str',
>              '*growable': 'bool',
> -            '*allow-other': 'FuseExportAllowOther' },
> +            '*allow-other': 'FuseExportAllowOther',
> +            '*iothreads': ['str'] },
>    'if': 'CONFIG_FUSE' }
> =20
>  ##
> diff --git a/block/export/fuse.c b/block/export/fuse.c
> index 345e833171..0edd994392 100644
> --- a/block/export/fuse.c
> +++ b/block/export/fuse.c
> @@ -31,11 +31,14 @@
>  #include "qemu/error-report.h"
>  #include "qemu/main-loop.h"
>  #include "system/block-backend.h"
> +#include "system/block-backend.h"
> +#include "system/iothread.h"
> =20
>  #include <fuse.h>
>  #include <fuse_lowlevel.h>
> =20
>  #include "standard-headers/linux/fuse.h"
> +#include <sys/ioctl.h>
> =20
>  #if defined(CONFIG_FALLOCATE_ZERO_RANGE)
>  #include <linux/falloc.h>
> @@ -50,12 +53,17 @@
>  /* Small enough to fit in the request buffer */
>  #define FUSE_MAX_WRITE_BYTES (4 * 1024)
> =20
> -typedef struct FuseExport {
> -    BlockExport common;
> +typedef struct FuseExport FuseExport;
> =20
> -    struct fuse_session *fuse_session;
> -    unsigned int in_flight; /* atomic */
> -    bool mounted, fd_handler_set_up;
> +/*
> + * One FUSE "queue", representing one FUSE FD from which requests are fe=
tched
> + * and processed.  Each queue is tied to an AioContext.
> + */
> +typedef struct FuseQueue {
> +    FuseExport *exp;
> +
> +    AioContext *ctx;
> +    int fuse_fd;
> =20
>      /*
>       * The request buffer must be able to hold a full write, and/or at l=
east
> @@ -66,6 +74,14 @@ typedef struct FuseExport {
>               FUSE_MAX_WRITE_BYTES,
>          FUSE_MIN_READ_BUFFER
>      )];
> +} FuseQueue;
> +
> +struct FuseExport {
> +    BlockExport common;
> +
> +    struct fuse_session *fuse_session;
> +    unsigned int in_flight; /* atomic */
> +    bool mounted, fd_handler_set_up;
> =20
>      /*
>       * Set when there was an unrecoverable error and no requests should =
be read
> @@ -74,7 +90,15 @@ typedef struct FuseExport {
>       */
>      bool halted;
> =20
> -    int fuse_fd;
> +    int num_queues;
> +    FuseQueue *queues;
> +    /*
> +     * True if this export should follow the generic export's AioContext.
> +     * Will be false if the queues' AioContexts have been explicitly set=
 by the
> +     * user, i.e. are expected to stay in those contexts.
> +     * (I.e. is always false if there is more than one queue.)
> +     */
> +    bool follow_aio_context;
> =20
>      char *mountpoint;
>      bool writable;
> @@ -85,11 +109,11 @@ typedef struct FuseExport {
>      mode_t st_mode;
>      uid_t st_uid;
>      gid_t st_gid;
> -} FuseExport;
> +};
> =20
>  /* Parameters to the request processing coroutine */
>  typedef struct FuseRequestCoParam {
> -    FuseExport *exp;
> +    FuseQueue *q;
>      int got_request;
>  } FuseRequestCoParam;
> =20
> @@ -102,12 +126,13 @@ static void fuse_export_halt(FuseExport *exp);
>  static void init_exports_table(void);
> =20
>  static int mount_fuse_export(FuseExport *exp, Error **errp);
> +static int clone_fuse_fd(int fd, Error **errp);
> =20
>  static bool is_regular_file(const char *path, Error **errp);
> =20
>  static bool poll_fuse_fd(void *opaque);
>  static void read_fuse_fd(void *opaque);
> -static void coroutine_fn fuse_co_process_request(FuseExport *exp);
> +static void coroutine_fn fuse_co_process_request(FuseQueue *q);
> =20
>  static void fuse_inc_in_flight(FuseExport *exp)
>  {
> @@ -137,9 +162,11 @@ static void fuse_attach_handlers(FuseExport *exp)
>          return;
>      }
> =20
> -    aio_set_fd_handler(exp->common.ctx, exp->fuse_fd,
> -                       read_fuse_fd, NULL, poll_fuse_fd,
> -                       read_fuse_fd, exp);
> +    for (int i =3D 0; i < exp->num_queues; i++) {
> +        aio_set_fd_handler(exp->queues[i].ctx, exp->queues[i].fuse_fd,
> +                           read_fuse_fd, NULL, poll_fuse_fd,
> +                           read_fuse_fd, &exp->queues[i]);
> +    }
>      exp->fd_handler_set_up =3D true;
>  }
> =20
> @@ -148,8 +175,10 @@ static void fuse_attach_handlers(FuseExport *exp)
>   */
>  static void fuse_detach_handlers(FuseExport *exp)
>  {
> -    aio_set_fd_handler(exp->common.ctx, exp->fuse_fd,
> -                       NULL, NULL, NULL, NULL, NULL);
> +    for (int i =3D 0; i < exp->num_queues; i++) {
> +        aio_set_fd_handler(exp->queues[i].ctx, exp->queues[i].fuse_fd,
> +                           NULL, NULL, NULL, NULL, NULL);
> +    }
>      exp->fd_handler_set_up =3D false;
>  }
> =20
> @@ -164,6 +193,11 @@ static void fuse_export_drained_end(void *opaque)
> =20
>      /* Refresh AioContext in case it changed */
>      exp->common.ctx =3D blk_get_aio_context(exp->common.blk);
> +    if (exp->follow_aio_context) {
> +        assert(exp->num_queues =3D=3D 1);
> +        exp->queues[0].ctx =3D exp->common.ctx;
> +    }
> +
>      fuse_attach_handlers(exp);
>  }
> =20
> @@ -187,10 +221,52 @@ static int fuse_export_create(BlockExport *blk_exp,
>      ERRP_GUARD(); /* ensure clean-up even with error_fatal */
>      FuseExport *exp =3D container_of(blk_exp, FuseExport, common);
>      BlockExportOptionsFuse *args =3D &blk_exp_args->u.fuse;
> +    FuseQueue *q;
>      int ret;
> =20
>      assert(blk_exp_args->type =3D=3D BLOCK_EXPORT_TYPE_FUSE);
> =20
> +    if (args->iothreads) {
> +        strList *e;
> +
> +        exp->follow_aio_context =3D false;
> +        exp->num_queues =3D 0;
> +        for (e =3D args->iothreads; e; e =3D e->next) {
> +            exp->num_queues++;
> +        }
> +        if (exp->num_queues < 1) {
> +            error_setg(errp, "Need at least one queue");
> +            ret =3D -EINVAL;
> +            goto fail;
> +        }
> +        exp->queues =3D g_new0(FuseQueue, exp->num_queues);
> +        q =3D exp->queues;
> +        for (e =3D args->iothreads; e; e =3D e->next) {
> +            IOThread *iothread =3D iothread_by_id(e->value);
> +
> +            if (!iothread) {
> +                error_setg(errp, "IOThread \"%s\" does not exist", e->va=
lue);
> +                ret =3D -EINVAL;
> +                goto fail;
> +            }
> +
> +            *(q++) =3D (FuseQueue) {
> +                .exp =3D exp,
> +                .ctx =3D iothread_get_aio_context(iothread),
> +                .fuse_fd =3D -1,
> +            };
> +        }
> +    } else {
> +        exp->follow_aio_context =3D true;
> +        exp->num_queues =3D 1;
> +        exp->queues =3D g_new(FuseQueue, exp->num_queues);
> +        exp->queues[0] =3D (FuseQueue) {
> +            .exp =3D exp,
> +            .ctx =3D exp->common.ctx,
> +            .fuse_fd =3D -1,
> +        };
> +    }
> +
>      /* For growable and writable exports, take the RESIZE permission */
>      if (args->growable || blk_exp_args->writable) {
>          uint64_t blk_perm, blk_shared_perm;
> @@ -275,14 +351,24 @@ static int fuse_export_create(BlockExport *blk_exp,
> =20
>      g_hash_table_insert(exports, g_strdup(exp->mountpoint), NULL);
> =20
> -    exp->fuse_fd =3D fuse_session_fd(exp->fuse_session);
> -    ret =3D fcntl(exp->fuse_fd, F_SETFL, O_NONBLOCK);
> +    assert(exp->num_queues >=3D 1);
> +    exp->queues[0].fuse_fd =3D fuse_session_fd(exp->fuse_session);
> +    ret =3D fcntl(exp->queues[0].fuse_fd, F_SETFL, O_NONBLOCK);
>      if (ret < 0) {
>          ret =3D -errno;
>          error_setg_errno(errp, errno, "Failed to make FUSE FD non-blocki=
ng");
>          goto fail;
>      }
> =20
> +    for (int i =3D 1; i < exp->num_queues; i++) {
> +        int fd =3D clone_fuse_fd(exp->queues[0].fuse_fd, errp);
> +        if (fd < 0) {
> +            ret =3D fd;
> +            goto fail;
> +        }
> +        exp->queues[i].fuse_fd =3D fd;
> +    }
> +
>      fuse_attach_handlers(exp);
>      return 0;
> =20
> @@ -355,6 +441,39 @@ static int mount_fuse_export(FuseExport *exp, Error =
**errp)
>      return 0;
>  }
> =20
> +/**
> + * Clone the given /dev/fuse file descriptor, yielding a second FD from =
which
> + * requests can be pulled for the associated filesystem.  Returns an FD =
on
> + * success, and -errno on error.
> + */
> +static int clone_fuse_fd(int fd, Error **errp)
> +{
> +    uint32_t src_fd =3D fd;
> +    int new_fd;
> +    int ret;
> +
> +    /*
> +     * The name "/dev/fuse" is fixed, see libfuse's lib/fuse_loop_mt.c
> +     * (fuse_clone_chan()).
> +     */
> +    new_fd =3D open("/dev/fuse", O_RDWR | O_CLOEXEC | O_NONBLOCK);
> +    if (new_fd < 0) {
> +        ret =3D -errno;
> +        error_setg_errno(errp, errno, "Failed to open /dev/fuse");
> +        return ret;
> +    }
> +
> +    ret =3D ioctl(new_fd, FUSE_DEV_IOC_CLONE, &src_fd);
> +    if (ret < 0) {
> +        ret =3D -errno;
> +        error_setg_errno(errp, errno, "Failed to clone FUSE FD");
> +        close(new_fd);
> +        return ret;
> +    }
> +
> +    return new_fd;
> +}
> +
>  /**
>   * Try to read a single request from the FUSE FD.
>   * Takes a FuseRequestCoParam object pointer in `opaque`.
> @@ -370,8 +489,9 @@ static int mount_fuse_export(FuseExport *exp, Error *=
*errp)
>  static void coroutine_fn co_read_from_fuse_fd(void *opaque)
>  {
>      FuseRequestCoParam *co_param =3D opaque;
> -    FuseExport *exp =3D co_param->exp;
> -    int fuse_fd =3D exp->fuse_fd;
> +    FuseQueue *q =3D co_param->q;
> +    int fuse_fd =3D q->fuse_fd;
> +    FuseExport *exp =3D q->exp;
>      ssize_t ret;
>      const struct fuse_in_header *in_hdr;
> =20
> @@ -381,8 +501,7 @@ static void coroutine_fn co_read_from_fuse_fd(void *o=
paque)
>          goto no_request;
>      }
> =20
> -    ret =3D RETRY_ON_EINTR(read(fuse_fd, exp->request_buf,
> -                              sizeof(exp->request_buf)));
> +    ret =3D RETRY_ON_EINTR(read(fuse_fd, q->request_buf, sizeof(q->reque=
st_buf)));
>      if (ret < 0 && errno =3D=3D EAGAIN) {
>          /* No request available */
>          goto no_request;
> @@ -400,7 +519,7 @@ static void coroutine_fn co_read_from_fuse_fd(void *o=
paque)
>          goto no_request;
>      }
> =20
> -    in_hdr =3D (const struct fuse_in_header *)exp->request_buf;
> +    in_hdr =3D (const struct fuse_in_header *)q->request_buf;
>      if (unlikely(ret !=3D in_hdr->len)) {
>          error_report("Number of bytes read from FUSE device does not mat=
ch "
>                       "request size, expected %" PRIu32 " bytes, read %zi=
 "
> @@ -413,7 +532,7 @@ static void coroutine_fn co_read_from_fuse_fd(void *o=
paque)
> =20
>      /* Must set this before yielding */
>      co_param->got_request =3D 1;
> -    fuse_co_process_request(exp);
> +    fuse_co_process_request(q);
>      fuse_dec_in_flight(exp);
>      return;
> =20
> @@ -432,7 +551,7 @@ static bool poll_fuse_fd(void *opaque)
>  {
>      Coroutine *co;
>      FuseRequestCoParam co_param =3D {
> -        .exp =3D opaque,
> +        .q =3D opaque,
>          .got_request =3D -EINPROGRESS,
>      };
> =20
> @@ -451,7 +570,7 @@ static void read_fuse_fd(void *opaque)
>  {
>      Coroutine *co;
>      FuseRequestCoParam co_param =3D {
> -        .exp =3D opaque,
> +        .q =3D opaque,
>          .got_request =3D -EINPROGRESS,
>      };
> =20
> @@ -481,6 +600,16 @@ static void fuse_export_delete(BlockExport *blk_exp)
>  {
>      FuseExport *exp =3D container_of(blk_exp, FuseExport, common);
> =20
> +    for (int i =3D 0; i < exp->num_queues; i++) {
> +        FuseQueue *q =3D &exp->queues[i];
> +
> +        /* Queue 0's FD belongs to the FUSE session */
> +        if (i > 0 && q->fuse_fd >=3D 0) {
> +            close(q->fuse_fd);
> +        }
> +    }
> +    g_free(exp->queues);
> +
>      if (exp->fuse_session) {
>          if (exp->mounted) {
>              fuse_session_unmount(exp->fuse_session);
> @@ -1137,23 +1266,23 @@ static int fuse_write_buf_response(int fd, uint32=
_t req_id,
>  /*
>   * For use in fuse_co_process_request():
>   * Returns a pointer to the parameter object for the given operation (in=
side of
> - * exp->request_buf, which is assumed to hold a fuse_in_header first).
> - * Verifies that the object is complete (exp->request_buf is large enoug=
h to
> + * q->request_buf, which is assumed to hold a fuse_in_header first).
> + * Verifies that the object is complete (q->request_buf is large enough =
to
>   * hold it in one piece, and the request length includes the whole objec=
t).
>   *
> - * Note that exp->request_buf may be overwritten after yielding, so the =
returned
> + * Note that q->request_buf may be overwritten after yielding, so the re=
turned
>   * pointer must not be used across a function that may yield!
>   */
> -#define FUSE_IN_OP_STRUCT(op_name, export) \
> +#define FUSE_IN_OP_STRUCT(op_name, queue) \
>      ({ \
>          const struct fuse_in_header *__in_hdr =3D \
> -            (const struct fuse_in_header *)(export)->request_buf; \
> +            (const struct fuse_in_header *)(q)->request_buf; \
>          const struct fuse_##op_name##_in *__in =3D \
>              (const struct fuse_##op_name##_in *)(__in_hdr + 1); \
>          const size_t __param_len =3D sizeof(*__in_hdr) + sizeof(*__in); \
>          uint32_t __req_len; \
>          \
> -        QEMU_BUILD_BUG_ON(sizeof((export)->request_buf) < __param_len); \
> +        QEMU_BUILD_BUG_ON(sizeof((q)->request_buf) < __param_len); \
>          \
>          __req_len =3D __in_hdr->len; \
>          if (__req_len < __param_len) { \
> @@ -1190,11 +1319,12 @@ static int fuse_write_buf_response(int fd, uint32=
_t req_id,
>   * Process a FUSE request, incl. writing the response.
>   *
>   * Note that yielding in any request-processing function can overwrite t=
he
> - * contents of exp->request_buf.  Anything that takes a buffer needs to =
take
> + * contents of q->request_buf.  Anything that takes a buffer needs to ta=
ke
>   * care that the content is copied before yielding.
>   */
> -static void coroutine_fn fuse_co_process_request(FuseExport *exp)
> +static void coroutine_fn fuse_co_process_request(FuseQueue *q)
>  {
> +    FuseExport *exp =3D q->exp;
>      uint32_t opcode;
>      uint64_t req_id;
>      /*
> @@ -1217,7 +1347,7 @@ static void coroutine_fn fuse_co_process_request(Fu=
seExport *exp)
>      /* Limit scope to ensure pointer is no longer used after yielding */
>      {
>          const struct fuse_in_header *in_hdr =3D
> -            (const struct fuse_in_header *)exp->request_buf;
> +            (const struct fuse_in_header *)q->request_buf;
> =20
>          opcode =3D in_hdr->opcode;
>          req_id =3D in_hdr->unique;
> @@ -1225,7 +1355,7 @@ static void coroutine_fn fuse_co_process_request(Fu=
seExport *exp)
> =20
>      switch (opcode) {
>      case FUSE_INIT: {
> -        const struct fuse_init_in *in =3D FUSE_IN_OP_STRUCT(init, exp);
> +        const struct fuse_init_in *in =3D FUSE_IN_OP_STRUCT(init, q);
>          ret =3D fuse_co_init(exp, FUSE_OUT_OP_STRUCT(init, out_buf),
>                             in->max_readahead, in->flags);
>          break;
> @@ -1248,23 +1378,23 @@ static void coroutine_fn fuse_co_process_request(=
FuseExport *exp)
>          break;
> =20
>      case FUSE_SETATTR: {
> -        const struct fuse_setattr_in *in =3D FUSE_IN_OP_STRUCT(setattr, =
exp);
> +        const struct fuse_setattr_in *in =3D FUSE_IN_OP_STRUCT(setattr, =
q);
>          ret =3D fuse_co_setattr(exp, FUSE_OUT_OP_STRUCT(attr, out_buf),
>                                in->valid, in->size, in->mode, in->uid, in=
->gid);
>          break;
>      }
> =20
>      case FUSE_READ: {
> -        const struct fuse_read_in *in =3D FUSE_IN_OP_STRUCT(read, exp);
> +        const struct fuse_read_in *in =3D FUSE_IN_OP_STRUCT(read, q);
>          ret =3D fuse_co_read(exp, &out_data_buffer, in->offset, in->size=
);
>          break;
>      }
> =20
>      case FUSE_WRITE: {
> -        const struct fuse_write_in *in =3D FUSE_IN_OP_STRUCT(write, exp);
> +        const struct fuse_write_in *in =3D FUSE_IN_OP_STRUCT(write, q);
>          uint32_t req_len;
> =20
> -        req_len =3D ((const struct fuse_in_header *)exp->request_buf)->l=
en;
> +        req_len =3D ((const struct fuse_in_header *)q->request_buf)->len;
>          if (unlikely(req_len < sizeof(struct fuse_in_header) + sizeof(*i=
n) +
>                                 in->size)) {
>              warn_report("FUSE WRITE truncated; received %zu bytes of %" =
PRIu32,
> @@ -1293,7 +1423,7 @@ static void coroutine_fn fuse_co_process_request(Fu=
seExport *exp)
>      }
> =20
>      case FUSE_FALLOCATE: {
> -        const struct fuse_fallocate_in *in =3D FUSE_IN_OP_STRUCT(falloca=
te, exp);
> +        const struct fuse_fallocate_in *in =3D FUSE_IN_OP_STRUCT(falloca=
te, q);
>          ret =3D fuse_co_fallocate(exp, in->offset, in->length, in->mode);
>          break;
>      }
> @@ -1308,7 +1438,7 @@ static void coroutine_fn fuse_co_process_request(Fu=
seExport *exp)
> =20
>  #ifdef CONFIG_FUSE_LSEEK
>      case FUSE_LSEEK: {
> -        const struct fuse_lseek_in *in =3D FUSE_IN_OP_STRUCT(lseek, exp);
> +        const struct fuse_lseek_in *in =3D FUSE_IN_OP_STRUCT(lseek, q);
>          ret =3D fuse_co_lseek(exp, FUSE_OUT_OP_STRUCT(lseek, out_buf),
>                              in->offset, in->whence);
>          break;
> @@ -1322,11 +1452,11 @@ static void coroutine_fn fuse_co_process_request(=
FuseExport *exp)
>      /* Ignore errors from fuse_write*(), nothing we can do anyway */
>      if (out_data_buffer) {
>          assert(ret >=3D 0);
> -        fuse_write_buf_response(exp->fuse_fd, req_id, out_hdr,
> +        fuse_write_buf_response(q->fuse_fd, req_id, out_hdr,
>                                  out_data_buffer, ret);
>          qemu_vfree(out_data_buffer);
>      } else {
> -        fuse_write_response(exp->fuse_fd, req_id, out_hdr,
> +        fuse_write_response(q->fuse_fd, req_id, out_hdr,
>                              ret < 0 ? ret : 0,
>                              ret < 0 ? 0 : ret);
>      }
> --=20
> 2.48.1
>=20
>=20

--IeAEo9zzPRzuKp0E
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfldQ0ACgkQnKSrs4Gr
c8jJQAgAoamRhCh0wnH9mDoaSHYafvhDrsr2NiaTTHGt2MaHO5dczRxqG2/no0VB
ZSWmHJTpBjMKllbDO3Yq8f5FPj59njLC2SuyOJ4SRDa/yOYGpfjdwUYHZq3WRzlY
Et3AMJwP839C7FEkO48JqCXiwnkm+PL6PC2/j5QuSFMhHc6wvf3Vhj1ydv95AAT6
eVH2Jm9h2RbvT2l+cFc+lYiqiBaTu0nX9r9YOSyLv/HMXDlM5VFFqXCNmzf0qSHj
e9GKBWFN+tG76OddUzgMUyb3XAXm/X+LfzYZcKgK6VfBqDpHpe1xP6slB3R7DT0V
ZLuof6eeeCVk2h5m5/W4Rcvhgd2zoA==
=V3pT
-----END PGP SIGNATURE-----

--IeAEo9zzPRzuKp0E--


