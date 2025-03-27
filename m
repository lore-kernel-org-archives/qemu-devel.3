Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B82FC36010
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 15:36:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txpGL-0002bY-E9; Thu, 27 Mar 2025 11:35:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1txpGH-0002Yp-TI
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 11:35:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1txpGD-00060F-Qu
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 11:35:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743089712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=85DxKaACl602pm4XHCyXrNitkLxQbfHDOGneoge0V1I=;
 b=S+9pTv7p1+9EqM2LugbxEwnr5z970hPBnSUcycJvzSpBs/ZRjCW34Bvb1Kf4vP6jQX4CfP
 3mHt7J3Mwo/l1F8kRtxf67FBibRZ/wzC9/V/5O5AlEMx41Vy+52APSc7eIMRgYEDaGcGB9
 vKkKnbscD/U3evFUfvIKTWjylvoemSk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-50-5M8QnZ6qOK6ssigBAS2nqQ-1; Thu,
 27 Mar 2025 11:35:08 -0400
X-MC-Unique: 5M8QnZ6qOK6ssigBAS2nqQ-1
X-Mimecast-MFC-AGG-ID: 5M8QnZ6qOK6ssigBAS2nqQ_1743089708
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 280211933B60; Thu, 27 Mar 2025 15:35:06 +0000 (UTC)
Received: from localhost (unknown [10.2.16.93])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9075319560AD; Thu, 27 Mar 2025 15:35:04 +0000 (UTC)
Date: Thu, 27 Mar 2025 11:35:03 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 11/15] fuse: Manually process requests (without libfuse)
Message-ID: <20250327153503.GK37458@fedora>
References: <20250325160529.117543-1-hreitz@redhat.com>
 <20250325160655.119407-10-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="AmNWUu5KoYbNJM+0"
Content-Disposition: inline
In-Reply-To: <20250325160655.119407-10-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--AmNWUu5KoYbNJM+0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 05:06:51PM +0100, Hanna Czenczek wrote:
> Manually read requests from the /dev/fuse FD and process them, without
> using libfuse.  This allows us to safely add parallel request processing
> in coroutines later, without having to worry about libfuse internals.
> (Technically, we already have exactly that problem with
> read_from_fuse_export()/read_from_fuse_fd() nesting.)
>=20
> We will continue to use libfuse for mounting the filesystem; fusermount3
> is a effectively a helper program of libfuse, so it should know best how
> to interact with it.  (Doing it manually without libfuse, while doable,
> is a bit of a pain, and it is not clear to me how stable the "protocol"
> actually is.)
>=20
> Take this opportunity of quite a major rewrite to update the Copyright
> line with corrected information that has surfaced in the meantime.
>=20
> Here are some benchmarks from before this patch (4k, iodepth=3D16, libaio;
> except 'sync', which are iodepth=3D1 and pvsync2):
>=20
> file:
>   read:
>     seq aio:   78.6k =B11.3k IOPS
>     rand aio:  39.3k =B12.9k
>     seq sync:  32.5k =B10.7k
>     rand sync:  9.9k =B10.1k
>   write:
>     seq aio:   61.9k =B10.5k
>     rand aio:  61.2k =B10.6k
>     seq sync:  27.9k =B10.2k
>     rand sync: 27.6k =B10.4k
> null:
>   read:
>     seq aio:   214.0k =B15.9k
>     rand aio:  212.7k =B14.5k
>     seq sync:   90.3k =B16.5k
>     rand sync:  89.7k =B15.1k
>   write:
>     seq aio:   203.9k =B11.5k
>     rand aio:  201.4k =B13.6k
>     seq sync:   86.1k =B16.2k
>     rand sync:  84.9k =B15.3k
>=20
> And with this patch applied:
>=20
> file:
>   read:
>     seq aio:   76.6k =B11.8k (- 3 %)
>     rand aio:  26.7k =B10.4k (-32 %)
>     seq sync:  47.7k =B11.2k (+47 %)
>     rand sync: 10.1k =B10.2k (+ 2 %)
>   write:
>     seq aio:   58.1k =B10.5k (- 6 %)
>     rand aio:  58.1k =B10.5k (- 5 %)
>     seq sync:  36.3k =B10.3k (+30 %)
>     rand sync: 36.1k =B10.4k (+31 %)
> null:
>   read:
>     seq aio:   268.4k =B13.4k (+25 %)
>     rand aio:  265.3k =B12.1k (+25 %)
>     seq sync:  134.3k =B12.7k (+49 %)
>     rand sync: 132.4k =B11.4k (+48 %)
>   write:
>     seq aio:   275.3k =B11.7k (+35 %)
>     rand aio:  272.3k =B11.9k (+35 %)
>     seq sync:  130.7k =B11.6k (+52 %)
>     rand sync: 127.4k =B12.4k (+50 %)
>=20
> So clearly the AIO file results are actually not good, and random reads
> are indeed quite terrible.  On the other hand, we can see from the sync
> and null results that request handling should in theory be quicker.  How
> does this fit together?
>=20
> I believe the bad AIO results are an artifact of the accidental parallel
> request processing we have due to nested polling: Depending on how the
> actual request processing is structured and how long request processing
> takes, more or less requests will be submitted in parallel.  So because
> of the restructuring, I think this patch accidentally changes how many
> requests end up being submitted in parallel, which decreases
> performance.
>=20
> (I have seen something like this before: In RSD, without having
> implemented a polling mode, the debug build tended to have better
> performance than the more optimized release build, because the debug
> build, taking longer to submit requests, ended up processing more
> requests in parallel.)
>=20
> In any case, once we use coroutines throughout the code, performance
> will improve again across the board.
>=20
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  block/export/fuse.c | 793 +++++++++++++++++++++++++++++++-------------
>  1 file changed, 567 insertions(+), 226 deletions(-)
>=20
> diff --git a/block/export/fuse.c b/block/export/fuse.c
> index 3dd50badb3..407b101018 100644
> --- a/block/export/fuse.c
> +++ b/block/export/fuse.c
> @@ -1,7 +1,7 @@
>  /*
>   * Present a block device as a raw image through FUSE
>   *
> - * Copyright (c) 2020 Max Reitz <mreitz@redhat.com>
> + * Copyright (c) 2020, 2025 Hanna Czenczek <hreitz@redhat.com>
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License as published by
> @@ -27,12 +27,15 @@
>  #include "block/qapi.h"
>  #include "qapi/error.h"
>  #include "qapi/qapi-commands-block.h"
> +#include "qemu/error-report.h"
>  #include "qemu/main-loop.h"
>  #include "system/block-backend.h"
> =20
>  #include <fuse.h>
>  #include <fuse_lowlevel.h>
> =20
> +#include "standard-headers/linux/fuse.h"
> +
>  #if defined(CONFIG_FALLOCATE_ZERO_RANGE)
>  #include <linux/falloc.h>
>  #endif
> @@ -42,17 +45,27 @@
>  #endif
> =20
>  /* Prevent overly long bounce buffer allocations */
> -#define FUSE_MAX_BOUNCE_BYTES (MIN(BDRV_REQUEST_MAX_BYTES, 64 * 1024 * 1=
024))
> -
> +#define FUSE_MAX_READ_BYTES (MIN(BDRV_REQUEST_MAX_BYTES, 64 * 1024 * 102=
4))
> +/* Small enough to fit in the request buffer */
> +#define FUSE_MAX_WRITE_BYTES (4 * 1024)
> =20
>  typedef struct FuseExport {
>      BlockExport common;
> =20
>      struct fuse_session *fuse_session;
> -    struct fuse_buf fuse_buf;
>      unsigned int in_flight; /* atomic */
>      bool mounted, fd_handler_set_up;
> =20
> +    /*
> +     * The request buffer must be able to hold a full write, and/or at l=
east
> +     * FUSE_MIN_READ_BUFFER (from linux/fuse.h) bytes
> +     */
> +    char request_buf[MAX_CONST(
> +        sizeof(struct fuse_in_header) + sizeof(struct fuse_write_in) +
> +             FUSE_MAX_WRITE_BYTES,
> +        FUSE_MIN_READ_BUFFER
> +    )];
> +
>      /*
>       * Set when there was an unrecoverable error and no requests should =
be read
>       * from the device anymore (basically only in case of something we w=
ould
> @@ -60,6 +73,8 @@ typedef struct FuseExport {
>       */
>      bool halted;
> =20
> +    int fuse_fd;
> +
>      char *mountpoint;
>      bool writable;
>      bool growable;
> @@ -72,19 +87,20 @@ typedef struct FuseExport {
>  } FuseExport;
> =20
>  static GHashTable *exports;
> -static const struct fuse_lowlevel_ops fuse_ops;
> =20
>  static void fuse_export_shutdown(BlockExport *exp);
>  static void fuse_export_delete(BlockExport *exp);
> -static void fuse_export_halt(FuseExport *exp) G_GNUC_UNUSED;
> +static void fuse_export_halt(FuseExport *exp);
> =20
>  static void init_exports_table(void);
> =20
>  static int mount_fuse_export(FuseExport *exp, Error **errp);
> -static void read_from_fuse_export(void *opaque);
> =20
>  static bool is_regular_file(const char *path, Error **errp);
> =20
> +static bool poll_fuse_fd(void *opaque);
> +static void read_fuse_fd(void *opaque);
> +static void fuse_process_request(FuseExport *exp);
> =20
>  static void fuse_inc_in_flight(FuseExport *exp)
>  {
> @@ -105,22 +121,27 @@ static void fuse_dec_in_flight(FuseExport *exp)
>      }
>  }
> =20
> +/**
> + * Attach FUSE FD read and poll handlers.
> + */
>  static void fuse_attach_handlers(FuseExport *exp)
>  {
>      if (exp->halted) {
>          return;
>      }
> =20
> -    aio_set_fd_handler(exp->common.ctx,
> -                       fuse_session_fd(exp->fuse_session),
> -                       read_from_fuse_export, NULL, NULL, NULL, exp);
> +    aio_set_fd_handler(exp->common.ctx, exp->fuse_fd,
> +                       read_fuse_fd, NULL, poll_fuse_fd,
> +                       read_fuse_fd, exp);
>      exp->fd_handler_set_up =3D true;
>  }
> =20
> +/**
> + * Detach FUSE FD read and poll handlers.
> + */
>  static void fuse_detach_handlers(FuseExport *exp)
>  {
> -    aio_set_fd_handler(exp->common.ctx,
> -                       fuse_session_fd(exp->fuse_session),
> +    aio_set_fd_handler(exp->common.ctx, exp->fuse_fd,
>                         NULL, NULL, NULL, NULL, NULL);
>      exp->fd_handler_set_up =3D false;
>  }
> @@ -247,6 +268,14 @@ static int fuse_export_create(BlockExport *blk_exp,
> =20
>      g_hash_table_insert(exports, g_strdup(exp->mountpoint), NULL);
> =20
> +    exp->fuse_fd =3D fuse_session_fd(exp->fuse_session);
> +    ret =3D fcntl(exp->fuse_fd, F_SETFL, O_NONBLOCK);
> +    if (ret < 0) {
> +        ret =3D -errno;
> +        error_setg_errno(errp, errno, "Failed to make FUSE FD non-blocki=
ng");
> +        goto fail;
> +    }
> +
>      fuse_attach_handlers(exp);
>      return 0;
> =20
> @@ -292,7 +321,7 @@ static int mount_fuse_export(FuseExport *exp, Error *=
*errp)
>      mount_opts =3D g_strdup_printf("%s,nosuid,nodev,noatime,max_read=3D%=
zu,"
>                                   "default_permissions%s",
>                                   exp->writable ? "rw" : "ro",
> -                                 FUSE_MAX_BOUNCE_BYTES,
> +                                 FUSE_MAX_READ_BYTES,
>                                   exp->allow_other ? ",allow_other" : "");
> =20
>      fuse_argv[0] =3D ""; /* Dummy program name */
> @@ -301,8 +330,8 @@ static int mount_fuse_export(FuseExport *exp, Error *=
*errp)
>      fuse_argv[3] =3D NULL;
>      fuse_args =3D (struct fuse_args)FUSE_ARGS_INIT(3, (char **)fuse_argv=
);
> =20
> -    exp->fuse_session =3D fuse_session_new(&fuse_args, &fuse_ops,
> -                                         sizeof(fuse_ops), exp);
> +    /* We just create the session for mounting/unmounting, no need to se=
t ops */
> +    exp->fuse_session =3D fuse_session_new(&fuse_args, NULL, 0, NULL);
>      g_free(mount_opts);
>      if (!exp->fuse_session) {
>          error_setg(errp, "Failed to set up FUSE session");
> @@ -320,55 +349,94 @@ static int mount_fuse_export(FuseExport *exp, Error=
 **errp)
>  }
> =20
>  /**
> - * Callback to be invoked when the FUSE session FD can be read from.
> - * (This is basically the FUSE event loop.)
> + * Try to read a single request from the FUSE FD.
> + * If a request is available, process it, and return true.
> + * Otherwise, return false.
>   */
> -static void read_from_fuse_export(void *opaque)
> +static bool read_from_fuse_fd(void *opaque)
>  {
>      FuseExport *exp =3D opaque;
> -    int ret;
> +    int fuse_fd =3D exp->fuse_fd;
> +    ssize_t ret;
> +    const struct fuse_in_header *in_hdr;
> +
> +    fuse_inc_in_flight(exp);
> =20
>      if (unlikely(exp->halted)) {
> -        return;
> +        goto no_request;
>      }
> =20
> -    fuse_inc_in_flight(exp);
> +    ret =3D RETRY_ON_EINTR(read(fuse_fd, exp->request_buf,
> +                              sizeof(exp->request_buf)));
> +    if (ret < 0 && errno =3D=3D EAGAIN) {
> +        /* No request available */
> +        goto no_request;
> +    } else if (unlikely(ret < 0)) {
> +        error_report("Failed to read from FUSE device: %s", strerror(-re=
t));
> +        goto no_request;
> +    }
> =20
> -    do {
> -        ret =3D fuse_session_receive_buf(exp->fuse_session, &exp->fuse_b=
uf);
> -    } while (ret =3D=3D -EINTR);
> -    if (ret < 0) {
> -        goto out;
> +    if (unlikely(ret < sizeof(*in_hdr))) {
> +        error_report("Incomplete read from FUSE device, expected at leas=
t %zu "
> +                     "bytes, read %zi bytes; cannot trust subsequent "
> +                     "requests, halting the export",
> +                     sizeof(*in_hdr), ret);
> +        fuse_export_halt(exp);
> +        goto no_request;
>      }
> =20
> -    /*
> -     * Note that polling in any request-processing function can lead to =
a nested
> -     * read_from_fuse_export() call, which will overwrite the contents of
> -     * exp->fuse_buf.  Anything that takes a buffer needs to take care t=
hat the
> -     * content is copied before potentially polling.
> -     */
> -    fuse_session_process_buf(exp->fuse_session, &exp->fuse_buf);
> +    in_hdr =3D (const struct fuse_in_header *)exp->request_buf;
> +    if (unlikely(ret !=3D in_hdr->len)) {
> +        error_report("Number of bytes read from FUSE device does not mat=
ch "
> +                     "request size, expected %" PRIu32 " bytes, read %zi=
 "
> +                     "bytes; cannot trust subsequent requests, halting t=
he "
> +                     "export",
> +                     in_hdr->len, ret);
> +        fuse_export_halt(exp);
> +        goto no_request;
> +    }
> +
> +    fuse_process_request(exp);
> +    fuse_dec_in_flight(exp);
> +    return true;
> =20
> -out:
> +no_request:
>      fuse_dec_in_flight(exp);
> +    return false;
> +}
> +
> +/**
> + * Check the FUSE FD for whether it is readable or not.  Because we cann=
ot
> + * reasonably do this without reading a request at the same time, also r=
ead and
> + * process that request if any.
> + * (To be used as a poll handler for the FUSE FD.)
> + */
> +static bool poll_fuse_fd(void *opaque)
> +{
> +    return read_from_fuse_fd(opaque);
> +}

The other io_poll() callbacks in QEMU peek at memory whereas this one
invokes the read(2) syscall. Two reasons why this is a problem:
1. Syscall latency is too high. Other fd handlers will be delayed by
   microseconds.
2. This doesn't scale. If every component in QEMU does this then the
   event loop degrades to O(n) of non-blocking read(2) syscalls where n
   is the number of fds.

Also, handling the request inside the io_poll() callback skews
AioContext's time accounting because time spent handling the request
will be accounted as "polling time". The adaptive polling calculation
will think it polled for longer than it did.

If there is no way to peek at memory, please don't implement the
io_poll() callback.

> +
> +/**
> + * Read a request from the FUSE FD.
> + * (To be used as a handler for when the FUSE FD becomes readable.)
> + */
> +static void read_fuse_fd(void *opaque)
> +{
> +    read_from_fuse_fd(opaque);
>  }
> =20
>  static void fuse_export_shutdown(BlockExport *blk_exp)
>  {
>      FuseExport *exp =3D container_of(blk_exp, FuseExport, common);
> =20
> -    if (exp->fuse_session) {
> -        fuse_session_exit(exp->fuse_session);
> -
> -        if (exp->fd_handler_set_up) {
> -            fuse_detach_handlers(exp);
> -        }
> +    if (exp->fd_handler_set_up) {
> +        fuse_detach_handlers(exp);
>      }
> =20
>      if (exp->mountpoint) {
>          /*
> -         * Safe to drop now, because we will not handle any requests
> -         * for this export anymore anyway.
> +         * Safe to drop now, because we will not handle any requests for=
 this
> +         * export anymore anyway (at least not from the main thread).
>           */
>          g_hash_table_remove(exports, exp->mountpoint);
>      }
> @@ -386,7 +454,6 @@ static void fuse_export_delete(BlockExport *blk_exp)
>          fuse_session_destroy(exp->fuse_session);
>      }
> =20
> -    free(exp->fuse_buf.mem);
>      g_free(exp->mountpoint);
>  }
> =20
> @@ -428,46 +495,57 @@ static bool is_regular_file(const char *path, Error=
 **errp)
>  }
> =20
>  /**
> - * A chance to set change some parameters supplied to FUSE_INIT.
> + * Process FUSE INIT.
> + * Return the number of bytes written to *out on success, and -errno on =
error.
>   */
> -static void fuse_init(void *userdata, struct fuse_conn_info *conn)
> +static ssize_t fuse_init(FuseExport *exp, struct fuse_init_out *out,
> +                         uint32_t max_readahead, uint32_t flags)
>  {
> -    /*
> -     * MIN_NON_ZERO() would not be wrong here, but what we set here
> -     * must equal what has been passed to fuse_session_new().
> -     * Therefore, as long as max_read must be passed as a mount option
> -     * (which libfuse claims will be changed at some point), we have
> -     * to set max_read to a fixed value here.
> -     */
> -    conn->max_read =3D FUSE_MAX_BOUNCE_BYTES;
> +    const uint32_t supported_flags =3D FUSE_ASYNC_READ | FUSE_ASYNC_DIO;
> =20
> -    conn->max_write =3D MIN_NON_ZERO(BDRV_REQUEST_MAX_BYTES, conn->max_w=
rite);
> -}
> +    *out =3D (struct fuse_init_out) {
> +        .major =3D FUSE_KERNEL_VERSION,
> +        .minor =3D FUSE_KERNEL_MINOR_VERSION,
> +        .max_readahead =3D max_readahead,
> +        .max_write =3D FUSE_MAX_WRITE_BYTES,
> +        .flags =3D flags & supported_flags,
> +        .flags2 =3D 0,
> =20
> -/**
> - * Let clients look up files.  Always return ENOENT because we only
> - * care about the mountpoint itself.
> - */
> -static void fuse_lookup(fuse_req_t req, fuse_ino_t parent, const char *n=
ame)
> -{
> -    fuse_reply_err(req, ENOENT);
> +        /* libfuse maximum: 2^16 - 1 */
> +        .max_background =3D UINT16_MAX,
> +
> +        /* libfuse default: max_background * 3 / 4 */
> +        .congestion_threshold =3D (int)UINT16_MAX * 3 / 4,
> +
> +        /* libfuse default: 1 */
> +        .time_gran =3D 1,
> +
> +        /*
> +         * probably unneeded without FUSE_MAX_PAGES, but this would be t=
he
> +         * libfuse default
> +         */
> +        .max_pages =3D DIV_ROUND_UP(FUSE_MAX_WRITE_BYTES,
> +                                  qemu_real_host_page_size()),
> +
> +        /* Only needed for mappings (i.e. DAX) */
> +        .map_alignment =3D 0,
> +    };
> +
> +    return sizeof(*out);
>  }
> =20
>  /**
>   * Let clients get file attributes (i.e., stat() the file).
> + * Return the number of bytes written to *out on success, and -errno on =
error.
>   */
> -static void fuse_getattr(fuse_req_t req, fuse_ino_t inode,
> -                         struct fuse_file_info *fi)
> +static ssize_t fuse_getattr(FuseExport *exp, struct fuse_attr_out *out)
>  {
> -    struct stat statbuf;
>      int64_t length, allocated_blocks;
>      time_t now =3D time(NULL);
> -    FuseExport *exp =3D fuse_req_userdata(req);
> =20
>      length =3D blk_getlength(exp->common.blk);
>      if (length < 0) {
> -        fuse_reply_err(req, -length);
> -        return;
> +        return length;
>      }
> =20
>      allocated_blocks =3D bdrv_get_allocated_file_size(blk_bs(exp->common=
=2Eblk));
> @@ -477,21 +555,24 @@ static void fuse_getattr(fuse_req_t req, fuse_ino_t=
 inode,
>          allocated_blocks =3D DIV_ROUND_UP(allocated_blocks, 512);
>      }
> =20
> -    statbuf =3D (struct stat) {
> -        .st_ino     =3D 1,
> -        .st_mode    =3D exp->st_mode,
> -        .st_nlink   =3D 1,
> -        .st_uid     =3D exp->st_uid,
> -        .st_gid     =3D exp->st_gid,
> -        .st_size    =3D length,
> -        .st_blksize =3D blk_bs(exp->common.blk)->bl.request_alignment,
> -        .st_blocks  =3D allocated_blocks,
> -        .st_atime   =3D now,
> -        .st_mtime   =3D now,
> -        .st_ctime   =3D now,
> +    *out =3D (struct fuse_attr_out) {
> +        .attr_valid =3D 1,
> +        .attr =3D {
> +            .ino        =3D 1,
> +            .mode       =3D exp->st_mode,
> +            .nlink      =3D 1,
> +            .uid        =3D exp->st_uid,
> +            .gid        =3D exp->st_gid,
> +            .size       =3D length,
> +            .blksize    =3D blk_bs(exp->common.blk)->bl.request_alignmen=
t,
> +            .blocks     =3D allocated_blocks,
> +            .atime      =3D now,
> +            .mtime      =3D now,
> +            .ctime      =3D now,
> +        },
>      };
> =20
> -    fuse_reply_attr(req, &statbuf, 1.);
> +    return sizeof(*out);
>  }
> =20
>  static int fuse_do_truncate(const FuseExport *exp, int64_t size,
> @@ -544,160 +625,149 @@ static int fuse_do_truncate(const FuseExport *exp=
, int64_t size,
>   * permit access: Read-only exports cannot be given +w, and exports
>   * without allow_other cannot be given a different UID or GID, and
>   * they cannot be given non-owner access.
> + * Return the number of bytes written to *out on success, and -errno on =
error.
>   */
> -static void fuse_setattr(fuse_req_t req, fuse_ino_t inode, struct stat *=
statbuf,
> -                         int to_set, struct fuse_file_info *fi)
> +static ssize_t fuse_setattr(FuseExport *exp, struct fuse_attr_out *out,
> +                            uint32_t to_set, uint64_t size, uint32_t mod=
e,
> +                            uint32_t uid, uint32_t gid)
>  {
> -    FuseExport *exp =3D fuse_req_userdata(req);
>      int supported_attrs;
>      int ret;
> =20
> -    supported_attrs =3D FUSE_SET_ATTR_SIZE | FUSE_SET_ATTR_MODE;
> +    /* SIZE and MODE are actually supported, the others can be safely ig=
nored */
> +    supported_attrs =3D FATTR_SIZE | FATTR_MODE |
> +        FATTR_FH | FATTR_LOCKOWNER | FATTR_KILL_SUIDGID;
>      if (exp->allow_other) {
> -        supported_attrs |=3D FUSE_SET_ATTR_UID | FUSE_SET_ATTR_GID;
> +        supported_attrs |=3D FATTR_UID | FATTR_GID;
>      }
> =20
>      if (to_set & ~supported_attrs) {
> -        fuse_reply_err(req, ENOTSUP);
> -        return;
> +        return -ENOTSUP;
>      }
> =20
>      /* Do some argument checks first before committing to anything */
> -    if (to_set & FUSE_SET_ATTR_MODE) {
> +    if (to_set & FATTR_MODE) {
>          /*
>           * Without allow_other, non-owners can never access the export, =
so do
>           * not allow setting permissions for them
>           */
> -        if (!exp->allow_other &&
> -            (statbuf->st_mode & (S_IRWXG | S_IRWXO)) !=3D 0)
> -        {
> -            fuse_reply_err(req, EPERM);
> -            return;
> +        if (!exp->allow_other && (mode & (S_IRWXG | S_IRWXO)) !=3D 0) {
> +            return -EPERM;
>          }
> =20
>          /* +w for read-only exports makes no sense, disallow it */
> -        if (!exp->writable &&
> -            (statbuf->st_mode & (S_IWUSR | S_IWGRP | S_IWOTH)) !=3D 0)
> -        {
> -            fuse_reply_err(req, EROFS);
> -            return;
> +        if (!exp->writable && (mode & (S_IWUSR | S_IWGRP | S_IWOTH)) !=
=3D 0) {
> +            return -EROFS;
>          }
>      }
> =20
> -    if (to_set & FUSE_SET_ATTR_SIZE) {
> +    if (to_set & FATTR_SIZE) {
>          if (!exp->writable) {
> -            fuse_reply_err(req, EACCES);
> -            return;
> +            return -EACCES;
>          }
> =20
> -        ret =3D fuse_do_truncate(exp, statbuf->st_size, true, PREALLOC_M=
ODE_OFF);
> +        ret =3D fuse_do_truncate(exp, size, true, PREALLOC_MODE_OFF);
>          if (ret < 0) {
> -            fuse_reply_err(req, -ret);
> -            return;
> +            return ret;
>          }
>      }
> =20
> -    if (to_set & FUSE_SET_ATTR_MODE) {
> +    if (to_set & FATTR_MODE) {
>          /* Ignore FUSE-supplied file type, only change the mode */
> -        exp->st_mode =3D (statbuf->st_mode & 07777) | S_IFREG;
> +        exp->st_mode =3D (mode & 07777) | S_IFREG;
>      }
> =20
> -    if (to_set & FUSE_SET_ATTR_UID) {
> -        exp->st_uid =3D statbuf->st_uid;
> +    if (to_set & FATTR_UID) {
> +        exp->st_uid =3D uid;
>      }
> =20
> -    if (to_set & FUSE_SET_ATTR_GID) {
> -        exp->st_gid =3D statbuf->st_gid;
> +    if (to_set & FATTR_GID) {
> +        exp->st_gid =3D gid;
>      }
> =20
> -    fuse_getattr(req, inode, fi);
> +    return fuse_getattr(exp, out);
>  }
> =20
>  /**
> - * Let clients open a file (i.e., the exported image).
> + * Open an inode.  We only have a single inode in our exported filesyste=
m, so we
> + * just acknowledge the request.
> + * Return the number of bytes written to *out on success, and -errno on =
error.
>   */
> -static void fuse_open(fuse_req_t req, fuse_ino_t inode,
> -                      struct fuse_file_info *fi)
> +static ssize_t fuse_open(FuseExport *exp, struct fuse_open_out *out)
>  {
> -    fi->direct_io =3D true;
> -    fi->parallel_direct_writes =3D true;
> -    fuse_reply_open(req, fi);
> +    *out =3D (struct fuse_open_out) {
> +        .open_flags =3D FOPEN_DIRECT_IO | FOPEN_PARALLEL_DIRECT_WRITES,
> +    };
> +    return sizeof(*out);
>  }
> =20
>  /**
> - * Handle client reads from the exported image.
> + * Handle client reads from the exported image.  Allocates *bufptr and r=
eads
> + * data from the block device into that buffer.
> + * Returns the buffer (read) size on success, and -errno on error.
>   */
> -static void fuse_read(fuse_req_t req, fuse_ino_t inode,
> -                      size_t size, off_t offset, struct fuse_file_info *=
fi)
> +static ssize_t fuse_read(FuseExport *exp, void **bufptr,
> +                         uint64_t offset, uint32_t size)
>  {
> -    FuseExport *exp =3D fuse_req_userdata(req);
> -    int64_t length;
> +    int64_t blk_len;
>      void *buf;
>      int ret;
> =20
>      /* Limited by max_read, should not happen */
> -    if (size > FUSE_MAX_BOUNCE_BYTES) {
> -        fuse_reply_err(req, EINVAL);
> -        return;
> +    if (size > FUSE_MAX_READ_BYTES) {
> +        return -EINVAL;
>      }
> =20
>      /**
>       * Clients will expect short reads at EOF, so we have to limit
>       * offset+size to the image length.
>       */
> -    length =3D blk_getlength(exp->common.blk);
> -    if (length < 0) {
> -        fuse_reply_err(req, -length);
> -        return;
> +    blk_len =3D blk_getlength(exp->common.blk);
> +    if (blk_len < 0) {
> +        return blk_len;
>      }
> =20
> -    if (offset + size > length) {
> -        size =3D length - offset;
> +    if (offset + size > blk_len) {
> +        size =3D blk_len - offset;
>      }
> =20
>      buf =3D qemu_try_blockalign(blk_bs(exp->common.blk), size);
>      if (!buf) {
> -        fuse_reply_err(req, ENOMEM);
> -        return;
> +        return -ENOMEM;
>      }
> =20
>      ret =3D blk_pread(exp->common.blk, offset, size, buf, 0);
> -    if (ret >=3D 0) {
> -        fuse_reply_buf(req, buf, size);
> -    } else {
> -        fuse_reply_err(req, -ret);
> +    if (ret < 0) {
> +        qemu_vfree(buf);
> +        return ret;
>      }
> =20
> -    qemu_vfree(buf);
> +    *bufptr =3D buf;
> +    return size;
>  }
> =20
>  /**
> - * Handle client writes to the exported image.
> + * Handle client writes to the exported image.  @buf has the data to be =
written
> + * and will be copied to a bounce buffer before polling for the first ti=
me.
> + * Return the number of bytes written to *out on success, and -errno on =
error.
>   */
> -static void fuse_write(fuse_req_t req, fuse_ino_t inode, const char *buf,
> -                       size_t size, off_t offset, struct fuse_file_info =
*fi)
> +static ssize_t fuse_write(FuseExport *exp, struct fuse_write_out *out,
> +                          uint64_t offset, uint32_t size, const void *bu=
f)
>  {
> -    FuseExport *exp =3D fuse_req_userdata(req);
>      void *copied;
> -    int64_t length;
> +    int64_t blk_len;
>      int ret;
> =20
>      /* Limited by max_write, should not happen */
>      if (size > BDRV_REQUEST_MAX_BYTES) {
> -        fuse_reply_err(req, EINVAL);
> -        return;
> +        return -EINVAL;
>      }
> =20
>      if (!exp->writable) {
> -        fuse_reply_err(req, EACCES);
> -        return;
> +        return -EACCES;
>      }
> =20
> -    /*
> -     * Heed the note on read_from_fuse_export(): If we poll (which any b=
lk_*()
> -     * I/O function may do), read_from_fuse_export() may be nested, over=
writing
> -     * the request buffer content.  Therefore, we must copy it here.
> -     */
> +    /* Must copy to bounce buffer before polling (to allow nesting) */
>      copied =3D blk_blockalign(exp->common.blk, size);
>      memcpy(copied, buf, size);
> =20
> @@ -705,55 +775,57 @@ static void fuse_write(fuse_req_t req, fuse_ino_t i=
node, const char *buf,
>       * Clients will expect short writes at EOF, so we have to limit
>       * offset+size to the image length.
>       */
> -    length =3D blk_getlength(exp->common.blk);
> -    if (length < 0) {
> -        fuse_reply_err(req, -length);
> -        goto free_buffer;
> +    blk_len =3D blk_getlength(exp->common.blk);
> +    if (blk_len < 0) {
> +        ret =3D blk_len;
> +        goto fail_free_buffer;
>      }
> =20
> -    if (offset + size > length) {
> +    if (offset + size > blk_len) {
>          if (exp->growable) {
>              ret =3D fuse_do_truncate(exp, offset + size, true, PREALLOC_=
MODE_OFF);
>              if (ret < 0) {
> -                fuse_reply_err(req, -ret);
> -                goto free_buffer;
> +                goto fail_free_buffer;
>              }
>          } else {
> -            size =3D length - offset;
> +            size =3D blk_len - offset;
>          }
>      }
> =20
>      ret =3D blk_pwrite(exp->common.blk, offset, size, copied, 0);
> -    if (ret >=3D 0) {
> -        fuse_reply_write(req, size);
> -    } else {
> -        fuse_reply_err(req, -ret);
> +    if (ret < 0) {
> +        goto fail_free_buffer;
>      }
> =20
> -free_buffer:
>      qemu_vfree(copied);
> +
> +    *out =3D (struct fuse_write_out) {
> +        .size =3D size,
> +    };
> +    return sizeof(*out);
> +
> +fail_free_buffer:
> +    qemu_vfree(copied);
> +    return ret;
>  }
> =20
>  /**
>   * Let clients perform various fallocate() operations.
> + * Return 0 on success (no 'out' object), and -errno on error.
>   */
> -static void fuse_fallocate(fuse_req_t req, fuse_ino_t inode, int mode,
> -                           off_t offset, off_t length,
> -                           struct fuse_file_info *fi)
> +static ssize_t fuse_fallocate(FuseExport *exp, uint64_t offset, uint64_t=
 length,
> +                              uint32_t mode)
>  {
> -    FuseExport *exp =3D fuse_req_userdata(req);
>      int64_t blk_len;
>      int ret;
> =20
>      if (!exp->writable) {
> -        fuse_reply_err(req, EACCES);
> -        return;
> +        return -EACCES;
>      }
> =20
>      blk_len =3D blk_getlength(exp->common.blk);
>      if (blk_len < 0) {
> -        fuse_reply_err(req, -blk_len);
> -        return;
> +        return blk_len;
>      }
> =20
>  #ifdef CONFIG_FALLOCATE_PUNCH_HOLE
> @@ -765,16 +837,14 @@ static void fuse_fallocate(fuse_req_t req, fuse_ino=
_t inode, int mode,
>      if (!mode) {
>          /* We can only fallocate at the EOF with a truncate */
>          if (offset < blk_len) {
> -            fuse_reply_err(req, EOPNOTSUPP);
> -            return;
> +            return -EOPNOTSUPP;
>          }
> =20
>          if (offset > blk_len) {
>              /* No preallocation needed here */
>              ret =3D fuse_do_truncate(exp, offset, true, PREALLOC_MODE_OF=
F);
>              if (ret < 0) {
> -                fuse_reply_err(req, -ret);
> -                return;
> +                return ret;
>              }
>          }
> =20
> @@ -784,8 +854,7 @@ static void fuse_fallocate(fuse_req_t req, fuse_ino_t=
 inode, int mode,
>  #ifdef CONFIG_FALLOCATE_PUNCH_HOLE
>      else if (mode & FALLOC_FL_PUNCH_HOLE) {
>          if (!(mode & FALLOC_FL_KEEP_SIZE)) {
> -            fuse_reply_err(req, EINVAL);
> -            return;
> +            return -EINVAL;
>          }
> =20
>          do {
> @@ -813,8 +882,7 @@ static void fuse_fallocate(fuse_req_t req, fuse_ino_t=
 inode, int mode,
>              ret =3D fuse_do_truncate(exp, offset + length, false,
>                                     PREALLOC_MODE_OFF);
>              if (ret < 0) {
> -                fuse_reply_err(req, -ret);
> -                return;
> +                return ret;
>              }
>          }
> =20
> @@ -832,44 +900,38 @@ static void fuse_fallocate(fuse_req_t req, fuse_ino=
_t inode, int mode,
>          ret =3D -EOPNOTSUPP;
>      }
> =20
> -    fuse_reply_err(req, ret < 0 ? -ret : 0);
> +    return ret < 0 ? ret : 0;
>  }
> =20
>  /**
>   * Let clients fsync the exported image.
> + * Return 0 on success (no 'out' object), and -errno on error.
>   */
> -static void fuse_fsync(fuse_req_t req, fuse_ino_t inode, int datasync,
> -                       struct fuse_file_info *fi)
> +static ssize_t fuse_fsync(FuseExport *exp)
>  {
> -    FuseExport *exp =3D fuse_req_userdata(req);
> -    int ret;
> -
> -    ret =3D blk_flush(exp->common.blk);
> -    fuse_reply_err(req, ret < 0 ? -ret : 0);
> +    return blk_flush(exp->common.blk);
>  }
> =20
>  /**
>   * Called before an FD to the exported image is closed.  (libfuse
>   * notes this to be a way to return last-minute errors.)
> + * Return 0 on success (no 'out' object), and -errno on error.
>   */
> -static void fuse_flush(fuse_req_t req, fuse_ino_t inode,
> -                        struct fuse_file_info *fi)
> +static ssize_t fuse_flush(FuseExport *exp)
>  {
> -    fuse_fsync(req, inode, 1, fi);
> +    return blk_flush(exp->common.blk);
>  }
> =20
>  #ifdef CONFIG_FUSE_LSEEK
>  /**
>   * Let clients inquire allocation status.
> + * Return the number of bytes written to *out on success, and -errno on =
error.
>   */
> -static void fuse_lseek(fuse_req_t req, fuse_ino_t inode, off_t offset,
> -                       int whence, struct fuse_file_info *fi)
> +static ssize_t fuse_lseek(FuseExport *exp, struct fuse_lseek_out *out,
> +                          uint64_t offset, uint32_t whence)
>  {
> -    FuseExport *exp =3D fuse_req_userdata(req);
> -
>      if (whence !=3D SEEK_HOLE && whence !=3D SEEK_DATA) {
> -        fuse_reply_err(req, EINVAL);
> -        return;
> +        return -EINVAL;
>      }
> =20
>      while (true) {
> @@ -879,8 +941,7 @@ static void fuse_lseek(fuse_req_t req, fuse_ino_t ino=
de, off_t offset,
>          ret =3D bdrv_block_status_above(blk_bs(exp->common.blk), NULL,
>                                        offset, INT64_MAX, &pnum, NULL, NU=
LL);
>          if (ret < 0) {
> -            fuse_reply_err(req, -ret);
> -            return;
> +            return ret;
>          }
> =20
>          if (!pnum && (ret & BDRV_BLOCK_EOF)) {
> @@ -897,34 +958,38 @@ static void fuse_lseek(fuse_req_t req, fuse_ino_t i=
node, off_t offset,
> =20
>              blk_len =3D blk_getlength(exp->common.blk);
>              if (blk_len < 0) {
> -                fuse_reply_err(req, -blk_len);
> -                return;
> +                return blk_len;
>              }
> =20
>              if (offset > blk_len || whence =3D=3D SEEK_DATA) {
> -                fuse_reply_err(req, ENXIO);
> -            } else {
> -                fuse_reply_lseek(req, offset);
> +                return -ENXIO;
>              }
> -            return;
> +
> +            *out =3D (struct fuse_lseek_out) {
> +                .offset =3D offset,
> +            };
> +            return sizeof(*out);
>          }
> =20
>          if (ret & BDRV_BLOCK_DATA) {
>              if (whence =3D=3D SEEK_DATA) {
> -                fuse_reply_lseek(req, offset);
> -                return;
> +                *out =3D (struct fuse_lseek_out) {
> +                    .offset =3D offset,
> +                };
> +                return sizeof(*out);
>              }
>          } else {
>              if (whence =3D=3D SEEK_HOLE) {
> -                fuse_reply_lseek(req, offset);
> -                return;
> +                *out =3D (struct fuse_lseek_out) {
> +                    .offset =3D offset,
> +                };
> +                return sizeof(*out);
>              }
>          }
> =20
>          /* Safety check against infinite loops */
>          if (!pnum) {
> -            fuse_reply_err(req, ENXIO);
> -            return;
> +            return -ENXIO;
>          }
> =20
>          offset +=3D pnum;
> @@ -932,21 +997,297 @@ static void fuse_lseek(fuse_req_t req, fuse_ino_t =
inode, off_t offset,
>  }
>  #endif
> =20
> -static const struct fuse_lowlevel_ops fuse_ops =3D {
> -    .init       =3D fuse_init,
> -    .lookup     =3D fuse_lookup,
> -    .getattr    =3D fuse_getattr,
> -    .setattr    =3D fuse_setattr,
> -    .open       =3D fuse_open,
> -    .read       =3D fuse_read,
> -    .write      =3D fuse_write,
> -    .fallocate  =3D fuse_fallocate,
> -    .flush      =3D fuse_flush,
> -    .fsync      =3D fuse_fsync,
> +/**
> + * Write a FUSE response to the given @fd, using a single buffer consecu=
tively
> + * containing both the response header and data: Initialize *out_hdr, an=
d write
> + * it plus @response_data_length consecutive bytes to @fd.
> + *
> + * @fd: FUSE file descriptor
> + * @req_id: Corresponding request ID
> + * @out_hdr: Pointer to buffer that will hold the output header, and
> + *           additionally already contains @response_data_length data by=
tes
> + *           starting at *out_hdr + 1.
> + * @err: Error code (-errno, or 0 in case of success)
> + * @response_data_length: Length of data to return (following *out_hdr)
> + */
> +static int fuse_write_response(int fd, uint32_t req_id,
> +                               struct fuse_out_header *out_hdr, int err,
> +                               size_t response_data_length)
> +{
> +    void *write_ptr =3D out_hdr;
> +    size_t to_write =3D sizeof(*out_hdr) + response_data_length;
> +    ssize_t ret;
> +
> +    *out_hdr =3D (struct fuse_out_header) {
> +        .len =3D to_write,
> +        .error =3D err,
> +        .unique =3D req_id,
> +    };
> +
> +    while (true) {
> +        ret =3D RETRY_ON_EINTR(write(fd, write_ptr, to_write));
> +        if (ret < 0) {
> +            ret =3D -errno;
> +            error_report("Failed to write to FUSE device: %s", strerror(=
-ret));
> +            return ret;
> +        } else {
> +            to_write -=3D ret;
> +            if (to_write > 0) {
> +                write_ptr +=3D ret;
> +            } else {
> +                return 0; /* success */
> +            }
> +        }
> +    }
> +}
> +
> +/**
> + * Write a FUSE response to the given @fd, using separate buffers for the
> + * response header and data: Initialize *out_hdr, and write it plus the =
data in
> + * *buf to @fd.
> + *
> + * In contrast to fuse_write_response(), this function cannot return err=
ors, and
> + * will always return success (error code 0).
> + *
> + * @fd: FUSE file descriptor
> + * @req_id: Corresponding request ID
> + * @out_hdr: Pointer to buffer that will hold the output header
> + * @buf: Pointer to response data
> + * @buflen: Length of response data
> + */
> +static int fuse_write_buf_response(int fd, uint32_t req_id,
> +                                   struct fuse_out_header *out_hdr,
> +                                   const void *buf, size_t buflen)
> +{
> +    struct iovec iov[2] =3D {
> +        { out_hdr, sizeof(*out_hdr) },
> +        { (void *)buf, buflen },
> +    };
> +    struct iovec *iovp =3D iov;
> +    unsigned iov_count =3D ARRAY_SIZE(iov);
> +    size_t to_write =3D sizeof(*out_hdr) + buflen;
> +    ssize_t ret;
> +
> +    *out_hdr =3D (struct fuse_out_header) {
> +        .len =3D to_write,
> +        .unique =3D req_id,
> +    };
> +
> +    while (true) {
> +        ret =3D RETRY_ON_EINTR(writev(fd, iovp, iov_count));
> +        if (ret < 0) {
> +            ret =3D -errno;
> +            error_report("Failed to write to FUSE device: %s", strerror(=
-ret));
> +            return ret;
> +        } else {
> +            to_write -=3D ret;
> +            if (to_write > 0) {
> +                iov_discard_front(&iovp, &iov_count, ret);
> +            } else {
> +                return 0; /* success */
> +            }
> +        }
> +    }
> +}
> +
> +/*
> + * For use in fuse_process_request():
> + * Returns a pointer to the parameter object for the given operation (in=
side of
> + * exp->request_buf, which is assumed to hold a fuse_in_header first).
> + * Verifies that the object is complete (exp->request_buf is large enoug=
h to
> + * hold it in one piece, and the request length includes the whole objec=
t).
> + *
> + * Note that exp->request_buf may be overwritten after polling, so the r=
eturned
> + * pointer must not be used across a function that may poll!
> + */
> +#define FUSE_IN_OP_STRUCT(op_name, export) \
> +    ({ \
> +        const struct fuse_in_header *__in_hdr =3D \
> +            (const struct fuse_in_header *)(export)->request_buf; \
> +        const struct fuse_##op_name##_in *__in =3D \
> +            (const struct fuse_##op_name##_in *)(__in_hdr + 1); \
> +        const size_t __param_len =3D sizeof(*__in_hdr) + sizeof(*__in); \
> +        uint32_t __req_len; \
> +        \
> +        QEMU_BUILD_BUG_ON(sizeof((export)->request_buf) < __param_len); \
> +        \
> +        __req_len =3D __in_hdr->len; \
> +        if (__req_len < __param_len) { \
> +            warn_report("FUSE request truncated (%" PRIu32 " < %zu)", \
> +                        __req_len, __param_len); \
> +            ret =3D -EINVAL; \
> +            break; \
> +        } \
> +        __in; \
> +    })
> +
> +/*
> + * For use in fuse_process_request():
> + * Returns a pointer to the return object for the given operation (insid=
e of
> + * out_buf, which is assumed to hold a fuse_out_header first).
> + * Verifies that out_buf is large enough to hold the whole object.
> + *
> + * (out_buf should be a char[] array.)
> + */
> +#define FUSE_OUT_OP_STRUCT(op_name, out_buf) \
> +    ({ \
> +        struct fuse_out_header *__out_hdr =3D \
> +            (struct fuse_out_header *)(out_buf); \
> +        struct fuse_##op_name##_out *__out =3D \
> +            (struct fuse_##op_name##_out *)(__out_hdr + 1); \
> +        \
> +        QEMU_BUILD_BUG_ON(sizeof(*__out_hdr) + sizeof(*__out) > \
> +                          sizeof(out_buf)); \
> +        \
> +        __out; \
> +    })
> +
> +/**
> + * Process a FUSE request, incl. writing the response.
> + *
> + * Note that polling in any request-processing function can lead to a ne=
sted
> + * read_from_fuse_fd() call, which will overwrite the contents of
> + * exp->request_buf.  Anything that takes a buffer needs to take care th=
at the
> + * content is copied before potentially polling.
> + */
> +static void fuse_process_request(FuseExport *exp)
> +{
> +    uint32_t opcode;
> +    uint64_t req_id;
> +    /*
> +     * Return buffer.  Must be large enough to hold all return headers, =
but does
> +     * not include space for data returned by read requests.
> +     * (FUSE_IN_OP_STRUCT() verifies at compile time that out_buf is ind=
eed
> +     * large enough.)
> +     */
> +    char out_buf[sizeof(struct fuse_out_header) +
> +                 MAX_CONST(sizeof(struct fuse_init_out),
> +                 MAX_CONST(sizeof(struct fuse_open_out),
> +                 MAX_CONST(sizeof(struct fuse_attr_out),
> +                 MAX_CONST(sizeof(struct fuse_write_out),
> +                           sizeof(struct fuse_lseek_out)))))];
> +    struct fuse_out_header *out_hdr =3D (struct fuse_out_header *)out_bu=
f;
> +    /* For read requests: Data to be returned */
> +    void *out_data_buffer =3D NULL;
> +    ssize_t ret;
> +
> +    /* Limit scope to ensure pointer is no longer used after polling */
> +    {
> +        const struct fuse_in_header *in_hdr =3D
> +            (const struct fuse_in_header *)exp->request_buf;
> +
> +        opcode =3D in_hdr->opcode;
> +        req_id =3D in_hdr->unique;
> +    }
> +
> +    switch (opcode) {
> +    case FUSE_INIT: {
> +        const struct fuse_init_in *in =3D FUSE_IN_OP_STRUCT(init, exp);
> +        ret =3D fuse_init(exp, FUSE_OUT_OP_STRUCT(init, out_buf),
> +                        in->max_readahead, in->flags);
> +        break;
> +    }
> +
> +    case FUSE_OPEN:
> +        ret =3D fuse_open(exp, FUSE_OUT_OP_STRUCT(open, out_buf));
> +        break;
> +
> +    case FUSE_RELEASE:
> +        ret =3D 0;
> +        break;
> +
> +    case FUSE_LOOKUP:
> +        ret =3D -ENOENT; /* There is no node but the root node */
> +        break;
> +
> +    case FUSE_GETATTR:
> +        ret =3D fuse_getattr(exp, FUSE_OUT_OP_STRUCT(attr, out_buf));
> +        break;
> +
> +    case FUSE_SETATTR: {
> +        const struct fuse_setattr_in *in =3D FUSE_IN_OP_STRUCT(setattr, =
exp);
> +        ret =3D fuse_setattr(exp, FUSE_OUT_OP_STRUCT(attr, out_buf),
> +                           in->valid, in->size, in->mode, in->uid, in->g=
id);
> +        break;
> +    }
> +
> +    case FUSE_READ: {
> +        const struct fuse_read_in *in =3D FUSE_IN_OP_STRUCT(read, exp);
> +        ret =3D fuse_read(exp, &out_data_buffer, in->offset, in->size);
> +        break;
> +    }
> +
> +    case FUSE_WRITE: {
> +        const struct fuse_write_in *in =3D FUSE_IN_OP_STRUCT(write, exp);
> +        uint32_t req_len;
> +
> +        req_len =3D ((const struct fuse_in_header *)exp->request_buf)->l=
en;
> +        if (unlikely(req_len < sizeof(struct fuse_in_header) + sizeof(*i=
n) +
> +                               in->size)) {
> +            warn_report("FUSE WRITE truncated; received %zu bytes of %" =
PRIu32,
> +                        req_len - sizeof(struct fuse_in_header) - sizeof=
(*in),
> +                        in->size);
> +            ret =3D -EINVAL;
> +            break;
> +        }
> +
> +        /*
> +         * poll_fuse_fd() has checked that in_hdr->len matches the numbe=
r of
> +         * bytes read, which cannot exceed the max_write value we set
> +         * (FUSE_MAX_WRITE_BYTES).  So we know that FUSE_MAX_WRITE_BYTES=
 >=3D
> +         * in_hdr->len >=3D in->size + X, so this assertion must hold.
> +         */
> +        assert(in->size <=3D FUSE_MAX_WRITE_BYTES);
> +
> +        /*
> +         * Passing a pointer to `in` (i.e. the request buffer) is fine b=
ecause
> +         * fuse_write() takes care to copy its contents before potential=
ly
> +         * polling.
> +         */
> +        ret =3D fuse_write(exp, FUSE_OUT_OP_STRUCT(write, out_buf),
> +                         in->offset, in->size, in + 1);
> +        break;
> +    }
> +
> +    case FUSE_FALLOCATE: {
> +        const struct fuse_fallocate_in *in =3D FUSE_IN_OP_STRUCT(falloca=
te, exp);
> +        ret =3D fuse_fallocate(exp, in->offset, in->length, in->mode);
> +        break;
> +    }
> +
> +    case FUSE_FSYNC:
> +        ret =3D fuse_fsync(exp);
> +        break;
> +
> +    case FUSE_FLUSH:
> +        ret =3D fuse_flush(exp);
> +        break;
> +
>  #ifdef CONFIG_FUSE_LSEEK
> -    .lseek      =3D fuse_lseek,
> +    case FUSE_LSEEK: {
> +        const struct fuse_lseek_in *in =3D FUSE_IN_OP_STRUCT(lseek, exp);
> +        ret =3D fuse_lseek(exp, FUSE_OUT_OP_STRUCT(lseek, out_buf),
> +                         in->offset, in->whence);
> +        break;
> +    }
>  #endif
> -};
> +
> +    default:
> +        ret =3D -ENOSYS;
> +    }
> +
> +    /* Ignore errors from fuse_write*(), nothing we can do anyway */
> +    if (out_data_buffer) {
> +        assert(ret >=3D 0);
> +        fuse_write_buf_response(exp->fuse_fd, req_id, out_hdr,
> +                                out_data_buffer, ret);
> +        qemu_vfree(out_data_buffer);
> +    } else {
> +        fuse_write_response(exp->fuse_fd, req_id, out_hdr,
> +                            ret < 0 ? ret : 0,
> +                            ret < 0 ? 0 : ret);
> +    }
> +}
> =20
>  const BlockExportDriver blk_exp_fuse =3D {
>      .type               =3D BLOCK_EXPORT_TYPE_FUSE,
> --=20
> 2.48.1
>=20
>=20

--AmNWUu5KoYbNJM+0
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmflcCcACgkQnKSrs4Gr
c8hQigf/csvvy0tOQb7z7OuAv56I12mgMLGBHTZYHBnXlfVe/7bjCoLnZ4nhvPQ0
H0Gi3C3mRGF6g8Lp4G4kS3VRLK0ZgdIRM96dOsNcmjtVHg4r3lq2HmU72MYBZnBq
rupcp21l85HOH0nhLIPoqIHhuozpHT67KmkeGBIsM6/ev4Tzeuz4IK7ddTZyqA1C
8DFMvHse3SF4a8IYq7265oHHKf3dLQjckz7RKshZv43Uiw37IMn/PUPUP+YcTEBQ
+CXsr41e3DWnhWUMXRzfEXzdgBSqCjkX7GqMpFFMsheB+jaKxqaoLwgUDZgtZk2l
8p/CI+NhETkoT1BBebzc3NcN1ybljw==
=/UfY
-----END PGP SIGNATURE-----

--AmNWUu5KoYbNJM+0--


